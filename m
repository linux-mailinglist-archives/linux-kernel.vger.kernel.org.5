Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF9A75E718
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjGXBYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjGXBXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:23:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83C7E7E;
        Sun, 23 Jul 2023 18:22:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5426060F16;
        Mon, 24 Jul 2023 01:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344DEC433CC;
        Mon, 24 Jul 2023 01:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161765;
        bh=pipj35J1cxmcWg+1B6OqVjY2vDHh5dIsPs1xkoLxH/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJ1x7SOol9p1HDGD4mmHM7zYy+veeGF213zqmwdUDSY4zX7Z3xLH4facmz5iV0IN3
         6c9Z2XeoquxOR8T4AhFr5OKhPudrgdPcrsL7OJeqaim9ncNtKyPuYeRNXp/VDzvzT3
         OtcpKfnPIkmv8cE7V5chJB4wF6Uylm4pdNBgmaQtx2kVNv406Tf3FQFRc7u6kez/OK
         GdUHQylWt/eOehK7sHHIx19mANaa690FJEP0bUnJ/SkNlEYzkZ/nkBtR/scRQ16CKr
         0eFXInv+KIA8dbUZ/9hlPYgFhVOYANBLErs1Gl7itNhHSdB9tHSWWQTcrO9Lzj4z2B
         Sr54arJObxplQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     stuarthayhurst <stuart.a.hayhurst@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 24/41] HID: logitech-hidpp: Add USB and Bluetooth IDs for the Logitech G915 TKL Keyboard
Date:   Sun, 23 Jul 2023 21:20:57 -0400
Message-Id: <20230724012118.2316073-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724012118.2316073-1-sashal@kernel.org>
References: <20230724012118.2316073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
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

From: stuarthayhurst <stuart.a.hayhurst@gmail.com>

[ Upstream commit 48aea8b445c422a372cf15915101035a47105421 ]

Adds the USB and Bluetooth IDs for the Logitech G915 TKL keyboard, for device detection
For this device, this provides battery reporting on top of hid-generic

Reviewed-by: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-logitech-hidpp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index b2cd7527de195..28761272afe52 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4403,6 +4403,8 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC086) },
 	{ /* Logitech G903 Hero Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC091) },
+	{ /* Logitech G915 TKL Keyboard over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC343) },
 	{ /* Logitech G920 Wheel over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
 		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
@@ -4418,6 +4420,8 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ /* MX5500 keyboard over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb30b),
 	  .driver_data = HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS },
+	{ /* Logitech G915 TKL keyboard over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb35f) },
 	{ /* M-RCQ142 V470 Cordless Laser Mouse over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb008) },
 	{ /* MX Master mouse over Bluetooth */
-- 
2.39.2

