Return-Path: <linux-kernel+bounces-64604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6BC8540C7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA881C2684F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D197800;
	Wed, 14 Feb 2024 00:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="YBHSZrOm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T9PAm2m+"
Received: from wflow7-smtp.messagingengine.com (wflow7-smtp.messagingengine.com [64.147.123.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D55A191;
	Wed, 14 Feb 2024 00:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707869892; cv=none; b=gLQemPv5Yn3JBSqvhFGHW15Uh57fDWTXGiRB0b3NcyDrVmYSYpdkzAoO3UmCRMCcdGVMrnqa4ADcDBM6q3x/nUkPS37YeZedsZdIEMA6SZuYw0g0PqaqA6BpaKEsscDisQYuDdMKfwuJacZw0Ai0Uln1n8l9OkufQ6UdbWca6ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707869892; c=relaxed/simple;
	bh=gEf+mkmtwOGXura5Rt/DicCA9CrNFAQFmPRLVIIUT6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMw8DpqyVOCtXz3SwU7ewK1VibLBuswjuJ1qNPf/HDQxjt5DVPTXXjqUKdBe3cCYnDpqjjTTKFmNaLS6QZlPoCWKkmTw0t0gW7sUF9hCjMXqavimeDVuso3lo0FszgJM5ovAptE3zTTqPjMgnp0WgljOTC0Fec1yc1LRWRczLr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=YBHSZrOm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T9PAm2m+; arc=none smtp.client-ip=64.147.123.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailflow.west.internal (Postfix) with ESMTP id 951832CC0489;
	Tue, 13 Feb 2024 19:18:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 13 Feb 2024 19:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1707869887; x=1707877087; bh=+YWq+i5wkg
	LUyMl08epmILv+GcdTX//gtb/mupi/CfA=; b=YBHSZrOmvx6+CcLrFo4GSsKEJp
	gYRIU2YOOAfK/RfQBK+Kq1R4BpofODQ108VkVwJ/LJJ93gRD2uJN7K7t+/Msrtgk
	0gKVBbqs1YHRKhCO/5q3KUR3c/kb5eZX1QusyUcT9Q6eWBks5zO2VdDmG0cSZusA
	yBguFhzrl2F4aLgWWB9IsEA7A/nsQLuCs4zwXhK/hhGNiNBoDXEuayy2dGEGs0g+
	BFMqutX51g3c/HM/9+/nsuZKMOhnKVF11/aWTc6I59D3/UpkCx9HBF/LtCCElZ9M
	xnDLZoSq4HPd2x0rx6NWlrpOFZp7+CQmcyU7ilnTWmjLMQXmsRd4dnDweesg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707869887; x=1707877087; bh=+YWq+i5wkgLUyMl08epmILv+GcdT
	X//gtb/mupi/CfA=; b=T9PAm2m+adehj020mz5sR7uTZydpYbiI9iATyNzY6cza
	C7vQTlD+UX6kCZ6AThUb4IWG76SVdZc/R5/XZGvzwFEld85CYyym/z96V/ds/Qt9
	0S64IbLTUlhGjP9O4W/N25OqXApifx3e+SbIaRvA73sBUO1S8vp4F/V27kety90B
	ko27YzD8y3NW9IMxkdrnJ5RKTIG6HTzX588wURXkZmje57NPjGaDIDZHyY8eJnx6
	jcXogG7sueI8rr/6CUJYd5ko9SFM8CIbTTQqVQFGaJ+UKokNZUYbHCWTOh+w6yzd
	ascXflD6S2c6EpbY8XeolsZdm55i5R23HS5sBLY8/A==
X-ME-Sender: <xms:vgbMZch1IAdnL0dgQHNZ6-1lqe3RRsMXCgzMcsww43kfPpdea__EjA>
    <xme:vgbMZVDy-X5mJwkQKPc4_DOjT0Z-08ZIm45yIUYajYmm9c4urwxzNBAQWCwE2Yf-6
    cBchoc0YUkZ3qg1eug>
X-ME-Received: <xmr:vgbMZUFkQFkX2qI5cHyFpgMCo-L1K82uLQc_9scDZScAR77CV-JNLXxaDcs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeigddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeevkefhudeffeetgeeggfevvdeuueefueegueeghffffedulefggfetieel
    iedutdenucffohhmrghinheptghovhgvrhhithihrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthihtghhohesthihtghhohdrphhi
    iiiirg
X-ME-Proxy: <xmx:vgbMZdSBTOmiwn0hCO6_Hs260tMk7exTnodgg9C5_qJ4ZvRybYAxyA>
    <xmx:vgbMZZyD69W23Gk2t7gGfQs_6TN4CXt92brQq9raeY766Ffmtw5fGw>
    <xmx:vgbMZb7NO8pU7mdSO1WWghxEqzVcZeOwirIgHT7Ad0SOSQOjwJQ0gQ>
    <xmx:vwbMZez0Lzk2Vsjvp2O799s8CEOzPlAvzX0sE9cEulMWVQu_gk7km4K-zzV3zzTx>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Feb 2024 19:18:03 -0500 (EST)
Date: Tue, 13 Feb 2024 17:18:01 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: coverity-bot <keescook@chromium.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Tycho Andersen <tandersen@netflix.com>,
	Mike Christie <michael.christie@oracle.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: __do_sys_pidfd_send_signal(): UNINIT
Message-ID: <ZcwGua3a9Z8nJXVq@tycho.pizza>
References: <202402131559.B76A34B@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402131559.B76A34B@keescook>

On Tue, Feb 13, 2024 at 03:59:37PM -0800, coverity-bot wrote:
> Hello!
> 
> This is an experimental semi-automated report about issues detected by
> Coverity from a scan of next-20240213 as part of the linux-next scan project:
> https://scan.coverity.com/projects/linux-next-weekly-scan
> 
> You're getting this email because you were associated with the identified
> lines of code (noted below) that were touched by commits:
> 
>   Sat Feb 10 22:37:25 2024 +0100
>     3f643cd23510 ("pidfd: allow to override signal scope in pidfd_send_signal()")
>   Sat Feb 10 22:37:23 2024 +0100
>     81b9d8ac0640 ("pidfd: change pidfd_send_signal() to respect PIDFD_THREAD")
> 
> Coverity reported the following:
> 
> *** CID 1583637:    (UNINIT)
> kernel/signal.c:3963 in __do_sys_pidfd_send_signal()
> 3957     		/* Only allow sending arbitrary signals to yourself. */
> 3958     		ret = -EPERM;
> 3959     		if ((task_pid(current) != pid) &&
> 3960     		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
> 3961     			goto err;
> 3962     	} else {
> vvv     CID 1583637:    (UNINIT)
> vvv     Using uninitialized value "type" when calling "prepare_kill_siginfo".
> 3963     		prepare_kill_siginfo(sig, &kinfo, type);
> 3964     	}
> 3965
> 3966     	if (type == PIDTYPE_PGID)
> 3967     		ret = kill_pgrp_info(sig, &kinfo, pid);
> 3968     	else
> kernel/signal.c:3966 in __do_sys_pidfd_send_signal()
> 3960     		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
> 3961     			goto err;
> 3962     	} else {
> 3963     		prepare_kill_siginfo(sig, &kinfo, type);
> 3964     	}
> 3965
> vvv     CID 1583637:    (UNINIT)
> vvv     Using uninitialized value "type".
> 3966     	if (type == PIDTYPE_PGID)
> 3967     		ret = kill_pgrp_info(sig, &kinfo, pid);
> 3968     	else
> 3969     		ret = kill_pid_info_type(sig, &kinfo, pid, type);
> 3970     err:
> 3971     	fdput(f);
> 
> If this is a false positive, please let us know so we can mark it as
> such, or teach the Coverity rules to be smarter. If not, please make
> sure fixes get into linux-next. :) For patches fixing this, please
> include these lines (but double-check the "Fixes" first):

I think this is a false positive, we have:

        /* Enforce flags be set to 0 until we add an extension. */
        if (flags & ~PIDFD_SEND_SIGNAL_FLAGS)
                return -EINVAL;

        /* Ensure that only a single signal scope determining flag is set. */
        if (hweight32(flags & PIDFD_SEND_SIGNAL_FLAGS) > 1)
                return -EINVAL;

which should enforce that at most one bit is set, and there's a case
statement for each of these bits in the later switch,

        switch (flags) {
        case 0:
                /* Infer scope from the type of pidfd. */
                if (f.file->f_flags & PIDFD_THREAD)
                        type = PIDTYPE_PID;
                else
                        type = PIDTYPE_TGID;
                break;
        case PIDFD_SIGNAL_THREAD:
                type = PIDTYPE_PID;
                break;
        case PIDFD_SIGNAL_THREAD_GROUP:
                type = PIDTYPE_TGID;
                break;
        case PIDFD_SIGNAL_PROCESS_GROUP:
                type = PIDTYPE_PGID;
                break;
        }

That said, a default case wouldn't hurt, and we should fix the first
comment anyways, since now we have extensions.

I'm happy to send a patch or maybe it's better for Christian to fix it
in-tree.

Tycho

