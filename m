Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840587A6085
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjISLDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjISLDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:03:09 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B3119D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:03:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPXeQU9wn0W0hqCAxiIV2q2kDZD/iazW6XnEbyGjc5P0fcoOuwUnnDdnRYct8Gpo5rfywQAPuixzisyM99SS/pehf0vRT05sjY9mmI4U/thkoSwT1rG8l+av7pblm3JsiE515e87e3qtfol/SuTsjdWxaJovGPYrHE9GbI+uNdkrIjDbjVlhMzJg9atBfRJUDIY2XCZh/vJO+mFCf6idULRn7yNb8Xci1sU01JxV2Pe1CUuBAzwPMggjOShy1ZFy12iwkTd3299WwyCPjPX3esC5W7QRSYomsODLjVQ1d/8g0ot5wBGpnaawvX1dXPzN066rT8K7/bPRRyhEiO9BdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTa6x8C4rAzvS0wAW9UyemxMoqk14yikg5bCtxfOXHw=;
 b=F0qsoj05S3FMAiSXYK7mSk56isSL+fdoJP7LzzSHgJ7ZHEWo2ffMn/VgYRKb6xH4TrymdHaZhq1ubBX46ot/4xQ/3Jxu88g2gv7WPeYEize7kFcxv89YO9XGK5Pv0GNUbLy047TZobyIzQkWPCliRU+2/H1E4r7J/EVHmo5dvM1NlZy7SVdVb0xiRvghQDQoeq8Ezn8VRiuY4dJO5ZBF/zNP5z5MrExhyIu726x5sm/s7YOqBsk4kWl5VFXjMVN2H+YJbhaY9OIDIyooyS+GfUAoIrHy51+pdK+9qkc/Urw/xsRH1A1PuA7fvgVDoesJPY1UKDiTLo9wXxw7QZ+Y5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTa6x8C4rAzvS0wAW9UyemxMoqk14yikg5bCtxfOXHw=;
 b=vXrsnO1pQk0Uikzv0OaCmPn4I97BnKnyKVDh88nRq9cziPYiLePtyWCyY9+xP4ayxu69DmWulNam/6r0LQJ0N8ToMh2Ca1z36I2IZTtfHaLKkLB9IKPXoQXesak2Z5LlOWsqkmHy0kcRsZuv+cO40IEHI0MiT02NrctDvhh/GcI=
Received: from MW4P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::19)
 by IA1PR12MB8192.namprd12.prod.outlook.com (2603:10b6:208:3f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Tue, 19 Sep
 2023 11:02:54 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:115:cafe::6a) by MW4P220CA0014.outlook.office365.com
 (2603:10b6:303:115::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Tue, 19 Sep 2023 11:02:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.0 via Frontend Transport; Tue, 19 Sep 2023 11:02:53 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 06:02:47 -0500
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
        <qemu-devel@nongnu.org>
CC:     <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Anthony PERARD <anthony.perard@citrix.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>,
        Honglei Huang <Honglei1.Huang@amd.com>,
        Julia Zhang <Julia.Zhang@amd.com>,
        Huang Rui <Ray.Huang@amd.com>,
        Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [QEMU PATCH v5 1/2] virtio-pci: Add freeze_mode case for virtio pci
Date:   Tue, 19 Sep 2023 19:02:24 +0800
Message-ID: <20230919110225.2282914-2-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919110225.2282914-1-Jiqian.Chen@amd.com>
References: <20230919110225.2282914-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|IA1PR12MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: 583b4faf-442f-4f99-ad88-08dbb8fff8f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gr8OFxxFDbpPu0DBrcB6bGkstDJqbwAkFE5Sg2eb1/hYFyMmpDPhn72QtHwFzamysE+tA77iv0bI5PMjzBH0kFYQRWJw8sEVRvOP36vWhn1RwbGoCQw9U24ZLvIfxmF/RU96hcq+/8ReTsqwy/AszztgyEd75O7EyGQW2IRLi+rBlAijyOIrjAxZ6sQyKCVPB/2N2+PlKrXDaRXUa5allqvxOh4ijZjfDWm4l2RmCYEBU/M0wJfhXyMtU/JC7R+mmhEPYVvqigORE24e05MrncYYh2pyn7bMB1jcydwfa49OCC6w8JTEOQSTquafuXAOrv0vxTyFNxXpQNopYlykFaDG3IgMpTmKiK9kdVai6e58NOgRsmRBorQss7KEf1i0FRj8tBIeJF81NH2r323O2H6WYHdoyLwcLN/ckXK3jAkZa2EEiwFp2Cpmo+DvmNe+RDMS+Wz4a1CT83ZWudAF8NVJ42MaMj6mLR0JB87ChrqtMtreOiXSAqCCAZkl64GeA0zzGwIw73w+uZgrMZ2uTDlPAE+UuBSHddcdMI2Nwhp7dgJCkU8ro9FsIhuaZeePm3L5/dEeCKSBbh0smOcWZTt2NnjkL2c4PkWTYp4nv+HdKfDmVwEdvzWdEQcKC7JDsh2flKltV+S3SLY13MFu3yhfyfg6yefB+wdQ69/CC7j7NSuI8PxmxCwP99MfbOB+yy42zEXUDRsP8V16LQfnuZ3OqFe2643OTIAazSiy/SD9NgGDlx+wn9kv7UDaBR/Q+x6y3JlO8dWlLouKHVnzhOjh1pNCcKbFVZwES/JMlvA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(82740400003)(86362001)(40480700001)(40460700003)(81166007)(1076003)(921005)(356005)(16526019)(7696005)(54906003)(26005)(316002)(41300700001)(70586007)(8676002)(5660300002)(4326008)(70206006)(478600001)(110136005)(36860700001)(336012)(426003)(83380400001)(8936002)(47076005)(6666004)(2616005)(36756003)(7416002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 11:02:53.4385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 583b4faf-442f-4f99-ad88-08dbb8fff8f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8192
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When guest vm do S3, Qemu will reset and clear some things of virtio
devices, but guest can't aware that, so that may cause some problems.
For excample, Qemu calls virtio_reset->virtio_gpu_gl_reset, that will
destroy render resources of virtio-gpu. As a result, after guest resume,
the display can't come back and we only saw a black screen. Due to guest
can't re-create all the resources, so we need to let Qemu not to destroy
them when S3.

For above purpose, this patch add a new parameter named freeze_mode to
struct VirtIODevice, and when guest suspends, guest can write freeze_mode
to be FREEZE_S3, so that virtio devices can change their reset behavior
on Qemu side according to that mode.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 hw/virtio/virtio-pci.c     | 5 +++++
 hw/virtio/virtio.c         | 1 +
 include/hw/virtio/virtio.h | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index edbc0daa18..7a3cca79b4 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1651,6 +1651,11 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
             proxy->vqs[vdev->queue_sel].enabled = 0;
         }
         break;
+    case VIRTIO_PCI_COMMON_F_MODE:
+        virtio_pci_freeze_mode_t freeze_mode = (virtio_pci_freeze_mode_t)val;
+        if ((1 << freeze_mode) & VIRTIO_PCI_FREEZE_MODE_MASK)
+            vdev->freeze_mode = freeze_mode;
+        break;
     default:
         break;
     }
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 969c25f4cf..4278cedef4 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3201,6 +3201,7 @@ void virtio_init(VirtIODevice *vdev, uint16_t device_id, size_t config_size)
     vdev->vhost_started = false;
     vdev->device_id = device_id;
     vdev->status = 0;
+    vdev->freeze_mode = VIRTIO_PCI_FREEZE_MODE_UNFREEZE;
     qatomic_set(&vdev->isr, 0);
     vdev->queue_sel = 0;
     vdev->config_vector = VIRTIO_NO_VECTOR;
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c8f72850bc..f8bfd9da28 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -21,6 +21,7 @@
 #include "qemu/event_notifier.h"
 #include "standard-headers/linux/virtio_config.h"
 #include "standard-headers/linux/virtio_ring.h"
+#include "standard-headers/linux/virtio_pci.h"
 #include "qom/object.h"
 
 /*
@@ -106,6 +107,7 @@ struct VirtIODevice
     DeviceState parent_obj;
     const char *name;
     uint8_t status;
+    virtio_pci_freeze_mode_t freeze_mode;
     uint8_t isr;
     uint16_t queue_sel;
     /**
-- 
2.34.1

