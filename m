Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADD57FC8C2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376414AbjK1VIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346650AbjK1VII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:08:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04C02D67
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:07:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E4CC433C9;
        Tue, 28 Nov 2023 21:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205637;
        bh=ob+HZVAARe+Rhv/4hXZU6NwzWHjA4yQyjh2YxsKF1kA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tgy07eK5Al6xocrq85J7/hISaJm5A3JQ7Qxeqeo7JHMyce2zi/ExJNSmAx84vWbao
         Ocg2OXC9tLXGVU1+cNTugR/9Wn+hQzET+ftZFRFD71fR+IkBxVdE/+dlC2y4rrb2dY
         EZjm00AEXjgM+dCdqUwwpjhrGpAwCqyJzisQkb/eUhTbp2n1wsEPT5tAeOoxeczvuQ
         hHT+979Pp8/TpyD/CfQgBtX5XtZalxAYRBaDg2i+3OZPgkEZVLfQeiifIq7k0WgIv3
         S8wZCl1m/GK5ynVLTzosdteC//w4ns6xOyTkZy0ta61y3MMi/ALcbD/+2DexPTpR/F
         qqiZAF1B1xgOg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yihong Cao <caoyihong4@outlook.com>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <sashal@kernel.org>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 26/40] HID: apple: add Jamesdonkey and A3R to non-apple keyboards list
Date:   Tue, 28 Nov 2023 16:05:32 -0500
Message-ID: <20231128210615.875085-26-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
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

From: Yihong Cao <caoyihong4@outlook.com>

[ Upstream commit 113f736655e4f20633e107d731dd5bd097d5938c ]

Jamesdonkey A3R keyboard is identified as "Jamesdonkey A3R" in wired
mode, "A3R-U" in wireless mode and "A3R" in bluetooth mode. Adding them
to non-apple keyboards fixes function key.

Signed-off-by: Yihong Cao <caoyihong4@outlook.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-apple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 3ca45975c686e..d9e9829b22001 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -345,6 +345,8 @@ static const struct apple_non_apple_keyboard non_apple_keyboards[] = {
 	{ "AONE" },
 	{ "GANSS" },
 	{ "Hailuck" },
+	{ "Jamesdonkey" },
+	{ "A3R" },
 };
 
 static bool apple_is_non_apple_keyboard(struct hid_device *hdev)
-- 
2.42.0

