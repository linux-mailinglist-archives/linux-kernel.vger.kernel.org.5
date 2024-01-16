Return-Path: <linux-kernel+bounces-27583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D05082F27F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEB691F2466A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30081CA85;
	Tue, 16 Jan 2024 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWFoK4ab"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE081C69E;
	Tue, 16 Jan 2024 16:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929ABC433F1;
	Tue, 16 Jan 2024 16:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705423094;
	bh=gnfuR+CoEms4g+OOIQmvnFNkl/7dcAwNRub/zxCI31w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=bWFoK4ab+26RTuIGWUBQ6bFiN0bJ+DlKnyDP4+3lit9AadUNQB12cVI5NkgchXhb6
	 MJ8PixSlI8V0LVVOaHpz6YPumcGjXdx2xwbsJSZFgkQF1C9lmehm+zP+UgBFlB/WdI
	 Ap8SheGglv7MuYJm4FibU3bF8hGgbwlumP68fvCurEaqA18+b3K+afLo1Edl7qvMYR
	 iLGjkYDoFQUCgpqo0+uMcTmrmZ53KRI1pe+RgaDPR1dxeVBttU3A3gYK7z4mdt6XJ2
	 HZpdfv1JaAusRhH0Yps+eK65ojg1CVZKLYqDtVeIROes3KjPfB3F3S2ZUFO60lpHag
	 b+NZLuCvTlW7A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6EFACCE04A3; Tue, 16 Jan 2024 08:38:12 -0800 (PST)
Date: Tue, 16 Jan 2024 08:38:12 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/2] rcu/nocb cleanups
Message-ID: <938ff17b-f09e-4952-ae54-021a5db9423b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240109222401.28961-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109222401.28961-1-frederic@kernel.org>

On Tue, Jan 09, 2024 at 11:23:59PM +0100, Frederic Weisbecker wrote:
> Hi,
> 
> This is an excerpt from the "[PATCH 0/8 v2] rcu: Fix expedited GP
> deadlock (and cleanup some nocb stuff)" patchset with only nocb bits
> that were off-topic.
> 
> No change since their previous posting.

Hearing no objections, I have queued this for further review and
testing.

							Thanx, Paul

> Frederic Weisbecker (2):
>   rcu/nocb: Make IRQs disablement symmetric
>   rcu/nocb: Re-arrange call_rcu() NOCB specific code
> 
>  kernel/rcu/tree.c      | 47 +++++++++++++++++++++---------------------
>  kernel/rcu/tree.h      |  9 ++++----
>  kernel/rcu/tree_nocb.h | 38 +++++++++++++++++++++-------------
>  3 files changed, 51 insertions(+), 43 deletions(-)
> 
> -- 
> 2.43.0
> 

