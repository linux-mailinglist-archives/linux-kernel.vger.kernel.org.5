Return-Path: <linux-kernel+bounces-152867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71DA8AC56C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDDBD1F22E34
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1246B52F99;
	Mon, 22 Apr 2024 07:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5DZ/D1H"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005BE4F213;
	Mon, 22 Apr 2024 07:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770573; cv=none; b=OfZJl3E6Liu14eLeQ+3uiAbMrMhYZOpqhPAXWBs4XEM9/aRlgP10xHEaz/e5IcwsdGYyi9Q2U94h9+/Xl++EDkHPNKXXrEHPYA2Fn09iJsdZOIbHklbhP5jEccYo6ZCxw2H+2G6+K7Q0c+DUz5NOxzTn0uE6Cudv6f67k6SieWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770573; c=relaxed/simple;
	bh=jhzuF9QA/7POdNqr5VvYVdizlPwxZzZbm6rVCf02xj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taDVppRy5r+tGazVMcLkJwCgutEQ9pft7uFyqse5sBnf0R1HpYdz77ErUMtE4YzQ5O2RrJFx/dGQ3EddQoJUQ0gzgN8uf58jM8FXCCtiPDjgpW5CSXBmN9KqEMYpFxPn7iPfwrVkRnj2P+LiggNQDTRC4FnPE+yF1zgqDcexS6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5DZ/D1H; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-439656c1b4fso13375151cf.1;
        Mon, 22 Apr 2024 00:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713770571; x=1714375371; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jhzuF9QA/7POdNqr5VvYVdizlPwxZzZbm6rVCf02xj8=;
        b=G5DZ/D1HiahtnUnPqjM+XHuaqBWXxzoti7RHpF6/7ysA1i0OyyNxM7Pvi7SkjfsZIZ
         hKupamAzi4EbwYIe7D/uJplphKh68Sm5Wv0xPNTSn0sRBH3FGxSmHp88bfl+U1dEWUXw
         Nou/fDvRr6h26tFNDkYoXthKopgf8HhXhfjLLaWWzrWQP72HY7FdRb5owwwqu5zyyBnJ
         +5Sabk9IMP64MVMU/Xn3YoM/lgOLQ6SGYNDI+/gO/i+sQ4LPzpGJmrJs7y/SMwIjnQC9
         HS0UgctlTK4xZT6BWlgJRjsdr1R5+jXhhQA3+JEIhh6zpLQ7dyT7aTC5k3tOpug6+uHC
         IFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713770571; x=1714375371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jhzuF9QA/7POdNqr5VvYVdizlPwxZzZbm6rVCf02xj8=;
        b=l22AYsmtxhk7xJDRsEO8Yt0izTtZ919or9sHm5G5YC9YTq7cFZg0b5FtHPSCoVXDAC
         UVCLPW5xcOV2IqBzjcNIFuCPOnhvU4goSa43zgJqcwH4fgzLGJcgjiVfS6wEO9hNcWby
         I/Jtrw3fktufK0ADzs9I8GBmS+uPUNc5SVWEQNkM/CZIAjSRdXGeJjcM5LFWwTRrIjcZ
         lifu6XuW3YkoJQPlh3a+C8CoMmh+r6izQtMh2dzaSqeYd2qe+awl+zGrUJxc/r6+mcGF
         GUbpHOSgD27C7ko69piPiFCeP7s+cZvp+HFFu/n0E6zbarOoIBt75V4ddK94dvPhdwl4
         jCaA==
X-Forwarded-Encrypted: i=1; AJvYcCVlWTUROYPPdnlh0v1NxW4NA9nQNXXrlFz5cAdHw+q5I4bMaCmHRDSjpku+FM3gG78ptJ6Fvw3EWhb+0VCiIqUjpOPL1WWGILDgDzyjhQnA7MPez4OR/2GfhIdGvfFPdHmD3SqmeHklnGDV
X-Gm-Message-State: AOJu0Yx2Lf3vezkQ2laYnDNN1W7P+5ZCflxNzRl4zWUJz576H2kMlKRQ
	tcERYzhxSaIqlxdW/APke9haBcosb96v3SG2bzpyxiz4nfdltImlc/SOsj6A78HswweCUvbhiSQ
	u3uPV5RuH3ncZdDNAr8lxYccuHQVL8t5b
X-Google-Smtp-Source: AGHT+IE5Os4sthxTtZBmRXVrUAXCWOk8CxEjvCuf0zQcLW7KWRYNpoC0BqYmBPpmgQUu7RbyvgckzngUXtVU4Jz78u4=
X-Received: by 2002:a05:622a:1346:b0:439:88ea:6e7f with SMTP id
 w6-20020a05622a134600b0043988ea6e7fmr5196724qtk.2.1713770570838; Mon, 22 Apr
 2024 00:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFGhKbzev7W4aHwhFPWwMZQEHenVgZUj7=aunFieVqZg3mt14A@mail.gmail.com>
 <CAFULd4a75kS=3cJzYKsOcJ3ULjW8k5M1cvPYZQ25zZqTo3QX9Q@mail.gmail.com>
 <CAFGhKbx3dzrMC0euRMNe5=sAhM87v=6gLwOT+c9HwWKZrWc5Gg@mail.gmail.com>
 <CAFULd4ZNi7eONVu8syiWyA5ek2TgHTf6jTM+Pf7SaSG6WyHoNw@mail.gmail.com>
 <CAFGhKbwqrr=_bOnKW+wqtX2OyW0xpS_9wkJnHpwxmwx7MHGhfg@mail.gmail.com>
 <CAFGhKbzdWLw7fmRTLYPhEycWZvfjE-OCvnWct2A_kWVe94-p-A@mail.gmail.com>
 <CAFULd4ahxmEiJ37hLXUg3RwZMW9GnkN=38ZuirSq_cu3VHMU0g@mail.gmail.com> <CAFGhKbzJ-icVy-YmPVSNd4O4AA-4QGiaYZWM+2T=xq5_-MB4MA@mail.gmail.com>
In-Reply-To: <CAFGhKbzJ-icVy-YmPVSNd4O4AA-4QGiaYZWM+2T=xq5_-MB4MA@mail.gmail.com>
From: Charlemagne Lasse <charlemagnelasse@gmail.com>
Date: Mon, 22 Apr 2024 09:22:39 +0200
Message-ID: <CAFGhKbwXOpR4GaQF11BA2viCTa6Zbcmd=fF+2yxvPiROmF+yVw@mail.gmail.com>
Subject: Re: warning: cast removes address space '__percpu' of expression
To: Uros Bizjak <ubizjak@gmail.com>, linux-sparse@vger.kernel.org
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Luc Van Oostenryck <lucvoo@kernel.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Am Mi., 3. Apr. 2024 um 09:14 Uhr schrieb Charlemagne Lasse
<charlemagnelasse@gmail.com>:
>
> Am Di., 2. Apr. 2024 um 22:40 Uhr schrieb Uros Bizjak <ubizjak@gmail.com>:
> [snip]
> > > ```
> > > git reset --hard ed2f752e0e0a21d941ca0ee539ef3d4cd576bc5e
> > > git cherry-pick 3a1d3829e193c091475ceab481c5f8deab385023
> > > patch -p1 -i ~/p.diff.txt
> > > git clean -dfx
> > > make allnoconfig -j$(nproc)
> > > make kvm_guest.config
> > > echo CONFIG_MODULES=y >> .config
> > > echo CONFIG_NET_9P_VIRTIO=m >> .config
> > > make olddefconfig
> > > make prepare -j$(nproc)
> > > touch net/9p/trans_virtio.c
> > > make C=1 M=net/9p/ trans_virtio.o CHECK="sparse -Wconstexpr-not-const"
> > > ```
> > >
> > > This now shows the warning:
> > >
> > > ```
> > > net/9p/trans_virtio.c:831:1: warning: non-constant initializer for static object
> > > net/9p/trans_virtio.c:832:1: warning: non-constant initializer for static object
> > > ```
> [snip]
> > It's this part:
> >
> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index d7779a18b24fc3..bf9815eaf4aabf 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -212,7 +212,7 @@ void ftrace_likely_update(struct
> > ftrace_likely_data *f, int val,
> > */
> > #define ___ADDRESSABLE(sym, __attrs) \
> > static void * __used __attrs \
> > - __UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)&sym;
> > + __UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)(uintptr_t)&sym;
> > #define __ADDRESSABLE(sym) \
> > ___ADDRESSABLE(sym, __section(".discard.addressable"))
> >
> > But ... how is this not const?
>
> @Luc Van Oostenryck Do you have any idea how to correctly implement it
> to make sparse happy?

ping?

