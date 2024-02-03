Return-Path: <linux-kernel+bounces-51286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4D48488BD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 21:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D772830CF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8417610A1B;
	Sat,  3 Feb 2024 20:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="N+U6LiGc"
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28CBF9DE;
	Sat,  3 Feb 2024 20:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706992893; cv=none; b=OiivZl2hXNx8Mj86tay+EoRI2Fp/t52gEMRFhaGMh18JVWH8A6Z4I1KeFWSW7j5Kw6Oe6j4V5eK0zdI1kV2cyrA1MhQqRYCG9k9fj2/YnGfS6jU935LhlrSl5I8o20EBaqrwZ0arToomPV3pepOEzXlg0UP1ectQmmK/mTzEYWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706992893; c=relaxed/simple;
	bh=G+Z8Tr/QMHEj0Lnb9zod1S1zRHM6gBHtCgLuFZk1iXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Are1hZMdAV0EkflR40vP3tKCss0w0LQGnODpi72pGyU976i7CoO2gils0JpvTlvtQZkpVwPXWYCVGIb6NAt9y+xSgAWLB1jNzQmcGQf622KVv63MnmN3bjkZgE0jjRJZkmHjtfJBvIOJc/J5LvpLorWwKym6DmIu9LlLZXFrNqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=N+U6LiGc; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id WMpJrXSMHJaAXWMpJrBska; Sat, 03 Feb 2024 21:41:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1706992887;
	bh=ciO9V5GhJU2uF2MVzi9ivsD5pJNMZDZsuri+PA9470I=;
	h=From:To:Cc:Subject:Date;
	b=N+U6LiGcCkVY2dNtmWpPacGMhsaYnmxkjNg+omS3Mz0cyFXZQlj4HPDqqFwAh7BoT
	 VAOU3Ap018R95HGxnXVjMJxE87iZvfuRIID65Ed6RKZTlx3meDNwdo2/CQGKyPBwFz
	 wisxoIDGsegc9EYBO7N0neLnebOg18o4EWrLn604Q21FzQObM0IUfdNPCA2dWkK2o2
	 1GbMLBWwykKM+Dzq9K4dlcB8aOCjQfMU7gpCaeaOjAJ+BiMBzYzKPNodo42B/jqU/U
	 Z5koaX55TKT2sINkIxVRMrr+vwWg6lyf/0g8L1QxSihm6nq+dtbTNYGDdvPq3r6D1M
	 j+P0/71lv5gpA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 03 Feb 2024 21:41:27 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] group_cpus: Remove #include <linux/kernel.h>
Date: Sat,  3 Feb 2024 21:41:19 +0100
Message-ID: <ae0ffde483285da96a78ef937580aaf5023e6304.1706992837.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to include <linux/kernel.h> here, so remove it.

All files that include <linux/group_cpus.h> also already include
<linux/kernel.h>, so this can't break anything.

These files are:
$ git grep group_cpus\\.h
MAINTAINERS:F:  include/linux/group_cpus.h
block/blk-mq-cpumap.c:#include <linux/group_cpus.h>
drivers/virtio/virtio_vdpa.c:#include <linux/group_cpus.h>
kernel/irq/affinity.c:#include <linux/group_cpus.h>
lib/group_cpus.c:#include <linux/group_cpus.h>
---
 include/linux/group_cpus.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/group_cpus.h b/include/linux/group_cpus.h
index e42807ec61f6..ecc4708dc468 100644
--- a/include/linux/group_cpus.h
+++ b/include/linux/group_cpus.h
@@ -6,7 +6,7 @@
 
 #ifndef __LINUX_GROUP_CPUS_H
 #define __LINUX_GROUP_CPUS_H
-#include <linux/kernel.h>
+
 #include <linux/cpu.h>
 
 struct cpumask *group_cpus_evenly(unsigned int numgrps);
-- 
2.43.0


