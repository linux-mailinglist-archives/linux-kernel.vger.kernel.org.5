Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5304180CAF2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343662AbjLKN0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343625AbjLKN00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:26:26 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D43AB3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:26:31 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BBDQ1GU122474;
        Mon, 11 Dec 2023 07:26:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702301161;
        bh=UtCzAYAIRzPVfRJP9Kfrt39CwnlXcV5HuJkPTvuZFDE=;
        h=From:To:CC:Subject:Date;
        b=nKiXeNd00NFgq3Qb5xq2e7WXspoF7Fc6a0IQA5zR58Bem6Oi3k77JV/nFbIn4Sdnc
         46jlOnrMWBooDt/EWyEC5yCqbiBAxOBnc9fSqazQs0duyzLacjLouEvydhaU5AEcns
         2iwSap1f0KwctkKb3H+u/eHAOoFPW/E4Y6R5hn08=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BBDQ1ih015892
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Dec 2023 07:26:01 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Dec 2023 07:26:01 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Dec 2023 07:26:01 -0600
Received: from localhost ([10.24.69.141])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BBDQ0A4062315;
        Mon, 11 Dec 2023 07:26:01 -0600
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <nm@ti.com>, <ssantosh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <vigneshr@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
        <vaishnav.a@ti.com>
Subject: [PATCH] soc: ti: k3-socinfo: Add JTAG ID for J722S
Date:   Mon, 11 Dec 2023 18:56:00 +0530
Message-ID: <20231211132600.25289-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add JTAG ID info for the J722S SoC family to enable SoC detection.

More details about this SoC can be found in the TRM:
	https://www.ti.com/lit/zip/sprujb3

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

Bootlog with changes:
https://gist.github.com/vaishnavachath/23d859925277df9ccd628190e7c23371

 drivers/soc/ti/k3-socinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
index 7517a9c8c8fa..59101bf7cf23 100644
--- a/drivers/soc/ti/k3-socinfo.c
+++ b/drivers/soc/ti/k3-socinfo.c
@@ -42,6 +42,7 @@
 #define JTAG_ID_PARTNO_J784S4		0xBB80
 #define JTAG_ID_PARTNO_AM62AX		0xBB8D
 #define JTAG_ID_PARTNO_AM62PX		0xBB9D
+#define JTAG_ID_PARTNO_J722S		0xBBA0
 
 static const struct k3_soc_id {
 	unsigned int id;
@@ -56,6 +57,7 @@ static const struct k3_soc_id {
 	{ JTAG_ID_PARTNO_J784S4, "J784S4" },
 	{ JTAG_ID_PARTNO_AM62AX, "AM62AX" },
 	{ JTAG_ID_PARTNO_AM62PX, "AM62PX" },
+	{ JTAG_ID_PARTNO_J722S, "J722S" },
 };
 
 static const char * const j721e_rev_string_map[] = {
-- 
2.17.1

