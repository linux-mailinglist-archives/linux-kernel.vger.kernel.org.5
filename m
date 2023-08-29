Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC1278CCEB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238955AbjH2T27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjH2T2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:28:35 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F78EA;
        Tue, 29 Aug 2023 12:28:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VId7LzybT3JA9fmc4naS4PfZaWk0DR7D4QqcRvQR8nz738fDUHS0jctZ4hir7Z9IE1oBvxa+/jhcxKryaVKuJcbiu9Ol/+K8aNT1SjuGL9klNmGsSZtsacyWNNXNnp9FjnT3g5Nexu1W74Wy7cBA5WCQ+JM9LhuEnWnNW+oo/+z3imkq/lZI7491bhyTyOQkHrgT6UIVvWPzBcQ6Te4A0kv+w8z3MCdt98dO4sLZvMgZFFktr8a66J1LeQRX+BSs4DHqhEWCe0aYoFsyypCJZAeSN/Lkh7RZX7loDsUl1QgNWjiBFXNdiU0U//qcMCAK7fATparn3SPYv9qyp/NoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWGUddQQOCoEdFIvbfmaTW1zbVVFkxfL0wof+gLd+4g=;
 b=asZ1QoZFnQTriuQlT82UeeAVGW4w3bLXDzvYH9WcHRIPcHd3W3TMcPvNrcz1MB2TFt9kjdYyQpA0i/24X9AsMLCnuyj8MIuBbZLGGXWv93rCS1mUwRw48h8mLsDh7KPo5vwxk882thEsUbirQbLa3+BwlJ2p/VlGHuLL8ozBtGyPmBHVmhZuCzQGCoSpwkiLj/zH+/lMZ2EN1Kh1/NrBiGY1H0i+WTZFZYbBSVn+ou9aJZc2iqHy8VLxEgb77bhHAIr34OXAOUILMSIIQux47LYHNZWGuwd/aT18d6b+oRchOmwxhlgyRStaO5krQiczBnN370FjqAg92d+EkUSRrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWGUddQQOCoEdFIvbfmaTW1zbVVFkxfL0wof+gLd+4g=;
 b=VCdvdNgFgh3KDkM5/sXZ6udggVPXCpqznd6CtoHjcjTPThxZV67xrQecTzH2Frvw6cPNF/8pdV40/kMCjNGN45H2jKgEspn1/cyZUePPs41GLUUHG8k06wEg+0CgpxPcMpUK+Zn7G6xt0S2UHfX0/qppSIIrT/12rXtoTYp3PcI=
Received: from CY5PR19CA0040.namprd19.prod.outlook.com (2603:10b6:930:1a::31)
 by SJ0PR12MB6757.namprd12.prod.outlook.com (2603:10b6:a03:449::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 19:28:30 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:1a:cafe::ac) by CY5PR19CA0040.outlook.office365.com
 (2603:10b6:930:1a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36 via Frontend
 Transport; Tue, 29 Aug 2023 19:28:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Tue, 29 Aug 2023 19:28:30 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 14:28:29 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <hdegoede@redhat.com>, <bhelgaas@google.com>, <rafael@kernel.org>,
        <Shyam-sundar.S-k@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v16 0/3] Avoid PCIe D3 for AMD PCIe root ports
Date:   Tue, 29 Aug 2023 12:12:09 -0500
Message-ID: <20230829171212.156688-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|SJ0PR12MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f21ce1-3c4e-461d-af12-08dba8c6209d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmltj9pSh8Qx2sn8kP3XQ+PeS8IKj3n9yzeIXAw7PcYIeM0xR1FYQiTpLA6xrlPEQ2FfhPi5cZnoI7qX8KnIV7nH24Y93VI09YHyMvtCM5wzN0IYT5/g2/JqfxmmHfHUv8w/veD6GTVYB71Ldyslf5P/lHHfBzK2VYfNP+M/SPwxLisahbFfR2wV+ZzxWXjx5K15YRfxM4cXP/hYMdlv6/0zsf/EwBYpxb7DhMAgxYPRnfiSwp4gfHsj+Tr2i5kqVK33KSKLLUC4bXqruMztsL16npaptdb3ANx43sGNiALm10zxE7TEsffwnushlEwq5fJ5Is7lPGdMCmgAJDzqws/Bp+BoKKbZdUK2H7AHLI03aVt8SuimVr6EtMbuN/vTZ1Yrmb8WLc1sSUOoSUNizA2Ki3z1ZfDhUqFitDqVeg5UgC4P4FDGq7S6HlVQG+VznZ8Wk7oDf4u0PC6IoprCFhYLHeFSxxWbA4NClIBmE8v8F9YX52kn+ZvoNcHxNxxBWcuThb/7aNwV9pU2tSNT5e01PUQkCsvi2sMWDi/mwhBOlE4uyeeAqxCcXp5CRtSSjsGpdKzxT1I0eX4B8SSpVRXp9e5CDFKEkBxnEQnPBruVIRDgh+jOylAPwOsZD1QaHby/cS40gHvXgX4GyYAa8EIqz9fJsEB1cOs+umyfcArfa2MutP03GPLfScwfNucuO+IgtHiOuOldMwC6LEDIKsUqtYvdbyUlfesGD7LKkKG1jB4T8LLecFTac8P3uxqKX4OEsSpH9+cbbp77srR7TA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(82310400011)(451199024)(186009)(1800799009)(36840700001)(46966006)(40470700004)(83380400001)(1076003)(5660300002)(426003)(44832011)(336012)(2616005)(6666004)(4326008)(26005)(8676002)(47076005)(8936002)(36860700001)(16526019)(40460700003)(7696005)(6636002)(316002)(54906003)(41300700001)(356005)(4744005)(40480700001)(82740400003)(81166007)(2906002)(110136005)(86362001)(70206006)(478600001)(70586007)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 19:28:30.6159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f21ce1-3c4e-461d-af12-08dba8c6209d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6757
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D3 on PCIe root ports isn't used on Windows systems in Modern Standby.
This series adjusts the amd-pmc driver to choose the same strategy
for Rembrandt and Phoenix platforms in Linux with s2idle.

LPS0 constraints are the basis for it; which if they are added for
Windows would also apply for Linux as well.

This version doesn't incorporate a callback, as it's pending feedback
from Bjorn if that approach is amenable.

NOTE:
This series relies upon changes that are both in linux-pm.git and
platform-x86.git. So it won't be able to apply to either maintainer's
tree until later.

Mario Limonciello (3):
  ACPI: x86: s2idle: Export symbol for fetching constraints for module
    use
  platform/x86/amd: pmc: Adjust workarounds to be part of a switch/case
  platform/x86/amd: pmc: Don't let PCIe root ports go into D3

 drivers/acpi/x86/s2idle.c          |  1 +
 drivers/platform/x86/amd/pmc/pmc.c | 56 ++++++++++++++++++++++++++----
 2 files changed, 50 insertions(+), 7 deletions(-)

-- 
2.34.1

