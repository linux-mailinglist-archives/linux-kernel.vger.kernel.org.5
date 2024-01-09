Return-Path: <linux-kernel+bounces-20474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8E4827F76
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E27288A0E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1438A9477;
	Tue,  9 Jan 2024 07:27:47 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2081.outbound.protection.partner.outlook.cn [139.219.146.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F249449;
	Tue,  9 Jan 2024 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqAoaRdZ9RDhpvlgAig9fxh16t0tzfCN1P6Kn8Xq814/UtJ945BYKsFSModATaBLhdYpziIYETq17SR8anJd+uyf1jkFY3Y7Q+Yb8N0Io8jgjYeH6KvdSslETEizK44bFhVzUrL6D6pMREfzSkUvKU5ewsLwvld8jBDCj/coAjIFIVRaAxf77InoDjhbNh/OwjATJsY3zRtUSc0gOtK2WZXjWxZuEfHMvxYS56ODb2xqTg2JgRnJ7BZ+0UZwHsVbRHQobM9q0lXG5QWVJNpmfJpIlrcM5O88Zv9qKOpp6nSRQlIyR5yGxe2B3Zjgvav0k2CTwpPC25Dr2Qi3bF4PoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbwkNBfMAtvtjoDE2g5+26yH+NEeG0775jqiRWFJH3s=;
 b=P0ntvRYQ3LBK2I7hK2SP1Vxvu8beSODGOvCiE871rIYsWIOfTB1V2got+8qvKsvPyT49y2QuS50ouK6z/ilR+m+ojG6lvbhvbPC81wCrI2GqiEYFT/6LZMHKTt+GzJxvrkCuUKDj8c46aDCaJbR/np68gZgXeopyEGn+gTkXw0GrubCRUH6GpCCHJBsVSb3xMhNNs3beO8MXdMe+iHjCJIs+3WooCeQSi1VhhLrZbF3CrUFGD3T5nfrmjyhe7Usflz43FYCUyzYSFrH81FHCCQY4jrW7SEL9sls7QFoKiji1ThF8rbjCW5+z+Z44MSYvLgZCBGK0p/e/KTniH01zbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) by NT0PR01MB0957.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Tue, 9 Jan
 2024 07:12:55 +0000
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 ([fe80::85fc:7fb9:8b00:dd88]) by
 NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn ([fe80::85fc:7fb9:8b00:dd88%3])
 with mapi id 15.20.7135.019; Tue, 9 Jan 2024 07:12:55 +0000
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
Subject: [PATCH v2 0/2] Add JH7110 MIPI DPHY TX support
Date: Tue,  9 Jan 2024 15:12:44 +0800
Message-Id: <20240109071246.24065-1-shengyang.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0032.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::6) To NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1070:EE_|NT0PR01MB0957:EE_
X-MS-Office365-Filtering-Correlation-Id: 3242e14b-f145-4838-8bd3-08dc10e266e7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p7SaokcJr6CssfjnDXMbIvQbai1YlrBoYN0ZylZz6htM00MyYJIuhptTm5meej3Y3d1zdQjZ4uKq9nbdP+ed/PaLeiXAaQXB34ghtc0yquskHmN6g7T48pXvQ2DJkVwsbYCOBwhl/ll6JnNZr40UpeGc1aeNOVZgzGp7XacHvFnhHMlHKRpF3CAuQxw1DDAMb+c695EtvuPlYdFhyePv4yCioh2xNC4B3+Lgwm0Zc2bUf97XqRT4BKa6gr6eMnt7eVuRpnzHM9zmETe0DMZh2uSignWkUDeUKWjMJVmffZamzYEg27Gyrlpx2l5Tdh8xJuGH+04/2vEZGTGCcyxVy6B7mtd6NrrnWSpnw3yctC23LTugTP0zbsQhzjYLDM5aHRCxQfYUangVdghuO0l/izh+OBm/st6KLgE8V8G1MHWLG4eQLXF8SSOwvjWK+Ykg1BFQRlw7SAnwnYWCj8SCAHpxSOv3gA6UkyGyo0NtJWC7ZHYL+wQP0Dic9KOEPz3hsri0aoC4H9fjCCK1oU1uwTSyhtVBtWSJsA1s+ptqQyvQJj0d0ER5ejs8olyg2fgR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(396003)(39830400003)(366004)(346002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(66476007)(66946007)(4326008)(66556008)(8936002)(44832011)(36756003)(26005)(2616005)(966005)(6666004)(1076003)(508600001)(8676002)(41320700001)(41300700001)(5660300002)(2906002)(7416002)(52116002)(83380400001)(40180700001)(38350700005)(40160700002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FW9ZvuXC6yv4TOYy07cAlpEGh0gzQpO+wfaEauupjiAUFLmEOnfFJnVSFi7R?=
 =?us-ascii?Q?6/aLgN/qvF0/WNNGtMA2+a7Tlrzvd4Z6UKKDdnAfWD2r3wxRxvD3nqlbFQko?=
 =?us-ascii?Q?0Emg2atCLyidNzbsYt1HIovBnOibwltDSTwmhYcmP6yZakolB4RZ+ZNZTBqs?=
 =?us-ascii?Q?OqLWW05wElDmjpKDafQk0O4nwPfLPj+hABGZd5mMv/mp3UKMujoAIVHVBrWW?=
 =?us-ascii?Q?ExvWKso7gNtzv9chPmuTRi57daErIMo+H5zx+VQJ5z1uPiKRO4w7eLUwZlvP?=
 =?us-ascii?Q?TW6k96Is0OYdEQUA9qd3jv+P3KTfA2LN5/srLq7cn7AhM4mQpBdmEMhM58XJ?=
 =?us-ascii?Q?WnMfnJblQabUzIOCYHmVoUYruf4YqS/tiRfn82R9PcNmE79Uu51+sve8tlhq?=
 =?us-ascii?Q?z5OK4IZYhmO+ucCGAWe+TPPEvoUXK1N3qc8qVpwbwQv9Tnq6dzRkI4M/T9+g?=
 =?us-ascii?Q?7B8QClxJZdEa1myoG/xjWumOh1jE247PHh5bLdx0oLVCjzhQYBF62ly20piB?=
 =?us-ascii?Q?rm8BDDFPcFivvhPgjaK9VDf860HLMa+uuRsHVsiRcJora7KyMfnlhVF5l5j2?=
 =?us-ascii?Q?SAMauQx1ffgCfSTt0zIWNqizmYxeykANaNv4DoWZFKaGHMJ9vdDg3upf25vU?=
 =?us-ascii?Q?VSYaYLtfRg+T2NuonF39ys4c2VB6vFz4nURVQBs5/KuVSwnpg8E+YypErY8e?=
 =?us-ascii?Q?D3NqjtR+egEu5oXu9SziBEfUbqgtYGYScQWLpsjmqzB5wvO+EAQu0b1lpnvj?=
 =?us-ascii?Q?T0Sp/JMxKldsiEulk6E8fKpPZ3es2njXc7zAgAbX8lzB5mMpgS+byFR7AIrh?=
 =?us-ascii?Q?1H9l9R4G2LUOT+DinLryA5gfyYzZeDfkEisL5kIZyMGqCzjxsgGsGsQ/xfmF?=
 =?us-ascii?Q?IrqfgIwAP+sDefmxz5YBfVJ0xMqVDJjy1+opTSS8iAgD3BX/ofCmnqM0CcTQ?=
 =?us-ascii?Q?khwZkHJURbM3Z+Wx00DdA/g47Eu3VN+lI4q7r3AlJfFK7q0AK1qVbaHuEbp7?=
 =?us-ascii?Q?PExoGDA8KlmEE8MEQXqj9shEUVBmEyN3PYvP4IPCIzdNSGMMjdGKULhg6TyM?=
 =?us-ascii?Q?LZjstMkDla58+pADNONnAKVvbYwza8iCy9LwbaufvhrSN0dNkVLEeqhuU4qb?=
 =?us-ascii?Q?8YDsguq+Iy+10sbLGpKcLzmhm5gZcAq9iogS98G8Jorfj7ZnutFNgEpRQk5d?=
 =?us-ascii?Q?k0Z7Ky2UTADL5iBTkh54K7wNa8zJjdbbPe0KCAjhUftuXjWox4vKh6+NY7Up?=
 =?us-ascii?Q?JdRZpkK/K4a5lIMeSXYyx7NUgcJPizltg4pT6ka6xZT1zdRG1pq7ggkiYbRH?=
 =?us-ascii?Q?MmOpbCBictSasHpgsi3boKc5QtLBzUAvkcN1UKthMaum772eiXQXVal/i3oP?=
 =?us-ascii?Q?ugcQooKngpLrL0oS0/wcXHuqIK+maNjDCSpDDyRpeF8vAtKmgKPNSWYGpX0F?=
 =?us-ascii?Q?VP5+uPq94xy136ISMqBKonGMJepIeDT7LiI+89t/osfX9k6GkwoP0XeBU8Do?=
 =?us-ascii?Q?/VwvOv+d03wgSf6WnScHmJYGBwTCYlH+QQLdGl2b+6JTnTjHsJPb3WCKhrQe?=
 =?us-ascii?Q?oTgRLXcrTZT/vsOxlpVXgQRvtRcdCoeM7uV10zAK5+FpiRnD8svP9nnz0/Kk?=
 =?us-ascii?Q?U8GELfHQid+EFC5kTXWPGZQ=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3242e14b-f145-4838-8bd3-08dc10e266e7
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 07:12:55.6343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BhX4G90XvLSk9f7gwjZOlsSmLrzE/mSeiPMuiLyKUmhQ6Bwmqm8Gr0LEAtX1wObK5hyCAU7icxJNYXU6esB0X2tW2yr50ez7dN2DeRE/STs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB0957

This patchset adds mipi dphy tx support for the StarFive JH7110 SoC.
It is used to transfer DSI data. The series has been tested on
the VisionFive 2 board.


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
 drivers/phy/starfive/phy-jh7110-dphy-tx.c     | 651 ++++++++++++++++++
 5 files changed, 737 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-tx.yaml
 create mode 100644 drivers/phy/starfive/phy-jh7110-dphy-tx.c

-- 
2.17.1


