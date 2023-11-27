Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E513D7FABB8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjK0UjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjK0UjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:39:04 -0500
Received: from smtp.livemail.co.uk (smtp-out-60.livemail.co.uk [213.171.216.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D2D93;
        Mon, 27 Nov 2023 12:39:11 -0800 (PST)
Received: from laptop (host-78-146-56-151.as13285.net [78.146.56.151])
        (Authenticated sender: malcolm@5harts.com)
        by smtp.livemail.co.uk (Postfix) with ESMTPSA id 2E419C5A30;
        Mon, 27 Nov 2023 20:39:08 +0000 (GMT)
References: <875y1nt1bx.fsf@5harts.com>
User-agent: mu4e 1.8.15; emacs 29.1
From:   Malcolm Hart <malcolm@5harts.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Sven Frotscher <sven.frotscher@gmail.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] sound: soc: amd: yc: Fix non-functional mic on ASUS E1504FA
Date:   Mon, 27 Nov 2023 20:36:00 +0000
In-reply-to: <875y1nt1bx.fsf@5harts.com>
Message-ID: <871qcbszh0.fsf@5harts.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



This patch adds ASUSTeK COMPUTER INC  "E1504FA" to the quirks file acp6x-mach.c
to enable microphone array on ASUS Vivobook GO 15.
I have this laptop and can confirm that the patch succeeds in enabling the
microphone array.

Signed-off-by: Malcolm Hart <malcolm@5harts.com>
Cc: stable@vger.kernel.org
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 15a864dcd7bd3a..3babb17a56bb55 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -283,6 +283,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M6500RC"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "E1504FA"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {

