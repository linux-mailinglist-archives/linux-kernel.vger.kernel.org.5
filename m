Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123807CDE7E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344875AbjJROMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbjJROML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:12:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9B912D;
        Wed, 18 Oct 2023 07:11:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A0CC433C8;
        Wed, 18 Oct 2023 14:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638315;
        bh=ZdE/+Wi7kowc42dVlvNo1gm7hHy7ZdYIidGafejPTVg=;
        h=From:To:Cc:Subject:Date:From;
        b=k2AohL2QX2tXd642Vy/qxOABhL0exebAj+onZDgj/B13U24Z2LNnPUU5GNRJzwC4j
         WxOKkx4c2v+0uNV9m3Ihe2T5O5X7c8wizdfb1qdjXZu9MClNEn2NzhjRR+8PrGrKeQ
         3lacmh+S87RO7NzsL0KTqkAv0yblijl3YFK4SdfGd2NfyKkFrLLy3ZrNAW+HY+O82x
         O8zH+8je8wanApqT3kvSsSvTl9Y7H6nvawv81BmsOh59zKCNv7F/2AH8iH4vSwZjWo
         fUaOj9FRJc85I8bSu608Cas9TJSz/PpFnfBkRB+s+ivQI7Mjc/k2eKgF5+GDxy9MI4
         wRnAPCiTFO7Ng==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Max Nguyen <maxwell.nguyen@hp.com>,
        Chris Toledanes <chris.toledanes@hp.com>,
        Carl Ng <carl.ng@hp.com>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, vi@endrift.com,
        swyterzone@gmail.com, doublej472@gmail.com,
        pgriffais@valvesoftware.com, slouken@libsdl.org,
        matthias.benkmann@gmail.com, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 01/31] Input: xpad - add HyperX Clutch Gladiate Support
Date:   Wed, 18 Oct 2023 10:11:18 -0400
Message-Id: <20231018141151.1334501-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.7
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Nguyen <maxwell.nguyen@hp.com>

[ Upstream commit e28a0974d749e5105d77233c0a84d35c37da047e ]

Add HyperX controller support to xpad_device and xpad_table.

Suggested-by: Chris Toledanes <chris.toledanes@hp.com>
Reviewed-by: Carl Ng <carl.ng@hp.com>
Signed-off-by: Max Nguyen <maxwell.nguyen@hp.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Link: https://lore.kernel.org/r/20230906231514.4291-1-hphyperxdev@gmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index cdb193317c3b6..1e377d040c435 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -130,6 +130,7 @@ static const struct xpad_device {
 	{ 0x0079, 0x18d4, "GPD Win 2 X-Box Controller", 0, XTYPE_XBOX360 },
 	{ 0x03eb, 0xff01, "Wooting One (Legacy)", 0, XTYPE_XBOX360 },
 	{ 0x03eb, 0xff02, "Wooting Two (Legacy)", 0, XTYPE_XBOX360 },
+	{ 0x03f0, 0x0495, "HyperX Clutch Gladiate", 0, XTYPE_XBOXONE },
 	{ 0x044f, 0x0f00, "Thrustmaster Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f03, "Thrustmaster Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
@@ -457,6 +458,7 @@ static const struct usb_device_id xpad_table[] = {
 	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* Xbox USB-IF not-approved class */
 	XPAD_XBOX360_VENDOR(0x0079),		/* GPD Win 2 controller */
 	XPAD_XBOX360_VENDOR(0x03eb),		/* Wooting Keyboards (Legacy) */
+	XPAD_XBOXONE_VENDOR(0x03f0),		/* HP HyperX Xbox One controllers */
 	XPAD_XBOX360_VENDOR(0x044f),		/* Thrustmaster Xbox 360 controllers */
 	XPAD_XBOX360_VENDOR(0x045e),		/* Microsoft Xbox 360 controllers */
 	XPAD_XBOXONE_VENDOR(0x045e),		/* Microsoft Xbox One controllers */
-- 
2.40.1

