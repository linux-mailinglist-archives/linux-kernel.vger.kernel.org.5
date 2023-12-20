Return-Path: <linux-kernel+bounces-6586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F20819AAA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60905288D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A021D52B;
	Wed, 20 Dec 2023 08:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="uXIUui8U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2082.outbound.protection.outlook.com [40.107.6.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A43C1C686;
	Wed, 20 Dec 2023 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlyMsD+C1PmuVNRZ/iXIVi9NeTJNcujl0RQqSxMZFU6wItPrfjZN6ECi5IOoJs9kT5o7S7N3jdUnRfFUHdgjegD4x1Mr02ADuPgit6fiODKVc2viOWbMcLODaRRve6u4t3KHTw88eKxRDcHa+zLpEYB58Q8VrUSsDfFTEMFwkB50J7ulqst3iF7nLS7IKSQ8uZpvi6iqHFLLS7o0gQhcnxr5jZNdZI6y+hpn6rhM2o0nxjfSbg02k9npnjRxhpjtx0T6TFd9GmszHFuJm1CHrol9qTiNbNeCttvESj4XZHy1YGdnbQa/GYS0M7I3oSlHwpZl0gR19V3QrJBBS+NWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNBswOFiXlpG2TbfJ2Ft81QtpZkhZ31M20XAdc8Qde8=;
 b=NxmlFyTajD3q7IjBowTb/w9Or25krQnuIgiJMETdGs7N+XIOF0+Cp+sdexSjjNcE3XrFYGXVZLRTz0spG9IFadsorZ0zmmLFA2ST1JrOi5z4wkRx6Oxj54E4fRvlaez9SOFjJcj2jCkJX6aB0p5JRPz6pGqFbWu2SmxweIE1sifcKMo+yDjOUJqga5uiIP+WZU+WhEUiqN9JOokGbli+cKlVHOH9HA/JD89fyyVK4AVBSF1TwPfRR3w1BpHYreIrXRBDVArlo6ko8NMuBLyXX5cJKmCR+m41ofGf80ENiHhSro/zQZQV8b03BRGAkHWBN33JT9GDfDc/LrOkJOKhRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNBswOFiXlpG2TbfJ2Ft81QtpZkhZ31M20XAdc8Qde8=;
 b=uXIUui8UF8/0Ie7jFu/rpR0eCQ82ggqk+tbI9X3bXvTgscjmlpcIS9zIWxq2HSXcWnSgezKpGHG45T3nNX3brnDjO5+dnXqLJOw67j3rYeRG1O8Ydg1jtIzL+8gTw4Lo1wlvY8SBCtdvaoNQ4l4MYO7w0rJnraqaZGaGvHNx1Xg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PA4PR08MB6080.eurprd08.prod.outlook.com (2603:10a6:102:ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 08:39:50 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 08:39:50 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Wed, 20 Dec 2023 09:39:43 +0100
Subject: [PATCH v6 1/4] dt-bindings: touchscreen: add touch-overlay
 property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230510-feature-ts_virtobj_patch-v6-1-d8a605975153@wolfvision.net>
References: <20230510-feature-ts_virtobj_patch-v6-0-d8a605975153@wolfvision.net>
In-Reply-To: <20230510-feature-ts_virtobj_patch-v6-0-d8a605975153@wolfvision.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
 Bastian Hecht <hechtb@gmail.com>, 
 Michael Riesch <michael.riesch@wolfvision.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703061588; l=7052;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=4T+y9c3JEc7F8j2inr9jIbj9OPr2/Ay085PHsKa7Kb0=;
 b=2KbDQvI5CQBqUY4sULSKuvQ9QltglZfZJ3899y8guJB5x9Ml5uG422mPZoGGWEARpx3SqIXA0
 7Idn9/8tKR7Bi1jKHXmfgDGeqBcSra8oWkpvTJOFufttUHwS4G5ITAT
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR0502CA0028.eurprd05.prod.outlook.com
 (2603:10a6:803:1::41) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PA4PR08MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: 08daf1d0-0e49-4648-8c07-08dc01373ac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Cki6PSJue6tHK9q90+pPaUMgK2vXdN8A7pYxDbF4UqN6TwWJhwRDfinyu1jT+nVUQxmN7+Em6WiUJTfHhY7pyQxLqZF1kVHAXFwPm3kXHplCVy0j4T0Fpo2WZO2/z7cbOkUPQLohw06d0HDiSWzBwUUJiQUda4UJQPt6XNKvdQBbMkGEEK3+T+FedXkWqDVw7CXKhMZU7RgeBWnDEToD4tGhOi0fdv9CTyXUYCV/0QXmDStPIUaUPXTK/ubDfghhd4To/GYn7f6yAF4+mkQkTiLs/n1IrCx93101t6SgSHqMU0OqWpG6Pb/bKB5G0T2gHbI7tsAWMnBW7slP1WOwLqKjPscNEjJbiXbBHfw4d8OU5zOyKTyFP7/exxH1DJwEcuYAPn4jXzKx+LjDgEQqvsM1cHBLxxKiMPfQIf96Q7A316h9BeCe2oE0m7jwUHTAhqLegkGzbTx+QRhULVFc08Ss8IybxdbvNvEIP+O5Dda/2jBPfegLuBdmz2b0gdLbC9U+tLwApuBM9xCVWU8y4rPW7LahKvrNYn66T7n7oDnv5GlzAX3Juwvc3S/XXmFjoYcaeV/aBipTKmaVXEad1m/4mDj+zt2GstUWB3N4OL5JfHcrhEQ5Q5hndhCPTUo7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(346002)(396003)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2616005)(86362001)(6666004)(6506007)(6512007)(52116002)(478600001)(26005)(107886003)(6636002)(316002)(66946007)(66556008)(66476007)(44832011)(6486002)(110136005)(38100700002)(36756003)(2906002)(4326008)(5660300002)(8936002)(8676002)(38350700005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3p6M0pCWGNoZkx3Y09jM3h3dzgyZHVBeFAzN0N6WGhFSkdVS3NseFZCdzZZ?=
 =?utf-8?B?Qis5ZFo4eVlUM1J2RUxKQzZzNzdXSlJzR2xQM2VwbXdEN3NzL1pvK3B0Y0J6?=
 =?utf-8?B?bU9kUnVhc0p0N1ZxQTlDV3JHQWIwbXhsbDJSdVBZZWs2WnY4R1MrUWtPZk5L?=
 =?utf-8?B?RGxKK3o0c05oSy9KeEhZcExGVjFSV003U0M1NXZCNEsyNUJBcjRXODdDRXhN?=
 =?utf-8?B?b3ExQldJam41ZmZ2YUdLcmZ4THhMSzZZQTcyWWx4UFRZMmlvenZoT3RIL3FB?=
 =?utf-8?B?QXIzdUZYaWtLekx3WnJCSUtIYUNMQ0cvY1AzNDhSdTA1cGZXRWduQnlndXFQ?=
 =?utf-8?B?NW1UT3Q4RnVwdjZuK1VDZFpsN1QxK1hLUXZSQk1aY3Jwajg0VFRaTkIyZE5K?=
 =?utf-8?B?dnJ2cFJUeXJYRW5oTkRsdVBjYXhnREhWcC9qUUVwT01LSS9HZkg1Qk9zT2No?=
 =?utf-8?B?VmRjRVJGNjNVMzNTRGMxYUlMYU53ODF0SmpySzBvaEo3RklvOStHdmZXcGhR?=
 =?utf-8?B?RERuYmxXRWpBVFNKTkExbDFXSFpTYkxZdURLNjM4NmNielI3UGNNcjNqazMy?=
 =?utf-8?B?S3ZIYjIyZCs5R0FjZUJ1RURKb2YrU3FuZ1BOVkErWG5qQjYvcUdQZG5pNUZt?=
 =?utf-8?B?MUZEUnBNUXBFUCtNRUFIQThJMkh3dysxZkhyc3hsaDZyczhReGZ0RXBDVEx3?=
 =?utf-8?B?OHE0ck9qRlIyTGtaNmVYSHEweVBjVTF0SmtFdmI2NUEyMW1lN0ZaYUtDZkd6?=
 =?utf-8?B?SEhELzRjS3lLSmFaVWdraWQzV3p1bE1mNStGdytHdSs4R3V1QzMxVVhxa2tU?=
 =?utf-8?B?ellmQVdWTy9meEFCRUw3bkhKWUxrMVN2SENkY0dMRTZNRUd5d2o5MzM5YWJH?=
 =?utf-8?B?cGVnM1JrcnB5YkUvYVZURTdlR3dWNmU1Mk8rdVdFeC9MeVN5ZUhPdER3Nlpa?=
 =?utf-8?B?N0lzMzNqN2pmSzdXVUh0a1VncTQ0U1JwUGd6cmVXaDBCby9ZZmJLemhqRG1L?=
 =?utf-8?B?UFJ1SllkeW0xSkhEeEg4d2EvWUdkZzlIc1l4SWVEOURQM3NNenpjWmFBaDJT?=
 =?utf-8?B?TTA2dVY2bmpBSys5WnFwWnBhOEZoYkxLdXNhalZSbHVEQjkreFgxcXZKaDhx?=
 =?utf-8?B?TU1teTQyOWFzMi9LZGptbTdCdTlZdVllbXRUUUpJSDluaGxvLzliMjMzWmVG?=
 =?utf-8?B?bUFxYllvKzJBUE5jbGEyNDZWWnNUZG52cENaV0c0TXdoSjBFRkhaRnQvY3Zz?=
 =?utf-8?B?Zm95YUd1ZHRyWUdONGhvOWc4NXMvdXdKR0ZaQU9qZncrdUpRa1lzRjFETFpR?=
 =?utf-8?B?RlQyWVFDVUZzUnNPQVFTRVM0cEFZSGhXV3M5MnJzRmhkSDRWcWFnL3ZWMkx3?=
 =?utf-8?B?eHdVN0VPbW1NZlBHM0N4RWlReFVtSHl1TWRiMTUrakZHVWhHREhBdDEvOStw?=
 =?utf-8?B?QXVrd05HS05UdEUvMkRGc0FuQThabTFyTDdzU2JoajF4K3dndXlZdHp6VlhL?=
 =?utf-8?B?Q3JsMko1WUlReUxLUWQveWYyUVRaMldTeXhnejl2cFhIdExWeTBnMHpEVkpM?=
 =?utf-8?B?L1FBVnBzUGJLcmViOVAySjRZUGVkUnExWFY3MUs5aXhqM1cwSnNUcVNzbllK?=
 =?utf-8?B?dGtMSkE4S1BQWEx0emgrWEJwWC9xSHNlb25zMTYxOU9ab3dBeVRFUVJlRW1R?=
 =?utf-8?B?NTBsTmJwOS9TRVJnYUtaNmJaQm12eHF0emR0a1F1dXJSNGYzUEluRmtxK1JQ?=
 =?utf-8?B?azdyMXQwOUdxakdKa3J2RGF2T3B2dElEZENqaWNwZlYwOGorbHhERlczQUQz?=
 =?utf-8?B?Wkg5RWxFQWdONk40bzBaamlHVC9RdkVjL0JJUDZ6a010NlFrdUpYZUNxTDg0?=
 =?utf-8?B?S3orbXg5aUJ2czRoZWRDeHU5VEswdG5QVHV0b3ZvVDV0UktHaEdqaU9Ga29H?=
 =?utf-8?B?bUZLVXB4M01ZVC9YV0VrSjN0dm8vdDlGcmhuaFJQcnVFTVFLcHJ4TVA4WTRz?=
 =?utf-8?B?ekNMQmJnajM1enFqakR1djlkcmJkZHg2WDZONHptV0xBRThvbEVXcUNpdmZK?=
 =?utf-8?B?MmExdGh5eHorSUUvL1pvVmI1ckhSTDdNT1pHdFUvMFNiemVJWituTlBnZENv?=
 =?utf-8?B?dUo4d2RSdzhVVUY5WE1sWHBsRllPSWpUbGE5cnoxYWRhbU9wbVFweE5JazhQ?=
 =?utf-8?Q?ZQtbp43CSTeQdYPFY880Jm8=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 08daf1d0-0e49-4648-8c07-08dc01373ac4
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 08:39:50.1877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqC+aiWp8HWvGTYOy1tu6fhmKJCWE3jSvJMKpwgwI9ero6Ht1J0V5URPWm+qFUwRJBXip9ObGrkeW4qFh83mhErhYQFzV8i5CqPH1w+SQOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6080

The touch-overlay encompasses a number of touch areas that define a
clipped touchscreen area and/or buttons with a specific functionality.

A clipped touchscreen area avoids getting events from regions that are
physically hidden by overlay frames.

For touchscreens with printed overlay buttons, sub-nodes with a suitable
key code can be defined to report key events instead of the original
touch events.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 .../bindings/input/touchscreen/touchscreen.yaml    | 119 +++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
index 431c13335c40..d5ac90667bef 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
@@ -87,6 +87,125 @@ properties:
   touchscreen-y-plate-ohms:
     description: Resistance of the Y-plate in Ohms
 
+  touch-overlay:
+    description: list of nodes defining segments (touch areas) on the
+      touchscreen.
+
+      This object can be used to describe a series of segments to
+      restrict the region within touch events are reported or buttons
+      with a specific functionality.
+
+      This is of special interest if the touchscreen is shipped with a physical
+      overlay on top of it with a frame that hides some part of the original
+      touchscreen area. Printed buttons on that overlay are also a typical
+      use case.
+
+      A new touchscreen area is defined as a sub-node without a key code. If a
+      key code is defined in the sub-node, it will be interpreted as a button.
+
+      The x-origin and y-origin properties of a touchscreen area define the
+      offset of a new origin from where the touchscreen events are referenced.
+      This offset is applied to the events accordingly. The x-size and y-size
+      properties define the size of the touchscreen effective area.
+
+      The following example shows a new touchscreen area with the new origin
+      (0',0') for the touch events generated by the device.
+
+                   Touchscreen (full area)
+         ┌────────────────────────────────────────┐
+         │    ┌───────────────────────────────┐   │
+         │    │                               │   │
+         │    ├ y-size                        │   │
+         │    │                               │   │
+         │    │       touchscreen area        │   │
+         │    │         (no key code)         │   │
+         │    │                               │   │
+         │    │            x-size             │   │
+         │   ┌└──────────────┴────────────────┘   │
+         │(0',0')                                 │
+        ┌└────────────────────────────────────────┘
+      (0,0)
+
+     where (0',0') = (0+x-origin,0+y-origin)
+
+      Sub-nodes with key codes report the touch events on their surface as key
+      events instead.
+
+      The following example shows a touchscreen with a single button on it.
+
+              Touchscreen (full area)
+        ┌───────────────────────────────────┐
+        │                                   │
+        │                                   │
+        │   ┌─────────┐                     │
+        │   │button 0 │                     │
+        │   │KEY_POWER│                     │
+        │   └─────────┘                     │
+        │                                   │
+        │                                   │
+       ┌└───────────────────────────────────┘
+     (0,0)
+
+      Segments defining buttons and clipped toushcreen areas can be combined
+      as shown in the following example.
+      In that case only the events within the touchscreen area are reported
+      as touch events. Events within the button areas report their associated
+      key code. Any events outside the defined areas are ignored.
+
+                  Touchscreen (full area)
+        ┌─────────┬──────────────────────────────┐
+        │         │                              │
+        │         │    ┌───────────────────────┐ │
+        │ button 0│    │                       │ │
+        │KEY_POWER│    │                       │ │
+        │         │    │                       │ │
+        ├─────────┤    │   touchscreen area    │ │
+        │         │    │     (no key code)     │ │
+        │         │    │                       │ │
+        │ button 1│    │                       │ │
+        │ KEY_INFO│   ┌└───────────────────────┘ │
+        │         │(0',0')                       │
+       ┌└─────────┴──────────────────────────────┘
+     (0,0)
+
+    type: object
+
+    patternProperties:
+      '^segment-':
+        type: object
+        description:
+          Each segment is represented as a sub-node.
+        properties:
+          x-origin:
+            description: horizontal origin of the node area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          y-origin:
+            description: vertical origin of the node area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          x-size:
+            description: horizontal resolution of the node area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          y-size:
+            description: vertical resolution of the node area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          label:
+            $ref: /schemas/types.yaml#/definitions/string
+            description: descriptive name of the button
+
+          linux,code: true
+
+        required:
+          - x-origin
+          - y-origin
+          - x-size
+          - y-size
+
+        unevaluatedProperties: false
+
 dependencies:
   touchscreen-size-x: [ touchscreen-size-y ]
   touchscreen-size-y: [ touchscreen-size-x ]

-- 
2.39.2


