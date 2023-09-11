Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3686D79B675
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjIKUuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbjIKKbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:31:08 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360D8120
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 03:31:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWSybtUMKyXGdbcxifNy7Pe16cA2pb2s+JZ9sf4gkibzAXZ+lEuKfl0/cKh2J1FoakrI9RSY8S3fSc2DNX4buiQQJBpK0zY+bo1B/j0sci4ge59/qAMRLoKpMn6y4SUPi89flM6u9xjTWhO9o8FP5SzgdAY1dhV5tFGDanypiHyiLbXTMVZc6L8ANPI6ywvGWJRQeSxzW3oWHOHPOkVQG4/a+9y3MvFQoH95BiXRPo46RwWG44aUnh+Pe+FzdwHQiUsBLlLP53upqGPJpGUjdz0WQ0hnyK8bUAQIAqc5Nx/R2FjNjrvmgAPFWdd8VqJlAM3w/F/c3KtkrFTMGdr4sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=be0+IeLWy2MesQFcUruoJ0FC8oaHcxOl/YQhM8BdXiM=;
 b=IdqahC3KpMK7KHjNg3ZAXIUyMh4jtlq05x7sxq+Y+KCJvYwZlRUb7ib8EeWjC7ctJKYQArbc/WRYuNAQIYJZ1PaA5m0QZQsbou8bgWY3t69PQIO3sTY+zBIXdJe0uZ+UpKD0rXnQcISHLd3uhaM8KF6twtYCp1K+Qiru/4jiDG6/iAOEHI9mns/tztZOZqg/7rv56SiBAJi3E/XozCQs77iktLg8q5W3IlqMCwWH/yebeQbgoBTrunqZ+6D1r+yTpNdYxbQUH48c9xgVYdrPzRSo77YKO++NMb5CbS4FXCS0SLzoB1xea9yqXpWYGsk/F18yO15LajKPfwbPoy1WyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=be0+IeLWy2MesQFcUruoJ0FC8oaHcxOl/YQhM8BdXiM=;
 b=PVqZ7lSPJlTSXlKA099bLWag0bOMO0+IoKwJVbKgwEIMB9/GunbrnASX9dg6hU/vzz7SjLC0N32wrUFBomTLhGj+wiOjGFo+ih1eagvbHENviFYAcnEiWGqNUsj1xtR6D1FyP8U0wrbH+YBAg0GOmxr35Oe5/mHA+06x2FkfD3U=
Received: from CH0PR03CA0052.namprd03.prod.outlook.com (2603:10b6:610:b3::27)
 by DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 10:31:01 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::99) by CH0PR03CA0052.outlook.office365.com
 (2603:10b6:610:b3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 10:31:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.16 via Frontend Transport; Mon, 11 Sep 2023 10:31:00 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 05:30:55 -0500
From:   Jiqian Chen <Jiqian.Chen@amd.com>
To:     Gerd Hoffmann <kraxel@redhat.com>,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
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
Subject: [RESEND QEMU PATCH v4 1/1] virtgpu: do not destroy resources when guest suspend
Date:   Mon, 11 Sep 2023 18:30:31 +0800
Message-ID: <20230911103031.1432693-2-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911103031.1432693-1-Jiqian.Chen@amd.com>
References: <20230911103031.1432693-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|DS0PR12MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c9f0a2c-59a8-44b2-2e26-08dbb2b23190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hdmFuSZB3cNsypMQ2wyOblGOLlxf2F1KMtoaL/tRZgUYNxSFj44oLTrWFEWqxSMbur40D8Wyi13W974kc6j2cKSLrIx01uMvoLvdx0ZqJtLxlPHKUjPi789zOU2mUlItct8PSfKtk/vobrHUPeGaOj6E2WxV1ar9fpONWG1SGsiz0BZ3lNB92ag/lS5qndPjjoP1/DRXauiB0bPCcZ04ZtHYT4X9ysnwi5mKK4VE2pOT6LJBEakM9UnFHmlxGR9dye2LGNqHyhPHDSuTtjIAILzndGA3jgFhigtlG9FKCEJ7M0Klqgp6ya2C854rtDZp4hCiw3cDd8jVxmsboRpkf/oPtmuj5KEzEmCgTJw+6tcB4jmREM4bOzhrQ2XFA2S4+ClZWy32B+AMRCtOHGhC8CgJD40GPDZu2Rr6eI13NIduYF2pNyGXmEaG5S/c4vy69bwIk1t7q9yW7D/gUaPQmEWlMK5oGn5MomA4CTHplgAI1RPYlOC4c9AFs52wUWDrqSHFXztXprJG30BZcM9tx2FNqHC3c5ROm31rVWCi1pvyiAnaBooEGjjDz4LbBcMInIGke04/rIeqcrRyro4u+et0pOyBG1Cof6ZU4CZBZuUX2dieUrdXjiJX6lzLDc+3+noyaL3n+VlQ5DGWozAqr96qENDaDO2x/kf3ZREe/F7NZm/FqduMu15aXlEDE1oeE79USBv4927mwtlD44YtS8R0Y3/DNbqfgvUqYAsmTW9C6pW3fK2AmKW6JDNh6mCPdCAixz3z8pzEXeLU9FiZDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(186009)(451199024)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(41300700001)(316002)(7416002)(15650500001)(1076003)(16526019)(40480700001)(26005)(336012)(426003)(2906002)(110136005)(8936002)(8676002)(70206006)(4326008)(54906003)(70586007)(5660300002)(478600001)(6666004)(40460700003)(7696005)(36756003)(36860700001)(47076005)(2616005)(83380400001)(81166007)(86362001)(82740400003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 10:31:00.3200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9f0a2c-59a8-44b2-2e26-08dbb2b23190
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6415
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After suspending and resuming guest VM, you will get
a black screen, and the display can't come back.

This is because when guest did suspending, it called
into qemu to call virtio_gpu_gl_reset. In function
virtio_gpu_gl_reset, it destroyed resources and reset
renderer, which were used for display. As a result,
guest's screen can't come back to the time when it was
suspended and only showed black.

So, this patch adds a new ctrl message
VIRTIO_GPU_CMD_SET_FREEZE_MODE to get notifications from
guest. If guest is during suspending, it sets freeze mode
of virtgpu to freeze_S3, this will prevent destroying
resources and resetting renderer when guest calls into
virtio_gpu_gl_reset. If guest is during resuming, it sets
freeze mode to unfreeze, and then virtio_gpu_gl_reset
will keep its origin actions and has no other impaction.

Due to this implemention needs cooperation with guest,
so it added a new feature flag VIRTIO_GPU_F_FREEZE_S3, so
that guest and host can negotiate whenever freeze_S3 is
supported or not.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 hw/display/virtio-gpu-base.c   |  3 +++
 hw/display/virtio-gpu-gl.c     | 10 ++++++-
 hw/display/virtio-gpu-virgl.c  |  7 +++++
 hw/display/virtio-gpu.c        | 48 ++++++++++++++++++++++++++++++++--
 hw/virtio/virtio-qmp.c         |  3 +++
 include/hw/virtio/virtio-gpu.h |  6 +++++
 6 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index ca1fb7b16f..ccc7cc80ce 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -232,6 +232,9 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
     if (virtio_gpu_blob_enabled(g->conf)) {
         features |= (1 << VIRTIO_GPU_F_RESOURCE_BLOB);
     }
+    if (virtio_gpu_freeze_S3_enabled(g->conf)) {
+        features |= (1 << VIRTIO_GPU_F_FREEZE_S3);
+    }
 
     return features;
 }
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index e06be60dfb..cb418dae9a 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -100,7 +100,15 @@ static void virtio_gpu_gl_reset(VirtIODevice *vdev)
      */
     if (gl->renderer_inited && !gl->renderer_reset) {
         virtio_gpu_virgl_reset_scanout(g);
-        gl->renderer_reset = true;
+        /*
+         * If guest is suspending, we shouldn't reset renderer,
+         * otherwise, the display can't come back to the time when
+         * it was suspended after guest was resumed.
+         */
+        if (!virtio_gpu_freeze_S3_enabled(g->parent_obj.conf) ||
+            g->freeze_mode == VIRTIO_GPU_FREEZE_MODE_UNFREEZE) {
+            gl->renderer_reset = true;
+        }
     }
 }
 
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 8bb7a2c21f..ba4258487e 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -483,6 +483,13 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
     case VIRTIO_GPU_CMD_GET_EDID:
         virtio_gpu_get_edid(g, cmd);
         break;
+    case VIRTIO_GPU_CMD_SET_FREEZE_MODE:
+        if (virtio_gpu_freeze_S3_enabled(g->parent_obj.conf)) {
+            virtio_gpu_cmd_set_freeze_mode(g, cmd);
+        } else {
+            cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        }
+        break;
     default:
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         break;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index bbd5c6561a..0cfccde834 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -383,6 +383,16 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
     QTAILQ_INSERT_HEAD(&g->reslist, res, next);
 }
 
+void virtio_gpu_cmd_set_freeze_mode(VirtIOGPU *g,
+                         struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_set_freeze_mode sf;
+
+    VIRTIO_GPU_FILL_CMD(sf);
+    virtio_gpu_bswap_32(&sf, sizeof(sf));
+    g->freeze_mode = sf.freeze_mode;
+}
+
 static void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
 {
     struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[scanout_id];
@@ -1018,6 +1028,13 @@ void virtio_gpu_simple_process_cmd(VirtIOGPU *g,
     case VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING:
         virtio_gpu_resource_detach_backing(g, cmd);
         break;
+    case VIRTIO_GPU_CMD_SET_FREEZE_MODE:
+        if (virtio_gpu_freeze_S3_enabled(g->parent_obj.conf)) {
+            virtio_gpu_cmd_set_freeze_mode(g, cmd);
+        } else {
+            cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        }
+        break;
     default:
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         break;
@@ -1394,11 +1411,28 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
     QTAILQ_INIT(&g->reslist);
     QTAILQ_INIT(&g->cmdq);
     QTAILQ_INIT(&g->fenceq);
+
+    g->freeze_mode = VIRTIO_GPU_FREEZE_MODE_UNFREEZE;
 }
 
 static void virtio_gpu_device_unrealize(DeviceState *qdev)
 {
     VirtIOGPU *g = VIRTIO_GPU(qdev);
+    struct virtio_gpu_simple_resource *res, *tmp;
+
+    /*
+     * This is to prevent memory leak in the situation that qemu is
+     * destroyed when guest is suspended. This also need hot-plug
+     * support.
+     */
+    if (virtio_gpu_freeze_S3_enabled(g->parent_obj.conf) &&
+        g->freeze_mode == VIRTIO_GPU_FREEZE_MODE_FREEZE_S3) {
+        QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
+            virtio_gpu_resource_destroy(g, res);
+        }
+        virtio_gpu_virgl_reset(g);
+        g->freeze_mode = VIRTIO_GPU_FREEZE_MODE_UNFREEZE;
+    }
 
     g_clear_pointer(&g->ctrl_bh, qemu_bh_delete);
     g_clear_pointer(&g->cursor_bh, qemu_bh_delete);
@@ -1413,8 +1447,16 @@ static void virtio_gpu_reset_bh(void *opaque)
     struct virtio_gpu_simple_resource *res, *tmp;
     int i = 0;
 
-    QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
-        virtio_gpu_resource_destroy(g, res);
+    /*
+     * If guest is suspending, we shouldn't destroy resources,
+     * otherwise, the display can't come back to the time when
+     * it was suspended after guest was resumed.
+     */
+    if (!virtio_gpu_freeze_S3_enabled(g->parent_obj.conf) ||
+        g->freeze_mode == VIRTIO_GPU_FREEZE_MODE_UNFREEZE) {
+        QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
+            virtio_gpu_resource_destroy(g, res);
+        }
     }
 
     for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
@@ -1509,6 +1551,8 @@ static Property virtio_gpu_properties[] = {
                      256 * MiB),
     DEFINE_PROP_BIT("blob", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_BLOB_ENABLED, false),
+    DEFINE_PROP_BIT("freeze_S3", VirtIOGPU, parent_obj.conf.flags,
+                    VIRTIO_GPU_FLAG_FREEZE_S3_ENABLED, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 7515b0947b..a5a6ccc515 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -227,6 +227,9 @@ static const qmp_virtio_feature_map_t virtio_gpu_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_GPU_F_CONTEXT_INIT, \
             "VIRTIO_GPU_F_CONTEXT_INIT: Context types and synchronization "
             "timelines supported"),
+    FEATURE_ENTRY(VIRTIO_GPU_F_FREEZE_S3, \
+            "VIRTIO_GPU_F_FREEZE_S3: Freezing virtio-gpu and keeping resources"
+            "alive is supported."),
     FEATURE_ENTRY(VHOST_F_LOG_ALL, \
             "VHOST_F_LOG_ALL: Logging write descriptors supported"),
     FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 390c4642b8..1ea87227ff 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -93,6 +93,7 @@ enum virtio_gpu_base_conf_flags {
     VIRTIO_GPU_FLAG_EDID_ENABLED,
     VIRTIO_GPU_FLAG_DMABUF_ENABLED,
     VIRTIO_GPU_FLAG_BLOB_ENABLED,
+    VIRTIO_GPU_FLAG_FREEZE_S3_ENABLED,
 };
 
 #define virtio_gpu_virgl_enabled(_cfg) \
@@ -105,6 +106,8 @@ enum virtio_gpu_base_conf_flags {
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_DMABUF_ENABLED))
 #define virtio_gpu_blob_enabled(_cfg) \
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_BLOB_ENABLED))
+#define virtio_gpu_freeze_S3_enabled(_cfg) \
+    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_FREEZE_S3_ENABLED))
 
 struct virtio_gpu_base_conf {
     uint32_t max_outputs;
@@ -179,6 +182,7 @@ struct VirtIOGPU {
 
     uint64_t hostmem;
 
+    virtio_gpu_freeze_mode_t freeze_mode;
     bool processing_cmdq;
     QEMUTimer *fence_poll;
     QEMUTimer *print_stats;
@@ -293,5 +297,7 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);
 void virtio_gpu_virgl_reset(VirtIOGPU *g);
 int virtio_gpu_virgl_init(VirtIOGPU *g);
 int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g);
+void virtio_gpu_cmd_set_freeze_mode(VirtIOGPU *g,
+                         struct virtio_gpu_ctrl_command *cmd);
 
 #endif
-- 
2.34.1

