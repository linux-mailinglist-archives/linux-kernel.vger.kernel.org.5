Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744BC755FEC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjGQJ7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjGQJ7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:59:50 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2112.outbound.protection.outlook.com [40.107.215.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD07186;
        Mon, 17 Jul 2023 02:59:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhgfKXD9/0ACWxzHvKRsKRhIKa660cpUW5Uy8ECJztD8WDd3eoJcHiQBhEgYdzH+t5IW02vSO9UYFBQeTqQi9RIeLfVAtnTq1PP6rat68a8j+pEyyVVRP6dnDOB9tZYTLq5QRXxA4yDMwL9ruw1J7U77vuZb4cMt74Lscbfr4OC9FShBcK0/LqfngA+g9CgZCSKXws+QcJLtuswe2whjMttjCjMxj4EEFob0+vvBQuOaXmPxPefiGil6EHFApeJbOIOWBvgwCbrS63xWojJMit9tjoexuHbRA0wq7q6qz6bqkvpyrSBkRj7M+7oD7TkHeKtT2iYh9Q5l/blKuB33iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aW72oikfy6WLi3q3W/J0rJZArfwsMvuH2MqrU42/2Xc=;
 b=IB5CehlZ/QwuI2fOtajNJUY7jgw+x3ecQb2o4rot7D3ajVrkdonphxciOUqKa721A3icJbddGKBNnfPBTnffXJLas9YUCZZSK1I0jfW9NyiE7tVN9469PuECm1ALxn5oCEE8pxzQsTiNEaQ3hWUjF0iR/XQy4TvIBgHaycdQlQ3Ikrvuw5YHIDqPq/43tR5x4vPaJA38B8e/UPVOkKKyKOGP31/yRlpYWHf3Q+0MEVopM6v9KSbBCZM0JIt8+kPruxnZxhDKohlYfDjC9zcD2OVY6Pm5sbnU9FzeDAzq8WyRldIV6rbAFCNdtIpU/ctRz7gKkabEu4MDs/uwzUPZPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aW72oikfy6WLi3q3W/J0rJZArfwsMvuH2MqrU42/2Xc=;
 b=fPO/m8EoposyiMwHy5fJTh162eVQ+soA9BihixIAujxWW5P5+B5PV+3zCnDY6c+h2j93qUmNk/ZggDorMU98RlzhvC11/HBbiR9FP5vNyudy6hrBReuf52UpukvdbZ/deNaG8lTLMY/G9c4By0h/vEZ+LmPhFN1JbBGiQEfXJLUweQMZOmONbbwl26zToykD/gE1jqb5y0gwesny4iGzXsmgl8fGvojng2wYNnIpCB7eulff6FWL14yYx0QOHj09YQ+zIT+dMLpt33Ia+bYvH/7mUgFavO7z6ieOXcAj7X8dxpukY5R4D3CITF2aZVFz51jGossfgiYkiUmXpNOngg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 PUZPR06MB5825.apcprd06.prod.outlook.com (2603:1096:301:e9::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Mon, 17 Jul 2023 09:59:42 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 09:59:42 +0000
From:   Wang Ming <machel@vivo.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH net v1] net: ipv4: Use kfree_sensitive instead of kfree
Date:   Mon, 17 Jul 2023 17:59:19 +0800
Message-Id: <20230717095932.18677-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0043.jpnprd01.prod.outlook.com
 (2603:1096:405:1::31) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|PUZPR06MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: df48cdb4-e192-4822-21e5-08db86ac8a69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yaxWLiu5MHyo/KC8bInUJPyCVyDRHgviOp+ACl9fNoMF5B52tfmrKYZ0pkCURWpQmoWri7vhfawjA9UxSuIAi58Mbc/5NKMUomT1xwqLufxp5F7g/F/Cog/8ep0UPA9HEAJ0C+yRKTZ1jAD/GS6PBj7svRKdsCflnPhozpcwy1F71QfnzIdmGzZf8eXXkGVWDmq4muhxUH7cYDeBrwQVN1wABotf/+TClubOydFIjTrEl9kNGY7Lf3+Pzd81L8MVSZfhZ8QJEueCT136y9WWCJ1kyXXLRv30Non9W66gGCBbSqPZXMuTcFObMXLbt+jsI4imD6Vx0RfiWk2rZsWGfElcQnGDX2pUIQkadehsmxaDpdn54hlYM++T81Tu1QRPD4OGQJ4Mm5+nAyQma+mxaroLJwtJlnYkW66rif6W5zfaMxHAsPU/8Z74OKdN5a32AxglF6xkwTe7q8erKIQo0B+dsm8uWJ/Zfm/Vf7yiBe++vbyYWnYugBp7yxPQpUtfDyoDppjw8H5t4Er0a689+30Sxduggq/CrOFPFvnzuy8Z611Eh0aW7KC400HHmDoBTrFWk8MKsmZvu5UsuQk8DukMXZiEpXWpQZmHQHS0FlnsCFRuCpH6g/YzdMD92p5Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199021)(2906002)(38100700002)(86362001)(38350700002)(6512007)(83380400001)(107886003)(2616005)(186003)(1076003)(26005)(6506007)(5660300002)(36756003)(4744005)(8676002)(8936002)(478600001)(6486002)(110136005)(52116002)(6666004)(316002)(41300700001)(66476007)(66556008)(4326008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qy9y8lZEVI1Qm1D5StDmMqqQgIUDHGw+19sAJMvuD2SiUhamCoJqOAthLyYr?=
 =?us-ascii?Q?2IGjrQxfX7QEoSszXSokpALjukxhPRYkV2ANg0f2tDtD1YhfmHu7+tZH9YYA?=
 =?us-ascii?Q?eZQhpMsQgVyWunoOz0TNgedeyjXWYWJgZpPGxE0vOVau/HUqpxBkfU4T645b?=
 =?us-ascii?Q?fG4SLFvHb/UOkSn4zqBj57Y1uy6qiHG2ohcaUiPUAeCdNc655PZLjRZBu3AL?=
 =?us-ascii?Q?fsNfsO1YajfM0Tuz8+4b9mg7s4aHjOSPjpN0eSKOeuVEMeFL6Jv1mnm0Ojql?=
 =?us-ascii?Q?zpKM1a3uWVAw9vtJJZB7FjxDK+TsAhvAW5tL2SplHvYCLuR34zt5qXXE5GzP?=
 =?us-ascii?Q?vNg9BpqEuFsx0CtGdEaxXUxkenJDYkwDvX+6gnr12A0kPF4n33fRYMcA55ad?=
 =?us-ascii?Q?G7cn4BAE1ZSeSsX5XcTXMcET9GyNK2nyorluYZpwv6InWo6JNxl6yDVzVLtQ?=
 =?us-ascii?Q?2FWOC3fse40/W80IXmGDuSNEb8sjxE7p9iM56M7UWDwmW/7B6z9+djxrC/6h?=
 =?us-ascii?Q?YGrS4m64Ng6a2KKRdw7drdKvOc68G9LHxqCPi8ke/NSt35gOLJlGqqDWppGQ?=
 =?us-ascii?Q?OXu+KwmdVe1BbGlTLUq8CfzQvhOfJoguX5IlnBfMcuFtB3vs04z8PanUbrnb?=
 =?us-ascii?Q?8FvgH946xkNnIHsNasX1OAFvZw56OVw3civ96NlOQ/MIYFR4W3coQD9KedjG?=
 =?us-ascii?Q?MxiA0U0rq/2eEs+TirV+2xLnIYmpboUnWJRgBo46SlNtdLq96hl94JaxW1pB?=
 =?us-ascii?Q?qnvRwXrprQ/dimLQbrTK+4tq5O31N8ff0MB/UefQMSbb6FXNZAMo6s/KXz24?=
 =?us-ascii?Q?M4SuzCLUu9op1XLtr6hF3JiLhjS63UJxXvXX4KfZZKDaZ+Sa+J0LPeHL22cf?=
 =?us-ascii?Q?1xst4b99X1b7FBRt9PukOiKX76CtSWHu5Ie0ET+eMmXOqjI06hAbrRjGZeso?=
 =?us-ascii?Q?3LfdMUsy+DKIGt/IAngihPPzOFQZfxfykIatsHfa2cJCaI7CC18aZXwcKkld?=
 =?us-ascii?Q?DV4R9p6PMcG4L9tQ4gWMYgTnLRjXgCFs7prkAouknXRJrVgYLoG8i1fH6PLl?=
 =?us-ascii?Q?ZZPWiHTm8xvjUZfVaCdp5jO87QSdymLepn8/sI0rEF9KEXdoqgojZVqfvjvj?=
 =?us-ascii?Q?j5jkKzTisytPdxnAmIvV6nBeIXDpvhZtpH8oRIP9KT57XZI+JSvThXDyl/2g?=
 =?us-ascii?Q?PTNFUbTp8GkAyAo6CtBYiPDct91GZcMQ8mP9XmNNm9r0iiqtynlSgC6xPXFB?=
 =?us-ascii?Q?TFoZwbSY+/MfUZZ/S+m2+h4ZTB4nEp9h8n4xEsBc06PsJljELhZG9CgzUbUp?=
 =?us-ascii?Q?5bsct7HcaL50smwTPh1aTeAuJrV3iDr1kiuFjyh1wIQUu3rttlUJTDwEdt44?=
 =?us-ascii?Q?nZDMCiB3/PxituznF5Cx7k0SRfKhyq6y2kQQgyqxVDTQfUCl3JCSSGi8dWiX?=
 =?us-ascii?Q?H6N4LTXPT3jkA9Zxf8tEt7yivCS8a8uK7vj1Q2DKGpHSZTyAmVgbyzH7Dw51?=
 =?us-ascii?Q?HupjznhWJppuhiuwBys+yrlA7UYNoTbCGBMRow1UJHfZmh6lEiMOv6qhyfv9?=
 =?us-ascii?Q?4S8KJ3MsYUVPDpCz1aAAfXmmTab8N82Z5WCNtMmF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df48cdb4-e192-4822-21e5-08db86ac8a69
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 09:59:41.9902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlLmlClhFMvY3IrXlwIXw+BqecYrkk55kVDn0PUWiKGGZ2b9cc5OoSemPQeXB9KuTQa9EkCmPtpxfyIPp8G0hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5825
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

key might contain private part of the key, so better use
kfree_sensitive to free it.

Fixes: 38320c70d282 ("[IPSEC]: Use crypto_aead and authenc in ESP")
Signed-off-by: Wang Ming <machel@vivo.com>
---
 net/ipv4/esp4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index ba06ed42e428..2be2d4922557 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -1132,7 +1132,7 @@ static int esp_init_authenc(struct xfrm_state *x,
 	err = crypto_aead_setkey(aead, key, keylen);
 
 free_key:
-	kfree(key);
+	kfree_sensitive(key);
 
 error:
 	return err;
-- 
2.25.1

