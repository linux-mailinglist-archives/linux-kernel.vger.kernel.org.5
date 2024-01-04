Return-Path: <linux-kernel+bounces-17061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D68C8247C0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70CC31F27267
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA482C198;
	Thu,  4 Jan 2024 17:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="HtC8Oi0/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BFC28E0C;
	Thu,  4 Jan 2024 17:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/W630B98njmZaqzx1SsIO+YunbEVe+FBM8FlI6f9f83jzj6TjDbrUXdnS5Bvp0NpsdY6BpHOH7D5CVk1fFnLxef94THxp82uzzGc0rCX+Gi8FNqzszEgI5QbMgQeGMsdx+LmI3PaycoidXsMAJINI+Sjk3v90Pi+IOsiFppTsXvwlAQ0nraeI38zCQpvyBG+EMKiVxGC6dqnD3deP0eIOhhfMb0mezY9Qz3A8eKdWsctstnwnjRpKBvWMCGBUj3zMG99dnTxmf50slWBPUdBi1I8HX2dqQQ/YWY6YgF7EBqtryj8HSPEozYGjudfC1AMn0eAWthn3QvBdC5LGScuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZuBqZeg+HdXEGItHyGz1uFPn7TrPj+2nmm90OYVaN4=;
 b=OGIz3M82mdxmuVEYGS0LmgPYebYnEcXYyA8ZnQe6idYyuhcw1f6MDG6m/yIIgOu6a1MS1oiBQX+zlWLL2t+XGSjifvsbRE3MG3soRXs1igfvoM6XJckOYjvRHQpFNX6NUNxj266RTtQKRr0qrVRuLFdGGRPPkHcDrIYaqZZkooSx22v7F/QnY312GR+WYCFyzy9Cefd1A+b1+N9RzvDHW+xEJls20gEaZTvrP7w4pxeAL8JItZ1g/jeb2lPV9tdWfgY2iMQYFzhFy8ceMmmBfzataGqL0FNyejuTSwR+YmjkEb8Ff1VuF2mbr9gvmpROWGH7oaJ/G3pyEY/M4cw0Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZuBqZeg+HdXEGItHyGz1uFPn7TrPj+2nmm90OYVaN4=;
 b=HtC8Oi0/QLFhPDf6TAku+7HMIQXCqpJznGLerbZn7O+C9kJCk00dUevJxgsxPDMnGd+kQpTdDGIz3Z7jBvJobdQ5G/Q1ayuEpyDKhV55H9jVQf0kBJ4XVtBVmzs18Far1jT0EJKZ/okdpW8w2gn78GkqTiE5JNM+Ise+lIZdTog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DU0PR04MB9495.eurprd04.prod.outlook.com (2603:10a6:10:32f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 17:48:09 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%6]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 17:48:09 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 04 Jan 2024 18:48:04 +0100
Subject: [PATCH v5 03/10] dt-bindings: marvell: a38x: add kobol helios-4
 board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240104-support-clearfog-gtr-l8-sfp-v5-3-52be60fc54e3@solid-run.com>
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
X-MS-Office365-Filtering-Correlation-Id: fffaf30c-4ab9-4415-2de4-08dc0d4d4f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9FhI2OdmKBgvLZbUt3Rpty1matszhCJFDVsX/iwSQX6T6BotgC4qjiqsZXE31vm6VOmY9/vUZ+zaDM7OQoMq3G9Z8xB6HtxhRKKC4xA8s4XkPyDSs34JSiAQ+0OYbt+Ac21Aeh2BcR0pg4WX4jP17X4xZ5Idmwj0MzIbIIuKAq3dlAR9SILfhtD+lAmwRRgfFkAkf0cF2gJtnwo6GzU5SFbbO83Le+i47j4f0zhyCI1vxXEZ3PhWProG3Dv1vPaVAZD0ARyqbaRN9xJGDQavWV/9i7E0/OLCxul0wys6EWwBIP1NA00U4O0Yf0YH+26BwKBAozgnyAU3dklGBZ6TAEHt+ctDeav3xVRR/qXJLR98ub7F8xYi7LJ51vdaUpbPKJYLcdvLRMu+unr2wuh26OpEyWh02bYFDtEXyrTmReYgq39+vkgGBa81sbNhu99t4kDsrv39OeMPFR5dR/XbUwUfbxHfSOtt494jY4EBnqeVLsVTwPVTMBv9xgdSxFAO3vLZq4epdi1tBjn5BXdh7X8z7WIXWxnMaaS0MvjRQmvBIV9eeJ+MioJet10WM6wN4bM8slRON9pKovwMY5JThTyu2fDgc77nr/DJPnbWYOq03hM5UOjoCQEG2zj3aA5k
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39840400004)(366004)(346002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(2616005)(6486002)(52116002)(6506007)(2906002)(8936002)(41300700001)(4326008)(66556008)(6512007)(7416002)(66946007)(6666004)(478600001)(5660300002)(8676002)(316002)(66476007)(86362001)(107886003)(38350700005)(36756003)(110136005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZC83bDhxTjdWSUJmWTBQeVkrRVFycjZNc0ZGVW53MHFYcWJnU1lxSHRaV3ZJ?=
 =?utf-8?B?WUlvcDZ4bmt2QWFMbE1ZV1IzdG5waFZSOTl1a0ZKYWxyUlVGUGhYRkZLSlNq?=
 =?utf-8?B?dUZVN0toN1J4NDI0ZUdudzhCNDlNUU9BeGZsMVhvNmx0SzVnMnFUdmYvb1BP?=
 =?utf-8?B?N1JJWm1Nd2grWXEzWkZVbStwcHhsWlNKUDBjeEJDeDhhT3EwcG5CNTk4MDUx?=
 =?utf-8?B?NVRzb2VSNk04TnRsSXV1emFNbkdDU2FmSHdidDZ2eFV6My9ubmJVZ3BjZ3F4?=
 =?utf-8?B?U2JnZEJNeWVzNXBtNUZadEF3Qyt5NEpteEVUaFFsR0FlR1E0T25MZk0zKzdQ?=
 =?utf-8?B?ZTZWMTFtYXpkaXdjWFhxL3RwVks0cWVKaExud2VTWWs2a2hWSjg0cmpDclc1?=
 =?utf-8?B?SlNYUHBLZUxaWjhkekpPUWcwQitsWWFnQ0lqWm0vZ3E3WEpmWkIvaTByYVpW?=
 =?utf-8?B?d3cxbHM2eGMvTkxyMFZidW5jKzI3bmNiTVh0enpQbUdWWGh3VGxYVTZnV203?=
 =?utf-8?B?VGh4ZVk5OUdDNGtHMTB6QkZKRG9KdS9lajUzZUV5aWdhZ1ZPVjloOG9INUV3?=
 =?utf-8?B?SWRlaExlQ0s3UU5kUjRac1dZd2p1UTBHVlgzY0NHcHRicE82WTNpcVhRYmJm?=
 =?utf-8?B?Q2RLNGVHbTREalorRVB6emhYYVNmZEl0R1J5NFJ4L3JDazJNakd6TXFBR3lZ?=
 =?utf-8?B?SERkbUNhUWE3akVKajltZTV5TkpKbFJRWDY5QTRhbUV2eHp1aWJSV1IzaTZJ?=
 =?utf-8?B?b2hTbVlraDBiazJKY0o2UlRzSnJhZzB1MG9mZS9xOExLTjNJNUJxNUduYmdj?=
 =?utf-8?B?dnA4Q3h0SUVFKzRLVVQyczUzbWc1blozekhFRWZ6ZVBrQ2ExenB5eHZZNW5K?=
 =?utf-8?B?NlpDSmFQRE02eEQrT3dTV3pITWlMd1c4R3Z2MXFwTU9waWs0VXp1SUx0Qkt0?=
 =?utf-8?B?MElBdjdWc244S0kvaEJ6WXR4K1BIQVVBb05YS29qb1NjSHl0TkJTSk1FWk1T?=
 =?utf-8?B?NjcxOUQ3STlleEJJTmxNVEdUTk5zakNPZzBxZXVDd1dqL2JLd1JSaUx4RmlZ?=
 =?utf-8?B?UzlXcC9pOStHUmFoTUlremhGVnE5YXBqV3gvcFBtUTc3SjBkeHNoTEpBNUtG?=
 =?utf-8?B?ejBYVzFhbTVJYUdxQytBbWY4ZzNpNHNpOFBJbkVlblpFNCs1TENEeU83RGVX?=
 =?utf-8?B?a1dPVjZrbVRRcHJicVNiZlNsekhDYzBVQkc0NXhrQ1ZuaWlhZjFic2xpUytI?=
 =?utf-8?B?aHFtbXhlTThQU0xBMTdOZ3czRnhhMUxGeVpuV2RHaU9NK3kzK1UvMkV3UUNL?=
 =?utf-8?B?dkdwTUxvcWYzNFFNMkIyOW5WZDJ4ZkN6Q3g4NkpaQkRydFM3eDlJc2liaFR0?=
 =?utf-8?B?VjhxSlJ5NGc0bGI3WC9mQjJEOGtCWldCTnBxWlQzK3B6M0pOQmlNSDdiditq?=
 =?utf-8?B?U09kTStHQ3k0OWxldnBwYXRiZlNzNld0TDNkdlR2ZzhjTHUwUkxCVW1uSk40?=
 =?utf-8?B?ZXVqVHVCajg1OVg0QTVqeEVTRWVKME00dmtEeFhOd3RieUdGM2dzYytUejlO?=
 =?utf-8?B?dzFCTHNvRThybXVNSDBOVWh1RHZsQ1lUNHhrQmIyWW9KWnQrTFhLZFpFTnQ2?=
 =?utf-8?B?a2NVdy9LOGU3YU9GVGh1SnJESEd4NmhlanFvRkVRMTd0MUZiWEFOZDNEbkVX?=
 =?utf-8?B?QkRKWk0vOGZtdTk1RjBOL3daeXBuU2JVMFVRTjlmTGlXYmw3L1dCL0c1ajNG?=
 =?utf-8?B?Yjl1NWlvK0pMM1R5WGREOFo4enh5Q0YvVE1PRHFvaXdRcjBua25OQXU2SUd2?=
 =?utf-8?B?c2x5VEJUN2dwcUt6bnFOZDBRRUR6anhNaWc4VnpBTTZLWVNpTGZsYWVVNFlE?=
 =?utf-8?B?UURWUVRSd3pUbENPTzRkbWJhRmRvR2JJRHpzRmg3NEdiWlo2T2dqSElKZFYz?=
 =?utf-8?B?djFzbVc3UVI5U0hyUFdTWFlqa2RsQm5KTUM2T3MxN3IwMHpvNVdYc2prSllx?=
 =?utf-8?B?TmpHZnVJOTE0UFlZQmtYT3hycjFWc1J5UXh5QkFNWTN3WGtmNmJWZ2x1ZXly?=
 =?utf-8?B?QkJKd3MvRXJmUXNlZGxTTURRc1BRNS9VUUUzYTczZHMwTXliMzhIWjdrQTRq?=
 =?utf-8?Q?BPvZLbmENzTo8ER5fyjO1+cg9?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffaf30c-4ab9-4415-2de4-08dc0d4d4f6a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 17:48:07.6994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GsQZfdvvpcCNYlM9Zu7xuKhGQ8vKlEu4lcNBD/u00mmkMGyDHYhzNxjL4OynZYPr7I2kmnQOifVTwjnjoi3juw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9495

Add DT compatible for the helios-4 nas by Kobol, which is already used
in-tree.

This product shares a common system on module with the solidrun armada
388 clearfog boards, however it is not easily described in a single
list due to their extra "solidrun,clearfog-a1" compatible string.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
index f4e930d8cc26..cd5e5f88d8b5 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
@@ -30,6 +30,14 @@ properties:
           - const: marvell,armada385
           - const: marvell,armada380
 
+      - description:
+          Kobol Armada 388 based Helios-4 NAS.
+        items:
+          - const: kobol,helios4
+          - const: marvell,armada388
+          - const: marvell,armada385
+          - const: marvell,armada380
+
       - description:
           Marvell Armada 388 Development Boards.
         items:

-- 
2.35.3


