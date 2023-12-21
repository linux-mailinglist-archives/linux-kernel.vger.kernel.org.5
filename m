Return-Path: <linux-kernel+bounces-7865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D98A81AE76
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024911F2449D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246A6AD5E;
	Thu, 21 Dec 2023 05:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8vWU9A+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF37AD4B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 05:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-54c77e0835bso485805a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 21:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703137223; x=1703742023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoKD59FQ8KF+PjXIUMFsCWtLMYHroPhscXhFuRMvJmQ=;
        b=a8vWU9A+cUV/eGV36AYBgg3hHdIdR8BaXhy8PnGstuVbSOmeKEEIGuXfgVjbpTA3L4
         tCOCn1e2SPw9Le63HfLKyo4rHC+xejXu+8W9cDn9Cq3K09R4iiiT+Y5PLYcYz/F+F6vh
         YNoAD13gMhZEoZdxzUE6+pxKKb51vdBr1zmLBVD6FKmLTPXCLcM5YMoJ8J6tglLQg9fu
         /JxNFODC8o3t04Hu9jGnWE7Kcho02/aTwH7z6xvCs9Q4tRw5w/jHusTTfcykgDhnO3dq
         gpd0LvVLijZgcyCLsizFSkxEsE8TXjBb7z34LHRsfd42jtmGQoqHrcaik91tJYkjq11/
         klbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703137223; x=1703742023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoKD59FQ8KF+PjXIUMFsCWtLMYHroPhscXhFuRMvJmQ=;
        b=j1Z4CNs23dl8WIGv0oD60aaf5hAVYMcfYpGuYbPsXiFG+s7uDY2sj2gcVJ55HtgVaG
         jEq6SU2DZzNsshkBAnL4oI6EaDYAa7F4/VxOa+fcIFORqdIZEOaKxmjjMIEVW6OuXNSb
         bYOpn4AS2fsgPdYw72ekH02BpLf2ATn8Kbyb5ek4Vl38cjLNdAtiokAoyYnqJdISz9Tq
         0eGa6d0P2G7EASfKMAg9zHddlceknIjhbilmN/rgptbknjzY9wU+FsQuV4xoxfSutibN
         sM+OUWjz+h5emxQF9DiWFJIWZbYQl3B1KnQue2sCSFZoDja9kVJqoMItrdz70eEvcrpu
         ADmA==
X-Gm-Message-State: AOJu0YyPRQ0jUJ602++lX5Mi1rCEeLFvBXLs1/yVUP1s77Wr5eryyTXJ
	Iiq7BelXwfxo6Onb0NYuuGsjQrwC3/Nb/0wOzSlPRQ9eYx36nl5w36I=
X-Google-Smtp-Source: AGHT+IECXI/KIO0fCAfyQQchXo0yiUpeazNAOyAZc81HxMxghK5DzwOcd7sz8snz+Fvk36CL9Lv56IEXz89ckXIFhEQ=
X-Received: by 2002:a50:9b16:0:b0:553:5a86:560a with SMTP id
 o22-20020a509b16000000b005535a86560amr2864694edi.56.1703137222896; Wed, 20
 Dec 2023 21:40:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220052839.26970-1-jiajun.xie.sh@gmail.com> <20231220095343.326584f605e8ce995ac151d0@linux-foundation.org>
In-Reply-To: <20231220095343.326584f605e8ce995ac151d0@linux-foundation.org>
From: Jiajun Xie <jiajun.xie.sh@gmail.com>
Date: Thu, 21 Dec 2023 13:40:11 +0800
Message-ID: <CADOw95fss1AY_xuQV+4iOLZOA0ofYAaK7uCJHPiuVVLZDZBa6A@mail.gmail.com>
Subject: Re: [PATCH v1] mm: fix unmap_mapping_range high bits shift bug
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 1:53=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 20 Dec 2023 13:28:39 +0800 "jiajun.xie" <jiajun.xie.sh@gmail.com>=
 wrote:
>
> > From: Jiajun Xie <jiajun.xie.sh@gmail.com>
> >
> > The bug happens when highest bit of holebegin is 1, suppose
> > holebign is 0x8000000111111000, after shift, hba would be
> > 0xfff8000000111111, then vma_interval_tree_foreach would look
> > it up fail or leads to the wrong result.
> >
> > error call seq e.g.:
> > - mmap(..., offset=3D0x8000000111111000)
> >   |- syscall(mmap, ... unsigned long, off):
> >      |- ksys_mmap_pgoff( ... , off >> PAGE_SHIFT);
> >
> >   here pgoff is correctly shifted to 0x8000000111111,
> >   but pass 0x8000000111111000 as holebegin to unmap
> >   would then cause terrible result, as shown below:
> >
> > - unmap_mapping_range(..., loff_t const holebegin)
> >   |- pgoff_t hba =3D holebegin >> PAGE_SHIFT;
> >           /* hba =3D 0xfff8000000111111 unexpectedly */
> >
> > turn holebegin to be unsigned first would fix the bug.
> >
>
> Thanks.  Are you able to describe the runtime effects of this
> (obviously bad, but it's good to spell it out) and under what
> circumstances it occurs?

Thanks for the quick reply.

The issue happens in Heterogeneous computing, where the
device(e.g. gpu) and host share the same virtual address space.

A simple workflow pattern which hit the issue is:
        /* host */
    1. userspace first mmap a file backed VA range with specified offset.
                        e.g. (offset=3D0x800..., mmap return: va_a)
    2. write some data to the corresponding sys page
                         e.g. (va_a =3D 0xAABB)
        /* device */
    3. gpu workload touches VA, triggers gpu fault and notify the host.
        /* host */
    4. reviced gpu fault notification, then it will:
            4.1 unmap host pages and also takes care of cpu tlb
                  (use unmap_mapping_range with offset=3D0x800...)
            4.2 migrate sys page to device
            4.3 setup device page table and resolve device fault.
        /* device */
    5. gpu workload continued, it accessed va_a and got 0xAABB.
    6. gpu workload continued, it wrote 0xBBCC to va_a.
        /* host */
    7. userspace access va_a, as expected, it will:
            7.1 trigger cpu vm fault.
            7.2 driver handling fault to migrate gpu local page to host.
    8. userspace then could correctly get 0xBBCC from va_a
    9. done

But in step 4.1, if we hitted the bug this patch mentioned, then user space
would never trigger cpu fault, and still get the old value: 0xAABB.

