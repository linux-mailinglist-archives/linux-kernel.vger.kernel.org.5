Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB163752107
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbjGMMRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbjGMMRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:17:14 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2132.outbound.protection.outlook.com [40.107.255.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349202733;
        Thu, 13 Jul 2023 05:17:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rd8Zjw7IwCSKSRp++sO8QV4lareEK0MopR+sCIH8iW6j8D3CPTeVZSv/AawqTSI/o2EWDAwf/u6pI+3i8zKZF2kIG60EuM5l1HRBLLe09FQvceKHKsiko0ycWpC0kNVUa38EBH5J486hESMbXy+iQDsK5ZgHpvHwCzFKeKxsDYC0tEg9TOmK8IlOALEEmuQsRFzs1j37oUhDln7RAmm7XKbk1yiuV1EkmzRzN37xkppJvbO7GP+JMtgtKWbnynzycsAPmyn9BXXQBJl/ZPIMmasBFd6SWrQVuWYVEJzUC/2L6bvLusX6EYQtbo9FNaEowcYTdlviH7qWUszczBV7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpThUSvHqRaXTFJuQuH9fiY1i27jp21aj+bJtQDtbLc=;
 b=KPCuiD2F/7hSkmamlcYuwZIbZJ6TTKSRt99+lbQotDSXAsSGRsq4vJ5uWE2XqT5DgjIFLBxMWai5VAlZ4fsKtE1EmlwywlHLeuretR+xpxI9YlDBvdG5l96KA9kU1b2P2iwyk+csJ0V1GWD8VFvsfo602KkKYSTam8uIyzoMycpZBdLNMvB6SDHuAGUl72Dat/gWaHoPJFyZGNQYlWdApP3Uh/ZWqKoQO8IeAM5xMPA1v2MWk+tbLCeSM5ka87VfNrgCpzdFTn2oeQuSbzdHLddXIl7K3Tb3kJjB5CwiRcPOyKWZrx2Ed36FoH8kJG2khAlQ6hL1w7K5vEMX8pbrRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpThUSvHqRaXTFJuQuH9fiY1i27jp21aj+bJtQDtbLc=;
 b=C0ilwZWserMt6c+bajA7E3nxmpLq22UTpIBgaxSIDxlKoJ7bg/7f4OGaJX8ZOYYWTijd8aq1TTAdeEz+ZJObwUfN+X2C8F9MRvq7OWKcAgtrby6VBlpr0R14OgRDJsr24NcehfhFzPOdSHmBgkLRYtXux76YKLAPe0Keg1uwu6t9xeo3/jThlum487gJus48ox/PXkH1n+D8vaRsLtejGANAzAByRosTvPHHHn7P58O9epXdNDbdKabpCIpQ6H0+ldLL2xbMDFABXCFjYdI0dkQ+jZzDklFfB0HdV6Fetdo9YPCO4E5mfZOh8gvGxDOvgEvLMV3vSSQRgqMMOFW9og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TYZPR06MB6808.apcprd06.prod.outlook.com (2603:1096:405:1d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20; Thu, 13 Jul 2023 12:16:57 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 12:16:57 +0000
From:   Wang Ming <machel@vivo.com>
To:     Jiawen Wu <jiawenwu@trustnetic.com>,
        Mengyuan Lou <mengyuanlou@net-swift.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Wang Ming <machel@vivo.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH net v1] net: ethernet: Remove repeating expression
Date:   Thu, 13 Jul 2023 20:16:03 +0800
Message-Id: <20230713121633.8190-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0199.apcprd04.prod.outlook.com
 (2603:1096:4:187::13) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|TYZPR06MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d1ec7b-4d1e-430f-d263-08db839b0db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rb3J2gO7hDwnFVGy3PE4KvDXRbYdg8y0JK2FfWQxEPNfI+F75ktGI4uUnSR9sTGSl8L9Z+no81ShWdGYjk0t4V27/MaN6FRzNUa23EzJAtm3Yo3Lv0mMdb6PPeYgEVzPeE7j93pK3wng5vX9j2Loye0bJIc6NRKUgi02jQvSBFQcZ7H0mUmF8zCVgiMmWZ4p8pu8C9eb6DpIYDg7ZeaKL9qmMc2f60InA2NbyoCMy5StoS70F7RcZcPxw+CVRkLcUTNqUUx5J30foV/hIOmAYMt05Zc7Gd3yPpXfakOyEXsqbzP82pefuE6hQy4szxA01TZegleBAtJhCAba8ofEvw34eEvdZ14f/ihUMH5Bj/7Uz6MbffHdKpJnSAYA3L2mfvs/AT2T7sJHvrtP2RBu+QNr66lSpOd6gagPoK6xkgUVA+M5fRpgBDKdPDaBk5cQZyc9FvMYYHTDGyKz0lRa0BHyABny2hSIm68T+QQLH51bAwL7OtSGaykEV7fDOJeluZr6i4TbaoQiE7E5AlBAAt5Sm1RdiBKzrhixzo64hRsGSn0xppvAzHArfihJCNJ7x78U0wsJ0uKh7j1veycbZYtot3pCwMZLS59iD7t2uqUM87Dm8spi/kNXCdlykItg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39850400004)(376002)(346002)(136003)(451199021)(6486002)(4326008)(66556008)(66946007)(66476007)(38350700002)(6506007)(38100700002)(107886003)(86362001)(186003)(2616005)(26005)(1076003)(52116002)(83380400001)(6512007)(36756003)(478600001)(110136005)(41300700001)(8676002)(5660300002)(8936002)(4744005)(6666004)(316002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zBnC04hWVavMPlJ33Hlz3z2fC33GkahQPBVzsfYMtgIbOCojFl3wITUO4OB0?=
 =?us-ascii?Q?ptIVs2dmTVWQyMW8sZPnPfYDA6dXwuRWj4snermEz089pKu3iYVs2lSI2NR+?=
 =?us-ascii?Q?Dopdk+VFDEj3PkZlOTWsLQ935h8T4HtVB3nW007ibsL5WnzjfGUIETzdYPig?=
 =?us-ascii?Q?/yohM1srQXIHk/B0eW6jFn4jRIQ3FPuA4KLI7rY32H+rPmZlaQe/mhJSRHCE?=
 =?us-ascii?Q?lKXnHlKvVeCWR9yKYkueA3yMqfbOgTJhZwuyzRsCxBCSyepOIbrhr0d8YuLe?=
 =?us-ascii?Q?js2+84NokYH9Uce2l+1K4W/q53uMyW+Oc2lCtgBQosjUEzqHDYdg8cdmfhTm?=
 =?us-ascii?Q?7z1x4xnXxYKBzmcH3WuAaEyb3m/Pa5LMFEEK6XdNjsw1X0hEesawcO5Cm/EU?=
 =?us-ascii?Q?2QUM5effJoLJZ7d/EwnuhTO7mtP7FAS0U2vJFFfLDFyFUf/4ny4nESFq54Zr?=
 =?us-ascii?Q?rZY2B9r5OndCW+7B1/ubbdkwkGZgVQIkwB37mzhGVgsSF65dFhIr8fzLxpWP?=
 =?us-ascii?Q?bcJg8g20I3sSlKmxV1vg+9Ns5Kl/zS7DMELZSeGL+GnGQNrQm9xMF73HQtdF?=
 =?us-ascii?Q?qPEgujULeqwcVG3Dz0Mif+BEwZMtTgjQiK8daHlmxRbS0ls2l0Nh+l7+UhYP?=
 =?us-ascii?Q?VfwNK3yM55fNXFW1LWfov3HsS1ZLE+v9fGOjy7+9bE+c/sFJavp5v3ORY+7M?=
 =?us-ascii?Q?Vj5LV/beazgAkTRYVZBKglAccQnAziqouAFF+kk07TKA3Koc/nZvtcyit/0M?=
 =?us-ascii?Q?hfQJzvHV3h/RfcR3OJmEYSmCSzlm/9Y35cFZ5iTkSK5++t4Ba9sny0WLJd5a?=
 =?us-ascii?Q?hUe1zaap+nDJ4PKThezIAuQZhCrFR2R0gBr3EmyN6XfA0l36UUb3jJp60Yos?=
 =?us-ascii?Q?AqZPjMMgyBR15xfhx6G2i/VjYgAXQOpB3tPMjpIab7/9ok8zWewTeRFGvFik?=
 =?us-ascii?Q?aWag7mSoPQ1z0kcWQSZqgsGGzBNZU44GGqnlEDGAcNRfWpBVGwiM1Bnl3jcZ?=
 =?us-ascii?Q?Ohp1I8SQoOAKMA95S97wNSCWEMfWDWd5n/TQvNsawdfgxp9uEr9O/n0jYI/T?=
 =?us-ascii?Q?EAF9vTeUMHEBWcQQ8b5BdrHLEn1uW3TgFqxh28XZGw5yN28uP+Ok08Zr5ulC?=
 =?us-ascii?Q?1MWIn3LawAc8jXRHntIK7TrUFdMKrB/Jet2dBtmq45e7kixejwYLo+krXFip?=
 =?us-ascii?Q?BgJtQOYWmezRSRVYkRSGhSMSLYHuQmnK+BnMJhf6IFAUA+5t5KeVGkikPYNe?=
 =?us-ascii?Q?JpZahmbzYpfEXWxtIpwMZLfbKZIzBFPDH22UzSPaUOyJvELxej91lzOTafI/?=
 =?us-ascii?Q?ybwN6viyCZ3RvaR67BT2Wz+QSUhyelN7c6UpQgFJ/lsRM4JESQwLDwu7WbUQ?=
 =?us-ascii?Q?52UAFhyo+sUgzZa2Wo9SesL3zBCKpOanUjf3U6pYb+d94ak2Xs+lmzfHehzV?=
 =?us-ascii?Q?l9tdsmgMVcw+VChd2jY8/v3cnO/SuBv1eexLJ0G9BYquYaVeqjk97B6nk33t?=
 =?us-ascii?Q?l4NUwWIU+swxLlXzN1XQp8XcZRLRJ/8W6//F6ataChGr9Fvykxj+bYw1jT56?=
 =?us-ascii?Q?f9wDC18gfL8os0LzuX96Wvqg0nG2BaD1CMckgez6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d1ec7b-4d1e-430f-d263-08db839b0db1
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 12:16:57.7605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vkIV+d6O/1HvkuNCPXoVt7qT7dDU2u9H32gCBAhiqjKjZD/QAJGCcY+qv1D2vfORiH6lAjmuHJNKK4iJ0K49DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6808
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Identify issues that arise by using the tests/doublebitand.cocci
semantic patch. Need to remove duplicate expression in if statement.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 39a9aeee7aab..6321178fc814 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1511,7 +1511,6 @@ static void wx_configure_rx(struct wx *wx)
 	psrtype = WX_RDB_PL_CFG_L4HDR |
 		  WX_RDB_PL_CFG_L3HDR |
 		  WX_RDB_PL_CFG_L2HDR |
-		  WX_RDB_PL_CFG_TUN_TUNHDR |
 		  WX_RDB_PL_CFG_TUN_TUNHDR;
 	wr32(wx, WX_RDB_PL_CFG(0), psrtype);
 
-- 
2.25.1

