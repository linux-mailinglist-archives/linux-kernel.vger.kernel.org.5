Return-Path: <linux-kernel+bounces-72713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3146285B7D0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E931F29429
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9306351A;
	Tue, 20 Feb 2024 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="Cjr8MuCo"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2128.outbound.protection.outlook.com [40.107.21.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC762627F1;
	Tue, 20 Feb 2024 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422011; cv=fail; b=RbgyXaR6cpyqCZth5zp8+TVsP1oV8H/5WgwmtKTBzKGh2bL7y/FB7L6sPP66e/P5vYlxOO1ZUM1yDDALN30GYGHExUfwTAeTvzlAgmpZ+Z6lUaS0/0dZKz0Xz3grplwfUMcB0cxNity+qLx4OhA09YktoeZC3WLurwry3Pd7K4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422011; c=relaxed/simple;
	bh=jLO5zZr3iqLcHWi2UTNWnW0pIZ89WenifkK9e6MjsWE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fzGdhfcILFLwFp4sYVm71J4jNARj7w3eAdP3mLHDHZLfjNxLEHhH2wIzg5F1K3lNNhdVwwUBjLuWH+xfJRt+UsdFWSxTmKj2WK0W3JYInPluFpgSoC/NPE+7WLakWaUB1hQ6NgZpfE3kE6gZ7+OBJedGS7IGvikkL+K7PD8gj8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=Cjr8MuCo; arc=fail smtp.client-ip=40.107.21.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcaghJha+j4HBBXOPUlkOn0bWMEWdxvwMGxrdLkzjLKVd5z9OKnKOu+WHQ0joHfDukSX45qHT4A+YdxVjvHbmV07HK9Clg9zMUSvDLVBwBNxSTDthUlB/ZVDHrGOQja/mHWBVflhcaEjKbdcgYYmHVy4hPYaOcNFuU3Ge0QgdsGpczOfoX+rUBIyCu39mnpdHnoid3JjFEi3kGCgiKPIXO+iXc60mHPXlGgRqE28+OWvo0GHd2Ds71d1wzwOm196Re7YnzekX5l+NMz427dVA1XnqJJJmEBb+2iuNN6eUK1Etji9UNVyMb3rd0tD9a9maEqwnjLbjLqsxUiDeSjoVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgxx/BbQP8Rwa0uW6yWMPJGzjK7QlTC2G+7rvNzH78M=;
 b=b6XO0EcQ0YGT6srL3Ruj3a7i+M/m5MEsJ7vCA4Mx2bW7RP0/0rrie/GmPxeH4QjZUeMfwiNle1K/hVAEDG1SjT8eKGActu8XacsY76KDnmO7DQM0mohepzPGovuVqWbS1uP7HFEsYXEfLD57QmDPBvbfCsR6u/er2/FEKUL8q5X+tAyQjb3E/ZbVMTY1QCUVW2peGR4t/5IAjMl4ojKInzMJ54kUSBmCXMYRB99MdOvSVp+5p+i9eVffWJ5fCqkogaHN8lFFHKsmimOuaqfqHJEtHqsg+AmtC5WA0Wc1Cj1T/PeYLYXk1EoHUt0MWenCIJtdLa4Dn4M69+ZWLICiBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgxx/BbQP8Rwa0uW6yWMPJGzjK7QlTC2G+7rvNzH78M=;
 b=Cjr8MuCoaS/CUohythEdma9p3xVP69wKLpr8UX7zzI375Zmr/JFWpVnNEt839URAPVDp5vbA0r1YtUIpu124lZsXiU0z86OBsVXmrIruYJN8/emBKztlzWjAgV4NRIGqHGggLcMe0pt65qc59Z9oN8vORN1H7Lwwq6htWOT+vd0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by DB9PR08MB6763.eurprd08.prod.outlook.com (2603:10a6:10:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 09:40:06 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::7409:db60:8209:c9f4]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::7409:db60:8209:c9f4%6]) with mapi id 15.20.7270.043; Tue, 20 Feb 2024
 09:40:06 +0000
From: Michael Riesch <michael.riesch@wolfvision.net>
Date: Tue, 20 Feb 2024 10:39:15 +0100
Subject: [PATCH 05/14] media: dt-bindings: media: rockchip,px30-vip: add
 rk3568-vicap compatible
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-v6-8-topic-rk3568-vicap-v1-5-2680a1fa640b@wolfvision.net>
References: <20240220-v6-8-topic-rk3568-vicap-v1-0-2680a1fa640b@wolfvision.net>
In-Reply-To: <20240220-v6-8-topic-rk3568-vicap-v1-0-2680a1fa640b@wolfvision.net>
To: Mehdi Djait <mehdi.djait.k@gmail.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Michael Riesch <michael.riesch@wolfvision.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708421995; l=2097;
 i=michael.riesch@wolfvision.net; s=20230803; h=from:subject:message-id;
 bh=jLO5zZr3iqLcHWi2UTNWnW0pIZ89WenifkK9e6MjsWE=;
 b=eAAciqIRF+rh69n2FNQHR/MURlqw5qOmN0VYe5JZyMHXOYDRCQLfPLBnxxUKoC1NUcrvkginR
 EKKtLfxJgveAVZiwlWO9MKCTQn9hBirFfvUuip0UxRM7O1E+7DLpdHZ
X-Developer-Key: i=michael.riesch@wolfvision.net; a=ed25519;
 pk=9ral3sulLe95bLcbaiNXTgUTRiBayRBEFZ5OVIEHp+0=
X-ClientProxiedBy: VI1PR04CA0128.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::26) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|DB9PR08MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad7360a-a6d8-4b45-56c8-08dc31f7ebbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cE9Ka2/xCrDBTay3tl7YUoEOE6rmkRXX2H/wX3HAtHQwgSLYAOtJazEuoAhGqKW/PJB6RqWT4Nil6EvPsfAacwAV3ekeq692ENwcsJSL0A/DrTj6OmF4q3IqxH3gxdni39pOGNBxd0PXLE89gkWrGN1Jks6cF2bR7mADZKdO8zrnjP75f4BWzvTFJ6wpxWR5BHpIzKBt6rUTbBZGTxpICocNYBQlwXVjutQiThEtVOl0iQjNEYVvRSuE+v04ha1hYAYvn9UyQaok+TqoXNgbw6HomCZcL1OeSLiIfaMUd+WVhy7m+pF4KFjwPVXozz/Twk39cjo6uqF9Xs0kmJIPhay1pgTPr/jeDBT46HrzLIRVno+42moN2POXcPNb+c5jxG5XX9OVy1QU1u/+cWvsHvzOoYR3nz8gTdlj5AnhIhqJeBObzNHT6PEeexrzps+ZpEVLYx2cy+HN15MwUKcyll7KrG4yhHue0Cvl4HCAjZKbWv89+42hfT9DkgtTWYy+E+j78APWxxjGHJ3zxqWvfyuqetIKhLYELs0KJY1bd6Iu0bbkkkmd6qfAGBi0ptvO8Z+nB/HrmK0zaYx4jMiiEtexGb3OOZPVzvsvBu1x+6z2PvIDsbZu5MH7mBMkBcbJ32WW9V6jXqNEymESgBrnHA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1JTN3p2aTYwRUVpTFVCR0ZoUlIzWUZ5ODNpMkg3V3hwcEc4Y1dKbmZmNjRF?=
 =?utf-8?B?blY0QlBIVlpTUk1CbWQreVoxVFV3SHFialR3K0FZVVZ2SlY2VTl3a29qanpn?=
 =?utf-8?B?QVZBdVc5ak1LNC9yczFFTmpsYW5vTGZXNjBWMGR3aVMvZnpydm9ZZWFwaXdZ?=
 =?utf-8?B?NVQ1d21RZ2JCMUxmdVJlRXBLenArWGl0UFk2RWdKdjNLcFZtQmloTWVVZnZs?=
 =?utf-8?B?OWhZTG85Um1RWTRrdG5XZi93K0dxVjRyYXNKdG9NMWJLN1UrYldLMHV1M0FT?=
 =?utf-8?B?SWVyK0dLbjVSVjJZY2haTlBFQlB2VDZjSEMvTmo5UUR0d0pEN01hbWNwMHRV?=
 =?utf-8?B?YnFZNVU5OFI5NEJyYTBPL0ZOMHlKamVwd2RLVGhxUU51Y1p1NmRXQ0RCdjJV?=
 =?utf-8?B?YTlpT2kxamV0RjVOUVB6ak1sYWlBellDZjJaYjZtbFRqUnlDRi95Z3dzeUVL?=
 =?utf-8?B?akZOYWppSTcyMEpZbC9xZHJORjMwNHpKT0NwY3JId1VEVVlZUlJPYngvbmIv?=
 =?utf-8?B?aUxzcXZkYVRPVytFUC9pQzc0bytJRExUMkM2MG82aEw3ekExVFkwNExnQWhQ?=
 =?utf-8?B?SnRFUjVhVytYYkxjeVg3NkFJckFpcno0SXJXVmlIMURqZk1SWklOZVRWcDJ4?=
 =?utf-8?B?RkdxalVPQUkzc1hRazkxUUZqL29oSnpIVjBHL2M3ZEkwM1I0eDdUZFdvbHlv?=
 =?utf-8?B?Qkh2dFhwS21yY2VCbHhlb0F3RFVyOVF6a01mYlZCdXNsUHpYV1A5aFo5WUY2?=
 =?utf-8?B?UC9DRmUyT05jUGhDb0pMc0xHRUE5M2lieXFtTTZMTGhESnNyTDNmaG5qalIz?=
 =?utf-8?B?anZmWGdWeTFCOWwrYVVlNVR2STNlQnVUUUdtUU1yQVFHUjNnS3Y2K1ByT1Rr?=
 =?utf-8?B?SFZUZTlWNkIzcEcybzdBdWUzUzQvN3ZYRG00UjRlcVZGUzh6bU95NncrUW9h?=
 =?utf-8?B?KytSU1RIemw0c2ZESDUzK2R3U2tBU3MzVUJzSms4czZwYm9CckpBS1QxcXNC?=
 =?utf-8?B?NmEzOFRpQ2lydzB0MlRqUHB2ZEJodVh6amFHM2FNaUNiMjJDNEdRL1IvNjVD?=
 =?utf-8?B?aXJCWUVQNUpDL2QxVUhyUnEzc01QNnpkVGJYMVdpcGN3NmI3RzUrWHZVUlFQ?=
 =?utf-8?B?YUVZdXptenQ5OWJXOUd0Ty9Ed1lpSm1PSEt4RnpSVUdqUlEySzdMSUd4VzdQ?=
 =?utf-8?B?SzNBK01jamsraVc1dU5pbEZRRFBBOWs2YUhFeHhIWEVpazNtQm5FUWszeFc5?=
 =?utf-8?B?ZXNTOGUrcEduZW1Memp4bVpidlF4SzVhQXBJUlVzMGw4My9yMERWNHhNc2hV?=
 =?utf-8?B?MkNMYU5NT21HMExkaFQwVTNWeUxaVWhUelVKL3JKckdJVURDbnFHWjZ4a3l5?=
 =?utf-8?B?dDRlbkgxbmRHTWdvYmljc1c2R2xMOHZyLzBLdVVFVUZ4S0EzMWdqeWhDNC92?=
 =?utf-8?B?UE8vQkhJQWs2bmJCa0FxQ3pSVDd6V1lFSG84WGRPK2dsZ3JNYmduNTM5YkdU?=
 =?utf-8?B?ZTBrK0FTUXB1TlM4SllJSDU5aUkzWjhPQ0JhMnh6ZWJuczFLRkJzRjM0R1I4?=
 =?utf-8?B?K1R3b0dWcjdOZkZNcTh3K3VmVERYb2V1Nm1rSTdRYjVwdThnK1pxTCtmYWlF?=
 =?utf-8?B?ZXVkdXdqK3ZxVWc5VWh0UFMwQTF4NDhld0dWZVlLaVQvbnZQWlR1Qkp4UEx2?=
 =?utf-8?B?NlJqODFSRmFRNnViRkxZQUlPK29mSVB6TmhsR24wdml1RHd1cmRsdGhJbTVr?=
 =?utf-8?B?WXJhNFpuOStMV2tOS2JiTm9iYVE3d1gySlVnbElaSlJqMnhpYitlV29lR3lZ?=
 =?utf-8?B?Zm13cHBwNFZYbnNjclRidE40blVFNzlxTVRsMy9xdXplQVNlbjNBVHY1NTkv?=
 =?utf-8?B?Tko1QnNBeEdwbnVUNENNYnJDVnN1UHJVS0dLalNEQStWTFJsajg2VDhwWlhP?=
 =?utf-8?B?VlE0TW5QcEdTazJ4Mm4wTzlYNnQvZVJFcTV4UExTeTZzcW5BekkrallFTlVm?=
 =?utf-8?B?UDF3dWpEZzRBTzkvN1BLbWtGMURZRlFDYnVDWUpXSnJIUXlUZ00xTFpFdVFv?=
 =?utf-8?B?b2NSdFpDeHNYSXM5N0p3OXdJektTY3ZkT1g4VkhYZ0JTVzJiN3JqallyeTBy?=
 =?utf-8?B?Sjg4d1BkVjlHS3dwZjdHSmZaM0RHSVFzZkVlekVpYjhXT3hiSTQ5bUp1S3pv?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad7360a-a6d8-4b45-56c8-08dc31f7ebbd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 09:40:06.2233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHhg2lU3inK96ei/j9BE6cyhrU59MnyEFPPZ/DjmtX90OMd8vRVurCGnfwj/wVqMQXzHa8WasH7XX8cKHOetDsPSYwDccN1CdzZ4Xal2pt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6763

Add compatible for the variant found in the Rockchip RK3568 SoC.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 .../bindings/media/rockchip,px30-vip.yaml          | 45 +++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
index 7168f166798c..06d49f591efd 100644
--- a/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
@@ -16,7 +16,9 @@ description:
 
 properties:
   compatible:
-    const: rockchip,px30-vip
+    enum:
+      - rockchip,px30-vip
+      - rockchip,rk3568-vicap
 
   reg:
     maxItems: 1
@@ -35,6 +37,11 @@ properties:
 
   reset-names: true
 
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to general register file used for video input block control.
+
   power-domains:
     maxItems: 1
 
@@ -100,6 +107,42 @@ allOf:
             - const: axi
             - const: ahb
             - const: pclkin
+ - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3568-vicap
+    then:
+      properties:
+        clocks:
+          items:
+            - description: ACLK
+            - description: HCLK
+            - description: DCLK
+            - description: ICLK
+
+        clock-names:
+          items:
+            - const: aclk
+            - const: hclk
+            - const: dclk
+            - const: iclk
+
+        resets:
+          items:
+            - description: ARST
+            - description: HRST
+            - description: DRST
+            - description: PRST
+            - description: IRST
+
+        reset-names:
+          items:
+            - const: arst
+            - const: hrst
+            - const: drst
+            - const: prst
+            - const: irst
 
 additionalProperties: false
 

-- 
2.30.2


