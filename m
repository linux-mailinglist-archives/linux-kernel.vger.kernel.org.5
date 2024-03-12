Return-Path: <linux-kernel+bounces-99696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E670878BE6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E4DAB2147B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716C36FCA;
	Tue, 12 Mar 2024 00:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="dFkrjHfH"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADEF6FB2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 00:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710203059; cv=none; b=YrTy2H7DBS26JEB/Xfo4BYoDskShYc1Us8XH39pBOF/TWqwemRvS2neQ2gMbrmEfgK888x67zFhTP9T6DJKd6A8jgfPBD2cn2esU1hYpVqd9ADkS/GUf/kajlf1a7IAyu7hKRTof4Hia8dVvRKIiCMr7wsLImX7ijap5HPPzSaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710203059; c=relaxed/simple;
	bh=NzL/Vp75xGIC57+O+XJplTrebcORbU60q7vqYjR0nmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jyJd9uu3O9+/QstZVWTkN+gY5MsnXUxD9mMB+IJZIa0BaqX2NYwFt32hvQji7Fa2dhQRq6dQx4x7lCS/CG6PmelAvVfH9zqili3CsZ4vc0NFPbARPEL3vlJvHz8+fg1ubcIg/Wlb6oTBbTmxQllqJgQh+o+Kpn7+2ueQxvwxZl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=dFkrjHfH; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a222daa741so160257eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710203057; x=1710807857; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fJF1VMAJYo3dGSmuMNLfw8I1xaRI9rtMN2Tb6jW3bD4=;
        b=dFkrjHfH8VL/nbl2Asix84+hFxapX8PXmFgkSAJc7KJVoQW4CS9T0sRePS0duWdnSK
         gjZHxBbhqKlzWu3FCNj5jgqZ4YxfRc6mVFXu0kfiioSuieOHKoVW+eFGO0mT8ZPprS5x
         JFgTs785re5g9habRPSexwv218End3p8v7Lb/5C4uV3oCoRwRW2ZaJjfNiNqOaUr4ute
         Sd36VLPvZ2yCNhsH6kImkeRDv9rll+v8XdUq1j7BZsHA5U/0vm0dLwbprDRtBCAGy+W2
         twcT0aeFuPSMlJyWOt7rLMtbMjtpuGMFptk2yjWhoIjjMZZdH8MtTzAMCTj6b09HrHPr
         pzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710203057; x=1710807857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJF1VMAJYo3dGSmuMNLfw8I1xaRI9rtMN2Tb6jW3bD4=;
        b=nGbTIQek0xvsN0L2apfupFMdjPBva0F5AjZ3AWK6byLoox2fU5rzNDLxjNyEy0FgGn
         rnEs2RWme91hAiCxo0KFZgPfyIjboSbB98dGsP8FkxHE+WAHp/RRhPaZFb9vm3M7Jy3i
         Vk8Mu3zJ1PtTxiflH2RnxpeHr+enJ9VKZ7nWwrpLORIA16XtT2foxwMfJmjERGF9QX5o
         EHHyJiqTaVn5NcS8K9AMcKH0+hP4wR4ufv1vLeg8PSvwS+yzDtB5/pVFV9tCxBwSwdQ6
         HSHWI3uy5jnD6O4qCDgLdgLPi+JnwRmdrymjHZ0M8SKCi2/mEvaCjDLRqIw/MuNF7Ubj
         AQrA==
X-Gm-Message-State: AOJu0YyNev8yUR1vACe7DqIjEw9Mi55n17GKdnDbTASacHzjJTYywu8J
	sA9hyrCavrgo544P/GSQtDOYHJdKnMEJ4lZRgvQtSqwi2rLdRsUUz94395CZ4/UncjMFYN6QyUB
	QAhMBjT8xIYO7xFgcQIIaUvmB02aaTe8NhiltPg==
X-Google-Smtp-Source: AGHT+IFrm73EIFt81h8eeLJnq4vZGqWLMUu3RvIuPYR4AQo72uaE8L0cdFsYYPF8xhxD2hkiFz2HAyrUNwXsUPeYS3E=
X-Received: by 2002:a05:6358:8747:b0:17b:f744:968 with SMTP id
 q7-20020a056358874700b0017bf7440968mr5552144rwh.28.1710203057363; Mon, 11 Mar
 2024 17:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-12-pasha.tatashin@soleen.com> <3e180c07-53db-4acb-a75c-1a33447d81af@app.fastmail.com>
 <CA+CK2bA22AP2jrbHjdN8nYFbYX2xJXQt+=4G3Rjw_Lyn5NOyKA@mail.gmail.com>
 <1ac305b1-d28f-44f6-88e5-c85d9062f9e8@app.fastmail.com> <CA+CK2bBU2zwu_V6hpOonswyuft5gWQh1H9tBbYP8efLRRAAdQQ@mail.gmail.com>
In-Reply-To: <CA+CK2bBU2zwu_V6hpOonswyuft5gWQh1H9tBbYP8efLRRAAdQQ@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 11 Mar 2024 20:23:40 -0400
Message-ID: <CA+CK2bC-yC-nF7aSxudDC0kd3i10BOhN-DDO6sSfgZTzVm+t5Q@mail.gmail.com>
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

> >
> > You can't block when scheduling, either.  What if you can't refill the pool?
>
> Why can't we (I am not a scheduler guy)? IRQ's are not yet disabled,
> what prevents us from blocking while the old process has not yet been
> removed from the CPU?

Answering my own question: single cpu machine, the thread is going
away, but tries to refill the dynamic-pages, alloc_page() goes into
slow path i.e (__alloc_pages_slowpath), where it performs
cond_resched() while waiting for oom kills, and yet we cannot leave
the CPU.

