Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7149E7A7B59
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbjITLvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbjITLvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:51:15 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1489130;
        Wed, 20 Sep 2023 04:51:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a++t16KJjtbrUpX8f4ASKkcM54okvoVeNTWqSbnpXEp6wvuc4Ov61LBIEBeZ2/Cm0b6ReypPe+sqpaE+oPahB21x7w/EIsJGVbEfuOYy9iszFZstslZrhxKBYiqZYOiAGv3eGZHzVii0Q0sD9SsWUijFqY+NxpfhhSxlmpXGVahdsCVODzy8K/n+j3KRTA05OcGeOIuC0mUM2GedeiveR+9ZTmTima1hpg80ahPk3ah+MK6yKg5XKbRVVN6FIhM3DmJ6Wz9EE296CxiaCsSzHqXLWQTentgivMZVgY0v3jlt2egyreis2XG1kQejppXYflaeRRq+tBdOYltERH5t6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzL5CoGtdQYgFiut1AY2LxEFmUTxwXDDJotBPFMB5Yk=;
 b=l6Qwl+XUAXd3q0vtnqG30vUELwc9I8cOBFJsIa9QjVkuAEbGRah3ECMmgQ7/gKq7irfnBAkPn6aCrwLW9E1s9NdjOPU8PokNNvjhrYztdK9XAkzlez42EHK+YRy6tnEI5j+0elxNx6Hs+Ij+NPffS5kuI/vKqsYv/KsP3H3oF1b3LvLz0FAk/+i3KpFMHDO8STu2IjWYKO1WpqAVQ6nbJ7WsEc2rzTXsSDuj9Mk2U0Ltv8OYM/T9owMM8uZ8K7flwthYCJq4S9uatGjdapl92oT4YlrlRhURZq/JrBDAMRsy0n9OIT1ZYX3VaWqXLaTIi6mTR5Q3x+me34vOjVSoDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzL5CoGtdQYgFiut1AY2LxEFmUTxwXDDJotBPFMB5Yk=;
 b=YD2mwS5ls+4uOAv8n7A6+ChaBcOg3KaKhCKu+OYAuIW+yeeitUDIb2XTQNeFa608bZiycM6qIwyTKno5X7o64wq6a8WsbEJNGwnL3re8EWuEp0uox00pF3n5g6I90iaTU91T/UALI2f9w4XOIGiZNJuwAqwNYjO2UekGQeYEfPU=
Received: from DM6PR03CA0069.namprd03.prod.outlook.com (2603:10b6:5:100::46)
 by CY5PR12MB6299.namprd12.prod.outlook.com (2603:10b6:930:20::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 20 Sep
 2023 11:51:05 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:5:100:cafe::5) by DM6PR03CA0069.outlook.office365.com
 (2603:10b6:5:100::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Wed, 20 Sep 2023 11:51:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 11:51:04 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 06:51:04 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 04:50:56 -0700
Received: from xhdharinik40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 20 Sep 2023 06:50:53 -0500
From:   Harini Katakam <harini.katakam@amd.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
        <pabeni@redhat.com>, <esben@geanix.com>, <jsc@umbraculum.org>,
        <christophe.jaillet@wanadoo.fr>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <harinikatakamlinux@gmail.com>,
        <michal.simek@amd.com>, <harini.katakam@amd.com>,
        <radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next] MAINTAINERS: Add an obsolete entry for LL TEMAC driver
Date:   Wed, 20 Sep 2023 17:20:47 +0530
Message-ID: <20230920115047.31345-1-harini.katakam@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|CY5PR12MB6299:EE_
X-MS-Office365-Filtering-Correlation-Id: 334b2dd9-d815-48c1-080d-08dbb9cfde9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tuITCXMIAJUeIfH5zBccvaGsnmao63ESyvXkEJGFlVgwHGdsVc2aIyLVCVLsuEHvu9eg0PikcofyrQ+dq/LH53D3SGtRyTqaz41JBuN79SuGJEYvotY2+lsE9lT8qhmbUPlhqj6FH6gXMQTeeCXFVL28WnPDcZVAAN/mv/uN8By2iy/iOiEyh1f+cVd+CKTsYgaEPNwhIzKvmT2SAG1hnZXjsIeVfLCnX6TJUNLH4hmdGwkZPT/8ozt5BGgQUGlZh98asdOSOnzxTQJSyM8FqVZMkr9U15IhQgeVTxsgk6ypn6deGL4i/Y4Bce8EuY7L+RImGSXOl4O16ZqnJ5754A3t3GExv3jXh1UCJPsrvuDa4o/bG3QFHkh9CP7c6DGn/gK3PbkHHSii+1y7zakOt9/gNhnioXPy+0DyP3C2tCv16DfdOg+5LWW1eBqyWWKIlGgMwJ0o4Tf8q+4VLelioMtzhBZBD4cvOTu+8JPL4Ysw4PIKg+5vytmw2N4hDgPdM6p362GJbykHZ4LXCY2NAz5vCGM6EF2N9TYvGXmsUTkg+y13jNzHaorDRB37P9967TYrWUhuH69so8g9Ra4zqLW2G2SD71IPwm7F/3MNwss9jMJtymnYNKqNXcM3luxIONJEErAAADVb/yIvmo73g8PyI11/+6K6R4vGtYCkXQ9jhCd3VhHb1btur/426wBEtmLqrQ5ISORrfP/mV4ZxDf9mFCidPMj2XKQZo6Z/obyFJCR/S4uos8XpL2rPkVIypxljSYDpFTMKRB9mhR9p4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(1800799009)(451199024)(186009)(82310400011)(40470700004)(46966006)(36840700001)(8936002)(44832011)(8676002)(478600001)(110136005)(70206006)(54906003)(70586007)(6666004)(316002)(40460700003)(5660300002)(36860700001)(36756003)(82740400003)(86362001)(40480700001)(4326008)(47076005)(4744005)(7416002)(2906002)(426003)(336012)(41300700001)(1076003)(2616005)(26005)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 11:51:04.6099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 334b2dd9-d815-48c1-080d-08dbb9cfde9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6299
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LL TEMAC IP is no longer supported. Hence add an entry marking the
driver as obsolete.

Signed-off-by: Harini Katakam <harini.katakam@amd.com>
---
This is an old driver with no bindings doc and hence the maintainers
entry does not contain a link to documentation.
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3dde038545d8..820a7817f02f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23696,6 +23696,11 @@ F:	Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml
 F:	drivers/gpio/gpio-xilinx.c
 F:	drivers/gpio/gpio-zynq.c
 
+XILINX LL TEMAC ETHERNET DRIVER
+L:	netdev@vger.kernel.org
+S:	Obsolete
+F:	drivers/net/ethernet/xilinx/ll_temac*
+
 XILINX PWM DRIVER
 M:	Sean Anderson <sean.anderson@seco.com>
 S:	Maintained
-- 
2.17.1

