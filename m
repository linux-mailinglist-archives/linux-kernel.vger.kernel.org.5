Return-Path: <linux-kernel+bounces-92292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32A5871DFF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5BFD1C23A5C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281FF56B7C;
	Tue,  5 Mar 2024 11:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyMSuYbS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605CD56758;
	Tue,  5 Mar 2024 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638533; cv=none; b=AUG67DE71G+eb2ogH+3QQG3ewpnK1q8Xbm3/g0r44hc+jXW2giudanVXD0Dh66QCS/wxXzY01uehkgrNf+oPp2lWc28btQHrDBJYUKHakmk/SmCha8euBfUDjP8VYC6qopQEv4A6P5zLcsqQUKLjWsyGqV4TL9/nbSPeXs4YAwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638533; c=relaxed/simple;
	bh=1pWSWqjFhvRKTLbt/RaCTa1L9MzH/peD1nMCCxEnHZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2fW3u3qWEOMc06SXYny/Ne2d+xGB+20qiXSz6SIulhGjY+6ezAlKqqjZGSnzhfKVUCh8/FVsWr2733AwgZsPAhRvnLPLfjARr4QwjSJxH4tfSEwAerfmNTiKx7llTOGh6TtlgLVXSSJpWhCyAp6SNHbo3kYatR1469Ci91jWKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyMSuYbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA48C433F1;
	Tue,  5 Mar 2024 11:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709638532;
	bh=1pWSWqjFhvRKTLbt/RaCTa1L9MzH/peD1nMCCxEnHZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qyMSuYbS9nx58vLVK+66V/99HS0zzw1qb/O4yaIqTItM19PP8lmPwpDpu9Z3KOgan
	 naW2DICnOAOjZ6vy+ZgD/NkiM3+IGrtb+BUjNGsi/hDBKsEe2ZMuuUOAaPdY303M7d
	 H/H+Qsg417fpmjQJeSOuCIP86wWs2iT3nnEmFwro3gfMq9dw94kJ1bppXdhkTM707F
	 JFtL/XlDsmGS4XpQOP562UEuqI6wk+jsXOGNM3CcC1T/k7E7KfhDBSImxEY8r6BUzp
	 IwHprECZJ+Q+e2Xr1nl7FrIeWwAHuEiYcAa0j7iOCEm3WlOAP3jTWtl86Vovmkz4iJ
	 hoIcMyrwC6xag==
Date: Tue, 5 Mar 2024 12:35:30 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, ying.huang@intel.com,
	feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [tip:timers/core] [timers]  7ee9887703:  netperf.Throughput_Mbps
 -1.2% regression
Message-ID: <ZecDghwFnq0Tmngo@lothringen>
References: <202403011511.24defbbd-oliver.sang@intel.com>
 <ZeUWreWcp4UWQ081@pavilion.home>
 <ZeUuLPXfLCmB39qq@xsang-OptiPlex-9020>
 <ZeWwYUY56IG0yzzQ@localhost.localdomain>
 <ZeaAx662HfbpMLdg@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeaAx662HfbpMLdg@xsang-OptiPlex-9020>

On Tue, Mar 05, 2024 at 10:17:43AM +0800, Oliver Sang wrote:
>      20.97 ±  3%      -9.7       11.23 ± 16%      -9.6       11.40 ±  4%  perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt

And yes, fewer time spent in IRQ-tail softirq processing.

>       1.70 ± 13%      +5.6        7.28 ± 14%      +5.8        7.54 ± 15%  perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.run_ksoftirqd.smpboot_thread_fn

And more time spent in ksoftirqd softirq processing.

This can match the increase in involuntary context switches: IRQ-tail softirq
processing takes too much time, possibly due to long lasting remote timer
expiring, ksoftirqd is then scheduled, preempting netperf (through
might_resched()/cond_resched()) as this is a voluntary preemption kernel).

Thanks.

