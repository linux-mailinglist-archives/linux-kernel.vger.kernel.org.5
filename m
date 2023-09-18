Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4416F7A49EB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241486AbjIRMmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241311AbjIRMlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:41:32 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6B594;
        Mon, 18 Sep 2023 05:41:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3Jjwrv9yUtrP7qMGz/ILNm1ugpcyAA2Q6kEmN3EIDqyNagSrcvt28EDQgVHodwuVmtRsqOR7LExxmgVKnfKI5iLI2HzTL6WsWz5yc2HJOmlN1M9SoohiEE3/06gxoplAhTfKrnZk7gED8CK0GQ9aC+cc++EAPMk1Mk2QXKGK+J7DlOIBIYGV7xUW4zhS42PG/uoQL6mTY9aqgO7+wXpBt2wStqL5LcEjprEOc2rn5GoELYWEA29iu88thBtqfkczaZvdsuLcXbuhPcwcCGEsizwOVkR6hEHgTXnGMd43Hh6ZzOgRpH+ptDYEY/ODXbKevk6W6K+fjy5kn0nqJLQdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBfT+ToUL17e0KxDZvULQ8kIbx/+ZoQjyRwRc10mNvY=;
 b=QaGKNI7z/y/kbMDL60hW/06qgdHW69FHNT9GAc+ab3+Dw3TC55ZxUZQyKsF8uSAclJubMvnCz7X9jQZgEAziUN75hBf9kKU4JQZ6tsvHjRQSSZUO5ZTjPj3Uc7QLTe1mcc9n9q0v3hucmcCVw2yD0ZCmCp2j4AZtQhOqEGqtdu4ul+78bmsRhBJJqTpf8tcLPX70H7Zsx/c4O5nMBYpllKSE+UMFJWKANuR8Lqe1RWJ8VIqxv5N/qOmsRugBWil6NSlu+HQj5mNzpDgD3/0isrmEGbm3h0IJz79nSa64MicPyI+7D7zmRz0D4nUkJhtjgUPOEFckIGvP6eRUExNvew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBfT+ToUL17e0KxDZvULQ8kIbx/+ZoQjyRwRc10mNvY=;
 b=zPxU9oOHuh/Xa3TBEi70Sn5niXvNuz4LXQc3G264IG+c3Q/ebpgmmsjV9+BaYGc4Au4kP2KuK1Fo01FW3veh/TLbOKrNt41IEWmQnIzhYBQcsNfGhHlfjjLqpSURbEoEDlT2MZjKYtRNoaoX6qWdbJixHTMSkVUfzL/mAu8iC7Y=
Received: from CY5P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::17) by
 DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.26; Mon, 18 Sep 2023 12:41:20 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:b:cafe::6d) by CY5P221CA0005.outlook.office365.com
 (2603:10b6:930:b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 12:41:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Mon, 18 Sep 2023 12:41:20 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 07:41:19 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        "Piyush Mehta" <piyush.mehta@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Sharath Kumar Dasari" <sharath.kumar.dasari@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/6] arm64: xilinx: Tune DTSes to remove warnings from make W=1 dtbs
Date:   Mon, 18 Sep 2023 14:41:11 +0200
Message-ID: <cover.1695040866.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1154; i=michal.simek@amd.com; h=from:subject:message-id; bh=h2D9CkIrNfmDOXCrtty72iX7GOJUFhmJk7wBy+zOzsI=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlQO1/QZ2Q6HE370OP67xG8/g2Vr4/QJMyt/rlE4r6vot LL+4aKOjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCR1lsM8zNEtyVv2Xlad1lf 6KOvUseFnbn/BzLMUzn4atbhS3curcmemHLLmv/VCbmNywA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|DS7PR12MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc20555-7765-4673-cb78-08dbb8448f46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5EM35m7KVlveOSGPoj2cW80CxU9G79V8SqRfaL0QRRr726QdwxydGdnORMVKrbVBpk4jKKqV2eqiHLCg1Jqticp+6hzVcAQPPUcYZ8coxF1OSNtRXLt/X27YwB2k8ZEvMFsoGamitxFfkxe7jcLmMJCVaL+4lICuuegIrNRweX/jSOOQtyesdiTly7dUOvhXGAD4XMuBieZmet6/KLl/Y7EEdkE4So1Ec7iLl4yHzvpE3UWPoAuin7jGV4yVZ2zXLUA9RZ4xR9WHqesWUbAnm08JVxzSy58Kf7gRsG6A1/mwBNacZVlsBXmC49EFWADEYK0VJjZb3DlKOGacAgmEBEaAPcLnUesSv+/+hQrIybW1dn07dQqaIN0SkZGLMY0W0dM5nquAcZxj6XpyHS9QzgG2OUq9Lh9JQNoLvLCR2GAGsiEz1ZX6+NLrJE3342wcgitX6ffNLKtbZ/eo561h4uE6ZIN5J1b0PxJKTBCkxcFFHd59LRxSpTK/N8aHVtFwbpVavf1620rKiuPIQzPeBhWBMI9pVCBL5S33kRvcmnyeMRUs0Lztk3peawTcCnfMlYpGA8H0gl+l2MDWcfUCjscceYVsypHmcCqG8oDjxNy7riBysSnHXwChs/NAa89XPvlZHW1dFO9pQuMEsltVMMrdWH0LwcL94OxfvV2vzlD0gL5eZVDPlZgyTzOGM1zlxe1jN7GOIXNfaAtnvFkilauhVWW9Xd6IidxuC/AOjWcJEUgWMdc/m0iBxEub35qJLGoWjXG96vpLtgKKPdtr+WaINr5Hzp75aylndPp2F+c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(82310400011)(1800799009)(186009)(451199024)(46966006)(36840700001)(40470700004)(356005)(81166007)(26005)(16526019)(82740400003)(2616005)(8936002)(8676002)(4326008)(40460700003)(7416002)(83380400001)(36860700001)(2906002)(36756003)(47076005)(426003)(336012)(40480700001)(5660300002)(44832011)(86362001)(478600001)(6666004)(316002)(54906003)(70206006)(70586007)(110136005)(41300700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 12:41:20.3188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc20555-7765-4673-cb78-08dbb8448f46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6288
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

make W=1 dtbs is reporting couple of issues which this series is going to
address. There is also one more changes related to removing additional
compatible string which is reported by dtbs_check.

Thanks,
Michal


Michal Simek (6):
  arm64: xilinx: Do not use '_' in DT node names
  arm64: xilinx: Use lower case for partition address
  arm64: xilinx: Remove mt25qu512a compatible string from SOM
  arm64: xilinx: Put ethernet phys to mdio node
  arm64: xilinx: Remove address/size-cells from flash node
  arm64: xilinx: Remove address/size-cells from gem nodes

 .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    |  8 +++---
 .../dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |  8 ++++--
 .../dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    | 16 +++++++-----
 .../dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    |  8 ++++--
 .../dts/xilinx/zynqmp-zc1751-xm018-dc4.dts    | 26 +++++++++++--------
 .../dts/xilinx/zynqmp-zc1751-xm019-dc5.dts    |  8 ++++--
 .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    |  4 +--
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 14 +++-------
 8 files changed, 51 insertions(+), 41 deletions(-)

-- 
2.36.1

