Return-Path: <linux-kernel+bounces-139271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4CB8A00C9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6582B1F225B4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C38181339;
	Wed, 10 Apr 2024 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tp03TWmJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JbvzwwGS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865D3180A8A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 19:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712778328; cv=none; b=el3r6N/izkgouDbDw2fuxzbGY/Z6CRH+krv+7QTJK29ak3oJ1ts9lzr7mNhQI70F9hx6HXLHHDV7cPDjyV/NiTBvT9GGsc597EcAhXbg7UbP+D/kg66FhrfuXVfWoVsOrYlFsIMqdqt/y165NeWQWyrSJ/uaNrIgC4RBeo+rWWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712778328; c=relaxed/simple;
	bh=BelLXsHnzBcl4pRFkjye7H4NG2rLu4vD1u9pdkB8Bx0=;
	h=Message-ID:From:To:Cc:In-Reply-To:References:Subject:Date; b=udiTzKu9J8ByWZFY7c5wh/ws24wVDbYNHFRVP5FWOqlcp78vwIbkw7Z7Y3UAuqG/GEOw9BSKu8YejqzqbkNkrp8BIK8Dm6D4Md2V8AgrJPw4NWEnkUccqDrn/jh/l/hSCqk9+doe/8xd0I0qQVwDWlZt7hmHKgyOafz5jeZK/Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tp03TWmJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JbvzwwGS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410194002.909839385@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712778326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=zXD3xkQMMp3nyR5N4kNRyu8kBxMNafMgulnNGUSs5NE=;
	b=Tp03TWmJUvWNrl3FCV2Da/FCijNPrcYk8nj4F3zI6okd4P17zroaCyNKL9w8TrnRXzk79L
	9EnLSlM9GNOaL2yK1zfjqs3ByALzieRfyo71Yl9wm9NUySc+1wVpDhSjz9erpGYrql4BSh
	Pj97uYL1BYDSwdqXaQxeuwsPTdK8+Bv2NG0gVrMi98W0P56uu69ANRMHJRDn0uq+ji+IE+
	5dNEi/m7HOkmp6YRfxgpssiEeZY0kC0/UJvgBrmWdIRQaH0V6zqDJVgWfKl8ix6pr5bpRf
	cQE3WBUXtXdNHt4Eek+Driq40mu7KQPAROmJb4jOfAl8OpaMZKJIDyoSWdoRxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712778326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=zXD3xkQMMp3nyR5N4kNRyu8kBxMNafMgulnNGUSs5NE=;
	b=JbvzwwGSfj0D0A2T4hE2Xz9HCTJbhjbWh1dDhZKjEd+Mldgsr31fKlS90A0iKhvSvBmmz3
	Uktydcr81dDEoDDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Laura Nao <laura.nao@collabora.com>,
 x86@kernel.org,
 kernel@collabora.com,
 regressions@leemhuis.info,
 regressions@lists.linux.dev
In-Reply-To: <87il0p2era.ffs@tglx>
References: <20240410161141.261818-1-laura.nao@collabora.com>
 <87il0p2era.ffs@tglx>
Subject: [patch 0/2] x86/cpu/amd: Fixup the topology rework fallout
Date: Wed, 10 Apr 2024 21:45:25 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Testing at Collabora unearthed two issues in the new AMD topology parser
code:

  1) The CPUID 0x80000008 parser initializes the wrong topology domain
     level.

  2) The NODEID_MSR parser uses bitfields in a union wrongly which results
     in reading out the wrong value and finally in a division by zero.

Many thanks to Laura for helping to debug this issue.

       tglx



