Return-Path: <linux-kernel+bounces-29057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CEA8307BF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C5628777C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3CB21A12;
	Wed, 17 Jan 2024 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HqcdGwWN"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DC521A0B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705500907; cv=none; b=iPay2UUhqCEmxtKJqF/bffyNebxBbMygUIrxdpzTPkP1cuqZ2P7HGVBpYBwWrfDGMaHyd5ZgrDhWTd35/ptuW+s6MPxVYNmP9OmrCQQkjhNK+28srtiNCNFFzF93ByeiTIwEl0vUEvmfotNZEB8mud10s4+lhRyjxvghbIs/F3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705500907; c=relaxed/simple;
	bh=B31h2YlLbN3wj8fP+StJ7lB3iWgaiyRvRRL+nieP7ks=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version; b=uEFfgZht+CNUgkzl4e7TD/SYBasuxNbeBDt92AGhredwc3Pi/PgLZykntpvXX8+FZ8f3xtek86rc1b5OFHrDJg5pXqtHACigIZbYpalJG4poGo0FcC00j624uG13Um0UX5J/lKMqQZ1SZtP5+qY/63fpwTvJjzapUdFtfVgaDw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HqcdGwWN; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H8rSAI012703;
	Wed, 17 Jan 2024 06:14:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=m8HLnfWt5Utpa3bLN6g2+5kjNr5BHp8QTjpnSgMN27w=; b=Hqc
	dGwWNDmhvajA4RbAz8cKg/qpEQe8XOzV9ZJMP8s/8wN+5wjbr7ZVXBDglm0vSk6A
	GUkRINNiKGrPpNyHZYB5uHaMDS+uVySNArKJMmREhFsRRcp6aofHN99iOhp2jxbd
	Cm6nyR5AARY8vKJI6+cV7rVkBo0DHFJ9qhMQRoHiQ9nsJmEfM3VyEoa9845xaD/K
	+h4ErTulsEKleacw5WW2R7TLbhi9z5BYPjf+Eo0D2piUxV5ILdMRYhOhiCOEhOKP
	wbe6aO8NsnQT3B5KP1u5wMYKRwKUW6FsjES/XJNjj02yHS9YKurjTMtYQ6chkW4K
	Bo6/zMCl4A7H3VzPQrw==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vp0ge3937-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 06:14:40 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 17 Jan
 2024 06:14:38 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 17 Jan 2024 06:14:38 -0800
Received: from localhost.localdomain (unknown [10.28.36.167])
	by maili.marvell.com (Postfix) with ESMTP id 8B60E5B6933;
	Wed, 17 Jan 2024 06:14:35 -0800 (PST)
From: Amit Singh Tomar <amitsinght@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <james.morse@arm.com>,
        <gcherian@marvell.com>, <robh@kernel.org>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <jonathan.cameron@huawei.com>,
        Amit Singh Tomar <amitsinght@marvell.com>
Subject: [PATCH v1 07/14] fs/resctrl: Schemata write only for intended resource
Date: Wed, 17 Jan 2024 19:43:58 +0530
Message-ID: <20240117141405.3063506-8-amitsinght@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240117141405.3063506-1-amitsinght@marvell.com>
References: <20240117141405.3063506-1-amitsinght@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 8fM2urcjehga6paIeoziVV4rQ93g8m6D
X-Proofpoint-ORIG-GUID: 8fM2urcjehga6paIeoziVV4rQ93g8m6D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02

At present, schemata write (for Cache Portion Bit Map or Memory Bandwidth
Allocation) goes through list of all the resources (supported by schemata),
and regardless of write for one resource, it attempts to write for all other
resources.

As an example, When the intended write is for only MBA resource, it
attempts (by calling resctrl_arch_update_domains) to write for CPBM
as well. Fix it, by doing schemata write based on input schemata supplied
from user.

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
---
Changes since RFC:
                * No change, it's new patch.
---
 fs/resctrl/ctrlmondata.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 451cbb7357fb..78f9fb1c52fa 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -351,9 +351,11 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 		if (is_mba_sc(r))
 			continue;
 
-		ret = resctrl_arch_update_domains(r, rdtgrp->closid);
-		if (ret)
-			goto out;
+		if (!strcmp(resname, s->name)) {
+			ret = resctrl_arch_update_domains(r, rdtgrp->closid);
+			if (ret)
+				goto out;
+		}
 	}
 
 	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
-- 
2.25.1


