Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1097CA031
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjJPHNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjJPHNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:13:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC83AD;
        Mon, 16 Oct 2023 00:13:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14A24C433C7;
        Mon, 16 Oct 2023 07:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697440414;
        bh=xNlXAuE+bCPUAWJr1nwMfcT6VUi0d0nMbIyJW/0hZW8=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=PcjYNHTjD/zqBiMcLKzPl6308JDp1LgAibKKMuFEsec11g5fAofXcmS5E3JbMI0mi
         0zg+X8vMWKbomehNTxU7efFC8Ym3+Yvc531ud2TSlUs0uoG6+kBNKQ1RnEmnq+S0ix
         XA6AgGhwyjkT/+wdFOp5xkCgTjZ/Niyye89F7uhCvoCDfZmYZ2kl95zVB4qXUj5Pxk
         i6TaPDnRL2zkQcHFfkgm1DtdaSzBOx21E+OQAg9lBU++5ZikE2PmyXlBx3R39a82yj
         uQGi7K9hx/tHN5cJfYeDAA6CjeMxzlyx68cGXHLHUdehH/gtGU4bG0l2JqoDb40071
         85I0VkblLnygg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id EA340CDB465;
        Mon, 16 Oct 2023 07:13:33 +0000 (UTC)
From:   Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date:   Mon, 16 Oct 2023 09:13:08 +0200
Subject: [PATCH] Bluetooth: hci_bcm4377: Mark bcm4378/bcm4387 as
 BROKEN_LE_CODED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231016-bt-bcm4377-quirk-broken-le-coded-v1-1-52ea69d3c979@jannau.net>
X-B4-Tracking: v=1; b=H4sIAIPiLGUC/x3NywrCMBBG4Vcps3YgaWovvoq4aJJfHaqJTlSE0
 nc3uPw256xUoIJCh2YlxUeK5FRhdw2F65wuYInV1JrWWWN79i/24d65YeDnW3Rhr3lB4hs45Ij
 I+2nqxxEudLOhmnkozvL9L46nbfsB4PTdgHIAAAA=
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2372; i=j@jannau.net;
 h=from:subject:message-id; bh=tGCXqB0xwKnmC4wp0Z2D26g3zMlTAh/Veq7m/j3H66A=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhlSdR3N8Ll/eFrPoypqAqzppXl93h7Rt0NBQeXLi9fkna
 0KuBzFEdJSyMIhxMMiKKbIkab/sYFhdoxhT+yAMZg4rE8gQBi5OAZiIsDUjQ98EJ1aXF7zHfXwE
 Hc/YvDj59n/7livy05TF44sudn3dVMzIsITZmXeuLEvwp6v/0hZNCFrCdki8cunOZ5O0uEWPph6
 /yAsA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/default with auth_id=62
X-Original-From: Janne Grunau <j@jannau.net>
Reply-To: <j@jannau.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Janne Grunau <j@jannau.net>

bcm4378 and bcm4387 claim to support LE Coded PHY but fail to pair
(reliably) with BLE devices if it is enabled.
On bcm4378 pairing usually succeeds after 2-3 tries. On bcm4387
pairing appears to be completely broken.

Cc: stable@vger.kernel.org # 6.4.y+
Link: https://discussion.fedoraproject.org/t/mx-master-3-bluetooth-mouse-doesnt-connect/87072/33
Link: https://github.com/AsahiLinux/linux/issues/177
Fixes: 288c90224eec ("Bluetooth: Enable all supported LE PHY by default")
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/bluetooth/hci_bcm4377.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 19ad0e788646..a61757835695 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -512,6 +512,7 @@ struct bcm4377_hw {
 	unsigned long disable_aspm : 1;
 	unsigned long broken_ext_scan : 1;
 	unsigned long broken_mws_transport_config : 1;
+	unsigned long broken_le_coded : 1;
 
 	int (*send_calibration)(struct bcm4377_data *bcm4377);
 	int (*send_ptb)(struct bcm4377_data *bcm4377,
@@ -2372,6 +2373,8 @@ static int bcm4377_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		set_bit(HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG, &hdev->quirks);
 	if (bcm4377->hw->broken_ext_scan)
 		set_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &hdev->quirks);
+	if (bcm4377->hw->broken_le_coded)
+		set_bit(HCI_QUIRK_BROKEN_LE_CODED, &hdev->quirks);
 
 	pci_set_drvdata(pdev, bcm4377);
 	hci_set_drvdata(hdev, bcm4377);
@@ -2461,6 +2464,7 @@ static const struct bcm4377_hw bcm4377_hw_variants[] = {
 		.bar0_core2_window2 = 0x18107000,
 		.has_bar0_core2_window2 = true,
 		.broken_mws_transport_config = true,
+		.broken_le_coded = true,
 		.send_calibration = bcm4378_send_calibration,
 		.send_ptb = bcm4378_send_ptb,
 	},
@@ -2474,6 +2478,7 @@ static const struct bcm4377_hw bcm4377_hw_variants[] = {
 		.has_bar0_core2_window2 = true,
 		.clear_pciecfg_subsystem_ctrl_bit19 = true,
 		.broken_mws_transport_config = true,
+		.broken_le_coded = true,
 		.send_calibration = bcm4387_send_calibration,
 		.send_ptb = bcm4378_send_ptb,
 	},

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20231016-bt-bcm4377-quirk-broken-le-coded-599688e3c4a0

Best regards,
-- 
Janne Grunau <j@jannau.net>

