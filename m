Return-Path: <linux-kernel+bounces-25638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2518D82D3E8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE0C281753
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 05:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A9A23CC;
	Mon, 15 Jan 2024 05:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iuFcPVHV"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A4B23A2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 05:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=a8eJsbheJU6scqYKXgbmKuumJ7y769XXTzVa2u6KpvY=; b=iuFcPVHV04VgxjcT/bKUAkywM/
	fk2+WWi+b0FiKCJzPBF8OpVMyDFQ3zt0sBD3SASAYvm8LHJXANNQzPqzW41l/dst3xfe/34xHbYVn
	MR76+UPoDPN8D11zoH/Ahalg9dlNFy05OHNOhLRvyWkRoDkkZH9cSAm2PalE95kgdHneYWJeDnR1c
	dcoMyzW4dutHFvlF90mbis5GHxL9ZzM2WwlmYxWoJCF2bIje+WCD1DAkwOYhBKrEHpYhjCPQKLN1h
	zuixT46XUuqVvxSiWBQTcL1pnbp1JxksNPo8kfus9Lt/5x3WXuA+foVF9Zi2O97u9P7tOVsMRMYps
	ATDvZPrA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPFeM-007o9K-0K;
	Mon, 15 Jan 2024 05:36:42 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	linux-arm-kernel@lists.infradead.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] clocksource: arm_global_timer: fix non-kernel-doc comment
Date: Sun, 14 Jan 2024 21:36:41 -0800
Message-ID: <20240115053641.29129-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a common C comment "/*" instead of a kernel-doc marker "/**"
to prevent kernel-doc warnings:

arm_global_timer.c:92: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * To ensure that updates to comparator value register do not set the
arm_global_timer.c:92: warning: missing initial short description on line:
 * To ensure that updates to comparator value register do not set the

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/clocksource/arm_global_timer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -88,7 +88,7 @@ static u64 gt_counter_read(void)
 	return _gt_counter_read();
 }
 
-/**
+/*
  * To ensure that updates to comparator value register do not set the
  * Interrupt Status Register proceed as follows:
  * 1. Clear the Comp Enable bit in the Timer Control Register.

