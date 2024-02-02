Return-Path: <linux-kernel+bounces-49280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FCD846829
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5821F2449C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6463F17C69;
	Fri,  2 Feb 2024 06:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BIT0YhsY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3E41799E;
	Fri,  2 Feb 2024 06:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856061; cv=none; b=cOa9e1YLYHWGS3FaIX2+sbSS6iwoN+iE+88CkSKPLzNZJyUlmdCBjBtpIQuh4RXSSL9bVoeotGqJGbYv0AG5SBE0P0CvQzFZfCYvHn8SXRSOH9ZXCUcq6GQnhsGeM700XLcddt9dRS+h6GnIQAFE4uxdOw72xrrNw2PGOArYtmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856061; c=relaxed/simple;
	bh=wv0RdXaPzOQFI/dSNphF2oKnr0c/b6g6w8ucASw1vZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y4kLbasWFwufU2OtyMRrKvqn7d2C12W1hRm6ROSta4yqAjcUX7RToeMSLVqF+N5PaiyuLxLFsb6xwxv0dlpPfWsgakQrjkx0fiouTOqbvBFqcgPCfFCEg85GX4hCsabPCOwAz/h7NmjwIw/6MXw/v7P/Ph34mP3N+Id65M70xFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BIT0YhsY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4121dIhb017196;
	Fri, 2 Feb 2024 06:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=yEjPmzOUm8KJS57P/SFd
	BTDisFXia25b4e5x+Agt1WY=; b=BIT0YhsY85iAvC7uonHNaIT4rrS9nURHI8hu
	ZefTtkJZR75rcLFcqfE13G1v1AmJtg7mvc4LJ1tv7ec8oQgxt/cGx+2irgJz3aEl
	9hL4FhivZK6Ls8N38zAJ36/7F6AEz0Duz3mQbzmNGupv6TVbMRphMs0afGre8saM
	v1hZRg1YeAJ5wfFBg2hmDn62GVxA3o7gtGmu4vtGq+dVQqGxUd7fq5/3ytG29tsI
	EqJv8tTayAy9+WmSQGcXhtED7zLFdHtwZDkkWc5ctPtFlkdszCA4i87ntva/Hunc
	TbAAr+8bzQrgWhmml7vjS1J6HxRjJl12CcrOWqigusWzsWxuFA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pwm0mr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 06:40:57 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4126eu54004518
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 06:40:56 GMT
Received: from hu-ekangupt-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 22:40:54 -0800
From: Ekansh Gupta <quic_ekangupt@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 03/16] misc: fastrpc: Add static PD restart support
Date: Fri, 2 Feb 2024 12:10:26 +0530
Message-ID: <20240202064039.15505-4-quic_ekangupt@quicinc.com>
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
X-Proofpoint-GUID: V9sUXhK_gNHwGwXlLO0Xri5NkyzAcH_A
X-Proofpoint-ORIG-GUID: V9sUXhK_gNHwGwXlLO0Xri5NkyzAcH_A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402020047

Static PDs on the audio and sensor domains are expected to support
PD restart. The kernel resource handling for the PDs are expected
to be handled by fastrpc driver. For this, there is a requirement
of PD service locator to get the event notifications for static PD
services. Also when events are received, the driver needs to handle
based on PD states. Added changes to add service locator for audio
and sensor domain static PDs and handle the PD restart sequence.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c | 216 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 204 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index bdce5469de19..e9b3b3b00aed 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -22,6 +22,7 @@
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <uapi/misc/fastrpc.h>
 #include <linux/of_reserved_mem.h>
+#include <linux/soc/qcom/pdr.h>
 
 #define ADSP_DOMAIN_ID (0)
 #define MDSP_DOMAIN_ID (1)
@@ -29,6 +30,7 @@
 #define CDSP_DOMAIN_ID (3)
 #define FASTRPC_DEV_MAX		4 /* adsp, mdsp, slpi, cdsp*/
 #define FASTRPC_MAX_SESSIONS	14
+#define FASTRPC_MAX_SPD		4
 #define FASTRPC_MAX_VMIDS	16
 #define FASTRPC_ALIGN		128
 #define FASTRPC_MAX_FDLIST	16
@@ -105,6 +107,18 @@
 
 #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
 
+#define AUDIO_PDR_SERVICE_LOCATION_CLIENT_NAME   "audio_pdr_adsp"
+#define AUDIO_PDR_ADSP_SERVICE_NAME              "avs/audio"
+#define ADSP_AUDIOPD_NAME                        "msm/adsp/audio_pd"
+
+#define SENSORS_PDR_ADSP_SERVICE_LOCATION_CLIENT_NAME   "sensors_pdr_adsp"
+#define SENSORS_PDR_ADSP_SERVICE_NAME              "tms/servreg"
+#define ADSP_SENSORPD_NAME                       "msm/adsp/sensor_pd"
+
+#define SENSORS_PDR_SLPI_SERVICE_LOCATION_CLIENT_NAME "sensors_pdr_slpi"
+#define SENSORS_PDR_SLPI_SERVICE_NAME            SENSORS_PDR_ADSP_SERVICE_NAME
+#define SLPI_SENSORPD_NAME                       "msm/slpi/sensor_pd"
+
 static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
 						"sdsp", "cdsp"};
 struct fastrpc_phy_page {
@@ -260,6 +274,16 @@ struct fastrpc_session_ctx {
 	bool valid;
 };
 
+struct fastrpc_static_pd {
+	char *servloc_name;
+	char *spdname;
+	void *pdrhandle;
+	u64 pdrcount;
+	u64 prevpdrcount;
+	atomic_t ispdup;
+	struct fastrpc_channel_ctx *cctx;
+};
+
 struct fastrpc_channel_ctx {
 	int domain_id;
 	int sesscount;
@@ -268,6 +292,7 @@ struct fastrpc_channel_ctx {
 	struct qcom_scm_vmperm vmperms[FASTRPC_MAX_VMIDS];
 	struct rpmsg_device *rpdev;
 	struct fastrpc_session_ctx session[FASTRPC_MAX_SESSIONS];
+	struct fastrpc_static_pd spd[FASTRPC_MAX_SPD];
 	spinlock_t lock;
 	struct idr ctx_idr;
 	struct list_head users;
@@ -304,6 +329,7 @@ struct fastrpc_user {
 	int pd;
 	bool is_secure_dev;
 	bool is_unsigned_pd;
+	char *servloc_name;
 	/* Lock for lists */
 	spinlock_t lock;
 	/* lock for allocations */
@@ -1256,6 +1282,41 @@ static int fastrpc_mmap_remove_ssr(struct fastrpc_channel_ctx *cctx)
 	return 0;
 }
 
+static int fastrpc_mmap_remove_pdr(struct fastrpc_user *fl)
+{
+	int i, err = 0, session = -1;
+
+	if (!fl)
+		return -EBADF;
+
+	for (i = 0; i < FASTRPC_MAX_SPD ; i++) {
+		if (!fl->cctx->spd[i].servloc_name)
+			continue;
+		if (!strcmp(fl->servloc_name, fl->cctx->spd[i].servloc_name)) {
+			session = i;
+			break;
+		}
+	}
+
+	if (i >= FASTRPC_MAX_SPD)
+		return -EUSERS;
+
+	if (atomic_read(&fl->cctx->spd[session].ispdup) == 0)
+		return -ENOTCONN;
+
+	if (fl->cctx->spd[session].pdrcount !=
+		fl->cctx->spd[session].prevpdrcount) {
+		err = fastrpc_mmap_remove_ssr(fl->cctx);
+		if (err)
+			dev_info(&fl->cctx->rpdev->dev,
+				"failed to unmap remote heap (err %d)\n", err);
+		fl->cctx->spd[session].prevpdrcount =
+				fl->cctx->spd[session].pdrcount;
+	}
+
+	return err;
+}
+
 static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 					      char __user *argp)
 {
@@ -1299,6 +1360,18 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 		goto err_name;
 	}
 
+	fl->servloc_name = AUDIO_PDR_SERVICE_LOCATION_CLIENT_NAME;
+
+	if (!strcmp(name, "audiopd")) {
+		/*
+		 * Remove any previous mappings in case process is trying
+		 * to reconnect after a PD restart on remote subsystem.
+		 */
+		err = fastrpc_mmap_remove_pdr(fl);
+		if (err)
+			goto err_name;
+	}
+
 	if (!fl->cctx->staticpd_status) {
 		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen, &buf);
 		if (err)
@@ -1688,6 +1761,12 @@ static int fastrpc_init_attach(struct fastrpc_user *fl, int pd)
 	args[0].fd = -1;
 	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_ATTACH, 1, 0);
 	fl->pd = pd;
+	if (pd == SENSORS_PD) {
+		if (fl->cctx->domain_id == ADSP_DOMAIN_ID)
+			fl->servloc_name = SENSORS_PDR_ADSP_SERVICE_LOCATION_CLIENT_NAME;
+		else if (fl->cctx->domain_id == SDSP_DOMAIN_ID)
+			fl->servloc_name = SENSORS_PDR_SLPI_SERVICE_LOCATION_CLIENT_NAME;
+	}
 
 	return fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE,
 				       sc, &args[0]);
@@ -2281,6 +2360,72 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 	return err;
 }
 
+static void fastrpc_notify_users(struct fastrpc_user *user)
+{
+	struct fastrpc_invoke_ctx *ctx;
+
+	spin_lock(&user->lock);
+	list_for_each_entry(ctx, &user->pending, node) {
+		ctx->retval = -EPIPE;
+		complete(&ctx->work);
+	}
+	spin_unlock(&user->lock);
+}
+
+static void fastrpc_notify_pdr_drivers(struct fastrpc_channel_ctx *cctx,
+		char *servloc_name)
+{
+	struct fastrpc_user *fl;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cctx->lock, flags);
+	list_for_each_entry(fl, &cctx->users, user) {
+		if (fl->servloc_name && !strcmp(servloc_name, fl->servloc_name))
+			fastrpc_notify_users(fl);
+	}
+	spin_unlock_irqrestore(&cctx->lock, flags);
+}
+
+static void fastrpc_pdr_cb(int state, char *service_path, void *priv)
+{
+	struct fastrpc_static_pd *spd = (struct fastrpc_static_pd *)priv;
+	struct fastrpc_channel_ctx *cctx;
+	unsigned long flags;
+
+	if (!spd)
+		return;
+
+	cctx = spd->cctx;
+	switch (state) {
+	case SERVREG_SERVICE_STATE_DOWN:
+		dev_info(&cctx->rpdev->dev,
+			"%s: %s (%s) is down for PDR on %s\n",
+			__func__, spd->spdname,
+			spd->servloc_name,
+			domains[cctx->domain_id]);
+		spin_lock_irqsave(&cctx->lock, flags);
+		spd->pdrcount++;
+		atomic_set(&spd->ispdup, 0);
+		spin_unlock_irqrestore(&cctx->lock, flags);
+		if (!strcmp(spd->servloc_name,
+				AUDIO_PDR_SERVICE_LOCATION_CLIENT_NAME))
+			cctx->staticpd_status = false;
+
+		fastrpc_notify_pdr_drivers(cctx, spd->servloc_name);
+		break;
+	case SERVREG_SERVICE_STATE_UP:
+		dev_info(&cctx->rpdev->dev,
+			"%s: %s (%s) is up for PDR on %s\n",
+			__func__, spd->spdname,
+			spd->servloc_name,
+			domains[cctx->domain_id]);
+		atomic_set(&spd->ispdup, 1);
+		break;
+	default:
+		break;
+	}
+}
+
 static const struct file_operations fastrpc_fops = {
 	.open = fastrpc_device_open,
 	.release = fastrpc_device_release,
@@ -2402,6 +2547,39 @@ static int fastrpc_device_register(struct device *dev, struct fastrpc_channel_ct
 	return err;
 }
 
+static int fastrpc_setup_service_locator(struct fastrpc_channel_ctx *cctx, char *client_name,
+			char *service_name, char *service_path, int domain, int spd_session)
+{
+	int err = 0;
+	struct pdr_handle *handle = NULL;
+	struct pdr_service *service = NULL;
+
+	/* Register the service locator's callback function */
+	handle = pdr_handle_alloc(fastrpc_pdr_cb, &cctx->spd[spd_session]);
+	if (IS_ERR(handle)) {
+		err = PTR_ERR(handle);
+		goto bail;
+	}
+	cctx->spd[spd_session].pdrhandle = handle;
+	cctx->spd[spd_session].servloc_name = client_name;
+	cctx->spd[spd_session].spdname = service_path;
+	cctx->spd[spd_session].cctx = cctx;
+	service = pdr_add_lookup(handle, service_name, service_path);
+	if (IS_ERR(service)) {
+		err = PTR_ERR(service);
+		goto bail;
+	}
+	pr_info("fastrpc: %s: pdr_add_lookup enabled for %s (%s, %s)\n",
+		__func__, service_name, client_name, service_path);
+
+bail:
+	if (err) {
+		pr_warn("fastrpc: %s: failed for %s (%s, %s)with err %d\n",
+				__func__, service_name, client_name, service_path, err);
+	}
+	return err;
+}
+
 static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 {
 	struct device *rdev = &rpdev->dev;
@@ -2481,6 +2659,25 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		goto fdev_error;
 	}
 
+	if (domain_id == ADSP_DOMAIN_ID) {
+		err = fastrpc_setup_service_locator(data, AUDIO_PDR_SERVICE_LOCATION_CLIENT_NAME,
+			AUDIO_PDR_ADSP_SERVICE_NAME, ADSP_AUDIOPD_NAME, domain_id, 0);
+		if (err)
+			goto populate_error;
+
+		err = fastrpc_setup_service_locator(data,
+			SENSORS_PDR_ADSP_SERVICE_LOCATION_CLIENT_NAME,
+			SENSORS_PDR_ADSP_SERVICE_NAME, ADSP_SENSORPD_NAME, domain_id, 1);
+		if (err)
+			goto populate_error;
+	} else if (domain_id == SDSP_DOMAIN_ID) {
+		err = fastrpc_setup_service_locator(data,
+			SENSORS_PDR_SLPI_SERVICE_LOCATION_CLIENT_NAME,
+			SENSORS_PDR_SLPI_SERVICE_NAME, SLPI_SENSORPD_NAME, domain_id, 0);
+		if (err)
+			goto populate_error;
+	}
+
 	kref_init(&data->refcount);
 
 	dev_set_drvdata(&rpdev->dev, data);
@@ -2510,18 +2707,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	return err;
 }
 
-static void fastrpc_notify_users(struct fastrpc_user *user)
-{
-	struct fastrpc_invoke_ctx *ctx;
-
-	spin_lock(&user->lock);
-	list_for_each_entry(ctx, &user->pending, node) {
-		ctx->retval = -EPIPE;
-		complete(&ctx->work);
-	}
-	spin_unlock(&user->lock);
-}
-
 static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 {
 	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
@@ -2537,6 +2722,13 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 		fastrpc_notify_users(user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
+	if (cctx->domain_id == ADSP_DOMAIN_ID) {
+		pdr_handle_release(cctx->spd[0].pdrhandle);
+		pdr_handle_release(cctx->spd[1].pdrhandle);
+	} else if (cctx->domain_id == SDSP_DOMAIN_ID) {
+		pdr_handle_release(cctx->spd[0].pdrhandle);
+	}
+
 	if (cctx->fdevice)
 		misc_deregister(&cctx->fdevice->miscdev);
 
-- 
2.17.0


