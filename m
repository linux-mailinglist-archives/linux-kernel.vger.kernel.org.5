Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5A67ACE39
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjIYCi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjIYCi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:38:26 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2054.outbound.protection.outlook.com [40.107.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC0CD3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:38:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQTqs3Vu2478CzF8FCI0bHa2wrm2f0IsCZ7caQdhBF37io06fIv/jVelpUaB3qk318ZBxylBgSjefRpyF4LAC0hxAn/C7+UKrX3OndfpdG39szKkkW6L2+M/SssoHRtp2QFrslTVdVDQeDKV00PkbTnJTzaRGUXMAH2Sc2eFJpIn0zA8CPImK23k0ni8UtSgGzxfy7MZjWfdW/85efPYGtUd5ii0BexcZtJlGSlhXorJgOS9vpsPGOIBF+qOyh4xEx9IGO1KGpp2Hq2oCEl0d3tIrNIlBXv+pehj5ErKPLCTjW5M88cKi03SyrqBycJYtM46RHpWIfwV99Rn9hWslw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FU5xGq5gjCnJlgVU5AMwAVPhsAbL+7DOFa1lyTvVIfo=;
 b=nJAjWHEspjnnPUsLNG9GM84iSVcAY/rdMbj7h4icfSk4VJUsBEaEBmvo2p99Cbxp1b7NygjSvBHiCGlSdyFNGwoHf4OSXTIJ1cChDEJDEfNytOVrNzeiDyKzBx6aQ9Ha4E/q0gBGF294GzYhoZboRcOY/wnM5x+7XMyLfyf9PQEtb9pOGJYD0GsQhYDcOQUZYeLavyeqOeLD708OMAHiG7VuoCd0evejeNSe6yn+xpBSCWTehS+ZutuR3dH+oZgy7lPd8sLG+l2Fno15kMyAZ7wM9geEjjNu7saX+D9PkZU7rk5E+Or0miwnKXmDQNaBTjrMA4DzvSeRL6NuFZfdGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FU5xGq5gjCnJlgVU5AMwAVPhsAbL+7DOFa1lyTvVIfo=;
 b=K7oEj7+3lGH/Ffp2WTXc/YZiienBt7MKqydSUB3l7xYitW4VXqQ+dHlNbzP6dITXVjL7pUlhf+4qhDiVyRa8SDUYYehJTzjMMean15XKc2lU0juhVZ5ZcnSLdUPeWqq9IS57fKRCN11/vqJXdQVs9D9yW8pSaN6uvNO/bocE+1Ym/Lt8oChOofRAWbFD6R2VWf6YswPzyVH6wjIbYo+W18xc+S2rr64zuRJYSETnjC5etAkw1aw31ObKvfIGG0y5S0S8+5Ki95PnUoWPClvJ/Quo1+3O17WVaVGLn886EZNtcoHY8nrzDO7JW0McUwIBg4l52bJlHNBTBe3yKYa7aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13) by PUZPR06MB5850.apcprd06.prod.outlook.com
 (2603:1096:301:fa::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 02:38:14 +0000
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::dcd7:b551:2d36:b7ee]) by KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::dcd7:b551:2d36:b7ee%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 02:38:14 +0000
From:   Rex Nie <rex.nie@jaguarmicro.com>
To:     tglx@linutronix.de, maz@kernel.org
Cc:     linux-kernel@vger.kernel.org, Rex Nie <rex.nie@jaguarmicro.com>
Subject: [PATCH] irqchip/gic-v3: move reading of GICR_TYPER later
Date:   Mon, 25 Sep 2023 10:34:08 +0800
Message-Id: <20230925023408.1441-1-rex.nie@jaguarmicro.com>
X-Mailer: git-send-email 2.39.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::32)
 To KL1PR0601MB5773.apcprd06.prod.outlook.com (2603:1096:820:b1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5773:EE_|PUZPR06MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: d8e9b1e2-03ce-4fad-7d30-08dbbd707742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S9pfa6jo+Ysxws08cM1Oi1heblFqmwAKubTjnSIc337ecSvkxVC5HztSUZzm6az9ZIOGD8nvpcZ/RLY3m45VdoKawvzU9k72kWVfiDb5xnlmM2AcdG69HJdChidSp0SI9bWkF6q6xE2DO4qdQdP5ld2u1W8HY+vMhmyTrOVmwQ3UQSUUBN74nGBqSRL+3dOqrLRYOcXbKtz3B7ATCWsCpuF2z+Zl2B7C8/gypLYmFhRGqjGoW7Qb5KNgPwESnHIVgdTJRRVLN9SvwXQkJIjTWHgt2gLspzNjXc6Z84bjxOqBJJYsRkn87/YilciCJsVEFyVMurzwnlqQo/V2gLTe2lquuhQkdKshl14jMmabASGICki1ggtzj2Sp2l6G37cDKfRxTWGompZGY7UwLTWgyiJITCt36gabkbXOl5z4rdEMsy/pmoRXQ8Qn5RPorQWgCXa6pZjOJYA7LYOPxPTmZwbnQVDUmwIb5KCC+wIA35iEHEdoFf56aVK4uHbROIhzf7hqLPiMpLH0fPfG90ZySkn6KTkfs3Sj31cIAg/TbEPy01M0Fzn8EV+a6kPoNcSzX5/gTc5pOKbEupX/MSvg0kdqrFBkIzbcAKk791+suhbGygsCFFKGm+MUiCOp9dP2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5773.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(39830400003)(366004)(230922051799003)(451199024)(1800799009)(186009)(316002)(41300700001)(26005)(2906002)(5660300002)(8676002)(66556008)(478600001)(44832011)(66476007)(66946007)(4326008)(8936002)(6486002)(6666004)(6506007)(52116002)(6512007)(107886003)(36756003)(1076003)(2616005)(83380400001)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j6EpDMDTAPWn4CjhnHe/Y+wa+QjV5D6tjpbsCYzKtQMCQdW8SVlzvKhdR6x0?=
 =?us-ascii?Q?nX5M7ZVXyw0MyFxO8/pE8fjkvkk7wAkyMRoEJIpBeYET9CnmeU84sassOX+D?=
 =?us-ascii?Q?vdKFNgljQYqdhSspxJMoZI1+XhiV4VDoFMs0eu9E2J4joj3vJ6iAIn90cT0p?=
 =?us-ascii?Q?yOEKRZxNAes2y83Xlslxld+ShVdA595/EeYX3AR56y8ZhmaIbu7emtn7K2xm?=
 =?us-ascii?Q?YOMsciOCa0VVjKZclgN+9VnXGBTcigVaS9kihJ/caW4Mt2u8loTDSKOq9xsE?=
 =?us-ascii?Q?Yx8rSWYJnoRvvLEnAlswdnR5VejRpPKIuSJRnC9b2OZ64gphhdwf5DrXkjGX?=
 =?us-ascii?Q?xZ+yXOHQr95CchoLyqLZxcF13XZYtS4bufzb1tAh3VzS98BQVaMYFZ2k6B/A?=
 =?us-ascii?Q?80IuBQ7zw3H39Fey8RDD5VC2tXiqZ9Uk90Y0lIKfyb8oKfjIdmCZV1YTA0kJ?=
 =?us-ascii?Q?+1n2rQIGFz5RsLgj1VLpFW8Q1u0+AqVHlktl8CAwPCLKo8Hv29L0TMmNY8CT?=
 =?us-ascii?Q?i9BwZppmBRUfd3YiCDfe7yTq13coD/6d1paN3j5k/sIg6eR2tlW81T5UG63A?=
 =?us-ascii?Q?ZQjBNgBVbNNGK5PFFkcqj0tid5vsKAno2X9NLMLVfDgcj0/WoPxLTSORXuGF?=
 =?us-ascii?Q?QeN+ud1quZRUHpnHxHtfOZBXrpTYPBmquXncJfQWZ+p5VF7cMJfLz+mEwpiq?=
 =?us-ascii?Q?/YlQ42WQlEtESa45Ozyg7Cal8gZYU0Gwis/Heb4LF3qZInhIX+i25f+IAOIa?=
 =?us-ascii?Q?4FeoZbmzFE9GYwvaLK1Ky5VZsMyzZD+Amp7xA+fy+VJuGiM/K7zAl8dmUR0/?=
 =?us-ascii?Q?z800AQ+1bV2B4XipNiklUBW6cylo5xWlO/n5cvcHlic5nTtwC7IbVEv4ojc1?=
 =?us-ascii?Q?ophV+rwt5z2K+qyVQfYMHuVKoQmh+LG+i/GzplK5u9eK3WKnrJQtAhH6gp3a?=
 =?us-ascii?Q?UgoUCnJ2EXsRZcbvZQ/xaLCEBM9miuZL1ezrVxSjyENrCEz50z2Sym6mfRZF?=
 =?us-ascii?Q?dpJoV8A3a/2PGxIe1XN5Dvs3POr32U457Fey6fmokhnuARiVziQq1FW1boEI?=
 =?us-ascii?Q?sDnyFI84vHMYAjKi0FPrmFpQbnjQdiGR27mJfKmceS6kl3QLIpMfMg8WiLOZ?=
 =?us-ascii?Q?m0dBFiT0CPQ2br0c+ByQaXld3CNMgUdCd0JFAORjZI1k1QCT3bjGDuabnP+u?=
 =?us-ascii?Q?gSDPNxVh+FW6lgtqMPOl6SkchQ7fmbrdedZXepnN95OwxrrIdszx2cJ5DYr1?=
 =?us-ascii?Q?y349k1IUqGppDb4Unh54qhk8lpV4Ai6UXU79WWG2cFjx5CiO2HjTZPyaET3n?=
 =?us-ascii?Q?Ttw+ufq0twvACu4f3OhLCg3dndi+ajtxqqit6VmgD8R35g7NRdf0Chqty2pi?=
 =?us-ascii?Q?z0j6ku/FbepRsVVNk+rKjWPO6k+eXphcAXdPSRthLsAyF7r5mq4Toy4Hk9a6?=
 =?us-ascii?Q?BIbCyfVxls6GmWBlPM1a4diOiVEpVFnW9l24bIN25KCnRcPzDgi09EAbo7oH?=
 =?us-ascii?Q?LeiTHqqOQ9vsbJkuclz+Wf3Zf8KRBWrOgUEG701g+COB11/NlbkEcP2Oeiej?=
 =?us-ascii?Q?/V2rWH3/iXEIFhDunJo+1xwcKaIJmjvH8mVQp3OVXk5eCH22iK/PfwNHkghB?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e9b1e2-03ce-4fad-7d30-08dbbd707742
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5773.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 02:38:13.9743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 111RN+rKmw/BeGHiS4vGX+hp31otBzbVz715rVE9eQIuQ8fhhkHMjoc9zGh5/vXDph8uv0axG0Aa0aGjNKNSnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5850
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changeset will reduce one reading of GICR_TYPER register
when any of next 2 condictions meets:
1. found redistributor for current cpu
2. single_redist is true for gic_data.redist_regions[i]

Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>
---
 drivers/irqchip/irq-gic-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index eedfa8e9f077..d08a4773f631 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -982,7 +982,6 @@ static int gic_iterate_rdists(int (*fn)(struct redist_region *, void __iomem *))
 		}
 
 		do {
-			typer = gic_read_typer(ptr + GICR_TYPER);
 			ret = fn(gic_data.redist_regions + i, ptr);
 			if (!ret)
 				return 0;
@@ -990,6 +989,7 @@ static int gic_iterate_rdists(int (*fn)(struct redist_region *, void __iomem *))
 			if (gic_data.redist_regions[i].single_redist)
 				break;
 
+			typer = gic_read_typer(ptr + GICR_TYPER);
 			if (gic_data.redist_stride) {
 				ptr += gic_data.redist_stride;
 			} else {
-- 
2.34.1

