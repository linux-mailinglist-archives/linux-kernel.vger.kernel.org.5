Return-Path: <linux-kernel+bounces-7380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CFC81A701
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 19:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0DCB1C232A5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AD3482D7;
	Wed, 20 Dec 2023 18:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4u7B8Gk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AAC1EA91
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3b86057b5b2so579449b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 10:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703098114; x=1703702914; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d7mGp1hR83ElfGWQ0fsDd19LRYHvYWUjJ6U/u4PZnlI=;
        b=C4u7B8GkUk4j9yCqFd5Ytw1zkIzTSrjlj7J1lmNsAKG8OSFtFrhsu5GE5nzSwLCPDM
         NTEn9QOLoU3ePI3kIXMUK4zRjnt6hE9Jhh/ZUSl0kyEETv+mtXToAeIpSPjRm86GRGT5
         tGSRpnqXoTLYvYn0OItmB7D0wTuU9m3zwfjZD36nAiVxeZX81AFZyKNSFFJtKq0I+lMY
         bpveHfxCq/dG0PV5uaFBRpTZsU2OHfvxFg4tUrZC01olon3JkseHrgesAj9YDKUkyVM9
         pGzI1jpNSxOcedlUNGpcKKkvx9Vsp7WaVVs1VDlCksLLGPAlZYL8DGseU5yoRbwX7MSJ
         oIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703098114; x=1703702914;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d7mGp1hR83ElfGWQ0fsDd19LRYHvYWUjJ6U/u4PZnlI=;
        b=ufYBJ4CFtl+LT74ytNEWFtUX2ADB93YM03xDmIvvApELbAaZeg41IEpXB2hK01xrCQ
         1A+h6bKP+4+p6wp/3GOZ9SlYbSTkpZ3SSEcRx1QJTzAMG+joTlDY/n3/VHPfHhS+2nJs
         WQVghgCXWpQC92UDkOvym8w9if0/DNFBic5EnSirl4jq6ZLlo2Ie1JxYlVdFXbfYDkxt
         aYbzcdGJLNpJFJ6mZ3fVLmFNQQ98gN8umXQPwL+1vezLA9mhwqEVgDGX/fZBPNVxzCW2
         t9daa+BBnbBZLqieWLGyHaO1vbYQGHONE4w6JD3+/A+LAzIVpy/2y+NNzRMPTDGZ8wRv
         AzhA==
X-Gm-Message-State: AOJu0YwqmvKsYtrXEwONuQGxQ73AWBDL76vRfvPULI/qQgrOymzFBGZV
	CVeVhFQdrLoXau+GJFL1TfW/pLtFL/Rbig==
X-Google-Smtp-Source: AGHT+IH7aYuqvjLXZhdMSqj+P2y/jtdDINg88sAobgWP++SVbA0t9t3k1RKOsUEjJ+6O75dZiahqWQ==
X-Received: by 2002:a54:4717:0:b0:3bb:73fe:daeb with SMTP id k23-20020a544717000000b003bb73fedaebmr1400255oik.4.1703098114012;
        Wed, 20 Dec 2023 10:48:34 -0800 (PST)
Received: from kernel.ryanengland.xyz ([2600:3c05::f03c:94ff:fea1:5b99])
        by smtp.gmail.com with ESMTPSA id h19-20020a0ceed3000000b0067f5ae87e54sm94664qvs.4.2023.12.20.10.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 10:48:32 -0800 (PST)
Date: Wed, 20 Dec 2023 18:48:32 +0000
From: Ryan England <rcengland@gmail.com>
To: Larry Finger <Larry.Finger@lwfinger.net>,
	Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: [PATCH v2] staging: rtl8712: fix open parentheses alignment
Message-ID: <ZYM3APIhUHxupDnq@kernel.ryanengland.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Made corrections given we have 100 lines. Thanks for the update.

Adhere to Linux kernel coding style.

Reported by checkpatch:

CHECK: Alignment should match open parenthesis

Signed-off-by: Ryan England <rcengland@gmail.com>
---
 drivers/staging/rtl8712/os_intfs.c            |   3 +-
 drivers/staging/rtl8712/rtl8712_efuse.c       |   9 +-
 drivers/staging/rtl8712/rtl8712_recv.c        |   3 +-
 drivers/staging/rtl8712/rtl8712_xmit.c        |  60 +++---
 drivers/staging/rtl8712/rtl871x_cmd.c         | 159 +++++---------
 drivers/staging/rtl8712/rtl871x_cmd.h         |  37 ++--
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 203 +++++++-----------
 7 files changed, 173 insertions(+), 301 deletions(-)

diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index b18e6d9c832b..7554613fe7e1 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -221,8 +221,7 @@ struct net_device *r8712_init_netdev(void)
 
 static u32 start_drv_threads(struct _adapter *padapter)
 {
-	padapter->cmd_thread = kthread_run(r8712_cmd_thread, padapter, "%s",
-					  padapter->pnetdev->name);
+	padapter->cmd_thread = kthread_run(r8712_cmd_thread, padapter, "%s", padapter->pnetdev->name);
 	if (IS_ERR(padapter->cmd_thread))
 		return _FAIL;
 	return _SUCCESS;
diff --git a/drivers/staging/rtl8712/rtl8712_efuse.c b/drivers/staging/rtl8712/rtl8712_efuse.c
index c9400e40a1d6..a39d6c06648f 100644
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
@@ -252,9 +252,8 @@ u8 r8712_efuse_pg_packet_read(struct _adapter *adapter, u8 offset, u8 *data)
 				memset(tmpdata, 0xFF, PGPKT_DATA_SIZE);
 				for (tmpidx = 0; tmpidx < word_cnts * 2;
 				     tmpidx++) {
-					if (efuse_one_byte_read(adapter,
-					    efuse_addr + 1 + tmpidx,
-					    &efuse_data)) {
+					if (efuse_one_byte_read(adapter, efuse_addr + 1 + tmpidx,
+								&efuse_data)) {
 						tmpdata[tmpidx] = efuse_data;
 					} else {
 						ret = false;
diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
index 7da014ab0723..a3c4713c59b3 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.c
+++ b/drivers/staging/rtl8712/rtl8712_recv.c
@@ -267,8 +267,7 @@ union recv_frame *r8712_recvframe_chk_defrag(struct _adapter *padapter,
 				/*the first fragment*/
 				if (!list_empty(&pdefrag_q->queue)) {
 					/*free current defrag_q */
-					r8712_free_recvframe_queue(pdefrag_q,
-							     pfree_recv_queue);
+					r8712_free_recvframe_queue(pdefrag_q, pfree_recv_queue);
 				}
 			}
 			/* Then enqueue the 0~(n-1) fragment to the defrag_q */
diff --git a/drivers/staging/rtl8712/rtl8712_xmit.c b/drivers/staging/rtl8712/rtl8712_xmit.c
index 4cb01f590673..d7d678b04ca8 100644
--- a/drivers/staging/rtl8712/rtl8712_xmit.c
+++ b/drivers/staging/rtl8712/rtl8712_xmit.c
@@ -147,9 +147,8 @@ static u32 get_ff_hwaddr(struct xmit_frame *pxmitframe)
 }
 
 static struct xmit_frame *dequeue_one_xmitframe(struct xmit_priv *pxmitpriv,
-					 struct hw_xmit *phwxmit,
-					 struct tx_servq *ptxservq,
-					 struct  __queue *pframe_queue)
+						struct hw_xmit *phwxmit, struct tx_servq *ptxservq,
+						struct  __queue *pframe_queue)
 {
 	struct list_head *xmitframe_plist, *xmitframe_phead;
 	struct	xmit_frame *pxmitframe = NULL;
@@ -167,7 +166,7 @@ static struct xmit_frame *dequeue_one_xmitframe(struct xmit_priv *pxmitpriv,
 }
 
 static struct xmit_frame *dequeue_xframe_ex(struct xmit_priv *pxmitpriv,
-				     struct hw_xmit *phwxmit_i, sint entry)
+					    struct hw_xmit *phwxmit_i, sint entry)
 {
 	unsigned long irqL0;
 	struct list_head *sta_plist, *sta_phead;
@@ -197,11 +196,10 @@ static struct xmit_frame *dequeue_xframe_ex(struct xmit_priv *pxmitpriv,
 		sta_phead = &phwxmit->sta_queue->queue;
 		sta_plist = sta_phead->next;
 		while (!end_of_queue_search(sta_phead, sta_plist)) {
-			ptxservq = container_of(sta_plist, struct tx_servq,
-						tx_pending);
+			ptxservq = container_of(sta_plist, struct tx_servq, tx_pending);
 			pframe_queue = &ptxservq->sta_pending;
-			pxmitframe = dequeue_one_xmitframe(pxmitpriv, phwxmit,
-				     ptxservq, pframe_queue);
+			pxmitframe = dequeue_one_xmitframe(pxmitpriv, phwxmit, ptxservq,
+							   pframe_queue);
 			if (pxmitframe) {
 				phwxmit->accnt--;
 				goto exit_dequeue_xframe_ex;
@@ -221,8 +219,7 @@ static struct xmit_frame *dequeue_xframe_ex(struct xmit_priv *pxmitpriv,
 	return pxmitframe;
 }
 
-void r8712_do_queue_select(struct _adapter *padapter,
-			   struct pkt_attrib *pattrib)
+void r8712_do_queue_select(struct _adapter *padapter, struct pkt_attrib *pattrib)
 {
 	unsigned int qsel = 0;
 	struct dvobj_priv *pdvobj = &padapter->dvobjpriv;
@@ -292,14 +289,12 @@ void r8712_append_mpdu_unit(struct xmit_buf *pxmitbuf,
 	r8712_xmit_complete(padapter, pxmitframe);
 	if (pxmitframe->attrib.ether_type != 0x0806) {
 		if ((pxmitframe->attrib.ether_type != 0x888e) &&
-			(pxmitframe->attrib.dhcp_pkt != 1)) {
-			r8712_issue_addbareq_cmd(padapter,
-					pxmitframe->attrib.priority);
+		    (pxmitframe->attrib.dhcp_pkt != 1)) {
+			r8712_issue_addbareq_cmd(padapter, pxmitframe->attrib.priority);
 		}
 	}
 	pxmitframe->last[0] = 1;
-	update_txdesc(pxmitframe, (uint *)(pxmitframe->buf_addr),
-		pxmitframe->attrib.last_txcmdsz);
+	update_txdesc(pxmitframe, (uint *)(pxmitframe->buf_addr), pxmitframe->attrib.last_txcmdsz);
 	/*padding zero */
 	last_txcmdsz = pxmitframe->attrib.last_txcmdsz;
 	padding_sz = (8 - (last_txcmdsz % 8));
@@ -333,8 +328,7 @@ void r8712_xmitframe_aggr_1st(struct xmit_buf *pxmitbuf,
 	pxmitbuf->aggr_nr = 1;
 }
 
-u16 r8712_xmitframe_aggr_next(struct xmit_buf *pxmitbuf,
-			struct xmit_frame *pxmitframe)
+u16 r8712_xmitframe_aggr_next(struct xmit_buf *pxmitbuf, struct xmit_frame *pxmitframe)
 {
 	pxmitframe->pxmitbuf = pxmitbuf;
 	pxmitbuf->priv_data = pxmitframe;
@@ -374,9 +368,9 @@ void r8712_dump_aggr_xframe(struct xmit_buf *pxmitbuf,
 	pxmitframe->bpending[0] = false;
 	pxmitframe->mem_addr = pxmitbuf->pbuf;
 
-	if ((pdvobj->ishighspeed && ((total_length + TXDESC_SIZE) % 0x200) ==
-	     0) || ((!pdvobj->ishighspeed && ((total_length + TXDESC_SIZE) %
-					      0x40) == 0))) {
+	if ((pdvobj->ishighspeed && ((total_length + TXDESC_SIZE) % 0x200) == 0) ||
+	    ((!pdvobj->ishighspeed && ((total_length + TXDESC_SIZE) %
+	    0x40) == 0))) {
 		ptxdesc->txdw0 |= cpu_to_le32
 			(((TXDESC_SIZE + OFFSET_SZ + 8) << OFFSET_SHT) &
 			 0x00ff0000);
@@ -387,8 +381,8 @@ void r8712_dump_aggr_xframe(struct xmit_buf *pxmitbuf,
 			 0x00ff0000);
 		/*default = 32 bytes for TX Desc*/
 	}
-	r8712_write_port(pxmitframe->padapter, RTL8712_DMA_H2CCMD,
-			total_length + TXDESC_SIZE, (u8 *)pxmitframe);
+	r8712_write_port(pxmitframe->padapter, RTL8712_DMA_H2CCMD, total_length + TXDESC_SIZE,
+			 (u8 *)pxmitframe);
 }
 
 #endif
@@ -618,14 +612,12 @@ int r8712_xmitframe_complete(struct _adapter *padapter,
 	pxmitframe = dequeue_xframe_ex(pxmitpriv, phwxmits, hwentry);
 	/* need to remember the 1st frame */
 	if (pxmitframe) {
-
 #ifdef CONFIG_R8712_TX_AGGR
 		/* 1. dequeue 2nd frame
 		 * 2. aggr if 2nd xframe is dequeued, else dump directly
 		 */
 		if (AGGR_NR_HIGH_BOUND > 1)
-			p2ndxmitframe = dequeue_xframe_ex(pxmitpriv, phwxmits,
-							hwentry);
+			p2ndxmitframe = dequeue_xframe_ex(pxmitpriv, phwxmits, hwentry);
 		if (pxmitframe->frame_tag != DATA_FRAMETAG) {
 			r8712_free_xmitbuf(pxmitpriv, pxmitbuf);
 			return false;
@@ -639,16 +631,12 @@ int r8712_xmitframe_complete(struct _adapter *padapter,
 		if (p2ndxmitframe) {
 			u16 total_length;
 
-			total_length = r8712_xmitframe_aggr_next(
-				pxmitbuf, p2ndxmitframe);
+			total_length = r8712_xmitframe_aggr_next(pxmitbuf, p2ndxmitframe);
 			do {
-				p2ndxmitframe = dequeue_xframe_ex(
-					pxmitpriv, phwxmits, hwentry);
+				p2ndxmitframe = dequeue_xframe_ex(pxmitpriv, phwxmits, hwentry);
 				if (p2ndxmitframe)
 					total_length =
-						r8712_xmitframe_aggr_next(
-							pxmitbuf,
-							p2ndxmitframe);
+						r8712_xmitframe_aggr_next(pxmitbuf, p2ndxmitframe);
 				else
 					break;
 			} while (total_length <= 0x1800 &&
@@ -662,8 +650,8 @@ int r8712_xmitframe_complete(struct _adapter *padapter,
 		xmitframe_xmitbuf_attach(pxmitframe, pxmitbuf);
 		if (pxmitframe->frame_tag == DATA_FRAMETAG) {
 			if (pxmitframe->attrib.priority <= 15)
-				res = r8712_xmitframe_coalesce(padapter,
-					pxmitframe->pkt, pxmitframe);
+				res = r8712_xmitframe_coalesce(padapter, pxmitframe->pkt,
+							       pxmitframe);
 			/* always return ndis_packet after
 			 * r8712_xmitframe_coalesce
 			 */
@@ -714,10 +702,10 @@ static void dump_xframe(struct _adapter *padapter,
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
index 4be96df5a329..bbd4a13c7bb9 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.c
+++ b/drivers/staging/rtl8712/rtl871x_cmd.c
@@ -242,8 +242,7 @@ void r8712_set_chplan_cmd(struct _adapter *padapter, int chplan)
 		kfree(ph2c);
 		return;
 	}
-	init_h2fwcmd_w_parm_no_rsp(ph2c, psetchplanpara,
-				GEN_CMD_CODE(_SetChannelPlan));
+	init_h2fwcmd_w_parm_no_rsp(ph2c, psetchplanpara, GEN_CMD_CODE(_SetChannelPlan));
 	psetchplanpara->ChannelPlan = chplan;
 	r8712_enqueue_cmd(pcmdpriv, ph2c);
 }
@@ -302,8 +301,7 @@ void r8712_getbbrfreg_cmdrsp_callback(struct _adapter *padapter,
 	padapter->mppriv.workparam.bcompleted = true;
 }
 
-void r8712_readtssi_cmdrsp_callback(struct _adapter *padapter,
-				struct cmd_obj *pcmd)
+void r8712_readtssi_cmdrsp_callback(struct _adapter *padapter, struct cmd_obj *pcmd)
 {
 	kfree(pcmd->parmbuf);
 	kfree(pcmd);
@@ -374,11 +372,10 @@ int r8712_joinbss_cmd(struct _adapter  *padapter, struct wlan_network *pnetwork)
 	psecuritypriv->authenticator_ie[0] = (unsigned char)
 					     psecnetwork->IELength;
 	if ((psecnetwork->IELength - 12) < (256 - 1))
-		memcpy(&psecuritypriv->authenticator_ie[1],
-			&psecnetwork->IEs[12], psecnetwork->IELength - 12);
+		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->IEs[12],
+		       psecnetwork->IELength - 12);
 	else
-		memcpy(&psecuritypriv->authenticator_ie[1],
-			&psecnetwork->IEs[12], (256 - 1));
+		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->IEs[12], (256 - 1));
 	psecnetwork->IELength = 0;
 	/*
 	 * If the driver wants to use the bssid to create the connection.
@@ -388,19 +385,15 @@ int r8712_joinbss_cmd(struct _adapter  *padapter, struct wlan_network *pnetwork)
 	if (!pmlmepriv->assoc_by_bssid)
 		ether_addr_copy(&pmlmepriv->assoc_bssid[0],
 				&pnetwork->network.MacAddress[0]);
-	psecnetwork->IELength = r8712_restruct_sec_ie(padapter,
-						&pnetwork->network.IEs[0],
-						&psecnetwork->IEs[0],
-						pnetwork->network.IELength);
+	psecnetwork->IELength = r8712_restruct_sec_ie(padapter, &pnetwork->network.IEs[0],
+						      &psecnetwork->IEs[0], pnetwork->network.IELength);
 	pqospriv->qos_option = 0;
 	if (pregistrypriv->wmm_enable) {
 		u32 tmp_len;
 
-		tmp_len = r8712_restruct_wmm_ie(padapter,
-					  &pnetwork->network.IEs[0],
-					  &psecnetwork->IEs[0],
-					  pnetwork->network.IELength,
-					  psecnetwork->IELength);
+		tmp_len = r8712_restruct_wmm_ie(padapter, &pnetwork->network.IEs[0],
+						&psecnetwork->IEs[0], pnetwork->network.IELength,
+						psecnetwork->IELength);
 		if (psecnetwork->IELength != tmp_len) {
 			psecnetwork->IELength = tmp_len;
 			pqospriv->qos_option = 1; /* WMM IE in beacon */
@@ -427,39 +420,28 @@ int r8712_joinbss_cmd(struct _adapter  *padapter, struct wlan_network *pnetwork)
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
-	psecnetwork->Ssid.SsidLength = cpu_to_le32(
-				       psecnetwork->Ssid.SsidLength);
+	psecnetwork->Ssid.SsidLength = cpu_to_le32(psecnetwork->Ssid.SsidLength);
 	psecnetwork->Privacy = cpu_to_le32(psecnetwork->Privacy);
 	psecnetwork->Rssi = cpu_to_le32(psecnetwork->Rssi);
-	psecnetwork->NetworkTypeInUse = cpu_to_le32(
-					psecnetwork->NetworkTypeInUse);
-	psecnetwork->Configuration.ATIMWindow = cpu_to_le32(
-				psecnetwork->Configuration.ATIMWindow);
-	psecnetwork->Configuration.BeaconPeriod = cpu_to_le32(
-				 psecnetwork->Configuration.BeaconPeriod);
-	psecnetwork->Configuration.DSConfig = cpu_to_le32(
-				psecnetwork->Configuration.DSConfig);
-	psecnetwork->Configuration.FHConfig.DwellTime = cpu_to_le32(
-				psecnetwork->Configuration.FHConfig.DwellTime);
-	psecnetwork->Configuration.FHConfig.HopPattern = cpu_to_le32(
-				psecnetwork->Configuration.FHConfig.HopPattern);
-	psecnetwork->Configuration.FHConfig.HopSet = cpu_to_le32(
-				psecnetwork->Configuration.FHConfig.HopSet);
-	psecnetwork->Configuration.FHConfig.Length = cpu_to_le32(
-				psecnetwork->Configuration.FHConfig.Length);
-	psecnetwork->Configuration.Length = cpu_to_le32(
-				psecnetwork->Configuration.Length);
-	psecnetwork->InfrastructureMode = cpu_to_le32(
-				psecnetwork->InfrastructureMode);
+	psecnetwork->NetworkTypeInUse = cpu_to_le32(psecnetwork->NetworkTypeInUse);
+	psecnetwork->Configuration.ATIMWindow = cpu_to_le32(psecnetwork->Configuration.ATIMWindow);
+	psecnetwork->Configuration.BeaconPeriod = cpu_to_le32(psecnetwork->Configuration.BeaconPeriod);
+	psecnetwork->Configuration.DSConfig = cpu_to_le32(psecnetwork->Configuration.DSConfig);
+	psecnetwork->Configuration.FHConfig.DwellTime = cpu_to_le32(psecnetwork->Configuration.FHConfig.DwellTime);
+	psecnetwork->Configuration.FHConfig.HopPattern = cpu_to_le32(psecnetwork->Configuration.FHConfig.HopPattern);
+	psecnetwork->Configuration.FHConfig.HopSet = cpu_to_le32(psecnetwork->Configuration.FHConfig.HopSet);
+	psecnetwork->Configuration.FHConfig.Length = cpu_to_le32(psecnetwork->Configuration.FHConfig.Length);
+	psecnetwork->Configuration.Length = cpu_to_le32(psecnetwork->Configuration.Length);
+	psecnetwork->InfrastructureMode = cpu_to_le32(psecnetwork->InfrastructureMode);
 	psecnetwork->IELength = cpu_to_le32(psecnetwork->IELength);
 #endif
 	INIT_LIST_HEAD(&pcmd->list);
@@ -485,13 +467,12 @@ void r8712_disassoc_cmd(struct _adapter *padapter) /* for sta_mode */
 		kfree(pdisconnect_cmd);
 		return;
 	}
-	init_h2fwcmd_w_parm_no_rsp(pdisconnect_cmd, pdisconnect,
-				   _DisConnect_CMD_);
+	init_h2fwcmd_w_parm_no_rsp(pdisconnect_cmd, pdisconnect, _DisConnect_CMD_);
 	r8712_enqueue_cmd(pcmdpriv, pdisconnect_cmd);
 }
 
 void r8712_setopmode_cmd(struct _adapter *padapter,
-		 enum NDIS_802_11_NETWORK_INFRASTRUCTURE networktype)
+			 enum NDIS_802_11_NETWORK_INFRASTRUCTURE networktype)
 {
 	struct cmd_obj *ph2c;
 	struct setopmode_parm *psetop;
@@ -543,14 +524,12 @@ void r8712_setstakey_cmd(struct _adapter *padapter, u8 *psta, u8 unicast_key)
 		psetstakey_para->algorithm = (unsigned char)
 					    psecuritypriv->PrivacyAlgrthm;
 	else
-		GET_ENCRY_ALGO(psecuritypriv, sta,
-			       psetstakey_para->algorithm, false);
+		GET_ENCRY_ALGO(psecuritypriv, sta, psetstakey_para->algorithm, false);
 	if (unicast_key)
 		memcpy(&psetstakey_para->key, &sta->x_UncstKey, 16);
 	else
-		memcpy(&psetstakey_para->key,
-			&psecuritypriv->XGrpKey[
-			psecuritypriv->XGrpKeyid - 1]. skey, 16);
+		memcpy(&psetstakey_para->key, &psecuritypriv->XGrpKey[psecuritypriv->XGrpKeyid - 1].
+		       skey, 16);
 	r8712_enqueue_cmd(pcmdpriv, ph2c);
 }
 
@@ -568,8 +547,7 @@ void r8712_setMacAddr_cmd(struct _adapter *padapter, const u8 *mac_addr)
 		kfree(ph2c);
 		return;
 	}
-	init_h2fwcmd_w_parm_no_rsp(ph2c, psetMacAddr_para,
-				   _SetMacAddress_CMD_);
+	init_h2fwcmd_w_parm_no_rsp(ph2c, psetMacAddr_para, _SetMacAddress_CMD_);
 	ether_addr_copy(psetMacAddr_para->MacAddr, mac_addr);
 	r8712_enqueue_cmd(pcmdpriv, ph2c);
 }
@@ -589,8 +567,7 @@ void r8712_addbareq_cmd(struct _adapter *padapter, u8 tid)
 		return;
 	}
 	paddbareq_parm->tid = tid;
-	init_h2fwcmd_w_parm_no_rsp(ph2c, paddbareq_parm,
-				   GEN_CMD_CODE(_AddBAReq));
+	init_h2fwcmd_w_parm_no_rsp(ph2c, paddbareq_parm, GEN_CMD_CODE(_AddBAReq));
 	r8712_enqueue_cmd_ex(pcmdpriv, ph2c);
 }
 
@@ -644,13 +621,11 @@ void r8712_joinbss_cmd_callback(struct _adapter *padapter, struct cmd_obj *pcmd)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	if (pcmd->res != H2C_SUCCESS)
-		mod_timer(&pmlmepriv->assoc_timer,
-			  jiffies + msecs_to_jiffies(1));
+		mod_timer(&pmlmepriv->assoc_timer, jiffies + msecs_to_jiffies(1));
 	r8712_free_cmd_obj(pcmd);
 }
 
-void r8712_createbss_cmd_callback(struct _adapter *padapter,
-				  struct cmd_obj *pcmd)
+void r8712_createbss_cmd_callback(struct _adapter *padapter, struct cmd_obj *pcmd)
 {
 	unsigned long irqL;
 	struct sta_info *psta = NULL;
@@ -660,8 +635,7 @@ void r8712_createbss_cmd_callback(struct _adapter *padapter,
 	struct wlan_network *tgt_network = &(pmlmepriv->cur_network);
 
 	if (pcmd->res != H2C_SUCCESS)
-		mod_timer(&pmlmepriv->assoc_timer,
-			  jiffies + msecs_to_jiffies(1));
+		mod_timer(&pmlmepriv->assoc_timer, jiffies + msecs_to_jiffies(1));
 	del_timer(&pmlmepriv->assoc_timer);
 #ifdef __BIG_ENDIAN
 	/* endian_convert */
@@ -670,31 +644,21 @@ void r8712_createbss_cmd_callback(struct _adapter *padapter,
 	pnetwork->Privacy = le32_to_cpu(pnetwork->Privacy);
 	pnetwork->Rssi = le32_to_cpu(pnetwork->Rssi);
 	pnetwork->NetworkTypeInUse = le32_to_cpu(pnetwork->NetworkTypeInUse);
-	pnetwork->Configuration.ATIMWindow =
-		le32_to_cpu(pnetwork->Configuration.ATIMWindow);
-	pnetwork->Configuration.DSConfig =
-		le32_to_cpu(pnetwork->Configuration.DSConfig);
-	pnetwork->Configuration.FHConfig.DwellTime =
-		le32_to_cpu(pnetwork->Configuration.FHConfig.DwellTime);
-	pnetwork->Configuration.FHConfig.HopPattern =
-		le32_to_cpu(pnetwork->Configuration.FHConfig.HopPattern);
-	pnetwork->Configuration.FHConfig.HopSet =
-		le32_to_cpu(pnetwork->Configuration.FHConfig.HopSet);
-	pnetwork->Configuration.FHConfig.Length =
-		le32_to_cpu(pnetwork->Configuration.FHConfig.Length);
-	pnetwork->Configuration.Length =
-		le32_to_cpu(pnetwork->Configuration.Length);
-	pnetwork->InfrastructureMode =
-		le32_to_cpu(pnetwork->InfrastructureMode);
+	pnetwork->Configuration.ATIMWindow = le32_to_cpu(pnetwork->Configuration.ATIMWindow);
+	pnetwork->Configuration.DSConfig = le32_to_cpu(pnetwork->Configuration.DSConfig);
+	pnetwork->Configuration.FHConfig.DwellTime = le32_to_cpu(pnetwork->Configuration.FHConfig.DwellTime);
+	pnetwork->Configuration.FHConfig.HopPattern = le32_to_cpu(pnetwork->Configuration.FHConfig.HopPattern);
+	pnetwork->Configuration.FHConfig.HopSet = le32_to_cpu(pnetwork->Configuration.FHConfig.HopSet);
+	pnetwork->Configuration.FHConfig.Length = le32_to_cpu(pnetwork->Configuration.FHConfig.Length);
+	pnetwork->Configuration.Length = le32_to_cpu(pnetwork->Configuration.Length);
+	pnetwork->InfrastructureMode = le32_to_cpu(pnetwork->InfrastructureMode);
 	pnetwork->IELength = le32_to_cpu(pnetwork->IELength);
 #endif
 	spin_lock_irqsave(&pmlmepriv->lock, irqL);
 	if ((pmlmepriv->fw_state) & WIFI_AP_STATE) {
-		psta = r8712_get_stainfo(&padapter->stapriv,
-					 pnetwork->MacAddress);
+		psta = r8712_get_stainfo(&padapter->stapriv, pnetwork->MacAddress);
 		if (!psta) {
-			psta = r8712_alloc_stainfo(&padapter->stapriv,
-						   pnetwork->MacAddress);
+			psta = r8712_alloc_stainfo(&padapter->stapriv, pnetwork->MacAddress);
 			if (!psta)
 				goto createbss_cmd_fail;
 		}
@@ -702,20 +666,17 @@ void r8712_createbss_cmd_callback(struct _adapter *padapter,
 	} else {
 		pwlan = _r8712_alloc_network(pmlmepriv);
 		if (!pwlan) {
-			pwlan = r8712_get_oldest_wlan_network(
-				&pmlmepriv->scanned_queue);
+			pwlan = r8712_get_oldest_wlan_network(&pmlmepriv->scanned_queue);
 			if (!pwlan)
 				goto createbss_cmd_fail;
 			pwlan->last_scanned = jiffies;
 		} else {
-			list_add_tail(&(pwlan->list),
-					 &pmlmepriv->scanned_queue.queue);
+			list_add_tail(&(pwlan->list), &pmlmepriv->scanned_queue.queue);
 		}
 		pnetwork->Length = r8712_get_wlan_bssid_ex_sz(pnetwork);
 		memcpy(&(pwlan->network), pnetwork, pnetwork->Length);
 		pwlan->fixed = true;
-		memcpy(&tgt_network->network, pnetwork,
-			(r8712_get_wlan_bssid_ex_sz(pnetwork)));
+		memcpy(&tgt_network->network, pnetwork, (r8712_get_wlan_bssid_ex_sz(pnetwork)));
 		if (pmlmepriv->fw_state & _FW_UNDER_LINKING)
 			pmlmepriv->fw_state ^= _FW_UNDER_LINKING;
 		/*
@@ -728,14 +689,11 @@ void r8712_createbss_cmd_callback(struct _adapter *padapter,
 	r8712_free_cmd_obj(pcmd);
 }
 
-void r8712_setstaKey_cmdrsp_callback(struct _adapter *padapter,
-				     struct cmd_obj *pcmd)
+void r8712_setstaKey_cmdrsp_callback(struct _adapter *padapter, struct cmd_obj *pcmd)
 {
 	struct sta_priv *pstapriv = &padapter->stapriv;
-	struct set_stakey_rsp *psetstakey_rsp = (struct set_stakey_rsp *)
-						(pcmd->rsp);
-	struct sta_info *psta = r8712_get_stainfo(pstapriv,
-						  psetstakey_rsp->addr);
+	struct set_stakey_rsp *psetstakey_rsp = (struct set_stakey_rsp *) (pcmd->rsp);
+	struct sta_info *psta = r8712_get_stainfo(pstapriv, psetstakey_rsp->addr);
 
 	if (!psta)
 		goto exit;
@@ -750,27 +708,23 @@ void r8712_setassocsta_cmdrsp_callback(struct _adapter *padapter,
 	unsigned long	irqL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct set_assocsta_parm *passocsta_parm =
-				(struct set_assocsta_parm *)(pcmd->parmbuf);
-	struct set_assocsta_rsp *passocsta_rsp =
-				(struct set_assocsta_rsp *) (pcmd->rsp);
-	struct sta_info *psta = r8712_get_stainfo(pstapriv,
-						  passocsta_parm->addr);
+	struct set_assocsta_parm *passocsta_parm = (struct set_assocsta_parm *)(pcmd->parmbuf);
+	struct set_assocsta_rsp *passocsta_rsp = (struct set_assocsta_rsp *) (pcmd->rsp);
+	struct sta_info *psta = r8712_get_stainfo(pstapriv, passocsta_parm->addr);
 
 	if (!psta)
 		return;
 	psta->aid = psta->mac_id = passocsta_rsp->cam_id;
 	spin_lock_irqsave(&pmlmepriv->lock, irqL);
-	if ((check_fwstate(pmlmepriv, WIFI_MP_STATE)) &&
-	    (check_fwstate(pmlmepriv, _FW_UNDER_LINKING)))
+	if ((check_fwstate(pmlmepriv, WIFI_MP_STATE)) && (check_fwstate(pmlmepriv, _FW_UNDER_LINKING)))
 		pmlmepriv->fw_state ^= _FW_UNDER_LINKING;
 	set_fwstate(pmlmepriv, _FW_LINKED);
 	spin_unlock_irqrestore(&pmlmepriv->lock, irqL);
 	r8712_free_cmd_obj(pcmd);
 }
 
-void r8712_disconnectCtrlEx_cmd(struct _adapter *adapter, u32 enableDrvCtrl,
-			u32 tryPktCnt, u32 tryPktInterval, u32 firstStageTO)
+void r8712_disconnectCtrlEx_cmd(struct _adapter *adapter, u32 enableDrvCtrl, u32 tryPktCnt,
+				u32 tryPktInterval, u32 firstStageTO)
 {
 	struct cmd_obj *ph2c;
 	struct DisconnectCtrlEx_param *param;
@@ -790,7 +744,6 @@ void r8712_disconnectCtrlEx_cmd(struct _adapter *adapter, u32 enableDrvCtrl,
 	param->TryPktInterval = (unsigned char)tryPktInterval;
 	param->FirstStageTO = (unsigned int)firstStageTO;
 
-	init_h2fwcmd_w_parm_no_rsp(ph2c, param,
-				GEN_CMD_CODE(_DisconnectCtrlEx));
+	init_h2fwcmd_w_parm_no_rsp(ph2c, param, GEN_CMD_CODE(_DisconnectCtrlEx));
 	r8712_enqueue_cmd(pcmdpriv, ph2c);
 }
diff --git a/drivers/staging/rtl8712/rtl871x_cmd.h b/drivers/staging/rtl8712/rtl871x_cmd.h
index 8453d8de8248..2613b3c2acfc 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.h
+++ b/drivers/staging/rtl8712/rtl871x_cmd.h
@@ -716,39 +716,28 @@ struct DisconnectCtrlEx_param {
 #define H2C_RESERVED			0x07
 
 void r8712_setMacAddr_cmd(struct _adapter *padapter, const u8 *mac_addr);
-u8 r8712_sitesurvey_cmd(struct _adapter *padapter,
-			struct ndis_802_11_ssid *pssid);
+u8 r8712_sitesurvey_cmd(struct _adapter *padapter, struct ndis_802_11_ssid *pssid);
 int r8712_createbss_cmd(struct _adapter *padapter);
 void r8712_setstakey_cmd(struct _adapter *padapter, u8 *psta, u8 unicast_key);
-int r8712_joinbss_cmd(struct _adapter *padapter,
-		      struct wlan_network *pnetwork);
+int r8712_joinbss_cmd(struct _adapter *padapter, struct wlan_network *pnetwork);
 void r8712_disassoc_cmd(struct _adapter *padapter);
-void r8712_setopmode_cmd(struct _adapter *padapter,
-		 enum NDIS_802_11_NETWORK_INFRASTRUCTURE networktype);
+void r8712_setopmode_cmd(struct _adapter *padapter, enum NDIS_802_11_NETWORK_INFRASTRUCTURE networktype);
 int r8712_setdatarate_cmd(struct _adapter *padapter, u8 *rateset);
 void r8712_set_chplan_cmd(struct _adapter  *padapter, int chplan);
 int r8712_getrfreg_cmd(struct _adapter *padapter, u8 offset, u8 *pval);
 int r8712_setrfreg_cmd(struct _adapter  *padapter, u8 offset, u32 val);
 void r8712_addbareq_cmd(struct _adapter *padapter, u8 tid);
 void r8712_wdg_wk_cmd(struct _adapter *padapter);
-void r8712_survey_cmd_callback(struct _adapter  *padapter,
-			       struct cmd_obj *pcmd);
-void r8712_disassoc_cmd_callback(struct _adapter  *padapter,
-				 struct cmd_obj *pcmd);
-void r8712_joinbss_cmd_callback(struct _adapter  *padapter,
-				struct cmd_obj *pcmd);
-void r8712_createbss_cmd_callback(struct _adapter *padapter,
-				  struct cmd_obj *pcmd);
-void r8712_getbbrfreg_cmdrsp_callback(struct _adapter *padapter,
-				      struct cmd_obj *pcmd);
-void r8712_readtssi_cmdrsp_callback(struct _adapter *padapter,
-				struct cmd_obj *pcmd);
-void r8712_setstaKey_cmdrsp_callback(struct _adapter  *padapter,
-				     struct cmd_obj *pcmd);
-void r8712_setassocsta_cmdrsp_callback(struct _adapter  *padapter,
-				       struct cmd_obj *pcmd);
-void r8712_disconnectCtrlEx_cmd(struct _adapter *adapter, u32 enableDrvCtrl,
-			u32 tryPktCnt, u32 tryPktInterval, u32 firstStageTO);
+void r8712_survey_cmd_callback(struct _adapter  *padapter, struct cmd_obj *pcmd);
+void r8712_disassoc_cmd_callback(struct _adapter  *padapter, struct cmd_obj *pcmd);
+void r8712_joinbss_cmd_callback(struct _adapter  *padapter, struct cmd_obj *pcmd);
+void r8712_createbss_cmd_callback(struct _adapter *padapter, struct cmd_obj *pcmd);
+void r8712_getbbrfreg_cmdrsp_callback(struct _adapter *padapter, struct cmd_obj *pcmd);
+void r8712_readtssi_cmdrsp_callback(struct _adapter *padapter, struct cmd_obj *pcmd);
+void r8712_setstaKey_cmdrsp_callback(struct _adapter  *padapter, struct cmd_obj *pcmd);
+void r8712_setassocsta_cmdrsp_callback(struct _adapter  *padapter, struct cmd_obj *pcmd);
+void r8712_disconnectCtrlEx_cmd(struct _adapter *adapter, u32 enableDrvCtrl, u32 tryPktCnt, 
+				u32 tryPktInterval, u32 firstStageTO);
 
 struct _cmd_callback {
 	u32	cmd_code;
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
index 36f6904d25ab..0653aa27b1fa 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -59,8 +59,7 @@ void r8712_indicate_wx_assoc_event(struct _adapter *padapter)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	wrqu.ap_addr.sa_family = ARPHRD_ETHER;
-	memcpy(wrqu.ap_addr.sa_data, pmlmepriv->cur_network.network.MacAddress,
-		ETH_ALEN);
+	memcpy(wrqu.ap_addr.sa_data, pmlmepriv->cur_network.network.MacAddress, ETH_ALEN);
 	wireless_send_event(padapter->pnetdev, SIOCGIWAP, &wrqu, NULL);
 }
 
@@ -111,11 +110,9 @@ static inline void handle_group_key(struct ieee_param *param,
 		memcpy(grk[param->u.crypt.idx - 1].skey,
 		       &param->u.crypt.key[24], 8);
 		padapter->securitypriv.binstallGrpkey = true;
-		r8712_set_key(padapter, &padapter->securitypriv,
-			param->u.crypt.idx);
+		r8712_set_key(padapter, &padapter->securitypriv, param->u.crypt.idx);
 		if (padapter->registrypriv.power_mgnt > PS_MODE_ACTIVE) {
-			if (padapter->registrypriv.power_mgnt !=
-			    padapter->pwrctrlpriv.pwr_mode)
+			if (padapter->registrypriv.power_mgnt != padapter->pwrctrlpriv.pwr_mode)
 				mod_timer(&padapter->mlmepriv.dhcp_timer,
 					  jiffies + msecs_to_jiffies(60000));
 		}
@@ -148,13 +145,11 @@ static noinline_for_stack char *translate_scan_wpa(struct iw_request_info *info,
 		memset(iwe, 0, sizeof(*iwe));
 		iwe->cmd = IWEVCUSTOM;
 		iwe->u.data.length = (u16)strlen(buf);
-		start = iwe_stream_add_point(info, start, stop,
-			iwe, buf);
+		start = iwe_stream_add_point(info, start, stop, iwe, buf);
 		memset(iwe, 0, sizeof(*iwe));
 		iwe->cmd = IWEVGENIE;
 		iwe->u.data.length = (u16)wpa_len;
-		start = iwe_stream_add_point(info, start, stop,
-			iwe, wpa_ie);
+		start = iwe_stream_add_point(info, start, stop, iwe, wpa_ie);
 	}
 	if (rsn_len > 0) {
 		memset(buf, 0, MAX_WPA_IE_LEN);
@@ -168,13 +163,11 @@ static noinline_for_stack char *translate_scan_wpa(struct iw_request_info *info,
 		memset(iwe, 0, sizeof(*iwe));
 		iwe->cmd = IWEVCUSTOM;
 		iwe->u.data.length = strlen(buf);
-		start = iwe_stream_add_point(info, start, stop,
-			iwe, buf);
+		start = iwe_stream_add_point(info, start, stop, iwe, buf);
 		memset(iwe, 0, sizeof(*iwe));
 		iwe->cmd = IWEVGENIE;
 		iwe->u.data.length = rsn_len;
-		start = iwe_stream_add_point(info, start, stop, iwe,
-			rsn_ie);
+		start = iwe_stream_add_point(info, start, stop, iwe, rsn_ie);
 	}
 
 	return start;
@@ -189,14 +182,11 @@ static noinline_for_stack char *translate_scan_wps(struct iw_request_info *info,
 	u8 wps_ie[512];
 	uint wps_ielen;
 
-	if (r8712_get_wps_ie(pnetwork->network.IEs,
-	    pnetwork->network.IELength,
-	    wps_ie, &wps_ielen)) {
+	if (r8712_get_wps_ie(pnetwork->network.IEs, pnetwork->network.IELength, wps_ie, &wps_ielen)) {
 		if (wps_ielen > 2) {
 			iwe->cmd = IWEVGENIE;
 			iwe->u.data.length = (u16)wps_ielen;
-			start = iwe_stream_add_point(info, start, stop,
-				iwe, wps_ie);
+			start = iwe_stream_add_point(info, start, stop, iwe, wps_ie);
 		}
 	}
 
@@ -259,16 +249,14 @@ static char *translate_scan(struct _adapter *padapter,
 	start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_CHAR_LEN);
 	/* Add mode */
 	iwe.cmd = SIOCGIWMODE;
-	memcpy((u8 *)&cap, r8712_get_capability_from_ie(pnetwork->network.IEs),
-		2);
+	memcpy((u8 *)&cap, r8712_get_capability_from_ie(pnetwork->network.IEs), 2);
 	le16_to_cpus(&cap);
 	if (cap & (WLAN_CAPABILITY_IBSS | WLAN_CAPABILITY_ESS)) {
 		if (cap & WLAN_CAPABILITY_ESS)
 			iwe.u.mode = (u32)IW_MODE_MASTER;
 		else
 			iwe.u.mode = (u32)IW_MODE_ADHOC;
-		start = iwe_stream_add_event(info, start, stop, &iwe,
-			IW_EV_UINT_LEN);
+		start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_UINT_LEN);
 	}
 	/* Add frequency/channel */
 	iwe.cmd = SIOCGIWFREQ;
@@ -276,28 +264,23 @@ static char *translate_scan(struct _adapter *padapter,
 		/*  check legal index */
 		u8 dsconfig = pnetwork->network.Configuration.DSConfig;
 
-		if (dsconfig >= 1 && dsconfig <= sizeof(
-		    ieee80211_wlan_frequencies) / sizeof(long))
-			iwe.u.freq.m =
-				(s32)(ieee80211_wlan_frequencies
-				      [dsconfig - 1] * 100000);
+		if (dsconfig >= 1 && dsconfig <= sizeof(ieee80211_wlan_frequencies) / sizeof(long))
+			iwe.u.freq.m = (s32)(ieee80211_wlan_frequencies[dsconfig - 1] * 100000);
 		else
 			iwe.u.freq.m = 0;
 	}
 	iwe.u.freq.e = (s16)1;
 	iwe.u.freq.i = (u8)pnetwork->network.Configuration.DSConfig;
 	start = iwe_stream_add_event(info, start, stop, &iwe,
-		IW_EV_FREQ_LEN);
+				     IW_EV_FREQ_LEN);
 	/* Add encryption capability */
 	iwe.cmd = SIOCGIWENCODE;
 	if (cap & WLAN_CAPABILITY_PRIVACY)
-		iwe.u.data.flags = (u16)(IW_ENCODE_ENABLED |
-				    IW_ENCODE_NOKEY);
+		iwe.u.data.flags = (u16)(IW_ENCODE_ENABLED | IW_ENCODE_NOKEY);
 	else
 		iwe.u.data.flags = (u16)(IW_ENCODE_DISABLED);
 	iwe.u.data.length = (u16)0;
-	start = iwe_stream_add_point(info, start, stop, &iwe,
-		pnetwork->network.Ssid.Ssid);
+	start = iwe_stream_add_point(info, start, stop, &iwe, pnetwork->network.Ssid.Ssid);
 	/*Add basic and extended rates */
 	current_val = start + iwe_stream_lcp_len(info);
 	iwe.cmd = SIOCGIWRATE;
@@ -307,10 +290,9 @@ static char *translate_scan(struct _adapter *padapter,
 	i = 0;
 	while (pnetwork->network.rates[i] != 0) {
 		/* Bit rate given in 500 kb/s units */
-		iwe.u.bitrate.value = (pnetwork->network.rates[i++] &
-				      0x7F) * 500000;
-		current_val = iwe_stream_add_value(info, start, current_val,
-			      stop, &iwe, IW_EV_PARAM_LEN);
+		iwe.u.bitrate.value = (pnetwork->network.rates[i++] & 0x7F) * 500000;
+		current_val = iwe_stream_add_value(info, start, current_val, stop, &iwe,
+						   IW_EV_PARAM_LEN);
 	}
 	/* Check if we added any event */
 	if ((current_val - start) > iwe_stream_lcp_len(info))
@@ -324,8 +306,7 @@ static char *translate_scan(struct _adapter *padapter,
 	iwe.cmd = IWEVQUAL;
 	rssi = r8712_signal_scale_mapping(pnetwork->network.Rssi);
 	/* we only update signal_level (signal strength) that is rssi. */
-	iwe.u.qual.updated = (u8)(IW_QUAL_QUAL_INVALID | IW_QUAL_LEVEL_UPDATED |
-				  IW_QUAL_NOISE_INVALID);
+	iwe.u.qual.updated = (u8)(IW_QUAL_QUAL_INVALID | IW_QUAL_LEVEL_UPDATED | IW_QUAL_NOISE_INVALID);
 	iwe.u.qual.level = rssi;  /* signal strength */
 	iwe.u.qual.qual = 0; /* signal quality */
 	iwe.u.qual.noise = 0; /* noise level */
@@ -490,71 +471,59 @@ static int r871x_set_wpa_ie(struct _adapter *padapter, char *pie,
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
 		}
 		switch (group_cipher) {
 		case WPA_CIPHER_NONE:
-			padapter->securitypriv.XGrpPrivacy =
-				 _NO_PRIVACY_;
-			padapter->securitypriv.ndisencryptstatus =
-				 Ndis802_11EncryptionDisabled;
+			padapter->securitypriv.XGrpPrivacy = _NO_PRIVACY_;
+			padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled;
 			break;
 		case WPA_CIPHER_WEP40:
 			padapter->securitypriv.XGrpPrivacy = _WEP40_;
-			padapter->securitypriv.ndisencryptstatus =
-				 Ndis802_11Encryption1Enabled;
+			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 			break;
 		case WPA_CIPHER_TKIP:
 			padapter->securitypriv.XGrpPrivacy = _TKIP_;
-			padapter->securitypriv.ndisencryptstatus =
-				 Ndis802_11Encryption2Enabled;
+			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption2Enabled;
 			break;
 		case WPA_CIPHER_CCMP:
 			padapter->securitypriv.XGrpPrivacy = _AES_;
-			padapter->securitypriv.ndisencryptstatus =
-				 Ndis802_11Encryption3Enabled;
+			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption3Enabled;
 			break;
 		case WPA_CIPHER_WEP104:
 			padapter->securitypriv.XGrpPrivacy = _WEP104_;
-			padapter->securitypriv.ndisencryptstatus =
-				 Ndis802_11Encryption1Enabled;
+			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 			break;
 		}
 		switch (pairwise_cipher) {
 		case WPA_CIPHER_NONE:
-			padapter->securitypriv.PrivacyAlgrthm =
-				 _NO_PRIVACY_;
-			padapter->securitypriv.ndisencryptstatus =
-				 Ndis802_11EncryptionDisabled;
+			padapter->securitypriv.PrivacyAlgrthm = _NO_PRIVACY_;
+			padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled;
 			break;
 		case WPA_CIPHER_WEP40:
 			padapter->securitypriv.PrivacyAlgrthm = _WEP40_;
-			padapter->securitypriv.ndisencryptstatus =
-				 Ndis802_11Encryption1Enabled;
+			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 			break;
 		case WPA_CIPHER_TKIP:
 			padapter->securitypriv.PrivacyAlgrthm = _TKIP_;
-			padapter->securitypriv.ndisencryptstatus =
-				 Ndis802_11Encryption2Enabled;
+			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption2Enabled;
 			break;
 		case WPA_CIPHER_CCMP:
 			padapter->securitypriv.PrivacyAlgrthm = _AES_;
-			padapter->securitypriv.ndisencryptstatus =
-				 Ndis802_11Encryption3Enabled;
+			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption3Enabled;
 			break;
 		case WPA_CIPHER_WEP104:
 			padapter->securitypriv.PrivacyAlgrthm = _WEP104_;
-			padapter->securitypriv.ndisencryptstatus =
-				 Ndis802_11Encryption1Enabled;
+			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 			break;
 		}
 		padapter->securitypriv.wps_phase = false;
@@ -574,8 +543,8 @@ static int r871x_set_wpa_ie(struct _adapter *padapter, char *pie,
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
@@ -592,8 +561,7 @@ static int r871x_set_wpa_ie(struct _adapter *padapter, char *pie,
 	return ret;
 }
 
-static int r8711_wx_get_name(struct net_device *dev,
-			     struct iw_request_info *info,
+static int r8711_wx_get_name(struct net_device *dev, struct iw_request_info *info,
 			     union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
@@ -604,8 +572,7 @@ static int r8711_wx_get_name(struct net_device *dev,
 	struct wlan_bssid_ex *pcur_bss = &pmlmepriv->cur_network.network;
 	u8 *prates;
 
-	if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE) ==
-	    true) {
+	if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE) == true) {
 		/* parsing HT_CAP_IE */
 		p = r8712_get_ie(&pcur_bss->IEs[12], WLAN_EID_HT_CAPABILITY,
 				 &ht_ielen, pcur_bss->IELength - 12);
@@ -658,9 +625,7 @@ static int r8711_wx_set_freq(struct net_device *dev,
 	int rc = 0;
 
 /* If setting by frequency, convert to a channel */
-	if ((fwrq->e == 1) &&
-	  (fwrq->m >= 241200000) &&
-	  (fwrq->m <= 248700000)) {
+	if ((fwrq->e == 1) && (fwrq->m >= 241200000) && (fwrq->m <= 248700000)) {
 		int f = fwrq->m / 100000;
 		int c = 0;
 
@@ -685,8 +650,7 @@ static int r8711_wx_set_freq(struct net_device *dev,
 	return rc;
 }
 
-static int r8711_wx_get_freq(struct net_device *dev,
-			     struct iw_request_info *info,
+static int r8711_wx_get_freq(struct net_device *dev, struct iw_request_info *info,
 			     union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
@@ -745,7 +709,7 @@ static int r8711_wx_get_mode(struct net_device *dev, struct iw_request_info *a,
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
 		wrqu->mode = IW_MODE_INFRA;
 	else if (check_fwstate(pmlmepriv,
-		 WIFI_ADHOC_MASTER_STATE | WIFI_ADHOC_STATE))
+			       WIFI_ADHOC_MASTER_STATE | WIFI_ADHOC_STATE))
 		wrqu->mode = IW_MODE_ADHOC;
 	else if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		wrqu->mode = IW_MODE_MASTER;
@@ -754,9 +718,8 @@ static int r8711_wx_get_mode(struct net_device *dev, struct iw_request_info *a,
 	return 0;
 }
 
-static int r871x_wx_set_pmkid(struct net_device *dev,
-			     struct iw_request_info *a,
-			     union iwreq_data *wrqu, char *extra)
+static int r871x_wx_set_pmkid(struct net_device *dev, struct iw_request_info *a,
+			      union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
@@ -828,7 +791,7 @@ static int r871x_wx_set_pmkid(struct net_device *dev,
 		break;
 	case IW_PMKSA_FLUSH:
 		memset(psecuritypriv->PMKIDList, 0,
-			sizeof(struct RT_PMKID_LIST) * NUM_PMKID_CACHE);
+		       sizeof(struct RT_PMKID_LIST) * NUM_PMKID_CACHE);
 		psecuritypriv->PMKIDIndex = 0;
 		intReturn = true;
 		break;
@@ -850,9 +813,8 @@ static int r8711_wx_get_sens(struct net_device *dev,
 	return 0;
 }
 
-static int r8711_wx_get_range(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
+static int r8711_wx_get_range(struct net_device *dev, struct iw_request_info *info,
+			      union iwreq_data *wrqu, char *extra)
 {
 	struct iw_range *range = (struct iw_range *)extra;
 	u16 val;
@@ -912,9 +874,9 @@ static int r8711_wx_get_rate(struct net_device *dev,
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
@@ -995,12 +957,10 @@ static int r871x_wx_set_priv(struct net_device *dev,
 		);
 		sprintf(ext, "OK");
 	} else {
-		netdev_info(dev, "r8712u: %s: unknown Command %s.\n",
-			    __func__, ext);
+		netdev_info(dev, "r8712u: %s: unknown Command %s.\n", __func__, ext);
 		goto FREE_EXT;
 	}
-	if (copy_to_user(dwrq->pointer, ext,
-				min(dwrq->length, (__u16)(strlen(ext) + 1))))
+	if (copy_to_user(dwrq->pointer, ext, min(dwrq->length, (__u16)(strlen(ext) + 1))))
 		ret = -EFAULT;
 
 FREE_EXT:
@@ -1021,10 +981,8 @@ static int r871x_wx_set_priv(struct net_device *dev,
  * For this operation to succeed, there is no need for the interface to be up.
  *
  */
-static int r8711_wx_set_wap(struct net_device *dev,
-			 struct iw_request_info *info,
-			 union iwreq_data *awrq,
-			 char *extra)
+static int r8711_wx_set_wap(struct net_device *dev, struct iw_request_info *info,
+			    union iwreq_data *awrq, char *extra)
 {
 	int ret = -EINPROGRESS;
 	struct _adapter *padapter = netdev_priv(dev);
@@ -1072,17 +1030,15 @@ static int r8711_wx_set_wap(struct net_device *dev,
 	return ret;
 }
 
-static int r8711_wx_get_wap(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
+static int r8711_wx_get_wap(struct net_device *dev, struct iw_request_info *info,
+			    union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex *pcur_bss = &pmlmepriv->cur_network.network;
 
 	wrqu->ap_addr.sa_family = ARPHRD_ETHER;
-	if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE |
-				     WIFI_AP_STATE))
+	if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE | WIFI_AP_STATE))
 		ether_addr_copy(wrqu->ap_addr.sa_data, pcur_bss->MacAddress);
 	else
 		eth_zero_addr(wrqu->ap_addr.sa_data);
@@ -1122,9 +1078,8 @@ static int r871x_wx_set_mlme(struct net_device *dev,
  * For this operation to succeed, the interface is brought Up beforehand.
  *
  */
-static int r8711_wx_set_scan(struct net_device *dev,
-			struct iw_request_info *a,
-			union iwreq_data *wrqu, char *extra)
+static int r8711_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
+			     union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -1150,8 +1105,7 @@ static int r8711_wx_set_scan(struct net_device *dev,
 			unsigned long irqL;
 			u32 len = min_t(u8, req->essid_len, IW_ESSID_MAX_SIZE);
 
-			memset((unsigned char *)&ssid, 0,
-				 sizeof(struct ndis_802_11_ssid));
+			memset((unsigned char *)&ssid, 0, sizeof(struct ndis_802_11_ssid));
 			memcpy(ssid.Ssid, req->essid, len);
 			ssid.SsidLength = len;
 			spin_lock_irqsave(&pmlmepriv->lock, irqL);
@@ -1173,9 +1127,8 @@ static int r8711_wx_set_scan(struct net_device *dev,
 	return 0;
 }
 
-static int r8711_wx_get_scan(struct net_device *dev,
-				struct iw_request_info *a,
-				union iwreq_data *wrqu, char *extra)
+static int r8711_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
+			     union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -1189,8 +1142,7 @@ static int r8711_wx_get_scan(struct net_device *dev,
 
 	if (padapter->driver_stopped)
 		return -EINVAL;
-	while (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY |
-			     _FW_UNDER_LINKING)) {
+	while (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING)) {
 		msleep(30);
 		cnt++;
 		if (cnt > 100)
@@ -1228,9 +1180,8 @@ static int r8711_wx_get_scan(struct net_device *dev,
  * For this operation to succeed, there is no need for the interface to be Up.
  *
  */
-static int r8711_wx_set_essid(struct net_device *dev,
-				struct iw_request_info *a,
-				union iwreq_data *wrqu, char *extra)
+static int r8711_wx_set_essid(struct net_device *dev, struct iw_request_info *a,
+			      union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -1268,8 +1219,7 @@ static int r8711_wx_set_essid(struct net_device *dev,
 			if ((!memcmp(dst_ssid, src_ssid, ndis_ssid.SsidLength))
 			    && (pnetwork->network.Ssid.SsidLength ==
 			     ndis_ssid.SsidLength)) {
-				if (check_fwstate(pmlmepriv,
-							WIFI_ADHOC_STATE)) {
+				if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
 					if (pnetwork->network.
 						InfrastructureMode
 						!=
@@ -1291,9 +1241,8 @@ static int r8711_wx_set_essid(struct net_device *dev,
 	return -EINPROGRESS;
 }
 
-static int r8711_wx_get_essid(struct net_device *dev,
-				struct iw_request_info *a,
-				union iwreq_data *wrqu, char *extra)
+static int r8711_wx_get_essid(struct net_device *dev, struct iw_request_info *a,
+			      union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -1311,9 +1260,8 @@ static int r8711_wx_get_essid(struct net_device *dev,
 	return ret;
 }
 
-static int r8711_wx_set_rate(struct net_device *dev,
-				struct iw_request_info *a,
-				union iwreq_data *wrqu, char *extra)
+static int r8711_wx_set_rate(struct net_device *dev, struct iw_request_info *a,
+			     union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 	u32 target_rate = wrqu->bitrate.value;
@@ -1382,8 +1330,7 @@ static int r8711_wx_set_rate(struct net_device *dev,
 	return r8712_setdatarate_cmd(padapter, datarates);
 }
 
-static int r8711_wx_get_rate(struct net_device *dev,
-			     struct iw_request_info *info,
+static int r8711_wx_get_rate(struct net_device *dev, struct iw_request_info *info,
 			     union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
@@ -1437,9 +1384,8 @@ static int r8711_wx_get_rate(struct net_device *dev,
 	return 0;
 }
 
-static int r8711_wx_get_rts(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
+static int r8711_wx_get_rts(struct net_device *dev, struct iw_request_info *info,
+			    union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 
@@ -1448,9 +1394,8 @@ static int r8711_wx_get_rts(struct net_device *dev,
 	return 0;
 }
 
-static int r8711_wx_set_frag(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
+static int r8711_wx_set_frag(struct net_device *dev, struct iw_request_info *info,
+			     union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 
-- 
2.30.2


