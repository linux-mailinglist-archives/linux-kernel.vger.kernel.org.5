Return-Path: <linux-kernel+bounces-126114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3B289325B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7811C21BDF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BBC14882F;
	Sun, 31 Mar 2024 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b="r9VmLxBd"
Received: from sender-of-o51.zoho.eu (sender-of-o51.zoho.eu [136.143.169.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0947145B14
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711900949; cv=pass; b=pgLnE6Oh4/cdwtUmbXiG0TEtj2IkFSJ9eHgymftnwm3JWn7bxBn1vXRa32ZNCnazhHFA1KmXEUkHMCCgOShUB5M9BPMYBCMz7BXX0lcsmZissAj+detOD8b+EB8eSZQ2WWtBfRS1BU/+qH+pqHldmZ8JteJgSI359y0Omua9SSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711900949; c=relaxed/simple;
	bh=prLx6gsZJs5Wv0DMByRz8ryTqBfhCeklEU78XQxEff0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tCkOzkkP5C4nRD0sdE4svYWxVm38ehB5zfboC6D0po58eL1azhmkzDUdy9h/KwkCrjmLjoelCQT33wWECRzN5yVU4gfas7RsIXDHM/tbktKrM/u/blAauy0ihaLgdbw3bMuleC9LMk2Z3qP0FEcNGKLzBO6yIt6K1HEtmETypv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com; spf=pass smtp.mailfrom=bursov.com; dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b=r9VmLxBd; arc=pass smtp.client-ip=136.143.169.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bursov.com
Delivered-To: vitaly@bursov.com
ARC-Seal: i=1; a=rsa-sha256; t=1711900923; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ItdR4datuyeBHV9JGUunPjhdVKVQCHIsFAK7Nrx1erJ5kLFlZi5lZQOI59rDjIq+uaVNLi61wUhxtAzFsFJjvoqvbQ18A2Y1mCEhyz4X3yX733asrfJ8hOMbbxenSOdVcvCuIWbHKSZK1P7lIHmWT4+p7XvIzjhxu8It6ua5YAg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1711900923; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=C2WtKsBc1JRgHZZuJw4FpfBx5UPxzqv4dYWspQwk4eg=; 
	b=O6hccTJeyffTsk6vTPK+jJ3kTNekSZbcPMgPETjsarn4eZiXcVnTmI8soUl336Lc0qQZjGCl+cU1wZXYrRNHaUifsf1HuzzApXqfhCdF/cUxWbhT1q5eTYpnvL+ZpiFPgEXfNHcI+okwhDO1FsWCfoGAp/28t8b65R2/PgHF1AE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=bursov.com;
	spf=pass  smtp.mailfrom=vitaly@bursov.com;
	dmarc=pass header.from=<vitaly@bursov.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1711900923;
	s=zoho; d=bursov.com; i=vitaly@bursov.com;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To:Cc;
	bh=C2WtKsBc1JRgHZZuJw4FpfBx5UPxzqv4dYWspQwk4eg=;
	b=r9VmLxBd8T52cb+baTrmgZjatyjlD5DYNwjTWpylUMK/Emdc96BR1Gvs7QrGOUr3
	zKz903kpCZz23AjRF4HIwTqDXdLaH8zLTWYCDO048YcasdpWq4uhN6It/bG4chCclrq
	76fnOejsJ+S8D6h5GNf3LSgLq7hOmlR+ltDsCZvo=
Received: from localhost.localdomain (217.20.170.230 [217.20.170.230]) by mx.zoho.eu
	with SMTPS id 1711900921346329.18890410430356; Sun, 31 Mar 2024 18:02:01 +0200 (CEST)
From: Vitalii Bursov <vitaly@bursov.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Vitalii Bursov <vitaly@bursov.com>
Subject: [PATCH v2 2/3] sched/debug: dump domains' level
Date: Sun, 31 Mar 2024 19:01:48 +0300
Message-Id: <da9480a19fcc53e173b1ae83411aac2a730e3465.1711900396.git.vitaly@bursov.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1711900396.git.vitaly@bursov.com>
References: <cover.1711900396.git.vitaly@bursov.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Knowing domain's level exactly can be useful when setting
relax_domain_level or cpuset.sched_relax_domain_level

Usage:
cat /debug/sched/domains/cpu0/domain1/level
to dump cpu0 domain1's level.

Signed-off-by: Vitalii Bursov <vitaly@bursov.com>
---
 kernel/sched/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8d5d98a58..c1eb9a1af 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -425,6 +425,7 @@ static void register_sd(struct sched_domain *sd, struct dentry *parent)
 
 	debugfs_create_file("flags", 0444, parent, &sd->flags, &sd_flags_fops);
 	debugfs_create_file("groups_flags", 0444, parent, &sd->groups->flags, &sd_flags_fops);
+	debugfs_create_u32("level", 0444, parent, (u32 *)&sd->level);
 }
 
 void update_sched_domain_debugfs(void)
-- 
2.20.1


