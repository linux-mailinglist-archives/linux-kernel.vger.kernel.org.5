Return-Path: <linux-kernel+bounces-41606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F20183F54D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 12:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E152822A4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 11:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EB2208AF;
	Sun, 28 Jan 2024 11:56:58 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2026.outbound.protection.outlook.com [40.92.59.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9858B200AA;
	Sun, 28 Jan 2024 11:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.59.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706443017; cv=fail; b=d4FEU11A2xm10MfLUwTkF9dJMKvZZMphsARxy25zudS6GPTiCBEhKhVLQlMUoU7ywtuuORoXS3DrfJNzajA7FaQah6JVcRhZK2xyqG9SnalE5VOLylI51IdYqJwr30S8/WbxK4KZSw4iJFdebZmG14WFBBTkcEde3GPU0t8B+zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706443017; c=relaxed/simple;
	bh=UgsXPaoDs8H6h3uiW+dlGv2MoKDLED7s9q+ne/AUsFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AU8I9cYvroF5ebEbv2gUgrGEYpuz3dQpe1fJU+cY+KryaWBHGn2hPUVgOI2pqjlFmfNnQf9FWpLtYapahAqejVDmeiW02dZZq1IAcNfTcbVu4OaB6/DFmTQ57AG/Yy7aJspozLlUatlAYXoka16tDj0Lvw0tjtMwmFWO6+oncPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; arc=fail smtp.client-ip=40.92.59.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBe/dxi4GfWKcli80cXbHJUsE05P8AtT01q27lvML/kgN4XdWiD7YnuqM7vUBS+J77OVEpTJvwI0p1ExIEtWRAipYwAsCi2iHTQLDUSkmrGNfzDpNT9ZWv01DMsMNMViTy/WZ29l3Y01EiAM0by+4FW2WdvdBgUnav+dZYhv6uon8xtDJ+sT+R9szvDkUa3DC1XTgRGTXK10o8sKuoNdKLQaybSReR0eEX4NOy7YNRSWMCIiRnQhIGOjq5vZ7lBKVCM+ugp53KUNDWxlcfKt2Xu71wOXWS5z4h+jJl68KVYiWNbgfKvbX36oGoAWbSrzRzzbbmH4rkB/OY6cQFOznQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2X1cCmQlH7uQqRiokg2ArH8Y4glMulVK9ARLleL7ChI=;
 b=nfxhRtIGf/2vQi6vGUvuySydQtVsLratd6cFtbO+5H44EKlI2qCPjwfByV4oC4vKr5spP0SdOlerka562U7peoXfZXToGe0Ut0aYELRyGet1JePJDCTENOZ5A4SHOsNU2onAcb7YtWOKQNICd8PGVL6648BkF5zONB3jjnOsaYPacsVMaY4CQU8DMFcMNPinCOoEuhpJsUiyFiSMLgt+/nuykBPp4NPW6BKfUwMMTjz+efR491mzpeVYHAQsa7HajdkJBJiXkGf2Svz7NLxW9QEcXk1F+IH1zG4+wgUJuayl0kmqCvsa4L3o7tTpTYxHfq7J1TV8i+OwiOf0lvs/Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com (2603:10a6:20b:47d::10)
 by PAWPR03MB10134.eurprd03.prod.outlook.com (2603:10a6:102:342::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Sun, 28 Jan
 2024 11:56:52 +0000
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5]) by AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5%5]) with mapi id 15.20.7202.035; Sun, 28 Jan 2024
 11:56:52 +0000
From: Sergio Palumbo <palumbo.ser@outlook.it>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: sfp: add quirk for OEM DFP-34X-2C2 GPON ONU SFP DFP-34X-2C2 is a GPON spf module working at both1000baseX and 2500baseX. Setting the module to LAN_SDS_MODE=6 the module is working at 2500baseX with auto negotiation see at https://hack-gpon.org/ont-odi-realtek-dfp-34x-2c2/ Unfortunatly the module's PHY is accessible at 1000baseX only. ethtool returning: Supported ports: [Fibre ] Supported link modes: 1000baseX/Full
Date: Sun, 28 Jan 2024 12:56:25 +0100
Message-ID:
 <AS1PR03MB81897EB6C46BCC9514CB55C7827F2@AS1PR03MB8189.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Ij/+dckAOUh8i5q62aimpnsGqBK2bLqw]
X-ClientProxiedBy: ZR0P278CA0129.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::8) To AS1PR03MB8189.eurprd03.prod.outlook.com
 (2603:10a6:20b:47d::10)
X-Microsoft-Original-Message-ID:
 <20240128115625.6278-1-palumbo.ser@outlook.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR03MB8189:EE_|PAWPR03MB10134:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b3a6f0f-f4cd-4c2f-67e5-08dc1ff83433
X-MS-Exchange-SLBlob-MailProps:
	e5BdfXQOl3MkenxTmcf80xFmDy4LLhxfFIG4HFXHelWTr5HbYXePbZad1+xhwZ6De5RRT2nLX6pU9BIe9i8sKTyZq7KtTgk9RDiDiRBoy+HQEUHaqoX9KdR4XJMi111voeeAQbLwENsPBNcQy48aKKUhgEagGQA627EoOEQMnwfbE5vDWfRw9d1VD2GGEQZ08b4xe++EQ0rHvZ7P9xwB+ZlZzYyqYlz24tVP8IR24tC7R7IAxVzl3cVuHjr+eyDcWPilsqAoIsYGug0jqZ6Fy7Ko+y8pOzW3r2VsRLnmy/5omK1B6qn5BhOskQMeJlpu9wcYnQViJOFUxtRbO+OkWJPFMpljSBmvQ2T8077J3bCv2xYMq/SfWkYW0IpYXkChK2UGQDqAUK7pxxPGWgwkrLU8Lvnx3u9VvjLiLKWdmABeKcGVnsWEd0ZE3zaJvWdQlVu75cm72pGD5wuFBFFGchmKlqoAnbxrTFHMooNOvKkbtuoWESKGIGaCHfgpd48SmdosGZhaJJHsVCKr3G6MIsKMJXqfXHmKSQhyQvsmapVTjr5Eb5CXnZIzsH60K41Oy0Umu6ydGYnV1RbGiQ7v5857tsFj7oQNo+uJ/Fv9gRWySUiWGOuvLz9g2yBEvz0pAp2w/ZUv9ReyQAyo9BJxpvbBdIV7HsS7ODq5AIBaAEM5lEU3TCAluJ/hYZVrZ63if0qbN94U/+/2HDxlXLXe/J57ezO/V1LJlICbRHEtIHbUji7w/2NLXHuRj4sj+UUYhS9o2Ha+6/b/FDnRm7Usvd53O/U4gxioj/2D481gyk9puyPet3F8Y4dheIuOPSWHZfZT5L8ymHM=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OSLBv26FxpCECm1X4jZsxiDS94qJvDrnDuZ4F1YCgsotu3HlqO+4qvIeRrrP4ecexWt6SpbEm1B7kdYPeb/FU0Xifb5C3R8VJqY1/eOZNe7txJqWe5arMUbOmkYec+FildC6vLcO8DwhzAg4iLNjYol3fhHal/yxGXDNI2XKfehAsHoFa4e5c+TGooQwZn/jyVpg3vINT7FuqQfhkYbm3PXzLFSkkfrelel74798SUq9vr2wzPf3/cBHZGJFUrTQ6fi/PEhkEq83YFspw3TSjtrNCa5uJtJ0hBd3Je2LwoRKtws3XlZaJ9xo3XlfUAEADHQ0Dzf94D7K5YcgnS+COb6I4ISTau9TQyD/0EEHUj2e1NPl6OpLtncqEbsLcexG1CSQXV2E6kgZes6B6cw6kEnr29aCaNRBOudqb76vZA5/enfvQYBtGTrw/y+jdZ9e9IGWIxEnj0H6hMsAaCWwdC1Zy5C4BXRMGpKOLLcEH2kZLUfgLeAbNx0FYcd9Q6akyU9CZdamlTalOPajcpOzZDP4DDTpJzUKVBu2uq4j8bQ7KhdfDtBJJVN5KcA0ULA4GQC2+Tawut7Fxkd4oJMFrZ0HK4aMYTAk25hdmFaqV80=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ug98CNzNlzn9L3h5OjPtLQ7xJDF0jjXvhE5oAoqKjYaPVSI62DPd7cWXRMZ1?=
 =?us-ascii?Q?so+0cfcTa0Hn6wLhTIxeciR/WeutkdsIdj1URsoSkwPRo4q5LiJ2f8E6a19B?=
 =?us-ascii?Q?b2xn4mzgSHkIzk4wV1HrnkO7cUewxnLgyUWCELhsQGS49mi0eWupluCzqEpT?=
 =?us-ascii?Q?yb+5zm4s/bZ9n3Q0UMYp5MCPkekT3n/8jKm2hIwVgSe9HpC434km+XRpIc8B?=
 =?us-ascii?Q?ccsDv2o8YoGM64dy1vujJqsTLdu8vx8S3PyQTG4ETtK8gmhblOohCY+QD2KN?=
 =?us-ascii?Q?32wSAq1U9MQd3woIEaOZyqYZQFntEUPNio5d8O/uTjR5wrnzL0SeJ05T4/4/?=
 =?us-ascii?Q?XggzYQfQ9FGlg0ez21YdSh/F8jY2ZK2j3z3YxX2/gRKOvQMitiFUFzV825xW?=
 =?us-ascii?Q?D758nt9UwwLzqwmNbJt2+ce29FylrOqAMZc87LwJH4Q1IW+h2JbDwNaOUXGj?=
 =?us-ascii?Q?IZ74YX/TeAN9e7gQs9v1LrkgGfLoUg8lnX5Jkv1JyEwP0u2+FbZHPdTSTv+8?=
 =?us-ascii?Q?/QUrIig+W5AdKd7KIJp3MV2hvc4qhUKO597a46SalhmDwRGMMPFd4MLRY+iL?=
 =?us-ascii?Q?gVZ/xEUGnOvtKR4Cf2wm61RllY/c2b4jXFf7QETlpWewAhxv3aR374c19Hjl?=
 =?us-ascii?Q?XdT9Ip+DDWHksPGNf7DwfFzq5NZhlsurMlRvTSc6xq71hrq0JZY1z9hkBeF9?=
 =?us-ascii?Q?gKAHNhFKz1jwobOaqFeiJfxiyle6sOXJnVnMi4eGj4nh6aCN2oy7mg46aGJx?=
 =?us-ascii?Q?yqJEkZCVNCZpxg1jPYAbw2WV33mpoACirGrxc4UMLBvIl+4KfivbDHvWgXX+?=
 =?us-ascii?Q?BLe+U4vp3iERIfaijI2ahrA7YhqsAB0VM92q19c4hGnYQrlOIH2OZ/gziV9m?=
 =?us-ascii?Q?c7ivWLn/QlGdiOagmaFWSypO7C9nnJ3VizM8wb34kbXsf3ep9nKbHwRSoBNQ?=
 =?us-ascii?Q?/AYsqxdF9XuMD7LC4Gt+iy8Onap/9DEI7mDhdExifAu++vsuUSPZhl4Gxf6F?=
 =?us-ascii?Q?0ow9U6QUF01EoCSumedBCVovVprlPeyJ8grxtaGAibKpVTpRsiIzvvig1t3j?=
 =?us-ascii?Q?pAKo+LUAUZrftQV4RHjzJD231z0bICh8dhF9cYZCldA8kc7qEsk+Dmq4Jr6o?=
 =?us-ascii?Q?qhs/6wmNQA8nzL6tESILFOGop1Je85QtpDb//xQcNK/iZNZJots6LpwQUEO/?=
 =?us-ascii?Q?vs3cDFrhioe6/Oh2GYJo1U1Gco6IKjghTu/c8awmJF9SUvRE6Eda4iks3tQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-76d7b.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3a6f0f-f4cd-4c2f-67e5-08dc1ff83433
X-MS-Exchange-CrossTenant-AuthSource: AS1PR03MB8189.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2024 11:56:52.3972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB10134

 After applying the quirk:
 Supported ports: [ Fibre ]
 Supported link modes: 1000baseX/Full
                       2500baseX/Full
 Tested on BANANA PI R3 in OpenWRT v 23.05.2 Kernel 5.15.137
 Tested on sfp to ethernet Media Converter.
 Autonegotiating 10001000baseX or 2500baseX according to the connected
 host speed.
 
 This module is existing in 2 versions:
 Vendor = "ODI"
 Vendor = "OEM"
 This is the patch for vendor "OEM"
 
 Patch has been inserted keeping the list in alphabetical order
 first by vendor first and then by part string.

Signed-off-by: Sergio Palumbo <palumbo.ser@outlook.it>
---
 drivers/net/phy/sfp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index f75c9eb3958e..260917488c77 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -502,6 +502,9 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_F("Walsun", "HXSX-ATRC-1", sfp_fixup_fs_10gt),
 	SFP_QUIRK_F("Walsun", "HXSX-ATRI-1", sfp_fixup_fs_10gt),
 
+	// OEM FP-34X-2C2 GPON ONU support 2500base-X
+	SFP_QUIRK_M("OEM", "DFP-34X-2C2", sfp_quirk_2500basex),
+
 	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
 	SFP_QUIRK_M("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
-- 
2.34.1


