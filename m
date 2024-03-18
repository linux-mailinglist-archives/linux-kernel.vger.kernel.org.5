Return-Path: <linux-kernel+bounces-105710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EDD87E346
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A56AB21C58
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 05:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78841219FC;
	Mon, 18 Mar 2024 05:39:02 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AC51E89E;
	Mon, 18 Mar 2024 05:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710740342; cv=none; b=szsTNYA7xWLkKx1tXShr6YKwKuRkGGqsZWozHAwPBSU8+a06INAbVjtdaZx87I2895E60LgKvYqxKJFsyJl/yMx9or3SC/6bRoSngM1rRoTiI7Mm4NY8Tpb51h3k6cAZ5BL0vmRiyWbs96saIKi6QCWuQDFOkD5fs1qaX5TU9Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710740342; c=relaxed/simple;
	bh=uP6yxOuhru5pk3+N7LmNlkupwHCliWC0SV3s4Ca7uWU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dRFfAv8NVU0R0Ol7wlK+nIibdzZ+TzsAd8EZwwtoKi/+dyuurxTwHR2s1BG3l8gTN3zW9mvFKFHWJ1HwifA0X43eGiFlEUUWB+UkwDmSezTJ000jwBjJcbPUUpa+2EPmaMPzUiIm4PBEr5W+nq6pqvCM8cZmSgjqr6bZhmwqBuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id OYD00038;
        Mon, 18 Mar 2024 13:37:38 +0800
Received: from localhost.localdomain (10.94.10.250) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2507.35; Mon, 18 Mar 2024 13:37:39 +0800
From: Deming Wang <wangdeming@inspur.com>
To: <hca@linux.ibm.com>, <"gor@linux.ibm.comagordeev"@linux.ibm.com>
CC: <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
	<linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Deming Wang
	<wangdeming@inspur.com>
Subject: [PATCH] s390/sthyi: remove the double word
Date: Mon, 18 Mar 2024 01:37:50 -0400
Message-ID: <20240318053750.2271-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2024318133738776d4deabf41f894d68768cd58e8d431
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Remove the repeat 'the' word.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 arch/s390/kernel/sthyi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/sthyi.c b/arch/s390/kernel/sthyi.c
index 30bb20461db4..77e08ab92568 100644
--- a/arch/s390/kernel/sthyi.c
+++ b/arch/s390/kernel/sthyi.c
@@ -250,7 +250,7 @@ static void fill_diag_mac(struct sthyi_sctns *sctns,
 	sctns->mac.infmval1 |= MAC_CNT_VLD;
 }
 
-/* Returns a pointer to the the next partition block. */
+/* Returns a pointer to the next partition block. */
 static struct diag204_x_part_block *lpar_cpu_inf(struct lpar_cpu_inf *part_inf,
 						 bool this_lpar,
 						 void *diag224_buf,
-- 
2.31.1


