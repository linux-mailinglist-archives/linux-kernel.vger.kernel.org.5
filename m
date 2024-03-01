Return-Path: <linux-kernel+bounces-87788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C50C86D907
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2647D1C20929
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807F02E416;
	Fri,  1 Mar 2024 01:40:40 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2117.outbound.protection.partner.outlook.cn [139.219.17.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE52D8480;
	Fri,  1 Mar 2024 01:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709257239; cv=fail; b=HcZVJpL26zfQDvydVHuN1Ro3xJFiCU7KK0WKAF6SpjXKxxGZJD2Mvxgsc8ALEaUd+7E3ohyRhcPL9FYNu60DrBzrX+ht1IJPl77N3ORlM4iXsYVhGO6xaw4NKOhTi0XX7pGSdQMIIYw2pC6AI/XMzKjaZJWYhBj5OLQ/YvpeAw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709257239; c=relaxed/simple;
	bh=2BR3Tde7w2KeCsWNWL8jcs+RKYR7PxcB+OvJu/iXYq8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VdT3KMrgJQaVyghtuJOYKNnQLji06wdhpqJ4pc2fSVnkAu84eXTKZSvUg4uQwNqm6QAYFxe0DiaCQ3nxGEjoahOYOIc4MrGto77xma+BzpcxsR+fTARLa8jzZE9dp5lpxJcNNfwZQg/wiz4JZNMNUkzvWxgONOuLh9yTX6N52wA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSnt5YVurvaShbHx/fe8X7WIFnfS5WfI9X8soLHFPIGwHeSmwmdifoK9pOOw1stpUTzf3RTTeKgqidoSpoo92CPznq/COffasYhMea6jwbw4XAkfK9OJB8yD5bGb9qBIR7YoDLGnUv1KgGz1S4Pc9p1oPhJZ7aSoOEgSroUYtR8d0UY/fRENNZM/S4f1g37Zo6uJQ6MSjS44Stkj6mhfKvE4U+Vb8A+fDJ5F4LSvxYaKgRSesiQXTLR7g6cMKqYehyt9dFK1/Jvz66wH3P4+iNmZMapaj+ZMjePsYcfIR+pYvE8Nn30KClYUrR+EjrvMPmKnXY9YhODnECsX87swEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMVKcRgaNn3qIx6x+wfgYBmszKFin2iGu5OOyw2CjHo=;
 b=E6BYNerCgdd0TYgMim+s5r5yXU3R/cRy4lVKf4jva12Kq1Mm6YStrCbGyjsBPTxG2NSMT9rIi1nKFokjIEhp8EtdjntCPtkoN35B7Fwh0gG+Q0cYwyT6SP0+PSLyF1H7meVj/+ZoeTlUuxXbSl1Zv4EhcHNEJcPkZAqMjtqrtHuDrBD33JMdaOPD1THF4WjUD5QA5G785tLcZEQ+P/JZdwnZH3ZoNaEBTJdVjcu3KXqVX6lWsNO4yQkoMJeW8dWRS9Qlksz+EFFqgtlSXVvEJq8XTNxwha5r80NBt7uodVOCmFLxIRPHU40a+kgxHurbiOIm0Qq2TTrTM5IrCpIwtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) by NT0PR01MB1167.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:10::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 01:24:25 +0000
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 ([fe80::db9a:cc7:56ae:de5a]) by NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 ([fe80::db9a:cc7:56ae:de5a%3]) with mapi id 15.20.7316.037; Fri, 1 Mar 2024
 01:24:25 +0000
From: Shengyang Chen <shengyang.chen@starfivetech.com>
To: devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: vkoul@kernel.org,
	kishon@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	minda.chen@starfivetech.com,
	changhuang.liang@starfivetech.com,
	rogerq@kernel.org,
	geert+renesas@glider.be,
	keith.zhao@starfivetech.com,
	shengyang.chen@starfivetech.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] Add JH7110 MIPI DPHY TX support
Date: Fri,  1 Mar 2024 09:24:04 +0800
Message-Id: <20240301012406.92589-1-shengyang.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0069.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::36) To NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1070:EE_|NT0PR01MB1167:EE_
X-MS-Office365-Filtering-Correlation-Id: da0cb591-f786-47c7-888f-08dc398e54ec
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HKayPVMk/S0iAuaYHb5UwCyFnWXme9K1UklSn1plDARkJt8WMKkrebgfeCPX7My+WXxhm4gxnjPoTB/QD1d9ZjQIgiauZ9gLzTzesV64i/i5iNZck/JeHrvv6570WpE5OJhIcZf7WOkLpbp2fzDg8poJ6p4y++xbYYBKff4RVHzQ93cTJolDhsGd2QEkfAIh5yO+7rMqsJMOoXJxulquI9M/fVC5RiJFSClGMrOUDu8MP9V8/DFOq+daKILVUydtLSx2cB21eNX2w8NjaHJaOIzAGakaPFm9jODzM5qTBNrNFHUmtbTZQvqJlw89l3f/0mHwNSavDA83zGjgS7tSy4gvST2gVF5OWgJ2cSeHb6fXKRn4ZsVau7I/6FaOp8Mc6WaeUToJUIH2AS1niOLSe2xnTZ5aCwFUEqFgYXrLP8qNab4Ihu1odcLxXYniYKTjzd9zVuMeTDUeJGF5Cx0KkPnqK61geS/XTr9l5aDX6bTIPVtpPO4cu9+SCtbwu7oQxTLiVoZ/mP6BVmqV5u0+M7T4se0usPtXaBFtULAirb3S0xRoqCpOi0Un5tpezS5aK1nW7l9LiVcZgUpZq9T+eI1o7t3u1qiopd6r23tAgbJsl5eplkXa24Bumq061eUJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tXE/JfWuBzpsHkmCUbnol8vprjqmqpXY3dHdxj2ZDM1d3T8YykoB6hK2S3u6?=
 =?us-ascii?Q?9JGuHY9rih7qdLCoNOqcSIGTqtvAwn6b7laE0eHazan5iWMRvIslAR0CjZGt?=
 =?us-ascii?Q?Xl6xOXjTEFV4E3LmbC3G1Fesy3dB/Mu66NTpkBIdaNyf65SS2y0CcUhY8/r5?=
 =?us-ascii?Q?yfbhdHEgnoMOOwOMOS7+pd999gNvnJGeGGk/VS6AIErGBalEZ6lIMYhhOxSw?=
 =?us-ascii?Q?oLNlZyHOe+SK/MbKDtc9WSGvRSfX8xXz5pvOiHJAgc5JOjZQz692AbnDqScJ?=
 =?us-ascii?Q?t1cHg2fB/jc30rkmdyvE6Iya3Ygq6qs0wfppCkoR+tRiotkRhOPyRwHaNpLD?=
 =?us-ascii?Q?A6ofQOywMpUs6/oZKYW0QrSxT5i463bprgkm8BeuBakyqfe9vZ1x8BKSoI9Y?=
 =?us-ascii?Q?MtXxE8gpujZh8gFwN18Ge8IyIuOYxewhyol97H9+OyqCKkXtyGroHn04K/Mp?=
 =?us-ascii?Q?tUh/ZqDypy9u4aIN4kM0FuYKl+ll5QIbrO7IipPvDFrjs22srnTozwG5s5TW?=
 =?us-ascii?Q?1jakn2/kDZUgT1TbRathLS+/wIymoh7xdVoOUcbpUWYZmnTKOu9JykxYUfwB?=
 =?us-ascii?Q?bPm3ZXNQ/ky4/6LCect18Gf529/4ljt1jAHZ7byL3nGp/BFcty/nFFAngKY5?=
 =?us-ascii?Q?6CysDeIFYWkVBwe1TPqqwIKHxJbR0bIkQiMqFvzikz0DEgBbczkFzBX10MNE?=
 =?us-ascii?Q?fpg7TnFX19DFP6/pwOQPINo84irSuyWQiQoZ+YGPr6GNzItukNzPxsyXa4vc?=
 =?us-ascii?Q?prrjE4hB4EAoKqR5M/tuMEFOo4VXUhwzw9OnpqlrsMyqCPZ7dIi1GPEGYsZQ?=
 =?us-ascii?Q?z3PV19+lmyWFIgSKI+r+vwnkZmWkh887uDzBL8inzGiuEpxi+7n20DJ/ozk6?=
 =?us-ascii?Q?37BoFEsWm7rUY/xeuNulLsXg6aQ1G/puOLT3BrXjOU32vI/84X+Fsgarnj8g?=
 =?us-ascii?Q?rVRfXkuq7G4t6QqwNWCMVNDvg0dz9S627KeCjgpd0B6Ic3osIoEiGXwaXC92?=
 =?us-ascii?Q?3aLtYeeHnGWbSLmWPh58EIhb3gZY/aSO/RYGLqh9zsuOW1pL4g8asypFERWB?=
 =?us-ascii?Q?WpsgazBSBwmsteMkvw3Zdtg7Vo2XNo6YGuX5Z2POg8PEu150UE7v2sH1h97z?=
 =?us-ascii?Q?4vOwegUaSG+qyxcvLKasLSGhes1JmluA4WkSksbYwfo0SlRt0uu+vXo39Y6L?=
 =?us-ascii?Q?kshRj1lKnGci97B7/rqVkoL4VYViUADEEAwEdfCF63VT20/D1vJjiaNP3M0L?=
 =?us-ascii?Q?cNn8mJFRalBT6jG7W8UTHAwDSe0pX2NJNdJ4fvT28Ie3dUTDl2YYN35o358p?=
 =?us-ascii?Q?VVfYysaR/qWmHfnPfaGcCQD+qvudqcEYFuCwH0lf6OPVm8k7Nxc8Q9CHqxiF?=
 =?us-ascii?Q?DFBLK8Z84ScMgo9UzB6avsnoMCjgTXH3Khw5ElkSBX5aVF/I1SUym+jAfDsZ?=
 =?us-ascii?Q?664hVhtuQV9aSizio4e8xa7eD/7BmZLudXo83gxmsTqGYfaoQnMLaa1IqwDM?=
 =?us-ascii?Q?+59DohMnUZr/8Jrlt8mIZUlUnuS+psk2/0DmYXhbicagea56/Y82JVg34SVj?=
 =?us-ascii?Q?uN3Zuv3ngJWTDkg2IgI4PiwlQNlr/C5Jq0omwW77fqhVMGlsnqLH/xjBdg0n?=
 =?us-ascii?Q?QlzIjRZvLuu0RH8JQzal9Uk=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0cb591-f786-47c7-888f-08dc398e54ec
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 01:24:25.4597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDCawmhYF4YUW1Kd27yYKZ6Xx5StaE+2jsCjlRBSMy6A3A+q7DnhraT5rCuN1ZLtNvlPjHXmPX+a2Gj6INXMz0/ooqMWl/b9fwYGIYooneY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1167

This patchset adds mipi dphy tx support for the StarFive JH7110 SoC.
It is used to transfer DSI data. The series has been tested on
the VisionFive 2 board.


change since v3:
- Rebased on tag v6.8-rc6.

patch 2:
- Lower case for hex value.
- Replace bit shifts operation with macro definitions.
- Drop delay in stf_dphy_hw_reset().
- Change variable declarations order in stf_dphy_configure().

v3: https://patchwork.kernel.org/project/linux-phy/cover/20240206061921.107372-1-shengyang.chen@starfivetech.com/


change since v2:
- Rebased on tag v6.8-rc3.

patch 2:
- Drop regulator operation.

v2: https://patchwork.kernel.org/project/linux-phy/cover/20240109071246.24065-1-shengyang.chen@starfivetech.com/


changes since v1:
- Rebased on tag v6.7.

patch 1:
- Drop 'dphy_'prefix.
- Drop DSI reset.
- Drop unnecessary resets.


patch 2:
- Changed the commit message.
- Use dev_err_probe() and PTR_ERR() in probing.
- Drop DSI reset operation.
- Drop unnecessary resets operation.
- Add configs in array for full support of the module
- Changed 'void *io_addr' to 'void __iomem *io_addr'.

v1: https://patchwork.kernel.org/project/linux-phy/cover/20231117130421.79261-1-shengyang.chen@starfivetech.com/


Shengyang Chen (2):
  dt-bindings: phy: Add starfive,jh7110-dphy-tx
  phy: starfive: Add mipi dphy tx support

 .../bindings/phy/starfive,jh7110-dphy-tx.yaml |  68 ++
 MAINTAINERS                                   |   7 +
 drivers/phy/starfive/Kconfig                  |  10 +
 drivers/phy/starfive/Makefile                 |   1 +
 drivers/phy/starfive/phy-jh7110-dphy-tx.c     | 702 ++++++++++++++++++
 5 files changed, 788 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-tx.yaml
 create mode 100644 drivers/phy/starfive/phy-jh7110-dphy-tx.c

-- 
2.17.1


