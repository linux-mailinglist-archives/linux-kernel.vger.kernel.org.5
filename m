Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429527E9CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjKMNRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjKMNRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:17:42 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFDBD6C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:17:39 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc3bb32b5dso38454115ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699881459; x=1700486259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BENlKbuFPKHXVOXGwxTOg37z6FdtT5c5MFKpNXhyfZY=;
        b=Eg1bGrNrgkZr00NB0dkckvtN+DGJEZHoKR1aRuOpbup8UFCXu+y0HYRjVkay4BEsjN
         YLV6Oj6/6NrGTjkJbHaxFBP3DE863aI7XlZ4+xtzdCTQ/UiSVbrssoRtaP/zwugIYXg/
         RIjOcbW23vGnLCNiXp8/O06ch+q7alsZYrbZqU+VodcLucRTflEGSP2Y38J4K3cW25zn
         Ilnp9f7cX1D0134h3NY9rPbAjlyHEN2Fmop1FQ2SVoCEKGGuoWoUnsUegu2/19skKv9/
         EpTSv2S0gzh4VjHMApTCPypv33kbHKH0mqLCBdPcr6eGlj3lJAgkpULszGt3Z8fPogaH
         cqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699881459; x=1700486259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BENlKbuFPKHXVOXGwxTOg37z6FdtT5c5MFKpNXhyfZY=;
        b=VfZOFBwfH5Wtd8SWz9hzbZbCvK5Kw+weXnhQJlOFjSv0VP4v3QS+GGJYM8Keo32Qrm
         sXc7/0LSlNXA+fzgVwK70BDHcrJQMaheQUIDAQE7SdfS3S1OeVHZg+qb4nH/QhQmvhBp
         2/iJTIKCIewhI97W2A8V3yi9E55mU7ZHQxV/ZRzEpb6MVpRVY15Fl+TYxjhBsdwDlv5d
         rKO1u0oMrrHQjuIy/PObZI39DlZzj4XEATOU8pLiJf2K0XTzXcSFAnfM9H+Sll7jm2Yo
         qi7MvM/YZue0B+VPEOSH4kAh8ABFEEpm0SCQw/S1vyj3mWTGjGIaIj16/YLW1hyRzxBb
         c2FQ==
X-Gm-Message-State: AOJu0Yyts1KYeJcSVGjjRIgVd0uT5y+OUGKqBgMjGMMIB0bX4g3aDwHm
        X5VkMPilIi4oeZyfLRU0fVpJc9gYS7WspVUH
X-Google-Smtp-Source: AGHT+IHqm4pW1ifICU5+1F7FEK25e8uswN0H7HrMr7MU2H/FOdlpI4jqngLLlc2SDiSyEOdRJVj0sg==
X-Received: by 2002:a17:903:2289:b0:1cc:665d:f822 with SMTP id b9-20020a170903228900b001cc665df822mr9071037plh.32.1699881458663;
        Mon, 13 Nov 2023 05:17:38 -0800 (PST)
Received: from localhost.localdomain ([149.167.148.33])
        by smtp.gmail.com with ESMTPSA id z18-20020a170903019200b001bb97e51ab4sm4020621plg.98.2023.11.13.05.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 05:17:38 -0800 (PST)
From:   Ronald Monthero <debug.penguin32@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        martin.blumenstingl@googlemail.com, paul@crapouillou.net,
        robh@kernel.org, u.kleine-koenig@pengutronix.de,
        debug.penguin32@gmail.com, AVKrasnov@sberdevices.ru,
        r.czerwinski@pengutronix.de, andriy.shevchenko@linux.intel.com,
        jaimeliao.tw@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] mtd:nand: Increment IFC_TIMEOUT_MSECS for nand controller response
Date:   Mon, 13 Nov 2023 23:16:28 +1000
Message-Id: <20231113131634.614467-1-debug.penguin32@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nand controller not responding scenario occurs causing blocked tasks
and rcu_prempt warnings of stall on cpus. Incrementing the
IFC_TIMEOUT_MSECS appears to solve the nand controller not responding
issue.

** ID_531 main/smrcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu:    Tasks blocked on level-0 rcu_node (CPUs 0-1): P116/2:b..l
        (detected by 1, t=2102 jiffies, g=12653, q=518)
task:irq/31-arm-irq1 state:D stack: 0 pid:  116 ppid: 2 flags:0x00000000
[<8064b97f>] (__schedule) from [<8064bb01>] (schedule+0x8d/0xc2)
[<8064bb01>] (schedule) from [<8064fa65>] (schedule_timeout+0x6d/0xa0)
[<8064fa65>] (schedule_timeout) from [<804ba353>] (fsl_ifc_run_command+0x6f/0x178)
[<804ba353>] (fsl_ifc_run_command) from [<804ba72f>] (fsl_ifc_cmdfunc+0x203/0x2b8)
[<804ba72f>] (fsl_ifc_cmdfunc) from [<804b135f>] (nand_status_op+0xaf/0xe0)
[<804b135f>] (nand_status_op) from [<804b13b3>] (nand_check_wp+0x23/0x48)
[<804b13b3>] (nand_check_wp) from [<804b231d>] (nand_do_write_ops+0x99/0x2b8)
[<804b231d>] (nand_do_write_ops) from [<804b5355>] (nand_write_oob+0x3b/0x4a)
[<804b5355>] (nand_write_oob) from [<804a3585>] (mtd_write+0x41/0x5c)
[<804a3585>] (mtd_write) from [<804c1d47>] (ubi_io_write+0x17f/0x22c)
[<804c1d47>] (ubi_io_write) from [<804c047b>] (ubi_eba_write_leb+0x5b/0x1d0)
[<804c047b>] (ubi_eba_write_leb) from [<804bf62d>] (ubi_leb_write+0x75/0x90)
[<804bf62d>] (ubi_leb_write) from [<803745b7>] (ubifs_leb_write+0x4b/0x8c)
[<803745b7>] (ubifs_leb_write) from [<80374bbb>] (ubifs_wbuf_sync_nolock+0x10f/0x1a4)
[<80374bbb>] (ubifs_wbuf_sync_nolock) from [<8036c6dd>] (ubifs_jnl_update+0x1e9/0x36c)
[<8036c6dd>] (ubifs_jnl_update) from [<80370933>] (ubifs_create+0xb3/0x130)
[<80370933>] (ubifs_create) from [<802cf0c7>] (lookup_open+0x173/0x1c4)
[<802cf0c7>] (lookup_open) from [<802cf8a3>] (open_last_lookups+0xd7/0x16c)
[<802cf8a3>] (open_last_lookups) from [<802d08e5>] (path_openat+0x91/0x104)
[<802d08e5>] (path_openat) from [<802d0989>] (do_filp_open+0x31/0x74)
[<802d0989>] (do_filp_open) from [<802c4fb3>] (file_open_name+0x33/0x48)
[<802c4fb3>] (file_open_name) from [<802c4fe9>] (filp_open+0x21/0x2e)
[<802c4fe9>] (filp_open) from [<80490bd3>] (irq1_handler+0x53/0xa4)
[<80490bd3>] (irq1_handler) from [<80247dd7>] (irq_forced_thread_fn+0x1f/0x4c)
[<80247dd7>] (irq_forced_thread_fn) from [<80247cd9>] (irq_thread+0x89/0x114)
[<80247cd9>] (irq_thread) from [<8022ca67>] (kthread+0xcf/0xe4)
[<8022ca67>] (kthread) from [<80200149>] (ret_from_fork+0x11/0x28)
Exception stack(0x822bbfb0 to 0x822bbff8)
bfa0:                                     00000000 00000000 00000000 00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000

fsl,ifc-nand 7e800000.nand: Controller is not responding
ID_531 main/smp_fsm.c:1884 <inrcu: rcu_preempt detected stalls on CPUs:
rcu:    Tasks blocked on level-0 rcu_node (CPUs 0-1): P116/2:b..l
        (detected by 1, t=2102 jiffies, g=7729, q=754)
task:irq/31-arm-irq1 state:D stack: 0 pid:  116 ppid: 2 flags:0x00000000
[<8064b97f>] (__schedule) from [<8064bb01>] (schedule+0x8d/0xc2)
[<8064bb01>] (schedule) from [<8064dacd>] (rt_mutex_slowlock_block.con)
[<8064dacd>] (rt_mutex_slowlock_block.constprop.0) from [<8064db57>] 
[<8064db57>] (__rt_mutex_slowlock.constprop.0) from [<8064dbf7>] 
[<8064dbf7>] (rt_mutex_slowlock.constprop.0) from [<804b2047>] 
[<804b2047>] (nand_get_device) from [<804b5335>] (nand_write_oob+0x1b/0x4a)
[<804b5335>] (nand_write_oob) from [<804a3585>] (mtd_write+0x41/0x5c)
[<804a3585>] (mtd_write) from [<804c1d47>] (ubi_io_write+0x17f/0x22c)
[<804c1d47>] (ubi_io_write) from [<804c047b>] (ubi_eba_write_leb+0x5b/0x1d0)
[<804c047b>] (ubi_eba_write_leb) from [<804bf62d>] (ubi_leb_write+0x75/0x90)
[<804bf62d>] (ubi_leb_write) from [<803745b7>] (ubifs_leb_write+0x4b/0x8c)
[<803745b7>] (ubifs_leb_write) from [<80374bbb>] (ubifs_wbuf_sync_nolock+0x10f/0x1a4)
[<80374bbb>] (ubifs_wbuf_sync_nolock) from [<8036c6dd>] (ubifs_jnl_update+0x1e9/0x36c)

Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
---
 drivers/mtd/nand/raw/fsl_ifc_nand.c | 2 +-
 drivers/mtd/nand/raw/nand_base.c    | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index 20bb1e0cb5eb..42f8ea46b6a8 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -21,7 +21,7 @@
 
 #define ERR_BYTE		0xFF /* Value returned for read
 					bytes when read failed	*/
-#define IFC_TIMEOUT_MSECS	500  /* Maximum number of mSecs to wait
+#define IFC_TIMEOUT_MSECS	1000  /* Maximum number of mSecs to wait
 					for IFC NAND Machine	*/
 
 struct fsl_ifc_ctrl;
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 9e24bedffd89..05b52ed41f4c 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -363,8 +363,11 @@ static int nand_check_wp(struct nand_chip *chip)
 	int ret;
 
 	/* Broken xD cards report WP despite being writable */
-	if (chip->options & NAND_BROKEN_XD)
+	if (chip->options & NAND_BROKEN_XD) {
+		pr_info("nand_chip->options indicates NAND_BROKEN_XD %d\n",
+			(chip->options & NAND_BROKEN_XD));
 		return 0;
+	}
 
 	/* Check the WP bit */
 	ret = nand_status_op(chip, &status);
-- 
2.34.1

