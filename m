Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E267A618C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjISLnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjISLnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:43:20 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06B1114
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkTF3WSyCn2crS3b+1NPcpw9fYR2CiPuZ7PKegZ/1iVq2Nn+ioRGpvgyWcnuF96KtDVFjwsi0VZWyYr51FaFm5v8utjoGV9TjekSfgM11lYfJYENsMMZ0OG43R7yybAexSifppxXwz+4Vi2gl3uBOAt5WDRYa43Ei+SSpsd1jY6jXWZYgyxcd4y/WLuGBqFaAohV6+HSl/zQDYZRXseb2LOWLUhTetgKduW1et10JPxGw9QlLA6KJoGwE3EY6xuWc/zHrvAgXiPLbQcVHi1pNJXVJiXayETzFGZ5hLuw+mmXrLShYgrJ7T6E2rT89Pnjfjov07uDgum9/ameCzJ+CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAoFkhY5oJpBx+yo7Mt0oeKdn/WSd1Ii7Z/MVzUD6c4=;
 b=Tsaf0iXg80DxaxxyIsTbKB2xIVRKf8jfo41hPbXM4XEi/nPJHdB9D+5xZ1glLSJB9Fck0mFfFbM4e9eips6d7gmPaFDLvQ/u/KG4PA6eE/zQi0wlf4qT15nhqDDOOHhKDu7Az9PpHLi76zMKk6A+n9vKw2j1+aJQEfjxEUaInmIehywm13VhmysHZ5pDRfUrdlzLTxYFF+8j8CTpJBhXqMm7dTakOSPFnfMLEKoydQ7fHJDl71wFI5JsUkxvwRYNb2B4PNhpncyRATg34vh6/0BA2HX3KjK99LGkENvSg0NFfH6+KpEmER0fDsZ3IW3HiKm6DPilESeWabq+UlJiaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAoFkhY5oJpBx+yo7Mt0oeKdn/WSd1Ii7Z/MVzUD6c4=;
 b=txfSppbHT0roKNsRaUo5OzIkJstFs+xG94YH4pNkT/by1wkfJaWqo/3A0SeFjoupHCMdxyImwzREm7YDOTLaA01t8lt3T7P+K7+StnEbmKHk0fETh2XqiS0W6Tud6PHvpFxTZPv6ATB4nJmbBz7/CLtqllkOqPfLqie3Z3F3f2o=
Received: from CH2PR14CA0015.namprd14.prod.outlook.com (2603:10b6:610:60::25)
 by SA3PR12MB7903.namprd12.prod.outlook.com (2603:10b6:806:307::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 11:43:09 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::6) by CH2PR14CA0015.outlook.office365.com
 (2603:10b6:610:60::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Tue, 19 Sep 2023 11:43:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Tue, 19 Sep 2023 11:43:09 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 06:43:03 -0500
From:   Jiqian Chen <Jiqian.Chen@amd.com>
To:     Gerd Hoffmann <kraxel@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        David Airlie <airlied@redhat.com>,
        "Gurchetan Singh" <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
        "Robert Beckett" <bob.beckett@collabora.com>,
        Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
        Parav Pandit <parav@nvidia.com>,
        <virtio-comment@lists.oasis-open.org>,
        <virtio-dev@lists.oasis-open.org>
CC:     <qemu-devel@nongnu.org>, <linux-kernel@vger.kernel.org>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        "Christian Koenig" <Christian.Koenig@amd.com>,
        Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>,
        Honglei Huang <Honglei1.Huang@amd.com>,
        Julia Zhang <Julia.Zhang@amd.com>,
        Huang Rui <Ray.Huang@amd.com>,
        Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add freeze_mode to virtio_pci_common_cfg
Date:   Tue, 19 Sep 2023 19:42:42 +0800
Message-ID: <20230919114242.2283646-2-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|SA3PR12MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b12617c-c774-427f-62af-08dbb90598d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KCKuvHBhVj6cqPB6s23uZHyR4PywbTe8iUO0cllczWSmAc800XCHAy7oXwP3DpPfrckPUqdiGrjNbW+ogvSO1oUkai1feKm1NVUoRrgIMXmMmY3WOG/UHm7vM3FvdXwuLRZLvTRyO0sJH4qw6e10KpgrYfkNzBHRPN1xps/TFTDojVOak5RGa8b3IYrba8oPARjaLyBL9m4LPuWKVAnJ3DsMdn9D3VL0xEg+ruPY4m3fEjchvS6d/De85YqvG9IaxXfI7nGbIvEhA4gbmoMtjNSQHy63j6tzBVTiOiBV51xZ4KQJQT2CJnzzPhQYLotsBWTeU7yJKZsEq9gySulbNFR9BeEuoaoeL+dAlDpud2DWwkVEUFNUqJNhyxkGhNLmRJjdqTCLhX6CmplsnkHZUGZVtH8ZP3pVyatpT8D6QoYjlImutypOzxM8YwJTciy7+x49wiMS05yYM2+fZVGfxhEGLclW9BzSY87evoPswOH2qpimEXKutQihyGG1JnLKiq8Vp63cot0e6qIksdSV14Pu3wgOSH7fIMC/AVAjvThffdSZR2XxdDT3tyUC5f3VDT74wFBtWn3lZn0jhIFbOWnT6nxMlf30zvo+tPOzB94dCXtovb8YYE+2negjYAvSytg+1cdrF0D3gBk4dP01f+Axk7EtzopFqKiDhyS2VdkkKX746lHa06VegFG3aRqViOYPIsgqtOF1VXZ1XwSXECicvh6HnHDVyXDhIx5TamAGWmnUxjYb08ilT8tqhMvT5C+X5FNkgDOju/4pX3nHq9165a4Aj+1n8ooW+mKUpVc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199024)(82310400011)(1800799009)(186009)(40470700004)(46966006)(36840700001)(70206006)(70586007)(54906003)(7696005)(110136005)(40480700001)(316002)(41300700001)(478600001)(6666004)(8936002)(4326008)(8676002)(40460700003)(82740400003)(1076003)(26005)(5660300002)(16526019)(47076005)(36860700001)(356005)(81166007)(921005)(336012)(83380400001)(426003)(2906002)(2616005)(86362001)(7416002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 11:43:09.2437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b12617c-c774-427f-62af-08dbb90598d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7903
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When guest vm does S3, Qemu will reset and clear some things of virtio
devices, but guest can't aware that, so that may cause some problems.
For excample, Qemu calls virtio_reset->virtio_gpu_gl_reset when guest
resume, that function will destroy render resources of virtio-gpu. As
a result, after guest resume, the display can't come back and we only
saw a black screen. Due to guest can't re-create all the resources, so
we need to let Qemu not to destroy them when S3.

For above purpose, we need a mechanism that allows guests and QEMU to
negotiate their reset behavior. So this patch add a new parameter
named freeze_mode to struct virtio_pci_common_cfg. And when guest
suspends, it can write freeze_mode to be FREEZE_S3, and then virtio
devices can change their reset behavior on Qemu side according to
freeze_mode. What's more, freeze_mode can be used for all virtio
devices to affect the behavior of Qemu, not just virtio gpu device.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 transport-pci.tex | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/transport-pci.tex b/transport-pci.tex
index a5c6719..2543536 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -319,6 +319,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
         le64 queue_desc;                /* read-write */
         le64 queue_driver;              /* read-write */
         le64 queue_device;              /* read-write */
+        le16 freeze_mode;               /* read-write */
         le16 queue_notif_config_data;   /* read-only for driver */
         le16 queue_reset;               /* read-write */
 
@@ -393,6 +394,12 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 \item[\field{queue_device}]
         The driver writes the physical address of Device Area here.  See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
 
+\item[\field{freeze_mode}]
+        The driver writes this to set the freeze mode of virtio pci.
+        VIRTIO_PCI_FREEZE_MODE_UNFREEZE - virtio-pci is running;
+        VIRTIO_PCI_FREEZE_MODE_FREEZE_S3 - guest vm is doing S3, and virtio-pci enters S3 suspension;
+        Other values are reserved for future use, like S4, etc.
+
 \item[\field{queue_notif_config_data}]
         This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated.
         The driver will use this value when driver sends available buffer
-- 
2.34.1

