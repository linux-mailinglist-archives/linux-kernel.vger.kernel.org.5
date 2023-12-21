Return-Path: <linux-kernel+bounces-9039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B2B81BF7D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52FA32859D5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82300745C7;
	Thu, 21 Dec 2023 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0L6pdioM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC98651B3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e68243b67so223359e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703189662; x=1703794462; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ijpi7yL8jJKP/LTHTn6tiHQRczMxthGLWkutDiKOvB4=;
        b=0L6pdioMDuF165iiRuns8H9PItu+bNbcYNV0g829gJER/VJRzdDg+VBtilu4gA0RHo
         1nEUgqn5lSJAxY4oFxR9xn5EeJCB/PB30IurC//Mp+yOj4bfGlbm8s+vC1KHX44tgtZy
         CryJA26h7KZ7+PyfFmCFlSzzRCnFyV75Qng97AkQgOMiYlnGy1fXfr0BWBuWEYXSBuFg
         BLG7/xQhiBQb7Lm54WXKu3hBuV6yKy93BeNkzehiGqhiIZlx42S47c2e/FMKjwTioBzd
         AlIErK6fQz8CwbGEYJWTDlUtKhZcx4IEHi2nLiJrQYI+qjtO4yqriEliOTtS2/Upwzc0
         D5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703189662; x=1703794462;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ijpi7yL8jJKP/LTHTn6tiHQRczMxthGLWkutDiKOvB4=;
        b=j4lPPfvCk0S8fTgl2iK+ndqUuip0ArIpnuvJGhMkG3+xgT/jbQ8rEu6AEyxzckqvuL
         nvMCf1BM0MnwpijAS+D+1lHMqvaK7hB8aJTWujMBlX9am6Q7g1xi7vhYy5eBJ9cvum4O
         41LYG8KrKWe3Q++qptLPLIHCxAFMPzismZChNk9LZTwxiCaWB7F0aGiMMuzj30pkrUg9
         XnkEcUdbmM1No+wtW9VFqHnU/0K2MSbzdDoSid06fpS6X3eesNGCepvuJjlyT+OgXgc4
         7NDTSuLM9qQSMt98jNJqlOPPB9rW5+UZRTYq8AkabqpERaYD1hxhfL5fuiGy8z3qgi0n
         UsGA==
X-Gm-Message-State: AOJu0YwEeBck4bHYQBfGAfdG9eey3CNDKaeYV7dGRQYZiaEig0wxp+Nr
	0s3TQ3Knqo08PSMU/x1IwbYurGBrAOpQBCpjZ2uPlnkYCFgX
X-Google-Smtp-Source: AGHT+IHBnrac0FEpnHGgr+WUxPanK1JDmNnibxTtSW5ojDg1dk13bRfTTGEW38UxwbiZtW29eD+v3LwcFyB1OtSnzHw=
X-Received: by 2002:a05:6512:3767:b0:50e:644a:d384 with SMTP id
 z7-20020a056512376700b0050e644ad384mr83656lft.129.1703189662207; Thu, 21 Dec
 2023 12:14:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221183540.168428-1-andrey.konovalov@linux.dev> <20231221183540.168428-4-andrey.konovalov@linux.dev>
In-Reply-To: <20231221183540.168428-4-andrey.konovalov@linux.dev>
From: Marco Elver <elver@google.com>
Date: Thu, 21 Dec 2023 21:13:44 +0100
Message-ID: <CANpmjNMJM0zp9qmxh0MkAfKTLgzkcxyraGMp6JKSf9YquW4WMg@mail.gmail.com>
Subject: Re: [PATCH mm 4/4] kasan: simplify kasan_complete_mode_report_info
 for tag-based modes
To: andrey.konovalov@linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>, Juntong Deng <juntong.deng@outlook.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Dec 2023 at 19:35, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> memcpy the alloc/free tracks when collecting the information about a bad
> access instead of copying fields one by one.
>
> Fixes: 5d4c6ac94694 ("kasan: record and report more information")
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kasan/report_tags.c | 23 ++++-------------------
>  1 file changed, 4 insertions(+), 19 deletions(-)
>
> diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
> index 688b9d70b04a..d15f8f580e2c 100644
> --- a/mm/kasan/report_tags.c
> +++ b/mm/kasan/report_tags.c
> @@ -27,15 +27,6 @@ static const char *get_common_bug_type(struct kasan_report_info *info)
>         return "invalid-access";
>  }
>
> -#ifdef CONFIG_KASAN_EXTRA_INFO
> -static void kasan_complete_extra_report_info(struct kasan_track *track,
> -                                        struct kasan_stack_ring_entry *entry)
> -{
> -       track->cpu = entry->track.cpu;
> -       track->timestamp = entry->track.timestamp;
> -}
> -#endif /* CONFIG_KASAN_EXTRA_INFO */
> -
>  void kasan_complete_mode_report_info(struct kasan_report_info *info)
>  {
>         unsigned long flags;
> @@ -80,11 +71,8 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
>                         if (free_found)
>                                 break;
>
> -                       info->free_track.pid = entry->track.pid;
> -                       info->free_track.stack = entry->track.stack;
> -#ifdef CONFIG_KASAN_EXTRA_INFO
> -                       kasan_complete_extra_report_info(&info->free_track, entry);
> -#endif /* CONFIG_KASAN_EXTRA_INFO */
> +                       memcpy(&info->free_track, &entry->track,
> +                              sizeof(info->free_track));

Not sure why the line break is necessary.

>                         free_found = true;
>
>                         /*
> @@ -98,11 +86,8 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
>                         if (alloc_found)
>                                 break;
>
> -                       info->alloc_track.pid = entry->track.pid;
> -                       info->alloc_track.stack = entry->track.stack;
> -#ifdef CONFIG_KASAN_EXTRA_INFO
> -                       kasan_complete_extra_report_info(&info->alloc_track, entry);
> -#endif /* CONFIG_KASAN_EXTRA_INFO */
> +                       memcpy(&info->alloc_track, &entry->track,
> +                              sizeof(info->alloc_track));
>                         alloc_found = true;
>
>                         /*
> --
> 2.25.1
>

