Return-Path: <linux-kernel+bounces-165966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F15018B93ED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6762840DE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071511CD2C;
	Thu,  2 May 2024 04:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oeIMWEPg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37D523A9;
	Thu,  2 May 2024 04:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714624897; cv=none; b=qV/WDbaVYpbfsdQhZHsFxsoiG/iDcAqyhs+YiCdRqG3AAAXQxxoAEB1D4G6vC8EgtimrEXafjYBpa7sAC7cAucpVCelmqGD2Pe1uB/7wh7YxUUvWZH8B0zzK+rfe+VfETWSLAGgHxXE9dLF+wcSfhPNjauyDDsCmV7yazj0xvVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714624897; c=relaxed/simple;
	bh=299mMI2LUjr+nObINO/jPTh23fQK8xv06dDMPbsZubw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eQd2EFWpqlIAgcAqBNTxrlM+6pK5Ch3nxIZQvkyfr4+gL/9WoqKZdTFtRhSAfZG4GnuTMb3yLP+h/7PTyOQMJ5SCoRJ6YWZQ8cRIToqH/+0ZjqcGWzFWajLhTH1q1dc7GKKbJU/ixnZ1g15x9MWFACVTzUqf5hKkwqj6BMVzNdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oeIMWEPg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4424MBr4013887;
	Thu, 2 May 2024 04:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=5zIIYEs
	h/B9NGyiwPUz3ttQWfA7ru763lpbdHrXzpVQ=; b=oeIMWEPgadSM+3gk4chOoyI
	Sk30WkFRUxHElL4lgX40lhC8DZpEB4qx3wcvt03GRX41etTIHJgnLY+0BDXoYT78
	bvD4yPqGxSC/sC4qWxL8xtafwJC+w//PkE0MSBtGVbYp1wZNbpU2+O4/DVhFLOUU
	3gKd7JOaWOmh+sG1r8HfO24eZVKTH0ehVNtQo2ctjXEBFqmvv5uMjTCEs+bbzZNn
	cqH3i1Fw7AchgYR6+r2QGMvWnyy7h09t5azl6EehyzfVXxgF3uc7CId6dvg6sQe/
	TUY/X6Y9AWCyeBMEqYPV3PF4ZyODgakyET2798pD2bYckXPWG9Wj4S4NfLLeinA=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xv01trah4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 04:41:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4424fV9Q024889
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 04:41:31 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 1 May 2024 21:41:28 -0700
From: Prashanth K <quic_prashk@quicinc.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Wesley Cheng <quic_wcheng@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, Prashanth K <quic_prashk@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v3] usb: dwc3: Wait unconditionally after issuing EndXfer command
Date: Thu, 2 May 2024 10:11:03 +0530
Message-ID: <20240502044103.1066350-1-quic_prashk@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iXvG1bllfJr-GaGeReu1yE6PRpcfmnbb
X-Proofpoint-GUID: iXvG1bllfJr-GaGeReu1yE6PRpcfmnbb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2405020022

Currently all controller IP/revisions except DWC3_usb3 >= 310a
wait 1ms unconditionally for ENDXFER completion when IOC is not
set. This is because DWC_usb3 controller revisions >= 3.10a
supports GUCTL2[14: Rst_actbitlater] bit which allows polling
CMDACT bit to know whether ENDXFER command is completed.

Consider a case where an IN request was queued, and parallelly
soft_disconnect was called (due to ffs_epfile_release). This
eventually calls stop_active_transfer with IOC cleared, hence
send_gadget_ep_cmd() skips waiting for CMDACT cleared during
EndXfer. For DWC3 controllers with revisions >= 310a, we don't
forcefully wait for 1ms either, and we proceed by unmapping the
requests. If ENDXFER didn't complete by this time, it leads to
SMMU faults since the controller would still be accessing those
requests.

Fix this by ensuring ENDXFER completion by adding 1ms delay in
__dwc3_stop_active_transfer() unconditionally.

Cc: <stable@vger.kernel.org>
Fixes: b353eb6dc285 ("usb: dwc3: gadget: Skip waiting for CMDACT cleared during endxfer")
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
Changes in v3:
Fixed build errors by removing unused variable 'dwc'.

Changes in v2:
Changed the patch logic from CMDACT polling to 1ms mdelay.
Updated subject and commit accordingly.
Link to v1: https://lore.kernel.org/all/20240422090539.3986723-1-quic_prashk@quicinc.com/

 drivers/usb/dwc3/gadget.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 4df2661f6675..140120953c76 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1699,7 +1699,6 @@ static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
  */
 static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt)
 {
-	struct dwc3 *dwc = dep->dwc;
 	struct dwc3_gadget_ep_cmd_params params;
 	u32 cmd;
 	int ret;
@@ -1724,8 +1723,7 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 	dep->resource_index = 0;
 
 	if (!interrupt) {
-		if (!DWC3_IP_IS(DWC3) || DWC3_VER_IS_PRIOR(DWC3, 310A))
-			mdelay(1);
+		mdelay(1);
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 	} else if (!ret) {
 		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
-- 
2.25.1


