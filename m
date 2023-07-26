Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C99E7629DF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjGZEF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjGZEE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:04:57 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2133.outbound.protection.outlook.com [40.107.215.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501FD268E;
        Tue, 25 Jul 2023 21:02:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NViTL0bx+Opwo1OhmsO4amyLJzeyGnJH3vnAi27l2HuGZVmwOk5Lm447HWX/vUA74jUyczquOlo6uZndk2qY6eX+m2jEfCk3oiFTSNDr6jiA72TxVBLXl2oM7+ZJA3KsyamM8Xo8Xg03KaUYu54KRMpQvjPcQN4p+Jj4ArFLgtl2AY/dbxV685YHHyVvVgfZNJFMTRELEaacz+6Ja0FQRON8axDQSvL6qUUqvRw7c0g4jJTf8JyvBg6X7vcaootPdjlZiRigO1HO7OwLYPYkd4axiAHRDa8NY8rUFd2ZWajWmOMGXXPYITj/MAcPl2jPfj1SXTKN+IIXP47ItZPW8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoA9//5kHHjTZWZjeepbfNiubEEEDDWamxoqqTR60BI=;
 b=J8JaQw9Knj4YM2Jeui02azWhofCFqaoWSwrqaRPejSb1Tn3UkMt3zBvWbbzf1sd1XlgEiLU8xBfyYLBs4IcY2enss+myJPqK5XJmDHPmIPty/7UhwRlbtZ5WsBOms3LZSMbbLlL1+dNj9buo7YOz+ZA9zrrRAzxSHKTQrO6vfW5K8TmuLO5DpwlzoIfvJlySaQxJTcglqLTGrIjMEBTcHgtUwKXBIKX+YPM7uYk/cGfwcy0d2qNZJxM6/5Nm3ETD9k2Es+0xrw+8T5i1iUV8mI/fNyVDWMsXJFesqifQR3JGbgeu7g+qi2ugaejx5TBaYAGQUFLIYiK7/JYCIGXOrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoA9//5kHHjTZWZjeepbfNiubEEEDDWamxoqqTR60BI=;
 b=Y+RlYzyujhBusf25BSQI5W/2vDTLL0YxmlLJLXQ5JRA5hrPPypyk0q6i7XFbUGD5Q4QojwPI2SbIJCXM3w3J/bCY4smoQ6psY14G0f+6xGFUYAi6JvZzuPbh05tGUgImFwlfxwMrnToSd6m2FgYgbDxbNDPSocaRpjX9DaGy4uIE221Y8DrTlkUjFvg4PLwiXmtx+O8dfIVQzmNwu9X1aSbxIpF92oZ23WHoBpgS3LMURY1ZBlR0hGEFzp5u4nn9nSBxeGQ7qlfUK38wQUhWV2iO/L9Vg9F1KN90p0tnHgDxZAyzzMNVu4+vNKKrNPLfMrq1SNjN/O6AcLY9HA4Jpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5463.apcprd06.prod.outlook.com (2603:1096:820:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 04:02:22 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 04:02:22 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joel Stanley <joel@jms.id.au>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 33/61] mmc: sdhci-of-aspeed: remove unneeded variables
Date:   Wed, 26 Jul 2023 12:00:13 +0800
Message-Id: <20230726040041.26267-33-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230726040041.26267-1-frank.li@vivo.com>
References: <20230726040041.26267-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5463:EE_
X-MS-Office365-Filtering-Correlation-Id: 04768a4e-f160-4414-c11a-08db8d8d0cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n6jMPVaF8l+qYUI86EW0hbdtamj7x9YYUA2em50Ww+gYGOmblsRzIp7Ne3VBf1K7rvshuxA0i0DYxgjTFheH54WtAnl63fKn2KL+WNW2baXQux93k56vxHtsV8dBYm9iPfjzizmLdbJmxA8LGIO3ZRb9EEykNAj6kB0L3PJE/PyVyk6R8HSOGwImSJlEPLJrp/QqV9yYEgN7C/6BZcza7xJKx93Wl/ZAsgFu71EXMKuPhLJUlF/jTPeVXf60Auqj+tRO/94L87PkCrf7bniycCFQfabC5fT6IOq45yikg9rNfvhzEKg/oFV3A9bnVt24g9c806+Vs3DhgkQIWWS1nUR++NrLe8mC6wR0Sawt9iYdLutDuoiMiVDt6yh2P71tuJDQoo0jLKNhcY9cSOfPZEQmj/tkZSr1/QB6t7MuEpZoEtHejrynTVzMNWOvQT5pvBOhvPfD1KjpOsG/Lm9k5o43EHX7ng/HUbsYLu8T6KWAXqBt3CTi9mC4+WR6/uubgVv6ocQDC3UAcs8JxPslku5boPaIeqgYJvpCbZyb5LJ5HvcgExM6o4Z9iXQytODGGyAVfxjH2V0eK1fT99D2n5sdHmXFmlFywx8do5vZg96hQ0mQeYh1uVwbQLDBfwiE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(38350700002)(6512007)(38100700002)(52116002)(6486002)(6666004)(478600001)(41300700001)(5660300002)(2616005)(8936002)(8676002)(66556008)(4326008)(66476007)(66946007)(316002)(186003)(83380400001)(6506007)(26005)(1076003)(86362001)(4744005)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ySiMMvKQq1lNIHu5yDNHKuT7lvcme/+vpzsz65JJojYuaA1li7jbp7tvI6HQ?=
 =?us-ascii?Q?8Z/ykk3oSETDZ/bNm4QMaMJRdkmJtcHnuQjNYXNkI962VLGJne/ijtWnt+1m?=
 =?us-ascii?Q?NYqKsoyK/yryqF6/GfV/kgVcr51UOoAhwpGh9W2JPszOP+UdJDvPUej1sxll?=
 =?us-ascii?Q?3D0VMRgTHM42N7ei8bjURLNMf/Ca4HEtKdgRrOZ4J/Pqw1u0rafxGZELIlvo?=
 =?us-ascii?Q?vLwWjXFN1e3tTq0yKJ9sSwxZ6PRTPFqK1lEbmWs0P+c46+Ph4WHreHn2kem8?=
 =?us-ascii?Q?flsqJr77NSy/ZicVyNkkazWa8D13AJyWp0T46HO0PMygl+6LmwBNwvWBiw8j?=
 =?us-ascii?Q?SNzbK9BMXsftTpOtGlCpr3T6hfF6u3N1ShWbnsfJiKqKovxuI75JHvT2GT4p?=
 =?us-ascii?Q?3egJah34W+PCELm5gXUCVFFBZ2iN9iNLamV0awn5mUCK3RDRqhNSB6NMNouN?=
 =?us-ascii?Q?scc9XD8R94R9yJNU5efHbvcyIoNi4BFOSGTUwGy/Zs3NdWGq+8qLc9Y7JLD2?=
 =?us-ascii?Q?k0FZxzaE8nTpap33PxMLsxUTeG7BouqtfRbDAPkjd5T+Krlm+JpHNS0+VN/m?=
 =?us-ascii?Q?1cPjBXILHudltKCBnEqxoax9gNhkmn3sFOYR/8DjVBhxuV07pLRvXew/SmWZ?=
 =?us-ascii?Q?FsOHoLdxRmBU1CYhfOMOhwW21DV8Mahpbyd+p7Vio1idqVykGS15yQtlBuhs?=
 =?us-ascii?Q?Fe0+CHjQsh8M/m9aVf8X1yzrCOL4QaE29QFT+RehEWDa9yGo25DBa+MesC0e?=
 =?us-ascii?Q?bPLyq6M3i09wXhPaoLm6uiSRZtl5PUZ4SsP2RCdWV82D7BksIoR/TwLz3DXl?=
 =?us-ascii?Q?DUCxpfzGoC3AN2jSYWUbsThS+qu3TF+zmpZKLgfD4LmKJBuwSzV5a7P0TfI2?=
 =?us-ascii?Q?lkzglwziSxGHoBQZsLI62U3KluFgJcARVQi7204/uhNMgoeS9CtkdePKyU9S?=
 =?us-ascii?Q?9k86+GY4TSoXgePax16uBEtbJSsYl6UT/3cL8t3WvpN/+ggpQjCbfuXqLe6H?=
 =?us-ascii?Q?nj5xIkI5FHnGdC0HFw1J5QZUVraEkihzoKqNlvndAmPQMkmWWCnJlDrjhioy?=
 =?us-ascii?Q?L5kh0HmQb1iJGL7k0wQCWjAMh0/nVXTymXdyHGujRLK8ahHIiHHkRgkRbbj7?=
 =?us-ascii?Q?nw8yau6MIC1NwJTJCa4O58iVn5LTkptku6t7j/GyIBA3xOaSMcowa90lnl//?=
 =?us-ascii?Q?VP/BK6JPfWeeFAoGgQKW6W5SvNw25QmgraMSC8pfBBZsu3LPAXFuBPn4QPKY?=
 =?us-ascii?Q?U5KHviYylZdVr+cgyPiQzTutGdhLat8uasUCOdVpbBeMAtY9fystJNXHoZjP?=
 =?us-ascii?Q?59IZEbnJJrVRUDcYtKtp6HWPh/UWCQ5m/Hvg3MZyEh8an/qbZmoRE+YuS7nv?=
 =?us-ascii?Q?HXgkMR2s8CzJepPsyqwh6XhlYaM44Obj1UTv+1oF8367p3xGdDRzAjx0w/iH?=
 =?us-ascii?Q?Es7vh1cIqP0bEvWRS3yoizjpOIlgh0c2G85jLurSHJ/yLXVt4IuUkP+OUHo/?=
 =?us-ascii?Q?mtq5xY6tBXh+D0SFdytNRwK4Gs3VzCPM6DgV/4Kew2qLWYeWeOPrLT8T45H1?=
 =?us-ascii?Q?N1BhXM+cYyMeXO3OfZ1pwH+1hxpG2Q8nRUGaVSCP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04768a4e-f160-4414-c11a-08db8d8d0cdf
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 04:01:55.1175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMux5BcvO6rt5Jc0VYq5LQvVzTOk9FFr7OPfrGvPAaDBZ43aQHSeCP2ycZEe8w0dNevu6MIoWsIgo53mTnm0+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5463
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'dead' is redundant, let's remove it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 25b4073f698b..b4867bb4a564 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -454,12 +454,11 @@ static int aspeed_sdhci_remove(struct platform_device *pdev)
 {
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_host *host;
-	int dead = 0;
 
 	host = platform_get_drvdata(pdev);
 	pltfm_host = sdhci_priv(host);
 
-	sdhci_remove_host(host, dead);
+	sdhci_remove_host(host, 0);
 
 	clk_disable_unprepare(pltfm_host->clk);
 
-- 
2.39.0

