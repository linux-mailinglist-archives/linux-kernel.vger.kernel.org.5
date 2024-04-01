Return-Path: <linux-kernel+bounces-127169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922808947AE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C407E1C21BC2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D23457300;
	Mon,  1 Apr 2024 23:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="fXYeJ9pj"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E124A56B89;
	Mon,  1 Apr 2024 23:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712013955; cv=none; b=UWUke6odxpbtc89Dc42w7pk7sbrlyOxdSouL3nNSRRu3KiJ7i9laV7iz5WeX1xJQKs8js/lir/Hq+gQayXJqsq6DPxycjemDO0LT+5mojRh4F9NramiA1cZR7O8jIEcpaOEM85+5+EuiqyFtLpfVSmFyejhtDEcZo6DuKq48yhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712013955; c=relaxed/simple;
	bh=6OmxJ/xi1QoJKbExnA/ZS2JoIjfcwBbOXlEN0cIRvmc=;
	h=From:Subject:Date:Message-ID:To; b=gQZ32GlwzdNZ7PURpR6dnlAGTPnkG1B/KX6fsYHtXd98BH7p4PMQ2p9g6L2Ihavkk5Dmaog8Ytwd4+ZhOBJYyfPxjm1mjEAmT1HIPfKElB4a8wW+wbHz0e2swtKotb0+H7nnkW5aW6ub77xhxZpkc6SQtI8gZ1Qehj9US6MKXq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=fXYeJ9pj; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from canonical.com (1.general.jsalisbury.us.vpn [10.172.66.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D20E83FE50;
	Mon,  1 Apr 2024 23:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712013945;
	bh=jG50dJ3zJpG9G2aF82/d1laDoH8jlfQ8avhPUxYUoHk=;
	h=From:Subject:Date:Message-ID:To;
	b=fXYeJ9pjgWWRZg6hy4RJgFQy3T9/tLWxmqKITP09ExJcHTbT08UeLZy3VkfP3dL+u
	 uqB8Pb495YcQqTQRQjxUYtgJeVPrVgWpd7ftbPDEVFORR2FdxWjwsQjKJ/x2JcuYkZ
	 VPBhcOOYmAClKL4ErcFANx5eAhHu30SRjmHRAl8vsegxE95gQ48ugqn2wK3jzdnrY6
	 FszgNOsgkgX0rY8sooiIWZucLybuK6h+QLzKkrZ9wb95U9Yi1gN4VKZ2fm/ME7O3sA
	 dMompmfaQfVuKbcN8a1eOOF0jNgshjXwOD/PazQ1TclsPua1WDBFtvmmt51mn5aWkp
	 yNqDIQZ7jUfsw==
From: Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [ANNOUNCE] 5.15.153-rt75
Date: Mon, 01 Apr 2024 19:36:14 -0000
Message-ID: <171200017428.328934.7030647013892748846@jupiter.home.arpa>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.153-rt75 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 07c40bd88823dc5320a6d32b8473cb8c85a91cd9

Or to build 5.15.153-rt75 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.153.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.153-rt75.patch.xz


Enjoy!
Joseph Salisbury

