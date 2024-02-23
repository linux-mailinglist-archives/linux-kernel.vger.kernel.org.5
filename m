Return-Path: <linux-kernel+bounces-77752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0600D8609C2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3A41F23DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE58610A2A;
	Fri, 23 Feb 2024 04:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b="Ta+4dPdP"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2115.outbound.protection.outlook.com [40.107.117.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C9DF9EB;
	Fri, 23 Feb 2024 04:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708661528; cv=fail; b=M5f8fN7HewRzmKp+y7jX9WfC7nyto1RmxBJu1k5X73cM4eOnCDQKBg5Oo1uNXy1fJl3T/8krsHLBigwv6ekVkGQSPU18IYPA03o3WVI29dY5eJ7aWpLll5RU8o9xWMzYby+wL4RdCxMkPdSTVefywI0o7+lRxV7KXv2KtKNbKL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708661528; c=relaxed/simple;
	bh=2gB01mfiI5Su3fSNl2c5D7daX09fvjYOGLHKTQ0Jcgc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=miSzkqGJ3WBb30YEZYVEbJJNlFE4OUdoi7ledtE0TbIY+6VS/AplY1gLuywtmRy1LgQZ4sFtSKsHXbPNXLNR2Q9WQCxHKGEqjiG7QEzMHfP+So/uNOO7925sIFrNVsiQn3fSIT41qT07Ln1fwyNY1rq8qm/PwtMkcf0Aber6NQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com; spf=pass smtp.mailfrom=qnap.com; dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b=Ta+4dPdP; arc=fail smtp.client-ip=40.107.117.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qnap.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyUh8lKK04nYeingkcU7v/0cpc+At2EaHg5lz188KBnTGm8p8ITinZkN+l0QWoQ/XFu0MRpTmZGkrqw1hcCfdyYJhYafnb1DA8J9j+ZmoqFkOKzEeKBWJGLzQwE8Y/5LIptc69StvPJR1zJkS2G8LTbt4swmAZ+ceH/TRQBmhMpEoLiUA0nDGGFscuGgSIWn2Y/QZq0nUURHfWrDV1gIMCo/sq4udzKGkJT77ICrU8IjqRUbpIZ8C7d8xQIyLQUfhKMJUyb6g9+82yhMzse/AVQL1cG+MFLDyvQKluT5xKTsp0zfd1GR4fQT9hfIB6l2g8wp0fxAyMLhtgJDqHO51Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcKMC+9CozGDANij/FQFNux6cWN8rZGiGfEwccn0f5E=;
 b=gTxk9qMK8rcbZwdC08pa6088+znE5BcssUp0MnVEHKS2p/jc3Y4XelcPNT+6+3qfPpKNoWMMB3sVR5RMjxDnFVZ81nBhw5JFq60oSRrBs1PXgxBE0ZBXm0GFCriBtSYk+sh631Bk/ooILMaNnJiIXicEMc88N5lcpwn7YjLr9PtM2nvi1+vbHf7varXlJENgGYaMPCkz0zr/4YlaaDp4JNPNz++3Ow6kvsmraZzpObl7niINa5WTtMsVpXJJqV6wGOtVvwPa+4V9en2FwvmJvIDGNSPlE/Ni73slYsWNkSLxQyXUF9Z89ofAJ1jVHbdqL3DelRRF6BfKPgHgbMjV4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qnap.com; dmarc=pass action=none header.from=qnap.com;
 dkim=pass header.d=qnap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcKMC+9CozGDANij/FQFNux6cWN8rZGiGfEwccn0f5E=;
 b=Ta+4dPdP3MLmBqLo/jYsicHYOtCWYp/ck5wnk08Z7Sd78gjx0a21uW/D1vo/GbxHyNI6iYiN/OMFT//TDTHWlp+ojDk0M2Z4WBk3YoTFlC5nhZZ+H8C2t8M4Z+FpRJsDZL1JnXe7OnmYTuZUfXZ8ppFWWcqzmXJvU123jB8wPvEPs63bQXcHRXC72gZvTUuCbQhMcGTb59qDVtSEIos11mVLcmefcUHsg0ZYlFMrx9i6qs8xy/T6CVzRU8Mc1ab6BKJd/jRMvCwcl3h1bEpXqK0suF8a0byaaOvGVzAAi+xYNrX3MYd/FzevMXTllLSwMAweTP4+m/30iCEKzjLDTQ==
Received: from SI2PR04MB5097.apcprd04.prod.outlook.com (2603:1096:4:14d::9) by
 JH0PR04MB7624.apcprd04.prod.outlook.com (2603:1096:990:62::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.29; Fri, 23 Feb 2024 04:12:00 +0000
Received: from SI2PR04MB5097.apcprd04.prod.outlook.com
 ([fe80::2f40:e11f:9d69:5bf5]) by SI2PR04MB5097.apcprd04.prod.outlook.com
 ([fe80::2f40:e11f:9d69:5bf5%7]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 04:12:00 +0000
From: =?iso-2022-jp?B?Sm9uZXMgU3l1ZSAbJEJpLVhnPSEbKEI=?= <jonessyue@qnap.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "j.vosburgh@gmail.com" <j.vosburgh@gmail.com>, "andy@greyhouse.net"
	<andy@greyhouse.net>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2] bonding: 802.3ad replace MAC_ADDRESS_EQUAL with
  __agg_has_partner
Thread-Topic: [PATCH net-next v2] bonding: 802.3ad replace MAC_ADDRESS_EQUAL
 with  __agg_has_partner
Thread-Index: AQHaZgwUAa7mb20qqEG8uJDe8uCv/g==
Date: Fri, 23 Feb 2024 04:12:00 +0000
Message-ID:
 <SI2PR04MB5097AA23EE6799B3E56C0762DC552@SI2PR04MB5097.apcprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qnap.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR04MB5097:EE_|JH0PR04MB7624:EE_
x-ms-office365-filtering-correlation-id: 72a6a500-aaeb-4317-cbbe-08dc3425958a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 32F7VKSqYmXyqbMd/reUE5e9JFBeCeCAk5SJXxtp3ew5HmFfOmxEORxSeu4IGGlApdShfino1MWdwasVi0JAoZaz+gA8ZMgSC6HT3g8eTOrTvXRJ6iPfjnGsCxGIpyzbOUDRgfnb35P/VnxMXNqmEm13+kFYKXA9fTkTxbrbDR2SQbK5A9MXYuIMzFB1pFCMybfyOSg3miyP5Gw14ZJSV3dDOJ1swzVOWZpOo/Du0Q9Esb0ypdblYlXh/lm55e4zeJiUUcBwkjgL6ElyavGTUKGZHTCqTEbHY2N8piGe+OgMa0TrvwVusjNM3SJMBGwu2B9GZKxSwz637pJga0wmPbua3FJh4MTsu+ll+18PkrG8SD0Jhv0AVufK1yrzRGY3/ccAYBSC9NlWSWvKWonAJfqZ51Z0/IYZq+1hOPUJqU0vWZ0+LfGkRwQjd1AvRu24b7apRa5gJ/r6mblkncVoHhVxV9iI2SUIlV1iAwNKZ12iIr0LmKb+VAESsFfhr5C9thLrV5myXDp1ZiEdqscCD7jevp2XY8UNMtWyNDfeCXw5IiT7Xm+NnsRTA9qXWQojexgDvJRP6MVJyXMYqvEOHslhPGLBt5LVcGki6HRw7qU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR04MB5097.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?Z09BUlcySXZVaEVRNUM3NWhSeEEzdDFldUlBZU44OXUya2d1MXlQaWpQ?=
 =?iso-2022-jp?B?MGFBcHphVmJvbjZHK2JjVTlCMkpoREJkUU1DT1pvZ2xRODJWaU5mRDhi?=
 =?iso-2022-jp?B?eGdrdm1weWxSS2kybTVUZDBLRnIzaGtRVytZUUh6WDhHTzNDSys0Y2lm?=
 =?iso-2022-jp?B?ZmlXVWZnWkJEWXJNUUk3d1l5REJuT1ZLTjBNSVVIR1BJeXk5eHhzS0lj?=
 =?iso-2022-jp?B?V2dzTis5Q1N6R2E0ditWRG9PMDY4QVBZWEZBR3B1aEpyZk1ScXJzcWVF?=
 =?iso-2022-jp?B?SUdhL2lOSnI2RG0vTUdKT2hUQmxOb0dsc0Z6RGFDODQ2U1RCdjRPTGdQ?=
 =?iso-2022-jp?B?a1VKcWVXcDRWRG96MjVWMWZyU3VXTHFvekdDT0krZmZNMk5kak1EOTMv?=
 =?iso-2022-jp?B?eGJBQVFPWWVYNWIraGpMQlFHblVKNlZ2c3QvTWljSXVDM1pReHBmMFk3?=
 =?iso-2022-jp?B?TldYaWVNV2oycFpkZnNuZlNLQmFjOStDVGtsVXg4dGxnb1F5c1p6ckFo?=
 =?iso-2022-jp?B?RndGMnBuTFFIMDdIOFJZUDBwVTdQanFaOHQ1WDVGc24yS1pIeHdGek1X?=
 =?iso-2022-jp?B?eGtGMGQ2VVU4TTdMMXhoOGxERnhGUUNhaVJKWUVOQ3lqS3FpSFM3ZWxS?=
 =?iso-2022-jp?B?ZStBbFZPSjdhLysrZ2JDdlgrcTZIZDJIaU5jemltWjBUT1FIck1HQjhU?=
 =?iso-2022-jp?B?ZElia0pxeXpiK1N5UldVYlBQcXV5RjVsRU1nSkRpVEhRTHRzQVZCaWZR?=
 =?iso-2022-jp?B?NnhRNGp0eDl5TjFjL3pXdTJQdjl6dlk4djZoekx0d25QWFdSd29ad1Jj?=
 =?iso-2022-jp?B?aThuWkdnN0lzL1cvYWpKODY5S3czYTFzZHNDL3dCemlzWFV1MTVvTVU4?=
 =?iso-2022-jp?B?MEdFakw1ZVY5M3QxUGhONFJwd1U1b0VuTHR4dzhtT0h3WHFja09WRURB?=
 =?iso-2022-jp?B?TkJBWmg0ZGNsQ1A1eEh4QW9uN29kbVFxVUw1dVRzeDFXMk4wMmNwU1BY?=
 =?iso-2022-jp?B?dDV3MVdXYUVqY1kzTDBDdUQzVkNMYmtaaldNOUpHNUJEOU4wSWNlenQ1?=
 =?iso-2022-jp?B?aDRaRHhNSkRqRjQvd3BoS3VWdmpCVVYxK0JqSXg1U2xKbTNSMnYzRm1Z?=
 =?iso-2022-jp?B?UW1leGlsZnVrM3duN1FJM0llUXRabXJobnhkczFFOTZQQkxYcGJhM09k?=
 =?iso-2022-jp?B?dmdOcWdKRllGT0VtVHBWbGl0OFIyaXlPZ2tyT1NmdTJyYldueEpzOEMr?=
 =?iso-2022-jp?B?S2NJM1dmalgwVGQ4aTNpMmZkZGI2NGhodWZhcG5YWndpcUdWNk9zSDNU?=
 =?iso-2022-jp?B?MTV4eVEyL012VkVxU29HdkJRZWtaZm9JbGlhTHcyZU5xTmcxZmw2TE1I?=
 =?iso-2022-jp?B?UFJxTHZlOGhwY1h2SWtybTV6MTVKcEIxMkh3WVJGNFpmOXlRVE9WU083?=
 =?iso-2022-jp?B?TCtrbFdFbjBvRm5UMVBtSnJNS2V3VGlsU2s2eTMrR2JJTG1IS3cwUVJ4?=
 =?iso-2022-jp?B?UFN0N09pRDlPS0RycDE4T0x1aEVpUmRQUlR2V09ONWg5TjRCc1F0c3Ew?=
 =?iso-2022-jp?B?cnl2ZjNwc0hCQ29NNEpYdWVxRyt5d0JWc2FtUjZ3YlQ5RWJ4N1VwUms4?=
 =?iso-2022-jp?B?NmlaZHllMHFoOHRJdWhJMENjWkxva3QzcnJ0UnBkT24ybmFlY1Z2Ylkx?=
 =?iso-2022-jp?B?eDBPYXc3WjVjWDEwZkU1YnNCYU5ES2JrNndYeW81bndvNlAwQjZyL3pF?=
 =?iso-2022-jp?B?TWl4d1NmcnltVTN0dDNjY2xZOGRvcFZ3dmE5QUJkYUl0Vmk2cTRqeVdz?=
 =?iso-2022-jp?B?VXhTZmFaajFoOUV0dmc1RFl2NkR1NERTTXdtd3VCMzNhNDlkNGsxcEQ5?=
 =?iso-2022-jp?B?Tk85TjdPeFJ5RXdsTTNMRzJKQ0tKK0hOZkJhZ3NDaGc3Q0Y5UUVBbWU1?=
 =?iso-2022-jp?B?MVJOS3FJank3UDBGaXFEUUZZY2VQQVRpZlhoOGRoTjRSNTJJeXBvaFVv?=
 =?iso-2022-jp?B?VHdqczhHOFJqRzNNb0QwUTR2U0FScjI3NmJiYmhsZWUveUkwZkJRVVZ6?=
 =?iso-2022-jp?B?eklrVWR1VnUzdnB1QytpNjZBM0hqSlBLcFFKZHhLWXQ5MlowSnlPRTVq?=
 =?iso-2022-jp?B?M1BXa2ErRkp4YVl0WXF3cE9ra0tnWlVxMmlnem4vK2FhYnJEK2RKWkhM?=
 =?iso-2022-jp?B?NG4zQU90ZEVWV1FMR2Jtd1l3bU9hd2taZkIzT2ZoYVpMaHpXWndjbWtP?=
 =?iso-2022-jp?B?NThHUUw5Ykx6VDlpRStVWWxCalN5KzI1ST0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: qnap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR04MB5097.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a6a500-aaeb-4317-cbbe-08dc3425958a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 04:12:00.7006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6eba8807-6ef0-4e31-890c-a6ecfbb98568
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k0YERYfYGhgiccWP36fCScaoXtKDkpL0SrGItgjwzWNgSMChow8OLSf8k98uwRwOpg2ym5mq3an382NFp8tNGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7624

They are verifying the same thing: if aggregator has a partner or not.=0A=
Replaces macro with inline function would look more clear to understand.=0A=
=0A=
Signed-off-by: Jones Syue <jonessyue@qnap.com>=0A=
---=0A=
v2:=0A=
  - Add correct CC list by './scripts/get_maintainer.pl -f Documentation/ne=
tworking/bonding.rst'=0A=
v1: https://lore.kernel.org/netdev/SI2PR04MB50977DA9BB51D9C8FAF6928ADC562@S=
I2PR04MB5097.apcprd04.prod.outlook.com/=0A=
---=0A=
 drivers/net/bonding/bond_3ad.c | 8 ++------=0A=
 1 file changed, 2 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.=
c=0A=
index f2942e8..eb3c2d1 100644=0A=
--- a/drivers/net/bonding/bond_3ad.c=0A=
+++ b/drivers/net/bonding/bond_3ad.c=0A=
@@ -2036,9 +2036,7 @@ static void ad_enable_collecting(struct port *port)=
=0A=
  */=0A=
 static void ad_disable_distributing(struct port *port, bool *update_slave_=
arr)=0A=
 {=0A=
-	if (port->aggregator &&=0A=
-	    !MAC_ADDRESS_EQUAL(&port->aggregator->partner_system,=0A=
-			       &(null_mac_addr))) {=0A=
+	if (port->aggregator && __agg_has_partner(port->aggregator)) {=0A=
 		slave_dbg(port->slave->bond->dev, port->slave->dev,=0A=
 			  "Disabling distributing on port %d (LAG %d)\n",=0A=
 			  port->actor_port_number,=0A=
@@ -2078,9 +2076,7 @@ static void ad_enable_collecting_distributing(struct =
port *port,=0A=
 static void ad_disable_collecting_distributing(struct port *port,=0A=
 					       bool *update_slave_arr)=0A=
 {=0A=
-	if (port->aggregator &&=0A=
-	    !MAC_ADDRESS_EQUAL(&(port->aggregator->partner_system),=0A=
-			       &(null_mac_addr))) {=0A=
+	if (port->aggregator && __agg_has_partner(port->aggregator)) {=0A=
 		slave_dbg(port->slave->bond->dev, port->slave->dev,=0A=
 			  "Disabling port %d (LAG %d)\n",=0A=
 			  port->actor_port_number,=0A=
-- =0A=
2.1.4=

