Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BA47C8053
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjJMIdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjJMIdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:33:16 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6738B8;
        Fri, 13 Oct 2023 01:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=gLlXF
        jKTiiIs5lXq19j2GudYTxs8nyTJiUwjN1lbkPE=; b=QTicBGFrsAwwaMl9UXZ5M
        XaRi1FjW71Fp5fIuJJupS6LLbb3qZc4fGCm5VygD5SA0ff8onxyMWOLMP8l6c7kP
        4ZMXDKFgqY7Muk3O25Anc2bcATKQOUBvvL4Viqw3HEGv8BbYRulUKTiRGKMcoPZs
        NN4wsOM1iSayqvUdSvVS+0=
Received: from test-Z390-GAMING-X.bayhubtech.com (unknown [58.48.115.170])
        by zwqz-smtp-mta-g0-1 (Coremail) with SMTP id _____wDX3425ACll2Aa7AQ--.10191S2;
        Fri, 13 Oct 2023 16:32:58 +0800 (CST)
From:   liuchang_125125@163.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mark.tao@bayhubtech.com, shaper.liu@bayhubtech.com,
        thomas.hu@bayhubtech.com, chevron.li@bayhubtech.com,
        charl.liu@bayhubtech.com, Charl Liu <liuchang_125125@163.com>
Subject: [PATCH 1/9] scsi: Update Kconfig and Makefile for supporting Bayhub's SD/MMC Card interface driver
Date:   Fri, 13 Oct 2023 16:32:54 +0800
Message-Id: <20231013083254.10244-1-liuchang_125125@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDX3425ACll2Aa7AQ--.10191S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr4xWr48Ww1fAFyxAFykAFb_yoW8GF15pF
        Z5J34DA3yDXayFkrZrG3yUWFy5ta97t34Y9ayUX3s8WFy8CFyYvrnrtFy7JFWkGr4kJry3
        tFnxGa42ga4UJrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_-eOUUUUUU=
X-Originating-IP: [58.48.115.170]
X-CM-SenderInfo: polxux5dqjsiqsvrjki6rwjhhfrp/xtbB0BsIWWEssysXgQAAsZ
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charl Liu <liuchang_125125@163.com>

1.update Kconfig for loading Bayhub's Kconfig
2.update Makefile for compiling Bayhub's module

Signed-off-by: Charl Liu <liuchang_125125@163.com>
---
Change in V1:
Update Kconfig and Makefile for supporting Bayhub's SD/MMC Card
interface driver.
---
 drivers/scsi/Kconfig  | 1 +
 drivers/scsi/Makefile | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 695a57d894cd..15e94b5fdb25 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -490,6 +490,7 @@ source "drivers/scsi/megaraid/Kconfig.megaraid"
 source "drivers/scsi/mpt3sas/Kconfig"
 source "drivers/scsi/mpi3mr/Kconfig"
 source "drivers/scsi/smartpqi/Kconfig"
+source "drivers/scsi/bht/Kconfig"
 
 config SCSI_HPTIOP
 	tristate "HighPoint RocketRAID 3xxx/4xxx Controller support"
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index f055bfd54a68..80f1987a9770 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -152,6 +152,8 @@ obj-$(CONFIG_SCSI_ENCLOSURE)	+= ses.o
 
 obj-$(CONFIG_SCSI_HISI_SAS) += hisi_sas/
 
+obj-$(CONFIG_SCSI_BHT)	+= bht/
+
 # This goes last, so that "real" scsi devices probe earlier
 obj-$(CONFIG_SCSI_DEBUG)	+= scsi_debug.o
 scsi_mod-y			+= scsi.o hosts.o scsi_ioctl.o \
-- 
2.34.1

