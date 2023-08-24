Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A19787018
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240929AbjHXNSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241006AbjHXNRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:17:52 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7925219A;
        Thu, 24 Aug 2023 06:17:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+Epv1woY8dhSXJ7cAsEm3KiCKFxhVrLsmE28Kxo/aMPkgnG93EsL7fubD8GnUkEeYEKiHBfTo/PzV6RMhrkd7PKwHySvhTzdIdU1I4Gdd4B9URfEKK+JVNm9nFlQJcUJkxQLfQ9foTAwlXWF+AboPgw4Xp0WnNGYEYHMJG1yonrKHYN4YeafhWuSacskVSM+gERTX45+Rd/liOZ31US2z/Qhf8IiTXya03ROllV11DD1TOffesg4u5q80OdY7UD6uhHTjIVMf8KaLXnsvgKJSHBHo9foBukR4B5XsYziZYDi4ohhrPXYXKOL8g1+Ru5NpklHdQ+TtV1MP2mywWMvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6/kFKI0NorhWh1j4OXQ2/MPC4YGBNjdWP527DLbt6s=;
 b=hEXNmCFRrpOM5QX+EEGshe5kG2Z8zHyesiVaRzogXYZEIZbc0Vvw5U187sESo4XjS7fCqhatBAPkqVPBVZBsd5FIupgiZBcGS03i9+yCwrCoB+jllFPB72qDItuKWYNi16faC8GopK9LsvK+fsv8Q5Gn7+Ohk8VdbTVoshRoCmGhqmQRAc5A9j/9Lk7xPjE7wwtISnSUmhdUVEuFbECTa/yhOfNCFA7SRHMF0IdgjGK6x4wHbg327PsFi442SgbnZovKC1wM7x0k3yMxIfxvWhK9SeqWvTjTDOAa4FClckq0fLAKDEGfTPYlvtVGn9ULpXBcFQct8MwKxNOK34ntwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6/kFKI0NorhWh1j4OXQ2/MPC4YGBNjdWP527DLbt6s=;
 b=X5XoVpZapGzpmpIBxk7bbh8//FuwfVQoMs9g02/4ZdCThOVeMkK75AflRisaAJE76AwggXDF4G+bWlFqR9Ptvd0y6QpQtT3HJNkg7n0c9Mk8K1Ui0+JQchwsVG8mMa2BrmREkXyqun60JJ0lfpLV297aKdISuOu5rb1bx9oZRIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from AM6PR08MB4966.eurprd08.prod.outlook.com (2603:10a6:20b:d4::23)
 by AM7PR08MB5397.eurprd08.prod.outlook.com (2603:10a6:20b:dd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Thu, 24 Aug
 2023 13:17:46 +0000
Received: from AM6PR08MB4966.eurprd08.prod.outlook.com
 ([fe80::f7b3:4adb:c638:d8c7]) by AM6PR08MB4966.eurprd08.prod.outlook.com
 ([fe80::f7b3:4adb:c638:d8c7%6]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 13:17:46 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Thu, 24 Aug 2023 15:17:10 +0200
Subject: [PATCH v4 2/4] dt-bindings: touchscreen: add overlay-touchscreen
 and overlay-buttons properties
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230510-feature-ts_virtobj_patch-v4-2-5c6c0fc1eed6@wolfvision.net>
References: <20230510-feature-ts_virtobj_patch-v4-0-5c6c0fc1eed6@wolfvision.net>
In-Reply-To: <20230510-feature-ts_virtobj_patch-v4-0-5c6c0fc1eed6@wolfvision.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692883063; l=8400;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=ZWJjL37dWNM/Rum/o4XxZV7Z+HY/odWYwXzuhSOL4eo=;
 b=FdJeaG3FsJ5N6GkYznUooDYeMHIfjoO7hygJLRjqPQ9APVxnedwC608GgM2bQ4nzvRWTL0NxF
 UPi6H+M3S4/AACRupRpOYDrBO9TIgwOxdv5+YH3j9ncBxe0l2tpvVga
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR07CA0301.eurprd07.prod.outlook.com
 (2603:10a6:800:130::29) To AM6PR08MB4966.eurprd08.prod.outlook.com
 (2603:10a6:20b:d4::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4966:EE_|AM7PR08MB5397:EE_
X-MS-Office365-Filtering-Correlation-Id: 5891f476-724f-475a-24c1-08dba4a4818d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hwU3PXnYCJbP2ItNJdMtbUCVmRY89vQSXU5MuALDXnSeJvxkWp5OXTUodQgyHV9w+lBByNh0izo3bimv0HGVfOdBtCRbMc7gvISaUHkdT00hQ9pyUW5311A0+FbQDyUGlpNxR5g2sTar3xUtuf84GbdaaItkvAap1c/v+s9zrE61RoB+qewJTJDCB8K2d+698996RSf5nuSev8UQ1WCn5JOiMPNO7Ah2/xGxLrKul7o9Xp1TC7zfV6N69qroiqolKGTv7vduoW6yOvaHPvW26q61RcDfsU9Fvv01vOUvEXGIwbaprDkVEKBHXl8MOExAKzY5d35efZiYvwCSwDCQcqu0+d/BmvMJSjot3Dlz4mAFcMuhSXv1Bk+MDBx4NH6lmMTpQas81Vblzro64CJY1VBGcBv9BOYk3CWkqVgp0oTA22qUjtCbxS6IQSt6zIiP+t1JNzqlGdl/rUEjCgF8hlZJylZkVlJjbr1SMWefC5Zlpv/YiCBHwc1pSEFN6NZyXPfW25FKNfc3JLfcbWa+z7JKVeSKopn0gwr3MKb8gBV4uwUzXDmCCX/2ACM0Fez/RR2YaKkYH7fJ32v61yiOLS4CWYP9GbJheDwCekMCFSCcNbAxj0CMgYyumjUa1Lhf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4966.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39840400004)(366004)(376002)(136003)(396003)(451199024)(1800799009)(186009)(2906002)(38350700002)(52116002)(6506007)(6486002)(5660300002)(44832011)(26005)(86362001)(38100700002)(8676002)(107886003)(8936002)(4326008)(2616005)(66946007)(6512007)(66556008)(316002)(66476007)(110136005)(6636002)(478600001)(6666004)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VER4RnFRZmxNMENDczRJem1FNXNvUE1rbCtiL0huTFlLQnVVVm9XU3J2Y3BQ?=
 =?utf-8?B?QlAvZ0t3OTdjSEtoMzFPbWtoeVQxSys3RFJ4aG9vL3NZd2E3RCtCYW14YWRo?=
 =?utf-8?B?MElIekNVU01wU01lK3JkS3lVNVNTWmJhQkZzU1VUQ05mSUhpemhVMTdINlBj?=
 =?utf-8?B?Z09POEsva0hQajgzN1g1UHFEUXkrR0E2NWViVDIvUzN3QUpGbklnNFdNU1l1?=
 =?utf-8?B?KzBpaGs2OWxPUXdUU0R6aHY1alFrb29wTGp1Uk9BeEs3UnNrSTNjOWpuMmZK?=
 =?utf-8?B?S0NISVBMTk9yUkNaT243UTE2YlIxUUVWN0lEMFR1YTdYYmhSQXBxd3NYcmRK?=
 =?utf-8?B?d3VSQS9jNUpma0MvOXZGQkVRUXNocTlwYkhNQzRaQ1YwWHRoK2pNRU1sd1l3?=
 =?utf-8?B?MUhqV0paaXVub1JSOU5NNUVpcXRndlBRRVF2NzE0VWJXN0pZZmFadWkvR200?=
 =?utf-8?B?OEh0U2lBOC9UbXFxenNVUHl2QmR6aG53NWdrelJoNUNmc3dpWG13ME0zSzBR?=
 =?utf-8?B?KzhTampLeXFXWlFBeUFrckkzak5kVHhJcTFuNmtqcE9jVG02OU93NWVuclgx?=
 =?utf-8?B?dS9KZStHY3BZRW93N0JjdWtOdCtsRlY0VHdBN0RobUl6U3BYSTZ4akpNWjZT?=
 =?utf-8?B?aFNHVmZiRXF3ekV2WXZBK09ySkRsdWRkQ1c3MjZOU3lGWlVWQzdzS1doUDRi?=
 =?utf-8?B?cno2eHJEYmZzRnFFTHFzNUs5ajdOMTdEVWI0MjZhTHZMN1NEYTRpSndwL0Jx?=
 =?utf-8?B?N0NyWDd1eEIyZm1jK0hHbmpObkxJTmtIRmRGMFNVUTluYkhkRjh1b0Z0ckxx?=
 =?utf-8?B?TWRjbkN2QTVyZTV5NEhnTmhEQzBOcW1sUGRRWG1wUXhyNHhKWkFyRUxoY0F4?=
 =?utf-8?B?VVF0UXRFbHpKVXFKYmhEdVFDWnd5aHdybWlaclNRejhGS3VWRWhlS21EUEYx?=
 =?utf-8?B?RTNtVVNOa09GOThGandINmV6MjNtQWp6aGViUHVzSTNxbHVBcEJwekFtTlZi?=
 =?utf-8?B?MUJOSlZYc29ZZ2FJSnBJSHZtREVwN2ZubjExRVVvTVNCM3Z1QVdxSjByMndx?=
 =?utf-8?B?WXFYRTZqVnZzOFVoTVFXcGFkMmY4K0kyaFVBTnUyOTBPV253SWREWHpSM1hU?=
 =?utf-8?B?VVE1SEV2bGovdmpRanhTSG8zemNLY2hZWUE4UTRvbVdPdnh5YkVyeTVZK3Js?=
 =?utf-8?B?SkQxUldkc2JNdHkwWkFRVEZ4RzZtd3JiKzdIT0RVbFNaaHJQbFF1aWVFYndR?=
 =?utf-8?B?bXc2cXlQVVN6OGZWTExqQVNwa29WZ1ZLYXZxaWd6QzRqdHpGTTlzVis2WE5u?=
 =?utf-8?B?YWtsVExXYjFQdjY4WitXUFpnT0VJbGx5Yit6UnV3ak1NTVhkOTV3NDd6RlhB?=
 =?utf-8?B?MHpaZlk3NG53Si9jZ0JZdXo2UWljbW8rMjNpZEpNQ2NsRzJ4Z1lWN0NGVUJn?=
 =?utf-8?B?dzhJQzkyRWZPMUtSN25wV1lKTlpWQUM4ZzBvNDd2ZU5HZzFhWkNuMk9IbmFs?=
 =?utf-8?B?ZkYwTVVoVVhSMUJkQUZnRFJuaG1GdWovYnNINndGdnVmSHFWajhqcHZhc0ta?=
 =?utf-8?B?RUpsbFNuZjQ2KzUyMFppczFCZnEvUmE0aXhPK2ZqYkNiWjlJVDUrUUgzWHBX?=
 =?utf-8?B?TjlycUJPcGY2R1NnbHNicThkVDNXU3NMVEVIbmQ2VmpPVkRhTFZtSmdCTzZM?=
 =?utf-8?B?UlNaYXJ1ZUVhV3Mxa3pEQjkrOHdQT1JleVUrSmljNDIxOWZXN0ZBMUxVQmNw?=
 =?utf-8?B?VnBmcE9CTEtlOXZqQU50OVpEc09zRUtQSmY1WE5mdUJPQytONE4yK2l0bjR1?=
 =?utf-8?B?ODZoL3NIRHc3TEZTTnI2dWNrdURWdmZPS0xURjJpMkMxZ3I5bXBOVldwai9j?=
 =?utf-8?B?amM3RHA5ZmlhanR1MlBraUFQSnZ5Y2UzSEQ1SGhzNEhONVJId2ZhdXZzNlFC?=
 =?utf-8?B?YXM0bXprNHhHNHZLQzNPRnJjeFhRR203K1pEOGp6dzFkUElVMlp1OUZ3VmZ1?=
 =?utf-8?B?MFZ0bnVwRmpVb1k5eVltM2ZQN05xZzdqMERLTjg2QTRyT2l3REhhNEViS1pi?=
 =?utf-8?B?QS9JaGtZSmZPWFVPaDdMbjhCam1scWwwa2dYRkEzcmoydC9DTGREd1E0QXJ1?=
 =?utf-8?B?Q3BDRFAvRXJQS1MxcmtuSjFTTEg1NGdWaEl2MnJTTHZuSlZWYUtqNjVuWDhJ?=
 =?utf-8?Q?7iJTtPDRuwGSMCr0z1WOons=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5891f476-724f-475a-24c1-08dba4a4818d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4966.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 13:17:45.9714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X75KWb3QzM1nwAH6vHJzbvp4w/DqaKGLn8pTbGnr/gV3R4w47P9BlsyJsSx2hN/rc55UdqQ5pcbf7CUUXpB9qKNQkyITlkkwreX9RnWVfgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5397
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The overlay-touchscreen object defines an area within the touchscreen
where touch events are reported and their coordinates get converted to
the overlay origin. This object avoids getting events from areas that
are physically hidden by overlay frames.

For touchscreens where overlay buttons on the touchscreen surface are
provided, the overlay-buttons object contains a node for every button
and the key event that should be reported when pressed.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 .../bindings/input/touchscreen/touchscreen.yaml    | 152 +++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
index 895592da9626..d90cbb4932b5 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
@@ -80,6 +80,158 @@ properties:
   touchscreen-y-plate-ohms:
     description: Resistance of the Y-plate in Ohms
 
+  overlay-touchscreen:
+    description: Clipped touchscreen area
+
+      This object can be used to describe a frame that restricts the area
+      within touch events are reported, ignoring the events that occur outside
+      this area. This is of special interest if the touchscreen is shipped
+      with a physical overlay on top of it with a frame that hides some part
+      of the original touchscreen area.
+
+      The x-origin and y-origin properties of this object define the offset of
+      a new origin from where the touchscreen events are referenced.
+      This offset is applied to the events accordingly. The x-size and y-size
+      properties define the size of the overlay-touchscreen (effective area).
+
+      The following example shows the new touchscreen area and the new origin
+      (0',0') for the touch events generated by the device.
+
+                   Touchscreen (full area)
+         ┌────────────────────────────────────────┐
+         │    ┌───────────────────────────────┐   │
+         │    │                               │   │
+         │    ├ y-size                        │   │
+         │    │                               │   │
+         │    │      overlay-touchscreen      │   │
+         │    │                               │   │
+         │    │                               │   │
+         │    │            x-size             │   │
+         │   ┌└──────────────┴────────────────┘   │
+         │(0',0')                                 │
+        ┌└────────────────────────────────────────┘
+      (0,0)
+
+     where (0',0') = (0+x-origin,0+y-origin)
+
+    type: object
+
+    properties:
+      x-origin:
+        description: horizontal origin of the clipped area
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      y-origin:
+        description: vertical origin of the clipped area
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      x-size:
+        description: horizontal resolution of the clipped area
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      y-size:
+        description: vertical resolution of the clipped area
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+        required:
+          - x-origin
+          - y-origin
+          - x-size
+          - y-size
+
+  overlay-buttons:
+    description: list of nodes defining the buttons on the touchscreen
+
+      This object can be used to describe buttons on the touchscreen area,
+      reporting the touch events on their surface as key events instead of
+      the original touch events.
+
+      This is of special interest if the touchscreen is shipped with a
+      physical overlay on top of it where a number of buttons with some
+      predefined functionality are printed. In that case a specific behavior
+      is expected from those buttons instead of raw touch events.
+
+      The overlay-buttons properties define a per-button area as well as an
+      origin relative to the real touchscreen origin. Touch events within the
+      button area are reported as the key event defined in the linux,code
+      property. Given that the key events do not provide coordinates, the
+      button origin is only used to place the button area on the touchscreen
+      surface. Any event outside the overlay-buttons object is reported as a
+      touch event with no coordinate transformation.
+
+      The following example shows a touchscreen with a single button on it
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
+      The overlay-buttons object can  be combined with the overlay-touchscreen
+      object as shown in the following example. In that case only the events
+      within the overlay-touchscreen object are reported as touch events.
+
+                  Touchscreen (full area)
+        ┌─────────┬──────────────────────────────┐
+        │         │                              │
+        │         │    ┌───────────────────────┐ │
+        │ button 0│    │                       │ │
+        │KEY_POWER│    │                       │ │
+        │         │    │                       │ │
+        ├─────────┤    │  overlay-touchscreen  │ │
+        │         │    │                       │ │
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
+      '^button-':
+        type: object
+        description:
+          Each button (key) is represented as a sub-node.
+
+        properties:
+          label:
+            $ref: /schemas/types.yaml#/definitions/string
+            description: descriptive name of the button
+
+          linux,code: true
+
+          x-origin:
+            description: horizontal origin of the button area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          y-origin:
+            description: vertical origin of the button area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          x-size:
+            description: horizontal resolution of the button area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          y-size:
+            description: vertical resolution of the button area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+        required:
+          - linux,code
+          - x-origin
+          - y-origin
+          - x-size
+          - y-size
+
 dependencies:
   touchscreen-size-x: [ touchscreen-size-y ]
   touchscreen-size-y: [ touchscreen-size-x ]

-- 
2.39.2

