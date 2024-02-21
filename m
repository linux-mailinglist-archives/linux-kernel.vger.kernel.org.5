Return-Path: <linux-kernel+bounces-75009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C0B85E16D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DF031F22662
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C964980BE4;
	Wed, 21 Feb 2024 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qh3MKagF"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D154F8063A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529892; cv=none; b=ZLh8YW5780Py0jAC0hZ8iZ5THb4s1Y2wRAE6UT5gXPlpaZ5Q376gjDgNUe+fHPmrat/j2tLb0DXJPSWH9f2MTF76ay85YUbCuRo3seem9tS/PScZ8HB+VoMesjQ9kXjods4QleYyIT62QxFGqxMHue9XRNjzdiauiN8ao0cGKqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529892; c=relaxed/simple;
	bh=Bu0mJfqyJkmDVD/OgydeykdSlc4J0+gKLfF/FCmYX58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5xJXdjsdfRxsGaukV2qAK7R8DUGH1ztZ1G/wBMGqr4mne9a3arTBFCrkFhgp1qaoj1/C1ir657P+i/I55ZD0FvhOTT9l8ksVFstF94wb4HSO3J126vHAioQ8DBF3AlQjBvqwSRj2zc8+Am3y71Zu3B3+V+yffMb5s7QF+YWdpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qh3MKagF; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso480470866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708529889; x=1709134689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hEKlCTLxshJjrR0vzrCVw2fOtfdhkn1op0+oVphqyTY=;
        b=Qh3MKagFlcv/xU/WOPN0lRBHJ8K+Ikx1eOZfLaVJVY5DUhvy9pm+Y61cpJ5RhLui7K
         SfSUVcR0bqIZSWINgvWuHMn+TcGBmdlGkb+9CcQAwc3wCbJWozpS7jng6guCsPqKkttY
         nHgyu8wSuCwyyIl69DspOgfB4xiAEqOEGQc0X+bvI7keUZkijavRhAmjVMTXSi7c1d/C
         OWrT8hhmX5ClCuNgQhSmFqoq44vWO+FWwVyt+oI5ydVRTXNc+s5/aGK3R97qb6wkI/8L
         Sge0g5R2sw45oI1QE1MAJH0AbIGiETyu3HXH/GBrchzVZAABBm5XzyCy9wOqhRdayXE4
         q59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708529889; x=1709134689;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hEKlCTLxshJjrR0vzrCVw2fOtfdhkn1op0+oVphqyTY=;
        b=mEDDhIx8sndZWrp1PGVutKFo6LT0AVuI3XvpBWcWxqe+OodSLUZaKRJVvG5G4D5MQz
         o8mm+1nhpb86CfJNpMibKbmc9VbXwkadJWm87kyckgT1hQhGPvn9X/wRdMPV4poKbr71
         8jLso9WCMFDtobhq5RjgziftLKn9k/2+4Mv7R2j2wmSyZVg79Cdp+FgIZXTM7IAGPdeM
         NSvXGRuY4Puptae4cvyE+cVbZqlzeVOiZzrscNAorTxo212fnFerfCbGIQHe9DjzBaHQ
         Na24KGpHry8u7BsZ/MAGVCnvEtI8uLT8HxEM5Q9NpBnp8XH4jPxSlFBZrV66MsHZ6ikl
         1Jdg==
X-Forwarded-Encrypted: i=1; AJvYcCW6K7RFbkJQAiRzqei7CAdEmwBs1AtWgfWIQnulqtAOFKJxn+Txu85VjPmwENGMPROMYp8couA8LyNamNTEQsLKlU108DvfFvikeP2X
X-Gm-Message-State: AOJu0YzvP2GNTx1wuytwsmGcTZKXnAeTRFxhMDZPItDRpstWU+ezZldh
	mjcHjOlyypzOAm9fT5AvNbTjgnTGh0ibavcAdVJ39rb1bkttWgKCkzzbPKr0D9U=
X-Google-Smtp-Source: AGHT+IEgXPNY6KfzFpIIWCqBy8a4c+A0dwKx0vGppcKeYOF5uwpqzsk0YGrWOxXxlUbWaIyBAGxC6g==
X-Received: by 2002:a17:907:86a3:b0:a3e:f9ae:4764 with SMTP id qa35-20020a17090786a300b00a3ef9ae4764mr5641304ejc.38.1708529889062;
        Wed, 21 Feb 2024 07:38:09 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id tb21-20020a1709078b9500b00a3e51df2280sm4090336ejc.223.2024.02.21.07.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 07:38:08 -0800 (PST)
Message-ID: <9083c414-62f2-4bff-93ee-13f8ff60eb34@linaro.org>
Date: Wed, 21 Feb 2024 16:38:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: defconfig: Enable zram, xfs and loading
 compressed FW support
Content-Language: en-US
To: Maxime Ripard <mripard@redhat.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 linux-kernel@vger.kernel.org, Enric Balletbo i Serra <eballetbo@redhat.com>,
 Erico Nunes <nunes.erico@gmail.com>, Brian Masney <bmasney@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson <quic_bjorande@quicinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
References: <20240221141350.3740488-1-javierm@redhat.com>
 <1f28256c-e436-4add-aa67-2cfb2248b220@linaro.org>
 <6scz7iti3tzzrd4ph3gnuc2pvkcbtuuicgfgujh3pa3c34kdkt@bhfa4xbxeu7t>
 <cb8bf006-57df-494e-80f3-947582ec71f1@linaro.org>
 <fy3wffb2jwv4veo3golfn5olri77clxywbuwuokese7sbobixd@mird5k66cl2w>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <fy3wffb2jwv4veo3golfn5olri77clxywbuwuokese7sbobixd@mird5k66cl2w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2024 16:24, Maxime Ripard wrote:
> On Wed, Feb 21, 2024 at 04:10:12PM +0100, Krzysztof Kozlowski wrote:
>> On 21/02/2024 15:48, Maxime Ripard wrote:
>>> On Wed, Feb 21, 2024 at 03:22:38PM +0100, Krzysztof Kozlowski wrote:
>>>> On 21/02/2024 15:13, Javier Martinez Canillas wrote:
>>>>> These options are needed by some Linux distributions (e.g: Fedora), so
>>>>
>>>> How ZRAM is needed? Why Fedora cannot boot without it? Debian, which I
>>>> use on my arm64 boards, does not have any problem.
>>>
>>> Is it relevant in any way?
>>
>> Yes, because it is justification why we are doing it. Each commit is
>> supposed to explain "why" and the explanation here is not enough.
> 
> There's a why though: it makes Fedora boot. It might not be enough for

I want to know to understand. Maybe it is not really neeed but "nice to
have"? People write various vague statements...

> you, but that's a different story. So, if it's not enough, please state
> exactly what you expect from that patch description so Javier can
> provide it.

Any explanation what ZRAM is necessary for Fedora to boot.

> 
>>> I'm sure Debian can boot without MEMORY_HOTREMOVE, or BRIDGE, or
>>> NUMA_BALANCING, or BPF_JIT, or NFS_FS, yet all of them are enabled. Let
>>> me know if you want hundreds more examples.
>>
>> So if there is any bug, you are allowed to add new one? If there is any
>> silly option, you are allowed to add new one?
>>
>> Feel free to propose dropping of any irrelevant options.
> 
> No, of course you aren't. My point is that Fedora is a distro just as
> established and legitimate as Debian is. And apparently "it makes Debian
> works" is a reasonable argument, since, well, it does.
> 
> If making Fedora boot with that defconfig is not a legitimate goal,

It is, but I asked for more information.

> please state why, and document it (with the ack of all the maintainers
> involved with that defconfig, obviously) so we don't have the same
> argument over and over again.
> 
>>>> I kind of repeat comments from similar patch earlier:
>>>> https://lore.kernel.org/all/fe1e74a2-e933-7cd9-f740-86d871076191@linaro.org/
>>>>
>>>> About XFS: I don't think it is needed to boot anything.
>>>
>>> Just like 9P_FS, NFS or UBIFS.
>>
>> NFS is often used on targets, e.g. my board farm, but also by other people.
>>
>> UBIFS was added recently because one device was using it - you needed
>> it. 9P_FS looks unnecessary.
> 
> So all we need is one person or use case to require it? Sounds like
> we've checked that mark here.

Use case of given type. I would disagree for SMBFS because we have NFS.
UBIFS is hardware requirement. 9P_FS seems like virtio case.

> 
>>>> This is a defconfig, not a distro config. Please don't make it distro.
>>>>
>>>> I will gladly support things needed by systemd or equivalent, but not
>>>> unusual filesystems needed by distro.
>>>
>>> It's a defconfig. It's whatever people want it to be. Or we need to come
>>> up with a clearly defined set of rules of what is acceptable in that
>>> defconfig or not, and prune every option that isn't.
>>
>> So that's the rule I am commenting from time to time. defconfigs are not
>> distro configs. These are reference hardware configs and debugging
>> configs.
> 
> Supporting a board farm is hardly either.

Debugging purpose, but I agree we can drop it.

> 
> And again, I've never heard of such rule for that defconfig in my ~10y
> as an ARM platform maintainer. But what do I know, right?
> 
>> I was working in distro so trust me - they do stuff differently
>> and they not need XFS in our defconfig for anything.
> 
> Sure, but you're not just arguing for XFS there.

I raised need for "why" for ZRAM and un-necessity of XFS. What's wrong
with that? I should send separate emails or what?

> 
> What I really don't get is this: this makes the life of people easier.

Again: this makes my life harder. I cannot be buying new machines every
two years to be able to compile defconfig while testing/working.

> 
> Being able to test an upstream kernel quickly when you have a bug in a
> downstream distro is super valuable for any distro developper. And on

That's a distro need, not relevant. And even if it was, then your
argument would be "let's enable everything distro has!". This is not a
distro kernel.


> the long run, if we don't make the switch from a kernel distro to a
> mainline kernel relatively easy, we're the ones that will lose out.
> Because people just won't bother, or be frustrated and thus super
> reluctant to do that work.
> 
> That's the part I don't get. Why do we want to make the life of people
> harder. This patch has never been about making the defconfig the main

Because it makes my life harder and I don't see benefits. Quoting Arnd:
"Unfortunately this will increase build time noticeably, but"

Best regards,
Krzysztof


