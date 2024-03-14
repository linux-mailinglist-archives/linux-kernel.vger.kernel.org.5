Return-Path: <linux-kernel+bounces-103284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F1E87BD77
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7211F2215D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421486DCE3;
	Thu, 14 Mar 2024 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YzuXlKhV"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2045.outbound.protection.outlook.com [40.107.8.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2585C6EB55;
	Thu, 14 Mar 2024 13:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710422257; cv=fail; b=KkKcB8BoN4Svzg2vfUfSepUKx9q6TD0S30Zi62DpNC+dtOabtHWdnrdW0FhNchPpS0+L5Pu6iDP6FApKU+xd/cvPEG1dfCWBY9IA/twGR+IjClaXGV3yoKHzhXP43YsD+xh7PF4oGpg2K9bOImT8jbg5+s60HGj7+we4LBMk2+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710422257; c=relaxed/simple;
	bh=aaFHRrcLdFxXpn3xtANy3lDPAyqrB9mFqlHPM37e3x4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aMq8o5qanrMWAzftOz4Y5gov/JzrokESccCsh0WrOcClSnUuCig7wlbOXkCqbt5pYE/r9J2o2bvGxhJuLn58epoFaed40Kwix/KVADSwC/Gl1dOSwryT4xN04BXZQ65oKnmLa42gB+aEs4/mKO0SqadryjQjS6QzdZTJ0Z/3Ln4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YzuXlKhV; arc=fail smtp.client-ip=40.107.8.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUofnJ9y/Sef3S2DM19vy9k6//AnZEbP8aIj0YzveqS4NPupk+J5PcPyfBZeSVWVtUtnmRETTxJh0aVulIFYw28FNRnv5s1lyz2pgias1p7KE/lVTPkKrmYV6O9MwydC6VU2FuhZH+SZ8gXvxekBThPbILv+jDjyDn2attEDkgKirUQ+WYM9guH65KXLTTePCM1MjT9P/BBg6epL3wdY2SAaraZQ4JUbtl854N52x+v1xvGPP3c6DDw7Ug+ZsKawRMCsjJl/h4lTNyra4rxJUIYAlbtebdIRh/EMVbSO6SVyBp97wvjMrDeQrqioQrBuy/2ksTUm5AjU2KhFkg0vPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yk8XFiyyANXV35TM2w/vxaNgwnnpdcdqgw24oCH4bz4=;
 b=lKoMpYwAy0azahO3lthiWQrUe5eXRfiDrChnzRgR9y/HcL6HoKKecpvVshZClG6qaSs4mxsiFLDLLuGbSi5MGoO0JNHC1sSV7PkD3KSF/tZLZwOhtt+g+XzfGrEClvoJGJJaWwEO93Ypg8hjzSec5KgCkOnEE12IUDZwJYkdZOMydzupES5kHwyn+hncae0zHtB7MsAJ0X0lZ3F17uLeU7TexUePFS5A+Q+YYvWxOkxoed6jCZcav0d9rtcf77Z9G1Nc/ZuajbHnt2tuyyxeJTUH2ptizcgf3ufKri+QTNzSnC7YSc++nJqHy0xHJVD9h9ps8wngYGq4MCdGEHhOag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yk8XFiyyANXV35TM2w/vxaNgwnnpdcdqgw24oCH4bz4=;
 b=YzuXlKhV89aO0TczgkgumQJ/sa+u/BR9ireIA/vxVcMqtAeEusqNnKgLaK3dhAoDTCLj2wMI6vq8L1C/duNAvVHhgQkSCAla7MK/4AOTR4MbTPLwwMPSO3wKDwgy7Xz7aG9z1EvovS/F0GsYbpsInpIqpGvvK0LB6PVQdCN+ZMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8806.eurprd04.prod.outlook.com (2603:10a6:10:2e1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 13:17:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 13:17:31 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 14 Mar 2024 21:25:10 +0800
Subject: [PATCH v4 1/6] dt-bindindgs: clock: nxp: support i.MX95 VPU CSR
 module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240314-imx95-blk-ctl-v4-1-d23de23b6ff2@nxp.com>
References: <20240314-imx95-blk-ctl-v4-0-d23de23b6ff2@nxp.com>
In-Reply-To: <20240314-imx95-blk-ctl-v4-0-d23de23b6ff2@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710422742; l=2432;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=oBfgXvJOkUvZpqBqKyx61phq+NVdb4iyS6Nu0vXi1l8=;
 b=J9UCWV2mJZkpJq83v+YDYvK0Gn0se2D5+Nw0rwOnC1ogjD9MHOqQ5xuIujHBCIu/QFIEAeTLF
 4KCxWT1fMlJA5Jz8Zx91gMIdrta/oMNWRVzymxPlQ/THyxMqZGHgM5M
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0130.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::34) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f15a57-f1db-468f-3b23-08dc44291ad4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	72OA4G/Kdw/0g+EdDoV1TK3z8mvy4r7nmh8Rgkc0E1zR4oKrg6Z7Oc0Qu3B5UeiIzSAaisf55GTmDf3mRdwHeWGqjg+RzjjYdkt54PlwSjBr3F4L0kIm6/BlEoOOeASoCoAp20R/w7Pzgd5Mu/JqNEh43plo7b5mvyvGh3a5nOQi7UxVhf2TOcB76vC8/UWgFGtoHp+F0dAhrPKwYE5zefv3QOr+AK+ZAlxl5oEIWLrpKgjFs3aSleO9Ftld0T95DjLdmiJmJGJqSvwp3D+UmcXxm2hyfRx+2/PueEpNctsvVbeUQsO0CDNsDy+ovhak+02snQDMw3Qana3qIFzuPeMnBD/SuG5UuW/DRbeDLW3IwTnVeyAMgG9LZVNOc67euHgeYoC8fQzBWX/QTciB84C/l8bjJ1mS+GlQiygM36CiE5M/PFNQgehlAlPBjLs1XnFRF6L/gp2xPuc/PdU8DLBC0jvuGmJx2k6ArIVdCkGk+2e24H8i5im8Yfjw5QxgmloejGHwJzK1vrHGKb/tsWwcA/XQCvarfqFHxuycNOn9KjIj8dnn4kVj1I8OFZ1OYSPkASwNaLY7RaHQL91/FYM9v7Jk4wMZk+uaphx1ftcqxtU5n53Jt20lz+3cLq4OneEfos4hA6+0UKW42ePk8/1ia+W3DNTw6P+/RPmWZj0pIFvRhT46Vxak3LxNjHKc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(52116005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUtNVVVhUTJtZHd4Vk1DQzJsbkNydzFKNnNJZlhjYkdnc3prL0hnSHpMU25N?=
 =?utf-8?B?UEJ6SXpwc0ZIZ0dGYmJyeGJUaUt4TDd2UThXRWZWQjFVRDZOeUhqRnN2ZnFV?=
 =?utf-8?B?TUlMS1VnRCtMZVJBVktiMUYrS2Jsb1dHWUtMenQ3YUx4TXI4MWp5T1N0V0cw?=
 =?utf-8?B?VHhoYStZM2xYdkNxS0s2VTVZWTJjMmlaZXVnNVJRaWtkT01wbExub0hKR1NV?=
 =?utf-8?B?R2JjekFQV05zby85dHBBQ2JnSGVuajlzVnEyNUc5UnNsSGFPbFBuWUo5ZHlT?=
 =?utf-8?B?R3E2R2ZVdWdSeDBwZFRtTGc5K09UV3BDU3NPOWgya0JZdnhyNTUxWEVieURS?=
 =?utf-8?B?VlYvMk9zdnBHY0dHaVhFSEVOVXVsc0RnMC9sNk9UV1Y2bW9sSkpBNHJMd2p2?=
 =?utf-8?B?ZDd4Z3I2MS9kK09BeDExUXdBMThXMkg5by9iYmI1UzVlWHU0MGFvNzhuaTls?=
 =?utf-8?B?c242TVZaeDduVUJqVE4rTVJySVJsRE11aGdiQ3NYWE0wQ1A2Z0paSmptZkV1?=
 =?utf-8?B?Umxmb0s5R1N6Q3dyMXdETHNwZjM1VkpVUjdka3o1YmQ4Uk52cDZNZkw5c3pM?=
 =?utf-8?B?WTQ2RUVmVVFaTnZsa0NwQnRCUDFEUDhza1RWQllITjh5NSt5d2NzS0w5aXdo?=
 =?utf-8?B?cHpZMFJTWFhxWjIzRlozN2E5TEhzZkZreGRPRmNRTThnbVV3clY1Y1NBa0JF?=
 =?utf-8?B?anlZdFJIUVE3NFRVWEh3ZnAwOVkybFZVSHhFcTFQd1MwMVdaeGsrNW0zUzBO?=
 =?utf-8?B?VVJiNnFPZklaT2w1VExBWUh5a3ZtZXgzakRwSWwwTklTVkNwbWpIbktsZ3Nr?=
 =?utf-8?B?YWJ3MldxamRtbHVxeERSMkppcXh2ZmRpb244TjNmckJJZjR0OEVWbFE4N2pR?=
 =?utf-8?B?WnlRcUFuaEJqZFVGMlNJT2RoVDY2UGFNa3ptWW1oZ2RNV0c4elg3UUdNdEF3?=
 =?utf-8?B?S1p0TzkvbzhJU1N1VGVsSWcrb0hpM0hDYU9pUkdGY2xoMHFHWWptZDZKMzJE?=
 =?utf-8?B?RTRMb3NtRGFBTHdJMWxBbzRVYzlXOGJUWHFDS0RnaTA2eWpKb1Q4TFdZd3V1?=
 =?utf-8?B?dkdOM2hacjFIYnFaSmJFRHc4dFl6K01tK0hZQTJtVGhTTTVWekV6ZC8vVnA3?=
 =?utf-8?B?QnBid2tCQ01Gd0pYSVF2WVNUcTdIQjNJbnQwc2FOamxyS095ZGIrOU5wdTU5?=
 =?utf-8?B?N0JmMlJlWU9nOTJuUVcrUGR5M21SQ3RBa3pZcHM5RklReUhVOGRvTGJnTlB4?=
 =?utf-8?B?V2hxWUxhbmZVdUtNaGlsbHA1U3ZXQ044bGs1OXlKN3FpcmZacGxudmpwZG1a?=
 =?utf-8?B?Rmp2T0NZbTlrMmx4M3k3Q0pJSFp1S1g5cjE5NGlaNVBQSk9tall1eG5sMXRS?=
 =?utf-8?B?NzErTGdtbHVuQ3JRZG5LbjdaYmtxREI2SGE4YTNrK000WmlMMGw2cFg5d0hx?=
 =?utf-8?B?V1E0eFlqaXFRbHRHNWorOS9HbnErVGFDN1lDMSs1eTBzRm5JUmsrWWZmVlVu?=
 =?utf-8?B?cWh4ckppYWQwejBPVUh0Z3JzY0NaWXpxUGlDek9WcTI3QmE2cTlzSUZ5aEdC?=
 =?utf-8?B?WTBmU0dNSzJWdjZmbng4ejhZSi9sOXV4SHRFU3lQRVVCbGlDVlpiUnNxRHdz?=
 =?utf-8?B?YkFXNFVoeUxFdm1vL3Z4SHErZkhnTmpkWCsyL3ZzUTA4TlovSHV0TXk3SCsw?=
 =?utf-8?B?T3NRZ0d6RW1iSXRzejVHSnNWZjYxTkJlczRZNkZlcG1jTHY2bUNBRVFod0RW?=
 =?utf-8?B?ZzdLN0RERWhuNzhMK04xN3NicU5adXphUEpUZStpM0tFNit0c0oxNTBINWs5?=
 =?utf-8?B?VzJNQm1qb0NWSTlSSWMybWFzL2V5VHhxVEYzRStaVEJaL1VnbGw3TjRlRVlP?=
 =?utf-8?B?dUYxdlhSREJaVk1QU2tkWHd5RkUxOG82TEd5RTh3WjZwL0tRUkRVcitIQ2c5?=
 =?utf-8?B?TXAxVXVXWWtUREpISmRHZWV6SjJ2dmJlYTNSd0xmVWpxQnQ5b3FMVkhkcUhp?=
 =?utf-8?B?amxCVUJEOW9xYzhFWDQzMms0ZXIyVW9vSzB6d3daa3RSSFJza3NUaUZhdS83?=
 =?utf-8?B?RzJhcXNCb0dsZDVmNWlwVWxZMGNUcG9GMGsxNVl2blIrcHR0RnRPanR4VG1T?=
 =?utf-8?Q?IqdQ7EApVSkJlyBNKaSqbhAU0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f15a57-f1db-468f-3b23-08dc44291ad4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 13:17:31.5466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7G7c5xzBCFI8CagsMuVOaeJdhwJiibh1Sc7W+udBG11BR32AQuwP+WpCzP3P6ABVF3XBRY4HH7hh4EZ3ZlltQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8806

From: Peng Fan <peng.fan@nxp.com>

The i.MX95 VPU_CSR contains control and status registers for VPU
status, pending transaction status, and clock gating controls.

This patch is to add clock features for VPU CSR.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/clock/nxp,imx95-vpu-csr.yaml          | 50 ++++++++++++++++++++++
 include/dt-bindings/clock/nxp,imx95-clock.h        | 14 ++++++
 2 files changed, 64 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-vpu-csr.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-vpu-csr.yaml
new file mode 100644
index 000000000000..4a1c6dcfe3f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nxp,imx95-vpu-csr.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/nxp,imx95-vpu-csr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX95 VPUMIX Block Control
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+properties:
+  compatible:
+    items:
+      - const: nxp,imx95-vpu-csr
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
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@4c410000 {
+      compatible = "nxp,imx95-vpu-csr", "syscon";
+      reg = <0x4c410000 0x10000>;
+      #clock-cells = <1>;
+      clocks = <&scmi_clk 114>;
+      power-domains = <&scmi_devpd 21>;
+    };
+...
diff --git a/include/dt-bindings/clock/nxp,imx95-clock.h b/include/dt-bindings/clock/nxp,imx95-clock.h
new file mode 100644
index 000000000000..9d8f0a6d12d0
--- /dev/null
+++ b/include/dt-bindings/clock/nxp,imx95-clock.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_IMX95_H
+#define __DT_BINDINGS_CLOCK_IMX95_H
+
+#define IMX95_CLK_VPUBLK_WAVE			0
+#define IMX95_CLK_VPUBLK_JPEG_ENC		1
+#define IMX95_CLK_VPUBLK_JPEG_DEC		2
+#define IMX95_CLK_VPUBLK_END			3
+
+#endif	/* __DT_BINDINGS_CLOCK_IMX95_H */

-- 
2.37.1


