Return-Path: <linux-kernel+bounces-84317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DBD86A4E3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8A281F278B4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71381C3E;
	Wed, 28 Feb 2024 01:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s38fWbvg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CFF4C81;
	Wed, 28 Feb 2024 01:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709083235; cv=none; b=BK4S08+md1JQoRShH7uXDU3WmqJ6pMoFz9lsrLdJ5NeTeCJUl1yi3YxGb1bRXQNFGxpruAE7FXZtOo/55KFlWB/hrtl58PDG/ZBY6j5zhKWHd0w3KiCkydCJ31N2z7gH0SXpmtp436amOhVICZKvGJ92BI/o1+IpuIbEr2+enQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709083235; c=relaxed/simple;
	bh=p42blfqp+LF2vrYwaNNmhZcdp50VSJg4XnVgPU0nQSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctixS8QzcnqpgR55PAxPuvZrBFfcjYYV602xWlfIgs3RPY/K0YeXaqUYizPcJBguVsgdrx8TFP/6TOVmTiqUSD8/DS0LV9gCzHGVDN7JwhneSJ+dK4XMlv5C2dKVbInsCMmAGLEIyLTzfroNJBCo6O60c3ovG6dFIlAHdyFi6Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s38fWbvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A428C43399;
	Wed, 28 Feb 2024 01:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709083234;
	bh=p42blfqp+LF2vrYwaNNmhZcdp50VSJg4XnVgPU0nQSc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=s38fWbvgq4T1e18j9P4oue1PBACWecYEF8j7BUFY7QJG/SOsP7WnRFbcew5r1U9Ir
	 Sips2ZAWPWiiC93/8EDzhJVhBadYmb3bzS8L6ijqPLvBY5HRLfyQlR0WwCCb23AWIV
	 Lq9812vQFsrcumy0I57tHL5Ommk7150qUJMUy+pQfoF1sUtjXvuYgs8YRccRSj8ZoX
	 q5WQBAZ9JJACQc1pjVZ/nciC718zs3hLqpM9SAK9U3W6IjJLj7kCypsLkP274n5ZvJ
	 q/G5JEllCNXlNgAiyTwYVcu/r5LgeL2UwRTLykom8RSj/7Gh3BLTHEoFSd6H5LcB3i
	 v+LBTRUcGa/mQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 259D5CE098C; Tue, 27 Feb 2024 17:20:34 -0800 (PST)
Date: Tue, 27 Feb 2024 17:20:34 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the rcu tree
Message-ID: <23c3ec9c-2b8d-4739-a7b4-f41c29f7d8d1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240228120610.0fdd20af@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228120610.0fdd20af@canb.auug.org.au>

On Wed, Feb 28, 2024 at 12:06:10PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the tip tree as a different commit
> (but the same patch):
> 
>   020eee167cca ("x86/nmi: Fix "in NMI handler" check")
> 
> This is commit
> 
>   d54e56f31a34 ("x86/nmi: Fix the inverse "in NMI handler" check")
> 
> in the tip tree.

Earlier today, I pulled it out of the range of -rcu patches that are
sent to -next.  If overnight testing goes well, you will not see the
copy from -rcu starting tomorrow.

Thank you for calling it out, though!

							Thanx, Paul

