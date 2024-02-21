Return-Path: <linux-kernel+bounces-73952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E3285CDFD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C7C2858F4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED527FC16;
	Wed, 21 Feb 2024 02:27:11 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2107.outbound.protection.partner.outlook.cn [139.219.146.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075DBF9D1;
	Wed, 21 Feb 2024 02:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708482431; cv=fail; b=k4iDrY4tnyd5C/zH1bTExyTi4nECIp+3L/ObHz17Y/TKsaBFTg9aBPo6PKwn5U+L7oQTBlgk6Jzv7djurd+7gCSnjs4AzgPGUx5SiEOk01/lnyI9dxOHzeMEY2KqojQf6UAG7dtAB3Pd+rYSCPrtJfNhZ4c0ht1tD1T2lRwOXrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708482431; c=relaxed/simple;
	bh=VRJ3LESqHfxIx5wjEHzeY0b0HN5lzVbe3dYX/SbyStw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SMEI+3SMbZadVdz+UKWXNZeUYzZKA7FwOKlgKtTHPomLlnI2f6FgkR4VDOyFEF4fK5FFKTZArcxliP1eho4TOkt3WzPHRY5nuTXqn9PvGve/aORhxJrsQLYRAUofVIx2ZRtwzUxfQdDTmcoOeDBYyXCQHmsVrO7q5V18cHKnwLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCazbs3yIHnGycNP9PirP9RtXuQl6xXMkb8wzLsz+5XMVy/Ts3DSlToUOznjKXBE003hrRmJia0ejc93v7jhPyRqYdmofpFIGteaXTF1G2RTvxBKuRjzvsAZaPIM/qnD44JbL+TEEAcST5XBw179HKuBgnuRr8qFAJRG6178XzGiyU1RctcKDhr9jmmP0skJOczhBvPiH9pzWz9p88X65HDFSvxwtXXkwx4oucmbSZyKWVFO0wd2kuiYB0tHXv434vKBHt91n7WeLjrWbRkPZVOlX4CxIw815m7c9/NiWL7zqlCvEPZfsTc5gaDS/l0wa1Lwz+5go/SKCJcmVCmL8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXH2Ufp5YYhxh0G5JWRTRiCebYvvnz6DUENJPrfHZZs=;
 b=EBLGVUMUQXqwCIP7FJVWekxStul/oSkNagdr+bJvFmMOdeHJNmaLBKX1Pg5A+jhHMg1xSdnQAvQpgkoIxyFJTazgSz2BowIoPih0Qupbw1moHKWWZeeMQPolXFxHCePrPLDUS0iILHGcqyw4c0w99DjBwXk6mdADJHdJIW1aa1muZ4PmbWCA58C4doVz+yqM2lMyuABz4sOf5wdnOC8fSO11ir4l8l71OIWQzIDmBEBtp5YeXZjyRDvoT+qDRNrpQQM0ewH3D0bzHlSEj2prFMhM5HhXGa6k95X8gnS6VZ6/8OinCWGeu341p8Nwi95Cr+Obk/1x9Tf/hC03DE8gMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0541.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Wed, 21 Feb
 2024 02:26:56 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Wed, 21 Feb 2024 02:26:56 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 0/2] Add JH8100 external interrupt controller support
Date: Tue, 20 Feb 2024 18:26:45 -0800
Message-Id: <20240221022647.5297-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0019.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::31) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0541:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b1a4567-c110-4788-fff0-08dc328492f7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LkCNqk+sEAkYGGJEnrxaVFAoKpypMji2yQQdVn8ID3bRvMHWrU2HRv64YIGpmAMUkkKoEaI9gEw/mWF57zCOjrcWPo8hqvMY34AABVewkFutAq2WxOaBIMfi7VtJ6BpaMPBUAr0taatNTk3fv1+5wV/fa+w5u0jCRHkaIMNXcmm9NtxNFMNmltBRBHsfuVF7rrvKTL+pLKWxEKiwIy3lE8NnS2H0+VJ5y6EwUlwYOhcdEXO8hmQ3k8nrhGVhAIXf+4qwM9vlMtFLA5TACYAb2RBSlHYn1NGvFtn6sNRhHmynivcfbfiY5sJcZMmOLBG63iQDuVoNB+EkmrTC7DcD5UeuoAk0GgsTsfbILTwKcjj4f3O4+s34U9Yxh5wIAVD/g3gn/pEMgokr2dTBWyqpfcAAT4wkk8+WZuUNke9JrcxWBT+AE3xihIyjh2TfmsSw/PzzR9t+pmcM4ysasp1mSWmQZYqHRw7zTLGu5/WGyl8QRCnTur9InQQvYGAdDAbX8VyNdM4Smq6O8ZTZl/5Io+fzaXxUys/9lwTlYZ0v7Qw9VX8mnp0Npalgk1CoVKQI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gR7l4nj7CZy7cB46UlAmwZpNzV24PIryLL2aUl91E1xRO4qn7bjRo5gMd0f3?=
 =?us-ascii?Q?T72YUe/0JGgedvZKlS1dxiPoV7qWHzIAeL/p1mfSljHt28qV4unriDu/92I4?=
 =?us-ascii?Q?Q+IDTfzonBjDXvMZQIgWXCefY80SukisnqSL7nDAbKyUAYVWpT33ar3mTIhN?=
 =?us-ascii?Q?qhflReM76EUOiwu2Pw3N2xnF+a3LhtWdb+wUYRcJRgfKzixBwHOXpPN0CNrl?=
 =?us-ascii?Q?ligIq2ihgPQxJVvEjEYvm0HgbDyJCVvKCxScr9jlrP1lOFXVkU6QQKhNxSrk?=
 =?us-ascii?Q?FRQ8l8vc1HsOgeCwMJutzr9REsPZOuih68AUtrAhUra6icEsen0JGOKvsEyr?=
 =?us-ascii?Q?EJYoO9b0tFpiE1wFZRtg3Nnx5jRRlkVGxpdDuyNBrL0keq+yyIo4i83IJQRp?=
 =?us-ascii?Q?v1mQpfAl88YWc/VfKp1In5L7yrDT4kEKX7rUBKGDHlLgadnuzEtFNZbkvwuB?=
 =?us-ascii?Q?fbs/IiwWwgsrh6x0kFiNqy0oK+7oPI4FivnHzonJs/GVbfHr2vJB+LFmy8uZ?=
 =?us-ascii?Q?q3T7OYVUH2+fEHUWF/j2eAGeqFGwJobJ/Ps0K07KqZRmfjrzi5/NXqAp+R3C?=
 =?us-ascii?Q?GeNxIbJjaqbCJ1u6CwhXtwZIDxUiiCuJy6+y8xKbzepsePUZZdquM11RjgGn?=
 =?us-ascii?Q?KaNSYYPLHU0//6yv6Tb9eeHn0hV40LHsVrWJ6BGxbnY28Ac+C4BzjGT0rri6?=
 =?us-ascii?Q?6hc0qGuKD3+3iC+1Ox3pOYoLw56QgXG4TVELZPd0iVX3VPKzvA/Jie0Rvt3o?=
 =?us-ascii?Q?ah4XekuFJg24GcS3k27TslfGUq8h9BQgfN4zMYMKETnVmn4sNumsmBJoL5K6?=
 =?us-ascii?Q?ZvPwsEGNJ06DTaRz86lUoYuVNUD6N9v7pO2wy/TZZuU7il+4F11ZZv1dxx9f?=
 =?us-ascii?Q?JcCTq89qP3jQFvA3uyc8zivzegnCwv4/8OIgSPlpBC1FGiMO7/VJhtVg0Qsf?=
 =?us-ascii?Q?Dw+lpxv9GHRG6yJeezYOxcm0hSlhI/JNOID6+qhOle7rMGvuZSGzvPTxtkwD?=
 =?us-ascii?Q?zLsfwRxGWJhh9HqknOtdISsiXd11bryNK05In8cIZKwMvtPJEI/9vwLO6yF6?=
 =?us-ascii?Q?FN2VLZJcdUY3PEWulHqN+I7XmgKJ2pmgeHFeZfmT/c+VuILs+9FG1xjH3iGQ?=
 =?us-ascii?Q?v0s0kD6O64TgvUKDwR9cOZcaGpyvxcE6MsxxzhdH8A50TrHnb54g74HvEdUC?=
 =?us-ascii?Q?/GlYrlcLtQQiGcNKD3qpbE47QWT328YUXOA0D5CHbwuGdF99tIStBn8fwbSv?=
 =?us-ascii?Q?wYTI9shy+6q7z4uT+Gd1BiAsd0wzGSr3AHYeiLkcfpLYLArrVV6nIgz7WeTf?=
 =?us-ascii?Q?0HPEINMoGD8+Z+bPLKYKhETOj8b66QV+BR0LKbVgHSKyhEojiQFJNW6dzw3P?=
 =?us-ascii?Q?RA/xcu6DNGVY2M7i2fOFRtUC0mtUr6FQnKRlkIU1qohFIq4P64Mu5qxZDe5e?=
 =?us-ascii?Q?JFHeQfOnQPjX8SXs/2A59EN0A+or1kMHaHsyjADgpbvBi9I8fnEKxlPoc1DW?=
 =?us-ascii?Q?oZBzDPgQQGWzLy8hBn08XAAc6AyBboPrE7wVueNDkFHTguoAgSFiVgtBG+8c?=
 =?us-ascii?Q?eDOPlat/1pA9Fo+c5DM36hAma6iCw7BJWzD0OAHykKLFYao2oGUEIpWiSjbX?=
 =?us-ascii?Q?OkcDT+gESgU2odfI5DBtNXU=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1a4567-c110-4788-fff0-08dc328492f7
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 02:26:56.3820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iW6rpJLyGGatH06HCi2q9+w9JiNhzH6Gcnqv9r2b0eXY5bMi7KKNkG92xNT8g2hvZYQWH3qsK3rVJkMIZY3rPwBc4XS9CBZS8tP3mM0G/iCNSgUMuK1oDMiPLmuTAO8p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0541

This patchset adds external interrupt controller driver for the StarFive
JH81000 SoC. It can be used to handle high-level input interrupt signals.
It also send the output interrupt signal to RISC-V PLIC.

changes since v2:
- Rebased on tag v6.8-rc4.
- Added raw_spinlock_t
- Added irq_domain_remove free domain
- Updated struct declarations and initializers
- Updated variable declarations
- Dropped store clk in struct starfive_irq_chip
- Replaced "starfive_intc_mod" with "starfive_intc_bit_set&starfive_intc_bit_clear"
- Replaced "struct irq_domain *root_domain" with "struct irq_domain *domain"
- Added reset_control_assert&clk_disable_unprepare helper functions to error recover

v2: https://lore.kernel.org/all/20240130055843.216342-1-changhuang.liang@starfivetech.com/

changes since v1:
- Rebased on tag v6.8-rc1.
- Dropped store reset_contorl.
- Replaced "of_reset_control_get_by_index" with of_reset_control_get_exclusive
- Printed the error code via %pe

v1: https://lore.kernel.org/all/20240111023201.6187-1-changhuang.liang@starfivetech.com/


Changhuang Liang (2):
  dt-bindings: interrupt-controller: Add starfive,jh8100-intc
  irqchip: Add StarFive external interrupt controller

 .../starfive,jh8100-intc.yaml                 |  61 +++++
 MAINTAINERS                                   |   6 +
 drivers/irqchip/Kconfig                       |  11 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-starfive-jh8100-intc.c    | 208 ++++++++++++++++++
 5 files changed, 287 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/starfive,jh8100-intc.yaml
 create mode 100644 drivers/irqchip/irq-starfive-jh8100-intc.c

--
2.25.1

