Return-Path: <linux-kernel+bounces-130379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33992897754
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56CD31C20DD9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAFE157498;
	Wed,  3 Apr 2024 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3aPeaN9O"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B22152521
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 17:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712165596; cv=none; b=V8IE8OaIxZcincg66v0s6q/NGkHglTJ/jtk2MUqeydoCOF1b23y2YE5N2WpgOO+gVvCkrl/JTbkjGyaUZRj9qNK+ZEo57Qmy411gKG9Ipzlft/osc40d0ojVcwtF+jDnymltc6j9wOkPD3UqD+zzGQId/pcWzgI3mu86UIoKyIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712165596; c=relaxed/simple;
	bh=bNitdDZEZ45Wu2BGg5a1lM8zD7IM1Pkagn/eVdTtlLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KEhQjhGD8BHT4PZRMd5so+oBm8m7GpHkc5qnPXWJLciLQYReszYtDXVR8nwpTgPN+tkE99iiIhHbWVurRZWnQ49UY78tDinvBwAi9D39FwHdNEz9x64ZSVn9r2HBGzhfa0rVeJWHA7MbbWoVPl2UAfWgm+nT3ezK1ItOC4wj0Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3aPeaN9O; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e223025ccbso104115ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 10:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712165593; x=1712770393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fdtmFuCQtKqL7XQB5yBZBXcGu9/7lkplVdP/I75yquc=;
        b=3aPeaN9OmKsmSJh0e4LCI/S5B/ommlnc04giwq0H8FDYAXrTmfuoatLuFSzt5ij4A3
         WtSQPF6DolV/7iVKYMGS1dRUcJSpFQObopoUDGVUdj3acs+/f9PFbaOW31FOdmhKxKFu
         KDp+6LWKlZWD2KgIthfjx+yV89Abfb73lvCjoAC6BBCv/cuD+cnMvzoiDuReVNii7mey
         OVhLNcnbEKDcsEkkBlHDUPdHw/jyY25GuYvXTj8Oz15oKeuEhFTrWZeyWiN0T/empJ9T
         ehE6Lvu7admIzoqoSaOXd43WMv0a8GpeO5wZQbHKUJ9wta/klskzdjtvYr/Kyfn2qPvR
         53Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712165593; x=1712770393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fdtmFuCQtKqL7XQB5yBZBXcGu9/7lkplVdP/I75yquc=;
        b=pYlhMvmRH5+tebmmpwcVhWgwpKDCqc2XEziiyixcwjYAGewCg/B0/i0R/TuP6SwpL3
         97mH+Yl4bS68Bhi+hs8s4CjFmcCzc809kMN2977WBSurruhYakeBCDjgmh/ieCd5fAr/
         gYWJLMOX/EC/DjmNJPBBrtmq1QMeWsqStIt71b2McYnmMVn2jJKahFxiNa0pDeVgS1Ff
         I92WkXqI/QLXjnYg8YDJ1WTSaeaGHp7B6Zw3haIpH61qczw3pWXv0SMoK/uiovgeLUgp
         +JcvH2X+dl8q7ox0lWo2aNC07LaJnGaJ+WXH9o0KY27x2gIhYKRpZqeDE6NtAkMPBnoN
         WN+A==
X-Forwarded-Encrypted: i=1; AJvYcCU13X3Xgw3vQPatPZl/z4JEyxtsYoEzEAurDsg5qrhXutoBcLSiLldkYrOhKf5V9Or9xAgkf/GSqgZq+Kxwr2HalO9FGaecB1JKUExa
X-Gm-Message-State: AOJu0YyoFs/nxLqia1kvpUjbySn9VFrpCDhhFkLmrvMFM9+5nH8HfzQT
	i2o+iHlPB2VbQ3MfTZ9BVPBbSPVxIqR8jYDY7vfzku4HwWGxEtI2+iEM1aUAxDM=
X-Google-Smtp-Source: AGHT+IFBs/XuJJMQmrVQUKGAA9J8OyyBRTsBqretCIWUOoly3HJp/hb+dobtV3ICE1IfQjtI5xaAtQ==
X-Received: by 2002:a17:90a:886:b0:2a2:c354:64dd with SMTP id v6-20020a17090a088600b002a2c35464ddmr202756pjc.38.1712165593547;
        Wed, 03 Apr 2024 10:33:13 -0700 (PDT)
Received: from [10.0.16.165] ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id ga4-20020a17090b038400b002a04f430937sm3863480pjb.43.2024.04.03.10.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 10:33:13 -0700 (PDT)
Message-ID: <314e0216-a667-4bba-bdc7-3ae8af351800@rivosinc.com>
Date: Wed, 3 Apr 2024 10:33:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Fix vector state restore in rt_sigreturn()
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andy Chiu <andy.chiu@sifive.com>, linux-riscv@lists.infradead.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>,
 Vincent Chen <vincent.chen@sifive.com>, Ben Dooks
 <ben.dooks@codethink.co.uk>, Greentime Hu <greentime.hu@sifive.com>,
 Haorong Lu <ancientmodern4@gmail.com>, Jerry Shih <jerry.shih@sifive.com>,
 Nick Knight <nick.knight@sifive.com>, linux-kernel@vger.kernel.org,
 Charlie Jenkins <charlie@rivosinc.com>, Vineet Gupta <vgupta@kernel.org>
References: <20240403072638.567446-1-bjorn@kernel.org>
Content-Language: en-US
From: Vineet Gupta <vineetg@rivosinc.com>
In-Reply-To: <20240403072638.567446-1-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/3/24 00:26, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
>
> The RISC-V Vector specification states in "Appendix D: Calling
> Convention for Vector State" [1] that "Executing a system call causes
> all caller-saved vector registers (v0-v31, vl, vtype) and vstart to
> become unspecified.". In the RISC-V kernel this is called "discarding
> the vstate".
>
> Returning from a signal handler via the rt_sigreturn() syscall, vector
> discard is also performed. However, this is not an issue since the
> vector state should be restored from the sigcontext, and therefore not
> care about the vector discard.
>
> The "live state" is the actual vector register in the running context,
> and the "vstate" is the vector state of the task. A dirty live state,
> means that the vstate and live state are not in synch.
>
> When vectorized user_from_copy() was introduced, an bug sneaked in at
> the restoration code, related to the discard of the live state.
>
> An example when this go wrong:
>
>   1. A userland application is executing vector code
>   2. The application receives a signal, and the signal handler is
>      entered.
>   3. The application returns from the signal handler, using the
>      rt_sigreturn() syscall.
>   4. The live vector state is discarded upon entering the
>      rt_sigreturn(), and the live state is marked as "dirty", indicating
>      that the live state need to be synchronized with the current
>      vstate.
>   5. rt_sigreturn() restores the vstate, except the Vector registers,
>      from the sigcontext
>   6. rt_sigreturn() restores the Vector registers, from the sigcontext,
>      and now the vectorized user_from_copy() is used. The dirty live
>      state from the discard is saved to the vstate, making the vstate
>      corrupt.
>   7. rt_sigreturn() returns to the application, which crashes due to
>      corrupted vstate.
>
> Note that the vectorized user_from_copy() is invoked depending on the
> value of CONFIG_RISCV_ISA_V_UCOPY_THRESHOLD. Default is 768, which
> means that vlen has to be larger than 128b for this bug to trigger.
>
> The fix is simply to mark the live state as non-dirty/clean prior
> performing the vstate restore.
>
> Link: https://github.com/riscv/riscv-isa-manual/releases/download/riscv-isa-release-8abdb41-2024-03-26/unpriv-isa-asciidoc.pdf # [1]
> Reported-by: Charlie Jenkins <charlie@rivosinc.com>
> Reported-by: Vineet Gupta <vgupta@kernel.org>
> Fixes: c2a658d41924 ("riscv: lib: vectorize copy_to_user/copy_from_user")
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>

Tested-by: Vineet Gupta <vineetg@rivosinc.com>

For completeness (and fun)

1. The issue was triggered on dual core spike run with a seemingly
benign workload (the key is repeated fork/execve/exit with a little I/O)

    some-shell-script.sh

    #!/bin/bash

    (while true; do ls; done) &

    for i in $seq (1 20); do
       <long running job>
    done

2. The issue initially appears as follows: Vector store instruction,
before starting to run invalidates it's own context (page fault ->
preemption -> handle-signal -> sigreturn -> VILL / V-clobber), so when
it eventually runs, it takes an illegal instruction exception, taking
down the entire program.

Thx,
-Vineet
   

