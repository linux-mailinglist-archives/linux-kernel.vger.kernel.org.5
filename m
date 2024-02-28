Return-Path: <linux-kernel+bounces-84505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E91C86A797
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89059B26030
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1FA20B3E;
	Wed, 28 Feb 2024 04:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="X1jP2W1S"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1D6208C0;
	Wed, 28 Feb 2024 04:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709094182; cv=fail; b=b2aaRsVEPvXXcjo80zh7GJyjIg4desAVW7Ewz47Lh2pgOXYUQvH/DnAAT+pHvT/CHo9sLNFOL9ONJ7+WKhQgpJPSGnMA9Ct39IR5U4c2gtLzdBdq+iV+zAJjxMVsywwDELJc7GiLVnFTOYoBPygnpdp3UYDhUNIMCxPbM3k7nKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709094182; c=relaxed/simple;
	bh=S1HgsjD3dZ4RoXYTdcKsu5ix/IjJp4iKGy73RMCTk7s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PLbBF9Y3rduj38jxnhkE5L40D2bFjsC7zqGcAW/OUDqFHTwA1V2gFsODn/chF2P/bBQdcfUnbaHvXSInjuBALxYPW9tnfP5t36MGqybpcDcKJtoVR2bSWfWSSvJMkMSgW9bn2/tPuldM/nr53EljSCSphjeKqGDkwQbBwd37gaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=X1jP2W1S; arc=fail smtp.client-ip=40.107.21.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bo52VduNkhNYc2kJ/qdKgeb4lgnMb7qm/B3bNMy3cI9xRdgWZJz4ngSz8aPJMBrGxuijs0+gicdg7lW7YcymBzvJsxrQ9yqfguEs6xwClOLF4iP3dYPL9an+tlSC6fcMUVbTNkanC2+Mcux1ac/4rHR4sosbG+VXHOibNf10TCg1eaAW0R1ax2F4us0ezZYha9cccFsKnnva79qlUT2mtZVKK3azxu2vF9PzyPrVzxrmssvW44Abeuj4x51mcOatWT4R1Vius216VLIts8Vd+0ayrBRXyd9r5TQvskGQadEkFEgrUBVLxuIvug84shVhUZhsefVZtXOiFqFfXStViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORNNA6N6AjT7SXeItuRt8JCWRVDMfFhRORx5WAf2YcU=;
 b=QALe3Oe/Rvr9l4fOeDxIlIj/DCmTEfKuIRd/kFKE5iZqWpD3TiojbGaRdBa3ZPvwvkR/bbu9P6MvaZlqYo6kq8yIuB6/EDVfVY5HxQNssq20A+Tm4idueJp8I+aup4KMX8LsLuNdx9pngz7xLsI2/LMVK6KXBI89uMI5Tol/CfxsuSZSB6QyTpH5Etto8SVdPyXGrnVEmy67AsBnuOxrvTO8cFQibTjx3RVtRyCFrMrgAJgsBIDYMfOXwR61eh1Hndn7F+KdJW4m1RSbXpSMShufx0XMnQCQI7rsBDUX31z2RkwjBrgOgpgUsRDTfHF/u3FyVb6uSuB+kql1akLZ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORNNA6N6AjT7SXeItuRt8JCWRVDMfFhRORx5WAf2YcU=;
 b=X1jP2W1SrQxSZwpG/VDj6UUyQOxeIhSL7ETRVaD+jiTg2QoXiBiY6ksUgg8QyyK/sHizaZAC8E+QPrJqpfATdKHrUUyUyf7esgq99jLB1oCK06u3Hga9AzScHBYliSQ8Q9xSKW+xbIJ+Gg26MZLQ0hvBN/mnxN82wQSXg7fDC3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GVXPR04MB10071.eurprd04.prod.outlook.com (2603:10a6:150:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 04:22:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 04:22:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 28 Feb 2024 12:31:04 +0800
Subject: [PATCH 1/2] dt-bindindgs: clock: support NXP i.MX95 BLK CTL module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-imx95-blk-ctl-v1-1-9b5ae3c14d83@nxp.com>
References: <20240228-imx95-blk-ctl-v1-0-9b5ae3c14d83@nxp.com>
In-Reply-To: <20240228-imx95-blk-ctl-v1-0-9b5ae3c14d83@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709094675; l=3477;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=l8DKBMnJPihRSjEjA5EKu1UUtQxQgZicRf3XlO1U4jk=;
 b=yCS7aqsZGnh5va/ERTHo/c5phirQISOxMD56HWimAO+PmHc0i1tlmPQtTm9ARPL7nqzlEAcsM
 OJB7eaUJBl9Bh2+3rc1ZXoPNeohadKPs8UBXmM00f1pdI2fyF4t0Bl/
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|GVXPR04MB10071:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d535e3d-5e1e-43b0-4616-08dc3814f143
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UcGyvfH+3Or3SEiMz1eii844I/QfxPKZIrVFL8E78Yf4toj8m8GCSExkIh4ucLQmXUmwgGCPUE3wcGKdmJStCDzJl9PoWGS7DBEeeI8mZsDYv+WjalmfrQmuLuAdQIWu3D96zQIUc+/SEFGstagiL+9Q/x0BEZatzwhOkUjGQLorjKkl6uO7hmtUSMMFbrmhISZvBpUiYE6TnipMNvk2eVXkvCLpZqzjZ7mxsFHuxSvG6RMRYw/PzqVfT4SyRUKi8J5iUh8AA5pbgXg6ze4NFCKRFyBcTHduzsXEuGHXfdjku8nH+9Kgf/fDLfdF1hln4RpubSAlFRmV7Vkyk4a5Hh5IIbIqon2oJjZjbrNLUzwKMlKgrP60D9jgnKcN9GxtEz1xG6pIkKDdRcme3Bx/PPrYG0o8jy4y6kp/Z0qIVQntMnLGxYhfiMYzDnzI7vab9nvDdcnvd2tc8TtfMHn9SHtHNbct+XTS79gdB9ylN3Z7pMI+eYEass4ZuVUkqcqxy+jT4fXGRaIUMVSjTuPNlgbPV6hcpz4Vpgmdka/6wN8VTMY8idpQrdfiXG8huiOGp3Qgz9wpL1rOvWyQan9zzEgfHI9r1+TfJfbnrGivqszhY9TIHuqqijuZ5BkQZOk3pAsQj+PX4OyzVDbzH2gJIwk/cRhdYVxgHnpCbJLQfEvwZ/IWqog1YkQl0bg9WX07aOJrfV5IyJ+3IzChzhBTCbj79JXcXwjSDkSCC5DCx7M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djZYblZ6a3ZvUWRvVVo5c1RMYW5VR1VyQnlSN0R3V3lobkVXbmtGRWFCekM5?=
 =?utf-8?B?MXlaZjZPSmNaMFhNc083SXc2NllybEhraGVGOEwxaUw1N1VZMlJNRldlc0x1?=
 =?utf-8?B?eVZPWE9SdzBtTWx1b0wrcFRBRnd0aU1GUVV0YUNZVjFBWVRmd2FrVlA4RitC?=
 =?utf-8?B?V3hDTzcrNTZ6dWtTVmZiTUNGa0pHdXg2ekd4ZVFSK24wV0NBRWNFSVZYVm40?=
 =?utf-8?B?dmgxcHJBVGVuSWFmQm1pQ1RrVXBRNmd6RXBKdDhSWGxvUUlPcUFDbHNiNHdl?=
 =?utf-8?B?UEtaSmtKYk9WaGJEdjZFMjVoenoxaEIzQ2RDZytxQXh4SFFIdkFzRW1UOEVL?=
 =?utf-8?B?dWVNaXlJVm5Eb1BFaGtlVm1STVRnTlVwd3EwcC9nYXdmbEw0UDhqeHpFZk1K?=
 =?utf-8?B?TkwyVTF3RXVXVktBZ0Vma3U2SDk5d2Q2NEo0NUF3bENycUFhQmdrWUx5Z3pa?=
 =?utf-8?B?ajhGcnc3SDY2ams5TVZTanVEajdNMEVrUFZQWjQ5RXM1U1R3RVpDWklYNS90?=
 =?utf-8?B?UlNOaVRNcm9MRGg1eTBmSzNYa2F4OGpsR1hRbVpYaGhUMEV6dG8zdDhXanFz?=
 =?utf-8?B?ekh5dS8wa2R1NE13QmVXZlNkY1ZZNmZvaVVQZ3pGU29DZlY4Sy9WdG1JWGJ1?=
 =?utf-8?B?Z21oZFRoMWpPSUlYcGVKdWNBN1l4K1hxb2ZLS0Y0bEdXT0kwdmJEUmY3eXJX?=
 =?utf-8?B?OC9pdURHa1NGNjl6TUJqejRFL0VVQXRNN3VNT1JGbWMra0NnSngwN1pDNmZl?=
 =?utf-8?B?azZqc0V1SktPSWlCbnVNano4TXVVNExHbzErTk9LL1EvTHE2bTlDdU5iSUl5?=
 =?utf-8?B?WE12VmE0WUZFSFJnNzhzTUZjOHgwZlRMK1B3WXBpN1VBcER5bTNwNWlSUUo3?=
 =?utf-8?B?MUdmTUtNL1pGOHZCVHdUdnR4QXRTWlUwN05vWEZ1MW5INHZUb3BadW9heXFz?=
 =?utf-8?B?OEJqUkZzRlljNmJLYitCdmpld2w5T0xSUXU0UXgzaXN5ekZFbGU2azUxQ2Zw?=
 =?utf-8?B?ZERCMjl5dUl4bHJOak9xRnBVVXhReXNjSmprWUExTVpkL2J5aWo1YStFemVa?=
 =?utf-8?B?bHVuVGFpNGlodTFOa1phbUJkQktwcVZEcDJhNncwV2dYRnZJampEeEtwTmFE?=
 =?utf-8?B?czRoemk1MFZVNHEvSkRSLyt4RHdQZlpldnNWVTFUSGdoVWorSGxsU0R4RTds?=
 =?utf-8?B?VnJsU1dyemNveDlPa2YyUUFKOHhhREZ5R3YzMHBuazFwZVhxeUpmZUFpcXJv?=
 =?utf-8?B?YlcweGMyZERUWjJjTVp3WFhNQ1dtaklEMS9mVmhYajA4cjUvMUcrUUpvczhG?=
 =?utf-8?B?RnY1MlpPWTFnd29OZDV5Ni9ESHF4TnVKWnlDa29VTEtxSUpNNHZrdThZNlM2?=
 =?utf-8?B?dzduM3dxRWxsa1BRdlhDNmtsOVpjcUY3VXRCQWpqUjZmYVpGZm1xQ29UMkE3?=
 =?utf-8?B?RnY2ejBoamtZak5jVk14NHlrejFsY2hHczNNWHpxZTRVMXVqVlc2YWZvWkMv?=
 =?utf-8?B?MDNPaCt6MUdWZzdBU2NySlZ0Z0JOMzhrSERETzNQV2dENGlqdmE1b29hSHFL?=
 =?utf-8?B?d3AvT0hDTVdUQkFZczdxVUNSZjdEcGw1SWxRN1Jmb1RualRDWjNGU3V5cW5Y?=
 =?utf-8?B?QzN2cmQvalJrVWYxdGRXRXVOcmZnNGRMS1NQU01zckcwV3hJM0tyL1JIZlhh?=
 =?utf-8?B?SXZIa2YrV1BUMk9jelhqOVN5Y05DUjU0Kzc1ZlZWMFZrQ0svalZ6dEd2L3VN?=
 =?utf-8?B?TjNsTm5VYVdlaHB3SmsrUUFIR20zWGZvRVNqM24vTENNci9oVDNGRi9yR0li?=
 =?utf-8?B?bWNqT2dzM0F6STlGUWFJb2lBVW82TUl1T2ZpY3hVRHNyejg4c0VLeDFUOGhl?=
 =?utf-8?B?R09uUlNuZXBhSm1zdWkxOEJ6SDJFWk9UZGlrYlpQWlQ3MkZyRXpCN1dKVVV0?=
 =?utf-8?B?bm1MRlZxU0FnQUh2cnpJT1c5S1BjWm41N0l1RVlVaFNpZWx1aUJ6QndFSUQw?=
 =?utf-8?B?UTRwUGt5eFRBZnczVzAwOEVYekNzajFOME5od242MDdwZEdtaHc4T2Yvc3F4?=
 =?utf-8?B?RExSVVNVYVBmZlBybE4rZ3MwT1ZUUHVGTndNdFB3aXRZMjY2VWVmOFY2Y3h2?=
 =?utf-8?Q?Wk9Uk5Vh/oJKMf6o13s5dl9o5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d535e3d-5e1e-43b0-4616-08dc3814f143
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 04:22:57.9095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uH2zt473zSNNeQ8HBKL4TfUAr3UBB09fLbSKXpW7fDSzim/llGYmH7+meVRg2ZyQ47YLkDXmuSUaIBfRl36D0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10071

From: Peng Fan <peng.fan@nxp.com>

i.MX95 includes BLK CTL module in several MIXes, such as VPU_CSR in
VPUMIX, BLK_CTRL_NETCMIX in NETCMIX, CAMERA_CSR in CAMERAMIX and etc.

The BLK CTL module is used for various settings of a specific MIX, such
as clock, QoS and etc.

This patch is to add some BLK CTL modules that has clock features.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/clock/imx95-blk-ctl.yaml   | 61 ++++++++++++++++++++++
 include/dt-bindings/clock/nxp,imx95-clock.h        | 32 ++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/imx95-blk-ctl.yaml
new file mode 100644
index 000000000000..179bdd33504c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx95-blk-ctl.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imx95-blk-ctl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX95 Block Control
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - nxp,imx95-cameramix-csr
+          - nxp,imx95-display-master-csr
+          - nxp,imx95-dispmix-lvds-csr
+          - nxp,imx95-dispmix-csr
+          - nxp,imx95-netcmix-blk-ctrl
+          - nxp,imx95-vpumix-csr
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+    description:
+      The clock consumer should specify the desired clock by having the clock
+      ID in its "clocks" phandle cell. See
+      include/dt-bindings/clock/nxp,imx95-clock.h
+
+  mux-controller:
+    type: object
+    $ref: /schemas/mux/reg-mux.yaml
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  # Clock Control Module node:
+  - |
+    #include <dt-bindings/clock/nxp,imx95-clock.h>
+
+    syscon@4c410000 {
+      compatible = "fsl,imx95-vpumix-blk-ctrl", "syscon";
+      reg = <0x4c410000 0x10000>;
+      #clock-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/nxp,imx95-clock.h b/include/dt-bindings/clock/nxp,imx95-clock.h
new file mode 100644
index 000000000000..09120e098a97
--- /dev/null
+++ b/include/dt-bindings/clock/nxp,imx95-clock.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_IMX95_H
+#define __DT_BINDINGS_CLOCK_IMX95_H
+
+#define IMX95_CLK_DISPMIX_ENG0_SEL		0
+#define IMX95_CLK_DISPMIX_ENG1_SEL		1
+#define IMX95_CLK_DISPMIX_END			2
+
+#define IMX95_CLK_DISPMIX_LVDS_PHY_DIV		0
+#define IMX95_CLK_DISPMIX_LVDS_CH0_GATE		1
+#define IMX95_CLK_DISPMIX_LVDS_CH1_GATE		2
+#define IMX95_CLK_DISPMIX_PIX_DI0_GATE		3
+#define IMX95_CLK_DISPMIX_PIX_DI1_GATE		4
+#define IMX95_CLK_DISPMIX_LVDS_CSR_END		5
+
+#define IMX95_CLK_VPUBLK_WAVE			0
+#define IMX95_CLK_VPUBLK_JPEG_ENC		1
+#define IMX95_CLK_VPUBLK_JPEG_DEC		2
+#define IMX95_CLK_VPUBLK_END			3
+
+#define IMX95_CLK_CAMBLK_CSI2_FOR0		0
+#define IMX95_CLK_CAMBLK_CSI2_FOR1		1
+#define IMX95_CLK_CAMBLK_ISP_AXI		2
+#define IMX95_CLK_CAMBLK_ISP_PIXEL		3
+#define IMX95_CLK_CAMBLK_ISP			4
+#define IMX95_CLK_CAMBLK_END			5
+
+#endif	/* __DT_BINDINGS_CLOCK_IMX95_H */

-- 
2.37.1


