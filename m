Return-Path: <linux-kernel+bounces-22568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B22A829FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2903D1F2743A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80054E1B6;
	Wed, 10 Jan 2024 17:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DpmzU5Sd"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3B94E1AA;
	Wed, 10 Jan 2024 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Efcc99vmQBPS1st09pSIY+xa871dT8pKeQToU4KhhnKrlaZCzJDTK0TuDyoKT4Vi+n+Qi3I9xZBA4HLBdEuLVJFAk2bJzoJfFz2ff6E3FMDXbb/DXTHIWdpJH3fcDrdKQ48VUZw84g2zq8DQA7ADKDYeG/ORhqiAs3fyi+Joqs2rIZHhRtabJH07wHrxAgGadDPHSAfwk+PldjdHADmYVSNoenpmQ+g/cGWW83nokv1pCYnWVJ1gWhPRlqAOCE2oLlBKnW/MVUDuOHSgvp5bFnfIPE8rx3ESEl49k5GwBuIsKKp1ZBAmquYL/0XmXvJBZIWMRnbzuFe5Kv3/oCZdcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcAD7n5DFC8zY5SMsqG6DN1S/Q3hAt3IaNHuvXjxowM=;
 b=N250vdKsgVm1ShTrkubA36sGNSsXDAe7jNCUqBYB9BKpRYCUw263Z0fUuoqGBw9jhaNpS+fy8IAxsBjeRWhP5l66Q5byK0MMdzgT89cgaoqVi2ykobNpc6vuISnLJ6EwRttYZRQc/TxXiIKtpoT4MaVrhzpli1aJ+nNWXlTZ8BonpHpOxLT9Dw8ugK6NbBc0XKJ4yXjVxwvVOc8gXHccTMZuy0R+hHz511ZhrVVEqgNuzauXIxYwoRmDy/VrPxFpzyIzmreBRB5RsDUm/nU5yXEnDgs9iEs/WqpMNYhSp9Qiz8i1Qv29Gwj8RyaVTUHauUbejai0aMklL6oBoLjOpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcAD7n5DFC8zY5SMsqG6DN1S/Q3hAt3IaNHuvXjxowM=;
 b=DpmzU5SdxPk0EjRi+SNfQtzEgFVGE4v10ewpzRD1wWrjXxtXd/G6NlSODNPBbA7ljIaurOhNzNP5Pk3ech2TV5UYT2qQ9hT5pRM4UjHMOybgnWrbX46XQEwXGTdyBQQ0B+b7LrL8lPLww/qWqFg7WEJtvFa5tHWQN2yySQjdbec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by DB9PR04MB9332.eurprd04.prod.outlook.com (2603:10a6:10:36c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 17:52:52 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 17:52:52 +0000
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
Subject: [PATCH v2 3/7] Documentation: i3c: Add I3C target mode controller and function
Date: Wed, 10 Jan 2024 12:52:17 -0500
Message-Id: <20240110175221.2335480-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110175221.2335480-1-Frank.Li@nxp.com>
References: <20240110175221.2335480-1-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9dab7bb1-443b-4067-27d3-08dc1204f7a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9nxJvlIsVZu1vygP9uDqSDsLozArq9IHfwZ5YVZJEdISG8FpjHT5GlhaJeEY025K1k1bu1eJf/iIrulDHP6u5AJgx9uvT1XWp0jXWhLo3RSojMxMK8XmRid6Zw72aqsyZVsklQ4KH+YswYvySCvK3Yd45h1t2y8hiaIh7PsNJhDg2or6S23nhhk27et1E+E05dfN6Na3O1jIli4ITsbvdyfMdjMgHoyy3QiFwkmjvE2YE6rPA1Eh+fRzMtDz5jEcRGBp8AkzfLlO9XpDYEBNwBdHFOUaU/VM5iP8Hmh8R9JGi3d959+kNP6IHQbAX2RCIc/who1pp4Ug0YUfDeaioimQaMN4ay2bJIJqzftzzNTAXCV5oa28PeJKx0ygwMYlqF5XtkUfjIidLVt/173m1RN6HJQy2zuzIqAA6Kl/U1Fe2HVMa9uX5oRHvOXRF/5zOEpvBRCpNLu/AhsI7TeVXpasz5JXK4tm/dNAWl166tKNWogppfTMAs+WOm3ShMN1yrfr/Drri5p/2MxoxWF3KC0m2SRtqNX9pTpW/b0d3GfEqW4GqcyPdtmPCwTkmqKAH3xJszWFImlMlVDeu12kf4El5NWEartUPpyhejenm2Z6bEh5gE/UZoZDX4eW9Q3C
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6486002)(8676002)(8936002)(86362001)(5660300002)(4326008)(66556008)(30864003)(66476007)(316002)(66946007)(7416002)(38350700005)(36756003)(2906002)(41300700001)(38100700002)(6512007)(52116002)(6666004)(83380400001)(6506007)(1076003)(26005)(2616005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yeRWtNAmFAccgJMBzf1P3XfOLK4aULOd6oWaWpJo+enGwgfr/y7zszTxH4Wr?=
 =?us-ascii?Q?Sjoiowdpxx8kRsuryqlPlb0LH+QsLg/EzWI6tirUNJ4dkz00wqKn3kUBBxcT?=
 =?us-ascii?Q?fZTp8xOG4DVoBpox8+UclI75xa/Uy5XYQmZNHN+nh9zo2Vi4IY3JVU7Ptx/S?=
 =?us-ascii?Q?RIo5xz4oAaxSooIXL5YsrMr8mzMEOsF7swETHiEQNJgWifwH5yuQ//r8uSRO?=
 =?us-ascii?Q?QD441yUZPWZMd4LhDfEVVwClfepAo3MGz442q0iMbZZhr+FKL9eBm+D46UdL?=
 =?us-ascii?Q?/+PJbj5tX+dlho02tOo3VvyGQQWlYrF3iGVECzHXJXMLcvwb/sANi/rOkpGi?=
 =?us-ascii?Q?0eFOqSbKhfm2+NbqBUfCwuMNu+gimgxNafk2A3SB+5UH5pWSWXW/sgRijyFb?=
 =?us-ascii?Q?6jtV45LoK7dw5zw1ddfJBC7NHXRFtEJbQzXwTLKquMRFYhlsRXhmPn3ZtcX5?=
 =?us-ascii?Q?OogZQ0JAavUgh9zDU1VH2mSNW+/2mOZGZhl6wGlN0WdOE82NdmJ2lO74a8m+?=
 =?us-ascii?Q?c9dK3xUaH3OH8Lp42pIcdvMqoLFIsGzfiU5RW9jex3VoM9L2KVb+EvAp4AV9?=
 =?us-ascii?Q?AJf+FJbt0sbmCUIbBYZ76Nf98WHjU1XJdy8+2p+Gr6KNer+YFYYtWB8iAzar?=
 =?us-ascii?Q?Bu5jsG0wuo/mh96WVURM/TJrQMECeFRF6MvTVyyTqbiqvmL3w7Z7N2yu0Bl0?=
 =?us-ascii?Q?/vbpcEcGAJBtc9qTp/gN1nYHqbxzM5knUqCIwVr5FRPp+N3902Ni6cVgnM/c?=
 =?us-ascii?Q?BlzkmkUg9Ry/xW0MzGkRH2yX8ybt/JzIDX5m5sOfISuGbpqtg3cGdLjwu8LQ?=
 =?us-ascii?Q?PZoWTVzcZMo/k+jMtg8BJuDq0xkQs0+TxhS/DVrNbdRour/xaevRFLS1XuMA?=
 =?us-ascii?Q?ySl7755qE5Nn6TZVL395uZ0Wo36SkSUc2qJzfraq99GTfBmhJkEToPpe33og?=
 =?us-ascii?Q?RI5KcV7W1C9dc24pMa/x0eCCfj6oIV23Uy2Wyoq6Cmljcws+tr1xuDmdm0GK?=
 =?us-ascii?Q?4ba/OY66ZCvHl3dchASoeLQMlpp0w+/07fV2gwMqAJ8MbVtAilNiEUB34Avi?=
 =?us-ascii?Q?oOhyRYHQPMPbDKGVPPxeJh7/AdBIPRY8jWp+qfNOMmaEF6aRl5boAngTjuC8?=
 =?us-ascii?Q?896736hptwDo7UQHOxZt2tPY+ln3AEL6iU6UAf3zZXcpEC4vsPfQ92JMAzr8?=
 =?us-ascii?Q?6Vcq6cLcKrS5HeZLUxggKLFfqqxd6CNrNZ3GMxdtoBQ2pLzXzAknZZ3kC3eB?=
 =?us-ascii?Q?LYudKWWpIzJ++0UirtZA7+K/tDtgxY0pdGFdrLGpxPfa11gXV5lBRq6ezvfv?=
 =?us-ascii?Q?94l3sbKhOJUJ994NbYfxsacC6WeemryB7kLiUsiMPZ0EFp/vzU67AkxdUzdL?=
 =?us-ascii?Q?1olP/AFQ/wOo89keLaIgVilH/2lFqE06xZoK+PiytX7v5FO2Tq7x/txulrGM?=
 =?us-ascii?Q?hyGzIg0X3QmFoCCoY2w/iXGzftX0NFN9/3cD/y4fGw4Ki5xvmrrkJZilpELH?=
 =?us-ascii?Q?TWp7cpbtBuiTkfYLkJDgM0/xAMoTIWPLE2cr2UjIVIn8MUQhLyc9opCdEbz6?=
 =?us-ascii?Q?oa26LoqxEeUUjJ6mniI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dab7bb1-443b-4067-27d3-08dc1204f7a6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 17:52:52.6545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJz3VUmUhBHLT6Rbxzuxu4LjoNr+5QABbmLlnNMElzcNa5v5A/NnJMAcfTJqhRI24y+QXkNvzsdjFSzugl8igQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9332

Add I3C target mode and tty over i3c func driver document.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/driver-api/i3c/index.rst        |   1 +
 .../driver-api/i3c/target/i3c-target-cfs.rst  | 109 ++++++++++
 .../driver-api/i3c/target/i3c-target.rst      | 189 ++++++++++++++++++
 .../driver-api/i3c/target/i3c-tty-howto.rst   | 109 ++++++++++
 Documentation/driver-api/i3c/target/index.rst |  13 ++
 5 files changed, 421 insertions(+)
 create mode 100644 Documentation/driver-api/i3c/target/i3c-target-cfs.rst
 create mode 100644 Documentation/driver-api/i3c/target/i3c-target.rst
 create mode 100644 Documentation/driver-api/i3c/target/i3c-tty-howto.rst
 create mode 100644 Documentation/driver-api/i3c/target/index.rst

diff --git a/Documentation/driver-api/i3c/index.rst b/Documentation/driver-api/i3c/index.rst
index 783d6dad054b6..345a43c9f61b0 100644
--- a/Documentation/driver-api/i3c/index.rst
+++ b/Documentation/driver-api/i3c/index.rst
@@ -9,3 +9,4 @@ I3C subsystem
    protocol
    device-driver-api
    master-driver-api
+   target/index
diff --git a/Documentation/driver-api/i3c/target/i3c-target-cfs.rst b/Documentation/driver-api/i3c/target/i3c-target-cfs.rst
new file mode 100644
index 0000000000000..1fcf829dc4ae2
--- /dev/null
+++ b/Documentation/driver-api/i3c/target/i3c-target-cfs.rst
@@ -0,0 +1,109 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================================
+Configuring I3C Target Using CONFIGFS
+=======================================
+
+:Author: Frank Li <Frank.Li@nxp.com>
+
+The I3C Target Core exposes configfs entry (i3c_target) to configure the I3C
+target function and to bind the target function with the target controller.
+(For introducing other mechanisms to configure the I3C Target Function refer to
+[1]).
+
+Mounting configfs
+=================
+
+The I3C Target Core layer creates i3c_target directory in the mounted configfs
+directory. configfs can be mounted using the following command::
+
+	mount -t configfs none /sys/kernel/config
+
+Directory Structure
+===================
+
+The i3c_target configfs has two directories at its root: controllers and
+functions. Every Controller device present in the system will have an entry in
+the *controllers* directory and every Function driver present in the system will
+have an entry in the *functions* directory.
+::
+
+	/sys/kernel/config/i3c_target/
+		.. controllers/
+		.. functions/
+
+Creating Function Device
+===================
+
+Every registered Function driver will be listed in controllers directory. The
+entries corresponding to Function driver will be created by the Function core.
+::
+
+	/sys/kernel/config/i3c_target/functions/
+		.. <Function Driver1>/
+			... <Function Device 11>/
+			... <Function Device 21>/
+			... <Function Device 31>/
+		.. <Function Driver2>/
+			... <Function Device 12>/
+			... <Function Device 22>/
+
+In order to create a <Function device> of the type probed by <Function Driver>,
+the user has to create a directory inside <Function DriverN>.
+
+Every <Function device> directory consists of the following entries that can be
+used to configure the standard configuration header of the target function.
+(These entries are created by the framework when any new <Function Device> is
+created)
+::
+
+		.. <Function Driver1>/
+			... <Function Device 11>/
+				... vendor_id
+				... part_id
+				... bcr
+				... dcr
+				... ext_id
+				... instance_id
+				... max_read_len
+				... max_write_len
+				... vendor_info
+
+Controller Device
+==========
+
+Every registered Controller device will be listed in controllers directory. The
+entries corresponding to Controller device will be created by the Controller
+core.
+::
+
+	/sys/kernel/config/i3c_target/controllers/
+		.. <Controller Device1>/
+			... <Symlink Function Device11>/
+		.. <Controller Device2>/
+			... <Symlink Function Device21>/
+
+The <Controller Device> directory will have a list of symbolic links to
+<Function Device>. These symbolic links should be created by the user to
+represent the functions present in the target device. Only <Function Device>
+that represents a physical function can be linked to a Controller device.
+
+::
+
+			 | controllers/
+				| <Directory: Controller name>/
+					| <Symbolic Link: Function>
+			 | functions/
+				| <Directory: Function driver>/
+					| <Directory: Function device>/
+						| vendor_id
+						| part_id
+						| bcr
+						| dcr
+						| ext_id
+						| instance_id
+						| max_read_len
+						| max_write_len
+						| vendor_info
+
+[1] Documentation/I3C/target/pci-target.rst
diff --git a/Documentation/driver-api/i3c/target/i3c-target.rst b/Documentation/driver-api/i3c/target/i3c-target.rst
new file mode 100644
index 0000000000000..09ae26b1f311a
--- /dev/null
+++ b/Documentation/driver-api/i3c/target/i3c-target.rst
@@ -0,0 +1,189 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+:Author: Frank Li <Frank.Li@nxp.com>
+
+This document is a guide to use the I3C Target Framework in order to create
+target controller driver, target function driver, and using configfs interface
+to bind the function driver to the controller driver.
+
+Introduction
+============
+
+Linux has a comprehensive I3C subsystem to support I3C controllers that
+operates in master mode. The subsystem has capability to scan I3C bus,assign
+i3c device address, load I3C driver (based on Manufacturer ID, part ID),
+support other services like hot-join, In-Band Interrupt(IBI).
+
+However the I3C controller IP integrated in some SoCs is capable of operating
+either in Master mode or Target mode. I3C Target Framework will add target mode
+support in Linux. This will help to run Linux in an target system which can
+have a wide variety of use cases from testing or validation, co-processor
+accelerator, etc.
+
+I3C Target Core
+=================
+
+The I3C Target Core layer comprises 3 components: the Target Controller
+library, the Target Function library, and the configfs layer to bind the target
+function with the target controller.
+
+I3C Target Controller Library
+------------------------------------
+
+The Controller library provides APIs to be used by the controller that can
+operate in target mode. It also provides APIs to be used by function
+driver/library in order to implement a particular target function.
+
+APIs for the I3C Target controller Driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This section lists the APIs that the I3C Target core provides to be used by the
+I3C controller driver.
+
+* devm_i3c_target_ctrl_create()/i3c_target_ctrl_create()
+
+   The I3C controller driver should implement the following ops:
+
+	* set_config: ops to set i3c configuration
+	* enable: ops to enable controller
+	* disable: ops to disable controller
+	* raise_ibi: ops to raise IBI to master controller
+	* alloc_request: ops to alloc a transfer request
+	* free_request: ops to free a transfer request
+	* queue: ops to queue a request to transfer queue
+	* dequeue: ops to dequeue a request from transfer queue
+	* cancel_all_reqs: ops to cancel all request from transfer queue
+        * fifo_status: ops to get fifo status
+        * fifo_flush: ops to flush hardware fifo
+	* get_features: ops to get controller supported features
+
+   The I3C controller driver can then create a new Controller device by
+   invoking devm_i3c_target_ctrl_create()/i3c_target_ctrl_create().
+
+* devm_i3c_target_ctrl_destroy()/i3c_target_ctrl_destroy()
+
+   The I3C controller driver can destroy the Controller device created by
+   either devm_i3c_target_ctrl_create() or i3c_target_ctrl_create() using
+   devm_i3c_target_ctrl_destroy() or i3c_target_ctrl_destroy().
+
+I3C Target Controller APIs for the I3C Target Function Driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This section lists the APIs that the I3C Target core provides to be used by the
+I3C target function driver.
+
+* i3c_target_ctrl_set_config()
+
+   The I3C target function driver should use i3c_target_ctrl_set_config() to
+   write i3c configuration to the target controller.
+
+* i3c_target_ctrl_enable()/i3c_target_ctrl_disable()
+
+   The I3C target function driver should use i3c_target_ctrl_enable()/
+   i3c_target_ctrl_disable() to enable/disable i3c target controller.
+
+* i3c_target_ctrl_alloc_request()/i3c_target_ctrl_free_request()
+
+   The I3C target function driver should usei3c_target_ctrl_alloc_request() /
+   i3c_target_ctrl_free_request() to alloc/free a i3c request.
+
+* i3c_target_ctrl_raise_ibi()
+
+   The I3C target function driver should use i3c_target_ctrl_raise_ibi() to
+   raise IBI.
+
+* i3c_target_ctrl_queue()/i3c_target_ctrl_dequeue()
+
+   The I3C target function driver should use i3c_target_ctrl_queue()/
+   i3c_target_ctrl_dequeue(), to queue/dequeue I3C transfer to/from transfer
+   queue.
+
+* i3c_target_ctrl_get_features()
+
+   The I3C target function driver should use i3c_target_ctrl_get_features() to
+   get I3C target controller supported features.
+
+Other I3C Target Controller APIs
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+There are other APIs provided by the Controller library. These are used for
+binding the I3C Target Function device with Controlller device. i3c-cfs.c can
+be used as reference for using these APIs.
+
+* i3c_target_ctrl_get()
+
+   Get a reference to the I3C target controller based on the device name of
+   the controller.
+
+* i3c_target_ctrl_put()
+
+   Release the reference to the I3C target controller obtained using
+   i3c_target_ctrl_get()
+
+* i3c_target_ctrl_add_func()
+
+   Add a I3C target function to a I3C target controller.
+
+* i3c_target_ctrl_remove_func()
+
+   Remove the I3C target function from I3C target controller.
+
+I3C Target Function Library
+----------------------------------
+
+The I3C Target Function library provides APIs to be used by the function driver
+and the Controller library to provide target mode functionality.
+
+I3C Target Function APIs for the I3C Target Function Driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This section lists the APIs that the I3C Target core provides to be used
+by the I3C target function driver.
+
+* i3c_target_func_register_driver()
+
+   The I3C Target Function driver should implement the following ops:
+	 * bind: ops to perform when a Controller device has been bound to
+	   Function device
+	 * unbind: ops to perform when a binding has been lost between a
+	   Controller device and Function device
+
+  The I3C Function driver can then register the I3C Function driver by using
+  i3c_target_func_register_driver().
+
+* i3c_target_func_unregister_driver()
+
+  The I3C Function driver can unregister the I3C Function driver by using
+  i3c_epf_unregister_driver().
+
+APIs for the I3C Target Controller Library
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This section lists the APIs that the I3C Target core provides to be used by the
+I3C target controller library.
+
+Other I3C Target APIs
+~~~~~~~~~~~~~~~~~~~~
+
+There are other APIs provided by the Function library. These are used to notify
+the function driver when the Function device is bound to the EPC device.
+i3c-cfs.c can be used as reference for using these APIs.
+
+* i3c_target_func_create()
+
+   Create a new I3C Function device by passing the name of the I3C EPF device.
+   This name will be used to bind the Function device to a Function driver.
+
+* i3c_target_func_destroy()
+
+   Destroy the created I3C Function device.
+
+* i3c_target_func_bind()
+
+   i3c_target_func_bind() should be invoked when the EPF device has been bound
+   to a Controller device.
+
+* i3c_target_func_unbind()
+
+   i3c_target_func_unbind() should be invoked when the binding between EPC
+   device and function device is lost.
diff --git a/Documentation/driver-api/i3c/target/i3c-tty-howto.rst b/Documentation/driver-api/i3c/target/i3c-tty-howto.rst
new file mode 100644
index 0000000000000..43a129b18e938
--- /dev/null
+++ b/Documentation/driver-api/i3c/target/i3c-tty-howto.rst
@@ -0,0 +1,109 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================
+I3C TTY User Guide
+===================
+
+:Author: Frank Li <Frank.Li@nxp.com>
+
+This document is a guide to help users use i3c-target-tty function driver and
+i3ctty master driver for testing I3C. The list of steps to be followed in the
+master side and target side is given below.
+
+Endpoint Device
+===============
+
+Endpoint Controller Devices
+---------------------------
+
+To find the list of target controller devices in the system::
+
+	# ls  /sys/class/i3c_target/
+	  44330000.i3c-target
+
+If CONFIG_I3C_SLAVE_CONFIGFS is enabled::
+
+	# ls /sys/kernel/config/i3c_target/controllers/
+	  44330000.i3c-target
+
+
+Endpoint Function Drivers
+-------------------------
+
+To find the list of target function drivers in the system::
+
+	# ls /sys/bus/i3c_target_func/drivers
+	  tty
+
+If CONFIG_I3C_SLAVE_CONFIGFS is enabled::
+
+	# ls /sys/kernel/config/i3c_target/functions
+	  tty
+
+
+Creating i3c-target-tty Device
+----------------------------
+
+I3C target function device can be created using the configfs. To create
+i3c-target-tty device, the following commands can be used::
+
+	# mount -t configfs none /sys/kernel/config
+	# cd /sys/kernel/config/i3c_target/
+	# mkdir functions/tty/func1
+
+The "mkdir func1" above creates the i3c-target-tty function device that will
+be probed by i3c tty driver.
+
+The I3C target framework populates the directory with the following
+configurable fields::
+
+	# ls functions/tty/func1
+	bcr  dcr  ext_id  instance_id  max_read_len  max_write_len
+	part_id  vendor_id  vendor_info
+
+The I3C target function driver populates these entries with default values when
+the device is bound to the driver. The i3c-target-tty driver populates vendorid
+with 0xffff and interrupt_pin with 0x0001::
+
+	# cat functions/tty/func1/vendor_id
+	  0x0
+
+Configuring i3c-target-tty Device
+-------------------------------
+
+The user can configure the i3c-target-tty device using configfs entry. In order
+to change the vendorid, the following commands can be used::
+
+	# echo 0x011b > functions/tty/func1/vendor_id
+	# echo 0x1000 > functions/tty/func1/part_id
+	# echo 0x6 > functions/tty/t/bcr
+
+Binding i3c-target-tty Device to target Controller
+------------------------------------------------
+
+In order for the target function device to be useful, it has to be bound to a
+I3C target controller driver. Use the configfs to bind the function device to
+one of the controller driver present in the system::
+
+	# ln -s functions/tty/func1 controllers/44330000.i3c-target/
+
+I3C Master Device
+================
+
+Check I3C tty device is probed
+
+	# ls /sys/bus/i3c/devices/0-23610000000
+	0-23610000000:0  bcr  dcr  driver  dynamic_address  hdrcap
+	modalias  pid  power  subsystem  tty  uevent
+
+Using Target TTY function Device
+-----------------------------------
+
+Host side:
+	cat /dev/ttyI3C0
+Target side
+	echo abc >/dev/ttyI3C0
+
+You will see "abc" show at console.
+
+You can use other tty tool to test I3C target tty device.
diff --git a/Documentation/driver-api/i3c/target/index.rst b/Documentation/driver-api/i3c/target/index.rst
new file mode 100644
index 0000000000000..56eabfae83aa4
--- /dev/null
+++ b/Documentation/driver-api/i3c/target/index.rst
@@ -0,0 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+I3C Target Framework
+======================
+
+.. toctree::
+   :maxdepth: 2
+
+   i3c-target
+   i3c-target-cfs
+   i3c-tty-howto
+
-- 
2.34.1


