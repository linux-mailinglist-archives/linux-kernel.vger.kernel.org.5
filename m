Return-Path: <linux-kernel+bounces-161426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E548C8B4BD6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7381C20F50
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBF26BB37;
	Sun, 28 Apr 2024 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0H2uhuk"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E0CF516;
	Sun, 28 Apr 2024 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714308777; cv=none; b=RsHG+uBd1Hnls1pdE1pkTTeLkWRuYzgdsYsYQaALhZpj9Pqxpet0Yv0UaK3MTzOaY8X+bcHQtyNETyxw3xuEPFJY7VGdBzLMWzmDNCcK8YAHBsPAe/LmO2xFwrkLRwpANYYw0dgOflIkCXYv0JURkGYAg/27gXIz0bLXMOHClC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714308777; c=relaxed/simple;
	bh=e1t+DAm/UcjgWEj5zteVdEHb88i/sXfM9ZVZmE5sY4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XfeG1k0XBTLeUjWRA4acuPb4Z8bIbEam/vFhynFLpma6ed74EQ1e8c61tXTxYxX+qlijc9gTCHFZaFvx4pPXOwezz7rj9t5FzoV47JKj2DbuXrmT69x3HzwT0QorgndVcgdsRJbVyIJyG9uIVG1FDff3QgukvT+Eok4JpYcPELk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0H2uhuk; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34c90082dd7so1204919f8f.1;
        Sun, 28 Apr 2024 05:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714308774; x=1714913574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1t+DAm/UcjgWEj5zteVdEHb88i/sXfM9ZVZmE5sY4A=;
        b=O0H2uhukRGI0Gc0F1o1s9+HHOemAv0we5GkI5rxizleTwTRJuVVHA1j2ang2gNHTX9
         WDpzJEvp3ybnCgH9jKbx4a63sjxSlTfEpX866IThhcEm//vwp/HaDbLV5LyEul7kaVYP
         PerJRdpcsE/VSTkYL6qpzDos7SfOcO6vvjag5gWiEEx5xTOIE+Q1B6NVVcMHht/twobI
         9dsn1CJ5i+Z0t/xPgytv2qR3K7/NzTBBep9EtUSYt54yoVFIE2mGey3cEnZQM2YJ8l/V
         vsAjJNhfSAxJR5IXDWrRzm2m/qHIi7xZ1BlUfGHVJloeidUqF7krh6oaIhFFvr5oSUpm
         SDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714308774; x=1714913574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1t+DAm/UcjgWEj5zteVdEHb88i/sXfM9ZVZmE5sY4A=;
        b=iyaIjMdxKG4OirW1we8x9NFsswbWtyGpvxa7xsGuGgW+Lkxlad9/T4mzLsVEV9DXso
         Pn1DrnaNP7He4+eR5oNiyVz6kxWjKlDy8PB05i0uu+U1MO1lwU4Kjllffe65lVlkEuKQ
         aJklNtZUV8VMPV82d+gZKnVH3voFzzqZk1qzlsgOZFg2AbzX4lCJ03m938dXLe9APdH8
         L6ujbOpHCKa4Lb9tmdT6XuqLtJKtz1grvC3vPPwozflP2bO558c0PQnNd6nOWfnpQAUq
         QSQSJVn7yrEBwux8l+PrzZCdBOKQ61xBtVGAMdWjOndaQwdsXTjJUMlTeyKavDNAZwP6
         2q1g==
X-Forwarded-Encrypted: i=1; AJvYcCXK47kBW9Xlni2/Tdq25pt5VDHrwZRZ2WJzrRjUjCzvOEhwzSXUuyZmrhlTwQIek8aD6Sa5tit0VNG6JtFUfkGgttOa5RqRjGsj/dDkH9gzD33JxPfs1o/5f7oG+4xh+OLBDdoshUujoA==
X-Gm-Message-State: AOJu0YzDLumOhBWf1uChi4TUf9CX/5GQC7LOsDnPEchnC7cr0H2t6pKd
	4gethWsn/Bc0SDsuBlMGVGO/AfeNxI8gZZWeev2TWDZVNwkNIH9OAIAvh6DVhh9d0T8TifZXbnE
	n8MXd/nhx4utnB70fxuKWPtBBxiiq93DoYMU=
X-Google-Smtp-Source: AGHT+IFk4s2m4By0fwDK8jV6cj9RlLs4N1Ac1W9zBcBWrStk7pz9SjLguNE0AHswsQkf8U1r+OrAzsbOP41G9LsIR6c=
X-Received: by 2002:adf:f8d0:0:b0:346:4d41:8d5a with SMTP id
 f16-20020adff8d0000000b003464d418d5amr5892887wrq.56.1714308773903; Sun, 28
 Apr 2024 05:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416120635.361838-2-skseofh@gmail.com> <Zh9l_LpThq9aFUR7@kernel.org>
 <CAATEi5kywwC2yUaYjgs+Gm=4HM5o=KHTqH1ALKJijWE_gge0=g@mail.gmail.com>
 <ZiFgYWydIwvnpIIY@kernel.org> <CAATEi5kFt8iUeWSkrj_bVTyPO_tfQzG77D719P5dLsr2j6Zkzw@mail.gmail.com>
 <CAATEi5ksY-v7-LEqNZWFV5hsHiegNEtrh4LpMWOQ=vT7hC0Rng@mail.gmail.com>
 <Ziy8AsAGZyKCyXX_@kernel.org> <CAATEi5=Z0qirM-fyGJL_UPcr7-iyCFtOW9d3XsdN50Tkhpm0iA@mail.gmail.com>
 <Zi3twYLGvhtJa9Yh@kernel.org> <CAATEi5nOQE7xi5ztV0BFO6MRqSGwUPT4V9dqpMT+p4r7iZQwRQ@mail.gmail.com>
 <Zi46Wri1mPTiEArU@kernel.org>
In-Reply-To: <Zi46Wri1mPTiEArU@kernel.org>
From: DaeRo Lee <skseofh@gmail.com>
Date: Sun, 28 Apr 2024 21:52:42 +0900
Message-ID: <CAATEi5=-oxOGqGD=xL=tjYRh5Q_xk5qLsXcTXq+4LRyOT8J6Rg@mail.gmail.com>
Subject: Re: [PATCH v2] memblock: add no-map alloc functions
To: Mike Rapoport <rppt@kernel.org>
Cc: robh@kernel.org, saravanak@google.com, akpm@linux-foundation.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Daero Lee <daero_le.lee@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 4=EC=9B=94 28=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 9:01, M=
ike Rapoport <rppt@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sun, Apr 28, 2024 at 07:36:40PM +0900, DaeRo Lee wrote:
> > 2024=EB=85=84 4=EC=9B=94 28=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 3:3=
5, Mike Rapoport <rppt@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > >
> > > On Sat, Apr 27, 2024 at 07:24:23PM +0900, DaeRo Lee wrote:
> > > > 2024=EB=85=84 4=EC=9B=94 27=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84=
 5:50, Mike Rapoport <rppt@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
> > > > > > >
> > > > > > > So, here is what I think:
> > > > > > > - reserved-memory w/ nomap region -> mark only to memblock.me=
mory
> > > > > > > - reserved-memory w/o nomap region -> add to the memblock.res=
erved
> > > > >
> > > > > NOMAP and memblock.reserved are semantically different, and at ma=
kes sense
> > > > > to have a "reserved nomap" node in fdt recorded in both memblock.=
memory and
> > > > > memblock.reserved.
> > > > >
> > > > > memblock.reserved represents the memory that is used by firmware =
or early
> > > > > kernel allocation, so reserved memory in fdt should be reserved i=
n memblock
> > > > > as well. I believe it's an oversight that early_init_dt_reserve_m=
emory()
> > > > > does not call memblock_reserve() for nomap memory.
> > > > >
> > > > > NOMAP is a property of a memory region that says that that region=
 should
> > > > > not be mapped in the linear map, it's not necessarily in use.
> > > >
> > > > I agree that the NOMAP region should be added to memblock.reserved.
> > > >
> > > > So, I think we need to clean-up memmap_init_reserved_pages, because=
 in
> > > > this function we call reserve_bootmem_region for memblock.reserved =
and
> > > > memblock.memory with nomap. We don't need to call
> > > > reserve_bootmem_region for nomap.
> > >
> > > Read the comment about memblock_mark_nomap()
> > I read the comment about memblock_mark_nomap() and understood that
> > regions with nomap flags should be treated as PageReserved.
> > But, if we add this nomap region to memblock.reserved, the region with
> > nomap flag will be processed in the first for-loop in
> > memmap_init_reserved_pages.
>
> memblock still must make sure that pages in nomap regions get PG_Reserved
> to be robust against potential errors and bugs in firmware parsing.
Got it.
Thank you for your comments. I'll make another patch for just clean-up
early_init_dt_reserve_memory()

Thank you.

Regards,
DaeRo Lee

