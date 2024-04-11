Return-Path: <linux-kernel+bounces-139630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5688E8A057E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8AFEB2496D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E47B60B9D;
	Thu, 11 Apr 2024 01:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LKkv38HO"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBC79463
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 01:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712798877; cv=none; b=KVH4s9DwsO1FSeIp13/PJg7t/H50NrC1enfFcxrqx7jPaEYM+PQVVU2mV5gtCA4Z8zgbab75PxeCJVeNy7VLTMG+wGCu1enMWetPabho0V8svq3h1ZmoLQWO7bzqGkwI1GdZd1nOUfQIosCu3uSFPSXm1gUN5DueiLncEUgND/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712798877; c=relaxed/simple;
	bh=zY1vBuYzXUVAUPu7RYDaF9UtFORvIFjy44r4Y5Ige4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kFnO2xfY1GlwErcPHH5bjjPMAc4V8r5oPhYxf76DQIwJgvBfsY73xHKHU1SEklCGuz8RGPwhPMn6BtnDxsxcJ7ZcNwUojJkflmZP+x0A2TkCTJq2nssFtPKSUl3fe9TK2ogJva/FMIxKMdV6oFXkkikYLJNEc8pkDBHXtbMuH5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LKkv38HO; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2330f85c2ebso752646fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 18:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712798875; x=1713403675; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zY1vBuYzXUVAUPu7RYDaF9UtFORvIFjy44r4Y5Ige4g=;
        b=LKkv38HODTb7tDoqSW7ZCIK/QIRsuMQ9wf+dwQ30x4ZBho8y9efrp9yM/PjWM3ErC+
         fXD340D/fTjXt/riFHYr4ektQKre0gAPXLQ3DrwS/FDP/mntefcL7GiPcoZI3ZW/X7ER
         QESXKnJHie7YzUyiuykysAsz4/uYZIMMSWA8wPrXKlh6Qy5yGk8Oox2vJU6FL3jWrbMb
         brM4ED9ofH9Oj5IhMJPbXJJqTHQzRu9bQFrD65cGYAJAOh4T/9cpUGudUlOsMnrTkyO4
         l25xuXKUVY+T02d8Vza+IMYylD+TCRb1I279Ca/rzY/rP05249yuJnRZEDoIqtvmsh6k
         u+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712798875; x=1713403675;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zY1vBuYzXUVAUPu7RYDaF9UtFORvIFjy44r4Y5Ige4g=;
        b=gzB/EeENHxRIjtbbox4SCDK5VDZw9axB0pmB+f598cfSg1I3hjO3aSv7buOgAJufvs
         XMqK5Q9LYe/KIY+ztr6+usfoARKqOvUcw2bviQGPI+y/yN/OJKFepQKx/k4TESh7Mobe
         gMdL2YZxfaOMAVcnncdJHFeBE+XkZ2PlPVt6m84UKi+uwgFwkGphmeiOtIwjtgPO0cTt
         TV2ub+1fm4rFTM0lLDLTjX1uGOlKSdyJDyo2QLdLyH0XhMSSDzmKcSQiVps7YGS387TN
         RZLY0IYbqgNUHv72JW8jXZ0bK6h0TOMqe/n+7+Rz8sbv5fdPW7MrEzQyf2HXj4J+rNZc
         WakQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0el1ZPlkMzSghk+/MSorsIlPHiaKclqckvNh+0R6nFjzzdOwP7EI4VlElougOHajzw0ohq9JXn1nT5X/Jy6D/bzt1/RLbqYbSyIFO
X-Gm-Message-State: AOJu0Yxh9oXqcBWQbmlE1aZU/LYcCzTCuD0JAzkmRYChVX0zuHVL89r3
	bcR2zm3BTwc+bDO+AqZggZ+aVLjZBqDGOrGPAOxjlZZ4aV+JFj4X296SO7gcFz0=
X-Google-Smtp-Source: AGHT+IF8lPPFTalL1WPSfnBvduuYhf5K6F9EIeC9RLCCka0Vl/mHkW4wRauCXJubFXwb7faJCr3ffA==
X-Received: by 2002:a05:6870:518:b0:22e:bcfd:deb0 with SMTP id j24-20020a056870051800b0022ebcfddeb0mr4667832oao.41.1712798874921;
        Wed, 10 Apr 2024 18:27:54 -0700 (PDT)
Received: from localhost ([2804:14d:7e39:8470:fcac:9b42:fe81:c62f])
        by smtp.gmail.com with ESMTPSA id c1-20020aa78c01000000b006ed38291aebsm289791pfd.178.2024.04.10.18.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 18:27:54 -0700 (PDT)
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
  linux-arm-kernel@lists.infradead.org,  x86@kernel.org,
  linux-kernel@vger.kernel.org,  linux-arch@vger.kernel.org,
  linuxppc-dev@lists.ozlabs.org,  linux-riscv@lists.infradead.org,
  Christoph Hellwig <hch@lst.de>,  loongarch@lists.linux.dev,
  amd-gfx@lists.freedesktop.org,  Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH v4 13/15] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
In-Reply-To: <4c8e63d6-ba33-47fe-8150-59eba8babf2d@sifive.com> (Samuel
	Holland's message of "Wed, 10 Apr 2024 20:11:04 -0500")
References: <20240329072441.591471-1-samuel.holland@sifive.com>
	<20240329072441.591471-14-samuel.holland@sifive.com>
	<87wmp4oo3y.fsf@linaro.org>
	<75a37a4b-f516-40a3-b6b5-4aa1636f9b60@sifive.com>
	<87wmp4ogoe.fsf@linaro.org>
	<4c8e63d6-ba33-47fe-8150-59eba8babf2d@sifive.com>
User-Agent: mu4e 1.12.2; emacs 29.3
Date: Wed, 10 Apr 2024 22:27:52 -0300
Message-ID: <87le5kofhj.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hello Samuel,

Samuel Holland <samuel.holland@sifive.com> writes:

> On 2024-04-10 8:02 PM, Thiago Jung Bauermann wrote:
>> Samuel Holland <samuel.holland@sifive.com> writes:
>>> On 2024-04-10 5:21 PM, Thiago Jung Bauermann wrote:
>>>>
>>>> Unfortunately this patch causes build failures on arm with allyesconfig
>>>> and allmodconfig. Tested with next-20240410.
>>
>> <snip>
>>
>>> In both cases, the issue is that the toolchain requires runtime support to
>>> convert between `unsigned long long` and `double`, even when hardware FP is
>>> enabled. There was some past discussion about GCC inlining some of these
>>> conversions[1], but that did not get implemented.
>>
>> Thank you for the explanation and the bugzilla reference. I added a
>> comment there mentioning that the problem came up again with this patch
>> series.
>>
>>> The short-term fix would be to drop the `select ARCH_HAS_KERNEL_FPU_SUPPORT` for
>>> 32-bit arm until we can provide these runtime library functions.
>>
>> Does this mean that patch 2 in this series:
>>
>> [PATCH v4 02/15] ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
>>
>> will be dropped?
>
> No, because later patches in the series (3, 6) depend on the definition of
> CC_FLAGS_FPU from that patch. I will need to send a fixup patch unless I can
> find a GPL-2 compatible implementation of the runtime library functions.

Ok, thank you for clarifying.

Andrew Pinski just responded on the GCC bugzilla and if I understood his
point correctly, it seems to be a matter of changing function names to
what GCC (or actually the arm EABI) expects...

--
Thiago

