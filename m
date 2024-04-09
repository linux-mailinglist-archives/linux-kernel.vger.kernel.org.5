Return-Path: <linux-kernel+bounces-136545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100F689D56D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 417971C226C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741888002E;
	Tue,  9 Apr 2024 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ot9OcfQo"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FC47FBC2;
	Tue,  9 Apr 2024 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654528; cv=none; b=pAjW+Pc9H5+e448keDPDs30VNhrcoRL/PCX6BlIIaYgyuf4L0AfhES32JV3GaF0wiMVC7mVA+s4zp0lnASqaKaE6EqxbSAdqsF0ytdgXu9Dlpu/sygpJTwPF3XHLI25lxX6k3VhjgGUAHwJ1dJNqbi1GhGwfVFKCB6IA2Gu2/w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654528; c=relaxed/simple;
	bh=wgxmF8dF0t1OLiFgF5yhMNxV6zA389z8dZjRNqQbiDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2VfMIOw0uGo5dxumnOAxX/Y0JiNLbyPybSBvZ96oH5WhmV+YY35cHgyDoZXMiKfIb/5bMeia88ENRtcUIusi1Qa7kaUcmX6A6yKDrPeUcHyf79Sc7BDcS/Csuq6sBqCSXD+iF0SQ9DM9QX6jFkS6oshKerCMj8yFSwWvJ3yY/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ot9OcfQo; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d700beb60bso87034001fa.1;
        Tue, 09 Apr 2024 02:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712654525; x=1713259325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r1YI1LD16aBiZ7GIogy/yUsyhydLDw6SsonapHKI3FE=;
        b=Ot9OcfQokp9OQcmmKoNNyCBgkRKRPZkzMkBM1hAPJZzgRgPMxvFyjQ3O0G4IEXELCU
         tRNppEQJWqSlvWmm4BSQLjaZa3VpTnfaGt9cpRmG8AnTG7U95TUcCmXXmD0RwyiqfDNz
         jM2ckfvPW6o2jkaNMh7RMn2rCdRpi2cMEDUYDYjjRBeanHH3Nv0/SMLecNuLej1ICZB1
         mFpA6IThmfK2J+Rfgyj889O4t1dr4IqB6/uGG5UiD0L056vEymm3sw5sk4Fsm5SA8R97
         FeP9GB7ZkE/YW3N7ArDiuFbrvnCuaD9Cy6AXNiTztEcWwVYW2jvoPxJLzjb4AkRnLMpG
         Wz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712654525; x=1713259325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r1YI1LD16aBiZ7GIogy/yUsyhydLDw6SsonapHKI3FE=;
        b=OaCYE4iNgaCaAGqgpuRujd7KvdL41PE86wRZf0htDmuJiIfArXRJmE6JDpeaOOKwI5
         E8FQFbiheir4Ei7tCuRKQbGyg+wWG1v93oAKguWNItBBzW25RqPWZoJP+5aMnDruYXZE
         y4pU03VURWxkzpNYcXMdQBeAL1De11cbPta/6DnuUGEdP6duUEYSErgYWfamFq8nkIdP
         +hqDI5rOkjCGuFmQ4IY5G7DdsKsucQWBIoy3qsLccLmvzdeuW+xIITmKB7WGl1ysdacH
         zP/ap4zBiPDHx3Z9xHcGMTkofpX4e/046XR2gQG7j3jQZdLnau49+HGLJiFsZ2gdGNN/
         7VaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmaDFNuoChLQhzzZh57p/AEx5xRYQWzL3yj7h/HEDy1bC53DZvXMJnbna0e9gznV+ab2tnpWgy4tIc91WuyuPaSzG87h9ngSzbUn7gcSYU+9xXtGqeCMZifPp/UseLEN3XsiJZpI5afg==
X-Gm-Message-State: AOJu0YzDvIPJkpR0tTAVIkP7IsZ65/7Bnjs+bYMwytA3MP4vGUfKjNzk
	/md/ubFysnkN4MWjHIgSjALO691/8nJF3dEYgcJzOvhz1ixUFrvr
X-Google-Smtp-Source: AGHT+IEd5fPYAVXM4XxUF+C21LNjRVh8lxcxzN8JGvpeWnZKVlON9QdWZ6IU7KdQRBRKVpgj6S6efw==
X-Received: by 2002:a2e:854c:0:b0:2d6:f5c6:e5a1 with SMTP id u12-20020a2e854c000000b002d6f5c6e5a1mr8870002ljj.12.1712654524793;
        Tue, 09 Apr 2024 02:22:04 -0700 (PDT)
Received: from [192.168.0.31] (84-115-213-64.cable.dynamic.surfer.at. [84.115.213.64])
        by smtp.gmail.com with ESMTPSA id qs1-20020a170906458100b00a4e6626ae21sm5454291ejc.0.2024.04.09.02.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 02:22:04 -0700 (PDT)
Message-ID: <89e7db2d-1de0-4e2e-a2d2-f00d45399b11@gmail.com>
Date: Tue, 9 Apr 2024 11:22:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] dt-bindings: rtc: stmp3xxx-rtc: convert to dtschema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vladimir Zapolskiy <vz@mleia.com>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
 <20240408-rtc_dtschema-v1-8-c447542fc362@gmail.com>
 <f0467c4f-45e2-4cae-b1b5-3867e5b9bf08@linaro.org>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <f0467c4f-45e2-4cae-b1b5-3867e5b9bf08@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/24 09:40, Krzysztof Kozlowski wrote:
> On 08/04/2024 17:53, Javier Carrasco wrote:
>> Convert existing binding to dtschema to support validation.
>>
>> The 'fsl,imx28-rtc' compatible is currently not supported, and it is
>> only referenced in this binding and in nxp/mxs/imx28.dtsi. Therefore,
>> that compatible has been dropped, which triggers a warning when testing
>> the DT against the new binding.
> 
> Instead document missing compatibles and mention this in commit msg.
> 


There is no driver that will match 'fsl,imx28-rtc', only
'fsl,stmp3xxx-rtc', so I am not sure how to document the missing
compatible in a sensible way. My first suggestion to account for
undocumented strings would be:

  compatible:
    oneOf:
      - items:
          - enum:
              - fsl,imx23-rtc
              - fsl,imx28-rtc
          - const: fsl,stmp3xxx-rtc
      - const: fsl,stmp3xxx-rtc

Any suggestions or improvements?

>>
>> There is another reference to fsl,stmp3xxx-rtc in nxp/mxs/imx23.dtsi,
>> where another unsupported compatible 'fsl,imx23-rtc' is used, and the
>> same problem would arise when testing the file against the new binding.
> 
> Please write concise messages... you have to paragraphs about the same?
> What is the difference here?
> 
The difference is that 'fsl,imx23-rtc' was not even mentioned in any
binding, and it can only be found in imx23.dtsi. 'fsl,imx28-rtc' was
indeed mentioned in the txt binding.

My understanding after your comment is that we should gather
undocumented compatibles and add them to the bindings they would belong
to,no matter if they are used anywhere or not. I added this one to the
suggestion above as well.

>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>  .../devicetree/bindings/rtc/fsl,stmp3xxx-rtc.yaml  | 45 ++++++++++++++++++++++
>>  .../devicetree/bindings/rtc/stmp3xxx-rtc.txt       | 21 ----------
>>  2 files changed, 45 insertions(+), 21 deletions(-)
>>
> 
> 
> Best regards,
> Krzysztof
> 

Best regards,
Javier Carrasco

