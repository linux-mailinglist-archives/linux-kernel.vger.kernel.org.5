Return-Path: <linux-kernel+bounces-131550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFA489897E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA351F2ACDF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4901A1292E6;
	Thu,  4 Apr 2024 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqz23xxk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A12B12880A;
	Thu,  4 Apr 2024 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239540; cv=none; b=ObpFi7EaolaJ+4qK/gwBceZj5Oi2030hUtL4eEpY/DaA8TpKfO7/ymrP1KZ0l0cUMbHIdFeHwrGzKcGg85lXQLcdCJgbdpt9nTbBy8zkoFGASqDaQedLSnrUar3swk+eAhGNNRFPmh3r89mSWRL0MXKYZdANDgF9yUL/mzBIKdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239540; c=relaxed/simple;
	bh=U/MPpQggBCzuKAhHoUOfvrR+Z2ao2griNbbZUp9Y+FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+X3DcFztgc2oAyGKt3BqDCxFmZTf2Yk+ayvPhbfDzvnMBmJE76T5j1EIoGZJfrbTio6WXrhVlk2uEbUFWG931hSGNdaCRp8J9CcoyM/GbF60dATVqaBkE4vb7Xedv/XNIl33PXEQM209JwHy3W0PuJZN7Hf1lfVrJGZlup13kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqz23xxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F06C433F1;
	Thu,  4 Apr 2024 14:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712239540;
	bh=U/MPpQggBCzuKAhHoUOfvrR+Z2ao2griNbbZUp9Y+FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qqz23xxki1mIXnAn+WLvnaKU8EC8fa6V5d6k5Usmy77PxW7O+g/Val5wg3CcRaipW
	 YKnVAkSAt+QkgRFy7T6+wLHcfe4VRNl0giMnZVtWuLT0+9vgk3x3IuFo0uSLILr2hF
	 38oCiSGmm9D9TiUbfdAiYMMze3u6lqZvXK+Mue1IKwOqdQkFRedSI0nnU1oifJA2QB
	 iZGyfT6ZgaetNmvNRoUi/q9h/GVHhLkUoyRguasgV/EGkIx+OAH5A6obocOLzCsIBk
	 QP0TJfX532W1p7z0iTei/pgnZdunysyNUKsQy6RnsEmkOnTbev8yM6/4+fAolbICX6
	 +HzJf7Dw7Gh3A==
Date: Thu, 4 Apr 2024 16:05:37 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, ying.huang@intel.com,
	feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [timers]  7ee9887703:
 stress-ng.uprobe.ops_per_sec -17.1% regression
Message-ID: <Zg6zscsaZ0OA14yn@localhost.localdomain>
References: <202403271623.f0b40181-oliver.sang@intel.com>
 <Zgs5NxoUUoGIkuQO@pavilion.home>
 <Zgtjdd0C2FzYVBto@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zgtjdd0C2FzYVBto@xsang-OptiPlex-9020>

Le Tue, Apr 02, 2024 at 09:46:29AM +0800, Oliver Sang a écrit :
> hi, Frederic Weisbecker,
> 
> On Tue, Apr 02, 2024 at 12:46:15AM +0200, Frederic Weisbecker wrote:
> > Le Wed, Mar 27, 2024 at 04:39:17PM +0800, kernel test robot a écrit :
> > > 
> > > 
> > > Hello,
> > > 
> > > 
> > > we reported
> > > "[tip:timers/core] [timers]  7ee9887703:  netperf.Throughput_Mbps -1.2% regression"
> > > in
> > > https://lore.kernel.org/all/202403011511.24defbbd-oliver.sang@intel.com/
> > > 
> > > now we noticed this commit is in mainline and we captured further results.
> > > 
> > > still include netperf results for complete. below details FYI.
> > > 
> > > 
> > > kernel test robot noticed a -17.1% regression of stress-ng.uprobe.ops_per_sec
> > > on:
> > 
> > The good news is that I can reproduce.
> > It has made me spot something already:
> > 
> >    https://lore.kernel.org/lkml/ZgsynV536q1L17IS@pavilion.home/T/#m28c37a943fdbcbadf0332cf9c32c350c74c403b0
> > 
> > But that's not enough to fix the regression. Investigation continues...
> 
> Thanks a lot for information! if you want us test any patch, please let us know.

The good news is that I can reproduce on two CPUs with just this:

    ./tmp-pkg/stress-ng/src/stress-ng/stress-ng --uprobe-ops 1 --uprobe 2 --timeout 5 --metrics-brief

This reminds me I should try on a single CPU. 

Anyway but the big problem with stress-ng.uprobe is that it consists in
triggering uprobes events and consuming /sys/kernel/tracing/trace_pipe

This makes this testcase nearly impossible to analyse because I can't use any
tracing: the traces are consumed by the testcase. That alone took me quite
some time to figure out.

Then I tried using perf event to do the tracing, as it relies on a different
ring buffer. It works but traces generate ring buffer consumer wake up, which
doesn't work as we are analysing code that depends on idle behaviour.

Then I tried hacking stress-uprobe.c so that the consumed traces are recorded
in a buffer that I writeback in the end. So I can add my own tracepoints in
the flow. And it works but that again doesn't mix up well with tracing idle
behaviour, similar to perf event: the fact that the testcase waits on
/sys/kernel/tracing/trace_pipe produce wake ups from idle while a trace happen
on idle. And that noise ruins the tracing.

So I'm kind of running out of options for now :-/

