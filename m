Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D7076E92D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbjHCNEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbjHCNDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:03:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541312130;
        Thu,  3 Aug 2023 06:03:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 858E661D96;
        Thu,  3 Aug 2023 13:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1656EC433CA;
        Thu,  3 Aug 2023 13:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691067811;
        bh=/KZ+NBYj5oRfUIy4ch/kbLxHnSNCemURov2WCN6qSuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pXd/MeKhTfGFktebqNzN+XfFV4NT5F5n2WPdcjXRPg8vy6BYsQIOaQFW1OBlyj3nX
         U2W2Nmzd4sxtqCvcrIO6I2BunKXxJtuzkQ/HEZUGrid04DT+Q67fDE7cpxKnLA6BJM
         u+sFYIHjrPUIY/awOWgF2qO6SWx7nqbFOPeAE3rG8+iaMruTQTLECXuqbVHDKI/8LK
         7OyEZdmQIiAInkAC156BIEufYtdk6icEpgOOV0+jKxKacj9geNypawGjE77kDQLJzn
         XjbndDGMHWYpEThnRzf8yG3c32Evkx1IyBl4ZYx2CmqbE4OyZY12LThV2vuZs9eh3g
         7MKpkKIypNvzg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Tissoires <bentiss@kernel.org>,
        Sasha Levin <sashal@kernel.org>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 6/7] HID: logitech-hidpp: Add wired USB id for Logitech G502 Lightspeed
Date:   Thu,  3 Aug 2023 09:03:19 -0400
Message-Id: <20230803130321.641516-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230803130321.641516-1-sashal@kernel.org>
References: <20230803130321.641516-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.7
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>

[ Upstream commit a343a7682acc56182d4b54777c358f5ec6d274e7 ]

Previously, support for the G502 had been attempted in commit
'27fc32fd9417 ("HID: logitech-hidpp: add USB PID for a few more supported
mice")'

This caused some issues and was reverted by
'addf3382c47c ("Revert "HID: logitech-hidpp: add USB PID for a few more
supported mice"")'.

Since then, a new version of this mouse has been released (Lightpseed
Wireless), and works correctly.

This device has support for battery reporting with the driver

Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
Reviewed-by: Bastien Nocera <hadess@hadess.net>
Link: https://lore.kernel.org/r/20230630113818.13005-1-stuart.a.hayhurst@gmail.com
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index f7e06d433a915..22d5ba88954fc 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4598,6 +4598,8 @@ static const struct hid_device_id hidpp_devices[] = {
 
 	{ /* Logitech G403 Wireless Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC082) },
+	{ /* Logitech G502 Lightspeed Wireless Gaming Mouse over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC08D) },
 	{ /* Logitech G703 Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC087) },
 	{ /* Logitech G703 Hero Gaming Mouse over USB */
-- 
2.40.1

