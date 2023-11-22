Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758997F5094
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344035AbjKVTc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 14:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjKVTc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:32:26 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497E411F;
        Wed, 22 Nov 2023 11:32:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCCHxAk800WzBRkrlmrm2/mdP8nwuyH5/RuPdU1f+Hl5Rw/Zg9aSk+0DbAipmSlmyXsa6CGVYZqMfL5UJl4c26qQYDExN9b9GKYkLLPwq8U+wfWLPzHpmbAYJpMOBEaykcHspWMf0ipM6TXWw/t6fC8QUCvWpgop50G3Z3KEum605ILnvK96fv3U6LKhqZxi8q+LEBIBr+1iXSrlMmsNhDUhqMpSA9Z3dS2CwjRItaqG5tNG2p7dOwQO3qCLU7pPAPXs38bInJH1F802uIsNLaOL9kXxCXsgnsQrRuO8Noa9smJ+umj3EM3gGB7nqbgmIiYmkO3w3hzxfpd1gEpvag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3i9GB9uvgNyCJ99OoNYuM+tGFP7EQRSR/eMXKNQk1M=;
 b=BLjFoyFJDvAobw4nevyXA8mwGDsQDbArgVzSRnoKTEW5AcgH/vNmWB+vBwHTQUQgUefuPRZDkk97dj27rHRVQ5e1K7y7Uz89mV+gwMShKFh2MCFnpk+TTpqP0guppY/oYX5TKliWXTdKcWv+aSTrMl37vfygTljedjdatj6fsnGkDoKN3JsJithqYt9MxtwjYOPxxuk2FVZxsYd2AFhmBdLocT37xn3u1JH8j+Ok4KRS5YyXOAZXo9NJSK8mrNtj1HFuA6/K4FWaIKPNzzsFV8Nj+Mi7qroe+Z6izzErPNJqhjI/7uU6Hj0jHRTpRfJjOMVCLdyGJW++E8o/Y0SIzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3i9GB9uvgNyCJ99OoNYuM+tGFP7EQRSR/eMXKNQk1M=;
 b=Qd/j36yUC7SxXy87FZuRIs2urVa9RMrPD6ea+FPvrX0CNXkPTH+Fi1mnVV5Zwqgt8tSyXlTNJqJmkfooZTOcAiKMRu3emxZxGpn0FT2lF+UfA9VJFGiwBkKmtTp/hKFVu4TtwrcEoQf9XixHq62PLa4UDrVasvPU+vYXp7IufF8=
Received: from SA9PR13CA0044.namprd13.prod.outlook.com (2603:10b6:806:22::19)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 19:32:16 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:22:cafe::62) by SA9PR13CA0044.outlook.office365.com
 (2603:10b6:806:22::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16 via Frontend
 Transport; Wed, 22 Nov 2023 19:32:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 19:32:15 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 13:32:14 -0600
From:   Brett Creeley <brett.creeley@amd.com>
To:     <jgg@ziepe.ca>, <yishaih@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>, <kevin.tian@intel.com>,
        <alex.williamson@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH vfio 0/2] vfio/mlx5: locking updates
Date:   Wed, 22 Nov 2023 11:32:01 -0800
Message-ID: <20231122193203.26127-1-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 096d390e-62ac-4d6f-abf8-08dbeb91bbfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIYD+p28TY++Ny81ePGQ9ystz/E+7T0BpJm9gMayUZJpJ4qkEOR9e1tEOyZc9on+OwzynGZR/cLxR5RuLLSEcbPGXu8qZIEiXs4AaolCPBV3AkX5WXwaXzwsYohbvU/di9AeHUXR86awyUATkwHQ4Dm0+2x6nJYxvbL6rnzX3/igxWBNFeU+4a6DzAC11PbMirelsO8rP6gh1QKTT6P9E39YTGGQ7vUldkTft4LfEs7D4VM+3QxGE3rcpB+uZh1a3Ohtu8iTkYVVXs8UKJbiKixoUgMu+XJy1amhzbKiTXC+sl9d2MSo0hIvPpPWH9SGWVtHN5C3+rMbYhhBssUFE857aDQAxNi67ZdlChlfKIlB8nbQh2shsToYm+unKVaJK3u3xWYM/mebbx97RnOm3gYQV5OWMqeKDHT8JjPSCwRhOkZ8UUfp0N9exb0Q4P6cuJNsU132YtjantvkfmeiHRvnFksBfyQFpjIqGXdKmLZgLqWcNxtZCid4DAoynDQHjqhba0Set3ZXtDB3DfKp6Aa/J3NrSYPerJclXhXzmasTtQ8n/FFl2SXSxDkC9B4D88VCIESrwWCZMojTFiL0WfmD6FrbU1sMh6NFPpfS7/Z0Hl0sGob1v6qeiEvI1WRJnwJEe2bf+NStrw0zsrIUkg6s3pp3g9zyUO2KIXjAUjOfqJzEvj+1AbEfLUtewrBh1g8ripJr8b1+PAxy2mXnWGb8E+guK1PnV2N27MFUEscg0J6Tr4WkIC/djHBRQEwTkn8EP2KYa1JO5Mp2oAUlvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(2616005)(54906003)(110136005)(1076003)(316002)(6666004)(70586007)(70206006)(8676002)(8936002)(82740400003)(4326008)(40460700003)(426003)(336012)(83380400001)(26005)(36756003)(16526019)(478600001)(966005)(5660300002)(4744005)(15650500001)(2906002)(40480700001)(36860700001)(86362001)(356005)(47076005)(41300700001)(44832011)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 19:32:15.9206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 096d390e-62ac-4d6f-abf8-08dbeb91bbfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vfio/pds series for locking updates/fixes in the following link
made some changes that can also be done for other vendor's vfio
drivers. Specifically, changing the reset lock from a spinlock to mutex
and also calling mutex_destroy() in the vfio device release callback.

https://lore.kernel.org/kvm/20231122192532.25791-1-brett.creeley@amd.com/

So, this series makes these changes in order to remain separate from
the vfio/pds series linked above.

Note, that I don't have the required hardware to test on this vendor's
hardware, so help would be appreciated.

Brett Creeley (2):
  vfio/mlx5: Change reset_lock to mutex_lock
  vfio/mlx5: Destroy the state_mutex on release

 drivers/vfio/pci/mlx5/cmd.c  |  4 +++-
 drivers/vfio/pci/mlx5/cmd.h  |  3 +--
 drivers/vfio/pci/mlx5/main.c | 12 ++++++------
 3 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.17.1

