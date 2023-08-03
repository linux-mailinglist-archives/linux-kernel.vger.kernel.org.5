Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C2776E93D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbjHCNEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235900AbjHCNED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:04:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6351712;
        Thu,  3 Aug 2023 06:03:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1356A61D69;
        Thu,  3 Aug 2023 13:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96ACAC43391;
        Thu,  3 Aug 2023 13:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691067833;
        bh=2BIlihJrsZR9kI2AMzIx24MVr8B3ngTWa/8RgxEL0d4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fCv8ae7tUuBG4Wne83NbfcND1ayQM9L4VlII3A58j9Nr4rCDg5B744bZPyk28gO/Z
         PhX7BZ0MeHYUOylnbLR8tlJPfp+RtgkSUHOG69vizouJkiIIB97kRfOdTtxCkmxGJ1
         9LlzKaqYCAnzZbeoBZUPDF3dR1VPhnaZO5/Iryi75cJiifHWdW1kZ/t9uxTEq3nrqy
         Ylgt8kZ/7FhvdYkG3G4dELtoLh3ND+Xwy1nN9QC89+pL/xFEJvrpLXqLtO10TQxEhU
         18bbc8O7hhQAf7bWoac/zAEJKmRWIivwj9pMqTpC6fD4qQ9Cez+XodXUhyFzuWPkZG
         4VHcMamzvbGkg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Tissoires <bentiss@kernel.org>,
        Sasha Levin <sashal@kernel.org>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/2] HID: logitech-hidpp: Add wired USB id for Logitech G502 Lightspeed
Date:   Thu,  3 Aug 2023 09:03:48 -0400
Message-Id: <20230803130349.641732-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230803130349.641732-1-sashal@kernel.org>
References: <20230803130349.641732-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.188
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
index 2e32a21bbcbfc..e1db47f5077fb 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4081,6 +4081,8 @@ static const struct hid_device_id hidpp_devices[] = {
 
 	{ /* Logitech G403 Wireless Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC082) },
+	{ /* Logitech G502 Lightspeed Wireless Gaming Mouse over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC08D) },
 	{ /* Logitech G703 Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC087) },
 	{ /* Logitech G703 Hero Gaming Mouse over USB */
-- 
2.40.1

