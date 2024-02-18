Return-Path: <linux-kernel+bounces-70257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24654859554
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A25D2B2102A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5E2E544;
	Sun, 18 Feb 2024 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eWzFXJ6e"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B5E2CA8
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708242872; cv=none; b=IoSOxo6PBEHgUQGJuBEO6kdlmNlJ2zk4rNR6dq235d4rG4ZcryMNcqQSVOAe/J+baVOjA+nmHvpEw7FbCRGeAIYOZ8s2BLQjHnBQvoFREPl97rRR52WtFRZkgIc59IBlp45f5kEF2G7AHtW+EczC3N7uFd0njpN/+hKjgpSOnpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708242872; c=relaxed/simple;
	bh=4cOP/oBQEEDik3LAt/EfJ4cRr19Eors6IRjnRmL/xOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7UybXXRTt4/nkNIRqXhT+NNm/dcuTOUS0S/CqZhYuzuDAVbfStHLS6quPqXBBH/Vq9gLdWDqDaRafLf1IFRBXZtKfycJOymCSlWT0F7/OSfZWRziyLJHoQytA/pXUSdDknopKOd8n62w0hoSVnZkc232EhZYfoEyE0KEuUXaqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eWzFXJ6e; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7d5c40f874aso1624945241.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 23:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708242869; x=1708847669; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gJ2L9fNJYKMBNrnXV18Ja+6CS5sjhRFPehfcYBs4xrQ=;
        b=eWzFXJ6eqjPn+kg8Ls5kXsv65z6BtcN+mXyUDDuwnKtP4BWvodRS43MXElATd+0fgZ
         GupRXfEOYThtIL3OeuuDB6UqHC7dadd0FNpYU1gZd0YlV4+ZoTEKvXpJ3tVbujJ9f7/d
         z03tyL6r1mLhXoSYGYXelHVHwTUP8Wy68xcJNw1pwFqggD0mtnc5fhseNxud0pPIOp8h
         D//v6rQCxkGwUrD5hv83fe3vSE8YUUCjO5jtrxL09lfQ0RcFe38zN+oec1QRVOHmqd04
         glj+yng89YRblcDHBq3XCHhNMr8v/1w4I185xhrD4Yh8ktA4yflYG76QHgO5w8Ahgzo0
         jI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708242869; x=1708847669;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJ2L9fNJYKMBNrnXV18Ja+6CS5sjhRFPehfcYBs4xrQ=;
        b=QZlEHm5moU/Jdpl1ktz7K7z5I+7DA7xpYFiwoA2wGs7hgBS+hE6tg1HoM+moW92vna
         MsEFszzmUQSgzqJkf13KiVxu0l6/UDGJ2HdmEJTfa3UgslPoDJo6XS56HCFI+S9EJ0/H
         td+HSgrJ7Zih/ku+gE3BGjxL6v28IVN+jl4CjxS/Dlnzx7ywkzxhOyR/JdYMKaU2ImvP
         btDJ+AiDCXCAckEyAgAKP/PTufq4Ife4XQn+CjOZ0QeqkeZI9Waqm6TdwJ0FkrWxQsBE
         BHHd2mK46nCSm5J/lb3lu99UY8NmyHnBj6ExvWNm7sjJ3RvfHhvz2GqAfOCGdvCu8lvr
         Tc2g==
X-Forwarded-Encrypted: i=1; AJvYcCXBrzYmulcEjvPoTLce/K4vjGlyBSB0Uj9uePDDqFpv+iXevg4ogzWVQplXFLfadsX7kfcFbxGGIoJH3GfU542UUGt2xsrC7hW9n5fN
X-Gm-Message-State: AOJu0YyItgyOtokjq8ugmig7nf04UXE+FwZONvy3qpLXjXzWfooTm45k
	HTaZju7Wc/VvRs4VUa3dLRMAFenNaSmzuU54Pkc4DBoH3st0GjZfBI0tmuH1S6KP3prUyeXPbOD
	CuHwN1cp84s0M3X7coPboa1S/7V412Ay/rc4vt3wZGjmHxhuc9Do=
X-Google-Smtp-Source: AGHT+IE/Xcw/KWaPa1CbbhJ5cctVq226IFNKyz1IX3FmhL9zHqK32U4B2rS1QE4Sc0pJXJoeKyE2lsx2ITjjvfIL3Fk=
X-Received: by 2002:a67:be06:0:b0:470:3a99:f3c with SMTP id
 x6-20020a67be06000000b004703a990f3cmr2392342vsq.23.1708242869395; Sat, 17 Feb
 2024 23:54:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217104311.3749655-1-arnd@kernel.org>
In-Reply-To: <20240217104311.3749655-1-arnd@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 18 Feb 2024 13:24:18 +0530
Message-ID: <CA+G9fYt6riy6as7sS=T6iDxvo-pA2JT+N6SVbg8TWx4tOY8u5w@mail.gmail.com>
Subject: Re: [PATCH] [v2] ALSA: core: fix buffer overflow in test_format_fill_silence()
To: Arnd Bergmann <arnd@kernel.org>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Feb 2024 at 16:13, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> KASAN caught a buffer overflow with the hardcoded 2048 byte buffer
> size, when 2080 bytes are written to it:
>
>  BUG: KASAN: slab-out-of-bounds in snd_pcm_format_set_silence+0x3bc/0x3e4
>  Write of size 8 at addr ffff0000c8149800 by task kunit_try_catch/1297
>
>  CPU: 0 PID: 1297 Comm: kunit_try_catch Tainted: G N 6.8.0-rc4-next-20240216 #1
>  Hardware name: linux,dummy-virt (DT)
>  Call trace:
>   kasan_report+0x78/0xc0
>   __asan_report_store_n_noabort+0x1c/0x28
>   snd_pcm_format_set_silence+0x3bc/0x3e4
>   _test_fill_silence+0xdc/0x298
>   test_format_fill_silence+0x110/0x228
>   kunit_try_run_case+0x144/0x3bc
>   kunit_generic_run_threadfn_adapter+0x50/0x94
>   kthread+0x330/0x3e8
>   ret_from_fork+0x10/0x20
>
>  Allocated by task 1297:
>   __kmalloc+0x17c/0x2f0
>   kunit_kmalloc_array+0x2c/0x78
>   test_format_fill_silence+0xcc/0x228
>   kunit_try_run_case+0x144/0x3bc
>   kunit_generic_run_threadfn_adapter+0x50/0x94
>   kthread+0x330/0x3e8
>   ret_from_fork+0x10/0x20
>
> Replace the incorrect size with the correct length of 260 64-bit samples.
>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Suggested-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> Fixes: 3e39acf56ede ("ALSA: core: Add sound core KUnit test")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

> ---
> v2: use a named constant as suggested by Ivan Orlov
> ---
>  sound/core/sound_kunit.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/sound/core/sound_kunit.c b/sound/core/sound_kunit.c
> index 5d5a7bf88de4..4212c4a20697 100644
> --- a/sound/core/sound_kunit.c
> +++ b/sound/core/sound_kunit.c
> @@ -8,7 +8,8 @@
>  #include <sound/core.h>
>  #include <sound/pcm.h>
>
> -#define SILENCE_BUFFER_SIZE 2048
> +#define SILENCE_BUFFER_MAX_FRAMES 260
> +#define SILENCE_BUFFER_SIZE (sizeof(u64) * SILENCE_BUFFER_MAX_FRAMES)
>  #define SILENCE(...) { __VA_ARGS__ }
>  #define DEFINE_FORMAT(fmt, pbits, wd, endianness, signd, silence_arr) {                \
>         .format = SNDRV_PCM_FORMAT_##fmt, .physical_bits = pbits,               \
> @@ -165,7 +166,7 @@ static void _test_fill_silence(struct kunit *test, struct snd_format_test_data *
>
>  static void test_format_fill_silence(struct kunit *test)
>  {
> -       u32 buf_samples[] = { 10, 20, 32, 64, 129, 260 };
> +       u32 buf_samples[] = { 10, 20, 32, 64, 129, SILENCE_BUFFER_MAX_FRAMES };
>         u8 *buffer;
>         u32 i, j;
>
> --
> 2.39.2
>


--
Linaro LKFT
https://lkft.linaro.org

