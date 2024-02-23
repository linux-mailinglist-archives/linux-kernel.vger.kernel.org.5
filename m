Return-Path: <linux-kernel+bounces-78181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E52860FDF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494FB1C238E8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6FB6350B;
	Fri, 23 Feb 2024 10:54:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5F55D485;
	Fri, 23 Feb 2024 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708685675; cv=none; b=mXrVd7l7BkB9h9PqoLKic9xXXbGEulxBQqLxJd42mWLNP6IH3qbniEcxbuIf8OgZLsfyrwo+1/dWXkPyyxjvwOnFZJ9UqbqXQoQXY/nk3zcDTp6mUQ0tJHUM7flkRJqhxRBmix7eGMDvUKJ7Ip6y0vUDfr7GuROpNia+77y2AUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708685675; c=relaxed/simple;
	bh=9dVfvruGdbgHremfgUv+pqbA8QF04s4I7tA2NqshGxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZL87DyD6cXObvnHBLJGhxfAAKNFFgf+S2Bx5Rv55pFum3LZzxrp4x1Am++KSGpgDllF4/grdc9LaiK1ulwG4tATuItBdHEIfMlIQZzvERZ/vOI+sDsIF8Y9vRRCfCsHrF/OH/H1giUnAR57sSKW2VFsQfK/bXP9XQSWiJSf29yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E64B91596;
	Fri, 23 Feb 2024 02:55:10 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.66.180])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A6DE3F762;
	Fri, 23 Feb 2024 02:54:31 -0800 (PST)
Date: Fri, 23 Feb 2024 10:54:28 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, ankur.a.arora@oracle.com, tglx@linutronix.de
Subject: Re: [PATCH rcu 0/4] Refactor TASKS_RCU for lazy preemption
Message-ID: <Zdh5ZIboTTQJjG1i@FVFF77S0Q05N>
References: <8c938bd5-6d62-4eff-9289-13b0d7ae8e17@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c938bd5-6d62-4eff-9289-13b0d7ae8e17@paulmck-laptop>

On Thu, Feb 22, 2024 at 04:26:18PM -0800, Paul E. McKenney wrote:
> Hello!

Hi!

> This series refactors the NEED_TASKS_RCU option so that the conditional
> processing is in one place in kernel/rcu/Kconfig.  This makes it easier
> to make sure that Tasks RCU is enabled in PREEMPT_AUTO kernels, given
> that such kernels are preemptible, even if only lazily so.  After all,
> it takes only one lazy preemption from a trampoline to significantly
> degrade your kernel's actuarial statistics.
> 
> 1.	Create NEED_TASKS_RCU to factor out enablement logic.
> 
> 2.	Select new NEED_TASKS_RCU Kconfig option.
> 
> 3.	Select new NEED_TASKS_RCU Kconfig option.
> 
> 4.	Select new NEED_TASKS_RCU Kconfig option.

For the series:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

