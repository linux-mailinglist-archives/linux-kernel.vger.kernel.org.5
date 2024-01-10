Return-Path: <linux-kernel+bounces-21717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D7D829332
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 06:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E7C1F26A84
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 05:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5654D51E;
	Wed, 10 Jan 2024 05:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GHWuMtFp"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FF8DDA2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 05:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-204520717b3so2582739fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 21:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704863442; x=1705468242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqFyBuMc6fS1E/k0UoQASz+hs9FQx1u1fDT0hLV9lNA=;
        b=GHWuMtFpYIwoe42qRwZsGFubYEvh1fXTj969PaNa7K4dQN/p9bDPfxgRNmUvq/9AGs
         9b6DLbFmS99hUBIjS7SuK82qHTDMjHSDRO/9oQ7uAS3Bc3SvgN6iUTflIXXE58lJ4EEC
         ZiCY7ys7YxVM3PKQ3USzloKxPnkmx6tItLz/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704863442; x=1705468242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqFyBuMc6fS1E/k0UoQASz+hs9FQx1u1fDT0hLV9lNA=;
        b=LnwC0ybS287vll3hSZBusDYJxhYf4Skfn0U/RwQ1KciyIcEeiumevDwbUjrOjZlu4u
         znHA5AXt0fBaHikVX4CTyXM8EqERI5A60rIYjBj5yz2K2nLZE+hZhAg7Ezf8LCs/+k0V
         ieYLvv8gIPEJo6MKcS0fDZIOyAp0cGfh7suYSiKKy3C1CX9Xbzv3brp46VRcnNzx+GmM
         MGEpbvBkwSwGqoL4cFcZIx4FNnN1VaY6QndziUfQkhgpsUArmFK3TzxcSJFu9WfUGgmb
         fjesgjdAIOVwdV29H3D4f4SiY7JprOfp9wwtCEhU9TL2NsWgP/DIlZgg6gV6XclbRwxX
         5AKg==
X-Gm-Message-State: AOJu0YwTk5amWL9trUFlAKN3KmhOSffuaeZ68rDwtkqP94a/YKeOWRST
	/B5o7gCb2ud1AhflQnZMYIJr3o5QEPywN9As6iqzojKHXdr5
X-Google-Smtp-Source: AGHT+IFzInwEpmPhc/U9+ydEplUFYyrbuwyIxW/doupjiq5FShE4fPsCc8x8D2TMy9+WDinLmFAW9YkJ/grsITlSt80=
X-Received: by 2002:a05:6870:b296:b0:206:7b6:9700 with SMTP id
 c22-20020a056870b29600b0020607b69700mr182118oao.41.1704863441699; Tue, 09 Jan
 2024 21:10:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109154547.1839886-1-jeffxu@chromium.org> <20240109154547.1839886-2-jeffxu@chromium.org>
 <CAMuHMdWhHuhviuK=Ku-HUm_y9SzVPuubjiNfHS_jQMk4NRxJxg@mail.gmail.com>
In-Reply-To: <CAMuHMdWhHuhviuK=Ku-HUm_y9SzVPuubjiNfHS_jQMk4NRxJxg@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 9 Jan 2024 21:10:30 -0800
Message-ID: <CABi2SkVGPjeFEk7jUHHeckx9U+EuFW8ydf8oy92KCJcSHbiWNQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 1/4] mseal: Wire up mseal syscall
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 10:32=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Jeff,
>
> On Tue, Jan 9, 2024 at 4:46=E2=80=AFPM <jeffxu@chromium.org> wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Wire up mseal syscall for all architectures.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
>
> Thanks for the update!
>
> > --- a/arch/m68k/kernel/syscalls/syscall.tbl
> > +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> > @@ -456,3 +456,4 @@
> >  454    common  futex_wake                      sys_futex_wake
> >  455    common  futex_wait                      sys_futex_wait
> >  456    common  futex_requeue                   sys_futex_requeue
> > +457    common  mseal                           sys_mseal
>
> In the meantime, 457 and 458 are already taken by statmount() and
> listmount():
>
Thanks! I will adjust that in the next version.
-Jeff




-Jeff

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/m68k/kernel/syscalls/syscall.tbl#n459
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

