Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C302F7647B4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjG0HGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbjG0HFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:05:01 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2116.outbound.protection.outlook.com [40.107.117.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7DD3AB7;
        Thu, 27 Jul 2023 00:03:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIepKKW5ffVg2+rjDWZRDCIMjlajBrxFkZbA3aPzDUyeyY1sGEQkRQ4yccYhdfyWHDj0vE1x+4ODU4H6kA+RnUQu6o2Q+NP2eG6a6U9DjQ8xiYaLzTDrT0j49gWNOO+XC/HN8CKZ51nFa2FzSLVrIGir9taMhlUBnHEeA0eQGFSNZdl6iaeY8n8Cdgr5a2hvrP8uuvWh3ASIP2mQxODN9mDradL/HjVpTRn6hHURospG0MuRk9ZZqICV2E5skX0Bv66AdfsejwZ/oRuwC4bMEAwhMg5n6lAD/AE1ZtAEvRHVhBpNvgHwPpxG6YpSj3uHsI4Rn4/98OKCUTHtvQsNWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3SD+E/n9s8sf/g0RFwOgCc5gSVCSgDJcPQDwPUCPDE=;
 b=WybfvHKUgY3/dM8oKSdzMBgzZzsUZFc9bXX4LKustqcV0cddRKfhaiPcCsYeSwVDquCq1y5x23PEAEqtapz5msa5bZwgwi0Tonb8yl5cbwqKSFoWmIvrvM77ua8mBcUCMtxoAom0xwH08pBr8UY+O2wr4PkRXFU7C1Sdr9iUYpqYzwkSx0BWnYQi/sX9pP3d+5MXHgY5nvkBUPJN2hBvjonzPgZKRjlqK52ToXl3rc/vYJg0B4IhCu7S1CD5fviWjyu4uGaiLyFEgtGNOAbCAuBudUP5R3c5CVTuXy50HHWcCdIeT2LDuOhJ23kOT0Afdq+2fKoqRRXrdflPEFG5AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3SD+E/n9s8sf/g0RFwOgCc5gSVCSgDJcPQDwPUCPDE=;
 b=Vh8FaxLLmXx0omhy9WsMcjGQpZ4yOb9iMEDqh2K0yqpVG7Joka3etm4FFSGv5WQigdROTJDtokuSrT4M69It8L4ObfjJ2fwOKfpq106UbGU+YZiaefJ1lH2i7ZmbfI7gaC9GmdUMSGVfO95anTlz69D1vp5BP+MOy8I4g9k4uxkpL6/ciBUISf9MvjxLXT1rOaDFMpMtpsnKPHm4w2HLYzxADo2TmIyA3mcJ8oG265BPBbfXX+I9cpw4hj2rGmYKqTueCQXKmSpKqkWKnddICwXeN3A/j5LEYMFakDAI4s2aJCEeETS/ln9YOw+3iR/uBdw25mxGDQCvx/waeC3f6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6027.apcprd06.prod.outlook.com (2603:1096:400:351::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:01:55 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:01:55 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Andrew Jeffery <andrew@aj.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joel Stanley <joel@jms.id.au>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 32/62] mmc: sdhci-of-aspeed: remove unneeded variables
Date:   Thu, 27 Jul 2023 15:00:21 +0800
Message-Id: <20230727070051.17778-32-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230727070051.17778-1-frank.li@vivo.com>
References: <20230727070051.17778-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYUPR06MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: e71f6839-8742-445a-019b-08db8e6f5cbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i2qcdyt+7+uDuRoRHKe0bl1DKPxmgQ0GLcc587BOjIsazpDPKfFWRvP7GPjQzUMDpCfa9U9is5XabFGGRTHhnn1jNNyGr3x7OGcqEYirZz71/syvYt230QjzedZnzX08QReHUF/+UWs6K0sn7sper5dQUHxxcj+2PgdnhXnZmB2LSb1DQrIOw1kXS1GpXFcKYBE79oBhsvdDFgGs6Jy3H+s0NlKeUDbnthum8rmungHQEQ7xvonSuu4lYOXXjHsR5Hg31EM+vutnP8d3J2G6OynIQZTnQfXIKlN7swBzMu9GoFo/gbCNOB2sa6fh9oMmS/pVOxvl8QEfJ73Rx8Tzr6syGOcTXXKTk7oDbHySD8fUgopM+TxQEmFPNtZRQiACrAtSKrqAuDPkqzb5gtlV/cOrYC846eVCCYdZVZaXZn0VDufhbU8YRGW/wrD87w5TekHeYxBvpGonWLXaDNEL08fkBD7BTrjpq12OAowQPkwrnU7brwqcREFAWAWckw77EES64VkZvGMTzs2Vc4FG9dYRXrsh4eE9+BP3EGr4KAMMNhCUNS0rXUvlAuA+4WhD38VLzwCdJSsj0iH/tTHfdKVAGf1/Oa80hze6df2O5azSeDIlRjNWwG2ziTFkefvW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(2906002)(4744005)(1076003)(6506007)(26005)(186003)(86362001)(316002)(38350700002)(38100700002)(2616005)(83380400001)(5660300002)(66946007)(41300700001)(66556008)(66476007)(8676002)(36756003)(8936002)(7416002)(52116002)(110136005)(6512007)(6666004)(4326008)(6486002)(478600001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nnd0MEQ4ekJrMVlhblhNQk9JcU5WOEc4T0dDMENOQ0s4dk5VaEdaajlSMGpO?=
 =?utf-8?B?NldtYnVXTHJIZVJadkorQlp6blU2NVJNVHY0eDJ5RFFYeEhqQmZHNWM4U2lt?=
 =?utf-8?B?aVVpWXZTSzVPT0dCYm0zcklKWWJLR2JmQ0RpSk1qZzlMVnhYQ0dQODMwb3dE?=
 =?utf-8?B?T2JUa0htT1BTOFFLRFNzVm1vVEdNUy9oUFF6WUtrb1IwYnpwMzlKQWJvWmlh?=
 =?utf-8?B?bERTcjhtRldLMldoQUh6aDNtTUptZitUWEpJTWlPcGR0NGw3blVoR1o2ZUVv?=
 =?utf-8?B?em1mVWRiUjR0VFk1VkxLMHdlYkorRW43L0tCcTEwVCtWR1BrVG5lVzczUzF2?=
 =?utf-8?B?dnpoRWxpR0ZyYnhCb2JHZjU1cUZUeld5ZXE5cVRSRVROeW56emFKdlhJNHlB?=
 =?utf-8?B?WXVxWTZrajdpaW9jWCtSbWhpbTR6RUZWMklTTUpyejJTYklWdlc5RVB3WmdL?=
 =?utf-8?B?OGlRakIwQkxHZlJEdHpkbm9pYytaTUVvUHUvU0FFN21QNEN2WFlDRVRCTU9n?=
 =?utf-8?B?eXdDY2thNmM3TGkvT1lQaE9LSVM0cWcxbmFiOU1jVTNLbGVObm1KT2RVQXRB?=
 =?utf-8?B?NisvNE5RTVJMSUdHWWpVdHprWjNEV0h1eFRnejYrWWg4d3BQakJsOGFTd2ow?=
 =?utf-8?B?aWlkeTl4RGt1MithTlRadllZY0EzSE1RRmNLMUNxYWh6R08vZEFWa3RDQ1d6?=
 =?utf-8?B?NjlrdWtidTFPWkk0VVNkU3hOdmwzU04xbm8zaTIrc3BOVzJ4T0R0a1p6a1VQ?=
 =?utf-8?B?ajN6cEJmYlduOTZaTjZsdkFCOXpENHVDL01sZ2JnN3FURFFjczlKanNBTGVJ?=
 =?utf-8?B?NXNHUGx6VVREcG1uaDFOamlZM1FxTkFDZ20zUHNoMFF5dU5VRmlhV1VUcDk4?=
 =?utf-8?B?Q09kbDY0ZDdmQUdSeVJ6SGN6cmtXRCttUGVPck9MUXVYTmZoZzNvSUxaRW82?=
 =?utf-8?B?d0psOCs1T1l4NFVCVjJLYThWUVRCYllNbjQ2ZzBjRTA2NEZNQ2xHSllkcEph?=
 =?utf-8?B?c0w1YlcvUkx1Sm5Oa3RVeUxkcDdxMUFzQ1QzZTkvQVJaTXpmamZDbTF2QW02?=
 =?utf-8?B?V3VTRk1mVmVEMjFIWWFxeDBpWTdjalJ2cjArUGNTNFByQzNIV3o5anJRU2xE?=
 =?utf-8?B?MUs4bGg1MHJSVHJaYjVzWXVKL1B1QUJ4Q0x3VkpvcHZkQ3daK25WWjJJN01U?=
 =?utf-8?B?Q045RU5zTGxpZmMzbjVmRTA2SXRMYkhVQjlvblh0N3JSd1pWbVM0NHU2NUdk?=
 =?utf-8?B?ZzdteENlM200TXNpMDY3ZTExcTl0QzJyUzlHKzk2Q3lpRTRGVzQ4ZnRKMGVP?=
 =?utf-8?B?K09MOG5aTXRBcmwwUEpmWThpbnNiNjdOczFmNGphaUVVazIvR3dLRWIrSFFN?=
 =?utf-8?B?blhuUFl4UC9XSnk0S2tNQjVURm1oTUtEdGdoa29ObjRnSStwS09VTVF6MUhD?=
 =?utf-8?B?dC9xOGdiNCs2bEdOTHB4TDlHQ2NNaGphU0diNmJ1RkNIM0lWekVqc1VYQitp?=
 =?utf-8?B?clpDQmxwRjJZSjZ2TnRtNG1JOXZPMWtia1VKRGVONTRma0d5K0E4TkVJYjNm?=
 =?utf-8?B?Ujl0K09IUTBEMHcydUhPQkhILzliRDNKQlNiT0UrVFRqWVNDcDRkcjZoSFAy?=
 =?utf-8?B?RFVFeGRPclFzemN0NFZQUnU2M0l2N0tpelBqUm5XczdLOGJRbi9GdU1DVlg0?=
 =?utf-8?B?RVJaUkxadVJCMVBjT3d6ZnVkTTlUWlpub2s0UEIybDcvSTJ5dDNvT2hXQzB0?=
 =?utf-8?B?aEc5TjhZSzlncjQ0S3B0WjVsWm5jN3NFQVRQZDltbC9wbnp0REozUXFwTnZ4?=
 =?utf-8?B?L3BqZmRLeURucGJKck0zOFM4K0pnNlRScVZLRXBSeVlFNXQwbG9YSFlzQ2xF?=
 =?utf-8?B?NVVWWkJiWjc4QzQ1NjRNUTJ5U3VlM1MyK25tcmhUYlFMMVc3aWRHR2Q3SXJK?=
 =?utf-8?B?eTVuRnB5VW1kSHVOWkE3VHJuTTA2UjdlN09OV05od0lhSlcyVkZYUUdncksr?=
 =?utf-8?B?WmR3WWo5ZGk3UlJoZGlYZm9qT1VRM0MvdzlINlc5RXgzSmNOdVE2d2xRdWhm?=
 =?utf-8?B?MnQ2K21IeUxNb0l6eXNobElYQWVUWlIwWUFET2FIV0pTZ3E5VVU4SlA5Y0pv?=
 =?utf-8?Q?LaH1sreGouOp4PiJwTrre9Fqj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71f6839-8742-445a-019b-08db8e6f5cbe
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:01:55.3464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HY71Aw5OcZfZvwInE9Icw1LX2f7E51TUpmeQgS7GNysTKxtZwzBEr4LcW7Dj8DlBKIIsRhC2QmCu9kiCS79T2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'dead' is redundant, let's remove it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
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

