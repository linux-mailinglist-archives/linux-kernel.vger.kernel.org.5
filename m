Return-Path: <linux-kernel+bounces-9030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 299B381BF6B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26941F24FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83054745D7;
	Thu, 21 Dec 2023 20:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fRUwPKb8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFA5651B3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4b6c8d8bcc1so260213e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703189228; x=1703794028; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=46inm7EUcbpVm7rpSw28k0//HHFlqfxCAk6ESa9fcvo=;
        b=fRUwPKb8XgtIFQJSk6BoZxv7kb3auZpr8Y1e1s7JVc1i4QqEf1QgQPFcPglDT5f+u5
         OmasVzYHcIGYCc0rxq+NVDpkzE67ZQTflqVn+FSthUUo4+XhB3rGDNOxHhjRcTy8BdC9
         vq4UUQQSMvoZqAG1vzCavO5Xy7YMzY4DGUIh5py/aH/V62Wog/NiwjFgmku19zbaEOCH
         /RHxcIxrkRSlVhY76PfzJoJkeR81FMINFFEidxXXPnS4PH9FJry7vJGkb/sAbxAB6lnD
         XvZRp7jsZG9XCoDOd8EvMc7fPS7NOGibFrxYuTqBMIUyrpsY4yk/Hhvs9XckK+VCDVDC
         /6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703189228; x=1703794028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46inm7EUcbpVm7rpSw28k0//HHFlqfxCAk6ESa9fcvo=;
        b=gnJmdAEJC5higsdddY3oD74kaBZCQo/3QgyqR86XXPyxdkAY/qG+Uq7DNxqu4zyeDJ
         2Vc5tEAdJJ5MTyGefvDvMbxwu9fHQAd9VMpdYJRRfB+mEWEoLNV5lBd/g52lNWMwZZbH
         Sw9zJt5oaljue8Dw0JlmlSI+Xsw7Nm7o6p/bxPD50r0b2cmp4/2mL1I5dY/MARYG0q/W
         oaykatA7SIqFqXuY2VQKOLfqkof8En7+1fJURqELmmotbH5hPZNVToehUk7e4PxuIBHX
         7ziUJzJ3aByd3tCLrrOkQdrfFVSAtLx5cS4161ml6KXHW0I7sI+jIR7BAd+73G7mceAx
         VXpg==
X-Gm-Message-State: AOJu0Ywk9l20rLcC11HUQWlza5bCtm7F1TQXuF5bPj7mv4XEu9rIhFsL
	E+HXT4j8EKth1RK1iY0pMAzlIT+pa7EveeCMmy+4Y7bUClbj
X-Google-Smtp-Source: AGHT+IFWJBf021bVD3HBL1XMDg2r6jCFj7xkufEA0sRc3cU6qhLMt+3BsUWsDxPRWECM2VrQvPeFVdWjTAGKBl9DBjs=
X-Received: by 2002:a05:6122:2b9:b0:4b2:f6a2:7736 with SMTP id
 25-20020a05612202b900b004b2f6a27736mr177040vkq.28.1703189228145; Thu, 21 Dec
 2023 12:07:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221180637.105098-1-andrey.konovalov@linux.dev>
In-Reply-To: <20231221180637.105098-1-andrey.konovalov@linux.dev>
From: Marco Elver <elver@google.com>
Date: Thu, 21 Dec 2023 21:06:29 +0100
Message-ID: <CANpmjNNY81MMtRVgux5725viFoq2i7PzjVvrnbJmT8ArmTMBUA@mail.gmail.com>
Subject: Re: [PATCH mm] kasan: fix for "kasan: rename and document kasan_(un)poison_object_data"
To: andrey.konovalov@linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Dec 2023 at 19:06, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Update references to renamed functions in comments.
>
> Fixes: ac6b240e1ede ("kasan: rename and document kasan_(un)poison_object_data")
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kasan/shadow.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index d687f09a7ae3..0154d200be40 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -130,7 +130,7 @@ void kasan_poison(const void *addr, size_t size, u8 value, bool init)
>
>         /*
>          * Perform shadow offset calculation based on untagged address, as
> -        * some of the callers (e.g. kasan_poison_object_data) pass tagged
> +        * some of the callers (e.g. kasan_poison_new_object) pass tagged
>          * addresses to this function.
>          */
>         addr = kasan_reset_tag(addr);
> @@ -170,7 +170,7 @@ void kasan_unpoison(const void *addr, size_t size, bool init)
>
>         /*
>          * Perform shadow offset calculation based on untagged address, as
> -        * some of the callers (e.g. kasan_unpoison_object_data) pass tagged
> +        * some of the callers (e.g. kasan_unpoison_new_object) pass tagged
>          * addresses to this function.
>          */
>         addr = kasan_reset_tag(addr);
> --
> 2.25.1
>

