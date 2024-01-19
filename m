Return-Path: <linux-kernel+bounces-30859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E867F832531
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978BE286697
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681BA2E656;
	Fri, 19 Jan 2024 07:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="p1Q/n2Nw"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2043.outbound.protection.outlook.com [40.107.14.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A0028E1E;
	Fri, 19 Jan 2024 07:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705650233; cv=fail; b=nYaPyD1Gq9+XotbgxiZOcKVKrIvTx1nxmLX/TygUkzX3JZbW9cwouwlhv5heUVNGj1snBgEfsS+r73/PshcCtHwy2otDXlVoLt7uSYLAweWUyKvE3pfWjAapxTuWjtZeZpaQRAOD5hvsnZnzQfCkG6dpEKurre27nzv6jWDBDvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705650233; c=relaxed/simple;
	bh=8ZCwLODssVe58IJ/RKNeTtBq1x6Smnd905NV4m4CNXo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LKX9gFikdqWGJA5m6WUIwvY12dNhnYw0XV8xWch8KCcUFwyWW42lRqY7xCUc+uYDwAuC1Vl2ZPgTA6uHT8mYOBgcTbHlLzX/wzi9/cPJ7MLYS5D0GzRE068jynELYEIhqVCXVwQLVowRJ1V42W+Ip2/SyX4/AxrjZRhGuAtN4JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=p1Q/n2Nw; arc=fail smtp.client-ip=40.107.14.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZO4KRyQYt9UsfjEQOpWLTxlolaDJk+6LPI48UH8JdMiYwxfxnQOuNoSpZdh/EXw2E6/rfg5zt3qfwziQMCj1oGSbJbnBdEmdY33hpqXoFwX67QbyA3YrEXI3P6ydIf55Jk4kU1g84CUZSVdCmxLtYrekr/yNifKPE96CKaamkgbT+lIpkkhZISADJdtup06qRCTlnyIlgb9VF9TYMfN/iEu7YzYaHyrBiv5Fow08EDjY2b4JoXAhiI0gPWWC7Fq6GRPzzD5vmCxwDzXQ6y8Oaa+jf8zcs9Rto8q1x+I+6kGZZqsYGAChtROKlzkwqIVcgPiZEZyQYgHhvap6n6gXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/pOwDYwfpSMY0Ty5wfbusqYghdBkhPgGizdIHn9Z6w=;
 b=Dx9xNJwVo3qmIrK6+ZYP2PNgLS1QP7o1tXgfVR9KTi38CwiZliN74TlK0vQg3q9hUt/AXbxpdUA5ZKDpQ4htKhkBgSYwwRE7Rc7fzuYzgSxVJKZbBxYYfhQHQl7yP96Sywr6gn3L4uegh9FvxdcOTlzIaVBEJrwK0LGqWWHLh5BRFkjrVFS5BKbQ2moZ/610Iui5FZgueTpRpniBM+ojfhOYnCXw7AKVV88UW2MuX7daVNuYOaYTBDGnD5z9R36z4mjDRo0YqpZsz52rPBGBbk2puR9qty6dUcBRmZi+LIIYmB2NANgXG6/G7pQJRCJDtY96NJYzUxJGsO1bkEv3hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/pOwDYwfpSMY0Ty5wfbusqYghdBkhPgGizdIHn9Z6w=;
 b=p1Q/n2NwDqoSR0pm21selj1nq69jAfUW/uE9G8pVB3NO214f7Ah19ww3geN/aPJdLYvPTmgXPP9Xo8CNH0gotfekK+cys/GdiGqHLdSN5EpUeYzMq4LLU6o48KWvFLW64LcMAlHEISLavPRiuKhi2c3tQPlSulQCtPyr921pKnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AM8PR08MB6578.eurprd08.prod.outlook.com (2603:10a6:20b:36a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 07:43:42 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab%6]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 07:43:42 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Fri, 19 Jan 2024 08:43:36 +0100
Subject: [PATCH v7 4/4] Input: st1232 - add touch overlays handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240119-feature-ts_virtobj_patch-v7-4-eda70985808f@wolfvision.net>
References: <20240119-feature-ts_virtobj_patch-v7-0-eda70985808f@wolfvision.net>
In-Reply-To: <20240119-feature-ts_virtobj_patch-v7-0-eda70985808f@wolfvision.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
 Bastian Hecht <hechtb@gmail.com>, 
 Michael Riesch <michael.riesch@wolfvision.net>, 
 Jeff LaBundy <jeff@labundy.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705650218; l=3410;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=8ZCwLODssVe58IJ/RKNeTtBq1x6Smnd905NV4m4CNXo=;
 b=Bsze/vswBYZq/N3RY5sCRFd4ol6ZvkcCTPlWeRyxFygRvOKtuzVQaiBnM8SJSibUnIuqfajT1
 8MiWN5CSpioBojsvsS8eA1EO2LNxetHQaweU05XQs2pCaeq7CDMrrmb
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR0102CA0088.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::29) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AM8PR08MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: 06961663-92f8-4436-e527-08dc18c25bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6iGXlA1Tb/fKoxAFHsvQ63bmCzpO4JXC8ZlZS7GQLEkN2CJmLjyAUJwXIc1AVIUbMGPU8wd13ZP5YrzwKUqv1Q+DreHTcavnRkgpe9yH4oS/QN3mrWIIoft6ihxexxwVioa0Et/VenvUkDebABzUv2CMkmvaPIbCbl2qHhTZ+edlge7udIZQRuvUcE/6rT05peQ9ZPcJnANqaLaNAmaqpjT19QIc1tWXbl1vzP0IWMrAEloE4uK7BxD5ijY6NrkF9CSocIiAFpdMpr+6JsDw4TgYZAeDW/Qf/z4KOywLmanevjpeV9jWD47rA1HQS0euU+N+o50H+exuWmN86TamOxt1osg/9VMV5sh67hZSC0y5sth6jXC8AEXVXdj/I91SRZlSvKHqS+oq6fwxTbreihgwysFTj+GenUVh1h8T5SdRzGsOnSkjK9Fz1iXYzZGM7Fw6T0DAskvRe7W89AarSeoew+L8dbL7bijoXBbXKYasyt2HBrs/g8qkjFVrKWhJPSJ11hhFW7hrKaSISu/mqxwcQCxP1P0nH5OfvObsEeoMdAt5b+N5VIAwM5M8mCI+k+d098AS8BuOHzTANJiJV34up7Bal5p8tiDiudqG3kbKRtNxqH1fYB81DJZkKAA8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(346002)(39850400004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2906002)(7416002)(4326008)(5660300002)(41300700001)(86362001)(38100700002)(478600001)(6486002)(36756003)(107886003)(83380400001)(2616005)(6666004)(6506007)(6512007)(26005)(52116002)(316002)(8936002)(8676002)(44832011)(38350700005)(110136005)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTBMb0ZKMTB0VHQzUm80dm52UG5JUkpSTEdUK25zc1ArSFl0eUx3U3drY2Y4?=
 =?utf-8?B?c0hBSlFNa1F1YTkwRzV0czd6dE95NGVHQVlNWnJzQ3ozMWxVYno3bjZmTzBJ?=
 =?utf-8?B?NDIwWEt6TFBDWFVEVXkwMGZsSDd4RDljZmxpTjZWTHBNaVVVM0NzUFBVL0VD?=
 =?utf-8?B?U25RMHpMUHRmZWhwZU53Zzd3Tmh6S1N4L1Rua05hM3h4VENJYkMyYUg4eGNY?=
 =?utf-8?B?U1JldXpFWHhZYXRVN3A0N1JtOEdqRllmaHI0QkZTNm5sUTdOKys5UU5lQ0dH?=
 =?utf-8?B?MkRYSFFCZ29nUm5IMUhtNFdzMFFaK3dHVlZtd3JWaWViOHljckVjQmRSa1Bw?=
 =?utf-8?B?QmI3b3luc0xXVjZlSm5SQTliY09SaUtTWm5GMU1WZCtnR2Fuc0VYVXdZQU1R?=
 =?utf-8?B?QjNMYkFWbnYyNHFnVFE3djVBUFNCRVVnckppSDdXNjdRTytXeXlRTWg3VzBk?=
 =?utf-8?B?b0tXSGJudEsvdTFzL2xtcFdETWZYcndEZ0tJMndYTlBockFJYWVuZGZpY0lF?=
 =?utf-8?B?T25sOHdzRDVQdVd2Q3d6S1pPKzJoVEdUU0dqNWZJT0Vtdjc2ZldoYmJGQy83?=
 =?utf-8?B?dXdPaThFUlErQUVKbWREYmlZeUVjL2dvZEZHZ0ZLNW5CZGIyQjlwM2VkSTQ4?=
 =?utf-8?B?Yk56a00xdmFEdnBYRkVkellvczc0dzkzZzFMekh5TGNIRllZSE12OHVCWEdk?=
 =?utf-8?B?S256WXlObHFxd0xScDdYeCtiTHovc0JrTVhWNTROeDhTVzcvQm9NbVNIdGlh?=
 =?utf-8?B?akhwR3c0V2FaQlhlRS9YSlliNmk5TTk0ZGJLbnJTV0duUk1oMHNWZXBJdW9W?=
 =?utf-8?B?aHlPSGxKckZleXJWNTYxcTlxbjRoUktqTkU1a1VYVld5Mk1Sd2JlcGpSK3RG?=
 =?utf-8?B?ZDFTeXhzT0tseW9SVkk1WjFNMTZyeDE1OWo3K1Y3Q0htK2JORU1UWjc1bHI1?=
 =?utf-8?B?VHB4dzZzMVZySmtabjVycmU4NnJRaVFFNHBMTDVjSWFRcVNMK0VpYVJ6ZG83?=
 =?utf-8?B?eElRZEJGaXltOXNEQkEwL05kUWlIUVAxNHpBcVV0aFU2S2tJWUxuY1hhcEtL?=
 =?utf-8?B?eFUwMGJKTVJLYXd1RGNGY2lobFNBOGZMRlY5ZCtzTU83bzRySklqMWM1aWVS?=
 =?utf-8?B?b0VhT0NIVDNnRkVrWHJVZGFzdlUvSFJOUkVzamU4MlRDbkdQT3dwdTZ0YWxN?=
 =?utf-8?B?aW0xd3NmMkk2VVZwK1BodWptMVhWbDh3MmtXS2ZCRW5ER2JVQ3d0M0FFbEV0?=
 =?utf-8?B?VkdVdmczaml0WkR0UGp4cCszNWJjL3B4QXNUbGZzVVlyak56R1l6VW1EYkw1?=
 =?utf-8?B?ZUtkU1VWLzB3elR4dHQyZHZGdHc2OXRuY2YraFpqdnVBY05QNGd3UFNmeXp1?=
 =?utf-8?B?L1J3bTFuUUVWaHpoTENkMTNRdks5Zk8zVnJWTHNyTVZaaEVIcEQ1WVQ0eXNK?=
 =?utf-8?B?M2RhNFM4eUE3TjRmUmcwWlF5U25PVnFRSTlVTlVGaW5XZmtBTnpMOXRxTWNp?=
 =?utf-8?B?WVRhOVNNbXUxVmZmQ01LeFlZVjRTcitMZklzRHpSYUhkZlRIbDVMRzNGSEdx?=
 =?utf-8?B?clpyYzBNYWpsZXRzOHFZUDlOL29tSSthMkc0T3hqdEtWOEVSMXR6UUljT0hr?=
 =?utf-8?B?MCt5M0gyVEcyU2FyMGFVRURlS251eDhCVFhMandJS01kUmJySlpDaU9GMGpV?=
 =?utf-8?B?Uk94d3VHNGUwNm1hVTY5THI3YnJRcVViekhEQ0xTKzdKTTVUTUtEcitlR3h0?=
 =?utf-8?B?Q1VuM1hUUWNTT0cveWZ1UDNSQTZuYjhjSkV1eGdYb0FYUER2VXBPZHlUdEw3?=
 =?utf-8?B?dGthQWpxSTBiVm92cFZPdkE1S2pyTUtxa2pBTlpiYmpNSWhPRVN5RXJYUEVN?=
 =?utf-8?B?Tzd2NDg3Q2t2WnUxbDNuYnJXcldxeUZtbnhSbWNLcHdJSGNIRUtqNnpqTFNn?=
 =?utf-8?B?N3ozN3N6dTRZVGpPL0NZai9kclFPMFlQSGVrc3FNTGN1d05kR01QTUVOTm16?=
 =?utf-8?B?djV5NmJhaGRRZlNkSmZFT2cxSlpKNjBieGRYeTJiQXdGVmt5S01UWlEzL3U2?=
 =?utf-8?B?SGMvQTJ1R2dZOUNEenNWdTc4bktrNFh3cFVseUU0bEZ4VjhOWm1pdmc3MlYv?=
 =?utf-8?B?WGdnZUtVTmplbTFmVUR4QVVHSHZzMlVJeXhzTjRmcU5Na3N6czlQbVpZVXZh?=
 =?utf-8?Q?CIhweey8eBy65MKjFr3BiWQ=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 06961663-92f8-4436-e527-08dc18c25bff
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 07:43:42.7440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgyZ4ny1bH2B7C/425u61TV8G9fiopr6az+tY5yVbEj+yBHgxjIEX6b+SKmYvxpiJe1/rybic/wVxEc+go9DnY61x+1Rih9HYJqNkdBOiEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6578

Use touch-overlay to support overlay objects such as buttons and a resized
frame defined in the device tree.

If buttons are provided, register an additional device to report key
events separately. A key event will be generated if the coordinates
of a touch event are within the area defined by the button properties.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/input/touchscreen/st1232.c | 48 +++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index 6475084aee1b..4fa31447dbc1 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -22,6 +22,7 @@
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/input/touch-overlay.h>
 
 #define ST1232_TS_NAME	"st1232-ts"
 #define ST1633_TS_NAME	"st1633-ts"
@@ -57,6 +58,7 @@ struct st1232_ts_data {
 	struct dev_pm_qos_request low_latency_req;
 	struct gpio_desc *reset_gpio;
 	const struct st_chip_info *chip_info;
+	struct list_head touch_overlay_list;
 	int read_buf_len;
 	u8 *read_buf;
 };
@@ -138,14 +140,20 @@ static int st1232_ts_parse_and_report(struct st1232_ts_data *ts)
 
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
+		if (touch_overlay_process_event(&ts->touch_overlay_list, input,
+						contact ? &x : NULL,
+						contact ? &y : NULL, i))
+			continue;
 
+		if (contact) {
+			touchscreen_set_mt_pos(&pos[n_contacts], &ts->prop, x, y);
 			/* st1232 includes a z-axis / touch strength */
 			if (ts->chip_info->have_z)
 				z[n_contacts] = ts->read_buf[i + 6];
@@ -292,18 +300,30 @@ static int st1232_ts_probe(struct i2c_client *client)
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
+	error = touch_overlay_map(&ts->touch_overlay_list, input_dev);
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

-- 
2.39.2


