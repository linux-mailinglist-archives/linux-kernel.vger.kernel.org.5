Return-Path: <linux-kernel+bounces-165850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF00D8B925F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E58A1C20D57
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9320D168B18;
	Wed,  1 May 2024 23:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O30NH25c"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BEA1581E3
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 23:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714606063; cv=none; b=iaPXev608Sa+1uhX2e28NRZDbJJyHaqmoSa2RoZApPAWaZ8akKLSQS+Mw+PV98vz1uLyOQHq5AYcGtjG4cFLb8QM/9hBSZoeAnBrDw6GgLW2aUXAbkLlopR1ChbXhyc/bGiBLOptl7uGceiyYObm57ng42LZ6C4orh4SDSulhso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714606063; c=relaxed/simple;
	bh=Vejiy+vf8zrb4REZkuafU7dlCh5bhHcQ7BKMFAFU0Eo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dcdBWYPUTO/WToW+wksYh/j1fKDH4mmdgmws7QCZAULlmK8BrNxKMp0is8XtnfOJeq3tPK1pinwFIs+LHfQuwHtfANjHV4w7wmujwjaD942OSZIiEJWo9ua0to5uO99sHSiq1KGKh2xLBUJj2RUx5hjHaxCIpIjTzCbV9JEJZC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O30NH25c; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 441MJoFZ018832;
	Wed, 1 May 2024 23:27:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=wY3UVMyMfxgmoJifRLcjAmBE75B0nsP3Ptes0P01A1M=;
 b=O30NH25cEiHmaQi1UYG/GI/J9vkfjdSG/p9zThfthrKfqpArV/XvmpJlQSzOC6Zu+XBn
 xH1usMXR+tIYLDXSYDtvLXksqQFvQRzk+0jvH3c0QsoIubAVPBo8sBnJrbrL6dgrzuX/
 H1d/VZImw3KYAraRssEdn515z8ouf6MLQ48AZtykRMb6S0WsUSvlklyQSlkq59del6QS
 CQxWa4qGwyY0v+m3KSb5qn8pQF8yq6eS21J1pb1m9qeP0VWax8QkxFn9ydAmNGX0QIzP
 d2gVRZWbmU+0R+uAQ1FNHT6uyCr15X5Nh7b6CaTF7AMUapMQGFeCROsBl3upOYn5/hKh 2Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqy31xa6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 23:27:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 441MBS4A033172;
	Wed, 1 May 2024 23:25:06 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xrqt9vbuq-2;
	Wed, 01 May 2024 23:25:06 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm/memory-failure: try to send SIGBUS even if unmap failed
Date: Wed,  1 May 2024 17:24:56 -0600
Message-Id: <20240501232458.3919593-2-jane.chu@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240501232458.3919593-1-jane.chu@oracle.com>
References: <20240501232458.3919593-1-jane.chu@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405010165
X-Proofpoint-ORIG-GUID: SNkRBuHMGLGZMo7XtV4v_r1aq305_slf
X-Proofpoint-GUID: SNkRBuHMGLGZMo7XtV4v_r1aq305_slf

For years when it comes down to kill a process due to hwpoison,
a SIGBUS is delivered only if unmap has been successful.
Otherwise, a SIGKILL is delivered. And the reason for that is
to prevent the involved process from accessing the hwpoisoned
page again.

Since then a lot has changed, a hwpoisoned page is marked and
upon being re-accessed, the process will be killed immediately.
So let's take out the '!unmap_success' factor and try to deliver
SIGBUS if possible.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 mm/memory-failure.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 9e62a00b46dd..7fcf182abb96 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -519,19 +519,14 @@ void add_to_kill_ksm(struct task_struct *tsk, struct page *p,
  * Also when FAIL is set do a force kill because something went
  * wrong earlier.
  */
-static void kill_procs(struct list_head *to_kill, int forcekill, bool fail,
+static void kill_procs(struct list_head *to_kill, int forcekill,
 		unsigned long pfn, int flags)
 {
 	struct to_kill *tk, *next;
 
 	list_for_each_entry_safe(tk, next, to_kill, nd) {
 		if (forcekill) {
-			/*
-			 * In case something went wrong with munmapping
-			 * make sure the process doesn't catch the
-			 * signal and then access the memory. Just kill it.
-			 */
-			if (fail || tk->addr == -EFAULT) {
+			if (tk->addr == -EFAULT) {
 				pr_err("%#lx: forcibly killing %s:%d because of failure to unmap corrupted page\n",
 				       pfn, tk->tsk->comm, tk->tsk->pid);
 				do_send_sig_info(SIGKILL, SEND_SIG_PRIV,
@@ -1666,7 +1661,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	 */
 	forcekill = PageDirty(hpage) || (flags & MF_MUST_KILL) ||
 		    !unmap_success;
-	kill_procs(&tokill, forcekill, !unmap_success, pfn, flags);
+	kill_procs(&tokill, forcekill, pfn, flags);
 
 	return unmap_success;
 }
@@ -1730,7 +1725,7 @@ static void unmap_and_kill(struct list_head *to_kill, unsigned long pfn,
 		unmap_mapping_range(mapping, start, size, 0);
 	}
 
-	kill_procs(to_kill, flags & MF_MUST_KILL, false, pfn, flags);
+	kill_procs(to_kill, flags & MF_MUST_KILL, pfn, flags);
 }
 
 /*
-- 
2.39.3


