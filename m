Return-Path: <linux-kernel+bounces-44589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AC38424A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89C621F255C3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB6C67E9F;
	Tue, 30 Jan 2024 12:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="pqf8gJpx"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DA766B37
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706617090; cv=none; b=AWV8xzPYqOpxQ6T/7BoDppbe1mBaXhCECDGGtzXEzKHKy+XNDpip2QZk4x2er2z2L0AZ4ALpSZRtvhi9E8cF9g0YusYHfKm2xoJml190JWFvB9iasBzynTqv/dpWFfoBSRx5QDSw1NNhdqlL5XRpRolU9VrZKh29LQtEePiMOYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706617090; c=relaxed/simple;
	bh=aap5r7ioaHBr3oZ1CL2DgTUN+lzMesYEoUhuwOS3e9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsZS5aJBamBsE/L5u009TP9IE4p3nZGfHBm1y62fhmmtPVtxqJVYTWA5h6xw3nPsWRQD/P/74TAOG6XOuvynBqxaJ9jSPz4ai4nQbc/yl3i2DEqEgKBzdr+vqiWHDS1gwpKxTtMCrSbYgNnCFOC1lmQZNh3AxpYchmDDlaBBfXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=pqf8gJpx; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51028acdcf0so4761886e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1706617086; x=1707221886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JVZ040pnszTJYS9ZApPN/ubynpN7vUyGZw+eMhwthB8=;
        b=pqf8gJpxBhey654iwKbCow5Pf5c2ehDfd9kDaPDZsGMJis5z6yv9/By0uBJmQiydQ0
         JzUP5Zc8v5oGKDrvvqYvZov9+RCo2TOXdU2GRotvjWJ5VSAuFR/nRU8HcgAhsI6LGlIz
         XKyfq1vv57j6Jx/ujCUEKcQq1lox6KFhe2mDcKKUjACjFFw1C5PCvcawxl4fuauYnYd9
         2Rx7zDRG+vJh1EtRt3sr/DRKHL06c+pzt+VvybreS7ukz5mWrkTpyHj0p07ptcOsS7E9
         Z9oLWIZQ9SOpc20v8/LkR5plKqkzONhJT8X2BHKQKlhpSemgzlKC9Sgsu8CPtB1mRDtN
         DJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706617086; x=1707221886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVZ040pnszTJYS9ZApPN/ubynpN7vUyGZw+eMhwthB8=;
        b=vU4uhvKND7FTVuXKROzEtnvfWqKsWIHMPEqNC5xTWhjApnIka+oSx5VdslHWqxVNMz
         AGsRVEoWO5GRYBBfjhhS6WOwjnNogw7DwCBvUL2CrixIOnDIWA4RMh2r+4jDmBF9oVpn
         9O/HOdAvmNcfrx8TJQqcVJauo9C7wR+dnT7gUlPb1z6HT11dCIz9Dh3/XH28LojOM7/K
         H3RnBqx90C+uwDEE7JwShSljfs223WNLhxqoT3sREFN1UW2ST22hIHl7XePM6IVNM15j
         k8o2j3X6CqJaKJhRkHSAPLhCbtSwvTtCQ7osEV5d6TXh+2r7M3biAiP6utbGZVMfQdVq
         QlIA==
X-Gm-Message-State: AOJu0YykvTZeyboaQHXHH1TAkTRcn6gjfy5WmnWcwYpGiwrSD4YSRjtH
	wJiVYJystu5cudQ4dEeg8zSTWFGypAKyBIKESCTFG7+XBltBIUGhp0twbjbENRg=
X-Google-Smtp-Source: AGHT+IHirGZCrIDHZGhiLejiH/5mnKA4eFh1BSnZ91z5ycddYmGjZebxLWFC21DK+0c7MDWsyG6VFw==
X-Received: by 2002:a05:6512:2209:b0:510:24aa:ba7d with SMTP id h9-20020a056512220900b0051024aaba7dmr6919311lfu.38.1706617086169;
        Tue, 30 Jan 2024 04:18:06 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a20-20020aa7d754000000b0055efeee7722sm2079010eds.79.2024.01.30.04.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:18:05 -0800 (PST)
Date: Tue, 30 Jan 2024 13:18:04 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@rivosinc.com>
Subject: Re: arch/riscv/kernel/paravirt.c:44:1: sparse: sparse: symbol
 '__pcpu_scope_steal_time' was not declared. Should it be static?
Message-ID: <20240130-630542897176b3dbc536657a@orel>
References: <202401301733.XLBqnyLY-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202401301733.XLBqnyLY-lkp@intel.com>

On Tue, Jan 30, 2024 at 05:18:30PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   861c0981648f5b64c86fd028ee622096eb7af05a
> commit: fdf68acccfc6af9497c34ee411d89af13b6516ed RISC-V: paravirt: Implement steal-time support
> date:   4 weeks ago
> config: riscv-randconfig-r133-20240130 (https://download.01.org/0day-ci/archive/20240130/202401301733.XLBqnyLY-lkp@intel.com/config)
> compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 4a39d08908942b2d415db405844cbe4af73e75d4)
> reproduce: (https://download.01.org/0day-ci/archive/20240130/202401301733.XLBqnyLY-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401301733.XLBqnyLY-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> arch/riscv/kernel/paravirt.c:44:1: sparse: sparse: symbol '__pcpu_scope_steal_time' was not declared. Should it be static?
>    arch/riscv/kernel/paravirt.c:106:19: sparse: sparse: cast to restricted __le32
>    arch/riscv/kernel/paravirt.c:107:30: sparse: sparse: restricted __le32 degrades to integer
>    arch/riscv/kernel/paravirt.c:102:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sequence @@     got restricted __le32 @@
>    arch/riscv/kernel/paravirt.c:102:26: sparse:     expected unsigned int [usertype] sequence
>    arch/riscv/kernel/paravirt.c:102:26: sparse:     got restricted __le32
>    arch/riscv/kernel/paravirt.c:104:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] steal @@     got restricted __le64 @@
>    arch/riscv/kernel/paravirt.c:104:23: sparse:     expected unsigned long long [usertype] steal
>    arch/riscv/kernel/paravirt.c:104:23: sparse:     got restricted __le64
>    arch/riscv/kernel/paravirt.c:109:16: sparse: sparse: cast to restricted __le64
> 
> vim +/__pcpu_scope_steal_time +44 arch/riscv/kernel/paravirt.c
> 
>     43	
>   > 44	DEFINE_PER_CPU(struct sbi_sta_struct, steal_time) __aligned(64);
>     45	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

I wrote patches for these almost a month ago, but somehow forgot to post
them... I'll retest and post now.

Thanks,
drew

