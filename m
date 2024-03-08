Return-Path: <linux-kernel+bounces-96771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F0587613B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AD01B22EE6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53580535C2;
	Fri,  8 Mar 2024 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJn4o238"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F9426296
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709891343; cv=none; b=ecK7iKSuolpKq6m+e4PRSGIxeoblt0iievoxGAQBHOZSG06G5QT4W2LgA8nVgKr5fHhxD1o/+d+O/NxajmoI3qLuSoRRUFzEq6T38IXbLwuXV6YiV1JYWl4JjAfvpPbgRRrPQksJDc6M/Hzk5LfSLD83r5R0xGBzWcfhR9WowUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709891343; c=relaxed/simple;
	bh=8FEYMktuDdPldJdpEQIeybWwsrv+ni5tPS9cjUSHIs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fn2haj3R+XPHDBzEdzt0fhIcW+uNmHJgoVpT9cAnh7IpazgBzAtOKzG8ChhBp+tAaSpH+KsrtMYTy69jkYNo5GgSDtJ5ykWwxZHnaEmNGnruINdAtVJRTX+H701TfRiIrFALASMj4oNHVpfifEJtEFKy5TvQQ+WSJFwpbFU+8r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJn4o238; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d220e39907so26453321fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 01:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709891340; x=1710496140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H9upTxzDiDyuqRqzO8TSC9yrQw1jm3q2ca6hlxSfwnI=;
        b=YJn4o238413mT+bBc+XfZjJQg9rb20IjpbPVAOG+y2/Ma/QSzLIcsz551SwWT61Wa2
         H/RYqgLLNNE46AUIttJEDGcB2FkHUK52WO94Iyuuie6Jum50dIoQtapBlsgd106iZiw0
         I4sh4kBCyLRV79HGk7CwkOF+oDCkEceCSpIqBqX2pKyUZ7N1ct1/vwMkyggRMXjrhUHH
         bm9xEJ0Tn0wOp1AguD1eqVQPgzJr5SDurfSw/E65NFCCGNQRq9uasiK1iIk7gELlzk59
         Wl+HmXvkNmS5Ituu49kPglshghjJgYVXgOHcmG8x3LmyL3+P1YflMVjfj6N2V4kNatV1
         WiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709891340; x=1710496140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9upTxzDiDyuqRqzO8TSC9yrQw1jm3q2ca6hlxSfwnI=;
        b=qgQlb32Sy8kG1PFDNfdv+JK4CRg89rbVbyOedRKnsPWc4/hKQG3x/AIqyLJoR7klyo
         Ff9VikapmybLEkff7fvv+7vRa/58KiMZkfvJO2/g5ETfkIJ2BrqISnpHw90IigN6b9Xf
         Apsu+HAlgiVI38cJXv2ZdlCOHgUQPbVTCjZwt46K6246MBG/VWGSoiacgqKshAiiml35
         Z1hL0LZzOWWRRXRFj3v3nqFSL/KQrXg63STB4WdnbZGKaTRvvDUykb3POb6CnvUj1fEO
         /5664xyfQMl/PTtPEXg51tIgqxynnomRjFrA18JoylOKH8Vip8gHY/6/qEs1nPPseris
         JJyA==
X-Gm-Message-State: AOJu0Yx47FK18Dq1gVia5iIbQmh0hMwwg7husK+ux0MNfcxSzlGnTgN8
	JlNYD8dhT6HUDGBVT+RI28aPEZiChiP4TZJmXo/TPfsF4fIfFCLI
X-Google-Smtp-Source: AGHT+IF6tDAC2R07Dc8STCP17sEn5rb81PKVIRLTvWUi6xWulgdc56BYE78KW9AoCKNTZLTA8BjEZw==
X-Received: by 2002:a2e:8899:0:b0:2d2:8ad9:a667 with SMTP id k25-20020a2e8899000000b002d28ad9a667mr3307511lji.17.1709891339259;
        Fri, 08 Mar 2024 01:48:59 -0800 (PST)
Received: from gmail.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id k16-20020a05600c1c9000b004130e0906dfsm5233989wms.33.2024.03.08.01.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 01:48:57 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 8 Mar 2024 10:48:55 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, Shrikanth Hegde <sshegde@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/9] sched/balancing: Switch the
 'DEFINE_SPINLOCK(balancing)' spinlock into an 'atomic_t
 sched_balance_running' flag
Message-ID: <ZerfB+r3XAEKAezy@gmail.com>
References: <20240304094831.3639338-1-mingo@kernel.org>
 <20240304094831.3639338-2-mingo@kernel.org>
 <xhsmhh6hldkau.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhh6hldkau.mognet@vschneid-thinkpadt14sgen2i.remote.csb>


* Valentin Schneider <vschneid@redhat.com> wrote:

> On 04/03/24 10:48, Ingo Molnar wrote:
> > The 'balancing' spinlock added in:
> >
> >   08c183f31bdb ("[PATCH] sched: add option to serialize load balancing")
> >
> > ... is taken when the SD_SERIALIZE flag is set in a domain, but in reality it
> > is a glorified global atomic flag serializing the load-balancing of
> > those domains.
> >
> > It doesn't have any explicit locking semantics per se: we just
> > spin_trylock() it.
> >
> > Turn it into a ... global atomic flag. This makes it more
> > clear what is going on here, and reduces overhead and code
> > size a bit:
> >
> >   # kernel/sched/fair.o: [x86-64 defconfig]
> >
> >      text	   data	    bss	    dec	    hex	filename
> >     60730	   2721	    104	  63555	   f843	fair.o.before
> >     60718	   2721	    104	  63543	   f837	fair.o.after
> >
> > Also document the flag a bit.
> >
> > No change in functionality intended.
> >
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> 
> Few comment nits, otherwise:
> 
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>

Thanks!

> > -static DEFINE_SPINLOCK(balancing);
> > +/*
> > + * This flag serializes load-balancing passes over large domains
> > + * (such as SD_NUMA) - only once load-balancing instance may run
>                                ^^^^
>                            s/once/one/
> 
> Also, currently the flag is only set for domains above the NODE topology
> level, sd_init() will reject an architecture that forces SD_SERIALIZE in a
> topology level's ->sd_flags(), so what about:
> 
> s/(such as SD_NUMA)/(above the NODE topology level)

Agreed & done.

> > + * at a time, to reduce overhead on very large systems with lots
> > + * of CPUs and large NUMA distances.
> > + *
> > + * - Note that load-balancing passes triggered while another one
> > + *   is executing are skipped and not re-tried.
> > + *
> > + * - Also note that this does not serialize sched_balance_domains()
>                                                ^^^^^^^^^^^^^^^^^^^^^
> Did you mean rebalance_domains()?

Correct, a later rename that unifies the nomenclature of all the 
rebalancing functions along the sched_balance_*() prefix that I have not 
posted yet crept back into this comment block, but obviously this patch 
should refer to the current namespace. Fixed.

Thanks,

	Ingo

