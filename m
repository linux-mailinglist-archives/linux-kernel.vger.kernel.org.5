Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528817C54B4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjJKNDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjJKNDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:03:31 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DE48F;
        Wed, 11 Oct 2023 06:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=IFsYLR4wmr3IAYVRLjSnORkQTv/8c6YGBfQFkD5vk3U=; b=JHyD4Wp0zJGuCznKIDyQmWN5pD
        V+PezETsgtuu1YGGs1JsyxiL1CTWpRHE+wPOny9mTWooj5LA2tMg1iGiGKYSfKgJHoSnOXtjzo46c
        FH9RSez3JmBjkPtIrfor3qDHGe6bp04neXbxbCoeKckrFL731cp6EXE0ZlEn8PiL1rrc=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:33542 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qqYs0-0000rX-T1; Wed, 11 Oct 2023 09:03:25 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Date:   Wed, 11 Oct 2023 09:03:17 -0400
Message-Id: <20231011130317.3562401-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH] serial: max310x: remove trailing whitespaces
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Fix coding style. No functional changes.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index db3204d2a305..97e4965b73d4 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -402,7 +402,7 @@ static int max14830_detect(struct device *dev)
 	ret = s->if_cfg->extended_reg_enable(dev, true);
 	if (ret)
 		return ret;
-	
+
 	regmap_read(s->regmap, s->if_cfg->rev_id_reg, &val);
 	s->if_cfg->extended_reg_enable(dev, false);
 	if (((val & MAX310x_REV_MASK) != MAX14830_REV_ID)) {

base-commit: 1c8b86a3799f7e5be903c3f49fcdaee29fd385b5
-- 
2.39.2

