Return-Path: <linux-kernel+bounces-64408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76858853E62
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C408AB2934F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9321F634EB;
	Tue, 13 Feb 2024 21:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hFwIPqHd"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9FD69D00;
	Tue, 13 Feb 2024 21:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861550; cv=none; b=f6LkcAkr73xXd7di63hR+uJ2zhE3x6zi0LhBlegOjasuYjfN9YWac2aRMygkXnb+wvniEI0LjJN1BSp7RWBuJN6nAHOTMn7oTbd2O6eHMQxFJ5FWcdcLgR8WVWAqsOiJ4GHKovTTEsL0pCFGcXYS+Lfeief2wVvcWiAsxORIzYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861550; c=relaxed/simple;
	bh=JJZKe2t0kamyMzVROuPedbDxFm+zHMjxwqHfKjv86Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hNNx/AKoi6sNludGWLhIl+rJF7ZEZIkprNKtEAd3LJJvsCHg7Rb4ZSPKAZ0C6m9b9I2Qiuy8Q3ty2gGtoegGsrkkdFVSUaRrjSgpIX+WRC6IkDAoiAxttn98ei4rE5+k7y12cbbeyxsa0Lnm+CsjYeheuRA9FakQLOvp60SRxuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hFwIPqHd; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DL4fIu001929;
	Tue, 13 Feb 2024 21:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=ukCGGXI9Jxb1GstaggI2PMFSAmqWV+ZT0DPIrBgA8Ns=;
 b=hFwIPqHdkoDZYsVMHJ8zXgJ+TLgjlWOfxhztM+UJgYDB/AWOR/3a984ul5nwA8gnexMD
 i2V7x9UOLzu2YlSdaCrIH9yAZYVhuetntb8L1SNgT0bRzg9aLZ6Mwr5D0guvTNOudA+x
 KLXRDsLvFFFnEsrHxvZ5LGr6B4+jFRUu/i2Cd3rwZ/NskzqDODb5HID+pXZL7ryJ4m9f
 VVixqT6zm3xj70AINFvCMrEjhDlRvMkXBtLayIl7LXq1EX5gk+fG9NBUmer1bF3WPTrS
 kF3fRfvr/fZeyerU0eCJZO+rqqbCZL/2B8iGMaTBVKg+oDziNTRRhbiMtBRgtlApHTud Cg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8cxr8p2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 21:58:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41DLFAtr015276;
	Tue, 13 Feb 2024 21:58:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk80tj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 21:58:59 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41DLwwaX037838;
	Tue, 13 Feb 2024 21:58:58 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3w5yk80thj-1;
	Tue, 13 Feb 2024 21:58:58 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, jolsa@kernel.org
Cc: samasth.norway.ananda@oracle.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH ] perf daemon: Fix file leak in daemon_session__control
Date: Tue, 13 Feb 2024 13:58:57 -0800
Message-ID: <20240213215857.3081841-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_14,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130173
X-Proofpoint-GUID: UmyLGXzZ-iwIc4jmZcmbUW1efb5iKuvz
X-Proofpoint-ORIG-GUID: UmyLGXzZ-iwIc4jmZcmbUW1efb5iKuvz

The open() function returns -1 on error.
'control' and 'ack' both initialized with open() and further
validated with 'if' statement. 'if (!control)' would evaluate
to 'true' if returned value on error were '0' but it is actually '-1'.

Fixes: edcaa47958c7 ("perf daemon: Add 'ping' command")
Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
Found this error through static analysis. This has only been compile
tested.
---
 tools/perf/builtin-daemon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 83954af36753..de76bbc50bfb 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -523,7 +523,7 @@ static int daemon_session__control(struct daemon_session *session,
 		  session->base, SESSION_CONTROL);
 
 	control = open(control_path, O_WRONLY|O_NONBLOCK);
-	if (!control)
+	if (control < 0)
 		return -1;
 
 	if (do_ack) {
@@ -532,7 +532,7 @@ static int daemon_session__control(struct daemon_session *session,
 			  session->base, SESSION_ACK);
 
 		ack = open(ack_path, O_RDONLY, O_NONBLOCK);
-		if (!ack) {
+		if (ack < 0) {
 			close(control);
 			return -1;
 		}
-- 
2.42.0


