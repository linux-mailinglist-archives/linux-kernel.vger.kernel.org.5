Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DE67A9A08
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjIUSfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjIUSfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:35:25 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4115065BA;
        Thu, 21 Sep 2023 11:15:22 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4053c6f0d3dso922945e9.1;
        Thu, 21 Sep 2023 11:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695320120; x=1695924920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VewR6GvnAG1Xb3ny5cXxxfMwVZK0RXHm5eoMUnZrOq4=;
        b=dNMWu+4wZaZq9t/liVVlkh0RkoNzuzAWg28uiKBteA91wSWenHkvXGatLVu7j1+ApF
         eUPQZp46d5xh7OGrShzDvxC+G6Z+pszsJybMS5NdD2ICisaGIyU/7KX1yvIrk3HV0sog
         7MRo/bOwJY2p4nskGEAjjjGDKUBbGGbUU/xZJEDLnADN+GK9vlJzFy/oHiRX944F45Sm
         tFtMuHeeTvbCPBpwwsCrwJm6N/reheVrojhQGJj08LVI2TAtwwYbmzj165trvrRiyfrk
         0Afvf0yxBt79AVrhkVLz7XIAtNb5f9poI+I4Tblkk+Re6i+vE7WjfgMYxXa8XkbNjJPb
         d+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320120; x=1695924920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VewR6GvnAG1Xb3ny5cXxxfMwVZK0RXHm5eoMUnZrOq4=;
        b=v3HyRDiuDSv4UOAOI6b2dJJiQiyLcmxcawoAsFopmfBJIm4CL+TxYZXymZLZgH/8bZ
         mdEd9nCNQ2HmEtgera8S24ZzcIlLo59AIB/6t+IWhSLSRfKAWP8GiDaJP1Pn2FeaGnH0
         FtN/H1iPK7WysWNw4baL5T9KjyqMvGkNQz+QzstQwyANyvsfF518wkNETEdPn4yu2qdj
         4XQze42yzDc301hW8vfMseqXzR8hZx4SRwhAPNnFQwHBsTLdUiNhP+c//qlLda4B5XAZ
         dqsTZABY+mRMbSW7gAkfSFJbGABejaZQ4d3NFkcHMLn0KqfPVzM1aXL8SJ/Dplxfyb9p
         4Tug==
X-Gm-Message-State: AOJu0YxynJVca+OWaTbMFhngqOpLDHk3DpUNVlqMtgGUfTKzqbDbAmnf
        Xpa8ljMaU95TwpVstx1sgQfE6PG83n4z9Q==
X-Google-Smtp-Source: AGHT+IFHhXhgBdE5T7SPSfFl/a9nBt06Mtr/0hBhDGBXRf4YMzvsWqLkX0osTD7Hjg49aO3EPR3Lkw==
X-Received: by 2002:a05:6512:4002:b0:4fe:25bc:71f5 with SMTP id br2-20020a056512400200b004fe25bc71f5mr4995738lfb.11.1695281585731;
        Thu, 21 Sep 2023 00:33:05 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
        by smtp.googlemail.com with ESMTPSA id k22-20020a05600c0b5600b0040523bef620sm1161231wmr.0.2023.09.21.00.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 00:33:05 -0700 (PDT)
From:   "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     Alessandro Carminati <alessandro.carminati@gmail.com>,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Philip Daly <pdaly@redhat.com>
Subject: [PATCH v2] clk: Sanitize possible_parent_show to Handle Return Value of of_clk_get_parent_name
Date:   Thu, 21 Sep 2023 07:32:17 +0000
Message-Id: <20230921073217.572151-1-alessandro.carminati@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-type: text/plain
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

From: Alessandro Carminati <alessandro.carminati@gmail.com>

In the possible_parent_show function, ensure proper handling of the return
value from of_clk_get_parent_name to prevent potential issues arising from
a NULL return.
The current implementation invokes seq_puts directly on the result of
of_clk_get_parent_name without verifying the return value, which can lead
to kernel panic if the function returns NULL.

This patch addresses the concern by introducing a check on the return
value of of_clk_get_parent_name. If the return value is not NULL, the
function proceeds to call seq_puts, providing the returned value as
argument.
However, if of_clk_get_parent_name returns NULL, the function provides a
static string as argument, avoiding the panic.

Fixes: 1ccc0ddf046a ("clk: Use seq_puts() in possible_parent_show()")
Reported-by: Philip Daly <pdaly@redhat.com>
Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
---
 drivers/clk/clk.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c249f9791ae8..473563bc7496 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3416,6 +3416,7 @@ static void possible_parent_show(struct seq_file *s, struct clk_core *core,
 				 unsigned int i, char terminator)
 {
 	struct clk_core *parent;
+	const char *name = NULL;
 
 	/*
 	 * Go through the following options to fetch a parent's name.
@@ -3430,18 +3431,20 @@ static void possible_parent_show(struct seq_file *s, struct clk_core *core,
 	 * registered (yet).
 	 */
 	parent = clk_core_get_parent_by_index(core, i);
-	if (parent)
+	if (parent) {
 		seq_puts(s, parent->name);
-	else if (core->parents[i].name)
+	} else if (core->parents[i].name) {
 		seq_puts(s, core->parents[i].name);
-	else if (core->parents[i].fw_name)
+	} else if (core->parents[i].fw_name) {
 		seq_printf(s, "<%s>(fw)", core->parents[i].fw_name);
-	else if (core->parents[i].index >= 0)
-		seq_puts(s,
-			 of_clk_get_parent_name(core->of_node,
-						core->parents[i].index));
-	else
-		seq_puts(s, "(missing)");
+	} else {
+		if (core->parents[i].index >= 0)
+			name = of_clk_get_parent_name(core->of_node, core->parents[i].index);
+		if (!name)
+			name = "(missing)";
+
+		seq_puts(s, name);
+	}
 
 	seq_putc(s, terminator);
 }
-- 
2.34.1

