Return-Path: <linux-kernel+bounces-70819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 467D4859CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34CD1F2105A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051D4208D5;
	Mon, 19 Feb 2024 07:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kG6O2P5Y"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9163920DFA;
	Mon, 19 Feb 2024 07:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708327349; cv=none; b=McpiT3vHquUR2qmbE9OvJ1sQS57xqg+NybdBgAjM410D8ob6agr+O9IJZ/gmyzDMorHKuQ409M3nGXeLaKrbLPNmUva0SzqKzVPsgPz+uM8a/ZfSGhfeJk4KIn+gfLrHFODquBGwHX94V+fvtB9TVyfaVt0TptZ080a4p7YnDR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708327349; c=relaxed/simple;
	bh=DCwcoy6i2dIfEynaA2hMRSxAkVtFeDmoK4ATPZKLVw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxyfKSuyFrTh/eJ/+nFg9Z7WbCV5BNFt87Td7QJm1+Defe/NtRrKznd6PfJq4sJnzeT1Zkgmcz21ZBU5QJzVG/cvJgkQiwOhd3jR3/UGZIyDIzwZ7sz377h0Vt8WYrlnxLNjJ2YHDLNXBH5fI/X81guvtMTNdHDPSj5g8pcTkLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kG6O2P5Y; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d22b8c6e0dso19744731fa.2;
        Sun, 18 Feb 2024 23:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708327346; x=1708932146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cTTrsk6bp8SruacSiky2KnDgNOQi6dDXIKoIppajxgU=;
        b=kG6O2P5YSyFgNzL6y0dgdSz7pWGPRY4ICDoIVOz37FXR2Y66W/4vWKVwJQXjAJVWVI
         B/6dmTKHkUeDS6U2gpohqSkbEX1Xh8BM2KA2f2SejpcY/XuHWhAFXIRCW1b1lVb9dHBR
         T9kVG+DbAgd0UAmpbdz9U15uMCR6RpnPOK/FMelcCTuYX+cwkRUO7TVbDkWcMNobpDOn
         f0QSwNvAjwtLrkqyANb/qSBWjeFeOsasAWaWPZ4gmBMFlSz02252F4ruyy2kJFzOfmL4
         kfyNyMA65Nh6wTZceyExKZT3Jm19/u61ASZhb6h96bQFHR5/cLeZaa4tfjBjcm1hjTKP
         snBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708327346; x=1708932146;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cTTrsk6bp8SruacSiky2KnDgNOQi6dDXIKoIppajxgU=;
        b=Sfxvuos646kPEEj/MHpIIoHJHmCge2UQRPnBJezpqM7pPDbA7tGDmSWdO9ckPuCOyV
         ZsAX7NZ0XSxoYMYKWq0kbqKQrtAbyvQVon1wJbtpeePSQJzG86N7MvXz5tRainBfD36p
         Dirc/YTqMSb0GVjxjGZyTdPUKMH2wJCscQqBrQE72+f/SKPLC2jtXRPUeTPhn+zUA3Fh
         1tETv0eMvuklLDn+57bZKGol9VOb6Aq4o7Fc+ODjMCOIYOtnT1ESc4TlYEqpEJNx+mEI
         qQTcOP53Y9xN7squqdItlJn82Ns5f6x4jH1FP5qRXI8o6hf6PrTlia1UmjBrWwCs15eZ
         8kng==
X-Forwarded-Encrypted: i=1; AJvYcCVKoTZBVfP2byEn1sGX/5GJu93vZwW4/nRLyYt2A1PPcPJbL6uXLowYHjFIMFGfQExLEnFeip1khs/oDqx8O/+nO8XWA/9iYuzzt+IsCOMX9d8HlVfvNAZEfVVrTjFV7oTt3362Tx+R
X-Gm-Message-State: AOJu0Yysav+4dQln7EAGdO5tFyt1YEh7UlnsvlchzOZ/BOytctnnkq9g
	Yf+bT4iVY7Mv+5bF3niQQKTw0PykVCNT6okDtRW2GD+y+qrUfnAF
X-Google-Smtp-Source: AGHT+IFfimPVqArqhtgMYJNVlWi+J+lzLSFY5QeJ5LPNALcimXpBcgGPanYaBR1Qrx4bWJijEMsgXw==
X-Received: by 2002:ac2:4c0e:0:b0:512:bc93:8640 with SMTP id t14-20020ac24c0e000000b00512bc938640mr304269lfq.24.1708327345551;
        Sun, 18 Feb 2024 23:22:25 -0800 (PST)
Received: from ?IPV6:2001:14ba:7426:df00::2? (drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:7426:df00::2])
        by smtp.gmail.com with ESMTPSA id bp25-20020a056512159900b0051148f220ccsm792114lfb.285.2024.02.18.23.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 23:22:25 -0800 (PST)
Message-ID: <f1511679-0309-4aa6-bbfe-40d0d3374634@gmail.com>
Date: Mon, 19 Feb 2024 09:22:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2] iio: gts-helper: Fix division loop
Content-Language: en-US, en-GB
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
 David Laight <David.Laight@aculab.com>, linux-iio@vger.kernel.org
References: <Zcn-6e-0-nh2WcfU@drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi>
 <20240216135812.07c9b769@jic23-huawei>
 <dfe6e5da-b104-4acd-b323-4a7fa980de88@tweaklogic.com>
 <20240217162724.767f2ab6@jic23-huawei>
 <65582213-1091-4877-ae83-c9450a3610fa@tweaklogic.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <65582213-1091-4877-ae83-c9450a3610fa@tweaklogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/18/24 07:26, Subhajit Ghosh wrote:
> On 18/2/24 02:57, Jonathan Cameron wrote:
>> On Sun, 18 Feb 2024 01:09:33 +1030
>> Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:
>>
>>> On 17/2/24 00:28, Jonathan Cameron wrote:
>>>> On Mon, 12 Feb 2024 13:20:09 +0200
>>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>>> The loop based 64bit division may run for a long time when dividend 
>>>>> is a
>>>>> lot bigger than the divider. Replace the division loop by the
>>>>> div64_u64() which implementation may be significantly faster.
>>>>>
>>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>>> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
>>>>>
>>>>> ---


> As I understand that you have already applied this patch but still,
> 
> Tested-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>

Thank you Subhajit! Your effort is _very much_ appreciated! :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


