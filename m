Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09367535A7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbjGNIvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbjGNIvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:51:36 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2101.outbound.protection.outlook.com [40.107.215.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5522713;
        Fri, 14 Jul 2023 01:51:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbaySADE63tBgQ5D248KMcpcek565RdcC93nYOKcWr9i+/65Kwb3kz1kdvqa4ELhAnHe7dj0Y2nGm1vMbzyqAgna2XxAzQLnpZPgesfSCYlo3EB2mW5ZdIOnOvZqakbtiZJtBxVlZyFrHxi3uGXsqesTzHtAx6D5DGH5mQBcFUZss5LY5uLTUYKBpShL8dYMUo9fYZGxa/sCraHw3kHx9BuTDeeSBUCGIOlg70BcFyH+G3u0K/lLgweFQBI0tMuAvmuM1ng0/NDOjfW8+D5hlrmbL4E/KBUiTCrU48FWorwHDbzj0DdCkHiKfwcTFHwwJkAkCJcbCuWfQR3tVY90Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15Lwfe0WBVeBBgSfPvWK73Bw83rebUol8cj5oCaGGxU=;
 b=YSGx1UX1o3LzBOEx94l4cT7rWbrXzYOqOxfr6cvabN55P9764He9F+m9rJTS8vT8tCvsTW/7RO+aRutNKFo8O0Mkc03gkE0FEUp+BVBkXU3KVrU0tkVLfRw2o3fL6z0xL7JxF1b9gLJAjjudx3AaK++iG401m6dLM3aT+OR7ZlNnNohbYSt251Oib3uA5bOQReXFQzZiKQXw15AphmqqBNJ9Nn5skw6Faq9v40ZOdufb2KIJdpxDp7uUKK5WapalsgrllHKqWH9W61Vc0aohGyIpa27hGCXSd3T2YXXtO8YSBMRVeWGDSlDrAAqSYQfrvvbH+BJqyMsEXNu9qmFo2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15Lwfe0WBVeBBgSfPvWK73Bw83rebUol8cj5oCaGGxU=;
 b=WtEm/4cNCP7RKPnZfs8kDLhurlWzL1YV+njiMT/A02v67e53CNRvXCRGpplRvpTW02Op3rC3l7V0U53YW3lfgLOrv44rr9jH1ZXHSf4VsMEUCw7OGnMQmf16dzFbxesrG6NZsAZZMrjfohfzS1tdNdrYRhtmjv1+0x6T3dezUOj4vMeBax6nKW8sWfwc2tKd8VASjJLztI8nvzr7giOcUNHAn4LInjbuWIRobf8Ylc3SZ6g7EwNQFVj5HtP7sNx4W88eQNSGFx5lI0CETrv8qWR9wdQUe1ADtSE5AXptyEcmpQ6JX6Cpd6iuyg7hIyCWBNuniU0uulMYBb50EYgl8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 KL1PR0601MB4291.apcprd06.prod.outlook.com (2603:1096:820:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 08:51:26 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.037; Fri, 14 Jul 2023
 08:51:26 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com (maintainer:MICROCHIP LAN966X ETHERNET
        DRIVER), "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        netdev@vger.kernel.org (open list:MICROCHIP LAN966X ETHERNET DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH net v3] net: lan966x: fix parameter check in two functions
Date:   Fri, 14 Jul 2023 16:51:15 +0800
Message-Id: <20230714085115.2379-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:404:e2::15) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|KL1PR0601MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a367aa-b114-4d46-cfe0-08db844781f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: en1cqslyXVTNBNWkQqDl9qRrob0+Z6AF594omJAKLIBwBIFtzGijuMfvvLx1imVwXgaJ0eQHacGYBq6sN0tWoNk6W52ZD20a57NWKcVgwOuJTNh3IG1OPia845AfJn/NM5z4p+99E8M0yCxTMmheWM8t2764CXuG8g1tgbBgHUX0TK8WFjwUId0EZzH6YTsCVMqQNbs/cciQ5QKyOluRrxV+oK0gxo9m1f1lqbuqWfja69Hi7aFuAjcykNGFVn946g+bgcthDFV3LOPnpjqs8okhgXKen9TKWiCKkBG8OjJO+zYIyAsASxAq9SK3AmcZ5S/LBC8mKGl+TCsa5ts8xU2tEVcrvyCtqyi466J8kt7lAqUodGPv2qer/TSITa/9E+OJWlEWngOHZCyyws62dens6K0xHuv3Dn+YVG1WwLRH5sbpdEVhmh1ukSaVJYfXuVZ/iO+SJqPGB0OjeQZjH0m2XZI/xkk+JcvVRfR0pKC/WIEMDiHMC8Sc3W2l+qNFxGnOzKFhyjn2wXlzCejx1lh8DFgBtBoBiBJnyqHLm/YfOb8tvWToItXh9OVSNj13siHO4pb7LqGEmFpBF7iPXgfKt5/Le+dT4OnV9NFJGJX6OUg2p+8IRO5mRZhaXm5y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(2906002)(38100700002)(38350700002)(6512007)(83380400001)(2616005)(186003)(107886003)(26005)(1076003)(6506007)(5660300002)(86362001)(8676002)(8936002)(36756003)(110136005)(478600001)(41300700001)(6486002)(52116002)(6666004)(316002)(4326008)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/vX4WCB0OCllJ26P6rEpqIrKhitVfQsOM4M/oYu64shrsrH2qZsJWoo5w1W5?=
 =?us-ascii?Q?OQ9EvLHZ+9W568RbmP67kL7p2k5ovBgQY+/zWfTJPNPoB1jJSNuck3emXrfX?=
 =?us-ascii?Q?S/ovrJ879aRsgRFOIJe+VNK0MSdRDniAxwAlwf5IqYz1G4gkP8l+wdA7L/A0?=
 =?us-ascii?Q?ArQJmGftQlWhmzk9XEdPruIv94/SekSkhDAoYOLUOGZJlPWNT97k3mlCCHps?=
 =?us-ascii?Q?G6oSm0vX4Hp4dbKXua+XQrOp/mKk49SAH6nZcRR5usvfS3PFttqHyOcBqf5Y?=
 =?us-ascii?Q?rJJxYbws8gumsVDrN5CiUNOFEiV+6n/yK2Ljw7a922w5Yal3cIdedq38eT7h?=
 =?us-ascii?Q?6KgqFXlcm4GMs1Yn1kh0fiQdpjWi83t25zUCsYFOx8AC/0JlDrUhoiNIF2Rc?=
 =?us-ascii?Q?7JNZLWv818OxqpLdKsj14SEMzbcMoczSWR72vkfWTUFeYvD3yhxSNqx0n5hO?=
 =?us-ascii?Q?9dJoTcdyhdmOe1DBJjxy+QroKBWK96czqhdfJ5FN1OIxPfHXEK2cjn80tUAT?=
 =?us-ascii?Q?FBNvph2PfHzhVSRau+uNBK9SvXDovbz1faZI3XbBR5uPKYmzY9bis3bCK4N+?=
 =?us-ascii?Q?c/+vwez7zaLOoo1P4Cc8g/p1wivWlGfxi6P9UWuBrq3Df52PElFNSYOYR5ye?=
 =?us-ascii?Q?jjd2TGKRRr3NAAXI4MwEFPL5vyhhMbTarM7snLQAMCu6+ZAJ396W2eEQuJ4k?=
 =?us-ascii?Q?M6gtZ/2uvW3DMGBtvz+hqOdgmkWMv/yYRqbr1241W0kYc43FwYxlT+wdxXmi?=
 =?us-ascii?Q?lhZNp5ZxBPc8AIsEp0n0GH4FZ0BahjmQG14f4C98jz2mNZvMB/pLBUm1WYtG?=
 =?us-ascii?Q?EhhQ/gXT8Rj5l8wtROhkaPFMdMhANaSbCXuZXjDLbJSbQNj4oMHdLnyvVBLZ?=
 =?us-ascii?Q?wvb16VetUnHgKsjXcK+PSPZ6s3xxyx58bbKQYtaK1QlgignfBuv+H1LAKUEU?=
 =?us-ascii?Q?ToeErh/SvsLG95y1Rvoh+azkIpn4KXS+WOJz2ic9UeUvB1UOcgkp0pUn8r/K?=
 =?us-ascii?Q?aX8oAUegcfhNdJIm1lfi0Q/Aq3aPXE+f/UBfupIffu+15m6XB9mJI0l02soL?=
 =?us-ascii?Q?aPb/d/o4rnGY0NPltrZpgTtE/TMEbQWU2rqA6JtRMU/fCfk5hyWovCnPrK1J?=
 =?us-ascii?Q?yBQsb3ka0jD6i4L6tBBrq0wpNfH+dS8imxcFC8PH4ketHheDIVbTRd9DGNJx?=
 =?us-ascii?Q?XOuaTAL6jA8ZPShlifryHPAmE+l+7srb5lsbOKV1xeklmJ31otGRKFafTAql?=
 =?us-ascii?Q?Mb3E4P0sB38TZMqFYUJR+fZ6e1zl+PLHCiqS7MTsJTvCODt/nCtQMvbG5XJJ?=
 =?us-ascii?Q?FMo6sWJAcDcDvFcnRuoCPU2GAR5P1LkBxxR5Pe0CVlLAyw2iVTTgkWHHwgVq?=
 =?us-ascii?Q?ea9Gg3i5dYTMESqZhpcu8jBjmwiUjiqWBCE0BSwFKSASfkDa9nt9YOYv8p/3?=
 =?us-ascii?Q?BVp9Czm1bMWtVcCW/neb6Xgq4LoTkTVcEUNJ4LXJvy66M31EAFDijEEZeIUa?=
 =?us-ascii?Q?9AM/OMw9Dzbrkr3p6TAi/MPuctLyaTPu09A9iP7GwXRtyLbCZYMScQHSTYBh?=
 =?us-ascii?Q?9j4Ag2cTif/B82eJV25WLrCOuHLWAdAuA14QG2s0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a367aa-b114-4d46-cfe0-08db844781f4
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 08:51:26.2754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6AieI4fprRBIyH8QQbvaJ92p033j3EL+zqjgeiEq9nDyaPxY5H50uX2ZO61yYXluX6/00B1/xOil1FILGa5CPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4291
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make IS_ERR_OR_NULL() judge the vcap_get_rule() function return.
in lan966x_ptp_add_trap() and lan966x_ptp_del_trap().

Fixes: 72df3489fb10 ("net: lan966x: Add ptp trap rules")
Signed-off-by: Minjie Du <duminjie@vivo.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
V2 -> V3: set the target tree in the subject and add 'Reviewed-by:' tag.
V1 -> V2: add Fixes tag.
V1: fix parameter check in two functions.
---
 drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
index 266a21a2d..59dd14247 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
@@ -59,7 +59,7 @@ static int lan966x_ptp_add_trap(struct lan966x_port *port,
 	int err;
 
 	vrule = vcap_get_rule(lan966x->vcap_ctrl, rule_id);
-	if (vrule) {
+	if (!IS_ERR_OR_NULL(vrule)) {
 		u32 value, mask;
 
 		/* Just modify the ingress port mask and exit */
@@ -106,7 +106,7 @@ static int lan966x_ptp_del_trap(struct lan966x_port *port,
 	int err;
 
 	vrule = vcap_get_rule(lan966x->vcap_ctrl, rule_id);
-	if (!vrule)
+	if (IS_ERR_OR_NULL(vrule))
 		return -EEXIST;
 
 	vcap_rule_get_key_u32(vrule, VCAP_KF_IF_IGR_PORT_MASK, &value, &mask);
-- 
2.39.0

