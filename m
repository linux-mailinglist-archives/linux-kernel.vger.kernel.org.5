Return-Path: <linux-kernel+bounces-6589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCD8819AB3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBEB0B25C0F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366B3200AB;
	Wed, 20 Dec 2023 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="gV7/VU15"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2082.outbound.protection.outlook.com [40.107.6.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10B11DA31;
	Wed, 20 Dec 2023 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwawyAnUYzuolo3qtickjZrF7SgH00XBOVTbQgJevDvzRaTuRF8j4TDeF/TyMWp4pC99sTKGBbZ1h3i27ZAMpOQaSt/SCi8vESqKWrCQLKYgLawOAurK0DeLiQ8ctGb8GG2eucWpmxI4YoNA8nPDrzenhFHV2axnGnBdfpFvlra1tMgV/Yr2CWKy/IhD2kQdOnBxW4uRqbefJXMzDCq5BsoFzK/KTvJnu3kLKRM7BzV1X1z93hi/us3K2TPeEGDu5Od2v+YHGTupvC9YIXrPpvJFUCFcL1keviQs1rV2DvWiohONFA4XSvBB0EuLHXYGfDZW297xUfxoszQ/1KMIDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhIWW4/rDnj+F3sOuf67Df7bs4EBw1L8/azwrFPGv9E=;
 b=dqwWdYcRYFIu76zBYoInXa0OlIsX6iBKyHGP0xYVerHqhPIcpXC9iYU2TK6pJOR/ZPw8/+UDNEnSwBwn3xga3m8yHjhlYiIwSEqdZ3vE/jw+erdNJThIfLeoqfr4/JcwNFX7M5R17ePLsjVg4D44LvywAHxNQNn6U8lc8LZY7YGc7Vkq7SsPa0hO8As0tGcH1AjYq/79vKPXHzNy7s15F9LUG0z506Ng1gksuoLol/FKXkaoIenmhjSh2QCY6E8vcGAbQqLuw/RjpL58pNBhCFuiDgrNNw5lxmb6YcaWWgWotBilWC6FzAAenzMEHnlPXbu0zedjMPuSB3R1nU6+TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhIWW4/rDnj+F3sOuf67Df7bs4EBw1L8/azwrFPGv9E=;
 b=gV7/VU15ZhBW8TqOJ6+fw6J+hguHTloP4Bj4V//rzc/K7m3s3MLlgVdbj5v1jSD73klWTtQjL/4XHmN+pXDOe92H+8DuniDqiZGeClo5Hjl9zCegC4GFDhchCEocmrj1EFi2YgWsq22hpCiQg41WFJ07esRl4keY518Y/j8R+X8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PA4PR08MB6080.eurprd08.prod.outlook.com (2603:10a6:102:ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 08:39:52 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 08:39:52 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Wed, 20 Dec 2023 09:39:45 +0100
Subject: [PATCH v6 3/4] dt-bindings: input: touchscreen: st1232: add
 touch-overlay example
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-feature-ts_virtobj_patch-v6-3-d8a605975153@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703061588; l=2473;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=59bW29DENUDew3cR5WsWqMNLxLGnItTLxZpUNAO1AqM=;
 b=zJKzrBhBPFDk7o7khvgq+un3DAbxCeyIfIOU8YOIlnteq3GzaFvaj2lYIC8a60xddubnQ7oZZ
 3rTxHLzniIMBboD9hYbsQUPz2AB+edkkq9B+y0Vfeij7Y0aGnKv29od
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
X-MS-Office365-Filtering-Correlation-Id: 14fc98aa-1b1c-4182-1c68-08dc01373bd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i9witi/rKJyhru9eDXOBrNXaHa80FVaZ8n2XLSJ1riuRzYRrjHiILjuq/YYOoE1Xjyjle3FzmtK1StliM9WzbsiRqspgIYy2WtqvN6E/Cydc8iD6OYAVmDsPjf89od3sdXUC11nEnaVRV0aCpuaKB+4IdyxtkzxujH+GBzuWabEjGPeaNVA05PfGS63pKYI0u/wb/dg0jsVHd3HkM/RHkjNWU9yIvONg9A9lLq8XTGWW3nJVR7zhDB/6Lk2Dn+KbxWsd1Ivl8WB6Pf5zcEm/uLK3mYNHtJYMVFyjV5hHxtDTe9sDYbBuJQUjmQeGLGHI0JtPOTj5w6Ej7StlK7RnU/FYDn0uDXB4PSWzt+2h+m2FoceGZDNCIFnKAoX3mNVunEWQ1J3RnJHl54h4V3jTU2bZnhwuy4U+S1lNJp6RkEp9m6BR3ThtP5FE5bKdnudxnp3HX95CgVkbgVd8CcLMySrD+sCElV/EwMu5xrDubIpGSlgyxmheBZYqUNvclnoP4HTNfh5U2kpGJ0oGbuL0v1ojxbc7YUMoybGX4YTaC68rX6evvRYM3uZMnrAw79BMBWBB6G48u8lOcbFh0HXtt4qfabbKBAgO+6/5lnpY9/U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(346002)(396003)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2616005)(86362001)(6666004)(6506007)(6512007)(52116002)(478600001)(26005)(107886003)(6636002)(316002)(66946007)(66556008)(66476007)(44832011)(6486002)(110136005)(38100700002)(36756003)(2906002)(4326008)(5660300002)(8936002)(8676002)(38350700005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzNOYUZaMExZU2s3WVhBOTNWUDJJVWNScTZ1VUFoNHZLUTBpUld5aVV0UVpM?=
 =?utf-8?B?dld0dlBnTnByQXJkclczNXNhK1RVMnJxTmF5bWc1TXNISEJ2eHMyMGVBczhK?=
 =?utf-8?B?R25qME1ZWmp0b0lVd3dDUXAwVXh4NDJSa0NyeWg1WG0zbFNSSnFIa1ovRVlp?=
 =?utf-8?B?UXFQY2I4RFRIRldVaWM4c0ZSSllrU0lvc1hRU29HMitGeU1udUsvclZ0aFFk?=
 =?utf-8?B?NFZaMDlySENCTVgxRjlJdG9KaTU2ZmZpSm1UbUpXVlM0UmhaUSs3R3pwMmt0?=
 =?utf-8?B?YWJsNGl6cVdzQklIMEw2blZ5ellXTDBNNmNMSnI1bmJWcmhHWXpCMnJRMG42?=
 =?utf-8?B?dFhJbDFLREl3YzVHYXNvaEozQkx2SUtBTDNUL1VPdUNIWlIzT3A3Q3RldDM2?=
 =?utf-8?B?Q1ZWckZjYmNPaDFrZGF0MzlFbm5JVmVTcFhGUW5YTkFGVFBrNVQ5WGZuMkFS?=
 =?utf-8?B?bjdyS1B1bVlZS0MrRXRCSVdZbEdSSmxXbDhkdHk5T0ZzaHc0Q3FkRmQ1SG9C?=
 =?utf-8?B?V1ljV0E0UWloYlFFcVBHSE5XcVVJVFBuaklhbFRuNnpEWHB2VzZKWXg3U0JE?=
 =?utf-8?B?Z1dwUllRaU92QmdtaHZwbWlyblBoS25MSzhYTklkK096OWNOa3RSVzFaQTdO?=
 =?utf-8?B?cTNncldKcURGalJJOWw4QnVBcXkwZGFsRFora1ZoeXNYWWgxMTVEY0U0Tmtk?=
 =?utf-8?B?dWdsZXI2TEFRLzFDczJsVndJOHFRaWxyOFRjK0Q3bjViU1p3cnc1MTFxQWU5?=
 =?utf-8?B?UU5kTjZXQ0lxV0N0Z0NkNUpOeWRwSndER3BoRUJmSDZuZmRPL3UzNlQ4QlBE?=
 =?utf-8?B?dlFpQkhkcWJrV1E1N1pOS29RRGd0NUROR1FtdnVGdFB6NVBBL3VrdDlWYnRH?=
 =?utf-8?B?VENQZUFnSFhoa3NWV0R6NWJWYkFZNEY0YmVrU3VUZDBsR1c2UFhTR0tQdGZB?=
 =?utf-8?B?QW1ST1F2OUxyemhBVFNDT0syZ1dUcy9PUlZOMjhwYmtLWE01VWNMSDdPbmhS?=
 =?utf-8?B?SGc1dXpBSTEyZnFDcEFNRUhQeWg3d2pBdVJQVWZCNmtsS0hlbEdodzl1Wlk5?=
 =?utf-8?B?UkRzaWE4MWc0TEc1U0oveFFqWkllUjdKdGI4OEgyaTB0YU1mMjF2TmoxY2RN?=
 =?utf-8?B?dE81QTZ0ajdCdFVNZ1hFK0ZnNFhRRWJURUZQRlF0WGpnSUVVeWlXYktncXQ5?=
 =?utf-8?B?eTlCOHYyRUYrSDc0UmdFOEZYSXBtRVZFeHBTRE1DeHVwcTNKVFJrQUFMQkFy?=
 =?utf-8?B?ZFdqWHpzOXlyV2JNQ2NQcmtVL05GNnByd21MeVlHa2huejZiOXovdHFReFdi?=
 =?utf-8?B?aHVGUG1PS05EeWlDNUh6a0g5NkpvSWZwY0MyT0phTDR5cHlYRFlrbGxDc1kz?=
 =?utf-8?B?MlIvY2sxY2d0SWF2cmNoM3RFajlkMnVBdTZsa0hiVkdBclI2SHpMRlZMU2Rx?=
 =?utf-8?B?bFg1aVN6MFJydHUzSjk1OTI5S2dSbWx2aWR6QVdjL3Z5NWlVd0c5YWg3UmhD?=
 =?utf-8?B?eFhtSThoRmZKMkZwaHArTWtDcW5qNnNROGsyUk5HbXpFN3RSQThDY3JweDhq?=
 =?utf-8?B?dHZFak5YdXhSTG9QWktzQmp4QnNWR1ptb3VhUjlORG9GQUFJNUlCb1UzNDVF?=
 =?utf-8?B?aC9VaG04Q2loQWxhclF3OFB2WlZUL3JxWFFMUDlzdWowUDBMWUhqWk5OWnov?=
 =?utf-8?B?S3pRam5iRDZQYVhNNDNEbEl5c0tXVWVSQW1ucjNlVjhYTFlpVGhiRmFVRTQ5?=
 =?utf-8?B?bk1OVXZRWXZjbDhTNUI0cGZNMXlWOExjakE3bTFnYWR2YlpKY3d1YjNkalVs?=
 =?utf-8?B?L2VIbWM1UitpcU9XODBFL050ODRqSjdaU1Y4OStUYkJuVEM4OEl1ZlR6YkJh?=
 =?utf-8?B?Rnh1b0pFS1VQMTFTQzIxSmZQVThrcForQ2lxbGticTloYUVOVjhMQlVZTVc4?=
 =?utf-8?B?ejhKQ2RGNGVxYU1mYXJHRS9vM0xpdmtoRGYvN09WREhiNTdXU2hwYzVsQUpS?=
 =?utf-8?B?UURydUVEaVpGYzNBdGozcmFaTkxhaDIxbkJnUVlBQzBsYlRCYlF3emcvODB1?=
 =?utf-8?B?Y1RMK3k5cTBVZHlEQWhzL2M0R0lLSmpNMUJjWXcxTXlIQmFWRGRKZFpXY3Zz?=
 =?utf-8?B?bC96dEg2Yy8xbmQ3MGwvOVgzdEdzY0R3S1p5a0xDQmMySURSS28zNC9ObytF?=
 =?utf-8?Q?mtaLISGPZG4TQlc7xTkiRQI=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fc98aa-1b1c-4182-1c68-08dc01373bd9
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 08:39:51.9909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1U/3eOAnkQT9ldTr8WbVWDi3p3YFVM4hNydpiS93YU+Ow8au+AeoKPXu++5IfjaM7rHNnqTOes0QIvFa/i1zOzEhva20pMtJm8WZx6BEm74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6080

The touch-overaly feature adds support for segments (touch areas) on the
touchscreen surface that represent overlays with clipped touchscreen
areas and printed buttons.

Add nodes for a clipped touchscreen and overlay buttons to the existing
example.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 .../input/touchscreen/sitronix,st1232.yaml         | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
index 1d8ca19fd37a..e7ee7a0d74c4 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
@@ -37,6 +37,7 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/input/linux-event-codes.h>
     i2c {
             #address-cells = <1>;
             #size-cells = <0>;
@@ -46,5 +47,33 @@ examples:
                     reg = <0x55>;
                     interrupts = <2 0>;
                     gpios = <&gpio1 166 0>;
+
+                    touch-overlay {
+                            segment-0 {
+                                    label = "Touchscreen";
+                                    x-origin = <0>;
+                                    x-size = <240>;
+                                    y-origin = <40>;
+                                    y-size = <280>;
+                            };
+
+                            segment-1a {
+                                    label = "Camera light";
+                                    linux,code = <KEY_LIGHTS_TOGGLE>;
+                                    x-origin = <40>;
+                                    x-size = <40>;
+                                    y-origin = <0>;
+                                    y-size = <40>;
+                            };
+
+                            segment-2a {
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


