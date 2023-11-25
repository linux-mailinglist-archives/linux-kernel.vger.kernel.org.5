Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575B87F8C5B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 17:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjKYQXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 11:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjKYQW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 11:22:56 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425E79F;
        Sat, 25 Nov 2023 08:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1700929349; bh=PAlRc2ja3hh6DeaWm9zc1SFzcPjmPGHqZ2p19AErk3o=;
        h=From:Date:Subject:To:Cc;
        b=WXA2qcl9v7BwZVhxsSk1xhOGD5Ht/FoltLKgnMNZbuPQY6j34wQArAvx/hY3IxuiI
         dKm+XjZ4Snk9jWDdIonZsHOcsLk/R0X7nh0UO1GI/DHMWaNT+XVJy912QIQyiGaNpm
         0yYPaqNNd+Wyg7diUsY7CVNUyChrbxqwVilnImmk=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sat, 25 Nov 2023 17:22:15 +0100
Subject: [PATCH] Input: xpad - add Razer Wolverine V2 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-razer-wolverine-v2-v1-1-979fe9f9288e@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIADYfYmUC/x3MMQqAMAxA0atIZgNtpItXEYdqowaklRSqKN7d4
 viH9x/IrMIZ+uYB5SJZUqxh2wbmzceVUUJtIEOdteRQ/c2KZ9pLhZGxEAbjyE7UefYOKjyUF7n
 +6TC+7wcepOICZAAAAA==
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1124; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=PAlRc2ja3hh6DeaWm9zc1SFzcPjmPGHqZ2p19AErk3o=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlYh85IHrmrKDRYKR+d09mJfLAfIvc0J+BeffIi
 DinFHOWPwKJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZWIfOQAKCRBy2EO4nU3X
 Vs14D/9iC5JJyHV8M8HNrp2ivvOA7otQzZYCyfH/ZTtCwfBNUMzWIjMVqYOwSsjkPW/zYucXfaq
 uCVG+2tnCWBrvxGuGPtx6A34cKuapwm46ddT2wzrmiJ9wYoJFaU2wgassw54wWcs/qbR1KmHeOh
 jS+Ve1WkQF/2YO75cyW9zuDpWsvboiTA8NEQ66mHljmf3CTnqxn82P7Pbmnr0rJMOG6LhsiS26C
 3W8pDf7ELwXSk9WEDOqlxwCZi4Cdbbmvc0mbc7UJef1lFKB85zYj8ew72ishXxHsIhvBI9P8LSf
 SljEc4mmzUVsf+tNLOoYE94b5ZkAC6F9c3C+9TnNL1k1YrWbsLW04B7QRo+FwDGFX56jRw8ry9i
 0GEkSViAu5GqZL0tdOxaY5s+7mD5jp+PTC4U6RhQg3205GR9e9CnmiVYDAVENZ47avoKHXZovV2
 iDP0LBl2rCU8k+XHQZPLyAceWTP1Uiw/Ie5xbhisGMIUaHIAnbPJHe0kstUJayFLaeVydvH96Jj
 75jPhQVL8QxljqoWWTrALWxWjAHaxDg/VOzvZvsOu7pGaFlXOyxgWH3HLR7JLJLQkLdhVLzGSsr
 HqO5qLlqagbjjs9FvG1Vp4hsjaeBnQS4YBhXdOV9vpKYHaKLMZhd0irtJd+GLPlxqAdfE1N4sgW
 3s+wy+l8/9S8wlA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the VID and PID of Razer Wolverine V2 to xpad_device.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/input/joystick/xpad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index f5c21565bb3c..e2c1848182de 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -286,6 +286,7 @@ static const struct xpad_device {
 	{ 0x146b, 0x0604, "Bigben Interactive DAIJA Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x1532, 0x0a00, "Razer Atrox Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x1532, 0x0a03, "Razer Wildcat", 0, XTYPE_XBOXONE },
+	{ 0x1532, 0x0a29, "Razer Wolverine V2", 0, XTYPE_XBOXONE },
 	{ 0x15e4, 0x3f00, "Power A Mini Pro Elite", 0, XTYPE_XBOX360 },
 	{ 0x15e4, 0x3f0a, "Xbox Airflo wired controller", 0, XTYPE_XBOX360 },
 	{ 0x15e4, 0x3f10, "Batarang Xbox 360 controller", 0, XTYPE_XBOX360 },

---
base-commit: 0f5cc96c367f2e780eb492cc9cab84e3b2ca88da
change-id: 20231125-razer-wolverine-v2-d0521b23aea5

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

