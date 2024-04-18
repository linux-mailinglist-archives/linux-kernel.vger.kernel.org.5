Return-Path: <linux-kernel+bounces-150169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E358A9B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BFCD1C21D27
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4752315FD11;
	Thu, 18 Apr 2024 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SgP7+cyG"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DC71E4AD;
	Thu, 18 Apr 2024 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446906; cv=none; b=R/k8je7uEoHLazhZiBDysTYzWLFZKWbHNBqK3voRV2/jXgzXs1ZiiV+pSiWzPYkl03nhiwjPZAOCwcA3OointDT3dJVo4udYs5H5Tar8c2UduFFF8k2PCGiEYvgOCuI0JryTPuuYEE8UEta4sN7lf45a5wRQIpLqfkeMgzSRPis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446906; c=relaxed/simple;
	bh=15LPlCyRM81vOGjzDxrl6KXHOHp5iqRPEIb9hDh66tU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hh3QBq9MzcB0NM3qWTB6m5ue01yuA+F+XteRaTfnY7K9DHPKpVzXZ0ifFX+5cHC+1tLhuX+CrSWAfMmOsULFnzL9JR74/AYKuxqgGTIo0/b7Xzistiq2FXpS0L7il2ok4xaMH+i/HPM6EGqoGumowOZe0LztRMwi59RtqK0jq/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SgP7+cyG; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43ICItAm016003;
	Thu, 18 Apr 2024 13:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=/rQLjm77xGR+HZhohR1S8rUegbh2eDq/nXt99qYuhCo=;
 b=SgP7+cyG+MSVKUL0DW5IHlD5PlpRhryMrsQhnunJqiDNzNaxtgSPOTz6k5qUUHNOcJIg
 gWbnvl1AmnQ6hwBteREXPyLdhD0HQonmHUKeYNGTBEq1Q8E/2f42ZrFsFB60GtK+ibJC
 BwhZvFUpR2bLX1Awy7Ht4zaTzTtlHmVy+npC5ostl2at8L6VhogjBpbd8J3IDSQwCrRx
 XXX9pVb6nEKR3X4zYD5Hs6zZPrPtdsqoBcqgayvMF2T7LqVbCOmf5V6kmLX9vWN5bRom
 OP7DhNypfwr6rFv70QXaocLuDTaJcmKUzp5sZOzrfsz1FBe6NCQQpSE54PWoYpDm/bQE qw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgujtmq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 13:28:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43IC0h1c004339;
	Thu, 18 Apr 2024 13:28:18 GMT
Received: from localhost.uk.oracle.com (dhcp-10-175-207-172.vpn.oracle.com [10.175.207.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xfgggp2x3-1;
	Thu, 18 Apr 2024 13:28:17 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, stable@kernel.org
Subject: [PATCH] Revert "tracing/trigger: Fix to return error if failed to alloc snapshot"
Date: Thu, 18 Apr 2024 18:58:06 +0530
Message-ID: <20240418132806.159307-1-siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_11,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404180096
X-Proofpoint-ORIG-GUID: Wapcbe12npm_BidS0zFgRethTNsYNxOn
X-Proofpoint-GUID: Wapcbe12npm_BidS0zFgRethTNsYNxOn

This reverts commit b5085b5ac1d96ea2a8a6240f869655176ce44197.

The change has an incorrect assumption about the return value because
in the current stable trees for versions 5.15 and before, the following
commit responsible for making 0 a success value is not present:
b8cc44a4d3c1 ("tracing: Remove logic for registering multiple event triggers at a time")

The return value should be 0 on failure in the current tree, because in
the functions event_trigger_callback() and event_enable_trigger_func(),
we have:

	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
	/*
	 * The above returns on success the # of functions enabled,
	 * but if it didn't find any functions it returns zero.
	 * Consider no functions a failure too.
	 */
	if (!ret) {
		ret = -ENOENT;

Cc: stable@kernel.org # 5.15, 5.10, 5.4, 4.19
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 kernel/trace/trace_events_trigger.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index dfdbcf1da216..106f9813841a 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1161,10 +1161,8 @@ register_snapshot_trigger(char *glob, struct event_trigger_ops *ops,
 			  struct event_trigger_data *data,
 			  struct trace_event_file *file)
 {
-	int ret = tracing_alloc_snapshot_instance(file->tr);
-
-	if (ret < 0)
-		return ret;
+	if (tracing_alloc_snapshot_instance(file->tr) != 0)
+		return 0;
 
 	return register_trigger(glob, ops, data, file);
 }
-- 
2.43.0


