Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778DF751C6B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbjGMI7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbjGMI7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:59:22 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2116.outbound.protection.outlook.com [40.107.255.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F18AB0;
        Thu, 13 Jul 2023 01:59:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4XqaN06+RI4/AoaveWIFNaNpCPrvC3Eh9yHEi0F5aUROUa/sDSo/c3hVLvyK57IhrmuRD2oKYWK7MXOrQ7EDVypw1a0goIk07MSoziNImQTGx8XlNECP7x61Q+eIGAeOuyp7JgGweHLP0YcsNlOdrw1gIMN5Y7tckYKmdyaau9z4tjeSd4Dt3ovEMKI256p2O+8b+EBxs6G1dwEuvGwW5Vu+4449FJ5ltkaZOQd8e89MX3qmH+lcH9QDuUfEaQaYX+ZC8gOtkEJL+nQuYVZaUTua1DAfd9jmW6hPXE/UldbuQ1ur7NWWtYGs+GYHGyzXUcwPMC/OHrq0B2nCm580w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5LE0cpv3OxvSJiIVM4ed2wkE+I0ImGMGvUXgAc/oxY=;
 b=fXQLarOqXhouVV0En4fR4jQcsY/z0xkzGi+6PWV6JdYWKs8NhE/B6FGseMNA5qeTUYR4cKf7nGVGYSLy3mcrI/BpgsfCscvcQaluK61C7M/KnUj3b8cRgXtD5z7GvRv0svfTUoeoyuY0AfPBA0tvvImpCDqzb6LrsGEuPUxYYK1QQAbIKviZTvxhBSPqvHnoFDwR8OHcmDSB6EccGfvIy3tGJgryypVmRniSgKI7et9QbWBTwHaQo4cQdp/7Jp0cNzXkW38DMvQlW44VW2nBFYbl3uNGz8SgVTblUT0rEn6MM+QjaP+2NxgI+izd9M1o0F6CMhOTmIUTPwSZhWaeHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5LE0cpv3OxvSJiIVM4ed2wkE+I0ImGMGvUXgAc/oxY=;
 b=iRwiwUfxfUKdg+hkgzQtzPPyOYm5VNhtmkhWU4D2EICal2bX16GWBmIGwt1PXgDxKg4pLG0lU0hYgle87ziTq+51E2Vf1GQ56hWkGvsswDgB2DyVhQHqZBhy/3+M1PDDU7LVDD36wdvSXtbouVkfrx3UGEUsR3hq5rYiiOCfFnAVGE8zNEGxQLCMyGHgmnzNLKwZrzh9Txppp/oCjWwB7dR6iRRAvox818ETkOKpnMc5bwQqSN6Q+5sM/WlDsuRbbcpzsDAvl3OG7hl7dov0WXasWk5KDQ4TL0VCWGOEMva+Dgeix9SO6nHG3VW/PHY5GT7Lg+N0nNvhR2j4IYZXcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 PUZPR06MB6055.apcprd06.prod.outlook.com (2603:1096:301:106::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Thu, 13 Jul
 2023 08:59:16 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:59:16 +0000
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
Subject: [PATCH v1] net: lan966x: fix parameter check in two functions
Date:   Thu, 13 Jul 2023 16:59:08 +0800
Message-Id: <20230713085908.12113-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0113.apcprd02.prod.outlook.com
 (2603:1096:4:92::29) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|PUZPR06MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: 08143d98-ea92-4de0-880c-08db837f6fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wbJsxWzHD6tYWI+QZEXcnvIjiVTrolsxmjqdl6nEiXoZZMkJgz1uT66JPydVSC7cHUuNI5KdOuaMYs3A9uuG0MokWZA5Gd1g3gBDabSoXHwRczc33RYwQTLJi/d6jHmXackAu0HIHNsiCDed5OiRvm3vNNtOBixLnYPmhrnEg7x/DqpBHK2nXJ1X+9Z9B/9HtxY0dbAXcmHkMnj3M2Ja7Pwc4sCOwl7U04pbInPSTacTckFO5n2zgBOrOu1squAqFn4svtVFKlA2xLor+UUeJg9joD3baOIMue1bhCy9hyLofNlmYSquz9HMwzsOSn3ouyHHfwIB2KuT4oCKdlBVyHTGSZCRyq+rENChvvd5K8yTEhgRsG7Sx7pg8oLDMkFmS6h31RN9jXqrYMM+xCSc/ru4vq+MsgyHI7XQM4sdbyxxawWCuvo9RoZmLo0IBB6MJ/VcM+9KqUI60xtlYQKi1e8tffKuvtP2uJeRLo4EokeaPLf/snBE/8Kc8Si/S5K7lAlN6zCPGH9qHpQ1CxM3ZZ6dZlvqBVSAGLMPBjHtNi7Olf+/VXK4CK2xMvqY2K01do5mSe8qUGFbUZkFQOIhUDhK+ICtwNwLwKkZ4dJuI8KJJSUnOimsbPXRbMtX0mjb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199021)(186003)(2616005)(6506007)(2906002)(6512007)(478600001)(26005)(1076003)(107886003)(83380400001)(4326008)(41300700001)(66556008)(66476007)(5660300002)(316002)(8676002)(8936002)(66946007)(6486002)(52116002)(6666004)(36756003)(110136005)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h7rRM9dO6Fd04w6g4zGYxtxIn9a8zP4gDl+tlXkZxvvO/tuH02tTKecuhaHk?=
 =?us-ascii?Q?iUQl586qBDux1eJqmvQ7ymS3rGta3CAxFHT+TtGGyU+9elfogXd0ktmt4jl7?=
 =?us-ascii?Q?dI7FYn/zt/49lfG8sn/pKUPcIvVhy+8GRsFK/wruogKaR5bXq4uXJNPOrKX/?=
 =?us-ascii?Q?sHpAS/0JLUmU2ZGZbPVnyx1OjSJyPColI10Qef+og5BZjEw672dk7JrkB2TW?=
 =?us-ascii?Q?vH82S53ApjnyYxpXuVuuwyYlFsYl58Enjp81YYlZAraamWT/jE4hmzEGJQ9Y?=
 =?us-ascii?Q?O4h5KLEGVrdbR+uD5OzOsPu8rcL2ZYq1f+0O1+QqoFA+Oxu9trWCoZuaH7MC?=
 =?us-ascii?Q?HmHZxYwkdvILp6kkyMC6s0g4IvOsg8nH6lS3PS3MAvBpDkPg011L3AKWF6wo?=
 =?us-ascii?Q?p1PYjAurEXoGnRnqEMMMyxstcbEM4xkRdff3TP+yedcqJfcE8bob9o7qMrac?=
 =?us-ascii?Q?/1fXAEmOkzjwCOuCGZDvOBoaRyCqwjhHz7hlpiZa3rrE9tbo1uOfFeIeXNcn?=
 =?us-ascii?Q?RaBMYlTDw/eggSi3VzDxOrrQXNjs8wbj8378OD5ecScOc7ckk7TQcJ/IdZ/L?=
 =?us-ascii?Q?yI2eitTZXCfnzn/QP2cxAX2CSanlRP3mDgy2vgYTdlGvHUCj8aA/KLuUSxOk?=
 =?us-ascii?Q?oAbzjISY3d+vyyrsH/xTqslc4LilrBO9OsljD4o48Be36tIjEt5oJ0hgH39H?=
 =?us-ascii?Q?Wt1YWRUJfm0OSc/QApNRb0FVdb6t0F086HE1oWFvGVrayHvgsLUTSWMRc+6U?=
 =?us-ascii?Q?y02PLLINMOrB0ys5zT9Yvu/BHH7HTXypw0vnLfBW/A2iIzJm8kwgj7gC3wWa?=
 =?us-ascii?Q?AWNucxHtNQhGHLEt5cZqTAF9zYpjRO+cLQNmvau0ZdEztBfBc80XRO6XPb3B?=
 =?us-ascii?Q?m+C5a+B3qNR02pB72NbA1TIQnjrBIlQ2oBjYLT5dH53xM3o7pRn7ZRMWRZaL?=
 =?us-ascii?Q?YRmliaKZo6QkdxfTY+hUiEjez96WZcxhyBytfRFjzMiSEw+HxtG5edUT295C?=
 =?us-ascii?Q?XrkulvL+2duegfnHTVQS1TageAQELoijJ1fR5JrWT0OS1bVAYzPRyfBghi20?=
 =?us-ascii?Q?T6cAWX9Y77iS6v2uh9pH+SGSnOyc1N+eZSdS2LhzYM7sJTw74gAvuZSZNY7I?=
 =?us-ascii?Q?IifxaC00dUaE0AQ/ppxeGRc1Mrz3zdinvpH8Z5h/dN0FrNS7ecBH2e9KTHV0?=
 =?us-ascii?Q?JbGu10UqN56ZyKbUiXO5FOeo+Y7jL5aRbr3v5DPZ+jiJnjdTdLQ/U8u34vlW?=
 =?us-ascii?Q?shQN5C5P3Ml9ZzXVVjo7OMpsqhLmH4bmhxPrepF1RbZ1X+pcny6dLOzBjoDJ?=
 =?us-ascii?Q?qklzlRzVUlTLWeVh1lzHU9aGDTIVf5pgWug2MDwVgPED0cQovZuWEc4yqMK4?=
 =?us-ascii?Q?H2OAkPbAWvhaqr1NuuHHoCxaXWcv4R9QzC+yNNo1NQPf2RK1KnkRKfqXiHzu?=
 =?us-ascii?Q?NAN2686m7/EZuBSee26Y3+NJ2LnxwZCpicX/Hsu7zDgzku2oPClH4S657JPX?=
 =?us-ascii?Q?rJ2INZPsCwQDtBJjtros0VjsWc1To8fQAVDkfS5PDassNrkRv1Gx87Gxbe7f?=
 =?us-ascii?Q?zRKIlBeAWn135Tkf6vxZomKqV9c2RglgI2MLiJoM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08143d98-ea92-4de0-880c-08db837f6fba
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:59:16.3362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9TmHBzpIdKhlgVN9TsfGjaIHPs9lRVezjI9hFp734CBK8mWCfo4VOja8NKM1491TTsUHlUPqW3NCSgGf497iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6055
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make IS_ERR_OR_NULL() judge the vcap_get_rule() function return
in lan966x_ptp_add_trap() and lan966x_ptp_del_trap().

Signed-off-by: Minjie Du <duminjie@vivo.com>
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

