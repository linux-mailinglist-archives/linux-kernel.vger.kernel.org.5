Return-Path: <linux-kernel+bounces-76732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8173F85FBAD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38881C22F67
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C331487FB;
	Thu, 22 Feb 2024 14:57:36 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7483FE5D
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708613856; cv=none; b=iF8XJBfuo/428FhHxLGb+VufUjJpPdB82oo+eTKerEc5eHuBqpINJ6VOhXwLxIdKvCE+6Vl8weVQ4UHg9PD8hh3uiKyQFE3ZDyXrWonzAwarb+B0855MnsuccoivKm8DhTKNwZM3uHv0aPaQr0Uh0ITyJ5nmLmqzvdMMDYcHYxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708613856; c=relaxed/simple;
	bh=8sbuQCBjMjr/4bzz3ffyl08Qx1nuAMXfpHIFwg5NIx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWxN2INSqXs1VtehbCc9mpRy9F+ZVg1O2OK59ymR3SCPHCMDkX1p4r1pG2ZbjAAGJjv4DnIToLb0hQl6VPM0RsV7bLNh0tgRd5hOp3kR2negEqn2U75gaH+VXyaH86nVtwNUb1DCXl2TeZs6xOzHTuAVrNJuJIW390kYKQMoFfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18831C43399;
	Thu, 22 Feb 2024 14:57:33 +0000 (UTC)
Date: Thu, 22 Feb 2024 09:59:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Eric Dumazet <edumazet@google.com>, "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@infradead.org>, "Paul
 E . McKenney" <paulmck@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, Rik van Riel <riel@surriel.com>, Sebastian Siewior
 <bigeasy@linutronix.de>, Giovanni Gherdovich <ggherdovich@suse.cz>, Lukasz
 Luba <lukasz.luba@arm.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@intel.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH v11a 19/20] timer_migration: Add tracepoints
Message-ID: <20240222095924.733964db@gandalf.local.home>
In-Reply-To: <20240222103403.31923-1-anna-maria@linutronix.de>
References: <20240221090548.36600-20-anna-maria@linutronix.de>
	<20240222103403.31923-1-anna-maria@linutronix.de>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Feb 2024 11:34:03 +0100
Anna-Maria Behnsen <anna-maria@linutronix.de> wrote:

> The timer pull logic needs proper debugging aids. Add tracepoints so the
> hierarchical idle machinery can be diagnosed.
>=20
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
> v11a: Address Stevens review remarks

=46rom the tracing POV:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

