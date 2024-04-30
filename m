Return-Path: <linux-kernel+bounces-164244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8C38B7B57
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1D21F2366B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1397914373F;
	Tue, 30 Apr 2024 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b="UMXp7fH5"
Received: from sender-of-o59.zoho.eu (sender11.zoho.eu [31.186.226.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF76152799
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=31.186.226.224
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490494; cv=pass; b=AO8e2WtNFcg4LM0gkLKEYLnnKLKMThD1d86caIlnqN5QSrG3lZ6dC+Supd7Gx1JhOtVS0c3MB5ffSHqSJUIxpNkmhpr3Co76iR3QoilkvlTgXt6WKygEBcxYXnnQ8xZ6JBuoPnzB0nx9EPWNoArEUIlSo6ZwIxswdUmCcr4K30E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490494; c=relaxed/simple;
	bh=4IYFvX1b6QiGO1/5J43up48bhB143WjpaEwFgfhwe+g=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oubppQ+lzkhJCI1gV4Jj9FmOEW/8OukQbbB6zIZJW7JrT/+9Ugk5EXLbigg+7bWkT+NNqepJ9/z2ZNPdVc2Nn+V2AKaHfmjEjukYw+FF3XJxrPhKoIH0c/OtZNuc1aV/HlUpPq1CcGJPyS2TekKIczQHs7ZqSdrlhds0Kn1M6WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com; spf=pass smtp.mailfrom=bursov.com; dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b=UMXp7fH5; arc=pass smtp.client-ip=31.186.226.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bursov.com
Delivered-To: vitaly@bursov.com
ARC-Seal: i=1; a=rsa-sha256; t=1714489544; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=cm2J7ndQWpQBVCAmMjSTdHEGpD5U2KQ494uFaRWe+YAg6TRMKnPS+IAchm5U/u/2ycTRzxcWFxaKdMy4fHRpGbEU3zTomzrXsW3XGQRKhe9pF5olq/lrKWu2W7Vl0Ydq1v9o+Zd6GufSUA6kd71JSJ2xsnjl9N99qPQ/hAxkleA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1714489544; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=CBC7Fu2NEYn+ls8avVIuRHKbqAbCU9lUfbYF3tRg4a4=; 
	b=egQd3tTOTxbnQcptSvE3r1c4rEYzNwSonXQCgWeZdV39LGy1dVNKSX5AWudfYiHK8NmEw+nkC/HfFUmgAI4j8pmPU19V0j9jCnwAeLal/Clirn1Jg0ywbOOQAZqB8SpiBxocDE2RZkh12mtB31ACeBUEapquj6iuhnSqmZ86Rhg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=bursov.com;
	spf=pass  smtp.mailfrom=vitaly@bursov.com;
	dmarc=pass header.from=<vitaly@bursov.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1714489544;
	s=zoho; d=bursov.com; i=vitaly@bursov.com;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To:Cc;
	bh=CBC7Fu2NEYn+ls8avVIuRHKbqAbCU9lUfbYF3tRg4a4=;
	b=UMXp7fH5CD1FKLNLyQC1ykBYfd809euR0k0MEbq0Wnk3xD1TDL7A8Zd0gOh4idyv
	vWOhxWvShVmxtF0cY/Nd12jr1nELESW8LpUJoDlGPd2D+Kug5UavN8cBFrI5bJnv1o5
	oX6YquuBj69M/wt78yAMTR3Df7dt7h7qa0vlMj9E=
Received: by mx.zoho.eu with SMTPS id 1714489540370440.6683863089778;
	Tue, 30 Apr 2024 17:05:40 +0200 (CEST)
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
	Vitalii Bursov <vitaly@bursov.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH v4 2/3] sched/debug: dump domains' level
Date: Tue, 30 Apr 2024 18:05:24 +0300
Message-Id: <9489b6475f6dd6fbc67c617752d4216fa094da53.1714488502.git.vitaly@bursov.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1714488502.git.vitaly@bursov.com>
References: <cover.1714488502.git.vitaly@bursov.com>
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

SDM macro is not used because sd->level is int and
it would hide the type mismatch between int and u32.

Signed-off-by: Vitalii Bursov <vitaly@bursov.com>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8d5d98a5834d..c1eb9a1afd13 100644
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


