Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA507647EC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjG0HJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbjG0HIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:08:07 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20729.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483D949F1;
        Thu, 27 Jul 2023 00:04:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbQQQaYStS58XllNgeQCaxdx4vROErkz53nGfYWsrEeuP1SkLjzPZbAqTJdNGa/6LIKPUii7wYhA7lr7UhoX2Bi9HnG9i0cg+re81akr0sgJ6Gf9vPLp4Zc4AQjxz/quwvPMJD7F8hw1nUCU689H71CN2lNILxVMH7AAIC4kDvrUoUplQJ9PR5EYD+TjdCy4WyY15OGVQA5ynF4AvnTo+hb+xUq38vJnl8vN1HJxtFp2hUYRbci0VWYfTf91tmmsrAkmRVxHV6U0yEU5BZJD0VTtm0j+xXksdJ9EI9PaoysXwkrfBN/yDWVIiblyxp6m/djI9ZQadPSIcAiZwrP7fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcT8TsOkXmzzeka/1/dQjq/N2WSLPScPPwSFO+0rVvg=;
 b=K1fZor3LkXUrntte7wl+yZoohfAo93iDfuaTVS4Shrf/f6NM2YAjzN2tmMmb7ztJTXHPtDRYmscAPMQcw6Z1KkCaYci5R13dbKCpWxIW7/nrzQA97TxsKng4bSwbsDwT8k1WOxLSyLG8Qb23iVbGn020n/DbzGIEQYas85NKTgOiIXa7gvDyhb3P3gm/pJTFLCn0XLos913JEKp6pEXKOG62aVYXVhkvXcByxOixJdvN7LBqUwb/C7BGUDwqgVLF0xrqJjVQj8vwWMXG57Z8ZpbgFgEpz1it19+Ni9oaciZRcprg6Zu1pGmfX0kMaY9+Ofu9VYbexKfpx+QLcZd+HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcT8TsOkXmzzeka/1/dQjq/N2WSLPScPPwSFO+0rVvg=;
 b=p9l/2P6hQqbl8nYoOozhlE5vQAg1coQmP9S6mx3mu9PfXODEEXQWzuDiRRfqTJnn0qNIosRiFFTjsWGCJ+/GGA9vDSp3+isQL3HnwV9nSZ5ThEq7fM9oYlmHp6retqMnfhkFimhoFMkMi3rCLa1oMFKeGdstjc5s+CHv/iy+B/kuz347LFqV9VbfTMrGpPTGRd1iyPAzD7o6ltMRqHH46rN811xHuM5ChjqgIO5A9EM9Vqsc8pgR/Jr1z8U0KnigR9AlT495cwbnyuVg3eBXd2EfIIZrkW/7hPUEI1NnYwXSfJbhXZrRoXm8AaqCSAZEzjgV5laNOVNZ9jw/NNPbmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PSAPR06MB4152.apcprd06.prod.outlook.com (2603:1096:301:34::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:02:48 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:02:48 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 62/62] mmc: f-sdh30: fix order of function calls in sdhci_f_sdh30_remove
Date:   Thu, 27 Jul 2023 15:00:51 +0800
Message-Id: <20230727070051.17778-62-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PSAPR06MB4152:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d192c5-ce8a-4ac0-694c-08db8e6f7c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5FrgY7idtNy3UpNTJnbmlnFtUnC9RIj5KlqNp/Gk6Zdz4G9w7TSs5xVl42TDVeCz9iKjxuECNKUMq9xd77FPNcUy1ZpOf7vDShzG0ifja2PZvOdJhtEzApi8mN30BSzIoaDa6ixwVcPxbYG4IpzTr1EW2NtEJAd2g16l3G4dgdU02YU7kvOdOhAWNuGJSb1oKdOCAuBOObFtF0wnt9CwVKj61c6f5SkZIPTbklyVzZop0jbZcDJWYBQzoKyNoDUXejTRsRKUTdr7cQNZ5Yhaxiok8yN8KtAkoer8hcNNKXAHBqQ5dhBlMMtqqIVJCRARm0VPLjnC9HWej8gkcxj41PDnKjuFZm8+bnHWuebcpxV7rmZxtEXFjjR7c9iw7bU8LhlY6ik9x0lJsjPkvMwwgKfvbq/4y1JebOU6DLMyRsCWPwv5RnPpuUSl0IA8xsmrTcA2SJE+q3M3jd6iaue3fid+FtWJf3TI0cUNB1TaOw/GebZKGPRozaIyAnIfNNWXAjzMxbXXNDxRSv1pHIrdSQLRYiPWAPvQHLabAslVpTSdOOXbk3mTAhrUu19jz1NlA8Tom09+g7Z2Hl+nxCuGmE3DV9eH1GUkt7qD4no4lk219MBFKBTp4BDT0pW8AzMh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39850400004)(346002)(376002)(451199021)(6666004)(6486002)(478600001)(52116002)(83380400001)(26005)(1076003)(6506007)(6512007)(38350700002)(38100700002)(66556008)(66946007)(4326008)(54906003)(66476007)(110136005)(66574015)(186003)(2616005)(5660300002)(316002)(8936002)(8676002)(2906002)(41300700001)(4744005)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dENRUStTeTFSRGl4YUljM250VkF0am11eDJ0T09YZkZKc01Yclc4UDZxWWJ1?=
 =?utf-8?B?QzJaQ0Q2dGhaMGFXQUlhdmpSY2NaVnd4WEJLcTArM3FuVGx4dDFndS9GYW5S?=
 =?utf-8?B?VVJrYUI3TzBScm5MdnFoWm12bEdpbHpYOThPSGlSZnl3a3VsQXJzQUd6VGJn?=
 =?utf-8?B?SkRVU3FVd2NyK1J3VjVIUTRhTWVCNVQ5QUdYckNwYUN5V3FQMk9iVE1jcDAv?=
 =?utf-8?B?ZHBqOGtWalBsRktlNk0vYnU0R2ZiU2oxL1lmdWU0Mk1nMzQvc0hmVnp0UzRo?=
 =?utf-8?B?VkRrZ2dkWGI2SEhaQ25UbkR6N0tHSUlUSk9tU2pKNm9ySGlKenUvcFgxVXB1?=
 =?utf-8?B?Ni9zYk1wK3g3NjdqTmF6TjAvWWNXclB5VHBYeFl0UUc4d1FuN1ZnMGl1MzFa?=
 =?utf-8?B?cGtYWkZNR0ttMWtlODBENGxyQlBGTi9MdFlueFJCNnFwODR6empLU0hNdkFn?=
 =?utf-8?B?RElkY1dLYzIrOWFsUUdPVlB3cjVxOHlRNmZMdklvU3BUZnd2UEZHNkdDOXdT?=
 =?utf-8?B?T0pJSVorck9BTkl5T1NYMW01QmY0RHJJR08wWFlZbmtJaEpzTkhubzY3VnZV?=
 =?utf-8?B?enMrSzJDaWNnLzR1Qk1zYVBaL2RudTRXTGNWTGlacjRPMFp4MjRMMVh3NWJI?=
 =?utf-8?B?ekRIZHZRbEhZKzA2UFFRMVFTZzZ0dVIrWUl1SjR2bHFaR0ZzQ1hJL0pzRWNV?=
 =?utf-8?B?eDVPU0pucS8wUWxRakd2eGUvWlFvb3o5MkRDaktSeFFjREM3ZWIyeVlzUGt0?=
 =?utf-8?B?dWZaV1Fmb2RkaFdJVHJyVENxN1BsYWd5QmlmVkRUNVQ3d0pVbUpLNGg5Tm1h?=
 =?utf-8?B?L1RTY3UwbThlMlJuM1M3VDRKM0JPbkJKQmpsSmVaSWVIUExmU3VIWmY5WGVI?=
 =?utf-8?B?SENQcXNhMitYRUI4eW9pdXhGQVRudHBJQ3pUTjk0WjIrcExlQW4rZHdCZWVw?=
 =?utf-8?B?ZGJOWXlYNy9hNzlhOHlDd1JMQkYvMmlmTWV6eWEzSnE1WUNtNXJUam15YmxG?=
 =?utf-8?B?NXJINnNIMlR3NS9BelJueHc0TnoyUDB1Z0haa21OQ3JDR1RwanNkSmRTZVg1?=
 =?utf-8?B?dTFZaWZESTNPR1Y5UG52bzJEaWw5Rkt0NDdpRjh6RUtQMmVsbnRTNUJBU0FU?=
 =?utf-8?B?TnBmajFoRVcrSkZBcGtFWm9sZDdUMWJXbnNCWThGRUJtVXRQSktvUm5vbStk?=
 =?utf-8?B?YnF5MWlzZ01hR3FKRVd6SnZYTjN1Rk50UUNyc2dsYlI4djVwa05DeG9CSlVv?=
 =?utf-8?B?OG9Sam0yMmExRkE0am9GWDNHVnBWb1k4dDFTdnhkQzNkMjhydHRrdHhjSW9W?=
 =?utf-8?B?NEhlTCtHTU5CUHh2TXUvWDNCM2s1OE4xbEtOdTdheCtESVhOR3RSbGhiY0E4?=
 =?utf-8?B?YVcwMHcyTndxVCt5eDM3QzJhRFRpVTI4ZkF3dkovY21qRFZTR0dSL2lIRWNH?=
 =?utf-8?B?cE11MDA1ZUpEM2FoQzcrWXR6TDNmSlN4RllVait2SERRS1FCVitXYVBqbUFJ?=
 =?utf-8?B?YkNRVUJuTHJhK3ZDVksrdW9WVmR3ZEIrOTFLSkNmbDh4Tit6OTZScHhhMldU?=
 =?utf-8?B?Y2JySGRXck9WZENoZ0ZFdlQ1R0l6Z0Y4bzVLalEzZGxLUmdIVVFyK3Nkb0ZU?=
 =?utf-8?B?Uy9sN081SkNpTGV4ZmpDVFZ2bzVQT002a2pOY0UzS2YwUmRIamZMUytuUnp0?=
 =?utf-8?B?M3BTMFprSGtwcThuM1JDQkFYZUtqNzJZL3pYN25LdjA1VWZOOGhXMkwwOU5E?=
 =?utf-8?B?b2dwbHI3aGR5UUY2M0dHUmJOR3FWV2xTc2FZcm9LcVNuNVBYZ3pCcGpFTGh4?=
 =?utf-8?B?ZjY0bXlMc01BQlJ5NEhYWS94Wk1WbElJOGV6cjVHMTRoVU5WbWZpZVp4a0pj?=
 =?utf-8?B?bFRKVUpkb3JYZUpFbWpDMmlXR2RySVd0K1V5dkJlTzJ6WVRQZnhzd2ZWZE1i?=
 =?utf-8?B?Q24xM0FxdjE4RTJZRmxKcWYyMWx6SEIzYjVlUWtVZGdDWmhCMGw2QWt0elFP?=
 =?utf-8?B?SVA4SElMM3VBUnh4STVlbDNSQ2tyWFgxZGFZZCt0bGlWdHBiTHJjOGovV2Qx?=
 =?utf-8?B?YlpxMXRMUFNSSC94UDdQeTRzTVBsbURJcXBMcG1rY21VZXNlLzRWaU5obEFp?=
 =?utf-8?Q?ujqyfrHdRVHUAQwk7XTKBULpy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d192c5-ce8a-4ac0-694c-08db8e6f7c58
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:02:48.4011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWLAaOhm8nGABZ0wbkrbPqU21xQYZYZXWw/NbE1KScX8sl3XAHbBRpGaYyax5J0SJ6btho9y01iOzWnhHqbwEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4152
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The order of function calls in sdhci_f_sdh30_remove is wrong,
let's call sdhci_pltfm_unregister first.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Fixes: 5def5c1c15bf ("mmc: sdhci-f-sdh30: Replace with sdhci_pltfm")
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/mmc/host/sdhci_f_sdh30.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index 840084ee72e6..964fa18a61a4 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -211,11 +211,11 @@ static void sdhci_f_sdh30_remove(struct platform_device *pdev)
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
 
+	sdhci_pltfm_unregister(pdev);
+
 	reset_control_assert(priv->rst);
 	clk_disable_unprepare(priv->clk);
 	clk_disable_unprepare(priv->clk_iface);
-
-	sdhci_pltfm_unregister(pdev);
 }
 
 #ifdef CONFIG_OF
-- 
2.39.0

