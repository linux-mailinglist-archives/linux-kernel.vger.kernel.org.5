Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EC87CE077
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345080AbjJRO4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbjJRO4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:56:02 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EE8EA;
        Wed, 18 Oct 2023 07:56:00 -0700 (PDT)
Received: from toolbox.int.toradex.com ([213.66.31.70]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MI55X-1qmkxj1GCN-00F8Gg;
 Wed, 18 Oct 2023 16:55:52 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sherry Sun <sherry.sun@nxp.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v1 2/2] Bluetooth: btnxpuart: Fix nxp_setup
Date:   Wed, 18 Oct 2023 16:55:40 +0200
Message-Id: <20231018145540.34014-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231018145540.34014-1-marcel@ziswiler.com>
References: <20231018145540.34014-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+MFEQ/J99joPxvIsCqTTlAHdQvjl7U1vV7zy6rVxiDyAsju9BZN
 6V6aDZOOfqFZpc6MQkuHmCLo+ZcIDwK7L8e2QTnivo5Q0I4KIWF9jND7wA7BcRR4Pu+qJyI
 AbwTyeSlk3A3/6pU/BC1ZCPk26tivUXMRIAvpXFTkmUpfritabMPvF26VeONfSKgCU4CrVp
 iJKiXKyfvEKuFMt9dZViw==
UI-OutboundReport: notjunk:1;M01:P0:M955cJquLio=;4/OtX+QdajlRNC6k1uaGtR0pnzq
 0HBvWwPIoXxcKB2NoKJ4DwWbHl7iU+gPwPSjs0L7aSSaV6XGPkqXBwUAbETRzYXoA+GPjJEd0
 S3wUNal/Nj8x9Bxr+mqqxXzJHwEG0KpB0hzMNg0JRiaOm4hsY/OMUqCbviRo2GBsnKwJvYOfG
 OERzvRjsSotfq5LQPqY3P3j8l0uSR1vP4NSwUvm9Lf7WMFdYqiTKyYDWeUWiUWGd3XSLmpKqA
 tc9H8IBFhED+IUzNBW2sadrOdOJjgzZEgQWFs8OidqFvpblld+HBB0iPyQaDhxpqYzRvu1/ek
 aZACIx/eSzXuH8qIH2UtVyuYT0R+m3uuXgrv9jb9v3rqQs81FF6sZnt+9NK1R2txsSgcga2rV
 UzJAtdOqkjY3s9vlAqpBXwhvmQ3gG1SZ0TQr2X/J4uXXa8OA8l90GKnLAKu/m/OhhLHG1HPLi
 u8gZW2KbIRCxP73FgBt8uS9ggFyc33qGrpl/8ZmBgBA8pGfF5eA8Qyys1VTdcVbesYzvpeZeO
 fTsXq7UJDDoRYcm5l8WMsoj7SgtOufglNt2TdtXCKsjjbPlqC29nqfYRSPdc2xqFdrxeCCpP8
 35jQpTaFh5hIXxIk/ivmQ3M+EEZa9cnv2KjcnjN+IuuHsJO7vJaL7PcWAs+qsWCpF31zBACQC
 lG7VHZADfjrfIv5ToecpnOe+x2gET8grN4QpXswa06JtGKZHkcAd554TYakJOfKzxf6nYrDGt
 RhmlRTScYYK5frp/hoszOREVnwepIBK4SbLx4z3My1eYvzIks/XaHsNx5zduVyWG2yyjjpLh2
 PxoIpd40vm3nlqcB8N7i/vpYX/GADMmxx7gCtMqwulJelhSjU1NnT2qGwdKjNkJbc+qaVw0DG
 i8NWHqFFcM+ZPHg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Unfortunately, nxp_setup() may inadvertently assume that the
firmware is already running while the module is not even powered yet.
Fix this by waiting up to 10 seconds for the CTS to go up as the combo
firmware might be loaded by the Wi-Fi driver over SDIO (mwifiex_sdio).

Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---
This is what may happen without this fix:
[  284.588177] Bluetooth: hci0: Opcode 0x0c03 failed: -110
[  286.636167] Bluetooth: hci0: Setting wake-up method failed (-110)
Unfortunately, even re-loading the btnxpuart kernel module would not
recover from this condition.

 drivers/bluetooth/btnxpuart.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 9cb7529eef09..4b83a0aa3459 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1021,6 +1021,16 @@ static int nxp_setup(struct hci_dev *hdev)
 		if (err < 0)
 			return err;
 	} else {
+		/* The combo firmware might be loaded by the Wi-Fi driver over SDIO (mwifiex_sdio).
+		 * We wait up to 10s for the CTS to go up. Afterwards, we know that the firmware is
+		 * really ready.
+		 */
+		err = serdev_device_wait_for_cts(nxpdev->serdev, true, 10000);
+		if (err) {
+			bt_dev_err(nxpdev->hdev, "Wait for CTS failed with %d", err);
+			return err;
+		}
+
 		bt_dev_dbg(hdev, "FW already running.");
 		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 	}
-- 
2.36.1

