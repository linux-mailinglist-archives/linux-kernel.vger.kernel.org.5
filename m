Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CA8760655
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 05:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjGYDHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 23:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjGYDGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 23:06:45 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2099.outbound.protection.outlook.com [40.107.117.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E9F1BC0;
        Mon, 24 Jul 2023 20:06:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHw4lEI8i3SFQwVfdHy36Ct6dWyDWZxJ6eUzdyShgfa2JJKCD0H6R1hns1LhfimXLI3q8UtqlP5sznzKvJtUcENrAXNaCoEqIz3BB9HE+wfExYhUOujo/d98/JQYagCnx0EEtWuefZccNIU6YQKzwm9GGaZwdqam1BaD2V1VKL+ie+wIuQqZVZTX02fa9ZKO79roaJvPw6/daFWS0Qs8ZA140oaR64/SxEEFC/1jjS95Qu4ascHkkjSt8SSezpoClN8CxOsyuXwRMiKc+2YAYGcrs19tuQ9UrHh2l1E+eSuc+w303TVjeFKQaTzTa/xXmkGOu58hqZSbZJo7edyeYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnjHj/K3ARr9yYIpaJTnsi1Gvp0PwUDHuiEUCJ3kUx4=;
 b=Kxbe2fleGQzmxb9AAVX7rIpE8UgCnZ17+le7VQTuNUBnh5aeLOUvxG+NTKYjvMEWtkjAfzUNSF2lkrt0XSFSijwOPGbxysvq52o5FDwO9FQ+INiVyMC9mB0rIDijBa7/noJB3cMe3qXNKFSlgIkNNrjY4H1B26JSuqnK2m8sVUvVmzt0UVxMuh5lhhz4YtXP8MF8wD+K29Q+4wzjFpxElTA562mVC3e0sOKfWY+6XGziFOttS06nZkngW6FZhInLw/cvGsP3C/7KV2lCWV4P/bFDtiRuqDTsLXDVGWyBZVv+AmzB1HYvFfLotE39VJncWPPfuTVur5RGRIpanK9CEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnjHj/K3ARr9yYIpaJTnsi1Gvp0PwUDHuiEUCJ3kUx4=;
 b=l7xHZq8BhAblh4mQxmPXGShon/bgWD4gV9gF11RSbpmmEmecLS8KijUCIajkALlXNygHRLlAtAfRk/OTGaqY3xvpfLYyjyn/CXp4r3JkSjlBNVKbeUCVXHaithZ5lHTDWWxc9+njwtOPUD3HEYAM8+b0c5fUKLXdF2fBoN0s0/wBS/lfXVrzsD/5GlE/3g/E6+6dvmerzsz8E2btmAAOqCYTTg+ZY0lXOZwCKp78Bb2EW3r31PxJKVZMKgRekkaqY8cukoF/RTVOGxb6QuUZCqseqX+vlObkzxs+2+BvoNPYR6tQCMOsQRlKH4ltZbGQ3kqxAuTkOyjBlffn1o2J/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 PUZPR06MB4602.apcprd06.prod.outlook.com (2603:1096:301:a6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.33; Tue, 25 Jul 2023 03:06:38 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::75ed:803d:aa0a:703f]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::75ed:803d:aa0a:703f%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 03:06:38 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Viresh Kumar <vireshk@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-ide@vger.kernel.org (open list:LIBATA PATA ARASAN COMPACT FLASH
        CONTROLLER), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v5] ata: pata_arasan_cf: Use dev_err_probe() instead dev_err() in data_xfer()
Date:   Tue, 25 Jul 2023 11:06:25 +0800
Message-Id: <20230725030627.1103-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:404:e2::20) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|PUZPR06MB4602:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f2af69a-e668-47ef-56f7-08db8cbc2954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DHi/BbMn1hlQ5qGDYJF7oBUkXSVt+CzxTLdN+ah6NSUIjUkXpFh+6vxew3EXafw8HSyQjl9M1M/MKShfK3aGH8WeUSiuRSHT9+a8/RPcDaxE8mog3MnikZp5AxKVg+mrhxQgt7Gf4nB38Vg656W2IWdbyIfeuRB4S06ThJ4rGN1EGQROTCYcXxlxjp96IxKInAgE+elV4q2R7eIlCGGI6EYpgc2jV/A38jqh8XJmx0bOd7XeHg0x/4sp2U8RDqWEXpn76CkmTUmrzrGfbs+u2NJCwGvh72hzIhdhe2yYm6ZLrPyIffqifzhbEpI8Kt18L528FY437dHXKNr8iAYVtX4ey2jgsDUwQpnN/ZBRpnka6SmkJ/2E21siypQuckxNeGJVrlUBx3ifApH69MrzCmrrjfmly46U0e2plSl+wEu6AilYVpRnwg7dLQWDn6WpE6KXDOaTAGEbdKTL96AmPZhVdFTtwAN7POC+iaI/ML2KjqMoimgxJ6O7b91dPep6jduWULUOyPZ6YTIT6dUUsYj4fA6HTl8UkgKYEXhf2A9G1EmYa48AaE10MZYkfskFLyrTXgn7LtJrS2bjW0ae8Z22c8qpALkg+ivgNX4y6Q194NT5K46GsAZA9DLxyAvs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199021)(66476007)(66556008)(66946007)(2616005)(36756003)(83380400001)(86362001)(38350700002)(38100700002)(478600001)(110136005)(186003)(6506007)(6486002)(6512007)(52116002)(107886003)(26005)(1076003)(6666004)(4744005)(2906002)(41300700001)(5660300002)(316002)(4326008)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LnsQ/eAWcITzPU9ts+WUGeKqcpDwRkm6ycDLKL38mIMbKKdQ1OSF1YBm7VkG?=
 =?us-ascii?Q?pnCtjtn4LdJROJdEZotqmZNIqirGEFL1TSEcREY8jrg1MlJZz9DHH5LlmZxL?=
 =?us-ascii?Q?CCrJg/7RRZ3WyAtKKfkRPxqLRQHXdg1XP78RSdcG1sL9eUYGpy76S3vou1R4?=
 =?us-ascii?Q?LKQydVdx3iaY+oLlu7IpGMpvgvhFh2EnHIvObC8uUxCbU6FlbtyamUTSj2D2?=
 =?us-ascii?Q?uWo5GMZf3qEUN4YIe2K7FXq1uDYh0OWBO4DJvlslIG0oG2VOmPEQpJr92D2Q?=
 =?us-ascii?Q?xtbuKxFcaYBl1EklJZmJ635Blw2P0UmvZCmX7Sgvo22v6FnZh5BTRWdbVm68?=
 =?us-ascii?Q?iZMjpvqZz9hdcRFtz/loDoVKK42c28froNSakxW7pALN3Kun1sLq7dRp2bsM?=
 =?us-ascii?Q?zc/XWmZSil2qzoQML7NYs2WU59UNG/aUuN0o2f2Pd9tc6BHa11kr/OhOw5GI?=
 =?us-ascii?Q?hENMzJzTuEnBWSYZ/1wbCVLTxoRa9rAxCLutYxbrD+PM1KMa4iLXN2YRreIb?=
 =?us-ascii?Q?Woz8QSBjsjL6toREqhPsDjXhjg5DPPnxfrURgy02ywxfzCg+W8RocDzOD5MG?=
 =?us-ascii?Q?6MYtoa71exmZJ9c2XWA6C1UhxhjLt86mluHkmK8j8931TB1O6X1CPCrRCp2Q?=
 =?us-ascii?Q?h4xbFsYB5bYHJCu2JNc3DfH4WC++9OPOVRe7omuuNsPsr6MiZLhkUb37Q8F1?=
 =?us-ascii?Q?DYPYeXH8l4pg3FTjNmpLM1+xvUaOrNbHirtz6leD2RVhPrt6PUrQIWN7eV45?=
 =?us-ascii?Q?fdRIbpLpnL/xDKJBBeSrSnKQ6bOFN/EYRgVQvVqbnO1sPhYHFx54XWBrI0mO?=
 =?us-ascii?Q?H0Amc9sw8C71MKQ8yCIGTxtR57Lhf865Qzf2sfoHx6066tTOzoPDWoEtFBlf?=
 =?us-ascii?Q?jtTP1Tmhtb/UGaobanT/K3ufB0yhjMlr3DkDaXh+pesoKqQmztnAXyWuvOwx?=
 =?us-ascii?Q?cwEmXmgwPIuEPPNmLexsMc28lhY3/XQrN1beNhlMuwbo9YTlghe7S0L/tXnZ?=
 =?us-ascii?Q?tx5IsJPax1MnVbHl24a99r7+YnitPINgI9TlxMgyLnRnlTcGgVMJtgiW16x3?=
 =?us-ascii?Q?2DEULG+5Ji35fcLqH/4Lr+ca5bD4BBKy/M2lxv8XNEi42yK9V3vbcJz9py9q?=
 =?us-ascii?Q?qyDwVkrrRoANOdJ13jKxoYv8gnenjfLYjCDXCZwZkBHgs279RLTgr2K5aPs7?=
 =?us-ascii?Q?G9hM9tXI8pxVVXiSKE2XDFkaN0Gl/It7gzau8SoVdGFMTJHh4mNJed0vcUON?=
 =?us-ascii?Q?+F2cS65qJpOmo/GGaKMdMeOCA9DDweo29xermQdHt6EsEcTBDY0jqAeFyxFq?=
 =?us-ascii?Q?l0W72zsiNcVBzDgJ7NEHWkkuj7ZmPsHPL5qi/9otZ3oLsafR8bsPFrQZKZct?=
 =?us-ascii?Q?BYYt1GRDiUeMkNOb5kA2SLStqJpbLFdqumxkzwvdIjHgwWtb1ROBQPoL6Mnt?=
 =?us-ascii?Q?km+Bm31uaXPcAWd/277oqz6QyknXx6NCU/ZHZT/2xYpIfJwYc/4kn6HvXOut?=
 =?us-ascii?Q?EKztlaw3BV2Pyrd7+/zEqDUt58M3zNNjGe8BmKKW6B+R+sraBKCJAv+BH3ja?=
 =?us-ascii?Q?fn84PT6Zu5TUegngcMrtG8HEjP46fxP9ZmO/P6el?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2af69a-e668-47ef-56f7-08db8cbc2954
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 03:06:38.0705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boh0fMjlP5FhQhwgl9C+ZopSFj7IZ+9bDLBM6Grze+tQ6WFrJh1EXqsZFQ96sHinuiX9gybSAQLWr1ddvWI2WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB4602
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible for dma_request_chan() to return EPROBE_DEFER, which means
acdev->host->dev is not ready yet.
At this point dev_err() will have no output.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
V2 -> V5: Fixed code formatting errors.
---
 drivers/ata/pata_arasan_cf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index 6ab294322e79..b32d47112c0a 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -529,7 +529,8 @@ static void data_xfer(struct work_struct *work)
 	/* dma_request_channel may sleep, so calling from process context */
 	acdev->dma_chan = dma_request_chan(acdev->host->dev, "data");
 	if (IS_ERR(acdev->dma_chan)) {
-		dev_err(acdev->host->dev, "Unable to get dma_chan\n");
+		dev_err_probe(acdev->host->dev, PTR_ERR(acdev->dma_chan),
+			      "Unable to get dma_chan\n");
 		acdev->dma_chan = NULL;
 		goto chan_request_fail;
 	}
-- 
2.39.0

