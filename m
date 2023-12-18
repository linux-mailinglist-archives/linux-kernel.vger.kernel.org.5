Return-Path: <linux-kernel+bounces-4089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E0F8177D2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7CDA1C22BBC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2045E5A868;
	Mon, 18 Dec 2023 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Y1qK8jK4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00DE4FF84;
	Mon, 18 Dec 2023 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIAcDmq012815;
	Mon, 18 Dec 2023 16:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=KYPY5SG/rwJ/IwIDQa
	izbrPz+WrG3YG7Ds8LXTG9BM0=; b=Y1qK8jK4Hpr0F4jQ5pADFh1cX8mTq0GYS9
	2F29GH94HYNfZJca10TU4R00ahfRZMKT/M7DAgwch+jRK7eo99Z10aUFqbccClB2
	ezumj5P5PWvNLLJZGpPPON47KUoxBZ+2jPp7vPi4/RTOBa8AwiNxckofRrxcRtfZ
	ALt9ei/ih3ZDXFVX3PbVhjdSprzWSfRrbmH4sue/gPUuNioztnElSX8rJ5cweZtx
	OoeIbgR68xX4muT7MiKvIqAkNicfGB2emHWX2MKkq7axcnzaL4+MXchy5g3mjTNE
	BFT8Vy78BDOKq/2iOXbf4kEwgjY6nvc5sriIfLWWoT8igVA05FYQ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v12v5t6pv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 16:46:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOEQiFapKzCQ2Mhj0IcpQ7FL+avrRQ+Fn0s3TAAadCT/ywChPNbb4INb8mUSeF8aOpox/ON7f/aaEoWNNhILnXyo0XsfZnvEYzhP4zbbcE3nTtRGpD5m4CMtMzB1zSyX261u+B+YRYDDlR8AXKGn8ag7YhtJGtAvF4Ai4ulDp+WNes+ROGGEc++ErwLIRlIOCg9azApWE6VLMnm86kPiZjtOsmItdlgCJHp18GimptqA8eZbuIcjbyjEqlKHMpwY+mxcozrABeK/EBBOlZakHPaXdKrRuHyA3J0QFsIDjJlNDndlQtfoQFhWtLtGgGVHpkRz19Q/3IVsQ9kuhTS+bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYPY5SG/rwJ/IwIDQaizbrPz+WrG3YG7Ds8LXTG9BM0=;
 b=EppjoA1roPYsEjfwvjtXV+JWXL2J15rmThamwL+n1fxOcKu49P7/zqOmqUL2GsTwc+osnRQBeOWOJNWkhMbRLLxkcyieqkKsqcK6T9lZeG9kMKNTfav3ylAqrZqJp8TGyLQ3BXZnE/qfpqIHecBKM/FczhEvK00vHTqomwAPZkwiDBchQwsIQHb4bGUCMwJktQNodvS7/A5Fl11HXhXjCVMQWKC86LL7kYP5+/xouvhpTbsFal6qwFbb5FoLaxFQU+SXUOGqV/hkaRfKjfhkJpkXAAYTubikhT7NyqIr5dHm79wd4sbhizpIYNDlASyTCjxJRP9l8djv2nzvUfo6jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by SA3PR11MB7978.namprd11.prod.outlook.com (2603:10b6:806:2fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 16:46:13 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::7c2e:5b95:fdc2:30e]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::7c2e:5b95:fdc2:30e%3]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 16:46:13 +0000
From: ovidiu.panait@windriver.com
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, Ovidiu Panait <ovidiu.panait@windriver.com>,
        Heiko Stuebner <heiko@sntech.de>, Corentin Labbe <clabbe@baylibre.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/7] crypto: rk3288 - Use helper to set reqsize
Date: Mon, 18 Dec 2023 18:46:43 +0200
Message-Id: <20231218164649.2492465-1-ovidiu.panait@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::33) To DM4PR11MB5327.namprd11.prod.outlook.com
 (2603:10b6:5:392::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5327:EE_|SA3PR11MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f941d94-4370-4e1f-ba4d-08dbffe8d846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dv7nj6wLLTBHSwchoc8o1BwxgbXXY7mWWN2JFa10GYfGYdGptepjHw7Agti8Odxh88GfqpeyWnlVxiB7uhsLIPeFrk1yJ4KCEdKDoum5P9GjyMb01ouzphnvCTDJELD2D5SnAQikWRRwV/ZQsPRFWUSmjDrH38XE+vOK/rm+HhICahCkXet14K8MXbr6vzcxKGn6pYo9CdLWsZpcNp5BbBuBGZOWap92wiX8D4zYsj2GKLXUdxMOcNqtlDHnn0iGw3OybnU7CafI6H4lNQ32a11AVTkohaLo/29Z2toS8e2kvqkp7V+U6DsD22WGmLs2w1t6r47WjfOHjDf+Mq1z6gyW0LREj8lERIdzUfsQQ2AuNkGYTqXk/HzOXTlq0Dr8kaOs/s4jhi8fXFfUhEyCPwcT+xM8YWVnA9uA/1aN6reCHzcwEuPPavpkLXGVOlhNKaYxTVPX4elJNNUj1C3U1c9QIG1m6A60On83FpdaQjQzbmcrNh1yS2FWAAThJROlZEie+oT0C9fmmqVyGRKwaWnRz7ubvG1ge+3LOsTmQY/xRNTUvHpCqLGwGn8EnFz8ojvFntBaaGiRxewRpmbZBo2esp/Kvwwc+PHQWyD5ZFRCKOx6bNVLj5mJpBVWMrv5
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39850400004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(86362001)(41300700001)(38100700002)(478600001)(6486002)(8936002)(8676002)(2616005)(4326008)(66946007)(66556008)(5660300002)(66476007)(54906003)(6916009)(316002)(1076003)(2906002)(26005)(6506007)(6666004)(9686003)(6512007)(52116002)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3tmTMKGXIXGNxSE8EIWucpj3XHHxZFlMRx7xEKPU0ri3qQUMLzKZmKPXFAxv?=
 =?us-ascii?Q?pphvljHXpPszXs0/Ji8saXDwipoj2eD3TR7XzDAPl4LXR/VKmJtfqjOC8pEW?=
 =?us-ascii?Q?JuoLYqZJWu0Wv+WVlQmgSVfaz+OkjIsiKQnkQNaz01CAHn8X6UF0+COa70fV?=
 =?us-ascii?Q?3+WUjCGTSqU75jKg23JNk1kMVk4dQ6BS8o/EuedfFrv/goBYcj/W3a5qnat7?=
 =?us-ascii?Q?l30XeDisaAlAJNuf7BTh3Rn3kjCDyJi4dbWKvXunLzykvv5aqbecvVVvhtGl?=
 =?us-ascii?Q?XCMTj5nhHZEDdbNc8x4hcVsNunX9hZXcvypW1y87dMTG27qgPLwDdLxr/gF1?=
 =?us-ascii?Q?VjdKLMCSh2/Ka31AI9nG6GZPD2CvwmWNbcsE38xqwb4oRpic9MFKrLOiLf72?=
 =?us-ascii?Q?UhQFiSjdhRFSUpWFjHmf4Y5pLssjLFfmLToVWtm4w4r2bkBdy5dweP7fuQFw?=
 =?us-ascii?Q?kK6wvWwdn0uubl05gbvlZIazcd6oQDv6X1hyXU3ewUKaDj1QjlNobO+Nhkga?=
 =?us-ascii?Q?ZamtO7pzxkwnFuwiPIi9bodOVyYMRGMslueLlutQN4le4UdkhKzftYmwsXVf?=
 =?us-ascii?Q?FMctWWOnOfFX+Gev1fQ+61+B7aoD4qg1mDNmk3kHavgJtlI9p77s864xhTvB?=
 =?us-ascii?Q?l88yl0N/A/9ds7Rf1SCSjTDti+vLkEbzCUI3nQYJ6AjofPcd7/D8zysKDx3N?=
 =?us-ascii?Q?OPh+7xUAjVS6DOV9IxE5g2b8D8SX6dA+Lt662VqBbZZnktCXh1+uKOk3+4UY?=
 =?us-ascii?Q?hnBXgQTFRzxD+n8Ucfc7fqJ4SlOQz2Hwzx/2Gy67sQ3H6Hl5f6x1071xKxOH?=
 =?us-ascii?Q?ELIb/IInle3Xd2QWJVjgwCZZocj+J5rsudtQ4cH40ZCb4UgUJKiKW/WHXVgs?=
 =?us-ascii?Q?N2NS7E3cnDB+V0RQgdnf5sdUOGxTnxfF5YWwmIch816gDiXNHJWFOm7KZGGJ?=
 =?us-ascii?Q?pBrvxrbZ1NDNARuZ5RTFtS2dzwVyTXzuRx80AKkJ2+jyyttXBvDE9oyMpJze?=
 =?us-ascii?Q?F9xrkapAHgC+VQjQCPJ8u1hYPapnXubVFTgfOHK+9Hj5qsuZ4SRhStxgJDJe?=
 =?us-ascii?Q?bg+eXxorQ47oVXkCepV3555B60dFFcLRnI3Ea5QKaCvIJelBmcnI8UNcFJ8S?=
 =?us-ascii?Q?INK8aPnMFU+/846Vnw++dcgXKAdvWlfS9ZPmP5FerG35CDXv2IllRBHcIQ3l?=
 =?us-ascii?Q?usxdTxJlg58x67LrLbslihXO7+JAZPcdemdA6cGDsSbHCQkbANBu/klrR0kk?=
 =?us-ascii?Q?qpnULOj+aNhHmFkgjCIZNghcQZNqPopvMq4VPEYx3Td4ZfPI7xhQB38ozKeW?=
 =?us-ascii?Q?NC+th2h4FIB2ZOYUrtHei+97ruQ5l23PJ3BYQQAXbXEjeVadIT3oIkRuBbQs?=
 =?us-ascii?Q?h5dBLUDe+Ydbc/DSjxlsEhhDpptAKEDjHtll4JYvQVwWEcZMvAvT8eyZtYsL?=
 =?us-ascii?Q?fKZsgp84UVcHMir+xngHHQQfZOSJWBO3yKBQUT4bTckX0ksM+OGG1nHqzsAL?=
 =?us-ascii?Q?m0UckS0ZYJOilvFEmIj1PoRclFZMdWOr5WaYPQ5svrmY4aU5JXqGz+agKLNT?=
 =?us-ascii?Q?YUs/Dehbum6Bwqs0iS6vdPrqT5e0FfbJwY/WHCIcKJzdq1Oe/OQ/cdNKd1SJ?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f941d94-4370-4e1f-ba4d-08dbffe8d846
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 16:46:13.2542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3niiV7UZKtXMyNb64hIPY/RtLos9yrGIJwyie+sXY0p6vO8XycsQEdeuStEYo29p7dSRFDFmIBNQ+5qhU2z/zgv9zZFw6e0uho5PNWrrQ3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7978
X-Proofpoint-ORIG-GUID: 3xZZfXaPKsum0pzVaCa294IrERcq2s-6
X-Proofpoint-GUID: 3xZZfXaPKsum0pzVaCa294IrERcq2s-6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=633
 priorityscore=1501 spamscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312180123

From: Ovidiu Panait <ovidiu.panait@windriver.com>

The value of reqsize must only be changed through the helper.

Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
---
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Corentin Labbe <clabbe@baylibre.com>
Cc: linux-rockchip@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org

 drivers/crypto/rockchip/rk3288_crypto_skcipher.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
index da95747d973f..9393e10671c2 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
@@ -445,8 +445,8 @@ static int rk_cipher_tfm_init(struct crypto_skcipher *tfm)
 		return PTR_ERR(ctx->fallback_tfm);
 	}
 
-	tfm->reqsize = sizeof(struct rk_cipher_rctx) +
-		crypto_skcipher_reqsize(ctx->fallback_tfm);
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct rk_cipher_rctx) +
+				    crypto_skcipher_reqsize(ctx->fallback_tfm));
 
 	return 0;
 }
-- 
2.34.1


