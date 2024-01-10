Return-Path: <linux-kernel+bounces-22565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC50829FC3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEDDEB273DA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE3C4D129;
	Wed, 10 Jan 2024 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cX5fm8C2"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31814D109;
	Wed, 10 Jan 2024 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7zuw1yVGSiHeVCz1c0k1VHCsVIrsDBorFm0MNVsdVsZ8SeFhYEuQr89PZGGPtVHjFYcnU8veilMWY2t6ghCA4qUvMNg6bfuqYJvaPgm9x2teQOovgtWf5/2Y0ECa+z3g++V6j0ynXbq/Fjvbp/nwyJ3Eu7AETWI/bSJ/IgNW6JJnxKcgrQ4qI1WtK71tCzrr1ui2rFA4VMmOYYO97An6vF6EC1uFoR/5o3HeyDxmr/nVuh5Nc7MKLrmZsh2alnkYCPvz3PsP4YD91rBzayjFnPzc/eGEHEmrya7Qtpk8h2mcpQeGO5HjpjQ7+q3DIDGFmFCivZeVny0b/EhHXSBwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvXh/SX2xTFHQKfL4pOe9HHkLCTP10Iok+xE4nIDS4c=;
 b=bDqku4TGYhI7YwaBI4o4X2qkE/3/WpVqoRQV8rzxu6hIgsEpIZDmNYq/GPzuErI0huoLjJ7VbwYcOtIEtsuZaleHPpPLC3BkR+Oa6bny4mMecgZoO1F/jhJH3cY/ubKZ/l3smLyvqNGszTlAe2y7saoW/pzLaSqZwvK2gPQVDlQU6WciWTx5WZnZtYpRwqL7mENn1x672Wl5F/HklhVMUQvOBj6+LO0x7oDCof+gtVtI9ETQMtqC8+SExRE/tsT86Wl7NsDJs/0JyjFUFMy3NOpXk5n3zfYiMxstZ+v+gvESXZyejhhMcDM9biBO7j0uA3SRS8HmZRjTK/RkEngpgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvXh/SX2xTFHQKfL4pOe9HHkLCTP10Iok+xE4nIDS4c=;
 b=cX5fm8C2BO8fTSCza4DZRjgUlhCQ5CusY/WSEavfKSnnAaAs9+RdFSn62KV4qrgbo3L5V3iIUTy9PS6dB8DoVrZ9LDS4m+ONr+jUveCY107jl2pqI4IT0K4QnDUK9WMBVp4bDLJi9LZeWn1oOOgDFs9Dy8OYdBge0Oo4sl4mG5g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by DB9PR04MB9332.eurprd04.prod.outlook.com (2603:10a6:10:36c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 17:52:40 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 17:52:40 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com,
	robh@kernel.org
Cc: alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com,
	gregkh@linuxfoundation.org,
	imx@lists.linux.dev,
	jirislaby@kernel.org,
	joe@perches.com,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	miquel.raynal@bootlin.com,
	zbigniew.lukwinski@linux.intel.com,
	devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org
Subject: [PATCH v2 0/7] I3C target mode support
Date: Wed, 10 Jan 2024 12:52:14 -0500
Message-Id: <20240110175221.2335480-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0145.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::30) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|DB9PR04MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab9a493-8cba-4c4d-27f6-08dc1204f054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FEVBXgX5R+jxHPO0NCDCxDTT9mfrQJo03EmMbpFoc+vrXPdNT/Ifr9tVAdpWUQkqO3UOHFYyoDVX4RheQIJTtZjpJ4Z8itLyUd13X/fp4gtYIqN/UhPlxgTt5VFhGFfACPMAamatGSM49bNbJgHyvtp9iFUBUNCQfLPuvd4mFG+A2+iP/3+bjzwkRw8kAtnjv8OnxmxlYDi2mdF83BNxO9zn9bvJaTC8mu31kB07X2fQHL63ZGPBb+lH6boIeCmPjfNy1puIaXhtM9YomEmmWN7o1hf5yrR9cvEbQ6mSoBI+i+ZNyzCEpJJB4gySMUAwsEGAzY6sEAFYyHP97fUtz9rl75K3rB3KlMyW4HQNC+A7AxAXdSR6kqpooovowM32FF/1cjTdKLPAmnh5QI3jhXUThwJFzTLxE03/KAMf4UFSpEWI5AOK6trRsJLBDt5PNB8ZE9vJ0KUNxAYyrsvgekIr0/DHGqZrbKtm5c0iK2Is3NDtfws86qTxjy6JwnzUpyFvuHp+t3tmukqmtT2gRDrJwypaiXD/A61OaMtbPb/MhU2tpro0JrSrzNBdKBvzcjwgR3YZgpD2RJjscIQ+I9QoadC5J3xEHsaz5xz8BIdOaxWZ5cdQmJWj+hXj0uf6iRZHUgFCef/GMeINJHkKAw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(136003)(376002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6486002)(8676002)(8936002)(86362001)(5660300002)(4326008)(66556008)(66476007)(316002)(66946007)(7416002)(38350700005)(36756003)(2906002)(41300700001)(38100700002)(6512007)(52116002)(6666004)(83380400001)(6506007)(1076003)(26005)(2616005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OTeQOviWeloyQDFLVCZhtbu4wzAOMshI35JgtT81FAPfoULYyyBf2YVLcWF6?=
 =?us-ascii?Q?G6VuhW+dsP3sGH1zzckXSl9RJtrNvAZ/5O+/YeMvdTib/PjPMjL1S7/z7TCL?=
 =?us-ascii?Q?zdbbK+KiCPrkhhbUK4FwzGDH4Y1mGznArvfwG+YJRQLLKwj2SwXZ1c2VQuP2?=
 =?us-ascii?Q?W6FeQOkO/OMiTcRbQdJax0Wah08XvBJ7F6js4oq0JRigtP6ghZ3ntwwhyEtF?=
 =?us-ascii?Q?8FH0xXNL3lzcdZLyhyF2QSXN/Yqst2Z78leIxCAGMJF/tZDWhxKmH5Yvj1gG?=
 =?us-ascii?Q?H+I1Lb9qKC+kno1oLhkhJUJeBi2exCgGMtZ6IKmxIitnb9OqcsOkZHzu5I/4?=
 =?us-ascii?Q?A4wOhJy5SRt13MXPQYIgkSKcndUliVwDBtjVgl/OGZHlVrcKJPUZj1Tibm5w?=
 =?us-ascii?Q?/k1S5YlSx5bQm1xy7GymV3jEcbA4IbHfHXYiABhfkU5qOdTwCj3AzVeDxEoS?=
 =?us-ascii?Q?BNWAanEDnb8E87ZSZ2fMd58ChbMTx71EiFiuO3gj8jhr2UeDSoPrTyUCO+NG?=
 =?us-ascii?Q?hQrZfS8YhQnhv2rp9MlVgOdCu30m/ecxP+RgvOZTCgAs4o5zbP4TtitqyyOA?=
 =?us-ascii?Q?Btw+/PpgqCZRUgqPIALTH3LL5y2n3+HfcDvey3u87v3WJqxqsF89n4MzP++1?=
 =?us-ascii?Q?5ZlkZERoyiHzT+h+PtTQvaRFfEkwiZdJRerKE8ow4id8CCBTdseeU3I3AaML?=
 =?us-ascii?Q?YBEBWvCaMGrW5cuC1h+fN55DTK4kjak1ugTaY7UHNu2YBH3bRYyB2AepoCHa?=
 =?us-ascii?Q?8bo0x9IxFTPOxlH0u7x+8iZq4sn5h0LJaPTuOdUx896Z1QMrx4vogDMSB1e+?=
 =?us-ascii?Q?ILDKrN5yeqn23tH7k7mu3hmUrrWA1yY2YpU9b95y402C/rGlzXvBem8Zn3wx?=
 =?us-ascii?Q?MW0R6C9FXRPiLtEld8gDyarPRzfj0ioasGoeS6tyAh65wG/KLq6fLtrYf7X2?=
 =?us-ascii?Q?p8G7PbhRP5HFTgup4/9JazbvGNMzdFAkYORuEfZqD+RmLTRAoWVnW+KZ5C8G?=
 =?us-ascii?Q?cCYqOQV3Pj90I7YpdkbJZj9zvILK+ITfsnIDUzE15S+ujqUbynHn32Y9cOMm?=
 =?us-ascii?Q?MpdF8bplh7B8R/6PHdPSB+iSzkvnhYZRZwSqT3DUUS10d6jg0s7m5ya7EMhY?=
 =?us-ascii?Q?Z61asftS3RtCP0xuja4OxR8+HPe3ljh2wK2jTZfFLKkSSEUyFmsSTUxL6f+K?=
 =?us-ascii?Q?jKdvE4PRF8KC7qx5QBWWUnPfLke8wJ1tqBk5+uztC619urxH35yQs9XWxhqg?=
 =?us-ascii?Q?9EVAu6V93alLZih4mNJUw9wuA5KR24gMPiiMvoojputUKCEshHBEV+n6Ecj3?=
 =?us-ascii?Q?JOEAs4TkTj48JvkaX5eUthhLjtwXXrm7OPTtZh8Zv04aURxvPhKTv/juq/BB?=
 =?us-ascii?Q?U4jgBU572PysKAHcG50SjPMB9qoaudWdt3Q1PsLQqCt5TWlHhzzKtaOAahXG?=
 =?us-ascii?Q?HYtuVHIa7CydEIutq5aDXpEzfRl4lkd3ZIg0l2fsWaBEPvzD/ZZGDYR59vBx?=
 =?us-ascii?Q?KIxlXU+p4coGNaw6humYa1mX1iopFmjujR5+fegJ3F0bMTkaoNbTxQKLv1Yp?=
 =?us-ascii?Q?F9UIOAEU4kmeMl25cpU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab9a493-8cba-4c4d-27f6-08dc1204f054
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 17:52:40.2778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTeGZNaEb9N+mjPZVsi10GRev1sv7Fq50sQiBaultAtMknQqWqwbb+/2m1WWVo2hFDaduwWSMdjgMcw5H8pC6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9332

This  patch introduces support for I3C target mode, which is referenced
with a PCIe Endpoint system. It also establishes a configuration framework
(configfs) for the I3C target controller driver and the I3C target function
driver

Typic usage as

The user can configure the i3c-target-tty device using configfs entry. In
order to change the vendorid, the following commands can be used

        # echo 0x011b > functions/tty/func1/vendor_id
        # echo 0x1000 > functions/tty/func1/part_id
        # echo 0x6 > functions/tty/t/bcr

Binding i3c-target-tty Device to target Controller
------------------------------------------------

In order for the target function device to be useful, it has to be bound to
a I3C target controller driver. Use the configfs to bind the function
device to one of the controller driver present in the system::

        # ln -s functions/pci_epf_test/func1 controllers/44330000.i3c-target/

Host side:
        cat /dev/ttyI3C0
Taret side:
        echo abc >/dev/ttyI3C0

Change from v1 to v2
- change "slave" to "target"
- include master side tty patch
- fixed dtbcheck problem
- fixed kerne-doc check warning

Some review comment may be lost since it is quite long time since v1. Now
master side dependent patches already in linux-next. So sent target side
patches with tty support again.

No sure why an additional "\r\n" appended.

Frank Li (7):
  i3c: add target mode support
  dt-bindings: i3c: svc: add compatible string i3c:
    silvaco,i3c-target-v1
  Documentation: i3c: Add I3C target mode controller and function
  i3c: target: add svc target controller support
  i3c: target: func: add tty driver
  i3c: add API i3c_dev_gettstatus_format1() to get target device status
  tty: i3c: add TTY over I3C master support

 .../bindings/i3c/silvaco,i3c-master.yaml      |   7 +-
 Documentation/driver-api/i3c/index.rst        |   1 +
 .../driver-api/i3c/target/i3c-target-cfs.rst  | 109 +++
 .../driver-api/i3c/target/i3c-target.rst      | 189 +++++
 .../driver-api/i3c/target/i3c-tty-howto.rst   | 109 +++
 Documentation/driver-api/i3c/target/index.rst |  13 +
 drivers/i3c/Kconfig                           |  32 +-
 drivers/i3c/Makefile                          |   4 +
 drivers/i3c/device.c                          |  24 +
 drivers/i3c/func/Kconfig                      |   9 +
 drivers/i3c/func/Makefile                     |   3 +
 drivers/i3c/func/tty.c                        | 475 +++++++++++
 drivers/i3c/i3c-cfs.c                         | 389 +++++++++
 drivers/i3c/internals.h                       |   1 +
 drivers/i3c/master.c                          |  26 +
 drivers/i3c/target.c                          | 453 ++++++++++
 drivers/i3c/target/Kconfig                    |   9 +
 drivers/i3c/target/Makefile                   |   4 +
 drivers/i3c/target/svc-i3c-target.c           | 795 ++++++++++++++++++
 drivers/tty/Kconfig                           |  13 +
 drivers/tty/Makefile                          |   1 +
 drivers/tty/i3c_tty.c                         | 426 ++++++++++
 include/linux/i3c/device.h                    |   1 +
 include/linux/i3c/target.h                    | 511 +++++++++++
 24 files changed, 3600 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/driver-api/i3c/target/i3c-target-cfs.rst
 create mode 100644 Documentation/driver-api/i3c/target/i3c-target.rst
 create mode 100644 Documentation/driver-api/i3c/target/i3c-tty-howto.rst
 create mode 100644 Documentation/driver-api/i3c/target/index.rst
 create mode 100644 drivers/i3c/func/Kconfig
 create mode 100644 drivers/i3c/func/Makefile
 create mode 100644 drivers/i3c/func/tty.c
 create mode 100644 drivers/i3c/i3c-cfs.c
 create mode 100644 drivers/i3c/target.c
 create mode 100644 drivers/i3c/target/Kconfig
 create mode 100644 drivers/i3c/target/Makefile
 create mode 100644 drivers/i3c/target/svc-i3c-target.c
 create mode 100644 drivers/tty/i3c_tty.c
 create mode 100644 include/linux/i3c/target.h

-- 
2.34.1


