Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC317CC158
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343764AbjJQLA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjJQLAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:00:22 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2047.outbound.protection.outlook.com [40.107.249.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5986B0;
        Tue, 17 Oct 2023 04:00:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWmMSVixzF/PIR+tC6JHTsenD9P88P5os/AY41O12ayCN3Blu/EOn1FVsr+HhpwkAo9JaUG+gqItRwcxHu19WmFsU9SX5hqaACr3PcPclreIFUVvIN+1SazdPKaoQVQkey/9ajwTEonZz7ZQFoc68uxRVdhCODx86NWtg5IibO77CdcSDRhBgV6eCVnXGkisPkLeGe0eWOqRy9awtjHYF/jbfv5twa/3CUPEn/LUyYtyoh+6VhNLD93075I7KC1Jre+UX+DYHKUJYwIlM1DVbg+iD1vXBIy4asewZugbyWA2hBdNqH5QMeH/I35r1WEHj1c2GLA7DeuDrlbO6zoREg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2PhTsUJcMQ4SW1OvpZNerNhpFQAX2maswC0f+vfs70=;
 b=cKBZ91FIEF0bChbpdwrIiTA+rxIGHVTz3IRkpS82ZweVm6vNL4A311zVFBi6z/YQIvz2GCvQLUKrR32NXO4MpY4TOcuHG2q5Zi1BvOz0IPNMjmWO4ybPdVOMoiMFrllDxWbB2sDkg2pUJdr4sqzNIGHQmeLf1DvgV8PW3VQ1TCaNBnHNGJEoHYKzYSCtEQpaojcDU/KULPMuU+f42yxGdiIo19XNX1mnUK5/oUsChneffMxmGXGpW3LPC5MMPaiHilGl5xCh4ceBg5vWyX8qat5bpnH8QT9vbEclFJBUQV+VE7+JYaZkhz4Lw9BVyO59ACjiEyghRXnAd+Cl4Z1FWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2PhTsUJcMQ4SW1OvpZNerNhpFQAX2maswC0f+vfs70=;
 b=1vComKO4VFSPizXJeM3owWTxtyT+y/5eTj0xYPQ0emlhBG9ZA0tKahN+D/INpShv6syk2HcJNdoqntW6n5zWfxBrXsqiQtazuVBhKeGxXVo6YVkoICPTN/DyEq4tHdEfqwPH3ymj5f731ebnZnIUnRuxF+usode5teDJfgZSOUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB6295.eurprd08.prod.outlook.com (2603:10a6:20b:295::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 11:00:15 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 11:00:15 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Tue, 17 Oct 2023 13:00:08 +0200
Subject: [PATCH v5 2/4] dt-bindings: touchscreen: add overlay-touchscreen
 and overlay-buttons properties
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230510-feature-ts_virtobj_patch-v5-2-ff6b5c4db693@wolfvision.net>
References: <20230510-feature-ts_virtobj_patch-v5-0-ff6b5c4db693@wolfvision.net>
In-Reply-To: <20230510-feature-ts_virtobj_patch-v5-0-ff6b5c4db693@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697540413; l=8076;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=wU9mLFkAGHcvGbxx9FJKDONfjfWjyoVrkM1llQopSTA=;
 b=XLIuisbolFeig/Z3ayKvnMqCF4whG3kIp9PhOPP9aY9r/G3u7sNSg5rUUSnyIOJXPEb1bWunM
 CZSxQ/s9Jm0DHjoSEwuA7wCAD/V5FTX7vqM8eOFcgBlF2ECszSHL0gC
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR07CA0250.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::17) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 6075dda0-d713-4eb3-df1d-08dbcf003e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f9arAlYJR5derrwSuzQAjKxdKsntFwhMekMcG+y78MaXQmpGlU3oFhwjHCQ1pIctcUN3JMI56pl15nuBVQ2m+igStkQ6G18xI060b70pIAz2xr+9bXG7EUj1tCIA/KWWrFMkl+MOK2gVh+GJCO6x75U+qD8nRBD2AV9aDZZETjRexl8syum/73EZ5WGO+u6npV4TCNc/AwpZX5vgNMUVGswmrrm1aodlTiYMoChvbxkQOLjAXGlAqgBNGXVlqu2e6uDEA0DN4yOLvLRzK/RyiO6evHl5KbuuKutnc51f7Vc92COGTwjQ4ssPufDi7PSVh0RI5TGTaejoMKQ58MU93D9Mz8F1JOftuB/ttMoM7joTpSDQSsOxk/xTkkngh9OHGG+EUYGyMA5KMTPIC1Yl2GvRCHeEv74SNxpYpdbWAAuf10T0yiR7sM3GBgjNwTMHOdxy3iWpTeGrrYDCEcdrwUgvmWcCuvijOYjUA3UT9TI/4dTeGSgZpNRPSzfKr/UvX6VWhSrLARIEaK3XMERkKuk8SEQhegMyd0rusk+30EGItFtWFj9FhnUbTLR6rODzav+9u2+oiaVuAqeGGdcquz/ty6cw99SvKnpmzESM9iDntWM3yrgT1+Mo+dyLQKKz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39840400004)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(107886003)(478600001)(38100700002)(52116002)(6506007)(2616005)(6486002)(38350700005)(26005)(6512007)(6666004)(41300700001)(44832011)(5660300002)(4326008)(8936002)(8676002)(316002)(66946007)(86362001)(110136005)(2906002)(66556008)(66476007)(6636002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2pHYjZJSm05M1RLUkRMMFF2enJhS3pmTmlEMlgvblJXRDNXeDJsdWExT25T?=
 =?utf-8?B?Z2taYjdvNHIrRTRCSkFYNzBnQU16M3lOYzVoUVRETEdKcXY0NFU1aEZDa3ha?=
 =?utf-8?B?WmJBRVJ4ZEtkcml6ZURURHorcTFSZmVIS2ttWmo5eGYxWGpOWmovVUdBb3Br?=
 =?utf-8?B?N1hRZXJOMUhGcWZDeStRV1JRdTdNdjcyVkhSTDNmZVJWNjJLUENVa3ZPU0pw?=
 =?utf-8?B?eFZnVHdhMXRHL242bHlFS041bjQ2VHc4aGNUNEJGb2xXNm15WXhqNWFRZytm?=
 =?utf-8?B?Vmx2SmVGK3pLcEE5R2tBV05neitwUUJwVnEvR0J3cEpqSjBKK1dOUlYrTFFt?=
 =?utf-8?B?N1FjUGVYRXU5ZFlyWXM5SWhHSkRIbjl2U1NsWE5Db1NxQWZ5MmRzRTRKVzVl?=
 =?utf-8?B?bjV0Q1JpZmR6ZERCZWhVL2xBemVwTzM5cVNkSGVCVGZxK3RyMmdLZ3FiMWFz?=
 =?utf-8?B?UlNQS2FzeW11Q0RSQ0lray9rNkw2bTV5RVk3L3hOMW5TNTJ1UGt0OFYyWDJt?=
 =?utf-8?B?eHVHTWhZVk1KZWk5Rnd4TjFXUXhZOGx5cFNLemRhcUxtWUhRYkJhSk1KVXNS?=
 =?utf-8?B?M213cTgzVmpnTXR2eDhQOVNRaWpYODMzNFRBSzZkUHBWcytUTG5UN1JaM3g2?=
 =?utf-8?B?QkF4U0pXVm5oVFdjUGF0bzdSanNITlFBWFpPT1FWcnVqN2xGV0dPUTBRM2Iw?=
 =?utf-8?B?aGNJM0pYRDFJOW40L2hjYWYrcDBXNW9rY3dWNEJreVlRcWQrU24xSXhTVU5U?=
 =?utf-8?B?VEJlcklwblZUUUExSnBQQkJvN2xZMWJaU2Jzb1lWeVJvNzcwOG5DcXJUYnBY?=
 =?utf-8?B?S05FTzJmeTRoUE5SYytmelJ1S0xPM3Yvc3VQbGxjL0VUNlBrcW9ueHl3R1Fu?=
 =?utf-8?B?N1EvWjNXNGZmYTdGT0w0cTBaTEhIcnJnSGt5VEpMd0Y3UDA3cWdES1NtVjg0?=
 =?utf-8?B?Rk9kbHNOMURsbUswcTU4SUJXOUNVMFJpR2VaNWJUeTNnd0NrTlYwdTVmTjFZ?=
 =?utf-8?B?MDVUdzk2dm85Sm9XYUozeDBlTjFVd3BKdmtoa1FQRkxJQ0I1enVPUGpzWEYr?=
 =?utf-8?B?dURhUytxREtvbDd4Rk9DOVlZUXhFUjhZSUMxY01RUVovbDc2WG9jNU02OEpU?=
 =?utf-8?B?NFNwcGpVQXpHMUQ5cXpaVDFTNWN3UTAyREhoaE80b2VnNldqYi9qWG1uNTVN?=
 =?utf-8?B?ZGdRNmlQMm43bUNwaHByZmZCeWwyMkU1YjJ4MmhQb1RCNFZTcm1LSFE2STZZ?=
 =?utf-8?B?RC8wam0vSXFqRFBNZ3o3WksrK3BpWDc0V3E5ZXVrRGJlbm91YW9uS0tGMURJ?=
 =?utf-8?B?MVhpSHpaMFBpVnhtM3RYNWozMWFydFNjY21vNmg4RjlYK1ducVEvRE9uZmJT?=
 =?utf-8?B?cEJ0dDJJZ0k5ZG5FRGx5bHhuenAzbEVwLzZaeS9qMkErNHk4OUxhUHlJZGNm?=
 =?utf-8?B?RnJBUVh2eXlJRDFBd1N2bDBZQTVmSkw0N0txL0R0UW9aUDFadEI1dDlWWFNt?=
 =?utf-8?B?QXVCN3Noc2hYR0ltbTI5THpwVXhXWENFZE50U2xnckhLMHZ5akNYd2VoRmdi?=
 =?utf-8?B?a1dXUkFXVXdkOEtJcVBaSHFtTWFpaG9hY0NYbTVkZzMwc1Jsc3FvZmdSVW1k?=
 =?utf-8?B?SVlwL0VFTE5wR2FWcDNuSnhibGx2OEVVNk53MGkvTFlXQkcwMEpWbzgra2V1?=
 =?utf-8?B?TU9YdXN2RGNpa3NBcDRaV0I1cUdVRjFTdzN1VU9YUGx0T09ieG0xRHo1T1ZI?=
 =?utf-8?B?ckE3NmVzOGgzaVpCZTYwRWdTQU9zTXExUVNKNjJUaWc3TmJ6aXpQRHpxUXl4?=
 =?utf-8?B?d21UUG9PcjI1NzRZVE52d05GSXF3L25KeEJnSllEblhxUHdJZkliQXpTcHVL?=
 =?utf-8?B?TElsQWpxcWpINklncnR3Vk9yOTI3Q1ZCNGZtL0EwYmdWR2NJN1BEUDA5Vmhp?=
 =?utf-8?B?MHcvaktXM0JpN1NIZTBPZzJ6bGZST1V4MnI2YjBrQ2RpQ014S0pnRnNKM2dO?=
 =?utf-8?B?RFkvNFJjdnpFYmkrYmtHZDRlclZ5a1c3OWpIM05vMCtreVFRamU5cWN0RnMy?=
 =?utf-8?B?Nmg0VFJaRnBURE93bk14V1VSZmNGS2tKQUpMTGltS2Z1eEJ4YzNRQVVQOEV3?=
 =?utf-8?B?YVFQeFEyYW5iTnNOYnRFc2Y3eFQzWDZhTEVLWEpPUE56UENiZmNxcUpwRGtG?=
 =?utf-8?Q?eReM03teisEmgydnrTF98xw=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6075dda0-d713-4eb3-df1d-08dbcf003e1c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 11:00:15.3057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uK4O51GRrmrmeatfZl7n6nWs5hmKHWp0ZXXDF0VNvzLt38JcoKzPWhDF/coMiUoChqG0p0GHIlEONsc+0URNaUECnSymM8yqi3deiDbgNFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6295
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
 .../bindings/input/touchscreen/touchscreen.yaml    | 143 +++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
index 431c13335c40..5c58eb79ee9a 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
@@ -87,6 +87,129 @@ properties:
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
+    $ref: '#/$defs/overlay-node'
+    unevaluatedProperties: false
+
+    required:
+      - x-origin
+      - y-origin
+      - x-size
+      - y-size
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
+        $ref: '#/$defs/overlay-node'
+        unevaluatedProperties: false
+
+        properties:
+          label:
+            $ref: /schemas/types.yaml#/definitions/string
+            description: descriptive name of the button
+
+          linux,code: true
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
@@ -94,3 +217,23 @@ dependencies:
   touchscreen-y-mm: [ touchscreen-x-mm ]
 
 additionalProperties: true
+
+$defs:
+  overlay-node:
+    type: object
+    properties:
+      x-origin:
+        description: horizontal origin of the node area
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      y-origin:
+        description: vertical origin of the node area
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      x-size:
+        description: horizontal resolution of the node area
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      y-size:
+        description: vertical resolution of the node area
+        $ref: /schemas/types.yaml#/definitions/uint32

-- 
2.39.2

