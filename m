Return-Path: <linux-kernel+bounces-148785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452458A8763
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768161C21ACB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB341474DB;
	Wed, 17 Apr 2024 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="smpWUpLi"
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC6A146D5E;
	Wed, 17 Apr 2024 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367273; cv=none; b=YQ6YeDYlamBuoPlaIytlLERCk2wu/z3VP4vH/FTfndyFk8aSHIQiUYU1nTWK7GD1gtdgwvatTfvrX8iGhosPy4nfcTCDs580AUjNCkC9XyhMpLcd9pP5dxxC8XZWnDqwAJcxnW7cBeN5fEV0p4TOoAOwsJ5Z02PaQpcX3YHZk/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367273; c=relaxed/simple;
	bh=PnerTbnErOAt2o29eZggxHKphReZ65hZ65hSIZ9fBvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+6ujrxNCiPPu9KhWaATZYu6vRZEA6i/tt2kvZITLKjYWRaQriRhsZrCOnSXcjLPYyiYQJ6Zhnffhfb8WRRuvTAByfyCYjCJ4spD1kVG+UPVg6tF3PEL+EsAXp/wnXkJiPgUtZMQhO+jB8gpifZWM32UvZzj8Qd3hEKGNcmnVHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=smpWUpLi; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 26647DB260;
	Wed, 17 Apr 2024 17:13:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1713366781; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=PRwR5wEbdBvw9xklZXKKjy7Ww8IbSNYmDqokgFNljmw=;
	b=smpWUpLiEXgoXB7vEWfErSUMVb1flPcIGw1xDm9b5JhYVi4Ezw/dQi4dfjaJ3P8lPAeOFt
	YnywLpQNy/I0ryqOhjr5j62QTzsna96DcqMoN+ioUrxUFI1rF1Pq2t1MwvxTy2Kvt9d9qw
	TpZLCNV+/tb3nJvWwYRyzXAB4W7A3vBGMol/HnX2iFAsiEya7jgGIuDPo5tF5vXfnfpr2i
	0LC7AcWNxQFSI9/qrdDjxHMtFJFBPqgDLaavwO8hJ74LZfPToEaE4aXfsL3etzWBITWHAl
	fJCMwx/gSS18gCWMzAlbMSLJrJhZv36gzarh8ljOq92s3NRQNqX0bNtHENSCsg==
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>,
	 <linux-rt-users@vger.kernel.org>,
	 <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 1/1] Linux 4.19.312-rt134
Date: Wed, 17 Apr 2024 17:12:53 +0200
Message-ID: <20240417151253.16881-2-wagi@monom.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417151253.16881-1-wagi@monom.org>
References: <20240417151253.16881-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

v4.19.312-rt134-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index c2c7e0fb6685..6067da4c8c99 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt133
+-rt134
-- 
2.44.0


