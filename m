Return-Path: <linux-kernel+bounces-133466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D170C89A41F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602871F22E52
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045CF171E6F;
	Fri,  5 Apr 2024 18:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zZxinCEg"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F788171E5B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 18:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712341284; cv=none; b=lODUWOXl8DmbGGu6a07LBkRAtRpvej1VWC4up/AIbT1tlNAqvxEiV/WdqhT48iWLV/DzAF+nKK7j5a7iimYSEx8YWrIWXlgcjRDHKemMxDkdNAddzLHpLWVaEhd2/3LKpAus7HZQfsUZcAfH6YeZ6U6Deh3g+aa6f+UEPrKJqxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712341284; c=relaxed/simple;
	bh=U1bhPfgZUUHhnsTYnxvS3Dlkc1fZX0KD2x/ZnQur3Fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fehse2qp8Pxc6CZSY8ecrLvWxzEFTyogVywEqXC0K74BtmM9rrWJF0znwKKJvKpdTMox6Qcqc9m3PhEb6ij0BG60lfLcsYCR7MIJ3kxSv1iqtlGmCxay/txxC9I1KE8E/630YozM8PnM9W4fXicEysAg1wn3aETUg+0u6i+8NrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zZxinCEg; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516d15d72c3so2283578e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 11:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712341280; x=1712946080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Aoqb0ZvgJjDrARAuD79kB80qdeeEZC580nOfAjj2138=;
        b=zZxinCEgkGh1Qe6zaAQWgtii794JMqCE6OMiFeUUJFInrhOzymqa4HeOwZPBvg+yPt
         NFeEpj2wQKFvfgxUkBRn3XbQAmbrmsFiaBlqPwjKRCIaFQGA0bhk74Bf0XiDD0BOlIB8
         zvCj00eTlwJPnUHMTMbfXQyojua1/sMrQTdKoTywLzRcIVVgvX948m9wQCEXbxxC6ZW1
         70V42Ms3P9h7sXxYDwI9J5/oWGiDM6iy151JmOEQ7qBrC1bg/ffSCFaV6BPe2Tn0lq1a
         VUnhSVQ2hOQAdrIoV9bg2kxfAK8SDOmwbF+LtYlS4zMUwU8L/di02UI4HrfC39zBiYQY
         mRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712341280; x=1712946080;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aoqb0ZvgJjDrARAuD79kB80qdeeEZC580nOfAjj2138=;
        b=piCpwJyFkEAj+kzqzpgylwCbiHSOLpdgW5LXAKSK1cCvAz1xYFGFTHrPVLXIPqKaV+
         fXWhyVJkx3enNYVVddxrTjQpy5RhZRvtm1fXoMSCkkVXF6HAa8b9SRESdIC47yA03VTP
         BTWclYTq6G6Vbi2yWEpHsBOgckO8HzuG6PUpZW/YKYuw9TB6LZjqpnTHfBifM3Kcg59l
         a5r3X5vB1ltXtjlJ+Od6to/Xd1yG5MiVbi/htJYF9gcMcDw6CeJ5uxRuADRn1+VHkGdh
         /qBWAP4qh6u9pf3N7oP4G1YP6qhLVOAoAc/tzBK3DTbsvpxVrGTg6bRlbLcVvyhWJNKP
         SyRg==
X-Forwarded-Encrypted: i=1; AJvYcCU/S0CKPoDRTcoJ91os0+SBiwshsfv98LwjekNcwnsBOJe1jdgRDJissjCzP/6J16B0A5S1pksc3E1zHnvYF4ZAkBsxqRPD0Vn81Fvs
X-Gm-Message-State: AOJu0YzObSEXwEg79eNS/Vx9zz959Jaww3j5sbPvezjp/WJnVDAysqBl
	3g9QQuGKgdmh8gRrY3P3X52BN1ql6NJEgADzOKeSvIYG8oAlhCJ7qeLofu6Sk7A=
X-Google-Smtp-Source: AGHT+IE6UiMSad29esrjwaWubKN7rdr6QVJiWDc4K33rovL4UBL/Z/eUnCeh8MAuY2oVX98VJEPZSw==
X-Received: by 2002:ac2:5f94:0:b0:515:a733:2e0e with SMTP id r20-20020ac25f94000000b00515a7332e0emr1625285lfe.25.1712341280466;
        Fri, 05 Apr 2024 11:21:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id ne6-20020a1709077b8600b00a4e5a6b57a2sm1094189ejc.163.2024.04.05.11.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 11:21:19 -0700 (PDT)
Message-ID: <938489b1-eb94-4f8a-8881-230951299f6a@linaro.org>
Date: Fri, 5 Apr 2024 20:21:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm64: dts: imx8qxp-mek: add cm40_i2c, wm8960/wm8962
 and sai[0,1,4,5]
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240404161914.1655305-1-Frank.Li@nxp.com>
 <efc9c624-6a31-4299-a604-8aad1d0cd878@linaro.org>
 <ZhAO4YWuB8r8k+m8@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZhAO4YWuB8r8k+m8@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/04/2024 16:46, Frank Li wrote:
> On Fri, Apr 05, 2024 at 08:41:59AM +0200, Krzysztof Kozlowski wrote:
>> On 04/04/2024 18:19, Frank Li wrote:
>>> imx8qxp-mek use two kind audio codec, wm8960 and wm8962. Using dummy gpio
>>> i2c bus mux to connect both i2c devices. One will probe failure and other
>>> will probe success when devices driver check whoami. So one dtb can cover
>>> both board configuration.
>>
>> I don't understand it. Either you add real device or not. If one board
>> has two devices, then why do you need to check for failures?
>>
>> Anyway, don't add fake stuff to DTS.
> 
> NAK can't resolve the problem. It should be common problem for long time
> cycle boards. Some chipes will be out life cycle. such as some sensor. So
> chips on boards have been replace by some pin to pin compatible sensor. For
> example: 
> 	old boards: use sensor A with address 0x1a
> 	new bench: use sensor B with address 0x1b.
> 
> You can treat it as two kind boards, RevA or RevB. But most user want to
> use one dtb to handle such small differences. For this case, it should be
> simple. Just add a super set.
> 	i2c
> 	{
> 		sensorA@1a
> 		{
> 		}
> 		sensorB@1b
> 		{
> 		}	
> 	}
> 
> It also depend on whoami check by i2c devices. Only A or B will probe.
> 
> wm8960 and wm8962 are more complex example.  wm8960 is out of life. But
> wm8962 and wm8960 have the same i2c address. The current i2c frame can't
> allow the same i2c address in one i2c bus.
> 
> You are feel to NAK my method, but I hope you also provide constructive
> solution to help resolve the problem.

Yes, we resolved it long time ago. Your bootloader can (usually easily)
detect revision of the board and load appropriate DTS or DTS+DTSO.

Best regards,
Krzysztof


