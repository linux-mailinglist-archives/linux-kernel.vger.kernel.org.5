Return-Path: <linux-kernel+bounces-4090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163F48177D4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88593285065
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EB35BF8A;
	Mon, 18 Dec 2023 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="S4C+vFQ+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A647D5A85A;
	Mon, 18 Dec 2023 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BICUTZI022133;
	Mon, 18 Dec 2023 08:46:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	PPS06212021; bh=FqQWgmAboSavDcjjNJ2CFNqFv0wq0SkpVU+5sQd7DYQ=; b=
	S4C+vFQ+7nCXwrTEs6/hMqYwjFNGsg/mZDTixuaLZPJVhf971HCWcx0n6YL76rAC
	oXFwl6x3kQ9XOshWTg92YwKpWwSLcR0NuDN3sajZHrmBmL/NBlXVYBL9cmpL4DDn
	7lhKfxvBHNTy3OKyT1x27Enlv2Vu5pZiF4cUv02xSBJKEY+vNZQtVWpgr7F4TM//
	vLSF7DydGFLuy9q6mEAjHyek0RfmhKDfqlJga7sgFQRgOgJo5iQb7xlDzUEuKm+7
	aNJPuaOiYDVBXc88dwz/d+OULlYUNUrXxrTSlEQRJJ5OsTjIHCLs2D7qsk6yJV2a
	d9EZja1U6bnkfj8yRIAuIg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v1c9khts2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 08:46:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEzuMsITMm4d5lIcqV64hqu0/DLCG0K69BIS9jJhHkeTmOuVLfi238fMfvagmjY5iGALN4MAl0hrek0GOGMhiJEN5BH0+xGLNIrd/AyT1oup3YwRl1iuOMi2p6gwDtIy9rEYIO5W6VSxTDgcz6Hvk1/FCeVxXjjKMnNk9nDnPogPtFVrd424TGc2eyxHZvybb+TLhyxFZKvzGXRbS/TupLY7kw6zFDlQ9DqAycSyunplE7bKrOxe8qz4NgdFhVqrYNEm//zf1OtZk25SRibvHYcoZTBUpKmfD68DsIXyMh9IU8dp4kwj6H8bSXVtOyduxg7svlT2Itsq2sZbNtJSGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqQWgmAboSavDcjjNJ2CFNqFv0wq0SkpVU+5sQd7DYQ=;
 b=YKyXkfuEd0E6YnpKl02acFnOLvodrlkTGOa2/Es1KW9xFLUcNKbjlykU/AaC6T+rRX19Y1SXCE6CS4VnsO+gLHgDr5NanlEQ7r1ZcLMmqTyP9Y5swVGLwCo87Hfg5df5HGY2DXhv7GBtUhffYnL2pLpJgDE5Ba43Fc6NkR4Ey0rxQWQ4/vrUv2G5aGot5SW+yscfxvBb4qFq1Vq4RMdn8djk8alJvpssH+43UXVm9yeXut8j3tKsKgGy/y/gvOummvhRfMwcTiqO4seHM2zGSZtPonrcjvJft8VH5LNjT4TNOzp8UUP4MaOfvAlTqgaLDgMzVmGLB1FTIPdkkJiyLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by SA3PR11MB7978.namprd11.prod.outlook.com (2603:10b6:806:2fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 16:46:23 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::7c2e:5b95:fdc2:30e]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::7c2e:5b95:fdc2:30e%3]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 16:46:23 +0000
From: ovidiu.panait@windriver.com
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, Ovidiu Panait <ovidiu.panait@windriver.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/7] crypto: sl3516 - Use helper to set reqsize
Date: Mon, 18 Dec 2023 18:46:47 +0200
Message-Id: <20231218164649.2492465-5-ovidiu.panait@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218164649.2492465-1-ovidiu.panait@windriver.com>
References: <20231218164649.2492465-1-ovidiu.panait@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: f8802d7c-1c93-4aa2-eff9-08dbffe8de56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fuy9mj68g1Dos3Ix8ztewGtoRcOwXau+DGizTIjDQlpItJca30Tj3K1E5BfqvxZBdknU5HWqaDBZpiQKhoACmL5/BkXfGWKIAl7fHn/BJOP2fH2/m1DpTIhy0XcSYpnsWUvhfbxjqhElCgyFwLdSlJIHvEjrX3ojKv+PBargDhk/LFz5t2Aj3i3etkn0pcUJaoq/K7zlkQPcuwQLne0UlA5vqhLdxsAAq8C+q+w7/YTPd/rOWaHEd6kpzXXEZ2LZrZcxtSQlktITF037WdvsCMNl7vJlkREq43wzt9Gg4OM+npKg8Sbgfzc1quy1njJxaTnGdodXf9/VorF8ORYdljC1iGwzgE9PBcsSOLxVOBV7qA0yVBdqwemYobjk+NMCcqOSbe+2v5oC25ItrVKC/fJgbWd8ZnkJspe9j74b+oS7ureQyS2qvsokhSIzgQzADXp+66wAQzHPHduK6B7d+zm7LR4xjOVumvjtiSXY2U4zCA3AwycKKmUwzMnuETtRj79nbg2wmSI5+psucJV63xg9catBXGLZ+CH6FqgF/fBh8Uce5s+O2OSqewxuP73gId1OiqK/t8q+Ol4fPpwMor4gPRAGbizQBd6JUxpn8l6pf8Sorcceo8aV7hRUPbFB
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39850400004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(86362001)(41300700001)(38100700002)(478600001)(6486002)(8936002)(8676002)(2616005)(4326008)(66946007)(66556008)(5660300002)(66476007)(54906003)(6916009)(316002)(1076003)(2906002)(26005)(6506007)(6666004)(9686003)(6512007)(52116002)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?U9KUQl7DeQe7vyb8tIzC469wVLyocj8MXYv9hIBwMrp8jC2xygdc1jaoJyNu?=
 =?us-ascii?Q?QVbYSeR/JK2xpBYZLftr1oCVmtJ73m2qD4KNs4KPzRQ7sGz81CjLe7JUi985?=
 =?us-ascii?Q?gmEiRSNSoefBfYdUdSi9bjO61Z/cANT3l5i5XYgD8a2hhZ0u5V780+f6SDHb?=
 =?us-ascii?Q?P29PBu+cd+8E0eaJ+M5+KE4HrqawGYaD56NFMcY7SNRWQxEbm+7BiWDEoKzl?=
 =?us-ascii?Q?khLSEiF/m6dAZAzuXOiyqyJ+usA8gFX6ELWtaE/nYQ/0hICpGmb3PWyQb3Z1?=
 =?us-ascii?Q?TnuJ0AZZqKhENkhMRcGu8jherNKUmIYqxgY1iNp0yFFWicsiV+M22rXwEJzW?=
 =?us-ascii?Q?hQZQpBOvydIwqbrXhwEowBO5JIU+k0kwJrgRT9/OpGAZhuL31rftu6ckOVsB?=
 =?us-ascii?Q?KZjFkDhY7i9XEC3oosjOn+zFRRDNbEeAo34y1pG55EssCfeLI+Qv21aXCoid?=
 =?us-ascii?Q?UiwXjWEbP/l4UdBUNJG0AFFh/47EP4NJUU/Go/eunx0HsNk3ZXQfZeCOoxd9?=
 =?us-ascii?Q?eNT8c9AHIM9pcR8TJL/9AnIcUpaD6Ba8fhtPxE50URxqlbGU5LAKY1zBemLZ?=
 =?us-ascii?Q?cWiBhk3hM1XToRsXRS29IwjoSvNbOKkGweWRtk92BeO+5bBFv5a8nK/0hws4?=
 =?us-ascii?Q?177tXSiA8RXtlGDW9oeQLz0q9o0SphomcUICEFWUIJcDn3LuLqQVEgvlzghO?=
 =?us-ascii?Q?/AgHOUSODwY95v3N8qQALfCy+KgK3cAydNfTGib2O9AdY1Gh74MYY6HC8+ew?=
 =?us-ascii?Q?o1prEB6FrNmYhLxkFE3bWtwLVlm6PryFuzAdgItmIfvGfLWDA010tdaZKfRk?=
 =?us-ascii?Q?VNw0GnFr4ErlqfUCD9ZmlpojbVHQ+/xlalT+UmLU+BaGolVyWI3kXd+atv2d?=
 =?us-ascii?Q?Qq54Qq0eeKFtTDuKLZVl3AwyuCHDdpCktXx73SYpytx08iR1WXdz+1Kov2OZ?=
 =?us-ascii?Q?kU4X/ftG7TcbVoAHrbrz6V3Fx1xqCF7vXu73Nsu3QHbzUiVUAt5hVuXzlhDS?=
 =?us-ascii?Q?xrFLhjYQV9KfgWKa3iTE722eAiXpXF84b2g+vyLTmDBbPV/rb0uGjfoGht7R?=
 =?us-ascii?Q?eokkwbWIK0UIwh0jpXd/PS1vnXz01JRJXuPm6uL2dEj/VMkW/gvjZKjprk9o?=
 =?us-ascii?Q?8mkrP62Ud9oVVJMvohcjluDFuCRXA1oNlCp3NGPEXHhK6q7x9l/ZbU4qh9QW?=
 =?us-ascii?Q?uH9LR0t/0nP6uf1umUjHGCvdvGnH0RoT9V+j2VYmu4pQxKPv/M4yg2ZnXhJ6?=
 =?us-ascii?Q?afoEDOaQASsTvD+Ha7TO+gsjOmjUPGVdfQ1/+2O5qbba8Yt2vfuNFhPIfN3x?=
 =?us-ascii?Q?YdVEmCePwUk5e9mUKLZF1fa70NoXSNQH03kIGvGN86p77zX4r6T1jfbRALLK?=
 =?us-ascii?Q?xMYyY5Y3PoU/x5Ud8NiINPZP0cXx2ilhmL9tqCyiyo1gMv8sZlCHLDu5MpVQ?=
 =?us-ascii?Q?aLK/43R52n+cscHXHbxCLQhbuG3/izpnmJQh0b7yhKKDYbn7pHrSY8GWb5cw?=
 =?us-ascii?Q?nJ5zh00i3JTfHSJ9/IcpsvcJT4XunkiVdzG24APQq07TemcOKfDjyGxb9PdA?=
 =?us-ascii?Q?K9NsobYOD3fO65CUhe+yLuFAZeV1KmVByFbO4TsEAmuP4/oB8IFTh5gcZ44O?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8802d7c-1c93-4aa2-eff9-08dbffe8de56
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 16:46:23.3733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmFZKYFiEk2q4EUaO47P8ada0xTeYpHmXQH1ywSTTwR8glwWj6O6IeKDVwTtKwFsbszB8Fh3AjV4Sb56Pz3fURMQZTpyrtwgjCG22mLOgdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7978
X-Proofpoint-GUID: 7nwNSduQhqoGKgajKHZJgp6uS_bgBlNi
X-Proofpoint-ORIG-GUID: 7nwNSduQhqoGKgajKHZJgp6uS_bgBlNi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=582 clxscore=1011 bulkscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180123

From: Ovidiu Panait <ovidiu.panait@windriver.com>

The value of reqsize must only be changed through the helper.

Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
---
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Corentin Labbe <clabbe@baylibre.com>
Cc: linux-arm-kernel@lists.infradead.org

 drivers/crypto/gemini/sl3516-ce-cipher.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/gemini/sl3516-ce-cipher.c b/drivers/crypto/gemini/sl3516-ce-cipher.c
index 49dce9e0a834..583010b2d007 100644
--- a/drivers/crypto/gemini/sl3516-ce-cipher.c
+++ b/drivers/crypto/gemini/sl3516-ce-cipher.c
@@ -332,8 +332,8 @@ int sl3516_ce_cipher_init(struct crypto_tfm *tfm)
 		return PTR_ERR(op->fallback_tfm);
 	}
 
-	sktfm->reqsize = sizeof(struct sl3516_ce_cipher_req_ctx) +
-			 crypto_skcipher_reqsize(op->fallback_tfm);
+	crypto_skcipher_set_reqsize(sktfm, sizeof(struct sl3516_ce_cipher_req_ctx) +
+				    crypto_skcipher_reqsize(op->fallback_tfm));
 
 	dev_info(op->ce->dev, "Fallback for %s is %s\n",
 		 crypto_tfm_alg_driver_name(&sktfm->base),
-- 
2.34.1


