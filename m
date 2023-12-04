Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844D7802F2C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjLDJrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbjLDJrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:47:42 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A6D186;
        Mon,  4 Dec 2023 01:47:42 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-548f853fc9eso5518383a12.1;
        Mon, 04 Dec 2023 01:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701683260; x=1702288060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PBj0ExkdS0nAMQxMeeSrLoKah7qZBkE5ZZuTEy/N10=;
        b=EkYvYor90g/OIr1ac5xYLW+vht3sB3bdOagEHCKOwvmSbTkXouNDL9h9SRXsPcC90W
         Sjp7Rd+nQ51D9+oczjf69OplcRYJ8iHpZ1PQ7jF2GaLqL8O4lp7NG8mvk5DayiXe3adS
         eg2/4fRwRsTToIeeRa/FzPjODpUibD/sUJsTcg/Y5Km6Q0IiwSeda06RE9sg45ljEe0F
         sJlKcrbfgIX8MMZMbBZ00to1OHJCxUZ7eiz9/p946aaI9FQmAl4Bgr921GOki9bhODHS
         h8o6bRpEIiTp8wUVt59txKc23J2Ne4TQcxh1uAxZxCFoo6e+1Y8A1+lW0seS+m5qLR5t
         W73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701683260; x=1702288060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7PBj0ExkdS0nAMQxMeeSrLoKah7qZBkE5ZZuTEy/N10=;
        b=uDXDSl6xDY5ijfREivlINc0iDDKwreTSr2IjuiayecUhksm6eKNbLvEF3G3FXodEHa
         0JsW1WBPFLe9wdid/PCkcOgDQA3tCHleQlHuvYfylNF5szPdd5aAf7Y13AZN2wE30jo6
         kHMCTdcb+lM//zLEOBw7VNu7lzevCXxrqa8oCrug8nBPbKXXisA2yFFyVIf7n2VxPe6g
         rr08aQhIOh9nw36o/0YtGRt6CNn0wpVgaKo9CEIC5t8Bwn5SH2DzrfH4p/vYcFIjwXDU
         RMlszRdgWVNtcbd28gOue3cCFITCCFgoyqFq7BSLkZfdSwkV3ivQH2jzVzGKJ/EU6zZc
         G9lA==
X-Gm-Message-State: AOJu0YwgtYfi+hqA0JpK7C7gHxg+R8P0GaiYHVvte3pm7l5qi/a9SO0c
        WmtrIQRUm1Kern1Wy8tB7Fo=
X-Google-Smtp-Source: AGHT+IHFbhIHu/+Htws1F6vxtiTIS2zB5hOMQa6GKq3c0iAGx4LC+FO9sBUagKbbGrKuMHOml3MfPg==
X-Received: by 2002:a17:906:2248:b0:a1b:447d:311c with SMTP id 8-20020a170906224800b00a1b447d311cmr673381ejr.35.1701683260222;
        Mon, 04 Dec 2023 01:47:40 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-48-100.cust.vodafonedsl.it. [188.217.48.100])
        by smtp.gmail.com with ESMTPSA id le12-20020a170907170c00b009dd90698893sm5051705ejc.38.2023.12.04.01.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 01:47:39 -0800 (PST)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     laurent.pinchart@ideasonboard.com, martin.hecht@avnet.eu,
        michael.roeder@avnet.eu, linuxfancy@googlegroups.com,
        mhecht73@gmail.com, sakari.ailus@linux.intel.com,
        christophe.jaillet@wanadoo.fr,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Scally <djrscally@gmail.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v15 3/3] media: i2c: Add support for alvium camera
Date:   Mon,  4 Dec 2023 10:47:16 +0100
Message-Id: <20231204094719.190334-4-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204094719.190334-1-tomm.merciai@gmail.com>
References: <20231204094719.190334-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Alvium camera is shipped with sensor + isp in the same housing.
The camera can be equipped with one out of various sensor and abstract
the user from this. Camera is connected via MIPI CSI-2.

Most of the camera module features are supported, with the main exception
being fw update.

The driver provides all mandatory, optional and recommended V4L2 controls
for maximum compatibility with libcamera

References:
 - https://www.alliedvision.com/en/products/embedded-vision-solutions

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
Changes since v2:
 - Removed gpios/clock handling as suggested by LPinchart
 - Added vcc-ext-in supply support as suggested by LPinchart
 - Fixed alvium_setup_mipi_fmt funct as suggested by CJAILLET
 - Removed upside_down/hshake_bit priv data as suggested by CJAILLET
 - Fixed commit body as suggested by LPinchart
 - Mv alvium_set_streamon_delay to yalvium_set_lp2hs_delay
 - Fixed comment on lp2hs prop as suggested by LPinchart
 - Added pm resume/suspend functs as suggested by LPinchart
 - Dropped alvium_link_setup/alvium_s_power as suggested by LPinchart
 - Fixed regs defines as suggested by LPinchart
 - Fixed typedef as suggested by LPinchart
 - Dropped bcrm_v/fw_v from priv data as suggested by LPinchart
 - Now driver use the subdev active state to store the active format and crop
   as suggested by LPinchart
 - Dropped alvium_is_csi2/i2c_to_alvium as suggested by LPinchart

Changes since v3:
 - Fixed warnings Reported-by: kernel test robot <lkp@intel.com>

Changes since v4:
 - Removed print into alvium_get_dt_data for alliedvision,lp2hs-delay-us as
   suggested by CDooley

Changes since v5:
 - Used tab instead of space in .h as suggested by SAilus
 - Added support for new CCI API from HDeGoede as suggested by SAilus
 - Fixed alvium_write/alvium_read, functions now using the new CCI api, suggested by LPinchart
 - Fixed alvium_get_feat_inq func as suggested by SAilus
 - Fixed indentation/var-order/includes-order as suggested by SAilus
 - Fixed alvium_csi2_fmts with MIPI_CSI2_DT_ defines as suggested by SAilus
 - Fixed alvium_is_alive as suggested by SAilus
 - Fixed alvium_code_to_pixfmt funct as suggested by SAilus
 - Fixed alvium_get_dt_data function, now use only fwnode as suggested by SAilus
 - Fixed autosuspend into the probe, is disable as default as suggested by SAilus
 - Fixed alvium_get_dt_data function, assigned bus type before parsing the ep
   as suggested by SAilus
 - Fixed alvium_power_off, removed wrong print as suggested by SAilus

Changes since v6:
 - Fixed .h indentation
 - Fixed function params indentation
 - Added int *err params for alvium_read/alvium_write as suggested by LPinchart
 - Removed dbg print from the driver, driver is now using dbg/err prints that comes from
   new cci API as suggested by LPinchart. This, fits SAilus suggestion on common pattern function.
 - Fixed alvium_write_hshake, now use read_poll_timeout as suggested by LPinchart
 - Removed useless includes
 - Added maintainers file entries

Changes since v7:
 - Fix company legal entity from Inc. to GmbH
 - Fix warnings given from HVerkuil build-scripts in alvium_get_bcrm_vers,
   alvium_get_fw_version and probe functions using __le16/__le32. Fixed also
   probe function warning alvium-csi2.c:2665 alvium_probe() warn: missing error code? 'ret'

Changes since v8:
 - Fixed alvium_i2c_driver struct, use probe istead of probe_new
 - Fixed Kconfig description taking as reference new mt9m114 driver
 - Fixed Kconfig just select V4L2_CCI_I2C taking as reference new mt9m114 driver

Changes since v9:
 - Fixed Y8_1X8 mipi_fmt_regval
 - Removed alliedvision,lp2hs-delay-us property we set now a default safe value as discussed with SAilus
 - Added dft property for ctrls initialization, we first read dft values from the camera and set this into ctrls
 - Fixed indentation as suggested by SAilus
 - Fixed bit field definitions alignment into .h as suggested by SAilus
 - Fixed Heartbeat reg from R -> RW
 - Fixed adjusting values in format/crop changes as suggested by SAilus
 - Removed unnecessary brcm_addr checks as suggested by SAilus
 - Merged poweron/poweroff functions as suggested by SAilus
 - Added poweroff path during probe as suggested by SAilus
 - Fixed module license type as suggested by SAilus
 - Removed unnecessary MODULE_DEVICE_TABLE as suggested by SAilus
 - Fixed pm support in s_ctrl and s_stream functions
 - Removed unnecessary local variables  as suggested by SAilus
 - Added ret values checks as suggested by SAilus

Changes since v10:
 - Fixed alignment as suggested by SAilus
 - Fixed alvium_read pattern over the driver as suggested by LPinchart
 - Fixed alvium_set_csi_clk
 - Fixed counters types of alvium_setup_mipi_fmt as suggested by SAilus
 - Fixed alvium_set_frame_rate now don't use local var as suggested by SAilus
 - Added pm_runtime_put into alvium_s_stream as suggested by SAilus
 - Fixed alvium_g_volatile_ctrl as suggested by SAilus

Changes since v11:
 - Fixed kmalloc_array alignment in alvium_setup_mipi_fmt as suggested by CJAILLET
 - Fixed alvium_s_frame_interval: return ret instead of -EIO as suggested by CJAILLET
 - Fixed alvium_power_on: useless init ret var as suggested by CJAILLET
 - Fixed missing space in alvium_power_on function as suggested by CJAILLET
 - Fixed probe function print, from now driver use dev_err_probe as suggested by CJAILLET
 - Add missing alvium_subdev_cleanup into alvium_remove function as suggested by CJAILLET

Changes since v12:
 - Fixed alvium_remove function as suggested by CJAILLET/SAilus

Changes since v13:
 - Added free for alvium->alvium_csi2_fmt as suggested by SAilus
 - Renamed alvium_power_on into alvium_set_power as suggested by SAilus
 - Use alvium_set_power into alvium_runtime_resume (pwr off path) as suggested by SAilus
 - Use new v4l2_subdev_state_get_crop/v4l2_subdev_state_get_format
 - Use v4l_bound_align_image into alvium_set_fmt/alvium_set_mode as suggested by SAilus
 - Refactoring of alvium_ctrl_init
 - Splitted auto_gain/gain exposure/auto_exposure awb/bb/rb into alvium_s_ctrl as suggested by SAilus
 - Use container_of_const as suggested by SAilus

Changes since v14:
 - Added .init_state alvium_internal_ops rebased on top of 79adb3adb331
 - Splitted REG_BCRM_VERSION_R/REG_BCRM_DEVICE_FIRMWARE_VERSION_R
 - Fixed alvium_get_bcrm_vers/alvium_get_fw_version as suggested by SAilus
 - Removed unnecessary initialization of alvium->alvium_csi2_fmt into alvium_setup_mipi_fmt as suggested by SAilus
 - Use alvium->alvium_csi2_fmt and not add a local variable into alvium_code_to_pixfmt as suggested by SAilus

 MAINTAINERS                     |    9 +
 drivers/media/i2c/Kconfig       |   10 +
 drivers/media/i2c/Makefile      |    1 +
 drivers/media/i2c/alvium-csi2.c | 2530 +++++++++++++++++++++++++++++++
 drivers/media/i2c/alvium-csi2.h |  475 ++++++
 5 files changed, 3025 insertions(+)
 create mode 100644 drivers/media/i2c/alvium-csi2.c
 create mode 100644 drivers/media/i2c/alvium-csi2.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b6c4c8e037bf..d0ae9678a574 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -711,6 +711,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/allegro,al5e.yaml
 F:	drivers/media/platform/allegro-dvt/
 
+ALLIED VISION ALVIUM CAMERA DRIVER
+M:	Tommaso Merciai <tomm.merciai@gmail.com>
+M:	Martin Hecht <martin.hecht@avnet.eu>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
+F:	drivers/media/i2c/alvium-csi2.c
+F:	drivers/media/i2c/alvium-csi2.h
+
 ALLWINNER A10 CSI DRIVER
 M:	Maxime Ripard <mripard@kernel.org>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index aae05142e191..1e0b0abf93bb 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -41,6 +41,16 @@ config VIDEO_APTINA_PLL
 config VIDEO_CCS_PLL
 	tristate
 
+config VIDEO_ALVIUM_CSI2
+	tristate "Allied Vision ALVIUM MIPI CSI-2 camera support"
+	select V4L2_CCI_I2C
+	help
+	  This is a Video4Linux2 sensor-level driver for the Allied Vision
+	  ALVIUM camera connected via MIPI CSI-2 interface.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called alvium-csi2.
+
 config VIDEO_AR0521
 	tristate "ON Semiconductor AR0521 sensor support"
 	help
diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
index a7ee96174397..1ec1ab0f160e 100644
--- a/drivers/media/i2c/Makefile
+++ b/drivers/media/i2c/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_VIDEO_ADV7604) += adv7604.o
 obj-$(CONFIG_VIDEO_ADV7842) += adv7842.o
 obj-$(CONFIG_VIDEO_AK7375) += ak7375.o
 obj-$(CONFIG_VIDEO_AK881X) += ak881x.o
+obj-$(CONFIG_VIDEO_ALVIUM_CSI2) += alvium-csi2.o
 obj-$(CONFIG_VIDEO_APTINA_PLL) += aptina-pll.o
 obj-$(CONFIG_VIDEO_AR0521) += ar0521.o
 obj-$(CONFIG_VIDEO_BT819) += bt819.o
diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
new file mode 100644
index 000000000000..cff2b67247a7
--- /dev/null
+++ b/drivers/media/i2c/alvium-csi2.c
@@ -0,0 +1,2530 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Allied Vision Technologies GmbH Alvium camera driver
+ *
+ * Copyright (C) 2023 Tommaso Merciai
+ * Copyright (C) 2023 Martin Hecht
+ * Copyright (C) 2023 Avnet EMG GmbH
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <media/mipi-csi2.h>
+#include <media/v4l2-async.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-fwnode.h>
+#include <media/v4l2-subdev.h>
+
+#include "alvium-csi2.h"
+
+static const struct v4l2_mbus_framefmt alvium_csi2_default_fmt = {
+	.code = MEDIA_BUS_FMT_UYVY8_1X16,
+	.width = 640,
+	.height = 480,
+	.colorspace = V4L2_COLORSPACE_SRGB,
+	.ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(V4L2_COLORSPACE_SRGB),
+	.quantization = V4L2_QUANTIZATION_FULL_RANGE,
+	.xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(V4L2_COLORSPACE_SRGB),
+	.field = V4L2_FIELD_NONE,
+};
+
+static const struct alvium_pixfmt alvium_csi2_fmts[] = {
+	{
+		/* UYVY8_2X8 */
+		.id = ALVIUM_FMT_UYVY8_2X8,
+		.code = MEDIA_BUS_FMT_UYVY8_2X8,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.fmt_av_bit = ALVIUM_BIT_YUV422_8,
+		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
+		.mipi_fmt_regval = MIPI_CSI2_DT_YUV422_8B,
+		.bay_fmt_regval = -1,
+		.is_raw = 0,
+	}, {
+		/* UYVY8_1X16 */
+		.id = ALVIUM_FMT_UYVY8_1X16,
+		.code = MEDIA_BUS_FMT_UYVY8_1X16,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.fmt_av_bit = ALVIUM_BIT_YUV422_8,
+		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
+		.mipi_fmt_regval = MIPI_CSI2_DT_YUV422_8B,
+		.bay_fmt_regval = -1,
+		.is_raw = 0,
+	}, {
+		/* YUYV8_1X16 */
+		.id = ALVIUM_FMT_YUYV8_1X16,
+		.code = MEDIA_BUS_FMT_YUYV8_1X16,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.fmt_av_bit = ALVIUM_BIT_YUV422_8,
+		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
+		.mipi_fmt_regval = MIPI_CSI2_DT_YUV422_8B,
+		.bay_fmt_regval = -1,
+		.is_raw = 0,
+	}, {
+		/* YUYV8_2X8 */
+		.id = ALVIUM_FMT_YUYV8_2X8,
+		.code = MEDIA_BUS_FMT_YUYV8_2X8,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.fmt_av_bit = ALVIUM_BIT_YUV422_8,
+		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
+		.mipi_fmt_regval = MIPI_CSI2_DT_YUV422_8B,
+		.bay_fmt_regval = -1,
+		.is_raw = 0,
+	}, {
+		/* YUYV10_1X20 */
+		.id = ALVIUM_FMT_YUYV10_1X20,
+		.code = MEDIA_BUS_FMT_YUYV10_1X20,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.fmt_av_bit = ALVIUM_BIT_YUV422_10,
+		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
+		.mipi_fmt_regval = MIPI_CSI2_DT_YUV422_10B,
+		.bay_fmt_regval = -1,
+		.is_raw = 0,
+	}, {
+		/* RGB888_1X24 */
+		.id = ALVIUM_FMT_RGB888_1X24,
+		.code = MEDIA_BUS_FMT_RGB888_1X24,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.fmt_av_bit = ALVIUM_BIT_RGB888,
+		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
+		.mipi_fmt_regval = MIPI_CSI2_DT_RGB888,
+		.bay_fmt_regval = -1,
+		.is_raw = 0,
+	}, {
+		/* RBG888_1X24 */
+		.id = ALVIUM_FMT_RBG888_1X24,
+		.code = MEDIA_BUS_FMT_RBG888_1X24,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.fmt_av_bit = ALVIUM_BIT_RGB888,
+		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
+		.mipi_fmt_regval = MIPI_CSI2_DT_RGB888,
+		.bay_fmt_regval = -1,
+		.is_raw = 0,
+	}, {
+		/* BGR888_1X24 */
+		.id = ALVIUM_FMT_BGR888_1X24,
+		.code = MEDIA_BUS_FMT_BGR888_1X24,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.fmt_av_bit = ALVIUM_BIT_RGB888,
+		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
+		.mipi_fmt_regval = MIPI_CSI2_DT_RGB888,
+		.bay_fmt_regval = -1,
+		.is_raw = 0,
+	}, {
+		/* RGB888_3X8 */
+		.id = ALVIUM_FMT_RGB888_3X8,
+		.code = MEDIA_BUS_FMT_RGB888_3X8,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.fmt_av_bit = ALVIUM_BIT_RGB888,
+		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
+		.mipi_fmt_regval = MIPI_CSI2_DT_RGB888,
+		.bay_fmt_regval = -1,
+		.is_raw = 0,
+	}, {
+		/* Y8_1X8 */
+		.id = ALVIUM_FMT_Y8_1X8,
+		.code = MEDIA_BUS_FMT_Y8_1X8,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW8,
+		.bay_av_bit = ALVIUM_BIT_BAY_MONO,
+		.mipi_fmt_regval = MIPI_CSI2_DT_RAW8,
+		.bay_fmt_regval = 0x00,
+		.is_raw = 1,
+	}, {
+		/* SGRBG8_1X8 */
+		.id = ALVIUM_FMT_SGRBG8_1X8,
+		.code = MEDIA_BUS_FMT_SGRBG8_1X8,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW8,
+		.bay_av_bit = ALVIUM_BIT_BAY_GR,
+		.mipi_fmt_regval = MIPI_CSI2_DT_RAW8,
+		.bay_fmt_regval = 0x01,
+		.is_raw = 1,
+	}, {
+		/* SRGGB8_1X8 */
+		.id = ALVIUM_FMT_SRGGB8_1X8,
+		.code = MEDIA_BUS_FMT_SRGGB8_1X8,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW8,
+		.bay_av_bit = ALVIUM_BIT_BAY_RG,
+		.mipi_fmt_regval = MIPI_CSI2_DT_RAW8,
+		.bay_fmt_regval = 0x02,
+		.is_raw = 1,
+	}, {
+		/* SGBRG8_1X8 */
+		.id = ALVIUM_FMT_SGBRG8_1X8,
+		.code = MEDIA_BUS_FMT_SGBRG8_1X8,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW8,
+		.bay_av_bit = ALVIUM_BIT_BAY_GB,
+		.mipi_fmt_regval = MIPI_CSI2_DT_RAW8,
+		.bay_fmt_regval = 0x03,
+		.is_raw = 1,
+	}, {
+		/* SBGGR8_1X8 */
+		.id = ALVIUM_FMT_SBGGR8_1X8,
+		.code = MEDIA_BUS_FMT_SBGGR8_1X8,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW8,
+		.bay_av_bit = ALVIUM_BIT_BAY_BG,
+		.mipi_fmt_regval = MIPI_CSI2_DT_RAW8,
+		.bay_fmt_regval = 0x04,
+		.is_raw = 1,
+	}, {
+		/* Y10_1X10 */
+		.id = ALVIUM_FMT_Y10_1X10,
+		.code = MEDIA_BUS_FMT_Y10_1X10,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW10,
+		.bay_av_bit = ALVIUM_BIT_BAY_MONO,
+		.mipi_fmt_regval = MIPI_CSI2_DT_RAW10,
+		.bay_fmt_regval = 0x00,
+		.is_raw = 1,
+	}, {
+		/* SGRBG10_1X10 */
+		.id = ALVIUM_FMT_SGRBG10_1X10,
+		.code = MEDIA_BUS_FMT_SGRBG10_1X10,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW10,
+		.bay_av_bit = ALVIUM_BIT_BAY_GR,
+		.mipi_fmt_regval = MIPI_CSI2_DT_RAW10,
+		.bay_fmt_regval = 0x01,
+		.is_raw = 1,
+	}, {
+		/* SRGGB10_1X10 */
+		.id = ALVIUM_FMT_SRGGB10_1X10,
+		.code = MEDIA_BUS_FMT_SRGGB10_1X10,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW10,
+		.bay_av_bit = ALVIUM_BIT_BAY_RG,
+		.mipi_fmt_regval = MIPI_CSI2_DT_RAW10,
+		.bay_fmt_regval = 0x02,
+		.is_raw = 1,
+	}, {
+		/* SGBRG10_1X10 */
+		.id = ALVIUM_FMT_SGBRG10_1X10,
+		.code = MEDIA_BUS_FMT_SGBRG10_1X10,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW10,
+		.bay_av_bit = ALVIUM_BIT_BAY_GB,
+		.mipi_fmt_regval = MIPI_CSI2_DT_RAW10,
+		.bay_fmt_regval = 0x03,
+		.is_raw = 1,
+	}, {
+		/* SBGGR10_1X10 */
+		.id = ALVIUM_FMT_SBGGR10_1X10,
+		.code = MEDIA_BUS_FMT_SBGGR10_1X10,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW10,
+		.bay_av_bit = ALVIUM_BIT_BAY_BG,
+		.mipi_fmt_regval = MIPI_CSI2_DT_RAW10,
+		.bay_fmt_regval = 0x04,
+		.is_raw = 1,
+	}, {
+		/* Y12_1X12 */
+		.id = ALVIUM_FMT_Y12_1X12,
+		.code = MEDIA_BUS_FMT_Y12_1X12,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW12,
+		.bay_av_bit = ALVIUM_BIT_BAY_MONO,
+		.mipi_fmt_regval = MIPI_CSI2_DT_RAW12,
+		.bay_fmt_regval = 0x00,
+		.is_raw = 1,
+	}, {
+		/* SGRBG12_1X12 */
+		.id = ALVIUM_FMT_SGRBG12_1X12,
+		.code = MEDIA_BUS_FMT_SGRBG12_1X12,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW12,
+		.bay_av_bit = ALVIUM_BIT_BAY_GR,
+		.mipi_fmt_regval = MIPI_CSI2_DT_RAW12,
+		.bay_fmt_regval = 0x01,
+		.is_raw = 1,
+	}, {
+		/* SRGGB12_1X12 */
+		.id = ALVIUM_FMT_SRGGB12_1X12,
+		.code = MEDIA_BUS_FMT_SRGGB12_1X12,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW12,
+		.bay_av_bit = ALVIUM_BIT_BAY_RG,
+		.mipi_fmt_regval = MIPI_CSI2_DT_RAW12,
+		.bay_fmt_regval = 0x02,
+		.is_raw = 1,
+	}, {
+		/* SGBRG12_1X12 */
+		.id = ALVIUM_FMT_SGBRG12_1X12,
+		.code = MEDIA_BUS_FMT_SGBRG12_1X12,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW12,
+		.bay_av_bit = ALVIUM_BIT_BAY_GB,
+		.mipi_fmt_regval = MIPI_CSI2_DT_RAW12,
+		.bay_fmt_regval = 0x03,
+		.is_raw = 1,
+	}, {
+		/* SBGGR12_1X12 */
+		.id = ALVIUM_FMT_SBGGR12_1X12,
+		.code = MEDIA_BUS_FMT_SBGGR12_1X12,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW12,
+		.bay_av_bit = ALVIUM_BIT_BAY_BG,
+		.mipi_fmt_regval = MIPI_CSI2_DT_RAW12,
+		.bay_fmt_regval = 0x04,
+		.is_raw = 1,
+	}, {
+		/* SBGGR14_1X14 */
+		.id = ALVIUM_FMT_SBGGR14_1X14,
+		.code = MEDIA_BUS_FMT_SBGGR14_1X14,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW14,
+		.bay_av_bit = ALVIUM_BIT_BAY_GR,
+		.mipi_fmt_regval = MIPI_CSI2_DT_RAW14,
+		.bay_fmt_regval = 0x01,
+		.is_raw = 1,
+	}, {
+		/* SGBRG14_1X14 */
+		.id = ALVIUM_FMT_SGBRG14_1X14,
+		.code = MEDIA_BUS_FMT_SGBRG14_1X14,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW14,
+		.bay_av_bit = ALVIUM_BIT_BAY_RG,
+		.mipi_fmt_regval = MIPI_CSI2_DT_RAW14,
+		.bay_fmt_regval = 0x02,
+		.is_raw = 1,
+	}, {
+		/* SRGGB14_1X14 */
+		.id = ALVIUM_FMT_SRGGB14_1X14,
+		.code = MEDIA_BUS_FMT_SRGGB14_1X14,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW14,
+		.bay_av_bit = ALVIUM_BIT_BAY_GB,
+		.mipi_fmt_regval = MIPI_CSI2_DT_RAW14,
+		.bay_fmt_regval = 0x03,
+		.is_raw = 1,
+	}, {
+		/* SGRBG14_1X14 */
+		.id = ALVIUM_FMT_SGRBG14_1X14,
+		.code = MEDIA_BUS_FMT_SGRBG14_1X14,
+		.colorspace = V4L2_COLORSPACE_RAW,
+		.fmt_av_bit = ALVIUM_BIT_RAW14,
+		.bay_av_bit = ALVIUM_BIT_BAY_BG,
+		.mipi_fmt_regval = MIPI_CSI2_DT_RAW14,
+		.bay_fmt_regval = 0x04,
+		.is_raw = 1,
+	},
+	{ /* sentinel */ }
+};
+
+static int alvium_read(struct alvium_dev *alvium, u32 reg, u64 *val, int *err)
+{
+	if (reg & REG_BCRM_V4L2) {
+		reg &= ~REG_BCRM_V4L2;
+		reg += alvium->bcrm_addr;
+	}
+
+	return cci_read(alvium->regmap, reg, val, err);
+}
+
+static int alvium_write(struct alvium_dev *alvium, u32 reg, u64 val, int *err)
+{
+	if (reg & REG_BCRM_V4L2) {
+		reg &= ~REG_BCRM_V4L2;
+		reg += alvium->bcrm_addr;
+	}
+
+	return cci_write(alvium->regmap, reg, val, err);
+}
+
+static int alvium_write_hshake(struct alvium_dev *alvium, u32 reg, u64 val)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	u64 hshake_bit;
+	int ret = 0;
+
+	/* reset handshake bit and write alvium reg */
+	alvium_write(alvium, REG_BCRM_WRITE_HANDSHAKE_RW, 0, &ret);
+	alvium_write(alvium, reg, val, &ret);
+	if (ret) {
+		dev_err(dev, "Fail to write reg\n");
+		return ret;
+	}
+
+	/* poll handshake bit since bit0 = 1 */
+	read_poll_timeout(alvium_read, hshake_bit,
+			  ((hshake_bit & BCRM_HANDSHAKE_W_DONE_EN_BIT) == 1),
+			  15000, 45000, true,
+			  alvium, REG_BCRM_WRITE_HANDSHAKE_RW, &hshake_bit, &ret);
+	if (ret) {
+		dev_err(dev, "poll bit[0] = 1, hshake reg fail\n");
+		return ret;
+	}
+
+	/* reset handshake bit, write 0 to bit0 */
+	alvium_write(alvium, REG_BCRM_WRITE_HANDSHAKE_RW, 0, &ret);
+	if (ret) {
+		dev_err(dev, "Fail to reset hshake reg\n");
+		return ret;
+	}
+
+	/* poll handshake bit since bit0 = 0 */
+	read_poll_timeout(alvium_read, hshake_bit,
+			  ((hshake_bit & BCRM_HANDSHAKE_W_DONE_EN_BIT) == 0),
+			  15000, 45000, true,
+			  alvium, REG_BCRM_WRITE_HANDSHAKE_RW, &hshake_bit, &ret);
+	if (ret) {
+		dev_err(dev, "poll bit[0] = 0, hshake reg fail\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_get_bcrm_vers(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	u64 min, maj;
+	int ret = 0;
+
+	ret = alvium_read(alvium, REG_BCRM_MINOR_VERSION_R, &min, &ret);
+	ret = alvium_read(alvium, REG_BCRM_MAJOR_VERSION_R, &maj, &ret);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "bcrm version: %llu.%llu\n", min, maj);
+
+	return 0;
+}
+
+static int alvium_get_fw_version(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	u64 spec, maj, min, pat;
+	int ret = 0;
+
+	ret = alvium_read(alvium, REG_BCRM_DEVICE_FW_SPEC_VERSION_R, &spec, &ret);
+	ret = alvium_read(alvium, REG_BCRM_DEVICE_FW_MAJOR_VERSION_R, &maj, &ret);
+	ret = alvium_read(alvium, REG_BCRM_DEVICE_FW_MINOR_VERSION_R, &min, &ret);
+	ret = alvium_read(alvium, REG_BCRM_DEVICE_FW_PATCH_VERSION_R, &pat, &ret);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "fw version: %llu.%llu.%llu.%llu\n", spec, maj, min, pat);
+
+	return 0;
+}
+
+static int alvium_get_bcrm_addr(struct alvium_dev *alvium)
+{
+	u64 val;
+	int ret;
+
+	ret = alvium_read(alvium, REG_BCRM_REG_ADDR_R, &val, NULL);
+	if (ret)
+		return ret;
+
+	alvium->bcrm_addr = val;
+
+	return 0;
+}
+
+static int alvium_is_alive(struct alvium_dev *alvium)
+{
+	u64 bcrm, hbeat;
+	int ret = 0;
+
+	alvium_read(alvium, REG_BCRM_MINOR_VERSION_R, &bcrm, &ret);
+	alvium_read(alvium, REG_BCRM_HEARTBEAT_RW, &hbeat, &ret);
+	if (ret)
+		return ret;
+
+	return hbeat;
+}
+
+static void alvium_print_avail_mipi_fmt(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+
+	dev_dbg(dev, "avail mipi_fmt yuv420_8_leg: %u\n",
+		alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_8_LEG]);
+	dev_dbg(dev, "avail mipi_fmt yuv420_8: %u\n",
+		alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_8]);
+	dev_dbg(dev, "avail mipi_fmt yuv420_10: %u\n",
+		alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_10]);
+	dev_dbg(dev, "avail mipi_fmt yuv420_8_csps: %u\n",
+		alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_8_CSPS]);
+	dev_dbg(dev, "avail mipi_fmt yuv420_10_csps: %u\n",
+		alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_10_CSPS]);
+	dev_dbg(dev, "avail mipi_fmt yuv422_8: %u\n",
+		alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV422_8]);
+	dev_dbg(dev, "avail mipi_fmt yuv422_10: %u\n",
+		alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV422_10]);
+	dev_dbg(dev, "avail mipi_fmt rgb888: %u\n",
+		alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB888]);
+	dev_dbg(dev, "avail mipi_fmt rgb666: %u\n",
+		alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB666]);
+	dev_dbg(dev, "avail mipi_fmt rgb565: %u\n",
+		alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB565]);
+	dev_dbg(dev, "avail mipi_fmt rgb555: %u\n",
+		alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB555]);
+	dev_dbg(dev, "avail mipi_fmt rgb444: %u\n",
+		alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB444]);
+	dev_dbg(dev, "avail mipi_fmt raw6: %u\n",
+		alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW6]);
+	dev_dbg(dev, "avail mipi_fmt raw7: %u\n",
+		alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW7]);
+	dev_dbg(dev, "avail mipi_fmt raw8: %u\n",
+		alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW8]);
+	dev_dbg(dev, "avail mipi_fmt raw10: %u\n",
+		alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW10]);
+	dev_dbg(dev, "avail mipi_fmt raw12: %u\n",
+		alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW12]);
+	dev_dbg(dev, "avail mipi_fmt raw14: %u\n",
+		alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW14]);
+	dev_dbg(dev, "avail mipi_fmt jpeg: %u\n",
+		alvium->is_mipi_fmt_avail[ALVIUM_BIT_JPEG]);
+}
+
+static void alvium_print_avail_feat(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+
+	dev_dbg(dev, "feature rev_x: %u\n", alvium->avail_ft.rev_x);
+	dev_dbg(dev, "feature rev_y: %u\n", alvium->avail_ft.rev_y);
+	dev_dbg(dev, "feature int_autop: %u\n", alvium->avail_ft.int_autop);
+	dev_dbg(dev, "feature black_lvl: %u\n", alvium->avail_ft.black_lvl);
+	dev_dbg(dev, "feature gain: %u\n", alvium->avail_ft.gain);
+	dev_dbg(dev, "feature gamma: %u\n", alvium->avail_ft.gamma);
+	dev_dbg(dev, "feature contrast: %u\n", alvium->avail_ft.contrast);
+	dev_dbg(dev, "feature sat: %u\n", alvium->avail_ft.sat);
+	dev_dbg(dev, "feature hue: %u\n", alvium->avail_ft.hue);
+	dev_dbg(dev, "feature whiteb: %u\n", alvium->avail_ft.whiteb);
+	dev_dbg(dev, "feature sharp: %u\n", alvium->avail_ft.sharp);
+	dev_dbg(dev, "feature auto_exp: %u\n", alvium->avail_ft.auto_exp);
+	dev_dbg(dev, "feature auto_gain: %u\n", alvium->avail_ft.auto_gain);
+	dev_dbg(dev, "feature auto_whiteb: %u\n", alvium->avail_ft.auto_whiteb);
+	dev_dbg(dev, "feature dev_temp: %u\n", alvium->avail_ft.dev_temp);
+	dev_dbg(dev, "feature acq_abort: %u\n", alvium->avail_ft.acq_abort);
+	dev_dbg(dev, "feature acq_fr: %u\n", alvium->avail_ft.acq_fr);
+	dev_dbg(dev, "feature fr_trigger: %u\n", alvium->avail_ft.fr_trigger);
+	dev_dbg(dev, "feature exp_acq_line: %u\n", alvium->avail_ft.exp_acq_line);
+}
+
+static void alvium_print_avail_bayer(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+
+	dev_dbg(dev, "avail bayer mono: %u\n",
+		alvium->is_bay_avail[ALVIUM_BIT_BAY_MONO]);
+	dev_dbg(dev, "avail bayer gr: %u\n",
+		alvium->is_bay_avail[ALVIUM_BIT_BAY_GR]);
+	dev_dbg(dev, "avail bayer rg: %u\n",
+		alvium->is_bay_avail[ALVIUM_BIT_BAY_RG]);
+	dev_dbg(dev, "avail bayer gb: %u\n",
+		alvium->is_bay_avail[ALVIUM_BIT_BAY_GB]);
+	dev_dbg(dev, "avail bayer bg: %u\n",
+		alvium->is_bay_avail[ALVIUM_BIT_BAY_BG]);
+}
+
+static int alvium_get_feat_inq(struct alvium_dev *alvium)
+{
+	struct alvium_avail_feat *f;
+	u64 val;
+	int ret;
+
+	ret = alvium_read(alvium, REG_BCRM_FEATURE_INQUIRY_R, &val, NULL);
+	if (ret)
+		return ret;
+
+	f = (struct alvium_avail_feat *)&val;
+	alvium->avail_ft = *f;
+	alvium_print_avail_feat(alvium);
+
+	return 0;
+}
+
+static int alvium_get_host_supp_csi_lanes(struct alvium_dev *alvium)
+{
+	u64 val;
+	int ret;
+
+	ret = alvium_read(alvium, REG_BCRM_CSI2_LANE_COUNT_RW, &val, NULL);
+	if (ret)
+		return ret;
+
+	alvium->h_sup_csi_lanes = val;
+
+	return 0;
+}
+
+static int alvium_set_csi_lanes(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	u64 num_lanes;
+	int ret;
+
+	num_lanes = alvium->ep.bus.mipi_csi2.num_data_lanes;
+
+	if (num_lanes > alvium->h_sup_csi_lanes)
+		return -EINVAL;
+
+	ret = alvium_write_hshake(alvium, REG_BCRM_CSI2_LANE_COUNT_RW,
+				  num_lanes);
+	if (ret) {
+		dev_err(dev, "Fail to set csi lanes reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_lp2hs_delay(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret = 0;
+
+	/*
+	 * The purpose of this reg is force a DPhy reset
+	 * for the period described by the millisecond on
+	 * the reg, before it starts streaming.
+	 *
+	 * To be clear, with that value bigger than 0 the
+	 * Alvium forces a dphy-reset on all lanes for that period.
+	 * That means all lanes go up into low power state.
+	 *
+	 */
+	alvium_write(alvium, REG_BCRM_LP2HS_DELAY_RW,
+		     ALVIUM_LP2HS_DELAY_MS, &ret);
+	if (ret) {
+		dev_err(dev, "Fail to set lp2hs delay reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_get_csi_clk_params(struct alvium_dev *alvium)
+{
+	u64 min_csi_clk, max_csi_clk;
+	int ret = 0;
+
+	alvium_read(alvium, REG_BCRM_CSI2_CLOCK_MIN_R, &min_csi_clk, &ret);
+	alvium_read(alvium, REG_BCRM_CSI2_CLOCK_MAX_R, &max_csi_clk, &ret);
+	if (ret)
+		return ret;
+
+	alvium->min_csi_clk = min_csi_clk;
+	alvium->max_csi_clk = max_csi_clk;
+
+	return 0;
+}
+
+static int alvium_set_csi_clk(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	u64 csi_clk;
+	int ret;
+
+	csi_clk = clamp(alvium->ep.link_frequencies[0], (u64)alvium->min_csi_clk,
+			(u64)alvium->max_csi_clk);
+
+	if (alvium->ep.link_frequencies[0] != (u64)csi_clk) {
+		dev_warn(dev, "requested csi clock (%llu MHz) out of range [%u, %u]"
+			 "Adjusted to %llu\n", alvium->ep.link_frequencies[0],
+			 alvium->min_csi_clk, alvium->max_csi_clk, csi_clk);
+	}
+
+	ret = alvium_write_hshake(alvium, REG_BCRM_CSI2_CLOCK_RW, csi_clk);
+	if (ret) {
+		dev_err(dev, "Fail to set csi clock reg\n");
+		return ret;
+	}
+
+	alvium->link_freq = csi_clk;
+
+	return 0;
+}
+
+static int alvium_get_img_width_params(struct alvium_dev *alvium)
+{
+	u64 imgw, imgw_min, imgw_max, imgw_inc;
+	int ret = 0;
+
+	alvium_read(alvium, REG_BCRM_IMG_WIDTH_RW, &imgw, &ret);
+	alvium_read(alvium, REG_BCRM_IMG_WIDTH_MIN_R, &imgw_min, &ret);
+	alvium_read(alvium, REG_BCRM_IMG_WIDTH_MAX_R, &imgw_max, &ret);
+	alvium_read(alvium, REG_BCRM_IMG_WIDTH_INC_R, &imgw_inc, &ret);
+	if (ret)
+		return ret;
+
+	alvium->dft_img_width = imgw;
+	alvium->img_min_width = imgw_min;
+	alvium->img_max_width = imgw_max;
+	alvium->img_inc_width = imgw_inc;
+
+	return 0;
+}
+
+static int alvium_get_img_height_params(struct alvium_dev *alvium)
+{
+	u64 imgh, imgh_min, imgh_max, imgh_inc;
+	int ret = 0;
+
+	alvium_read(alvium, REG_BCRM_IMG_HEIGHT_RW, &imgh, &ret);
+	alvium_read(alvium, REG_BCRM_IMG_HEIGHT_MIN_R, &imgh_min, &ret);
+	alvium_read(alvium, REG_BCRM_IMG_HEIGHT_MAX_R, &imgh_max, &ret);
+	alvium_read(alvium, REG_BCRM_IMG_HEIGHT_INC_R, &imgh_inc, &ret);
+	if (ret)
+		return ret;
+
+	alvium->dft_img_height = imgh;
+	alvium->img_min_height = imgh_min;
+	alvium->img_max_height = imgh_max;
+	alvium->img_inc_height = imgh_inc;
+
+	return 0;
+}
+
+static int alvium_set_img_width(struct alvium_dev *alvium, u32 width)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_write_hshake(alvium, REG_BCRM_IMG_WIDTH_RW, width);
+	if (ret) {
+		dev_err(dev, "Fail to set img width\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_img_height(struct alvium_dev *alvium, u32 height)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_write_hshake(alvium, REG_BCRM_IMG_HEIGHT_RW, height);
+	if (ret) {
+		dev_err(dev, "Fail to set img height\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_img_offx(struct alvium_dev *alvium, u32 offx)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_write_hshake(alvium, REG_BCRM_IMG_OFFSET_X_RW, offx);
+	if (ret) {
+		dev_err(dev, "Fail to set img offx\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_img_offy(struct alvium_dev *alvium, u32 offy)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_write_hshake(alvium, REG_BCRM_IMG_OFFSET_Y_RW, offy);
+	if (ret) {
+		dev_err(dev, "Fail to set img offy\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_get_offx_params(struct alvium_dev *alvium)
+{
+	u64 min_offx, max_offx, inc_offx;
+	int ret = 0;
+
+	alvium_read(alvium, REG_BCRM_IMG_OFFSET_X_MIN_R, &min_offx, &ret);
+	alvium_read(alvium, REG_BCRM_IMG_OFFSET_X_MAX_R, &max_offx, &ret);
+	alvium_read(alvium, REG_BCRM_IMG_OFFSET_X_INC_R, &inc_offx, &ret);
+	if (ret)
+		return ret;
+
+	alvium->min_offx = min_offx;
+	alvium->max_offx = max_offx;
+	alvium->inc_offx = inc_offx;
+
+	return 0;
+}
+
+static int alvium_get_offy_params(struct alvium_dev *alvium)
+{
+	u64 min_offy, max_offy, inc_offy;
+	int ret = 0;
+
+	alvium_read(alvium, REG_BCRM_IMG_OFFSET_Y_MIN_R, &min_offy, &ret);
+	alvium_read(alvium, REG_BCRM_IMG_OFFSET_Y_MAX_R, &max_offy, &ret);
+	alvium_read(alvium, REG_BCRM_IMG_OFFSET_Y_INC_R, &inc_offy, &ret);
+	if (ret)
+		return ret;
+
+	alvium->min_offy = min_offy;
+	alvium->max_offy = max_offy;
+	alvium->inc_offy = inc_offy;
+
+	return 0;
+}
+
+static int alvium_get_gain_params(struct alvium_dev *alvium)
+{
+	u64 dft_gain, min_gain, max_gain, inc_gain;
+	int ret = 0;
+
+	alvium_read(alvium, REG_BCRM_GAIN_RW, &dft_gain, &ret);
+	alvium_read(alvium, REG_BCRM_GAIN_MIN_R, &min_gain, &ret);
+	alvium_read(alvium, REG_BCRM_GAIN_MAX_R, &max_gain, &ret);
+	alvium_read(alvium, REG_BCRM_GAIN_INC_R, &inc_gain, &ret);
+	if (ret)
+		return ret;
+
+	alvium->dft_gain = dft_gain;
+	alvium->min_gain = min_gain;
+	alvium->max_gain = max_gain;
+	alvium->inc_gain = inc_gain;
+
+	return 0;
+}
+
+static int alvium_get_exposure_params(struct alvium_dev *alvium)
+{
+	u64 dft_exp, min_exp, max_exp, inc_exp;
+	int ret = 0;
+
+	alvium_read(alvium, REG_BCRM_EXPOSURE_TIME_RW, &dft_exp, &ret);
+	alvium_read(alvium, REG_BCRM_EXPOSURE_TIME_MIN_R, &min_exp, &ret);
+	alvium_read(alvium, REG_BCRM_EXPOSURE_TIME_MAX_R, &max_exp, &ret);
+	alvium_read(alvium, REG_BCRM_EXPOSURE_TIME_INC_R, &inc_exp, &ret);
+	if (ret)
+		return ret;
+
+	alvium->dft_exp = dft_exp;
+	alvium->min_exp = min_exp;
+	alvium->max_exp = max_exp;
+	alvium->inc_exp = inc_exp;
+
+	return 0;
+}
+
+static int alvium_get_red_balance_ratio_params(struct alvium_dev *alvium)
+{
+	u64 dft_rb, min_rb, max_rb, inc_rb;
+	int ret = 0;
+
+	alvium_read(alvium, REG_BCRM_RED_BALANCE_RATIO_RW, &dft_rb, &ret);
+	alvium_read(alvium, REG_BCRM_RED_BALANCE_RATIO_MIN_R, &min_rb, &ret);
+	alvium_read(alvium, REG_BCRM_RED_BALANCE_RATIO_MAX_R, &max_rb, &ret);
+	alvium_read(alvium, REG_BCRM_RED_BALANCE_RATIO_INC_R, &inc_rb, &ret);
+	if (ret)
+		return ret;
+
+	alvium->dft_rbalance = dft_rb;
+	alvium->min_rbalance = min_rb;
+	alvium->max_rbalance = max_rb;
+	alvium->inc_rbalance = inc_rb;
+
+	return 0;
+}
+
+static int alvium_get_blue_balance_ratio_params(struct alvium_dev *alvium)
+{
+	u64 dft_bb, min_bb, max_bb, inc_bb;
+	int ret = 0;
+
+	alvium_read(alvium, REG_BCRM_BLUE_BALANCE_RATIO_RW, &dft_bb, &ret);
+	alvium_read(alvium, REG_BCRM_BLUE_BALANCE_RATIO_MIN_R, &min_bb, &ret);
+	alvium_read(alvium, REG_BCRM_BLUE_BALANCE_RATIO_MAX_R, &max_bb, &ret);
+	alvium_read(alvium, REG_BCRM_BLUE_BALANCE_RATIO_INC_R, &inc_bb, &ret);
+	if (ret)
+		return ret;
+
+	alvium->dft_bbalance = dft_bb;
+	alvium->min_bbalance = min_bb;
+	alvium->max_bbalance = max_bb;
+	alvium->inc_bbalance = inc_bb;
+
+	return 0;
+}
+
+static int alvium_get_hue_params(struct alvium_dev *alvium)
+{
+	u64 dft_hue, min_hue, max_hue, inc_hue;
+	int ret = 0;
+
+	alvium_read(alvium, REG_BCRM_HUE_RW, &dft_hue, &ret);
+	alvium_read(alvium, REG_BCRM_HUE_MIN_R, &min_hue, &ret);
+	alvium_read(alvium, REG_BCRM_HUE_MAX_R, &max_hue, &ret);
+	alvium_read(alvium, REG_BCRM_HUE_INC_R, &inc_hue, &ret);
+	if (ret)
+		return ret;
+
+	alvium->dft_hue = (s32)dft_hue;
+	alvium->min_hue = (s32)min_hue;
+	alvium->max_hue = (s32)max_hue;
+	alvium->inc_hue = (s32)inc_hue;
+
+	return 0;
+}
+
+static int alvium_get_black_lvl_params(struct alvium_dev *alvium)
+{
+	u64 dft_blvl, min_blvl, max_blvl, inc_blvl;
+	int ret = 0;
+
+	alvium_read(alvium, REG_BCRM_BLACK_LEVEL_RW, &dft_blvl, &ret);
+	alvium_read(alvium, REG_BCRM_BLACK_LEVEL_MIN_R, &min_blvl, &ret);
+	alvium_read(alvium, REG_BCRM_BLACK_LEVEL_MAX_R, &max_blvl, &ret);
+	alvium_read(alvium, REG_BCRM_BLACK_LEVEL_INC_R, &inc_blvl, &ret);
+	if (ret)
+		return ret;
+
+	alvium->dft_black_lvl = (s32)dft_blvl;
+	alvium->min_black_lvl = (s32)min_blvl;
+	alvium->max_black_lvl = (s32)max_blvl;
+	alvium->inc_black_lvl = (s32)inc_blvl;
+
+	return 0;
+}
+
+static int alvium_get_gamma_params(struct alvium_dev *alvium)
+{
+	u64 dft_g, min_g, max_g, inc_g;
+	int ret = 0;
+
+	alvium_read(alvium, REG_BCRM_GAMMA_RW, &dft_g, &ret);
+	alvium_read(alvium, REG_BCRM_GAMMA_MIN_R, &min_g, &ret);
+	alvium_read(alvium, REG_BCRM_GAMMA_MAX_R, &max_g, &ret);
+	alvium_read(alvium, REG_BCRM_GAMMA_INC_R, &inc_g, &ret);
+	if (ret)
+		return ret;
+
+	alvium->dft_gamma = dft_g;
+	alvium->min_gamma = min_g;
+	alvium->max_gamma = max_g;
+	alvium->inc_gamma = inc_g;
+
+	return 0;
+}
+
+static int alvium_get_sharpness_params(struct alvium_dev *alvium)
+{
+	u64 dft_sh, min_sh, max_sh, inc_sh;
+	int ret = 0;
+
+	alvium_read(alvium, REG_BCRM_SHARPNESS_RW, &dft_sh, &ret);
+	alvium_read(alvium, REG_BCRM_SHARPNESS_MIN_R, &min_sh, &ret);
+	alvium_read(alvium, REG_BCRM_BLACK_LEVEL_MAX_R, &max_sh, &ret);
+	alvium_read(alvium, REG_BCRM_SHARPNESS_INC_R, &inc_sh, &ret);
+	if (ret)
+		return ret;
+
+	alvium->dft_sharp = (s32)dft_sh;
+	alvium->min_sharp = (s32)min_sh;
+	alvium->max_sharp = (s32)max_sh;
+	alvium->inc_sharp = (s32)inc_sh;
+
+	return 0;
+}
+
+static int alvium_get_contrast_params(struct alvium_dev *alvium)
+{
+	u64 dft_c, min_c, max_c, inc_c;
+	int ret = 0;
+
+	alvium_read(alvium, REG_BCRM_CONTRAST_VALUE_RW, &dft_c, &ret);
+	alvium_read(alvium, REG_BCRM_CONTRAST_VALUE_MIN_R, &min_c, &ret);
+	alvium_read(alvium, REG_BCRM_CONTRAST_VALUE_MAX_R, &max_c, &ret);
+	alvium_read(alvium, REG_BCRM_CONTRAST_VALUE_INC_R, &inc_c, &ret);
+	if (ret)
+		return ret;
+
+	alvium->dft_contrast = dft_c;
+	alvium->min_contrast = min_c;
+	alvium->max_contrast = max_c;
+	alvium->inc_contrast = inc_c;
+
+	return 0;
+}
+
+static int alvium_get_saturation_params(struct alvium_dev *alvium)
+{
+	u64 dft_sat, min_sat, max_sat, inc_sat;
+	int ret = 0;
+
+	alvium_read(alvium, REG_BCRM_SATURATION_RW, &dft_sat, &ret);
+	alvium_read(alvium, REG_BCRM_SATURATION_MIN_R, &min_sat, &ret);
+	alvium_read(alvium, REG_BCRM_SATURATION_MAX_R, &max_sat, &ret);
+	alvium_read(alvium, REG_BCRM_SATURATION_INC_R, &inc_sat, &ret);
+	if (ret)
+		return ret;
+
+	alvium->dft_sat = dft_sat;
+	alvium->min_sat = min_sat;
+	alvium->max_sat = max_sat;
+	alvium->inc_sat = inc_sat;
+
+	return 0;
+}
+
+static int alvium_set_bcm_mode(struct alvium_dev *alvium)
+{
+	int ret = 0;
+
+	alvium_write(alvium, REG_GENCP_CHANGEMODE_W, ALVIUM_BCM_MODE, &ret);
+	alvium->bcrm_mode = ALVIUM_BCM_MODE;
+
+	return ret;
+}
+
+static int alvium_get_mode(struct alvium_dev *alvium)
+{
+	u64 bcrm_mode;
+	int ret;
+
+	ret = alvium_read(alvium, REG_GENCP_CURRENTMODE_R, &bcrm_mode, NULL);
+	if (ret)
+		return ret;
+
+	switch (bcrm_mode) {
+	case ALVIUM_BCM_MODE:
+		alvium->bcrm_mode = ALVIUM_BCM_MODE;
+		break;
+	case ALVIUM_GENCP_MODE:
+		alvium->bcrm_mode = ALVIUM_GENCP_MODE;
+		break;
+	}
+
+	return 0;
+}
+
+static int alvium_get_avail_mipi_data_format(struct alvium_dev *alvium)
+{
+	struct alvium_avail_mipi_fmt *avail_fmt;
+	u64 val;
+	int ret;
+
+	ret = alvium_read(alvium, REG_BCRM_IMG_AVAILABLE_MIPI_DATA_FORMATS_R,
+			  &val, NULL);
+	if (ret)
+		return ret;
+
+	avail_fmt = (struct alvium_avail_mipi_fmt *)&val;
+
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_8_LEG]
+				  = avail_fmt->yuv420_8_leg;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_8]
+				  = avail_fmt->yuv420_8;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_10]
+				  = avail_fmt->yuv420_10;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_8_CSPS]
+				  = avail_fmt->yuv420_8_csps;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_10_CSPS]
+				  = avail_fmt->yuv420_10_csps;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV422_8]
+				  = avail_fmt->yuv422_8;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV422_10]
+				  = avail_fmt->yuv422_10;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB888]
+				  = avail_fmt->rgb888;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB666]
+				  = avail_fmt->rgb666;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB565]
+				  = avail_fmt->rgb565;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB555]
+				  = avail_fmt->rgb555;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB444]
+				  = avail_fmt->rgb444;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW6]
+				  = avail_fmt->raw6;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW7]
+				  = avail_fmt->raw7;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW8]
+				  = avail_fmt->raw8;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW10]
+				  = avail_fmt->raw10;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW12]
+				  = avail_fmt->raw12;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW14]
+				  = avail_fmt->raw14;
+	alvium->is_mipi_fmt_avail[ALVIUM_BIT_JPEG]
+				  = avail_fmt->jpeg;
+
+	alvium_print_avail_mipi_fmt(alvium);
+
+	return 0;
+}
+
+static int alvium_setup_mipi_fmt(struct alvium_dev *alvium)
+{
+	unsigned int avail_fmt_cnt = 0;
+	unsigned int fmt = 0;
+	size_t sz = 0;
+
+	/* calculate fmt array size */
+	for (fmt = 0; fmt < ALVIUM_NUM_SUPP_MIPI_DATA_FMT; fmt++) {
+		if (!alvium->is_mipi_fmt_avail[alvium_csi2_fmts[fmt].fmt_av_bit])
+			continue;
+
+		if ((!alvium_csi2_fmts[fmt].is_raw) ||
+		    (alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit]))
+			sz++;
+	}
+
+	/* init alvium_csi2_fmt array */
+	alvium->alvium_csi2_fmt_n = sz;
+	alvium->alvium_csi2_fmt =
+		kmalloc_array(sz, sizeof(struct alvium_pixfmt), GFP_KERNEL);
+	if (!alvium->alvium_csi2_fmt)
+		return -ENOMEM;
+
+	/* Create the alvium_csi2 fmt array from formats available */
+	for (fmt = 0; fmt < ALVIUM_NUM_SUPP_MIPI_DATA_FMT; fmt++) {
+		if (!alvium->is_mipi_fmt_avail[alvium_csi2_fmts[fmt].fmt_av_bit])
+			continue;
+
+		if ((!alvium_csi2_fmts[fmt].is_raw) ||
+		    (alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit])) {
+			alvium->alvium_csi2_fmt[avail_fmt_cnt] = alvium_csi2_fmts[fmt];
+			avail_fmt_cnt++;
+		}
+	}
+
+	return 0;
+}
+
+static int alvium_set_mipi_fmt(struct alvium_dev *alvium,
+			       const struct alvium_pixfmt *pixfmt)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_write_hshake(alvium, REG_BCRM_IMG_MIPI_DATA_FORMAT_RW,
+				  pixfmt->mipi_fmt_regval);
+	if (ret) {
+		dev_err(dev, "Fail to set mipi fmt\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_get_avail_bayer(struct alvium_dev *alvium)
+{
+	struct alvium_avail_bayer *avail_bay;
+	u64 val;
+	int ret;
+
+	ret = alvium_read(alvium, REG_BCRM_IMG_BAYER_PATTERN_INQUIRY_R,
+			  &val, NULL);
+	if (ret)
+		return ret;
+
+	avail_bay = (struct alvium_avail_bayer *)&val;
+
+	alvium->is_bay_avail[ALVIUM_BIT_BAY_MONO] = avail_bay->mono;
+	alvium->is_bay_avail[ALVIUM_BIT_BAY_GR] = avail_bay->gr;
+	alvium->is_bay_avail[ALVIUM_BIT_BAY_RG] = avail_bay->rg;
+	alvium->is_bay_avail[ALVIUM_BIT_BAY_GB] = avail_bay->gb;
+	alvium->is_bay_avail[ALVIUM_BIT_BAY_BG] = avail_bay->bg;
+
+	alvium_print_avail_bayer(alvium);
+
+	return 0;
+}
+
+static int alvium_set_bayer_pattern(struct alvium_dev *alvium,
+				    const struct alvium_pixfmt *pixfmt)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_write_hshake(alvium, REG_BCRM_IMG_BAYER_PATTERN_RW,
+				  pixfmt->bay_fmt_regval);
+	if (ret) {
+		dev_err(dev, "Fail to set bayer pattern\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_get_frame_interval(struct alvium_dev *alvium)
+{
+	u64 dft_fr, min_fr, max_fr;
+	int ret = 0;
+
+	alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_RW,
+		    &dft_fr, &ret);
+	alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_MIN_R,
+		    &min_fr, &ret);
+	alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_MAX_R,
+		    &max_fr, &ret);
+	if (ret)
+		return ret;
+
+	alvium->dft_fr = dft_fr;
+	alvium->min_fr = min_fr;
+	alvium->max_fr = max_fr;
+
+	return 0;
+}
+
+static int alvium_set_frame_rate(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_write_hshake(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_RW,
+				  alvium->fr);
+	if (ret) {
+		dev_err(dev, "Fail to set frame rate lanes reg\n");
+		return ret;
+	}
+
+	dev_dbg(dev, "set frame rate: %llu us\n", alvium->fr);
+
+	return 0;
+}
+
+static int alvium_set_stream_mipi(struct alvium_dev *alvium, bool on)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_write_hshake(alvium, on ? REG_BCRM_ACQUISITION_START_RW :
+				  REG_BCRM_ACQUISITION_STOP_RW, 0x01);
+	if (ret) {
+		dev_err(dev, "Fail set_stream_mipi\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_get_gain(struct alvium_dev *alvium)
+{
+	u64 gain;
+	int ret;
+
+	/* The unit is millibel (1 mB = 0.01 dB) */
+	ret = alvium_read(alvium, REG_BCRM_GAIN_RW, &gain, NULL);
+	if (ret)
+		return ret;
+
+	return gain;
+}
+
+static int alvium_set_ctrl_gain(struct alvium_dev *alvium, int gain)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	/* The unit is millibel (1 mB = 0.01 dB) */
+	ret = alvium_write_hshake(alvium, REG_BCRM_GAIN_RW, (u64)gain);
+	if (ret) {
+		dev_err(dev, "Fail to set gain value reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_ctrl_auto_gain(struct alvium_dev *alvium, bool on)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_write_hshake(alvium, REG_BCRM_GAIN_AUTO_RW,
+				  on ? 0x02 : 0x00);
+	if (ret) {
+		dev_err(dev, "Fail to set autogain reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_get_exposure(struct alvium_dev *alvium)
+{
+	u64 exp;
+	int ret;
+
+	/* Exposure time in ns */
+	ret = alvium_read(alvium, REG_BCRM_EXPOSURE_TIME_RW, &exp, NULL);
+	if (ret)
+		return ret;
+
+	return exp;
+}
+
+static int alvium_set_ctrl_auto_exposure(struct alvium_dev *alvium, bool on)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_write_hshake(alvium, REG_BCRM_WHITE_BALANCE_AUTO_RW,
+				  on ? 0x02 : 0x00);
+	if (ret) {
+		dev_err(dev, "Fail to set autoexposure reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_ctrl_exposure(struct alvium_dev *alvium, int exposure_ns)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_write_hshake(alvium, REG_BCRM_EXPOSURE_TIME_RW,
+				  (u64)exposure_ns);
+	if (ret) {
+		dev_err(dev, "Fail to set exposure value reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_ctrl_blue_balance_ratio(struct alvium_dev *alvium, int blue)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_write_hshake(alvium, REG_BCRM_BLUE_BALANCE_RATIO_RW,
+				  (u64)blue);
+	if (ret) {
+		dev_err(dev, "Fail to set blue ratio value reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_ctrl_red_balance_ratio(struct alvium_dev *alvium, int red)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_write_hshake(alvium, REG_BCRM_RED_BALANCE_RATIO_RW,
+				  (u64)red);
+	if (ret) {
+		dev_err(dev, "Fail to set red ratio value reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_ctrl_awb(struct alvium_dev *alvium, bool on)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_write_hshake(alvium, REG_BCRM_WHITE_BALANCE_AUTO_RW,
+				  on ? 0x02 : 0x00);
+	if (ret) {
+		dev_err(dev, "Fail to set awb reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_ctrl_hue(struct alvium_dev *alvium, int val)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_write_hshake(alvium, REG_BCRM_HUE_RW, (u64)val);
+	if (ret) {
+		dev_err(dev, "Fail to set hue value reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_ctrl_contrast(struct alvium_dev *alvium, int val)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_write_hshake(alvium, REG_BCRM_CONTRAST_VALUE_RW, (u64)val);
+	if (ret) {
+		dev_err(dev, "Fail to set contrast value reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_ctrl_saturation(struct alvium_dev *alvium, int val)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_write_hshake(alvium, REG_BCRM_SATURATION_RW, (u64)val);
+	if (ret) {
+		dev_err(dev, "Fail to set contrast value reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_ctrl_gamma(struct alvium_dev *alvium, int val)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_write_hshake(alvium, REG_BCRM_GAMMA_RW, (u64)val);
+	if (ret) {
+		dev_err(dev, "Fail to set gamma value reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_ctrl_sharpness(struct alvium_dev *alvium, int val)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_write_hshake(alvium, REG_BCRM_SHARPNESS_RW, (u64)val);
+	if (ret) {
+		dev_err(dev, "Fail to set sharpness value reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_ctrl_hflip(struct alvium_dev *alvium, int val)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_write_hshake(alvium, REG_BCRM_IMG_REVERSE_X_RW, (u64)val);
+	if (ret) {
+		dev_err(dev, "Fail to set reverse_x value reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_set_ctrl_vflip(struct alvium_dev *alvium, int val)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_write_hshake(alvium, REG_BCRM_IMG_REVERSE_Y_RW, (u64)val);
+	if (ret) {
+		dev_err(dev, "Fail to set reverse_y value reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_get_hw_features_params(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_get_csi_clk_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read min/max csi clock regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_img_width_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read img width regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_img_height_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read img heigth regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_offx_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read offx regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_offy_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read offy regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_gain_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read gain regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_exposure_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read min/max exp regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_red_balance_ratio_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read red balance ratio regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_blue_balance_ratio_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read blue balance ratio regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_hue_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read hue regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_contrast_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read contrast regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_saturation_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read saturation regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_black_lvl_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read black lvl regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_gamma_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read gamma regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_sharpness_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read sharpness regs\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_get_hw_info(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	ret = alvium_get_bcrm_vers(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read bcrm version reg\n");
+		return ret;
+	}
+
+	ret = alvium_get_bcrm_addr(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to bcrm address reg\n");
+		return ret;
+	}
+
+	ret = alvium_get_fw_version(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read fw version reg\n");
+		return ret;
+	}
+
+	ret = alvium_get_host_supp_csi_lanes(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read host supported csi lanes reg\n");
+		return ret;
+	}
+
+	ret = alvium_get_feat_inq(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read bcrm feature inquiry reg\n");
+		return ret;
+	}
+
+	ret = alvium_get_hw_features_params(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read features params regs\n");
+		return ret;
+	}
+
+	ret = alvium_get_avail_mipi_data_format(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read available mipi data formats reg\n");
+		return ret;
+	}
+
+	ret = alvium_get_avail_bayer(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to read available Bayer patterns reg\n");
+		return ret;
+	}
+
+	ret = alvium_get_mode(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to get current mode reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_hw_init(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	int ret;
+
+	/* Set Alvium BCM mode*/
+	ret = alvium_set_bcm_mode(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to set BCM mode\n");
+		return ret;
+	}
+
+	ret = alvium_set_csi_lanes(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to set csi lanes\n");
+		return ret;
+	}
+
+	ret = alvium_set_csi_clk(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to set csi clk\n");
+		return ret;
+	}
+
+	ret = alvium_set_lp2hs_delay(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to set lp2hs reg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+/* --------------- Subdev Operations --------------- */
+
+static int alvium_g_frame_interval(struct v4l2_subdev *sd,
+				   struct v4l2_subdev_frame_interval *fi)
+{
+	struct alvium_dev *alvium = sd_to_alvium(sd);
+
+	fi->interval = alvium->frame_interval;
+
+	return 0;
+}
+
+static int alvium_set_frame_interval(struct alvium_dev *alvium,
+				     struct v4l2_subdev_frame_interval *fi)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	u64 req_fr, min_fr, max_fr;
+	int ret;
+
+	if (fi->interval.denominator == 0)
+		return -EINVAL;
+
+	ret = alvium_get_frame_interval(alvium);
+	if (ret) {
+		dev_err(dev, "Fail to get frame interval\n");
+		return ret;
+	}
+
+	min_fr = alvium->min_fr;
+	max_fr = alvium->max_fr;
+
+	dev_dbg(dev, "fi->interval.numerator = %d\n", fi->interval.numerator);
+	dev_dbg(dev, "fi->interval.denominator = %d\n", fi->interval.denominator);
+
+	req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
+		       fi->interval.numerator);
+
+	if (req_fr >= max_fr && req_fr <= min_fr)
+		req_fr = alvium->dft_fr;
+
+	alvium->fr = req_fr;
+	alvium->frame_interval.numerator = fi->interval.numerator;
+	alvium->frame_interval.denominator = fi->interval.denominator;
+
+	return 0;
+}
+
+static int alvium_s_frame_interval(struct v4l2_subdev *sd,
+				   struct v4l2_subdev_frame_interval *fi)
+{
+	struct alvium_dev *alvium = sd_to_alvium(sd);
+	struct v4l2_subdev_state *state;
+	int ret;
+
+	if (alvium->streaming)
+		return -EBUSY;
+
+	state = v4l2_subdev_lock_and_get_active_state(sd);
+
+	ret = alvium_set_frame_interval(alvium, fi);
+	if (!ret)
+		ret = alvium_set_frame_rate(alvium);
+
+	v4l2_subdev_unlock_state(state);
+
+	return ret;
+}
+
+static int alvium_enum_mbus_code(struct v4l2_subdev *sd,
+				 struct v4l2_subdev_state *sd_state,
+				 struct v4l2_subdev_mbus_code_enum *code)
+{
+	struct alvium_dev *alvium = sd_to_alvium(sd);
+
+	if (code->index >= alvium->alvium_csi2_fmt_n)
+		return -EINVAL;
+
+	code->code = alvium->alvium_csi2_fmt[code->index].code;
+
+	return 0;
+}
+
+static const struct alvium_pixfmt *
+alvium_code_to_pixfmt(struct alvium_dev *alvium, u32 code)
+{
+	unsigned int i;
+
+	for (i = 0; alvium->alvium_csi2_fmt[i].code; ++i)
+		if (alvium->alvium_csi2_fmt[i].code == code)
+			return &alvium->alvium_csi2_fmt[i];
+
+	return &alvium->alvium_csi2_fmt[0];
+}
+
+static int alvium_set_mode(struct alvium_dev *alvium,
+			   struct v4l2_subdev_state *state)
+{
+	struct v4l2_mbus_framefmt *fmt;
+	struct v4l2_rect *crop;
+	int ret;
+
+	crop = v4l2_subdev_state_get_crop(state, 0);
+	fmt = v4l2_subdev_state_get_format(state, 0);
+
+	v4l_bound_align_image(&fmt->width, alvium->img_min_width,
+			      alvium->img_max_width, 0,
+			      &fmt->height, alvium->img_min_height,
+			      alvium->img_max_height, 0, 0);
+
+	/* alvium don't accept negative crop left/top */
+	crop->left = clamp((u32)max(0, crop->left), alvium->min_offx,
+			   (u32)(alvium->img_max_width - fmt->width));
+	crop->top = clamp((u32)max(0, crop->top), alvium->min_offy,
+			  (u32)(alvium->img_max_height - fmt->height));
+
+	ret = alvium_set_img_width(alvium, fmt->width);
+	if (ret)
+		return ret;
+
+	ret = alvium_set_img_height(alvium, fmt->height);
+	if (ret)
+		return ret;
+
+	ret = alvium_set_img_offx(alvium, crop->left);
+	if (ret)
+		return ret;
+
+	ret = alvium_set_img_offy(alvium, crop->top);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int alvium_set_framefmt(struct alvium_dev *alvium,
+			       struct v4l2_mbus_framefmt *format)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	const struct alvium_pixfmt *alvium_csi2_fmt;
+	int ret = 0;
+
+	alvium_csi2_fmt = alvium_code_to_pixfmt(alvium, format->code);
+
+	ret = alvium_set_mipi_fmt(alvium, alvium_csi2_fmt);
+	if (ret)
+		return ret;
+
+	if (alvium_csi2_fmt->is_raw) {
+		ret = alvium_set_bayer_pattern(alvium, alvium_csi2_fmt);
+		if (ret)
+			return ret;
+	}
+
+	dev_dbg(dev, "start: %s, mipi_fmt_regval regval = 0x%llx",
+		__func__, alvium_csi2_fmt->mipi_fmt_regval);
+
+	return ret;
+}
+
+static int alvium_s_stream(struct v4l2_subdev *sd, int enable)
+{
+	struct alvium_dev *alvium = sd_to_alvium(sd);
+	struct i2c_client *client = v4l2_get_subdevdata(&alvium->sd);
+	struct v4l2_mbus_framefmt *fmt;
+	struct v4l2_subdev_state *state;
+	int ret = 0;
+
+	state = v4l2_subdev_lock_and_get_active_state(sd);
+
+	if (enable) {
+		ret = pm_runtime_resume_and_get(&client->dev);
+		if (ret < 0)
+			goto out;
+
+		ret = __v4l2_ctrl_handler_setup(&alvium->ctrls.handler);
+		if (ret)
+			goto out;
+
+		ret = alvium_set_mode(alvium, state);
+		if (ret)
+			goto out;
+
+		fmt = v4l2_subdev_state_get_format(state, 0);
+		ret = alvium_set_framefmt(alvium, fmt);
+		if (ret)
+			goto out;
+
+		ret = alvium_set_stream_mipi(alvium, enable);
+		if (ret)
+			goto out;
+
+	} else {
+		alvium_set_stream_mipi(alvium, enable);
+		pm_runtime_mark_last_busy(&client->dev);
+		pm_runtime_put_autosuspend(&client->dev);
+	}
+
+	alvium->streaming = !!enable;
+	v4l2_subdev_unlock_state(state);
+
+	return 0;
+
+out:
+	pm_runtime_put(&client->dev);
+	v4l2_subdev_unlock_state(state);
+	return ret;
+}
+
+static int alvium_init_state(struct v4l2_subdev *sd,
+			     struct v4l2_subdev_state *state)
+{
+	struct alvium_dev *alvium = sd_to_alvium(sd);
+	struct alvium_mode *mode = &alvium->mode;
+	struct v4l2_subdev_format sd_fmt = {
+		.which = V4L2_SUBDEV_FORMAT_TRY,
+		.format = alvium_csi2_default_fmt,
+	};
+	struct v4l2_subdev_crop sd_crop = {
+		.which = V4L2_SUBDEV_FORMAT_TRY,
+		.rect = {
+			.left = mode->crop.left,
+			.top = mode->crop.top,
+			.width = mode->crop.width,
+			.height = mode->crop.height,
+		},
+	};
+
+	*v4l2_subdev_state_get_crop(state, 0) = sd_crop.rect;
+	*v4l2_subdev_state_get_format(state, 0) = sd_fmt.format;
+
+	return 0;
+}
+
+static int alvium_set_fmt(struct v4l2_subdev *sd,
+			  struct v4l2_subdev_state *sd_state,
+			  struct v4l2_subdev_format *format)
+{
+	struct alvium_dev *alvium = sd_to_alvium(sd);
+	const struct alvium_pixfmt *alvium_csi2_fmt;
+	struct v4l2_mbus_framefmt *fmt;
+	struct v4l2_rect *crop;
+
+	fmt = v4l2_subdev_state_get_format(sd_state, 0);
+	crop = v4l2_subdev_state_get_crop(sd_state, 0);
+
+	v4l_bound_align_image(&format->format.width, alvium->img_min_width,
+			      alvium->img_max_width, 0,
+			      &format->format.height, alvium->img_min_height,
+			      alvium->img_max_height, 0, 0);
+
+	/* Adjust left and top to prevent roll over sensor area */
+	crop->left = clamp((u32)crop->left, (u32)0,
+			   (alvium->img_max_width - fmt->width));
+	crop->top = clamp((u32)crop->top, (u32)0,
+			  (alvium->img_max_height - fmt->height));
+
+	/* Set also the crop width and height when set a new fmt */
+	crop->width = fmt->width;
+	crop->height = fmt->height;
+
+	alvium_csi2_fmt = alvium_code_to_pixfmt(alvium, format->format.code);
+	fmt->code = alvium_csi2_fmt->code;
+
+	*fmt = format->format;
+
+	return 0;
+}
+
+static int alvium_set_selection(struct v4l2_subdev *sd,
+				struct v4l2_subdev_state *sd_state,
+				struct v4l2_subdev_selection *sel)
+{
+	struct alvium_dev *alvium = sd_to_alvium(sd);
+	struct v4l2_mbus_framefmt *fmt;
+	struct v4l2_rect *crop;
+
+	if (sel->target != V4L2_SEL_TGT_CROP)
+		return -EINVAL;
+
+	crop = v4l2_subdev_state_get_crop(sd_state, 0);
+	fmt = v4l2_subdev_state_get_format(sd_state, 0);
+
+	/*
+	 * Alvium can only shift the origin of the img
+	 * then we accept only value with the same value of the actual fmt
+	 */
+	if (sel->r.width != fmt->width)
+		sel->r.width = fmt->width;
+
+	if (sel->r.height != fmt->height)
+		sel->r.height = fmt->height;
+
+	/* alvium don't accept negative crop left/top */
+	crop->left = clamp((u32)max(0, sel->r.left), alvium->min_offx,
+			   alvium->img_max_width - sel->r.width);
+	crop->top = clamp((u32)max(0, sel->r.top), alvium->min_offy,
+			  alvium->img_max_height - sel->r.height);
+
+	sel->r = *crop;
+
+	return 0;
+}
+
+static int alvium_get_selection(struct v4l2_subdev *sd,
+				struct v4l2_subdev_state *sd_state,
+				struct v4l2_subdev_selection *sel)
+{
+	struct alvium_dev *alvium = sd_to_alvium(sd);
+
+	switch (sel->target) {
+	/* Current cropping area */
+	case V4L2_SEL_TGT_CROP:
+		sel->r = *v4l2_subdev_state_get_crop(sd_state, 0);
+		break;
+	/* Cropping bounds */
+	case V4L2_SEL_TGT_NATIVE_SIZE:
+		sel->r.top = 0;
+		sel->r.left = 0;
+		sel->r.width = alvium->img_max_width;
+		sel->r.height = alvium->img_max_height;
+		break;
+	/* Default cropping area */
+	case V4L2_SEL_TGT_CROP_BOUNDS:
+	case V4L2_SEL_TGT_CROP_DEFAULT:
+		sel->r.top = alvium->min_offy;
+		sel->r.left = alvium->min_offx;
+		sel->r.width = alvium->img_max_width;
+		sel->r.height = alvium->img_max_height;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int alvium_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct v4l2_subdev *sd = ctrl_to_sd(ctrl);
+	struct alvium_dev *alvium = sd_to_alvium(sd);
+	int val;
+
+	switch (ctrl->id) {
+	case V4L2_CID_GAIN:
+		val = alvium_get_gain(alvium);
+		if (val < 0)
+			return val;
+		alvium->ctrls.gain->val = val;
+		break;
+	case V4L2_CID_EXPOSURE:
+		val = alvium_get_exposure(alvium);
+		if (val < 0)
+			return val;
+		alvium->ctrls.exposure->val = val;
+		break;
+	}
+
+	return 0;
+}
+
+static int alvium_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct v4l2_subdev *sd = ctrl_to_sd(ctrl);
+	struct alvium_dev *alvium = sd_to_alvium(sd);
+	struct i2c_client *client = v4l2_get_subdevdata(&alvium->sd);
+	int ret;
+
+	/*
+	 * Applying V4L2 control value only happens
+	 * when power is up for streaming
+	 */
+	if (!pm_runtime_get_if_in_use(&client->dev))
+		return 0;
+
+	switch (ctrl->id) {
+	case V4L2_CID_GAIN:
+		ret = alvium_set_ctrl_gain(alvium, ctrl->val);
+		break;
+	case V4L2_CID_AUTOGAIN:
+		ret = alvium_set_ctrl_auto_gain(alvium, ctrl->val);
+		break;
+	case V4L2_CID_EXPOSURE:
+		ret = alvium_set_ctrl_exposure(alvium, ctrl->val);
+		break;
+	case V4L2_CID_EXPOSURE_AUTO:
+		ret = alvium_set_ctrl_auto_exposure(alvium, ctrl->val);
+		break;
+	case V4L2_CID_RED_BALANCE:
+		ret = alvium_set_ctrl_red_balance_ratio(alvium, ctrl->val);
+		break;
+	case V4L2_CID_BLUE_BALANCE:
+		ret = alvium_set_ctrl_blue_balance_ratio(alvium, ctrl->val);
+		break;
+	case V4L2_CID_AUTO_WHITE_BALANCE:
+		ret = alvium_set_ctrl_awb(alvium, ctrl->val);
+		break;
+	case V4L2_CID_HUE:
+		ret = alvium_set_ctrl_hue(alvium, ctrl->val);
+		break;
+	case V4L2_CID_CONTRAST:
+		ret = alvium_set_ctrl_contrast(alvium, ctrl->val);
+		break;
+	case V4L2_CID_SATURATION:
+		ret = alvium_set_ctrl_saturation(alvium, ctrl->val);
+		break;
+	case V4L2_CID_GAMMA:
+		ret = alvium_set_ctrl_gamma(alvium, ctrl->val);
+		break;
+	case V4L2_CID_SHARPNESS:
+		ret = alvium_set_ctrl_sharpness(alvium, ctrl->val);
+		break;
+	case V4L2_CID_HFLIP:
+		ret = alvium_set_ctrl_hflip(alvium, ctrl->val);
+		break;
+	case V4L2_CID_VFLIP:
+		ret = alvium_set_ctrl_vflip(alvium, ctrl->val);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	pm_runtime_put(&client->dev);
+
+	return ret;
+}
+
+static const struct v4l2_ctrl_ops alvium_ctrl_ops = {
+	.g_volatile_ctrl = alvium_g_volatile_ctrl,
+	.s_ctrl = alvium_s_ctrl,
+};
+
+static int alvium_ctrl_init(struct alvium_dev *alvium)
+{
+	const struct v4l2_ctrl_ops *ops = &alvium_ctrl_ops;
+	struct alvium_ctrls *ctrls = &alvium->ctrls;
+	struct v4l2_ctrl_handler *hdl = &ctrls->handler;
+	struct v4l2_fwnode_device_properties props;
+	int ret;
+
+	v4l2_ctrl_handler_init(hdl, 32);
+
+	/* Pixel rate is fixed */
+	ctrls->pixel_rate = v4l2_ctrl_new_std(hdl, ops,
+					      V4L2_CID_PIXEL_RATE, 0,
+					      ALVIUM_DEFAULT_PIXEL_RATE_MHZ, 1,
+					      ALVIUM_DEFAULT_PIXEL_RATE_MHZ);
+	ctrls->pixel_rate->flags |= V4L2_CTRL_FLAG_READ_ONLY;
+
+	/* Link freq is fixed */
+	ctrls->link_freq = v4l2_ctrl_new_int_menu(hdl, ops,
+						  V4L2_CID_LINK_FREQ,
+						  0, 0, &alvium->link_freq);
+	ctrls->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
+
+	/* Auto/manual white balance */
+	if (alvium->avail_ft.auto_whiteb) {
+		ctrls->auto_wb = v4l2_ctrl_new_std(hdl, ops,
+						   V4L2_CID_AUTO_WHITE_BALANCE,
+						   0, 1, 1, 1);
+		v4l2_ctrl_auto_cluster(3, &ctrls->auto_wb, 0, false);
+	}
+
+	ctrls->blue_balance = v4l2_ctrl_new_std(hdl, ops,
+						V4L2_CID_BLUE_BALANCE,
+						alvium->min_bbalance,
+						alvium->max_bbalance,
+						alvium->inc_bbalance,
+						alvium->dft_bbalance);
+	ctrls->red_balance = v4l2_ctrl_new_std(hdl, ops,
+					       V4L2_CID_RED_BALANCE,
+					       alvium->min_rbalance,
+					       alvium->max_rbalance,
+					       alvium->inc_rbalance,
+					       alvium->dft_rbalance);
+
+	/* Auto/manual exposure */
+	if (alvium->avail_ft.auto_exp) {
+		ctrls->auto_exp = v4l2_ctrl_new_std_menu(hdl, ops,
+							 V4L2_CID_EXPOSURE_AUTO,
+							 V4L2_EXPOSURE_MANUAL, 0,
+							 V4L2_EXPOSURE_AUTO);
+		v4l2_ctrl_auto_cluster(2, &ctrls->auto_exp, 1, true);
+	}
+
+	ctrls->exposure = v4l2_ctrl_new_std(hdl, ops,
+					    V4L2_CID_EXPOSURE,
+					    alvium->min_exp,
+					    alvium->max_exp,
+					    alvium->inc_exp,
+					    alvium->dft_exp);
+	ctrls->exposure->flags |= V4L2_CTRL_FLAG_VOLATILE;
+
+	/* Auto/manual gain */
+	if (alvium->avail_ft.auto_gain) {
+		ctrls->auto_gain = v4l2_ctrl_new_std(hdl, ops,
+						     V4L2_CID_AUTOGAIN,
+						     0, 1, 1, 1);
+		v4l2_ctrl_auto_cluster(2, &ctrls->auto_gain, 0, true);
+	}
+
+	if (alvium->avail_ft.gain) {
+		ctrls->gain = v4l2_ctrl_new_std(hdl, ops,
+						V4L2_CID_GAIN,
+						alvium->min_gain,
+						alvium->max_gain,
+						alvium->inc_gain,
+						alvium->dft_gain);
+		ctrls->gain->flags |= V4L2_CTRL_FLAG_VOLATILE;
+	}
+
+	if (alvium->avail_ft.sat)
+		ctrls->saturation = v4l2_ctrl_new_std(hdl, ops,
+						      V4L2_CID_SATURATION,
+						      alvium->min_sat,
+						      alvium->max_sat,
+						      alvium->inc_sat,
+						      alvium->dft_sat);
+
+	if (alvium->avail_ft.hue)
+		ctrls->hue = v4l2_ctrl_new_std(hdl, ops,
+					       V4L2_CID_HUE,
+					       alvium->min_hue,
+					       alvium->max_hue,
+					       alvium->inc_hue,
+					       alvium->dft_hue);
+
+	if (alvium->avail_ft.contrast)
+		ctrls->contrast = v4l2_ctrl_new_std(hdl, ops,
+						    V4L2_CID_CONTRAST,
+						    alvium->min_contrast,
+						    alvium->max_contrast,
+						    alvium->inc_contrast,
+						    alvium->dft_contrast);
+
+	if (alvium->avail_ft.gamma)
+		ctrls->gamma = v4l2_ctrl_new_std(hdl, ops,
+						 V4L2_CID_GAMMA,
+						 alvium->min_gamma,
+						 alvium->max_gamma,
+						 alvium->inc_gamma,
+						 alvium->dft_gamma);
+
+	if (alvium->avail_ft.sharp)
+		ctrls->sharpness = v4l2_ctrl_new_std(hdl, ops,
+						     V4L2_CID_SHARPNESS,
+						     alvium->min_sharp,
+						     alvium->max_sharp,
+						     alvium->inc_sharp,
+						     alvium->dft_sharp);
+
+	if (alvium->avail_ft.rev_x)
+		ctrls->hflip = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_HFLIP, 0, 1, 1, 0);
+
+	if (alvium->avail_ft.rev_y)
+		ctrls->vflip = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_VFLIP, 0, 1, 1, 0);
+
+	if (hdl->error) {
+		ret = hdl->error;
+		goto free_ctrls;
+	}
+
+	ret = v4l2_fwnode_device_parse(&alvium->i2c_client->dev, &props);
+	if (ret)
+		goto free_ctrls;
+
+	ret = v4l2_ctrl_new_fwnode_properties(hdl, ops, &props);
+	if (ret)
+		goto free_ctrls;
+
+	alvium->sd.ctrl_handler = hdl;
+	return 0;
+
+free_ctrls:
+	v4l2_ctrl_handler_free(hdl);
+	return ret;
+}
+
+static const struct v4l2_subdev_core_ops alvium_core_ops = {
+	.log_status = v4l2_ctrl_subdev_log_status,
+	.subscribe_event = v4l2_ctrl_subdev_subscribe_event,
+	.unsubscribe_event = v4l2_event_subdev_unsubscribe,
+};
+
+static const struct v4l2_subdev_video_ops alvium_video_ops = {
+	.g_frame_interval	= alvium_g_frame_interval,
+	.s_frame_interval	= alvium_s_frame_interval,
+	.s_stream		= alvium_s_stream,
+};
+
+static const struct v4l2_subdev_pad_ops alvium_pad_ops = {
+	.enum_mbus_code = alvium_enum_mbus_code,
+	.get_fmt = v4l2_subdev_get_fmt,
+	.set_fmt = alvium_set_fmt,
+	.get_selection = alvium_get_selection,
+	.set_selection = alvium_set_selection,
+};
+
+static const struct v4l2_subdev_internal_ops alvium_internal_ops = {
+	.init_state = alvium_init_state,
+};
+
+static const struct v4l2_subdev_ops alvium_subdev_ops = {
+	.core	= &alvium_core_ops,
+	.pad	= &alvium_pad_ops,
+	.video	= &alvium_video_ops,
+};
+
+static int alvium_subdev_init(struct alvium_dev *alvium)
+{
+	struct i2c_client *client = alvium->i2c_client;
+	struct device *dev = &alvium->i2c_client->dev;
+	struct v4l2_subdev *sd = &alvium->sd;
+	int ret;
+
+	/* Setup initial frame interval*/
+	alvium->frame_interval.numerator = 1;
+	alvium->frame_interval.denominator = ALVIUM_DEFAULT_FR_HZ;
+	alvium->fr = ALVIUM_DEFAULT_FR_HZ;
+
+	/* Setup the initial mode */
+	alvium->mode.fmt = alvium_csi2_default_fmt;
+	alvium->mode.width = alvium_csi2_default_fmt.width;
+	alvium->mode.height = alvium_csi2_default_fmt.height;
+	alvium->mode.crop.left = alvium->min_offx;
+	alvium->mode.crop.top = alvium->min_offy;
+	alvium->mode.crop.width = alvium_csi2_default_fmt.width;
+	alvium->mode.crop.height = alvium_csi2_default_fmt.height;
+
+	/* init alvium sd */
+	v4l2_i2c_subdev_init(sd, client, &alvium_subdev_ops);
+
+	sd->internal_ops = &alvium_internal_ops;
+	sd->flags |= V4L2_SUBDEV_FL_HAS_EVENTS | V4L2_SUBDEV_FL_HAS_DEVNODE;
+	alvium->pad.flags = MEDIA_PAD_FL_SOURCE;
+	sd->entity.function = MEDIA_ENT_F_CAM_SENSOR;
+
+	ret = media_entity_pads_init(&sd->entity, 1, &alvium->pad);
+	if (ret) {
+		dev_err(dev, "Could not register media entity\n");
+		return ret;
+	}
+
+	ret = alvium_ctrl_init(alvium);
+	if (ret) {
+		dev_err(dev, "Control initialization error %d\n", ret);
+		goto entity_cleanup;
+	}
+
+	alvium->sd.state_lock = alvium->ctrls.handler.lock;
+
+	ret = v4l2_subdev_init_finalize(sd);
+	if (ret < 0) {
+		dev_err(dev, "subdev initialization error %d\n", ret);
+		goto err_ctrls;
+	}
+
+	return 0;
+
+err_ctrls:
+	v4l2_ctrl_handler_free(&alvium->ctrls.handler);
+entity_cleanup:
+	media_entity_cleanup(&alvium->sd.entity);
+	return ret;
+}
+
+static void alvium_subdev_cleanup(struct alvium_dev *alvium)
+{
+	v4l2_fwnode_endpoint_free(&alvium->ep);
+	v4l2_subdev_cleanup(&alvium->sd);
+	media_entity_cleanup(&alvium->sd.entity);
+	v4l2_ctrl_handler_free(&alvium->ctrls.handler);
+}
+
+static int alvium_get_dt_data(struct alvium_dev *alvium)
+{
+	struct device *dev = &alvium->i2c_client->dev;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	struct fwnode_handle *endpoint;
+
+	if (!fwnode)
+		return -EINVAL;
+
+	/* Only CSI2 is supported for now: */
+	alvium->ep.bus_type = V4L2_MBUS_CSI2_DPHY;
+
+	endpoint = fwnode_graph_get_endpoint_by_id(fwnode, 0, 0, 0);
+	if (!endpoint) {
+		dev_err(dev, "endpoint node not found\n");
+		return -EINVAL;
+	}
+
+	if (v4l2_fwnode_endpoint_alloc_parse(endpoint, &alvium->ep)) {
+		dev_err(dev, "could not parse endpoint\n");
+		goto error_out;
+	}
+
+	if (!alvium->ep.nr_of_link_frequencies) {
+		dev_err(dev, "no link frequencies defined");
+		goto error_out;
+	}
+
+	return 0;
+
+error_out:
+	v4l2_fwnode_endpoint_free(&alvium->ep);
+	fwnode_handle_put(endpoint);
+
+	return -EINVAL;
+}
+
+static int alvium_set_power(struct alvium_dev *alvium, bool on)
+{
+	int ret;
+
+	if (!on)
+		return regulator_disable(alvium->reg_vcc);
+
+	ret = regulator_enable(alvium->reg_vcc);
+	if (ret)
+		return ret;
+
+	/* alvium boot time 7s */
+	msleep(7000);
+	return 0;
+}
+
+static int alvium_runtime_resume(struct device *dev)
+{
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
+	struct alvium_dev *alvium = sd_to_alvium(sd);
+	int ret;
+
+	ret = alvium_set_power(alvium, true);
+	if (ret)
+		return ret;
+
+	ret = alvium_hw_init(alvium);
+	if (ret) {
+		alvium_set_power(alvium, false);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int alvium_runtime_suspend(struct device *dev)
+{
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
+	struct alvium_dev *alvium = sd_to_alvium(sd);
+
+	alvium_set_power(alvium, false);
+
+	return 0;
+}
+
+static const struct dev_pm_ops alvium_pm_ops = {
+	RUNTIME_PM_OPS(alvium_runtime_suspend, alvium_runtime_resume, NULL)
+};
+
+static int alvium_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct alvium_dev *alvium;
+	int ret;
+
+	alvium = devm_kzalloc(dev, sizeof(*alvium), GFP_KERNEL);
+	if (!alvium)
+		return -ENOMEM;
+
+	alvium->i2c_client = client;
+
+	alvium->regmap = devm_cci_regmap_init_i2c(client, 16);
+	if (IS_ERR(alvium->regmap))
+		return PTR_ERR(alvium->regmap);
+
+	ret = alvium_get_dt_data(alvium);
+	if (ret)
+		return ret;
+
+	alvium->reg_vcc = devm_regulator_get_optional(dev, "vcc-ext-in");
+	if (IS_ERR(alvium->reg_vcc))
+		return dev_err_probe(dev, PTR_ERR(alvium->reg_vcc),
+				     "no vcc-ext-in regulator provided\n");
+
+	ret = alvium_set_power(alvium, true);
+	if (ret)
+		goto err_powerdown;
+
+	if (!alvium_is_alive(alvium)) {
+		dev_err_probe(dev, ret, "Device detection failed\n");
+		ret = -ENODEV;
+		goto err_powerdown;
+	}
+
+	ret = alvium_get_hw_info(alvium);
+	if (ret) {
+		dev_err_probe(dev, ret, "get_hw_info fail\n");
+		goto err_powerdown;
+	}
+
+	ret = alvium_hw_init(alvium);
+	if (ret) {
+		dev_err_probe(dev, ret, "hw_init fail\n");
+		goto err_powerdown;
+	}
+
+	ret = alvium_setup_mipi_fmt(alvium);
+	if (ret) {
+		dev_err_probe(dev, ret, "setup_mipi_fmt fail\n");
+		goto err_powerdown;
+	}
+
+	/*
+	 * Enable runtime PM without autosuspend:
+	 *
+	 * Don't use pm autosuspend (alvium have ~7s boot time).
+	 * Alvium has been powered manually:
+	 *  - mark it as active
+	 *  - increase the usage count without resuming the device.
+	 */
+	pm_runtime_set_active(dev);
+	pm_runtime_get_noresume(dev);
+	pm_runtime_enable(dev);
+
+	/* Initialize the V4L2 subdev. */
+	ret = alvium_subdev_init(alvium);
+	if (ret)
+		goto err_pm;
+
+	ret = v4l2_async_register_subdev(&alvium->sd);
+	if (ret < 0) {
+		dev_err_probe(dev, ret, "Could not register v4l2 device\n");
+		goto err_subdev;
+	}
+
+	return 0;
+
+err_subdev:
+	alvium_subdev_cleanup(alvium);
+err_pm:
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
+	kfree(alvium->alvium_csi2_fmt);
+err_powerdown:
+	alvium_set_power(alvium, false);
+
+	return ret;
+}
+
+static void alvium_remove(struct i2c_client *client)
+{
+	struct v4l2_subdev *sd = i2c_get_clientdata(client);
+	struct alvium_dev *alvium = sd_to_alvium(sd);
+	struct device *dev = &alvium->i2c_client->dev;
+
+	v4l2_async_unregister_subdev(sd);
+	alvium_subdev_cleanup(alvium);
+	kfree(alvium->alvium_csi2_fmt);
+	/*
+	 * Disable runtime PM. In case runtime PM is disabled in the kernel,
+	 * make sure to turn power off manually.
+	 */
+	pm_runtime_disable(dev);
+	if (!pm_runtime_status_suspended(dev))
+		alvium_set_power(alvium, false);
+	pm_runtime_set_suspended(dev);
+}
+
+static const struct of_device_id alvium_of_ids[] = {
+	{ .compatible = "alliedvision,alvium-csi2", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, alvium_of_ids);
+
+static struct i2c_driver alvium_i2c_driver = {
+	.driver = {
+		.name = "alvium-csi2",
+		.pm = pm_ptr(&alvium_pm_ops),
+		.of_match_table = alvium_of_ids,
+	},
+	.probe = alvium_probe,
+	.remove = alvium_remove,
+};
+
+module_i2c_driver(alvium_i2c_driver);
+
+MODULE_DESCRIPTION("Allied Vision's Alvium Camera Driver");
+MODULE_AUTHOR("Tommaso Merciai <tomm.merciai@gmail.com>");
+MODULE_AUTHOR("Martin Hecht <martin.hecht@avnet.eu>");
+MODULE_AUTHOR("Avnet Silica Software & Services EMEA");
+MODULE_LICENSE("GPL");
diff --git a/drivers/media/i2c/alvium-csi2.h b/drivers/media/i2c/alvium-csi2.h
new file mode 100644
index 000000000000..8b554bffdc39
--- /dev/null
+++ b/drivers/media/i2c/alvium-csi2.h
@@ -0,0 +1,475 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Allied Vision Technologies GmbH Alvium camera driver
+ *
+ * Copyright (C) 2023 Tommaso Merciai
+ * Copyright (C) 2023 Martin Hecht
+ * Copyright (C) 2023 Avnet EMG GmbH
+ */
+
+#ifndef ALVIUM_CSI2_H_
+#define ALVIUM_CSI2_H_
+
+#include <linux/kernel.h>
+#include <linux/regulator/consumer.h>
+#include <media/v4l2-cci.h>
+#include <media/v4l2-common.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-fwnode.h>
+#include <media/v4l2-subdev.h>
+
+#define REG_BCRM_V4L2					BIT(31)
+
+#define REG_BCRM_V4L2_8BIT(n)				(REG_BCRM_V4L2 | CCI_REG8(n))
+#define REG_BCRM_V4L2_16BIT(n)				(REG_BCRM_V4L2 | CCI_REG16(n))
+#define REG_BCRM_V4L2_32BIT(n)				(REG_BCRM_V4L2 | CCI_REG32(n))
+#define REG_BCRM_V4L2_64BIT(n)				(REG_BCRM_V4L2 | CCI_REG64(n))
+
+/* Basic Control Register Map register offsets (BCRM) */
+#define REG_BCRM_MINOR_VERSION_R			CCI_REG16(0x0000)
+#define REG_BCRM_MAJOR_VERSION_R			CCI_REG16(0x0002)
+#define REG_BCRM_REG_ADDR_R				CCI_REG16(0x0014)
+
+#define REG_BCRM_FEATURE_INQUIRY_R			REG_BCRM_V4L2_64BIT(0x0008)
+#define REG_BCRM_DEVICE_FW_SPEC_VERSION_R		REG_BCRM_V4L2_8BIT(0x0010)
+#define REG_BCRM_DEVICE_FW_MAJOR_VERSION_R		REG_BCRM_V4L2_8BIT(0x0011)
+#define REG_BCRM_DEVICE_FW_MINOR_VERSION_R		REG_BCRM_V4L2_16BIT(0x0012)
+#define REG_BCRM_DEVICE_FW_PATCH_VERSION_R		REG_BCRM_V4L2_32BIT(0x0014)
+#define REG_BCRM_WRITE_HANDSHAKE_RW			REG_BCRM_V4L2_8BIT(0x0018)
+
+/* Streaming Control Registers */
+#define REG_BCRM_SUPPORTED_CSI2_LANE_COUNTS_R		REG_BCRM_V4L2_8BIT(0x0040)
+#define REG_BCRM_CSI2_LANE_COUNT_RW			REG_BCRM_V4L2_8BIT(0x0044)
+#define REG_BCRM_CSI2_CLOCK_MIN_R			REG_BCRM_V4L2_32BIT(0x0048)
+#define REG_BCRM_CSI2_CLOCK_MAX_R			REG_BCRM_V4L2_32BIT(0x004c)
+#define REG_BCRM_CSI2_CLOCK_RW				REG_BCRM_V4L2_32BIT(0x0050)
+#define REG_BCRM_BUFFER_SIZE_R				REG_BCRM_V4L2_32BIT(0x0054)
+
+#define REG_BCRM_IPU_X_MIN_W				REG_BCRM_V4L2_32BIT(0x0058)
+#define REG_BCRM_IPU_X_MAX_W				REG_BCRM_V4L2_32BIT(0x005c)
+#define REG_BCRM_IPU_X_INC_W				REG_BCRM_V4L2_32BIT(0x0060)
+#define REG_BCRM_IPU_Y_MIN_W				REG_BCRM_V4L2_32BIT(0x0064)
+#define REG_BCRM_IPU_Y_MAX_W				REG_BCRM_V4L2_32BIT(0x0068)
+#define REG_BCRM_IPU_Y_INC_W				REG_BCRM_V4L2_32BIT(0x006c)
+#define REG_BCRM_IPU_X_R				REG_BCRM_V4L2_32BIT(0x0070)
+#define REG_BCRM_IPU_Y_R				REG_BCRM_V4L2_32BIT(0x0074)
+
+#define REG_BCRM_PHY_RESET_RW				REG_BCRM_V4L2_8BIT(0x0078)
+#define REG_BCRM_LP2HS_DELAY_RW				REG_BCRM_V4L2_32BIT(0x007c)
+
+/* Acquisition Control Registers */
+#define REG_BCRM_ACQUISITION_START_RW			REG_BCRM_V4L2_8BIT(0x0080)
+#define REG_BCRM_ACQUISITION_STOP_RW			REG_BCRM_V4L2_8BIT(0x0084)
+#define REG_BCRM_ACQUISITION_ABORT_RW			REG_BCRM_V4L2_8BIT(0x0088)
+#define REG_BCRM_ACQUISITION_STATUS_R			REG_BCRM_V4L2_8BIT(0x008c)
+#define REG_BCRM_ACQUISITION_FRAME_RATE_RW		REG_BCRM_V4L2_64BIT(0x0090)
+#define REG_BCRM_ACQUISITION_FRAME_RATE_MIN_R		REG_BCRM_V4L2_64BIT(0x0098)
+#define REG_BCRM_ACQUISITION_FRAME_RATE_MAX_R		REG_BCRM_V4L2_64BIT(0x00a0)
+#define REG_BCRM_ACQUISITION_FRAME_RATE_INC_R		REG_BCRM_V4L2_64BIT(0x00a8)
+#define REG_BCRM_ACQUISITION_FRAME_RATE_ENABLE_RW	REG_BCRM_V4L2_8BIT(0x00b0)
+
+#define REG_BCRM_FRAME_START_TRIGGER_MODE_RW		REG_BCRM_V4L2_8BIT(0x00b4)
+#define REG_BCRM_FRAME_START_TRIGGER_SOURCE_RW		REG_BCRM_V4L2_8BIT(0x00b8)
+#define REG_BCRM_FRAME_START_TRIGGER_ACTIVATION_RW	REG_BCRM_V4L2_8BIT(0x00bc)
+#define REG_BCRM_FRAME_START_TRIGGER_SOFTWARE_W		REG_BCRM_V4L2_8BIT(0x00c0)
+#define REG_BCRM_FRAME_START_TRIGGER_DELAY_RW		REG_BCRM_V4L2_32BIT(0x00c4)
+#define REG_BCRM_EXPOSURE_ACTIVE_LINE_MODE_RW		REG_BCRM_V4L2_8BIT(0x00c8)
+#define REG_BCRM_EXPOSURE_ACTIVE_LINE_SELECTOR_RW	REG_BCRM_V4L2_8BIT(0x00cc)
+#define REG_BCRM_LINE_CONFIGURATION_RW			REG_BCRM_V4L2_32BIT(0x00d0)
+
+#define REG_BCRM_IMG_WIDTH_RW				REG_BCRM_V4L2_32BIT(0x0100)
+#define REG_BCRM_IMG_WIDTH_MIN_R			REG_BCRM_V4L2_32BIT(0x0104)
+#define REG_BCRM_IMG_WIDTH_MAX_R			REG_BCRM_V4L2_32BIT(0x0108)
+#define REG_BCRM_IMG_WIDTH_INC_R			REG_BCRM_V4L2_32BIT(0x010c)
+
+#define REG_BCRM_IMG_HEIGHT_RW				REG_BCRM_V4L2_32BIT(0x0110)
+#define REG_BCRM_IMG_HEIGHT_MIN_R			REG_BCRM_V4L2_32BIT(0x0114)
+#define REG_BCRM_IMG_HEIGHT_MAX_R			REG_BCRM_V4L2_32BIT(0x0118)
+#define REG_BCRM_IMG_HEIGHT_INC_R			REG_BCRM_V4L2_32BIT(0x011c)
+
+#define REG_BCRM_IMG_OFFSET_X_RW			REG_BCRM_V4L2_32BIT(0x0120)
+#define REG_BCRM_IMG_OFFSET_X_MIN_R			REG_BCRM_V4L2_32BIT(0x0124)
+#define REG_BCRM_IMG_OFFSET_X_MAX_R			REG_BCRM_V4L2_32BIT(0x0128)
+#define REG_BCRM_IMG_OFFSET_X_INC_R			REG_BCRM_V4L2_32BIT(0x012c)
+
+#define REG_BCRM_IMG_OFFSET_Y_RW			REG_BCRM_V4L2_32BIT(0x0130)
+#define REG_BCRM_IMG_OFFSET_Y_MIN_R			REG_BCRM_V4L2_32BIT(0x0134)
+#define REG_BCRM_IMG_OFFSET_Y_MAX_R			REG_BCRM_V4L2_32BIT(0x0138)
+#define REG_BCRM_IMG_OFFSET_Y_INC_R			REG_BCRM_V4L2_32BIT(0x013c)
+
+#define REG_BCRM_IMG_MIPI_DATA_FORMAT_RW		REG_BCRM_V4L2_32BIT(0x0140)
+#define REG_BCRM_IMG_AVAILABLE_MIPI_DATA_FORMATS_R	REG_BCRM_V4L2_64BIT(0x0148)
+#define REG_BCRM_IMG_BAYER_PATTERN_INQUIRY_R		REG_BCRM_V4L2_8BIT(0x0150)
+#define REG_BCRM_IMG_BAYER_PATTERN_RW			REG_BCRM_V4L2_8BIT(0x0154)
+#define REG_BCRM_IMG_REVERSE_X_RW			REG_BCRM_V4L2_8BIT(0x0158)
+#define REG_BCRM_IMG_REVERSE_Y_RW			REG_BCRM_V4L2_8BIT(0x015c)
+
+#define REG_BCRM_SENSOR_WIDTH_R				REG_BCRM_V4L2_32BIT(0x0160)
+#define REG_BCRM_SENSOR_HEIGHT_R			REG_BCRM_V4L2_32BIT(0x0164)
+#define REG_BCRM_WIDTH_MAX_R				REG_BCRM_V4L2_32BIT(0x0168)
+#define REG_BCRM_HEIGHT_MAX_R				REG_BCRM_V4L2_32BIT(0x016c)
+
+#define REG_BCRM_EXPOSURE_TIME_RW			REG_BCRM_V4L2_64BIT(0x0180)
+#define REG_BCRM_EXPOSURE_TIME_MIN_R			REG_BCRM_V4L2_64BIT(0x0188)
+#define REG_BCRM_EXPOSURE_TIME_MAX_R			REG_BCRM_V4L2_64BIT(0x0190)
+#define REG_BCRM_EXPOSURE_TIME_INC_R			REG_BCRM_V4L2_64BIT(0x0198)
+#define REG_BCRM_EXPOSURE_AUTO_RW			REG_BCRM_V4L2_8BIT(0x01a0)
+
+#define REG_BCRM_INTENSITY_AUTO_PRECEDENCE_RW		REG_BCRM_V4L2_8BIT(0x01a4)
+#define REG_BCRM_INTENSITY_AUTO_PRECEDENCE_VALUE_RW	REG_BCRM_V4L2_32BIT(0x01a8)
+#define REG_BCRM_INTENSITY_AUTO_PRECEDENCE_MIN_R	REG_BCRM_V4L2_32BIT(0x01ac)
+#define REG_BCRM_INTENSITY_AUTO_PRECEDENCE_MAX_R	REG_BCRM_V4L2_32BIT(0x01b0)
+#define REG_BCRM_INTENSITY_AUTO_PRECEDENCE_INC_R	REG_BCRM_V4L2_32BIT(0x01b4)
+
+#define REG_BCRM_BLACK_LEVEL_RW				REG_BCRM_V4L2_32BIT(0x01b8)
+#define REG_BCRM_BLACK_LEVEL_MIN_R			REG_BCRM_V4L2_32BIT(0x01bc)
+#define REG_BCRM_BLACK_LEVEL_MAX_R			REG_BCRM_V4L2_32BIT(0x01c0)
+#define REG_BCRM_BLACK_LEVEL_INC_R			REG_BCRM_V4L2_32BIT(0x01c4)
+
+#define REG_BCRM_GAIN_RW				REG_BCRM_V4L2_64BIT(0x01c8)
+#define REG_BCRM_GAIN_MIN_R				REG_BCRM_V4L2_64BIT(0x01d0)
+#define REG_BCRM_GAIN_MAX_R				REG_BCRM_V4L2_64BIT(0x01d8)
+#define REG_BCRM_GAIN_INC_R				REG_BCRM_V4L2_64BIT(0x01e0)
+#define REG_BCRM_GAIN_AUTO_RW				REG_BCRM_V4L2_8BIT(0x01e8)
+
+#define REG_BCRM_GAMMA_RW				REG_BCRM_V4L2_64BIT(0x01f0)
+#define REG_BCRM_GAMMA_MIN_R				REG_BCRM_V4L2_64BIT(0x01f8)
+#define REG_BCRM_GAMMA_MAX_R				REG_BCRM_V4L2_64BIT(0x0200)
+#define REG_BCRM_GAMMA_INC_R				REG_BCRM_V4L2_64BIT(0x0208)
+
+#define REG_BCRM_CONTRAST_VALUE_RW			REG_BCRM_V4L2_32BIT(0x0214)
+#define REG_BCRM_CONTRAST_VALUE_MIN_R			REG_BCRM_V4L2_32BIT(0x0218)
+#define REG_BCRM_CONTRAST_VALUE_MAX_R			REG_BCRM_V4L2_32BIT(0x021c)
+#define REG_BCRM_CONTRAST_VALUE_INC_R			REG_BCRM_V4L2_32BIT(0x0220)
+
+#define REG_BCRM_SATURATION_RW				REG_BCRM_V4L2_32BIT(0x0240)
+#define REG_BCRM_SATURATION_MIN_R			REG_BCRM_V4L2_32BIT(0x0244)
+#define REG_BCRM_SATURATION_MAX_R			REG_BCRM_V4L2_32BIT(0x0248)
+#define REG_BCRM_SATURATION_INC_R			REG_BCRM_V4L2_32BIT(0x024c)
+
+#define REG_BCRM_HUE_RW					REG_BCRM_V4L2_32BIT(0x0250)
+#define REG_BCRM_HUE_MIN_R				REG_BCRM_V4L2_32BIT(0x0254)
+#define REG_BCRM_HUE_MAX_R				REG_BCRM_V4L2_32BIT(0x0258)
+#define REG_BCRM_HUE_INC_R				REG_BCRM_V4L2_32BIT(0x025c)
+
+#define REG_BCRM_ALL_BALANCE_RATIO_RW			REG_BCRM_V4L2_64BIT(0x0260)
+#define REG_BCRM_ALL_BALANCE_RATIO_MIN_R		REG_BCRM_V4L2_64BIT(0x0268)
+#define REG_BCRM_ALL_BALANCE_RATIO_MAX_R		REG_BCRM_V4L2_64BIT(0x0270)
+#define REG_BCRM_ALL_BALANCE_RATIO_INC_R		REG_BCRM_V4L2_64BIT(0x0278)
+
+#define REG_BCRM_RED_BALANCE_RATIO_RW			REG_BCRM_V4L2_64BIT(0x0280)
+#define REG_BCRM_RED_BALANCE_RATIO_MIN_R		REG_BCRM_V4L2_64BIT(0x0288)
+#define REG_BCRM_RED_BALANCE_RATIO_MAX_R		REG_BCRM_V4L2_64BIT(0x0290)
+#define REG_BCRM_RED_BALANCE_RATIO_INC_R		REG_BCRM_V4L2_64BIT(0x0298)
+
+#define REG_BCRM_GREEN_BALANCE_RATIO_RW			REG_BCRM_V4L2_64BIT(0x02a0)
+#define REG_BCRM_GREEN_BALANCE_RATIO_MIN_R		REG_BCRM_V4L2_64BIT(0x02a8)
+#define REG_BCRM_GREEN_BALANCE_RATIO_MAX_R		REG_BCRM_V4L2_64BIT(0x02b0)
+#define REG_BCRM_GREEN_BALANCE_RATIO_INC_R		REG_BCRM_V4L2_64BIT(0x02b8)
+
+#define REG_BCRM_BLUE_BALANCE_RATIO_RW			REG_BCRM_V4L2_64BIT(0x02c0)
+#define REG_BCRM_BLUE_BALANCE_RATIO_MIN_R		REG_BCRM_V4L2_64BIT(0x02c8)
+#define REG_BCRM_BLUE_BALANCE_RATIO_MAX_R		REG_BCRM_V4L2_64BIT(0x02d0)
+#define REG_BCRM_BLUE_BALANCE_RATIO_INC_R		REG_BCRM_V4L2_64BIT(0x02d8)
+
+#define REG_BCRM_WHITE_BALANCE_AUTO_RW			REG_BCRM_V4L2_8BIT(0x02e0)
+#define REG_BCRM_SHARPNESS_RW				REG_BCRM_V4L2_32BIT(0x0300)
+#define REG_BCRM_SHARPNESS_MIN_R			REG_BCRM_V4L2_32BIT(0x0304)
+#define REG_BCRM_SHARPNESS_MAX_R			REG_BCRM_V4L2_32BIT(0x0308)
+#define REG_BCRM_SHARPNESS_INC_R			REG_BCRM_V4L2_32BIT(0x030c)
+
+#define REG_BCRM_DEVICE_TEMPERATURE_R			REG_BCRM_V4L2_32BIT(0x0310)
+#define REG_BCRM_EXPOSURE_AUTO_MIN_RW			REG_BCRM_V4L2_64BIT(0x0330)
+#define REG_BCRM_EXPOSURE_AUTO_MAX_RW			REG_BCRM_V4L2_64BIT(0x0338)
+#define REG_BCRM_GAIN_AUTO_MIN_RW			REG_BCRM_V4L2_64BIT(0x0340)
+#define REG_BCRM_GAIN_AUTO_MAX_RW			REG_BCRM_V4L2_64BIT(0x0348)
+
+/* Heartbeat reg*/
+#define REG_BCRM_HEARTBEAT_RW				CCI_REG8(0x021f)
+
+/* GenCP Registers */
+#define REG_GENCP_CHANGEMODE_W				CCI_REG8(0x021c)
+#define REG_GENCP_CURRENTMODE_R				CCI_REG8(0x021d)
+#define REG_GENCP_IN_HANDSHAKE_RW			CCI_REG8(0x001c)
+#define REG_GENCP_OUT_SIZE_W				CCI_REG16(0x0020)
+#define REG_GENCP_IN_SIZE_R				CCI_REG16(0x0024)
+
+/* defines */
+#define REG_BCRM_HANDSHAKE_STATUS_MASK			0x01
+#define REG_BCRM_HANDSHAKE_AVAILABLE_MASK		0x80
+
+#define BCRM_HANDSHAKE_W_DONE_EN_BIT			BIT(0)
+
+#define ALVIUM_DEFAULT_FR_HZ				10
+#define ALVIUM_DEFAULT_PIXEL_RATE_MHZ			148000000
+
+#define ALVIUM_LP2HS_DELAY_MS				100
+
+enum alvium_bcrm_mode {
+	ALVIUM_BCM_MODE,
+	ALVIUM_GENCP_MODE,
+	ALVIUM_NUM_MODE
+};
+
+enum alvium_mipi_fmt {
+	ALVIUM_FMT_UYVY8_2X8 = 0,
+	ALVIUM_FMT_UYVY8_1X16,
+	ALVIUM_FMT_YUYV8_1X16,
+	ALVIUM_FMT_YUYV8_2X8,
+	ALVIUM_FMT_YUYV10_1X20,
+	ALVIUM_FMT_RGB888_1X24,
+	ALVIUM_FMT_RBG888_1X24,
+	ALVIUM_FMT_BGR888_1X24,
+	ALVIUM_FMT_RGB888_3X8,
+	ALVIUM_FMT_Y8_1X8,
+	ALVIUM_FMT_SGRBG8_1X8,
+	ALVIUM_FMT_SRGGB8_1X8,
+	ALVIUM_FMT_SGBRG8_1X8,
+	ALVIUM_FMT_SBGGR8_1X8,
+	ALVIUM_FMT_Y10_1X10,
+	ALVIUM_FMT_SGRBG10_1X10,
+	ALVIUM_FMT_SRGGB10_1X10,
+	ALVIUM_FMT_SGBRG10_1X10,
+	ALVIUM_FMT_SBGGR10_1X10,
+	ALVIUM_FMT_Y12_1X12,
+	ALVIUM_FMT_SGRBG12_1X12,
+	ALVIUM_FMT_SRGGB12_1X12,
+	ALVIUM_FMT_SGBRG12_1X12,
+	ALVIUM_FMT_SBGGR12_1X12,
+	ALVIUM_FMT_SBGGR14_1X14,
+	ALVIUM_FMT_SGBRG14_1X14,
+	ALVIUM_FMT_SRGGB14_1X14,
+	ALVIUM_FMT_SGRBG14_1X14,
+	ALVIUM_NUM_SUPP_MIPI_DATA_FMT
+};
+
+enum alvium_av_bayer_bit {
+	ALVIUM_BIT_BAY_NONE = -1,
+	ALVIUM_BIT_BAY_MONO = 0,
+	ALVIUM_BIT_BAY_GR,
+	ALVIUM_BIT_BAY_RG,
+	ALVIUM_BIT_BAY_GB,
+	ALVIUM_BIT_BAY_BG,
+	ALVIUM_NUM_BAY_AV_BIT
+};
+
+enum alvium_av_mipi_bit {
+	ALVIUM_BIT_YUV420_8_LEG = 0,
+	ALVIUM_BIT_YUV420_8,
+	ALVIUM_BIT_YUV420_10,
+	ALVIUM_BIT_YUV420_8_CSPS,
+	ALVIUM_BIT_YUV420_10_CSPS,
+	ALVIUM_BIT_YUV422_8,
+	ALVIUM_BIT_YUV422_10,
+	ALVIUM_BIT_RGB888,
+	ALVIUM_BIT_RGB666,
+	ALVIUM_BIT_RGB565,
+	ALVIUM_BIT_RGB555,
+	ALVIUM_BIT_RGB444,
+	ALVIUM_BIT_RAW6,
+	ALVIUM_BIT_RAW7,
+	ALVIUM_BIT_RAW8,
+	ALVIUM_BIT_RAW10,
+	ALVIUM_BIT_RAW12,
+	ALVIUM_BIT_RAW14,
+	ALVIUM_BIT_JPEG,
+	ALVIUM_NUM_SUPP_MIPI_DATA_BIT
+};
+
+struct alvium_avail_feat {
+	u64 rev_x:1;
+	u64 rev_y:1;
+	u64 int_autop:1;
+	u64 black_lvl:1;
+	u64 gain:1;
+	u64 gamma:1;
+	u64 contrast:1;
+	u64 sat:1;
+	u64 hue:1;
+	u64 whiteb:1;
+	u64 sharp:1;
+	u64 auto_exp:1;
+	u64 auto_gain:1;
+	u64 auto_whiteb:1;
+	u64 dev_temp:1;
+	u64 acq_abort:1;
+	u64 acq_fr:1;
+	u64 fr_trigger:1;
+	u64 exp_acq_line:1;
+	u64 reserved:45;
+};
+
+struct alvium_avail_mipi_fmt {
+	u64 yuv420_8_leg:1;
+	u64 yuv420_8:1;
+	u64 yuv420_10:1;
+	u64 yuv420_8_csps:1;
+	u64 yuv420_10_csps:1;
+	u64 yuv422_8:1;
+	u64 yuv422_10:1;
+	u64 rgb888:1;
+	u64 rgb666:1;
+	u64 rgb565:1;
+	u64 rgb555:1;
+	u64 rgb444:1;
+	u64 raw6:1;
+	u64 raw7:1;
+	u64 raw8:1;
+	u64 raw10:1;
+	u64 raw12:1;
+	u64 raw14:1;
+	u64 jpeg:1;
+	u64 reserved:45;
+};
+
+struct alvium_avail_bayer {
+	u8 mono:1;
+	u8 gr:1;
+	u8 rg:1;
+	u8 gb:1;
+	u8 bg:1;
+	u8 reserved:3;
+};
+
+struct alvium_mode {
+	struct v4l2_rect crop;
+	struct v4l2_mbus_framefmt fmt;
+	u32 width;
+	u32 height;
+};
+
+struct alvium_pixfmt {
+	u32 code;
+	u32 colorspace;
+	u64 mipi_fmt_regval;
+	u64 bay_fmt_regval;
+	u8 id;
+	u8 is_raw;
+	u8 fmt_av_bit;
+	u8 bay_av_bit;
+};
+
+struct alvium_ctrls {
+	struct v4l2_ctrl_handler handler;
+	struct v4l2_ctrl *pixel_rate;
+	struct v4l2_ctrl *link_freq;
+	struct v4l2_ctrl *auto_exp;
+	struct v4l2_ctrl *exposure;
+	struct v4l2_ctrl *auto_wb;
+	struct v4l2_ctrl *blue_balance;
+	struct v4l2_ctrl *red_balance;
+	struct v4l2_ctrl *auto_gain;
+	struct v4l2_ctrl *gain;
+	struct v4l2_ctrl *saturation;
+	struct v4l2_ctrl *hue;
+	struct v4l2_ctrl *contrast;
+	struct v4l2_ctrl *gamma;
+	struct v4l2_ctrl *sharpness;
+	struct v4l2_ctrl *hflip;
+	struct v4l2_ctrl *vflip;
+};
+
+struct alvium_dev {
+	struct i2c_client *i2c_client;
+	struct v4l2_subdev sd;
+	struct v4l2_fwnode_endpoint ep;
+	struct media_pad pad;
+	struct regmap *regmap;
+
+	struct regulator *reg_vcc;
+
+	u16 bcrm_addr;
+
+	struct alvium_avail_feat avail_ft;
+	u8 is_mipi_fmt_avail[ALVIUM_NUM_SUPP_MIPI_DATA_BIT];
+	u8 is_bay_avail[ALVIUM_NUM_BAY_AV_BIT];
+
+	u32 min_csi_clk;
+	u32 max_csi_clk;
+	u32 dft_img_width;
+	u32 img_min_width;
+	u32 img_max_width;
+	u32 img_inc_width;
+	u32 dft_img_height;
+	u32 img_min_height;
+	u32 img_max_height;
+	u32 img_inc_height;
+	u32 min_offx;
+	u32 max_offx;
+	u32 inc_offx;
+	u32 min_offy;
+	u32 max_offy;
+	u32 inc_offy;
+	u64 dft_gain;
+	u64 min_gain;
+	u64 max_gain;
+	u64 inc_gain;
+	u64 dft_exp;
+	u64 min_exp;
+	u64 max_exp;
+	u64 inc_exp;
+	u64 dft_rbalance;
+	u64 min_rbalance;
+	u64 max_rbalance;
+	u64 inc_rbalance;
+	u64 dft_bbalance;
+	u64 min_bbalance;
+	u64 max_bbalance;
+	u64 inc_bbalance;
+	s32 dft_hue;
+	s32 min_hue;
+	s32 max_hue;
+	s32 inc_hue;
+	u32 dft_contrast;
+	u32 min_contrast;
+	u32 max_contrast;
+	u32 inc_contrast;
+	u32 dft_sat;
+	u32 min_sat;
+	u32 max_sat;
+	u32 inc_sat;
+	s32 dft_black_lvl;
+	s32 min_black_lvl;
+	s32 max_black_lvl;
+	s32 inc_black_lvl;
+	u64 dft_gamma;
+	u64 min_gamma;
+	u64 max_gamma;
+	u64 inc_gamma;
+	s32 dft_sharp;
+	s32 min_sharp;
+	s32 max_sharp;
+	s32 inc_sharp;
+
+	struct alvium_mode mode;
+	struct v4l2_fract frame_interval;
+	u64 dft_fr;
+	u64 min_fr;
+	u64 max_fr;
+	u64 fr;
+
+	u8 h_sup_csi_lanes;
+	u64 link_freq;
+
+	struct alvium_ctrls ctrls;
+
+	u8 bcrm_mode;
+
+	struct alvium_pixfmt *alvium_csi2_fmt;
+	u8 alvium_csi2_fmt_n;
+
+	u8 streaming;
+	u8 apply_fiv;
+};
+
+static inline struct alvium_dev *sd_to_alvium(struct v4l2_subdev *sd)
+{
+	return container_of_const(sd, struct alvium_dev, sd);
+}
+
+static inline struct v4l2_subdev *ctrl_to_sd(struct v4l2_ctrl *ctrl)
+{
+	return &container_of_const(ctrl->handler, struct alvium_dev,
+					  ctrls.handler)->sd;
+}
+#endif /* ALVIUM_CSI2_H_ */
-- 
2.34.1

