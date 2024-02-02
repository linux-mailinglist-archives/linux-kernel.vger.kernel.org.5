Return-Path: <linux-kernel+bounces-49292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0F2846847
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496AE1C21ABF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0999481A7;
	Fri,  2 Feb 2024 06:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YWCb/Qxe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C6547A76;
	Fri,  2 Feb 2024 06:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856086; cv=none; b=CRTuxeOjrA1oHkIynJlZhRS2mufLJ3YQMcEh4Xnq9YgME7GUiBJl3++eUFxrnyHL6Df65zTtV50oZ9Uz+yvaYXXxZpueSVtyrq7ZLHfvNCovIDT1L3QLd9gMkVpo4vLlZB32z7tfQN6JyPa8gELSGZJz723geO+EZAR5kSbB9xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856086; c=relaxed/simple;
	bh=qbNEGZz2C4Gx3HMPisN75TK8yz+GYjwi6ez/CMvVt6o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mDHiDsUhVpF6cBTfHm7ZaurNfdVWXhE+M78QSdZV16AOJk4lMysLiHZ3XrLQBYSJ2pmdex7sV7l4sj3ALdJjpNTfTkO8e/Yx1zvZ3konH+x52pyBaQXmDK1rxuKXUZwqo2+eHps0OUJykqk1jcShyBNi+eE9OBVcEECtTcFXVMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YWCb/Qxe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4126A0IY017772;
	Fri, 2 Feb 2024 06:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=LCXm5lUyxmruJ09/Ia5z
	NnoeixYPjyKFDjc2aPuwBcM=; b=YWCb/QxeUO512bf1XYcGTvzSUUY8dVYr+uEW
	hJALsDgpmO5pdjsQZlf+ipIiXg/8jCUdNQANSX/bbMu2UEVaEKUuIeNs1PO+u8ff
	MN+hflJj8dZAWgBQ1kn0dho+8o0YXjgCTTpPUSsxHHCp2OfAlVOxCDMa12ubXESX
	7fUiidjoF8U3ODsjsDgc69kzZmkzv5LuuwjKsx8bs4D6xTng0oE2GdaaLUGtslZt
	fWOra5AgQciKjipfgwjQySESr+cxqPONX0JLclxcyh1LBYx4S5evTWScP6jqnr4v
	BJGqW2kfmP552X+Q+FcGaDoLX6WXzeobCpoGex1I4xozbPVfjA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0ptxgnpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 06:41:22 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4126fLfE002710
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 06:41:21 GMT
Received: from hu-ekangupt-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 22:41:19 -0800
From: Ekansh Gupta <quic_ekangupt@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 15/16] misc: fastrpc: Restrict untrusted apk to spawn privileged PD
Date: Fri, 2 Feb 2024 12:10:38 +0530
Message-ID: <20240202064039.15505-16-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20240202064039.15505-1-quic_ekangupt@quicinc.com>
References: <20240202064039.15505-1-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -YarlE4HGTE6R_7E4QvVLmPChXBLSlkc
X-Proofpoint-GUID: -YarlE4HGTE6R_7E4QvVLmPChXBLSlkc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 suspectscore=0 mlxlogscore=581 mlxscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020047

Untrusted application can attach to guestOS and staticPD if it can
make root PD, sensors PD or audio PD attach request. This is a
potential security issue as the untrusted application can crash
rootPD or staticPD. Restrict attach to guestOS or staticPD request
if request is being made using non-secure device node.

Also for untrusted dynamic processes, DSP HAL process opens the
device node on behalf of the application. Add a check to restrict
such untrusted applications from offloading to signed PD.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 0308f717456f..4aa4e36bebc3 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -471,6 +471,7 @@ struct fastrpc_user {
 	bool sharedcb;
 	/* If set, threads will poll for DSP response instead of glink wait */
 	bool poll_mode;
+	bool untrusted_process;
 	char *servloc_name;
 	/* Lock for lists */
 	spinlock_t lock;
@@ -1722,20 +1723,24 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 
 static bool is_session_rejected(struct fastrpc_user *fl, bool unsigned_pd_request)
 {
-	/* Check if the device node is non-secure and channel is secure*/
+	/* Check if the device node is non-secure and channel is secure */
 	if (!fl->is_secure_dev && fl->cctx->secure) {
 		/*
 		 * Allow untrusted applications to offload only to Unsigned PD when
 		 * channel is configured as secure and block untrusted apps on channel
 		 * that does not support unsigned PD offload
 		 */
-		if (!fl->cctx->unsigned_support || !unsigned_pd_request) {
-			dev_err(&fl->cctx->rpdev->dev, "Error: Untrusted application trying to offload to signed PD");
-			return true;
-		}
+		if (!fl->cctx->unsigned_support || !unsigned_pd_request)
+			goto reject_session;
 	}
+	/* Check if untrusted process is trying to offload to signed PD */
+	if (fl->untrusted_process && !unsigned_pd_request)
+		goto reject_session;
 
 	return false;
+reject_session:
+	dev_err(&fl->cctx->rpdev->dev, "Error: Untrusted application trying to offload to signed PD");
+	return true;
 }
 
 static int fastrpc_mmap_remove_ssr(struct fastrpc_channel_ctx *cctx)
@@ -1822,6 +1827,11 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 		u32 pageslen;
 	} inbuf;
 
+	if (!fl->is_secure_dev) {
+		dev_err(&fl->cctx->rpdev->dev, "untrusted app trying to attach to privileged DSP PD\n");
+		return -EACCES;
+	}
+
 	args = kcalloc(FASTRPC_CREATE_STATIC_PROCESS_NARGS, sizeof(*args), GFP_KERNEL);
 	if (!args)
 		return -ENOMEM;
@@ -1981,11 +1991,19 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 		goto err;
 	}
 
+	/*
+	 * Third-party apps don't have permission to open the fastrpc device, so
+	 * it is opened on their behalf by DSP HAL. This is detected by
+	 * comparing current PID with the one stored during device open.
+	 */
+	if (current->tgid != fl->tgid)
+		fl->untrusted_process = true;
+
 	if (init.attrs & FASTRPC_MODE_UNSIGNED_MODULE)
 		fl->is_unsigned_pd = true;
 
 	if (is_session_rejected(fl, fl->is_unsigned_pd)) {
-		err = -ECONNREFUSED;
+		err = -EACCES;
 		goto err;
 	}
 
@@ -2244,6 +2262,11 @@ static int fastrpc_init_attach(struct fastrpc_user *fl, int pd)
 	struct fastrpc_enhanced_invoke ioctl;
 	int tgid = fl->tgid;
 
+	if (!fl->is_secure_dev) {
+		dev_err(&fl->cctx->rpdev->dev, "untrusted app trying to attach to privileged DSP PD\n");
+		return -EACCES;
+	}
+
 	fl->sctx = fastrpc_session_alloc(fl->cctx, fl->sharedcb);
 	if (!fl->sctx)
 		return -EBUSY;
-- 
2.17.0


