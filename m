Return-Path: <linux-kernel+bounces-43973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93012841BCD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A711F28091
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38816381DD;
	Tue, 30 Jan 2024 06:13:52 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2062.outbound.protection.partner.outlook.cn [139.219.146.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA93381B9;
	Tue, 30 Jan 2024 06:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706595231; cv=fail; b=eVDvWdrtfK0Hl+0XS48yCPRu6tSkkNo91fe4EkmTAwQrQAUZpvE6fB2pArB7BIoK7/vKQUtvXniQ47FqFGy9415fprYs0m0t+6TgAu/acvT9ED6DX6eShyL+sp4sHjaoCBLP+z7r/nPASfW+57ffqFZoO8VmpU6KwsNhEX/ekZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706595231; c=relaxed/simple;
	bh=XWXzYI6vl5ZYgChcZMy9ItbC7fyoge158CXHYgZSw8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gsuB0DY/sMjwOYmpS3AdUR3Ra/lvUmBUKzsjAxNAEpxteSDSxKTLPKLkmZvQbXVZDSxlOcrvFhrQJ4Sa6KuF/Oz/9eoTLyixaj/vzi6ceUkUMfhJEbqr/4/i613kStDP8r2VtDKZ0MpxEGPhISNVMY5HlM5cQ3cEzSw9RjnlQJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/navuGbPP7XWKZbuB6IY2icveg4bhu/ysc0jNMX80mazLLTs7YDF55Knp8k+72hZ8exD4tv/HYF7yWTR7cZxppBsCubK+lKsZen174ib/klBT5surzD+3ztp28vZehz9URUirP7J1vcHZ+QzvS/XAwZ0UeyjPa7v5fCdbDgZAhScpF+mRiumPrqP2oO3qSU5Ha9i89Wt8K7b5Bjfjho2WePNEMKSkkomoMjS5+ns+/PqOZcKHklmKTH5+eaOe7RFuEGnmxmeV70AXOlljZXUL1JCyGEawhat3cl9hL2F9Y6ZuA2xNu67IjR9dVxEFDhKoAtFl2HIPLgywpRE7jeiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rn0g3fXf37W1YYXGaUPSZ/XI/w+jWMxSzQVT9xp/C1o=;
 b=QwRT32S469oZ9SdykLn68NC/RAmv+nnWUgJ3Q1Pmen9H23IGiRAu6A0VzpZ+mtd07flUGhzqt81omosmR5KP3QRpIbC7VHmTNTGR5i+Jd7Pq3jM2oSPKmruqhrv5HQBTTsAvUQKkR3cEbUYTrImNM0zoEt0yrWx939e1MvczuscVCWsUQW5ODCDG0VdYb9D/CBXwtYnEh6C9WCtsy5NIt7x8fZgG0zqtaRwKG5tP46pLSfq+jLEqZtsKWcg3zCvm2hGBmxuJ+NlKM2uWEcDuQ675wmxnwpX/VT27HoKfCpJeqLcbuH3MWUm6bcTOUjSVK0h6OUzyCUtDmx4Oevap/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0878.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Tue, 30 Jan
 2024 05:58:50 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::148c:e1dd:302a:196b]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::148c:e1dd:302a:196b%6])
 with mapi id 15.20.7228.022; Tue, 30 Jan 2024 05:58:50 +0000
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
Subject: [PATCH v2 0/2] Add JH8100 external interrupt controller support
Date: Mon, 29 Jan 2024 21:58:41 -0800
Message-Id: <20240130055843.216342-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0006.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::8) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0878:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e9ae80-66d9-423c-78a5-08dc215887b9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ET8UOhXokSdCnvkVVzUum6I0AeaqDfx1y5WhOaBulyAtU8q3Rd1LsCzWyooNQLakWI8JwYMa0pVklAYuTVolAUKCxgRlkczTbyzTWHdUufm++FjToEnTLdff+ssCVzFz2HSNs9WbBsTacswn6VP4H/1/gqfwdZAkgbO2Z2pdYhBpqpXaAetsofBSZMkqvSf0ndhEKMjHVbFbaiwtwuQ/OzdqktsE7I5aBeu87ujlv/Zzi0K570yMUUumYcqnLFzT10ZH6zDjczCyGlPKjYOcKj/DhBlpWZW6NhyXMa8oy+uKq2JFbs0Q6l6NP1qg91NVO2AYc56zTuybasvu+H0a1M46KwlWUcYtxV6tAwghZ27M0DdXk5StJvlGnYY32yc8GkRwCZFAHzAatLF1JTzVlY0O10J/iWSISP0JjBJtiIYwpYrrVBP3JS5TJgFeKdkjUNcrmgs9vwbacOxPwjhr9PUEun2EvP3p9VabagoKrHoDKxviZ7e9KTinyR0iDx6oHc+LeEu4VXcTJeTtpqlLlrlRJQxXQVAjSQ3sWYCZZ4N4h/aaKyLJzX+3ktM6DR+ilxCZLa+5v7ubSyPJHn/+2RtfKazhSKbTOghzRFBB9C8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39830400003)(136003)(230273577357003)(230173577357003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(26005)(41300700001)(1076003)(41320700001)(36756003)(38350700005)(2616005)(508600001)(40160700002)(40180700001)(54906003)(52116002)(6666004)(966005)(38100700002)(8676002)(5660300002)(110136005)(86362001)(66556008)(66476007)(4326008)(44832011)(2906002)(66946007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hqRzRXFkeHWCdanKmNwsiKmUUJPJFipk+dek6l1N6Z9W944xUGH+ZiB1+5Ud?=
 =?us-ascii?Q?4qRUmCQgvF7xqaa6o8/OOPP9Qu3hafmb1TFrfa+sRXjD4WrAHQzB0iAXUzB3?=
 =?us-ascii?Q?dRnozx5dDxLJ4Kq3xQCIGQ6bLZOordrKZM6kGuB7AhQY6abbuj8vrIRIyCvy?=
 =?us-ascii?Q?ocfncGojoKixLCJLYlJmUt1aqD/osI7GX50hWMBUJ5WVhdZ0Z8u3O4xWaYx7?=
 =?us-ascii?Q?pFSf4xywpE0p9UQbYeWAw++T3lBpQ7gcxX8exf1Ft2IsMMSYpycAH3m1qRvm?=
 =?us-ascii?Q?m8jA21z1HA6QaYfMLxSADLNOD2RWMh/p2KigBvwerRVCdYEkMiezOQeTwXRr?=
 =?us-ascii?Q?hYFBYMXLYitt9lhRBjdOXfAaVL/6+ZMRR0rRMl6/orIeBSLwYdWcpRz4o3LC?=
 =?us-ascii?Q?oWJ/7Z+yhzOGkUKcXFy/XAFksBGddd9l+2hqSxtrVSurEBnmidIPjzToW/CD?=
 =?us-ascii?Q?WlzPv9VZR4dITSh09C/nFG2tlfjUN2CDZaGsz04OJlacNLP2lAnW6fpeT2M4?=
 =?us-ascii?Q?FprT+VIvTUutAcQ0nhda/cREYAx111kCCJYu9ujVBKiQvqCp47p9fJwud9w1?=
 =?us-ascii?Q?/6MupDftY6hOG2E+WwloQrF/guMMLl0yx+8QBx4uoEcvB1z1/21df6DdMOW4?=
 =?us-ascii?Q?fqaEOZTBpRN2FQV1rW4cQ72hE91jOuDhKw5b8MqNw+cjjBSsHsUkBajKbwPb?=
 =?us-ascii?Q?A7dqOltjxaslTzmDwOFlyRlZvI1qx6Y1s2DDotVFEITPK2hrZwbKf4UzaneS?=
 =?us-ascii?Q?Oj8CsO2CeFArYcxh72qQDffcXKeNSNL5Y4qe0VGCaD3NWH88rjQD3Oy8jmDF?=
 =?us-ascii?Q?zh3SFAhjV41E4IeBBWQsGNxvit3QsjYv8a0KXrHzyiTv1MQwWUBdNatrw1jr?=
 =?us-ascii?Q?OipV6pVZZIhR0w2exr7wnKD1wjS9JZIL2g37zuwWDNp+BTPzzlnHc6zy68sC?=
 =?us-ascii?Q?xOE1G7y5nym5Tp+6crgYbTXV0Rr2Mz1srQ0q8TRR5FwEA7xfxpISgrDWtFxT?=
 =?us-ascii?Q?wLaXFMRppwmFhZKhIRKo/eshW2Oefpp7/x+b7xTEZ8I/Kl+0VdIFhx1HOOP6?=
 =?us-ascii?Q?Hi07rPw5+sXrL7HZaglmNxtyK9Fo8gBj7o3lxRteTOZSO0aVIvALOJAhD2S7?=
 =?us-ascii?Q?tIeidwBSUnElNGaYeb8kuVcfeUxPcxz50FK2MUvJ+Zr8WcU5vtP6N4zLCkbS?=
 =?us-ascii?Q?eQUwkqEyZVVR1/ksjD7V6keMgt38PBwPfr7A04IXT1stEj/JvxmYYwfUnIY0?=
 =?us-ascii?Q?YQl11FDsEQThD91fTC15LuH+/FrrwJ9HfJ4ae2zkEGri4Cf9HEh3Vkdfp0Yo?=
 =?us-ascii?Q?nDI9Es6qnmT4iGSGf40nAHbUkrJO0MZ63LbBQt161GSvioVZINeP5Vu5n7C5?=
 =?us-ascii?Q?BwXU+Dj2Jw816tYCDy3b1ahMsoBJCJChunnzgfLBAz4v8UbQQOEg23zUnqEQ?=
 =?us-ascii?Q?rI/LZYep4MHDiGxnaI+DYj16KwiSxmdTfC/EUN3XqZ1OSAyNVi/2ykqqZw0V?=
 =?us-ascii?Q?Ya+8wlVK+tIAD/m+Xu7NHHGr8kZ/P++Dj9ng0L6jVX72XvgAPaajvBvCStEC?=
 =?us-ascii?Q?gy5HxpxjRqga4XsJThuXM1pmdigE5Rt3wB+w+hTIY1VuGKRvFkT3whApDSeJ?=
 =?us-ascii?Q?6bBT6mnwwzP04izdBTXbHjw=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e9ae80-66d9-423c-78a5-08dc215887b9
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 05:58:49.9324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TTkVStDfoMc9zQthib1HluZlkffTl7POHV7044Gg/BBFIhgljGr6XC09v/9UKq/sZaCax3L1p+QAZgKzc2nwwoInSVoCv4CL4GOiAfJeVv/yBTDQ1ZXpMDXZW2w6bS6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0878

This patchset adds external interrupt controller driver for the StarFive
JH81000 SoC. It can be used to handle high-level input interrupt signals.
It also send the output interrupt signal to RISC-V PLIC.

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
 drivers/irqchip/Kconfig                       |  11 ++
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-starfive-jh8100-intc.c    | 180 ++++++++++++++++++
 5 files changed, 259 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/starfive,jh8100-intc.yaml
 create mode 100644 drivers/irqchip/irq-starfive-jh8100-intc.c

--
2.25.1

