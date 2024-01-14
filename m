Return-Path: <linux-kernel+bounces-25390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D7F82CF83
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 04:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223D01C20E2F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 03:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3DE17CA;
	Sun, 14 Jan 2024 03:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CUWkaKpF"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032B210F1
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 03:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=8WcDrWhwyF6+0d50fMqI14ywgGdAPyrjYBJJv+Fsvu4=; b=CUWkaKpFqjOLPF3UQyWkiOJqMK
	cuLniWn9yh9uQsmMRvFy2owCA5PGiVeEPIX02pU4mk7Ux/0A+daKlfal3xSjKOyHJYjSuHnfmPiy/
	QbJGGO5FBbpMNCja616elWuAjcZJn1nGb+OzxGcQ+QScKDsMyCp/QX5ArnFI33JSTsUiyd6Irk6hD
	tyCDOr9RBw/sCktF48jdGM8qw4wJccvNoDSSoodVSTkD3KDnO/1KG2rUfS0VngoGy7lfzCaEkKAju
	DuQTRB7XnQImYVevkTVquPbx1Kfr9i+4wSCxzchTS1kmMMi7e2VEWaQfaQHtkYFGZ2jaSeXtmC1V4
	gMkdf2Lw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rOqpF-0066c9-16;
	Sun, 14 Jan 2024 03:06:17 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] cpu/hotplug: delete an extraneous kernel-doc description
Date: Sat, 13 Jan 2024 19:06:15 -0800
Message-ID: <20240114030615.30441-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct cpuhp_cpu_state has an extraneous kernel-doc comment for @cpu.
There is no struct member by that name, so remove the comment to
prevent the kernel-doc warning:

kernel/cpu.c:85: warning: Excess struct member 'cpu' description in 'cpuhp_cpu_state'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/cpu.c |    1 -
 1 file changed, 1 deletion(-)

diff -- a/kernel/cpu.c b/kernel/cpu.c
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -54,7 +54,6 @@
  * @rollback:	Perform a rollback
  * @single:	Single callback invocation
  * @bringup:	Single callback bringup or teardown selector
- * @cpu:	CPU number
  * @node:	Remote CPU node; for multi-instance, do a
  *		single entry callback for install/remove
  * @last:	For multi-instance rollback, remember how far we got

