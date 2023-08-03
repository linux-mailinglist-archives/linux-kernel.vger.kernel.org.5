Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C9B76E953
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbjHCNFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbjHCNEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:04:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29603A92;
        Thu,  3 Aug 2023 06:03:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC9E761DA3;
        Thu,  3 Aug 2023 13:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7946DC433C7;
        Thu,  3 Aug 2023 13:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691067838;
        bh=yIpruNAPGx2u8XrrkSoakxAMdQCdVLZmZFH1vNVCkhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YiLg1+aS9I1gIqyOXW0MUSC/GY6ApirQZayok2CVkxL7CGN57UENY9tnNUTLPK8wM
         QElLN78+3+DtR9s8dzWrWkJtQUGSv1XId9FNteQFMYvIy/X1snSfU7XOxki1PJx66T
         95os9ISsqUQTOUxLReecQgNC84/FIzuZBu8rdX5GJITb92FimHF7xULYpJvPhHBdlg
         /TgvTSIz5An0VQuABEQ9VAmBzi9eb2nhIJruT8jkL22c0JPkSyQDmoabnAJ6I+jcTy
         1LCx4cGSL7xPz1XJdKijgXpIQXz9NpIQnsBQOD4WnUuB7CQt6b0kIxZ4VUnrxkgrxK
         Z8gcxcpV5X7nA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Tissoires <bentiss@kernel.org>,
        Sasha Levin <sashal@kernel.org>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 2/2] HID: logitech-hidpp: Add wired USB id for Logitech G502 Lightspeed
Date:   Thu,  3 Aug 2023 09:03:53 -0400
Message-Id: <20230803130354.641771-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230803130354.641771-1-sashal@kernel.org>
References: <20230803130354.641771-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.251
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
index b8558292801ec..d661e44232586 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3864,6 +3864,8 @@ static const struct hid_device_id hidpp_devices[] = {
 
 	{ /* Logitech G403 Wireless Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC082) },
+	{ /* Logitech G502 Lightspeed Wireless Gaming Mouse over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC08D) },
 	{ /* Logitech G703 Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC087) },
 	{ /* Logitech G703 Hero Gaming Mouse over USB */
-- 
2.40.1

