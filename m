Return-Path: <linux-kernel+bounces-46982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F00D84476C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3312B256FE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B414BCA7F;
	Wed, 31 Jan 2024 18:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGG2C0fY"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86A7210FE
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706726823; cv=none; b=sl23G7caDpAOJOmpH4VOUNj8GsSrbTK5+Jxrlitx379SVcnwXoNMxMjWnz9Xk1sAObEFyMW5mpUpxRh8L3YmpxHzQpLmmTu2nLxzTKiM/VB+xIxvFGjuk48G94VTV+G8XbpjaZDAnlY4+Bt7c2CkJb7qMOwXWopzK218iR3bEEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706726823; c=relaxed/simple;
	bh=dVSKYLu85fk24kHXvSBQbP4SomzQfCwwVPmuegQ5S8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLGaQ0mu/wMUm2LD6mNEK7kYKROr+S23r9z2uTLCRwQpNeQKNlyDDK4za7+Mz7HSTHT9hyofDTCspSU/kWolbwOcol5Sd1aHujKtmSmzGVxLDVcTt/vGII/rNAh6AWQYipJ99jsaKk6GNAm6fl4YT6hwfTjwKIw9OP2Nq2Hbnh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGG2C0fY; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6df60be4a1dso24322b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706726821; x=1707331621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Up3uofbpHbcgfF19VzZ1HsIvzv/qL2Mf7ez3FTnsd3E=;
        b=gGG2C0fYQ9VW6Njo7FKQLCFcv/+MNpUlZhpCaFeEEZsftbjpofGfjpRQ3VlHcPWArf
         l5eLcUedPLnZ6fHZrPMEUxTr93eHuEX10zue1DCnPP2nDmkDw9KEvUGfzdkcqWGxR2jB
         6aYfms2pjgoP4mqJaTOb+hD+Wa+uMYs9ymcR3e7/oQk3r8Vf/KE7e4QDYzvrQdJbUKwc
         5OzlJUXTViKzvIruScZkOMrZOoK+k8P8A6RAvl/PeO0gEpTz0tPXCAFW7jP7RzV3c1eD
         rPUq9NhIGUmqoAAY6sgSflQo2atfpAhNC4Yty710X2OTvldyNN4uV+iupxd4wMCJVjhJ
         pwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706726821; x=1707331621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Up3uofbpHbcgfF19VzZ1HsIvzv/qL2Mf7ez3FTnsd3E=;
        b=Df1LVGqTU+lAoyx75cleYiV1Rr+NYdSiW6LwpA+jgeXKrDZhCZb6kX5eAKcW4EXVIQ
         gAyBEmjeuWlOsX6Qq9RwWcUJdnpn6wHPVbumWEuhCbKRLQfAKWKS+5QgqeofLj45Df3M
         NRBgV6oLMUEXj7dU+d6QH2DTR7wg9IGnfSYK6YTGOc0AefLA7hHtbEl/wfXAexkQ6Wk9
         mjsUUErPyX+8/jj5P44XB6ptpY8CAMx0ljDnN8WPzeQmOKu5MnMyfpxNbgwH7PR+ZG//
         eNcigKHuUYnkohpyQobBEj62POke9ZM+xgGlHZqtnCr0yVlLKpH948XcjNBjSQJyejyS
         pifQ==
X-Gm-Message-State: AOJu0YxCDcjJdCB3MNTP0a/siKOsyvDjKX6El9AkTU22P2YIVtngMich
	nrLlJZZlVuo96MUxBGOvcXZ5XHSgb29Vfu6Vfx/iK2VZWdOsYIrEIzdBNj66VTY0rKzgu8Csyko
	Dr/4G/9WS3VsRm72U/PjjZmGQ+WM=
X-Google-Smtp-Source: AGHT+IFvdMrLLs2jfzcjF2taIMDHL9UNC5E6++Ziyq/77dlIzpAy7+xkg+/jO/FfZjN2sSsEbkktYP3+0JF85l4oQFA=
X-Received: by 2002:a05:6a00:23d6:b0:6db:b355:892d with SMTP id
 g22-20020a056a0023d600b006dbb355892dmr3120222pfc.2.1706726820943; Wed, 31 Jan
 2024 10:47:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221065943.2803551-1-shy828301@gmail.com> <20231221065943.2803551-2-shy828301@gmail.com>
 <878r46ym4b.fsf@oldenburg.str.redhat.com>
In-Reply-To: <878r46ym4b.fsf@oldenburg.str.redhat.com>
From: Yang Shi <shy828301@gmail.com>
Date: Wed, 31 Jan 2024 10:46:48 -0800
Message-ID: <CAHbLzkq1ah6y-dCgA0rFePNn3FsE8ebuSNd+jaS8sO51a=X9Yw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: mmap: map MAP_STACK to VM_NOHUGEPAGE
To: Florian Weimer <fweimer@redhat.com>
Cc: oliver.sang@intel.com, riel@surriel.com, fengwei.yin@intel.com, 
	willy@infradead.org, cl@linux.com, ying.huang@intel.com, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 11:53=E2=80=AFPM Florian Weimer <fweimer@redhat.com=
> wrote:
>
> * Yang Shi:
>
> > From: Yang Shi <yang@os.amperecomputing.com>
> >
> > The commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
> > boundaries") incured regression for stress-ng pthread benchmark [1].
> > It is because THP get allocated to pthread's stack area much more possi=
ble
> > than before.  Pthread's stack area is allocated by mmap without VM_GROW=
SDOWN
> > or VM_GROWSUP flag, so kernel can't tell whether it is a stack area or =
not.
> >
> > The MAP_STACK flag is used to mark the stack area, but it is a no-op on
> > Linux.  Mapping MAP_STACK to VM_NOHUGEPAGE to prevent from allocating
> > THP for such stack area.
>
> Doesn't this introduce a regression in the other direction, where
> workloads expect to use a hugepage TLB entry for the stack?

Maybe, it is theoretically possible. But AFAICT, the real life
workloads performance usually gets hurt if THP is used for stack.
Willy has an example:

https://lore.kernel.org/linux-mm/ZYPDwCcAjX+r+g6s@casper.infradead.org/#t

And avoiding THP on stack is not new, VM_GROWSDOWN | VM_GROWSUP areas
have been applied before, this patch just extends this to MAP_STACK.

>
> It's seems an odd approach to fixing the stress-ng regression.  Isn't it
> very much coding to the benchmark?
>
> Thanks,
> Florian
>

