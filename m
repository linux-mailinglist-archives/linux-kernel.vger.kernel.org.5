Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282327EA0A7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjKMPyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjKMPyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:54:23 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA0893;
        Mon, 13 Nov 2023 07:54:20 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b2f28caab9so2851801b6e.1;
        Mon, 13 Nov 2023 07:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699890860; x=1700495660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9P5g3/fICZscbHOqQNcqknCdN9kVr+xTLjYRH6XTbc=;
        b=eTTRM7Rwd3EBv48LZWBcBqSucUfO5aZOsf2vd8gC+/rp3j1eKF6/sBpJ1lIMYTk0fI
         QHJ41rMcuds7wQuBpoOBzid8WPPq3bgOcbulPrzFgcAPmS5+nJlKiU2978JvD71U8982
         nj5la319XQvcXMyQ2f0LHGALszE3CA2fHIbMnonclOvR88KVU7WQvF9X3h7tZA1fpvxD
         7tj9axPBVWf7VAhMYFO9YD4RsXiKSEN7hA1dPQnU1spBtzbETcCA18Cio80CJAJtLWDx
         JoBcubKYSjnsenAOSCa8BKFxjnqGZvf8KF+VJh0j3OI5xebiXcp1knxW0xTsWsiBMjBO
         NqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699890860; x=1700495660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9P5g3/fICZscbHOqQNcqknCdN9kVr+xTLjYRH6XTbc=;
        b=mu5sigezdjhWED4PDaVqI4UI/s58N6OZJrNPYKJfDg0to6hU6mc6NJnbtUMb0dghAq
         0XfBnMNtAzTU7ZQ6pDv4dBL5ABtaHHmkNBQ1WQZT8AqYKm/+uya+4+maQugBEYoXtVlT
         aslYlE4Bo6yjLanFKs1qnbNyd3xdDY7fveFkD+P9qHQuH31BISt5akNZCc0mhMVCaFyT
         QQu+M5TBQkaeSqjp4wPJLuNUTU0xBE3T50l0jVLF7xWBReEOOZ8yA26OIGhOrH2AN2yN
         ko4+12WTTwHR0nmoCn+NbXNoEgWYuHe6Ey+l9JQUSo/W/+EdpYLjA97OSxlVCyGeUKTt
         5T7w==
X-Gm-Message-State: AOJu0Yz1hqwRpaITxtxeRkxaM0EOo6xsZsxCkH4TBebwPEqM8gEpNtkb
        ApcLLXBbhpU0xG9BC3N5OBc=
X-Google-Smtp-Source: AGHT+IH7k7dXZTgMDY7KAlEHkCgMgyykBUG0pei1zXSEMtetT39nGZqwDyaAZ6slrLKnSuvOyvLMAw==
X-Received: by 2002:a54:4810:0:b0:3ac:a4ec:e136 with SMTP id j16-20020a544810000000b003aca4ece136mr7716635oij.51.1699890860256;
        Mon, 13 Nov 2023 07:54:20 -0800 (PST)
Received: from localhost.localdomain ([149.167.148.33])
        by smtp.gmail.com with ESMTPSA id e15-20020a65678f000000b0057ab7d42a4dsm3562722pgr.86.2023.11.13.07.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 07:54:19 -0800 (PST)
From:   Ronald Monthero <debug.penguin32@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        martin.blumenstingl@googlemail.com, paul@crapouillou.net,
        robh@kernel.org, u.kleine-koenig@pengutronix.de,
        debug.penguin32@gmail.com, AVKrasnov@sberdevices.ru,
        r.czerwinski@pengutronix.de, andriy.shevchenko@linux.intel.com,
        jaimeliao.tw@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2] mtd: rawnand: Increment IFC_TIMEOUT_MSECS for nand controller response
Date:   Tue, 14 Nov 2023 01:53:51 +1000
Message-Id: <20231113155354.620298-1-debug.penguin32@gmail.com>
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

