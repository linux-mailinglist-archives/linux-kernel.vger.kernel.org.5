Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEDF7FEC6A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbjK3J70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjK3J7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:59:24 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECB0B2;
        Thu, 30 Nov 2023 01:59:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdPx9E61v+BeCvs6YHuzb1KlUbPd+LOWpTIducWwSmNq+eGXjqXAB4uzBME3NPJ3MYBGihlzKcBA1EqfvmPcEvjpxjjIC8ji6bUEa2a1IaOInhKBpwbIMcPb6rIwcVlApG09pVxAGVWNlT4Cts963o6O0R2JDYQYtCFOfNAddBaic3Iq5GeG3M/6S6Db7Iyzle2LLb2qMuwl3T6x3blI3DNsCytSF1VVJQiJ+ovPo9ZHWMDsasc32eGdaI2OgOblh4RjBvXPF6OHVJvArDKjCaPxD74jopJ522BR3yPJktEb8peUL7+6loQ+qC1u/XhG20jUEIIwirYhPBFhdJy38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyf2/aWqtn7HzkL86Yt926FSHo70jAzbmhP8oGq0xiw=;
 b=Cqluu+X74MXmtC1vNTEp4qmZb41GNOOWIJknkmtJsHmYUrokvIpzvcjA56slIQgZGp5JA/5UwsGhYr5BzxS5cVjx/V9q/28ZbuX+y6tnXc43cUPhx+YXCj+iEVB2/F6DodRS2oBqQHmjs8ZAj+faek931hwcIOWRiUkZgY2g2lWzDRoulH7NY+W977RsmkbjbQ6elE93onYGqOzG1WXz1EE0L06AH6ptkQo0st05IuU1ccUJhY2cH7zE2GNIWHsJtllA9t21Gg/aF6KFgx4EACKIzH1fFchUnE2SdNFHHNmC1+KqbokEKXTmeyLuUVpvs1xp2hNSaB+UKUc3WW0MKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyf2/aWqtn7HzkL86Yt926FSHo70jAzbmhP8oGq0xiw=;
 b=XDM87xsD4rgVfNQ3CLhv2bgTcDaXQPU6A/EzvzK4d59YiCrwcPUmhX7cKcB29C7SscWWPwiG+9iGDtphTpjxiM0bK6ayUVg4brpv792YlrJzh8JbH541GVT3AekNH6t7ZxjRDX+UUJjTss0AdLPikbdWy48EPUMnvOMyvTZwX9w=
Received: from CY5PR15CA0126.namprd15.prod.outlook.com (2603:10b6:930:68::16)
 by CH3PR12MB8711.namprd12.prod.outlook.com (2603:10b6:610:176::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 09:59:28 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:68:cafe::77) by CY5PR15CA0126.outlook.office365.com
 (2603:10b6:930:68::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Thu, 30 Nov 2023 09:59:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 09:59:28 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 03:59:26 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Andrew Davis <afd@ti.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Harini Katakam <harini.katakam@amd.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/2] arm64: zynqmp: Align fixed-clock nodes for kv260
Date:   Thu, 30 Nov 2023 10:59:14 +0100
Message-ID: <cover.1701338352.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=485; i=michal.simek@amd.com; h=from:subject:message-id; bh=rqE7fYAVvJml5bUiJ8BLqmxJi3ud3RhmDF6Hq2i7v4E=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtSMmE/BO5fs3+MyN6Niw4172apKi04+fNB2PeKn3q3iS /tOrZqg1RHLwiDIxCArpsgibXPlzN7KGVOELx6Wg5nDygQyhIGLUwAmcrySYQ7H7dWlU9/snNBg vndx0rxOyY3fd05jmGe2/d8P5vPsBZo3N3wtlRO+9DznuA0A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|CH3PR12MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: ee0a010d-8276-4340-9d3e-08dbf18b0a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x1laghmarIGKTahSbbQKOFuy9TcFqYn2fQeKtoolRBhRWFSLRXiCCU8J2FU6VDVXCohKdJ7kj5pkETlfeR+T11pIiJy1MRubyIZgt+CmKSt2UUeP8zrxpjQE9FkW5PUTur6mk0HaLmVASIFlpUoKqADZm7cvhtvSkrgujGtEqezR7KLpa6Y7QK0Q3VMg3vqs+y3lWipPz5Ic7bPdJ2Y3EymNw2GujTlUV9SUCbXm1674ghJmR+lsPStpdvXO/hBeW99BSVWAp4fr5CKY6pb4oj0Lp32khCgbtwtCJYv/ojeFLui1T3qjYnKWmp6LAZKIjii15LmXddWSpmU5E7eRVS9UoIKKgp9XOO2jeqMvbb46xvJHDX9HvFSzRewj1CEErMeAL2W4KZPCGbVKbq6b7mgszptVwSr1SFO9VMmyO6cE23FqrOilpQVObzR5Mw1cjA9gef8qSoTXbaFG/3vgUrDQEkNWUtEQS28F6gSOuHS69PB0E7q9+tPFqKqAxz9raBL/aQPwXeT3Sq+VmlDlLnF/lsfLuQHjUrTJ+Txgp/V8gQ4JXwuC1vBZ2BzOG5bMQq+jvS6sDvUnTg8dBXjMcuNG/LwdAKr1pc0pzd4amoPNNpfbImsB8QyLCmOnfaDbcA4ZmugXWhHVhzV6CC/BfnlqwbaRVU+R36OwyO/rG5yEWFKLTkQxnS8J2nuTPhGlrR0pbxxEnc2WFHYKdzmRSoOzbNS7Hy6zi1VZulHlxaTtFOlj2Y2nqTtPGg2liYFi96sKcd5h3ZoYYAoEzG8B6aYAoOrzhbHCs962OhmX7hpspF1ACIQXbastrWpiRzhz1UGNFA7m0n8/XdlXifvmDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(26005)(336012)(83380400001)(426003)(6666004)(2616005)(36860700001)(47076005)(44832011)(5660300002)(4326008)(8676002)(8936002)(41300700001)(4744005)(7416002)(478600001)(2906002)(316002)(110136005)(16526019)(54906003)(70206006)(70586007)(202311291699003)(86362001)(36756003)(81166007)(82740400003)(356005)(40480700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 09:59:28.2445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0a010d-8276-4340-9d3e-08dbf18b0a95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8711
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

these two patches are moving clock nodes out of bus because they don't have
reg property and also align node names.

Thanks,
Michal


Michal Simek (2):
  arm64: zynqmp: Move fixed clock to / for kv260
  arm64: zynqmp: Fix clock node name in kv260 cards

 .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 40 +++++++++---------
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 42 +++++++++----------
 2 files changed, 41 insertions(+), 41 deletions(-)

-- 
2.36.1

