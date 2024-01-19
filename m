Return-Path: <linux-kernel+bounces-31456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EC5832E93
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E024B21006
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D449956444;
	Fri, 19 Jan 2024 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjEt9H6n"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B917555C34;
	Fri, 19 Jan 2024 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705687337; cv=none; b=WKDtrZr3ZEmm0SYDnLiDNvJbMz19pK8IyWs23CpeGIdIOTB4wpFxSzdgAdMOzDmuiO2eZHydGSMQtJ0AzlqRYnAxsDjB/SykINUB6OKoOTH7Xwxvcv4SehqncXoUGfWBpzw0I8EShqwKtVAzFMUx7001MJZMcbReB05D3C9IDIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705687337; c=relaxed/simple;
	bh=Vpvm4KefXKpJuW7kEf49W4+4n5jkxACkg0N5JK3WnqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6DhFe+UzmipYzHhXBaRfid5KRL3vYpq9gFRxNVmuhzht1vbR/CFzMdi1nBaePoUTYidM+vG7z+iKCEANlToFnI/kQHtE+2Stk6NuVmMub74fCNFmJxuO97lZSzydoxYvqjsnKnMeF2Qx0/onl3QsKwiHsA5cbGdbh4O+Paxxjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjEt9H6n; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5e54d40cca2so8504477b3.3;
        Fri, 19 Jan 2024 10:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705687335; x=1706292135; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5b/i454jUf4ojxYvY+VxBq+cGu5zdwzrcVsmFXePrUc=;
        b=cjEt9H6nQ3rscFQE99JWn/WbaxZNRZVLVGOwcnl3R6kZeELFAKpZYrbnQQU9icrDHl
         Xfz7CYSQr9bJsTehUcj66eCKtWkEm+MrZgngnAe0f8uuoclg3pFmpdW11jlwQtGsViqI
         /NO52s74ekv49dIafEgDTUrhnS3grveRU2O+WIaarPVnpTtaR8kuDUaA1e0PNj/UEQ2a
         qS0ddmTKJy4V3iBN11EmxBHi2F/rqaWK/Ez22bajvPeTBsK1Z9QAqJ+8MgFjOYNgB240
         bX2YpJxBdZYrcQa7PSsqdFIqu8F+fbxXWZ5xvVCFqA/OMvycIBegHtHHEah291mjGvAh
         nAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705687335; x=1706292135;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5b/i454jUf4ojxYvY+VxBq+cGu5zdwzrcVsmFXePrUc=;
        b=iJ9L1jHeb4KvuiOEK+DnlBDJbOcOuUE/dU64qBe/FROgNY1Mgm7Tm3aLl0o6QAViQj
         EghqOT6eVC/sVR8EWO5WZZHqJHyvYS4CjtNE5TZ73711Fk13tmh6A6ZHiZ2+FxcGVJoB
         iNrhQysOLN48rqcgzM17rQwmz3pn/VzFiPde+AwezF296cNegcDpS+CoKvYk6KCZu3kw
         z5uMW1NQIMSnp0l5kQ0jveAkClNPmETvQCnY+ItZllUf3xfC5xPOFaCq9E2IQ5eYXJ4s
         Dy7HMF/JBB/sTtGzP3uSOZB+1OAcJbQHEorewv5kBMGWeDJGLIv/Kcx7e2AyKfuZauXp
         +66A==
X-Gm-Message-State: AOJu0Ywlkn3q0iTfLeD+8pcK3G5jRYGuR2jimevfJgUqxngMTndIFehO
	Ctvspv0rug2Z3eybvSn0vmo/A0PNpTXjuH3kRiYglnADnuZ/JJag
X-Google-Smtp-Source: AGHT+IH9gcZrsox+4pkG+XVC3K2DCkhX2jg2gbQvfcMMKA5AWgDkyl6PTnKywYab9xjZ/eqMztcaSA==
X-Received: by 2002:a0d:e003:0:b0:5ff:9567:c81 with SMTP id j3-20020a0de003000000b005ff95670c81mr286738ywe.22.1705687334593;
        Fri, 19 Jan 2024 10:02:14 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2288:782e:a717:678d])
        by smtp.gmail.com with ESMTPSA id n68-20020a0dcb47000000b005ff877093easm1389519ywd.143.2024.01.19.10.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 10:02:14 -0800 (PST)
Date: Fri, 19 Jan 2024 10:02:13 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Shijie Huang <shijie@amperemail.onmicrosoft.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	gregkh@linuxfoundation.org, patches@amperecomputing.com,
	rafael@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, kuba@kernel.org, vschneid@redhat.com,
	mingo@kernel.org, akpm@linux-foundation.org, vbabka@suse.cz,
	tglx@linutronix.de, jpoimboe@kernel.org, ndesaulniers@google.com,
	mikelley@microsoft.com, mhiramat@kernel.org, arnd@arndb.de,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will@kernel.org, mark.rutland@arm.com, mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org, chenhuacai@kernel.org,
	jiaxun.yang@flygoat.com, linux-mips@vger.kernel.org,
	cl@os.amperecomputing.com
Subject: Re: [PATCH] NUMA: Early use of cpu_to_node() returns 0 instead of
 the correct node id
Message-ID: <Zaq5JT6SaiogCEkT@yury-ThinkPad>
References: <20240119033227.14113-1-shijie@os.amperecomputing.com>
 <Zan9sb0vtSvVvQeA@yury-ThinkPad>
 <1cd078fd-c345-4d85-a92f-04c806c20efa@amperemail.onmicrosoft.com>
 <Zao13I4Bb0tur0fZ@kernel.org>
 <b8786c38-d6c4-4fea-a918-ac6a45682dba@amperemail.onmicrosoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8786c38-d6c4-4fea-a918-ac6a45682dba@amperemail.onmicrosoft.com>

On Fri, Jan 19, 2024 at 04:50:53PM +0800, Shijie Huang wrote:
> 
> 在 2024/1/19 16:42, Mike Rapoport 写道:
> > On Fri, Jan 19, 2024 at 02:46:16PM +0800, Shijie Huang wrote:
> > > 在 2024/1/19 12:42, Yury Norov 写道:
> > > > This adds another level of indirection, I think. Currently cpu_to_node
> > > > is a simple inliner. After the patch it would be a real function with
> > > > all the associate overhead. Can you share a bloat-o-meter output here?
> > > #./scripts/bloat-o-meter vmlinux vmlinux.new
> > > add/remove: 6/1 grow/shrink: 61/51 up/down: 1168/-588 (580)
> > > Function                                     old     new   delta
> > > numa_update_cpu                              148     244     +96
> > > 
> > >   ...................................................................................................................................(to many to skip)
> > > 
> > > Total: Before=32990130, After=32990710, chg +0.00%
> > It's not only about text size, the indirect call also hurts performance
> 
> The cpu_to_node() is called at very low frequency, most of the times is in
> the kernel booting time.
 
That doesn't matter. This function is a simple inliner that dereferences
a pointer, and I believe all of us want to keep it simple. 
 
> > > > Regardless, I don't think that the approach is correct. As per your
> > > > description, some initialization functions erroneously call
> > > > cpu_to_node() instead of early_cpu_to_node() which exists specifically
> > > > for that case.
> > > > 
> > > > If the above correct, it's clearly a caller problem, and the fix is to
> > > > simply switch all those callers to use early version.
> > > It is easy to change to early_cpu_to_node() for sched_init(),
> > > init_sched_fair_class()
> > > 
> > > and workqueue_init_early(). These three places call the cpu_to_node() in the
> > > __init function.
> > > 
> > > 
> > > But it is a little hard to change the early_trace_init(), since it calls
> > > cpu_to_node in the deep
> > > 
> > > function stack:
> > > 
> > >    early_trace_init() --> ring_buffer_alloc() -->rb_allocate_cpu_buffer()
> > > 
> > > 
> > > For early_trace_init(), we need to change more code.
> > > 
> > > 
> > > Anyway, If we think it is not a good idea to change the common code, I am
> > > oaky too.
> > Is there a fundamental reason to have early_cpu_to_node() at all?
> 
> The early_cpu_to_node does not work on some ARCHs (which support the NUMA),
> such
> 
> as  SPARC, MIPS and S390.

So, your approach wouldn't work either, right? I think you've got a
testing bot report on it already...

You can make it like this:

  #ifdef CONFIG_ARCH_NO_EARLY_CPU_TO_NODE
  #define early_cpu_to_node cpu_to_node
  #endif
 
> > It seems that all the mappings are known by the end of setup_arch() and the
> > initialization of numa_node can be moved earlier.
> > > > I would also initialize the numa_node with NUMA_NO_NODE at declaration,
> > > > so that if someone calls cpu_to_node() before the variable is properly
> > > > initialized at runtime, he'll get NO_NODE, which is obviously an error.
> > > Even we set the numa_node with NUMA_NO_NODE, it does not always produce
> > > error.

You can print this error yourself:

  #ifndef cpu_to_node
  static inline int cpu_to_node(int cpu)
  {
        int node = per_cpu(numa_node, cpu);

  #ifdef CONFIG_DEBUG_PER_CPU_MAPS
        if (node == NUMA_NO_NODE)
                pr_err(...);
  #endif

          return node;
  }
  #endif


