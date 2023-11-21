Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A77D7F3A10
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbjKUXJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbjKUXJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:09:17 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B559D40
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=+6hE03ddUTSileO+nPrb9c7HTKktwmVyB8a8F66SFQo=; b=H3xltCHD1wbqGJ4S6UftJC8q4l
        XFTPnYoer4k8O+Nj13RhC7Cc7Y02scHujIXC7mZAeDlvJJsVtKZ7qBvSLv3cC0wjEhKoqAapQCpV8
        75wl2886zTjZW0S1hdWObV2Bl9q8BtWLyC99ycIe6LW74p3WmGITR7X+pled8hDXnNnI=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:43268 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1r5Zrb-0002vT-Rw; Tue, 21 Nov 2023 18:09:04 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 21 Nov 2023 18:09:00 -0500
Message-Id: <20231121230900.3754785-1-hugo@hugovil.com>
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
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Subject: [PATCH] regmap: fix regmap_noinc_write() description
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Change "Write data from" -> "Write data to".

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/base/regmap/regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index ea6157747199..6db77d8e45f9 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2136,7 +2136,7 @@ static int regmap_noinc_readwrite(struct regmap *map, unsigned int reg,
 }
 
 /**
- * regmap_noinc_write(): Write data from a register without incrementing the
+ * regmap_noinc_write(): Write data to a register without incrementing the
  *			register number
  *
  * @map: Register map to write to

base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
-- 
2.39.2

