Return-Path: <linux-kernel+bounces-131091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A42FE8982FA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A9CDB26121
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BE46774E;
	Thu,  4 Apr 2024 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CPqkSkgq"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D887A6773D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 08:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712218674; cv=none; b=pVSUIFe4AFKwlG8XrP0BTfSnfHxYuTyozoVof2cuPgbXfWEXmGc9jJuoEcUWqYi276XbPSIjKDBzHZlH9dPE4wzUFUZZrE/bHTi5xR8BzT6qypOYl6mLKrweEeuz862NLkBxv1mrNFZg8ltg/6jIM7zDpwlohVGXcvKX9euBmO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712218674; c=relaxed/simple;
	bh=yW0CrOEA0Dm/cG5P22rynRdGvVDTVuEMbC6VflV4b8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lB97iO9HvtyY0EQbjQvcAXlhbhjehsDFO2vyLga3haIieRfrWWxYGwrL0IBqdSmwIU5qwo+RYV6l+RcV+5YixwVyqngWUbruMMG4CZ117/RAeLGAjaDDgRNlY3/zUGmbQIZLZ/vReU1OzlOfCaaDnObgBNeTi7VY7KMSJXDEMB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CPqkSkgq; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d485886545so10901711fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 01:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712218671; x=1712823471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u1kW5hhZmfYVG/s9V1ae03PuvAVXgYYRwAD09uGrjgY=;
        b=CPqkSkgqysoTQNURzMnCJ2WLT+jRtJNszEGUmC2niH5FbnOrRzsPxz0liMl/MGEBCw
         qAVecSJXxvSoDQDZtWgKJyUXJyn1mZYzYUgyxiRW01gcohHywGIevu33acKMyP/oonUG
         dO93V4KqTq97O2dE53mDVpa6nYyJsBEW7tKMN8WSj/yF+HCslyaWO91mherkVeRl86aq
         mFDBPaW6gv/bYevSQ0YPIcSQYh0UrXrKkkQsT9Lt+x2kTz8x0uC3v/pH0yEl5A9/NHX8
         Ov25BnpE/H5GaQsl/R3+8OD1eKbB9QnrH/husdHYMjiPcU2hSUB3jberkE5W2zQxj/d4
         lujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712218671; x=1712823471;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1kW5hhZmfYVG/s9V1ae03PuvAVXgYYRwAD09uGrjgY=;
        b=q6S1AUrejGs6INNb79xB8dJvpQjvykmGEq0yhy3FbVdeNvmum6xJaWhNtoVM7USU0H
         oXuxEEalHDwtSrJXtPusHoIi0Y5Kjk2VZGFrITfmQib+bvgGeN07/4vH04zXIhtlo/Ni
         R/S/93+Vk8gXP+ihauS1eDrzzprJYfWEUIsKqoJrAPzYFHVVaSS+YoIC1aR7ERp3pJOY
         LliwSMFmXbQqvqh798h2FRZLdlkLlmsGc6+q5TIzt0tKUIk6OYyNOvuhHkiIdMJyML+m
         zY4i+RWSndpLcTe3tn0rM6K7RtAL0SKz+ptrtVVpbKDLpPIgQkmVlKGc9SYE7LaADIPj
         yKdg==
X-Forwarded-Encrypted: i=1; AJvYcCXb3ZnNFy3HAbVrx72GQSqaFmyiGTU/FBjfjWQBPK58aCyJYZGGt+fmtXitrhhaqMvTD/bi7lLF16mXgoRJ8YUTVPefDvF40tO1PlTj
X-Gm-Message-State: AOJu0Yyo7tqYf08JLkj+xwkgTz/xlrwmgcZgYR7fky0tUT9Ust6GuX7f
	tHfu2UzaUp0rSWex2X9r8015557HbNuccsi/LXQuOXxMf0FsecuRLkz1BdQueBw=
X-Google-Smtp-Source: AGHT+IH4yyuhQuU+eQtBwBS4Q3958ruB0cKCKvSgq4YiijjsU3JTbKBSrgOoFpYuqtiaVgq88ZmDqQ==
X-Received: by 2002:ac2:4e16:0:b0:515:8dd3:e94d with SMTP id e22-20020ac24e16000000b005158dd3e94dmr1841327lfr.68.1712218671018;
        Thu, 04 Apr 2024 01:17:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id 12-20020a170906300c00b00a47342b53a4sm8655457ejz.191.2024.04.04.01.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 01:17:50 -0700 (PDT)
Message-ID: <358fc8c1-a4ef-4047-af89-fae11a1ff75c@linaro.org>
Date: Thu, 4 Apr 2024 10:17:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] Add Synopsys DesignWare HDMI RX Controller
To: Shreeya Patel <shreeya.patel@collabora.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, mchehab@kernel.org,
 hverkuil@xs4all.nl, hverkuil-cisco@xs4all.nl, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
 shawn.wen@rock-chips.com, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm@lists.infradead.org
References: <20240327225057.672304-1-shreeya.patel@collabora.com>
 <35f774-660d3b80-3-513fcf80@97941910>
 <86150c89-11d5-4d52-987e-974b1a03018f@linaro.org> <3049149.687JKscXgg@diego>
 <c790c8ba-a9bd-4820-8084-1294e5e523d9@linaro.org>
 <36bd27-660e6000-3-6c1c1e00@12777057>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <36bd27-660e6000-3-6c1c1e00@12777057>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/04/2024 10:07, Shreeya Patel wrote:
> On Thursday, April 04, 2024 11:45 IST, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 04/04/2024 00:48, Heiko Stübner wrote:
>>> Am Mittwoch, 3. April 2024, 13:24:05 CEST schrieb Krzysztof Kozlowski:
>>>> On 03/04/2024 13:20, Shreeya Patel wrote:
>>>>> On Wednesday, April 03, 2024 15:51 IST, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>>>
>>>>>> On 03/04/2024 11:24, Shreeya Patel wrote:
>>>>>>> On Thursday, March 28, 2024 04:20 IST, Shreeya Patel <shreeya.patel@collabora.com> wrote:
>>>>>>>
>>>>>>>> This series implements support for the Synopsys DesignWare
>>>>>>>> HDMI RX Controller, being compliant with standard HDMI 1.4b
>>>>>>>> and HDMI 2.0.
>>>>>>>>
>>>>>>>
>>>>>>> Hi Mauro and Hans,
>>>>>>>
>>>>>>> I haven't received any reviews so far. Hence, this is just a gentle reminder to review this patch series.
>>>>>>
>>>>>> Why did you put clk changes here? These go via different subsystem. That
>>>>>> might be one of obstacles for your patchset.
>>>>>>
>>>>>
>>>>> I added clock changes in this patch series because HDMIRX driver depends on it.
>>>>> I thought it is wrong to send the driver patches which don't even compile?
>>>>
>>>> Hm, why HDMIRX driver depends on clock? How? This sounds really wrong.
>>>> Please get it reviewed internally first.
>>>
>>> For the change in question, the clock controller on the soc also handles
>>> the reset controls (hence its name CRU, clock-and-reset-unit) .
>>>
>>> There are at least 660 reset lines in the unit and it seems the hdmi-rx one
>>> was overlooked on the initial submission, hence patches 1+2 add the
>>> reset-line.
>>>
>>> Of course, here only the "arm64: dts:" patch depends on the clock
>>> change, is it references the new reset-id.
>>
>> Wait, that's expected, but it is not what was written. Claim was HDMIRX
>> driver depends *build time* ("don't even compile").
>>
> 
> For some context, when I was testing the downstream driver against the
> device tree, I saw some failures because of the missing reset ( which I am trying
> to add in the first two patches for this series )
> 
> ...
> 	hdmirx_dev->rst_biu = devm_reset_control_get(hdmirx_dev->dev, "rst_biu");
> 	if (IS_ERR(hdmirx_dev->rst_biu)) {
> 		dev_err(dev, "failed to get rst_biu control\n");
> 		return PTR_ERR(hdmirx_dev->rst_biu);
> 	}

That's a driver....

> shreeya@shreeya:~/collabora/rd/rockchip/linux$ make dtbs
>   DTC     arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dtb

and that's a DTS.

> Error: arch/arm64/boot/dts/rockchip/rk3588.dtsi:187.23-24 syntax error
> FATAL ERROR: Unable to parse input tree
> make[3]: *** [scripts/Makefile.lib:419: arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:481: arch/arm64/boot/dts/rockchip] Error 2
> make[1]: *** [/home/shreeya/collabora/rd/rockchip/linux/Makefile:1392: dtbs] Error 2
> make: *** [Makefile:240: __sub-make] Error 2

They are not related anyhow. Look above which Makefile target produced
error. Which file failed to build. This is a expressed in make[3] line.
Directory is expressed in other places.

> 
> Sorry for referring this as a driver build failure but I am sure you would 
> also have not been okay with the above issues.
> Ofcourse I can simply remove this dependency from the driver but maybe
> that will affect the functionality and I didn't want to send a buggy patch series.

What dependency?

It seems you did not understand anything from Heiko's message, so please
reach to your colleagues for explanation where is the dependency.
> 
> My intention here was just like Heiko said, to keep all the dependent patches
> together. I didn't know that would be a trouble for Maintainers.

They are not dependent.

> 
> FWIW, HDMIRX patch series was reviewed multiple times and that is why you
> see a Reviewed-by tag from a Collabora Engineer. Sometimes the things that look
> problematic to one might not look the same to others and that is why I asked you
> to provide some more details about the problem that you were seeing.
> 
> https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/merge_requests/21
> https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/merge_requests/17

Sorry, that's some third party gitlab... I don't know what does it prove.

> 
> 
>>>
>>>
>>> Am Mittwoch, 3. April 2024, 12:22:57 CEST schrieb Krzysztof Kozlowski:
>>>> Please do not engage multiple subsystems in one patchset, if not
>>>> necessary. Especially do not mix DTS into media or USB subsystems. And
>>>> do not put DTS in the middle!
>>>
>>> picking up your reply from patch 4/6, there seem to be different "schools
>>> of thought" for this. Some maintainers might want to really only see
>>> patches that are explicitly for their subsystem - I guess networking
>>> might be a prime example for that, who will essentially apply whole series'
>>> if nobody protests in time (including dts patches)
>>
>> There is no school saying DTS is allowed to be in the middle.
>>
>> Other schools are indeed saying that seeing DTS is good and
>> recommendation is to post it separate and provide a link. That's way you
>> avoid DTS being pulled by Greg, media or networking.
>>
> 
> This was my mistake and I simply forgot to remove the DTS when I was
> testing the driver for the last time before sending the v3 upstream.
> Adding it in the middle was incorrect, I should have added it as a separate
> patch but honestly this has always been very confusing and the expectation
> differs from maintainers to maintainers.

There were guidelines - presented in the conferences, mailing list and
even SoC maintainer profile explains how patches eventually end up. I
agree that it still might be confusing, but these are the basics of
submitting patches to anything touching SoC. Anyone working with SoC
will need to know them, so how about Collabora creates some internal
guideline explaining this, so such confusions could be avoided?

I know that such guidelines exist in other companies...

Best regards,
Krzysztof


