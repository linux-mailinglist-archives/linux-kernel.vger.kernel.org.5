Return-Path: <linux-kernel+bounces-84810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9985086ABE0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397A91F269BE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7A9364AE;
	Wed, 28 Feb 2024 10:09:24 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB842D052;
	Wed, 28 Feb 2024 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709114964; cv=none; b=HG5rafy41h85sQd3guqcbeQWJf+xBNA0JEajVjqzkXPz3Oi4e2/Kn+ujo+g0AUVewr5JSvjhZW31qiMALoX7VlpR/YDzgHDWm/tAfaUS4gN4/4Z6pXX4xk43P/ozHnUtZAHhzFAml41POQJyS3KgL/XzNRY+PcMPQjO6DAOvPls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709114964; c=relaxed/simple;
	bh=Y/N54uYuQQOGm0T/0RrXeURdYc6prMJfZOab8x8pTyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzuS6EkLhmbmt7YtxuveaZ8KrqgXEOK1VNUahXVHuA5Cw3tKreh8Tmwk9kEGmoAOQ2URPS9d25dWXzsJLiM3yHJeQ9dZ5uJYX0e/thY00ZpQUha23lEZeFC62VkPqVNNqCLl7r/3i+GRlElJNjCeWXfJ6B7dsvJZf0mlm1ZQzqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6093247d1acso12634007b3.0;
        Wed, 28 Feb 2024 02:09:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709114961; x=1709719761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JkF52itMFctZfGHkRFOKbmrL2KHMgOrT0AHL5pYx+8=;
        b=BmG/A5OZxFgPhhh7GPr5JXVJiVnBb/eOWCMvQDyYZgHMcV8nq3bqObdikcGFl01TN+
         ONNE7wu/I9malLQ4W4EzBgZeDdS7wzFpuaosWHGeDqJGdugKprZDggsV3hklanwwxW9I
         QPLMVY0CgJUr1A6UzGOoB1OYPCGVERKpxWUKC29MV02TmKn8/uOWUKgejCSR75kJKinW
         YfdITJYYQa+OCF7CyKMBRYc4fJYm0AXXFUulP56nUxTkow31JkXexmQFoQk5M0uS/s36
         OG9QakwGRKoujOnHcnqVIld0mOKA5XHB/LoSz7vzvt4wPN2I2ncUcx+HRX4FvZknYch0
         Lxyw==
X-Forwarded-Encrypted: i=1; AJvYcCUpC2Av5wWRI0VHTupIGTEYeftmIjuLO2Py+lRhWv08rRyw3Y1DFL3aMCtJlkuAPZTAeelM42+bG3rXPbcWLheR+j1e75gwjs+LcrV6e5kF1rC58iFlSqIIZB1VUiVqJIEatPya
X-Gm-Message-State: AOJu0YyfBAN0AlLIusNK/9uV9S6W4E09XJKADGisto4LLOvuSBjpHPXX
	0BOLQF2JXrd57haVnqe6yzobyLX3tfiNXgc4LbIScf8gX++wiN0A4uUdOdTKq17F7A==
X-Google-Smtp-Source: AGHT+IFIRIorTALtXQ0i4CUL5x0UpwjueBJp834qkHOAfOwY7QRoj2czbWiSC8zCrqqRdJ6nu9ghpw==
X-Received: by 2002:a05:690c:9d:b0:607:9dda:676c with SMTP id be29-20020a05690c009d00b006079dda676cmr5582604ywb.18.1709114960712;
        Wed, 28 Feb 2024 02:09:20 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id h4-20020a0df704000000b006079b97c437sm2328343ywf.98.2024.02.28.02.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 02:09:19 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6093247d1acso12633577b3.0;
        Wed, 28 Feb 2024 02:09:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVtOsT4qOGBjlk0lrDWGVFnSi/qNEV36hwzoiyt0HMbq/yK4gxIuukS1g7lasa435QmPicVt91tNMyNI0Z0pjMHj59EMG9aUjtwfTR7lJUMcWPU3+VuUOv0tuKXevr0zcdHEei7
X-Received: by 2002:a25:e401:0:b0:dbe:4f15:b5cf with SMTP id
 b1-20020a25e401000000b00dbe4f15b5cfmr2155194ybh.15.1709114959404; Wed, 28 Feb
 2024 02:09:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228085824.74639-1-dawei.li@shingroup.cn> <754c3acb-538d-45a1-84a1-0bebd02fd945@kernel.org>
 <673EAB52C5659E99+Zd799lrOHAVIdm3S@centos8>
In-Reply-To: <673EAB52C5659E99+Zd799lrOHAVIdm3S@centos8>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 Feb 2024 11:09:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVSK2Ek6=uRE=FwibOqbCYifYsJ5otRXBpA1vW6tBqPMg@mail.gmail.com>
Message-ID: <CAMuHMdVSK2Ek6=uRE=FwibOqbCYifYsJ5otRXBpA1vW6tBqPMg@mail.gmail.com>
Subject: Re: [PATCH] mk68k: Fix broken THREAD_SIZE_ORDER
To: Dawei Li <dawei.li@shingroup.cn>
Cc: Jiri Slaby <jirislaby@kernel.org>, gerg@snapgear.com, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	set_pte_at@outlook.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dawei,

On Wed, Feb 28, 2024 at 10:34=E2=80=AFAM Dawei Li <dawei.li@shingroup.cn> w=
rote:
> On Wed, Feb 28, 2024 at 10:11:05AM +0100, Jiri Slaby wrote:
> > On 28. 02. 24, 9:58, Dawei Li wrote:
> > > Current THREAD_SIZE_ORDER implementation for m68k is incorrect, fix i=
t
> > > by ilog2().
> >
> > This is not a good commit log. Incorrect in what way and why is the fix=
ed
>
> Agreed.
>
> > version correct? And what is affected? Note you're referring to a chang=
e
> > which was done 14 years ago. It definitely must not be that incorrect (=
for
> > everybody).
>
> It's 'right' just for current PAGE_SIZE & THREAD_SIZE configs:
>
> // arch/m68k/include/asm/thread_info.h
> #if PAGE_SHIFT < 13
> #ifdef CONFIG_4KSTACKS
> #define THREAD_SIZE     4096
> #else
> #define THREAD_SIZE     8192
> #endif
> #else
> #define THREAD_SIZE     PAGE_SIZE
> #endif
> #define THREAD_SIZE_ORDER       ((THREAD_SIZE / PAGE_SIZE) - 1)

Indeed.  The only supported values for THREAD_SIZE_ORDER on m68k are
0 and 1.

> But it's incorrect in generic/mathematical way.

True.  But does it matter much?
I.e. do you plan to add support for larger values of THREAD_SIZE?

What about changing the #ifdeffery to set THREAD_SIZE_ORDER to an
explicit value, and calculating THREAD_SIZE from THREAD_SIZE_ORDER
instead?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

