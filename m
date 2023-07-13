Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29884751C68
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbjGMI7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbjGMI7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:59:14 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2131.outbound.protection.outlook.com [40.107.215.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC6BE42
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:59:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8iNT035x1iG/n/2EEDWVVnurirdvXje6Mm1KVE7icz+EzE5Ovj01M5cLbVu0oKasAg+4GReE7RWNecqWRF14IBveTL7d2RykoqtXsy2w0N2tWxmpm9AcqkoT8vNZdM/k3SxGBCTCgmXW0b74aX1ShtKWJCeMO1r46ROMWcRVejwMI0eILk3UHqnRIOv69cVzeLYAO/N8s8yb88m/bBr5qkltOjX9W0SdM6iX3Q1uJVmkisPc/yHx6VyidI3y8gDqx4k2KawcnBEA3pqHVTQsHqBl7nge/jNTLS6U4r1Lt5IEuoK+OD9ftD2A/KDB83YpHA9DYSqLDkug30zhukFDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZybLNZ2lJsTIlCwv9OVrdRsv3EK7P64YMJwpUUL3gaA=;
 b=FdZUcOXWvgQohYUCduoqHLEprG+xxIsu03eTPVERMzzEn/LTSEPXi/KYil9qoMwhJ8exvSRbcsJIzUYaKDJ+tTCDs7GmFZBD3AaUunBEon9aRVuzLIGuCNoSKkNUJZ5Rl4oWtlekO6FQiQ5uBSxE67aOhDkICtd41wSlO8UAXMZ2j53eO9Il/bZDYMBLRCM5x7BCPwoYZjUeyHoN8cJpMtMweOwq7U6rhaLSr24bYvBFtdmx39kerL8oXB1pQ+xIpc7+ngBLXP1vZa/pK6Oxm8FmkuOWAcdnNHpe3iHoLUVdCEmZMjnk9Jq8zd0O7QCNw8ZHzRc9fnAhDdgKXFRgLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZybLNZ2lJsTIlCwv9OVrdRsv3EK7P64YMJwpUUL3gaA=;
 b=Q8aedkKewLu08kC9EnjLT9OlZpX51OvHPy4JOJJgyvnDZICmGr+Eg+lC30urFoBvAiWyut8lFyvZIx1c+IajKJT7JwELrx7eHb1eOxak84D8R4MYOIch/UMPbcc0VaaKDKGynfAD5PRRWAE2KrhnB3oRT3XIRatVerV0quySRTBqzx7Kn1doBQdyo8+niS7TMGL9eHbADc0lEhE+JP0BMVE2O1JnbbiQTtb1wbbFE10wCt48vbI2W4JMqmagovSFFXIfwvuX66S+/8XEQdh9cC7cu7kISIAlI9mjr6FVX3b1laZ+Mm9ZHhfe2kAEGGAzT+e731BdaGDZ3FFb3jApUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 KL1PR0601MB4452.apcprd06.prod.outlook.com (2603:1096:820:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Thu, 13 Jul
 2023 08:59:08 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 08:59:08 +0000
From:   Wang Ming <machel@vivo.com>
To:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Wang Ming <machel@vivo.com>, Dan Carpenter <error27@gmail.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>, ntb@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, dan.carpenter@linaro.org
Subject: [PATCH v3]  ntb: Remove error checking for debugfs_create_dir()
Date:   Thu, 13 Jul 2023 16:56:06 +0800
Message-Id: <20230713085621.3380-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0233.apcprd06.prod.outlook.com
 (2603:1096:4:ac::17) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|KL1PR0601MB4452:EE_
X-MS-Office365-Filtering-Correlation-Id: 04db0f89-f25f-48a0-5987-08db837f6ab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l+HGcIUb63W2SRCEQ51V7DiScneIrKYyUo5yQWZTjEOU9do6KPw4Pq+DB94yh2PZS+Z8XSId/NfRVlsNnfsx184uGUCcRg/uFGM7eywKjIpjLi6brOXxclwBKesfZ1l7gMCGKiAYjiHLoSrJfhih4/4ol/qm9uKRoQB3pUO4Ncfj3HHo2zyxo6eMy1ClVt+HOBVZ/ghVSUd9wth5bF3obgCFsfxwFd8PDjcXKVfonGmpvRMfAzN3ONgO6dv7FxG1qcSy6MKJ0MwSt0L66FdBjrroYV7r/XINwaO1ls4lHqoouCSayeWy0ZcrhxWgkN9NIV5zvUATbqN6CrYsBRQZkwqTblzAEDhvjnRXdgpMV/y00KZxAZ3zmV/oKZezZfyEB9pbiYUMHOuxgg3VuJmExPOmiDeHuIjIR23QTpPhv9EjiP630vlkP4cQ16nVjWO8r/6svRv93xyq1g38fE7Be+AjaBpbWVnFjpf+smMdzrYcLPnDxRpRJWgqEPe4jWsSUDSWcVUrccGZOG6AmR2usWi2ivskNBP5Ald+9k8GNj+Rptvz44S1X7WzniiXQofot7efzHG+GoosEIsUtpDu6D4XFAvNbeoAJCihFjRLJI5s0l+OcqNwYO3G99T+TCiD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199021)(478600001)(4744005)(66946007)(110136005)(4326008)(2906002)(5660300002)(316002)(41300700001)(8676002)(8936002)(66556008)(66476007)(6512007)(6486002)(26005)(6506007)(1076003)(52116002)(38350700002)(38100700002)(186003)(83380400001)(2616005)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ki0jQA3hfBHfAYydaa8pmKLYC3lF7n5wZm3HxzlS2Kj/vfUOPjU9gPQOHonz?=
 =?us-ascii?Q?obCXunfHh+BY4J2IXbQ4v9acwvL1RSPXxj+I1BI/7UrFFTYlrd6zxyYU7uQ3?=
 =?us-ascii?Q?McLhu1hLShNt52lhyO9BVtNWcpWsm6AsKAyxqorsod2w1HbSxS78NStvQeEr?=
 =?us-ascii?Q?KfU4rdxvsUbCfCRv6LMao05gM5PNIseYSdY3Chdxkkd5TM4ti/Ydk6cAkEoQ?=
 =?us-ascii?Q?rdn0Utu++y8CZhHrqlwz1+De19W1aQQllES/ty4NnOothtjb7uCPedyJ6+/H?=
 =?us-ascii?Q?FPSQ0Hp1/qNhM9gldKrB7HR7Ap0DMwa/IWivLzZ0LxKPGjZL78lecOot4c1B?=
 =?us-ascii?Q?lOgte5PzJOzKLtOOP2uNaNnbjKbGfYFzj5WWhhlyel4305T8t/O9mTnDW5At?=
 =?us-ascii?Q?rQEucE5tPAMYAKyXrq/G/MJCwS8B/LerSk4L5V4EmBV2DsS9S2bJAe6KKSw6?=
 =?us-ascii?Q?MJhcmbmz6aWeKx8TzRIQftskT4KRs+X4/IgIyTKPvIOFh+JlC6iHO8zfsN6K?=
 =?us-ascii?Q?pGqMPUi7vZeAUH+JzWU5j6zqyDeXoiit44CZxO6VpvPWE/Tes0AX/omSkvMn?=
 =?us-ascii?Q?zZqLNcK96NpAGaR1VUDhnXNMUcne2uQJq6xRYxWoTbobtZf08YYFJIM5o3gw?=
 =?us-ascii?Q?ylHCAWvub6qfNdPyqdGZIvis3DZRsoTN9o1CBubQT10MQil1dT3Qcd7jzeYw?=
 =?us-ascii?Q?EqRvcQhTaKdvG8YJTKjyfp24vqd40jnYV3g1eNLAYoN3NoBOb0aNmZtWuU4y?=
 =?us-ascii?Q?+0MAbXoFew9Jdk5q4azBZqLOesHYGLdFy4a4k3dlNzQgl3Ph4W8vROo8MXrs?=
 =?us-ascii?Q?rV5VYYZl1cMj7fVmkXnOH3m8urAvAeiov9JOLsQ9rVb0/cIfUa1TOTZ1Wv5h?=
 =?us-ascii?Q?lHpxWEyhdYDl7QMXP5AQoZdGySjsKCrAYMK7Q02zirjFCnQABJraaYm9t/q5?=
 =?us-ascii?Q?DOFum3alp5CwJbjxQX+ejHRLdRk4XduzB5y8QdLFpH+m9IuVGn/j2cQ7ptyj?=
 =?us-ascii?Q?O2OiFmlNjllcODflGl92VbJd252WzRUDr0FD4S/RbM/cdNDkVz3VUS48Mrc3?=
 =?us-ascii?Q?N/tv1bkOk39Cmkea15LEtr558ZTY9hFLtoHDJMvEjAcNYx7KbORhoWcw46Z/?=
 =?us-ascii?Q?2mOqFPMITEY7ps9mXiHitxzeV3caaDWwC3SlvE5+anhSZr3NgDBgBzl9xJ7V?=
 =?us-ascii?Q?3lphlqESW1qyU8D9dBvbn7S/yGKbHiEXieSa0vZGipr4O2Tcov4LfyA9CY+0?=
 =?us-ascii?Q?ImJAsZfjnkIB4bxZfmVqVdrhIA7r2iPnpmjemn3W8MplGqQZi195gsoh1/ea?=
 =?us-ascii?Q?s+t4dDc5NZTBHfzSQCh+mmu7ADr/5G4MD5iPLnQhMvxcXb5UUVOzrNhJpXh2?=
 =?us-ascii?Q?MUA+PQkHo2M6r0YBLdF0gihSTZgn8qSfTyaHgXbwFr/sUw6TRcfW5OqSDVIx?=
 =?us-ascii?Q?LYsdumd+606TCFGi6sLyG4MH5xXRnW31mX5k5mnfClFMvLp2XFqsegnVkbyi?=
 =?us-ascii?Q?Lj7UIOHjES6+6tiWphjDwILpf4BR0esQBUgcAG8REfO4IuaeBrN45mSFztOR?=
 =?us-ascii?Q?oZX/o3FthHxovaPwEox8t58ylXLwls12hGQJ5hYO?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04db0f89-f25f-48a0-5987-08db837f6ab7
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:59:07.9606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RZ2IY5d7zRi8etEga2FSYieCoNyk/h5nVHUzSgwGKPiX6AIw4POJdWqPGCD4THxy3oA2poYsfGexP5NhlcRlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4452
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is expected that most callers should _ignore_ the errors
return by debugfs_create_dir() in tool_setup_dbgfs()

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/ntb/test/ntb_tool.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index eeeb4b1c97d2..e0acc11d29ba 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -1495,8 +1495,6 @@ static void tool_setup_dbgfs(struct tool_ctx *tc)
 
 	tc->dbgfs_dir = debugfs_create_dir(dev_name(&tc->ntb->dev),
 					   tool_dbgfs_topdir);
-	if (!tc->dbgfs_dir)
-		return;
 
 	debugfs_create_file("port", 0600, tc->dbgfs_dir,
 			    tc, &tool_port_fops);
-- 
2.25.1

