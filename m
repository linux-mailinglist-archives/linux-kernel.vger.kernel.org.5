Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5BB799B7A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 23:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245687AbjIIVrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 17:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjIIVrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 17:47:51 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C2CBB;
        Sat,  9 Sep 2023 14:47:46 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-501cef42bc9so5218443e87.0;
        Sat, 09 Sep 2023 14:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694296064; x=1694900864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VjkPTg6d1txBcnxQFxlQUXqq1PN1XBWEFnNTjUZQp8U=;
        b=OmUzY7Bd5ZELo2+srrfZgfLnkOin3dAUk1V9ap5wZEso9xKXT1wWXEQpLwgjwUgSRY
         5/lzVA3SF5xbqpCxfMsUVV1tZD4VUorXRAlM6sCYYd7LjuzTflEcQ8cPLC5F010s/U7Q
         Cexw5lHgdcPQVSZxt7SOGSM5l2JLq4Co8CxU6uNSvrKgK/8QygDYPzqfDeivDxpUNCsm
         /a+mH0eqHbqupTKxNWARRN6W8FskBzs/bS6y7KiZY/f2k5epfkzBH58VNjh0vNF/vg4C
         SbXHO6M4734IJaZTWg6YUtaS14Qnu1KOXsT2WWsihU15DAvA/cCZ5eLAXRYT2EZ2sTDB
         5ihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694296064; x=1694900864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VjkPTg6d1txBcnxQFxlQUXqq1PN1XBWEFnNTjUZQp8U=;
        b=Xt9l3Tb/es5ajn7Ad89Zg+NjB44XhomaGOM/a8c7lM8zYU1SYtLWMXJHTWoVi91LfS
         kOOPXbHNhA1/yhTmKc1V8/h2T+G2Gi/4QGPCVN4MfBZPCtvTk1mej9yQqPrc02nn1VPi
         Kjlv15orVq8pwcgsj7oHyflRH64pea+FmKPEOJKawpNc6VQf95WU7jylHUZgakRmaArc
         vDPBJ/X9hKvH2KHA4gAM1vDRycdQ0NJuRtCm5eZGK3XkdNKbenKH7ZKEMzhqGVbLcf+2
         m3eYoGgZ9iWGb0r/8O8yJNCLIWIHxatoKShYS6oGmpM2cKpksAI2tZTj7u6Lotttz8G2
         VLNQ==
X-Gm-Message-State: AOJu0Yx09L4FYnFDb6GnlTX3FNtj2U2Ng/V1McU1hYvRQV7BY+nSdWbQ
        prYrBdU7FBPP5Gm/065zIHJIiEiiOvTUdQ==
X-Google-Smtp-Source: AGHT+IGnahBBVT0pZWu7NpQPJloZxgwkpgFO4fKvItiJoiirz8vhclaabDlaXjsBK6Ty8SBgzl11Ww==
X-Received: by 2002:a05:6512:3194:b0:500:9a29:bcb8 with SMTP id i20-20020a056512319400b005009a29bcb8mr5609577lfe.4.1694296064323;
        Sat, 09 Sep 2023 14:47:44 -0700 (PDT)
Received: from user-PC.. ([92.51.95.194])
        by smtp.gmail.com with ESMTPSA id f24-20020a19ae18000000b004fe27a050fdsm745345lfc.259.2023.09.09.14.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 14:47:43 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Chinmoy Ghosh <chinmoyghosh2001@gmail.com>,
        Mintu Patel <mintupatel89@gmail.com>,
        Vimal Kumar <vimal.kumar32@gmail.com>,
        Vishal Badole <badolevishal1116@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v1] clk: Add clock consumer and connection id to clk summary
Date:   Sun, 10 Sep 2023 00:47:32 +0300
Message-Id: <20230909214732.4170560-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "consumer device" and "connection id" columns to the clk summary
in order to show which user acquired and enabled a particular clock.

Co-developed-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
Signed-off-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
Co-developed-by: Mintu Patel <mintupatel89@gmail.com>
Signed-off-by: Mintu Patel <mintupatel89@gmail.com>
Co-developed-by: Vimal Kumar <vimal.kumar32@gmail.com>
Signed-off-by: Vimal Kumar <vimal.kumar32@gmail.com>
Co-developed-by: Vishal Badole <badolevishal1116@gmail.com>
Signed-off-by: Vishal Badole <badolevishal1116@gmail.com>
Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/clk/clk.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c249f9791ae8..64ee44f55a6f 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3187,7 +3187,8 @@ static struct hlist_head *orphan_list[] = {
 static void clk_summary_show_one(struct seq_file *s, struct clk_core *c,
 				 int level)
 {
-	int phase;
+	int phase, next_line = 0;
+	struct clk *clk_user;
 
 	seq_printf(s, "%*s%-*s %7d %8d %8d %11lu %10lu ",
 		   level * 3 + 1, "",
@@ -3205,11 +3206,25 @@ static void clk_summary_show_one(struct seq_file *s, struct clk_core *c,
 	seq_printf(s, " %6d", clk_core_get_scaled_duty_cycle(c, 100000));
 
 	if (c->ops->is_enabled)
-		seq_printf(s, " %9c\n", clk_core_is_enabled(c) ? 'Y' : 'N');
+		seq_printf(s, " %9c", clk_core_is_enabled(c) ? 'Y' : 'N');
 	else if (!c->ops->enable)
-		seq_printf(s, " %9c\n", 'Y');
+		seq_printf(s, " %9c", 'Y');
 	else
-		seq_printf(s, " %9c\n", '?');
+		seq_printf(s, " %9c", '?');
+
+	hlist_for_each_entry(clk_user, &c->clks, clks_node) {
+		if (!clk_user->dev_id && !clk_user->con_id)
+			continue;
+
+		seq_printf(s, "%*s%-25s  %10s\n",
+			   2 + 103 * next_line, "",
+			   clk_user->dev_id, clk_user->con_id);
+
+		next_line = 1;
+	}
+
+	if (!next_line)
+		seq_puts(s, "\n");
 }
 
 static void clk_summary_show_subtree(struct seq_file *s, struct clk_core *c,
@@ -3230,9 +3245,9 @@ static int clk_summary_show(struct seq_file *s, void *data)
 	struct clk_core *c;
 	struct hlist_head **lists = s->private;
 
-	seq_puts(s, "                                 enable  prepare  protect                                duty  hardware\n");
-	seq_puts(s, "   clock                          count    count    count        rate   accuracy phase  cycle    enable\n");
-	seq_puts(s, "-------------------------------------------------------------------------------------------------------\n");
+	seq_puts(s, "                                 enable  prepare  protect                                duty  hardware  consumer                   connection\n");
+	seq_puts(s, "   clock                          count    count    count        rate   accuracy phase  cycle    enable    device                           id\n");
+	seq_puts(s, "----------------------------------------------------------------------------------------------------------------------------------------------\n");
 
 	clk_prepare_lock();
 
-- 
2.39.2

