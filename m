Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C5C7BAA15
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjJETZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjJETZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:25:38 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01hn2247.outbound.protection.outlook.com [52.100.0.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26247FC;
        Thu,  5 Oct 2023 12:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPYPgWQmLfQqLjcfFPaHDpqg7YzlwrUuSmDMiNfIhAKObYtO5yb4mS7pJtlUerP9H6qEkaavEUXno+EmmfscVcqNOEfWr4LRZW/OqnqM0FbnAkmyfSWooTuIiYtAP8GDFxPfxq5PUqJucg6WZBGdDa3RPdUxuArgEPThJ7rKPgZu3RYxwJ3qTsaR10uGtJCnjy13f9iXg6SkZmgxG/I3yH1LF9DZ9nV5ubfl86JyD6EGJDe+qqRWH7BO39KKt+V32mj+JGXKaXqh8qfO51+HtKZ9MszY9vZWSwwPF7VJFyL+Aoqa8lL8GmiyZHzqMSjTWca1XOXFq2RInDXqS5c8FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60l/P/bwOWdg2MkoncNt9iPmES2WMDnbSSJxCzK/2sM=;
 b=d9FylyFR9/250wqsNC3Bmp55vhnx1sDnPMEnalks4Jm0s7j5F4r6FBBOPO5AamuyZBD13ogxSYOtdQvDo73m7Os/jO/4xtdqVJz/6ccO/SCZEwP3f3lD+PBffz5T1hgUwHwOftuNXfEMTyv3TDjZiRBE1iI5S0TZ4Y4xOsP9Wwnn7mHRfLvFYViPCt5sUuRx5IjEOuzHmeidbdcn98/pn+d1dRhPfxme7Cr7m/KFqmavG2rWXfWVDPzVXprGfSK9MPyJ0YK49rK+OOGUPt0flpu2PxVYmx0FFWTRULZByIee2yTk1wszYXJ8z3Bhz+GuviEnsUSseAAJnH54WGqHUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60l/P/bwOWdg2MkoncNt9iPmES2WMDnbSSJxCzK/2sM=;
 b=SMckb2zqcc0cow0S3kpl1n2EdFrEyYiWragAY0TnhYYIpcsr7L79lUkIKFp6n7ykp8hoTza82lf49OGoUokgd/x/mmStjdsmXr3FY2efbvsXHEHwnvTuZiaQbJ11aRxtfk+d3fm7scLWs6Mi1/m2PW3IaH6gtPRr2GzBgmbm44I=
Received: from PS2PR06CA0007.apcprd06.prod.outlook.com (2603:1096:300:56::19)
 by TYZPR03MB5374.apcprd03.prod.outlook.com (2603:1096:400:8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 19:25:33 +0000
Received: from HK3PEPF0000021C.apcprd03.prod.outlook.com
 (2603:1096:300:56:cafe::af) by PS2PR06CA0007.outlook.office365.com
 (2603:1096:300:56::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Thu, 5 Oct 2023 19:25:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK3PEPF0000021C.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 19:25:33 +0000
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 6 Oct
 2023 03:25:32 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Fri, 6 Oct
 2023 03:25:32 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 6 Oct 2023 03:25:32 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 1CDC363A26; Thu,  5 Oct 2023 22:25:31 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <peter.chen@kernel.org>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <xu.yang_2@nxp.com>, <peng.fan@nxp.com>, <avifishman70@gmail.com>,
        <tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
        <yuenn@google.com>, <benjaminfair@google.com>,
        <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v5 0/3] usb: ChipIdea: add Nuvoton NPCM UDC support
Date:   Thu, 5 Oct 2023 22:25:26 +0300
Message-ID: <20231005192529.162785-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021C:EE_|TYZPR03MB5374:EE_
X-MS-Office365-Filtering-Correlation-Id: ca7edeb0-c9fa-4115-49ec-08dbc5d8d833
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?72afFOGRcCUM0pso/Wob/aCvkH6Bnu3BJcEBpUtgyaQJVeZqkGuoxdP/Y46E?=
 =?us-ascii?Q?4ZaZ13/0uUVVifVoxIt0SbWMuoA2w3eeO0RaqZTnoJcy1TjtMT8XQaB5FOjE?=
 =?us-ascii?Q?o82HainDxoxld8H2ZP1txS+w8fxq6VpfZGotDZUC0TO4EwgazjGgD+OwKWgi?=
 =?us-ascii?Q?fAJSgp+veX0SvYYpoDYbA+5SMeH2KFWDrQO36WX3RHrxEa/kj2P5NjiIZogb?=
 =?us-ascii?Q?VgOi4RhZYGDeyoCneov+idocwtP1e0c78hLh1WpNOm/RSYbbml04fLsJbruZ?=
 =?us-ascii?Q?HLpXSM/EMLhrbv0bXx+BCtOvrxlHCuu7xOeppejb05yL3mkMHWk65EvpOtue?=
 =?us-ascii?Q?Q6I9/eqYXCW3Wlruq5kb55gRBIEphQWwtXo6P5H3FS7cix6Ds4wviNJmOqfz?=
 =?us-ascii?Q?boGacvYsUS4UJeK6Vrk9vSZEA/mFttwR2znk/P2I/q4ogbc8zPHx3ZGazeQN?=
 =?us-ascii?Q?0DFV1HmUKpmLO1GDvrJ98UhrehuJPOfLL0etQcav4E/0XMH8bo4+b9OQ1HsO?=
 =?us-ascii?Q?cIw/Nzbo+iiE5FitLNuGinUjYxATshQKJ4reR86dxAo8z4g8LOv7G5drQYiJ?=
 =?us-ascii?Q?IkVG33bTTpgJE6zbEWRav28CrMe5PLMHbJkf2/gK/eYxB+9+u+EpacobXzGw?=
 =?us-ascii?Q?uEPHKL7BNWXoLO0G1kw4dM+eb2SLdV/AE07OxsVKvxPkpn+b78jR1E7OifUY?=
 =?us-ascii?Q?U4uNr4dcvoa77mBXkJsyU8VCMxINj0wIZdPO9REZoSd6nY2s+bGmIunz3tmz?=
 =?us-ascii?Q?5qaq0CSAC/bOC1GhZ261FUIIlND4baAMa8TkZZGtjvyDR9hu8Qr9ERIOBq15?=
 =?us-ascii?Q?ZAwpMjyvfzArkyOXp3tlXdI6pDTFaldl2G4ksIdVsGXa3V4jvRBEWzEuX3jx?=
 =?us-ascii?Q?3D4Triye031YFfI0QeX7x/M4GvOBBomEmQRIUlbh4zAo22+aJzZN63Dvz07F?=
 =?us-ascii?Q?bOBnChBHt2VgLC8akwhbjg=3D=3D?=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(5400799018)(82310400011)(451199024)(64100799003)(48200799006)(61400799006)(186009)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(6666004)(478600001)(76482006)(966005)(34020700004)(47076005)(36860700001)(55446002)(81166007)(83170400001)(356005)(82740400003)(921005)(2906002)(7416002)(110136005)(336012)(83380400001)(6266002)(73392003)(82202003)(26005)(2616005)(1076003)(42882007)(316002)(36756003)(54906003)(42186006)(70206006)(5660300002)(70586007)(41300700001)(8676002)(4326008)(8936002)(45356006)(35450700002)(84790400001)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 19:25:33.3592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7edeb0-c9fa-4115-49ec-08dbc5d8d833
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021C.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5374
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
 - Krzysztof Kozlowski : https://www.spinics.net/lists/devicetree/msg638451.html

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

 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml |   7 ++
 drivers/usb/chipidea/Kconfig                  |   4 +
 drivers/usb/chipidea/Makefile                 |   1 +
 drivers/usb/chipidea/ci_hdrc_npcm.c           | 114 ++++++++++++++++++
 drivers/usb/chipidea/otg.c                    |   5 +-
 include/linux/usb/chipidea.h                  |   1 +
 6 files changed, 131 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/chipidea/ci_hdrc_npcm.c

-- 
2.33.0

