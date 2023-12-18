Return-Path: <linux-kernel+bounces-4482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B82817E10
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C44284150
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE97679941;
	Mon, 18 Dec 2023 23:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="LVFQ8+dA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46296760AD;
	Mon, 18 Dec 2023 23:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1702942019; x=1703546819; i=wahrenst@gmx.net;
	bh=ATxU7wMSMtD0bHBBcfJuMS+/O0nKa9cCnqr0XhKW9G8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=LVFQ8+dAUv7lLg/+EOswhwj8vzo4qE1wZbJlOuC4It63T26l0C1CLLXpCmvKIRZF
	 TeLI8jHiUnmk5CoTzVLZ/2RpmKuSI0R50Yyx1NSHCrBYOM+P5LAbO2FXhK/0Lo82n
	 i7Uz/wtxvQY7yLNwBmxqjiUU9jr5qUmb/UQZCW+akPrN1NEJ8OMMiDbgb3Vib6Q78
	 f8qEGri1+M8Ir2Xjzuwh887tfM464dStsegTy9VIcErS9OH2Oak68Sukj6Dhyt2XV
	 /I+rmU7c+clumiVmiBFsN8U6uk9t/nDyh1VTnCGn2DhZ4W8Z8vYTuaoOW7ZOImyGg
	 3hwLxStLMMs3DkHNGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdvmO-1qhgQ913lW-00b4In; Tue, 19
 Dec 2023 00:26:59 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 06/12 net-next] qca_spi: Add QCASPI prefix to ring defines
Date: Tue, 19 Dec 2023 00:26:33 +0100
Message-Id: <20231218232639.33327-7-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218232639.33327-1-wahrenst@gmx.net>
References: <20231218232639.33327-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7KE+AW/+kLGLekatA9aLHaa5Jt/x/8as9hdPn+js9I22RFc4HKQ
 BTPKjtWmGkeOjRIZ0TcrJrEZJBr6k+ONVmWrc9nrt4IMwWDC61eprK50Upu8hNvVqHRKMl8
 S1A34GAlJIZLWncZ+9sJp4MzAEQmXPeTkwYeedDjKBv9s36B1OkboI+Sl9jMxKRN+UD/0S/
 6gJDENQ6rL+BVJcv0Bnuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2dskVjD6AZU=;/TF7XOTvB5vhsrfFEtjR7hdgZH5
 QLn8tNbYPhRpjjE8PSZFhVpGCyLm5iwQxztzD2iTBJOgVOS8RxejsaEotlrbflDCLtMfhr5Bo
 qf/Btug9ZWaM6b5QDyi76ToLmp/07ZCTZYkI2J3cSsA/loWtSgfAalKBZUkg7soGWtiQNqJVR
 nE2fHaIUguzClSD6DlyJCjGVFaE8e7F19Bh3aQ01rk4eakIdQhRethYK/lEuc8EEXAmiLlBke
 d98E/cvXP8/DyPF7pnmWk0r0aY/10G/shXreukWAPlfzaXzKjCCw5cdccBB+6JiUjIiyVEEBH
 8YEPhyInF/4h/OolJ6Abgro+dYkMYqNik0UFnBq174pf6UkiDMvoIHYbznRBxYgf4fBs9kPgH
 2DzTEckQqben1ZYC78a2zhnTSSHMiBW1pnrw7s48RFKoBQkzPzR8IZGs7cqqjVKK+BWKmonZF
 OpnZaFZn1NrkIC4PliR3oTK94aBduFJKzOnC40hAfYtY81l1JZ8ehBFc2PsW953iD39cGnw0C
 uh4aE/4P98t8BX2fPLQTdIEssGT+NelA/uHJp2dRhQPY9pjMwy3ZkmhAgnTUK5a25qO1dZqCt
 XO9FvcrnP2e88DK+B/BFN65cGD2yqlj/qLyJV3PK3l+WyfUiPs+wU0w3iQaxtInu+tEB89XKn
 aJjMk8IjcCnW2TnVfnPAExviUTpuS7wNNpybuf9C2lVUgliUFxWDqwmWvuNWrqZa++jl77laT
 boWL4dTyexSF04TnlHEj49INY6NDW15lysw0H927C+x36ifAmqvHmfmb6t8s4dQxbqLV3+Pjc
 hP9u/eGx9XeQzVkSyLC8IO2jKvqcSm/LLQGefyqqA4fyqcCQY4EjwRDdgdWSbpUeRzMEzQ9zF
 RTVoiphXgLpY06cNK7C1e76gQS4kNN57i6VBrQmz8NeFM/MBmDHaT0LOEHsrALh9rZFjel9Ty
 0iOi/DpPKndn04KsZLlbmZGQoKI=

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
index 1822f2ad8f0d..857883d0b5ed 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_debug.c
+++ b/drivers/net/ethernet/qualcomm/qca_debug.c
@@ -255,7 +255,7 @@ qcaspi_get_ringparam(struct net_device *dev, struct et=
htool_ringparam *ring,
 	struct qcaspi *qca =3D netdev_priv(dev);

 	ring->rx_max_pending =3D QCASPI_RX_MAX_FRAMES;
-	ring->tx_max_pending =3D TX_RING_MAX_LEN;
+	ring->tx_max_pending =3D QCASPI_TX_RING_MAX_LEN;
 	ring->rx_pending =3D QCASPI_RX_MAX_FRAMES;
 	ring->tx_pending =3D qca->txr.count;
 }
@@ -275,8 +275,8 @@ qcaspi_set_ringparam(struct net_device *dev, struct et=
htool_ringparam *ring,
 	if (qca->spi_thread)
 		kthread_park(qca->spi_thread);

-	qca->txr.count =3D max_t(u32, ring->tx_pending, TX_RING_MIN_LEN);
-	qca->txr.count =3D min_t(u16, qca->txr.count, TX_RING_MAX_LEN);
+	qca->txr.count =3D max_t(u32, ring->tx_pending, QCASPI_TX_RING_MIN_LEN);
+	qca->txr.count =3D min_t(u16, qca->txr.count, QCASPI_TX_RING_MAX_LEN);

 	if (qca->spi_thread)
 		kthread_unpark(qca->spi_thread);
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index 919a400412cb..2ca25844d91c 100644
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
@@ -889,7 +889,7 @@ qcaspi_netdev_setup(struct net_device *dev)
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


