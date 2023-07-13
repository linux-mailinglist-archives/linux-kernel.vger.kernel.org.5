Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3AB752090
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbjGML5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjGML5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:57:09 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07592D48;
        Thu, 13 Jul 2023 04:56:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EH1KO8+lagfabXSAkR0uVaxnV8VQ4tZEfexCFDg6vzspcdDN8RHfT2B46Oz9IIv+OlQNoeMWQ7lGHBvxHbZafflFX+b/Ul2iM2HKfWulanH6PEL1lQwhabgR/xLzLrPS7Hk2ZLpjRpxWW2nKl2tFIJrvtE9h/4vTF7fmbr+QmclDQMARJkQm4sMUJpZHdbcGTRw7YOyEgOBHi1pmE7OOl9d2OgPrJeDxYtwpj/oNnFRHdfqEFA086l39g8BO9yeGudy3+GBhVp61s3Lzmq/CW85y5m54neXRyH6h0qWhrPPdCovESi6rGiSxJ+VpF3OMSyMaDLt+TWSxUjew3I/2dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3mFyp/VYjBVmw282+eG2V/tGp60c1ECHjK0ePqsEOo=;
 b=PxBnbmnsr2VrHL/QXCE6RnZ6ZjjlnQKy+wpBjqpDHbEdPn9YeoR5ptj0zwV0RweMURwDidsvM47vv0AN491+jpV5JD/5fP6lJQlLEgK610RK3UI9TzqcgJu1R8ONmUAtTRDbvMCN6jpBzs9eoOvHFn04eU9IgajUx8jfmGmYifWtOQUuWhpnXrTjMpa40ZeJeCHgd359YUFv7drxSPjEOQzWW1wxagKzsBSJRN5WQq09A47s7fzj+ohuz6YdrVI3HEf7ZM5zwrVb01eBkrt7jyH36n0022dPtDeBOvKj6dDCV1DEi07uO79goVIDZGPu8VsXQHImOWA+ubkcJGrsxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3mFyp/VYjBVmw282+eG2V/tGp60c1ECHjK0ePqsEOo=;
 b=WMGrfBiM/opE0sRYfcYOOCrQ3lcC/1CTABnfR8ozmYnoydIKlwDFjkoVJGvwGLWnc0/CiF+xypxXP26ifogIMiCE+1FuEmaHebJishK+EQqXEtfwFgigqxnWxnZ1d2WT765RFt/Nd6ZvGv1fKJfL6TE+KZkMCSVhqxULEtTGlKTfXt7qzkviLjuC4gjrmlO04bkrUdiEfC+0qqOWhA7lWCXrsW7TLjdq+h1Qc63qxubYLV2PUjVrJE5gCTGhMKg862tvARXxq3EvgFVN4BmWBdQ1A+L2ZHkZoWPkLk2Sy2tlTWSN7I85RNRK+JO3prO/Y16ZRnsrrwqVQ2CYEmBClQ==
Received: from OS6P279CA0142.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:3a::16)
 by AS2PR10MB6951.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:579::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 11:56:51 +0000
Received: from HE1EUR01FT080.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:3a:cafe::11) by OS6P279CA0142.outlook.office365.com
 (2603:10a6:e10:3a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24 via Frontend
 Transport; Thu, 13 Jul 2023 11:56:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT080.mail.protection.outlook.com (10.152.0.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 11:56:51 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 13:56:50 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.69.128) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 13 Jul 2023 13:56:50 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Tobias Schaffner <tobias.schaffner@siemens.com>,
        "xingtong . wu" <xingtong.wu@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2 0/2] leds: simatic-ipc-leds-gpio: add new model BX-21A
Date:   Thu, 13 Jul 2023 13:56:37 +0200
Message-ID: <20230713115639.16419-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.128]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT080:EE_|AS2PR10MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c94e3a-d686-4e87-1c1d-08db83983ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUVLPAbN1zP+wMugSMhTHZkiHsb+gwRBDrpfkS8mVTukbg4OdIU53RX+Y5VDgwqm9X12jE6F8RjFMA99jG7vki6oTvcKYCfZPUuB4NwsR2uZXHMLrLZ7oLRO6VKlAqcW12DKTgp3zMW4T2DO9NAlkw0UMa98r8NiqBkwBMkDJRvNAyQdpBV3Fehu90mbgBX1NwziqHYFWxpQ1vR7LDDj+x8sUOfAtSi3f8zyvx50jOcS1+v2yrrhrWhowT1xPKcfS+rksvFAD7pBFBdkVkH9bY/iHo0RQ91SXjV2a/ROPWRN/juPp00PnygZOm+rNTyD0Ou+ly6f/lYzMZspngV4WCMO/xrmEEgoA5dqnd0yv7P1acc6/qa7osFbCmB5liImm+hPKR/37KDRwwWhBRlhV6JPiBD8yCk+0CCfe97zXkEe2PufdkczDvsR9JxxpwNim8CE2b2UY9xCTtR9gD9ebvCYNRw55gGe8QJceW3kXNkwN1UCekHF7bSjmh37FKpgfOpJMtJpB20vXZRppeFjOm6PnBeB8HaMMmvGBY078oih8EPhWXSgJx6AgkDEYnFP5srdIeYLDFmX1hBo/fO5EbmpEdSZ2lVTuAmd3XiVwZQHd4+vJgoLxVHyqVF9JCaYSzCSK7m/NQCbulLoJv9PjBrqJzY5C74KzrcOPhHBmbIBrMMbxzROLlAMhgFCFPMRDaUg+T9hd5pIS7psKf9r8iJbMi+08yyNMb7zu44W5KO08bWujOmsJRn4SoomhuMK9t2T2ln4XcNIns2Jrk/HUg==
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(2906002)(82310400005)(81166007)(356005)(82740400003)(82960400001)(83380400001)(47076005)(16526019)(956004)(186003)(336012)(2616005)(107886003)(26005)(40480700001)(1076003)(36860700001)(5660300002)(40460700003)(86362001)(8936002)(8676002)(4744005)(36756003)(44832011)(110136005)(478600001)(54906003)(6666004)(41300700001)(70206006)(316002)(4326008)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 11:56:51.1354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c94e3a-d686-4e87-1c1d-08db83983ea2
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT080.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6951
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change since v1:
- split into two patches to separate leds from platform code and ease
  merging

These are rather simple patches adding LED support for yet another Simatic
IPC model.

Henning Schild (2):
  platform/x86: simatic-ipc: add another model BX-21A
  leds: simatic-ipc-leds-gpio: add Elkhart Lake version

 drivers/leds/simple/Kconfig                   | 13 +++++
 drivers/leds/simple/Makefile                  |  1 +
 .../leds/simple/simatic-ipc-leds-gpio-core.c  |  4 ++
 .../simatic-ipc-leds-gpio-elkhartlake.c       | 57 +++++++++++++++++++
 drivers/platform/x86/simatic-ipc.c            |  3 +
 .../platform_data/x86/simatic-ipc-base.h      |  3 +-
 include/linux/platform_data/x86/simatic-ipc.h |  3 +-
 7 files changed, 82 insertions(+), 2 deletions(-)
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-elkhartlake.c

-- 
2.41.0

