Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF59811DC3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379283AbjLMS7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379245AbjLMS7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:59:48 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141B2A3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:59:52 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b86057b5b2so1049801b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702493991; x=1703098791; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zx9S+lGA9OC/+WrR5wj1eIo0oD+uqIi/xIZB38p/BMg=;
        b=JNDy4vMol3X0/912nWBrPk5YpKCYgvY5T3nO12U/mTKJ0gadeg1z9td0l3Xl6wSIgK
         R1SAiItsKYgCpmdfgs7Svv4pO0WFNOHAYs51GJlQ77fV9/hgm92gfE2mGpM2xDrzHoyt
         iTOJn7CFw3PeekitnU2MbY47edqK4xiG8vlb73hpzEZah/87mGX1PErzxo8wG+dvTt2E
         4QFMdF0RX2xsyj9oPeU0+P95CRx9uMbnxyv7ZIIUxmH+npXngK6GsBUjVQfvtUi3cv7a
         hRymWUFfH+UGb0bzeRH9Kh9IBLN+B7LSAhkgzkswTcG+cXwO6Wkw1vZY5tDtX3EDUb30
         w/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493991; x=1703098791;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zx9S+lGA9OC/+WrR5wj1eIo0oD+uqIi/xIZB38p/BMg=;
        b=g+wP27z73LuO4NhNFsF09gvtbhRP9rUwdTK+84yjoi9jAfu7tY+jhO7zGWEK05y0mT
         uz+vqrAVlHTj7PIw8L2tRxCGb+HGu2kOin+udKBRFHREPsjQbyncdGJu13TxzzZjoQjz
         wJ5FM/qsrtXaxmliz+An5Wca8WdRZMUSxa8ejqHOJrksiNr006urHLAK6n0ubWSQGU6I
         CyI2y1IbOJjLeWyij/sjFZXNmOw2uEdxwZATtC5mRQfV6plfCGLdnvM9+mc9wenaHk9s
         LQFW6FBANhk9MrXh4DNeQjqOkJut3dTvoL8XC+re00HjpCTlGlslzo/6QHKHFnrguQA3
         nX3w==
X-Gm-Message-State: AOJu0YwBMA0U7mo5Q6XRBu3mP/nzNf5CS9btoiMBvjgFPI+iz8Noa5OI
        O+9KDMsRHzOIWwB1soWoQzRGAgjptH5Vag==
X-Google-Smtp-Source: AGHT+IF/MT6TlsrklTGlyY3Avh1mEo3BWXZtahmnpJhH/AMzpq2GJyA2T/4UL6yFqekrZps7bHjiEA==
X-Received: by 2002:a05:6808:1245:b0:3b9:e654:9004 with SMTP id o5-20020a056808124500b003b9e6549004mr16600453oiv.1.1702493990901;
        Wed, 13 Dec 2023 10:59:50 -0800 (PST)
Received: from kernel.ryanengland.xyz ([2600:3c05::f03c:94ff:fea1:5b99])
        by smtp.gmail.com with ESMTPSA id r5-20020ac87945000000b00423ea1b31b3sm5089293qtt.66.2023.12.13.10.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:59:50 -0800 (PST)
Date:   Wed, 13 Dec 2023 18:59:50 +0000
From:   Ryan England <rcengland@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: [PATCH] staging: rtl8712: remove unnecessary parentheses
Message-ID: <ZXn/JjyrLGQzS9zD@kernel.ryanengland.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adhere to Linux kernel coding style.

Reported by checkpatch:

CHECK: Unnecessary parentheses

Signed-off-by: Ryan England <rcengland@gmail.com>
---
 drivers/staging/rtl8712/hal_init.c            |  4 +-
 drivers/staging/rtl8712/ieee80211.c           | 14 ++--
 drivers/staging/rtl8712/recv_linux.c          |  2 +-
 drivers/staging/rtl8712/rtl8712_cmd.c         |  4 +-
 drivers/staging/rtl8712/rtl8712_efuse.c       | 14 ++--
 drivers/staging/rtl8712/rtl8712_recv.c        | 14 ++--
 drivers/staging/rtl8712/rtl8712_xmit.c        | 12 +--
 drivers/staging/rtl8712/rtl871x_cmd.c         | 18 ++--
 drivers/staging/rtl8712/rtl871x_io.c          |  2 +-
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 42 +++++-----
 drivers/staging/rtl8712/rtl871x_ioctl_rtl.c   |  2 +-
 drivers/staging/rtl8712/rtl871x_ioctl_set.c   | 10 +--
 drivers/staging/rtl8712/rtl871x_mlme.c        | 84 +++++++++----------
 drivers/staging/rtl8712/rtl871x_mp.c          |  6 +-
 drivers/staging/rtl8712/rtl871x_mp_ioctl.c    | 14 ++--
 drivers/staging/rtl8712/rtl871x_pwrctrl.c     | 20 ++---
 drivers/staging/rtl8712/rtl871x_recv.c        | 14 ++--
 drivers/staging/rtl8712/rtl871x_security.c    | 10 +--
 drivers/staging/rtl8712/rtl871x_sta_mgt.c     | 32 +++----
 drivers/staging/rtl8712/rtl871x_xmit.c        | 38 ++++-----
 drivers/staging/rtl8712/usb_halinit.c         |  2 +-
 drivers/staging/rtl8712/usb_intf.c            | 16 ++--
 drivers/staging/rtl8712/usb_ops_linux.c       | 12 +--
 drivers/staging/rtl8712/xmit_linux.c          |  2 +-
 24 files changed, 194 insertions(+), 194 deletions(-)

diff --git a/drivers/staging/rtl8712/hal_init.c b/drivers/staging/rtl8712/hal_init.c
index 1148075f0cd6..4cf08b45c9b1 100644
--- a/drivers/staging/rtl8712/hal_init.c
+++ b/drivers/staging/rtl8712/hal_init.c
@@ -138,7 +138,7 @@ static u8 chk_fwhdr(struct fw_hdr *pfwhdr, u32 ulfilelength)
 	u32	fwhdrsz, fw_sz;
 
 	/* check signature */
-	if ((pfwhdr->signature != 0x8712) && (pfwhdr->signature != 0x8192))
+	if (pfwhdr->signature != 0x8712 && pfwhdr->signature != 0x8192)
 		return _FAIL;
 	/* check fw_priv_sze & sizeof(struct fw_priv) */
 	if (pfwhdr->fw_priv_sz != sizeof(struct fw_priv))
@@ -168,7 +168,7 @@ static u8 rtl8712_dl_fw(struct _adapter *adapter)
 	u8 ret = _FAIL;
 
 	ulfilelength = rtl871x_open_fw(adapter, &mappedfw);
-	if (mappedfw && (ulfilelength > 0)) {
+	if (mappedfw && ulfilelength > 0) {
 		update_fwhdr(&fwhdr, mappedfw);
 		if (chk_fwhdr(&fwhdr, ulfilelength) == _FAIL)
 			return ret;
diff --git a/drivers/staging/rtl8712/ieee80211.c b/drivers/staging/rtl8712/ieee80211.c
index 7d8f1a29d18a..24515fdeed68 100644
--- a/drivers/staging/rtl8712/ieee80211.c
+++ b/drivers/staging/rtl8712/ieee80211.c
@@ -63,8 +63,8 @@ uint r8712_is_cckrates_included(u8 *rate)
 	u32 i = 0;
 
 	while (rate[i] != 0) {
-		if ((((rate[i]) & 0x7f) == 2) || (((rate[i]) & 0x7f) == 4) ||
-		    (((rate[i]) & 0x7f) == 11) || (((rate[i]) & 0x7f) == 22))
+		if (((rate[i] & 0x7f) == 2) || ((rate[i] & 0x7f) == 4) ||
+		    ((rate[i] & 0x7f) == 11) || ((rate[i] & 0x7f) == 22))
 			return true;
 		i++;
 	}
@@ -76,8 +76,8 @@ uint r8712_is_cckratesonly_included(u8 *rate)
 	u32 i = 0;
 
 	while (rate[i] != 0) {
-		if ((((rate[i]) & 0x7f) != 2) && (((rate[i]) & 0x7f) != 4) &&
-		    (((rate[i]) & 0x7f) != 11)  && (((rate[i]) & 0x7f) != 22))
+		if (((rate[i] & 0x7f) != 2) && ((rate[i] & 0x7f) != 4) &&
+		    ((rate[i] & 0x7f) != 11)  && ((rate[i] & 0x7f) != 22))
 			return false;
 		i++;
 	}
@@ -147,7 +147,7 @@ static uint r8712_get_rateset_len(u8 *rateset)
 	uint i = 0;
 
 	while (1) {
-		if ((rateset[i]) == 0)
+		if (rateset[i] == 0)
 			break;
 		if (i > 12)
 			break;
@@ -372,7 +372,7 @@ int r8712_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len,
 	cnt = _TIMESTAMP_ + _BEACON_ITERVAL_ + _CAPABILITY_;
 	while (cnt < in_len) {
 		authmode = in_ie[cnt];
-		if ((authmode == _WPA_IE_ID_) &&
+		if (authmode == _WPA_IE_ID_ &&
 		    (!memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4))) {
 			memcpy(wpa_ie, &in_ie[cnt], in_ie[cnt + 1] + 2);
 			*wpa_len = in_ie[cnt + 1] + 2;
@@ -401,7 +401,7 @@ int r8712_get_wps_ie(u8 *in_ie, uint in_len, u8 *wps_ie, uint *wps_ielen)
 	match = false;
 	while (cnt < in_len) {
 		eid = in_ie[cnt];
-		if ((eid == _WPA_IE_ID_) &&
+		if (eid == _WPA_IE_ID_ &&
 		    (!memcmp(&in_ie[cnt + 2], wps_oui, 4))) {
 			memcpy(wps_ie, &in_ie[cnt], in_ie[cnt + 1] + 2);
 			*wps_ielen = in_ie[cnt + 1] + 2;
diff --git a/drivers/staging/rtl8712/recv_linux.c b/drivers/staging/rtl8712/recv_linux.c
index 215fca4abb3a..2bf4661432a9 100644
--- a/drivers/staging/rtl8712/recv_linux.c
+++ b/drivers/staging/rtl8712/recv_linux.c
@@ -105,7 +105,7 @@ void r8712_recv_indicatepkt(struct _adapter *adapter,
 	skb->data = recvframe->u.hdr.rx_data;
 	skb->len = recvframe->u.hdr.len;
 	skb_set_tail_pointer(skb, skb->len);
-	if ((attrib->tcpchk_valid == 1) && (attrib->tcp_chkrpt == 1))
+	if (attrib->tcpchk_valid == 1 && attrib->tcp_chkrpt == 1)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 	else
 		skb->ip_summed = CHECKSUM_NONE;
diff --git a/drivers/staging/rtl8712/rtl8712_cmd.c b/drivers/staging/rtl8712/rtl8712_cmd.c
index bb7db96ed821..568e252523e3 100644
--- a/drivers/staging/rtl8712/rtl8712_cmd.c
+++ b/drivers/staging/rtl8712/rtl8712_cmd.c
@@ -387,8 +387,8 @@ void r8712_event_handle(struct _adapter *padapter, __le32 *peventbuf)
 		goto _abort_event_;
 	}
 	/* checking if event size match the event parm size */
-	if ((wlanevents[evt_code].parmsize) &&
-	    (wlanevents[evt_code].parmsize != evt_sz)) {
+	if (wlanevents[evt_code].parmsize &&
+	    wlanevents[evt_code].parmsize != evt_sz) {
 		pevt_priv->event_seq = ((evt_seq + 1) & 0x7f);
 		goto _abort_event_;
 	} else if ((evt_sz == 0) && (evt_code != GEN_EVT_CODE(_WPS_PBC))) {
diff --git a/drivers/staging/rtl8712/rtl8712_efuse.c b/drivers/staging/rtl8712/rtl8712_efuse.c
index c9400e40a1d6..418d228a9567 100644
--- a/drivers/staging/rtl8712/rtl8712_efuse.c
+++ b/drivers/staging/rtl8712/rtl8712_efuse.c
@@ -169,9 +169,9 @@ void r8712_efuse_change_max_size(struct _adapter *adapter)
 	for (i = 0; i < pre_pg_data_size; i++)
 		efuse_one_byte_read(adapter, pre_pg_data_saddr + i,
 				    &pre_pg_data[i]);
-	if ((pre_pg_data[0] == 0x03) && (pre_pg_data[1] == 0x00) &&
-	    (pre_pg_data[2] == 0x00) && (pre_pg_data[3] == 0x00) &&
-	    (pre_pg_data[4] == 0x0C))
+	if (pre_pg_data[0] == 0x03 && pre_pg_data[1] == 0x00 &&
+	    pre_pg_data[2] == 0x00 && pre_pg_data[3] == 0x00 &&
+	    pre_pg_data[4] == 0x0C)
 		efuse_available_max_size -= pre_pg_data_size;
 }
 
@@ -384,8 +384,8 @@ u8 r8712_efuse_pg_packet_write(struct _adapter *adapter, const u8 offset,
 				break; /* continue to blind write */
 			}
 		}
-		if ((sub_repeat > _REPEAT_THRESHOLD_) ||
-		    (pg_header == efuse_data)) {
+		if (sub_repeat > _REPEAT_THRESHOLD_ ||
+		    pg_header == efuse_data) {
 			/* write header ok OR can't check header(creep) */
 			u8 i;
 
@@ -531,8 +531,8 @@ u8 r8712_efuse_map_write(struct _adapter *adapter, u16 addr, u16 cnts,
 				break;
 			}
 
-			if ((data[idx] != pktdata[i]) || (data[idx + 1] !=
-			     pktdata[i + 1])) {
+			if (data[idx] != pktdata[i] || data[idx + 1] !=
+			     pktdata[i + 1]) {
 				word_en &= ~BIT(i >> 1);
 				newdata[j++] = data[idx];
 				newdata[j++] = data[idx + 1];
diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
index 7da014ab0723..48b69da3d4f4 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.c
+++ b/drivers/staging/rtl8712/rtl8712_recv.c
@@ -256,7 +256,7 @@ union recv_frame *r8712_recvframe_chk_defrag(struct _adapter *padapter,
 	else
 		pdefrag_q = &psta->sta_recvpriv.defrag_q;
 
-	if ((ismfrag == 0) && (fragnum == 0))
+	if (ismfrag == 0 && fragnum == 0)
 		prtnframe = precv_frame;/*isn't a fragment frame*/
 	if (ismfrag == 1) {
 		/* 0~(n-1) fragment frame
@@ -283,7 +283,7 @@ union recv_frame *r8712_recvframe_chk_defrag(struct _adapter *padapter,
 			prtnframe = NULL;
 		}
 	}
-	if ((ismfrag == 0) && (fragnum != 0)) {
+	if (ismfrag == 0 && fragnum != 0) {
 		/* the last fragment frame
 		 * enqueue the last fragment
 		 */
@@ -301,7 +301,7 @@ union recv_frame *r8712_recvframe_chk_defrag(struct _adapter *padapter,
 			prtnframe = NULL;
 		}
 	}
-	if (prtnframe && (prtnframe->u.hdr.attrib.privacy)) {
+	if (prtnframe && prtnframe->u.hdr.attrib.privacy) {
 		/* after defrag we must check tkip mic code */
 		if (r8712_recvframe_chkmic(padapter, prtnframe) == _FAIL) {
 			r8712_free_recvframe(prtnframe, pfree_recv_queue);
@@ -397,8 +397,8 @@ static void amsdu_to_msdu(struct _adapter *padapter, union recv_frame *prframe)
 			sub_skb->protocol =
 				 eth_type_trans(sub_skb, padapter->pnetdev);
 			sub_skb->dev = padapter->pnetdev;
-			if ((pattrib->tcpchk_valid == 1) &&
-			    (pattrib->tcp_chkrpt == 1)) {
+			if (pattrib->tcpchk_valid == 1 &&
+			    pattrib->tcp_chkrpt == 1) {
 				sub_skb->ip_summed = CHECKSUM_UNNECESSARY;
 			} else {
 				sub_skb->ip_summed = CHECKSUM_NONE;
@@ -646,7 +646,7 @@ static int r8712_process_recv_indicatepkts(struct _adapter *padapter,
 
 static u8 query_rx_pwr_percentage(s8 antpower)
 {
-	if ((antpower <= -100) || (antpower >= 20))
+	if (antpower <= -100 || antpower >= 20)
 		return	0;
 	else if (antpower >= 0)
 		return	100;
@@ -1023,7 +1023,7 @@ static void recvbuf2recvframe(struct _adapter *padapter, struct sk_buff *pskb)
 		/* for first fragment packet, driver need allocate 1536 +
 		 * drvinfo_sz + RXDESC_SIZE to defrag packet.
 		 */
-		if ((mf == 1) && (frag == 0))
+		if (mf == 1 && frag == 0)
 			/*1658+6=1664, 1664 is 128 alignment.*/
 			alloc_sz = max_t(u16, tmp_len, 1658);
 		else
diff --git a/drivers/staging/rtl8712/rtl8712_xmit.c b/drivers/staging/rtl8712/rtl8712_xmit.c
index 4cb01f590673..3261b5ce292f 100644
--- a/drivers/staging/rtl8712/rtl8712_xmit.c
+++ b/drivers/staging/rtl8712/rtl8712_xmit.c
@@ -291,8 +291,8 @@ void r8712_append_mpdu_unit(struct xmit_buf *pxmitbuf,
 	/* free skb struct */
 	r8712_xmit_complete(padapter, pxmitframe);
 	if (pxmitframe->attrib.ether_type != 0x0806) {
-		if ((pxmitframe->attrib.ether_type != 0x888e) &&
-			(pxmitframe->attrib.dhcp_pkt != 1)) {
+		if (pxmitframe->attrib.ether_type != 0x888e &&
+			(pxmitframe->attrib.dhcp_pkt != 1) {
 			r8712_issue_addbareq_cmd(padapter,
 					pxmitframe->attrib.priority);
 		}
@@ -475,7 +475,7 @@ static void update_txdesc(struct xmit_frame *pxmitframe, uint *pmem, int sz)
 #endif
 		if (!pqospriv->qos_option)
 			ptxdesc->txdw1 |= cpu_to_le32(BIT(16));/*Non-QoS*/
-		if ((pattrib->encrypt > 0) && !pattrib->bswenc) {
+		if (pattrib->encrypt > 0 && !pattrib->bswenc) {
 			switch (pattrib->encrypt) {	/*SEC_TYPE*/
 			case _WEP40_:
 			case _WEP104_:
@@ -515,9 +515,9 @@ static void update_txdesc(struct xmit_frame *pxmitframe, uint *pmem, int sz)
 		 */
 		ptxdesc->txdw3 = cpu_to_le32((pattrib->priority << SEQ_SHT) &
 				 0x0fff0000);
-		if ((pattrib->ether_type != 0x888e) &&
-		    (pattrib->ether_type != 0x0806) &&
-		    (pattrib->dhcp_pkt != 1)) {
+		if (pattrib->ether_type != 0x888e &&
+		    pattrib->ether_type != 0x0806 &&
+		    pattrib->dhcp_pkt != 1) {
 			/*Not EAP & ARP type data packet*/
 			if (phtpriv->ht_option == 1) { /*B/G/N Mode*/
 				if (!phtpriv->ampdu_enable)
diff --git a/drivers/staging/rtl8712/rtl871x_cmd.c b/drivers/staging/rtl8712/rtl871x_cmd.c
index 4be96df5a329..8d0f9bb83305 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.c
+++ b/drivers/staging/rtl8712/rtl871x_cmd.c
@@ -48,7 +48,7 @@ int r8712_init_cmd_priv(struct cmd_priv *pcmdpriv)
 	init_completion(&pcmdpriv->cmd_queue_comp);
 	init_completion(&pcmdpriv->terminate_cmdthread_comp);
 
-	_init_queue(&(pcmdpriv->cmd_queue));
+	_init_queue(&pcmdpriv->cmd_queue);
 
 	/* allocate DMA-able/Non-Page memory for cmd_buf and rsp_buf */
 	pcmdpriv->cmd_seq = 1;
@@ -158,8 +158,8 @@ void r8712_enqueue_cmd_ex(struct cmd_priv *pcmdpriv, struct cmd_obj *obj)
 
 void r8712_free_cmd_obj(struct cmd_obj *pcmd)
 {
-	if ((pcmd->cmdcode != _JoinBss_CMD_) &&
-	    (pcmd->cmdcode != _CreateBss_CMD_))
+	if (pcmd->cmdcode != _JoinBss_CMD_ &&
+	    pcmd->cmdcode != _CreateBss_CMD_)
 		kfree(pcmd->parmbuf);
 	if (pcmd->rsp) {
 		if (pcmd->rspsz != 0)
@@ -414,8 +414,8 @@ int r8712_joinbss_cmd(struct _adapter  *padapter, struct wlan_network *pnetwork)
 		 * to avoid some IOT issues, especially for Realtek 8192u
 		 * SoftAP.
 		 */
-		if ((padapter->securitypriv.PrivacyAlgrthm != _WEP40_) &&
-		    (padapter->securitypriv.PrivacyAlgrthm != _WEP104_)) {
+		if (padapter->securitypriv.PrivacyAlgrthm != _WEP40_ &&
+		    padapter->securitypriv.PrivacyAlgrthm != _WEP104_) {
 			/* restructure_ht_ie */
 			r8712_restructure_ht_ie(padapter,
 						&pnetwork->network.IEs[0],
@@ -657,7 +657,7 @@ void r8712_createbss_cmd_callback(struct _adapter *padapter,
 	struct wlan_network *pwlan = NULL;
 	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)pcmd->parmbuf;
-	struct wlan_network *tgt_network = &(pmlmepriv->cur_network);
+	struct wlan_network *tgt_network = &pmlmepriv->cur_network;
 
 	if (pcmd->res != H2C_SUCCESS)
 		mod_timer(&pmlmepriv->assoc_timer,
@@ -689,7 +689,7 @@ void r8712_createbss_cmd_callback(struct _adapter *padapter,
 	pnetwork->IELength = le32_to_cpu(pnetwork->IELength);
 #endif
 	spin_lock_irqsave(&pmlmepriv->lock, irqL);
-	if ((pmlmepriv->fw_state) & WIFI_AP_STATE) {
+	if (pmlmepriv->fw_state & WIFI_AP_STATE) {
 		psta = r8712_get_stainfo(&padapter->stapriv,
 					 pnetwork->MacAddress);
 		if (!psta) {
@@ -708,11 +708,11 @@ void r8712_createbss_cmd_callback(struct _adapter *padapter,
 				goto createbss_cmd_fail;
 			pwlan->last_scanned = jiffies;
 		} else {
-			list_add_tail(&(pwlan->list),
+			list_add_tail(&pwlan->list,
 					 &pmlmepriv->scanned_queue.queue);
 		}
 		pnetwork->Length = r8712_get_wlan_bssid_ex_sz(pnetwork);
-		memcpy(&(pwlan->network), pnetwork, pnetwork->Length);
+		memcpy(&pwlan->network, pnetwork, pnetwork->Length);
 		pwlan->fixed = true;
 		memcpy(&tgt_network->network, pnetwork,
 			(r8712_get_wlan_bssid_ex_sz(pnetwork)));
diff --git a/drivers/staging/rtl8712/rtl871x_io.c b/drivers/staging/rtl8712/rtl871x_io.c
index 6789a4c98564..88952640bc39 100644
--- a/drivers/staging/rtl8712/rtl871x_io.c
+++ b/drivers/staging/rtl8712/rtl871x_io.c
@@ -110,7 +110,7 @@ uint r8712_alloc_io_queue(struct _adapter *adapter)
 	pio_queue->pallocated_free_ioreqs_buf = kzalloc(NUM_IOREQ *
 						(sizeof(struct io_req)) + 4,
 						GFP_ATOMIC);
-	if ((pio_queue->pallocated_free_ioreqs_buf) == NULL)
+	if (pio_queue->pallocated_free_ioreqs_buf == NULL)
 		goto alloc_io_queue_fail;
 	pio_queue->free_ioreqs_buf = pio_queue->pallocated_free_ioreqs_buf + 4
 			- ((addr_t)(pio_queue->pallocated_free_ioreqs_buf)
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
index 36f6904d25ab..140901580680 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -215,8 +215,8 @@ static char *translate_scan(struct _adapter *padapter,
 	u16	cap, ht_cap = false;
 	u8 rssi;
 
-	if ((pnetwork->network.Configuration.DSConfig < 1) ||
-	    (pnetwork->network.Configuration.DSConfig > 14)) {
+	if (pnetwork->network.Configuration.DSConfig < 1 ||
+	    pnetwork->network.Configuration.DSConfig > 14) {
 		if (pnetwork->network.Configuration.DSConfig < 1)
 			pnetwork->network.Configuration.DSConfig = 1;
 		else
@@ -565,8 +565,8 @@ static int r871x_set_wpa_ie(struct _adapter *padapter, char *pie,
 			while (cnt < ielen) {
 				eid = buf[cnt];
 
-				if ((eid == WLAN_EID_VENDOR_SPECIFIC) &&
-				    (!memcmp(&buf[cnt + 2], wps_oui, 4))) {
+				if (eid == WLAN_EID_VENDOR_SPECIFIC &&
+				    !memcmp(&buf[cnt + 2], wps_oui, 4)) {
 					netdev_info(padapter->pnetdev, "r8712u: SET WPS_IE\n");
 					padapter->securitypriv.wps_ie_len =
 					    ((buf[cnt + 1] + 2) <
@@ -658,9 +658,9 @@ static int r8711_wx_set_freq(struct net_device *dev,
 	int rc = 0;
 
 /* If setting by frequency, convert to a channel */
-	if ((fwrq->e == 1) &&
-	  (fwrq->m >= 241200000) &&
-	  (fwrq->m <= 248700000)) {
+	if (fwrq->e == 1 &&
+	  fwrq->m >= 241200000 &&
+	  fwrq->m <= 248700000) {
 		int f = fwrq->m / 100000;
 		int c = 0;
 
@@ -670,12 +670,12 @@ static int r8711_wx_set_freq(struct net_device *dev,
 		fwrq->m = c + 1;
 	}
 	/* Setting by channel number */
-	if ((fwrq->m > 14) || (fwrq->e > 0)) {
+	if (fwrq->m > 14 || fwrq->e > 0) {
 		rc = -EOPNOTSUPP;
 	} else {
 		int channel = fwrq->m;
 
-		if ((channel < 1) || (channel > 14)) {
+		if (channel < 1 || channel > 14) {
 			rc = -EINVAL;
 		} else {
 			/* Yes ! We can set it !!! */
@@ -930,7 +930,7 @@ static int r871x_wx_set_priv(struct net_device *dev,
 		/*Return received signal strength indicator in -db for */
 		/* current AP */
 		/*<ssid> Rssi xx */
-		struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+		struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 		struct wlan_network *pcur_network = &pmlmepriv->cur_network;
 		/*static u8 xxxx; */
 		if (check_fwstate(pmlmepriv, _FW_LINKED)) {
@@ -1139,8 +1139,8 @@ static int r8711_wx_set_scan(struct net_device *dev,
 		return -ENETDOWN;
 	if (!padapter->hw_init_completed)
 		return -1;
-	if ((check_fwstate(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING)) ||
-	    (pmlmepriv->sitesurveyctrl.traffic_busy))
+	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING) ||
+	    pmlmepriv->sitesurveyctrl.traffic_busy)
 		return 0;
 	if (wrqu->data.length == sizeof(struct iw_scan_req)) {
 		struct iw_scan_req *req = (struct iw_scan_req *)extra;
@@ -1155,9 +1155,9 @@ static int r8711_wx_set_scan(struct net_device *dev,
 			memcpy(ssid.Ssid, req->essid, len);
 			ssid.SsidLength = len;
 			spin_lock_irqsave(&pmlmepriv->lock, irqL);
-			if ((check_fwstate(pmlmepriv, _FW_UNDER_SURVEY |
-			     _FW_UNDER_LINKING)) ||
-			    (pmlmepriv->sitesurveyctrl.traffic_busy)) {
+			if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY |
+			     _FW_UNDER_LINKING) ||
+			    pmlmepriv->sitesurveyctrl.traffic_busy) {
 				if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING))
 					status = false;
 			} else {
@@ -1265,7 +1265,7 @@ static int r8711_wx_set_essid(struct net_device *dev,
 						struct wlan_network, list);
 			pmlmepriv->pscanned = pmlmepriv->pscanned->next;
 			dst_ssid = pnetwork->network.Ssid.Ssid;
-			if ((!memcmp(dst_ssid, src_ssid, ndis_ssid.SsidLength))
+			if (!memcmp(dst_ssid, src_ssid, ndis_ssid.SsidLength)
 			    && (pnetwork->network.Ssid.SsidLength ==
 			     ndis_ssid.SsidLength)) {
 				if (check_fwstate(pmlmepriv,
@@ -1871,7 +1871,7 @@ static int r871x_mp_ioctl_hdl(struct net_device *dev,
 	uint status;
 	int ret = 0;
 
-	if ((!p->length) || (!p->pointer))
+	if (!p->length || !p->pointer)
 		return -EINVAL;
 
 	bset = (u8)(p->flags & 0xFFFF);
@@ -1886,8 +1886,8 @@ static int r871x_mp_ioctl_hdl(struct net_device *dev,
 		goto _r871x_mp_ioctl_hdl_exit;
 	}
 	phandler = mp_ioctl_hdl + poidparam->subcode;
-	if ((phandler->paramsize != 0) &&
-	    (poidparam->len < phandler->paramsize)) {
+	if (phandler->paramsize != 0 &&
+	    poidparam->len < phandler->paramsize) {
 		ret = -EINVAL;
 		goto _r871x_mp_ioctl_hdl_exit;
 	}
@@ -1983,13 +1983,13 @@ static int r871x_get_ap_info(struct net_device *dev,
 			/* BSSID match, then check if supporting wpa/wpa2 */
 			pbuf = r8712_get_wpa_ie(&pnetwork->network.IEs[12],
 			       &wpa_ielen, pnetwork->network.IELength - 12);
-			if (pbuf && (wpa_ielen > 0)) {
+			if (pbuf && wpa_ielen > 0) {
 				pdata->flags = 1;
 				break;
 			}
 			pbuf = r8712_get_wpa2_ie(&pnetwork->network.IEs[12],
 			       &wpa_ielen, pnetwork->network.IELength - 12);
-			if (pbuf && (wpa_ielen > 0)) {
+			if (pbuf && wpa_ielen > 0) {
 				pdata->flags = 2;
 				break;
 			}
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_rtl.c b/drivers/staging/rtl8712/rtl871x_ioctl_rtl.c
index 2b539335206a..f9b5588fe4d6 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_rtl.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_rtl.c
@@ -488,7 +488,7 @@ enum _CONNECT_STATE_ {
 uint oid_rt_get_connect_state_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *padapter = poid_par_priv->adapter_context;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	u32 ulInfo;
 
 	if (poid_par_priv->type_of_oid != QUERY_OID)
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_set.c b/drivers/staging/rtl8712/rtl871x_ioctl_set.c
index 34c9a52b4c42..fa899393e7fd 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_set.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_set.c
@@ -30,7 +30,7 @@ static u8 validate_ssid(struct ndis_802_11_ssid *ssid)
 		return false;
 	for (i = 0; i < ssid->SsidLength; i++) {
 		/* wifi, printable ascii code must be supported */
-		if (!((ssid->Ssid[i] >= 0x20) && (ssid->Ssid[i] <= 0x7e)))
+		if (!(ssid->Ssid[i] >= 0x20 && ssid->Ssid[i] <= 0x7e))
 			return false;
 	}
 	return true;
@@ -40,8 +40,8 @@ static u8 do_join(struct _adapter *padapter)
 {
 	struct list_head *plist, *phead;
 	u8 *pibss = NULL;
-	struct	mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
-	struct  __queue	*queue	= &(pmlmepriv->scanned_queue);
+	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
+	struct  __queue	*queue	= &pmlmepriv->scanned_queue;
 	int ret;
 
 	phead = &queue->queue;
@@ -166,7 +166,7 @@ void r8712_set_802_11_ssid(struct _adapter *padapter,
 		goto _Abort_Set_SSID;
 	}
 	if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE)) {
-		if ((pmlmepriv->assoc_ssid.SsidLength == ssid->SsidLength) &&
+		if (pmlmepriv->assoc_ssid.SsidLength == ssid->SsidLength &&
 		    (!memcmp(&pmlmepriv->assoc_ssid.Ssid, ssid->Ssid,
 		    ssid->SsidLength))) {
 			if (!check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
@@ -228,7 +228,7 @@ void r8712_set_802_11_infrastructure_mode(struct _adapter *padapter,
 	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 	struct wlan_network	*cur_network = &pmlmepriv->cur_network;
 	enum NDIS_802_11_NETWORK_INFRASTRUCTURE *pold_state =
-				&(cur_network->network.InfrastructureMode);
+				&cur_network->network.InfrastructureMode;
 
 	if (*pold_state != networktype) {
 		spin_lock_irqsave(&pmlmepriv->lock, irqL);
diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index fccfa0915a02..839cb3aebcf4 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -44,10 +44,10 @@ int r8712_init_mlme_priv(struct _adapter *padapter)
 				 Ndis802_11AutoUnknown;
 	/* Maybe someday we should rename this variable to "active_mode"(Jeff)*/
 	pmlmepriv->passive_mode = 1; /* 1: active, 0: passive. */
-	spin_lock_init(&(pmlmepriv->lock));
-	spin_lock_init(&(pmlmepriv->lock2));
-	_init_queue(&(pmlmepriv->free_bss_pool));
-	_init_queue(&(pmlmepriv->scanned_queue));
+	spin_lock_init(&pmlmepriv->lock);
+	spin_lock_init(&pmlmepriv->lock2);
+	_init_queue(&pmlmepriv->free_bss_pool);
+	_init_queue(&pmlmepriv->scanned_queue);
 	set_scanned_network_val(pmlmepriv, 0);
 	memset(&pmlmepriv->assoc_ssid, 0, sizeof(struct ndis_802_11_ssid));
 	pbuf = kmalloc_array(MAX_BSS_CNT, sizeof(struct wlan_network),
@@ -57,9 +57,9 @@ int r8712_init_mlme_priv(struct _adapter *padapter)
 	pmlmepriv->free_bss_buf = pbuf;
 	pnetwork = (struct wlan_network *)pbuf;
 	for (i = 0; i < MAX_BSS_CNT; i++) {
-		INIT_LIST_HEAD(&(pnetwork->list));
-		list_add_tail(&(pnetwork->list),
-				 &(pmlmepriv->free_bss_pool.queue));
+		INIT_LIST_HEAD(&pnetwork->list);
+		list_add_tail(&pnetwork->list,
+				 &pmlmepriv->free_bss_pool.queue);
 		pnetwork++;
 	}
 	pmlmepriv->sitesurveyctrl.last_rx_pkts = 0;
@@ -93,7 +93,7 @@ static void _free_network(struct mlme_priv *pmlmepriv,
 {
 	u32 curr_time, delta_time;
 	unsigned long irqL;
-	struct  __queue *free_queue = &(pmlmepriv->free_bss_pool);
+	struct  __queue *free_queue = &pmlmepriv->free_bss_pool;
 
 	if (!pnetwork)
 		return;
@@ -219,8 +219,8 @@ int r8712_is_same_ibss(struct _adapter *adapter, struct wlan_network *pnetwork)
 	int ret = true;
 	struct security_priv *psecuritypriv = &adapter->securitypriv;
 
-	if ((psecuritypriv->PrivacyAlgrthm != _NO_PRIVACY_) &&
-		    (pnetwork->network.Privacy == cpu_to_le32(0)))
+	if (psecuritypriv->PrivacyAlgrthm != _NO_PRIVACY_ &&
+		    pnetwork->network.Privacy == cpu_to_le32(0))
 		ret = false;
 	else if ((psecuritypriv->PrivacyAlgrthm == _NO_PRIVACY_) &&
 		 (pnetwork->network.Privacy == cpu_to_le32(1)))
@@ -285,7 +285,7 @@ static void update_network(struct wlan_bssid_ex *dst,
 	struct smooth_rssi_data *sqd = &padapter->recvpriv.signal_qual_data;
 
 	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED) &&
-	    is_same_network(&(padapter->mlmepriv.cur_network.network), src)) {
+	    is_same_network(&padapter->mlmepriv.cur_network.network, src)) {
 		if (padapter->recvpriv.signal_qual_data.total_num++ >=
 		    PHY_LINKQUALITY_SLID_WIN_MAX) {
 			padapter->recvpriv.signal_qual_data.total_num =
@@ -317,8 +317,8 @@ static void update_current_network(struct _adapter *adapter,
 {
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
-	if (is_same_network(&(pmlmepriv->cur_network.network), pnetwork)) {
-		update_network(&(pmlmepriv->cur_network.network),
+	if (is_same_network(&pmlmepriv->cur_network.network, pnetwork)) {
+		update_network(&pmlmepriv->cur_network.network,
 			       pnetwork, adapter);
 		r8712_update_protection(adapter,
 			       (pmlmepriv->cur_network.network.IEs) +
@@ -426,8 +426,8 @@ static int is_desired_network(struct _adapter *adapter,
 			return true;
 		return false;
 	}
-	if ((psecuritypriv->PrivacyAlgrthm != _NO_PRIVACY_) &&
-		    (pnetwork->network.Privacy == 0))
+	if (psecuritypriv->PrivacyAlgrthm != _NO_PRIVACY_ &&
+		    pnetwork->network.Privacy == 0)
 		bselected = false;
 	if (check_fwstate(&adapter->mlmepriv, WIFI_ADHOC_STATE)) {
 		if (pnetwork->network.InfrastructureMode !=
@@ -483,7 +483,7 @@ void r8712_survey_event_callback(struct _adapter *adapter, u8 *pbuf)
 	spin_lock_irqsave(&pmlmepriv->lock2, flags);
 	/* update IBSS_network 's timestamp */
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
-		if (!memcmp(&(pmlmepriv->cur_network.network.MacAddress),
+		if (!memcmp(&pmlmepriv->cur_network.network.MacAddress,
 		    pnetwork->MacAddress, ETH_ALEN)) {
 			struct wlan_network *ibss_wlan = NULL;
 
@@ -536,7 +536,7 @@ void r8712_surveydone_event_callback(struct _adapter *adapter, u8 *pbuf)
 						  msecs_to_jiffies(MAX_JOIN_TIMEOUT));
 				} else {
 					struct wlan_bssid_ex *pdev_network =
-					  &(adapter->registrypriv.dev_network);
+					  &adapter->registrypriv.dev_network;
 					u8 *pibss =
 						 adapter->registrypriv.dev_network.MacAddress;
 					pmlmepriv->fw_state ^= _FW_UNDER_SURVEY;
@@ -596,8 +596,8 @@ void r8712_free_assoc_resources(struct _adapter *adapter)
 	if (pwlan)
 		pwlan->fixed = false;
 
-	if (((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) &&
-	     (adapter->stapriv.asoc_sta_count == 1)))
+	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) &&
+	     adapter->stapriv.asoc_sta_count == 1)
 		free_network_nolock(pmlmepriv, pwlan);
 }
 
@@ -726,7 +726,7 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 						cur_network->network.MacAddress);
 					spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL2);
 					r8712_free_stainfo(adapter, pcur_sta);
-					spin_unlock_irqrestore(&(pstapriv->sta_hash_lock), irqL2);
+					spin_unlock_irqrestore(&pstapriv->sta_hash_lock, irqL2);
 
 					ptarget_wlan =
 						r8712_find_network(&pmlmepriv->scanned_queue,
@@ -846,7 +846,7 @@ void r8712_stassoc_event_callback(struct _adapter *adapter, u8 *pbuf)
 {
 	unsigned long irqL;
 	struct sta_info *psta;
-	struct mlme_priv *pmlmepriv = &(adapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	struct stassoc_event *pstassoc	= (struct stassoc_event *)pbuf;
 
 	/* to do: */
@@ -915,7 +915,7 @@ void r8712_stadel_event_callback(struct _adapter *adapter, u8 *pbuf)
 				free_network_nolock(pmlmepriv, pwlan);
 			}
 			/*re-create ibss*/
-			pdev_network = &(adapter->registrypriv.dev_network);
+			pdev_network = &adapter->registrypriv.dev_network;
 			pibss = adapter->registrypriv.dev_network.MacAddress;
 			memcpy(pdev_network, &tgt_network->network,
 				r8712_get_wlan_bssid_ex_sz(&tgt_network->network));
@@ -990,8 +990,8 @@ void _r8712_sitesurvey_ctrl_handler(struct _adapter *adapter)
 			  (psitesurveyctrl->last_rx_pkts);
 	psitesurveyctrl->last_tx_pkts = adapter->xmitpriv.tx_pkts;
 	psitesurveyctrl->last_rx_pkts = adapter->recvpriv.rx_pkts;
-	if ((current_tx_pkts > pregistrypriv->busy_thresh) ||
-	    (current_rx_pkts > pregistrypriv->busy_thresh))
+	if (current_tx_pkts > pregistrypriv->busy_thresh ||
+	    current_rx_pkts > pregistrypriv->busy_thresh)
 		psitesurveyctrl->traffic_busy = true;
 	else
 		psitesurveyctrl->traffic_busy = false;
@@ -1086,8 +1086,8 @@ int r8712_select_and_join_from_scan(struct mlme_priv *pmlmepriv)
 		}
 		dst_ssid = pnetwork->network.Ssid.Ssid;
 		src_ssid = pmlmepriv->assoc_ssid.Ssid;
-		if ((pnetwork->network.Ssid.SsidLength ==
-		    pmlmepriv->assoc_ssid.SsidLength) &&
+		if (pnetwork->network.Ssid.SsidLength ==
+		    pmlmepriv->assoc_ssid.SsidLength &&
 		    (!memcmp(dst_ssid, src_ssid,
 		     pmlmepriv->assoc_ssid.SsidLength))) {
 			if (pmlmepriv->assoc_by_rssi) {
@@ -1280,15 +1280,15 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 	uint ndisauthmode = psecuritypriv->ndisauthtype;
 	uint ndissecuritytype = psecuritypriv->ndisencryptstatus;
 
-	if ((ndisauthmode == Ndis802_11AuthModeWPA) ||
-	    (ndisauthmode == Ndis802_11AuthModeWPAPSK)) {
+	if (ndisauthmode == Ndis802_11AuthModeWPA ||
+	    ndisauthmode == Ndis802_11AuthModeWPAPSK) {
 		authmode = _WPA_IE_ID_;
 		uncst_oui[0] = 0x0;
 		uncst_oui[1] = 0x50;
 		uncst_oui[2] = 0xf2;
 	}
-	if ((ndisauthmode == Ndis802_11AuthModeWPA2) ||
-	    (ndisauthmode == Ndis802_11AuthModeWPA2PSK)) {
+	if (ndisauthmode == Ndis802_11AuthModeWPA2 ||
+	    ndisauthmode == Ndis802_11AuthModeWPA2PSK) {
 		authmode = _WPA2_IE_ID_;
 		uncst_oui[0] = 0x0;
 		uncst_oui[1] = 0x0f;
@@ -1315,8 +1315,8 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 	match = false;
 	while (cnt < in_len) {
 		if (in_ie[cnt] == authmode) {
-			if ((authmode == _WPA_IE_ID_) &&
-			    (!memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4))) {
+			if (authmode == _WPA_IE_ID_ &&
+			    !memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4)) {
 				memcpy(&sec_ie[0], &in_ie[cnt],
 					in_ie[cnt + 1] + 2);
 				match = true;
@@ -1328,9 +1328,9 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 				match = true;
 				break;
 			}
-			if (((authmode == _WPA_IE_ID_) &&
-			     (!memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4))) ||
-			     (authmode == _WPA2_IE_ID_))
+			if ((authmode == _WPA_IE_ID_ &&
+			     !memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4)) ||
+			     authmode == _WPA2_IE_ID_)
 				memcpy(&bkup_ie[0], &in_ie[cnt],
 					in_ie[cnt + 1] + 2);
 		}
@@ -1348,7 +1348,7 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 					match = false;
 					break;
 				}
-				if ((sec_ie[6] != 0x01) || (sec_ie[7] != 0x0)) {
+				if (sec_ie[6] != 0x01 || sec_ie[7] != 0x0) {
 					/*IE Ver error*/
 					match = false;
 					break;
@@ -1415,7 +1415,7 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 			 * algorithm, and set the bc/mc encryption algorithm
 			 */
 			while (true) {
-				if ((sec_ie[2] != 0x01) || (sec_ie[3] != 0x0)) {
+				if (sec_ie[2] != 0x01 || sec_ie[3] != 0x0) {
 					/*IE Ver error*/
 					match = false;
 					break;
@@ -1474,7 +1474,7 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 			}
 		}
 	}
-	if ((authmode == _WPA_IE_ID_) || (authmode == _WPA2_IE_ID_)) {
+	if (authmode == _WPA_IE_ID_ || authmode == _WPA2_IE_ID_) {
 		/*copy fixed ie*/
 		memcpy(out_ie, in_ie, 12);
 		ielength = 12;
@@ -1609,7 +1609,7 @@ unsigned int r8712_restructure_ht_ie(struct _adapter *padapter, u8 *in_ie,
 
 	phtpriv->ht_option = 0;
 	p = r8712_get_ie(in_ie + 12, WLAN_EID_HT_CAPABILITY, &ielen, in_len - 12);
-	if (p && (ielen > 0)) {
+	if (p && ielen > 0) {
 		if (pqospriv->qos_option == 0) {
 			out_len = *pout_len;
 			r8712_set_ie(out_ie + out_len, WLAN_EID_VENDOR_SPECIFIC,
@@ -1646,13 +1646,13 @@ static void update_ht_cap(struct _adapter *padapter, u8 *pie, uint ie_len)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
-	struct wlan_network *pcur_network = &(pmlmepriv->cur_network);
+	struct wlan_network *pcur_network = &pmlmepriv->cur_network;
 
 	if (!phtpriv->ht_option)
 		return;
 	/* maybe needs check if ap supports rx ampdu. */
 	if (!phtpriv->ampdu_enable &&
-	    (pregistrypriv->ampdu_enable == 1))
+	    pregistrypriv->ampdu_enable == 1)
 		phtpriv->ampdu_enable = true;
 	/*check Max Rx A-MPDU Size*/
 	len = 0;
@@ -1701,7 +1701,7 @@ void r8712_issue_addbareq_cmd(struct _adapter *padapter, int priority)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct ht_priv	 *phtpriv = &pmlmepriv->htpriv;
 
-	if ((phtpriv->ht_option == 1) && (phtpriv->ampdu_enable)) {
+	if (phtpriv->ht_option == 1 && phtpriv->ampdu_enable) {
 		if (!phtpriv->baddbareq_issued[priority]) {
 			r8712_addbareq_cmd(padapter, (u8)priority);
 			phtpriv->baddbareq_issued[priority] = true;
diff --git a/drivers/staging/rtl8712/rtl871x_mp.c b/drivers/staging/rtl8712/rtl871x_mp.c
index 099c512c8519..c6bc7b546166 100644
--- a/drivers/staging/rtl8712/rtl871x_mp.c
+++ b/drivers/staging/rtl8712/rtl871x_mp.c
@@ -52,9 +52,9 @@ static int init_mp_priv(struct mp_priv *pmp_priv)
 			 ((addr_t)(pmp_priv->pallocated_mp_xmitframe_buf) & 3);
 	pmp_xmitframe = (struct mp_xmit_frame *)pmp_priv->pmp_xmtframe_buf;
 	for (i = 0; i < NR_MP_XMITFRAME; i++) {
-		INIT_LIST_HEAD(&(pmp_xmitframe->list));
-		list_add_tail(&(pmp_xmitframe->list),
-				 &(pmp_priv->free_mp_xmitqueue.queue));
+		INIT_LIST_HEAD(&pmp_xmitframe->list);
+		list_add_tail(&pmp_xmitframe->list,
+				 &pmp_priv->free_mp_xmitqueue.queue);
 		pmp_xmitframe->pkt = NULL;
 		pmp_xmitframe->frame_tag = MP_FRAMETAG;
 		pmp_xmitframe->padapter = pmp_priv->papdater;
diff --git a/drivers/staging/rtl8712/rtl871x_mp_ioctl.c b/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
index 26fa09b45c90..7edc7cc2d39e 100644
--- a/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
+++ b/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
@@ -545,8 +545,8 @@ uint oid_rt_pro_read_register_hdl(struct oid_par_priv *poid_par_priv)
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
 	RegRWStruct = (struct mp_rw_reg *)poid_par_priv->information_buf;
-	if ((RegRWStruct->offset >= 0x10250800) &&
-	    (RegRWStruct->offset <= 0x10250FFF)) {
+	if (RegRWStruct->offset >= 0x10250800 &&
+	    RegRWStruct->offset <= 0x10250FFF) {
 		/*baseband register*/
 		/*0ffset :0x800~0xfff*/
 		offset = (u16)(RegRWStruct->offset) & 0xFFF;
@@ -587,8 +587,8 @@ uint oid_rt_pro_write_register_hdl(struct oid_par_priv *poid_par_priv)
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
 	RegRWStruct = (struct mp_rw_reg *)poid_par_priv->information_buf;
-	if ((RegRWStruct->offset >= 0x10250800) &&
-	    (RegRWStruct->offset <= 0x10250FFF)) {
+	if (RegRWStruct->offset >= 0x10250800 &&
+	    RegRWStruct->offset <= 0x10250FFF) {
 		/*baseband register*/
 		offset = (u16)(RegRWStruct->offset) & 0xFFF;
 		value = RegRWStruct->value;
@@ -678,7 +678,7 @@ uint oid_rt_pro_read_efuse_hdl(struct oid_par_priv *poid_par_priv)
 	cnts = pefuse->cnts;
 	data = pefuse->data;
 	memset(data, 0xFF, cnts);
-	if ((addr > 511) || (cnts < 1) || (cnts > 512) || (addr + cnts) >
+	if (addr > 511 || cnts < 1 || cnts > 512 || addr + cnts >
 	     EFUSE_MAX_SIZE)
 		return RNDIS_STATUS_NOT_ACCEPTED;
 	if (!r8712_efuse_access(Adapter, true, addr, cnts, data))
@@ -707,8 +707,8 @@ uint oid_rt_pro_write_efuse_hdl(struct oid_par_priv *poid_par_priv)
 	cnts = pefuse->cnts;
 	data = pefuse->data;
 
-	if ((addr > 511) || (cnts < 1) || (cnts > 512) ||
-	    (addr + cnts) > r8712_efuse_get_max_size(Adapter))
+	if (addr > 511 || cnts < 1 || cnts > 512 ||
+	    addr + cnts > r8712_efuse_get_max_size(Adapter))
 		return RNDIS_STATUS_NOT_ACCEPTED;
 	if (!r8712_efuse_access(Adapter, false, addr, cnts, data))
 		status = RNDIS_STATUS_FAILURE;
diff --git a/drivers/staging/rtl8712/rtl871x_pwrctrl.c b/drivers/staging/rtl8712/rtl871x_pwrctrl.c
index cd6d9ff0bebc..6831fbcf10c0 100644
--- a/drivers/staging/rtl8712/rtl871x_pwrctrl.c
+++ b/drivers/staging/rtl8712/rtl871x_pwrctrl.c
@@ -64,7 +64,7 @@ void r8712_set_ps_mode(struct _adapter *padapter, uint ps_mode, uint smart_ps)
 	/* if driver is in active state, we dont need set smart_ps.*/
 	if (ps_mode == PS_MODE_ACTIVE)
 		smart_ps = 0;
-	if ((pwrpriv->pwr_mode != ps_mode) || (pwrpriv->smart_ps != smart_ps)) {
+	if (pwrpriv->pwr_mode != ps_mode || pwrpriv->smart_ps != smart_ps) {
 		if (pwrpriv->pwr_mode == PS_MODE_ACTIVE)
 			pwrpriv->bSleep = true;
 		else
@@ -86,17 +86,17 @@ void r8712_set_ps_mode(struct _adapter *padapter, uint ps_mode, uint smart_ps)
 void r8712_cpwm_int_hdl(struct _adapter *padapter,
 			struct reportpwrstate_parm *preportpwrstate)
 {
-	struct pwrctrl_priv *pwrpriv = &(padapter->pwrctrlpriv);
-	struct cmd_priv	*pcmdpriv = &(padapter->cmdpriv);
+	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
+	struct cmd_priv	*pcmdpriv = &padapter->cmdpriv;
 
-	if (pwrpriv->cpwm_tog == ((preportpwrstate->state) & 0x80))
+        if (pwrpriv->cpwm_tog == (preportpwrstate->state & 0x80))
 		return;
 	del_timer(&padapter->pwrctrlpriv.rpwm_check_timer);
 	mutex_lock(&pwrpriv->mutex_lock);
 	pwrpriv->cpwm = (preportpwrstate->state) & 0xf;
 	if (pwrpriv->cpwm >= PS_STATE_S2) {
 		if (pwrpriv->alives & CMD_ALIVE)
-			complete(&(pcmdpriv->cmd_queue_comp));
+			complete(&pcmdpriv->cmd_queue_comp);
 	}
 	pwrpriv->cpwm_tog = (preportpwrstate->state) & 0x80;
 	mutex_unlock(&pwrpriv->mutex_lock);
@@ -214,11 +214,11 @@ void r8712_unregister_cmd_alive(struct _adapter *padapter)
 
 	mutex_lock(&pwrctrl->mutex_lock);
 	unregister_task_alive(pwrctrl, CMD_ALIVE);
-	if ((pwrctrl->cpwm > PS_STATE_S2) &&
-	   (pwrctrl->pwr_mode > PS_MODE_ACTIVE)) {
-		if ((pwrctrl->alives == 0) &&
-		    (check_fwstate(&padapter->mlmepriv,
-		     _FW_UNDER_LINKING) != true)) {
+	if (pwrctrl->cpwm > PS_STATE_S2 &&
+	   pwrctrl->pwr_mode > PS_MODE_ACTIVE) {
+		if (pwrctrl->alives == 0 &&
+		    check_fwstate(&padapter->mlmepriv,
+		     _FW_UNDER_LINKING) != true) {
 			r8712_set_rpwm(padapter, PS_STATE_S0);
 		}
 	}
diff --git a/drivers/staging/rtl8712/rtl871x_recv.c b/drivers/staging/rtl8712/rtl871x_recv.c
index 8a3566214af7..bce5e7658605 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.c
+++ b/drivers/staging/rtl8712/rtl871x_recv.c
@@ -66,9 +66,9 @@ int _r8712_init_recv_priv(struct recv_priv *precvpriv,
 				    (RXFRAME_ALIGN_SZ - 1));
 	precvframe = (union recv_frame *)precvpriv->precv_frame_buf;
 	for (i = 0; i < NR_RECVFRAME; i++) {
-		INIT_LIST_HEAD(&(precvframe->u.list));
-		list_add_tail(&(precvframe->u.list),
-			      &(precvpriv->free_recv_queue.queue));
+		INIT_LIST_HEAD(&precvframe->u.list);
+		list_add_tail(&precvframe->u.list,
+			      &precvpriv->free_recv_queue.queue);
 		r8712_os_recv_resource_alloc(padapter, precvframe);
 		precvframe->u.hdr.adapter = padapter;
 		precvframe++;
@@ -200,7 +200,7 @@ union recv_frame *r8712_decryptor(struct _adapter *padapter,
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	union recv_frame *return_packet = precv_frame;
 
-	if ((prxattrib->encrypt > 0) && ((prxattrib->bdecrypted == 0) ||
+	if (prxattrib->encrypt > 0 && (prxattrib->bdecrypted == 0 ||
 					 psecuritypriv->sw_decrypt)) {
 		psecuritypriv->hw_decrypted = false;
 		switch (prxattrib->encrypt) {
@@ -310,7 +310,7 @@ static sint sta2sta_data_frame(struct _adapter *adapter,
 		/* filter packets that SA is myself or multicast or broadcast */
 		if (!memcmp(myhwaddr, pattrib->src, ETH_ALEN))
 			return _FAIL;
-		if ((memcmp(myhwaddr, pattrib->dst, ETH_ALEN)) && (!bmcast))
+		if ((memcmp(myhwaddr, pattrib->dst, ETH_ALEN)) && !bmcast)
 			return _FAIL;
 		if (is_zero_ether_addr(pattrib->bssid) ||
 		    is_zero_ether_addr(mybssid) ||
@@ -392,7 +392,7 @@ static sint ap2sta_data_frame(struct _adapter *adapter,
 			return _FAIL;
 
 		/* da should be for me */
-		if ((memcmp(myhwaddr, pattrib->dst, ETH_ALEN)) && (!bmcast))
+		if ((memcmp(myhwaddr, pattrib->dst, ETH_ALEN)) && !bmcast)
 			return _FAIL;
 		/* check BSSID */
 		if (is_zero_ether_addr(pattrib->bssid) ||
@@ -654,7 +654,7 @@ void r8712_recv_entry(union recv_frame *precvframe)
 	s32 ret = _SUCCESS;
 
 	padapter = precvframe->u.hdr.adapter;
-	precvpriv = &(padapter->recvpriv);
+	precvpriv = &padapter->recvpriv;
 
 	padapter->ledpriv.LedControlHandler(padapter, LED_CTL_RX);
 
diff --git a/drivers/staging/rtl8712/rtl871x_security.c b/drivers/staging/rtl8712/rtl871x_security.c
index e46a5dbc7b65..48f1bb8b5cc0 100644
--- a/drivers/staging/rtl8712/rtl871x_security.c
+++ b/drivers/staging/rtl8712/rtl871x_security.c
@@ -164,7 +164,7 @@ void r8712_wep_encrypt(struct _adapter *padapter, u8 *pxmitframe)
 		return;
 	pframe = ((struct xmit_frame *)pxmitframe)->buf_addr + TXDESC_OFFSET;
 	/*start to encrypt each fragment*/
-	if ((pattrib->encrypt == _WEP40_) || (pattrib->encrypt == _WEP104_)) {
+	if (pattrib->encrypt == _WEP40_ || pattrib->encrypt == _WEP104_) {
 		pki = psecuritypriv->PrivacyKeyIndex;
 		keylength = psecuritypriv->DefKeylen[pki];
 		for (curfragnum = 0; curfragnum < pattrib->nr_frags;
@@ -220,8 +220,8 @@ void r8712_wep_decrypt(struct _adapter  *padapter, u8 *precvframe)
 	pframe = (unsigned char *)((union recv_frame *)precvframe)->
 		  u.hdr.rx_data;
 	/* start to decrypt recvframe */
-	if ((prxattrib->encrypt == _WEP40_) || (prxattrib->encrypt ==
-	     _WEP104_)) {
+	if (prxattrib->encrypt == _WEP40_ || prxattrib->encrypt ==
+	     _WEP104_) {
 		iv = pframe + prxattrib->hdrlen;
 		keyindex = (iv[3] & 0x3);
 		keylength = psecuritypriv->DefKeylen[keyindex];
@@ -1039,7 +1039,7 @@ static void aes_cipher(u8 *key, uint hdrlen,
 	memset((void *)aes_out, 0, 16);
 	memset((void *)padded_buffer, 0, 16);
 
-	if ((hdrlen == WLAN_HDR_A3_LEN) || (hdrlen ==  WLAN_HDR_A3_QOS_LEN))
+	if (hdrlen == WLAN_HDR_A3_LEN || hdrlen ==  WLAN_HDR_A3_QOS_LEN)
 		a4_exists = 0;
 	else
 		a4_exists = 1;
@@ -1220,7 +1220,7 @@ static void aes_decipher(u8 *key, uint hdrlen,
 	pn_vector[3] = pframe[hdrlen + 5];
 	pn_vector[4] = pframe[hdrlen + 6];
 	pn_vector[5] = pframe[hdrlen + 7];
-	if ((hdrlen == WLAN_HDR_A3_LEN) || (hdrlen ==  WLAN_HDR_A3_QOS_LEN))
+	if (hdrlen == WLAN_HDR_A3_LEN || hdrlen ==  WLAN_HDR_A3_QOS_LEN)
 		a4_exists = 0;
 	else
 		a4_exists = 1;
diff --git a/drivers/staging/rtl8712/rtl871x_sta_mgt.c b/drivers/staging/rtl8712/rtl871x_sta_mgt.c
index 2c806a0105bf..3b756f080929 100644
--- a/drivers/staging/rtl8712/rtl871x_sta_mgt.c
+++ b/drivers/staging/rtl8712/rtl871x_sta_mgt.c
@@ -53,7 +53,7 @@ int _r8712_init_sta_priv(struct	sta_priv *pstapriv)
 	psta = (struct sta_info *)(pstapriv->pstainfo_buf);
 	for (i = 0; i < NUM_STA; i++) {
 		_init_stainfo(psta);
-		INIT_LIST_HEAD(&(pstapriv->sta_hash[i]));
+		INIT_LIST_HEAD(&pstapriv->sta_hash[i]);
 		list_add_tail(&psta->list, &pstapriv->free_sta_queue.queue);
 		psta++;
 	}
@@ -153,22 +153,22 @@ void r8712_free_stainfo(struct _adapter *padapter, struct sta_info *psta)
 		return;
 	pfree_sta_queue = &pstapriv->free_sta_queue;
 	pstaxmitpriv = &psta->sta_xmitpriv;
-	spin_lock_irqsave(&(pxmitpriv->vo_pending.lock), irqL0);
+	spin_lock_irqsave(&pxmitpriv->vo_pending.lock, irqL0);
 	r8712_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->vo_q.sta_pending);
-	list_del_init(&(pstaxmitpriv->vo_q.tx_pending));
-	spin_unlock_irqrestore(&(pxmitpriv->vo_pending.lock), irqL0);
-	spin_lock_irqsave(&(pxmitpriv->vi_pending.lock), irqL0);
+	list_del_init(&pstaxmitpriv->vo_q.tx_pending);
+	spin_unlock_irqrestore(&pxmitpriv->vo_pending.lock, irqL0);
+	spin_lock_irqsave(&pxmitpriv->vi_pending.lock, irqL0);
 	r8712_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->vi_q.sta_pending);
-	list_del_init(&(pstaxmitpriv->vi_q.tx_pending));
-	spin_unlock_irqrestore(&(pxmitpriv->vi_pending.lock), irqL0);
-	spin_lock_irqsave(&(pxmitpriv->bk_pending.lock), irqL0);
+	list_del_init(&pstaxmitpriv->vi_q.tx_pending);
+	spin_unlock_irqrestore(&pxmitpriv->vi_pending.lock, irqL0);
+	spin_lock_irqsave(&pxmitpriv->bk_pending.lock, irqL0);
 	r8712_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->bk_q.sta_pending);
-	list_del_init(&(pstaxmitpriv->bk_q.tx_pending));
-	spin_unlock_irqrestore(&(pxmitpriv->bk_pending.lock), irqL0);
-	spin_lock_irqsave(&(pxmitpriv->be_pending.lock), irqL0);
+	list_del_init(&pstaxmitpriv->bk_q.tx_pending);
+	spin_unlock_irqrestore(&pxmitpriv->bk_pending.lock, irqL0);
+	spin_lock_irqsave(&pxmitpriv->be_pending.lock, irqL0);
 	r8712_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->be_q.sta_pending);
 	list_del_init(&(pstaxmitpriv->be_q.tx_pending));
-	spin_unlock_irqrestore(&(pxmitpriv->be_pending.lock), irqL0);
+	spin_unlock_irqrestore(&pxmitpriv->be_pending.lock, irqL0);
 	list_del_init(&psta->hash_list);
 	pstapriv->asoc_sta_count--;
 	/* re-init sta_info; 20061114 */
@@ -181,10 +181,10 @@ void r8712_free_stainfo(struct _adapter *padapter, struct sta_info *psta)
 		preorder_ctrl = &psta->recvreorder_ctrl[i];
 		del_timer(&preorder_ctrl->reordering_ctrl_timer);
 	}
-	spin_lock(&(pfree_sta_queue->lock));
+	spin_lock(&pfree_sta_queue->lock);
 	/* insert into free_sta_queue; 20061114 */
 	list_add_tail(&psta->list, &pfree_sta_queue->queue);
-	spin_unlock(&(pfree_sta_queue->lock));
+	spin_unlock(&pfree_sta_queue->lock);
 }
 
 /* free all stainfo which in sta_hash[all] */
@@ -201,7 +201,7 @@ void r8712_free_all_stainfo(struct _adapter *padapter)
 		return;
 	spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL);
 	for (index = 0; index < NUM_STA; index++) {
-		phead = &(pstapriv->sta_hash[index]);
+		phead = &pstapriv->sta_hash[index];
 		plist = phead->next;
 		while (!end_of_queue_search(phead, plist)) {
 			psta = container_of(plist,
@@ -226,7 +226,7 @@ struct sta_info *r8712_get_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 		return NULL;
 	index = wifi_mac_hash(hwaddr);
 	spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL);
-	phead = &(pstapriv->sta_hash[index]);
+	phead = &pstapriv->sta_hash[index];
 	plist = phead->next;
 	while (!end_of_queue_search(phead, plist)) {
 		psta = container_of(plist, struct sta_info, hash_list);
diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
index 6353dbe554d3..0a56ec588818 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -88,14 +88,14 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 			((addr_t) (pxmitpriv->pallocated_frame_buf) & 3);
 	pxframe = (struct xmit_frame *) pxmitpriv->pxmit_frame_buf;
 	for (i = 0; i < NR_XMITFRAME; i++) {
-		INIT_LIST_HEAD(&(pxframe->list));
+		INIT_LIST_HEAD(&pxframe->list);
 		pxframe->padapter = padapter;
 		pxframe->frame_tag = DATA_FRAMETAG;
 		pxframe->pkt = NULL;
 		pxframe->buf_addr = NULL;
 		pxframe->pxmitbuf = NULL;
-		list_add_tail(&(pxframe->list),
-				 &(pxmitpriv->free_xmit_queue.queue));
+		list_add_tail(&pxframe->list,
+				 &pxmitpriv->free_xmit_queue.queue);
 		pxframe++;
 	}
 	pxmitpriv->free_xmitframe_cnt = NR_XMITFRAME;
@@ -140,7 +140,7 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 			goto clean_up_alloc_buf;
 		}
 		list_add_tail(&pxmitbuf->list,
-				 &(pxmitpriv->free_xmitbuf_queue.queue));
+				 &pxmitpriv->free_xmitbuf_queue.queue);
 		pxmitbuf++;
 	}
 	pxmitpriv->free_xmitbuf_cnt = NR_XMITBUFF;
@@ -271,8 +271,8 @@ int r8712_update_attrib(struct _adapter *padapter, _pkt *pkt,
 		pattrib->dhcp_pkt = 0;
 		if (pktfile.pkt_len > 282) {/*MINIMUM_DHCP_PACKET_SIZE)*/
 			if (pattrib->ether_type == ETH_P_IP) {/* IP header*/
-				if (((tmp[21] == 68) && (tmp[23] == 67)) ||
-					((tmp[21] == 67) && (tmp[23] == 68))) {
+				if ((tmp[21] == 68 && tmp[23] == 67) ||
+					(tmp[21] == 67 && tmp[23] == 68)) {
 					/* 68 : UDP BOOTP client
 					 * 67 : UDP BOOTP server
 					 * Use low rate to send DHCP packet.
@@ -323,7 +323,7 @@ int r8712_update_attrib(struct _adapter *padapter, _pkt *pkt,
 	}
 	if (psta->ieee8021x_blocked) {
 		pattrib->encrypt = 0;
-		if ((pattrib->ether_type != 0x888e) &&
+		if (pattrib->ether_type != 0x888e &&
 		    !check_fwstate(pmlmepriv, WIFI_MP_STATE))
 			return -EINVAL;
 	} else {
@@ -373,7 +373,7 @@ static int xmitframe_addmic(struct _adapter *padapter,
 	u8	*pframe, *payload, mic[8];
 	struct	mic_data micdata;
 	struct	sta_info *stainfo;
-	struct	qos_priv *pqospriv = &(padapter->mlmepriv.qospriv);
+	struct	qos_priv *pqospriv = &padapter->mlmepriv.qospriv;
 	struct	pkt_attrib  *pattrib = &pxmitframe->attrib;
 	struct	security_priv *psecpriv = &padapter->securitypriv;
 	struct	xmit_priv *pxmitpriv = &padapter->xmitpriv;
@@ -455,11 +455,11 @@ static int xmitframe_addmic(struct _adapter *padapter,
 						  pattrib->icv_len;
 				}
 			}
-			r8712_secgetmic(&micdata, &(mic[0]));
+			r8712_secgetmic(&micdata, &mic[0]);
 			/* add mic code  and add the mic code length in
 			 * last_txcmdsz
 			 */
-			memcpy(payload, &(mic[0]), 8);
+			memcpy(payload, &mic[0], 8);
 			pattrib->last_txcmdsz += 8;
 			payload = payload - pattrib->last_txcmdsz + 8;
 		}
@@ -682,7 +682,7 @@ sint r8712_xmitframe_coalesce(struct _adapter *padapter, _pkt *pkt,
 			pframe += llc_sz;
 			mpdu_len -= llc_sz;
 		}
-		if ((pattrib->icv_len > 0) && (pattrib->bswenc))
+		if (pattrib->icv_len > 0 && pattrib->bswenc)
 			mpdu_len -= pattrib->icv_len;
 		if (bmcst)
 			mem_sz = _r8712_pktfile_read(&pktfile, pframe,
@@ -691,7 +691,7 @@ sint r8712_xmitframe_coalesce(struct _adapter *padapter, _pkt *pkt,
 			mem_sz = _r8712_pktfile_read(&pktfile, pframe,
 				 mpdu_len);
 		pframe += mem_sz;
-		if ((pattrib->icv_len > 0) && (pattrib->bswenc)) {
+		if (pattrib->icv_len > 0 && pattrib->bswenc) {
 			memcpy(pframe, pattrib->icv, pattrib->icv_len);
 			pframe += pattrib->icv_len;
 		}
@@ -778,7 +778,7 @@ void r8712_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
 		return;
 	spin_lock_irqsave(&pfree_xmitbuf_queue->lock, irqL);
 	list_del_init(&pxmitbuf->list);
-	list_add_tail(&(pxmitbuf->list), &pfree_xmitbuf_queue->queue);
+	list_add_tail(&pxmitbuf->list, &pfree_xmitbuf_queue->queue);
 	pxmitpriv->free_xmitbuf_cnt++;
 	spin_unlock_irqrestore(&pfree_xmitbuf_queue->lock, irqL);
 }
@@ -856,7 +856,7 @@ void r8712_free_xmitframe_queue(struct xmit_priv *pxmitpriv,
 	struct list_head *plist, *phead;
 	struct	xmit_frame	*pxmitframe;
 
-	spin_lock_irqsave(&(pframequeue->lock), irqL);
+	spin_lock_irqsave(&pframequeue->lock, irqL);
 	phead = &pframequeue->queue;
 	plist = phead->next;
 	while (!end_of_queue_search(phead, plist)) {
@@ -864,7 +864,7 @@ void r8712_free_xmitframe_queue(struct xmit_priv *pxmitpriv,
 		plist = plist->next;
 		r8712_free_xmitframe(pxmitpriv, pxmitframe);
 	}
-	spin_unlock_irqrestore(&(pframequeue->lock), irqL);
+	spin_unlock_irqrestore(&pframequeue->lock, irqL);
 }
 
 static inline struct tx_servq *get_sta_pending(struct _adapter *padapter,
@@ -877,26 +877,26 @@ static inline struct tx_servq *get_sta_pending(struct _adapter *padapter,
 	switch (up) {
 	case 1:
 	case 2:
-		ptxservq = &(psta->sta_xmitpriv.bk_q);
+		ptxservq = &psta->sta_xmitpriv.bk_q;
 		*ppstapending = &padapter->xmitpriv.bk_pending;
 		(phwxmits + 3)->accnt++;
 		break;
 	case 4:
 	case 5:
-		ptxservq = &(psta->sta_xmitpriv.vi_q);
+		ptxservq = &psta->sta_xmitpriv.vi_q;
 		*ppstapending = &padapter->xmitpriv.vi_pending;
 		(phwxmits + 1)->accnt++;
 		break;
 	case 6:
 	case 7:
-		ptxservq = &(psta->sta_xmitpriv.vo_q);
+		ptxservq = &psta->sta_xmitpriv.vo_q;
 		*ppstapending = &padapter->xmitpriv.vo_pending;
 		(phwxmits + 0)->accnt++;
 		break;
 	case 0:
 	case 3:
 	default:
-		ptxservq = &(psta->sta_xmitpriv.be_q);
+		ptxservq = &psta->sta_xmitpriv.be_q;
 		*ppstapending = &padapter->xmitpriv.be_pending;
 		(phwxmits + 2)->accnt++;
 		break;
diff --git a/drivers/staging/rtl8712/usb_halinit.c b/drivers/staging/rtl8712/usb_halinit.c
index 313c569748e9..b3cd59b9830c 100644
--- a/drivers/staging/rtl8712/usb_halinit.c
+++ b/drivers/staging/rtl8712/usb_halinit.c
@@ -285,7 +285,7 @@ unsigned int r8712_usb_inirp_init(struct _adapter *adapter)
 	u8 i;
 	struct recv_buf *recvbuf;
 	struct intf_hdl *intfhdl = &adapter->pio_queue->intf;
-	struct recv_priv *recvpriv = &(adapter->recvpriv);
+	struct recv_priv *recvpriv = &adapter->recvpriv;
 
 	recvpriv->ff_hwaddr = RTL8712_DMA_RX0FF; /* mapping rx fifo address */
 	/* issue Rx irp to receive data */
diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index df05213f922f..71473b4772d9 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -320,7 +320,7 @@ static void disable_ht_for_spec_devid(const struct usb_device_id *pdid,
 		pid = specific_device_id_tbl[i].idProduct;
 		flags = specific_device_id_tbl[i].flags;
 
-		if ((pdid->idVendor == vid) && (pdid->idProduct == pid) &&
+		if (pdid->idVendor == vid && pdid->idProduct == pid &&
 		    (flags & SPEC_DEV_ID_DISABLE_HT)) {
 			padapter->registrypriv.ht_enable = 0;
 			padapter->registrypriv.cbw40_enable = 0;
@@ -536,13 +536,13 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
 		} else {
 			AutoloadFail = false;
 		}
-		if ((!AutoloadFail) ||
-		    ((mac[0] == 0xff) && (mac[1] == 0xff) &&
-		     (mac[2] == 0xff) && (mac[3] == 0xff) &&
-		     (mac[4] == 0xff) && (mac[5] == 0xff)) ||
-		    ((mac[0] == 0x00) && (mac[1] == 0x00) &&
-		     (mac[2] == 0x00) && (mac[3] == 0x00) &&
-		     (mac[4] == 0x00) && (mac[5] == 0x00))) {
+		if (!AutoloadFail ||
+		    (mac[0] == 0xff && mac[1] == 0xff &&
+		     mac[2] == 0xff && mac[3] == 0xff &&
+		     mac[4] == 0xff && mac[5] == 0xff) ||
+		    (mac[0] == 0x00 && mac[1] == 0x00 &&
+		     mac[2] == 0x00 && mac[3] == 0x00 &&
+		     mac[4] == 0x00 && mac[5] == 0x00)) {
 			mac[0] = 0x00;
 			mac[1] = 0xe0;
 			mac[2] = 0x4c;
diff --git a/drivers/staging/rtl8712/usb_ops_linux.c b/drivers/staging/rtl8712/usb_ops_linux.c
index b2181e1e2d38..f3de3a634c78 100644
--- a/drivers/staging/rtl8712/usb_ops_linux.c
+++ b/drivers/staging/rtl8712/usb_ops_linux.c
@@ -141,7 +141,7 @@ static unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr)
 static void usb_write_mem_complete(struct urb *purb)
 {
 	struct io_queue *pio_q = (struct io_queue *)purb->context;
-	struct intf_hdl *pintf = &(pio_q->intf);
+	struct intf_hdl *pintf = &pio_q->intf;
 	struct intf_priv *pintfpriv = pintf->pintfpriv;
 	struct _adapter *padapter = (struct _adapter *)pintf->adapter;
 
@@ -164,8 +164,8 @@ void r8712_usb_write_mem(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *wmem)
 	struct usb_device *pusbd = pdvobj->pusbdev;
 	struct urb *piorw_urb = pintfpriv->piorw_urb;
 
-	if ((padapter->driver_stopped) || (padapter->surprise_removed) ||
-	    (padapter->pwrctrlpriv.pnp_bstop_trx))
+	if (padapter->driver_stopped || padapter->surprise_removed ||
+	    padapter->pwrctrlpriv.pnp_bstop_trx)
 		return;
 	/* translate DMA FIFO addr to pipehandle */
 	pipe = ffaddr2pipehdl(pdvobj, addr);
@@ -190,7 +190,7 @@ static void r8712_usb_read_port_complete(struct urb *purb)
 		return;
 	if (purb->status == 0) { /* SUCCESS */
 		if ((purb->actual_length > (MAX_RECVBUF_SZ)) ||
-		    (purb->actual_length < RXDESC_SIZE)) {
+		    purb->actual_length < RXDESC_SIZE) {
 			r8712_read_port(padapter, precvpriv->ff_hwaddr, 0,
 				  (unsigned char *)precvbuf);
 		} else {
@@ -391,8 +391,8 @@ u32 r8712_usb_write_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *wmem)
 	struct usb_device *pusbd = pdvobj->pusbdev;
 	struct pkt_attrib *pattrib = &pxmitframe->attrib;
 
-	if ((padapter->driver_stopped) || (padapter->surprise_removed) ||
-	    (padapter->pwrctrlpriv.pnp_bstop_trx))
+	if (padapter->driver_stopped || padapter->surprise_removed ||
+	    padapter->pwrctrlpriv.pnp_bstop_trx)
 		return _FAIL;
 	for (i = 0; i < 8; i++) {
 		if (!pxmitframe->bpending[i]) {
diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
index ceb6b590b310..fb7eadafe73a 100644
--- a/drivers/staging/rtl8712/xmit_linux.c
+++ b/drivers/staging/rtl8712/xmit_linux.c
@@ -150,7 +150,7 @@ netdev_tx_t r8712_xmit_entry(_pkt *pkt, struct  net_device *netdev)
 {
 	struct xmit_frame *xmitframe = NULL;
 	struct _adapter *adapter = netdev_priv(netdev);
-	struct xmit_priv *xmitpriv = &(adapter->xmitpriv);
+	struct xmit_priv *xmitpriv = &adapter->xmitpriv;
 
 	if (!r8712_if_up(adapter))
 		goto _xmit_entry_drop;
-- 
2.30.2

