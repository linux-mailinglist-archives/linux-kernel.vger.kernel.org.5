Return-Path: <linux-kernel+bounces-40696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABFF83E444
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3BA1C217DF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E0B24A1F;
	Fri, 26 Jan 2024 21:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="gpM0uc3O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O4j+p8Uk"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4374B1805E;
	Fri, 26 Jan 2024 21:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706305861; cv=none; b=Yn2tm53ZF6M/FdRI/8KGS/fE1dEtESqN4HKNoxNr2GcQnc56xXTNj7P45/kJcNGGGIuhHVn7ZS7KF2eQ1DSXxA39yRRerwLEnGf9Ls5iaw4qm3AxTQEDGgyoWTVdslQ7EW3Jt5YPovIDWkBZ+36CSDGrsQKx/5Hk8JAoEVvO5h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706305861; c=relaxed/simple;
	bh=vqep7A2H2pWb7M+ma9wdtMtXHgbcX9Rcbrz/UHi2wTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/FraVVXDapc6c+zyRmh+whrynkW6grI8S/HUVdhX70MwoOaF1Gz9KkJZDrHwanUXDKw5rTbtBq5Jk3QF65YWCLc4LvizSmXPGuv+dTrYB5ypCMGIn7IlNOY+2AHQFFFW3ilIshSNIv46dKTNmD5VB31nvmeSj0jkXOQG1K4j0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=gpM0uc3O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O4j+p8Uk; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 2D93A5C0405;
	Fri, 26 Jan 2024 16:50:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 26 Jan 2024 16:50:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706305858; x=1706392258; bh=NGC0calPRX
	G9G8v2vl/uD+clljhyU1eOEW+4oIbL1eQ=; b=gpM0uc3OnAwDPfdanyfjGONEAX
	OdL39IegO362vrWfQ/oInqLVgFDV+DnWBuKE1lBX9XxvzfdsbqSRLGa9rhJbQtkg
	ghbb2XadgLoOvJC3Z+1/dQbukUTniCrTSrT/B4aFf+kFJlK43BMDZcbGkSbgMGyn
	rBf2lwJAoQwn2wcmFvP4Ds64VFw+yUscTMJMhXEX63Mn/B8TUIDoYN0E+ShyZvUY
	H6z9efCTyp7oKZH0OMtPRsKccKMUFjG5e22AjHX3PRyk+JiucwltH0ms+ws7SHxH
	T3QLHb4bcDNm4o6G83M7F0LupAfHWgGahO6mA1wXlE9xc4K7SlhDqI0aA/Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706305858; x=1706392258; bh=NGC0calPRXG9G8v2vl/uD+clljhy
	U1eOEW+4oIbL1eQ=; b=O4j+p8UkzgqdPMSr19QLqixNGFUlK0lMXfAjuX4Q+MOd
	fL3HP/HQdmOXKEfyuS7v0WU+jjl/qN/ekY59X1FYjhmKDiYD7vukPB/LqS9tH5kq
	1D25yjPNeb3wvKg9If51uUufbEzsv+j4PgECwRRVYiaxKTIhzrqd7TsdsM0CfIgC
	m+6Emby+BtuCoNQ62+gJQaoEVOnzicKAja/a04/KJ78gd+OmqxFz/GzOVXPYeeOd
	ezWSpwh5D2gSgimL0EZlS8R5McGG6dlNpFBvCbBB2aUcJRjX4nHTamakY+n9w/Nu
	Lc4SXrXwQP+YrTEggazsGGk+BiR+WLvBdvIFZg7OAQ==
X-ME-Sender: <xms:QSm0ZbNqGfLRGReLYGpNHk435Haz2gQdIh5f79e407eyFRaKnzCHPA>
    <xme:QSm0ZV9cqcn5Z6FML-GH9GW8F909wIbrMUYpnBbTs7nVe-MWNMf01zIwUnMjY0qTt
    wRlze7-NhcliVuS9tg>
X-ME-Received: <xmr:QSm0ZaQGDodnG5kKFx_ngwTVVNuhrMZ2qSwve8PjNSXHN5Dya3GUE3bep7c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeljedgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefvhigt
    hhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtf
    frrghtthgvrhhnpeelffekveduvefftdejkefhtefhgeduhffghfejtdehieevjedtkeej
    veejkeeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:QSm0ZfuXA7e71T-SFCUl9WZD0Y2TY8hwl6CRueHvIP08NxEESXUxCQ>
    <xmx:QSm0ZTf8uihncGYdOYKa-rZrz9HtD9bHAqUQbxl7b7uChVh_bFqv7g>
    <xmx:QSm0Zb1p0QsQAauFfPdkyVi2bRQMlkP2wmmPBFZzm-J1o5XI3CTwTg>
    <xmx:Qim0ZUF4qxO_SuwvFW57J_L4iorz7O0VQ9WChVAbz8tgQIOKJYkjpw>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jan 2024 16:50:56 -0500 (EST)
Date: Fri, 26 Jan 2024 14:50:54 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <ZbQpPknTTCyiyxrP@tycho.pizza>
References: <20240123153452.170866-1-tycho@tycho.pizza>
 <20240123153452.170866-2-tycho@tycho.pizza>
 <20240123195608.GB9978@redhat.com>
 <ZbArN3EYRfhrNs3o@tycho.pizza>
 <20240125140830.GA5513@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125140830.GA5513@redhat.com>

Hi Oleg,

On Thu, Jan 25, 2024 at 03:08:31PM +0100, Oleg Nesterov wrote:
> What do you think?

Thank you, it passes all my tests.

> +	/* unnecessary if do_notify_parent() was already called,
> +	   we can do better */
> +	do_notify_pidfd(tsk);

"do better" here could be something like,

diff --git a/kernel/exit.c b/kernel/exit.c
index efe8f1d3a6af..7e545393f2f5 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -742,6 +742,7 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 	bool autoreap;
 	struct task_struct *p, *n;
 	LIST_HEAD(dead);
+	bool needs_notify = true;
 
 	write_lock_irq(&tasklist_lock);
 	forget_original_parent(tsk, &dead);
@@ -756,16 +757,21 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 				!ptrace_reparented(tsk) ?
 			tsk->exit_signal : SIGCHLD;
 		autoreap = do_notify_parent(tsk, sig);
+		needs_notify = false;
 	} else if (thread_group_leader(tsk)) {
-		autoreap = thread_group_empty(tsk) &&
-			do_notify_parent(tsk, tsk->exit_signal);
+		autoreap = false;
+		if (thread_group_empty(tsk)) {
+			autoreap = do_notify_parent(tsk, tsk->exit_signal);
+			needs_notify = false;
+		}
 	} else {
 		autoreap = true;
 	}
 
 	/* unnecessary if do_notify_parent() was already called,
 	   we can do better */
-	do_notify_pidfd(tsk);
+	if (needs_notify)
+		do_notify_pidfd(tsk);
 
 	if (autoreap) {
 		tsk->exit_state = EXIT_DEAD;


but even with that, there's other calls in the tree to
do_notify_parent() that might double notify.

This brings up another interesting behavior that I noticed while
testing this, if you do a poll() on pidfd, followed quickly by a
pidfd_getfd() on the same thread you just got an event on, you can
sometimes get an EBADF from __pidfd_fget() instead of the more
expected ESRCH higher up the stack.

I wonder if it makes sense to abuse ->f_flags to add a PIDFD_NOTIFIED?
Then we can refuse further pidfd syscall operations in a sane way, and
also "do better" above by checking this flag from do_pidfd_notify()
before doing it again?

Tycho

