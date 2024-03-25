Return-Path: <linux-kernel+bounces-117663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9D088AE2C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F3E1FA0D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38FE74427;
	Mon, 25 Mar 2024 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TOfqsLI4"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0748C4D9FD
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389475; cv=none; b=qzPeEOUNxeSYyPYlz768sf5LSwDLnzLZMBJSxVa1jyH+BgOtu1103VGCugAVvYdcBVdnTL//jlrLJhbCZiATCdAaTWR7uCIr0zJ+mhOYzrnTH4qYSJyCNcI3q58TeZ0Qevwq9c/ZQ1YjXXzRzK+LEzk87RjPrgOJ5OcgnT5tREw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389475; c=relaxed/simple;
	bh=eW0a7WX8RMwOQ+GK6VZs7GP5fQrsDtcUr+HONEfJt0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LndjKBzJJubUAXbl+Wk71uMO9pHXrC+sbJp9xTqbhWfmg2/9MO1WaDGhn6EkTNSCiSmh2OSjAc25yXkV5+83B0Gg7BZb0QSTROodsgLxJO93w62mOTHTx3wDR9nVYIJPfpYwwC2u5zk4Ea9z5Zps1wllg5M4AZVtO22YkC0G35I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TOfqsLI4; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a46d0a8399aso947903566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711389464; x=1711994264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vTgR9569AKBIOfro0ug4KR0uxTmxP2IUC1rcBBMRyEM=;
        b=TOfqsLI4vP1F7sSJ5s0Zgnpd+DQfFxbw8IegjGwhPRl+0cO9uxl1DJMH71UCHN769v
         SdvgLaV4/N7cBFIoR4hbOwfIF/WEGQ7A6IC4kkT563O7J/vs+YOCcWaTuKXJWQH+ILJA
         3ZxUfmxurWmDPeEO2yh06Lz8VW0LyLgWBQOo1q6v/XvI5JIC9vOA5ZivNieZUnXiseot
         iunkcfwRKYgNnI7x6SYz2h+qwzU2RBIKdFNENumdYq9CASPVL/oH3RyoddhW9EWE8Rus
         98zt+MMgLhw3wgysM0nDbwM6PYFA3v+Uq71v2qnh1oZfdQAfpr4jmXtKvsaPYDt5IaJy
         cQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711389464; x=1711994264;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTgR9569AKBIOfro0ug4KR0uxTmxP2IUC1rcBBMRyEM=;
        b=Asre44tRHPtTSrGL7z/6aiPdtwtzw8QHx2qkcVEPRqURNRpAnctLFE+LsGa3J9/ydW
         U255VYLHd/KX+xmw0ye7NKy83gywne3VTtJZoC0AHUnchyZLu1ZVliVw4yqVupgbTQqd
         wzQir+u0gJRiqYkFBI8XDtKOZcgKTGZypwfgYqDP49NYaUuqJMJPoTUXx8lrOHy3WpSS
         pBU4+UwoZPRmWKs9VBUKr/+GUPVW+xu4e6Wg2hQfePhNBxuI4Ha0zDBRNCSUbvxvQrYP
         WOFeDuTDnNIhCTHMsXsjblGPIk70RXgEIsAXj0Q3SPPJNhJ6LGSCCJXctTQveeleI97n
         H7tw==
X-Forwarded-Encrypted: i=1; AJvYcCUnzPXRhKhcKrR1Bv0xlNe0LdJZK+1K427CUrj3IAFlSUDYbMIz31K+ehqlVxv8DBJYLeqO2LvEp8q2paj6Ant4YJwSq8nWaQZGreob
X-Gm-Message-State: AOJu0YwrNHNx1Tevdd+T/k+WCYL9E28aA+cp9agpOcIn+QW3MdIgU2Ye
	xsQY7S70FFUxv3C1qiAzG0UQV+3W8eEvvjM/dXFApCuP3NbLe5mMfAeD446Z3aM=
X-Google-Smtp-Source: AGHT+IHZaCqIgNZYNZYZx1Ul9q23YfDYZM2aAElxNhm5klcqTbymtNS99Wp5E8Bpw6Z8QVNt1a17sA==
X-Received: by 2002:a17:907:72c1:b0:a4a:39f3:b195 with SMTP id du1-20020a17090772c100b00a4a39f3b195mr2732824ejc.4.1711389463699;
        Mon, 25 Mar 2024 10:57:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id zh20-20020a170906881400b00a47531764fdsm1879244ejb.65.2024.03.25.10.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 10:57:43 -0700 (PDT)
Message-ID: <9bc55af4-1ef0-42ac-9561-fe08a3401ccf@linaro.org>
Date: Mon, 25 Mar 2024 18:57:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] dt-bindings: display: sony,td4353-jdi: allow
 width-mm and height-mm
To: Rob Herring <robh@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 devicetree@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor.dooley@microchip.com>
References: <20240325103227.27474-1-krzysztof.kozlowski@linaro.org>
 <171137719526.3318300.16563684034350324718.robh@kernel.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <171137719526.3318300.16563684034350324718.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/03/2024 15:33, Rob Herring wrote:
> On Mon, 25 Mar 2024 11:32:27 +0100, Krzysztof Kozlowski wrote:
>> Allow width and height properties from panel-common.yaml, already used
>> on some boards:
>>
>>   sdm845-sony-xperia-tama-apollo.dtb: panel@0: 'height-mm', 'width-mm' do not match any of the regexes: 'pinctrl-[0-9]+'
>>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>
>> Rob, could you pick up this one? Was on the list for almost a year.
>>
>>
>>  .../devicetree/bindings/display/panel/sony,td4353-jdi.yaml      | 2 ++
>>  1 file changed, 2 insertions(+)
>>
> 
> Applied, thanks!

Few hours earlier Neil Armstrong took it, so I think you can drop it.

Best regards,
Krzysztof


