Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07EE7B71C9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240943AbjJCTd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240932AbjJCTdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:33:21 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5972BE5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:33:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9b2d64c9307so53299566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696361595; x=1696966395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t+kgI4c8aoHedz3AgEryt8ujyL2qg+dNsB9glGz9XwY=;
        b=by0+W7lZOnVTd+CeJ6UEyhkgVW0kK5swvMDxwirX4el15LysY4e77w1Tr1iqHYO6ym
         G/mfUWxcQLQtPmy4T5cu6qYSHOkZPgvk/1yMZdOCckMw13dX4Dd/MYzVcLgfmOVYnfA4
         MPI0eaHO7LdwX0uJZFbmC4PFR5QqkFc5ViLyn3vrNaDw8ZIpnjBJfE6KsZgxkBCLyXnz
         bbRyeyxP0RMHp9zqlt2PrdAlMtAgz6XHEnOGOHRpPrNodxFDq3/jmvpFouGNmrMQYmxo
         nKHbM6PzX5Z+ABTTTZBS19ydT7bgp8lKqOVh5MDUiEFxzW4fEmsHD1Xv54XYhkvZ7kng
         Jp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696361595; x=1696966395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+kgI4c8aoHedz3AgEryt8ujyL2qg+dNsB9glGz9XwY=;
        b=lbSedoGMyDYereCZhyb9n9/o42SBrU66P3bkTxJpE/JWROoMHk8rOuF634pQqE37s7
         B/XI/f/mu6f3l2OGSZ/kk4fUGpglYXFuu5PExhgXrB4h8DSd+WXSmyut7Sfa2uTgGrv8
         zrFhEDFM4PQW2fDwgqPTyBSuagP18KZ/MeDoiCKPcMazh2T78QrSIPUlulWeM97DQZ2Z
         NhSZ3XYSwp5PFTyy6P+X0vJif7E1STYKjtuFKiO5zXQYDqTgNUh42p8kDmtL0VwdNb7Y
         LajCG/XeBK2JNlq6MIX1Ihv0gjbSrUhLMZ6JgGlCaWZKizzgdAV4bR06o9On6/4FCMXi
         jWwg==
X-Gm-Message-State: AOJu0Yz/5wscov5IjKA6lYXGbKQg0J7ES2WsdtdWBe5Z31k73fChFiCx
        NZ/szTZ68fgqdsOjnLGIl84=
X-Google-Smtp-Source: AGHT+IEnenlQglpBFPuTVhAE2UF+RvdKlK62R7A+284FmEJlr+9aUcdltH2gxIA3nFW1K2ngfPhcBw==
X-Received: by 2002:a05:6402:190f:b0:523:220e:a6ca with SMTP id e15-20020a056402190f00b00523220ea6camr122415edz.3.1696361594395;
        Tue, 03 Oct 2023 12:33:14 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id v18-20020aa7dbd2000000b00535204ffdb4sm1295199edt.72.2023.10.03.12.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 12:33:14 -0700 (PDT)
Date:   Tue, 3 Oct 2023 21:33:12 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] staging: rtl8192e: Remove equation in function
 rtllib_xmit_inter()
Message-ID: <970cd327eaecab8565e7486bbf62e1440a3b44b7.1696360403.git.philipp.g.hortmann@gmail.com>
References: <cover.1696360403.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696360403.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove equation with raw_tx in function rtllib_xmit_inter() as it is
always true.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 476 +++++++++++++--------------
 1 file changed, 229 insertions(+), 247 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 53ad5e3fb174..8d8ce22c5f09 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -576,289 +576,271 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 		goto success;
 	}
 
-	if (likely(ieee->raw_tx == 0)) {
-		if (unlikely(skb->len < SNAP_SIZE + sizeof(u16))) {
-			netdev_warn(ieee->dev, "skb too small (%d).\n",
-				    skb->len);
-			goto success;
-		}
-		/* Save source and destination addresses */
-		ether_addr_copy(dest, skb->data);
-		ether_addr_copy(src, skb->data + ETH_ALEN);
-
-		memset(skb->cb, 0, sizeof(skb->cb));
-		ether_type = ntohs(((struct ethhdr *)skb->data)->h_proto);
-
-		if (ieee->iw_mode == IW_MODE_MONITOR) {
-			txb = rtllib_alloc_txb(1, skb->len, GFP_ATOMIC);
-			if (unlikely(!txb)) {
-				netdev_warn(ieee->dev,
-					    "Could not allocate TXB\n");
-				goto failed;
-			}
+	if (unlikely(skb->len < SNAP_SIZE + sizeof(u16))) {
+		netdev_warn(ieee->dev, "skb too small (%d).\n",
+			    skb->len);
+		goto success;
+	}
+	/* Save source and destination addresses */
+	ether_addr_copy(dest, skb->data);
+	ether_addr_copy(src, skb->data + ETH_ALEN);
 
-			txb->encrypted = 0;
-			txb->payload_size = cpu_to_le16(skb->len);
-			skb_put_data(txb->fragments[0], skb->data, skb->len);
+	memset(skb->cb, 0, sizeof(skb->cb));
+	ether_type = ntohs(((struct ethhdr *)skb->data)->h_proto);
 
-			goto success;
+	if (ieee->iw_mode == IW_MODE_MONITOR) {
+		txb = rtllib_alloc_txb(1, skb->len, GFP_ATOMIC);
+		if (unlikely(!txb)) {
+			netdev_warn(ieee->dev,
+				    "Could not allocate TXB\n");
+			goto failed;
 		}
 
-		if (skb->len > 282) {
-			if (ether_type == ETH_P_IP) {
-				const struct iphdr *ip = (struct iphdr *)
-					((u8 *)skb->data + 14);
-				if (ip->protocol == IPPROTO_UDP) {
-					struct udphdr *udp;
-
-					udp = (struct udphdr *)((u8 *)ip +
-					      (ip->ihl << 2));
-					if (((((u8 *)udp)[1] == 68) &&
-					     (((u8 *)udp)[3] == 67)) ||
-					   ((((u8 *)udp)[1] == 67) &&
-					   (((u8 *)udp)[3] == 68))) {
-						bdhcp = true;
-						ieee->LPSDelayCnt = 200;
-					}
+		txb->encrypted = 0;
+		txb->payload_size = cpu_to_le16(skb->len);
+		skb_put_data(txb->fragments[0], skb->data, skb->len);
+
+		goto success;
+	}
+
+	if (skb->len > 282) {
+		if (ether_type == ETH_P_IP) {
+			const struct iphdr *ip = (struct iphdr *)
+				((u8 *)skb->data + 14);
+			if (ip->protocol == IPPROTO_UDP) {
+				struct udphdr *udp;
+
+				udp = (struct udphdr *)((u8 *)ip +
+				      (ip->ihl << 2));
+				if (((((u8 *)udp)[1] == 68) &&
+				     (((u8 *)udp)[3] == 67)) ||
+				   ((((u8 *)udp)[1] == 67) &&
+				   (((u8 *)udp)[3] == 68))) {
+					bdhcp = true;
+					ieee->LPSDelayCnt = 200;
 				}
-			} else if (ether_type == ETH_P_ARP) {
-				netdev_info(ieee->dev,
-					    "=================>DHCP Protocol start tx ARP pkt!!\n");
-				bdhcp = true;
-				ieee->LPSDelayCnt =
-					 ieee->current_network.tim.tim_count;
 			}
+		} else if (ether_type == ETH_P_ARP) {
+			netdev_info(ieee->dev,
+				    "=================>DHCP Protocol start tx ARP pkt!!\n");
+			bdhcp = true;
+			ieee->LPSDelayCnt =
+				 ieee->current_network.tim.tim_count;
 		}
+	}
 
-		skb->priority = rtllib_classify(skb, IsAmsdu);
-		crypt = ieee->crypt_info.crypt[ieee->crypt_info.tx_keyidx];
-		encrypt = !(ether_type == ETH_P_PAE && ieee->ieee802_1x) && crypt && crypt->ops;
-		if (!encrypt && ieee->ieee802_1x &&
-		    ieee->drop_unencrypted && ether_type != ETH_P_PAE) {
-			stats->tx_dropped++;
-			goto success;
-		}
-		if (crypt && !encrypt && ether_type == ETH_P_PAE) {
-			struct eapol *eap = (struct eapol *)(skb->data +
-				sizeof(struct ethhdr) - SNAP_SIZE -
-				sizeof(u16));
-			netdev_dbg(ieee->dev,
-				   "TX: IEEE 802.11 EAPOL frame: %s\n",
-				   eap_get_type(eap->type));
-		}
+	skb->priority = rtllib_classify(skb, IsAmsdu);
+	crypt = ieee->crypt_info.crypt[ieee->crypt_info.tx_keyidx];
+	encrypt = !(ether_type == ETH_P_PAE && ieee->ieee802_1x) && crypt && crypt->ops;
+	if (!encrypt && ieee->ieee802_1x &&
+	    ieee->drop_unencrypted && ether_type != ETH_P_PAE) {
+		stats->tx_dropped++;
+		goto success;
+	}
+	if (crypt && !encrypt && ether_type == ETH_P_PAE) {
+		struct eapol *eap = (struct eapol *)(skb->data +
+			sizeof(struct ethhdr) - SNAP_SIZE -
+			sizeof(u16));
+		netdev_dbg(ieee->dev,
+			   "TX: IEEE 802.11 EAPOL frame: %s\n",
+			   eap_get_type(eap->type));
+	}
 
-		/* Advance the SKB to the start of the payload */
-		skb_pull(skb, sizeof(struct ethhdr));
+	/* Advance the SKB to the start of the payload */
+	skb_pull(skb, sizeof(struct ethhdr));
 
-		/* Determine total amount of storage required for TXB packets */
-		bytes = skb->len + SNAP_SIZE + sizeof(u16);
+	/* Determine total amount of storage required for TXB packets */
+	bytes = skb->len + SNAP_SIZE + sizeof(u16);
 
-		if (encrypt)
-			fc = RTLLIB_FTYPE_DATA | IEEE80211_FCTL_PROTECTED;
-		else
-			fc = RTLLIB_FTYPE_DATA;
+	if (encrypt)
+		fc = RTLLIB_FTYPE_DATA | IEEE80211_FCTL_PROTECTED;
+	else
+		fc = RTLLIB_FTYPE_DATA;
 
-		if (qos_activated)
-			fc |= IEEE80211_STYPE_QOS_DATA;
-		else
-			fc |= IEEE80211_STYPE_DATA;
+	if (qos_activated)
+		fc |= IEEE80211_STYPE_QOS_DATA;
+	else
+		fc |= IEEE80211_STYPE_DATA;
 
-		if (ieee->iw_mode == IW_MODE_INFRA) {
-			fc |= IEEE80211_FCTL_TODS;
-			/* To DS: Addr1 = BSSID, Addr2 = SA,
-			 * Addr3 = DA
-			 */
-			ether_addr_copy(header.addr1,
+	if (ieee->iw_mode == IW_MODE_INFRA) {
+		fc |= IEEE80211_FCTL_TODS;
+		/* To DS: Addr1 = BSSID, Addr2 = SA,
+		 * Addr3 = DA
+		 */
+		ether_addr_copy(header.addr1,
+				ieee->current_network.bssid);
+		ether_addr_copy(header.addr2, src);
+		if (IsAmsdu)
+			ether_addr_copy(header.addr3,
 					ieee->current_network.bssid);
-			ether_addr_copy(header.addr2, src);
-			if (IsAmsdu)
-				ether_addr_copy(header.addr3,
-						ieee->current_network.bssid);
-			else
-				ether_addr_copy(header.addr3, dest);
-		}
+		else
+			ether_addr_copy(header.addr3, dest);
+	}
 
-		bIsMulticast = is_multicast_ether_addr(header.addr1);
+	bIsMulticast = is_multicast_ether_addr(header.addr1);
 
-		header.frame_control = cpu_to_le16(fc);
+	header.frame_control = cpu_to_le16(fc);
 
-		/* Determine fragmentation size based on destination (multicast
-		 * and broadcast are not fragmented)
-		 */
-		if (bIsMulticast) {
-			frag_size = MAX_FRAG_THRESHOLD;
-			qos_ctl |= QOS_CTL_NOTCONTAIN_ACK;
-		} else {
-			frag_size = ieee->fts;
-			qos_ctl = 0;
+	/* Determine fragmentation size based on destination (multicast
+	 * and broadcast are not fragmented)
+	 */
+	if (bIsMulticast) {
+		frag_size = MAX_FRAG_THRESHOLD;
+		qos_ctl |= QOS_CTL_NOTCONTAIN_ACK;
+	} else {
+		frag_size = ieee->fts;
+		qos_ctl = 0;
+	}
+
+	if (qos_activated) {
+		hdr_len = RTLLIB_3ADDR_LEN + 2;
+
+		/* in case we are a client verify acm is not set for this ac */
+		while (unlikely(ieee->wmm_acm & (0x01 << skb->priority))) {
+			netdev_info(ieee->dev, "skb->priority = %x\n",
+				    skb->priority);
+			if (wme_downgrade_ac(skb))
+				break;
+			netdev_info(ieee->dev, "converted skb->priority = %x\n",
+				    skb->priority);
 		}
 
-		if (qos_activated) {
-			hdr_len = RTLLIB_3ADDR_LEN + 2;
-
-			/* in case we are a client verify acm is not set for this ac */
-			while (unlikely(ieee->wmm_acm & (0x01 << skb->priority))) {
-				netdev_info(ieee->dev, "skb->priority = %x\n",
-					    skb->priority);
-				if (wme_downgrade_ac(skb))
-					break;
-				netdev_info(ieee->dev, "converted skb->priority = %x\n",
-					    skb->priority);
-			}
+		qos_ctl |= skb->priority;
+		header.qos_ctrl = cpu_to_le16(qos_ctl & RTLLIB_QOS_TID);
 
-			qos_ctl |= skb->priority;
-			header.qos_ctrl = cpu_to_le16(qos_ctl & RTLLIB_QOS_TID);
+	} else {
+		hdr_len = RTLLIB_3ADDR_LEN;
+	}
+	/* Determine amount of payload per fragment.  Regardless of if
+	 * this stack is providing the full 802.11 header, one will
+	 * eventually be affixed to this fragment -- so we must account
+	 * for it when determining the amount of payload space.
+	 */
+	bytes_per_frag = frag_size - hdr_len;
+	if (ieee->config &
+	   (CFG_RTLLIB_COMPUTE_FCS | CFG_RTLLIB_RESERVE_FCS))
+		bytes_per_frag -= RTLLIB_FCS_LEN;
 
+	/* Each fragment may need to have room for encrypting
+	 * pre/postfix
+	 */
+	if (encrypt) {
+		bytes_per_frag -= crypt->ops->extra_mpdu_prefix_len +
+			crypt->ops->extra_mpdu_postfix_len +
+			crypt->ops->extra_msdu_prefix_len +
+			crypt->ops->extra_msdu_postfix_len;
+	}
+	/* Number of fragments is the total bytes_per_frag /
+	 * payload_per_fragment
+	 */
+	nr_frags = bytes / bytes_per_frag;
+	bytes_last_frag = bytes % bytes_per_frag;
+	if (bytes_last_frag)
+		nr_frags++;
+	else
+		bytes_last_frag = bytes_per_frag;
+
+	/* When we allocate the TXB we allocate enough space for the
+	 * reserve and full fragment bytes (bytes_per_frag doesn't
+	 * include prefix, postfix, header, FCS, etc.)
+	 */
+	txb = rtllib_alloc_txb(nr_frags, frag_size +
+			       ieee->tx_headroom, GFP_ATOMIC);
+	if (unlikely(!txb)) {
+		netdev_warn(ieee->dev, "Could not allocate TXB\n");
+		goto failed;
+	}
+	txb->encrypted = encrypt;
+	txb->payload_size = cpu_to_le16(bytes);
+
+	if (qos_activated)
+		txb->queue_index = UP2AC(skb->priority);
+	else
+		txb->queue_index = WME_AC_BE;
+
+	for (i = 0; i < nr_frags; i++) {
+		skb_frag = txb->fragments[i];
+		tcb_desc = (struct cb_desc *)(skb_frag->cb +
+			    MAX_DEV_ADDR_SIZE);
+		if (qos_activated) {
+			skb_frag->priority = skb->priority;
+			tcb_desc->queue_index =  UP2AC(skb->priority);
 		} else {
-			hdr_len = RTLLIB_3ADDR_LEN;
+			skb_frag->priority = WME_AC_BE;
+			tcb_desc->queue_index = WME_AC_BE;
 		}
-		/* Determine amount of payload per fragment.  Regardless of if
-		 * this stack is providing the full 802.11 header, one will
-		 * eventually be affixed to this fragment -- so we must account
-		 * for it when determining the amount of payload space.
-		 */
-		bytes_per_frag = frag_size - hdr_len;
-		if (ieee->config &
-		   (CFG_RTLLIB_COMPUTE_FCS | CFG_RTLLIB_RESERVE_FCS))
-			bytes_per_frag -= RTLLIB_FCS_LEN;
+		skb_reserve(skb_frag, ieee->tx_headroom);
 
-		/* Each fragment may need to have room for encrypting
-		 * pre/postfix
-		 */
 		if (encrypt) {
-			bytes_per_frag -= crypt->ops->extra_mpdu_prefix_len +
-				crypt->ops->extra_mpdu_postfix_len +
-				crypt->ops->extra_msdu_prefix_len +
-				crypt->ops->extra_msdu_postfix_len;
+			if (ieee->hwsec_active)
+				tcb_desc->bHwSec = 1;
+			else
+				tcb_desc->bHwSec = 0;
+			skb_reserve(skb_frag,
+				    crypt->ops->extra_mpdu_prefix_len +
+				    crypt->ops->extra_msdu_prefix_len);
+		} else {
+			tcb_desc->bHwSec = 0;
 		}
-		/* Number of fragments is the total bytes_per_frag /
-		 * payload_per_fragment
-		 */
-		nr_frags = bytes / bytes_per_frag;
-		bytes_last_frag = bytes % bytes_per_frag;
-		if (bytes_last_frag)
-			nr_frags++;
-		else
-			bytes_last_frag = bytes_per_frag;
+		frag_hdr = skb_put_data(skb_frag, &header, hdr_len);
 
-		/* When we allocate the TXB we allocate enough space for the
-		 * reserve and full fragment bytes (bytes_per_frag doesn't
-		 * include prefix, postfix, header, FCS, etc.)
+		/* If this is not the last fragment, then add the
+		 * MOREFRAGS bit to the frame control
 		 */
-		txb = rtllib_alloc_txb(nr_frags, frag_size +
-				       ieee->tx_headroom, GFP_ATOMIC);
-		if (unlikely(!txb)) {
-			netdev_warn(ieee->dev, "Could not allocate TXB\n");
-			goto failed;
-		}
-		txb->encrypted = encrypt;
-		txb->payload_size = cpu_to_le16(bytes);
-
-		if (qos_activated)
-			txb->queue_index = UP2AC(skb->priority);
-		else
-			txb->queue_index = WME_AC_BE;
-
-		for (i = 0; i < nr_frags; i++) {
-			skb_frag = txb->fragments[i];
-			tcb_desc = (struct cb_desc *)(skb_frag->cb +
-				    MAX_DEV_ADDR_SIZE);
-			if (qos_activated) {
-				skb_frag->priority = skb->priority;
-				tcb_desc->queue_index =  UP2AC(skb->priority);
-			} else {
-				skb_frag->priority = WME_AC_BE;
-				tcb_desc->queue_index = WME_AC_BE;
-			}
-			skb_reserve(skb_frag, ieee->tx_headroom);
-
-			if (encrypt) {
-				if (ieee->hwsec_active)
-					tcb_desc->bHwSec = 1;
-				else
-					tcb_desc->bHwSec = 0;
-				skb_reserve(skb_frag,
-					    crypt->ops->extra_mpdu_prefix_len +
-					    crypt->ops->extra_msdu_prefix_len);
-			} else {
-				tcb_desc->bHwSec = 0;
-			}
-			frag_hdr = skb_put_data(skb_frag, &header, hdr_len);
-
-			/* If this is not the last fragment, then add the
-			 * MOREFRAGS bit to the frame control
-			 */
-			if (i != nr_frags - 1) {
-				frag_hdr->frame_control = cpu_to_le16(fc |
-								  IEEE80211_FCTL_MOREFRAGS);
-				bytes = bytes_per_frag;
-
-			} else {
-				/* The last fragment has the remaining length */
-				bytes = bytes_last_frag;
-			}
-			if ((qos_activated) && (!bIsMulticast)) {
-				frag_hdr->seq_ctrl =
-					 cpu_to_le16(rtllib_query_seqnum(ieee, skb_frag,
-									 header.addr1));
-				frag_hdr->seq_ctrl =
-					 cpu_to_le16(le16_to_cpu(frag_hdr->seq_ctrl) << 4 | i);
-			} else {
-				frag_hdr->seq_ctrl =
-					 cpu_to_le16(ieee->seq_ctrl[0] << 4 | i);
-			}
-			/* Put a SNAP header on the first fragment */
-			if (i == 0) {
-				rtllib_put_snap(skb_put(skb_frag,
-							SNAP_SIZE +
-							sizeof(u16)), ether_type);
-				bytes -= SNAP_SIZE + sizeof(u16);
-			}
+		if (i != nr_frags - 1) {
+			frag_hdr->frame_control = cpu_to_le16(fc |
+							  IEEE80211_FCTL_MOREFRAGS);
+			bytes = bytes_per_frag;
 
-			skb_put_data(skb_frag, skb->data, bytes);
-
-			/* Advance the SKB... */
-			skb_pull(skb, bytes);
-
-			/* Encryption routine will move the header forward in
-			 * order to insert the IV between the header and the
-			 * payload
-			 */
-			if (encrypt)
-				rtllib_encrypt_fragment(ieee, skb_frag,
-							hdr_len);
-			if (ieee->config &
-			   (CFG_RTLLIB_COMPUTE_FCS | CFG_RTLLIB_RESERVE_FCS))
-				skb_put(skb_frag, 4);
+		} else {
+			/* The last fragment has the remaining length */
+			bytes = bytes_last_frag;
 		}
-
 		if ((qos_activated) && (!bIsMulticast)) {
-			if (ieee->seq_ctrl[UP2AC(skb->priority) + 1] == 0xFFF)
-				ieee->seq_ctrl[UP2AC(skb->priority) + 1] = 0;
-			else
-				ieee->seq_ctrl[UP2AC(skb->priority) + 1]++;
+			frag_hdr->seq_ctrl =
+				 cpu_to_le16(rtllib_query_seqnum(ieee, skb_frag,
+								 header.addr1));
+			frag_hdr->seq_ctrl =
+				 cpu_to_le16(le16_to_cpu(frag_hdr->seq_ctrl) << 4 | i);
 		} else {
-			if (ieee->seq_ctrl[0] == 0xFFF)
-				ieee->seq_ctrl[0] = 0;
-			else
-				ieee->seq_ctrl[0]++;
+			frag_hdr->seq_ctrl =
+				 cpu_to_le16(ieee->seq_ctrl[0] << 4 | i);
 		}
-	} else {
-		if (unlikely(skb->len < sizeof(struct ieee80211_hdr_3addr))) {
-			netdev_warn(ieee->dev, "skb too small (%d).\n",
-				    skb->len);
-			goto success;
+		/* Put a SNAP header on the first fragment */
+		if (i == 0) {
+			rtllib_put_snap(skb_put(skb_frag,
+						SNAP_SIZE +
+						sizeof(u16)), ether_type);
+			bytes -= SNAP_SIZE + sizeof(u16);
 		}
 
-		txb = rtllib_alloc_txb(1, skb->len, GFP_ATOMIC);
-		if (!txb) {
-			netdev_warn(ieee->dev, "Could not allocate TXB\n");
-			goto failed;
-		}
+		skb_put_data(skb_frag, skb->data, bytes);
 
-		txb->encrypted = 0;
-		txb->payload_size = cpu_to_le16(skb->len);
-		skb_put_data(txb->fragments[0], skb->data, skb->len);
+		/* Advance the SKB... */
+		skb_pull(skb, bytes);
+
+		/* Encryption routine will move the header forward in
+		 * order to insert the IV between the header and the
+		 * payload
+		 */
+		if (encrypt)
+			rtllib_encrypt_fragment(ieee, skb_frag,
+						hdr_len);
+		if (ieee->config &
+		   (CFG_RTLLIB_COMPUTE_FCS | CFG_RTLLIB_RESERVE_FCS))
+			skb_put(skb_frag, 4);
+	}
+
+	if ((qos_activated) && (!bIsMulticast)) {
+		if (ieee->seq_ctrl[UP2AC(skb->priority) + 1] == 0xFFF)
+			ieee->seq_ctrl[UP2AC(skb->priority) + 1] = 0;
+		else
+			ieee->seq_ctrl[UP2AC(skb->priority) + 1]++;
+	} else {
+		if (ieee->seq_ctrl[0] == 0xFFF)
+			ieee->seq_ctrl[0] = 0;
+		else
+			ieee->seq_ctrl[0]++;
 	}
 
  success:
-- 
2.42.0

