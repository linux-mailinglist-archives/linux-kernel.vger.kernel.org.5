Return-Path: <linux-kernel+bounces-6967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C82B4819FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69598B25A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0C536AFE;
	Wed, 20 Dec 2023 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AovpgnEc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF287347B0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C7FC433C8;
	Wed, 20 Dec 2023 13:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703079312;
	bh=HrOmt2kvQ9It1H7pRVIbkEqO2iL/B/7VC6cApawHAoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AovpgnEc9px6j3AG1jgll0NnUYop9mP6KiSO7yVaH/AVLxHnSsxEyLlZBHsIKogHA
	 GIRz2Ybgw2eh8+WrzdqMRnq9eBoPUWlND+0kqNAqRbdxXyYC5zLBu5qRbLzSZ7SVhg
	 OOuOXdjInQai5SJAMU1G6Oc3/2mniukZF53frBpiynXMVh6ipc+OfvChJN6fIm12FX
	 GA66evDxo1AOWepot6nX+qUSZW5jW75rh32WNycUe+2Acvhp+v3Bi+Z0zXIJ0w1C+i
	 4LEpVddhUb7s1wb9ziX5UCaQJvgJjg1d9GFN9SLOJ+94rT2dTwPSUboTKCreu0ZEX5
	 NDx++gd2LGJTQ==
Date: Wed, 20 Dec 2023 14:35:08 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v9 04/32] tracing/timers: Enhance timer_start tracepoint
Message-ID: <ZYLtjPJZUPnrizu1@localhost.localdomain>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-5-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231201092654.34614-5-anna-maria@linutronix.de>

Le Fri, Dec 01, 2023 at 10:26:26AM +0100, Anna-Maria Behnsen a écrit :
> For starting a timer, the timer is enqueued into a bucket of the timer
> wheel. The bucket expiry is the defacto expiry of the timer but it is not
> equal the timer expiry because of increasing granularity when bucket is in
> a higher level of the wheel. To be able to figure out in a trace whether a
> timer expired in time or not, the bucket expiry time is required as well.
> 
> Add bucket expiry time to the timer_start tracepoint and thereby simplify
> the arguments.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

