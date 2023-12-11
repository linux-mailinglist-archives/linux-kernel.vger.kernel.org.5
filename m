Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8019380CBDB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343975AbjLKNzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343952AbjLKNyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:54:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F6018D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:53:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCCDC433C8;
        Mon, 11 Dec 2023 13:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302815;
        bh=lwKy+lY0I4t6JD+inUnKQb7hfXk6DjIgfY2rpHK+CfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tz9t/wNrTu7I6xSJc+IPSW2dbqWTJ539ityECh2Is/fYUbvLkhA+VPzKgbrqd9Ar7
         0M1bvl3tDGD+jnsQcnR7sm1Kvu17zGsMj0omHw2BUL1Gb0Q9R5k1AO4AFe2plzZSRS
         YCHZEgx7Ut/z1PkPG1Oy+GyT6IUEN+fMUdo00PfMsa+/Ml/R3Rs7wC0YUDuDnTFsEN
         XJm6yxr+Qm3DJuMZ14l3nNxoQ8r1Xj3bwGw23btdxUC6IceluhIPfkgFk4y6i6k0k2
         WWid7fhDPTkS/h2p66kMIDLtVnrwXcApxBquOI8r5OnjZrzOb4NkYqNSif77G7Es9P
         buFM8kaJ8GZkQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kelly Kane <kelly@hawknetworks.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, gregkh@linuxfoundation.org,
        hayeswang@realtek.com, dianders@chromium.org,
        grundler@chromium.org, bjorn@mork.no, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 37/47] r8152: add vendor/device ID pair for ASUS USB-C2500
Date:   Mon, 11 Dec 2023 08:50:38 -0500
Message-ID: <20231211135147.380223-37-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kelly Kane <kelly@hawknetworks.com>

[ Upstream commit 7037d95a047cd89b1f680eed253c6ab586bef1ed ]

The ASUS USB-C2500 is an RTL8156 based 2.5G Ethernet controller.

Add the vendor and product ID values to the driver. This makes Ethernet
work with the adapter.

Signed-off-by: Kelly Kane <kelly@hawknetworks.com>
Link: https://lore.kernel.org/r/20231203011712.6314-1-kelly@hawknetworks.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c   | 1 +
 include/linux/usb/r8152.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index be18d72cefcce..7a669f2c77fc0 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10001,6 +10001,7 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_NVIDIA,  0x09ff) },
 	{ USB_DEVICE(VENDOR_ID_TPLINK,  0x0601) },
 	{ USB_DEVICE(VENDOR_ID_DLINK,   0xb301) },
+	{ USB_DEVICE(VENDOR_ID_ASUS,    0x1976) },
 	{}
 };
 
diff --git a/include/linux/usb/r8152.h b/include/linux/usb/r8152.h
index 287e9d83fb8bc..33a4c146dc19c 100644
--- a/include/linux/usb/r8152.h
+++ b/include/linux/usb/r8152.h
@@ -30,6 +30,7 @@
 #define VENDOR_ID_NVIDIA		0x0955
 #define VENDOR_ID_TPLINK		0x2357
 #define VENDOR_ID_DLINK			0x2001
+#define VENDOR_ID_ASUS			0x0b05
 
 #if IS_REACHABLE(CONFIG_USB_RTL8152)
 extern u8 rtl8152_get_version(struct usb_interface *intf);
-- 
2.42.0

