Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8757DA396
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 00:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346659AbjJ0WhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 18:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbjJ0WhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 18:37:15 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CB71A5;
        Fri, 27 Oct 2023 15:37:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Om9Rvjj1/cWYaeM9fjxFcc3kyxhxEGbc/HiORJDi42ZpNr7lYtwMOMwj6yE3Z5uwUaC8mvZzN6IHTed9GlRbFEWqT8ehSuzdtkLls124S/8G9nyegb51sp+fKbhd1xFQyWgpAPD5evMrH1d6hV/oa9wlg9QWGKoadonKpDJtqRyqu636bCjW1R5fOYzUruPEiT0K66jbSJ3vUV6IXjMJXOoGnkdKbradteoLcd11CREarKjFwdd+TBvRS2CrAOOtnpQ+DhQhgoe+uzgBNsogGb3FXkJ0SirNQUL9RhiQkbkdqN4qDFvpxzQwQ0ebbSvQEkcl6lJMnHJY1ysFuD+3eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K43OMtLi3SL2eBNzFpi18AFLkQEj3+mlb2T7C6faEBM=;
 b=j7JB1p6rjmzpzkSd7UTAWJsjnKaniTQhjzBjpvRWQ3gKshUVbTnTbTZ9SZUKdiKjGlXXYlF7gm015HcwYnd3edOlPWfXx1DzzWZ4dHxHT5fZ78eY4trkC6CG88qLbB+EzBuW0L3YRJ/w6Sm7hSjljA7OO0QwRtcPGFyfZxHsTWlA4w/eGv55jl+snJaoo/Pz71gHyF6bl2DYYVXvQdDqAUQmAyRvikWVrkus7uttDaP0tF5VYYAZxAuCPnjuYz1CB8ivkOqV01fiPyqk0HJP3D9eCRQnhBqV++QLPu8jI5ZxaIssMg8PHacWv3MRV3JmmBAs87AaCOo77BesLe7JKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K43OMtLi3SL2eBNzFpi18AFLkQEj3+mlb2T7C6faEBM=;
 b=Chwzfaf3EeT1hwkN4obBxMlsULdHKjsSysDZj3MTGJb4hLbErKu6zW1RdZ66YKDjFG6N8+nYIhMq+MyOYMMd0ySpgRTeRe5lkGOnGurVLmbGuVvwr3ES2GoUOjtesl0mSwkCE9Zo5Zb9sCgU3bBtBTKOTKGydkSTkaN5GrmaU9I=
Received: from BL6PEPF00016413.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:b) by SA3PR12MB8762.namprd12.prod.outlook.com
 (2603:10b6:806:31f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Fri, 27 Oct
 2023 22:37:10 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2a01:111:f403:f902::) by BL6PEPF00016413.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Fri, 27 Oct 2023 22:37:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Fri, 27 Oct 2023 22:37:09 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 27 Oct
 2023 17:37:07 -0500
From:   Brett Creeley <brett.creeley@amd.com>
To:     <jgg@ziepe.ca>, <yishaih@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>, <kevin.tian@intel.com>,
        <alex.williamson@redhat.com>, <dan.carpenter@linaro.org>
CC:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <brett.creeley@amd.com>, <shannon.nelson@amd.com>
Subject: [PATCH v3 vfio 1/3] pds/vfio: Fix spinlock bad magic BUG
Date:   Fri, 27 Oct 2023 15:36:49 -0700
Message-ID: <20231027223651.36047-2-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231027223651.36047-1-brett.creeley@amd.com>
References: <20231027223651.36047-1-brett.creeley@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|SA3PR12MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: ad323e1c-30ee-42c4-9f8d-08dbd73d4197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ryhICwS61JYI1qEe2XhS9qzlz4ANszou5iabraJYBDVQYhPtsmq9irfQRtPUIY1Ue9Hnjhhsx5cYYCQZgAlABeRDnbgyFfugbw2q7EP1+BxnrriIe/kl2/M0kqfQXfT/Y7f7e51WzW97QWNyaHqOmGJ23J43thcMVJr4gYhA5gbaK+EcFdtESLTuNW/QLJJF+8twU8+Aq69yK5PykNmVCKPLNIHbsPLJ9NVIKNKd4dkr/gNsEV2xG5trPYR+2ynpkxkcXUp8k9JSnbSuxXUVLG3+QAfiFWNWXy+4X2lwVeCOAHkxNBXQHdKekYMyp0nPd+gIcSSjYkG6qF1L4JK/s6hz/fwpKniHSuNqp+Hc8Y8sWqaZYC/+B11DadyzMvDnJflYCTKb+NpgshdZYchzwZy0C3n/FShXTmjXdTHO61OKKTZVAK05Vb1d0JcBRp1HP7ln0c8YqEplR1ppDvUjT7QS7h7Z02/rjSUJ8ZSH3qXtHo9FkzTo4OXvJ5nndHoG39hCHLwh1RwPoTQ4e/ODiJuusCb0t4D+I8GXP09q3+BgelZWs9rhSgdetv0ktLdcctofBIrIoMNTkISoTGOvcSrCmCMaPZBdakM+1IY9TO34vzmh5c6igpBDbmbvnOx+aQvTBM3UhJk9qOVi8Bs21kc7B5oSKZmw5beAdBH1kunekAmevgGrIoSljJk/E3vGunRvoWD6Iy5uXvPAEuVI458OgNYX3QJJ7HmccIAJT56TnI9qXpRddBh7xEZeF3FoHTEBx7yhVUgACF4FXVHJqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(83380400001)(4326008)(40460700003)(40480700001)(82740400003)(1076003)(2616005)(316002)(86362001)(6666004)(54906003)(2906002)(41300700001)(44832011)(8936002)(8676002)(110136005)(5660300002)(70206006)(70586007)(426003)(36756003)(336012)(478600001)(356005)(16526019)(26005)(36860700001)(81166007)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 22:37:09.6021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad323e1c-30ee-42c4-9f8d-08dbd73d4197
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8762
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following BUG was found when running on a kernel with
CONFIG_DEBUG_SPINLOCK=y set:

BUG: spinlock bad magic on CPU#2, bash/2481
 lock: 0xffff8d6052a88f50, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
Call Trace:
 <TASK>
 dump_stack_lvl+0x36/0x50
 do_raw_spin_lock+0x79/0xc0
 pds_vfio_reset+0x1d/0x60 [pds_vfio_pci]
 pci_reset_function+0x4b/0x70
 reset_store+0x5b/0xa0
 kernfs_fop_write_iter+0x137/0x1d0
 vfs_write+0x2de/0x410
 ksys_write+0x5d/0xd0
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

As shown, the .magic: 00000000, does not match the expected value. This
is because spin_lock_init() is never called for the reset_lock. Fix
this by calling spin_lock_init(&pds_vfio->reset_lock) when initializing
the device.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/vfio/pci/pds/vfio_dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vfio/pci/pds/vfio_dev.c b/drivers/vfio/pci/pds/vfio_dev.c
index 649b18ee394b..c351f588fa13 100644
--- a/drivers/vfio/pci/pds/vfio_dev.c
+++ b/drivers/vfio/pci/pds/vfio_dev.c
@@ -155,6 +155,8 @@ static int pds_vfio_init_device(struct vfio_device *vdev)
 
 	pds_vfio->vf_id = vf_id;
 
+	spin_lock_init(&pds_vfio->reset_lock);
+
 	vdev->migration_flags = VFIO_MIGRATION_STOP_COPY | VFIO_MIGRATION_P2P;
 	vdev->mig_ops = &pds_vfio_lm_ops;
 	vdev->log_ops = &pds_vfio_log_ops;
-- 
2.17.1

