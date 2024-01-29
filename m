Return-Path: <linux-kernel+bounces-42503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FC9840243
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881371C22285
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657125914E;
	Mon, 29 Jan 2024 09:52:45 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2056.outbound.protection.partner.outlook.cn [139.219.17.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044FB5820C;
	Mon, 29 Jan 2024 09:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521964; cv=fail; b=E7uF1vDnX8SFTuGh5v44Au7dyw59C6EbnHfKh0NLvbjKgScoOfFMtClDHw6JE7HsFF80IppggakmBTbWdLfjQegxmNpUWCQn29e7Rj16yK/iDjEjq+fMB0er59gursfG24G4ZrkTe2IvNhKKltKj1r6eGYNB7vsDFrsn2ZEdm+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521964; c=relaxed/simple;
	bh=2YZfhxXTrz6dqRa0HmtIdyOb2+I/bCk2fq1+oynN3gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jwz/wx31F/uC/e4HUeL5l+F+VwshxFj8NNGfa1JcTxMX9Nq2g2xwmQDWDV7TH5tvnmwHpxutr9Ac0B0xmAqtMprigW/VzaGQpNy/YvBvPotmhTFd8rtg2MK1d7YUY5Jm9jacIYW+l8zT05XaF2FpccePr2ZbQF/T3XJ9v7zSk8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzD3dozRvFpfYUFiZHaG6fdCZPfWcIfav5AVoaNobqctHAWU9NmCalEK8wErU121lNw44sZwTEhD0FOcPWoJ70AYM0xEK1fruDXijOhiDlpP6SQBdOTkjtKzrr5LdzndqNEvwMhXtcJBbmWqHlTUeNVwb5fy6+ZPbnJKUT+ZNe5v/m7x8nRQsnCxe5yNSmpzx9wsBaTPaRFyEYzS0+F/IcQGs04wo9kYx/vi0vESca8fvWBRXwtYZGrrxwBDjWSqvKQYRPocdJ2pG3IMVq6oJJ5ef0EBgtaBIu+g5bobirPGF9VmUaFn8W9Uqdl9N3rnO0ikhsQvmFJSgUiSBzZSwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKPbgEYhEJkMDhzGNyMD+jRvD2wxpI5aGwtJ0B1ETZc=;
 b=VjtGcqHW7focgmD8o+3mMS0Gy4gyKM+ZymlIrHcaoNgvR4wvI9fYEYhVl2EiCL1sl15gPyGdQ9aydWY+XtNdeZ3munmxmmjFZRNowtVmkmXP33eqrTvAo78vh9bjxPwwKf4rjK7LoPDkyFh3ESIdiYYG54uQmeU8+4WtLHmYUbCxkns9PzeMNqI5y3nmZZRYcOoFoiQHn/WrdB+0+i5t49Se6tD51BNjT5OqyGiTgm7UrtWJ/ydoxPyxAq6qZzN/TFFsTOVuQiMI+AwK+3GQPAOr+/HLgSPDoYri+vfvjFpu3ABUX3abD/i2cUHsbt4samg76ALmdPXMb6vckxrxlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6) by ZQ0PR01MB1096.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Mon, 29 Jan
 2024 09:52:33 +0000
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 ([fe80::1dbb:b090:7d89:4e22]) by
 ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn ([fe80::1dbb:b090:7d89:4e22%4])
 with mapi id 15.20.7228.028; Mon, 29 Jan 2024 09:52:33 +0000
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH v6 4/4] MAINTAINERS: Add entry for StarFive StarLink PMU
Date: Mon, 29 Jan 2024 17:51:41 +0800
Message-ID: <20240129095141.3262366-5-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129095141.3262366-1-jisheng.teoh@starfivetech.com>
References: <20240129095141.3262366-1-jisheng.teoh@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::15) To ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1160:EE_|ZQ0PR01MB1096:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c11677-4d78-4714-17a9-08dc20b003e0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HlJT12Mm3EsQW8N/o7+rWUJ6bPA5d927YdM+P/JEm1xhe72GddqgyfWEb2xubLOlZ0d8ZELrPxgT9h2OBjq45VYWQ4gtJsHIODvysF7aaZoc4iG2u9S1/crF+xOhkKpYuW6lwBc5Kx84D5HGGsR2+0jm0XvWOY332SoVMKAam915GPtPG/IYEeeYrEwzln1vzRBYtoIG5PuNVeWlLn3KEc1fBLGXv0HTjheySo80bQ1E0rErnELt5m+B902m5C+t7MtU7s0bY2y31eXfiNeJj1LZirUHR7w9wOGzRpVJjR3EzMR6OUYBKbXZ7jcNYfP5OLsaWd9bfe8YoBm5BYZAhCpQp8svmETvpXRBM9lZaAYFybvROZCJAOmugxx//V6xz2SNHmXfQOHAhT0yBL/HMe55Db8IwtxHO9OY3ctoRTVB18bLTqFkbP6FFMx23qr62TjQp85x0UDdjf3OK2extSpiNGRVIDhR3WfVPXa66Xs+UKtvqgL+m9kX/o6tz6uSG2sQMkxPK1IqvssrcVk8HzJMh3mMGWioDa8TzkHDPPyytOTDfIGwUH5Unmv7lhLH22ioIvQx5ZWcPGRGWD+nkw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39830400003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41320700001)(4326008)(7416002)(8676002)(8936002)(66946007)(4744005)(66556008)(5660300002)(110136005)(86362001)(2906002)(40180700001)(38350700005)(966005)(36756003)(52116002)(54906003)(508600001)(38100700002)(40160700002)(66476007)(83380400001)(2616005)(6666004)(41300700001)(1076003)(921011)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bm5eM06aMM1ydsJf/iDlNsT6SLuVp7Ey+4A7utKACTu2Nn7eEYi8OiJ3IpJ6?=
 =?us-ascii?Q?k/U1XzqKF6ueSxLQ7KuNEw3Lp2sFxXMwq9tD9G4BO+CwuRDhTcE0sAY+2vf8?=
 =?us-ascii?Q?P8xGBZlu50EkXyRYY6hk0ThKxGaZILz7EstwTjXb1HamZe+kS5aUC14PI3gI?=
 =?us-ascii?Q?1LfNNci/CAzrq/NQttXHT1Hr4629RgYvXjswNWixKYb3s4KzytD12v5OElUV?=
 =?us-ascii?Q?vDYs5/ZoqkKRuA9q7sLAVHsYWTizJUaScePjQ76vOdGWG1J7e3inoMYyZ994?=
 =?us-ascii?Q?9ZobzOAXbOI6gV0Xrvq/hhHE1QlQOWZLXvQWczPwJjyOf+QkZWqJqIuC0HzT?=
 =?us-ascii?Q?u35lbNhC4ZHtIIJ77NaQfYytKXvKE/Kx4OFAUmS6J/lNuNcTUf3NxKJvsxk4?=
 =?us-ascii?Q?l7Lfpx+L0jlAD4WLVsQ2/q+M4zllGZzAO12iEqTJk3EKjk0yHo9DFdH1ZiDc?=
 =?us-ascii?Q?cZxIvr94Itl/n+uGcMZlPfUmN1kso/kfjs0Spuc64vOZlnWyDrXROGb4YZ9E?=
 =?us-ascii?Q?OiiiA0NUeG6QReIXm2I3MDSCw0DoaafrI0nId/5PtzPJFaoeRIqCdjcOPDsG?=
 =?us-ascii?Q?c9FtdtRjc4CWW2Sy6pRB9ZjUmQutNXXHlOr0KN2k2aOgprDr8esSEa83D5H3?=
 =?us-ascii?Q?aCkyH9RY+mvzIqfzJrYyX1GElLu6U5sgY/B7LjAZsl41HMalMy4lwzemY8Iz?=
 =?us-ascii?Q?kw9eny7vUpF5xWVuuGmbZBiEeNVwhca2h6sAT7LS9ksv1cIs5XxSaplpJA7F?=
 =?us-ascii?Q?2KJVwNK48NL5vfLvRc4EHVaKUlqS6VQDj8pj2WzyvfucMFGNQrNHJ4peQNKj?=
 =?us-ascii?Q?5yCiQT/4wjaPWpwFf6h/vaZmECp8BiPhv+1xym6BK+DB9J4dudSxFZQ/c8pO?=
 =?us-ascii?Q?a2DCtAlfo+fV/R6+ffgrm8q8BIZfUILEbeNZOjwgsz7AehGkIma/VuatfgRu?=
 =?us-ascii?Q?4taEJvaunP0eoxeHP88nWrB5DoDcqSy6xa7A5gSDFQqBliVTYO3EcrbrqXwm?=
 =?us-ascii?Q?CO3VGkZBY1Tw6HQpNbKBYTFWRMvqV+Xy9ubU2Jca1Ic6tOmXYXe+7HWQxkcx?=
 =?us-ascii?Q?kps7/CJlp85hHKrRJxzvtvCiw98amKoLnDI4n8pAVIRmqZnHTO8s+zfThqzS?=
 =?us-ascii?Q?JfOx5gdJqA+ypkw4SOyZhBQy9W3DgegQr5vyxrcLvaeWI3NLmIpNnOqL5jUA?=
 =?us-ascii?Q?wna0Rs/f2rBmmN0w8h/+Csmt1NQO6/DL2WmkKAgFBqY3rvVdgqDipycpirIR?=
 =?us-ascii?Q?TuLs95iXBRwbxZHh68JyIZ1Qtr60rI8YySy/1cZepLy2lT14/528Rf8xP7n6?=
 =?us-ascii?Q?/hSP5pnP7zD2GcUDXhpubnFsJJT1JBGY0cN97TeR/XxPGK/TwDRkSjrTJtti?=
 =?us-ascii?Q?nv43vaHJdIrB04HU0PllVD5RQyXVWeZgd3x0xsMdBbCjXWVGq+7Re+gKwzqO?=
 =?us-ascii?Q?BKknQXvJGSXKrIPqJQbqYxAp/V9dNwE64EtYrg3pEWF7x6q4nBf9bsfixpOY?=
 =?us-ascii?Q?CX4a87/fKPsiKJkYBgcDwNKIJDm5eg/Ys30BOFghAq0h3yztc1F3k3LQu4ft?=
 =?us-ascii?Q?iE13tEHCCsVE03l9O+vPZuZm/DUgyeJrUsYU5o8QUcvDW6N8DPa91qZM2zua?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c11677-4d78-4714-17a9-08dc20b003e0
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 09:52:33.2963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJLo593CliMnRDTczmtzZgif5RpNxsoT9ac8h6q97zPLfOrqfPSdzkwmeUyA+reoWKLD3Lfsj4rBcHzwqnHYQhM25yrPm56tTYhQkhGyONQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1096

Add maintainer entry for StarFive StarLink PMU driver, and mark it as
"Maintained"

Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97f51d5ec1cf..5c4b2ae90823 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20742,6 +20742,13 @@ S:	Maintained
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
 F:	Documentation/devicetree/bindings/soc/starfive/
 
+STARFIVE STARLINK PMU DRIVER
+M:	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
+S:	Maintained
+F:	Documentation/admin-guide/perf/starfive_starlink_pmu.rst
+F:	Documentation/devicetree/bindings/perf/starfive,jh8100-starlink-pmu.yaml
+F:	drivers/perf/starfive_starlink_pmu.c
+
 STARFIVE TRNG DRIVER
 M:	Jia Jie Ho <jiajie.ho@starfivetech.com>
 S:	Supported
-- 
2.43.0


