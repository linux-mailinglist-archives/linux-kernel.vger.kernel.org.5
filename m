Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24B1813434
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573761AbjLNPKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573673AbjLNPKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:10:13 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64908125;
        Thu, 14 Dec 2023 07:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1702566603; x=1703171403; i=wahrenst@gmx.net;
        bh=uRDT1P17rUMa94Pjny3C2uqVoUmM42vy9zD9t/wTjGk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=Te9nOUmS5DV+lamdchh7tlTxpnIZ9N8RWzsLNeWdv29/2iYR+AJoF2oi6iF5FGV+
         P7cAsQCofAZA9H5IBFsmwiWCbG5VIH2P6i5R6zp9OiHTdlh+8I8TAA2+M6/bgonD+
         nXfAONcBfn5hLzNBq5eDArRNx4a63s+FAOf/41/dSAN81EGwStCq9xz8cNGC1qJYJ
         RvVJBXfH0Fbc9YuuDy/ZrW90fNEVJzNMZcYtlj1fUzRrFU7wKiPu88GLpSiNisFi6
         o9zHZW05Dax/xiZshLF4gKYR8VZro9EPAL6y+o1IP16dNAq1O3NMCsbGz7OMhuD88
         a0DoLGXBLotJ2ccSJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV63q-1qo3Gn0xEM-00S9ry; Thu, 14
 Dec 2023 16:10:03 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 06/12 net-next] qca_spi: Add QCASPI prefix to ring defines
Date:   Thu, 14 Dec 2023 16:09:38 +0100
Message-Id: <20231214150944.55808-7-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214150944.55808-1-wahrenst@gmx.net>
References: <20231214150944.55808-1-wahrenst@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gt2WAqBmQtUV9umX0eQ4VehFvnkIU8kxOa/49+geh7iqOIfK9wu
 4jBKJtteiFHuAlxWBrwPGc7XWnNwv5tWVTUaU2WMl+nlgGrGTGIDHIGYCHFi+k0YMi2CD2I
 avAP8hdiQL4P9XFRnZ7o/n5ZleMIZYhq2L/bkSjkY1GYsdHl1q5DLkbY0ZjJS+YR5QrY+rW
 PKvEepFpymKGoEnIag5Ow==
UI-OutboundReport: notjunk:1;M01:P0:EpkKNXJVzz0=;RTI8JM35GT/KQRK4nQ5xbnkBLZg
 yuzqPqL4JDFLkIQwLPb26jAuWAkhwowlffzQBhfot5HF/9B9B3MhMMMy1TKRaOHGUVtDwI3f8
 9HbXWtGlIBrxq1M36atL55+IfOfChO7UBnekGK4K6SeDhckqdFyq3kyCpCcd2yn960DQmn5sr
 KwU1b/eC7X885wKLm1GMAu4zj+TvRvxsPdioQeiXHSMDtdkNhwD9fXr6cFLeAfgVkfLvHL683
 yOMcMi0XvGTK2mytPZ9wgbHSKmwhWONYtdLOQb41mm/KU74szwXSRGOB+HH+yrNmxw5okqCR1
 QbA+psPbJjy6gLlzLVuNy8CEu9lYPJbSsEjIL5/t80U1qbcAvPBBpQVWjoNsD8TP/yV0uoNVS
 gi+zna9r9lU5KIU4w8AIbOu5/n5ua5whuqeAf2gFwsryviWKZYtbsICC+ed+4SUImMSZzZyxC
 SVw3agNhyI+jQhUzs5uySejr6n5QSa6wzBTZFiHWDDTAMIcobEKQUm2jgzVoGkc3GmS6HslH0
 Z+VLNCQpEHF/JCjmBZyy5RTf0qe1XmBesx5l2SLjG6yQwtTpvq3meO0xAVfUm4bPlHfFFsQHy
 npB3Lhb5FXHqcN2cNxT97Wgi2qcP0CKLMZpcpxkJhIOLn1YZw3TNWspa/PD1ciFzYM8AqaP5A
 LYFuTqt945v6YRkbFTdOeaYT3PtxYNSc2blOiUpy4VHXxzzPK5QG1yGyeDCgXCPdqPOI7ER0X
 txeB4Trx2fUjm/ku9G1xBQjnPwrBo0C4lbRTurcBPqplwdFjIkAuwi6uIR7KfwW5u4Ffr90Bg
 QJzFVEQiCOyhEWdEEYGZrYgVdx1I0k5GTQ/kiQ4cikGyjZCXKIA6Vmi+9fPq2CcQUDAYtP71V
 0TB8PvVVrFfu1xXsRUp1uYKguKYo1NZyVRqiE3C9jLosD0zE4bcfKpuNpIZlEITQxKwba2/Ma
 0uEXlg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All defines in qca_spi.h except of the two ring limit defines have
a QCASPI prefix. Since the name is quite generic add the QCASPI prefix
to avoid possible name conflicts.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_debug.c | 6 +++---
 drivers/net/ethernet/qualcomm/qca_spi.c   | 4 ++--
 drivers/net/ethernet/qualcomm/qca_spi.h   | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/ether=
net/qualcomm/qca_debug.c
index 6f2fa2a42770..12d68fdaad8e 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_debug.c
+++ b/drivers/net/ethernet/qualcomm/qca_debug.c
@@ -253,7 +253,7 @@ qcaspi_get_ringparam(struct net_device *dev, struct et=
htool_ringparam *ring,
 	struct qcaspi *qca =3D netdev_priv(dev);

 	ring->rx_max_pending =3D 4;
-	ring->tx_max_pending =3D TX_RING_MAX_LEN;
+	ring->tx_max_pending =3D QCASPI_TX_RING_MAX_LEN;
 	ring->rx_pending =3D 4;
 	ring->tx_pending =3D qca->txr.count;
 }
@@ -274,8 +274,8 @@ qcaspi_set_ringparam(struct net_device *dev, struct et=
htool_ringparam *ring,
 	if (netif_running(dev))
 		ops->ndo_stop(dev);

-	qca->txr.count =3D max_t(u32, ring->tx_pending, TX_RING_MIN_LEN);
-	qca->txr.count =3D min_t(u16, qca->txr.count, TX_RING_MAX_LEN);
+	qca->txr.count =3D max_t(u32, ring->tx_pending, QCASPI_TX_RING_MIN_LEN);
+	qca->txr.count =3D min_t(u16, qca->txr.count, QCASPI_TX_RING_MAX_LEN);

 	if (netif_running(dev))
 		ops->ndo_open(dev);
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index f0c99ac8d73d..31ed7a527092 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -476,7 +476,7 @@ qcaspi_flush_tx_ring(struct qcaspi *qca)
 	 * has been replaced by netif_tx_lock_bh() and so on.
 	 */
 	netif_tx_lock_bh(qca->net_dev);
-	for (i =3D 0; i < TX_RING_MAX_LEN; i++) {
+	for (i =3D 0; i < QCASPI_TX_RING_MAX_LEN; i++) {
 		if (qca->txr.skb[i]) {
 			dev_kfree_skb(qca->txr.skb[i]);
 			qca->txr.skb[i] =3D NULL;
@@ -871,7 +871,7 @@ qcaspi_netdev_setup(struct net_device *dev)
 	memset(qca, 0, sizeof(struct qcaspi));

 	memset(&qca->txr, 0, sizeof(qca->txr));
-	qca->txr.count =3D TX_RING_MAX_LEN;
+	qca->txr.count =3D QCASPI_TX_RING_MAX_LEN;
 }

 static const struct of_device_id qca_spi_of_match[] =3D {
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.h b/drivers/net/etherne=
t/qualcomm/qca_spi.h
index 3067356106f0..dcecb072b8eb 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.h
+++ b/drivers/net/ethernet/qualcomm/qca_spi.h
@@ -39,8 +39,8 @@

 #define QCASPI_GOOD_SIGNATURE 0xAA55

-#define TX_RING_MAX_LEN 10
-#define TX_RING_MIN_LEN 2
+#define QCASPI_TX_RING_MAX_LEN 10
+#define QCASPI_TX_RING_MIN_LEN 2

 /* sync related constants */
 #define QCASPI_SYNC_UNKNOWN 0
@@ -54,7 +54,7 @@
 #define QCASPI_EVENT_CPUON  1

 struct tx_ring {
-	struct sk_buff *skb[TX_RING_MAX_LEN];
+	struct sk_buff *skb[QCASPI_TX_RING_MAX_LEN];
 	u16 head;
 	u16 tail;
 	u16 size;
=2D-
2.34.1

