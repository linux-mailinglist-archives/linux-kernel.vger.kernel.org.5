Return-Path: <linux-kernel+bounces-106306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C0787EC33
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A25E9B21682
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2412D4F214;
	Mon, 18 Mar 2024 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="R5MNsB4F"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABB64F1FC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775881; cv=none; b=Mc4vzxeRpgVyyESAPnWmrw0WuPJveDG8w5MIep7Fv3jDNR5qVlp7NT4lJIA4pe3pKfYPzbe1TnZnh+FKU40UL5PXip27aGBUoAh+y1ck1Y0Gv7JRdjbYaYbEoPKzLDWFqh0whOqz+QtfHKsdDOOqLA0NgkQxof39eNJ26VT2TWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775881; c=relaxed/simple;
	bh=T0Ne9yMNYLZi4uTj1Xuo2ZKrcAbKFkp6jK9oc5YUMpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yksl9Y6NltyPf3ATJuZFPCA96ys8jcnNo8IMhSfqFAprh+Xp72Mg8IrBlWwK8oaxIsB1aYyjcxCBqxvQx+SNtrCkcbdDmL9UNx3h46DNpgNVq+CqCOKLoguQ+9wZ+CWpl1NA4JpvByIdBw7W9334e45QQ2dFYzhwOsbPEHy1uGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=R5MNsB4F; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42e29149883so18685591cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 08:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710775879; x=1711380679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnbQuLUwlY/yZQSEJ6UKuPd4bJoloGALr8ZQRUHT1Jc=;
        b=R5MNsB4Fifqd1eCnameang+os7as9bXZ3nIlwxLPkyGC8kLuK4v5leY8JmAjmMHrQW
         r2Tfx0c7S2Zrb2Dl9sn98NyWCS1OnBAiLIsCcNxKTCUpLPAOTT0U9GQpoFfcQcrHcWcn
         qCNhjHvIiBO0YdnCfaLTxHx7kVD3CDZx6wBZ9B9JSKQpgxnBet2SQP7teK4Pr8XfGQoi
         BWsSw+ArhyyAf3mn3+NIan2VayH17DjJJg4PjLcWUa0eJnH1jfUU9GHPfpmh3Ci5InTT
         CdutYP8X1uEjPLZven4iwIJbD60GspzOzFY6prMEt7B4muvF52r8zbcMSYXqy0AeYUS2
         5K1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710775879; x=1711380679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnbQuLUwlY/yZQSEJ6UKuPd4bJoloGALr8ZQRUHT1Jc=;
        b=N5AX1iUyIBDVH0vCqH+UR3u9NqY017BICP9cd5eiDeTAvs5LGvYD9SPywQfWM6g+Ym
         IqdDgOf0T7HdBbmkdct5scrkwF/c621tzvQdW19ScxJ7kznnNtqS9n2YO0h1ZlOyNmyl
         N0dmLJu+OTJJvDNpdsT889Vyik+a4GmJH5NGKmXQL4oi5QEPDBc3vdjmGv7WpfvXN5Vg
         LeAL2vh3Tj1llI+YYdo7Wxsq0pGqmfKnPGLWaTKoIBAdeDn6Y6H5rfbG/I6Ge7FYxpE8
         nGpPBHw5aCW3d6mtxwzUcUXA61hkJZKGaxTjJCzS5J71M4goruJzmn8DgmwZ4FzLBbKL
         RMyw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ1M6NcwH8pLdvo5ulNw9peeIa45KVoliwJvQD9ZWC0Xxhckr9phLedRte87yUpeLfDSsluVNv65cd9bAfQbq2/uh65/fpy9hB5MIg
X-Gm-Message-State: AOJu0Yzpn/8s1A+pXTeuMpLv3EwAIsXZ6jglJaIpxzBxKax+J5ddIDFV
	hHUwmKNgBLqQLR2OKQhXW/dc7xh81UhkjU+JkZYv/BSZZqvyuab8TgNbSZab129dvUJtlMo9wgz
	RrzD/8Fg16cEABb8fycAAc+eGsfzwsBBFS6sLgQ==
X-Google-Smtp-Source: AGHT+IEHJI3BKnTNZ4pHvdvXvf6ScyD+ygtuclFrnt6J3mDPUAzP6GAAk2aJt67Hogo1BqGPjrMe4sHxSLrZLo1EbcE=
X-Received: by 2002:ac8:5d8c:0:b0:42e:f950:d225 with SMTP id
 d12-20020ac85d8c000000b0042ef950d225mr18462982qtx.1.1710775878637; Mon, 18
 Mar 2024 08:31:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com> <ZfNTSjfE_w50Otnz@casper.infradead.org>
 <2qp4uegb4kqkryihqyo6v3fzoc2nysuhltc535kxnh6ozpo5ni@isilzw7nth42>
 <ZfNWojLB7qjjB0Zw@casper.infradead.org> <CA+CK2bAmOj2J10szVijNikexFZ1gmA913vvxnqW4DJKWQikwqQ@mail.gmail.com>
 <39F17EC4-7844-4111-BF7D-FFC97B05D9FA@zytor.com> <CA+CK2bDothmwdJ86K1LiKWDKdWdYDjg5WCwdbapL9c3Y_Sf+kg@mail.gmail.com>
 <bb203717ab644362a8eafe78aff23947@AcuMS.aculab.com> <CA+CK2bAuNLXq4p8pjwAatuw2KuadhKjD6JRwJN8ZvSEd1d7ntA@mail.gmail.com>
 <Zfhblk609XJn5clL@casper.infradead.org>
In-Reply-To: <Zfhblk609XJn5clL@casper.infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 18 Mar 2024 11:30:42 -0400
Message-ID: <CA+CK2bDFUekHnh=XqLcLJS-VgTMrTRWPm4xgmXHWgFCd9JXYmw@mail.gmail.com>
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
To: Matthew Wilcox <willy@infradead.org>
Cc: David Laight <David.Laight@aculab.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "x86@kernel.org" <x86@kernel.org>, 
	"bp@alien8.de" <bp@alien8.de>, "brauner@kernel.org" <brauner@kernel.org>, 
	"bristot@redhat.com" <bristot@redhat.com>, "bsegall@google.com" <bsegall@google.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"dianders@chromium.org" <dianders@chromium.org>, 
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, 
	"eric.devolder@oracle.com" <eric.devolder@oracle.com>, "hca@linux.ibm.com" <hca@linux.ibm.com>, 
	"hch@infradead.org" <hch@infradead.org>, 
	"jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "jroedel@suse.de" <jroedel@suse.de>, 
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, "kinseyho@google.com" <kinseyho@google.com>, 
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "lstoakes@gmail.com" <lstoakes@gmail.com>, 
	"luto@kernel.org" <luto@kernel.org>, "mgorman@suse.de" <mgorman@suse.de>, "mic@digikod.net" <mic@digikod.net>, 
	"michael.christie@oracle.com" <michael.christie@oracle.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"mjguzik@gmail.com" <mjguzik@gmail.com>, "mst@redhat.com" <mst@redhat.com>, 
	"npiggin@gmail.com" <npiggin@gmail.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"pmladek@suse.com" <pmladek@suse.com>, 
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"surenb@google.com" <surenb@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"urezki@gmail.com" <urezki@gmail.com>, 
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "vschneid@redhat.com" <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 11:19=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Mon, Mar 18, 2024 at 11:09:47AM -0400, Pasha Tatashin wrote:
> > The TLB load is going to be exactly the same as today, we already use
> > small pages for VMA mapped stacks. We won't need to have extra
> > flushing either, the mappings are in the kernel space, and once pages
> > are removed from the page table, no one is going to access that VA
> > space until that thread enters the kernel again. We will need to
> > invalidate the VA range only when the pages are mapped, and only on
> > the local cpu.
>
> No; we can pass pointers to our kernel stack to other threads.  The
> obvious one is a mutex; we put a mutex_waiter on our own stack and
> add its list_head to the mutex's waiter list.  I'm sure you can
> think of many other places we do this (eg wait queues, poll(), select(),
> etc).

Hm, it means that stack is sleeping in the kernel space, and has its
stack pages mapped and invalidated on the local CPU, but access from
the remote CPU to that stack pages would be problematic.

I think we still won't need IPI, but VA-range invalidation is actually
needed on unmaps, and should happen during context switch so every
time we go off-cpu. Therefore, what Brian/Andy have suggested makes
more sense instead of kernel/enter/exit paths.

Pasha

