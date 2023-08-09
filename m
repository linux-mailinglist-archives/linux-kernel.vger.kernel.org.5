Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AED67751B0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 05:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjHIDxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 23:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHIDxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 23:53:11 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D18E5E;
        Tue,  8 Aug 2023 20:52:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPi+kzQJdfZ8zTzZ0zhgG8mwoshMH4+0JYiBZQbjheBf59byMhHGiqVZOt44fhXPPmZ28W0r57AWe/FvOH7r/bP5Vlk8VAs8PX8prrtfmLt6hoPS9uRtBapT9NuLJXyZVS3sMLDYZ5WcXLSpf1lo/E0Lsq4ra/TfoIQGGqt+QM3pIKWFY/WOsJayY1rdKCI9MjSyfV5K87/vu4gTBgpWQkkpo8sTvXsmr83ny00rPMUqAECafK1zgj+J8ZaqUlwMY0aN/TGJZrAHklYNU8Svj5Z7swv34i+mDSbKKSFCH2MbMRVIKQgthcPV1rOsr8sQHr9S4DzuApsb7NrQGJxidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kt89GBAjQMxAUZp/UaCUDoyTJrSMSEYzLJywOInBXsQ=;
 b=K8Z/bPJboW6KNHCWcsfdPUrznyLeUbF0M/MaxJLlDzsaMUdXjYQ+fki7NH14z9e26uPCcppKH7n2c/oDfnxvdqbmtVJBjLi3cagWDzEvXNWZPz4ZIoi7g+PIPnLXLUiZhPZJontjuBTJcnoaPYX+mUqa/+iEmNJuTTycdnvEwqy+QPMXuP5ZILkl6h3F5sclhmE3nhjZWj3Cn4006P7raAD2CHx3ddZrZwGlGn1aLLCCe0wkQCYRDzpXKGIsYOgl+SImBB4hp8lDjRys762Kc3S9gnBMlK5hz0t3AITes+SIwO8fM1baTXHiO45zDWcV9xLN0ndnuAGV4VvMwgQL1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kt89GBAjQMxAUZp/UaCUDoyTJrSMSEYzLJywOInBXsQ=;
 b=POsoWkvuW/jZOf2fNQRTU6gsvDbhk/ITlEoXkM+RPBcuueFgyd4RFeN8nSg7nwbcXjNeB4eeDeDTjt5x7UE7vr9GazK0Ba/yze1K5fMr67DnpzS/9bJwmXXWud4m9bkJJIaVn4nhQf56tPsal1R4+jfVeuyD6hLNJlJplHGo5z0=
Received: from SN7PR04CA0039.namprd04.prod.outlook.com (2603:10b6:806:120::14)
 by MW4PR12MB7439.namprd12.prod.outlook.com (2603:10b6:303:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 03:52:51 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:120:cafe::e9) by SN7PR04CA0039.outlook.office365.com
 (2603:10b6:806:120::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Wed, 9 Aug 2023 03:52:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Wed, 9 Aug 2023 03:52:51 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 22:52:50 -0500
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <bp@alien8.de>, <x86@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mario.limonciello@amd.com>,
        <yazen.ghannam@amd.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH v2 0/3] Updates for AMD Family 1Ah-based Models
Date:   Tue, 8 Aug 2023 22:52:41 -0500
Message-ID: <20230809035244.2722455-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|MW4PR12MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: ad2091e0-36f2-4d92-5d72-08db988c1a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 67GW8sIiFOR7/G0ptZGVk5sn9eIDx4mGMT9uXU44pDvIhSRF1NkrC/cKD/lyMb1CaGGXe24r8GuxQKs8d/uaY/Jt6OuOSO3ymjwvgP/gDMFAFWK0h1zgdc1mz2ehru0nNzDwcZLkpZWOggjDxrUbD5ljFgB6UtOwsPiH4pkH4i7IXpJz9Iphca+8AzB2Ie81sJmOO6+oSr668aYhEdO53oPwxE2W+Rp/AZb+0HT+1pXPsW3wSuxdIYhlofrIGK7+vSvlF4YnmTSw1tGznxCzy0GVlTxj7pJV6JxwMuEXxCa8kWqWKi9RXGwX6NM5RpKSFrJb19R8+HHCNapmRqW89TSJTkrUc9EgOAR3lNLoYwNqlO/8AM3ijIAqMr7P0P+426WzbzA5CdDTrRbtqEljuvOvS0uQa8tc14Fu0PZX+WsT99dctxTC3Lp+AJv38+YNkowvrsGJzIhxax1SjqnZY5AB7eAe37HmXHoNkZd7/2wkL+nCf3CfYKQWQM4whmnkTywZMdGBCb8pvAj6TO5NDpY7HhiaNjmge4zLPZCOgYlMHxGYwBvh8ZGD/MmBFQ52+0UKMo7g9gf4/Q0/z/BLSCWzztk9RFBjmMEIHjGBEqVGt5HQLaDgojBz+VjKpuT0Wk9lR7nSgkE7RRh3AXCzJfdxdJ/saGpfzYfnYNHjtBjNi8pEU2DdFhwiXFGa6lfmkANR+pgMX+pvV49t1B0ShyFUdBAgoTDnNdCWEmk0Eb2kiCILxmfsfU8ykumCV3wr2v5YXM01YEE5kcLZoRcyI/MffvF9TzgT/Ll8dsducBQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(82310400008)(186006)(1800799006)(451199021)(36840700001)(40470700004)(46966006)(26005)(1076003)(16526019)(2616005)(36756003)(7696005)(336012)(966005)(6666004)(478600001)(82740400003)(81166007)(356005)(110136005)(54906003)(70586007)(70206006)(4326008)(426003)(41300700001)(316002)(8676002)(5660300002)(8936002)(44832011)(40460700003)(15650500001)(4744005)(2906002)(36860700001)(83380400001)(47076005)(86362001)(40480700001)(170073001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 03:52:51.1796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2091e0-36f2-4d92-5d72-08db988c1a9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7439
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for amd64_edac module and temperature monitoring,
through k10temp driver, on AMD's Family 1Ah-based models.

The first patch adds the required PCI IDs for models 00h-1Fh, 20h and
40h-4Fh.

The second patch adds the required support in k10temp driver for AMD's
Family 1Ah-based models.

The third patch adds support in amd64_edac module for models 00h-1Fh and
40h-4Fh.

Changes in v2:
 - Modify commit message of the first patch according to the feedback
received.

v1: https://lore.kernel.org/linux-edac/20230706171323.3722900-1-avadhut.naik@amd.com/T/#t

Avadhut Naik (3):
  x86/amd_nb: Add PCI IDs for AMD Family 1Ah-based models
  hwmon: (k10temp) Add thermal support for AMD Family 1Ah-based models
  EDAC/amd64: Add support for AMD Family 1Ah Models 00h-1Fh and 40h-4Fh

 arch/x86/kernel/amd_nb.c  |  8 ++++++++
 drivers/edac/amd64_edac.c | 15 +++++++++++++++
 drivers/hwmon/k10temp.c   |  8 +++++++-
 include/linux/pci_ids.h   |  2 ++
 4 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.34.1

