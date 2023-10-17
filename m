Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926B57CC15D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbjJQLAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbjJQLAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:00:35 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2047.outbound.protection.outlook.com [40.107.249.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B63BF7;
        Tue, 17 Oct 2023 04:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0xMTsXpqwiqQcoRSGaDpNJI2vHwb+LNr6v0o2CLo3cNfGXYZEtqftO5Le3FwUyOe0n/Rqv0X4uyw7/vbf8/oMSZTVcOMIQM/tpknHDWYRZ7QydocVeRE4HAB9VIEYJMZkkHbEVoeV6Kz+2nwnZDYZ/gfupcg0JWr4O2eJo5bIvUh/YjCSMacEJi+0CnKoklswBGfmxbH5aqPvhj+gLntjRQ+ZaY30fPFalbHJF4oQVB23ys3jvFRv2p0gcMs9o/1hhliPFv324PbP7byle6CzM/nV2vrFE5D9JWXBN9PgrTxNI3Hj1tIxCLvcIf87ifgKCz9ngl5Cfmq7fkst2+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7bJxCqTJ9g4MIATbCMC0K8OKp28hAs7h61w97OYN30=;
 b=Rm6hkdbZ74HwK/nNGAz1UeN6O4bykfglO6wxnp4Y/iDukE0DCTtU2NVgkAOkI9tEu0GlDTe0FqXSKXUJoTSqRh9ocCfoTe4LpHz4f9yKf5eFAHzDoBL9oNjMWOyne+9KoCKfeIGpWNXN0Sb/Kh55kuOrhWfzooZID1Gxv2zYIXzWqHRw210s1hCS457EcAdF7KzXVUuAzi2J76W5d7TQOjG9/3HqFf8yh6ju2bh9T2rwU6aGviEmPK59hACMtps/uVfYnVLT6sgSZNAUaJfSBvDi1w1fT324CH5ZPS/PRyPgWHfFfdUyczLJXRayJVJt50C+9ulAzd+lZRCyxVpCvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7bJxCqTJ9g4MIATbCMC0K8OKp28hAs7h61w97OYN30=;
 b=XUtxCd+0Wldq3JggtckXspZtPVEVTDqjXSH8TIt9i//ZHWIo5w6TMs0/CFayZi3H9X02bW6VymEFzayAMuCML6dJkdYwzJQ2RYUZ9nXfrm3mj+r9GlL694CtJxhyvS2rBJffIZqv1yafwQcz7ZT1txJjeXhjK7ejIwtNkJNYNEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB6295.eurprd08.prod.outlook.com (2603:10a6:20b:295::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 11:00:16 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 11:00:16 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Tue, 17 Oct 2023 13:00:10 +0200
Subject: [PATCH v5 4/4] dt-bindings: input: touchscreen: st1232: add
 touch-overlay example
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-feature-ts_virtobj_patch-v5-4-ff6b5c4db693@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697540413; l=2380;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=1LZHOKMnwrpCeQ2+qaEcztfZHfZu03BFbjJG0+mOSG0=;
 b=w7WigiRzqN4MYZGEwYUBbZ/8FDWA3dLCYshizEXgtxJYWAi05xD+3e9pfGquhb2hAKhlPltbc
 Io7nKxUKK3YB1lEEoU6fDucrSGDl3cgvttsml7Q4EbU3IIpRS7XtPRQ
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR07CA0250.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::17) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d35a0a1-cb80-491b-3b9c-08dbcf003e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQPUpZPh3LSfGD1WZwS07NDUjK/YdEKyA8aTEo0RCwmB9uRqvNSgUpnP+2eC15VljqUVQt8p/5N5ZmxF9E0AxqUnKWZINRPRCT5RKBKU/S3uSSoPoxF8LkiT07qbzlhSQuYxXcsxRTsHklRafL/xOscLfZPYLVrFczw7COtuzlwf48rUO5pkn12ovvWwAfXZAeEvJZr2DqgjEA4yr4PEQluyjOd2RULYc9poIkaETcmiQ3NfNq8pBIYIojn9XlqyHjDZVOTAwpq81AKzAOETmvQzF6p4ZENXE/UGRMWjI00S2AprdTkrApZxEkVX+39Q2qGnM+iTuKQOThNsAC8zctetJeQpqetnDhlbYEW9xeUGYXFO+IwNGKQMxCE3LITY+NdHCmCAOUdRcUXeleR6M/9hmakKKo09oHmrxow4KdsDlf2msYhm2dtwnnJnA0fs0VaqgOsx+3WVmxxPCbB50DbXudD9A2tL9sl7fgX6x3bLerbQlCrIDaaatujEkdWGE1/rvyRah9sQFn0PZ6rk5na0trVEgS/cIBtX1Qtou6Fe7WSwTwCw0CXdHPRwJSQ+YhIHL4Xs1TzK3KRTn2KfRycbHzF4Iz+HofpzSlGVn/BhiCSEVViBAiWEgsd6ojh4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39840400004)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(107886003)(478600001)(38100700002)(52116002)(6506007)(2616005)(6486002)(38350700005)(26005)(6512007)(6666004)(41300700001)(44832011)(5660300002)(4326008)(8936002)(8676002)(316002)(66946007)(86362001)(110136005)(2906002)(66556008)(66476007)(6636002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUtIVmNHZUhBQWZyd29aYU9tc0NOWjRIYmtqSVVla0xYZzIzNDIwMUVEYVlU?=
 =?utf-8?B?T1dtaXNzTXJwS1JoK2NyVFhZRCtuWlB1L0k2NHNTa3kvWVhBTnpseXJVeStn?=
 =?utf-8?B?ajhyZUJyTjhVZndKVDZ5dDIzTkExOEcxVUt4SU5WZkw3MlJSYllZTU5NaVRv?=
 =?utf-8?B?RTFMVElUeUN4czN5d3JiaUZiMkNiNncxUzBsaGw5QitaamhmQUZKMm9DSmxN?=
 =?utf-8?B?ZUR3YkJSei9HQXpjb2VpYVhqeVRhOWY3UDFGMk5yZk9yR3kreWg0eExlWWl4?=
 =?utf-8?B?NXREWjhaOUlzbk14OFdOL0JacVNaQ1I0bXJ2NGg0R2gxSjVDbHRVVDF5eEZx?=
 =?utf-8?B?SmtFeUZZb3ZFQ0crNVFZanVlbHo2Sk8zNkpmVDZGTHFzMFJoTTdxTTFXWERy?=
 =?utf-8?B?amcvUTBVUkdlZk1xaldKdDNyVG9JRktMY1ROSDArTjErSHZiN21wTXVjNXJq?=
 =?utf-8?B?SUEzTnBqb3RNcHRBMWdqZ1FDanNLbHNZUC9LSGtKc2t2SzZyN3MydnFoSGZX?=
 =?utf-8?B?cGpGMlpsSjNZMC9xdjkrNmIvdGMvUzZGd1I0aTh4a2xKcyt2N3FBMVpQUXFo?=
 =?utf-8?B?VU1kYVFqOXZTbzMrWFhXT2ZTVWF4NXZjVlpRU0tUdVRYYUhqRGhDMm53T0Jz?=
 =?utf-8?B?Nzd6WTV5cE9oV0RnMXVPR1pWYTJacHdvejdiT1dzUnk3S0NOdFNNdHVJUGlk?=
 =?utf-8?B?a3pubGExKzhSS3VCZm9kb0FTSFc3cW9YSzArdnVIUlVpMkJ3eWVJK0pIVGlU?=
 =?utf-8?B?cnlIdWhaT2VYVHZSU3ZkVWorTHhyYVMrOEF4QjhhZXdiMzFOV2g0cC9JWXh2?=
 =?utf-8?B?Z3VISVVrVUpDMmdRcStJSkZJM1haYlFua0NhMGlyMGRsL1Z4Y2U2SFl1NjFE?=
 =?utf-8?B?ZStsQ1BxaE1idmYwRzMrUmdVWXBnenM1NUczOElpOHVpQlhzN0xjdDVKRVRN?=
 =?utf-8?B?NWFNS2g3d1AxWUZDMmdXYVFSSEd6Q2hRNjVxZDJ5QjdyNzlYWWFYWDh6OWx3?=
 =?utf-8?B?bnhhOHBiU3RWYk9TQ0p1R3RJRXJzOUtybm9pUm1ubjZYWjBqRnk2d2tJSmZB?=
 =?utf-8?B?V1RVSlFuYkNaaldhNUpBa0ZXQXlDQ0RJOFBjVFVJL1BXYUpVWXgvOWl3NTRn?=
 =?utf-8?B?N0VDZGp4TWNnWFBVM2hkMlJpaGxlQnFMbVVEdVJZK3VGUUVJV3h3L0RuRDMw?=
 =?utf-8?B?d244Zmp1eVlNTURSdkNDVFZZdHA1Wjcyb1kyN3JQZGErU3czekp3T0dib2g4?=
 =?utf-8?B?NE0vaERBMFV4UGFUWmpjaTczSmw3bnpTaFdzM25hNUdSejF3S1U0TGxaQlQr?=
 =?utf-8?B?TU1SbWpoN1RpN01sQzNLVmVVd0J4bDR5Ty9Ba3oxaXNCU3l1Sjh2a2N6d3hx?=
 =?utf-8?B?WDhNNW0rYUV6N3JLeWpWeHVpdTBGbWNKSHpLZHlaRmFXZERWUDI1NWJObWRO?=
 =?utf-8?B?aDN6dGlhR3Z1MW1jVW5WTWZtTnNvZ0dIcFNXT0dESnJId1RYUEhoVWlCL2sw?=
 =?utf-8?B?ei9kUzdTL05GdE9adW8vcXc0ckpkcGxuVkYxd1RTbFM2ZHFhWTlHaXhYMWdh?=
 =?utf-8?B?bzFDUmpQSlFmNERKOW1scVM3T2drelRkTC9XNGZRa2xzNS9mUkVzUElLbEla?=
 =?utf-8?B?M1ZXY0d0SnJ5cjBrSUplYTRTV3BERmM1Z2JGeDJmSmdjTlE4V0hVMTY3bnRi?=
 =?utf-8?B?ZWxrSUxiOVIxRnk4aGljRzAvS3pUYTltcVFUN2ZYL0R5Y1pNUGJzWFFwUlE0?=
 =?utf-8?B?MFdHWmR6WnFjd2ZQWGtvdk5VWkViUUFiN0xMUXQxKytacEVvLzAyR0g3ZXFS?=
 =?utf-8?B?UzRMYmZOY3BRTjhTZ0VUcXpYQTB2VHdOdHNjaGVVb3JjLzVrTzUwS29tTlRM?=
 =?utf-8?B?WStkY3FkbFUzNExaYk9MS2E5cUs4MmZQRWpkL1FhdENQbTU1SFZaUUMrMENM?=
 =?utf-8?B?Y0VuUjRvSUl5dFVQdlZZVGNuek9JcnJHbys5QXF1T3o2MFp4NzY1YzUrOC9R?=
 =?utf-8?B?ZWp0c2FaWUxQTVFURWwxcnYwbkxZTEFmTUVXYWdMR3BNaEUwcUtFYllEMWN5?=
 =?utf-8?B?aE9qWGk3dzNneFRHWHJtQjNWSHlnWmtPdVBjVUlSbGhhekYwcDg5aGhDNDE2?=
 =?utf-8?B?bDhYM3RZZ2lvQi9VMWdLYnFjWnk3enpqTk1xeWxKbmtKRTRiSytjenFrVEpD?=
 =?utf-8?Q?aEnni+dQqeOb46qZbH4o8fg=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d35a0a1-cb80-491b-3b9c-08dbcf003e9b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 11:00:16.1687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pa25oFj+U583y1Lgy6cdZYVvyQiDyAlojOh7fOatR5FlFBkHIL2WZgPnxl2Q4+I/DZ5UTjj3x/EYD6Y1kBudPTNdkFcHz5uks20Mo0EopQg=
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

The st1232 driver supports the overlay-touchscreen and overlay-buttons
objects defined in the generic touchscreen bindings and implemented in
the touch-overlay module.

Add nodes for an overlay touchscreen and overlay buttons to the existing
example.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 .../input/touchscreen/sitronix,st1232.yaml         | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
index 1d8ca19fd37a..f33fc0113a67 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
@@ -37,6 +37,7 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/input/linux-event-codes.h>
     i2c {
             #address-cells = <1>;
             #size-cells = <0>;
@@ -46,5 +47,32 @@ examples:
                     reg = <0x55>;
                     interrupts = <2 0>;
                     gpios = <&gpio1 166 0>;
+
+                    overlay-touchscreen {
+                            x-origin = <0>;
+                            x-size = <240>;
+                            y-origin = <40>;
+                            y-size = <280>;
+                    };
+
+                    overlay-buttons {
+                            button-light {
+                                    label = "Camera light";
+                                    linux,code = <KEY_LIGHTS_TOGGLE>;
+                                    x-origin = <40>;
+                                    x-size = <40>;
+                                    y-origin = <0>;
+                                    y-size = <40>;
+                            };
+
+                            button-power {
+                                    label = "Power";
+                                    linux,code = <KEY_POWER>;
+                                    x-origin = <160>;
+                                    x-size = <40>;
+                                    y-origin = <0>;
+                                    y-size = <40>;
+                            };
+                    };
             };
     };

-- 
2.39.2

