Return-Path: <linux-kernel+bounces-54756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 352AD84B33B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3191C20DC4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FD6130AE2;
	Tue,  6 Feb 2024 11:12:53 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4006DCF7;
	Tue,  6 Feb 2024 11:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217972; cv=none; b=LBKDR93b+fc0So7EhruAfqw4lHVkzIuOqm61kO49Pu8v24WobqHYTq/9Jfdjd6yYgoyGTejbRMv+yeSzukP3+FDqz1Pqm2sZmNmppdzupM52uN3hWxJUhu/98PHZI9ZMIlZfwlEZ3psikEULm+4sMVsOoJZIIHUjtU9X7ounl6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217972; c=relaxed/simple;
	bh=xLsUrWAF94DFAah13mIxpHx4xGej5buoLWWu3kHIIuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pgyg27h9Y/MVfRdZO1EDJKMtaDxfkiMkS80/rPivSYM9Rd2tc9MIdT0xnvxJLwg+j9CvxefCLs22rrOu3f1JlfDiknu9ynRtguCo+IXW22iGfiNfk/mBVLD6VGY//Euu6GX//LArCjX5K8HrG8/1DnnvfTwRNWQvVu9RYnst3qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60412f65124so50328727b3.3;
        Tue, 06 Feb 2024 03:12:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707217969; x=1707822769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8fQrZ9bDID7Tr4RFzpi8NTxLyF9LrFzXifM+3Heoz0=;
        b=ZnW7njt3Qk0NpsL3pOtOhKYH2ShgZmkOarfPvt9p+nMAsuGIgWz0Nn+z2AOZlZ/9DA
         Bp/q7rfUdAJrswzdgBmk6lCl9oBdWHwAurmqWt6HfAVYXHnwLVJFKArhN40C3BtjBrnE
         l9LHkwbme2TY4xgnWOJPuJIG+WfkwXtduaocPD/HhEceh64do9jF6QOVKprtdwwJJ0kS
         2mfj1JIkN1lh4k4Ak+T/Dcl7uftEvfdO7HueCDYVh5g3l2t28hAx5fij2bTPKB9BZmGR
         poWtS/OcOoeDi4T7cyUa0P8NA7rSLhPCCmOkZ6C6rNS/4NG8j6M8qtf4BHRe2t2Ra5vx
         jEKw==
X-Gm-Message-State: AOJu0YwjvTtybBZVZe2DeSKGFzSiLbslncF1QU4S/s7JhvczrglKVnFV
	KnlaFONgz79TxS1aSKKVx1+o6jg00Z3sKeP+rcito1K+4lWP3/6JntHxrWgXLAo=
X-Google-Smtp-Source: AGHT+IF6UNKTDJ5HQAXbkqL/RGf2jTZ8oKvmExoMjbYS8CvqOSsyteqaGwKD0a/19JNUuos30y6/ww==
X-Received: by 2002:a81:ed03:0:b0:5ee:a910:107 with SMTP id k3-20020a81ed03000000b005eea9100107mr1379968ywm.21.1707217969102;
        Tue, 06 Feb 2024 03:12:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVbLaxEdSyUjrxYAZHBYgMUAOsP23xov8DDpMe6UDjv+GmwiMIPDscIrM1DKdCxRBeDcIkDitCL1rnUS7ePeY955OXY8qNllhKLWkratu1KiJ7a6CU4swJSe5E9NHehIse3myF+gfCOPg==
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id p206-20020a8198d7000000b0060480a0e282sm125934ywg.60.2024.02.06.03.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 03:12:48 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc6d8f19ab3so5450495276.3;
        Tue, 06 Feb 2024 03:12:48 -0800 (PST)
X-Received: by 2002:a5b:991:0:b0:dc2:2654:5139 with SMTP id
 c17-20020a5b0991000000b00dc226545139mr1313669ybq.15.1707217968613; Tue, 06
 Feb 2024 03:12:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206131050.0e86d882@canb.auug.org.au>
In-Reply-To: <20240206131050.0e86d882@canb.auug.org.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 6 Feb 2024 12:12:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWjAKbt_bne8Mjpg3N_7R8TcKvAoVV8T4VrwTC2apAr_g@mail.gmail.com>
Message-ID: <CAMuHMdWjAKbt_bne8Mjpg3N_7R8TcKvAoVV8T4VrwTC2apAr_g@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the block tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jens Axboe <axboe@kernel.dk>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 3:11=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
> After merging the block tree, today's linux-next build (arm
> multi_v7_defconfig) produced these warnings:
>
> In file included from /home/sfr/next/next/include/linux/bits.h:6,
>                  from /home/sfr/next/next/include/linux/bitops.h:6,
>                  from /home/sfr/next/next/include/linux/kernel.h:23,
>                  from /home/sfr/next/next/io_uring/nop.c:2:
> /home/sfr/next/next/include/vdso/bits.h:7:40: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
>     7 | #define BIT(nr)                 (UL(1) << (nr))
>       |                                        ^~
> /home/sfr/next/next/include/linux/io_uring_types.h:538:35: note: in expan=
sion of macro 'BIT'
>   538 |         REQ_F_CAN_POLL          =3D BIT(REQ_F_CAN_POLL_BIT),
>       |                                   ^~~
>
> (and mny more similar)
>
> Introduced by commit
>
>   d964e8440442 ("io_uring: add io_file_can_poll() helper")
>
> REQ_F_CAN_POLL_BIT is 32.

All of these BIT() have to be changed to BIT_ULL().
And let's hope all variables used for storing these flags have been
changed from unsigned long to u64...

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

