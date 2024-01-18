Return-Path: <linux-kernel+bounces-30483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C22831F36
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86F7BB243EC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0722E633;
	Thu, 18 Jan 2024 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CL3ilbyd"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826A02E636
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 18:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705603384; cv=none; b=hRQgZa36MTJ/pQTR9gTzSLHECB/HLziAHcSAwLAhpF4e7qE4HOLDMffAIzo+2b+cQBjvFU972uB+T5biDZUqzm1askopOcMXr+VOpxgum1bPrEHxMRpKodxjDcu1bgpoyqQ2jsHtlH/YaAGSIn4AXrCR1mIOdrI7FBe+YfiJwTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705603384; c=relaxed/simple;
	bh=HEXphMu6SjLMMxjbVMmpM5JJ4Fe57kTgpaE41xWIJDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDFqxdItgBad4ua/NfePB7Hwnz+BVqaj85HT7WZyqvjc6clR38ciiqNMQOpYPU8OAEH6u/drsG8O1SEMtE/FamVpzT1Hrr2zCwnF5dDQiQEyeHYmVrJx4aoLvg8cJ6ZL5ywxqqVXmRYc0qxFRInJPOoM32y88cbo+zASZv0ZQNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CL3ilbyd; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d6fbaaec91so14537165ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 10:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705603383; x=1706208183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeI4j4Idz7TgFBkGXvSs6IJWNfZQHvsM8zwFWZMGmnM=;
        b=CL3ilbydRQRVDl4MDNVKnaYBn4oK8juBE4Jn6jX4me8xuwNOLl6ke4fzhmibthCdcF
         w8QoG0sgcKv/MOOLGzHzkBFvgYHPXoCb096Rr8lLgmsvXsTZ+OxIwIeEOhKzBiDtRHCb
         xrOwAfMZgt6htQcZUy+F45RVtRO+1IAs0T2auiFQ2x27eXcRlNP6gO+FUkEO/6EM46aW
         wGtrzVRvrITS3tmi/DpokDD+UeSTh7rFIp09PohEXNvzVfQoGVLmVL/hVals74WMqDWx
         SXedzjp/6wvw/sWzvfUo+s1CkxTHbntDXFpRRZssplcKdPy12wm81XVFIS7tJLiJXF2S
         7Myw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705603383; x=1706208183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zeI4j4Idz7TgFBkGXvSs6IJWNfZQHvsM8zwFWZMGmnM=;
        b=mZpfv6hs2b6S5DlUmVePB7mr3fI3I8GHUQY5hQnr2DJZToKjB+4PTa4mCPhuroMCrJ
         jymjCC2aE0+XMM3LtOsvNhKnd3iFflixxdmVn1Jicc4N55p2wTigBNfHUkI+WnNmxhw7
         bv7X3XhpG7Jgjo1jZAPEnUXZfFMnAdDnUDBjFYq8y3B1DzLXfKSKJwk2NRbulc4lfbdB
         m4EG85gnEg67I8L1Oz6BaHx53lIe+Y5q1BWVefdYdpe0bBN6ZLh0srRtdnO8TYWgRa28
         0+cdE+uiEjS7K89z8z7fwE/Zm/J//cqvXsUnXJlchsUrhMAeZbFbtjKNhT/WxitCMGLS
         Z7DQ==
X-Gm-Message-State: AOJu0Yw2B3sLI3dpuRAxnyxNqlOEmcT94NWkRK41IV5M1YXZc9742Zbt
	ZDR0GMQp/KZYT3Fv5wI1cHn5RYP9ZEDUUNLhy6zzP8lNh89fiWN5JIFVsMn5Etw6UnN8LIK3gPq
	RwtwM5YY0qNH9I8lK8iyyaESf3q5SY9EL
X-Google-Smtp-Source: AGHT+IEv6grbIYOdIbrLGcDoMuL5oGvrY167ZnJIUjcc2FGCIJPklTHs8Ji5ii04DRVGjB5D5E/088J8y73CSq9bHec=
X-Received: by 2002:a17:90b:ec4:b0:290:3652:d1b1 with SMTP id
 gz4-20020a17090b0ec400b002903652d1b1mr742158pjb.10.1705603382785; Thu, 18 Jan
 2024 10:43:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220809142457.4751229f@imladris.surriel.com> <d0a136a0-4a31-46bc-adf4-2db109a61672@kernel.org>
 <3193bf5b-4e22-412f-8c5b-68574942d9bc@kernel.org> <CAHbLzkoL6sCDciHqVMJga288853CHdOTa5thOPQ9SHKSqjGGPQ@mail.gmail.com>
 <7103dfea-0db3-44b7-9b2e-e89d4edd19d7@kernel.org>
In-Reply-To: <7103dfea-0db3-44b7-9b2e-e89d4edd19d7@kernel.org>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 18 Jan 2024 10:42:50 -0800
Message-ID: <CAHbLzkqa1SCBA10yjWTtA2mKCsoK5+M1BthSDL8ROvUq2XxZMw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Rik van Riel <riel@surriel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@fb.com, 
	Matthew Wilcox <willy@infradead.org>, Christoph Lameter <cl@linux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 11:04=E2=80=AFPM Jiri Slaby <jirislaby@kernel.org> =
wrote:
>
> On 18. 01. 24, 1:07, Yang Shi wrote:
> >> This works around the problem, of course (but is a band-aid, not a fix=
):
> >>
> >> --- a/mm/mmap.c
> >> +++ b/mm/mmap.c
> >> @@ -1829,7 +1829,7 @@ get_unmapped_area(struct file *file, unsigned lo=
ng
> >> addr, unsigned long len,
> >>                    */
> >>                   pgoff =3D 0;
> >>                   get_area =3D shmem_get_unmapped_area;
> >> -       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> >> +       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> >> !in_32bit_syscall()) {
> >>                   /* Ensures that larger anonymous mappings are THP
> >> aligned. */
> >>                   get_area =3D thp_get_unmapped_area;
> >>           }
> >>
> >>
> >> thp_get_unmapped_area() does not take care of the legacy stuff...
> >
> > Could you please help test the below patch? It is compiled, but I
> > don't have 32 bit userspace or machine to test it.
>
> Yeah, for x86_64, it's semantically the same as the above, so this works
> too:
>
> Tested-by: Jiri Slaby <jirislaby@kernel.org>

Thanks!

>
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -811,6 +811,9 @@ static unsigned long
> > __thp_get_unmapped_area(struct file *filp,
> >          loff_t off_align =3D round_up(off, size);
> >          unsigned long len_pad, ret;
> >
> > +       if (IS_ENABLED(CONFIG_32BIT) || in_compat_syscall())
> > +               return 0;
> > +
> >          if (off_end <=3D off_align || (off_end - off_align) < size)
> >                  return 0;
>
> thanks,
> --
> js
> suse labs
>

