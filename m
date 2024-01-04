Return-Path: <linux-kernel+bounces-17057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622638247B7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7D71C22568
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D4128DCF;
	Thu,  4 Jan 2024 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="k/nVesN2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE157288DC;
	Thu,  4 Jan 2024 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlMw5xj+qDd7rvDh4CnyMOQ0CQ3AIU8dMkLHGDDW+97Q2bardCEzzt34GanwoM+QRSAf6e2zi6nkK8kCUV/DXPtSkfAkrhiCG6SOUWl5w68R+E6m4BsdcjmX0fYg9h7rlqZe7pnwZBZgbwlXhHdHYpP74BqA+Qyc+ztKVYW3u4EgspTkmGihSIj8xwK5H0n8heTgDVRhhPcBhvpmaCj3EM8rgh+XFglrCEoKWcqQjRUyTUiIVPzyqrAsw2xuliKlKYIbsPV4TfLbRx5kSYmcRQ2C63bW22Q1xunouhHIatCYp7wWHzUgomr1pUTX82vDtbbvQqB9z6jr8a/NbgUGPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsz+aAFGo4YjY2zs03h+N661ENmJZ3Rw/2R+wKByAnk=;
 b=M+Zd/br6phVrn1Wxt+TlOFMk1jM7bgyu4nF3BtJYWQeyUBPH9bm1ZdXJqi1sM0xgnzrYy7HZyM0jCAemfXC0a1ARGjsjCSDfO0Z73vetBNP05OkbIoe1+mPqkOaDBH+ewVx+OhWskLPPzTPh+jvTPGmGZkLQE/Mkg+OTUCfifjyfRZMdIoDJD2MvBpoX3uG9Bdg929S0GrcIHqREF3mwE+laE+J08/V/h0S8Fc4mgJozICH2xl3jxLV38vxdaIWV07em+gKZFegYk6c7yCuWgvOTr/JO8PR7scgm8dCXJYSZcKhNo0jU2efdbS3UomH5JUBOFUDwoxBCdHczgZPQ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsz+aAFGo4YjY2zs03h+N661ENmJZ3Rw/2R+wKByAnk=;
 b=k/nVesN2mQPayHbsBBsZJRNvO0D32bAl8uuHt/A2TsEe+aAZAmtHt8rMvsTI2YGBKY8EqXtMBvpsSxqzmLIXtdMzqOZ0pT3yuoHPg+hXWfRFik1UZvHg0M1/g+xkAZ7OCIgK/Z4A/l0fr+V2JPzW6zAymkQv0oys2KqokW0XDXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DU0PR04MB9495.eurprd04.prod.outlook.com (2603:10a6:10:32f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 17:48:06 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%6]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 17:48:06 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 04 Jan 2024 18:48:02 +0100
Subject: [PATCH v5 01/10] dt-bindings: marvell: a38x: convert soc
 compatibles to yaml
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240104-support-clearfog-gtr-l8-sfp-v5-1-52be60fc54e3@solid-run.com>
References: <20240104-support-clearfog-gtr-l8-sfp-v5-0-52be60fc54e3@solid-run.com>
In-Reply-To: <20240104-support-clearfog-gtr-l8-sfp-v5-0-52be60fc54e3@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR4P281CA0409.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::9) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DU0PR04MB9495:EE_
X-MS-Office365-Filtering-Correlation-Id: 2243c775-cc8e-476b-582a-08dc0d4d4ed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SwyJzY7rRrsyDBTdN9P7WsWXPjmmo8pFbA9g27cBxV5PB4ACn/6NwTLwrLhnNsHMl+6IuSPtKnR8xs8crBRS9jkEOYxER/4bXptCtTIG2H0BLGHV5KUvp+HzG6Ea/NEu7FYyCykMtYqPlrl6AP1VkeB0waLcTh5dp5W2jgjBbJsOaVKtn56YQbg+oYZ/QanWWvh96X+jrJ4+Hqe6Negx6khFtp1GkjiysVYhRVNuVZYW94VgGnl5mdA8GX/86aCfQ0F1Ukmw53GFsM71JLO6KH9py+0HjjuBUiZ88cAKCtGuhguyq/kuRIXgpIMPTFAxNelRPKVUimwD5391FZMKXHf1rp7OzrIjTLdhnMUhL6Azsee+52A+fOwnyWbEY8/38clpBrXEK93q+ubLH9MxZ+uEDAgwQKm+XxMYKP0/BHhXyGh+tm0eSsPtvY5wPvF43ky6gdiqa9/1LKExEBS31MJAMBkGnxaHxz84/jIGGKMKlxNqgP6I6z0mHq8GCzy8huNZanrMBCIPvfTHilb1zA5m0+rvMIRHwZ/OXllt6IYNkOURkSI31LFQgls49GwIqxQ7C2yy2OL4RcEHFRSkchaYgDHN7r8LBnk6NaH4qdA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39840400004)(366004)(346002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(26005)(2616005)(6486002)(52116002)(6506007)(2906002)(8936002)(41300700001)(4326008)(66556008)(6512007)(7416002)(66946007)(6666004)(966005)(478600001)(5660300002)(8676002)(316002)(66476007)(86362001)(107886003)(38350700005)(36756003)(110136005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUlnakc4VU9QSWdpYXYwWDdIbTlQYjJ0Sm55YUI4UUhkdGZTLzFscVZnZGJE?=
 =?utf-8?B?ZWdiRlhkeDVUWVJGZFNVbStjeWlvL2xUSkRoVllGN2QwMlk3bll3cGIzdjZ1?=
 =?utf-8?B?dnBiZ28wQVp2SDgwTndiTXEyekdwV29mQmRoUE4yVkxBWU9KK2svYnZkSmh6?=
 =?utf-8?B?YnVXWmN3VHgxSGZXdWRqQWdCRDF1UHdVN3VEVnUxaWNhVmtEMnRjc3p4MVlH?=
 =?utf-8?B?TFdPTTVpRlBMQm11R1Z5R3I5Y054dGtWbGk3amIxUW1nWm8zVWFvaHBHL1dN?=
 =?utf-8?B?clFSbUVOemVrckpoN3pxeUxnY3JhQkJ6Z3VqVDlYZVpVYW5mbEVUbzFqeFYz?=
 =?utf-8?B?eTZWVzZhWFVsdjVxb2R3YXpwcjMzdndEWWE3UktiZzRjcjZLcGRmNEp3T3h3?=
 =?utf-8?B?eSsxVGhST2dOZ2d3SVpocVQwR0xYdm5aQURiNEtDNWFPbmkyVUJFRGdHaUZo?=
 =?utf-8?B?a1IxMlU3TFQ2UFUySHZIc2ZhL3QrdXdiMlFEemxjd1RjbTZkd05TUk5EZVZB?=
 =?utf-8?B?dnpKMlB2OHVmcWIyR0tjaEJNcWlCNWhjU3JnbXZ0VWdXbmR2Zy9GVkRrOW9m?=
 =?utf-8?B?Wk5PTlVBNlhnMkxpN2I1S0NUdTdQd2ZERGZaVkVCdnBPMWE0WVRMR21sS2Rl?=
 =?utf-8?B?aGRnc2lzejN5amdjL0M1M05SL2dhT2VielR4QUgzenNSSTBtTlZ5ZG92UllU?=
 =?utf-8?B?NkZqZFFFclpYMWNQZGMxb2prN2o3M2o4YkpibTFDSGRTejZEVDR5T1BRbG8y?=
 =?utf-8?B?ZjRtNWthQ2pvZFZTY0FGdE44TGFzekJvVGxWZUJHNGVzNEZLQWZIVE51SjR5?=
 =?utf-8?B?VDNIODhkZFBoVitjek9naU4zUFRid0hLK2xCRDYxaUtTZDVMN1VIaktRcDdV?=
 =?utf-8?B?R2FhWE9OMU5UWURqZUxTeDIwVVJyY3pDbjVnK0FnNDFCQmdlREtmSHBCWFV2?=
 =?utf-8?B?bFlkQUdMV25aUzJ6eHNpcnR6dXdGWjBZa3lsNWNiaGFKa3FYeDBCRXNOdUdN?=
 =?utf-8?B?YUNXeW02YysxcG9qTVJwSXFDME9ZTlhhSFQrNi9IQkZNUHA2NlRsU2xTUG5F?=
 =?utf-8?B?Ky95L0NmUXY4NmhXTko5S010RWpUUmdUdTRGeVR5NHEyV2J4MzBMMnVRU1o2?=
 =?utf-8?B?dnRlUFVyY2h1cjlndUY3Um5udWx4cXQ0N0JQRUFuYWQ5NktWamphZHVJeEtv?=
 =?utf-8?B?UGxDMmwzaWZSSXIzRDhqTmQ4UEtpWnpTblEvVm94U29xZmpKOER0blVWN0Vi?=
 =?utf-8?B?YkV4cmExYWxCdTM5amM2TVE1ZXhacE5jTFNSS1c2WEo0bjNzcFlRZVJJamdk?=
 =?utf-8?B?ck5SZDZjZHFYUUsxaDRmbVhDMjhsMVRjUDRPdkI3OVpvcmxiQmYwVERxTW5K?=
 =?utf-8?B?QTdsaUp3UFFkMFh2VmlIY2dtY1RCeWdrcklIU0d3K2t1M0xDa1FXUE9oU285?=
 =?utf-8?B?cWVaQUZERjdsTkRWMWttMlJyU0U5d09ZU1lveW53UElSY1hKMG84MWhaeS8v?=
 =?utf-8?B?eGhRZDNRcjlKNWtKNlQySGlpY1FaTFJWa29hMmVidFVQczVxczdyM0ROeWYz?=
 =?utf-8?B?UVI4OWFzaitleTdpSlhHeHRNUmVHcnVYQ0lVZEdXZ3ZBWURqNTIybGJ4bk8y?=
 =?utf-8?B?dHJmaGprQzVpMDd4QWM1R2tSVnAxSzhLaFBGY3RmS1NsN0trYjZIMVlTNnZO?=
 =?utf-8?B?SmthVEdDV1JhbGNsc0FiaXRpRmkrYStXSS8rUmFid0cyMUc3K1ZyUytpZDMw?=
 =?utf-8?B?RjZvWkZPa200MFVtbEtHNzcyclYyYnp1NWhWRWN4NVFpU2I2Z1lJOTlubVFR?=
 =?utf-8?B?OUxDQTJ3YVNpbmcvTldVaVV2RHI5NWZZUllYQ2djRXVCM1FFTlA4UmZWT05X?=
 =?utf-8?B?NWxxOFQvUUFIdVd4SzJVZHprTmU3RUYyMDBDTVVlSVlqVkpldUFOdmpFbjVF?=
 =?utf-8?B?VUY5TjBhTUw0TkVob3MxUEpidHlCcWJua1lCL21CWXhWdTNQalFCTlczWngw?=
 =?utf-8?B?NXRLbjJZcmNVQnZ5WlJOMWgyaURWSCtnZkJHTjFCbEQzZ1lRazVFcVBMaVNG?=
 =?utf-8?B?R1pTZ2U0TDVVRjNvbEFBQXNpUDVUWkF4b0xrY1FxVThaVmt0bXNsNmhWK1Ji?=
 =?utf-8?Q?p7tt9TpcB8nxzu3Hw+rRbn79V?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2243c775-cc8e-476b-582a-08dc0d4d4ed6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 17:48:06.7447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FI90JnJaBCcRA+Ow8Te5BLE+z4oGeQSVnw/Tg3Qe2Fff48/lpov3hD3WgRQpqFJR6JbVRxh2VHL1kAEk1ayMdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9495

Convert the existing txt binding for armada-38x socs to DT schema
format.

The current bindings documentation for armada-38x are only listing SoCs,
but no actual boards. Only actual boards should be listed.

Replace the dropped entries with some actual baords that already have
valid compatibles in-tree:
- armada 380 netgear switch
- armada 385 marvell development boards
- armada 388 development board

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 .../devicetree/bindings/arm/marvell/armada-38x.txt | 27 --------------
 .../bindings/arm/marvell/armada-38x.yaml           | 42 ++++++++++++++++++++++
 2 files changed, 42 insertions(+), 27 deletions(-)

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
diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
new file mode 100644
index 000000000000..108d665220b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/marvell/armada-38x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Armada 38x Platforms
+
+maintainers:
+  - Gregory CLEMENT <gregory.clement@bootlin.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+
+      - description:
+          Netgear Armada 380 GS110EM Managed Switch.
+        items:
+          - const: netgear,gs110emx
+          - const: marvell,armada380
+
+      - description:
+          Marvell Armada 385 Development Boards.
+        items:
+          - enum:
+              - marvell,a385-db-amc
+              - marvell,a385-db-ap
+          - const: marvell,armada385
+          - const: marvell,armada380
+
+      - description:
+          Marvell Armada 388 Development Boards.
+        items:
+          - enum:
+              - marvell,a388-gp
+          - const: marvell,armada388
+          - const: marvell,armada385
+          - const: marvell,armada380
+
+additionalProperties: true

-- 
2.35.3


