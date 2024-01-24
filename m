Return-Path: <linux-kernel+bounces-37451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC0D83B037
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E762820BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7BD43147;
	Wed, 24 Jan 2024 17:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5EdBFOr"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE067F7F2;
	Wed, 24 Jan 2024 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118082; cv=none; b=Uk7OIwcgdGmO6fcVgsHAPrEFoAjCmkQioAqvH+93o7Fh6JsWrkeeOrZOIMbS5Pe/5dwf4PgOnobB7r/kO5anncA4FjL0ODIGRczFEHrY7C9imejCrW7MihtZKHYm2QA9wEszYT7RRC6KKZBBhZfdDeL9mM5IUlxN/WeBrwZ/03k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118082; c=relaxed/simple;
	bh=tw/ivyCBJnZU8g06Ui6BqgkgwG6NCYQYJWdwrEbM3kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSjtuzbZNbogPLgKRE0GjDpMZXi+bVag+INxfIeLFayqGzsE15FV5xX9LgonPjhxKBvHg24z9n9e1HNIj8PLfep8QUnT9ABJL3+NNYQkg3eoZQDvV7OrSAey113JwLzMFwhVm6jtEjb7DOTWWHhasgpuKjTyGYTc5OeFI8XEAWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5EdBFOr; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5ff84214fc7so56504587b3.0;
        Wed, 24 Jan 2024 09:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706118080; x=1706722880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HrKSWjAPLury0l0O07YwABLahdqYSfqu/vkyFWYooQ8=;
        b=G5EdBFOrAMr19wXn2q14X3LktuaZwjb1JaH9G+/9xLGwXHmGz3H/Bg/o9H/g+d5zTd
         MB7isfnGoAtjLDqpLhEPl48t1p0VST3rziSB78N+5rZfq915mUvuC3e2Z0cHLw8EkLe6
         7CmdbkRX9Ximcvf6CuJZLPPjugNw5kzYzMV1VUNRFXR7euEYBl9dIojpDZVjijgPXXer
         b2peL5QCepqqnrHucuRUg9L8FTjSx03nSx3g8WQjBpHFosE9urZenIJ2MXfU/LvijYvQ
         fFp+LtHhW0/Mn8aVc+YlF+exhgK2fQCH0NIh+lOJgSaP4ZP1aN3DqsexWp9RDkyAGgY5
         /0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706118080; x=1706722880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrKSWjAPLury0l0O07YwABLahdqYSfqu/vkyFWYooQ8=;
        b=MDhAxeb3LoGADwktNboej6gHeMACe96qXGog3FeumAwMpNzKxNEQpV2i4D4SuXerNW
         As6CYk484OsGwejYoQVcU99DPlxhkSGoLAi99WiNGyQr1fuKE9KcS6mPNRfhxlkiohph
         eV9Priu+YLfX39cRcaguUaXKT0G7kIFA2NM1v+UG32LebNIMSjAWqZG86dQoOxVW0Bzq
         SdCS5PgY7BONS01CpME/hq5XuHHvjW3HUvNoNuZJf6rDp2fF7xul7ZA+2VHojw+oG9Kk
         +kcYksoXY5WHHnjaZYtdq67wtDRvK5hgew/M1wckILDiupu8DH5dinQ7tkvIoj9BrGCx
         AQMg==
X-Gm-Message-State: AOJu0YyHdTSImhU/F5BF606d1InoH42aedxQTHfmFSJC3q+Sf/oYyrTB
	YfsAmX6VbBTgkIWCNjW7azF3Nm7jCuAaJIwDMwEJ3BuuIajmUg7t
X-Google-Smtp-Source: AGHT+IG8FJ68JYgvol2vsYmkZB9x7Cw6vyk82+V1soudJ0xN7Bq1azDGVFF6zVhVo1ZMyf65R6wE/A==
X-Received: by 2002:a0d:d70b:0:b0:5ff:9f2c:1299 with SMTP id z11-20020a0dd70b000000b005ff9f2c1299mr1077412ywd.65.1706118079707;
        Wed, 24 Jan 2024 09:41:19 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:abdb:7236:6977:9ab5])
        by smtp.gmail.com with ESMTPSA id t140-20020a0dea92000000b005ffb2815960sm77564ywe.45.2024.01.24.09.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:41:19 -0800 (PST)
Date: Wed, 24 Jan 2024 09:41:18 -0800
From: Yury Norov <yury.norov@gmail.com>
To: "Lameter, Christopher" <cl@os.amperecomputing.com>
Cc: Huang Shijie <shijie@os.amperecomputing.com>,
	gregkh@linuxfoundation.org, patches@amperecomputing.com,
	rafael@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, kuba@kernel.org, vschneid@redhat.com,
	mingo@kernel.org, akpm@linux-foundation.org, vbabka@suse.cz,
	rppt@kernel.org, tglx@linutronix.de, jpoimboe@kernel.org,
	ndesaulniers@google.com, mikelley@microsoft.com,
	mhiramat@kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will@kernel.org, mark.rutland@arm.com, mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org, chenhuacai@kernel.org,
	jiaxun.yang@flygoat.com, linux-mips@vger.kernel.org
Subject: Re: [PATCH v2] NUMA: Early use of cpu_to_node() returns 0 instead of
 the correct node id
Message-ID: <ZbFLvnMQ3wsQ0pIF@yury-ThinkPad>
References: <20240123045843.75969-1-shijie@os.amperecomputing.com>
 <4a13353c-cf4b-a388-5776-389c61c63ec0@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a13353c-cf4b-a388-5776-389c61c63ec0@os.amperecomputing.com>

On Wed, Jan 24, 2024 at 09:19:00AM -0800, Lameter, Christopher wrote:
> On Tue, 23 Jan 2024, Huang Shijie wrote:
> 
> > During the kernel booting, the generic cpu_to_node() is called too early in
> > arm64, powerpc and riscv when CONFIG_NUMA is enabled.
> > 
> > For arm64/powerpc/riscv, there are at least four places in the common code
> > where the generic cpu_to_node() is called before it is initialized:
> > 	   1.) early_trace_init()         in kernel/trace/trace.c
> > 	   2.) sched_init()               in kernel/sched/core.c
> > 	   3.) init_sched_fair_class()    in kernel/sched/fair.c
> > 	   4.) workqueue_init_early()     in kernel/workqueue.c
> > 
> > In order to fix the bug, the patch changes generic cpu_to_node to
> > function pointer, and export it for kernel modules.
> > Introduce smp_prepare_boot_cpu_start() to wrap the original
> > smp_prepare_boot_cpu(), and set cpu_to_node with early_cpu_to_node.
> > Introduce smp_prepare_cpus_done() to wrap the original smp_prepare_cpus(),
> > and set the cpu_to_node to formal _cpu_to_node().
> 
> Would  you please fix this cleanly without a function pointer?
> 
> What I think needs to be done is a patch series.
> 
> 1. Instrument cpu_to_node so that some warning is issued if it is used too
> early. Preloading the array with NUMA_NO_NODE would allow us to do that.

By preloading do you mean compile-time initialization?
 
> 2. Implement early_cpu_to_node on platforms that currently do not have it.
> 
> 3. A series of patches that fix each place where cpu_to_node is used too
> early.

Agree. This is the right way to go. And pretty well all of it was discussed
in v1, isn't?

Thanks,
Yury

