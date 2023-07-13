Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4C1751BA1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjGMId5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjGMIdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:33:32 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2114.outbound.protection.outlook.com [40.107.215.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D25729B;
        Thu, 13 Jul 2023 01:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBf4G/DH7iyDOINlPSdumkTgpuwNPAoXQGmSkJ0QueiXBSEepvFcivudsmIkfhbcXxzxWhQYZ2UatGO5cuaB3vYGrRyn43tSHJJLrFaEpmd2c8V8PkSSEmfV7333SpU6rnqoo3wIz6xujN30MXKxBQbCchZ6nB9cCEGlpE+u1R6HnjP8cOcTDkFCtl1G0cchiqrhhZhcTBHK9H0mMyOrCB1QQtfYjteBkJ3GFqth3xystxzuHSq/xDlRo84LbBlV6JNuqeQpSPaI/9yTq31ZvKkhDVl2euBS92jcluxUD4qVFN+fCu++lwBwSnsQTzZxv1u7IFTtFo7spm4E8oh+9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bxo1xLolQfpW5eY1VGCdRZTgP1+MVHPpwxQVGaezwc=;
 b=lfjUYYoWnrewtIUO+maPGTvJru0+EpjrM+BD1QDqIk/+6iFzqTYraBMrTuud5LCIHarzRlIXlFKC2ObbPa7FszOa69SjlVINVx0hh6SN3cy58YXA2lfkig77Kfz0Fc5uvgmo113hIhWWZLCHFDPHY69++0nRHZBhr52Z4wHeqDcleQk1w9ib9ybAxiaZZi6qM/z7MfV7ez3gABfLqGjaVlX4oNRXDJKnDl/u2DopRnYjbUoIcuNJ/qG+Y3AcIE8MyLglena7spPvg2+NT4yCHvUdLSSR+CCXR7UTQFm3vGH4Q9csM+tp/e+xiVAuQ64qdcRwp1q5Efh7ZcqEwtpcLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bxo1xLolQfpW5eY1VGCdRZTgP1+MVHPpwxQVGaezwc=;
 b=A50vvBJWCBiYxzyYzKeBIgtfhzWOf18YyppbC3TQx38+4osutjCP4fRSx21YChnGV02b+vzcEHFYKTDWetKcvVIPIgskzSLye42y1oMGgjw/H1mmMw1vM162cSLQ1epRP99VrGyXm5k+ulaeE61nloIt90aRj0jDEWi64iiP5DVW1mSV+0DLbkabMPfxfYOfmK/x7C/VnG4hIWXxv2aXGqpAsUjw9YA8rsMDR4/wHIh+5R82TaSiDnlg+z4K0OEQqXN4V4rOcM4Djl5y1bp9WYKKjaXyN4776GqB0wfZZ/Gie1UazPF1Qd6QbzJSyM23tUHeCxoRks/yeS4i0LnfeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 KL1PR06MB6686.apcprd06.prod.outlook.com (2603:1096:820:fe::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.31; Thu, 13 Jul 2023 08:24:43 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:24:43 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org (open list:ATHEROS ATH5K WIRELESS DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v4] wifi: ath5k: remove parameter check in ath5k_debug_init_device()
Date:   Thu, 13 Jul 2023 16:24:32 +0800
Message-Id: <20230713082433.11485-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0119.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::35) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|KL1PR06MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: b570493d-45bc-4582-3857-08db837a9c18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8rHNY8EHLu8/4E8PMJXtYp8neA2QJA/WL1udRay9KoplPsjhveapw760KHreeacYP0GOzo405c2fF/zT5b3u152wAroQz1Wqv2M6rlWs/fUNfOEfEw5cLP8cphZf+L9ZB1w4Dfgg3lHmElDvBBVgjisyv3MAbeNmFfTZRLNjn5078bdsxSdqv7lVHSwSTQlPv0hTyCOvfW2jtHjj0TlQJP+TRZaRTMM7h6+iO5FJs2LWGTGcoPuc+XFiB1i43bG7VnabmFV4OB/RCPYCE10goGEn39WHkoeJsuA6nMMwDLunbV8KiTDJyHqikBeyPzbt99y1+EmddrEUaJCxhqXTFnl/9Lsm/XQXYvQUGq5VMKZdVZk4QVooUAB4UCBkJo38k2Ez1Lv96QBA2Bp1EvWS0M99OCg5V/sZXJ5SyklaMhfD7OZLDREq6hB1iLJ9ZPSWiqJAjKnDHk9saFIE+Ppi5xICuoW7Eb4hkogvL2gZhrTZyLgib5FbLHL+6k6eHF/jaMA5m0piUjNkB4nsnrvHYYS2ULRrnu6gsBrQqgsIdJxVKVN91oIfzwmAOZGLJz7HvDLg8izADZSTA91NGs9CZuA/3+83k8MQ39Yz3emYgO3kZbaStxZuqR1wuyc9Ghuu6e4emc1Gi1TrRwRZBieiow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199021)(52116002)(6486002)(478600001)(6666004)(110136005)(186003)(26005)(6506007)(1076003)(6512007)(107886003)(2906002)(4744005)(66946007)(41300700001)(316002)(4326008)(66476007)(66556008)(8676002)(5660300002)(8936002)(38350700002)(38100700002)(86362001)(36756003)(83380400001)(2616005)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pPRdNEZgdbwwYFcnSNvU5V6cPyK5xTOTs7A7DywznWtC+eQxnBWtda+0y5Or?=
 =?us-ascii?Q?GQVIUW1UgR0TB8r4pjEBzsvI+wV6cz8Boh2tV/veyBIU1htfvJ1xGmS9crdH?=
 =?us-ascii?Q?KvgL6TKSfc8oQEABa6X3YuwGGNGn3u05ak6P8Nlcd+L/eHLAsKUF9M2BFuvw?=
 =?us-ascii?Q?E91gCxj5KAz6ZJX7BgUi56RO14UelQ8pOia574s50yF9bRRSmiWX9AJVS2bm?=
 =?us-ascii?Q?kACa3gccLhBmXMUSE9+H+PXLPeTm7F+PgNBzVIVXe5UQdJCCiuNsDc98Z6iK?=
 =?us-ascii?Q?8b6bIbHH+QhbiDWf5mPSug+sVvlQt9fVvKL9WXR07rOg8BlD/SDdCVci7UOn?=
 =?us-ascii?Q?6ZepWMYJnuhJ80clxWIm4jNBwCbNYCP5/jXxj18wWeHBzwoxvlohoenu+ph8?=
 =?us-ascii?Q?dBMCvAAylLcM/amkbImrx1m6J6pQlDsrivnEUR5Xq8XukWQY9/OhF2+y/bfO?=
 =?us-ascii?Q?55rrttUUHbT0dLnax3sXwu4C/JsHHx9ZHcmcLT5zSalmwey3Q1SzzIQvC/BY?=
 =?us-ascii?Q?mvIYadLsWweCSwr7RwoIq9YoFVDIHjbVY4Fmj/X4w/10jv1VnE963jVefK4O?=
 =?us-ascii?Q?bZRkYiTYSM75Q5fEBh2Nr2iYCaM/m9bPSmmLxgbDDTYNihawLsIC8KfxQg3v?=
 =?us-ascii?Q?iStBcu0UbULbaHmAE1+hO6Vk9PCui8QEUlWlwYTW+dvFQhwTqqLb2f3BkJUb?=
 =?us-ascii?Q?bkfLLDK4TiyzEdCKzJW9gCwCosaesLXC49uVCVOqRZi6Xzgdnlpl1G0+Iny8?=
 =?us-ascii?Q?vi7Dj0wz8FweRne5MFURoAhIFmcgekI/aya2QG8pCJN2N1lUEl/RX/tTcGRA?=
 =?us-ascii?Q?J2GSjL/ZBQ+hKAxbo/0+P16lP/VYHCjQBctbp+XEsWqOe4m5zPVubJy94pbF?=
 =?us-ascii?Q?6dBij09d6/jFg/evfEkostOFRstjY0Vs5Ax0s3Xyy/Ktjzh8BxQtbpYgBkVb?=
 =?us-ascii?Q?bMTkYd5kGEvxmiyUj1Ud3R8e1xRJ+vqEYjawXPuQhy2NDPxQWBMj7VD4U9zk?=
 =?us-ascii?Q?9YhQTogx4UhKh6pnBNBgLXX7vufmk9b+U3r4OWP1AoXojCvoUB4BAkiqBtNx?=
 =?us-ascii?Q?A3UW9D77iNNAepOVUIo08ZT7Gb1gq9e9elogwgayniZZoZ2iaHG5lLqwnB6v?=
 =?us-ascii?Q?K2tyuCO3d6zjAwU/8Rd8ZwHscTI2+SvDnfjc+2mLGmyD9cdzzKPTJOml8tc5?=
 =?us-ascii?Q?uH5mTfgE04Nu5w7VKWXHmRPwSdBnI4JRbjYZbNaz/Q7fzBJLLdSt84ugqDe/?=
 =?us-ascii?Q?W6TsIATe9J0/oaS+nNbUQ6xm9VsnmmFl5vhf6RfdNTBKyEkp3iueG5DdmbOo?=
 =?us-ascii?Q?kay1Lfp7NUq7++4OREfYZeNIgnydkcuWQikuTRqzQ/HGEKodBIqeSM1FDHmN?=
 =?us-ascii?Q?q+60ZnMNnKqQg0+6tZL1z/P7D4fbrYMWww2jbgMoij46b7EOMpRspo+2G6mT?=
 =?us-ascii?Q?LhGGBbaHNkMXWx6Lr0D5z7cQ4/GUxdN/E7g62dN3ADeNtwBqD6MYETXD6BdR?=
 =?us-ascii?Q?AZFmaa8CDAyUNgrDcd+DwgQUWRXYENEoKa62QvwXVWwTZC8MJn4qseHI0nNi?=
 =?us-ascii?Q?gYaN1Am9uvpbx2HvVnt0hZcswGmlNp/tIYyZ0+lr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b570493d-45bc-4582-3857-08db837a9c18
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:24:43.3193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmdyKGE41bGHeqqXHVy95UoEf7Sjn1D8C9qmWdCUnK/W7MKDIYO6YViX1n0rcO0Jcx7ZIEN8edeUxOBOJj6oBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6686
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter 'phydir' error check is mistake.
debugfs_create_file() will return early if 'phydir' is an error pointer,
so the error check is removed.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
v1: use IS_ERR() to error check.
v2: use IS_ERR_OR_NULL() to error check.
v3: remove the error check.
v4: fix the patch format.
---
 drivers/net/wireless/ath/ath5k/debug.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath5k/debug.c b/drivers/net/wireless/ath/ath5k/debug.c
index 4b41160e5..ec130510a 100644
--- a/drivers/net/wireless/ath/ath5k/debug.c
+++ b/drivers/net/wireless/ath/ath5k/debug.c
@@ -982,8 +982,6 @@ ath5k_debug_init_device(struct ath5k_hw *ah)
 	ah->debug.level = ath5k_debug;
 
 	phydir = debugfs_create_dir("ath5k", ah->hw->wiphy->debugfsdir);
-	if (!phydir)
-		return;
 
 	debugfs_create_file("debug", 0600, phydir, ah, &fops_debug);
 	debugfs_create_file("registers", 0400, phydir, ah, &registers_fops);
-- 
2.39.0

