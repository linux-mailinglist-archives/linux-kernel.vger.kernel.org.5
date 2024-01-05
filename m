Return-Path: <linux-kernel+bounces-17390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882DA824C97
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84562861D3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B19920EE;
	Fri,  5 Jan 2024 01:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="gU0PYQp3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DA81FC4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 01:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40519pIm014102;
	Thu, 4 Jan 2024 17:23:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=jXnuO7pvT8IjM1ReUpoLR5l/X1QPGje02s035718OYw=; b=
	gU0PYQp3jF3lH23CmjyaZs+SuEHvZSNDJOC1+VA64huH/midD47LO+LHyLMFXEuJ
	MFiVC8gl1xaSCzJSt2leKFPfrdv+bWDlSdOjfu/l0uUUXobvHlD1LfAVPfUr9FgH
	mPS1cdrRq7fVW0p4zavhMmjurFm6SLWNjp8kd91q8YNO73DrOfRiiKH1lll0fSpI
	KcTAg+RwAtl5UAROH7x3gyIn9maOGt2LURlHMKe4V6xUsdRuMt9goku2c0SexVdC
	gn8ts/j8bgRTkU3L7gzu5RxhcDbnYu5N5rCx/P0fqOjkJTSclPONva8AeXbo4atG
	RSbZQ6ZbFrv2gtNbjFOLdw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ve12t0dkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 04 Jan 2024 17:23:29 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 17:24:04 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 17:24:03 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+f9238a0a31f9b5603fef@syzkaller.appspotmail.com>
CC: <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [fs?] BUG: unable to handle kernel NULL pointer dereference in do_pagemap_scan
Date: Fri, 5 Jan 2024 09:23:26 +0800
Message-ID: <20240105012326.2516274-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000f52642060d4e3750@google.com>
References: <000000000000f52642060d4e3750@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: GREus9UWf3D7HzC6yqbjn7XB0MiII6aS
X-Proofpoint-ORIG-GUID: GREus9UWf3D7HzC6yqbjn7XB0MiII6aS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 mlxscore=0 suspectscore=0 bulkscore=0 mlxlogscore=848
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401050008

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 861deac3b092

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 435b61054b5b..f547057f096b 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2433,6 +2433,9 @@ static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
 
 	/* Protection change for the range is going to happen. */
 	if (p.arg.flags & PM_SCAN_WP_MATCHING) {
+		if (IS_ERR_OR_NULL(mm))
+			return -EINVAL;
+
 		mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA, 0,
 					mm, p.arg.start, p.arg.end);
 		mmu_notifier_invalidate_range_start(&range);

