Return-Path: <linux-kernel+bounces-99690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EFD878BCE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7A61F2160B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83F26FBF;
	Tue, 12 Mar 2024 00:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="UKT0mLkE"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2E7567F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 00:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710202135; cv=none; b=awSP8E23jpD4B9/6yPGgj821lKi+EVPAX7n/E2ND7Dq9nogEVSdQ9bBHCe+g575cB6xEg3uNW9z1zYxOrKPn9/8ZYcuGZU5Nm/EWywUN53efMmVYAFGjTa4uQJ+tq98cFo5PiAEFqL1lON92Jy1cSJhKW2p4BPeZ4Jc/5u39WAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710202135; c=relaxed/simple;
	bh=/C3VJItrs0o7vvnGQLjOLjLnoEcD/Axem3JkzmQPo9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZacoTyxYNHreIU0LfDGoOFSf0kszmqnJ/lWT5gQX/stJDPDyvKJ8AuSp1L/TIRrRSqQ2MjuCTFLwatWLKFMM/I+kwK14isx9TasfRv0JUvzpfpF2gpct3oV1CUWw5gznouFdzOWhSjfYiMH+Ui0xLOp4B9jFqXuPJgRZt6BCLvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=UKT0mLkE; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42efa84f7b5so44427751cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710202133; x=1710806933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnBY48HsUFUFKc13ajCqh9BG/16i5QkSsCcX73NoIzo=;
        b=UKT0mLkEhs8Bl01vvKWBI4JcwoV6DBnn6sZVLVpAYIly8OOkuiFM/ufSmx0dzU2L9a
         BWtwinfL3vactbjXu+mhIzDJU9JCBuRRVyJAiIlKwz6IYbLM0sCxxp/xRxmgpR5S1lqr
         tGyiPbEHT+MBP98KJXy9qpqZtxdWeMRir5eqB9ViyFiytT+qWzWbfx/m6+aZzn2hpDQt
         k+B54zMCj0VUyHkQVKKtohvQx7G8oMeycdBM0Kt6XxYbo5PqAspHmgM8mQIa8KWPwbs0
         Th+pnmFHYtH56cXYOWhEkXfzpM5onMrAJ/8V0ci+nWDXJg3t3aFRtIVu8eU980R9SLKh
         8sFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710202133; x=1710806933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnBY48HsUFUFKc13ajCqh9BG/16i5QkSsCcX73NoIzo=;
        b=boTLTV8Ii8JGM5R4WrN5quuBQ6aKLdHt9CVoHsD2WOzkM/AIpdOOB2bFe2vSdZKmNX
         bEWEM/BnOZWpTWTodN7tBRge32WT+RwkwPpVSm73p2pzdLe717IE0+majt7ENFrOHSR+
         k0/kf2AInoHuSivmuuksYopdd+uMZ76vCq5PtZFwpmZbKNAGkqdCDu7O1wW0Jnas2DaM
         daFwZ7cYONuOGumEXz2fS3gTG5aG7p3XGzyfjhm2J3fRSTAR+ixRF/B/jMm6hh+JNI7/
         m0imaKpObhtHBatoks08jCX9k/ftEGZFZqbmRUlQto1DSVQX3z0UfT1ofT+FLJKyrvYV
         lJrA==
X-Gm-Message-State: AOJu0YyReb6f/VQ9rUGWzlIh0BD/tozStDEyRcmtuDFUHVqV9rc0iHoU
	hkk33YK1HhlFrHjV0hIra5SxGdwH85/bxu6IG8hbpZpA4FLCFkr0LWjJhqPFqxqMdsNNIjtxf5n
	dxYLstrONqFuJWyaj74pmEl9/VzVmDt/G4yfYsQ==
X-Google-Smtp-Source: AGHT+IFclJ3u+ZdSsmwur/E7OHzlyZd0+Q+MXWI4kYlZH3wpOUFOLSiwEmYSM3EPMVo3LpV3zVQHzIbAtD83uPkQQSo=
X-Received: by 2002:ac8:5f13:0:b0:42e:db75:3cf9 with SMTP id
 x19-20020ac85f13000000b0042edb753cf9mr14493400qta.27.1710202133152; Mon, 11
 Mar 2024 17:08:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-12-pasha.tatashin@soleen.com> <3e180c07-53db-4acb-a75c-1a33447d81af@app.fastmail.com>
 <CA+CK2bA22AP2jrbHjdN8nYFbYX2xJXQt+=4G3Rjw_Lyn5NOyKA@mail.gmail.com> <1ac305b1-d28f-44f6-88e5-c85d9062f9e8@app.fastmail.com>
In-Reply-To: <1ac305b1-d28f-44f6-88e5-c85d9062f9e8@app.fastmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 11 Mar 2024 20:08:16 -0400
Message-ID: <CA+CK2bBU2zwu_V6hpOonswyuft5gWQh1H9tBbYP8efLRRAAdQQ@mail.gmail.com>
Subject: Re: [RFC 11/14] x86: add support for Dynamic Kernel Stacks
To: Andy Lutomirski <luto@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Christian Brauner <brauner@kernel.org>, bristot@redhat.com, 
	Ben Segall <bsegall@google.com>, Dave Hansen <dave.hansen@linux.intel.com>, dianders@chromium.org, 
	dietmar.eggemann@arm.com, eric.devolder@oracle.com, hca@linux.ibm.com, 
	"hch@infradead.org" <hch@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, jpoimboe@kernel.org, 
	Joerg Roedel <jroedel@suse.de>, juri.lelli@redhat.com, 
	Kent Overstreet <kent.overstreet@linux.dev>, kinseyho@google.com, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, lstoakes@gmail.com, mgorman@suse.de, 
	mic@digikod.net, michael.christie@oracle.com, Ingo Molnar <mingo@redhat.com>, 
	mjguzik@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Uladzislau Rezki <urezki@gmail.com>, vincent.guittot@linaro.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> >> There are some other options: you could pre-map
> >
> > Pre-mapping would be expensive. It would mean pre-mapping the dynamic
> > pages for every scheduled thread, and we'd still need to check the
> > access bit every time a thread leaves the CPU.
>
> That's a write to four consecutive words in memory, with no locking requi=
red.

You convinced me, this might not be that bad. At the thread creation
time we will save the locations of the unmapped thread PTE's, and set
them on every schedule. There is a slight increase in scheduling cost,
but perhaps it is not as bad as I initially thought. This approach,
however, makes this dynamic stac feature much safer, and can be easily
extended to all arches that support access/dirty bit tracking.

>
> > Dynamic thread faults
> > should be considered rare events and thus shouldn't significantly
> > affect the performance of normal context switch operations. With 8K
> > stacks, we might encounter only 0.00001% of stacks requiring an extra
> > page, and even fewer needing 16K.
>
> Well yes, but if you crash 0.0001% of the time due to the microcode not l=
iking you, you lose. :)
>
> >
> >> Also, I think the whole memory allocation concept in this whole series=
 is a bit odd.  Fundamentally, we *can't* block on these stack faults -- we=
 may be in a context where blocking will deadlock.  We may be in the page a=
llocator.  Panicing due to kernel stack allocation  would be very unpleasan=
t.
> >
> > We never block during handling stack faults. There's a per-CPU page
> > pool, guaranteeing availability for the faulting thread. The thread
> > simply takes pages from this per-CPU data structure and refills the
> > pool when leaving the CPU. The faulting routine is efficient,
> > requiring a fixed number of loads without any locks, stalling, or even
> > cmpxchg operations.
>
> You can't block when scheduling, either.  What if you can't refill the po=
ol?

Why can't we (I am not a scheduler guy)? IRQ's are not yet disabled,
what prevents us from blocking while the old process has not yet been
removed from the CPU?

