Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1A175799F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjGRKwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjGRKw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:52:29 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2040.outbound.protection.outlook.com [40.107.249.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC0C94;
        Tue, 18 Jul 2023 03:52:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLbYAqhaFiW+M4nMDuIVaMGnQ/nBnvdhKjYzgOhbmYHFnpKrw/TJTz0chf3fTktD8HMa/up9JGUUHcSZmQTRbx2yEnY86qy0Psb0kEV9486Fu67wTAAQwjDSGX+39yQSreZIDUNpUto04WLAUdRPutAH5sJAAhSnDH3b+bf7TuJfokO76d7ert3ZLXXa9+swXzrc8/kvcJjUUaU8fU+kctljV+g805agDHBTW3EH/fgEkF8APuaFNJx3aM3gqLcjhYnBlbPfboPmvkULJ2NJv4C5X/9rp/zgO1ZY1Y2X8psH6Vgf0JiEkGFiu9gF26fJ4XEYBExC1euq6JF7w/z+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKyd+lnbu0O5uR6fuMHww+jkRKGvzNNenyEBsKCUcSo=;
 b=oTDvRncxjpWBKjyatBV0MXtL3KH9pq+q7iy6IVip65R42DFMWJVmUfiYgM2nC7FoSdPpdjZHlG4idyT2mQL2sqz+fBWGejkaVM1qXrY19XnzreddfWncATw1+xwEPvHzhEY9SbLv5/VKAoM25xG9mgP2DtWF+XUjjp1J/lIfJcVOQCoK+N1UjIqFy91NbFoifJFNjLs1UbfbT1BMwvcYybUSsNZ1wisa05AW6MLLU9F8Dh261Sp4Esf0YGYgn8xcBaFmITWSlCLf8PNk+AKp/9kpafr7PXtV64hz0mGLtZvhJMb3atT1lezBoQdizlubKEfgE13pd8rcjlCitxR2vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKyd+lnbu0O5uR6fuMHww+jkRKGvzNNenyEBsKCUcSo=;
 b=FMqQfzIHx2NF8/6LgYz4cp7cSr75jj6cpQujucASeM6CAO94qB0LZKrDCmZ48eSAx5jHKMfEj09pGyaL5BsjstHRckuYPowC1HmB7EWnaBP5Yv0aRBQ0R4iHDzIUULWZgjjoY81/eQTI6E52MoVsEnmGq7RMuTEAQWzTgXlozyzo0lG+WVWZ8QEoGyQKuOxJd7MD8N49RkXBy86P16pOWF4YsowUJOUapeEJ1ROhs43v1Dqsoae/sE65BobvW2Y9d0izPjfonBMR922Etnu/HVQGYh5nbeDHPIobwAYfCJ1XhuiQkcvvAKQxhOSq0d85agbEQRv4c/sTwJ1/euswkA==
Received: from FR0P281CA0037.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:48::19)
 by AS4PR10MB5647.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 10:52:25 +0000
Received: from VE1EUR01FT031.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:48:cafe::a5) by FR0P281CA0037.outlook.office365.com
 (2603:10a6:d10:48::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23 via Frontend
 Transport; Tue, 18 Jul 2023 10:52:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT031.mail.protection.outlook.com (10.152.2.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.23 via Frontend Transport; Tue, 18 Jul 2023 10:52:25 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 18 Jul 2023 12:52:24 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.68.216) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 18 Jul 2023 12:52:24 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Lee Jones <lee@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        "Wim Van Sebroeck" <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>
CC:     Pavel Machek <pavel@ucw.cz>, Mark Gross <markgross@kernel.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Tobias Schaffner <tobias.schaffner@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 2/3] leds: simatic-ipc-leds: default config switch to platform switch
Date:   Tue, 18 Jul 2023 12:52:12 +0200
Message-ID: <20230718105213.1275-3-henning.schild@siemens.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718105213.1275-1-henning.schild@siemens.com>
References: <20230718105213.1275-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.68.216]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT031:EE_|AS4PR10MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: a13f2e75-2ea4-460d-806e-08db877d1288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hawnKRpydw40J9A3Kp79L5B32oDT2fGHhkIQ0RSi1nBfzOVgk1eSwTxUNN3BzRnOUVX9EIznZ9C48TuBxq5t82D4CReQ2614lRTK5hBfRgz7EJz/SBDKP6dYPu5vVXvJjwgeXEdhsnW/YAu1T5YEMJoGE3HHj6DZvvMXqS9rwhutIx15rzYyJSIN5EuX3n6IsGYVRaQnKvohrJf369chzfZbV4yWn70Imn7tIHiY5b0wTfz04Ovvatl3IW7WdtZzVdgVRcjWAM0y9nNNO/X2cVNJpk/xLTMKokmVTtUiaA7EbpIsDUOoUZdjO2agWpeYFLYnDIzJWw+FfuUNWNp31XBtjkysxjLlF4t+1WQRiF52h2NO9vVHyzOrFFJi2LvAlgU1Iz5cWGHQWiUHW3ifRIirMY+nbt8JzbmnXPNs1WzGd/2SMm93YexGeTGBO/55yyU/8b37RweJPeV5y3K/4pIMVy78gkDEG5BxUVdztbGAKkm73tbj0UHCap1Twtx0UQUVscQakz9R87RSXZHXqsKg/GIB4yN+dU6T6WPoTKIB7uoTfTySM1v9oU7IEnULH5q/iT7r8dzUJKPtWN59z63Ow0r9xFfBL2CaBLX/86l4PKvT83/n3X2pKpHNGyaaKamGrQQi2CD+NZDkzMZaCsu9kbI6F2IJNaSqoJGDC1pT0ZgAlbDQK+UcENjYWQ2cg7mOTGbwN8SCHTUX+yOL4cK8c/LTaQaAo1xOsO7iCXpGH+4FjbotrYiGsaqCqiw8sVV3J/ucv0ZcBbFxMPU60ETz8joQbK0ig8OSXZgBeaw=
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(82960400001)(6666004)(478600001)(82740400003)(356005)(47076005)(16526019)(36860700001)(186003)(336012)(2616005)(956004)(26005)(1076003)(40460700003)(40480700001)(107886003)(8936002)(4744005)(41300700001)(8676002)(4326008)(2906002)(5660300002)(316002)(86362001)(36756003)(70206006)(54906003)(110136005)(7416002)(70586007)(81166007)(44832011)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 10:52:25.4105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a13f2e75-2ea4-460d-806e-08db877d1288
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT031.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5647
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a user did choose to enable Siemens Simatic platform support they
likely want the LED drivers to be enabled without having to flip more
config switches. So we make the LED drivers config switch default to
the platform driver switches value.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/leds/simple/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/simple/Kconfig b/drivers/leds/simple/Kconfig
index 44fa0f93cb3b..9666bf22d554 100644
--- a/drivers/leds/simple/Kconfig
+++ b/drivers/leds/simple/Kconfig
@@ -2,6 +2,7 @@
 config LEDS_SIEMENS_SIMATIC_IPC
 	tristate "LED driver for Siemens Simatic IPCs"
 	depends on SIEMENS_SIMATIC_IPC
+	default SIEMENS_SIMATIC_IPC
 	help
 	  This option enables support for the LEDs of several Industrial PCs
 	  from Siemens.
-- 
2.41.0

