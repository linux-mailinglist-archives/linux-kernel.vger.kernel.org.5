Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8717CA65B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjJPLNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjJPLNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:13:34 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACBA83
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+h6mDc3brEP0FDG++jaii4s7bKIluMdegjqd1TsVKSts2x3YhzZr4+bki1sgOMrByriK/oADjJF8v9UQsTnpxeVCjKmWpaQkBOZUkOLeP543KvAmQocW99eAYb+qrTxgJn26sf/8HhYSKw1hrEBtHhH8CtPRtLdgPjPBHQ+d4bItYaiCuVjpIExFr79WSJ7E8mvsYtqzuY0FayP84jaK4P7aHTqGq3h3oppkaSe5Aawt7jv+aGgDxKCnzXR1CNC6D3KDwcd0iV+zBYi8/vC6SJBkqrchJzmjdODLrpc4IXZ9L1DBc6QQwt87+NqzkaWYMFlweSpqi15uJo9rZLXcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rMdlbwjokAf3WEhxDNDaoSfHwU45yR3KoTdabwKApE=;
 b=hv972Fi7bgtmGtTJKBualGagDJEdhR5YEoD7vQ0ua/L1t0IyOhcwAyY9TG9Sk6bELP16oiIu+UPVJ0MRX2oPQSCFgxHrln5NqGvwOFGow5cG3r+1eogwWmZf/3f8UAaoPiCUsc598DKKujdLDH21xIU0kW2EhRjwAago0vSM7OLdrMtM3IENA7DKNWlynBXvMol5ijESMq4qZ0TJhe7ZmFw0WBTcH65Zjoq/ankpk1TukullPYvfu6UqDB92/fWqI7FRrRG75ugcPqAhWRDf6fYipmn2dhovNQl3m23Dfdl4QY6n/XQR+sjiOCJiDdzG8rYdpZ9nhAjysj9dAXEPtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rMdlbwjokAf3WEhxDNDaoSfHwU45yR3KoTdabwKApE=;
 b=bCzDsu7AyP6Itllxombokx0xZbmbaVLM3rnHjz61G49uC50/YOVis8fUswIAORtn749oQgiZvrjUNXvAPrrK+/rDTpZVJkN/7GU40w6AjAJ2WkVw4Fr2wWW7JuZC/1adj2kg544XEbPJKRL4CvQBR7TxtXB4z8AZASKNJaofFtg=
Received: from MW4PR04CA0355.namprd04.prod.outlook.com (2603:10b6:303:8a::30)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 11:13:29 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:8a:cafe::38) by MW4PR04CA0355.outlook.office365.com
 (2603:10b6:303:8a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Mon, 16 Oct 2023 11:13:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.6 via Frontend Transport; Mon, 16 Oct 2023 11:13:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 06:13:28 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 16 Oct 2023 06:13:27 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <tanmay.shah@amd.com>,
        <gregkh@linuxfoundation.org>, <mathieu.poirier@linaro.org>,
        <ben.levinsky@amd.com>, <nava.kishore.manne@amd.com>,
        <marex@denx.de>, <robh@kernel.org>, <arnd@arndb.de>,
        <ruanjinjie@huawei.com>, <sai.krishna.potthuri@amd.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH v3 0/5] update for versal net platform
Date:   Mon, 16 Oct 2023 04:12:56 -0700
Message-ID: <20231016111301.13369-1-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|DM6PR12MB4356:EE_
X-MS-Office365-Filtering-Correlation-Id: 307c4e96-34a6-4fee-bb06-08dbce38ed25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vAP0qn1UpLmY/gfnfAjLScfwBEP93MU+bcpKdtw5/feakMYnqYrMOI+1Cvx+FZkFZK7nquy9k92aCD9Eo+Iacq+ITYEQx4VfCAPtxd0ARGgI6JCgguYvmDW3jNVx3Rer1QKjqaYzOoPERkkd0X1SFY4zk60EWVQ0ivo+dpt7r8y7qgXB3Ri/CxSiIBL2aGN00G1bh6FUT98rH4cDd6GmuzZSIEHbDBt84qFAEFNIV98ZeibG9FI6W6mCu5zbhJOmRhblViyvF6Be77c5d5EK03QIBbyhrvVYEI+4zQejRddbvM4B9dKaGlEhytazpnnizryzkRcg5egPDmIe0G4VAwYFxoqYAcJna4/AAb5RywJ5FPcwbaz2S1Ip77J8fm0OvpHPPiKyQQQaoYLg0gOpjlmJm+WU3nLQaJ7jNXSmRg4QJqEx1BfQ1Kw8mmS+kt78hy8DXlSbx19QH2+fh2Z7Xo5ruaMOwvW72uqOVvfsfi5fMhNUoDmRefT36dpHivJ/wpMyONvdY9JGzXWuTCV2JdAfQ/W3qAO4++wpuVrO7EkEcfy8ihizn5/PfNvhl2nsNYTF7bjhGERo4ILMm5BigNoya8SjJ264JvQ4865hCLgD+c0vfYn4+5eyAlYf+dJB1vvCewTKmowRqAnad1ByvALZMO+B02MFnRtsgoE7O5sorNxJLqjyyBLDXLhuWvydRkmAO+ceEdfQDEMyAO1ih2AL0GamY2hQdilUD6iSab8wclfqe94ddb/ilz8NtLKE3F7nwkkdy/Y37lTOrnOTrczaOkCumacANOUViZplUBTKyBmfwaLEoiQCNOiFEqgd
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(82310400011)(1800799009)(186009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(966005)(478600001)(6636002)(54906003)(70206006)(70586007)(110136005)(316002)(2616005)(1076003)(426003)(336012)(26005)(6666004)(36756003)(2906002)(4326008)(8676002)(8936002)(5660300002)(15650500001)(44832011)(41300700001)(86362001)(81166007)(921005)(356005)(82740400003)(36860700001)(47076005)(83380400001)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 11:13:29.3814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 307c4e96-34a6-4fee-bb06-08dbce38ed25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update firmware and SoC drivers to support for Versal NET platform.
Versal Net is a new AMD/Xilinx SoC.

V1: https://lore.kernel.org/linux-arm-kernel/20230929105558.11893-1-jay.buddhabhatti@amd.com/
V2: https://lore.kernel.org/linux-arm-kernel/20231004094116.27128-1-jay.buddhabhatti@amd.com/
Changes in V3:
- Addressed formatting related comments
- Removed below patch to update maintainer of event management driver from v2 patch series
  https://lore.kernel.org/linux-arm-kernel/20231004094116.27128-7-jay.buddhabhatti@amd.com/

Changes in V2:
- Removed below patch from V1 patch series
  https://lore.kernel.org/linux-arm-kernel/20230929105558.11893-4-jay.buddhabhatti@amd.com/
- Corrected maintainer name format in patch #6 as per tool requirement

Jay Buddhabhatti (5):
  firmware: xilinx: Update firmware call interface to support additional
    arg
  firmware: xilinx: Expand feature check to support all PLM modules
  firmware: xilinx: Register event manager driver
  drivers: soc: xilinx: Fix error message on SGI registration failure
  firmware: zynqmp: Add support to handle IPI CRC failure

 drivers/firmware/xilinx/zynqmp.c        | 268 ++++++++++--------------
 drivers/soc/xilinx/xlnx_event_manager.c |   8 +-
 drivers/soc/xilinx/zynqmp_power.c       |   2 +-
 include/linux/firmware/xlnx-zynqmp.h    |  17 +-
 4 files changed, 136 insertions(+), 159 deletions(-)

-- 
2.17.1

