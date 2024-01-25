Return-Path: <linux-kernel+bounces-38633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAEE83C373
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF631C23A7B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6D54F88E;
	Thu, 25 Jan 2024 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcOoxCBj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB674E1C6;
	Thu, 25 Jan 2024 13:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706188735; cv=none; b=HYvdVdkz14lXcUkOUNkf/sEP6gaCpWF4nIP2ybJ/HIifloeUPuScisTH8ZcWk4/KFz3F2U1l9usGXKH8qsp3DoT2tSVHvfIkEwDwue/hsd+vQgnJE88iiI5MV8ENYetxwy0PHMl8sPkad7ZZl1q3VTeR0cpXpimfCsbxBc+DOSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706188735; c=relaxed/simple;
	bh=bY17jvWnfeTpSntdXGaQifQf3sNAI7rGnIfhJ2qaRVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3a5Tmo8QECF+w7kvxzE9tZOvdkzwpA4OrXR72B0ewq54Z8Bh1Fbn/8F7l4Oe0gfWu+x/ArYUpX4sz2Y06Ff4RY35vDlzS2plrG7QhlAYgWKAVUCx5H4LZtDHu1a5IGVm43dqfs4/qrF991Y6q1ObFmDeOrinkYT2v/h9K2lgTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcOoxCBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DFCC433C7;
	Thu, 25 Jan 2024 13:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706188734;
	bh=bY17jvWnfeTpSntdXGaQifQf3sNAI7rGnIfhJ2qaRVg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=bcOoxCBjpc57KyQCJkqDE4FgvksiptVn/lDz/eZXgIyA2ceRpLduJwO6geyVUg27w
	 2j7AgwmO6z7idJAN6uePhJvH5cc07+nWtF5jGP6yFWozNTj9RVne1AzOgMfEB9h7vT
	 rk9X7vdF11wegR2tL51mk5LVCBJs4yrKCCjSniy6x18wEYAYk5n8mJ1l+inUthPjFm
	 3wQCWRkWIZiXYaaxQcQYOmgAyjmDJ2AQhe3MWclO6y/6r1wGmtGIrFzw+KZpbFjHWT
	 ppnOHRjXA1BMD0BgMPUQDkoDvM+S/FlZSemSsMVzYRi/bx/a4zOvYBXrR767NGYXda
	 QmbaNYNTBQgJA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 17BF0CE189D; Thu, 25 Jan 2024 05:18:54 -0800 (PST)
Date: Thu, 25 Jan 2024 05:18:54 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the rcu tree
Message-ID: <b4ae2b65-f297-429d-8456-9b9285a4d1de@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240125143332.70c0866a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125143332.70c0866a@canb.auug.org.au>

On Thu, Jan 25, 2024 at 02:33:32PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the rcu tree, today's linux-next build (htmldocs) produced
> this warning:
> 
> include/linux/hrtimer.h:199: warning: Function parameter or struct member 'online' not described in 'hrtimer_cpu_base'
> 
> Introduced by commit
> 
>   7525a3cbb106 ("hrtimer: Report offline hrtimer enqueue")

Apologies for the hassle, and please see the proposed fixup patch below.
Unless I hear otherwise, I will merge this into the original before the
likely start of your day.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 4f2cf7309486..991c83e929b4 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -151,6 +151,7 @@ enum  hrtimer_base_type {
  * @hang_detected:	The last hrtimer interrupt detected a hang
  * @softirq_activated:	displays, if the softirq is raised - update of softirq
  *			related settings is not required then.
+ * @online:		CPU is online from an hrtimers viewpoint
  * @nr_events:		Total number of hrtimer interrupt events
  * @nr_retries:		Total number of hrtimer interrupt retries
  * @nr_hangs:		Total number of hrtimer interrupt hangs

