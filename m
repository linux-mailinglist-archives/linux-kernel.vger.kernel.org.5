Return-Path: <linux-kernel+bounces-28652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345F983015E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D751C243D8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9378A11C80;
	Wed, 17 Jan 2024 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="EuTaKTWm"
Received: from outbound-ip24b.ess.barracuda.com (outbound-ip24b.ess.barracuda.com [209.222.82.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66011118C;
	Wed, 17 Jan 2024 08:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705480503; cv=fail; b=q2EoJTg5yoM8gE/IVrYQb6wxmTqkC7uqJKSkRvZeqlsxoZfoGHh/rmjV3MdnsrQVLJM+laeYQsqN24fgSbej6MH/0Vohhb93/8bVPniKPh8xstB/z6ngPjjMDG9GL8QzH913c4I3vRoH2hqt1spL6VN7QDhLdJsHYfjJM9b47s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705480503; c=relaxed/simple;
	bh=2m7LjwrEutO88sYHQ26Z8cTnRntnoD3OmVbVIZHqN4Q=;
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
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BESS-ID:X-BESS-VER:X-BESS-Apparent-Source-IP:X-BESS-Parts:
	 X-BESS-Outbound-Spam-Score:X-BESS-Outbound-Spam-Report:
	 X-BESS-Outbound-Spam-Status:X-BESS-BRTS-Status; b=HcVhqXtl0r0/oT9WWP5GV8y17g1QXj9XmIWOJMXu9MV097orvEVjWaNKin+m3SaOZPBDbFNYmoJmli47KT2Ol1gHnFpLmHoraUNK4M+on4V9quobrOhmdyx/KW0pdaO1rQVtpN1MLIFz+M3gWadyED7Zb80zHZRgL0Qwl32ELQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b=EuTaKTWm; arc=fail smtp.client-ip=209.222.82.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101]) by mx-outbound45-159.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 17 Jan 2024 08:34:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGWStJBaHZEWzrUQveVG8NX9V44WI/hQFbn/29VA4+HrbhMWydYX2n0bCQXn4kKWHh/dHApcVusL6KbCN/lHL2P1CN2aa74NKhf8ROhzY+9/QXM3/bGVtLcbP9zj/aYgeXcR/enrXVSlLk/IUM9q2PV/1XqBTeMRlyeGof+O/9KHgSh6os3Z3KXlAeGvJE5l0SbTNOtT3DRKBeYeLV8CJePefDRHcIgYC778glltJCT9Rw0mM/JLG/CJScqavTw9YMhrQ+ssw7o9j1Oh2udGOWoLgW8K7bIFGkibMwTbBV9E4Ki+jG53MNJLoBUz83+0cCBATRgpzcdj4FGGIFXAlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bs10aiIDquAao3KGI9gdhUr4e4BjwqiWS3U54qicvIs=;
 b=gW0FeOeluIujW3DFeUkFz8kpQ8XBLUYgTNrhGrzodi/Gxqkx1L7+fq9/26fhHwwMpEn2/dwowGfKfJfHdgWGuWPTNuVu8nUAccpUx0v0CnT/WqsAQR561KGSxVefarlSobJgt40vXCs0A4ZiO6gVzJgm1qTZxjRb79T1ZlWNimUKPC2QiXUaKLszjYTbvWsPAe8ZeVxdKUSCGFTaTo6yF1ErZ7KCqiu40sEjxcXm2PMar1RskidSjoBtBB0LBfoGfbW0r/5/YueLIDGHKcRaLc0iTYPiQSDmDhbUHpnVmx/fDmRVaWXo1CGIu2AX0pNSLxofagu5TajdfcGsVP2Ivg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bs10aiIDquAao3KGI9gdhUr4e4BjwqiWS3U54qicvIs=;
 b=EuTaKTWmYtiIdk49BV64PVvJTeUBK/JuxvxHz+kPH161/st/hIwikHFJCPTEqgK5hEQeRGNvPfCeASOPYnbPdezSX1dq5BycBqYWWmJhV0g3e+v/j82BVOlrDxevKGwYR+5quKlR4Xg9m043p2o2vf3BUxIe4UtUcXPujCU56m5HA6jjusQMqB+DJ7dApsNjjfvBV/gAnhHpcI9jHkm5BVDuhttZgDKAhuhMLP2mYqhpIGhFUZgeDACDWGfRebtbEwrk5e0RgPK1Nuivny7LEnNABRvSO2mpQ98r4uL8sNHniqkn/NU0lMmuQWNPciFPKUERzUdD4eF2E5l6wCBB4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from BY5PR10MB4370.namprd10.prod.outlook.com (2603:10b6:a03:20b::19)
 by IA1PR10MB7143.namprd10.prod.outlook.com (2603:10b6:208:3f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Wed, 17 Jan
 2024 08:33:39 +0000
Received: from BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::283b:b934:7a82:c8c7]) by BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::283b:b934:7a82:c8c7%7]) with mapi id 15.20.7181.026; Wed, 17 Jan 2024
 08:33:39 +0000
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
Subject: [PATCH v3 1/3] gpio: vf610: add support to DT 'ngpios' property
Date: Wed, 17 Jan 2024 09:32:49 +0100
Message-Id: <20240117083251.53868-2-hector.palacios@digi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117083251.53868-1-hector.palacios@digi.com>
References: <20240117083251.53868-1-hector.palacios@digi.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::17) To BY5PR10MB4370.namprd10.prod.outlook.com
 (2603:10b6:a03:20b::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4370:EE_|IA1PR10MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd5b55e-54e1-433e-57da-08dc1737010c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HbsUVQBSFsIGnDOJalSUmsNwy3TdGLQHrqF8JDLH/k5B6AgV8FeuagOCfxZRY1ejSRFLEjlDuGTJ72dQoM3c8R3sQzoNlAmf/BDusoPjHHXXnidCXLQuqOCCMZwfLtuR7UTX7JDnU5BpOo6ekeX6qvVl5PZQT09ndagD27r4VKs+vE5ZkIP79KMfU2ZvZUOQnPR8lo2c146tJCV7cc1+qR+kEAnYvY707NTvupG9gCoHOhn5cRBUJ5Q2yrb/KhdDvE/unjoJHiMd/m4cbs6nWebfRe8PYv2epevkvdll1fKCqKpkflVsJawVeuIZJCWQt+hDv23IWeLy4l//tEmvzMQrvwp+c+cfpfnOSTrJb1BGAcJqpyaTplUMOmET/kFmid2PtUd055Um6FkOkZwrMF6SbL+LvYgp9kNVEEw+8ujRkrEZK7vTYGhl1HQhRHleNN5tsU4Dej4FyonopWChZsGq5cH370/JYyrtwtdD+8NvkgkglX1DA636E/evsVFaP9mI+m8hJVlrbZUVyE318TQGoyl194vs5rSGwWgxkS5U6BFJMNIjoW0wcMNOHtiecbj+SZP1bgd75xd7ULyvHLv2MRw0fsvIGLB9u48IeoRcvWv2Z06MbePVWzOyYoOy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4370.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(396003)(136003)(346002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(38350700005)(4326008)(66556008)(66946007)(66476007)(5660300002)(7416002)(316002)(86362001)(8936002)(44832011)(8676002)(107886003)(6486002)(36756003)(2906002)(41300700001)(6512007)(38100700002)(83380400001)(2616005)(52116002)(26005)(6666004)(478600001)(6506007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OekHf9Qt1zbW0Dn8gPe6o4ahgCyVfKWI+6JG7ELOJh9Go3t1S0tf9hO08HAM?=
 =?us-ascii?Q?Q4x2kY8/ywXZu0Bg215XH/EclKZuSQ8EvOXIBpYHzEcU7r+nkRYlO20ScdpC?=
 =?us-ascii?Q?ZFWGjeDr58nVGzVxMmtuEbGFSJAZ3r5lA8rlWhcrCMQvx0PJQlBS3eNJ/l7H?=
 =?us-ascii?Q?kP2NEf7vsz2PAZX6g1ZUfr3oGGmxRBvBS/ur39kYBhM2J6tDeebitbKjl96F?=
 =?us-ascii?Q?hbuDpvu1WgoREzHVIoetDi5NSLs38jSilG1aWUUK5YM8Kae3MPjBMYrapLaC?=
 =?us-ascii?Q?Vwskz/rgmW3fzo7S5fBCQzCo4Fh7sHA82WEZMPlGif1WC5HSuI2r958w65W3?=
 =?us-ascii?Q?mpkUkXAvZQZaMlBtsPPjmClqqrhouQfDcH/uvNtfQx6A9Cjn2lQz6O1F7otC?=
 =?us-ascii?Q?TAOTfl+Ys0ZV6aZFRhlsCIInUbIN10orLIIkFHOSEJgqwyOL8VZU7os+AG9x?=
 =?us-ascii?Q?4u99zP4QZ0Rt5DqGwmTICT0gCLem57jLv6PRAQ93ICPwd5ccAlu0Bj+7f2ex?=
 =?us-ascii?Q?9S81gbfv/aPEz40cpPebGr+62TGAXl1A/3UvPMcLHHEDKSW9OKk0htNYjqmI?=
 =?us-ascii?Q?/qHiULVtZKslMX/w+ENcaV6zfcu9WaiXFdjHHDsrYVOB1+IsTV6Ys8Ol9b77?=
 =?us-ascii?Q?hi1D6LEPXCsGpGtoWbOXIUcvIT1h4MNe07Et9f+tDJdu2SzRz3I4/JhJcSAD?=
 =?us-ascii?Q?GjJC+G/RVZBK3wZxTsos3btUpfKi18n9YNxya4KY3KKgSS6sZWbw+lSxUYl8?=
 =?us-ascii?Q?L36zwofnDmfcI44t2Kfz0YOugXOlXHRNlCz8NfmDP4iKX/OMW5EdP4HB97cq?=
 =?us-ascii?Q?qK6Ih+vOzT52MO0WCvsJaIPsDVLUHNhr4FNNWERkRqpBoYmi1yQ7W+HoF2ct?=
 =?us-ascii?Q?6cefrIwEjHBQLTYHH/jRGh6xZ1JcEta2hCDMjMbRby4BxrcRi1ypPq1nUW6/?=
 =?us-ascii?Q?bvyQ/mEBqQtnkoZiNUN1td0xB9UNHH6bbVOu3TuthjNSlNdh6KmmY5NrEf+h?=
 =?us-ascii?Q?styvypyyoaGnkkXTKP6FLQArONtImzru08Oq85Wx2mn3K7yGFStqnDu3lmpc?=
 =?us-ascii?Q?yYWed6FjDTNptE16Njn+anW1KsU23U8Y0fCl9ld7ty3yyqcITt6vKXHsnqt2?=
 =?us-ascii?Q?RgQYZS6zqDDcqIW1P+NNur9rilK41MMMiqJFz3LmbOk2jstqZ7blocZJhCxg?=
 =?us-ascii?Q?LcPn7tJ9wB4iJ9QbVUGGzFsBdy8MJXpFYmQwU19recn7diaRz3RTvsROmvuC?=
 =?us-ascii?Q?en0+ulNLPx+xyj6PLcRBNCJBQBtJU7svmWlkJ87r+dnf3CY65T00DOqxRWJY?=
 =?us-ascii?Q?ZdZF3Ev3dGOA4hgS1uXsoV5psa+ULXdab7uRI2uOrnSw0jGhzHGV5hXtxgok?=
 =?us-ascii?Q?I8zl1BhdK8cdkMjaV1yzywD3fukd8PwcXjxAZTFVCorq6Fvj96PwVBkkcHXG?=
 =?us-ascii?Q?9U5PoHwiAlnHwgj8r7JYdbmIfBokbklPmAOcmQIbuI+PM2gojGVNtrNwgB9w?=
 =?us-ascii?Q?Ex3SsxSKAbbgHwuSy8nxNx+DfxyMVT3BykyL6twuyMQDJwqJTFZbtyRJ4WG+?=
 =?us-ascii?Q?sQBA7iVa4l1DedsEJ6ImlI6zfkZ8C6X0Ec303/Sd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd5b55e-54e1-433e-57da-08dc1737010c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4370.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 08:33:39.1094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8b/qP9rQfQ9WNo6iFthbbRdtjpqj+/4zDqIFLfgVIYVu3CCOWwD728a5WJrPqEzHLThG6ZjHl1vj9UPQ0V+QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7143
X-OriginatorOrg: digi.com
X-BESS-ID: 1705480448-111679-12553-156555-4
X-BESS-VER: 2019.1_20240103.1634
X-BESS-Apparent-Source-IP: 104.47.70.101
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaG5kZAVgZQ0DDJPMXcIjXFOM
	ki1TjZzNjEIDHZ3MTSJMk40cjYMilFqTYWAPuhSvNBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253575 [from 
	cloudscan15-242.us-east-2a.ess.aws.cudaops.com]
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

