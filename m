Return-Path: <linux-kernel+bounces-137956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 229AD89EA47
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29551F22700
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E979F20326;
	Wed, 10 Apr 2024 06:04:05 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2121.outbound.protection.partner.outlook.cn [139.219.146.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9230B1A286;
	Wed, 10 Apr 2024 06:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729045; cv=fail; b=NLXVJvJoOhV0HWxhPKS+JiBA/rRPqXk5PR23NBcXCxrcmHJlVU62brzJghAch88FAq4SiZoGBAibWQ6N6PDVyqlAbAv73ykzWffK5j1r6UMD2cd5n3Byfwu/NBQVumML2y899TCWgQIzA2lzxPXlruBuI+GglkeOZJw215LqauA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729045; c=relaxed/simple;
	bh=tSE1Qhij4wK4SMcOKlnFut1pJFKY9BvqmpHhPa9FOlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DeSmWhcTal9/C9QTFtN6/h2aOah4c+KqiJRUhEjuznfMWEIajlbW/Y1SIrU1dau4nywcXrBgyFdgIxskG+FqEyZU/Of0/XrGbFfYCr17EiqE3V3G88stTyeLs5B0NTiwMFqLuHoDDIGTDvEiY6eOhD+tTgeKZE6qHj7ApgetnCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzRMwmF2BNonP90W1AGjNUsKG6Xyan2SSwLfuGC1lm9h039HLLFZ6sLwaRCJXAw/mpClvw/g79nohakU5jUT7BQDMHfOmrhQmkSUaIQoKjug47I78TYIeCyCOshIAq+xej46Pu5KCs5nN5/vt0Icfng6gBC0qMUatd4UsfgQILezvQcoLe3xz3qp4zuH/WUh1EbiSKjPxvZI6A9vm1fuaeNgvcUe57IDTQzlaIbN14+kMrgvxW5YxISRZw6j+mgK7EcBtAmq89ww6/a0YOsad3kCtHRwNbznkmUqXbb/q7gWvVdwVYzkft3qbiZzORTU4JP/V6we2OPz+8RRJf6WxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bu6cW3D24AA4mHs3NGtLf1pUBG0FFD8Tm+W0JTNEtAI=;
 b=aQKrYjjd+fBjZPZESZTmlCP/ddnCh+W4DbpAMYbrRVx16j4Xqlq3fh8JkVTEYECrjA6JK0bWJ3JuwO5XNZD+JddMJ74hU+nPIvbS322svTFPuD6+A1tV8JaWextehIrHxsmkWBXud8Qvtvk2eeXmexHTYTW0v1N+XL3mNfjgs0WOtnxjUNsOuXmUVe8r+0t9tIfab34kcjjK0SNFU6q1y0A9lDGJEXBZC4jtREYQ97UPGFw5a/nDaRZ8II4jLTXtf+WR1Hy7GrPsvppzr8yZJwZFk2MB7hQbp1D6E4H5CcZhw4ulFRVLsdZIB8v0BHgOchRBRCHL/gfKc6gl6fR87w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1084.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 03:31:56 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::6174:711d:d93:87c9]) by NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::6174:711d:d93:87c9%4]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 03:31:56 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Emil Renner Berthing <kernel@esmil.dk>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Hal Feng <hal.feng@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 2/2] riscv: dts: starfive: visionfive-2: Fix lower rate of CPUfreq by setting PLL0 rate to 1.5GHz
Date: Wed, 10 Apr 2024 11:31:48 +0800
Message-Id: <20240410033148.213991-3-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410033148.213991-1-xingyu.wu@starfivetech.com>
References: <20240410033148.213991-1-xingyu.wu@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0002.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::23) To NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB0956:EE_|NTZPR01MB1084:EE_
X-MS-Office365-Filtering-Correlation-Id: e951561a-600d-44d9-4ceb-08dc590ec5ed
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UwoNeYlbnaEzAr3pKIyhiiDkFpZLAyVVgUlnhm1U7PWkf8uwl/NK1zNLMsROsFT9lSv1w+BS0P350zc9YJ/XMhrkfBGOU7jNAzOI5x9XIGEkKy5KzmXVPUaXj6xuosQKepLX57z+Er9MNLdfAM6Ck9lEZCJ9wyWTP6IJ++meVdr1aJAOmsjx1bc2ybaRaE9AOlS54PQtLmiC9sVoSshegumrQepWsYlM4aXvtuAx2qZpreiksA6oPEiCL2d6715yIhmC3anM6QWjp0gm+0sZhthlS6ah6bn3+Ky1n6t1vhLm6wcH3IBcGS3NFlpHJUA65+bpse5WRRD+xjimsTyUjfHHdJg2dSis26eMkG5YHKpqzkDob90e743G8R5nH4A7Ck98w3jLw0mnjGF7Hg39bOEEybfskRNGpi8Gkqs8iNXGKa5wNIdE+nXt25gPj76/penr/5SOhJgLwskV+pTBZbYmO10Vhl7hN+9exaP9GfSkkh+o6rlm2oPkauTX+kWD0PadeyfNfflcHfuOoCe8H1oQQwCKYIaLeBi9u210H5Uy1ffyP17/2hQvmOQltpJ8tyKFrIHE5rgTpmSSUoijgJwO2nYyF0e2zgIbZOSay3T51YcmRpUBdhPDj8bTIFM1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(41320700004)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZBJZWPeztH2It8SDtqx1cmgwdDJYJZ1hMrOGdY5is5a7yHu6URBgv4klGsaF?=
 =?us-ascii?Q?FbSIwTTVQAsGRdQoLGACJN7RJTiuBikV5VzOhay4tcQnYsgzfCfQ4/jL1ggz?=
 =?us-ascii?Q?lasX07Z0Zp3yVy4L2qSquEa2kncpt8600b0FLzUd2FHsBLRhCwI/pV2CwdDp?=
 =?us-ascii?Q?Nqdl8h2oXUoykCcOOUOVPBkOUflfnBh40YdtV2tNo4iTLqN8tiuywEFixmdf?=
 =?us-ascii?Q?HQvrbhuRNNiVWOZDbkAH+qKqFkf4k3dKlO2x6/vNn00+yKwJmFk3/FI1I3PF?=
 =?us-ascii?Q?uucLZ+ZJwlgVs97vuBpH4GjGagbD+IogMJoVp2EBXFJLP91PO9WmOFLJEB6D?=
 =?us-ascii?Q?/Jq9vhDC4sr6Itb421fAduD+2Q9oxmSYUdJf07WtyFu+r0Pf3MAT7GLR84fd?=
 =?us-ascii?Q?DlQjlBum7gjtLarjGreZlDyc1mVi5ZeAJwFwnnhLpOrhAKH9VgXUPfaeJkvV?=
 =?us-ascii?Q?6Y9Klhd648DRIQmLb/yDxbM2W8f9ZJ5+2es8LoO+6rMS2OpI+7noquy5ydAv?=
 =?us-ascii?Q?clNDHsydarMtgDbF8hvuE2mj8rV0IZ4NcEdanTLzzdq/EAs+UHnCL/S7Irf+?=
 =?us-ascii?Q?ejr/cE65NNdPwtH5wD9GNlX6VpQ5u0V+Zx4I+KrMOl3SSNMQuGW/+D8Vl4AS?=
 =?us-ascii?Q?ziFNlWxUM7yancIWCMY3UwmaZVaGFibaUHxdqkNascsg9HJx2Khilw85XAS4?=
 =?us-ascii?Q?ZFMnVkdN8EjfdHSKd5XFYRsSkUT4V006V2CKBE+wsP9eyXihi3FXW5DwSnFw?=
 =?us-ascii?Q?qLk+Q70d8jaZW599l3Jth+UrjxybsLOGvFWn6a/hE2uGy2BtWUz32ebR9AQI?=
 =?us-ascii?Q?WlX1LlruoX+wVRKhqs320+rgSertuL3+OjO6qFo7K5QtoAVR8xZLuRutUU0G?=
 =?us-ascii?Q?RLg7qhCItg0zLu87kIIprYqispOmfK3bV2QoAiLSe3BZsRhUh1ir6eRWSycy?=
 =?us-ascii?Q?1DNtDelMUiLVL7aoKkTS0TW9M6oPzFzU9iHc9460O3bORf68VDOGJJYJaiJV?=
 =?us-ascii?Q?waK+i22PpLlb0aWuqmiiY6+eYN7MKzSHslq1vul24VS7dNBXC4RSJD4rmWnd?=
 =?us-ascii?Q?n/44nrGIr3qh28QCA8cyc6iE2jJWxTUYC51BZ46IhNv9sfS4VGmQmuBTkt5L?=
 =?us-ascii?Q?JbdUqLjHBAVTR4Tx/VBiV6dfu6tF0eac7dHQtVcMW8NF4vhfO9/19bBxelc8?=
 =?us-ascii?Q?8EibQbQNagLuVnh5jINl6SwaYLkdVFGinnSPB/Ml5hI6Sc+HhJUH70V9y6ps?=
 =?us-ascii?Q?BUND+DD764jf/qI9+gPyLo5vph7PVJyrz4edbM3bMwtzDhHuMypLMb0sStre?=
 =?us-ascii?Q?UfsQdvGOpR5F8XDSCv8tK3m/4h1FheM+qOhZc7GQwj2nQzNFMb5Gx31iNy5M?=
 =?us-ascii?Q?phTnyzhjKWWTulXeKJTQsu1cBSdlbLDHVH2gfei7mZUIxR1QexYX+uqe1BCo?=
 =?us-ascii?Q?Sc53kalj3P08wJxjYFAvTNfyaKqwuxjmzs+OqFYevRDblLBJsW47dzMES0Mn?=
 =?us-ascii?Q?a9NRrYUi25FFE4EUAIs8N//+i5lGbdFxXQApiUgNcLy08k1TG2M6Y83dICed?=
 =?us-ascii?Q?94dkCd9sEVI1i2/MczqIZLw6tYfYvcUnu2nSuJmbhawJ1aEOnJIlCMYW5LIl?=
 =?us-ascii?Q?Yw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e951561a-600d-44d9-4ceb-08dc590ec5ed
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 03:31:56.6373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFhEgKRBor53UbrkaxV7vaoyqSXbv+IBEjgJtevsVBitrHwUwfjTcTxZqDwpMjy2aUiLfiHFFk3qaE0acq4WKyKGyenKIHrv3M7hPHyVcJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1084

CPUfreq supports 4 cpu frequency loads on 375/500/750/1500MHz.
But now PLL0 rate is 1GHz and the cpu frequency loads become
333/500/500/1000MHz in fact.

So PLL0 rate should be default set to 1.5GHz and set the
cpu_core rate to 500MHz in safe.

Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling for JH7110 SoC")
Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 .../boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index 45b58b6f3df8..28981b267de4 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -390,6 +390,12 @@ spi_dev0: spi@0 {
 	};
 };
 
+&syscrg {
+	assigned-clocks = <&syscrg JH7110_SYSCLK_CPU_CORE>,
+			  <&pllclk JH7110_PLLCLK_PLL0_OUT>;
+	assigned-clock-rates = <500000000>, <1500000000>;
+};
+
 &sysgpio {
 	i2c0_pins: i2c0-0 {
 		i2c-pins {
-- 
2.25.1


