Return-Path: <linux-kernel+bounces-76120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAB085F327
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE8A1C21E37
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0470F24A0D;
	Thu, 22 Feb 2024 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sapkbjF7"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06F620310
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708591214; cv=none; b=ZTjlUxnUDOkTw597aVn4hImLFJo/sssCWl+7uLikdAqt0NUMqcBqZJ0Lxb/Fa8mswMUdsug6j7EZ5zCRFdOfWPbgQ83l0tHpvBbYrceKg75Q+bRC32S9xJKyDoi20BRo+95pdR7+NeR6ccXTFKM/kJJrZ5qGRTwa8Jy1b7hEqII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708591214; c=relaxed/simple;
	bh=PMBRQjSEiBo2Py5lJSRtY5q0z87HJGdO/UnELhJZl2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nc/zWixXPVU9K+q6cuHowslDuqO+ush+q/ful8LKeBe244+950QKXpjt2IeX79l89tiSDKHYYieM6lLIVz4L1hqJ3rLRJqKotAUc1/gA64PR+kIgkrmwXduYGR57FipmfV4XeHXIyx4pwPVytWFOCWagDwdAwiGanen6X3XFU8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sapkbjF7; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-564d9b0e96dso3329995a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708591211; x=1709196011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SrhuXXR3YophYxvTYOrzf6DN2Xf7cYwIpn5F8zaAcso=;
        b=sapkbjF7ZHS7PdbTCOSsxp7oedR/YIEWGHlQ4DrlbsV+AHCqpXAsIzVwwlJdV6POKq
         Hp8QBXjuayiYH7HuMxurcg++zyRzkufw9ZsSTZYyb1FKMJBcPl2RzDx1Bf8PQBJUSfz8
         08sHfj1nZaUIEQhgOTJLbhDqzJIKB5XDMWZF5i/VdmZhdMiq5fFKZQQKTMrN7DILf4/m
         H8Cl19RRvk+rvI4bHUG1QCPVoj7uKWsEbC/++98dgGI0l21NS5l5nR7rFX6mvH8+VFnQ
         QByT9hteHyifr3oP1xnwfiUGbXTalUQiRfMAhm10lBztOYO7/EMhX1+jedCxdqMA/rLh
         OTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708591211; x=1709196011;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SrhuXXR3YophYxvTYOrzf6DN2Xf7cYwIpn5F8zaAcso=;
        b=qrvQh9VPGACcnCqaGtHBIr54lum87V7vjKEfM79GmBODcXmaot9oCYt6Q7+sAU7PgQ
         yNgPCdpALZ8S3xWz81/REseKdpGFaKkS1XRFErarAve0XGgvnsS0lidIWWXH1tXzApIL
         /orvmtOO2sQAwb3AMIGECCoYDm/Y8ZuhmzefKJhrZL0VNdHe4P2nLhkSoYDiyZTmBpAO
         r7hT0bncwdTkWWNhifxmAAe7g4cCkhR0JrwquXT4SXTOYVynrHbJwm1B5eEVupfGgh2n
         mTyhICRAe6GQLq2Uyb6YiJ/rPCQY+GrVHzevefr+bbzThmCZMBDaJcwy9KCO1/ns03Bc
         L2+g==
X-Gm-Message-State: AOJu0Yy3PwmyX9NF7gEp/rFWnYGQTM3zMAqk7EUDT1xULC+jsNr0MMvk
	xvp6fhRZXq87V+ZzkDBHBesY1N+yAV04k3odM0yAFBcj67WvFJ3zKQTEY1J5dt8=
X-Google-Smtp-Source: AGHT+IGqK1E4c7d2RNehtYTGfr+BIS2r25U6HXf+qKjDPMG6ua0rg/nBsJZZDZOTGtdfLV7YWjQKUA==
X-Received: by 2002:a17:906:ae4a:b0:a3f:24e8:deb8 with SMTP id lf10-20020a170906ae4a00b00a3f24e8deb8mr3485518ejb.12.1708591211040;
        Thu, 22 Feb 2024 00:40:11 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id vw15-20020a170907a70f00b00a3f3a5d6752sm1364286ejc.51.2024.02.22.00.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 00:40:10 -0800 (PST)
Message-ID: <bd071521-7f7b-41e8-8786-ad2eeb58b03e@linaro.org>
Date: Thu, 22 Feb 2024 09:40:08 +0100
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
To: Javier Martinez Canillas <javierm@redhat.com>,
 Maxime Ripard <mripard@redhat.com>
Cc: linux-kernel@vger.kernel.org,
 Enric Balletbo i Serra <eballetbo@redhat.com>,
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
 <9083c414-62f2-4bff-93ee-13f8ff60eb34@linaro.org>
 <874je1ipb4.fsf@minerva.mail-host-address-is-not-set>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <874je1ipb4.fsf@minerva.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2024 20:34, Javier Martinez Canillas wrote:
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:
> 
>> On 21/02/2024 16:24, Maxime Ripard wrote:
>>> On Wed, Feb 21, 2024 at 04:10:12PM +0100, Krzysztof Kozlowski wrote:
>>>> On 21/02/2024 15:48, Maxime Ripard wrote:
>>>>> On Wed, Feb 21, 2024 at 03:22:38PM +0100, Krzysztof Kozlowski wrote:
>>>>>> On 21/02/2024 15:13, Javier Martinez Canillas wrote:
>>>>>>> These options are needed by some Linux distributions (e.g: Fedora), so
>>>>>>
>>>>>> How ZRAM is needed? Why Fedora cannot boot without it? Debian, which I
>>>>>> use on my arm64 boards, does not have any problem.
>>>>>
>>>>> Is it relevant in any way?
>>>>
>>>> Yes, because it is justification why we are doing it. Each commit is
>>>> supposed to explain "why" and the explanation here is not enough.
>>>
>>> There's a why though: it makes Fedora boot. It might not be enough for
>>
>> I want to know to understand. Maybe it is not really neeed but "nice to
>> have"? People write various vague statements...
>>
> 
> I usually try hard not to be vague. There was a why, it wasn't enough for
> you and that's fair.
> 
> But I think the crux of the why was explained: I don't want to remember
> each time that need to troubleshoot something, what options are missing
> in order to boot Fedora.
> 
>>> you, but that's a different story. So, if it's not enough, please state
>>> exactly what you expect from that patch description so Javier can
>>> provide it.
>>
>> Any explanation what ZRAM is necessary for Fedora to boot.
>>
> 
> I mentioned already in another email, Fedora is enabling the systemd
> zram-generator and not having a /dev/zram0 slows down the boot to the
> point of being unusable. One could disable that service but then is yet

That one sentence would be enough for me.

> another thing to remember when trying to boot an upstream kernel built.
> 
> Could had added all this information to the commit message but I thought
> that it would be too much...
> 
>>>
>>>>> I'm sure Debian can boot without MEMORY_HOTREMOVE, or BRIDGE, or
>>>>> NUMA_BALANCING, or BPF_JIT, or NFS_FS, yet all of them are enabled. Let
>>>>> me know if you want hundreds more examples.
>>>>
>>>> So if there is any bug, you are allowed to add new one? If there is any
>>>> silly option, you are allowed to add new one?
>>>>
>>>> Feel free to propose dropping of any irrelevant options.
>>>
>>> No, of course you aren't. My point is that Fedora is a distro just as
>>> established and legitimate as Debian is. And apparently "it makes Debian
>>> works" is a reasonable argument, since, well, it does.
>>>
>>> If making Fedora boot with that defconfig is not a legitimate goal,
>>
>> It is, but I asked for more information.
>>
>>> please state why, and document it (with the ack of all the maintainers
>>> involved with that defconfig, obviously) so we don't have the same
>>> argument over and over again.
>>>
>>>>>> I kind of repeat comments from similar patch earlier:
>>>>>> https://lore.kernel.org/all/fe1e74a2-e933-7cd9-f740-86d871076191@linaro.org/
>>>>>>
>>>>>> About XFS: I don't think it is needed to boot anything.
>>>>>
>>>>> Just like 9P_FS, NFS or UBIFS.
>>>>
>>>> NFS is often used on targets, e.g. my board farm, but also by other people.
>>>>
>>>> UBIFS was added recently because one device was using it - you needed
>>>> it. 9P_FS looks unnecessary.
>>>
>>> So all we need is one person or use case to require it? Sounds like
>>> we've checked that mark here.
>>
>> Use case of given type. I would disagree for SMBFS because we have NFS.
>> UBIFS is hardware requirement. 9P_FS seems like virtio case.
>>
> 
> So that means that for aarch64, some filesystems have more precedence over
> others? It's OK to have ext4 or btrfs but no xfs? Honestly it seems quite
> arbitrary and subjective for me.

Yes, subjective, but to be honest: I would drop Btrfs. I was thinking
about it, but since Arnd agrees on XFS I won't fight that battle.

> 
>>>
>>>>>> This is a defconfig, not a distro config. Please don't make it distro.
>>>>>>
>>>>>> I will gladly support things needed by systemd or equivalent, but not
>>>>>> unusual filesystems needed by distro.
>>>>>
>>>>> It's a defconfig. It's whatever people want it to be. Or we need to come
>>>>> up with a clearly defined set of rules of what is acceptable in that
>>>>> defconfig or not, and prune every option that isn't.
>>>>
>>>> So that's the rule I am commenting from time to time. defconfigs are not
>>>> distro configs. These are reference hardware configs and debugging
>>>> configs.
>>>
>>> Supporting a board farm is hardly either.
>>
>> Debugging purpose, but I agree we can drop it.
>>
>>>
>>> And again, I've never heard of such rule for that defconfig in my ~10y
>>> as an ARM platform maintainer. But what do I know, right?
>>>
>>>> I was working in distro so trust me - they do stuff differently
>>>> and they not need XFS in our defconfig for anything.
>>>
> 
> Which distro? Every one uses a different filesystem. SUSE uses btrfs,
> Debian I think ext4, Fedora uses xfs and so on. It's OK if the policy
> is that the defconfig should only be compatible with Debian, but then
> should be written somewhere.

Hm, don't all these distros support choosing the filesystem? I did not
propose Ext4 because Debian is more important or something, but because
we need to choose something and it is kind of default for many people.

> 
>>> Sure, but you're not just arguing for XFS there.
>>
>> I raised need for "why" for ZRAM and un-necessity of XFS. What's wrong
>> with that? I should send separate emails or what?
>>
>>>
>>> What I really don't get is this: this makes the life of people easier.
>>
>> Again: this makes my life harder. I cannot be buying new machines every
>> two years to be able to compile defconfig while testing/working.
>>
> 
> And not having it enabled makes my life (and other fedora users) harder
> because xfs needs to be enabled every time that an upstream kernel needs
> to be tested.

We can here disagree that we might have a bit different needs... I just
provided argument why I object.

> 
>>>
>>> Being able to test an upstream kernel quickly when you have a bug in a
>>> downstream distro is super valuable for any distro developper. And on
>>
>> That's a distro need, not relevant. And even if it was, then your
>> argument would be "let's enable everything distro has!". This is not a
>> distro kernel.
>>
> 
> It's not a distro need in my opinion but an upstream kernel developer
> need. If I have had chosen xfs for personal preference, would that be
> any different?
> 
>>
>>> the long run, if we don't make the switch from a kernel distro to a
>>> mainline kernel relatively easy, we're the ones that will lose out.
>>> Because people just won't bother, or be frustrated and thus super
>>> reluctant to do that work.
>>>
>>> That's the part I don't get. Why do we want to make the life of people
>>> harder. This patch has never been about making the defconfig the main
>>
>> Because it makes my life harder and I don't see benefits. Quoting Arnd:
>> "Unfortunately this will increase build time noticeably, but"
>>
> 
> The benefit is for developers who use Fedora to be able to boot their
> kernels built using defconfig, just like developers using other distros
> can now. We already have ext4 and btrfs, but somehow xfs is not OK.

I would drop btrfs :)

Best regards,
Krzysztof


