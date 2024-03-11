Return-Path: <linux-kernel+bounces-99289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096B887860A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040491C2119A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E8C4DA1A;
	Mon, 11 Mar 2024 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k57XC0Zv"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B984879E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710176952; cv=none; b=igbXL13GQBdR9QvBw3yVxozGoWW0UV26lMdOmbd79HFyJuKDHjPWjTIL2yE9YI4ENEDvAJ6RyNsEW2U+QGW1JCOC7vtafteeGmxt6E16+pc7Qu6WjcwpKbY6yoL1sqUpj4V9JBNwUkIb0VrMNqYjYMKC3Y6SNeXnMNbZS6M3YUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710176952; c=relaxed/simple;
	bh=KWEdPMNMKrcZiiaH9ykrXvu505pv5vfImkvwzahhefU=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IsKGnqCc+byjmuFfkl0rfCFrgmTNi3JWi9jPAGdGvnvelV9QwxuTIydEcrhquvgcwFGVqjcJ+rxMrEc0r0tdBbQBPDvHFfSQ/SQ5pM+c9gcpv0mT+4r8B3w3G7JulZalpUTS3JbYGC/Fq+XqhKhGyOnuI7WQH/t4rw0xIwtye1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k57XC0Zv; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a44cdb2d3a6so647657566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710176949; x=1710781749; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gcxaYy4HdUQtSCgmVUifcbC4d1XVexgxS1H8yyjyPBk=;
        b=k57XC0ZvB+fYmXOfPoMWL6FdvoOOWr2tt43ST7oXElPkMEez9hZtKnKwNqItKWyI+6
         vbMrrT07iHuGp1enBrGQ8zIq7Uifqs0tQPjssoeSX9JrgRW53jYBCQPv+EZBdPYfRskA
         WXtnRQx0koE17LmnZMnGUcbNl9p6sPibE9N4jYLIAAPhGvIo7qGmraVnRC/DoLx0tJEa
         l7/mPheuScgkWTPRz5rPlINXSOCc0MaH7FKNTou1ds3Rw2cEiSDKpRSKtioW+3ocAXQy
         XczN6aWPCTSH/n7O57xwhfwFggLav6Gd6hV682Z2sxP+GLkrs40Mp78c7IMTX1vvm/sT
         3UMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710176949; x=1710781749;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gcxaYy4HdUQtSCgmVUifcbC4d1XVexgxS1H8yyjyPBk=;
        b=rC8AKUXaIcEN0+dUFmGpoLnGqLZuWpMhOL94VGoLgVszSu/gWDf93jIRCMKCcC3dVF
         aNQu4Bw5y3TTquBN+ucrZiE7/F0KLC6AZzdI6Ao272viAON2fp7LIaXAT8ANv5/BXpQ4
         BzWQtqTgro9eRCtGDnbwRnh4402PIFKVnPNoymdEdxrWmGZJFojDBFTWlYlJIzJ2Z6RE
         BDBKeEeUnU/6SHBSRYfvRrGLUOh4cTa+0iRKPz9fwRgwXohCQRR7codMqVyMtLHKxB9v
         1d44HQ6tFDCjp8/suVXwdUbxQVTtb+PTpVeyVhYCZIpmCqOUR74bUkRyRDc+J8txKI5y
         xAxg==
X-Gm-Message-State: AOJu0YxV+ncE4kxaWZauzYtv134BqU4NnzQnEUGpy3zsWTCa9Ubyvzrq
	4v81kIaGZQ2ux9OlXJMlc9z4CZOHUzGg5SD5fFwakuMVrIbzYlJflopwrlFPepmzu28l1r++qr8
	JlMC7EUQdQpVHmIHslQd0QpeNOr4=
X-Google-Smtp-Source: AGHT+IHE2dEZK2oineSipFKnyOWGd3+fSAGb0nn5YD8UZEwcnKjbTYFTKyCU3SwNXJqBqRRQ8AHxFGJnllfxQxj+Blo=
X-Received: by 2002:a17:906:1849:b0:a45:f5e1:1050 with SMTP id
 w9-20020a170906184900b00a45f5e11050mr703781eje.18.1710176949030; Mon, 11 Mar
 2024 10:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a05:6f02:f0d:b0:65:b649:35ec with HTTP; Mon, 11 Mar 2024
 10:09:07 -0700 (PDT)
In-Reply-To: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 11 Mar 2024 18:09:07 +0100
Message-ID: <CAGudoHERLX=X1r0q7yHM22O9udsR=6M+geix7TR3f8ZzHkb-hQ@mail.gmail.com>
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de, brauner@kernel.org, 
	bristot@redhat.com, bsegall@google.com, dave.hansen@linux.intel.com, 
	dianders@chromium.org, dietmar.eggemann@arm.com, eric.devolder@oracle.com, 
	hca@linux.ibm.com, hch@infradead.org, hpa@zytor.com, 
	jacob.jun.pan@linux.intel.com, jgg@ziepe.ca, jpoimboe@kernel.org, 
	jroedel@suse.de, juri.lelli@redhat.com, kent.overstreet@linux.dev, 
	kinseyho@google.com, kirill.shutemov@linux.intel.com, lstoakes@gmail.com, 
	luto@kernel.org, mgorman@suse.de, mic@digikod.net, 
	michael.christie@oracle.com, mingo@redhat.com, mst@redhat.com, 
	npiggin@gmail.com, peterz@infradead.org, pmladek@suse.com, 
	rick.p.edgecombe@intel.com, rostedt@goodmis.org, surenb@google.com, 
	tglx@linutronix.de, urezki@gmail.com, vincent.guittot@linaro.org, 
	vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

On 3/11/24, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> This is follow-up to the LSF/MM proposal [1]. Please provide your
> thoughts and comments about dynamic kernel stacks feature. This is a WIP
> has not been tested beside booting on some machines, and running LKDTM
> thread exhaust tests. The series also lacks selftests, and
> documentations.
>
> This feature allows to grow kernel stack dynamically, from 4KiB and up
> to the THREAD_SIZE. The intend is to save memory on fleet machines. From
> the initial experiments it shows to save on average 70-75% of the kernel
> stack memory.
>

Can you please elaborate how this works? I have trouble figuring it
out from cursory reading of the patchset and commit messages, that
aside I would argue this should have been explained in the cover
letter.

For example, say a thread takes a bunch of random locks (most notably
spinlocks) and/or disables preemption, then pushes some stuff onto the
stack which now faults. That is to say the fault can happen in rather
arbitrary context.

If any of the conditions described below are prevented in the first
place it really needs to be described how.

That said, from top of my head:
1. what about faults when the thread holds a bunch of arbitrary locks
or has preemption disabled? is the allocation lockless?
2. what happens if there is no memory from which to map extra pages in
the first place? you may be in position where you can't go off cpu

-- 
Mateusz Guzik <mjguzik gmail.com>

