Return-Path: <linux-kernel+bounces-20450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85636827F29
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193DA285AB3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AA49475;
	Tue,  9 Jan 2024 07:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="thOts0ue"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2054.outbound.protection.outlook.com [40.107.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACA09442;
	Tue,  9 Jan 2024 07:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WugssPjh/OJYUcvxV9sfkxrKTiXpOz4DL0uEm8pwRvnqcIvVd5ylI+yyjKWWIj7RMV8hO58NgVlP+y8cEw7ZlBul9r9hXjodipp/Doc/KFxxUPrmfZnJwNntzFu2m7Y+rcbK8iCuItub5Ww6/wFzw577GP9xh6Hnasf5Mo43nIxVv2xpn9NNh2zfTLWsyHfUImFaZ78fYM2fCB52nIDI+NLLCmLLEW+SX38h01Lxw+o0FJeZ2SCerUlNMIDgLvOHbp97DFcXpWf5lboAOlbv8/ocUtIOEZ+gVjjCEe8UMribv0QfDtCrAtVQCcL7sHeDZ5Ungc21i8cDWv7Cmhh/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URliTfPydfFSeOAAfd2RMkJIoJV0MsL3XqcVqNriMcs=;
 b=CqQ74+N+JMnnjimwP+OQYu5wy51QXStUoo5Fl74PTKGPCVfLNmNnpdpCE31lD6Ebq1b7zPobnMDebfE2zCa1cEnJsbsOAFmXLsaqhdQhpPeAayIevsN2CKKBdUgvNyUh0CXDdT85qAO0h7aP9lDraUVTL6vLpLf3Cx2j8mfnUGs/LXFPkZiCLNVkbVnQwMLRHZGtJo8lJIc9vvnuDcExwR/2Kk1EJSlWYmDqC58MCSPqfbJQVVPmPSouQ0wRydY6sJqTRfhYmrFE7pwFPgPNKTBnidfmMyEV2Xn2BcGXOA9/ywvvjLacDGqXIFrRx8fWmfJFUDILg9mZTSNdz0Frnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URliTfPydfFSeOAAfd2RMkJIoJV0MsL3XqcVqNriMcs=;
 b=thOts0ueUzEv6wxJUfZ/CPD5DB+IzEgWtpkzeKbZcgycz+8zu0vKL2SgaYjyjZlPeZz1flL/jqPYpZgn6UStP7TgXYRR6Fhq1fIfqLKsGbjxp3csJ1jBBxvDj3SOEo8fo8nnnGGvGAHrsbZ5dQDPDgaJ+GNV6Ab9LIOaZB6I1Krc3YeV6GDWZ4uDgQpbZbrzjjtsZWagAbpECqtyij2Sv5nPnoVYF4MmJSA41y15f8MEn2uMNRZqTH/OHeGE5y8mfGoPPnDTRe+Av2mhAWxwkVNWDe0MuMTV+g8NKqeCggVeP+UqiHftKuAtD6+jgDdQs6OJbpJVTmePz78uDHyv9w==
Received: from PUZP153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::9) by
 TYSPR04MB7045.apcprd04.prod.outlook.com (2603:1096:400:482::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.23; Tue, 9 Jan 2024 07:20:56 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:301:c2:cafe::ff) by PUZP153CA0003.outlook.office365.com
 (2603:1096:301:c2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.6 via Frontend
 Transport; Tue, 9 Jan 2024 07:20:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 07:20:55
 +0000
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
Subject: [PATCH v4 00/19] Add i2c-mux and eeprom devices for Meta Yosemite 4
Date: Tue,  9 Jan 2024 15:20:32 +0800
Message-Id: <20240109072053.3980855-1-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|TYSPR04MB7045:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bb1919e8-ef6a-47f3-3678-08dc10e3851a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D7jkyhS5EbFk3N1d1Y3YHXLcXUAUbNT824tloUesD0zS97Q32L3xemlSEhLRq7Nkd/1OXhBTD6dQJtHFfchPyiMCT6B+Pnq5VWioiP8YDWviMb9VSp0nJ/23vAloUzzFB1EoKFfppIJnHRaxlO2/pozNKQiu0lwJleI5vBvgsmoLvgQxzPu7ae/m6perD+vFX7eIytAV+T4oDj/24gVufqlMn3mt7M/BPC4/6G8/jfj8tmd2HqYxBJ92Zw+K6cTeFUORbA+pskBB9R9aCcSa6JFJlUX0KJkgwcucnyEP+UtJPUY+509hsqeXJPHP5zw8iRPoEXdWwyL9vx7tD9tDQnh/aYMbdKW9t11LvXUBQq9wwjJOB6Xij2o1jquoru8vBIEM+mA+T3EG6TNJug3Pb/Vnbg3u+vydOq7xq69AWKklun2nxVzEneYDrJ504ifsMFiioNUYTTzC8QszYaUCLGKh8tsACJgDRfpjvK0R/YoPzLDYiMvGF8oDj0tGQJJ2mMBC3LSAES5t7aKM9tKEdJGpZAwIOzKblWgfqPsb8JMGygBMHVtRvPzxzrlsmNF0LVgSoVe7Ggvs17gUOvIjRl/bVZ2vrYFXG3V64iSdzvSWHgqQdSaQ10oMmhqDOcnWFQQgaDSrCpz9C97HSqVQ4h2wmLatiARYPDI+MoCxpaKNOS+a8RBy4jT1Xxx24QtCskucAvFqQk8wqZpdSeZy1g==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(36840700001)(46966006)(83380400001)(6512007)(6506007)(1076003)(956004)(336012)(26005)(2616005)(82740400003)(47076005)(36860700001)(4326008)(8676002)(8936002)(5660300002)(7416002)(2906002)(6486002)(6916009)(6666004)(478600001)(54906003)(316002)(36736006)(70206006)(41300700001)(70586007)(9316004)(356005)(81166007)(36756003)(86362001)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 07:20:55.4444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1919e8-ef6a-47f3-3678-08dc10e3851a
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7045

Changelog:
  - v4
    - Re-format gpio linename
    - Revise i2c device node names
    - Split patches by logic changes
  - v3
    - Correct patch for revising gpio name
  - v2
    - Revise mx31790 fan tach config
    - Add mctp config for NIC
    - Support mux to cpld
    - Revise gpio name
  - v1
    - Add gpio and eeprom behind i2c-mux
    - Remove redundant idle-state setting for i2c-mux
    - Enable adc 15, wdt2,spi gpio for yosemite4 use
    - Revise quad mode to dual mode to avoid WP pin influnece the SPI
    - Revise power sensor adm1281 for yosemite4 schematic change
    - Add gpio pca9506 I/O expander for yosemite4 use
    - remove space for adm1272 compatible
    - enable interrupt setting for pca9555
    - add eeprom for yosemite4 medusa board/BSM use
    - remove temperature sensor for yosemite4 schematic change
    - add power sensor for power module reading
    - Revise adc128d818 adc mode for yosemite4 schematic change
    - Revise ina233 for yosemite4 schematic change
    - Remove idle state setting for yosemite4 NIC connection
    - Initialize bmc gpio state
    - Revise mx31790 fan tach config
    - Add mctp config for NIC
    - Support mux to cpld
    - Revise gpio name

Delphine CC Chiu (19):
  ARM: dts: aspeed: yosemite4: Revise i2c-mux devices
  ARM: dts: aspeed: yosemite4: Enable adc15
  ARM: dts: aspeed: yosemite4: Enable spi-gpio setting
  ARM: dts: aspeed: yosemite4: Enable watchdog2
  ARM: dts: aspeed: yosemite4: Revise quad mode to dual mode
  ARM: dts: aspeed: yosemite4: Revise power sensor adm1281 for schematic
    change
  ARM: dts: aspeed: yosemite4: Add gpio pca9506
  ARM: dts: aspeed: yosemite4: Remove space for adm1272 compatible
  ARM: dts: aspeed: yosemite4: Enable interrupt setting for pca9555
  ARM: dts: aspeed: yosemite4: Add power sensor for power module reading
  ARM: dts: aspeed: yosemite4: Add eeprom for yosemite4 use
  ARM: dts: aspeed: yosemite4: Remove temperature sensor for yosemite4
    schematic change
  ARM: dts: aspeed: yosemite4: Revise adc128d818 adc mode for yosemite4
    schematic change
  ARM: dts: aspeed: yosemite4: Revise ina233 config for yosemite4
    schematic change
  ARM: dts: aspeed: yosemite4: Remove idle state setting for yosemite4
    NIC connection
  ARM: dts: aspeed: yosemite4: Initialize bmc gpio state
  ARM: dts: aspeed: yosemite4: Revise mx31790 fan tach config
  ARM: dts: aspeed: yosemite4: add mctp config for NIC
  ARM: dts: aspeed: yosemite4: support mux to cpld

 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 1206 +++++++++++++++--
 1 file changed, 1086 insertions(+), 120 deletions(-)

-- 
2.25.1


