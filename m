Return-Path: <linux-kernel+bounces-107355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF29F87FB5E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6D31F22621
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E207F7D1;
	Tue, 19 Mar 2024 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iesy20.onmicrosoft.com header.i=@iesy20.onmicrosoft.com header.b="0KpalkfO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=iesy20.onmicrosoft.com header.i=@iesy20.onmicrosoft.com header.b="r1T9OLvp"
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2105.outbound.protection.outlook.com [40.107.127.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231557F7CE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.127.105
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842200; cv=fail; b=ozHgnkRMUHYQaUXyxhB2mA16rXCeyEKsbfDBbnM3JyihDM2xwNQoqj+HpGNH6kAsW+GOpm4OcFW4KXqYAvrgTNfZhLxkLopHnSubX2vunclL89lCFjxymp9R5/QK5fqJV4NfWsmPKH2htuiupbiewkxS0rx1IIsmLEMGsrLM4TU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842200; c=relaxed/simple;
	bh=SftUslaHsqY8HGO3YhrDrJGlF/tU2RlUdzU760/6KF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F2rjENazj3L8zx2aSVcNmjEhDnE8toNTDiYiHelbHCTUU7Ht9oz8np3RwQPUc1rh0jasFw1kMsXPA3nUDQJ/zSUr499UkNxZQx/wOxtJoFvEgUC6l1Pbk7mskqY2dt+T2p10p3gi7k11o7C2dLjjPV9H11eezUS0Xqrbp+euZWI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iesy.com; spf=pass smtp.mailfrom=iesy.com; dkim=pass (1024-bit key) header.d=iesy20.onmicrosoft.com header.i=@iesy20.onmicrosoft.com header.b=0KpalkfO; dkim=fail (1024-bit key) header.d=iesy20.onmicrosoft.com header.i=@iesy20.onmicrosoft.com header.b=r1T9OLvp reason="signature verification failed"; arc=fail smtp.client-ip=40.107.127.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iesy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iesy.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=lai4m9tYlPDqp1DexJu02J5vkxu2p4px6StaSnwhxPldHCaGBxNShDclwJPT1J0qyD0sDtFEjjUhmEAXSvJ/aA8ZuusUquF8+Ejha//oTlQ52TNZgk8+byd0mzKOB/oyxIxk8Svhi9BuQZlU2yota/m3j2dssc5bxtk2pTgqJUtkBBqVY1zMrX0TaQfp69ep1Tkc0CV+1PItI5q4TwdONHRBQRWAkNF1vz+hz1Cm3NEPZaqiegKBXA4c8XJd76R4ApnWIuJZVtTwxo3iROjI9c7LgtoVkNZOP11LFWtZNfBCaSJlFRNmZE7vgy4wCPMgwKwvza86TYiLP+aeq0zVLA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qcm2tufEHCswe5/0BhmtkpeKGfTtdqAG/VOY759/Jdc=;
 b=n8Abz5CgyzB7Y7Dc62DmYSQDi9BiAOhMxVlen+tQYlXWIeMRwT0ePIFsmuQwPaQg0cchspDm3dY9VsBHSzT8zETxGMzyRUw22Mq3U4kP2fxB0ShkZ8INhcRHeA00R9BzPz394lGim62ZJMSmeQj7smjuWm4TVX9J1b+6aa13KlA0zXqheUumV62MoN8WTbd15PpeOCDzO/qt8AKPZNGDChb6xVAQvlMD1XvKNJIV5KMRsY9VMobO5wK+I+EVmRUTAkPO617Qc5Uh5SwgC0d4hHz9VUUsrZrCUh8DT59ZpYT6gJCUT/+oJY68zcI3EpOmCkivqGq5xVdTqDybTdNeJQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 20.79.220.33) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=iesy.com;
 dmarc=none action=none header.from=iesy.com; dkim=fail (body hash did not
 verify) header.d=iesy20.onmicrosoft.com; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iesy20.onmicrosoft.com; s=selector1-iesy20-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qcm2tufEHCswe5/0BhmtkpeKGfTtdqAG/VOY759/Jdc=;
 b=0KpalkfOqvnoufamsUT3+tBFJNBJRn4C+kBaxARfQliHdOujMHXCAeaVBkaUPpBkStEyFvBHBC+Cc4OARliBSmk7ORnEWIXe5paocX+XE1yLP0MU/nrs0NrI7hvLqM4G10wmgxYIgYXqWNU45uCGfnVb+Pv7OemEJUnALcujyCQ=
Received: from BE1P281CA0080.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:78::7) by
 BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:4a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.28; Tue, 19 Mar 2024 09:56:35 +0000
Received: from BE1PEPF0000056E.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78:cafe::a4) by BE1P281CA0080.outlook.office365.com
 (2603:10a6:b10:78::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 19 Mar 2024 09:56:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 20.79.220.33)
 smtp.mailfrom=iesy.com; dkim=fail (body hash did not verify)
 header.d=iesy20.onmicrosoft.com;dmarc=none action=none header.from=iesy.com;
Received-SPF: Fail (protection.outlook.com: domain of iesy.com does not
 designate 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com;
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 BE1PEPF0000056E.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 09:56:34 +0000
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (104.47.11.169) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 19 Mar 2024 09:56:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JROeYmpXKzVNBc/1Q+qWkSIs7j5XCf+FmYSbyIkLc6hUNUwAHXvLOiP4GODYpGSfs3/QYa8aw0BCmaLpu48+cX8/HdwMuuxtWhiViZaNSSADzzZGXReap0OR6kEzd91U7BFA632oAxy/F006EBiV24mM9SEn0isV/Ou4W83Zrk4vmVWhDc6mtmJ8TMGgr++Tq2BphTcz64I7zQt4LB9p+YHVQxWBhqRoZf9IHyP4j1vznoOBIm7ENm4ifQHsl/g6uvdvscuFGjFNPcLeCz2noKiUs7DkoewLw1FWqiesz2zqlYBu4VtXHS67orTL2POFAQteLyNXvrQwi8xFihr8tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81GBsRSGPUJDqOX3Fq1EM8MeHwVfr+Kid8EzQf8Qk0A=;
 b=YIbrisl0vbqy8LjvIto3HYBB5T21k2G9Wh18ncICt4AGcoHZZskCEvC22UiMdP/g3lSVbQfJaT8H21VpNr1AJgMHNmqyx3kOwlKrRb88z05OkxXWKndrSnLzmB9DQlaOi/rYUPYpfXX372IuNtbz5cLxjJOfb2gP/hJ3x56QwG6YMBFIGY5OEgC0otyQMMDrxWbAamwKDfsN26szrZ2jYIZ+BV+WqaCaWpTbtCjV0tni5OzXQTe6ZEXtru/x6lJBZwBHuRNDcZNsiXH/PLA7u3WZORNXTsRnMjF95dRJD8sCFSe6pX2RjTF45n9lNQt8GTrsaY2UUFClD/i11UeEuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iesy.com; dmarc=pass action=none header.from=iesy.com;
 dkim=pass header.d=iesy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iesy20.onmicrosoft.com; s=selector1-iesy20-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81GBsRSGPUJDqOX3Fq1EM8MeHwVfr+Kid8EzQf8Qk0A=;
 b=r1T9OLvpppXNhkDHp8pSyfiyz0hkJt18r2el5KHWBT15m43/uWvvQwFKFtnr74E646hCqGv1QtOCkWfkDmJSwewd+sGDS8Izwy82xo7FzLNtbMz5O691uc/oe8CaK1hUlV+fB3K7QXj+7e66gqNj6Vvst54n95CgFC/dfGmfVm0=
Received: from FR2P281MB2393.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:39::12)
 by BEYP281MB3930.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:b4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.29; Tue, 19 Mar
 2024 09:56:29 +0000
Received: from FR2P281MB2393.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8af4:a741:edb6:e851]) by FR2P281MB2393.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8af4:a741:edb6:e851%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 09:56:29 +0000
From: Dominik Poggel <pog@iesy.com>
To: robh+dt@kernel.org
CC: Dominik Poggel <pog@iesy.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Tianling Shen <cnsztl@gmail.com>,
	Andy Yan <andyshrk@163.com>,
	Jagan Teki <jagan@edgeble.ai>,
	Ondrej Jirman <megi@xff.cz>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: arm: rockchip: add iesy RPX30 evaluation board
Date: Tue, 19 Mar 2024 10:54:02 +0100
Message-ID: <20240319095411.4112296-4-pog@iesy.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240319095411.4112296-1-pog@iesy.com>
References: <20240319095411.4112296-1-pog@iesy.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0079.eurprd04.prod.outlook.com
 (2603:10a6:208:be::20) To FR2P281MB2393.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:39::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-TrafficTypeDiagnostic:
	FR2P281MB2393:EE_|BEYP281MB3930:EE_|BE1PEPF0000056E:EE_|BE1P281MB3400:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 8kdmXsvPkMB3mIgL77SS3UiIYLOO5E8j8MfRSh5CpDB0KBJbfxNUNJZua7kmRzC3267UigxWPDgOdddR8aPkb7fOx524t3d2zXNWAcMxX93Fl8jhA1S76BU3v2RqibLqJEBw3qTd7gHuZTMC/EU7/CdD7O1GYFKbz6rT2iOZf/+dl6donNDaDTsVmNeDzbWH+PFR0/nTysVHFuHC2lbUXF/e7zNRkL1MW3DUIFEU6nfj5ZW8WguTIkh7lW3t46Yx8tjhh83q/HkrHrSFw4qSlHkpXIk0nsffxcEA6TTk298H72Ov/n2rAhnrHfosxCYuYDWHLS5DCCxKSbK1YVgSe2CTO3drsbeu+pSuc55Y310B/x+4/cHpr2Vc6eNH6h11TvoZZgRNOds6jV47GkgptwBYJ8Et/K5aivcxIoiWDqkDIJtzvB0Z++uczWIlWcRM7VFW0U9pliyEbu56YfU99jtDtugtGRauUEf5ReBc1bMtWwfWbzVN9fVrKu8p5bo3ex7OCJTirisC7oxMZNfdd/5pNMBS796ZFnHjr7t646VzDuvgCgnkZKW8/T14aO5yzEbrtqedG6g2dk4Iq2wRBFt5oMqYzF3Grs+OtzPRRvz1rwb+RUhqRXYg6lADD9FoFb2V6IhGw12nSAak8SC2qv+zw7ie96VLszaqLeg+qpH4qe3gVIZc1UciBd/yLctRnmRbLwwpYLExo8u4YVS4nVOqbFuxS7UMvR0qPbh6vuA=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB2393.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEYP281MB3930
X-CodeTwo-MessageID: 9a9a5561-ba58-4002-b48f-78967127a1cc.20240319095632@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 BE1PEPF0000056E.DEUP281.PROD.OUTLOOK.COM
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb19e226-2aa8-416f-34b7-08dc47fadc9c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8KoGuSVWkUXoltzDs/6Njf5St0XddPun9hmqBw4Jxwybuuven0DhzR+h8t4TwMz3QhsxU7RILwPI0f6NHoU9NspuS6KFzBiopt3eXErMmaatznXRm3h2oM2M+DMb8+rb1S7CSl6qys8JvEwkkalKnmi4tM36qlBNP0WHxq+01d/dwggH6g6EzBDC94mtBVyLaURdfWdZ18A3tfTDEi9+xCQMuEQnZmKQ/YpeeYp8uK9RIwKOakLlejvtdZahSr25ODJEYZMWjDBWCwQDwWdi275u2gfG3dGijmmce585XeayiVWTc4N6YLvYg2IK9Ua20y7g1Us6gNN9kBu/acDJyUprmhGADocwCVdHlfcjlh62qXgejntAKKa/XiAwcdjQxDiF3vaIaIF41o6CwEhy3rBkJOi5FIYtNEJaszexHQRtE5Ftojg2YFN5d0e6pzo6j3cveDbT6dMDnKAomOkE7jqwfCKmLks/h/dZ5Z0arJxnTn5+0Kgypuk5JMbAwf9FB1bGsNQCYptv2tMrCgZTtKGXMJQPTDXQoLmEhWzg3ZBadkivkMv3v9yGLb2T4bi0lrhfuoXY0Crryj1dwvEGxxJ+lqx22hslcS1JGAD45o+nYb0uFYIXbT3hFGdBURe5G2QUlB4DA/rdp4aAjXqctKyTI09JhZ73I3Qqx0IcZpxeW3k7sn5geiRZ6dw9mAOZ2Zz/GPhJRJ/aZCIasphnu4R+2ayN30Pkjyo3uy9CSaOMTF4BaQZ+YMa90p3TGAxA
X-Forefront-Antispam-Report:
	CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1102;
X-OriginatorOrg: iesy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 09:56:34.7607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb19e226-2aa8-416f-34b7-08dc47fadc9c
X-MS-Exchange-CrossTenant-Id: ace663fd-5672-464f-8169-8d373312f6bc
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ace663fd-5672-464f-8169-8d373312f6bc;Ip=[20.79.220.33];Helo=[de1-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: BE1PEPF0000056E.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB3400

add entry for iesy rpx30 evaluation board with iesy rpx30 OSM SF SoM

Signed-off-by: Dominik Poggel <pog@iesy.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Document=
ation/devicetree/bindings/arm/rockchip.yaml
index fcf7316ecd74..601aa1510856 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -565,6 +565,11 @@ properties:
           - const: hugsun,x99
           - const: rockchip,rk3399
=20
+      - description: iesy RPX30 Evaluation board with RPX30 OSM SF SoM
+        items:
+          - const: iesy,rpx30-eva-mi-v2
+          - const: rockchip,px30
+
       - description: Indiedroid Nova SBC
         items:
           - const: indiedroid,nova
--=20
2.44.0


