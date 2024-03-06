Return-Path: <linux-kernel+bounces-94297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAD8873CB0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1D21F21DDB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CC9137C4E;
	Wed,  6 Mar 2024 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SRCOD/GS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kEIbJrkA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347D0136995;
	Wed,  6 Mar 2024 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709744088; cv=none; b=rfEwqX4WZh6p7zIWbujtTW/kxqrFYiaXAsHVELZN+J5uP2jD7GHYakcEhXrZB7CwyZu9y2pcd5PHBLZtpOxt13m25sl2OZIrREoQ8WADE6uq/taF5k4daM1vlH1VU1rXj16VEaj7u4iGXuWcl3s0yOEh/l4IoVVxaVzajkuAsE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709744088; c=relaxed/simple;
	bh=SzoK0Fw3umtF2LI2/KfCcWVLApBj6ZybhrvyoFVg85U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyOfHr5ElAT6ZsFeAK7m0xpMIqrbOM5/5ZVZAP0Q/7iRixwIh6zwXdNI/NBaSjwBdmUA/Z01C1bDZPHaSaS5xEAuKaPrQX+WJD2jvCqa3S3G60pP0lq/Td9mRJqiUKIWFVsadcuLiw3H3dPx/pwsJQlPclXz12OjWqx9wzTUWMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SRCOD/GS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kEIbJrkA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 6 Mar 2024 17:54:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709744085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SzoK0Fw3umtF2LI2/KfCcWVLApBj6ZybhrvyoFVg85U=;
	b=SRCOD/GSPjz1VFqxmztRkD9kmTvj+FnLQCGN3dmW8kMCM6rBAk3GzTl24Df+/vNGfTNWIF
	GIJuTdPYx4x5E5YYDAABtR06jRvShl5HmSMfMzslmf45pe68gsL6daIahK1Yfs2L+q6d+H
	xHBfc5ubfHsK1Ln7jQrFIL/1vDfP2iu5Gy2G7XhqxwIUaOgygGegosJEHBPhzsbtpWayue
	wLK0LIhgYKImMC3e3lf4/mxhkXszBPJvm4BH5HOduu/5sOFzm18rSGE2hr78Sw9A7sGjiF
	FEOfvMXOQz+ReBenspsds+G+pQ8exMFII8gW4fbxdIASzcgJJivCbKluydZr3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709744085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SzoK0Fw3umtF2LI2/KfCcWVLApBj6ZybhrvyoFVg85U=;
	b=kEIbJrkA4wW+QV7jKi44QsxBEyvS69z5PNbN23yP6TIApcmpoYG9VcEAw4poCS+02pemoW
	N89T/yyh6pNDfxCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mike Galbraith <efault@gmx.de>, Peter Zijlstra <peterz@infradead.org>,
	Marco Elver <elver@google.com>, linux-rt-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Alessandro Carminati <acarmina@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Artem Savkov <asavkov@redhat.com>
Subject: Re: 'perf test sigtrap' failing on PREEMPT_RT_FULL
Message-ID: <20240306165443.5AKJ403t@linutronix.de>
References: <ZdZOYnIkjqkyfo5P@x1>
 <ZeiZWjRUmXszp0CN@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZeiZWjRUmXszp0CN@x1>

On 2024-03-06 13:27:06 [-0300], Arnaldo Carvalho de Melo wrote:
> That its what introduces perf_pending_task(), I'm now unsure we can just
> disable migration, as event_sched_out() seems to require being called
> under a raw_spin_lock and that disables preemption...

Not sure what the best course of action is here but based on what I
learned last time you reported this I think we need delayed signals=E2=80=A6
Let me look into this. We had it and then removed it because we had no
users of it at some point but probably nobody took perf into account.

> - Arnaldo

Sebastian

