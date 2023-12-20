Return-Path: <linux-kernel+bounces-6588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0612819AB0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1281DB25A77
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601081F60A;
	Wed, 20 Dec 2023 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="g+cWobTZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201E11D6A4;
	Wed, 20 Dec 2023 08:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZcP6pdX+7gUNm2HLgMFTA9R1/pd951H56Df8zidPYxNfdXBU5ZS+IxM8JbYjK3QvPnXFEzMUggdjQJUsZuGChZtCYQ0G669A+nEHbwJe1JaNSaFrZv1onWbENlv+U+bdqRzMRAfSVZZOOSo7K+e7uAT/ZLQcFZDa6WBYTk5tgtDET/Qal/wGUi6mh4tmf5PUWiow6Lf2HRjHaUuf6+pikrEYUDxsMyiARkyoCR87Q0EaQo0ALFVH/72yvlZJ+tcFcw7GxeCN3N1K0ufEh6THiut5YBYtp37aaiQBvi3gHWDBl+c4bIpnF9jO95fqFiaCiRoe6BRGycOHhiXuFXATg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dJliw5bToQke3WfeUdjp5G1kxFNViFF+00Gz9vm6og=;
 b=bUIejdZISWkWAXYb7elbB0ZtiLRvi+EjV6v3lLGRcb8Iplo3J19AFiuzKSWpN0wHIO7/2YgVjrCRaK3/fC45HYT5mqFe5Y8K9fXrcCnCgDpaD9Aj5UKhWAuKmJL+PdObGunkq9HzTsjWVQHC8UMl/NbWlmRs0GF7nYbXRM766hOuJpy8Om7TyULMqDN/9kB9bZSJIX/rnYIOmQW/5mKjaFZg8od7NNFBm/aXdqpKaL4d0uGV5gK8vQjuW9umruVLx2rfsyiNjRxPym8c2ZOV2T0GxPjap2yfDVMil+2IwDYbzgd2L0CXlglMzdNsPzvIPPM078YVzEhzp3xXLA4+Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dJliw5bToQke3WfeUdjp5G1kxFNViFF+00Gz9vm6og=;
 b=g+cWobTZE/vFlvatSv5yd3f9V6X1DVmp/PlZKaWf4veIeh//1TM6UmL4Mn89JAVohnz9IP06W9Z8W5iaJkPWBuvDFIryZOdORd9H/p8SB2GFmxVb0dk36kIiBreznHd3+vYK0tF72L4CvcosW94/tsRx51X4F12zojrmrWOpLCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AM9PR08MB6114.eurprd08.prod.outlook.com (2603:10a6:20b:287::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 08:39:53 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 08:39:52 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Wed, 20 Dec 2023 09:39:46 +0100
Subject: [PATCH v6 4/4] Input: st1232 - add touch overlays handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-feature-ts_virtobj_patch-v6-4-d8a605975153@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703061588; l=5320;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=5l6dIl/NYW73Tl4xHQU1WZhPslhNKxcOjVzCX472s8k=;
 b=qSIXewiWUER8XL78l2IfugcIrm8vnXv0D6OSNSE33VjHncGYz1vBcRwowDeMMfrGIZB5C9bu5
 5CFFjp8NkQtChVlFfdsIIJEPXaiatvTNUaIdpiGkTvn5rrY9FhbVHWy
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
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AM9PR08MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: d0292b3c-689f-47fa-c811-08dc01373c46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VSyjRzKWbxq1gg5O1gn2OAiM9R42U03KX2CWXGJTLk0LM3ovx9iV2+ojrebip33fsK9a+00X7bW6BGtgiOsJ6qXhh5WQJpkP+Q0uE1JDCk3WDz6BRzgqrCe4qSfR+7JLOFeE8WuCTw4KPqguxNYafSEPCV1nx9linPjcAWcR6kZ2/9VnCNdgp5HGtzJCj8Cw891G0jtcMqvEGMdRKlhfbf1XEqztYM/mjopkAXhsGkUpW/afZg+4IJZ4tD+abTX2mnUkP3WsZJ4EGGHSVYwB/HHy/X7OC2bw8H0U94AnV6m2La/nfveHtOPambpOIv3Eayd+PvCBjSLIPAhqflBvJlpsSK71ou9AAyZummBUrgojzSnfIKi9u3dR27+gLbUy7Dl0aVOU+OB12qJEj9ltbo4eX1rYScF8a1KB7z2iar07orlW4Qjv8j3l4HjVPYzvNPgGInz57DRHpbpFO7OsYog9IrVxub2LZw3zkRsnsEcvKPFtxLO8+wQkkbMIbyS7oaT9g2HAsN4GCoi/y84tNsPcOE1OWyMMbe4GlPA78hQGIr3I6iLAPzwy3XoxQIMZvUdsYF4Wd8m1FenArys7D/4w9zsiI4PcjkB4zX1YLP/PyJG3XEnMb9RpcTzHgFii
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(396003)(136003)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(5660300002)(66556008)(6636002)(316002)(6486002)(66946007)(66476007)(44832011)(107886003)(2906002)(38100700002)(4326008)(8936002)(478600001)(8676002)(52116002)(83380400001)(6666004)(41300700001)(110136005)(86362001)(2616005)(6512007)(6506007)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTlPUzJRMElLL2lIRVRCMTlTQkpEallHUzc5OG9jalVzUS9FZXVWcDA5bUNX?=
 =?utf-8?B?S0s1ZUZ2cHNERHFBVTFhQ2QzZ2hrdE1yMU9WR253UDAxd0diZ1FNWVFFSTRW?=
 =?utf-8?B?TXRMa0RnV3pNZVRrcWUvZTVaUHNZNjR4TEJEM1dDbkpaVFJCQlJ0ckExM0lK?=
 =?utf-8?B?a3Zja08ySUM3VDJpS1ZSbTBoclBDdW43Z1FOUEJXSnczWFZBbTBYTVhKWW5l?=
 =?utf-8?B?VUdYdnhQZThSOTNLOWZUbnFic3NhMVVXV1B2TXUxMGFvWDN5WE9oV1ROa3Uw?=
 =?utf-8?B?WDZzOWY4Q2xUSVhKUGhsaGJmS0RLTVBneWdISFNhNHRrdGxsL1lTcWtZcytl?=
 =?utf-8?B?S3N2TDd3aFRpOHZMY0pSWllGQjRFSU1wMkRSaERocGNvQ3dXblpId251OW5k?=
 =?utf-8?B?WXFXRXpibURCbEFsaHFRMnRIQmlQRHVJdHhhdXlycjBpbWVtSGI5SFNoblpC?=
 =?utf-8?B?eEJ4eU4zU1BHZDVCNU42bjVHQjljeUE0WDdUOW12dVVna21HR0VSSFZ0VVor?=
 =?utf-8?B?M2ZTTTR3Y0NweHFSSTl1Q09FY2Fsc3RHR05iWnV4ZU10T1BVRXIyRnpGak0w?=
 =?utf-8?B?YzBSRTBLdm5DUTR2ay8wYVZlRWZ6MWtiQTJWbUdOdDk4KzRZZ2UrZjFUdzFT?=
 =?utf-8?B?NW1DOXFKZ2tpc29RdHFMbTEyaS95R1p5dzhtZ0oxamNOS2dDYStUTytaelM0?=
 =?utf-8?B?VGgrVldoSXpwVzBTdGQ1c1U5dndtWHgvWHRJZHI3T1FJRDArajlXL2ZUcEVP?=
 =?utf-8?B?aGpPKzNzRlJ6eW95dStJUmIvYno4bE1sZWNUVGFpOHJXcG43VXBuU0RMbW43?=
 =?utf-8?B?SkpJdndFOFc3Q1dyb1RuUnZvbDFxaTY4aXBXZFNqTW5hdjQzUGorSnNKS3JX?=
 =?utf-8?B?WXplQTlLQXUxN0I0WGNWT2hWR25BcFZvenFpaUJ4M29acWZEMTl2ZmtJRXBp?=
 =?utf-8?B?NytCS1hISWdteHJHN0luU0MwOWU4ek5YQk1MaWV6Y2N5d1ZFT2ZlalRwdTJS?=
 =?utf-8?B?WEVPZUtxT0ZHbWQ2bS9jNG1tK3VERlZ0dURURFJtdEUrdE9hYlVoZ0pnR1V2?=
 =?utf-8?B?RlhsNms1OWxVS0lNQjl5RVRRc2JibzBNUE04eEVyalh2NmtnNmUxTFRYcDVU?=
 =?utf-8?B?dEdYR2RBenBXVHF3S3gzSHR1N2d5MzNWTEUycnFaMUQ0NC9hU0VQRjFoa2dl?=
 =?utf-8?B?ZC8yMG1GSWpUL0NlWFVUNEs2QkVuU3hXS2oxTHVvYmpYZW1GTnIrUmlxTzRu?=
 =?utf-8?B?RDhjSjB5UFcxR2hzMG5ISWFXYlc4RkQ5TUlvYkQ3bm94am5mNVNGaE9YMXQ5?=
 =?utf-8?B?NVlJRmJvRkFKa2RqYkV1SUt2cWtiUmhDL091N0VYSDhlV1h4ODVmZm1xS25M?=
 =?utf-8?B?S0JocDVLT1dsT1I2ZGFxdzl5RFl4RDh5aE9MNVV6MFN2Y1lxVzNJVStjVVVY?=
 =?utf-8?B?aktBU2pQZGIzOHk2ZjA2NWNKWlMwQmZyRmR4WEpkcVdWeEcxYytBS2FHcnd1?=
 =?utf-8?B?V2NBZkIyN3F4N0U2TEZJMlFpc2RyWStrcmVBTEQxQnI0aWJtTmloNnZvSnBF?=
 =?utf-8?B?dlE3TnZoS2NhUUtGMWZ5aTFoWW9WZFExWFBQSS9CdXFNTmkxUSttUS9tcVMy?=
 =?utf-8?B?YkxLNHlrdjlXcGYzNEhEUk1lYk83cXN4L2tka1FuTEtVVXBuS1BsNUdCZmlx?=
 =?utf-8?B?NWxrR21tcFBITVRRR1A2M0QzaGxCNDR5VUo4TWhqeElhU2Y5VGk4MW5xUmIx?=
 =?utf-8?B?WTI3Y2RsdlR5NEplSDY0bnBRd01tdVF4YndVbFF4SVNxdXluSUV1UDBrNDBV?=
 =?utf-8?B?NzY4L3Fmc2dwTmJmejFlY0NGLzVIQTc3VG94MWhtd0hYOW9ldGJ2V2gySkMw?=
 =?utf-8?B?SXJLc3I1dW50MEVoTXI0aU1zVjlyeCtNZlErMHJBYXdOZVdQZUhhN3NXS2NN?=
 =?utf-8?B?M0tod053TXhhMnJPRlZxd2VsQmJKTCt4WDVwRUJBTkxhVXkyTk40TzdRa2dT?=
 =?utf-8?B?V01PUDd1MkhheVQwZU9jTDJZbG5GWjN5QWRadjRXSHB2V3lOOFQvVm5yaFdF?=
 =?utf-8?B?OUg3TTFZeE1mbUhqcnNUT25mdWowd0owNGRoSlFITXg2Q2lEdm5YQzNNV3g3?=
 =?utf-8?B?UnpPR2tCc09Ec0FWOUlEcmxBdTVrRzhnREMrWVFWVHE0TWN3amt1dEl4WEpX?=
 =?utf-8?Q?LjTeKSsut4K05QqfMGFjxl0=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d0292b3c-689f-47fa-c811-08dc01373c46
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 08:39:52.8580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: at+2ijy75fmjHGr/Nh/hNSv0d+LoxXK+4NSAEuuxWHonKorFx9WlYcTWjiUK5sKeR4djj9cQOnKLibkFfmmZgAInSmoRgei3WhejJ6VnHC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6114

Use touch-overlay to support overlay objects such as buttons and a resized
frame defined in the device tree.

If buttons are provided, register an additional device to report key
events separately. A key event will be generated if the coordinates
of a touch event are within the area defined by the button properties.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/input/touchscreen/st1232.c | 71 ++++++++++++++++++++++++++++++--------
 1 file changed, 57 insertions(+), 14 deletions(-)

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index 6475084aee1b..5684cf04bfa1 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -22,6 +22,7 @@
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/input/touch-overlay.h>
 
 #define ST1232_TS_NAME	"st1232-ts"
 #define ST1633_TS_NAME	"st1633-ts"
@@ -56,7 +57,9 @@ struct st1232_ts_data {
 	struct touchscreen_properties prop;
 	struct dev_pm_qos_request low_latency_req;
 	struct gpio_desc *reset_gpio;
+	struct input_dev *overlay_keypad;
 	const struct st_chip_info *chip_info;
+	struct list_head touch_overlay_list;
 	int read_buf_len;
 	u8 *read_buf;
 };
@@ -130,6 +133,7 @@ static int st1232_ts_read_resolution(struct st1232_ts_data *ts, u16 *max_x,
 static int st1232_ts_parse_and_report(struct st1232_ts_data *ts)
 {
 	struct input_dev *input = ts->input_dev;
+	struct input_dev *keypad = ts->overlay_keypad;
 	struct input_mt_pos pos[ST_TS_MAX_FINGERS];
 	u8 z[ST_TS_MAX_FINGERS];
 	int slots[ST_TS_MAX_FINGERS];
@@ -138,14 +142,20 @@ static int st1232_ts_parse_and_report(struct st1232_ts_data *ts)
 
 	for (i = 0; i < ts->chip_info->max_fingers; i++) {
 		u8 *buf = &ts->read_buf[i * 4];
+		bool contact = buf[0] & BIT(7);
+		unsigned int x, y;
 
-		if (buf[0] & BIT(7)) {
-			unsigned int x = ((buf[0] & 0x70) << 4) | buf[1];
-			unsigned int y = ((buf[0] & 0x07) << 8) | buf[2];
-
-			touchscreen_set_mt_pos(&pos[n_contacts],
-					       &ts->prop, x, y);
+		if (contact) {
+			x = ((buf[0] & 0x70) << 4) | buf[1];
+			y = ((buf[0] & 0x07) << 8) | buf[2];
+		}
+		if (touch_overlay_process_event(&ts->touch_overlay_list, keypad,
+						contact ? &x : NULL,
+						contact ? &y : NULL, i))
+			continue;
 
+		if (contact) {
+			touchscreen_set_mt_pos(&pos[n_contacts], &ts->prop, x, y);
 			/* st1232 includes a z-axis / touch strength */
 			if (ts->chip_info->have_z)
 				z[n_contacts] = ts->read_buf[i + 6];
@@ -226,6 +236,7 @@ static int st1232_ts_probe(struct i2c_client *client)
 	const struct st_chip_info *match;
 	struct st1232_ts_data *ts;
 	struct input_dev *input_dev;
+	struct input_dev *overlay_keypad;
 	u16 max_x, max_y;
 	int error;
 
@@ -263,8 +274,13 @@ static int st1232_ts_probe(struct i2c_client *client)
 	if (!input_dev)
 		return -ENOMEM;
 
+	overlay_keypad = devm_input_allocate_device(&client->dev);
+	if (!overlay_keypad)
+		return -ENOMEM;
+
 	ts->client = client;
 	ts->input_dev = input_dev;
+	ts->overlay_keypad = overlay_keypad;
 
 	ts->reset_gpio = devm_gpiod_get_optional(&client->dev, NULL,
 						 GPIOD_OUT_HIGH);
@@ -286,24 +302,38 @@ static int st1232_ts_probe(struct i2c_client *client)
 
 	input_dev->name = "st1232-touchscreen";
 	input_dev->id.bustype = BUS_I2C;
+	overlay_keypad->name = "st1232-keypad";
+	overlay_keypad->id.bustype = BUS_I2C;
 
 	/* Wait until device is ready */
 	error = st1232_ts_wait_ready(ts);
 	if (error)
 		return error;
 
-	/* Read resolution from the chip */
-	error = st1232_ts_read_resolution(ts, &max_x, &max_y);
-	if (error) {
-		dev_err(&client->dev,
-			"Failed to read resolution: %d\n", error);
-		return error;
-	}
-
 	if (ts->chip_info->have_z)
 		input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0,
 				     ts->chip_info->max_area, 0, 0);
 
+	/* map overlay objects if defined in the device tree */
+	INIT_LIST_HEAD(&ts->touch_overlay_list);
+	error = touch_overlay_map(&ts->touch_overlay_list, ts->overlay_keypad);
+	if (error)
+		return error;
+
+	if (touch_overlay_mapped_touchscreen(&ts->touch_overlay_list)) {
+		/* Read resolution from the overlay touchscreen if defined */
+		touch_overlay_get_touchscreen_abs(&ts->touch_overlay_list,
+						  &max_x, &max_y);
+	} else {
+		/* Read resolution from the chip */
+		error = st1232_ts_read_resolution(ts, &max_x, &max_y);
+		if (error) {
+			dev_err(&client->dev,
+				"Failed to read resolution: %d\n", error);
+			return error;
+		}
+	}
+
 	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
 			     0, max_x, 0, 0);
 	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
@@ -335,6 +365,19 @@ static int st1232_ts_probe(struct i2c_client *client)
 		return error;
 	}
 
+	/* Register keypad input device if overlay buttons were defined */
+	if (touch_overlay_mapped_buttons(&ts->touch_overlay_list)) {
+		error = input_register_device(ts->overlay_keypad);
+		if (error) {
+			dev_err(&client->dev,
+				"Unable to register %s input device\n",
+				overlay_keypad->name);
+			return error;
+		}
+	} else {
+		input_free_device(ts->overlay_keypad);
+	}
+
 	i2c_set_clientdata(client, ts);
 
 	return 0;

-- 
2.39.2


