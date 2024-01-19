Return-Path: <linux-kernel+bounces-31507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4AE832F44
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6301C23CCB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9C755E6D;
	Fri, 19 Jan 2024 19:08:35 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4515A52F6F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 19:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705691314; cv=none; b=uRtPs37HBdalNcsxPso8/IvgdI0ceeoJT4IkVEtwcmzriPD3b7flQJw/1OzEq+/cHmfBooW7V/305KqC4DSkMtrzVBxq23VaEHqb36WpJxTaW0olmFMTBPaXdAgPe3YQbrCAhEkL1dems12BiXX0R5SZWXOhxMaIZQEwtRtoumE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705691314; c=relaxed/simple;
	bh=qYmUwZXCEwwHxrejcnynTHJSvDAkBFIcibt439a8Vro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJZMLqbDxiJS23PA1niz8vuauy4cP9R/FOmg9RD15uwXQboe/BJZUHDE+UjH+XBniTl/BrzSl4/LLriNbEL6kRw1NsgT2cYymUI8n8+a06BuFO90jbJS+H8882K7vseCI6/lCl+O1i9cjLrwwruzvjFGQeUR85PqTni3i2yYmq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5ebca94cf74so11155227b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:08:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705691312; x=1706296112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Los1bUQR+nrchlfUsUNrM4jlMLqPsXp3+vKyRRoEhFE=;
        b=guzkosMOqcZbVrX9L+o3dE+tCeExEGzRjAf5nXAlcBhQLKn1LCiut5Tb346cmGzDT2
         ZMPhcHnYR/GHijVW0ICuY8OW0QcPa/KbZM3axc1t9+2j8dXgt2ewRXKocbVtYcecJ4xt
         b2bXzDFj2VpjcU6HbIy+wt+fH/6sU72wdo11wsmU0/lLsnQEt/Ooa/V3bV8I5oHKAhc4
         tC8qX2icLgnx6XR8F/8TSIWUwOP9mBnHzg4UUXb4jXMZZ5arK9RxqjQ372/HJn/tkLOn
         Hw5fQCl6VG1tpBIoRWJICM4WLQy84COfbPT3661xX22+Zn5l+ZWW2lgv/ofNb9KJ277z
         Ztzg==
X-Gm-Message-State: AOJu0YwS03nmwRDoZ69e6uFTYJ9OsX48u2toT/r0b+buUyTv4xhob0F7
	6URXEm3yRqVYmdTP5OQX+dCRjV4f5Mturf7m9kg7dMhpXtW1Xu5oERR53rEPgQs=
X-Google-Smtp-Source: AGHT+IEy/oJhNCXxDcO72+BcpvhibpOCqyX9Wdtw67nLVPLWu5x30m4UE7wWtLCRlde7jleRevvnlg==
X-Received: by 2002:a81:a24d:0:b0:5ff:483d:d156 with SMTP id z13-20020a81a24d000000b005ff483dd156mr347270ywg.23.1705691312034;
        Fri, 19 Jan 2024 11:08:32 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id g141-20020a0ddd93000000b005ff9a21d042sm785484ywe.46.2024.01.19.11.08.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 11:08:31 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc2308fe275so1040784276.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:08:30 -0800 (PST)
X-Received: by 2002:a05:6902:1611:b0:dbe:a537:58cd with SMTP id
 bw17-20020a056902161100b00dbea53758cdmr355239ybb.52.1705691310589; Fri, 19
 Jan 2024 11:08:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111192329.449189-1-urezki@gmail.com> <ZaDSmY5oObFqWCfs@infradead.org>
 <ZaD0L7nkFeTwv_g5@pc636>
In-Reply-To: <ZaD0L7nkFeTwv_g5@pc636>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 19 Jan 2024 20:08:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVoweOFJ8_QG-kxTmHKmpPcVQWki+Dc+wDWmBM3hFKfiQ@mail.gmail.com>
Message-ID: <CAMuHMdVoweOFJ8_QG-kxTmHKmpPcVQWki+Dc+wDWmBM3hFKfiQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Fix a warning in the crash_save_vmcoreinfo_init()
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Baoquan He <bhe@redhat.com>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Dave Chinner <david@fromorbit.com>, Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>, 
	kernel test robot <lkp@intel.com>, linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC linux-m68k

On Fri, Jan 12, 2024 at 9:11=E2=80=AFAM Uladzislau Rezki <urezki@gmail.com>=
 wrote:
> > On Thu, Jan 11, 2024 at 08:23:29PM +0100, Uladzislau Rezki (Sony) wrote=
:
> > >  #endif
> > >     VMCOREINFO_SYMBOL(_stext);
> > > -   vmcoreinfo_append_str("NUMBER(VMALLOC_START)=3D0x%lx\n", VMALLOC_=
START);
> > > +   vmcoreinfo_append_str("NUMBER(VMALLOC_START)=3D0x%lx\n", (unsigne=
d long) VMALLOC_START);
> >
> > Well, the right fix is of course to make sure VMALLOC_START has a
> > consistent type, else we need to plaster this crud all over.
> > unsigned long seems like the right type for it, so at least m68k should
> > be fixed to confirm to that by adding a UL postfix to the definition.
> >
> I agree with you. I wanted to focus on fixing that particular place
> because i wanted to avoid other(on this step), possible side effects
> or drawbacks if i went with patching the arch/m68k/* files.
>
> But, in general arch/m68k/* has to be fixed.

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

