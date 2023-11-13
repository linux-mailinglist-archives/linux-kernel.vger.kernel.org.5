Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCF07EA0F5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 17:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjKMQI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 11:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjKMQI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 11:08:56 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525D0171A;
        Mon, 13 Nov 2023 08:08:53 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5bd5809f63aso2689371a12.3;
        Mon, 13 Nov 2023 08:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699891732; x=1700496532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPuU6NHbUp/SgydRBNeLDEaf5ofrHVDlSX75GYurXdQ=;
        b=k4nTc58IHG7SWOnVaPKW/nFT16HjOtd+Mr9ro2+FhEEoJmJTmqEBwMD2soB+TOQG36
         qoHolMoMnT/3+PJIniFWA3F1/ZtNS68d6zNjYVrudV2k3kUIaaB1A+TdhOK/AS1/B/mk
         w8SbJJseWTCtlYGfYxyF5dJUB3qDl4ORbxvImgRIqcQrPW1aHJBKJyyDOkqqIsLlsNNm
         kczGJXxC1I9CV+0po4z4MBs/Ji4sfuc0bWW7hPGNQ73S2HwFVnjG9nsYTHsEIr/vy+1s
         AGxnMcmiAW239HkKO0dNOI+6y/Cktfj3qhXFKeoqU9jzGv/d+Qw6mJDE7sEmFUYBiPmJ
         jGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699891732; x=1700496532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPuU6NHbUp/SgydRBNeLDEaf5ofrHVDlSX75GYurXdQ=;
        b=hcqk22cxAGCMdH/Mk00BEJUIm+jdnqHnKtBfVJiZoroHGr6Z7gtiCPTiUtnPMuknYw
         Ykcors0KuOrz/mb9tH0YfIE1DWChq9Wg1N9aPixqDLnwn3kxqBpWnAB10wGcIcjjfFEP
         8crV1809NKCuoJXa1SRQTJyv1kA60+kceFTKoomn4JiA3pPdE0vTAtTI+5tNRdtMU8Xo
         +GrITLLsWIeERk8/MDn5AWK5Zp168YP8hPmng0y8RMQQPBSlQHTJDMNYqj8v7RtCyo7a
         CKPWCwJKSjp+Fa0bPvQvNC79hfl2uiR9yb0Bruhf5/J10eEx7dCJDyZ+Ud+z+SbEHoCw
         XJww==
X-Gm-Message-State: AOJu0Yw5CT1F0bXI4SgZJpfwGLjLjXGEal0q/Z813bCp1IJwMweb+U1w
        BmuSczEAOpglOX/FkwhWFEA=
X-Google-Smtp-Source: AGHT+IGBR1PQkuTCOAB2gjuro2F+BqtLV3jLOeCnkGMb78QpXMwT2zy1xxCdY45tREDYMdOC6/UwBQ==
X-Received: by 2002:a17:90b:11c1:b0:280:14ac:a6dc with SMTP id gv1-20020a17090b11c100b0028014aca6dcmr4522639pjb.25.1699891731757;
        Mon, 13 Nov 2023 08:08:51 -0800 (PST)
Received: from localhost.localdomain ([149.167.148.33])
        by smtp.gmail.com with ESMTPSA id p17-20020a17090adf9100b00281032f9f9csm5778832pjv.35.2023.11.13.08.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 08:08:51 -0800 (PST)
From:   Ronald Monthero <debug.penguin32@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        martin.blumenstingl@googlemail.com, paul@crapouillou.net,
        robh@kernel.org, u.kleine-koenig@pengutronix.de,
        debug.penguin32@gmail.com, AVKrasnov@sberdevices.ru,
        r.czerwinski@pengutronix.de, andriy.shevchenko@linux.intel.com,
        jaimeliao.tw@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH v2] mtd: rawnand: Increment IFC_TIMEOUT_MSECS for nand controller response
Date:   Tue, 14 Nov 2023 02:07:49 +1000
Message-Id: <20231113160751.620810-1-debug.penguin32@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113131634.614467-1-debug.penguin32@gmail.com>
References: <20231113131634.614467-1-debug.penguin32@gmail.com>
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

Under heavy load it is likely that the controller is done
with its own task but the thread unlocking the wait is not
scheduled in time. Increasing IFC_TIMEOUT_MSECS allows the
controller to respond within allowable timeslice of 1 sec

fsl,ifc-nand 7e800000.nand: Controller is not responding
main/smp_fsm.c:1884 <inrcu: rcu_preempt detected stalls on CPUs/tasks:
rcu:    Tasks blocked on level-0 rcu_node (CPUs 0-1): P116/2:b..l
        (detected by 1, t=2102 jiffies, g=7729, q=754)
task:irq/31-arm-irq1 state:D stack: 0 pid: 116 ppid: 2 flags:0x00000000
[<8064b97f>] (__schedule) from [<8064bb01>] (schedule+0x8d/0xc2)
[<8064bb01>] (schedule) from [<8064dacd>]
[<8064dacd>] (rt_mutex_slowlock_block.constprop.0) from [<8064db57>]
[<8064db57>] (__rt_mutex_slowlock.constprop.0) from [<8064dbf7>]
[<8064dbf7>] (rt_mutex_slowlock.constprop.0) from [<804b2047>]
[<804b2047>] (nand_get_device) from [<804b5335>] (nand_write_oob+0x1b/0x4a)
[<804b5335>] (nand_write_oob) from [<804a3585>] (mtd_write+0x41/0x5c)
[<804a3585>] (mtd_write) from [<804c1d47>] (ubi_io_write+0x17f/0x22c)
[<804c1d47>] (ubi_io_write) from [<804c047b>] (ubi_eba_write_leb+0x5b/0x1d0)

Cc: stable@vger.kernel.org
Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
---
 drivers/mtd/nand/raw/fsl_ifc_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.34.1

