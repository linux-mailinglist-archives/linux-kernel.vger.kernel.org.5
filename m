Return-Path: <linux-kernel+bounces-13462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E145F8206EE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 16:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100921C20C9E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 15:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033B39477;
	Sat, 30 Dec 2023 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="g3kTFmH+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760C1BA26;
	Sat, 30 Dec 2023 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XD1mpTNiFigowaLhxeFJ+CrXaOkYN1ntUYRtcQSCf0/vSBHH2T0Ap3JtjOxlFmB4knUDdd0KlQF2XFI6ekxqC/3wlBPSngkT5FccWTfPbfe/tpm+QSqwwtRvgeIZ984S7XbO3ArO3Q8ROYRb53FG9pOR1k/3wDwG+ZtCQn7iDcyxfXB9rZ6x5KxH8M7zOmwY98YpYpo3gHxZVDMoFMIh2T6wIf/ICh869NjOVszdNFC8UFqpf+Q+zorF8KAfpcGjTsU0XvRQ1E4aokpIbJ+5Ijdzbux/5trRJvgQfUcA3YVfgQhNHjj9c2rBXRW1XqcPkxdaXW42UHFRG8u7ENHqyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQ/wNMSx+DQQcBt/88Cj+GSOy0DxT4Izc5y+Igg7YYY=;
 b=iYGomGpFgzPSHRERGtm3yrfsY6qs1+C6moB9QYoKIae5Fya6Qdp/eqtSGhDvIWVTg7gt7OKNWU/XDE6u1cc+0E4wP4P/oEM8QBbydrmfYOTMIzBUZnTB636OLdlZT/Dz+15wI5v5of9WgwDG08aFaVWKGiHPBs+S08MuPIkpUZrzcziBePDstSCw1QMs6YtZ+ra8cneRoBeqnD3BDzFuGPKjs+K/oUkvhRivFsod7WxXHyfZEaJ+FghCiGLPxtACjNFG9b43RajzaVLT0EDgRv5rm2Yu8IubU5LzNuS3WoMIWmGBhl6DDnxxHBh0rgn+BpDx9g0bYrW0d/sNibdu5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQ/wNMSx+DQQcBt/88Cj+GSOy0DxT4Izc5y+Igg7YYY=;
 b=g3kTFmH+PyhqDo95aHIsGf4YCg8bwMExB9YiKH5BGZmtwaUbh3QmGAm0+gAtCvBcDzzLD1OxmpjR3ZmHCTndyTyAoFAOOwSzz8IdHpCYbxq7n3lfUPK7cu7aarP2KsdmRYBK23fj2icSsbnY1Bagf498SC15Mbo/WpOLuMPyLgc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB8PR04MB6970.eurprd04.prod.outlook.com (2603:10a6:10:fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.22; Sat, 30 Dec
 2023 15:44:46 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73%6]) with mapi id 15.20.7135.023; Sat, 30 Dec 2023
 15:44:46 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 30 Dec 2023 16:44:35 +0100
Subject: [PATCH v4 01/11] dt-bindings: marvell: a38x: remove invalid txt
 bindings for armada 38x SoCs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231230-support-clearfog-gtr-l8-sfp-v4-1-1d7f0e2c7128@solid-run.com>
References: <20231230-support-clearfog-gtr-l8-sfp-v4-0-1d7f0e2c7128@solid-run.com>
In-Reply-To: <20231230-support-clearfog-gtr-l8-sfp-v4-0-1d7f0e2c7128@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::16) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DB8PR04MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 177250fb-a906-46ad-0da2-08dc094e3f8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n3z5EmK1CFS6RwsYHn7govY8uFCPGiALlORdE2R38fEtGsiIBqYpnEViWJZU+y9UwSo0c1yyUwp6lO6PxuRbF1w0rTVtoH0EvrsfQNMQC91dWdTwUNTj+N0YuusG3nACTQjx+ye2PXwsTFRbYbH2kFQ/Kb7Lb5OMxIX9Foy3kw5YdSLlp753g1LwST/WZwEZWG4YgI/qBcu/0i2KzD7pga2EKcxVymmrqujxjjdg5kwZ/bwsSXKLd1JKjNDAGrfq94wIcvbe7GDuLSGSEVCY3G6fSavbnA6nJ9t7pL6irSxe4z0z0enVgXhA+vr6re5EFRYAwjgSE2/oUNCjW493sOS2R6atsqVHnPyWRs1XWjDw7tweYQc4ibp6NKTAZ9i1eSVlSHr4taEY23SBFkerUicdKswyEaaMttdsdBwSyRaV1ElIb4d+YlbkemJ5DoTFxwBcWupgHldYTyhrBVTiZS8YCZnf/P4c75YrMq4enF9/VTaxLGYC/r13R9JSq3QNdnVmmM8/dkUm4oDeXm063AUXoeaXNM0hX42ZSTKg2q7rXDDl8RPT5Ppufy2SdOB9nuO1P2niD7exZZjbG/Z+kUjka9EG7C5m6hg0qBubffgNPWQXoyNNP/ihX1+Y6PCW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(396003)(366004)(346002)(39830400003)(376002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2616005)(36756003)(2906002)(86362001)(107886003)(478600001)(66556008)(66476007)(66946007)(5660300002)(83380400001)(26005)(6486002)(110136005)(8936002)(8676002)(316002)(4326008)(6666004)(6506007)(6512007)(52116002)(38350700005)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OC96K3hvUkhOOENqZ3NsVm14T2xWTzBUb2J1c0JWU3E5Q0Y2eCtKeHNoOE9i?=
 =?utf-8?B?V2h6cjdjNDduOXliVURHMHE2bG5vOE9YVzNDOExOMHlCZFRXQUF2M1VqTDho?=
 =?utf-8?B?M2lwZTB1T21XVVhMa3FtYUN3REFwdnpycTBFWnUwNGNLZm1wOXVUTGhheWJD?=
 =?utf-8?B?OGFoTURITFhLYzI5eDhacGYzSWJwL1B5TnA4Si94NklRQnBxK3h5bUhrUExI?=
 =?utf-8?B?dndwTVpYTHYrUFZ0b3lOY2dKbC9VallFbEI2ZmF2TGVBUzRnaEJycllpMjU2?=
 =?utf-8?B?NzJRZWNBMmE4NTNZZWh5VktIWW00RnRPQWtYU2E3TlYwN2xFMC84clJPQ25Q?=
 =?utf-8?B?OUJrU3A3QW5qbFQ1bjNxdm10VU1LWlFOTVQzZXZQZlRsMk91RklZNjB1Qnk3?=
 =?utf-8?B?MVlkRmVJNXh0R1RDMFkyaGpRMzVQTVVxRHE0TGNCeTg1ZWE4bkVseHpHSlRm?=
 =?utf-8?B?SmtMTU94N0szSU5VRzZFamdTQ0tqYUhqVTAwY0FTbHBCeFNiRExCdXhWbEpX?=
 =?utf-8?B?M3RkOEhYdlZ3dFJ2L2M3akgwaUY4VW9WWXhHT1pEcHZGY2IyODdOa2FXWm1o?=
 =?utf-8?B?M3RwMDdOaGtFYnUyZkpKbTU0Y3YxcDRLU0tlRXNpSXVHdk5hbXI5N0pBcGsr?=
 =?utf-8?B?VEFJMS9RU2dzbXVGZWtOYzJKaTRKUWpTdFVSc0hDaWlDSmFJNk53alRjcTJH?=
 =?utf-8?B?RGJQMis1YWk2STBEaFFkZ1ZFNGRpNTE5ci9UdjFzYkIrY2w5cGpMeDJ6aWhn?=
 =?utf-8?B?ekdKbDdOZWZRUjZKeUlEbWF6Snl2WE40Y1hCWDkrbUZqTW1xS2llejhkS0Fs?=
 =?utf-8?B?TFNjQ1ZxdTlPUitxcDNlVFFWbThEeVowRDQ0TEFkdVlKak1hWGk1YVFIMzVH?=
 =?utf-8?B?UHJ0TWIzdXJKUVBrVVVKd085dUE3d3o0RjZsc01xWm1Dc1ZSQ1F2WnVaQVFM?=
 =?utf-8?B?a1cwRUJFTXBWVTVpZVJjcGttNGZ1YTZncUxvRXRIc3J0Y1lFaDNkbWl0ZWgv?=
 =?utf-8?B?RWgrQVZicXlZNEsvT1NLeXFpQ1E4NlEyajFMN1prSWZZWUIvNUdHOTNDR3VF?=
 =?utf-8?B?MGxEOWVOMHJrMUZYSEZIeWt6eE81VG1RNEtWbzNkQ0tjd2pVRDVmcUdiYjhu?=
 =?utf-8?B?VWI1ZzZuUUFoNkRFSzlRQjcxOFB5eklkcHJDWWxzbGRDcGFtQ0hZUWVJV1NR?=
 =?utf-8?B?dFBVMGFVQ2xTUUpKaUVmSWJnQWZYT2t0Z3NOSmQwSmdRRngvOFdUVzFBQ2tr?=
 =?utf-8?B?Zy9NY2xPbGpWb3BuUTFnYi9VOEtGaCtRM1A0OVkxSW1yeUl1TElESjA1TWV6?=
 =?utf-8?B?M3JuN3RwNWswRHFBdk9wQzRVODM0Q3dYd0pIbFlXcjNlZmZGU0ZDendKYSt0?=
 =?utf-8?B?ZHFpTWFsVS9iNUVzOG9kZytSb1g5c3hxeHJZMTNWSGNEdmdvSmsyYUtGQXZk?=
 =?utf-8?B?TGZZNmp6cXFvdGFjM1FkRUYzczJYZ0dYZC84WXVmaHhpN1ZuS1E5M011SlNV?=
 =?utf-8?B?NjhTYWVIdUEvb09Xd0lPQTRUcjVPSmttMFZBbG9qL24zMnFFdE5OZnlxN1hQ?=
 =?utf-8?B?NGFudmJFSGlLbmVNeC9LOVJmaUttTGQvVTZSdnJkMkZydkxWM1NCVWc4eEZH?=
 =?utf-8?B?alRVTjlOMTdSZzNEbFNhbzNwK2xwZ3ppVkhBQWdjeW80MmhCdXovZnlQL3lo?=
 =?utf-8?B?eXVaUnNtcVFFK1hoUkNiSmU1TW5CVXNDbTZRajl4Y0pTc3FvUHZUOVF3bFBs?=
 =?utf-8?B?YnpWSmpLaHdxM0NqNEM4cTkrMzczMzl5VHAybmlLOG9adzNWLzZkdnIxNEZQ?=
 =?utf-8?B?NGFDMWJoVjJ6UnFKbVhkeVl1WFdMUFJQZXgwaW9oL0tzOVBnYVUyUU9pVm1y?=
 =?utf-8?B?TGpGKzJhMEVTTDl1blQxd0REUjF6Rmkzd2h0UFE2RUtXbkpqaTBIT2h0S25L?=
 =?utf-8?B?d2VseC9HV2ZGR2hNZjM2QWxPSUtrcmNKWHlmZlEvaFo4MUxISFFSb0craUl6?=
 =?utf-8?B?NDNKRU1HRGx2QUJ3eklwZUxFUXFFZFQ2L0pUZk9nVzFQNWZzWDh6UjNTZ25V?=
 =?utf-8?B?YkdaUFZSWFUrczlVN3BFbndCbGVrb1Nwcy9SdzN6TXNhYXliNlpVYW9EMS93?=
 =?utf-8?Q?eU5wDixFBdj8SPeIRRwh94p1U?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177250fb-a906-46ad-0da2-08dc094e3f8c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2023 15:44:45.9142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlMGG0W+IqzkUlYOxKGPUyfygJqJn5lUaxeUdfWZHa1lOx6RXjWb+zZcpeR2fjmZ8gUKwgoy2vdaKFdiFGWVLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6970

The current bindings documentation for armada-38x are only listing SoCs,
but no actual boards. Only actual boards should be listed.

Delete this invalid binding document.

Conversion to a boilerplate yaml has been considered but is not useful.
A new bindings documentation in yaml format can be introduced with new
bindings for specific boards.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 .../devicetree/bindings/arm/marvell/armada-38x.txt | 27 ----------------------
 1 file changed, 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-38x.txt b/Documentation/devicetree/bindings/arm/marvell/armada-38x.txt
deleted file mode 100644
index 202953f1887e..000000000000
--- a/Documentation/devicetree/bindings/arm/marvell/armada-38x.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-Marvell Armada 38x Platforms Device Tree Bindings
--------------------------------------------------
-
-Boards with a SoC of the Marvell Armada 38x family shall have the
-following property:
-
-Required root node property:
-
- - compatible: must contain "marvell,armada380"
-
-In addition, boards using the Marvell Armada 385 SoC shall have the
-following property before the previous one:
-
-Required root node property:
-
-compatible: must contain "marvell,armada385"
-
-In addition, boards using the Marvell Armada 388 SoC shall have the
-following property before the previous one:
-
-Required root node property:
-
-compatible: must contain "marvell,armada388"
-
-Example:
-
-compatible = "marvell,a385-rd", "marvell,armada385", "marvell,armada380";

-- 
2.35.3


