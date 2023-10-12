Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987AC7C7A0B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443025AbjJLXBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344180AbjJLXBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:01:09 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01hn2245.outbound.protection.outlook.com [52.100.0.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFDBBB;
        Thu, 12 Oct 2023 16:01:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTnmXVkp6TT3p6qghXsKXVd6oQFqkfvWtf9aH1ldnQjO9jgqOolawbM5zt+8bdFCPa/xmmT6aYa/Z/T6E6z1agBocbBfPRMPWtRHQunF3oAqfrTTNe+2NsiHguz6qGL30/23tD+e+BXbBIfAFkGIwDVS3MOEoUD1YzvmAyjjPIvAphMGplcp+rQ6NZ/iLAWQe1vZKQh7E8slyAnoHY373gSl2Xl3nSTwOR6ex4EbSstlz01I3ExiI27z6oCm66Mgr1iXQjnm9LKwAPDfJH2KzXAEYvSqpw4WCX25XKjljs7Gi32UfUQP59y5GG0ZWMR5Q/w1uN21DHjv8P0od9ET8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgSVUxNh0OmHlGGR3GkvOcnS3oGIWwE9w1UlKgsVmnA=;
 b=cPb/g4mhsvJkaHnZ7iTnbirKESPNeRI9c7DZAtU3/18C/1Ul0P+vlZcolDl+DzOVvoQ/0+ARmbN95ZQYMTayp4FQzogmyRG99q019yngXCum/Y+6YwPW7oORQOs/H48As4c2mUjEu5e0qAQ1FVMkNkcQZKHTYyrnJbWUOjNiti/6+u5ne/ClQLcgjdTMdZCw+teBCWjhYlIPV0wNlwxo0wRR6SmyCa3Y7JJiZOqhFZUxteHb3Z1j8xlL8m6eK4l1yGbjqYkrLPI8Nb4opzTJV/3vcqlP9+Yr/WH49FKAUXmy6w8fvU6E+sYY0LKtnC2ledI6fE7nqloDkIruLM35Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgSVUxNh0OmHlGGR3GkvOcnS3oGIWwE9w1UlKgsVmnA=;
 b=b4iqzyE0+NhPfjuxuv8aeUujqqFUe57WIrwU971tHTXkO8LJJWKRXgYD6Ln9byKjUAzAPl7L4A3648ya59AAgCG9vPMod+ipaELKIVBm/+YEnxvZeCFk4RAdkDjZE+lhPltxziTMr0zMLiGzu3Doi0nJvzcnQfUtAJqFmLbp/YA=
Received: from SI2PR04CA0010.apcprd04.prod.outlook.com (2603:1096:4:197::11)
 by JH0PR03MB7341.apcprd03.prod.outlook.com (2603:1096:990:8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Thu, 12 Oct
 2023 23:01:03 +0000
Received: from HK2PEPF00006FAF.apcprd02.prod.outlook.com
 (2603:1096:4:197:cafe::8a) by SI2PR04CA0010.outlook.office365.com
 (2603:1096:4:197::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Thu, 12 Oct 2023 23:01:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 HK2PEPF00006FAF.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 23:01:02 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Fri, 13
 Oct 2023 07:01:02 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Fri, 13 Oct
 2023 07:01:01 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 13 Oct 2023 07:01:01 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id 4D7BB68DD9;
        Fri, 13 Oct 2023 02:01:00 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 3709E21CFCC4; Fri, 13 Oct 2023 02:01:00 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <peter.chen@kernel.org>, <gregkh@linuxfoundation.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v6 0/3] usb: ChipIdea: add Nuvoton NPCM UDC support
Date:   Fri, 13 Oct 2023 02:00:54 +0300
Message-ID: <20231012230057.3365626-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAF:EE_|JH0PR03MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: c560588e-d4e4-4a2b-fd98-08dbcb771ba6
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mCp+u5zsgkYb+pBWI9M2hm3aBDDy74Cy9ZAUJhiV5lY15+0PlmVw5VV+QS2Z?=
 =?us-ascii?Q?qm8SpifFSj/0rCQ+Az0+UTdUz8g2S+9VlEWqCvVDLoe+N6V6d9224h6nOj84?=
 =?us-ascii?Q?hazVohfOzlXALUpiduDdV5y9n3OKVgGfo8GS+Qk4TdUQ+x91fAf+JOayS68M?=
 =?us-ascii?Q?Mf/tQYXOzdJzMSjrDayz+poKMLJFbxximelajoeJdWmNCWI4Mi0odOjHqOxj?=
 =?us-ascii?Q?LHhgXJPtfCyV01FAfgnzZKZnYlm+rsujeVVGt+1apcchpw8DkcEAkglL0YZi?=
 =?us-ascii?Q?0bMQkcOXX8DQWyoEnSqZyli8/YUAIcL7KL5lYDVKSDiemsjCPgPML+ck/Qax?=
 =?us-ascii?Q?XJZbiQEkuy+Gz5/fWgvN4AhGBUEKSm6NTa7A8PYToxbTGY8g4B3uupzCgIa7?=
 =?us-ascii?Q?vaoanWDADuiBn8zBKn8f8CazaEfUaH6SrNWRDsjXC4H0L5YL7P3n0c4Wbua/?=
 =?us-ascii?Q?wBKVL08hGcPDgRKjnPlhyBtogkt+D8SzuYOf+8mNtFNvngYpF5GGyW5tVVKK?=
 =?us-ascii?Q?rlT3QvZ4ZLP25gaKplHMr1PIzdbs0NaksRP09nHtOhzf/6YUe+Pa9fxXAE6d?=
 =?us-ascii?Q?fYF6fiyDncqpEtoPKoKV/G33EO7xrLR2DbLThEeFL7pnEsMG48woXa13IGIR?=
 =?us-ascii?Q?Py+H+5d5JxnNdI2224H6jurXRIHwQliusRxkWowrEorsYeH5VeS+ZPZMukZu?=
 =?us-ascii?Q?4rWNumh81uZWrBfRekYDICB+JcWj7eS38lLbjpdUb7NXH9BqHNwXc79pu5hD?=
 =?us-ascii?Q?dzhkkh4keSfM/FVqf4hGlgnyU5PXJEhkRn82nRCFUZpgFX2QvBG7stNtTzlN?=
 =?us-ascii?Q?0TvickAva3Fidk8EMXH1ti766EBG7BMe/k//cNbv/rPoI5iQKR0WD/8zldD6?=
 =?us-ascii?Q?T1gXzDlh/O92ogF4Ox1XU4qynS1fbfEBF2HZ+feC0TinaZwJBryYdSmvPb6F?=
 =?us-ascii?Q?1XUKcv5VcGzG/tIOAujPcw=3D=3D?=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(186009)(82310400011)(451199024)(5400799018)(64100799003)(48200799006)(61400799006)(40470700004)(36840700001)(46966006)(6666004)(41300700001)(1076003)(2616005)(82740400003)(40480700001)(83170400001)(36756003)(81166007)(40460700003)(356005)(55446002)(42882007)(36860700001)(966005)(6266002)(2906002)(47076005)(336012)(7416002)(42186006)(73392003)(478600001)(82202003)(34020700004)(316002)(8936002)(4326008)(26005)(83380400001)(70586007)(8676002)(70206006)(5660300002)(76482006)(54906003)(110136005)(45356006)(35450700002)(84790400001)(12100799048);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 23:01:02.8063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c560588e-d4e4-4a2b-fd98-08dbcb771ba6
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FAF.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7341
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set add USB device controller for the NPCM Baseboard
Management Controllers (BMC).

NPCM UDC driver is a part of the USB ChipIdea driver.

Adding CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS flag to modify the vbus_active
parameter to active in case the ChipIdea USB IP role is device-only and
there is no otgsc register.

BMC NPCM7XX and BMC NPCM8XX has ten identical NPCM UDC modules,

The NPCM UDC were tested on NPCM845 evaluation board.

Addressed comments from:
 - Krzysztof Kozlowski : https://www.spinics.net/lists/devicetree/msg639032.html

Changes since version 5:
 - Remove unnecessary npcm845-udc compatible.

Changes since version 4:
 - Modify npcm845-udc compatible.

Changes since version 3:
 - Add Acked-by Peter Chen.
 
Changes since version 2:
 - Use dev_err_probe.
 - Remove MODULE_ALIAS.

Changes since version 1:
 - Add SoC specific compatible.
 - Remove USB phy mux property from dt-binding, will be handled differently.
 - Add CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS commit to this patch set.

Tomer Maimon (3):
  usb: chipidea: add CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS flag
  dt-bindings: usb: ci-hdrc-usb2: add npcm750 and npcm845 compatible
  usb: chipidea: Add support for NPCM

 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml |   6 +
 drivers/usb/chipidea/Kconfig                  |   4 +
 drivers/usb/chipidea/Makefile                 |   1 +
 drivers/usb/chipidea/ci_hdrc_npcm.c           | 114 ++++++++++++++++++
 drivers/usb/chipidea/otg.c                    |   5 +-
 include/linux/usb/chipidea.h                  |   1 +
 6 files changed, 130 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/chipidea/ci_hdrc_npcm.c

-- 
2.33.0

