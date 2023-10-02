Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929B67B55CA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbjJBOfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237802AbjJBOe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:34:58 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28F3CE;
        Mon,  2 Oct 2023 07:34:53 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-502e7d66c1eso25369485e87.1;
        Mon, 02 Oct 2023 07:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696257292; x=1696862092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAyPb+4PbZteFfrBpHoiNKrXXTZgul7BcTjyIP5qzwI=;
        b=luDbfG5yMYpkQN1wFwchk1CwKfzbGPXoLwEglY8ORUQlthziKeigmO5pyCP7VIRqCH
         bTlpuvZF9YAKyiuzGCOKyh59KO+Dg5ZpVo2NRFuCxxcHlG13YLeidNHxb6c59N3oImnt
         PQCNYjWVU7QCUh+NzJN+mFlvnu9nRpwzWVkoBRRrKpOFWWTVKSff1Whj5KRkqbCCmoKB
         dmrEAFwmmvJJy72rDR+/nT0HaWQ4fopK78FFK/umpqvIoLwHgqjvZ9WNRN0FAjIMtK4j
         6FbqfvJ3PpyRpN8kRXpSE2DZ2hRNRaLZyW+SjX8efYOz9UXIF6nsSW0OYf+7WrTZ6KB3
         fbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696257292; x=1696862092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAyPb+4PbZteFfrBpHoiNKrXXTZgul7BcTjyIP5qzwI=;
        b=b+F9ga5MMq3LHQAOj9b8OaCui7KvjQ3l2l+qyvKPhuhiW7d6vpa99X7/iVRh/48P93
         UwtclylJZkK5vSmhqvM/+5thNJZjHBKhD1NERoN+VcMvsnjMAP0aAHqx3zzBr3udt8aQ
         EalBruVIIK+FeFqLxr3rKSBdGaI02dH7JgdcULlC3K16CdiLh2K0EA0G27PAmHhXSFvl
         gEpHWkpWwLF8eX6gaFMXDLFAu38Ut01SF9u6rQrzEN/fn4gGFm5tPeCdTaIo2Oble7NM
         zWaaLozR7FOUnSjrnQJ2wxOzbXmP5VMulpkx4yVA87NHjGz8/bx/qZMxmoRzqUesu/gJ
         BWhA==
X-Gm-Message-State: AOJu0YxD+xg2IHj0p/eFzmWjKGyk16cWoBsLn1UlPhm5TKSPNDRByz5+
        5GAWmLpXfG0I2/QmwGh8IiE=
X-Google-Smtp-Source: AGHT+IGxULiuLg0LWMMpLKOqJNlyjxloCBBnv3llI6Auo4dJ81Zv+xcLJk73RSdrNSJZhfjTQ4zMMQ==
X-Received: by 2002:a05:6512:3b11:b0:505:7371:ec83 with SMTP id f17-20020a0565123b1100b005057371ec83mr7515383lfv.48.1696257291432;
        Mon, 02 Oct 2023 07:34:51 -0700 (PDT)
Received: from PC10319.67 ([82.97.198.254])
        by smtp.googlemail.com with ESMTPSA id e8-20020ac25468000000b004faa2de9877sm4751642lfn.286.2023.10.02.07.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 07:34:51 -0700 (PDT)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     minyard@acm.org, joel@jms.id.au, andrew@aj.id.au,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        aladyshev22@gmail.com, jk@codeconstruct.com.au,
        matt@codeconstruct.com.au, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org
Subject: [PATCH v2 3/3] mctp: Add MCTP-over-KCS transport binding
Date:   Mon,  2 Oct 2023 17:34:41 +0300
Message-Id: <20231002143441.545-4-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231002143441.545-1-aladyshev22@gmail.com>
References: <20231002143441.545-1-aladyshev22@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds a MCTP KCS transport binding, as defined by the DMTF
specificiation DSP0254 - "MCTP KCS Transport Binding".
A MCTP protocol network device is created for each KCS channel found in
the system.
The interrupt code for the KCS state machine is based on the current
IPMI KCS driver.

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 drivers/net/mctp/Kconfig    |   8 +
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-kcs.c | 594 ++++++++++++++++++++++++++++++++++++
 3 files changed, 603 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-kcs.c

diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index dc71657d9184..a37f7ba947c0 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -33,6 +33,14 @@ config MCTP_TRANSPORT_I2C
 	  from DMTF specification DSP0237. A MCTP protocol network device is
 	  created for each I2C bus that has been assigned a mctp-i2c device.
 
+config MCTP_TRANSPORT_KCS
+	tristate "MCTP KCS transport"
+	depends on IPMI_KCS_BMC
+	help
+	  Provides a driver to access MCTP devices over KCS transport, from
+	  DMTF specification DSP0254. A MCTP protocol network device is
+	  created for each KCS channel found in the system.
+
 endmenu
 
 endif
diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
index 1ca3e6028f77..885339a40f22 100644
--- a/drivers/net/mctp/Makefile
+++ b/drivers/net/mctp/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
 obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
+obj-$(CONFIG_MCTP_TRANSPORT_KCS) += mctp-kcs.o
diff --git a/drivers/net/mctp/mctp-kcs.c b/drivers/net/mctp/mctp-kcs.c
new file mode 100644
index 000000000000..530fd2e5dd3b
--- /dev/null
+++ b/drivers/net/mctp/mctp-kcs.c
@@ -0,0 +1,594 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Management Component Transport Protocol (MCTP) KCS transport binding.
+ * This driver is an implementation of the DMTF specificiation
+ * "DSP0254 - Management Component Transport Protocol (MCTP) KCS Transport
+ * Binding", available at:
+ *
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0254_1.0.0.pdf
+ *
+ * This driver provides DSP0254-type MCTP-over-KCS transport using a Linux
+ * KCS client subsystem.
+ *
+ * Copyright (c) 2023 Konstantin Aladyshev <aladyshev22@gmail.com>
+ */
+
+#include <linux/i2c.h>
+#include <linux/if_arp.h>
+#include <linux/ipmi_kcs.h>
+#include <linux/kcs_bmc_client.h>
+#include <linux/mctp.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/netdevice.h>
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+#include <net/pkt_sched.h>
+
+#define MCTP_KCS_MTU 64
+#define KCS_MSG_BUFSIZ 1000
+
+struct mctp_kcs {
+	struct list_head entry;
+
+	/* protects rx & tx state machines */
+	spinlock_t lock;
+
+	struct kcs_bmc_client client;
+	struct net_device *netdev;
+
+	enum kcs_ipmi_phases phase;
+	enum kcs_ipmi_errors error;
+
+	int data_in_idx;
+	u8 *data_in;
+
+	int data_out_idx;
+	int data_out_len;
+	u8 *data_out;
+
+	struct work_struct rx_work;
+};
+
+struct mctp_kcs_header {
+	u8 netfn_lun;
+	u8 defining_body;
+	u8 len;
+} __packed;
+
+struct mctp_kcs_trailer {
+	u8 pec;
+} __packed;
+
+#define MCTP_KCS_NETFN_LUN 0xb0
+#define DEFINING_BODY_DMTF_PRE_OS_WORKING_GROUP 0x01
+
+static int mctp_kcs_validate_data(struct mctp_kcs *mkcs,
+				  struct mctp_kcs_header *hdr, int len)
+{
+	struct net_device *ndev = mkcs->netdev;
+	struct mctp_kcs_trailer *tlr;
+	u8 pec;
+
+	if (hdr->netfn_lun != MCTP_KCS_NETFN_LUN) {
+		dev_err(mkcs->client.dev->dev,
+			"%s: KCS binding header error! netfn_lun = 0x%02x, but should be 0x%02x",
+			__func__, hdr->netfn_lun, MCTP_KCS_NETFN_LUN);
+		ndev->stats.rx_dropped++;
+		return -EINVAL;
+	}
+	if (hdr->defining_body != DEFINING_BODY_DMTF_PRE_OS_WORKING_GROUP) {
+		dev_err(mkcs->client.dev->dev,
+			"%s: KCS binding header error! defining_body = 0x%02x, but should be 0x%02x",
+			__func__, hdr->defining_body,
+			DEFINING_BODY_DMTF_PRE_OS_WORKING_GROUP);
+		ndev->stats.rx_dropped++;
+		return -EINVAL;
+	}
+	if (hdr->len != (u8)(len - sizeof(struct mctp_kcs_header) -
+			     sizeof(struct mctp_kcs_trailer))) {
+		dev_err(mkcs->client.dev->dev,
+			"%s: KCS binding header error! len = 0x%02x, but should be 0x%02x",
+			__func__, hdr->len,
+			(u8)(len - sizeof(struct mctp_kcs_header) -
+			     sizeof(struct mctp_kcs_trailer)));
+		ndev->stats.rx_length_errors++;
+		return -EINVAL;
+	}
+
+	pec = i2c_smbus_pec(0, (u8 *)(hdr + 1), hdr->len);
+	tlr = (struct mctp_kcs_trailer *)((u8 *)(hdr + 1) + hdr->len);
+	if (pec != tlr->pec) {
+		dev_err(mkcs->client.dev->dev,
+			"%s: PEC error! Packet value=0x%02x, calculated value=0x%02x",
+			__func__, tlr->pec, pec);
+		ndev->stats.rx_crc_errors++;
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static void mctp_kcs_rx_work(struct work_struct *work)
+{
+	struct mctp_kcs *mkcs = container_of(work, struct mctp_kcs, rx_work);
+	struct mctp_skb_cb *cb;
+	struct sk_buff *skb;
+	unsigned long flags;
+	int rc;
+	int i;
+	struct mctp_kcs_header *kcs_header;
+	int data_len;
+	int data_in_idx;
+
+	spin_lock_irqsave(&mkcs->lock, flags);
+	for (i = 0; i < (mkcs->data_in_idx); i++)
+		dev_dbg(mkcs->client.dev->dev, "%s: data_in[%d]=0x%02x",
+			__func__, i, mkcs->data_in[i]);
+
+	data_len = mkcs->data_in_idx - sizeof(struct mctp_kcs_header) -
+		   sizeof(struct mctp_kcs_trailer);
+	if (mkcs->phase != KCS_PHASE_WRITE_DONE) {
+		dev_err(mkcs->client.dev->dev,
+			"%s: error! Wrong KCS stage at the end of data read (phase=%d)",
+			__func__, mkcs->phase);
+		mkcs->netdev->stats.rx_dropped++;
+		goto unlock_irq;
+	}
+
+	mkcs->phase = KCS_PHASE_WAIT_READ;
+	data_in_idx = mkcs->data_in_idx;
+	mkcs->data_in_idx = 0;
+
+	skb = netdev_alloc_skb(mkcs->netdev, data_len);
+	if (!skb) {
+		mkcs->netdev->stats.rx_dropped++;
+		goto unlock_irq;
+	}
+
+	kcs_header = (struct mctp_kcs_header *)mkcs->data_in;
+	rc = mctp_kcs_validate_data(mkcs, kcs_header, data_in_idx);
+	if (rc) {
+		dev_err(mkcs->client.dev->dev,
+			"%s: error! Binding validation failed", __func__);
+		dev_kfree_skb(skb);
+		goto unlock_irq;
+	}
+
+	skb->protocol = htons(ETH_P_MCTP);
+	skb_put_data(skb, mkcs->data_in + sizeof(struct mctp_kcs_header),
+		     data_len);
+	skb_reset_network_header(skb);
+
+	cb = __mctp_cb(skb);
+	cb->halen = 0;
+
+	netif_rx(skb);
+	mkcs->netdev->stats.rx_packets++;
+	mkcs->netdev->stats.rx_bytes += data_len;
+
+unlock_irq:
+	spin_unlock_irqrestore(&mkcs->lock, flags);
+}
+
+static netdev_tx_t mctp_kcs_start_xmit(struct sk_buff *skb,
+				       struct net_device *ndev)
+{
+	struct mctp_kcs_header *kcs_header;
+	unsigned long flags;
+	int i;
+	struct mctp_kcs *mkcs = netdev_priv(ndev);
+
+	if (skb->len > MCTP_KCS_MTU) {
+		dev_err(&ndev->dev, "%s: error! skb len is bigger than MTU",
+			__func__);
+		ndev->stats.tx_dropped++;
+		goto out;
+	}
+
+	spin_lock_irqsave(&mkcs->lock, flags);
+	if (mkcs->phase != KCS_PHASE_WAIT_READ) {
+		dev_err(&ndev->dev,
+			"%s: error! Wrong KCS stage at the start of data write (phase=%d)",
+			__func__, mkcs->phase);
+		dev_kfree_skb(skb);
+		spin_unlock_irqrestore(&mkcs->lock, flags);
+		return NETDEV_TX_BUSY;
+	}
+
+	netif_stop_queue(ndev);
+	mkcs->phase = KCS_PHASE_READ;
+	kcs_header = (struct mctp_kcs_header *)mkcs->data_out;
+	kcs_header->netfn_lun = MCTP_KCS_NETFN_LUN;
+	kcs_header->defining_body = DEFINING_BODY_DMTF_PRE_OS_WORKING_GROUP;
+	kcs_header->len = skb->len;
+	skb_copy_bits(skb, 0, kcs_header + 1, skb->len);
+	mkcs->data_out[sizeof(struct mctp_kcs_header) + skb->len] =
+		i2c_smbus_pec(0, (u8 *)(kcs_header + 1), skb->len);
+	mkcs->data_out_idx = 1;
+	mkcs->data_out_len = skb->len + sizeof(struct mctp_kcs_header) +
+			     sizeof(struct mctp_kcs_trailer);
+
+	for (i = 0; i < (mkcs->data_out_len); i++)
+		dev_dbg(&ndev->dev, "%s: data_out[%d]=0x%02x", __func__, i,
+			mkcs->data_out[i]);
+
+	// Write first data byte to initialize transmission
+	kcs_bmc_write_data(mkcs->client.dev, mkcs->data_out[0]);
+
+	spin_unlock_irqrestore(&mkcs->lock, flags);
+out:
+	dev_kfree_skb(skb);
+	return NETDEV_TX_OK;
+}
+
+static inline void set_state(struct mctp_kcs *mkcs, u8 state)
+{
+	dev_dbg(mkcs->client.dev->dev, "%s: state=0x%02x", __func__, state);
+	kcs_bmc_update_status(mkcs->client.dev, KCS_STATUS_STATE_MASK,
+			      KCS_STATUS_STATE(state));
+}
+
+static int mctp_kcs_ndo_open(struct net_device *ndev)
+{
+	struct mctp_kcs *mkcs;
+
+	mkcs = netdev_priv(ndev);
+	dev_info(&ndev->dev, "Open MCTP over KCS channel %d",
+		 mkcs->client.dev->channel);
+	return kcs_bmc_enable_device(mkcs->client.dev, &mkcs->client);
+}
+
+static int mctp_kcs_ndo_stop(struct net_device *ndev)
+{
+	struct mctp_kcs *mkcs;
+
+	mkcs = netdev_priv(ndev);
+	dev_info(&ndev->dev, "Stop MCTP over KCS channel %d",
+		 mkcs->client.dev->channel);
+	mkcs->data_in_idx = 0;
+	mkcs->data_out_idx = 0;
+	mkcs->data_out_len = 0;
+	mkcs->phase = KCS_PHASE_IDLE;
+	set_state(mkcs, IDLE_STATE);
+	kcs_bmc_disable_device(mkcs->client.dev, &mkcs->client);
+	return 0;
+}
+
+static const struct net_device_ops mctp_kcs_netdev_ops = {
+	.ndo_start_xmit = mctp_kcs_start_xmit,
+	.ndo_open = mctp_kcs_ndo_open,
+	.ndo_stop = mctp_kcs_ndo_stop,
+};
+
+static void mctp_kcs_setup(struct net_device *ndev)
+{
+	ndev->type = ARPHRD_MCTP;
+
+	/* we limit at the fixed MTU, which is also the MCTP-standard
+	 * baseline MTU, so is also our minimum
+	 */
+	ndev->mtu = MCTP_KCS_MTU;
+	ndev->max_mtu = MCTP_KCS_MTU;
+	ndev->min_mtu = MCTP_KCS_MTU;
+
+	ndev->hard_header_len = 0;
+	ndev->addr_len = 0;
+	ndev->tx_queue_len = DEFAULT_TX_QUEUE_LEN;
+	ndev->flags = IFF_NOARP;
+	ndev->netdev_ops = &mctp_kcs_netdev_ops;
+	ndev->needs_free_netdev = true;
+}
+
+static void kcs_bmc_ipmi_force_abort(struct mctp_kcs *mkcs)
+{
+	dev_err(mkcs->client.dev->dev,
+		"Error! Force abort on KCS communication");
+	set_state(mkcs, ERROR_STATE);
+	kcs_bmc_read_data(mkcs->client.dev);
+	kcs_bmc_write_data(mkcs->client.dev, KCS_ZERO_DATA);
+	mkcs->phase = KCS_PHASE_ERROR;
+	mkcs->data_in_idx = 0;
+}
+
+static void kcs_bmc_ipmi_handle_data(struct mctp_kcs *mkcs)
+{
+	u8 data;
+	struct kcs_bmc_device *kcs_bmc = mkcs->client.dev;
+
+	switch (mkcs->phase) {
+	case KCS_PHASE_WRITE_START:
+		dev_dbg(kcs_bmc->dev, "%s: KCS_PHASE_WRITE_START", __func__);
+		mkcs->phase = KCS_PHASE_WRITE_DATA;
+		fallthrough;
+
+	case KCS_PHASE_WRITE_DATA:
+		dev_dbg(kcs_bmc->dev, "%s: KCS_PHASE_WRITE_DATA", __func__);
+		if (mkcs->data_in_idx < KCS_MSG_BUFSIZ) {
+			set_state(mkcs, WRITE_STATE);
+			kcs_bmc_write_data(kcs_bmc, KCS_ZERO_DATA);
+			mkcs->data_in[mkcs->data_in_idx++] =
+				kcs_bmc_read_data(kcs_bmc);
+			dev_dbg(kcs_bmc->dev,
+				"%s: KCS_PHASE_WRITE_DATA: data_in[%d]=0x%02x",
+				__func__, mkcs->data_in_idx - 1,
+				mkcs->data_in[mkcs->data_in_idx - 1]);
+		} else {
+			kcs_bmc_ipmi_force_abort(mkcs);
+			mkcs->error = KCS_LENGTH_ERROR;
+		}
+		break;
+
+	case KCS_PHASE_WRITE_END_CMD:
+		dev_dbg(kcs_bmc->dev, "%s: KCS_PHASE_WRITE_END_CMD", __func__);
+		if (mkcs->data_in_idx < KCS_MSG_BUFSIZ) {
+			set_state(mkcs, READ_STATE);
+			mkcs->data_in[mkcs->data_in_idx++] =
+				kcs_bmc_read_data(kcs_bmc);
+			dev_dbg(kcs_bmc->dev,
+				"%s: KCS_PHASE_WRITE_END_CMD: data_in[%d]=0x%02x",
+				__func__, mkcs->data_in_idx - 1,
+				mkcs->data_in[mkcs->data_in_idx - 1]);
+			mkcs->phase = KCS_PHASE_WRITE_DONE;
+			schedule_work(&mkcs->rx_work);
+		} else {
+			kcs_bmc_ipmi_force_abort(mkcs);
+			mkcs->error = KCS_LENGTH_ERROR;
+		}
+		break;
+
+	case KCS_PHASE_READ:
+		dev_dbg(kcs_bmc->dev,
+			"%s: KCS_PHASE_READ, data_out_idx=%d, data_out_len=%d",
+			__func__, mkcs->data_out_idx, mkcs->data_out_len);
+		if (mkcs->data_out_idx == mkcs->data_out_len)
+			set_state(mkcs, IDLE_STATE);
+
+		data = kcs_bmc_read_data(kcs_bmc);
+		if (data != KCS_CMD_READ_BYTE) {
+			dev_dbg(kcs_bmc->dev,
+				"%s: error! data is not equal to KCS_CMD_READ_BYTE",
+				__func__);
+			set_state(mkcs, ERROR_STATE);
+			kcs_bmc_write_data(kcs_bmc, KCS_ZERO_DATA);
+			break;
+		}
+
+		if (mkcs->data_out_idx == mkcs->data_out_len) {
+			kcs_bmc_write_data(kcs_bmc, KCS_ZERO_DATA);
+			mkcs->netdev->stats.tx_bytes += mkcs->data_out_len;
+			mkcs->netdev->stats.tx_packets++;
+			mkcs->phase = KCS_PHASE_IDLE;
+			if (netif_queue_stopped(mkcs->netdev))
+				netif_start_queue(mkcs->netdev);
+			break;
+		}
+
+		dev_dbg(kcs_bmc->dev, "%s: KCS_PHASE_READ: data_out[%d]=0x%02x",
+			__func__, mkcs->data_out_idx,
+			mkcs->data_out[mkcs->data_out_idx]);
+		kcs_bmc_write_data(kcs_bmc,
+				   mkcs->data_out[mkcs->data_out_idx++]);
+		break;
+
+	case KCS_PHASE_ABORT_ERROR1:
+		dev_dbg(kcs_bmc->dev, "%s: KCS_PHASE_ABORT_ERROR1", __func__);
+		set_state(mkcs, READ_STATE);
+		kcs_bmc_read_data(kcs_bmc);
+		kcs_bmc_write_data(kcs_bmc, mkcs->error);
+		mkcs->phase = KCS_PHASE_ABORT_ERROR2;
+		break;
+
+	case KCS_PHASE_ABORT_ERROR2:
+		dev_dbg(kcs_bmc->dev, "%s: KCS_PHASE_ABORT_ERROR2", __func__);
+		set_state(mkcs, IDLE_STATE);
+		kcs_bmc_read_data(kcs_bmc);
+		kcs_bmc_write_data(kcs_bmc, KCS_ZERO_DATA);
+		mkcs->phase = KCS_PHASE_IDLE;
+		break;
+
+	default:
+		dev_dbg(kcs_bmc->dev, "%s: unknown KCS phase", __func__);
+		kcs_bmc_ipmi_force_abort(mkcs);
+		break;
+	}
+}
+
+static void kcs_bmc_ipmi_handle_cmd(struct mctp_kcs *mkcs)
+{
+	struct kcs_bmc_device *kcs_bmc = mkcs->client.dev;
+
+	set_state(mkcs, WRITE_STATE);
+	kcs_bmc_write_data(kcs_bmc, KCS_ZERO_DATA);
+
+	switch (kcs_bmc_read_data(kcs_bmc)) {
+	case KCS_CMD_WRITE_START:
+		dev_dbg(kcs_bmc->dev, "%s: KCS_CMD_WRITE_START", __func__);
+		mkcs->phase = KCS_PHASE_WRITE_START;
+		mkcs->error = KCS_NO_ERROR;
+		mkcs->data_in_idx = 0;
+		break;
+
+	case KCS_CMD_WRITE_END:
+		dev_dbg(kcs_bmc->dev, "%s: KCS_CMD_WRITE_END", __func__);
+		if (mkcs->phase != KCS_PHASE_WRITE_DATA) {
+			kcs_bmc_ipmi_force_abort(mkcs);
+			break;
+		}
+		mkcs->phase = KCS_PHASE_WRITE_END_CMD;
+		break;
+
+	case KCS_CMD_GET_STATUS_ABORT:
+		dev_dbg(kcs_bmc->dev, "%s: KCS_CMD_GET_STATUS_ABORT", __func__);
+		if (mkcs->error == KCS_NO_ERROR)
+			mkcs->error = KCS_ABORTED_BY_COMMAND;
+
+		mkcs->phase = KCS_PHASE_ABORT_ERROR1;
+		mkcs->data_in_idx = 0;
+		break;
+
+	default:
+		dev_dbg(kcs_bmc->dev, "%s: unknown KCS command", __func__);
+		kcs_bmc_ipmi_force_abort(mkcs);
+		mkcs->error = KCS_ILLEGAL_CONTROL_CODE;
+		break;
+	}
+}
+
+static inline struct mctp_kcs *client_to_mctp_kcs(struct kcs_bmc_client *client)
+{
+	return container_of(client, struct mctp_kcs, client);
+}
+
+static irqreturn_t kcs_bmc_mctp_event(struct kcs_bmc_client *client)
+{
+	struct mctp_kcs *mkcs;
+	u8 status;
+	int ret;
+
+	mkcs = client_to_mctp_kcs(client);
+	if (!mkcs) {
+		dev_err(client->dev->dev,
+			"%s: error! can't find mctp_kcs from KCS client",
+			__func__);
+		return IRQ_NONE;
+	}
+
+	spin_lock(&mkcs->lock);
+
+	status = kcs_bmc_read_status(client->dev);
+	if (status & KCS_STATUS_IBF) {
+		if (status & KCS_STATUS_CMD_DAT)
+			kcs_bmc_ipmi_handle_cmd(mkcs);
+		else
+			kcs_bmc_ipmi_handle_data(mkcs);
+
+		ret = IRQ_HANDLED;
+	} else {
+		ret = IRQ_NONE;
+	}
+
+	spin_unlock(&mkcs->lock);
+
+	return ret;
+}
+
+static const struct kcs_bmc_client_ops kcs_bmc_mctp_client_ops = {
+	.event = kcs_bmc_mctp_event,
+};
+
+static DEFINE_SPINLOCK(kcs_bmc_mctp_instances_lock);
+static LIST_HEAD(kcs_bmc_mctp_instances);
+
+static int kcs_bmc_mctp_add_device(struct kcs_bmc_device *kcs_bmc)
+{
+	struct mctp_kcs *mkcs;
+	struct net_device *ndev;
+	char name[32];
+	int rc;
+
+	snprintf(name, sizeof(name), "mctpkcs%d", kcs_bmc->channel);
+
+	ndev = alloc_netdev(sizeof(*mkcs), name, NET_NAME_ENUM, mctp_kcs_setup);
+	if (!ndev) {
+		dev_err_probe(kcs_bmc->dev,
+			      "alloc_netdev failed for KCS channel %d\n",
+			      kcs_bmc->channel);
+		return -ENOMEM;
+	}
+
+	mkcs = netdev_priv(ndev);
+	mkcs->netdev = ndev;
+	mkcs->client.dev = kcs_bmc;
+	mkcs->client.ops = &kcs_bmc_mctp_client_ops;
+	mkcs->data_in = devm_kmalloc(kcs_bmc->dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
+	if (!mkcs->data_in) {
+		dev_err_probe(
+			kcs_bmc->dev,
+			"failed to allocate data_in buffer for KCS channel %d\n",
+			kcs_bmc->channel);
+		rc = -ENOMEM;
+		goto free_netdev;
+	}
+	mkcs->data_out = devm_kmalloc(kcs_bmc->dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
+	if (!mkcs->data_out) {
+		dev_err_probe(
+			kcs_bmc->dev,
+			"failed to allocate data_out buffer for KCS channel %d\n",
+			kcs_bmc->channel);
+		rc = -ENOMEM;
+		goto free_netdev;
+	}
+
+	INIT_WORK(&mkcs->rx_work, mctp_kcs_rx_work);
+
+	rc = register_netdev(ndev);
+	if (rc)
+		goto free_netdev;
+
+	spin_lock_irq(&kcs_bmc_mctp_instances_lock);
+	list_add(&mkcs->entry, &kcs_bmc_mctp_instances);
+	spin_unlock_irq(&kcs_bmc_mctp_instances_lock);
+
+	dev_info(kcs_bmc->dev, "Add MCTP client for the KCS channel %d",
+		 kcs_bmc->channel);
+	return 0;
+
+free_netdev:
+	free_netdev(ndev);
+
+	return rc;
+}
+
+static int kcs_bmc_mctp_remove_device(struct kcs_bmc_device *kcs_bmc)
+{
+	struct mctp_kcs *mkcs = NULL, *pos;
+
+	dev_info(kcs_bmc->dev, "Remove MCTP client for the KCS channel %d",
+		 kcs_bmc->channel);
+	spin_lock_irq(&kcs_bmc_mctp_instances_lock);
+	list_for_each_entry(pos, &kcs_bmc_mctp_instances, entry) {
+		if (pos->client.dev == kcs_bmc) {
+			mkcs = pos;
+			list_del(&pos->entry);
+			break;
+		}
+	}
+	spin_unlock_irq(&kcs_bmc_mctp_instances_lock);
+
+	if (!mkcs)
+		return -ENODEV;
+
+	unregister_netdev(mkcs->netdev);
+	free_netdev(mkcs->netdev);
+	kcs_bmc_disable_device(kcs_bmc, &mkcs->client);
+	devm_kfree(kcs_bmc->dev, mkcs->data_out);
+	devm_kfree(kcs_bmc->dev, mkcs->data_in);
+	return 0;
+}
+
+static const struct kcs_bmc_driver_ops kcs_bmc_mctp_driver_ops = {
+	.add_device = kcs_bmc_mctp_add_device,
+	.remove_device = kcs_bmc_mctp_remove_device,
+};
+
+static struct kcs_bmc_driver kcs_bmc_mctp_driver = {
+	.ops = &kcs_bmc_mctp_driver_ops,
+};
+
+static int __init mctp_kcs_init(void)
+{
+	kcs_bmc_register_driver(&kcs_bmc_mctp_driver);
+	return 0;
+}
+
+static void __exit mctp_kcs_exit(void)
+{
+	kcs_bmc_unregister_driver(&kcs_bmc_mctp_driver);
+}
+
+module_init(mctp_kcs_init);
+module_exit(mctp_kcs_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Konstantin Aladyshev <aladyshev22@gmail.com>");
+MODULE_DESCRIPTION("MCTP KCS transport");
-- 
2.25.1

