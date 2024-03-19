Return-Path: <linux-kernel+bounces-107351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0248E87FB56
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D0E8B21BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A66E7E101;
	Tue, 19 Mar 2024 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iesy20.onmicrosoft.com header.i=@iesy20.onmicrosoft.com header.b="LxfUnZy3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=iesy20.onmicrosoft.com header.i=@iesy20.onmicrosoft.com header.b="goFJTg40"
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2104.outbound.protection.outlook.com [40.107.127.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959547E0E4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.127.104
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842125; cv=fail; b=U8tj8iXjSK14+WNJ+atCjq4LFQVb/PeNvpnrfgCx7r6kwJd91QaCiHJPIOfwTwT3FyfQEFFMlCBkNjbYejDXX5Wen/DJvNEb7WUEmk1EOAOdrmEqVzKHPiGmEkm5gepHM9QYOFb8lyfdg4IiC8EK1gXlPPhRVtzCU4Z/VHsqR3Q=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842125; c=relaxed/simple;
	bh=FLmUmyMPQP6e4752th6cNUVoZJ6S05NRQpuMeNY/vx4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PxaQFNCYKmaRp5wX1sxPBITEHiDJQFWFt5xwAX4+bxAJJJ8OlQ8KHd14+tPVdhUmb5Ez165VE1Pd4hEXQBL+2SnjLq1/x5mEbEAB6WzoAqo37dicyR1CcjtIJEocEdnBmhjR+8eVJvcMYi6jK7QkUABvY5ILsxhEgew2rYXYfb8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iesy.com; spf=pass smtp.mailfrom=iesy.com; dkim=pass (1024-bit key) header.d=iesy20.onmicrosoft.com header.i=@iesy20.onmicrosoft.com header.b=LxfUnZy3; dkim=fail (1024-bit key) header.d=iesy20.onmicrosoft.com header.i=@iesy20.onmicrosoft.com header.b=goFJTg40 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.127.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iesy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iesy.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=SZcgXir09wHDHKmzEJWygSVPu3YQO9fXYibzE2cAddzfDEiJcpULl+63ICiVtPX6RGK9jGTZpJ+LS+7cHwTGY3PY1XN11Ap8/NEeNWy6NYT6WQuuwKpcS+DzY5Nf1bjyltBa2M24vTw5sUxTQGSveT0Q8y5cdqkApNmIwg8ta6HyUQoJ/CUIKEAAnRWJwbrT2a3PeH/Pn9Agz2fogUwbEPXzSmKjNaqXn92mG3h8nEWDAOrG5lPgnLYMacgONXsfjRCHbLw3/Dlecv1TJFKM5O3yJKff/MACqoQnMl86oob2BzQ9u3qfarWZy2fbm9oT1onPytMK68LRJtQKUXlYtA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+d5sLvVEdGISAEPHWV+vAAz45eGs9R2X0isKTcifFug=;
 b=gmYvH3s/81rBrLcZFQm0IE8wDkhHl7BSxw6NYC74SZTN7CD9BMNfsLP9bVIaZhWShqoEwUPcXEYZNGXyZ/8qPhF4mKvaZgo7/D2jTvBpvqOC70VGgsj+4uyxhgP4tpGiDVxKIvS2rbpxXI5d7fsHWD3iTQ4FY0Q6R3Ssdhl5YxSdLLqwUQAkZFutuKkY+KkdvFLFVxoOn+TslnGG5bsHlpK5bTe339E5dqRrasrPuAyXMZN5EvEACaFZ8W2ulrTNGbz5hirdNyx1YJ/7J1ZCYU7gcR3byv4JI9RhoRd0LhIDT0FZ5nUBpBNCX51et0EttgF5e/0kbtF304AwNLP1wQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 20.79.220.33) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=iesy.com;
 dmarc=none action=none header.from=iesy.com; dkim=fail (body hash did not
 verify) header.d=iesy20.onmicrosoft.com; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iesy20.onmicrosoft.com; s=selector1-iesy20-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+d5sLvVEdGISAEPHWV+vAAz45eGs9R2X0isKTcifFug=;
 b=LxfUnZy3na7SlSeNnwV1of/3df1SFSeM/2AB56IiUicX5cccEzQrdqn1Idiz17jwCnq+FGBGOzvMZfuikfoyJc0eBTeX5L+QyASQrP4/oNActoCa4joCfvTn0hr1dm7yt75GeB68ntR2Wx6OjcrK5KKCaZkPhXDAaeCYp9eKwbk=
Received: from FR2P281CA0101.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:9c::7) by
 BEUP281MB3593.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:9f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.29; Tue, 19 Mar 2024 09:55:18 +0000
Received: from FR1PEPF00000F0E.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c:cafe::45) by FR2P281CA0101.outlook.office365.com
 (2603:10a6:d10:9c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 19 Mar 2024 09:55:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 20.79.220.33)
 smtp.mailfrom=iesy.com; dkim=fail (body hash did not verify)
 header.d=iesy20.onmicrosoft.com;dmarc=none action=none header.from=iesy.com;
Received-SPF: Fail (protection.outlook.com: domain of iesy.com does not
 designate 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com;
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 FR1PEPF00000F0E.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 09:55:18 +0000
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (104.47.7.169) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 19 Mar 2024 09:55:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aa6vuhBrO/bhxR41V4QhU3SOC9UoSRrZ2I3DMKac+p7teQTOg/9JFkRVFIrHQMsRIJsAOZO+lczP3qL5klbj8hKnQydjGCHpUWNQsgygYLP7yQmODIcdit1g3Ubm1WZ5o0i5VvaO24fjynNG0srOuQRl/Y2BMNyUGTa1PqjodQ7nDQAJP6i0cAc438Hx8d107EqvUmCpQOCiilJ6acAL8FLqyJfuynL12zoYA7u+v6y52YyddyD6Gk+MGrzJaFGI7z47x9YyjzrgmpiDZDwjhZ2hnVEODX8U0y4bWvF9Srzq/OPrjeDyEwbGn4jnWEwucY2NcFCq5WbMj1AldDqHkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkHxqr/3Ru2tZlIEAaQM12Yl9f/NwXVwjLXLJ0Ow7TM=;
 b=lFs3EoHmxAQk4fUupnz7GJ86LdpBNkWVh+MDWV/p8sEnitZD0sNQ4otZyu+OlY+3/sJS7Yj92eIYWiv50be+gh2LnYfFQP8LvtRpa7IXLyF5GaTGL6AWzhdqDpMYoVK3PyPOnlvdPVHe8xttn3c/NPHstY1WbPMuN064nV3pPol4JuWMMQ4fGD2g7nRRvbWvFW/MSwNdXcXYbmXF5FQIiFonx1Pgk/chGOKqfstjAZH9mIN9Eg9u4AWN05ad6Il3tELsEdvXiYppQC3gOqnGWCXpa9IWCOg85xjKFdcurOP7RmBpJYX9uXOI5y5uH7yhWwHuW3rONfQhBRD30wtwqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iesy.com; dmarc=pass action=none header.from=iesy.com;
 dkim=pass header.d=iesy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iesy20.onmicrosoft.com; s=selector1-iesy20-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkHxqr/3Ru2tZlIEAaQM12Yl9f/NwXVwjLXLJ0Ow7TM=;
 b=goFJTg40pA4v+bkTx2y40K6c65jOy6Lm5X0xI6xOR7mXMDJgYxUqANS1o55Ep8SpbgVeGeESx00EbXAdu/vTUOAC2e2tVO/HcWcqwYMGYMipTi8OVr6Tz7fbUtX36k0kQcuu5w3bJJ3JOW5Emg3I7OKXPd+rrdT8YZt+jVaz3M8=
Received: from FR2P281MB2393.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:39::12)
 by FRYP281MB2558.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:77::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 09:55:15 +0000
Received: from FR2P281MB2393.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8af4:a741:edb6:e851]) by FR2P281MB2393.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8af4:a741:edb6:e851%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 09:55:15 +0000
From: Dominik Poggel <pog@iesy.com>
To: robh+dt@kernel.org
CC: Dominik Poggel <pog@iesy.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Tianling Shen <cnsztl@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Ondrej Jirman <megi@xff.cz>,
	Andy Yan <andyshrk@163.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: dts: rockchip: add support for iesy RPX30 SoM OSM-S
Date: Tue, 19 Mar 2024 10:53:59 +0100
Message-ID: <20240319095411.4112296-1-pog@iesy.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To FR2P281MB2393.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:39::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-TrafficTypeDiagnostic:
	FR2P281MB2393:EE_|FRYP281MB2558:EE_|FR1PEPF00000F0E:EE_|BEUP281MB3593:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 M4NOsYH3WU48Sq6uU7aI6PXWrEdgIorLW+3BKU+fw2IApHATTSloxvHn3CfrYSkCbUA88g/zAtXvLXk0cQ4ZvGYV28fD+EjccRUmerS0O1JDHtz8l3ddPj/QxfB2HHWqSk7krXYRf7+zHzgtk91x6fqkwVBRR5PR6y65drq1pCcdhGVSx+vvJHy9H3RMF8NDau8HJrtarzCRsADciDQde9r1HUnoXl6ru/AuFxwZwKNNog1ZdgWn5IZS5A1FOYIcqThYW3Kqm2alOXASlpoXt7319wPGvA/AQtfiTRbliNG9mvC6qwZDVSbbUBIxBhHg97FBQQxmnmTbC4GyFiYPg0Ug/oZmLp7yzu7h5zw8WeDFH4QeNI9orpHgS9L0fVDMOHmfd9y05gefL0l9ocoLD3fhhny15WTTQZmrukn/Ne+FTztVqmbNximt2WajYHVKgyZ4uc9tHFmiAFxCpTUANOTNlggJ3JZTb63ITqar9ERPLZD+06EbJJ8mnAbdSlA1FEFzxW6lmA/UQISBhPfGJidXhjB+QmbxlPhk/BCsnnhLrqmGTcZhhZ8GiNKaSY6CYHXYjGhzHmM6o//aiFbsmt4LJScZ3FaIvtNXRNLtQJOd5DfoQ6d3LW8PagFDs7HduPwgp9djSoHIfksxx8InrakiVrE5ecqQ4cH9pwZh13qT/5wG6YWT9Z6JgPNJOse9+m0WF0tv4GrCaGyiPMm1LditoOtxPCLd+RiLni2VhEo=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB2393.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB2558
X-CodeTwo-MessageID: 9ba82c68-768a-40fb-92a8-5a48e33bf570.20240319095516@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 FR1PEPF00000F0E.DEUP281.PROD.OUTLOOK.COM
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e351474-bcf5-4049-917d-08dc47faaef0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OqEAIfS11SuR0YKj4TX7nbZrU/r15mPm9r9bwpXNBzdtmOkDtC4jAb9pF8Pa7AIlim9FgyTzzo9qayMW7euAPKqBvxwvJ27vnq6NfuqxBosqBu17e+fKU8CB3me6BAyhBttoQHtxJ/x57tiSHxcPDvvESB5icQOHmeru8+BSCM0UlHc8pb+ouXru9KSiSKNlhZxTewsn8GqS+IjYXcLCiy9t0DJ7uIw+hHeFpyF5A/V41ilECA6SAXT5n2Clf+SoMJ0/zPz8yUW25bgogKUXVkiNpZlFd4vMtkwqsLGRwsweLg4P5G/+ixiCK2vmtxG14dPL2bWzCi9u192ymj3o5NxVv11v5lsM8qknahY4vILq1hl0TxK5vGUoF+eVBdiTpq1ElFjKvcSvUijybW5Poou7utHRslQNdxqSVPq6DvsV42oMwvbaGVK04cbvhOBpVgAsergqPX7BT4SRkwDxhBqR6MvLxFytH8Lsz2qfRp8CfDvxCkOy7ujuEw2IyZ2PJCs8KtZ7pGELQPgoybrSBRavLnl6QoJ/TuMCgrYYT3rO6RejUyV/6CTcY9qe/vxtoxOUnaB/OgLKwUs/Q9zdTSZX/juwcQB7M1z/UX0aMwdxEx4xLNd7gIlAPlHipnE+gZlBSxAwl6iDfhe/dbjL1WFBn2xPG4F1KTHKYwV3pGTO5st3IQci7gk6goTCfe0fp825BnsrMqRlL8CjAqy2F4qom8KvSuJBUBf3C2+JA4z5heNojYpytkXMPS/rFAXx
X-Forefront-Antispam-Report:
	CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: iesy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 09:55:18.2165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e351474-bcf5-4049-917d-08dc47faaef0
X-MS-Exchange-CrossTenant-Id: ace663fd-5672-464f-8169-8d373312f6bc
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ace663fd-5672-464f-8169-8d373312f6bc;Ip=[20.79.220.33];Helo=[de1-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: FR1PEPF00000F0E.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEUP281MB3593

Add dts files for SoM and baseboard featuring rockchip PX30 SoC

Add iesy GmbH to dt-bindings: vendor-prefixes

Add baseboard to dt-bindings: arm: rockchip

Dominik Poggel (3):
  arm64: dts: iesy: add support for iesy PX30 SoM OSM-S
  dt-bindings: vendor-prefixes: add iesy
  dt-bindings: arm: rockchip: add iesy RPX30 evaluation board

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/px30-iesy-eva-mi-v2.dts | 682 ++++++++++++++++++
 .../boot/dts/rockchip/px30-iesy-osm-sf.dtsi   | 362 ++++++++++
 5 files changed, 1052 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-iesy-eva-mi-v2.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-iesy-osm-sf.dtsi

--=20
2.44.0


