Return-Path: <linux-kernel+bounces-35720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 369258395C0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59A05B2F303
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F054D81208;
	Tue, 23 Jan 2024 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WZNluWex";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mZRw/UG+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F626A01D;
	Tue, 23 Jan 2024 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028702; cv=none; b=XcLdh7gZTy7jpqHU7130mmBt2JYrGkae86HiqsNsI2NSt/4qXzoxHwJueBdL1tPL3jqnjaWyIrW+1V8NzHG3Ljzw4RSpVw+RnqAfY6ViRU9ByKquh7WTCFWtOdlVNFcwJZoVwwD8nADdOgGWOOUdkSf5D87hh6fOgvVtD3eoBwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028702; c=relaxed/simple;
	bh=k3bJeIIb5jdM0JrTRo4Y2HnZMCOTaMAv+5vtQS4HJlk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uOrsYELZcueLEuqTc7DkArbeJXDeV+ANnuicvXn2hgX0gYs4zuIqmSV2/XRQIuuE3YxqMkxMsl3vq+jLkRllVr1L2UYwAFIZnPwHe4NspGoNjYEMbxK5wzhqVXWEkLROfhYsCUZ3i8jRPK+LAxbFi+Ol+deEW6mFX4Mb0hsMTgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WZNluWex; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mZRw/UG+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 23 Jan 2024 17:51:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706028699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ypjlCiyqDBcFmHfRo5K26CO3Vwl7VLB/wa7hfqhAprw=;
	b=WZNluWexZk3v3SZmkkuisgc8BaO8N6uTafF5FN3hq78+7HbehZ+LYV/sK9ExX+9JB8cXMA
	hO4UmzSdNKZg0wkYSfBU1nWa0VZQhyVI/rOeZDR79eQmI3i4gc0d++PF8PXgXvee/GKq9k
	qiIiWWCs9Z0fFA+rr9c+yaOxukHTQYDCTaq+iCOEF2aKO+SfMRBQNP4TWTrxyIysZJRZS1
	O7XCYubSDiLYxvkt7MpYCZAae48I20xhrL3YgzE/Qjs5D0ofTmyQXgESF2udx0uZ0ek0zt
	hJNByTVVY6tsmyAbwadj3C8uUmRI3Z2kNXImVMOMNs0IzapvUcTlweLgdGR0dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706028699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ypjlCiyqDBcFmHfRo5K26CO3Vwl7VLB/wa7hfqhAprw=;
	b=mZRw/UG+mCnQAKsrhuipL7tpnNps9HnA9xbf3+U79hJP25maXZRaCWzwUeDvXdTOvJnE65
	Xf0+w1yq3kC5CXCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.8-rc1-rt1
Message-ID: <20240123165137.rezlkolk@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.8-rc1-rt1 patch set. 

Changes since v6.7-rt6

  - Rebase to v6.8-rc1.

Known issues
     Pierre Gondois reported crashes on ARM64 together with "rtla timerlat
     hist" as trigger. It is not yet understood. The report is at
	https://lore.kernel.org/70c08728-3d4f-47a6-8a3e-114e4877d120@arm.com

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.8-rc1-rt1

The RT patch against v6.8-rc1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.8/older/patch-6.8-rc1-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.8/older/patches-6.8-rc1-rt1.tar.xz

Sebastian

