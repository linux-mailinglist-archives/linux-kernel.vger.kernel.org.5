Return-Path: <linux-kernel+bounces-32153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBB1835758
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2593D1C20859
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 19:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5580F38399;
	Sun, 21 Jan 2024 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzlEb1y5"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0474A374EB;
	Sun, 21 Jan 2024 19:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705865394; cv=none; b=o27cbdcWeTEf/nyoRkRk3wlj1IlCVpBVhAdGAiZSWgHAvH92rUMhlaR82c/+rm6SuqMFCglRHY4jMCnvKnkCkiGTeCsp7GXA6nKpbKD2LxjeS9RkXJwKjLwTblvdFkoFYffmF70uyENREU6i6V8nXSyVUrQ00edRIXPs87EdoH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705865394; c=relaxed/simple;
	bh=lzn/PJQVopxFhMAd/XJ5/RhSi1AeJbr0ckRsdkk0gI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rbKC+FbNx30rU4myRxCbLPSfllbPUGigKsf7q6mPxBTsy7fAqNzMIYGOIVekzP9qucwXBmp4XpmKoK4NyewXY1vGzQc0LRT0r4ioh5RdEiWC1KRFdD2OTStZPkApOAFWXk4ZIOxazocIAhaAlk6XG0GXR5/Y6S+2/z/eaexBGzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzlEb1y5; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e0a64d9449so1657353a34.2;
        Sun, 21 Jan 2024 11:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705865392; x=1706470192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/71KA+Z9avWu2cHYxMou4LBKNLAgsGE7jAm0VTGz0X8=;
        b=EzlEb1y58npGFpNmUQrqgelCwUrjppGPzyQbyEoDvGKo51ZQVkv4qpERCA6UZMFbv0
         VjTFum5uYPvlbrwmENWwM8zmRatla2nO+Npoh1VEFuLGBAKPV/QqGybAk3bg9DoLG+fv
         QKCKb4/vak9qJmhfMCIA5kizQud2usamsBuEiJWToaOgDvXXoN+1UoqJJpxu2oLKD2H6
         gGH/jQEPbKPPCEAVbiCM/u0dlYoa9HtpUr+bumLUo7tWHZmFBC5Qd+EGdzLnuPjU3QAp
         34NgHz0OQXj/nXDjxnwdeJRODkh/BsyPReVGgqVPy0sZUxdC1Fu18QUWYO/Q5tDg3vfG
         m2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705865392; x=1706470192;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/71KA+Z9avWu2cHYxMou4LBKNLAgsGE7jAm0VTGz0X8=;
        b=Jb7+waRPu5MynhOPjsdRyDOUxxmD1MOAMQG7L+yaHJSIfx6j4sDK5F1nkH1i3/8jmU
         3l5elCrRL2+7yFye74Yb8lDtdjRVVrZEPkhv5DzGWBABLq7k2NNiz+OpOeAkggp65fSD
         FyH1fHbmUuwrRXZ2TyMupptKhgtQfl9884gxSitrP1hlrGonXryDd39XwhCpophW+vay
         hV+QgWfCh5mTSSvC1EHXwUvOYoKLoZ82hn0Js83kGF3xXd1M0Oevo6ei1zKwPp6Li1v9
         UAuzQLOWfNN42K9cAIIxnPpbTeJklbZN+zsBt1qGMi5C49QqkJ+EL2O1pBlOzpb2TTmw
         0Wdg==
X-Gm-Message-State: AOJu0YwHz5ESpqWTeoNFSCGf72T7I1F3MMYNyMllLl3NsdhKNyFZMvC/
	7F9tTPFnN9uSMY2kW2SgLj/eMURzJNN1yAhTaN7HdxjnJidk3dxn
X-Google-Smtp-Source: AGHT+IGO0o0J2pAGLhCcX8eCUB4fj3TbCSnOczGo5AbTS9+T9WsIXxEt3XnhQmBNtlHxygiWGN/8Xg==
X-Received: by 2002:a9d:480b:0:b0:6dc:813:6c3f with SMTP id c11-20020a9d480b000000b006dc08136c3fmr4133438otf.38.1705865392022;
        Sun, 21 Jan 2024 11:29:52 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r28-20020a635d1c000000b005c67a388836sm6901617pgb.62.2024.01.21.11.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 11:29:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ed1de0d4-9a88-47b1-a280-b872f6fdecb6@roeck-us.net>
Date: Sun, 21 Jan 2024 11:29:48 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 03/10] spi: Add multi-cs memories support in SPI core
Content-Language: en-US
To: Michael Walle <michael@walle.cc>
Cc: Mark Brown <broonie@kernel.org>,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 tudor.ambarus@linaro.org, pratyush@kernel.org, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, sbinding@opensource.cirrus.com,
 lee@kernel.org, james.schulman@cirrus.com, david.rhodes@cirrus.com,
 rf@opensource.cirrus.com, perex@perex.cz, tiwai@suse.com,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 michal.simek@amd.com, linux-arm-kernel@lists.infradead.org,
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, git@amd.com, amitrkcian2002@gmail.com
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-4-amit.kumar-mahapatra@amd.com>
 <3d3a11b1-8396-4d8e-9bb3-61ecb67e7efa@roeck-us.net>
 <d3c93c4c-3754-480c-84c2-9455ec8af702@roeck-us.net>
 <Zaxtm0JlQYU0/K/v@finisterre.sirena.org.uk>
 <ec7e7972-d48d-4a47-bd03-eec0c4334471@roeck-us.net>
 <9806d99fab46c928f337b30b21057b3e@walle.cc>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <9806d99fab46c928f337b30b21057b3e@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/21/24 10:06, Michael Walle wrote:
>>>> FWIW, the problem is due to
>>>
>>>> +#define SPI_CS_CNT_MAX 4
>>>
>>>> in the offending patch, but apeed2400 FMC supports up to 5 SPI chip selects.
>>>>
>>>>   static const struct aspeed_spi_data ast2400_fmc_data = {
>>>>          .max_cs        = 5,
>>>>     ^^^^^^^^^^^^^^^^^^^
>>>>          .hastype       = true,
>>>
>>>> Limiting .max_cs to 4 or increasing SPI_CS_CNT_MAX to 5 fixes the problem,
>>>> though of course I don't know if increasing SPI_CS_CNT_MAX has other side
>>>> effects.
>>>
>>> Yeah, I was coming to a similar conclusion myself - the limit is just
>>> too low.  I can't see any problem with increasing it.
>>
>> It would cost a bit of memory and somewhat affect performance sine many
>> of the newly introduced loops are bound by SPI_CS_CNT_MAX and not by
>> num_chipselect.
>>
>> It also might make sense to document the new limit somewhere. Prior
>> to this commit it was not limited at all.
>> Documentation/devicetree/bindings/spi/spi-davinci.txt lists 5 chip
>> selects in its example for the use of cs-gpios.
>> Documentation/devicetree/bindings/spi/spi-controller.yaml also does not
>> list a limit.
> 
> Given that, that the rest of this series is under discussion (and esp. whether
> it is the correct way to do it) it might make sense to just revert the picked
> patches.
> 

I can't really comment on that, but I found that there is another
affected devicetree property: num-cs. Its range isn't limited in
Documentation/devicetree/bindings/spi/spi-controller.yaml. Various
dts/dtsi files use numbers as large as 8. The range is limited in some
bindings files, but not all of them.
Documentation/devicetree/bindings/spi/spi-lantiq-ssc.txt, for example,
says

   "num-cs: see spi-bus.txt, set to 8 if unset"

Various Broadcom dtsi files set it to 8.

So I guess 8 would be the absolute minimum to re-enable support for
affected systems.

Guenter


