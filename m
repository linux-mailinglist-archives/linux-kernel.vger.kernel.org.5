Return-Path: <linux-kernel+bounces-80577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A55558669E2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC0B8B21432
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75F21BC30;
	Mon, 26 Feb 2024 06:05:01 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2131.outbound.protection.partner.outlook.cn [139.219.146.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BAF1BDCE;
	Mon, 26 Feb 2024 06:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708927501; cv=fail; b=NjGTDwQhE4Sa680Y/qUOAfpyAQx11Fs3a183eDsV/jQTBd8kUNKibPG5CXK4iqAr5sAEo52SfvLx0Q28uvn399XQWUUVDkvtgKVjsiGe3t/tzHMM4+AFeVyS8rAA3n8X8ffkQ02b88hQ2rBUKWWt3jTr07AllWV+1wuazYd7WAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708927501; c=relaxed/simple;
	bh=ijAC6DtRyHCS+TxvTSHdNenGPycAQt4/0/Eejk5ldi4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CEZUvyQCuqnuqTRtE+C7M7i6sTG97gockanMmRNhcOBggdMR4RWZYZo7vpVAay1iWe2RqjKIt5Wniy7NJ2dsIl7xXZVsZ7kxAVw82v3fHk59RSyDc971ayASHtmWxA20a8jIDRWXXAC4ZhQTIUZAxziakHUAEwcIpYSIK1pOT2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfEFJ5Y5leTBHTAgrbdaK8Uc0uLN4h+v/RvRCjOF1jKvWhdi0ks/MihqGhUlukDhqwmAclFSNopOYwdMMgvttoTzNRi1i+mqPNBQChVAxLc0uBT5OJSbJejZflJP11n8Zs6k69SOIG87+fBX9BWmiuwdltqHtSMC6N0xuwSAn/TC6sVwgUE/161D78ASnZI6Ewj4Kgd4wEj39mc2D8lnM7Rw+5NFSp8HZJ3sy8lc1JoQv2DGp58zYpOS6ajGTzcn+ALJLyGq9UzvW2bSZ42IiCF19nC5VBA5rF6tM/UKZ2O8QdNqVcIpalbPdtObk3nblMuHWrp0kg0Q6NhM1VKpgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0wqzL9KCuENp2vmnM/R/u/DQnxZW72DkvivK6K5EGs=;
 b=h6C9vhNCdPeG7JZtvUcL1QJ/xirAkCgGyW7rLcurRkgJWo+62rFcCBZQJ8iXznN9D/KphlgFLnoIvOwpF4l526FuE0xezW5KCuJbv/ovKSJO3Ql80E3sX88tV5sfGG33wpRf1iE+eIee1qEdQaVB2pVD1Ad5+uVAYPY6ynveUR+GRVTV/tsIMhAwDbkVzl4St6ncHjINZvS+0VPJou2yXkQDw2jzHela3LsNNjTYXbF7ThF6hP7WGf+U3juM0hbusN6n5urpSn3dBNEpUYjM9LiG6guclKaHePuDdMkguX797uaHxWGIG5v8xxrPoO0KiIWiwJGwDit9+UMyTjzxXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.42; Mon, 26 Feb
 2024 05:50:33 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Mon, 26 Feb 2024 05:50:33 +0000
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
Subject: [PATCH v4 0/2] Add JH8100 external interrupt controller support
Date: Sun, 25 Feb 2024 21:50:23 -0800
Message-Id: <20240226055025.1669223-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0006.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::18) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ef64b8-860e-46b6-be76-08dc368ed8c9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VqyhRCosvruoweP3zFvRPg9TAGDGNEo6VOQcqjR+aDI13Uhqe37vhjv0zyswP5Q6z4YnZ2xiyQuTGpbDtlX+eEK4FcaKIhIM/nVSxt3yZwMsfyMm10VCNfA8b+/m1bbyMKBduzhI5K7Zjd4mxjlTVr7I8i5EkPADiXa3wedD4ghkgvzUyRksFYsCxk6DymN8wq2MMhJRcaD86SQYG9nvDTgcdPi2HwgQW3uT+gwW9IhrdZIxScublFjLlwsGujM7cmRLGXDIir6rC+rrvIEg20ShIW0OtW9OMA6zNB3xAu9zz4bjJbxmb5v9I48qHG3mlNXbpEODBBlpcvThUzEWVf+7JzYWBtnb8CITaCF0+/vOJXwLmmit8sK9lv0LQ5jSAephhmL5L1nYiRq+IUC98PdLwSuRmXvziHoemJQLZzcje4aHTx8YbVygrLjUST8goman75V75Kwe8nxd0TvdVA5SbnDqBOJMSabtiZxExGYJLxEK37Pa5IQAKFozgbp/ZngVg7/o3LdSPui3WXJGqalMZahbZ48d1uu9lpvsv+jVfUvps2tQc2j/6CniMt52U4I2TQMJxe2CdI4tFb/sG6z7dbKOsJe9BV39E5DTL3Xh1RfMJE1mnOXZSZo0Z8e5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hLFhtELmrjhysrm6MEbw6TbCQljYvrRni4aGwnWszT6UJAqX0lrTa79X5oUJ?=
 =?us-ascii?Q?kd4lYvXx3UZBUHWRnVdEhr37aT6rc861OKKgl2OwWxHrctUnsnFW2nOANjfy?=
 =?us-ascii?Q?pNmMjZndVAsJPdYQSLWCLs1MRmTjCkTZGJ/WW+Al4n653gS9GRFQRLFijOv+?=
 =?us-ascii?Q?bOsyJZlaGo3+4LO7pNY1p+jnL1itTgjdAE6xwDgxnsXybHCoDZ2cXFYWgQoa?=
 =?us-ascii?Q?LlPlOmvQHG1ZV8cU3SEJrh7iWdTtBYjImtySk8wIWoFOiRJiljyj0qH7bU31?=
 =?us-ascii?Q?ivE1wApp6yHsYFt1XMdZYA/WI1BZZB+i0DFHyRSTwXl6DuM/7zKK/ORc0wFc?=
 =?us-ascii?Q?0uZdmy4/XmF18vDrgSKs/Fp+jFVS9LI1fo61YBh0Q76Nbho6NVd1Yxy9x7A4?=
 =?us-ascii?Q?3UB4buc6wlHsIANgFQx+DKoSs6HKr8Nybkfe979/w6HHczqRpACVjC23Msx8?=
 =?us-ascii?Q?sDUEy6I3KrEtoyuFVIwroV/EFiEaG4APQ2f5oUcl/8LKsSiJjfze+8r9A/lj?=
 =?us-ascii?Q?2gj5f5HPAbZQvk9BCwEm2QRX/69y4p9UTB8Ch2hggLC44U1o0X7WjFOqk/dJ?=
 =?us-ascii?Q?9pRzyMT1SDO19ifv780Quq/OP1nQNDCrp1rz9bqBYuHqUAPu5HnbXERKjyuX?=
 =?us-ascii?Q?lXBRFaMw9zthFn6P6/+o5hnCzCGRTEOn9PSnrgiJhsqdyLSC6JNOLmxXKFtC?=
 =?us-ascii?Q?mHhKKryEX3qOgetTbvGWvRAJ3MDWpAkw642wQx4/nU4tXmnOuhOe7NEJ+ACu?=
 =?us-ascii?Q?ueYM7zegjQz/o8eBeUZnt6ijcVV0ByWJfSQWAw6EqLTpmjsHmwrC/sDGiZOR?=
 =?us-ascii?Q?gOFfjFJFUPMLxDelIvZcpsoZuvCWZE2dkRelN5SJ5vsrsr/Gx0zvCP0NIEmu?=
 =?us-ascii?Q?cw8bJ0e7GTFjFhBxRpFPlWNkbjmFDmSSt6Quyo0PrjXvWtNe2wk9EbuBv9Md?=
 =?us-ascii?Q?j2UDAZl8jxt4Wen4f8aC9Is26cH+Z5SrETzHdL98qdT0EKDsKvh9THnwONoS?=
 =?us-ascii?Q?6qMBGbBD0j/1noO3GahrLxIx9yn1YBNNpxt9HHHhJ87Z9lEC2k6laUBY/Dn0?=
 =?us-ascii?Q?j/iJWkfJhUEfyoCqEueRq/NpqOM8cxLw5e0p/KvQ1zbf9KS21Vx9RAP1G4kJ?=
 =?us-ascii?Q?GHTyr60GJKxIHsoVVHusUVt1Nit7y2SkrerXK1Wci+r13tlituw7kEIT0LwN?=
 =?us-ascii?Q?19Iw3hvh8peO1WPE/TFM50yLdx1ulUiWKx7VDrUvIC2ZWYR7ZS2gjt1CsWav?=
 =?us-ascii?Q?yalTMhy7jPS3Y9oTZzGcTEKFBHmmjEPI4Ag3WwVdG6zLZDuNWPrHgMaEnIW5?=
 =?us-ascii?Q?QZoFVk8XpbwtwUhc/TRoXU+BcRXSCJssJ4ptYAbXB1tvGnUmVcCEmOa5Wuvr?=
 =?us-ascii?Q?U4nLIb0ysdT8KVpaxtJZ1gXNcRbXGGI/vq5O2N5uir92RWRx7IHmCwUSglk+?=
 =?us-ascii?Q?zll1Q4Lce2ZD8gCZDYnHZlp0Q4jOZuyyExzNyKgAYZsvj3qvMiamDMFnqy9M?=
 =?us-ascii?Q?1CZqjYnx8hJZ3WxnFKKfnA/k3pkN4GBcxB2/n36Tl2ByeIVunNlwBZgrx4RW?=
 =?us-ascii?Q?XZTCiam2KliIWoTNOzK4vqVJSFESZ2/13hjV+XDOJSfq/PK5VNm9BKoBfVc9?=
 =?us-ascii?Q?VeW44YJuxXnGwzslunMgPcI=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ef64b8-860e-46b6-be76-08dc368ed8c9
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 05:50:33.1452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHod81AiHUng3QpyIxHUTSi2wxtBsgpBWu1OBFmg2JwNAS4qzvRlc9N09G8cSODC3iXLw9vTBnJQygaJq+SgFrEIS6oV6cubnyzSoWO94EuZASddnryeLal6fnHzTOpA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0671

This patchset adds external interrupt controller driver for the StarFive
JH81000 SoC. It can be used to handle high-level input interrupt signals.
It also send the output interrupt signal to RISC-V PLIC.

changes since v3:
- Replaced "raw_spin_lock_irqsave" with "raw_spin_lock"
- Replaced "raw_spin_unlock_irqsave" with "raw_spin_unlock"
- Replaced "clear_bit" with "__clear_bit"

v3: https://lore.kernel.org/all/20240221022647.5297-1-changhuang.liang@starfivetech.com/

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

 .../starfive,jh8100-intc.yaml                 |  61 ++++++
 MAINTAINERS                                   |   6 +
 drivers/irqchip/Kconfig                       |  11 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-starfive-jh8100-intc.c    | 207 ++++++++++++++++++
 5 files changed, 286 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/starfive,jh8100-intc.yaml
 create mode 100644 drivers/irqchip/irq-starfive-jh8100-intc.c

--
2.25.1

