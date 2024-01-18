Return-Path: <linux-kernel+bounces-29727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D729D831293
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47CF51F22565
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 06:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302398F7D;
	Thu, 18 Jan 2024 06:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="XFV81y8n"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2047.outbound.protection.outlook.com [40.107.117.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855958F51;
	Thu, 18 Jan 2024 06:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705557654; cv=fail; b=brc9mUr2zbaTGU0f7Srom+OKLkFjtcdeYpXIVq+SnjcOjQ1RPEuL/NwbxICsVyL+OoPitFDqwNcEzwu609ICj2yYnAxY/Lsx+HocU3/RUMHgbol9ISXvDhSXgRJyPInoOrY+AbEtEBeX5aAsoaALKYuNyxhyG/MoiFCjQLiPObo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705557654; c=relaxed/simple;
	bh=ZBo48Me5bL3031nMmETMgeFaNa2N+YC1N6v/Kk5S0hs=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=XiKPotcAOdRVdpoY8u/v2pJIDEFdEpEQzU28MgcWst7cab1Sl1eOhJpSLDnhiynUCrL2Fk4QqThABg8piiFfEm3jSFOW2o2ny2dQ8Z7efdfYS+rUJbB/CA7GMbJK6a9XwwGcmnd8PaWPRfSOIss7be0Wshy0FcmpiPfvFCDo8uU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=XFV81y8n; arc=fail smtp.client-ip=40.107.117.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nw+Mg0D12zXbJoWZu8sU5adDPVuU+S/I++W7z6qviU91zJ/3QVP9fM5zGMt9gGSR9qWor3u012o9cF+ibzCCmqdpPOMeKapWvD1v6BA/7hJSxuQ/5JD5wPBowlD5QqlUEyMbxjWx7ESWbcT7aLZyo4q3kKdVWOks992j8khr3J7uxTqpTqaqT/qc5iNWohKbhMu4573nr12JZFfGLGkQ3ZaTBZRd5EoopIxTt85Hzij4W5ZTkLInxTFwpCouOU3Xl6R9N1Zw/PXi3dWlI0wUnyZZDEw+o3hvcw7Cz46F8sEq+Ypw+kBtByzrgNLSiUQ/F/GEUtNAKGH2cr2P/OJ+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQc/EKVtkGvWctuIaLE8DGzk72FeZ503FjiicQJJFxs=;
 b=Pys3v5iEGhzvu49IH9PkssP0q9fTqLyAFMeJVgP4xV/cm/l8b9YDcVLiQGDb4YlQI/ZJkaelPA81+0ur+fzcY3Cmour38vtZfvf0nr+Lq6rtDs2+KopG4ykHTYEjg2Ogw2ECUBGV7huG3htEIccms+GLjypkOlT4w9lJ0jojGovBSh9lY2DaE7FxjCDk8TcB06HTyQuUq7TsX/7kf2aPo1/L7xj8XSsK1k0fT3F37cXYgZFEZlZ1aRe0UPLBmqJO91HsnoL9lB66cFLIR1lEFZPS2jxyPIKBxA4PG21KEinMdHhU/Uery48R644kB3ftjwNAjpbUetCoAlkLdKSAtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQc/EKVtkGvWctuIaLE8DGzk72FeZ503FjiicQJJFxs=;
 b=XFV81y8n8xhr/CjU5zfE57sraGrLKe491ho58vcZT8JW8Janfvd/h2uj3mzagCvyzTg3mgKtoLCgRCqfQBBdwc4vFrUk3wYqmuH6kQQp+CzzjHRc4K4Mhs5Q1yhorBj5hlMhSfiqcmiO+LMjE0iodvVB581K2qYqNDGVY3iqClXxeLNhkXVbMDqsoM7jUWQdpwmmMtCKrC94yNKd1yECT/I5Mq6EcG6Qqcm1HQ8A84cbkcygN1ekO2jRl8DN4r2X3vqoLlTNGEmG0BNMfCH0o8Fu5lpbg5cy4AQwKADEG3njAoC/VXjY6Prxu4vIwjttY5wa8rXZLRRYN1wLLr301A==
Received: from SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16) by
 SI6PR04MB7919.apcprd04.prod.outlook.com (2603:1096:4:252::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.24; Thu, 18 Jan 2024 06:00:48 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:1:cafe::20) by SG2PR06CA0184.outlook.office365.com
 (2603:1096:4:1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 06:00:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024
 06:00:46 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: add mac config for Yosemite 4
Date: Thu, 18 Jan 2024 14:00:41 +0800
Message-Id: <20240118060041.1923700-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|SI6PR04MB7919:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bb8dd6e0-04ed-42fd-2555-08dc17ead0d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PqX7a6Ll998Y4uej992fOJznfBAdrhwLQWmUbjt8Hl/xy4r61oik3KBCtFdTCSOTBbV2aIetZa2ZJlCK40NV3gMzQ+53NnR0KP9sIeUo+B60jG9e9FtiufcbARW+ko/SHKzIGiee9cDJmq+D/t/eTWMvoMf9b/xmjI3oHrsJRZS3y8TpgKhrFnWHek074QPQ9htwYHd5wYhg4noHOU48+IftW4pMMDeTW3e1KblSptZBle7LXvQ7VD9PVlPlCvD1DDXwNlI3M3fGEQERfgki6rxXrbJ5VIfSUiCa1jbb8IeF8zsjjzLhPQYuvWL/UPy2HJKfbu9Cp+jYTmDwi0I+rXom92OFCCXhy+nzSCy25UATx6J2cugb0mTFJgpOycB8HPjYuLee7d4owTG9f+c7rxjOkiWSaHP5d3uxriMc5BP+Y/ZtB+nbnFLb6z1j7twDHzK0x5XDNOSA1sEEWki2Zg/Jzsi+Igetj9BBxx+ArhXPkt+QwJSek4BwvZXIJ5fD0Yfl/+jJTyQN16EOKmdn77TsQ2k4yY5Z2JjTJtellQmaJw8rUt8IYgkxc0u8NRkxubld5+RGkRlkguLdbeHrIddKw6yyIcplqBlM5HFztki2sQB8DI+JI2RJP21Hd4GmIOGp7G5Gawk90ndFWgg/Iuu7DXd4xajcFTb0+3Ok4AtpKxnYV8a0O6VwzIEsdYJkH1CPnFT1dqo2LVErZjsMRw==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(46966006)(36840700001)(40480700001)(26005)(1076003)(6666004)(336012)(6506007)(9316004)(36756003)(86362001)(81166007)(82740400003)(356005)(5660300002)(47076005)(8676002)(4326008)(4744005)(7416002)(2616005)(956004)(36860700001)(6512007)(41300700001)(316002)(6916009)(70586007)(70206006)(54906003)(8936002)(2906002)(6486002)(36736006)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 06:00:46.6555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8dd6e0-04ed-42fd-2555-08dc17ead0d4
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR04MB7919

Add start-redo-probe and no-channel-monitor property in mac config
to fix Mellanox cx7 nic card cannot't get mac address after nic card
re-plug.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 64075cc41d92..33c01d79e5e0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -89,6 +89,8 @@ &mac2 {
 	pinctrl-0 = <&pinctrl_rmii3_default>;
 	use-ncsi;
 	mlx,multi-host;
+	ncsi-ctrl,start-redo-probe;
+	ncsi-ctrl,no-channel-monitor;
 };
 
 &mac3 {
@@ -97,6 +99,8 @@ &mac3 {
 	pinctrl-0 = <&pinctrl_rmii4_default>;
 	use-ncsi;
 	mlx,multi-host;
+	ncsi-ctrl,start-redo-probe;
+	ncsi-ctrl,no-channel-monitor;
 };
 
 &fmc {
-- 
2.25.1


