Return-Path: <linux-kernel+bounces-156293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C20F48B00E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E02DFB2247F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD20615530F;
	Wed, 24 Apr 2024 05:13:41 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2103.outbound.protection.partner.outlook.cn [139.219.146.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C3F1E868;
	Wed, 24 Apr 2024 05:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713935621; cv=fail; b=Zgbr53vr/U82UelIhehcKgHF861ii5nKqmNSdVFJOlk3ZmLrEbu34Nuvyq1gpwPIgFPgcp/QVd9yBsqs5gSJbArkOXrhFAumQJW0FWlPDqvT8vKHQqBfAaTQbCnDze+7EKaI6/2rl7+MI2DztPqtDk9YAZ6wWqg2Xhf56YTHPr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713935621; c=relaxed/simple;
	bh=Q148yCO2x5IVUrJI+bbwSpr/D1G+lYOWzP9Ai+MW8YA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iiYeFKP2PpXl6MMPD5eXv2wTCXMLrIae9y65m8sefdR+2nw7z0rQKpTem4MclQN68pk0BR9hc92/loVT5Ch/bhlFZx4Qu/mlsseXPPmfuRXmmiTQOnOb//bBagqZ4Ijrd/ArRDr1joTPM16r2YRtToZaxCJAnMlF8fp+TCDRnHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTxZIiKeV5E86rJpkJ2JvwbSgHYRXN6aF4nZCuHmhrbyS5ORuJgFcc0EBWt0CqnVszacJ5L7zW0LmBHdfiAtZqsglj25z6b/mpVbrTr1ho3NPoqdPkfMseyZYynhXrJhp25ukX59WTDyP783OImXBls3mq1RHVWkJ2WglqjLj/ejUvva0QCz833xjQVjJ98P/+GpQyi9rimrFL097ILcMuT1t2EVdPdoZclwymZlynTt1ZQJft/e9O/T4kbNIwIJlSSPaTOETI5wANFt8JK+LW06nzUeX7VjzXFDtqeuYVPxnQr5VB7byIIMBlllWmpGTO5qPQmq7BeCkta3Jc/Dzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sa9knZs56Z1m7Hwwmcsi6o9N1FeHYOvRIxMx+x9MG7A=;
 b=f0+Lz5doLydCIaJanyy9eniEuA3eg+d7mDlCXQxQScMALUZGOp2aMCbK4D2A5yo4wizM4kR8Aqu+xW1ab2+Nkrv8sLJDsrSxSAXme008F4Fcj6KIfKGZeYNZoiByzFT2w097XxfYZPbOQ0jrj04F9yKzJw5hfj9G7jOr4c271V5oGAURrz54+pUw1GwppRi3UCEVtmFwFLFyuhnzick4aTg5C9ATPlKCM7iRAjSbio7pD4G7j9+AFPbFdA30oX0i5yf+3Iz7Zu8nj6n+obB0y8RfSx64+M7yc8l3lF8LCjlCWgiLbxDNnHE6E3jw2qtFiv2W9IY6zjh4o3pPWTUwRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::9) by ZQ4PR01MB1268.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 05:13:32 +0000
Received: from ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 ([fe80::301e:ec80:4356:8b14]) by
 ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn ([fe80::301e:ec80:4356:8b14%6])
 with mapi id 15.20.7472.044; Wed, 24 Apr 2024 05:13:32 +0000
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Michal Simek <michal.simek@amd.com>
Cc: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Add optional reset control for Cadence SPI
Date: Wed, 24 Apr 2024 13:13:15 +0800
Message-ID: <20240424051317.2084059-1-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0024.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::8) To ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1154:EE_|ZQ4PR01MB1268:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d9235c5-8023-4156-fec6-08dc641d491e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rQTYTSmW3LeyjObv+R+GbD6jHyKOnKM0bhD052iZxcDuIcEMOf1V4CKb8rU0uHJKTQbZ+xACDhvsDMkmYVFS3r5wi5W9fmkdMW4owlPNYg9RoXTef8AKT376lliEEpBdNaWgAcvVUeLfkHhnd5oq/Upd8aq/QZAxFwnEzzRvG3olGJu7ZgXgSUZ3q9wphtfQUFaPH/nCjt0oKn2f2Xqs3NdP/nId8l83s5Nc7IUoMzKdTkT/pL+QlgdWR/XunqAJxkAWJnq1dQRnxCJTHvu8XgUEVzpHxHcRM5n1aze+fekK7jrW7SJu9+LM6t9Uoiv5NLagbtJrBopVWYaqmMYsKojzOHo3/wNzuQyJOPJtO14YlW+ebX7Y/brZeEAzuZzC4kfKJ/XbRwUUFaFabjZs2i485Dlt9f8H9LJkBuH24AtzAokiXxbBCX6BRl+EYVlMrNGV6PqZH947u0gZjJRTZp4/FsMjbgifJAA4F9DAc7t8OLRRAA5lBwAokEmUrbUO0syTyuJNz2THf2hG8YUSp6F90QQPC7aFi3FZQKq+4I2q2K8uwDV84n+/f4E0OGNICcCq3rBZfyEBmB9sByV+TOdFYq3lOjT6VbkrddF0ReWksXKWcKbv+rg7ji1whXIm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kztyJIAQAtMwaLf7rZ+PA3Q9IeIdg/w7G9gpvbNY1FDldNg0gjESTqjh54BV?=
 =?us-ascii?Q?auBea/rWnykY/jl3DdgcZleLnizSTycBEGfsJKAMGZqE5I1Tp5fKhK+LOULk?=
 =?us-ascii?Q?5YqcoyaRJzn9GbTZWdQnj5fMVbN3ankA+SoAyXDt/LnjaMK1aJKLtEoI9aK3?=
 =?us-ascii?Q?ctr+XIMcUiask/fh2ADWjAQ6oh8Ro+OM9dmygMIzRvr8YKKUiPidZk6oRvfm?=
 =?us-ascii?Q?sLG9Ju8j7B9jY832He9nqFbODlRO7obRSyxFCdzk+eh521nB0cWFAd6x8/0K?=
 =?us-ascii?Q?UwQRFWDiyl5NvqtehcT6t/uYRKYdlJIvhdR0kPtv8LYdEbvWph4PNGW6V58M?=
 =?us-ascii?Q?u1EBqV+EDPaNb+LJqSHzPNu9mqs6IY8G6epAv+d3k46hRnDhRjEEgdG2495g?=
 =?us-ascii?Q?cUgF4nfr22jcOeB7SYtxT860+vBDF1BCDLriwCHjf/QEu0KAKqCxmfGdOP84?=
 =?us-ascii?Q?lDgTFzVQsDEH9IkKhfV2v2cU4tDcSRBjIBAbzvJL0sWMgG4pwlh4+4mlemR6?=
 =?us-ascii?Q?tBHKfHSHfbjGF1jfsHCdORAOp9rLTv1SQStnXldyjzB9BPRTdgsUTmVu4dAt?=
 =?us-ascii?Q?tGkDS5VP/vq3xj8NItnxAGq/OsgSfHLd3MRBYoz8/BUIh9dZY6XQe/fjBMdV?=
 =?us-ascii?Q?1q8JfoSrozFnG1CtSFoIzP5vFIOsxAQGTcQCBJxGlrXqR9YFPpCc6gMeLMpj?=
 =?us-ascii?Q?DiAGGC+2LgtPEAXHH6eLaMuYB9qbLKkJ+HzjJV4vmTN701WWPQlUJ6c/PHoF?=
 =?us-ascii?Q?oQmRgKleBD66DwDyRTlJv4Q21T4utsZAituF2Fzo1KBE+/alwDjOLoAIaRIn?=
 =?us-ascii?Q?QEYXLlnlOXhtTY/jVOxqhZbTr0w4SDSwVMTD8YDs1CJWVIU3ImE6o97SLyhP?=
 =?us-ascii?Q?jhqNNlIoGmWKZb1coyZnTHUmasHEKnQwzIhy1AkXnyi0DhhJyUNgWNnpyUrb?=
 =?us-ascii?Q?I1l5y6fXg2u8/X82Hk7av+xCjxtFT6ujsmSjUybni0vboNWaLQW+71uxt/s9?=
 =?us-ascii?Q?905PJCuCS8fn2icx5OjaHv+4ZjCIMrg+Wq2NwlWKXl8rSAu8s0LOdIHqSTri?=
 =?us-ascii?Q?wIbf/8jAhNiBzcVjV/ZQf6u8MiRqD/3zDnN6CJzJz3fqJpkMTh2BRQrg54/8?=
 =?us-ascii?Q?rIBYxHDEWbAzYow/pZmozUzfp94XBCwcdzq5NlNZh8AJU+3pal7rliIU3WoH?=
 =?us-ascii?Q?7nPOkmlmrdEF3hEWmjHJ828EhRLyck4M5vEq7hfwMThEj9XuYurHFpdRLtfq?=
 =?us-ascii?Q?0ZpRjw0mojTyrkA5Yf+S2sqXq5vAtLXKRmSRetGcP+LYEyvSzQl8MiwrfBoD?=
 =?us-ascii?Q?EZ1f6/UY+9TQZhjccTwwScvCvXlzQjlrFKJIa0RrE9vRUkE3WuCYx9wUS1Ek?=
 =?us-ascii?Q?LiFfyeLp+jG0sQeKCGQkikKnr1A9VQ+WqKlpSC8k0ZopdIdxo+yFG6OOJT5F?=
 =?us-ascii?Q?S2dv6IO7Ne47vvzbW/WJFTrLH8/Jc3l8MWfsjmCTb/KkgcerROhNAWHJ9rVs?=
 =?us-ascii?Q?MYJVok/DMWktCGxzIKbuvCfpW+TIoMxS14+LSYp9NsNKo9PALkoWQc4GvUJo?=
 =?us-ascii?Q?0vWi74oy3ugZf0S12JnZRgNoF5R3o3r94aqWyD9ECR+Yak77NjLSMhVOD/wg?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9235c5-8023-4156-fec6-08dc641d491e
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 05:13:32.5627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBdeguKbeSJslo3N81GkwzobCo816gesANfngIY4a+0pN493UPzIZXJIkbMtOp0z62PE1oeoNBTp90sRiVA/nPKiMWDrkpK12RuGBDIZv84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1268

The first patch adds optional reset control to support assertion and
deassertion of reset signal to properly bring the SPI device into an
operating condition.
The second patch documents the optional reset control into dt-bindings.

Ji Sheng Teoh (2):
  spi: spi-cadence: Add optional reset control support
  dt-bindings: spi: spi-cadence: Add optional reset control

 .../devicetree/bindings/spi/spi-cadence.yaml         |  5 +++++
 drivers/spi/spi-cadence.c                            | 12 ++++++++++++
 2 files changed, 17 insertions(+)

-- 
2.43.2


