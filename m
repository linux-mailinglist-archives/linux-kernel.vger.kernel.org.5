Return-Path: <linux-kernel+bounces-104734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C78D787D2E8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE8F1C2223F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BFB4CB41;
	Fri, 15 Mar 2024 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HGrZiE2M"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745CF4AED8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710524186; cv=none; b=P31t+gGmmODC6AsGdyU8+925Cp4XcUi7OXrjoPaxaxHDTsdHHxeBB2ogys3BnxMdAH/Mh+6dY35sBXfZzau6F60VEREUNmGAyB3RGKITjSvKNrVSyR1AqNGVLOrDwyVZoGqmC68yUm41+fVT5tmbyD2FQ6o70Nm9bj8FKDGtbRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710524186; c=relaxed/simple;
	bh=j3POmon0ej8OD9b/cQu2u0opDXlOgUB4xDQ6A+YIzrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fd1gEmoGCtVninxbNvKRgu7iH6gC/FSybDjkEzwrhRqxg7cKWV23dc1FocVDyH2zQ7NzEyHUkjmBDqJ22k8eKtT2dMxDCyzyqMNmGPvNjK7zqKEWVMMZL8rGe5Hylbv5uMPLWUivqXNuX+/jUkWBdCi+WH71cU8Xu+X9b1lk5Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HGrZiE2M; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d4698f4936so31363781fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710524183; x=1711128983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ec9RrIuQWFrWDmIdusRv4/vXGJuKnTeszoS+IpWRfc=;
        b=HGrZiE2MvOCQe7hdBa8yJYshT097kkXsfzHjnc7a6jmz9M/uV6iPg8Pg2nCp4Ky3tw
         tpuAH4h/rbddiJowlcl2l3oZLV//ewOKcwV4/8mLHgxn9wdt3UZ+1nyJRwho3xYhhmrY
         0U7kEkY/ZR8QmvMshZ9neQa614rxAJ87CUnRo9HTXPvx4OVSw9PyPL813bPYjywxwYyK
         VFGhYbuBUtLp0nPAv29G6MFL6WxfHxgzGS43g0+hg0RO0vZwma18tr+Swe2jP7690wUZ
         k0CD8WMoHP29oPleEJeChf4ZxJ7/rePbsAWLBnlWWfsipfv5FNU3frGMpLFqBMYnM7Qe
         L35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710524183; x=1711128983;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ec9RrIuQWFrWDmIdusRv4/vXGJuKnTeszoS+IpWRfc=;
        b=oKyWqAoPnDylQGt9FMehKfkgYsIkkSNKenk3ufyoUainKxd0vCA4oU7lPnMkejWJ+b
         SsoZSDIf6qCJjIQVJz9y0TIzXVZrWnyRqZ3ZxJRlMg9f2Jxs/DeEHJrw/6B98efDXps6
         EDI3OdfGLwDQFb5lk9AGxThX4BtJ3TMABymQH/m7/xhEV2BI7defV4pzqRMT4Cg9vZk2
         uCfid8VCcrq63qF9xkTOJ1+sUsEsqaFCb8L+CtxONsDXljFyDxCG9QjaFcdkWVcmMF2e
         jjCzu9oyvI1FXXWAVgdAQUHEwDL0h+4T2xyfXZAE9wAy+bCXVrG0fe41hb8ZTiDw38o3
         jo+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJqlVMQ5OCLBtWY9l3C9W8kdxDng+lQ/PGeno2I4VtT+sT2ZaQjuwSdFnGmSSK8vcLLksvZpga/KxCINaFZ7lP7iqCe5GZg9kbiD5u
X-Gm-Message-State: AOJu0Yw+0jx6/qd8gfRxX2HXo+knKuGsVknAeXBojbkuER3fOgriVtPp
	q7zFfN0mLz8RYhj5hmMvMq64TpxBVw0zfEQsx8uhAaE+TyDP3uwAWxNdTn8F2lk=
X-Google-Smtp-Source: AGHT+IFk5NGPtCj8mXhvsYrdH1nre5XfSVGVRBDeRwQi7zLXGNIq4CodW9FczpHV1YSFYg82SuoADQ==
X-Received: by 2002:a05:651c:23a:b0:2d3:3b37:db78 with SMTP id z26-20020a05651c023a00b002d33b37db78mr3420227ljn.16.1710524182477;
        Fri, 15 Mar 2024 10:36:22 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id ca18-20020a170906a3d200b00a469ebf37dfsm46312ejb.203.2024.03.15.10.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 10:36:21 -0700 (PDT)
Message-ID: <a9ad625a-c6fd-44f1-8776-aa5d54b448ae@baylibre.com>
Date: Fri, 15 Mar 2024 18:36:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/18] ASoC: codecs: mt6357: add MT6357 codec
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nicolas Belin <nbelin@baylibre.com>
References: <20240226-audio-i350-v1-0-4fa1cea1667f@baylibre.com>
 <20240226-audio-i350-v1-12-4fa1cea1667f@baylibre.com>
 <9891855d-2284-42e4-9d3a-35ba406540e8@sirena.org.uk>
 <c441a132-b16b-4244-a712-8971c902d4d7@baylibre.com>
 <ff3d2db1-697b-42c6-a0f2-74276e9fc098@sirena.org.uk>
 <dda0e6ba-4538-47a0-95e9-6adcfd4169a7@baylibre.com>
 <0d31ffb2-9df5-4c3e-a728-902b71a1a713@sirena.org.uk>
 <fd53a0e7-fa70-4c0d-b578-393183487335@baylibre.com>
 <0a41b498-5cca-4487-a0e0-0df749f6e796@sirena.org.uk>
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <0a41b498-5cca-4487-a0e0-0df749f6e796@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/03/2024 16:15, Mark Brown wrote:
> On Fri, Mar 15, 2024 at 04:05:21PM +0100, Alexandre Mergnat wrote:
>> On 15/03/2024 15:30, Mark Brown wrote:
> 
>>>> Let me know, when you change de gain to do a ramp down (start from user gain
>>>> to gain=-40db), next time for the ramp up, how/where do you find the user
>>>> gain ?
> 
>>> In the register.  You only need to reset the gain to -40dB at the start
>>> of the ramp.
> 
>> Sorry but I don't understand your logic, I'm not able to implement it...
>> If I'm at -10dB and doing a ramp to reach -40dB, next time I will read the
>> register the value will be -40dB.
> 
> After we've done the ramp and turned the amplifier off we can just
> restore the desired value?  The hardware is not going to care what the
> volume is while it's not enabled.

If you do that, HP will be enabled at the saved gain, and after that you 
will do the ramp. To avoid pop, the driver should be rewrite to:

   Read gain in the reg and save it locally
   Set -40dB in the reg
   Enable HP
   Do ramp

And for the shutdown:

   Read gain in the reg and save it locally
   Do ramp
   Disable HP
   Set saved gain in the reg


To resume, that add 4 more steps to save 2 integers into the driver 
structure.

IMHO, I don't think it make the code more readable or optimized, but I 
don't have a strong opinion about that, so if you think it's better, I 
will change it.


> 
>> This implementation is also done in other MTK audio codec drivers.
> 
> Perhaps they should be updated too?
> 
>>>> When microphone isn't capturing, the gain read back from the register is
>>>> 0dB. I've put some logs in my code and do capture to show how it works:
> 
>>> Is this a property of the hardware or a property of your driver?
> 
>> At the end of the capture, the gain is set to 0dB by the driver.
>> At the start of the capture, the gain is set to the setup gain.
> 
> So that's a property of the driver then?

Yes

> 
>> AFAII from the comment in the code, it's done to avoid the "pop noises".
> 
> Yes, that's the usual reason to ramp gains.  Though if you've just
> copied the code without checking that it's needed it's possible that
> this is something that's been fixed in current hardware.

I did the test at 24dB with and without the "pop filter". Isn't big but 
I ear the pop at the start of the record without the "pop filter".

To be clear, the algo/behavior of this code is an implementation based 
on the 6k+ lines downstream code for this specific audio codec. But the 
shape/style is based on upstreamed drivers like mt6358.c.

-- 
Regards,
Alexandre

