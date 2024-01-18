Return-Path: <linux-kernel+bounces-29941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8056983158D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F7F1F22248
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA241CFB7;
	Thu, 18 Jan 2024 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y0pcGrQY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2431B96A;
	Thu, 18 Jan 2024 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705569123; cv=none; b=RxvMxIly+otN/jghSqmBzDNmpSZQ7ziqYOBaKIzD8l5PNLuBZW3gnbgm0ilcjhE0fS9Mxvm4nh0zsTS1WfQiSUZ9Vmfc9k7BOHGWquO6wUEtZlxub+CwjY706vHrxT6mbg6hbzde7KkqCmIP3HSYDul3LiuJF+qktTy/tiJiqXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705569123; c=relaxed/simple;
	bh=ULtFfcGqT5XGv+KCHCFhylQch68gZp9QuOmFfi0jSLQ=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=MTHVjGtE2+5M/Y/DYEeEjCoDiYFdMfOtoec3uspIDxsUoSw56p/DmzLt9m6iIH0WJWJSIueWIFWYlOw9xfnGZd6t5b465VHMGXJLDYVWaYzcGN0jx8QZR0iMjajE0jb0mT+TlD8TX3PySMuy3LErZcWRfkbrOyKpgeVdKGFSFeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y0pcGrQY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40I5A2PR023821;
	Thu, 18 Jan 2024 09:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=RTeWeFc9BGldA+QSl7OVVIf82YSnY2lNKVdyeiEAse8=; b=Y0
	pcGrQYp7ulsvyE7dzdoMyrtf6XxSZF6DojEEWUHfImG6ODLef25vvXjHeiMK1wRA
	81Hj8JvXUKMcY2x/z0jjke2FHFrpS+R5soMRfcVxkVtEl9HBYwSTTpIhPyC5JvS/
	fg0GnBks7BEK7EElSNEakhjDEf5X1QqDfeeK1T6DRuchb99jTZxCAsZrerLTip29
	LNl585HzGQX6ksCdraLHSVP5c/IrqHgZ1bolSSSjwo8+8+jGa2cDyQz3umptI1ro
	6j9xiOIjX87V4Seo9Ql51E70OROLv22Kl63AetRANahxy5K30bW/2LkZJp3RllPn
	uw/vfTLevERyVpQFTL9Q==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vpkjrhrca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 09:11:59 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40I9Bw2r003203
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 09:11:58 GMT
Received: from hu-uaggarwa-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jan 2024 01:11:55 -0800
From: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        "Uttkarsh
 Aggarwal" <quic_uaggarwa@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v2] usb: dwc3: gadget: Fix NULL pointer dereference in dwc3_gadget_suspend
Date: Thu, 18 Jan 2024 14:41:46 +0530
Message-ID: <20240118091146.3101-1-quic_uaggarwa@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GjPwsHW9zhFdjMXcb2JDo2WNoI80MV2Z
X-Proofpoint-GUID: GjPwsHW9zhFdjMXcb2JDo2WNoI80MV2Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_04,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=1 phishscore=0
 lowpriorityscore=1 suspectscore=0 adultscore=0 impostorscore=0
 mlxlogscore=659 clxscore=1015 malwarescore=0 priorityscore=1501
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401180065

In current scenario if Plug-out and Plug-In performed continuously
there could be a chance while checking for dwc->gadget_driver in
dwc3_gadget_suspend, a NULL pointer dereference may occur.

Call Stack:

	CPU1:                           CPU2:
	gadget_unbind_driver            dwc3_suspend_common
	dw3_gadget_stop                 dwc3_gadget_suspend
                                        dwc3_disconnect_gadget

CPU1 basically clears the variable and CPU2 checks the variable.
Consider CPU1 is running and right before gadget_driver is cleared
and in parallel CPU2 executes dwc3_gadget_suspend where it finds
dwc->gadget_driver which is not NULL and resumes execution and then
CPU1 completes execution. CPU2 executes dwc3_disconnect_gadget where
it checks dwc->gadget_driver is already NULL because of which the
NULL pointer deference occur.

Cc: <stable@vger.kernel.org>
Fixes: 9772b47a4c291 ("usb: dwc3: gadget: Fix suspend/resume during device mode")
Signed-off-by: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
---

Changes in v2:
Added cc and fixes tag missing in v1.

Link to v1:
https://lore.kernel.org/linux-usb/0ef3fb11-a207-2db4-1714-b3bca2ce2cea@quicinc.com/T/#t

drivers/usb/dwc3/gadget.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 019368f8e9c4..564976b3e2b9 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4709,15 +4709,13 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	unsigned long flags;
 	int ret;
 
-	if (!dwc->gadget_driver)
-		return 0;
-
 	ret = dwc3_gadget_soft_disconnect(dwc);
 	if (ret)
 		goto err;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	dwc3_disconnect_gadget(dwc);
+	if (dwc->gadget_driver)
+		dwc3_disconnect_gadget(dwc);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
-- 
2.17.1


