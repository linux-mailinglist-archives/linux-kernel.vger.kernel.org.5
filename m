Return-Path: <linux-kernel+bounces-41647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6179583F5D9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 15:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177B0281985
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 14:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4052560C;
	Sun, 28 Jan 2024 14:23:28 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2067.outbound.protection.outlook.com [40.92.89.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B97241E7;
	Sun, 28 Jan 2024 14:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706451808; cv=fail; b=fEXMkVWCt2iMafJDCJTr0lk5w+5kEoxZ1So3xyD57hpHsNHylB7qmzyj+Pm245fFPPMq0qR1Ex8tDFuSZsJ0pE9vIBayTaMgd2ZkJwv/kQQ7+6Z6HizBzPyytZydLo0OYlLZXCJSUN5FJj8Vu/MDauna+XsEj4xLDtjh356zfMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706451808; c=relaxed/simple;
	bh=d2WMKZY+3t9jbldqzkavAqU5GD8DKg10YeWWzr3jUrE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kzgQwOH4odQFUx+oDfsXepeb9CcMWZxJ0U/itub/WQ/jpRxPQ6cWF/C7g/PJ3H+K/ufC2v1QMFOiNv3JCcrNu2JGR3BfoS0IwkCB4DMev3+SLb1/VKYDINA27vtSPISLYCka6R6GyPdIklBANL9EO5lMC0GL8ouWo3Wi9B+5aoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; arc=fail smtp.client-ip=40.92.89.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQroOjk/peCMon7TpLfejotRrjQmFBm3uYh+yMeNdiLFR1yaJII+Oa1HhpXCqiL5Qs39/8aeEvq7mNrFxC9yhnZKF6xzwG4vaeogplkU/sDfO9ZV/mvFA2OyoVHHZAhQjQslYlzCik8095ry10izfh738qhxJtOSv/eMvtAuzmv0iDT3F4WRSGzniIWOb1tH3I5M5hexLcCEpg4Bm+eFNjJlqSke1jPi3EUQD2FKFXWaQg/Umk2ukJh41tWlFqpqJN3b7FWA1piwl/ASW4r3SwclZ5p3NWObt9vmD7IN2S8/CnL162FFltGAZqMrsHsxJuE6aZsg+4UDaqJuhcwLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qm3HM7lQpUjQ1nzPiH22X/nSNCuj3o416xBMbM7HM50=;
 b=NsQGvt3gbu0j0hJM83Pc3eWT84OzQiFu8iWaRJPNmqdZZQCiNfmStIwTjXB7o5Q+PM4xPCUuGBYO7UqNv1R03NoRNDPesS2VRMI9TFzKbPciiQFomZM2xdCSt1qGAqByzCUiJhM8kl9lc2HoYTrCrDUxeolmXfPZmK9BAKbDEwsSwdaYeEynLzFgSJqeGmyHUSalaQWpbyWJZUjRrkU9qgPGHYK71ViQdxr8YJP9zStIY7ZA7UYP3gy3xorqb7zS7AUJ1xBZePsXLrpfpjdbxH0SvUjVz6VOg9cKmJ6Md1FlpiVLvtx7+A6eWZuo0XeNNBEgoWYjrygVgM7kmV3n+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com (2603:10a6:20b:47d::10)
 by DB9PR03MB7401.eurprd03.prod.outlook.com (2603:10a6:10:221::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Sun, 28 Jan
 2024 14:23:23 +0000
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5]) by AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5%5]) with mapi id 15.20.7202.035; Sun, 28 Jan 2024
 14:23:23 +0000
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
Subject: [PATCH net-next] net: sfp: add quirk for ODI DFP-34X-2C2 GPON ONU SFP
Date: Sun, 28 Jan 2024 15:23:06 +0100
Message-ID:
 <AS1PR03MB81893D69344708C98EE2B470827F2@AS1PR03MB8189.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [IIiiBF5+Rhd7ugK03V6Oe7V70fxjqOGl]
X-ClientProxiedBy: MR1P264CA0003.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::8) To AS1PR03MB8189.eurprd03.prod.outlook.com
 (2603:10a6:20b:47d::10)
X-Microsoft-Original-Message-ID:
 <20240128142306.9120-1-palumbo.ser@outlook.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR03MB8189:EE_|DB9PR03MB7401:EE_
X-MS-Office365-Filtering-Correlation-Id: 990fe7c8-c0b2-44a4-ec35-08dc200caf5d
X-MS-Exchange-SLBlob-MailProps:
	Mga27o8vReGfIc1VICO0dmEM3GFX/n+pKij/noRrFm75yCKydnQV05IGpsbeQPm3bsAL+K7Ki3WKjxUWTI4EnK74GQnS0jRKN3bo4tAawaKXr2ff/u3ZcnwcYx5ByBZVjO4yqUNl0pJm/vJ0y8sVgbv/ZQpFvU7R+YsRlNiw6nrBmezvwqn1aP2mrOL2fQUThCgVAi44+hPtTzcFUriI9B2NV7dS5Kbr8SiJGqIlnKbqowZuNg/Lkn4jtbYYI/jOI5C03nP1INn2l6K+AJx80m+lNmtUv5NTe09XSF/YwYJAXbV8pqj5cI+ztJnOdR6HdCy9fBSc0laE0H+1YyU2lIXtcB9tHM6spyw8E5lywWvG8OhHwyaVeeMh7TaqVP7xwGod1sk5kbmujarw8g3VouW2LZNA2jvVB2XiX5mqNUssoZF49r5rjAkAnp+58K9mRX+fjMMvLh6sA80dyGkU5sO/BcusFFAQNoGmIWTiEcIxqph9lGPpQpzlsdEkFeB5PlKj1hZWvU9OJMMpF6o8cbEwzdvva39dfhJs0cyk3DykFUH7yEx4X1zJn/hyt5sysnB5qTon+vPnsO0U3JmxmaLj2nikBvHqt//wAzb3WqaNuoKPRi0qgIXxPISjLzxHyKasoB6EeSYUhzn92+d8VLdgaIJc9eFrsw4MYX3hwkVsDOWPuwlzYo5BTPeBRZ7jrEzJZfI8BhQHbGYJveB0M1ILcgBDz1zbWVabhPc1lS4QkwYPSs9ZNoyCIS/M6/4+PB/JDR2mzokaUQr20Qf4qLCk7/muXJH4B8ADdVMC577dp1t7IAxFwg==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OIoodg/yS0KIEMLcdmrLV1YX+zoBI1CinD3JikzmhigmtxbLijl8LWLndv/L7ANcs5W2c3hR1KG6V4z8sCtMXVFJcFZ8aTHanliPXVeTTuhCox4qw8t5FEyWCjFrwHhZy3uuTDfvNkYUTzLXS5fomk+/qzDq68HXIyc9cjt6bE5yF+leHKCxD+dKY7vng8ALc51Y2UULblTYWxYHcU1TwJ76DVdHRga1HQvx514oipF+S/WIgihcYDzcbmzv8fe67oUYcJQPulbp6pEupE/a3qo5RrZFdu/Gl6JM2q0RW+FvDr9n1yK9210AG+HfmfcXVOcGXhFsQ9RxdLstdYjytn/T0m4HvuD7NhN/WJqtUiMiFg0o7pjssFiBsMwVPZuxhnHItySd48gGjwClXUaeorPS6oDE1Zx3BfagHeQyBaOl8qOf2bKDX9EoWxKbnua7SCXVGj5QrRNnMRy0leCsqJoVxEUGN2qBnZBpi90wBgq72X06SiMh5pqhyiaMwVyitECyYNQVRvdwaZbCHGvZknQVqe1DU/i9LAyKB+d+1Zd6OXnS/WQ7ClcoBr8b5rwY5qLEVJHz/oZNzsROdYDft1fPjYP8lIviuUvMnsG2bXo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dcop3k5xDN/lKiPMBmHljy8f4fZQPEk+E2iPpfnbY7emJcSAaUh9lMJ1W0w0?=
 =?us-ascii?Q?WQSkCNFzvXPZPqR9Pbyws9fm7lI6fLN790F0iQq0YrXTr+jy+DccnNT42dKu?=
 =?us-ascii?Q?a7g8XLmArDEJ1uAxMei2PJ1A5fkjnlRq5xIRTIIY2zYNlcnjiewLllE8l05n?=
 =?us-ascii?Q?Ffl192FrkWLAue9+n7xUVDECERaedvxVmDgrrbJzdFOXX9Qw8yMU4Yquthf7?=
 =?us-ascii?Q?eK+9yc3UdEkxsPHKWqwYLdcxTYQ2lI+0Bhjnrm1u+ZQxUeGrGiy8QZK5zNjn?=
 =?us-ascii?Q?Db+ateYbK1Lzq0XuLdecJkEMGb+dC+K8d55jGdAqWSWflhojQqkv1Vy2tG91?=
 =?us-ascii?Q?I32zT7GDW73EXnsN7O+ZPpTgbuX7ubSdHXuc8oWNnb62wZFmBIHBK+WH7HAW?=
 =?us-ascii?Q?dzlaHi61KvtGXkMErYHIr7v8rgmoSuD1RODtQbjrS878ZO2IOgXGhph6Q9AQ?=
 =?us-ascii?Q?WYccaIn3B6Dq5Ya9nT5TKLX02PZYQPfhP+NhTMnO9cxUBeMGaqjvuWHE33fo?=
 =?us-ascii?Q?En23p8wpavxrXD/UqnWhzF9MY3EtIxmPhHxTOvG3S1Ge1g4M7JXHvsoLwNFx?=
 =?us-ascii?Q?ywh0BZEFROGNgmrZck8RkcNVZyDh72n3SWqmRBob+a1CpAvdE1KGNY7xGLGh?=
 =?us-ascii?Q?ufzcR9JPfokKnt0dXtDTZIsmWBnbBfsZ9eHFhdrU24pTkFeHp4V4EwCilBAd?=
 =?us-ascii?Q?cl58FctlnOkyl2vgJdvPyN9W5hjkjv/lzFlyuaTv3wbxBEAXTEVE19dp4wjV?=
 =?us-ascii?Q?3U+GtOhviA4W3DLjWodJUWDoDxBIycWAAt+oiZ2OeKIkZ+DR4F8E4IIW596r?=
 =?us-ascii?Q?C/UOcCeP9uZ2aRABqYEj3EA4wCvz0TMmibKhlZ3H8wUYXSa18gsqSQ/FpZM2?=
 =?us-ascii?Q?RvF14r6sonVFUhGnWjvXIJotk3sdxiRJeJQhW4spoXYX2O5b+uydiWuhXvqY?=
 =?us-ascii?Q?drF6om4if6zm6wz2VcRjBQ4y7R/yNu0eSARI+ScAF8wkpIVPMa0lhSF+NLnV?=
 =?us-ascii?Q?jcWFzL7nkAt0s6vjRmGFdr8EJKQe6iuoqDdEKMZsAtcFbcuvHO/rUkeAQQoy?=
 =?us-ascii?Q?t05al8egDxLQIKG/yfVD1NCvQTw9qwWv0ni9QupCDovAZe58vx3l2U9ViRNq?=
 =?us-ascii?Q?TC8w5JTrsseULeILYDmCfX2AGKX90NeBUODco/TLyFdXjQvuiaas8fkvKNuc?=
 =?us-ascii?Q?A8OOXzdrZ/hArCt4TgKxF3mSu2Y0gJ62eRYdPdfa/rX2fcNFLufgoE1E/Rc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-76d7b.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 990fe7c8-c0b2-44a4-ec35-08dc200caf5d
X-MS-Exchange-CrossTenant-AuthSource: AS1PR03MB8189.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2024 14:23:23.5314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7401

     DFP-34X-2C2 is a GPON spf module working at both 1000baseX
     and 2500baseX.
     Setting the module to LAN_SDS_MODE=6 the module is working
     at 2500baseX with auto negotiation see at
     https://hack-gpon.org/ont-odi-realtek-dfp-34x-2c2/
     Unfortunatly the module's PHY is accessible at 1000baseX only.
     ethtool returning:
     Supported ports: [ Fibre ]
     Supported link modes: 1000baseX/Full

     After applying the quirk:
     Supported ports: [ Fibre ]
     Supported link modes: 1000baseX/Full
                           2500baseX/Full
     Tested on BANANA PI R3 in OpenWRT v 23.05.2 Kernel 5.15.137
     Tested on sfp to ethernet Media Converter.
     Autonegotiating 1000baseX or 2500baseX according to the
     connected host speed.

     This module is existing in 2 versions:
     Vendor = "ODI"
     Vendor = "OEM"
     This is the patch for vendor "ODI"

     Patch has been inserted keeping the list in alphabetical order
     first by vendor first and then by part string.

Signed-off-by: Sergio Palumbo <palumbo.ser@outlook.it>
---
 drivers/net/phy/sfp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 3c0028a4af92..410375bc6b94 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -495,6 +495,9 @@ static const struct sfp_quirk sfp_quirks[] = {
 	// 2500MBd NRZ in their EEPROM
 	SFP_QUIRK_M("Lantech", "8330-262D-E", sfp_quirk_2500basex),
 
+	// ODI DFP-34X-2C2 GPON ONU support 2500base-X
+	SFP_QUIRK_M("ODI", "DFP-34X-2C2", sfp_quirk_2500basex),
+
 	SFP_QUIRK_M("UBNT", "UF-INSTANT", sfp_quirk_ubnt_uf_instant),
 
 	// Walsun HXSX-ATR[CI]-1 don't identify as copper, and use the
-- 
2.34.1


