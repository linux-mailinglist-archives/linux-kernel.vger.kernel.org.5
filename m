Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609CE7B2D31
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 09:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjI2Hph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 03:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjI2Hp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 03:45:27 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5DA1A7;
        Fri, 29 Sep 2023 00:45:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8uXqPoVH8eIQRp1PE0u9WwuMmdNwYbUzsd7zfskxjuV0db1BjcEz5xYTexXfcZ8NuJKaAkKCjBk1CgnmXa7xC0CqFRxKr0QkBYzplNdHBGrgPC/9q4Z6Pc5Fd2d8kmIhOVkdN/yIYdmRl6xwb3Amt45+Y2KQb2A0dBkmLB+NXetOlARuWFVutTN8QprwoQSPIx2kC1cRKgd1tD6iEnwq1B3GMCp+mbFg9UAuQWUMA991gAfGXmKs9wItcf57y3DAebvkce06ddNBhhwb87JdNAxPQmXxe4SkFYbpyotiUripQtU4YO3VhwEla3HrkmCR+YDVvDQITKAuuLf/rynug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Uq7HsJO9/a32sMOp9mjH3Oru3eRABhG9sDr50c7ACE=;
 b=IpQaoR/xRQTdX8Ph6Co5/1Ox1pZ+s86s41b9owRYIbefcCBrnaybr3FJh9OxvvrUr+x9BPsJkgOzOwJ3Zad9kHeNCEX3JyO9qEgRGLelWYw/zOJGWAirUh2ClrXpChcw9gAinK0lbZtskYVuP5PEXXY2dqkQGL02KkqNh5TtEiInek3Rx3BfVMHHq1iafP5762nwxtoD84kIkMTbedIsv0QWPb1G0hSJFwd1jMX2WeSueKQj+voJg45n07IVBXiBPghglXvFZm+UGUSfQMAoZTi1xazHmF1dBpMeCmGeN46EOD1dvB+kWoQaib43ObEznHqN3JSuEWPZ3w6zr+A6Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=linaro.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Uq7HsJO9/a32sMOp9mjH3Oru3eRABhG9sDr50c7ACE=;
 b=G0jZLixyts5KDtzYkGE+0XqhTNgNSR9NdkMbhMvh+zpi+B0oeZOGkG2gputlL2XMWtJZ/wF6EDtudqMEvEzQ13FsXydD8FJm60biGtnIHV92mjOpkOOIbGX6YEgCEIueQrIzgvy+7hYZ4JItYEbySVcQaBD6LS4Y01zp0KqYt1c=
Received: from AM6P192CA0106.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:8d::47)
 by AM9PR02MB6706.eurprd02.prod.outlook.com (2603:10a6:20b:2c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.36; Fri, 29 Sep
 2023 07:45:22 +0000
Received: from AMS0EPF000001B0.eurprd05.prod.outlook.com
 (2603:10a6:209:8d:cafe::4b) by AM6P192CA0106.outlook.office365.com
 (2603:10a6:209:8d::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26 via Frontend
 Transport; Fri, 29 Sep 2023 07:45:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001B0.mail.protection.outlook.com (10.167.16.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 07:45:22 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 29 Sep
 2023 09:45:18 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 29 Sep
 2023 09:45:18 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 29 Sep 2023 09:45:18 +0200
Received: from pc45945-2140.se.axis.com (pc45945-2140.se.axis.com [10.88.125.80])
        by se-intmail01x.se.axis.com (Postfix) with ESMTP id 5FAD529E0;
        Fri, 29 Sep 2023 09:45:18 +0200 (CEST)
Received: by pc45945-2140.se.axis.com (Postfix, from userid 10564)
        id 5BB1F7124470; Fri, 29 Sep 2023 09:45:18 +0200 (CEST)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Fri, 29 Sep 2023 09:45:08 +0200
Subject: [PATCH v2 1/2] mmc: core: Always reselect card type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230929-mmc-caps-v2-1-11a4c2d94f15@axis.com>
References: <20230929-mmc-caps-v2-0-11a4c2d94f15@axis.com>
In-Reply-To: <20230929-mmc-caps-v2-0-11a4c2d94f15@axis.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B0:EE_|AM9PR02MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1d4149-2c80-492f-d003-08dbc0c0092f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u1oSB4ap8MfRZoRnVvE6ejkUyHd0RkqbXdd8wGw5vVutM77jWjgDHEWHvprAvNxp9SsqG2FYx+kR0fBZCWAawVuO7lry0pOxjx2I5hm3ahJnJ2CsFwQhzqWNvUsJn0DFsqoNgFi/dGWgSso+t1b2/xml+lmxP2U8dZJdOApYqbNrXyC6dp5mjiP3BA4k5K20GBXkn8mQGobeht72PnMrjjQbobqshFXfkGbt1gIa3aSDtHrwqIwQ8C0LlRNVnB/Y3DOKB/Hvh6SPCQcji8i28zERvaQazn6/2klgX4MV5T9S3ROXg2Oeyvc3+iESDwN/UjbXNFzCVQmQFIFUmM8w2s6cFH4hqTHuClNLYBiUlZ+u0PwL+HQ8wHoR/wcngn+VFIAjrFt4HvKrdxcCiW+2xDpSccdMxK8Ah+1V37+X/H7Yvrf9Yr5XxCq4SdZUAyrH5nS9tiUFbpbiDVt0qNPW61AhHLgtf2g0HmJlcNRfOtzV1YUP+S80dFeYzDUMo0PHn8/HFn2IWjflMkrxdPyRoVg7ZH+V7aptGAIo93WNeU66Tt8S0//+SC+SrD/0Z5ttorfZ8dnVzbQWslfBuJ9qy60lJ8CNFfs9TU1Gcj570QTPqcX7yMZ4YgAxm2snE3BUawdD3rkRqVEbNVc4VIN8pKfCqiDPvtzu9d6eVLGBDT1+9qJJAa5/czK2IZ1B4San+NNMsXocQPqpwEjT2e8W33nsaeQVkC5m22ROBC9KSTigI9b993WI2RxkpTBZ6+/TZR/+t7+fJ+BmtEHZOu3Xvw==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(6666004)(478600001)(36860700001)(86362001)(82740400003)(81166007)(356005)(8936002)(6916009)(316002)(2616005)(83380400001)(107886003)(6266002)(426003)(336012)(26005)(2906002)(36756003)(70206006)(4326008)(8676002)(41300700001)(54906003)(42186006)(44832011)(70586007)(5660300002)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 07:45:22.3126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1d4149-2c80-492f-d003-08dbc0c0092f
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6706
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to allow host caps to be changed dynamically via debugfs, so for
these to have an effect, ensure that the card type reselection is always
applied even if the card is old.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/mmc/core/mmc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 89cd48fcec79..d372e2098ffc 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -419,7 +419,6 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 
 	card->ext_csd.strobe_support = ext_csd[EXT_CSD_STROBE_SUPPORT];
 	card->ext_csd.raw_card_type = ext_csd[EXT_CSD_CARD_TYPE];
-	mmc_select_card_type(card);
 
 	card->ext_csd.raw_s_a_timeout = ext_csd[EXT_CSD_S_A_TIMEOUT];
 	card->ext_csd.raw_erase_timeout_mult =
@@ -1732,6 +1731,12 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		mmc_set_erase_size(card);
 	}
 
+	/*
+	 * Reselect the card type since host caps could have been changed when
+	 * debugging even if the card is not new.
+	 */
+	mmc_select_card_type(card);
+
 	/* Enable ERASE_GRP_DEF. This bit is lost after a reset or power off. */
 	if (card->ext_csd.rev >= 3) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,

-- 
2.34.1

