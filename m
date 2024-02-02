Return-Path: <linux-kernel+bounces-49290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2739846842
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27CCF1F24D84
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C3C44360;
	Fri,  2 Feb 2024 06:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R9X5OUl0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494843FB21;
	Fri,  2 Feb 2024 06:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856082; cv=none; b=jfa2neG++meNYJ35b7VnOgITTtPvewT+xZ0/SvrwTl7PsFFsrbvYX4JXXCEKQermCgfCFRyny/4y6BthqNACT1tyiGcZ4dYNePwtKuIUDg2KiQ6y5BMOIZueC9gBsaXhirqwrIt74PfMOWoHWzXVa+QlO3VGfNmNX1bHAh8wnuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856082; c=relaxed/simple;
	bh=gF/SqtpTVB0DrzlvGPiFFaaJ9ERAGRdeoV6n2gPpPlE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ceZjomqRGj90kEZsK8F0RUzQWyHAhf8x7Pat+yXfnvNhVXfP1TFutYcceVZeVaiBKMWwZz11jKbHo+kpGgqgPHwAzY8Kfq2vSC5ZawCvROKQh7KiwvlV0PN8c04D8R366hKK7rvd51AFjbKudIUDv06XBEQXSkwt/OyYuED6uvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R9X5OUl0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4124IO66014103;
	Fri, 2 Feb 2024 06:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=T/2V3UuvVLP6wtSt1VgJ
	YGNQTOa4VMRME2NKbAkkap0=; b=R9X5OUl047IwGyS7ulrCIy4tnV9fDzeySAw0
	+HEVw2f82/DTU3ClS0ro/t1r99UtN2+dULIRAH2SwHKDGtHbChRsSmW/A16XkV2z
	ON5dObHQNnSTc4vDY62YJJ/UCVPQnIUoYgf/PXu7fZjXKT4FtWBNdqXMSrMiQ1nx
	Eh8MHgICjyde2oIR1Z2phmej2ACyCF9f3wwFTzsg5v51WDwSFVoZltvmdNFTRUYU
	d4t+hO/5AAUThLtgxt+ZmMm9jo44PFCpV/hnmFjEUauTruSbjck29dhSxorFmMnR
	s9PNbuxYOdS7umIZeecQj087/9XyEO9BWtJArCiYr4iASUm3LQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pu00n3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 06:41:18 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4126fH0X001074
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 06:41:17 GMT
Received: from hu-ekangupt-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 22:41:15 -0800
From: Ekansh Gupta <quic_ekangupt@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 13/16] misc: fastrpc: Add wakelock management support
Date: Fri, 2 Feb 2024 12:10:36 +0530
Message-ID: <20240202064039.15505-14-quic_ekangupt@quicinc.com>
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
X-Proofpoint-GUID: uKlEbjQky6_3nahxRcTyisKByp15Pad_
X-Proofpoint-ORIG-GUID: uKlEbjQky6_3nahxRcTyisKByp15Pad_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020047

CPU can go into suspend mode at anytime. Users might have a
requirement to keep the CPU awake until they get a response for
their remote call to DSP. Wakelock management can be used to
achieve this requirement.

Co-developed-by: Anandu Krishnan E <quic_anane@quicinc.com>
Signed-off-by: Anandu Krishnan E <quic_anane@quicinc.com>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c      | 98 ++++++++++++++++++++++++++++++++++++-
 include/uapi/misc/fastrpc.h | 10 ++++
 2 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index d1be89f84214..2b24d1f96978 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -125,6 +125,11 @@
 /* Process status notifications from DSP will be sent with this unique context */
 #define FASTRPC_NOTIF_CTX_RESERVED 0xABCDABCD
 
+/* Maximum PM timeout that can be voted through fastrpc */
+#define FASTRPC_MAX_PM_TIMEOUT_MS 50
+#define FASTRPC_NON_SECURE_WAKE_SOURCE_CLIENT_NAME	"fastrpc-non_secure"
+#define FASTRPC_SECURE_WAKE_SOURCE_CLIENT_NAME		"fastrpc-secure"
+
 #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
 
 #define AUDIO_PDR_SERVICE_LOCATION_CLIENT_NAME   "audio_pdr_adsp"
@@ -419,6 +424,10 @@ struct fastrpc_channel_ctx {
 	struct fastrpc_device *secure_fdevice;
 	struct fastrpc_device *fdevice;
 	struct list_head rmaps;
+	/* Secure subsystems like ADSP/SLPI will use secure client */
+	struct wakeup_source *wake_source_secure;
+	/* Non-secure subsystem like CDSP will use regular client */
+	struct wakeup_source *wake_source;
 	bool secure;
 	bool unsigned_support;
 	bool cpuinfo_status;
@@ -449,6 +458,8 @@ struct fastrpc_user {
 	u32 profile;
 	/* Threads poll for specified timeout and fall back to glink wait */
 	u32 poll_timeout;
+	u32 ws_timeout;
+	u32 wake_enable;
 	int tgid;
 	int pd;
 	bool is_secure_dev;
@@ -997,6 +1008,43 @@ static void fastrpc_session_free(struct fastrpc_channel_ctx *cctx,
 	spin_unlock_irqrestore(&cctx->lock, flags);
 }
 
+static void fastrpc_pm_awake(struct fastrpc_user *fl,
+					u32 is_secure_channel)
+{
+	struct fastrpc_channel_ctx *cctx = fl->cctx;
+	struct wakeup_source *wake_source = NULL;
+
+	/*
+	 * Vote with PM to abort any suspend in progress and
+	 * keep system awake for specified timeout
+	 */
+	if (is_secure_channel)
+		wake_source = cctx->wake_source_secure;
+	else
+		wake_source = cctx->wake_source;
+
+	if (wake_source)
+		pm_wakeup_ws_event(wake_source, fl->ws_timeout, true);
+}
+
+static void fastrpc_pm_relax(struct fastrpc_user *fl,
+					u32 is_secure_channel)
+{
+	struct fastrpc_channel_ctx *cctx = fl->cctx;
+	struct wakeup_source *wake_source = NULL;
+
+	if (!fl->wake_enable)
+		return;
+
+	if (is_secure_channel)
+		wake_source = cctx->wake_source_secure;
+	else
+		wake_source = cctx->wake_source;
+
+	if (wake_source)
+		__pm_relax(wake_source);
+}
+
 static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 			      u64 len, u32 attr, struct fastrpc_map **ppmap)
 {
@@ -2070,6 +2118,7 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 		fastrpc_buf_free(buf);
 	}
 
+	fastrpc_pm_relax(fl, cctx->secure);
 	fastrpc_session_free(cctx, fl->sctx);
 	fastrpc_channel_ctx_put(cctx);
 
@@ -2357,14 +2406,32 @@ static int fastrpc_internal_control(struct fastrpc_user *fl,
 	case FASTRPC_CONTROL_SMMU:
 		fl->sharedcb = cp->smmu.sharedcb;
 		break;
-	case FASTRPC_CONTROL_RPC_POLL:
-		err = fastrpc_manage_poll_mode(fl, cp->lp.enable, cp->lp.latency);
+	case FASTRPC_CONTROL_WAKELOCK:
+		if (!fl->is_secure_dev) {
+			dev_err(&fl->cctx->rpdev->dev,
+				"PM voting not allowed for non-secure device node");
+			err = -EPERM;
+			return err;
+		}
+		fl->wake_enable = cp->wp.enable;
+		break;
+	case FASTRPC_CONTROL_PM:
+		if (!fl->wake_enable)
+			return -EACCES;
+		if (cp->pm.timeout > FASTRPC_MAX_PM_TIMEOUT_MS)
+			fl->ws_timeout = FASTRPC_MAX_PM_TIMEOUT_MS;
+		else
+			fl->ws_timeout = cp->pm.timeout;
+		fastrpc_pm_awake(fl, fl->cctx->secure);
 		break;
 	case FASTRPC_CONTROL_DSPPROCESS_CLEAN:
 		err = fastrpc_release_current_dsp_process(fl);
 		if (!err)
 			fastrpc_queue_pd_status(fl, fl->cctx->domain_id, FASTRPC_USERPD_FORCE_KILL);
 		break;
+	case FASTRPC_CONTROL_RPC_POLL:
+		err = fastrpc_manage_poll_mode(fl, cp->lp.enable, cp->lp.latency);
+		break;
 	default:
 		err = -EBADRQC;
 		break;
@@ -3268,6 +3335,21 @@ static int fastrpc_setup_service_locator(struct fastrpc_channel_ctx *cctx, char
 	return err;
 }
 
+static void fastrpc_register_wakeup_source(struct device *dev,
+	const char *client_name, struct wakeup_source **device_wake_source)
+{
+	struct wakeup_source *wake_source = NULL;
+
+	wake_source = wakeup_source_register(dev, client_name);
+	if (IS_ERR_OR_NULL(wake_source)) {
+		dev_err(dev, "wakeup_source_register failed for dev %s, client %s with err %ld\n",
+		dev_name(dev), client_name, PTR_ERR(wake_source));
+		return;
+	}
+
+	*device_wake_source = wake_source;
+}
+
 static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 {
 	struct device *rdev = &rpdev->dev;
@@ -3368,6 +3450,13 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 			goto populate_error;
 	}
 
+	if (data->fdevice)
+		fastrpc_register_wakeup_source(data->fdevice->miscdev.this_device,
+			FASTRPC_NON_SECURE_WAKE_SOURCE_CLIENT_NAME, &data->wake_source);
+	if (data->secure_fdevice)
+		fastrpc_register_wakeup_source(data->secure_fdevice->miscdev.this_device,
+			FASTRPC_SECURE_WAKE_SOURCE_CLIENT_NAME, &data->wake_source_secure);
+
 	kref_init(&data->refcount);
 
 	dev_set_drvdata(&rpdev->dev, data);
@@ -3421,6 +3510,11 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 		pdr_handle_release(cctx->spd[0].pdrhandle);
 	}
 
+	if (cctx->wake_source)
+		wakeup_source_unregister(cctx->wake_source);
+	if (cctx->wake_source_secure)
+		wakeup_source_unregister(cctx->wake_source_secure);
+
 	if (cctx->fdevice)
 		misc_deregister(&cctx->fdevice->miscdev);
 
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index a3bc6666a653..f4c73f6774f7 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -187,11 +187,21 @@ struct fastrpc_ctrl_latency {
 	u32 latency;	/* latency request in us */
 };
 
+struct fastrpc_ctrl_wakelock {
+	u32 enable;		/* wakelock control enable */
+};
+
+struct fastrpc_ctrl_pm {
+	u32 timeout;	/* timeout(in ms) for PM to keep system awake */
+};
+
 struct fastrpc_internal_control {
 	u32 req;
 	union {
 		struct fastrpc_ctrl_smmu smmu;
 		struct fastrpc_ctrl_latency lp;
+		struct fastrpc_ctrl_wakelock wp;
+		struct fastrpc_ctrl_pm pm;
 	};
 };
 
-- 
2.17.0


