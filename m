Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6439B7635D3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjGZMFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjGZMFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:05:35 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2122.outbound.protection.outlook.com [40.107.215.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC91E0;
        Wed, 26 Jul 2023 05:05:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cG7pSGaDW97WSzLyLM+cMHBI0F3B5sxJbQE0VbmBk+lfk/PXCpfczVQiYKEAhCVXpzq0v3KVe4sxCvUMjPYtSYBzTmeaLutj3h/vXjeF+5pCybSl2PXICa5SHy0sepZf5NJQkfBqENsh2SBkKxNxl8dHr+RkvEt4xG0mRXt5GB+lYnTHK4+bxtAW72J30WY/6ZxfHR5GaqnavFzeihNgzCXmYZ120Z7D0DyGVsnRgOjSsb4ud/EIMZOJ2b2mnrgTAClRW/HCC/9O7ikhE22/F2Rg8B2GWQM74fM5Euw+hrTrD9d3r8PaHOYDXXQ7v2I9jRCCL/fScoHNmgCCI3RrFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5GnVBQE7IslcuyDauE1F7Eu/S54PVvS3btDX6SqEb0=;
 b=LDvf0112hHUqaJE2EMm+FGwzMUotsqt/JI0qnpPQvn76bHt9m36xr/ipea+lvXPQK0M4dj2w30LcF00z+5sjJ6BMzMaGqeY03RpKVx1VSX9ACffZq5EcnOYS6lpt2qQH5QYbQ5c+pgG25cnHG9wwWVeQwkH5iKY5oLWQxmCKHKWsT2+3s7AgX3XvBfTml3GAlKkG+MvssqEwFddTvaFmNGAm6ERKHKtGYeJONGD7H3+fcd5jcngfoQTi7aImyWFJ6SMvTXlGu67/0GoN4DTpN6GOSq9cFb23ZWAOaQWbUv7QMq7FurgaB2lHob/vu0gq7QEO410H6H30/hThXZB9Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5GnVBQE7IslcuyDauE1F7Eu/S54PVvS3btDX6SqEb0=;
 b=qsxiIMXC7k1owo6WBhtxIry+/DdesrAvnB5TGl16zFSR8tTAZNf91X9km/s1wHuhNlQ6Z7RIUHKh4sRVoVxo7BVzWDQt6sV7HuJ+7rV0ACbfI/L5jO5LitYJcC/TpjogiYVDOobnaZqYUznpQsrgTgi4rBon09cHOZbbobdaQr1ySBNOJ4Qa0JPiGxITKOOQIv39XZ5TS1mmoL0+P9QjsG6A+d0hLYb6A/QaibYrEIB7VRvoLEiMDjDQWTkR49tdsFnFMXM9PJSqGxmK5+UWf3YzsgYxWknGEt+zjYXIzbtgkKlCqEfJs9RVzPSXsLAuSRwuaKPuLwLQSOcB2yYH/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 KL1PR06MB6580.apcprd06.prod.outlook.com (2603:1096:820:ef::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Wed, 26 Jul 2023 12:05:31 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::535e:25af:a3bc:d600]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::535e:25af:a3bc:d600%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 12:05:29 +0000
From:   Wang Ming <machel@vivo.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v2] crypto: atmel: Use dev_err_probe instead of dev_err
Date:   Wed, 26 Jul 2023 20:04:41 +0800
Message-Id: <20230726120451.6099-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0119.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::35) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|KL1PR06MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e6d24f-946c-4d46-5800-08db8dd09aa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SFAxxzxJufwooNOFleqOacEagTHaXgFQtV9cCHL0xUCJud+8uOVGhSOA5W5GAVN9X3AG4SeaSEG3TTirAUydf32PCrmteGj5k36UG5a+c0GNm2POsV/xtuYgEP05KAteVRLydYLekWL1IuZYEn5SQz+Yk758q7Zxeq4di+IQrUUG5GAfOElwhOXuZ+COoEKrK4bZiv1BqNScR+8zhlU8ADftrohGVQhGQINCYHLHNokwxKLk3Q8xEFAqiE/rd7P1NoWNpN4cOeBa7rfw46y0uIoUZXASKPXxXSInJPvvfL4Bo0QLAJV4oJPxZz81rQ95iSl5jdHWQUXgGpaEG6caw93cF4+WwlyNonKXxqwDXjK1Vrd10veueH6uxFgNaCjMtlDe+mC0AYPwJHuH/6zozgNhJYcHXbopW0pEDymAb5YH9DkdRvW9morriwojt5MUU1Am0gsLFD9F8K+tJjb7rO2wmEFMN4CwThG2MYGdUgt9w2sWVPch6VXV4vRTCwIuojBe88ezeGp1bRK/vQd14mJbNjt0MtO7IhKuDVxCZUApebeGpCAJvV1QghQLRNt6+8iQL38t5HxZEZC2oMWH1YRUMfIwNJeyhPU5dPUL2gZ7Bevlhays3UvjftzaGhVs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199021)(6506007)(1076003)(83380400001)(26005)(2616005)(8936002)(5660300002)(8676002)(186003)(86362001)(107886003)(41300700001)(6512007)(6666004)(478600001)(52116002)(36756003)(6486002)(2906002)(110136005)(38100700002)(316002)(38350700002)(4744005)(4326008)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HVj4Y/5IdqbYd12IL0dspUApot3Swo6KKj5mPmGjU9Usxg+rX2cNkflLaieS?=
 =?us-ascii?Q?j7QpVeg6zyLcbEuLLlcYqNRaZNcQM/CleJiOEOp6ryOSNK+5gQP7qt2Xa7/3?=
 =?us-ascii?Q?MzFQXUfn7SKkRnJ8zT+xBD/PPGo1ll879rsfmbWesnTxq+lPCoo09O+ddiej?=
 =?us-ascii?Q?yGA1bYJp/Aii0iQqaoq6kyIL7iUtVv5xYMcdBkLeiozanmvaa9dVE+TlcqNX?=
 =?us-ascii?Q?QWtzyIJ0RrsTuTOBzL84PL5sORftoipfRZmU7pw9iH2m1hR+nu6Uu44+20pJ?=
 =?us-ascii?Q?eF5xP7HmoVOE9O90h+ksIjCoeG76IkCQyI6JlLFL/ZTZYsezWzDn68lL+Mty?=
 =?us-ascii?Q?KvO+up44T/19xXo0bZTNFArbUpzX6Ce+A3gZjfrGayA+rIes1BQKWrXOcwti?=
 =?us-ascii?Q?lSIv0SNHHypH2yZuDH0RT8GZVPqelPRanjXg+tVYrOviCeTqijAr+E8UZnXC?=
 =?us-ascii?Q?QgjDPRD5/yXqmJVGThL0CGT7SN136IPzdQPHKhXwa1doBmQ6q8t6SyydA5mk?=
 =?us-ascii?Q?qOBw54euoIHIEKDToSlGC0sypIjZ87BHgVZA3pUC+X7lkcOC7uTduQw5saZ5?=
 =?us-ascii?Q?fFVB65gtVTsvqoPeutO9Gq9qhLy1N75w4R8JIa1no+5gvVzWlcGUILU4wAjV?=
 =?us-ascii?Q?cHEn2R78FYSb9U5YPpfCu+DgzGZ6S4Uf2cacGlA78faqROdXD6KRW+UJVs5q?=
 =?us-ascii?Q?npBVb9Yw/yGJXDJ+VSEdXLpCEb2j3z+32VvNpqdclftfML7OgiMRzmAG88eG?=
 =?us-ascii?Q?Z1Gi7twtGjBe1KUUOU4zS5tAl15uqorhKWIh5f/K5f/hoNF/hDl+mYn6dIiH?=
 =?us-ascii?Q?AEtWdrWAnAcixM1tgJwFmh0HHOUEwaOSPBEuHLwGMj/666PO2vs82cIqxHLf?=
 =?us-ascii?Q?T4U688JcUinDDAoQf89fhd7f6jmy23BJLDdddst3VrwSj09ik2y9B3jeDBWU?=
 =?us-ascii?Q?N0UVjMgPAbdV3eWMAiqtXufErdJlLIVR9j++buIbz03d60KmVwnZ4kEZXSPI?=
 =?us-ascii?Q?aAGvxuF4UfzWRQyykvTG9uIqpiR3Nnu7UY5YgX1ht+iaCRMM8WN9QR7pEPzW?=
 =?us-ascii?Q?o/tGYMIo8TQT1+gdlHBSlVM2no1mSpzsS/v/gnIHLExwvEv0/V1j94bcDkzU?=
 =?us-ascii?Q?8jRojHJBuwYCtQj3AZ4OvBrau7QD45w6KB7vDHIC4BeivYakGUixbUEZ+wFW?=
 =?us-ascii?Q?vSZADwstlOXSTrNcDDv/wPoAH/zZ4G7kZS0mIpa9XXWwaWbOJhjQfoXLh//A?=
 =?us-ascii?Q?LZRW1rczP069bEBckkgNYjBh29e+tIzbpmPcCErC9Agr2Tuj2MMwf15vehm7?=
 =?us-ascii?Q?tAjswyniN97EcCgF4Eno9ho7O9eV2kHPeZpOzikymM7vM1bCpb3GjJDlLphE?=
 =?us-ascii?Q?DFILKTuDRnSInQfrAelsxKnPsxHLMIMUDeT602P83fq0PWv1EQQorMaJsajU?=
 =?us-ascii?Q?wwlkQrmR8lSVCOcnFB7TEHPFNzzN14SdR0pBki2yDrLSrDyhls2q5t41OaNy?=
 =?us-ascii?Q?XEnpHugxjhn+4RdjDvyBvJEuXPyeJLlsAoRiHPJid1I99Fo7Itdbk82ZK2n7?=
 =?us-ascii?Q?kA3zFLhqwhSdO2Bu9p/gBP9XSALpvzOUErazJn4C?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e6d24f-946c-4d46-5800-08db8dd09aa1
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 12:05:29.3257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBXofq+g0wz9yNqALxkzrL/CHt3WS1OZZMeUnH6Q6LtoEpRzwKmvct4RE78yYLF9l16SMrAfu7LkL9dR+ClaUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6580
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that dma_request_chan will return EPROBE_DEFER,
which means that dd->dev is not ready yet. In this case,
dev_err(dd->dev), there will be no output. This patch fixes the bug.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/crypto/atmel-sha.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
index 6bef634d3c86..5682957f805d 100644
--- a/drivers/crypto/atmel-sha.c
+++ b/drivers/crypto/atmel-sha.c
@@ -2499,8 +2499,8 @@ static int atmel_sha_dma_init(struct atmel_sha_dev *dd)
 {
 	dd->dma_lch_in.chan = dma_request_chan(dd->dev, "tx");
 	if (IS_ERR(dd->dma_lch_in.chan)) {
-		dev_err(dd->dev, "DMA channel is not available\n");
-		return PTR_ERR(dd->dma_lch_in.chan);
+		return dev_err_probe(dd->dev, PTR_ERR(dd->dma_lch_in.chan),
+			"DMA channel is not available\n");
 	}
 
 	dd->dma_lch_in.dma_conf.dst_addr = dd->phys_base +
-- 
2.25.1

