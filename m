Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C23755D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjGQHmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjGQHmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:42:20 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2131.outbound.protection.outlook.com [40.107.215.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1C8E7F;
        Mon, 17 Jul 2023 00:42:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPEM+ysneL4RXDd3smC8jEE6R+AYOLmkkEiWXpC26g6mN78g81ub2kCGhU0vcguu4OzQzVXCXfq+CNq6AOWXdrG89Pmh6WLY76i7TUNd9meltosRcgnzmBWMgLt/hfZM3F/yIjMNJayAfkZTmeUtry8BvevzlOddxS5/IGd4EAM+I6WGsHR5rzDOmr3yDiXqvrc4E2vclvnCJph/ZQWPXVtaHBGkjIVsS6hR4y1PDM672Y+noeXSn/+T4HOSfchvh1825+4uwYfKy2XTEt0LiHIqLc9gWLeiS05cvfMXtCgVZIwb0oPqlApEbgeUoVYapBxYCzHA0UdPwqFX9rQuDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYvdQqLiSpjTzRjR86WEtD8P1S/DaJZ3VFTpFg3rl7E=;
 b=BDHzbOC+v5VqT3Pllw0Yjko3ZIz+nPzRaF75PY/ASOEIP8kV8+K9+8SAsIk9Ootyk7yLPnWfoQljh+t79hDOMZFF0YskoOM1o/1zv+cvL9BNLJfVlbE4fU7gBMjzij4E8PGZ/DrM2k5LuXbA8wewDTvlYxSf7NDxXd8of4rJZ9eFvWlCcJoc6qzmKJDay8xXK/7H+KBcQUV40s1NyO8K9zmMcUxYD/MLOYl1qTeCm10Omwpk1QivIlgBD/GhhFk6akq2RhGPcEiCU3kJFdrw0oXv1tq599TpHc/aHHBhf3GP7NeeeMgnBA4AhyWRrY/DXv58UrK0slBdrn0tl98gZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYvdQqLiSpjTzRjR86WEtD8P1S/DaJZ3VFTpFg3rl7E=;
 b=LxPxWWtsIs90UAGoJxur8BhHH7QNWOSOVgn4HmtYwMJ49mY5mpPSfyu4YNzYHv/wd+//7c71t17f/vxI2ir95t93oPij8WWK6NSupDx1Ab75KznLSCEy4w4VTNFvKGofsly8rDAbr8Ud2ufohtQYB5mFCFDeuL2ruknLAwASdYMcBsQdOi6P8H/qk6XGNzV/DwZxfTk60s5OtqOvCyaH5KOmmeveFLz1AsOQgIhV+ENMMywwqTIMYc2OGjpImN3Avz6Ro1jyf6WeUOta4HbV/T1V6djsG7f3mThT05hOBWYzMhpRjVTcAfBlWGJuOH6I6Gh9i04Fv8LSFUmMYemFTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 SEYPR06MB6482.apcprd06.prod.outlook.com (2603:1096:101:178::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 07:42:08 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.037; Mon, 17 Jul 2023
 07:42:08 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-crypto@vger.kernel.org (open list:CRYPTO API),
        linux-s390@vger.kernel.org (open list:S390 ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] s390/crypto: use kfree_sensitive in _free_kb_keybuf()
Date:   Mon, 17 Jul 2023 15:41:12 +0800
Message-Id: <20230717074112.6580-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:404:a6::34) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|SEYPR06MB6482:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b7fde7-cc43-48fc-33ad-08db8699530c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +AuV7ktdDfvqHliRFU3VlpF1AsQk+yDAalduueiGnL6op6aC+4WsGMjmAZsqqtOckav3Y0VroTpMr4GKMhRBlZ/LW4jlmXSTwah8h+mXm13rCaOqxQ+6W82ihrPyjkMxbL/yrs3D8wJ3Gp5DO+Jho+LF7C0DuSa4dsPmucMp7D06/5zAiZrF8PCjuvYiVZWssSc6D/QxfVtvGCO7LCUq6MbR65gx/XiLc1xoFCYPMK3ZekeBnytyX0DEtGSyBkTyGZwGb17gT9R5U6BNA2gZ3oMqZRF1EznnCvvCHxUdR+khzB73FtCslqYOFTB6s8vtzlwGXnyTvCAzDg1/ycqkN6pHytW+uz3uYHxnd6nDcTyWbGItMifGWgC/JXQ3hth1KykNn6+hFwYkXGEY240MrlEWy88UPg80pU8HYlKjBNNGTvCw4MjHLPMiur3bgqR4Dsv2tOXis+Cwsu9V93CAcDdb80HRImNYDt4qb2DUdN7bN0HrMvRIA0WtAiwedU769pnyGs43/Lthe88OU7BrBER82qbbORgBpYEsfrUbmGNLngydQVikG7JuUeREaPohfdPrFEQ22iA1TVIQX9xRqvnd6QzhEnQd0OvxfKWn9ygh35yJU0u3pjo12GMgzZBTf0PgOY5QKXeGDFihvWOznQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199021)(6486002)(107886003)(52116002)(26005)(1076003)(6506007)(6512007)(36756003)(2616005)(83380400001)(38350700002)(86362001)(38100700002)(186003)(921005)(8936002)(8676002)(4744005)(2906002)(41300700001)(478600001)(7416002)(5660300002)(4326008)(316002)(66556008)(66476007)(66946007)(110136005)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8ua7Bbjs+fa7pulPgOEvDuXS56ERQUHApJxluf1s/O15nPMGmR7Zg0f+jjC1?=
 =?us-ascii?Q?nPaqQxInopzusZ/G1nhih9II09ax925JHkTsU5QaYOBlk78uSlaVaBjjI8TU?=
 =?us-ascii?Q?i1zD+dbCIgZzRJncKV7n2VeIzIR9gUfQffRRg+KWMbvP2ThOBK3nhXlyTPoy?=
 =?us-ascii?Q?Isp0Ime/v1Tkx4hTNrZiXFduMmdMkYgasAVTnOiJoLkH3CEdfLnXj+YQ9sVh?=
 =?us-ascii?Q?MLePRAlmBkz0+qO74vXTLwX9XAmp+UpixSJt0vJGF2Z2PQQpVuWLnCeRnWt4?=
 =?us-ascii?Q?XQ35hGGdSrYHGpZAaQuEEdNRpFCXgA+Jo8WEGqXujlN8jZbFaoSr4cs7Yrun?=
 =?us-ascii?Q?nO5VJF7H2vvfsqA/qec24lSRbUYWCEWRYs17m6EjJaLqFk8wPQ6f7wq3lZ/D?=
 =?us-ascii?Q?p/S6vWktmqb06sRqYl9DDPeiiqTz8/eeZQsDtq/bq03DLkRLH/a6cXKFKrx5?=
 =?us-ascii?Q?y+Gq71EAkISOyi10iytdpRuNWYDTCfQWK5WicpHSeQIbUugfzlTzeFGxMbw+?=
 =?us-ascii?Q?FBR8GK7fYzRUMdUsK5IjO/S1ym/siN2rZo3JLF0SKTdWknFar94HKH0xi72S?=
 =?us-ascii?Q?Sln/le56V1/Q7bgyYs6Q2SAraCQ8erwhwWb/UqlBOBEl+JuEvaFgWi4ZmbaN?=
 =?us-ascii?Q?YI9y7xVsPD+VGSD82KQakU9o/JLfe8Ek+OA7U/fPAHBnbkWs+BzRCB++oNXa?=
 =?us-ascii?Q?3wUhEGRjN0Mp0x5+E+H0MMRcmQoZh/zgPS/zgbWRnoOevRrhOUXU7zferp+G?=
 =?us-ascii?Q?J+kW9dNHU2S+YFRS3CLvPdP6x/xrgK4ZxPMm7SenVlY68HW+6btMhb78LX3m?=
 =?us-ascii?Q?eobv3izMD7nVzWVjnDjDTHSE3Wk+CO35b3YwSMHbNAUEU0zEF4WXUmuDN1JT?=
 =?us-ascii?Q?K4HfYlAGs3x5a0McpY5Mwab5sdZWb3xsutX75qWP6W6lyWQErMiH3HVPODq9?=
 =?us-ascii?Q?YOZiYq1NdPPGxQ0MLKuQiW+59mHu1LiLlp+QKruN/MqcXo4IsCzW/rkrZkNW?=
 =?us-ascii?Q?cuIyT3uCulXGIQK4/dpdUTrgMa+w54Tg5Jiw03sO5IXUG42/hjiFKR0Pw37y?=
 =?us-ascii?Q?Q6y/xsEGpcbaUt44LHn5qb7gez8Xb30QNilPndRRsoZC34gQLnPJKKUQU9ZN?=
 =?us-ascii?Q?DnGpJ9oS1cu/zLdh2xDyw/GWqaGYr2jjUgP8RrSQTXmepFjB8U/kFdmrpldY?=
 =?us-ascii?Q?ESK3zM8T12qFyAHwdrfXY2dRMn0F6Vno4NY1pbPL5eQ4K+I1zrWgegH4BrgN?=
 =?us-ascii?Q?gA2xD47m9FYbeE4MKnO/QPqVPADPTf4Mo3TqmXuJpE11/X0k1E2aBEtgTx+x?=
 =?us-ascii?Q?1MidbfSA99jbMMIzmpYNFfVjLjRWyYEG8GwwjnTM31zygZDZcjPZEV1DZsBL?=
 =?us-ascii?Q?Qym0nGpV6xOyZqe6sV2ffzzB4CGmkhp1YuXsE0ZcYeehFs1nUePMadAHZP3I?=
 =?us-ascii?Q?6/CrLpQehMOxbmd3dNFLX0MdAqMxVt5Dvz9ZMz5m3g8OGYAIA5G/n2F5zR4g?=
 =?us-ascii?Q?Zq8gVpQPDJ9I41VsUcXzHYvnB6R+jrhS3uV64+clc083miIn1ThBdNoPcgOg?=
 =?us-ascii?Q?Ku/dEqh45BE8UNZ/qrJPr1pUPoSAIgLTCFdUzd1J?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b7fde7-cc43-48fc-33ad-08db8699530c
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 07:42:08.7077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: toHQTy0DRfZrtYMYm95ZId3o8aG6Dj9dv9+i+gdc0U568U3gTzNgwiZ4yfgMuunFPcGunAV/Cn0dtXUzt/Vj/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6482
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

key might contain private part of the key, so better use
kfree_sensitive to free it.


Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 arch/s390/crypto/paes_s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index d29a9d908..38349150c 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -103,7 +103,7 @@ static inline void _free_kb_keybuf(struct key_blob *kb)
 {
 	if (kb->key && kb->key != kb->keybuf
 	    && kb->keylen > sizeof(kb->keybuf)) {
-		kfree(kb->key);
+		kfree_sensitive(kb->key);
 		kb->key = NULL;
 	}
 }
-- 
2.39.0

