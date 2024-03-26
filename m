Return-Path: <linux-kernel+bounces-118332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9893E88B873
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 04:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F21F0B22FC2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D4E129A69;
	Tue, 26 Mar 2024 03:27:09 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2094.outbound.protection.partner.outlook.cn [139.219.146.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FE11292D9;
	Tue, 26 Mar 2024 03:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711423629; cv=fail; b=e4LTVCW5nBbRdHvcGkwhXWsrBN38HHU2EPbUOBe4VLNMlRGopVaWIIxidul/NqRRhgSBcn1IQ9YW1K+uaZCcrvCq+5hooKHVzcXX1o9ydwOzCyrrtqJOhxTUYMMIxOFRK3A6WD7soookVWuedr3KLZAhLr0KWTylv6gV1Sj/7mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711423629; c=relaxed/simple;
	bh=ZzzORs4N4TpCL/GzR7EeRCVzRTVCpTvMUqWC1YCSFUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JN3lAyjv6+TEND0L/Y8W1q0xNuGlEbVOZezh/V48n4a6MTys8uyAk7zgiRFcmngTDVF2JTYlHQqO87mjbKROoalXTP2rIpAcU6gYXnvJ3159fx5SqEQTJdVsZtzi5LlnmucCMR65XRaxsJQO9HcJMJ/RhTtz7+dsyg4b+jjQhaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChTprVMLY2HcEkbXuip78PCM8q6Yl/0579SW6J0tXYOSjCftfowhg+Qq6E8axmvl3Trmto56qYII8z15D5vDl+p5nqrPsfvjV52RhR4osfE7v3VxNLN93vn3n000R7JyGmVMcS19YjEhXzaDpLBu2fiNsfVHk3Wu4jM3gVlNT/thYNIxdnDmr7C0aCwMNWTzbfy2zD98LSlLZr/vBKtHpgQVQLSl5vLY7oPzI4e5+inPj3ILaIjEm3SKX5mja00yc9iLyiNl8CpwId9Xb5rCDOAodpgpIhdStyisBm37jR2apE68tgtlzKlluCPQnpw1eaiALM9u6Pnv+Fqkb8+EnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucD0oXFf1SvC7cqQnsM+UhxRRmuGkb3qGoOijnPu3/E=;
 b=ZCT9WWCbh4e5l4/V0894OEWyO0BvHCrPx3ghRCzXCk2WItd2IKcSnA9R9rHx0dgHIlYtpYTe7q1tA4GZnvK17ufv4R1E9m11NJahzhCl4Zpj/wS5ZniR+m/zjjjR1TheTonfNl6bAnyuVX4wY4rMDPgyFdskHLNXxNi/3XccjiwF8KlUoPuZf/ZsmCYThT6xTXNZKqzYeAsmdNVde8d+cm32UfcKJrviQ+6JLhT0zlfOpTgiHgBif0xwzNmQesosp2WKFeaEuqMia5MrD83Ksosg65ikbopIaeU2SEAqMdgK6XHmAe0p6J16i4Im82UHDV8BiHfzeTMHot7klPDtag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0622.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.30; Tue, 26 Mar
 2024 03:12:48 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Tue, 26 Mar 2024 03:12:48 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jayshri Pawar <jpawar@cadence.com>,
	Jai Luthra <j-luthra@ti.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v1 2/4] media: cadence: csi2rx: Add suspend and resume support
Date: Mon, 25 Mar 2024 20:12:35 -0700
Message-Id: <20240326031237.25331-3-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240326031237.25331-1-changhuang.liang@starfivetech.com>
References: <20240326031237.25331-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::15) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0622:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b94b62-5d0f-4486-5675-08dc4d429d51
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GW9wITTQexcUAjE7sbz86LZF+StuOuAtrH7EZhDT2/g795GKPzG5Fa0mo+o6imSKavlroFHI/MDiU8hE4RCsSInfMNX09EDEhEAznnVzfYwtjLFAp8crIuA5GnyofTM7+kL1zq2mpK1dLefI06ccwXuDENG7o/Q17+2YpppU55tWXCIyuw9zUivx3MQsbM5O3WZzjzD7ahpUWbsEVYJsY/e8S6D8DZhxiDhgQ+yBXRhK0JS88xsq8elgc4LosnmdDFvLMyOWYBXz+N1Ondg3QeZVGLS3sym63C+2ucalCebHnK0nx8xn4TpWGcsrWiTQDPCtXIs6xhyZ8+i9M50C0/S9OsQzNqnCsn16LB+CQuXtpjvUYhT9Mj7NTxSNkqMRWc28vhAydHI0MyXBPjAJ3RozQhoIi9gZ90gorMbOTy87GKonMYyci15fvYZ+CPbzOrbi80fVSxxiHUJ4zNgW7S+1gX3bdYGF0LPujVs5TbRWV6DGP8lQjMmmVFOJapuUH5zSwz+rie5F0eHnD2wdNOGWPsizPM9p0Xc8svS932ZDCZQqnD8NaRwM3TCSNBuW+rXr747lFwSJHkUtUd8Kdu6sFdLV6n43vNE+nR0I/ka4OBWwuzEsPAjG9xp/VwWB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(41320700004)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sop5JPLTm4Zc1T9v8f5CMczxuowyU3s+aOexZb1vEeFy6U20SfEnKVUdGf8E?=
 =?us-ascii?Q?SOBTPFVM9jF8CVzwBOdUMI/dzBbARCyBC8QcJnYNyX4YIpl18RLumi2fOv7w?=
 =?us-ascii?Q?P6QIDzAdYB7lK/zB9qg/9E716myD2xVvRfUcHdhCfKvso7cRLEDmV3HUXN+i?=
 =?us-ascii?Q?TApJCdfaiUK4D0YhSPr+o2fEC0K/ucEUVhTASLRn7Ing5IdWKG5D0b5HRO31?=
 =?us-ascii?Q?QD1V1V5KtUOSj3v89DK/jWYe+RDAiYMHDTSg/F1J5eCWjKpfNIW5QNV1rdS5?=
 =?us-ascii?Q?XgEfBEnoE8ENPgCJuptcUxAOGdHjx79NGFxDJf13GKKzli0inqa5ARp4DGdD?=
 =?us-ascii?Q?aoO4R9Evm42Ua4repRE5PU8oqvFA48dPm7eM1uwBf/VYtzhBadCr67Ep9sO5?=
 =?us-ascii?Q?cnf21Vu5ASHyQd0q2KE+QXR0HO2si3V2458GQbVNppL+ys9xh4UiRBIhacLb?=
 =?us-ascii?Q?y1TAVPovJJ/zQt7gM90vLRmk84u8SKmKxFFlCDrNOYQliDPpZaM06KHLBA9Y?=
 =?us-ascii?Q?sGLHJ5AWDmk1JSUwDko4fjU0SMlvN++aEpoKsnBUljcs67kS7usCaIs1DLGJ?=
 =?us-ascii?Q?C4b2UeDiJ6LdDz4JUXALUDvrnlsAgHeNa6ccMpw4mKRsCcn7B2652uJRs5TR?=
 =?us-ascii?Q?Q9hdPzMJDDo/I061dLVrP5AjV1NeJHy05a67meiIMXtoNQ7wocRozuAqRUvQ?=
 =?us-ascii?Q?2zPJr4byeh2JUqyzJzAJoLV5zeSsqZmK2Iw+JyU6QYQyASOb1qVCXsPofDP4?=
 =?us-ascii?Q?39Zc8jBsTOl/GiH2TENFCtNQ+nX/AhzOWLWhbQaHNNiBHqtWSBPsfVHPpqg6?=
 =?us-ascii?Q?VywxGSN1N2xYD5nOHo9N3kZqcTN7tx69Idlhb415P0utAUVH+S2gi214212M?=
 =?us-ascii?Q?M3aITL+c5/2Uoz7gPDNyD/91FM//j8ZRQcO0CC4KzSiZiHrxbmlABPyCxTo7?=
 =?us-ascii?Q?GY22Ewpa1d7IIxOxeBRScx0rCV8EmYgXBXmD9lczT1y2vAj4Z9PM2MUpwW/Y?=
 =?us-ascii?Q?70u2x9985TxZntu96TKSghiTqozVHZHJgslY8N1zPQ5fDxfzjfjAeOOfBHV/?=
 =?us-ascii?Q?xGbkBcos79uYK3sdAY10+Arfweh6GYz5TZ3ryrBWCnPEDSF9RWIAGhwuEgCm?=
 =?us-ascii?Q?idSv6ETlu+GO8jk5t7ZSvAHlO0Ot4YT/JNpsQSU0F+VOAiCnObsS5hUlbHlB?=
 =?us-ascii?Q?4J5FfntOOuCcapW/fGBCnB5NlPIu8mKZudDqXoXIW5jLJMQ9x5ZMmzHBxAgR?=
 =?us-ascii?Q?wVPpHyFyDimZobP28Q4XKxJbrnb0Knae6JzloKTy/81jaDYn4H8WOn2vBcw2?=
 =?us-ascii?Q?fuVj+OCPFti9F7IWKzn4dkTo1DgUZlOZb9qjU07sNmPiVzF2qooGed0nfDkf?=
 =?us-ascii?Q?iHtsTpmpXe0XUgLg2AFqQZmcODWW1KUo39IoyuP4cBt0id5xFKS/fYWUZQ7U?=
 =?us-ascii?Q?tip3oo56uvVM5ruY4F3Ukg+huQ2Y/wX54Yfl8DgsGMiDqLFbZvosTGgCVIi+?=
 =?us-ascii?Q?V5394VdpeEm0zY2rSN0Q2QbAEdXhEk/gI/AcDEmB9ywWr9XLcDc8uQlET512?=
 =?us-ascii?Q?6cGCI6yCp+mcXl/fFIJ/dSuFvwrCBJFCi7JNWyzZrrPZD4EuCz06u/gfg3Ye?=
 =?us-ascii?Q?rYKCxiiljT54dz8TeUefoUs=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b94b62-5d0f-4486-5675-08dc4d429d51
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 03:12:48.3860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtXlffkcSi+7rHzpI0CShw3b78XMv+CK4187FuaVwb4SnibnHCNMyipBEFAkCwVlKv5jSVHdPC52NaNu1e0Av3Cry2czff7yIJnfStVLoeaCP3jLLYe1FEMDvkC52uRa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0622

This patch implements suspend and resume operation for Cadence MIPI-CSI2
RX Controller.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index a8b86369e34f..1f629be91bf5 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -778,6 +778,7 @@ static void csi2rx_remove(struct platform_device *pdev)
 
 static const struct dev_pm_ops csi2rx_pm_ops = {
 	SET_RUNTIME_PM_OPS(csi2rx_suspend, csi2rx_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 };
 
 static const struct of_device_id csi2rx_of_table[] = {
-- 
2.25.1


