Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD697DADFB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 20:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjJ2TqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 15:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJ2TqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 15:46:16 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8ADC79B
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 12:46:12 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxV_GCtj5lsps1AA--.39947S3;
        Mon, 30 Oct 2023 03:46:10 +0800 (CST)
Received: from openarena.loongson.cn (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxXNx+tj5lKq02AA--.51878S3;
        Mon, 30 Oct 2023 03:46:06 +0800 (CST)
From:   Sui Jingfeng <suijingfeng@loongson.cn>
To:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] drm/loongson: Introduce a minimal support for Loongson VBIOS
Date:   Mon, 30 Oct 2023 03:46:00 +0800
Message-Id: <20231029194607.379459-2-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231029194607.379459-1-suijingfeng@loongson.cn>
References: <20231029194607.379459-1-suijingfeng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxXNx+tj5lKq02AA--.51878S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj9fXoW3urWDWF1rGw1UtF1kWr1kXrc_yoW8Wr4kCo
        WxZan8Zw4Fgr4UZayvgr1Fqr1xXFyFqF1av3s3Zr4DuFWY9F4UJFW3Xry3W34FyF13Xr43
        A34rKw4xGr47Jrs5l-sFpf9Il3svdjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf
        9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
        UjIYCTnIWjp_UUUY67kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
        8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
        Y2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14
        v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
        Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWU
        XVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
        kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY
        6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
        vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kfnx
        nUUI43ZEXa7IU8q2NtUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because some boards are equipped with non-transparent display bridges,
which need the VBIOS to provided parameters.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/loongson/Makefile          |   3 +-
 drivers/gpu/drm/loongson/loongson_device.c |   4 +
 drivers/gpu/drm/loongson/loongson_vbios.c  | 420 +++++++++++++++++++++
 drivers/gpu/drm/loongson/loongson_vbios.h  |  59 +++
 drivers/gpu/drm/loongson/lsdc_drv.c        |   4 +
 drivers/gpu/drm/loongson/lsdc_drv.h        |   8 +
 6 files changed, 497 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/loongson/loongson_vbios.c
 create mode 100644 drivers/gpu/drm/loongson/loongson_vbios.h

diff --git a/drivers/gpu/drm/loongson/Makefile b/drivers/gpu/drm/loongson/Makefile
index 91e72bd900c1..bef00b2c5569 100644
--- a/drivers/gpu/drm/loongson/Makefile
+++ b/drivers/gpu/drm/loongson/Makefile
@@ -17,6 +17,7 @@ loongson-y := \
 	lsdc_ttm.o
 
 loongson-y += loongson_device.o \
-	      loongson_module.o
+	      loongson_module.o \
+	      loongson_vbios.o
 
 obj-$(CONFIG_DRM_LOONGSON) += loongson.o
diff --git a/drivers/gpu/drm/loongson/loongson_device.c b/drivers/gpu/drm/loongson/loongson_device.c
index 9986c8a2a255..64096ad5466e 100644
--- a/drivers/gpu/drm/loongson/loongson_device.c
+++ b/drivers/gpu/drm/loongson/loongson_device.c
@@ -7,6 +7,8 @@
 
 #include "lsdc_drv.h"
 
+extern struct loongson_vbios __loongson_vbios;
+
 static const struct lsdc_kms_funcs ls7a1000_kms_funcs = {
 	.create_i2c = lsdc_create_i2c_chan,
 	.irq_handler = ls7a1000_dc_irq_handler,
@@ -53,6 +55,7 @@ static const struct loongson_gfx_desc ls7a1000_gfx = {
 			.reg_size = 8,
 		},
 	},
+	.vbios = &__loongson_vbios,
 	.chip_id = CHIP_LS7A1000,
 	.model = "LS7A1000 bridge chipset",
 };
@@ -85,6 +88,7 @@ static const struct loongson_gfx_desc ls7a2000_gfx = {
 			.reg_size = 8,
 		},
 	},
+	.vbios = &__loongson_vbios,
 	.chip_id = CHIP_LS7A2000,
 	.model = "LS7A2000 bridge chipset",
 };
diff --git a/drivers/gpu/drm/loongson/loongson_vbios.c b/drivers/gpu/drm/loongson/loongson_vbios.c
new file mode 100644
index 000000000000..dc304018779e
--- /dev/null
+++ b/drivers/gpu/drm/loongson/loongson_vbios.c
@@ -0,0 +1,420 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Loongson Technology Corporation Limited
+ */
+
+#include <drm/drm_device.h>
+#include <drm/drm_managed.h>
+
+#include "loongson_vbios.h"
+#include "lsdc_drv.h"
+
+#define LOONGSON_VBIOS_HEADER_STR       "Loongson-VBIOS"
+/* Legacy VBIOS is stored at offset 0 */
+#define LOONGSON_VBIOS_LEGACY_OFFSET     0
+/* The size of legacy VBIOS is 1 KiB */
+#define LOONGSON_VBIOS_LEGACY_SIZE       0x000400
+
+/* Data Control Block of Newer version of the VBIOS started at here */
+#define LOONGSON_VBIOS_DCB_OFFSET        0x006000
+/* The last 1 MiB of the VRAM contains the raw VBIOS data */
+#define LOONGSON_VBIOS_BLOCK_OFFSET      0x100000
+/* Only 256KB of the 1 MiB are used for now */
+#define LOONGSON_VBIOS_BLOCK_SIZE        0x040000
+
+struct loongson_vbios __loongson_vbios;
+
+/*
+ * vbios data control block is a kind of metadata, which is used to index
+ * real hardware device data block.
+ */
+struct loongson_vbios_dcb {
+	u16 type;    /* what is it */
+	u8 version;  /* version of it, useless */
+	u8 id;       /* index (usually same with the display pipe) of the hardware */
+	u32 offset;  /* the offset of the real data */
+	u32 size;    /* the size of the real data */
+	u64 ext0;    /* for extension purpose */
+	u64 ext1;    /* extra space reserved for future use */
+} __packed;
+
+/*
+ * Loongson-VBIOS Data Block Layout
+ *
+ *
+ *         _____________________   0x00000
+ *        |_____________________|
+ *        |                     |  [0x0000, 0x0400) : legacy vbios storage
+ *        |    Not Used Yet     |
+ *        |                     |
+ *        |---------------------|<------- 0x6000
+ *   +----|        DCB 0        |
+ *   |    |---------------------|
+ *   |    |        DCB 1        |
+ *   |    |---------------------|      Format of Data Control Blocks
+ *   |    | One by one, packed  |            +------------+
+ *   |    |---------------------|            |  u16 type  |
+ *   |    |        DCB N        |----+       |            |
+ *   |    |---------------------|    |       +------------+
+ *   |    |          .          |    |       | u8 version |
+ *   |    |          .          |    |       |  u8 index  |
+ *   |    |          .          |    |       +------------+
+ *   |    |---------------------|    |       |            |
+ *   |    |        DCB end      |    |       | u32 offset |
+ *   |    |---------------------|    |   +-------         |
+ *   |    |                     |    |   |   |            |
+ *   |    |_____________________|    |   |   +------------+
+ *   |    |_____________________|    |   |   |            |
+ *   |    |                     |    |   |   |  u32 size  |
+ *   +--->|  vbios header info  |    |   |   |         -------+
+ *        |_____________________|    |   |   |            |   |
+ *        |          .          |    |   |   +------------+   |
+ *        |          .          |    |   |   |  useless   |   |
+ *        |          .          |    |   |   |  members   |   |
+ *        |_____________________|    |   |   +------------+   |
+ *        |                     |    |   |                    |
+ *        |    encoders info    |<---+   |                    |
+ *        |_____________________|        |                    |
+ *        |                     |     ___|                    |
+ *        |_____________________|____/                        |
+ *        |                     |                             |
+ *        |      Something      |                             |
+ *        |_____________________|_________________            |
+ *        |                     |             |               |
+ *        |        EDID         |             |<--------------+
+ *        |_____________________|_____________|___
+ *        |                     |
+ *        |                     |    Contents of those device specific data
+ *        |  GPU specific info  |    block are implement-defined and version
+ *        |                     |    dependent :0
+ *        |_____________________|
+ *        /          .          /
+ *        /          .          /
+ *        /          .          /
+ *        |_____________________|  0x040000
+ *
+ */
+
+enum loongson_vbios_dcb_type {
+	LV_DCB_HEADER = 0,
+	LV_DCB_CRTC = 1,
+	LV_DCB_ENCODER = 2,
+	LV_DCB_CONNECTOR = 3,
+	LV_DCB_I2C = 4,
+	LV_DCB_PWM = 5,
+	LV_DCB_GPIO = 6,
+	LV_DCB_BACKLIGHT = 7,
+	LV_DCB_FAN = 8,
+	LV_DCB_IRQ = 9,
+	LV_DCB_ENCODER_CFG = 10,
+	LV_DCB_ENCODER_RES = 11,
+	LV_DCB_GPU = 12,
+	LV_DCB_UNKNOWN = 13,
+	LV_DCB_END = 0xffff,
+};
+
+struct loongson_vbios_header {
+	char header[16];
+	u32 version_major;
+	u32 version_minor;
+	char information[20];
+	u32 num_crtc;
+	u32 crtc_offset;
+	u32 num_connector;
+	u32 connector_offset;
+	u32 num_encoder;
+	u32 encoder_offset;
+} __packed;
+
+struct loongson_vbios_encoder {
+	u32 feature;
+	u32 i2c_id;
+	u32 connector_id;
+	u32 type;
+	u32 config_method;
+	u32 chip_id;
+	u8 chip_addr;
+} __packed;
+
+struct loongson_vbios_connector {
+	u32 feature;
+	u32 i2c_id;
+	u8  edid[256];
+	u32 type;
+	u32 hotplug_method;
+	u32 edid_method;
+	u32 hpd_int_gpio;
+	u32 gpio_place;
+} __packed;
+
+/*
+ * A list node which contains the information about the device specific data
+ * block, the device here refer to the property or topology of hardware
+ * configuration, such as external display bridges, HDP GPIO, connectors etc.
+ */
+struct loongson_vbios_node {
+	struct list_head head;
+
+	/* @type: the type of the data. For search */
+	u32 type;
+	/* @id: the index(display pipe) of the data belong to. For search */
+	u32 id;
+	/*
+	 * @data: point to the device specific data block, such as external
+	 * encoders name and it's i2c device address, hpd gpio resource etc.
+	 */
+	const void *data;
+	/*
+	 * The size of the data.
+	 */
+	u32 size;
+};
+
+/*
+ * The returned pointer is actually point to &__loongson_vbios, but this
+ * function is only intended to provide READ-ONLY access. As our vbios is
+ * only be able to pass(provide) parameters, it is not executable and outside
+ * should not modify it.
+ */
+const struct loongson_vbios *to_loongson_vbios(struct drm_device *ddev)
+{
+	struct lsdc_device *ldev = to_lsdc(ddev);
+	const struct loongson_gfx_desc *gfx = to_loongson_gfx(ldev->descp);
+
+	return gfx->vbios;
+}
+
+static bool loongson_vbios_is_valid(const struct loongson_vbios *vbios)
+{
+	char header[32];
+
+	memcpy(header, vbios->raw_data, sizeof(header));
+
+	if (strcmp(header, LOONGSON_VBIOS_HEADER_STR))
+		return false;
+
+	return true;
+}
+
+/*
+ * The VBIOS blob is stored at the last 1 MiB of the VRAM, no SPI flush or
+ * EEPROM is needed. Platform BIOS is responsible for store this VBIOS blob
+ * data at right position on per boot time.
+ */
+static int loongson_vbios_construct(struct drm_device *ddev,
+				    struct loongson_vbios *vbios)
+{
+	struct lsdc_device *ldev = to_lsdc(ddev);
+	u64 vram_end = ldev->vram_base + ldev->vram_size;
+	u64 vbios_start = vram_end - LOONGSON_VBIOS_BLOCK_OFFSET;
+	void __iomem *ptr;
+
+	vbios->raw_data = kzalloc(LOONGSON_VBIOS_BLOCK_SIZE, GFP_KERNEL);
+	if (!vbios->raw_data)
+		return -ENOMEM;
+
+	ptr = ioremap(vbios_start, LOONGSON_VBIOS_BLOCK_SIZE);
+	if (!ptr) {
+		drm_err(ddev, "Map VBIOS region failed\n");
+		return -ENOMEM;
+	}
+
+	memcpy_fromio(vbios->raw_data, ptr, LOONGSON_VBIOS_BLOCK_SIZE);
+
+	iounmap(ptr);
+
+	INIT_LIST_HEAD(&vbios->list);
+	vbios->ddev = ddev;
+
+	return 0;
+}
+
+static void loongson_vbios_destruct(struct drm_device *ddev, void *data)
+{
+	struct loongson_vbios *vbios = (struct loongson_vbios *)data;
+	struct loongson_vbios_node *node;
+	struct loongson_vbios_node *tmp;
+
+	list_for_each_entry_safe(node, tmp, &vbios->list, head) {
+		list_del(&node->head);
+		kfree(node);
+	}
+
+	kfree(vbios->raw_data);
+	vbios->raw_data = NULL;
+}
+
+static void loongson_vbios_print_dcb(struct drm_device *ddev,
+				     struct loongson_vbios_dcb *dcb)
+{
+	drm_info(ddev, "type: %u, Offset: %u, Size: %u, version: %u, ID: %u\n",
+		 dcb->type, dcb->offset, dcb->size, dcb->version, dcb->id);
+}
+
+/*
+ * Process the data control block, establish a list for later searching.
+ * returns the number of data control block. Generally, loongson vbios
+ * has only 10 DCB or so.
+ */
+static int loongson_vbios_process_dcb(struct loongson_vbios *vbios,
+				      bool verbose)
+{
+	struct drm_device *ddev = vbios->ddev;
+	void *base = vbios->raw_data;
+	int count = 0;
+	struct loongson_vbios_dcb *dcb;
+
+	dcb = (struct loongson_vbios_dcb *)(base + LOONGSON_VBIOS_DCB_OFFSET);
+
+	while (dcb->type != LV_DCB_END) {
+		struct loongson_vbios_node *node;
+
+		node = kzalloc(sizeof(*node), GFP_KERNEL);
+		if (!node)
+			return -ENOMEM;
+
+		node->type = dcb->type;
+		node->id = dcb->id;
+		node->data = base + dcb->offset;
+		node->size = dcb->size;
+
+		list_add_tail(&node->head, &vbios->list);
+
+		if (verbose)
+			loongson_vbios_print_dcb(ddev, dcb);
+
+		++dcb;
+
+		if (++count > 1024) {
+			drm_err(ddev, "Unlikely, DCB is too much\n");
+			break;
+		}
+	}
+
+	return count;
+}
+
+static const struct loongson_vbios_node *
+loongson_vbios_get_node(struct drm_device *ddev, u32 type, u32 id)
+{
+	const struct loongson_vbios *vbios = to_loongson_vbios(ddev);
+	struct loongson_vbios_node *np;
+
+	if (!vbios)
+		return NULL;
+
+	list_for_each_entry(np, &vbios->list, head) {
+		if (np->type == type && np->id == id)
+			return np;
+	}
+
+	return NULL;
+}
+
+bool loongson_vbios_query_encoder_info(struct drm_device *ddev,
+				       u32 pipe,
+				       u32 *type,
+				       enum loongson_vbios_encoder_name *name,
+				       u8 *i2c_addr)
+{
+	const struct loongson_vbios_encoder *vencoder;
+	const struct loongson_vbios_node *np;
+
+	np = loongson_vbios_get_node(ddev, LV_DCB_ENCODER, pipe);
+	if (!np)
+		return false;
+
+	if (np->size != sizeof(*vencoder))
+		WARN_ON(1);
+
+	vencoder = (const struct loongson_vbios_encoder *)np->data;
+
+	if (type)
+		*type = vencoder->type;
+
+	if (name)
+		*name = vencoder->chip_id;
+
+	/* i2c address, as a slave device */
+	if (i2c_addr)
+		*i2c_addr = vencoder->chip_addr;
+
+	return true;
+}
+
+bool loongson_vbios_query_connector_info(struct drm_device *ddev,
+					 u32 pipe,
+					 u32 *connector_type,
+					 u32 *hpd_method,
+					 u32 *int_gpio,
+					 u8 *edid_blob)
+{
+	const struct loongson_vbios_connector *vconnector;
+	const struct loongson_vbios_node *np;
+
+	np = loongson_vbios_get_node(ddev, LV_DCB_CONNECTOR, pipe);
+	if (!np)
+		return false;
+
+	if (np->size != sizeof(*vconnector))
+		WARN_ON(1);
+
+	vconnector = (const struct loongson_vbios_connector *)np->data;
+
+	if (connector_type)
+		*connector_type = vconnector->type;
+
+	if (edid_blob)
+		memcpy(edid_blob, vconnector->edid, 256);
+
+	if (int_gpio)
+		*int_gpio = vconnector->hpd_int_gpio;
+
+	return true;
+}
+
+static void loongson_vbios_acquire_version(struct drm_device *ddev,
+					   struct loongson_vbios *vbios)
+{
+	struct loongson_vbios_header *vh;
+
+	vh = (struct loongson_vbios_header *)vbios->raw_data;
+
+	vbios->version_major = vh->version_major;
+	vbios->version_minor = vh->version_minor;
+
+	drm_info(ddev, "Loongson VBIOS version: %u.%u\n",
+		 vh->version_major, vh->version_minor);
+}
+
+int loongson_vbios_init(struct drm_device *ddev)
+{
+	struct loongson_vbios *vbios = &__loongson_vbios;
+	int ret;
+	int num;
+
+	ret = loongson_vbios_construct(ddev, vbios);
+	if (ret)
+		return ret;
+
+	ret = drmm_add_action_or_reset(ddev, loongson_vbios_destruct, vbios);
+	if (ret)
+		return ret;
+
+	if (!loongson_vbios_is_valid(vbios)) {
+		drm_err(ddev, "Loongson VBIOS: header is invalid\n");
+		return -EINVAL;
+	}
+
+	loongson_vbios_acquire_version(ddev, vbios);
+
+	num = loongson_vbios_process_dcb(vbios, false);
+	if (num <= 0) {
+		drm_err(ddev, "Loongson VBIOS: Process DCB failed\n");
+		return -EINVAL;
+	}
+
+	drm_info(ddev, "Loongson VBIOS: has %d DCBs\n", num);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/loongson/loongson_vbios.h b/drivers/gpu/drm/loongson/loongson_vbios.h
new file mode 100644
index 000000000000..66fb43b3609e
--- /dev/null
+++ b/drivers/gpu/drm/loongson/loongson_vbios.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2023 Loongson Technology Corporation Limited
+ */
+
+#ifndef __LOONGSON_VBIOS_H__
+#define __LOONGSON_VBIOS_H__
+
+#include <drm/drm_device.h>
+
+struct loongson_vbios {
+	struct list_head list;
+	void *raw_data;
+	struct drm_device *ddev;
+	u32 version_major;
+	u32 version_minor;
+};
+
+enum loongson_vbios_encoder_name {
+	ENCODER_CHIP_UNKNOWN = 0x00,
+	ENCODER_CHIP_INTERNAL_VGA = 0x01,
+	ENCODER_CHIP_INTERNAL_HDMI = 0x02,
+	ENCODER_CHIP_CH7055 = 0x10,
+	ENCODER_CHIP_ADV7125 = 0x11,
+	ENCODER_CHIP_TFP410 = 0x20,
+	ENCODER_CHIP_IT66121 = 0x30,
+	ENCODER_CHIP_SIL9022 = 0x31,
+	ENCODER_CHIP_LT8618 = 0x32,
+	ENCODER_CHIP_MS7210 = 0x33,
+	ENCODER_CHIP_NCS8805 = 0x40,
+	ENCODER_CHIP_LT9721 = 0x42,
+	ENCODER_CHIP_LT6711 = 0x43,
+	ENCODER_CHIP_LT8619 = 0x50,
+};
+
+enum loongson_vbios_hotplug_method {
+	LV_HPD_DISABLED = 0,
+	LV_HPD_POLLING = 1,
+	LV_HPD_IRQ = 2,
+};
+
+const struct loongson_vbios *to_loongson_vbios(struct drm_device *ddev);
+
+bool loongson_vbios_query_encoder_info(struct drm_device *ddev,
+				       u32 pipe,
+				       u32 *type,
+				       enum loongson_vbios_encoder_name *name,
+				       u8 *i2c_addr);
+
+bool loongson_vbios_query_connector_info(struct drm_device *ddev,
+					 u32 pipe,
+					 u32 *connector_type,
+					 u32 *hpd_method,
+					 u32 *int_gpio,
+					 u8 *edid_blob);
+
+int loongson_vbios_init(struct drm_device *ddev);
+
+#endif
diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongson/lsdc_drv.c
index 89ccc0c43169..aebb200fa567 100644
--- a/drivers/gpu/drm/loongson/lsdc_drv.c
+++ b/drivers/gpu/drm/loongson/lsdc_drv.c
@@ -213,6 +213,10 @@ lsdc_create_device(struct pci_dev *pdev,
 		return ERR_PTR(ret);
 	}
 
+	ret = loongson_vbios_init(ddev);
+	if (ret)
+		drm_info(ddev, "No VBIOS support\n");
+
 	ret = drm_aperture_remove_conflicting_framebuffers(ldev->vram_base,
 							   ldev->vram_size,
 							   driver);
diff --git a/drivers/gpu/drm/loongson/lsdc_drv.h b/drivers/gpu/drm/loongson/lsdc_drv.h
index fbf2d760ef27..335953c988d1 100644
--- a/drivers/gpu/drm/loongson/lsdc_drv.h
+++ b/drivers/gpu/drm/loongson/lsdc_drv.h
@@ -16,6 +16,7 @@
 #include <drm/drm_plane.h>
 #include <drm/ttm/ttm_device.h>
 
+#include "loongson_vbios.h"
 #include "lsdc_i2c.h"
 #include "lsdc_irq.h"
 #include "lsdc_gfxpll.h"
@@ -85,6 +86,13 @@ struct loongson_gfx_desc {
 		u32 reg_size;
 	} pixpll[LSDC_NUM_CRTC];
 
+	/*
+	 * @vbios: Provide information about the output configuration,
+	 * and provide information about dynamic features which cannot
+	 * be detected(determined) with the chip_id.
+	 */
+	const struct loongson_vbios *vbios;
+
 	enum loongson_chip_id chip_id;
 	char model[64];
 };
-- 
2.34.1

