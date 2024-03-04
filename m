Return-Path: <linux-kernel+bounces-90510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB870870068
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451E91F230A3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7068638DFC;
	Mon,  4 Mar 2024 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMaMUhnh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CD51B965;
	Mon,  4 Mar 2024 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551716; cv=none; b=Mcbvigxfu3mg8uiqZpI6TeTdvdcD/NdcCjB/5Rz7WpE2P0DQ5eNuyg0MAfKeskn5JHOBJugTWwj1fmgrZsjz+EJiXbBIsBTeZsJY4xZIMDRWcRhgdmth8IIKE7qw4NnucqYOL4cL+/QLcZd3xv3mX3Y4t+AqK5QCkjGL0uewWoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551716; c=relaxed/simple;
	bh=NEBYof5k9QJEgydUQqeTNGKxzFXbpJp/phcxbRBQ0M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqAL69e7/XTKmbMR8WS/rZnL5xT3WjkM/buZzAvDvm3HtsSv3ax1XVrBn7fIGR/kaVyPImeROHw+otkxRPYk+PkrzDKPeYUZ6aYP3vhb6UfxeaK6fceQnD227zSNLDJ6xBBoA/khDXeGyzByOFjMCEENbApkSRkKxSf7gJsB6gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMaMUhnh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBF3C433C7;
	Mon,  4 Mar 2024 11:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709551716;
	bh=NEBYof5k9QJEgydUQqeTNGKxzFXbpJp/phcxbRBQ0M0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dMaMUhnh2LfWm37z6cJrU9SorGFCIu8Jd8exYE37eMk+b+nf0uHAD86zfIeOWs5nu
	 KmToUzZC/uNnkgM0z65XtQQfGDWqgHk/9v83AUqicI+lsTjbIxGC3JxFwLPX4Kbicv
	 6sJJtUkCVqsvm5hg7yXHX4400udNN/UbMocZKUWxBekbl5phZYAi94YFQKVLg5a5Sr
	 fwWzi5uukTKJEJv1Rpg5pbfys1oYaJI7fLt/l4XPaf5x5v0og8hnXC7oecARUAq1By
	 hKjvBYJhUaSYuBpj5y7j9/5SfuRdELhOFDF8eFVtEE3nXvdZ7jxjqT6HWHONhJDekq
	 JiPzRBGBqBF2Q==
Date: Mon, 4 Mar 2024 12:28:33 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, ying.huang@intel.com,
	feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [tip:timers/core] [timers]  7ee9887703:  netperf.Throughput_Mbps
 -1.2% regression
Message-ID: <ZeWwYUY56IG0yzzQ@localhost.localdomain>
References: <202403011511.24defbbd-oliver.sang@intel.com>
 <ZeUWreWcp4UWQ081@pavilion.home>
 <ZeUuLPXfLCmB39qq@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeUuLPXfLCmB39qq@xsang-OptiPlex-9020>

Le Mon, Mar 04, 2024 at 10:13:00AM +0800, Oliver Sang a écrit :
> On Mon, Mar 04, 2024 at 01:32:45AM +0100, Frederic Weisbecker wrote:
> > Le Fri, Mar 01, 2024 at 04:09:24PM +0800, kernel test robot a écrit :
> > > commit: 
> > >   57e95a5c41 ("timers: Introduce function to check timer base is_idle flag")
> > >   7ee9887703 ("timers: Implement the hierarchical pull model")
> > 
> > Is this something that is observed also with the commits that follow in this
> > branch?
> 
> when this bisect done, we also tested the tip of timers/core branch at that time
> 8b3843ae3634b vdso/datapage: Quick fix - use asm/page-def.h for ARM64
> 
> the regression still exists on it:
> 
> 57e95a5c4117dc6a 7ee988770326fca440472200c3e 8b3843ae3634b472530fb69c386
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>       4.10            -1.2%       4.05            -1.2%       4.05        netperf.ThroughputBoth_Mbps
>       1049            -1.2%       1037            -1.2%       1036        netperf.ThroughputBoth_total_Mbps
>       4.10            -1.2%       4.05            -1.2%       4.05        netperf.Throughput_Mbps
>       1049            -1.2%       1037            -1.2%       1036        netperf.Throughput_total_Mbps

Oh, I see... :-/

> > Ie: would it be possible to compare instead:
> > 
> >     57e95a5c4117 (timers: Introduce function to check timer base is_idle flag)
> > VS
> >     b2cf7507e186 (timers: Always queue timers on the local CPU)
> > 
> > Because the improvements introduced by 7ee9887703 are mostly relevant after
> > b2cf7507e186.
> 
> got it. will test.
> 
> at the same time, we noticed current tip of timers/core is
> a184d9835a0a6 (tip/timers/core) tick/sched: Fix build failure for
> CONFIG_NO_HZ_COMMON=n

Shouldn't be a problem as it fixes an issue introduced after:

	  b2cf7507e186 (timers: Always queue timers on the local CPU)

> 
> though it seems irelevant, we will still get data for it.

Thanks a lot, this will be very helpful. Especially with all the perf diff
details like in the initial email report. Because I'm having some troubles
running those lkp tests. How is it working BTW? I've seen it downloading
two kernel trees but I haven't noticed a kernel build. Are the two compared
instances running through kvm?

Thanks.

> 
> > 
> > Thanks.

