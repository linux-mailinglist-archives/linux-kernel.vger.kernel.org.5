Return-Path: <linux-kernel+bounces-28752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA5D83029E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6611286314
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9735914273;
	Wed, 17 Jan 2024 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="S3I2d4eR"
Received: from outbound-ip24a.ess.barracuda.com (outbound-ip24a.ess.barracuda.com [209.222.82.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B06C12B84;
	Wed, 17 Jan 2024 09:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.206
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484770; cv=fail; b=HNgT5jTnOzQwtXkSJ+TzESS8Fp1GN3c4H8d085DiiBzA7gs+OMT6UiC5RJXD6wtNt5HN6MyUqWMZ9yYdtCBCl36gyvrY/WttrWplSbvQf1VeOrlvZz9Q3h2amEIvsTu49GxW+Tj9+ZWJi2ajLKVg96Ha7ZwxgSgfs3wTDNmAjY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484770; c=relaxed/simple;
	bh=9uIXFzRNQrOO0XTQ4/fQQjMbWCDEGa+uqspccC5N2sQ=;
	h=Received:ARC-Message-Signature:ARC-Authentication-Results:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BESS-ID:
	 X-BESS-VER:X-BESS-Apparent-Source-IP:X-BESS-Parts:
	 X-BESS-Outbound-Spam-Score:X-BESS-Outbound-Spam-Report:
	 X-BESS-Outbound-Spam-Status:X-BESS-BRTS-Status; b=QzeBr2dnzmkmY8Vsgpc0Z2ZiLlKvF7KD7g8NGFIEKzHGrg6H2EioWNVhTk7LUsa4V47f/9dsvOdkUSe1hQCjk3Bc+gp5UXPNzLmi3PYz6pMv01TC7vnui9mmlb3uboFqmhED042SfPGGrABL3AoGKAG0uw8rxoWXvYwd+bBN8gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b=S3I2d4eR; arc=fail smtp.client-ip=209.222.82.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168]) by mx-outbound14-151.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 17 Jan 2024 09:45:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blNAIA4VVShr+iz2nV3mC01B+MCL9XIz/N9wI5+Ll5j0VPuEmoJ/4StRKFbsrDh5uuWuk1ohKeYw+yI9jOyZFwMIOzH1tG3szravd1MIrLtTKpsi0rDWV0qpHGpMVUKyYjXkq/moJeu5uK5aeF73aykp/jLYt6dewiVWfo5Uo0cB1Ulthls2fnGZiyaaQuJP7wrbDSQGL9Arq8BbEXFpgtHu7UmJjzUflMOEvolaw3HjsKOuc7OWqNMWppR8J6n+h8B2V2Dt09qMRzg5y8/ce9C/+OL7LhmD6NX1Bwa3mkBB7oear+Qnonn8gWdHCOCwNTSiHqnxwd8RlDfr/j1i+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkuVsJ4MI5Iv3aJ9M9nMJrRDQMgFjWmaV1lGuSIaAlw=;
 b=F2J7rTKppBIijwTeK/qrCyopymJEuklvqFGmZUxNx18nRcEv3EMT3TGTN0QRIGUankuNrprrSN2xilnDqVHTAYQ25updJH5y3AiV5qlxiiQpQef/5bNfCpRNdc50BZrixxkNrE+pZaWTim4MXg6ltc8MeQ4V/+TqnQVNigh+zw4wRZJBaFLUuyegqVedC7XDweN+cIVYDsRWDxZYRqw9SRJbxfsgpGa0A/0/3Vl3cZ/2aFjhCOConjNgE3oWdX5TE9v12o0Z16p7Nvi8xaoF47Ctk1myqXi7aTsZzZ+7PO90WUYOX5RfAYwU4A3gz04EyBSscWzZbwf+rt9S0uN7IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkuVsJ4MI5Iv3aJ9M9nMJrRDQMgFjWmaV1lGuSIaAlw=;
 b=S3I2d4eRZ6BDQPYA+RfmLD3Vv5R48Cc3rJIuJKO/lGVwu6i81qzUHZ0KfrH7jLa/etx67sHtxxVOHCG6JADuqRv35/MDZafeudtzwoUzYdQb3YoZjb9HYTekGRpNgYbB4LnIvldFqra1NrxqC+FHAQ3bbBZdl0gU7C5Zq41xsfTDBCNLQC2UureKdYsDJpNdt7wmAv34b6mk19nhnyLHKqS6doCC0IVDGz23eTg5ToyFYhKQjXMghPIO0ieSBc6rBfNRWyjjMEnME5W8JWyJmYJDeaEv7IlmIZ9CFDDAUzOuqJ2EUj0ik3X8EwAmZth/c2Zw2ykgw4e8yGdcA88ltA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from BY5PR10MB4370.namprd10.prod.outlook.com (2603:10b6:a03:20b::19)
 by MN2PR10MB4317.namprd10.prod.outlook.com (2603:10b6:208:199::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Wed, 17 Jan
 2024 09:45:32 +0000
Received: from BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::283b:b934:7a82:c8c7]) by BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::283b:b934:7a82:c8c7%7]) with mapi id 15.20.7181.026; Wed, 17 Jan 2024
 09:45:32 +0000
From: Hector Palacios <hector.palacios@digi.com>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Cc: andy@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	stefan@agner.ch,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hector.palacios@digi.com
Subject: [PATCH v4 1/3] gpio: vf610: add support to DT 'ngpios' property
Date: Wed, 17 Jan 2024 10:44:51 +0100
Message-Id: <20240117094453.100518-2-hector.palacios@digi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117094453.100518-1-hector.palacios@digi.com>
References: <20240117094453.100518-1-hector.palacios@digi.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0108.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::37) To BY5PR10MB4370.namprd10.prod.outlook.com
 (2603:10b6:a03:20b::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4370:EE_|MN2PR10MB4317:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd8788a-34d8-42ab-60a6-08dc17410c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hJ4zCcqPv6aiym5texLvQGhY/EPi6i0paaeg5YXkWypgJRg87J1kQqtSoh1Vy/wHOCR8jTTcZQrIgqNMqrMpAsxYW95r3tLUhrfP2FiKb8DIG5vwzhSYDL3wo0zYPcnaUyO0TE1zA3JZGasHurDE3ENdbRHl7VyHC8L4+J/k/wSKaevsnf4x0Xb6JLmqvF0czQ7WTM73bT+pCvsmeN2p7+ny9s1bJpsJJoNqNi5AwQJuO6n3vnIkr4ewsbfqrJpsMwNmLJ+NF+Pi4Sq7EVJdgckDmCDKr5wBTuS7PlmS9KmJYytthYCjpVti1OnJLjtmejiM9/i8XH7unxgfj6s6opGeqc2LkFPMigpnQEaOlR9P/p057lG4qYvjRFKf6r28X8bMyLK0tv9KNv7X5Y5Bl3gpgpWZutXQeAJmRORMAii3L4BmHNUrWZFMPmXGB8d6bVVRQkTr1f+U9MLLEWpC/3cWntJrTWTFeQvB/rTg4S5NWYj3HP7XfbE9IsmVHaaPqlP6AHtQOhcy6yAQYJe4bPgWwYvhEv9GQSxRlvKGCFGtU8CL+C4iIAdjcKjIsRRRCxb4B4x4K7AZCiM/3eikK0nvvfvI0qshuTMYFKIfC01soYVHEG6eXIyqLZtEPGNp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4370.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(376002)(366004)(346002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6666004)(6506007)(478600001)(52116002)(6512007)(26005)(1076003)(107886003)(2616005)(38350700005)(38100700002)(36756003)(41300700001)(44832011)(2906002)(4326008)(83380400001)(5660300002)(316002)(66556008)(8676002)(7416002)(86362001)(66476007)(66946007)(8936002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3CeeQZVD9bSnEPJaDLSa5yJsXfegmypIS3cHhvgZFNtwZnWuAROLeLF7JcT4?=
 =?us-ascii?Q?2dZ+TuktISd7Yy7VkwEm6OKMcUdII2SpBAAMcx1046OtIRUDE0uDpd5sndlE?=
 =?us-ascii?Q?a6yRNJgUy3b1P1uXg2j0Ejikl+H0iQqeiWAuSjf3Fiv6z02R8Bih54R/Y9OF?=
 =?us-ascii?Q?AKvRfawFDPWxd9l7hsajMcojqeQ9EBpagncihMaPcmP4EQvkZmjN8uKO/J+C?=
 =?us-ascii?Q?tbseyuCXMipmlJZV/GFA1gPsIGzHhcSD/EGH/Sppq5l+/VXpPJy14p8fCKqO?=
 =?us-ascii?Q?r5vtEOB2n1CoX49ivYt1sDFpEmT8vDjISGjIbLsB6e7tzyzpqm13U0Zfiv9g?=
 =?us-ascii?Q?um/h3rs2hlS1PPsJDvsEl8fFVnI+sN94hhDo8QrnMF2yVHsjYulrnwFoOmYX?=
 =?us-ascii?Q?ztTIcfUn494nnU8Z1/X2Z8xevA0P0zEU9aFJuXi3EexOp7GyEsAkEqBh8jC2?=
 =?us-ascii?Q?qd+v36UwqP+D9SkaRLz07AGaV0OaeSM6uUVKajcDTOdM3ZIFK2xxhsZgyeGa?=
 =?us-ascii?Q?U1QI/6iDvKErUmAoMvqfhWNtckS15wC1MGO4kCR3hrFNW5vYC9BmCIozwgUv?=
 =?us-ascii?Q?vPlUOvfbNwxUQ8V0pFyrxV4goKz8lUKYOjkx6m1Az55GuDBSklsogRQDpGyo?=
 =?us-ascii?Q?obCP+ENqvDKCb/5Mfam4xJcKjs9qdDQAxt57yjuJBe0EcGljNZklkqeIVJQZ?=
 =?us-ascii?Q?wea+ZFzSxKSHHbIiZxv+K8xGk63+7JXeaLkyYaQer05ayR+It92ajeTFbG5R?=
 =?us-ascii?Q?McRHOKFfeVrdJJ7HMw+YrdHSIkvanCHNjRSEZBDNThgVo03Tk+KRjQ+FF3ad?=
 =?us-ascii?Q?+COZMW2fvShridvFtJ4OlEvAWrLSC0NvxReX3PaaagzG53AUqFAjQcBj03Bg?=
 =?us-ascii?Q?GlhIzTLYxwB0RzyjLNn63gzK7h+39ZL8e02+ZuNV70CR0wDUKmtBJ6YYCVvY?=
 =?us-ascii?Q?eHfQBjbrg6zGPa62W+hyPtcEeGT8COVW0fMWyLMsuTex5/QbLjTX9S7oBm5+?=
 =?us-ascii?Q?o7hRhszExVmc7NnVU1PASKLU9a8Yi++5SSUAS4K53Bwyx6+7srZ8hUCO/S/5?=
 =?us-ascii?Q?q56Efw+0aN/XBCh1L+49Rp4/4FDacvKkUCQW1SYM1JJVzAwJaiwOoNR5FUF0?=
 =?us-ascii?Q?iHy9Aoop8ZPnW2ZHzuyBkuYPTGvRAqqqyspNbqhZvRF39yMZ/LQApls72Tjc?=
 =?us-ascii?Q?4bJ3s+6Dv9CA7ss4S/+plfkQIuiZDdo/9WhqGTYgDSJg9kJIT4T0AhlooRiU?=
 =?us-ascii?Q?e8MoV9OG/K5EirT7YbPCZKMu0kwtaU5aoFmLTdsKn66ruYsYYbn9r5zosFmj?=
 =?us-ascii?Q?q8VYgN2I6RiCGB3A63uv9v164arBI8xjBLQBz/MFyNIyIPDlLuHWqZ5UZc3U?=
 =?us-ascii?Q?HToEv20b78GEPIUGtx1dHh3XJBClEBERB2bhfk8blRNMkKAIWlaVL/dpVEkp?=
 =?us-ascii?Q?4R2eM7/XDuvi6k37mrw+Bcz9U6tSAhhX7dJlAS90WXjx8LxSFFBZDSXsMz5B?=
 =?us-ascii?Q?eePMn2arm4iLG9dhOuHaF5KYzDNUS+WudrfFBcSgPy7iNqik50HGZVt4TC0q?=
 =?us-ascii?Q?UceBMcg2M2LeQea7QvpBO0zvP8FS/dRqU1EVmKTt?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd8788a-34d8-42ab-60a6-08dc17410c16
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4370.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 09:45:32.6660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTAxFRVTIOk+u5/KZWVw9jX/cnL9PAayKJsrz2e0GAVJuqLSX7w7sq0TukFUtdsI9DWIw3K9LdW/0etyqyt6yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4317
X-BESS-ID: 1705484730-103735-22813-55859-2
X-BESS-VER: 2019.1_20240103.1634
X-BESS-Apparent-Source-IP: 104.47.58.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZGRmZAVgZQMCU5ycTMINnIOD
	nJ1NDEMjExKSXVMinJLMXUyCDNKNlMqTYWAAp2iIxBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253576 [from 
	cloudscan13-0.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Some SoCs, such as i.MX93, don't have all 32 pins available
per port. Allow optional generic 'ngpios' property to be
specified from the device tree and default to
VF610_GPIO_PER_PORT (32) if the property does not exist.

Signed-off-by: Hector Palacios <hector.palacios@digi.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-vf610.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 07e5e6323e86..4abdf75e9a0a 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -276,6 +276,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	struct vf610_gpio_port *port;
 	struct gpio_chip *gc;
 	struct gpio_irq_chip *girq;
+	u32 ngpios;
 	int i;
 	int ret;
 	bool dual_base;
@@ -353,7 +354,11 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	gc = &port->gc;
 	gc->parent = dev;
 	gc->label = dev_name(dev);
-	gc->ngpio = VF610_GPIO_PER_PORT;
+	ret = device_property_read_u32(dev, "ngpios", &ngpios);
+	if (ret || ngpios > VF610_GPIO_PER_PORT)
+		gc->ngpio = VF610_GPIO_PER_PORT;
+	else
+		gc->ngpio = (u16)ngpios;
 	gc->base = -1;
 
 	gc->request = gpiochip_generic_request;

