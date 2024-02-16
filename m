Return-Path: <linux-kernel+bounces-67994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1CE857430
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCF01B243C7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E45C1758E;
	Fri, 16 Feb 2024 04:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PTNQpEyG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30F9FC02;
	Fri, 16 Feb 2024 03:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708055998; cv=none; b=MjN0yuklX8sl0KwCT9YcdqeMUj2RaYqa85zFnBND0RVm+W2PLw2an1WsCDgpgzsKcMlJghuhKA9LPj5qhiiC77LAn8RnBv6hDceeE3g4g+M/CghGWLN/eJkXn+nvdBySAwc1cVJRLG0C/ChnfpTS2oGZLzBbYVJksuREUjSQFus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708055998; c=relaxed/simple;
	bh=kxB/RSD3m8cOot9lwt4ZbiSu2jRwwtvQZClm8SVWgTU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rs7IeAtuH737aWOBV+LkaQkbCD8fmWsHsOk+a0zECpo1xrfru81fTK5cdftt6gcQ86GNvkVi5rqcIG+Fs+66FDOJBo6AMfyP7hR6oJz3jiMPneB99Sp8hkmteQkyjkSnGJKUnd9wrCEBE/DFlSsEFKP8kRr/WIz6vo4X13HNBWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PTNQpEyG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G3RLrf000423;
	Fri, 16 Feb 2024 03:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=IR/l05baFk1Nu0IwJQiY
	fPqNs58nUPFYs2cP5vSoQNE=; b=PTNQpEyG8diU62CWvrL9qa6klukqhIoU/V9+
	Mg/BT2bWYPGzWRMhKRDfzGU6tqf5+43Kwup9ajXBRd+23YYgjTN8qQLkwhlOsVQQ
	DKQoKv7XaAk41fRSoE6UM2MMtXdRj4Dbwa+3U0burwTkrqycBwbO37SZXLKq4TKA
	4UpqxPVizoGuLMFaNOwc2LwTyaBKquURwDvroG6AkNJJUijIhC00Pk04ZCqTu0Yh
	AFcD6SILOB0wEy/KYP2h6JhB54U2LwuLNvdj0xUYOdnz8VOwLISOhZMJj94Ey63u
	AmcIPHOf+c/yXd/rit61nBMZyWWY3IPq/HtJW2vldwoZjAAVDQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9qbc14hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 03:59:36 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41G3xai6020521
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 03:59:36 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 19:59:35 -0800
From: Wesley Cheng <quic_wcheng@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v16 10/50] xhci: add helper to stop endpoint and wait for completion
Date: Thu, 15 Feb 2024 19:58:43 -0800
Message-ID: <20240216035923.23392-11-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240216035923.23392-1-quic_wcheng@quicinc.com>
References: <20240216035923.23392-1-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BZBhOpxUUou-5DuS5v6-B1ZFqB1mlST2
X-Proofpoint-ORIG-GUID: BZBhOpxUUou-5DuS5v6-B1ZFqB1mlST2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_03,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160031

From: Mathias Nyman <mathias.nyman@linux.intel.com>

Expose xhci_stop_endpoint_sync() which is a synchronous variant of
xhci_queue_stop_endpoint().  This is useful for client drivers that are
using the secondary interrupters, and need to stop/clean up the current
session.  The stop endpoint command handler will also take care of cleaning
up the ring.

Modifications to repurpose the new API into existing stop endpoint
sequences was implemented by Wesley Cheng.

Change-Id: I153de06bd39107aa82a226a0b16b88e49a461be9
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Co-developed-by: Wesley Cheng <quic_wcheng@quicinc.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/host/xhci.c | 62 ++++++++++++++++++++++++++++++-----------
 drivers/usb/host/xhci.h |  2 ++
 2 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index b405b8236134..872ce8c1a5ba 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -2796,6 +2796,48 @@ static int xhci_reserve_bandwidth(struct xhci_hcd *xhci,
 	return -ENOMEM;
 }
 
+/*
+ * Synchronous XHCI stop endpoint helper.  Issues the stop endpoint command and
+ * waits for the command completion before returning.
+ */
+int xhci_stop_endpoint_sync(struct xhci_hcd *xhci, struct xhci_virt_ep *ep, int suspend,
+			    gfp_t gfp_flags)
+{
+	struct xhci_command *command;
+	unsigned long flags;
+	int ret;
+
+	command = xhci_alloc_command(xhci, true, gfp_flags);
+	if (!command)
+		return -ENOMEM;
+
+	spin_lock_irqsave(&xhci->lock, flags);
+	ret = xhci_queue_stop_endpoint(xhci, command, ep->vdev->slot_id,
+				       ep->ep_index, suspend);
+	if (ret < 0) {
+		spin_unlock_irqrestore(&xhci->lock, flags);
+		goto out;
+	}
+
+	xhci_ring_cmd_db(xhci);
+	spin_unlock_irqrestore(&xhci->lock, flags);
+
+	ret = wait_for_completion_timeout(command->completion, msecs_to_jiffies(3000));
+	if (!ret)
+		xhci_warn(xhci, "%s: Unable to stop endpoint.\n",
+				__func__);
+
+	if (command->status == COMP_COMMAND_ABORTED ||
+	    command->status == COMP_COMMAND_RING_STOPPED) {
+		xhci_warn(xhci, "Timeout while waiting for stop endpoint command\n");
+		ret = -ETIME;
+	}
+out:
+	xhci_free_command(xhci, command);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xhci_stop_endpoint_sync);
 
 /* Issue a configure endpoint command or evaluate context command
  * and wait for it to finish.
@@ -3119,7 +3161,7 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
 	struct xhci_virt_device *vdev;
 	struct xhci_virt_ep *ep;
 	struct xhci_input_control_ctx *ctrl_ctx;
-	struct xhci_command *stop_cmd, *cfg_cmd;
+	struct xhci_command *cfg_cmd;
 	unsigned int ep_index;
 	unsigned long flags;
 	u32 ep_flag;
@@ -3177,10 +3219,6 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
 	if (ep_flag == SLOT_FLAG || ep_flag == EP0_FLAG)
 		return;
 
-	stop_cmd = xhci_alloc_command(xhci, true, GFP_NOWAIT);
-	if (!stop_cmd)
-		return;
-
 	cfg_cmd = xhci_alloc_command_with_ctx(xhci, true, GFP_NOWAIT);
 	if (!cfg_cmd)
 		goto cleanup;
@@ -3203,23 +3241,16 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
 		goto cleanup;
 	}
 
-	err = xhci_queue_stop_endpoint(xhci, stop_cmd, udev->slot_id,
-					ep_index, 0);
+	spin_unlock_irqrestore(&xhci->lock, flags);
+
+	err = xhci_stop_endpoint_sync(xhci, ep, 0, GFP_NOWAIT);
 	if (err < 0) {
-		spin_unlock_irqrestore(&xhci->lock, flags);
-		xhci_free_command(xhci, cfg_cmd);
 		xhci_dbg(xhci, "%s: Failed to queue stop ep command, %d ",
 				__func__, err);
 		goto cleanup;
 	}
 
-	xhci_ring_cmd_db(xhci);
-	spin_unlock_irqrestore(&xhci->lock, flags);
-
-	wait_for_completion(stop_cmd->completion);
-
 	spin_lock_irqsave(&xhci->lock, flags);
-
 	/* config ep command clears toggle if add and drop ep flags are set */
 	ctrl_ctx = xhci_get_input_control_ctx(cfg_cmd->in_ctx);
 	if (!ctrl_ctx) {
@@ -3251,7 +3282,6 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
 
 	xhci_free_command(xhci, cfg_cmd);
 cleanup:
-	xhci_free_command(xhci, stop_cmd);
 	spin_lock_irqsave(&xhci->lock, flags);
 	if (ep->ep_state & EP_SOFT_CLEAR_TOGGLE)
 		ep->ep_state &= ~EP_SOFT_CLEAR_TOGGLE;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 6e09b9130fae..4f5e5187ea46 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1920,6 +1920,8 @@ void xhci_ring_doorbell_for_active_rings(struct xhci_hcd *xhci,
 void xhci_cleanup_command_queue(struct xhci_hcd *xhci);
 void inc_deq(struct xhci_hcd *xhci, struct xhci_ring *ring);
 unsigned int count_trbs(u64 addr, u64 len);
+int xhci_stop_endpoint_sync(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
+			    int suspend, gfp_t gfp_flags);
 
 /* xHCI roothub code */
 void xhci_set_link_state(struct xhci_hcd *xhci, struct xhci_port *port,

