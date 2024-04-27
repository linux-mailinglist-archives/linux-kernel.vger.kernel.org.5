Return-Path: <linux-kernel+bounces-160991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63538B4587
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 12:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64FF91F21FD2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 10:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D4D481D3;
	Sat, 27 Apr 2024 10:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDFe72rW"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFDC44C8B;
	Sat, 27 Apr 2024 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714213479; cv=none; b=DX6z/zxDBLUyoki9+DAtEmXlPfDxhR+FdimH/jWfHXaIB2ibPQQQF7KXcO+CFpu9ACdShobMlAIkBCt4ArLF8CWgkn4AAvDUaYeKXKxMB9xjC9sD5oC4exeQpFgXasMnnlDUyxjTNNm0mQf6fKgVrst7Qakh+9jqRepoytWcS9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714213479; c=relaxed/simple;
	bh=l2oCs009FNTFic+6/Bn8POOKtUyuT0t/au2Vi8nWiyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqFlsanCn+ALH/HyVdp6VF/yJhQCI1im7cv5XsTRnQe1dNw3FEwoCgy92RMRJZPNsWEoNnF4R8aMiAlQPM4mQK1fgUezcfmbcJQQNqf1ybp4zDm8TLeyotM65QUV0iLTPgbsUTZ1Spt03kVUTcwfaNKm4I7ua+P6wRWOdNTFpVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDFe72rW; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-349c4505058so2158466f8f.3;
        Sat, 27 Apr 2024 03:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714213476; x=1714818276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2oCs009FNTFic+6/Bn8POOKtUyuT0t/au2Vi8nWiyk=;
        b=EDFe72rWHUOT/z5QCFJznssUdeFLdS6GBnSg3ouPbn7X5YggRAkT5vtsoP4Mch0u2c
         iRPdEEDf20/0SFKYVerR52w5LvkoMtcOjvMOLgtm7gkJUBSawNKuCfbCBOBwo2kjHGv5
         cPRU6BjS55Ki5wOYRjdbwYy8e9m3nN3td2BTvbZ3c0pY1inYIG/CZMz6faEryE3bM+Nw
         DziI8qvs7t6sMYwZcqQEKhdmcJg3NMZ3shUMaNshLoZyZZJt9tAW0D+JpS/CJ6GVWjng
         +8hpVajPc8YFr+j4hl0fDIZUFe5MH7it5FaKY4Ei6hCve/s7z1I8Nzof4M/9FLBRYa7D
         bCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714213476; x=1714818276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2oCs009FNTFic+6/Bn8POOKtUyuT0t/au2Vi8nWiyk=;
        b=pBRuWj/wqhV30NCDcA8lSgy8u4T4mqrb2+DEFvk9BmIAwP6r01YEwluIwZmKo1gnOA
         0kyZD1lfGgjRO5ZbFaWMBNU3/NYOiPB4hWJO1eeSqaUqPH2pIIYyuWps+Z8J5xTjoex+
         wR2J77q5nUhYdf+6KbQfj+G/TMIYAuqZkHi+n5HXeNwzwPIAhhXKBflwvEe1FgYGnQbo
         GExyddLyAj7qrwD1A77/a5ZsQS0naSQEHqOiUoJ1YXLqBkqBqOIOZ8Th7jEvzFMFiqpE
         1FQGcwlAmzi1cnZoJU+O+/IHoO9QGmgMSfTrt7bGSWLGg4B6UMMMRwlDzMjuSVd7VmUt
         +/lA==
X-Forwarded-Encrypted: i=1; AJvYcCUT2f6rP0ybfMeml4V+OKKPcDfEWPAOJ0Bb8KiqONouUpQh8SBG21cRef3WI40zBIquGZvad9UABBfllcFq2ZLsBeUZ6AeAGRNIsnW/0gNV0tgztJ+5waqE+vTj3aN24a9YJutEcQNaWw==
X-Gm-Message-State: AOJu0YwKmisxhNUY+tAzttEJ4nfn6jTtKlDWwKbAoSe2vK+7xcmBJ2Nx
	XehRb+X1pWE8sz9tYWhvmD/TR0qrdjwOMtLJQV6d4fIEkdSm0jgKRemb0ILvGEG+/wF/XaM8Uet
	d76+EPmGW5aUlEacgF/mavyFU0vM=
X-Google-Smtp-Source: AGHT+IEpODtrHOY9y5XiFObx7A01K4CsUREu8unoiWY37KTSNvNOkosI6RMW7bnuRGPZWGVYRcGG1WgD5YuRs0mx3mU=
X-Received: by 2002:a5d:58d8:0:b0:34a:1cc5:ee0c with SMTP id
 o24-20020a5d58d8000000b0034a1cc5ee0cmr312655wrf.26.1714213475436; Sat, 27 Apr
 2024 03:24:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <linux-mm@kvack.org> <20240416120635.361838-1-skseofh@gmail.com>
 <20240416120635.361838-2-skseofh@gmail.com> <Zh9l_LpThq9aFUR7@kernel.org>
 <CAATEi5kywwC2yUaYjgs+Gm=4HM5o=KHTqH1ALKJijWE_gge0=g@mail.gmail.com>
 <ZiFgYWydIwvnpIIY@kernel.org> <CAATEi5kFt8iUeWSkrj_bVTyPO_tfQzG77D719P5dLsr2j6Zkzw@mail.gmail.com>
 <CAATEi5ksY-v7-LEqNZWFV5hsHiegNEtrh4LpMWOQ=vT7hC0Rng@mail.gmail.com> <Ziy8AsAGZyKCyXX_@kernel.org>
In-Reply-To: <Ziy8AsAGZyKCyXX_@kernel.org>
From: DaeRo Lee <skseofh@gmail.com>
Date: Sat, 27 Apr 2024 19:24:23 +0900
Message-ID: <CAATEi5=Z0qirM-fyGJL_UPcr7-iyCFtOW9d3XsdN50Tkhpm0iA@mail.gmail.com>
Subject: Re: [PATCH v2] memblock: add no-map alloc functions
To: Mike Rapoport <rppt@kernel.org>
Cc: robh@kernel.org, saravanak@google.com, akpm@linux-foundation.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Daero Lee <daero_le.lee@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 4=EC=9B=94 27=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84 5:50, M=
ike Rapoport <rppt@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Fri, Apr 19, 2024 at 10:59:52AM +0900, DaeRo Lee wrote:
> > 2024=EB=85=84 4=EC=9B=94 19=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 10:=
46, DaeRo Lee <skseofh@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > >
> > > In memmap_init_reserved_pages, we mark memblock.reserved as
> > > PageReserved first and mark the memblock.reserved with nomap flag
> > > also.
> > Sorry. This is my mistake. 'memblock.memory with nomap flag' is right.
> >
> > > -> Isn't this duplicated work? (If we add no-map region to
> > > memblock.reserved 'and' mark in memblock.memory..)
> > > So, I think that for the no-map region, we don't need to add to the
> > > memblock.reserved.
> > > This is what we do now in early_init_dt_reserve_memory. the nomap
> > > region is not added to the memblock.reserved.
> > >
> > > In early_init_dt_alloc_reserved_memory_arch, if 'nomap' is true, we
> > > mark the memblock.memory region as _NOMAP. And if the return value
> > > 'err' is not zero(which is '-ENOMEM' from memblock_isolate_range), we
> > > free the region.
> > > - 'nomap' is true -> memblock_mark_nomap : success -> not free the re=
gion
> > >
> > > : fail -> free the region
> > > And it can be said that we add the region to the memblock.reserved
> > > using memblock_phys_alloc_range and if the region is nomap, then we
> > > can free the region from memblock.reserved. But is it necessary to ad=
d
> > > it to memblock.reserved? We just need the region in memblock.memory t=
o
> > > mark nomap.
> > >
> > > So, here is what I think:
> > > - reserved-memory w/ nomap region -> mark only to memblock.memory
> > > - reserved-memory w/o nomap region -> add to the memblock.reserved
>
> NOMAP and memblock.reserved are semantically different, and at makes sens=
e
> to have a "reserved nomap" node in fdt recorded in both memblock.memory a=
nd
> memblock.reserved.
>
> memblock.reserved represents the memory that is used by firmware or early
> kernel allocation, so reserved memory in fdt should be reserved in memblo=
ck
> as well. I believe it's an oversight that early_init_dt_reserve_memory()
> does not call memblock_reserve() for nomap memory.
>
> NOMAP is a property of a memory region that says that that region should
> not be mapped in the linear map, it's not necessarily in use.

I agree that the NOMAP region should be added to memblock.reserved.

So, I think we need to clean-up memmap_init_reserved_pages, because in
this function we call reserve_bootmem_region for memblock.reserved and
memblock.memory with nomap. We don't need to call
reserve_bootmem_region for nomap.

Regards,.
DaeRo Lee

