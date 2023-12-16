Return-Path: <linux-kernel+bounces-2321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BB2815AF6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 19:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9EE1C21A84
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 18:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C9431747;
	Sat, 16 Dec 2023 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQb7BDUI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4157C17729
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 18:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3b9f11fee25so292032b6e.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 10:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702750223; x=1703355023; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D5Fsf2KwASZVPyC0UlF+LnEeN7/PIgO1DnGkZSvCMVg=;
        b=WQb7BDUIimUBQQw1iWwoZ7b/SFa75szrcN5vo8UT54K4RHFIH2xgAYz8JESOi4noZF
         D7dLeThz/qvYGC0wY/Ptqnuv8dBsR6mV54x8fzBD6Nok8EKfysjo1zjXLIdz5EOssPe+
         huBXDLYLoh0j9BgmY+6PRzMfouae2N2kfjqCT4RIkxhvTjvYeT67pnMJHX/lRtqt0ssz
         ECz+jlssFKv+3B/b63OuhK99zGTSJ9CUGvRl3X9hmNbdQ3D+kvTKtcU+XuBfv2HQd6HG
         sP/F9f78J5dy/hnoUDloupKmjiW7stR6wukegie7/HZByLCbf2zZN/6plT0zpOD8nYAg
         CqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702750223; x=1703355023;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5Fsf2KwASZVPyC0UlF+LnEeN7/PIgO1DnGkZSvCMVg=;
        b=G9XwWhdLtFlJBEFQMBwKemZs6+XXe6gDhVqNZJP9LTOXMo4GKTRXJvxOHyPuZdJZAk
         HuE2Ef43UEqGxzrCsnF0Qbgo6HsbLRv0IMnvgLrP5qFAASjzX1OQva+jBO7eIuOoyp9J
         pKc/orearad9sLRbdrrRq9QFM9tAFOEGsJWk56VBYtHYAxB83rDrSt+HNe2EcmbSlla5
         Xy6FLRqXLzhgYGSIgDvXNqRb+QVXnn70252+IbkMDGTFjTqhkKAerFbxy78/Zl2s6o4i
         T385cI8t7D/Io7gxvqi/pNgMHJe9AAOKTqkxfhWck/HpbxNl4gFWPl9eWhBd0PLdl6Yo
         8UGg==
X-Gm-Message-State: AOJu0Yyz6sNQEiJWcsZVA3NmqExUgdgWE5jZUB+ZNRFTScP019+BAyNY
	dwXEwB/ZrFXqec2FLXcOWX4=
X-Google-Smtp-Source: AGHT+IFwxdP8o2/Jts4G/U8VaVMGGbhMKndp91gRuM4Gbgf7v4OpBHogNoQQ7Wk/myWFgaWBCNBCQQ==
X-Received: by 2002:a05:6808:1307:b0:3b8:98f0:3c2 with SMTP id y7-20020a056808130700b003b898f003c2mr27484030oiv.4.1702750222394;
        Sat, 16 Dec 2023 10:10:22 -0800 (PST)
Received: from kernel.ryanengland.xyz ([2600:3c05::f03c:94ff:fea1:5b99])
        by smtp.gmail.com with ESMTPSA id ri4-20020a05620a8f8400b0077d84ad9744sm6989942qkn.36.2023.12.16.10.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 10:10:21 -0800 (PST)
Date: Sat, 16 Dec 2023 18:10:21 +0000
From: Ryan England <rcengland@gmail.com>
To: Larry Finger <Larry.Finger@lwfinger.net>,
	Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: [PATCH] staging: rtl8712: fix open parentheses alignment
Message-ID: <ZX3oDRuQ1OvZwCe3@kernel.ryanengland.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Adhere to Linux kernel coding style.

Reported by checkpatch:

CHECK: Alignment should match open parenthesis

Signed-off-by: Ryan England <rcengland@gmail.com>
---
 drivers/staging/rtl8712/os_intfs.c            |   2 +-
 drivers/staging/rtl8712/rtl8712_efuse.c       |   8 +-
 drivers/staging/rtl8712/rtl8712_recv.c        |   2 +-
 drivers/staging/rtl8712/rtl8712_xmit.c        |  48 ++++----
 drivers/staging/rtl8712/rtl871x_cmd.c         |  43 ++++----
 drivers/staging/rtl8712/rtl871x_cmd.h         |   7 +-
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 103 +++++++++---------
 7 files changed, 109 insertions(+), 104 deletions(-)

diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index b18e6d9c832b..1b11f8b04e13 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -222,7 +222,7 @@ struct net_device *r8712_init_netdev(void)
 static u32 start_drv_threads(struct _adapter *padapter)
 {
 	padapter->cmd_thread = kthread_run(r8712_cmd_thread, padapter, "%s",
-					  padapter->pnetdev->name);
+					   padapter->pnetdev->name);
 	if (IS_ERR(padapter->cmd_thread))
 		return _FAIL;
 	return _SUCCESS;
diff --git a/drivers/staging/rtl8712/rtl8712_efuse.c b/drivers/staging/rtl8712/rtl8712_efuse.c
index c9400e40a1d6..2f423682446b 100644
--- a/drivers/staging/rtl8712/rtl8712_efuse.c
+++ b/drivers/staging/rtl8712/rtl8712_efuse.c
@@ -213,8 +213,8 @@ u16 r8712_efuse_get_current_size(struct _adapter *adapter)
 	u8 hworden = 0;
 	u8 efuse_data, word_cnts = 0;
 
-	while (bContinual && efuse_one_byte_read(adapter, efuse_addr,
-	       &efuse_data) && (efuse_addr < efuse_available_max_size)) {
+	while (bContinual && efuse_one_byte_read(adapter, efuse_addr, &efuse_data) &&
+	       (efuse_addr < efuse_available_max_size)) {
 		if (efuse_data != 0xFF) {
 			hworden =  efuse_data & 0x0F;
 			word_cnts = calculate_word_cnts(hworden);
@@ -253,8 +253,8 @@ u8 r8712_efuse_pg_packet_read(struct _adapter *adapter, u8 offset, u8 *data)
 				for (tmpidx = 0; tmpidx < word_cnts * 2;
 				     tmpidx++) {
 					if (efuse_one_byte_read(adapter,
-					    efuse_addr + 1 + tmpidx,
-					    &efuse_data)) {
+								efuse_addr + 1 + tmpidx,
+								&efuse_data)) {
 						tmpdata[tmpidx] = efuse_data;
 					} else {
 						ret = false;
diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
index 7da014ab0723..3f5b6ae3540e 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.c
+++ b/drivers/staging/rtl8712/rtl8712_recv.c
@@ -268,7 +268,7 @@ union recv_frame *r8712_recvframe_chk_defrag(struct _adapter *padapter,
 				if (!list_empty(&pdefrag_q->queue)) {
 					/*free current defrag_q */
 					r8712_free_recvframe_queue(pdefrag_q,
-							     pfree_recv_queue);
+								   pfree_recv_queue);
 				}
 			}
 			/* Then enqueue the 0~(n-1) fragment to the defrag_q */
diff --git a/drivers/staging/rtl8712/rtl8712_xmit.c b/drivers/staging/rtl8712/rtl8712_xmit.c
index 4cb01f590673..a1a55679d336 100644
--- a/drivers/staging/rtl8712/rtl8712_xmit.c
+++ b/drivers/staging/rtl8712/rtl8712_xmit.c
@@ -147,9 +147,9 @@ static u32 get_ff_hwaddr(struct xmit_frame *pxmitframe)
 }
 
 static struct xmit_frame *dequeue_one_xmitframe(struct xmit_priv *pxmitpriv,
-					 struct hw_xmit *phwxmit,
-					 struct tx_servq *ptxservq,
-					 struct  __queue *pframe_queue)
+						struct hw_xmit *phwxmit,
+						struct tx_servq *ptxservq,
+						struct  __queue *pframe_queue)
 {
 	struct list_head *xmitframe_plist, *xmitframe_phead;
 	struct	xmit_frame *pxmitframe = NULL;
@@ -167,7 +167,7 @@ static struct xmit_frame *dequeue_one_xmitframe(struct xmit_priv *pxmitpriv,
 }
 
 static struct xmit_frame *dequeue_xframe_ex(struct xmit_priv *pxmitpriv,
-				     struct hw_xmit *phwxmit_i, sint entry)
+					    struct hw_xmit *phwxmit_i, sint entry)
 {
 	unsigned long irqL0;
 	struct list_head *sta_plist, *sta_phead;
@@ -200,8 +200,10 @@ static struct xmit_frame *dequeue_xframe_ex(struct xmit_priv *pxmitpriv,
 			ptxservq = container_of(sta_plist, struct tx_servq,
 						tx_pending);
 			pframe_queue = &ptxservq->sta_pending;
-			pxmitframe = dequeue_one_xmitframe(pxmitpriv, phwxmit,
-				     ptxservq, pframe_queue);
+			pxmitframe = dequeue_one_xmitframe(pxmitpriv,
+							   phwxmit,
+							   ptxservq,
+							   pframe_queue);
 			if (pxmitframe) {
 				phwxmit->accnt--;
 				goto exit_dequeue_xframe_ex;
@@ -292,14 +294,14 @@ void r8712_append_mpdu_unit(struct xmit_buf *pxmitbuf,
 	r8712_xmit_complete(padapter, pxmitframe);
 	if (pxmitframe->attrib.ether_type != 0x0806) {
 		if ((pxmitframe->attrib.ether_type != 0x888e) &&
-			(pxmitframe->attrib.dhcp_pkt != 1)) {
+		    (pxmitframe->attrib.dhcp_pkt != 1)) {
 			r8712_issue_addbareq_cmd(padapter,
-					pxmitframe->attrib.priority);
+						 pxmitframe->attrib.priority);
 		}
 	}
 	pxmitframe->last[0] = 1;
 	update_txdesc(pxmitframe, (uint *)(pxmitframe->buf_addr),
-		pxmitframe->attrib.last_txcmdsz);
+		      pxmitframe->attrib.last_txcmdsz);
 	/*padding zero */
 	last_txcmdsz = pxmitframe->attrib.last_txcmdsz;
 	padding_sz = (8 - (last_txcmdsz % 8));
@@ -334,7 +336,7 @@ void r8712_xmitframe_aggr_1st(struct xmit_buf *pxmitbuf,
 }
 
 u16 r8712_xmitframe_aggr_next(struct xmit_buf *pxmitbuf,
-			struct xmit_frame *pxmitframe)
+			      struct xmit_frame *pxmitframe)
 {
 	pxmitframe->pxmitbuf = pxmitbuf;
 	pxmitbuf->priv_data = pxmitframe;
@@ -388,7 +390,7 @@ void r8712_dump_aggr_xframe(struct xmit_buf *pxmitbuf,
 		/*default = 32 bytes for TX Desc*/
 	}
 	r8712_write_port(pxmitframe->padapter, RTL8712_DMA_H2CCMD,
-			total_length + TXDESC_SIZE, (u8 *)pxmitframe);
+			 total_length + TXDESC_SIZE, (u8 *)pxmitframe);
 }
 
 #endif
@@ -618,14 +620,13 @@ int r8712_xmitframe_complete(struct _adapter *padapter,
 	pxmitframe = dequeue_xframe_ex(pxmitpriv, phwxmits, hwentry);
 	/* need to remember the 1st frame */
 	if (pxmitframe) {
-
 #ifdef CONFIG_R8712_TX_AGGR
 		/* 1. dequeue 2nd frame
 		 * 2. aggr if 2nd xframe is dequeued, else dump directly
 		 */
 		if (AGGR_NR_HIGH_BOUND > 1)
 			p2ndxmitframe = dequeue_xframe_ex(pxmitpriv, phwxmits,
-							hwentry);
+							  hwentry);
 		if (pxmitframe->frame_tag != DATA_FRAMETAG) {
 			r8712_free_xmitbuf(pxmitpriv, pxmitbuf);
 			return false;
@@ -639,16 +640,16 @@ int r8712_xmitframe_complete(struct _adapter *padapter,
 		if (p2ndxmitframe) {
 			u16 total_length;
 
-			total_length = r8712_xmitframe_aggr_next(
-				pxmitbuf, p2ndxmitframe);
+			total_length = r8712_xmitframe_aggr_next(pxmitbuf,
+								 p2ndxmitframe);
 			do {
-				p2ndxmitframe = dequeue_xframe_ex(
-					pxmitpriv, phwxmits, hwentry);
+				p2ndxmitframe = dequeue_xframe_ex(pxmitpriv,
+								  phwxmits,
+								  hwentry);
 				if (p2ndxmitframe)
 					total_length =
-						r8712_xmitframe_aggr_next(
-							pxmitbuf,
-							p2ndxmitframe);
+						r8712_xmitframe_aggr_next(pxmitbuf,
+									  p2ndxmitframe);
 				else
 					break;
 			} while (total_length <= 0x1800 &&
@@ -663,7 +664,8 @@ int r8712_xmitframe_complete(struct _adapter *padapter,
 		if (pxmitframe->frame_tag == DATA_FRAMETAG) {
 			if (pxmitframe->attrib.priority <= 15)
 				res = r8712_xmitframe_coalesce(padapter,
-					pxmitframe->pkt, pxmitframe);
+							       pxmitframe->pkt,
+							       pxmitframe);
 			/* always return ndis_packet after
 			 * r8712_xmitframe_coalesce
 			 */
@@ -714,10 +716,10 @@ static void dump_xframe(struct _adapter *padapter,
 		ff_hwaddr = get_ff_hwaddr(pxmitframe);
 #ifdef CONFIG_R8712_TX_AGGR
 		r8712_write_port(padapter, RTL8712_DMA_H2CCMD, w_sz,
-				(unsigned char *)pxmitframe);
+				 (unsigned char *)pxmitframe);
 #else
 		r8712_write_port(padapter, ff_hwaddr, w_sz,
-			   (unsigned char *)pxmitframe);
+				 (unsigned char *)pxmitframe);
 #endif
 		mem_addr += w_sz;
 		mem_addr = (u8 *)RND4(((addr_t)(mem_addr)));
diff --git a/drivers/staging/rtl8712/rtl871x_cmd.c b/drivers/staging/rtl8712/rtl871x_cmd.c
index 4be96df5a329..1c67ad54ec6b 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.c
+++ b/drivers/staging/rtl8712/rtl871x_cmd.c
@@ -243,7 +243,7 @@ void r8712_set_chplan_cmd(struct _adapter *padapter, int chplan)
 		return;
 	}
 	init_h2fwcmd_w_parm_no_rsp(ph2c, psetchplanpara,
-				GEN_CMD_CODE(_SetChannelPlan));
+				   GEN_CMD_CODE(_SetChannelPlan));
 	psetchplanpara->ChannelPlan = chplan;
 	r8712_enqueue_cmd(pcmdpriv, ph2c);
 }
@@ -303,7 +303,7 @@ void r8712_getbbrfreg_cmdrsp_callback(struct _adapter *padapter,
 }
 
 void r8712_readtssi_cmdrsp_callback(struct _adapter *padapter,
-				struct cmd_obj *pcmd)
+				    struct cmd_obj *pcmd)
 {
 	kfree(pcmd->parmbuf);
 	kfree(pcmd);
@@ -375,10 +375,10 @@ int r8712_joinbss_cmd(struct _adapter  *padapter, struct wlan_network *pnetwork)
 					     psecnetwork->IELength;
 	if ((psecnetwork->IELength - 12) < (256 - 1))
 		memcpy(&psecuritypriv->authenticator_ie[1],
-			&psecnetwork->IEs[12], psecnetwork->IELength - 12);
+		       &psecnetwork->IEs[12], psecnetwork->IELength - 12);
 	else
 		memcpy(&psecuritypriv->authenticator_ie[1],
-			&psecnetwork->IEs[12], (256 - 1));
+		       &psecnetwork->IEs[12], (256 - 1));
 	psecnetwork->IELength = 0;
 	/*
 	 * If the driver wants to use the bssid to create the connection.
@@ -389,18 +389,18 @@ int r8712_joinbss_cmd(struct _adapter  *padapter, struct wlan_network *pnetwork)
 		ether_addr_copy(&pmlmepriv->assoc_bssid[0],
 				&pnetwork->network.MacAddress[0]);
 	psecnetwork->IELength = r8712_restruct_sec_ie(padapter,
-						&pnetwork->network.IEs[0],
-						&psecnetwork->IEs[0],
-						pnetwork->network.IELength);
+						      &pnetwork->network.IEs[0],
+						      &psecnetwork->IEs[0],
+						      pnetwork->network.IELength);
 	pqospriv->qos_option = 0;
 	if (pregistrypriv->wmm_enable) {
 		u32 tmp_len;
 
 		tmp_len = r8712_restruct_wmm_ie(padapter,
-					  &pnetwork->network.IEs[0],
-					  &psecnetwork->IEs[0],
-					  pnetwork->network.IELength,
-					  psecnetwork->IELength);
+						&pnetwork->network.IEs[0],
+						&psecnetwork->IEs[0],
+						pnetwork->network.IELength,
+						psecnetwork->IELength);
 		if (psecnetwork->IELength != tmp_len) {
 			psecnetwork->IELength = tmp_len;
 			pqospriv->qos_option = 1; /* WMM IE in beacon */
@@ -427,17 +427,17 @@ int r8712_joinbss_cmd(struct _adapter  *padapter, struct wlan_network *pnetwork)
 	psecuritypriv->supplicant_ie[0] = (u8)psecnetwork->IELength;
 	if (psecnetwork->IELength < 255)
 		memcpy(&psecuritypriv->supplicant_ie[1], &psecnetwork->IEs[0],
-			psecnetwork->IELength);
+		       psecnetwork->IELength);
 	else
 		memcpy(&psecuritypriv->supplicant_ie[1], &psecnetwork->IEs[0],
-			255);
+		       255);
 	/* get cmdsz before endian conversion */
 	pcmd->cmdsz = r8712_get_wlan_bssid_ex_sz(psecnetwork);
 #ifdef __BIG_ENDIAN
 	/* wlan_network endian conversion */
 	psecnetwork->Length = cpu_to_le32(psecnetwork->Length);
 	psecnetwork->Ssid.SsidLength = cpu_to_le32(
-				       psecnetwork->Ssid.SsidLength);
+				psecnetwork->Ssid.SsidLength);
 	psecnetwork->Privacy = cpu_to_le32(psecnetwork->Privacy);
 	psecnetwork->Rssi = cpu_to_le32(psecnetwork->Rssi);
 	psecnetwork->NetworkTypeInUse = cpu_to_le32(
@@ -491,7 +491,7 @@ void r8712_disassoc_cmd(struct _adapter *padapter) /* for sta_mode */
 }
 
 void r8712_setopmode_cmd(struct _adapter *padapter,
-		 enum NDIS_802_11_NETWORK_INFRASTRUCTURE networktype)
+			 enum NDIS_802_11_NETWORK_INFRASTRUCTURE networktype)
 {
 	struct cmd_obj *ph2c;
 	struct setopmode_parm *psetop;
@@ -549,8 +549,8 @@ void r8712_setstakey_cmd(struct _adapter *padapter, u8 *psta, u8 unicast_key)
 		memcpy(&psetstakey_para->key, &sta->x_UncstKey, 16);
 	else
 		memcpy(&psetstakey_para->key,
-			&psecuritypriv->XGrpKey[
-			psecuritypriv->XGrpKeyid - 1]. skey, 16);
+		       &psecuritypriv->XGrpKey[
+		       psecuritypriv->XGrpKeyid - 1]. skey, 16);
 	r8712_enqueue_cmd(pcmdpriv, ph2c);
 }
 
@@ -709,13 +709,13 @@ void r8712_createbss_cmd_callback(struct _adapter *padapter,
 			pwlan->last_scanned = jiffies;
 		} else {
 			list_add_tail(&(pwlan->list),
-					 &pmlmepriv->scanned_queue.queue);
+				      &pmlmepriv->scanned_queue.queue);
 		}
 		pnetwork->Length = r8712_get_wlan_bssid_ex_sz(pnetwork);
 		memcpy(&(pwlan->network), pnetwork, pnetwork->Length);
 		pwlan->fixed = true;
 		memcpy(&tgt_network->network, pnetwork,
-			(r8712_get_wlan_bssid_ex_sz(pnetwork)));
+		       (r8712_get_wlan_bssid_ex_sz(pnetwork)));
 		if (pmlmepriv->fw_state & _FW_UNDER_LINKING)
 			pmlmepriv->fw_state ^= _FW_UNDER_LINKING;
 		/*
@@ -770,7 +770,8 @@ void r8712_setassocsta_cmdrsp_callback(struct _adapter *padapter,
 }
 
 void r8712_disconnectCtrlEx_cmd(struct _adapter *adapter, u32 enableDrvCtrl,
-			u32 tryPktCnt, u32 tryPktInterval, u32 firstStageTO)
+				u32 tryPktCnt, u32 tryPktInterval,
+				u32 firstStageTO)
 {
 	struct cmd_obj *ph2c;
 	struct DisconnectCtrlEx_param *param;
@@ -791,6 +792,6 @@ void r8712_disconnectCtrlEx_cmd(struct _adapter *adapter, u32 enableDrvCtrl,
 	param->FirstStageTO = (unsigned int)firstStageTO;
 
 	init_h2fwcmd_w_parm_no_rsp(ph2c, param,
-				GEN_CMD_CODE(_DisconnectCtrlEx));
+				   GEN_CMD_CODE(_DisconnectCtrlEx));
 	r8712_enqueue_cmd(pcmdpriv, ph2c);
 }
diff --git a/drivers/staging/rtl8712/rtl871x_cmd.h b/drivers/staging/rtl8712/rtl871x_cmd.h
index 8453d8de8248..a3e7580d379a 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.h
+++ b/drivers/staging/rtl8712/rtl871x_cmd.h
@@ -724,7 +724,7 @@ int r8712_joinbss_cmd(struct _adapter *padapter,
 		      struct wlan_network *pnetwork);
 void r8712_disassoc_cmd(struct _adapter *padapter);
 void r8712_setopmode_cmd(struct _adapter *padapter,
-		 enum NDIS_802_11_NETWORK_INFRASTRUCTURE networktype);
+			 enum NDIS_802_11_NETWORK_INFRASTRUCTURE networktype);
 int r8712_setdatarate_cmd(struct _adapter *padapter, u8 *rateset);
 void r8712_set_chplan_cmd(struct _adapter  *padapter, int chplan);
 int r8712_getrfreg_cmd(struct _adapter *padapter, u8 offset, u8 *pval);
@@ -742,13 +742,14 @@ void r8712_createbss_cmd_callback(struct _adapter *padapter,
 void r8712_getbbrfreg_cmdrsp_callback(struct _adapter *padapter,
 				      struct cmd_obj *pcmd);
 void r8712_readtssi_cmdrsp_callback(struct _adapter *padapter,
-				struct cmd_obj *pcmd);
+				    struct cmd_obj *pcmd);
 void r8712_setstaKey_cmdrsp_callback(struct _adapter  *padapter,
 				     struct cmd_obj *pcmd);
 void r8712_setassocsta_cmdrsp_callback(struct _adapter  *padapter,
 				       struct cmd_obj *pcmd);
 void r8712_disconnectCtrlEx_cmd(struct _adapter *adapter, u32 enableDrvCtrl,
-			u32 tryPktCnt, u32 tryPktInterval, u32 firstStageTO);
+				u32 tryPktCnt, u32 tryPktInterval,
+				u32 firstStageTO);
 
 struct _cmd_callback {
 	u32	cmd_code;
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
index 36f6904d25ab..f7fe6a90cd2d 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -60,7 +60,7 @@ void r8712_indicate_wx_assoc_event(struct _adapter *padapter)
 
 	wrqu.ap_addr.sa_family = ARPHRD_ETHER;
 	memcpy(wrqu.ap_addr.sa_data, pmlmepriv->cur_network.network.MacAddress,
-		ETH_ALEN);
+	       ETH_ALEN);
 	wireless_send_event(padapter->pnetdev, SIOCGIWAP, &wrqu, NULL);
 }
 
@@ -112,7 +112,7 @@ static inline void handle_group_key(struct ieee_param *param,
 		       &param->u.crypt.key[24], 8);
 		padapter->securitypriv.binstallGrpkey = true;
 		r8712_set_key(padapter, &padapter->securitypriv,
-			param->u.crypt.idx);
+			      param->u.crypt.idx);
 		if (padapter->registrypriv.power_mgnt > PS_MODE_ACTIVE) {
 			if (padapter->registrypriv.power_mgnt !=
 			    padapter->pwrctrlpriv.pwr_mode)
@@ -149,12 +149,12 @@ static noinline_for_stack char *translate_scan_wpa(struct iw_request_info *info,
 		iwe->cmd = IWEVCUSTOM;
 		iwe->u.data.length = (u16)strlen(buf);
 		start = iwe_stream_add_point(info, start, stop,
-			iwe, buf);
+					     iwe, buf);
 		memset(iwe, 0, sizeof(*iwe));
 		iwe->cmd = IWEVGENIE;
 		iwe->u.data.length = (u16)wpa_len;
 		start = iwe_stream_add_point(info, start, stop,
-			iwe, wpa_ie);
+					     iwe, wpa_ie);
 	}
 	if (rsn_len > 0) {
 		memset(buf, 0, MAX_WPA_IE_LEN);
@@ -169,12 +169,12 @@ static noinline_for_stack char *translate_scan_wpa(struct iw_request_info *info,
 		iwe->cmd = IWEVCUSTOM;
 		iwe->u.data.length = strlen(buf);
 		start = iwe_stream_add_point(info, start, stop,
-			iwe, buf);
+					     iwe, buf);
 		memset(iwe, 0, sizeof(*iwe));
 		iwe->cmd = IWEVGENIE;
 		iwe->u.data.length = rsn_len;
 		start = iwe_stream_add_point(info, start, stop, iwe,
-			rsn_ie);
+					     rsn_ie);
 	}
 
 	return start;
@@ -190,13 +190,13 @@ static noinline_for_stack char *translate_scan_wps(struct iw_request_info *info,
 	uint wps_ielen;
 
 	if (r8712_get_wps_ie(pnetwork->network.IEs,
-	    pnetwork->network.IELength,
-	    wps_ie, &wps_ielen)) {
+			     pnetwork->network.IELength,
+			     wps_ie, &wps_ielen)) {
 		if (wps_ielen > 2) {
 			iwe->cmd = IWEVGENIE;
 			iwe->u.data.length = (u16)wps_ielen;
 			start = iwe_stream_add_point(info, start, stop,
-				iwe, wps_ie);
+						     iwe, wps_ie);
 		}
 	}
 
@@ -260,7 +260,7 @@ static char *translate_scan(struct _adapter *padapter,
 	/* Add mode */
 	iwe.cmd = SIOCGIWMODE;
 	memcpy((u8 *)&cap, r8712_get_capability_from_ie(pnetwork->network.IEs),
-		2);
+	       2);
 	le16_to_cpus(&cap);
 	if (cap & (WLAN_CAPABILITY_IBSS | WLAN_CAPABILITY_ESS)) {
 		if (cap & WLAN_CAPABILITY_ESS)
@@ -268,7 +268,7 @@ static char *translate_scan(struct _adapter *padapter,
 		else
 			iwe.u.mode = (u32)IW_MODE_ADHOC;
 		start = iwe_stream_add_event(info, start, stop, &iwe,
-			IW_EV_UINT_LEN);
+					     IW_EV_UINT_LEN);
 	}
 	/* Add frequency/channel */
 	iwe.cmd = SIOCGIWFREQ;
@@ -287,7 +287,7 @@ static char *translate_scan(struct _adapter *padapter,
 	iwe.u.freq.e = (s16)1;
 	iwe.u.freq.i = (u8)pnetwork->network.Configuration.DSConfig;
 	start = iwe_stream_add_event(info, start, stop, &iwe,
-		IW_EV_FREQ_LEN);
+				     IW_EV_FREQ_LEN);
 	/* Add encryption capability */
 	iwe.cmd = SIOCGIWENCODE;
 	if (cap & WLAN_CAPABILITY_PRIVACY)
@@ -297,7 +297,7 @@ static char *translate_scan(struct _adapter *padapter,
 		iwe.u.data.flags = (u16)(IW_ENCODE_DISABLED);
 	iwe.u.data.length = (u16)0;
 	start = iwe_stream_add_point(info, start, stop, &iwe,
-		pnetwork->network.Ssid.Ssid);
+				     pnetwork->network.Ssid.Ssid);
 	/*Add basic and extended rates */
 	current_val = start + iwe_stream_lcp_len(info);
 	iwe.cmd = SIOCGIWRATE;
@@ -310,7 +310,8 @@ static char *translate_scan(struct _adapter *padapter,
 		iwe.u.bitrate.value = (pnetwork->network.rates[i++] &
 				      0x7F) * 500000;
 		current_val = iwe_stream_add_value(info, start, current_val,
-			      stop, &iwe, IW_EV_PARAM_LEN);
+						   stop, &iwe,
+						   IW_EV_PARAM_LEN);
 	}
 	/* Check if we added any event */
 	if ((current_val - start) > iwe_stream_lcp_len(info))
@@ -490,13 +491,13 @@ static int r871x_set_wpa_ie(struct _adapter *padapter, char *pie,
 			goto exit;
 		}
 		if (r8712_parse_wpa_ie(buf, ielen, &group_cipher,
-		    &pairwise_cipher) == 0) {
+				       &pairwise_cipher) == 0) {
 			padapter->securitypriv.AuthAlgrthm = 2;
 			padapter->securitypriv.ndisauthtype =
 				  Ndis802_11AuthModeWPAPSK;
 		}
 		if (r8712_parse_wpa2_ie(buf, ielen, &group_cipher,
-		    &pairwise_cipher) == 0) {
+					&pairwise_cipher) == 0) {
 			padapter->securitypriv.AuthAlgrthm = 2;
 			padapter->securitypriv.ndisauthtype =
 				  Ndis802_11AuthModeWPA2PSK;
@@ -574,8 +575,8 @@ static int r871x_set_wpa_ie(struct _adapter *padapter, char *pie,
 					    (buf[cnt + 1] + 2) :
 					    (MAX_WPA_IE_LEN << 2);
 					memcpy(padapter->securitypriv.wps_ie,
-					    &buf[cnt],
-					    padapter->securitypriv.wps_ie_len);
+					       &buf[cnt],
+					       padapter->securitypriv.wps_ie_len);
 					padapter->securitypriv.wps_phase =
 								 true;
 					netdev_info(padapter->pnetdev, "r8712u: SET WPS_IE, wps_phase==true\n");
@@ -659,8 +660,8 @@ static int r8711_wx_set_freq(struct net_device *dev,
 
 /* If setting by frequency, convert to a channel */
 	if ((fwrq->e == 1) &&
-	  (fwrq->m >= 241200000) &&
-	  (fwrq->m <= 248700000)) {
+	    (fwrq->m >= 241200000) &&
+	    (fwrq->m <= 248700000)) {
 		int f = fwrq->m / 100000;
 		int c = 0;
 
@@ -745,7 +746,7 @@ static int r8711_wx_get_mode(struct net_device *dev, struct iw_request_info *a,
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
 		wrqu->mode = IW_MODE_INFRA;
 	else if (check_fwstate(pmlmepriv,
-		 WIFI_ADHOC_MASTER_STATE | WIFI_ADHOC_STATE))
+			       WIFI_ADHOC_MASTER_STATE | WIFI_ADHOC_STATE))
 		wrqu->mode = IW_MODE_ADHOC;
 	else if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		wrqu->mode = IW_MODE_MASTER;
@@ -755,8 +756,8 @@ static int r8711_wx_get_mode(struct net_device *dev, struct iw_request_info *a,
 }
 
 static int r871x_wx_set_pmkid(struct net_device *dev,
-			     struct iw_request_info *a,
-			     union iwreq_data *wrqu, char *extra)
+			      struct iw_request_info *a,
+			      union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
@@ -828,7 +829,7 @@ static int r871x_wx_set_pmkid(struct net_device *dev,
 		break;
 	case IW_PMKSA_FLUSH:
 		memset(psecuritypriv->PMKIDList, 0,
-			sizeof(struct RT_PMKID_LIST) * NUM_PMKID_CACHE);
+		       sizeof(struct RT_PMKID_LIST) * NUM_PMKID_CACHE);
 		psecuritypriv->PMKIDIndex = 0;
 		intReturn = true;
 		break;
@@ -851,8 +852,8 @@ static int r8711_wx_get_sens(struct net_device *dev,
 }
 
 static int r8711_wx_get_range(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
+		       	      struct iw_request_info *info,
+			      union iwreq_data *wrqu, char *extra)
 {
 	struct iw_range *range = (struct iw_range *)extra;
 	u16 val;
@@ -912,9 +913,9 @@ static int r8711_wx_get_rate(struct net_device *dev,
 			     union iwreq_data *wrqu, char *extra);
 
 static int r871x_wx_set_priv(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *awrq,
-				char *extra)
+			     struct iw_request_info *info,
+			     union iwreq_data *awrq,
+			     char *extra)
 {
 	int ret = 0, len = 0;
 	char *ext;
@@ -1000,7 +1001,7 @@ static int r871x_wx_set_priv(struct net_device *dev,
 		goto FREE_EXT;
 	}
 	if (copy_to_user(dwrq->pointer, ext,
-				min(dwrq->length, (__u16)(strlen(ext) + 1))))
+			 min(dwrq->length, (__u16)(strlen(ext) + 1))))
 		ret = -EFAULT;
 
 FREE_EXT:
@@ -1022,9 +1023,9 @@ static int r871x_wx_set_priv(struct net_device *dev,
  *
  */
 static int r8711_wx_set_wap(struct net_device *dev,
-			 struct iw_request_info *info,
-			 union iwreq_data *awrq,
-			 char *extra)
+			    struct iw_request_info *info,
+			    union iwreq_data *awrq,
+			    char *extra)
 {
 	int ret = -EINPROGRESS;
 	struct _adapter *padapter = netdev_priv(dev);
@@ -1073,8 +1074,8 @@ static int r8711_wx_set_wap(struct net_device *dev,
 }
 
 static int r8711_wx_get_wap(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -1123,8 +1124,8 @@ static int r871x_wx_set_mlme(struct net_device *dev,
  *
  */
 static int r8711_wx_set_scan(struct net_device *dev,
-			struct iw_request_info *a,
-			union iwreq_data *wrqu, char *extra)
+			     struct iw_request_info *a,
+			     union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -1151,7 +1152,7 @@ static int r8711_wx_set_scan(struct net_device *dev,
 			u32 len = min_t(u8, req->essid_len, IW_ESSID_MAX_SIZE);
 
 			memset((unsigned char *)&ssid, 0,
-				 sizeof(struct ndis_802_11_ssid));
+			       sizeof(struct ndis_802_11_ssid));
 			memcpy(ssid.Ssid, req->essid, len);
 			ssid.SsidLength = len;
 			spin_lock_irqsave(&pmlmepriv->lock, irqL);
@@ -1174,8 +1175,8 @@ static int r8711_wx_set_scan(struct net_device *dev,
 }
 
 static int r8711_wx_get_scan(struct net_device *dev,
-				struct iw_request_info *a,
-				union iwreq_data *wrqu, char *extra)
+		             struct iw_request_info *a,
+			     union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -1229,8 +1230,8 @@ static int r8711_wx_get_scan(struct net_device *dev,
  *
  */
 static int r8711_wx_set_essid(struct net_device *dev,
-				struct iw_request_info *a,
-				union iwreq_data *wrqu, char *extra)
+			      struct iw_request_info *a,
+			      union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -1269,7 +1270,7 @@ static int r8711_wx_set_essid(struct net_device *dev,
 			    && (pnetwork->network.Ssid.SsidLength ==
 			     ndis_ssid.SsidLength)) {
 				if (check_fwstate(pmlmepriv,
-							WIFI_ADHOC_STATE)) {
+						  WIFI_ADHOC_STATE)) {
 					if (pnetwork->network.
 						InfrastructureMode
 						!=
@@ -1292,8 +1293,8 @@ static int r8711_wx_set_essid(struct net_device *dev,
 }
 
 static int r8711_wx_get_essid(struct net_device *dev,
-				struct iw_request_info *a,
-				union iwreq_data *wrqu, char *extra)
+			      struct iw_request_info *a,
+			      union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -1312,8 +1313,8 @@ static int r8711_wx_get_essid(struct net_device *dev,
 }
 
 static int r8711_wx_set_rate(struct net_device *dev,
-				struct iw_request_info *a,
-				union iwreq_data *wrqu, char *extra)
+			     struct iw_request_info *a,
+			     union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 	u32 target_rate = wrqu->bitrate.value;
@@ -1438,8 +1439,8 @@ static int r8711_wx_get_rate(struct net_device *dev,
 }
 
 static int r8711_wx_get_rts(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 
@@ -1449,8 +1450,8 @@ static int r8711_wx_get_rts(struct net_device *dev,
 }
 
 static int r8711_wx_set_frag(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
+			     struct iw_request_info *info,
+			     union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 
-- 
2.30.2


