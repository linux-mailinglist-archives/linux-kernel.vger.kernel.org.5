Return-Path: <linux-kernel+bounces-129835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1604897114
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46E4FB20DED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EB71487E3;
	Wed,  3 Apr 2024 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b="MNYYXbv/"
Received: from sender-of-o51.zoho.eu (sender-of-o51.zoho.eu [136.143.169.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAFA147C8C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150939; cv=pass; b=r/uJewssxmx1GfDvpVSPQnayMoUZma12rFdGeEyOOC4JHl8uGoTdaHpGsdBEdwiIRXnQyioTuO0LuAZpoZdBKOBJiOahh5Bl39ccmzbUo/tbYkEffJxwSpuVmap2koED4BPo1fi+lenBsEXjz80ULYK+wHQbBjKLuUSetwo+lAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150939; c=relaxed/simple;
	bh=HFBn8Va2EJRRaykJqU54uJ2V9festAwLtakbcR7l1cc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O0LzhTryOz/48X69iytx6LciS28decURUdaVA8nduCeFk+zFambuWzkF/PA8sMMklaNa6Z+Uf0F9xbGvsua9S5JWAnUn037sGYwDUvgoZu5SLgy/4AMMwHkm2Ehvx7XXLptToGPsetP1O0jxhv/Jf5AvoPtkfuvMCdYqkUTmemA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com; spf=pass smtp.mailfrom=bursov.com; dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b=MNYYXbv/; arc=pass smtp.client-ip=136.143.169.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bursov.com
Delivered-To: vitaly@bursov.com
ARC-Seal: i=1; a=rsa-sha256; t=1712150904; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=aWIrxTIW7F6b/pJERf47VnpgMm7j3CkLlArVoHatESuRZVQZvkzuJ9I2m/WXzli2OYuHP3ItVzuXX9gBmQMXzILK4ElaD6E8DhOnIJ6B9yLHVfAtYE+JKzaOEJYaUZdgA4geGyP7GbO8GLY0hB3KDq/rhKE2oXCPb0jAw2Ar+A4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1712150904; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=/G/nzSQ7kdwKRJT389pLw6gQqAhf/jq7kfm0Q/TR32c=; 
	b=Zl4CShTyJvq9plfA9Iz05KG+EPExeC3wNRm9y0EZ6Ef7LeGo1CpWovzygoJTPXNlSaJf7bxeelaUYfm225RRqhF7ADTnEKy0RmgqAtE8Mu7O2EDOhEtEUjHm1bgBCb9zbNZTakl/4VRH+AaYhPemgNiQuzbBJ9eLW6CJpBHJjwA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=bursov.com;
	spf=pass  smtp.mailfrom=vitaly@bursov.com;
	dmarc=pass header.from=<vitaly@bursov.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1712150904;
	s=zoho; d=bursov.com; i=vitaly@bursov.com;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To:Cc;
	bh=/G/nzSQ7kdwKRJT389pLw6gQqAhf/jq7kfm0Q/TR32c=;
	b=MNYYXbv/+MsnMTJuH2ezJ3BYpD9EcldGsHFsx7cc6GKxoa2kXWyatuLluzAVkPty
	arJFwflOZOiVxTo6PSJy+xg3A65yWU6Ahi7DcLmWkKhYMS6AE2FnZIPWQSnRmpP+kh/
	RvShgoHzNT6/raTj07xMc53zXN7PVwetPyRyfPq4=
Received: from localhost.localdomain (217.20.170.230 [217.20.170.230]) by mx.zoho.eu
	with SMTPS id 1712150902076254.87269508142435; Wed, 3 Apr 2024 15:28:22 +0200 (CEST)
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
Subject: [PATCH v3 2/3] sched/debug: dump domains' level
Date: Wed,  3 Apr 2024 16:28:05 +0300
Message-Id: <d9af90271748e6035c5f8bfc03b7bacdde357766.1712147341.git.vitaly@bursov.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1712147341.git.vitaly@bursov.com>
References: <cover.1712147341.git.vitaly@bursov.com>
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


