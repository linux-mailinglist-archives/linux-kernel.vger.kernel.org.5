Return-Path: <linux-kernel+bounces-35092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AF3838BFE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82CE61F236DD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3B65C602;
	Tue, 23 Jan 2024 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jl2CS4kx"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8619D5C5F8;
	Tue, 23 Jan 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005829; cv=none; b=R+qcqpgb+0lZK57aNZOjUIDRZWikOMsjlYaVODuKQZ+Y1fMfVQORgQbxdljtE6v7GGP+VzwQGqxP39klckLBZpkX2MlMlBiGqWxFR9oamS1vO3g5pGAVIL0B7prgw8OHaeItvIBRq8SY8Lam9pYiL2i1iA9s3SxyuK6pjPi9YdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005829; c=relaxed/simple;
	bh=IuTfm31jmkH27ZtsRdI7YSB225R0zC/IYRCm6E4NpM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8okoKP7OvIIt8/95CyjePSy/LkycnloIv0+RptK9pOoO/bAb/y65wcBjTQz/0iuG7i3IDUptcuNEmOa2vLuO7+Iw2+3fyBRMijC+rzH/k6a0a0ZTUwh+AbWK7QEPu4UAXXDSq0P5A3rBsEjMosBmfNxzTUW976kGDMS1nu4XtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jl2CS4kx; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e80d14404so4507421e87.1;
        Tue, 23 Jan 2024 02:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706005825; x=1706610625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UfUJQgdA+VjnoF0GdJmwhuit5yVFNw31FMKfbAE46Sg=;
        b=jl2CS4kxNSIG2cNUh7vExJ08cj8CelNnKbU+cYvjwZIQTugg8IXKhrujkVmZnmsXad
         O3DWoL0l5wHdx1AYmNXxuEHGFsX3+THPDRVqGa8+ooLKLig1x4bhsDqcA0/pNm8/yFb/
         lMmepRb6w36rql/fZga0D4TkLvSe/biHZjg0Pfyfk0g9izW1vNlbAY7C8Ez2HAQ4Du+c
         EisgcwaOZ5Nx0QVbOgGLhUo2txWcoFC3glszk7ZJoUALZM88Mfxsckv1TuO7qfM6m7CT
         auGKQc25iGvhHEHMxYNM3kClJQoI3IZ9L9i9hQ7N+7O8fAnIOLjKu0tG1NbGgYOm47No
         puug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706005825; x=1706610625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UfUJQgdA+VjnoF0GdJmwhuit5yVFNw31FMKfbAE46Sg=;
        b=dB8iYw+5rkxnXTnm+bgQvRuduo+DceunfnX/DicincKmSHQWEiPrLfhHGqsEvOWNvj
         cVLPHUV9EfQ87fcn8Ic/3Z9c2xW2lB6BsPfHDYdLUOH+byWZfMr194B0K2Fnk9GEYVLk
         loC7mKPXV/GTjXLKwK03ot6C+pl8004Hin+wyFJSpwwm4/FnMyWR3y+BkRtUFm4M60gJ
         o0+w59ChkJubXGW5yyRhmLXPF3/J/55yBqcXT6KF/TZu0DXxkPhLVLeTmiXX9rg76Dd5
         lIB4PdmC5VuiwVROxjM4qCQc1NCzF5tomuWPbllX2A0ldZKQm8px0uMRCnaN91SfxDY8
         o4eQ==
X-Gm-Message-State: AOJu0Yz7/XF+PZBDRdcBuF4aF4Gece4xvycorX3lrhGwwsKozxcbA0BL
	v8HJUXM7wChgK7dL5sPNE+9uXNWNBLPl49rYG6IzyLpD085efpAl
X-Google-Smtp-Source: AGHT+IGD1sk0BsABE/WOIwvIBXqlV/0BF1zFbvFFQGCzrGhf5x2WPEOq8QVqUFDbo9WAxfVjZvXDmw==
X-Received: by 2002:ac2:5457:0:b0:510:95f:83ab with SMTP id d23-20020ac25457000000b00510095f83abmr348705lfn.27.1706005825145;
        Tue, 23 Jan 2024 02:30:25 -0800 (PST)
Received: from ?IPV6:2001:14ba:7426:df00::3? (drtxq0yyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:7426:df00::3])
        by smtp.gmail.com with ESMTPSA id d3-20020a05651221c300b0050e4e943b22sm2264143lft.247.2024.01.23.02.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 02:30:24 -0800 (PST)
Message-ID: <9e4e2e80-71f5-4814-901b-a948e2c1c7c8@gmail.com>
Date: Tue, 23 Jan 2024 12:30:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: gts-helper: Fix division loop
To: David Laight <David.Laight@ACULAB.COM>,
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <ZZZ7pJBGkTdFFqiY@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
 <20240107162253.66c1f0f1@jic23-huawei>
 <a41ef2c9-bd74-4b0e-afb7-12e198847609@tweaklogic.com>
 <717b7e70-5cf8-4671-8a6b-005eefd0535e@gmail.com>
 <2985a200057c4648817094cf747fca35@AcuMS.aculab.com>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <2985a200057c4648817094cf747fca35@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/22/24 18:27, David Laight wrote:
> From: Matti Vaittinen
>> Sent: 22 January 2024 06:51
>>
>> On 1/19/24 13:56, Subhajit Ghosh wrote:
>>> On 8/1/24 02:52, Jonathan Cameron wrote:
>>>> On Thu, 4 Jan 2024 11:34:28 +0200
>>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>>
>>>>> The loop based 64bit division may run for a long time when dividend is a
>>>>> lot bigger than the divider. Replace the division loop by the
>>>>> div64_u64() which implementation may be significantly faster.
>>>>>
>>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>>> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
>>>>
>>>> Hmm. Fix or not perf improvement?  I'm going to take the middle ground
>>>> and leave the fixes tag, but not rush this in.
>>>>
>>>> So applied to the togreg branch of iio.git and for now just pushed out
>>>> as testing for 0-day etc to take a look before I rebase that tree after
>>>> rc1.
>>>>
>>>>
>>>>
>>>>> ---
>>>>>
>>>>> I've implemented also a fixup series for supporting rounding of
>>>>> gains/scales:
>>>>>
>> https://lore.kernel.org/lkml/37d3aa193e69577353d314e94463a08d488ddd8d.1701780964.git.mazziesaccount@gm
>> ail.com/
>>>>>
>>>>> That series does also remove the offending loop.
>>>>>
>>>>> We don't currently have any in-tree users of GTS helpers which would
>>>>> need the rounding support so pushing the rounding is not urgent (and I
>>>>> haven't heard of Subjahit whose driver required the rounding). Hence, we
>>>>> may want to only take this loop fix in for now (?) and reconsider
>>>>> rounding when someone need that.
> 
> Why did I look as this crappy code :-)

Well, we all make mistakes, don't we? ;) Thanks for looking at it though!

> I think the change breaks the rounding.

This I do disagree with. AFAICS, the original code does not do any 
rounding either. This specific patch was just intended for removing the 
loop. It did not add or remove the rounding.

> For 'normal' values I think you just want:
> 	return 1 + (max - 1)/scale.

I am sorry but I think I got a bit lost. What we currently have in-tree 
is just an integer division. 64bit / 64bit, where no rounding whatsoever 
is done. It is implemented with a loop - hence the "funny" if - condition.

What I wanted to do with this patch was to just replace the loop.

I think the "return 1 + (max - 1)/scale" is not equivalent?

The driver submitted by Subjahit was first user which used scale values 
which did not match exact integer gains. This is because he used 
illuminance channel with the real world Lux values :) So, in order to 
avoid manual 'change scale values to be exact multiplies of the gains' 
work in driver, I thought of doing the regular rounding in these 
helpers. This, however, is not done in this specific patch.

Even if it was, I am not sure "return 1 + (max - 1)/scale" would be 
correct? If we have for example max = 7, scale = 6, division
7/6 = 1.166666..., which rounds down to 1.

However, 1 + (7 - 1) / 6
=> 1 + 6 / 6
=> 2.

> The 'avoid overflow' test isn't needed if you subtract 1 from max.

Ah, yes. I think our confusion comes from that "overflow"-test. It 
indeed is no longer necessary as we no longer need to add anything to 
the 'max'. This whole function renders to simple:

if (scale > full || !scale)
	return -EINVAL;

return div64_u64(full, scale);

unless we implement the proper rounding. should've noticed this. Thanks 
for the heads-up!

> (Rather than return (max + scale - 1)/scale; where the add can overflow.
> But you do need something to return 1 (or error) if max is zero.
> 
> 	David



-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


