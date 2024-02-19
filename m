Return-Path: <linux-kernel+bounces-71533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DF685A6CC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 006FC1F218D9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79203839B;
	Mon, 19 Feb 2024 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="EcZs4IIP"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2102.outbound.protection.outlook.com [40.107.22.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666AA381AC;
	Mon, 19 Feb 2024 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355028; cv=fail; b=FjVaqR0gYNT/oJ1Qw0FLYGUfUgtJsezJnYPVMYgEKYc+ZHqZTzrTcfsJOQJVyuO3x+AE7EwO70cuooTcc6vj6q9b2oCAwuBr84KHCKjC/iqj8X5qsKqHWr5COG2ZQFqdarRFtxpkTMfrnVRqgImAiGqTrWa97AqI5vZyRvXPW/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355028; c=relaxed/simple;
	bh=mwDdSh0+y/s6cnpH6XZpgpcRvp5XZELjoubpq4eori8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rRa/j9aurtL1WYT10Nqg1W+R1IYg+lpgyIhpgueje/9osvOSEEt8Zm4gwnBzqcqnzFwgrPkYyoDNSXYHy48VKR+zW8WjUrB+4rNKLqAjHzdXREcLs6yqk0ck7FeVVE+ZrwHpPF450EUJApe3nevzvx2G+eL15DwQKKuPs4j3Z4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=EcZs4IIP; arc=fail smtp.client-ip=40.107.22.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQlZp3MBbPWxKS4w8LZETlCMe5lhYi6G4YlrWYLhtAK0MKNhrqFn9xi38nzij64ec58dcf2eZjACIT+JD8maHtKpx6E5qMkAnYMDm1rZrS+Oerp62ZmxvLXFVGLunyWCEcL5cxQiki8YV4Y/tFQDcXkZvMQVI9ODT82UNpBE9fP0a/4xPCHtJKRprvvSCMju9hTTzMbyB6kdZDFBHgOtbAgDltkKhlyX478tE9ZI3KnJPdTeBOahu74i8SU9If3GOIYM+/Zgqht94heQXOQQpbihgDV/4cSQN7cX04tbVpQdh35zVxOGiuUi6ZQgW+RCElSv2hu5JBJsfLDZCT00bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVxPmi2eYokNgwgRMfWZLMrATkmf6SNKFaT5hWZTTKk=;
 b=kNAff+6ocrDjUOgocJHnitdCFpE1CO1N4jNnwX58K8eUHf01QD7QKqWCZ/rn4pXz/uNgodUtzD3/9Q9qExACDPKt4f15II2d0OGikd70Gw9lwfen68f8GK3MKD6ZcMnhK1z8bd4WVv1DDAlgPtRS/tTD8YrIQswKO5aty+tvZYf+0taFWda9ccw3x2oo0Lhar2tgRTeSzd0BmWKBHzIvwimmpd5lTx3Hg3ONrAKxsZIcf8X0tOieTN9lHAv2BUhLTtoLTdpu7LmS2ZY5V+u+44+qhw4HFC49ZaBXWvfvBkwiDUYHPfaiW450dXPjl84vsmbiP3UzEMbmFoIMtQieQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVxPmi2eYokNgwgRMfWZLMrATkmf6SNKFaT5hWZTTKk=;
 b=EcZs4IIPLEBPKvql3NodnEOriqFoeWhyyaIm4RQnRMbRfTEKirdCO8YuN6+oNF/K1nX2EjyuK8H1hyJqlAlYy7Cw2RRoqC6cU7LBc5Yudf3Kk4tCj8BH6ClY2LhtCT0QwNzvJDLnkQEBbuTI5YiddlVppxMJ+vcRUlEm83WKipc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DB9PR04MB8431.eurprd04.prod.outlook.com (2603:10a6:10:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Mon, 19 Feb
 2024 15:03:42 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 15:03:42 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Mon, 19 Feb 2024 16:03:00 +0100
Subject: [PATCH v7 1/4] dt-bindings: arm: ti: Add bindings for SolidRun
 AM642 HummingBoard-T
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-add-am64-som-v7-1-0e6e95b0a05d@solid-run.com>
References: <20240219-add-am64-som-v7-0-0e6e95b0a05d@solid-run.com>
In-Reply-To: <20240219-add-am64-som-v7-0-0e6e95b0a05d@solid-run.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DB9PR04MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: 56fa2c54-e816-456c-e586-08dc315bf645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tS9MfZrT6A2RNouYPki2i8xkHTAPgyV1hX4u5cOW0I/wWon3jXjim7ZG8yWX3NDVeKbMo12LdQoM1sTlAkM9YMGz1LoSg/5NRma8JbkiPogSU4G5RLWLX1fbV5qXlbLhIebmHCGP7nw/VMzQ4GWF4ak7Jjp+MgcaAbjiumS2YuLFPN1iNqnmWzaUuRvu0uReQZNpSqEoCMyCLDY0BGc2iOQzViMPXmOeFR7U/0VWQwauNz0vkp8E11hsFQat6yoduMMCuCN5c3BDcqIwQOQtZOyf5mlt0e1Uvx/jbGNDXxyDBC8t5E+qtq6YjmlFIvHyoQ0eF3zpZDKrKrHS9AqTEgBN0TYYtgkvrw3750EnfztmutWrsco2IwIddi4wIyfxS4WS9WlesQfZF0N2miIkiJU09emZHeUwb+m/HpydUIAG3ZBDlYqCCgBFr+wQx11Q0p/n3pPttb8rX07AkMzPk+qvcCgzMDs76CNW/YVfcK5qejnjnPb8dA3Ed4jS4zJVbz2tsODZcU5dkMYq7gUHAp+eHvQv3d49WLPKDIbSB1qBjnR+VmAXdN9mvbwbe39YGnoPZPqiDlD3W70t6+JeIrQ3Fgf15VZ3SE0ao7o52B3ur9SMSF0YABbJDhF0eqFi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emNuMjBtZkZFSnNCWjBEOGhYNlZOWXdZMzE2aC8vME5yVjFSQjRJWEZqRjFX?=
 =?utf-8?B?NHE5V2JTbkNuMENLVitjaW9zR3Jzc3pTOGIrV0RhalRSZW4vRkZtUGc2WjJV?=
 =?utf-8?B?YXlWZDA5bU1OVmVweFpYNC90NWpZV0JlY0tqUzJ6SGp0OTBHOUc1alVPNWNW?=
 =?utf-8?B?dWdTdFJ0ZC9PbEVwdGZ6ZDQ2UEMvc0pYRk5IdFdONFBPOG1oajB0R3g5VWo4?=
 =?utf-8?B?VmVQMGtKblVjQzdwVmRKL1UzNjg0bXVnZnhaYzVrelk3RzNncHNVVEgxRlhs?=
 =?utf-8?B?Z0p0ZjAraC9zUldmQ2dsZ0JySjRrWkZ3OG9QN2Q2a1Q2NHdXQTUzUVhIM2V3?=
 =?utf-8?B?SDM1dmw5ZWM3QXBsWC80WTBWS1cyWDF5QzFyMWNKbGM2dE4ycTBKd203Y082?=
 =?utf-8?B?eU1zUlZqdjZKM2RxY2NWT2xoRzV2WkRXVS9iUWV6bUwvelpEUU5tSmU0dmVL?=
 =?utf-8?B?WEZtMDhsdENURXJmT1NHdlVncFFOQUl4OTVZb2pGZ1B4b0hKQ1RGSjFyTnJ4?=
 =?utf-8?B?WlRnYm9yUmlnREZkMVZCaURLeFdWamZ4ZmFHMUpmK3VLSHdyVDJPWWZvN3Y2?=
 =?utf-8?B?VHo3M2UraE05ZmtjalFUTjhuWldDK1B0dU9rTHY3dVZuK2d0ZFkrQ2twQmll?=
 =?utf-8?B?ODBSR1pzU1ZONXptc3ovdk9lc1hzNTVTTjVSdVVmdm9SQU1SUmx4Q3Y1WU8r?=
 =?utf-8?B?cldzYnhFaXJ5QkhmSmhnRFNrWE5QMkIzOWRySXRNeXNNWkdHNHVMcURJcVlt?=
 =?utf-8?B?Nk9pNHl2TTFBaUJCaHFIVlcxaStSMGxpMUJYTnhQRzhyQkFLZzlGYnFNSmY3?=
 =?utf-8?B?SlJDWFlUWnlpWUxoYTQ4d3VBUmhienpNV1R1d2Qza1BzN2poZWplaG5ENDZL?=
 =?utf-8?B?Zi9KZWNZOUpCZEVHKzZSekxDNW42NnRyemQzYXlmUzFia3JIdEdBV1BkVkpM?=
 =?utf-8?B?SmRFRFdjQ3orRExnYmhnYUNZanpKWEFjcG41SlQrZXlvK2FTWXR4TVJLTmpN?=
 =?utf-8?B?bG1lQmdOdlFYZ3R4ME5zenMyZVdMT0piRmx4Nk9jZTRIWUpHL1k1R1I3UUwz?=
 =?utf-8?B?Q0F0L1ZNcG5ZK3ZsdDlzVmxmb1d5SzJhNGpEYXBwTXE3YlJkSnFWbVh2d1hj?=
 =?utf-8?B?YVJvZlBoQUM2eHV4a1NPOFdETWFuWlF5SlpkR2duYzFDblBiWXJ4amUyVTVB?=
 =?utf-8?B?MEpkNUF6MThRamZXUzViajc1cUc4Mml5ckY5c1VRZm9scmpYa3dCNytqUURI?=
 =?utf-8?B?Z1g0WEpEdm9Yb0YvVzV4ME4wWmR5dUVJeHhGUDZveXJVRWJrV1R1WVFqWnJ4?=
 =?utf-8?B?dmFjQ3pmWDlKVDlCVTRGVTZ0M0VITlhzb3BVSDJWTGdNWXNUZU1JKzVQOEhY?=
 =?utf-8?B?QytIbnJ6THJQZlBIM3hHdTA2MzIxMkcrZUE0TFJWMXlDQjZGWExadUZOcDhz?=
 =?utf-8?B?NFRZaTBzUFVrRHlnV1VXVnltRE03dktuRGNIdExuTCtMUFlKdlh2cWswbVg0?=
 =?utf-8?B?Vmxualg0VHAxa0I5bjYxVWUyMTFBZklOYTd1K3FWL0MyQ2N0bURVZW5CK0Rs?=
 =?utf-8?B?QzF6eENhZCtBdzlSZi9ERG1xYzJDQ3p0YytPc0laTTRka0RjVEkrVFNCVXBv?=
 =?utf-8?B?YzI1WkIrVmcycnNDSlNaSGtFekZ6eVFpM3gwaEw3S1psVW5zQjVoWDF4WHBT?=
 =?utf-8?B?eGxrb3NrWm5lcEdVU2owOU5nZ0p5aVYwMUdvY1paWnpMbmtYZGhyT1hFRUdj?=
 =?utf-8?B?YytPa2lMUkdkL01Ea25lNTNQZmR2SWdpRHVEZlJ0d2dMMXNZaFlIUlg2WVF6?=
 =?utf-8?B?OUhRejZvUG1VTjBhRVVINUIxSU1SRVBIVEJlQkErOStpS0VLQm9VRXY0WXQy?=
 =?utf-8?B?K0pMaWRmZFVzTStQZExpbHZOcU43Ymh3WWl0UkM1NGwxSzA1UU9EZmpjMlU1?=
 =?utf-8?B?TnVvanAvNEJqSU56cFd3MWgwUlowNG5LTzZHWWpkUkJTNXUxOUo4MU1zRk1k?=
 =?utf-8?B?QzFaUGtzVXRXbEV0RzlIb1lNN1NqcWVVWTMrUU5hWWRHTldER2h4dGlwTGQ5?=
 =?utf-8?B?ak1EeVBaQ1dXVUc1cGxhcFpjMmtWenk5Qmx4RWp2aDVvM0QwTG11T1gwSkJG?=
 =?utf-8?Q?TQk90Xj/z6g5UnOIfBEtiKZrd?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56fa2c54-e816-456c-e586-08dc315bf645
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 15:03:42.4318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYVPPnVHLXfL46Qfb7JXV+US5WY71td14axhY9wxcAkKQnjVykdkx6xZH8SMWpRQSKm6e4kBuxcT0qzguyErWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8431

Add bindings for SolidRun AM642 HummingBoard-T Board, which is the
evaluation board for SolidRun AM642 SoM.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index c6506bccfe88..0233a8b0b6fc 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -87,6 +87,13 @@ properties:
           - const: tq,am642-tqma6442l
           - const: ti,am642
 
+      - description: K3 AM642 SoC SolidRun SoM based boards
+        items:
+          - enum:
+              - solidrun,am642-hummingboard-t
+          - const: solidrun,am642-sr-som
+          - const: ti,am642
+
       - description: K3 AM654 SoC
         items:
           - enum:

-- 
2.35.3


