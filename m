Return-Path: <linux-kernel+bounces-157721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 075A88B150B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD531C23468
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A9A156999;
	Wed, 24 Apr 2024 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHQdcPXp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C168B156973;
	Wed, 24 Apr 2024 21:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713992891; cv=none; b=WMs75hn2k+zxtZE/X7sk+iOD4bAlDF4KmCKh47WeYZtkD4Kl/Cb4eXPB1Los2lmJwhBzTwyVdvaSXn9kGd0BP1+G2sp0KDzT/cDSTDXfTJsBoHzFqYr4nKxJd/3fA0TU+ceuMmxxupe5ga9L9qe6qdyZSSHSrjjorvt7JO8HOTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713992891; c=relaxed/simple;
	bh=EleAqayESlUVzBofwFBWgvBnL/gAQLThLFFs1fbkf/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cQ4v731jKT6MAFBYF6tuc9EhiBxeG4ss+JfTOghUECbjpg2IAld4dgEbMt5XdzDlHleS2Bsg/4mopkRclR3boCJgtgTgcGZk0Alc7xv9UaNWiIHe8dKdZD5F0J6Vjqt3MDMnITObbDjg+Ihq9zghGE5W135qAVeHYlZr8jCuq8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHQdcPXp; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713992887; x=1745528887;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EleAqayESlUVzBofwFBWgvBnL/gAQLThLFFs1fbkf/0=;
  b=gHQdcPXpGnwODpjs+jxKqA0Y4sLrIwyhDDYaTyqAsLCcRmXWWYI9fPKo
   3+fOA1i4WahhqEMWMVJCFivOdPAW86pJBRzU/FiL4k7Ef/zdDwUehWBiV
   40BR5WTIwP1VwBdpKl08Ldsp/HKuE5PUiQVffxTOvWd7EyWXTapg7XoKU
   0A4g0HKG9EgOKevY8NDsz6c5u6dj2gMu/1sx36Yj2JWBpM4QUHsIvq5P0
   WxgGQezhtk3mWKGT1ujaYi0EhKg9PPXao70sQrBOOcPy2bKxQX0pnNAW5
   +cZB8Sw/mO0YtZ4755utnL87M2V9MOZIHLxWcjKVw5Q9ky5Zu/WiyvwkF
   w==;
X-CSE-ConnectionGUID: 1b99vKqpTRqY1IKgBKol5w==
X-CSE-MsgGUID: Iz8FMMaAQY2f21W1RDudfw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9773167"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="9773167"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 14:08:07 -0700
X-CSE-ConnectionGUID: Lv1gvZraTkKZW5iTcmo1Hg==
X-CSE-MsgGUID: ABvCwH99TYqF8RioM8Aj9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="24848109"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 24 Apr 2024 14:08:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6646F288; Thu, 25 Apr 2024 00:08:03 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Kate Hsuan <hpa@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 1/1] media: atomisp: Remove unused GPIO related defines and APIs
Date: Thu, 25 Apr 2024 00:08:00 +0300
Message-ID: <20240424210800.1776038-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused GPIO related defines and APIs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../media/atomisp/pci/gpio_block_defs.h       | 17 -------
 .../pci/hive_isp_css_common/gpio_global.h     | 23 ----------
 .../pci/hive_isp_css_common/host/gpio_local.h | 21 ---------
 .../hive_isp_css_common/host/gpio_private.h   |  9 ++--
 .../atomisp/pci/hive_isp_css_include/gpio.h   | 46 -------------------
 .../hive_isp_css_include/host/gpio_public.h   | 46 -------------------
 drivers/staging/media/atomisp/pci/sh_css.c    | 10 ++--
 7 files changed, 7 insertions(+), 165 deletions(-)
 delete mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gpio_local.h
 delete mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/gpio.h
 delete mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/host/gpio_public.h

diff --git a/drivers/staging/media/atomisp/pci/gpio_block_defs.h b/drivers/staging/media/atomisp/pci/gpio_block_defs.h
index e1bd638d344a..55c39067a9bf 100644
--- a/drivers/staging/media/atomisp/pci/gpio_block_defs.h
+++ b/drivers/staging/media/atomisp/pci/gpio_block_defs.h
@@ -16,27 +16,10 @@
 #ifndef _gpio_block_defs_h_
 #define _gpio_block_defs_h_
 
-#define _HRT_GPIO_BLOCK_REG_ALIGN 4
-
 /* R/W registers */
 #define _gpio_block_reg_do_e				 0
 #define _gpio_block_reg_do_select		       1
 #define _gpio_block_reg_do_0				 2
 #define _gpio_block_reg_do_1				 3
-#define _gpio_block_reg_do_pwm_cnt_0	     4
-#define _gpio_block_reg_do_pwm_cnt_1	     5
-#define _gpio_block_reg_do_pwm_cnt_2	     6
-#define _gpio_block_reg_do_pwm_cnt_3	     7
-#define _gpio_block_reg_do_pwm_main_cnt    8
-#define _gpio_block_reg_do_pwm_enable      9
-#define _gpio_block_reg_di_debounce_sel	  10
-#define _gpio_block_reg_di_debounce_cnt_0	11
-#define _gpio_block_reg_di_debounce_cnt_1	12
-#define _gpio_block_reg_di_debounce_cnt_2	13
-#define _gpio_block_reg_di_debounce_cnt_3	14
-#define _gpio_block_reg_di_active_level	  15
-
-/* read-only registers */
-#define _gpio_block_reg_di				  16
 
 #endif /* _gpio_block_defs_h_ */
diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_common/gpio_global.h b/drivers/staging/media/atomisp/pci/hive_isp_css_common/gpio_global.h
index b5f017482f89..06b6cb3842f4 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_common/gpio_global.h
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_common/gpio_global.h
@@ -16,31 +16,8 @@
 #ifndef __GPIO_GLOBAL_H_INCLUDED__
 #define __GPIO_GLOBAL_H_INCLUDED__
 
-#define IS_GPIO_VERSION_1
-
 #include <gpio_block_defs.h>
 
-/* pqiao: following part only defines in hive_isp_css_defs.h in fpga system.
-	port it here
-*/
-
-/* GPIO pin defines */
-/*#define HIVE_GPIO_CAMERA_BOARD_RESET_PIN_NR                   0
-#define HIVE_GPIO_LCD_CLOCK_SELECT_PIN_NR                     7
-#define HIVE_GPIO_HDMI_CLOCK_SELECT_PIN_NR                    8
-#define HIVE_GPIO_LCD_VERT_FLIP_PIN_NR                        8
-#define HIVE_GPIO_LCD_HOR_FLIP_PIN_NR                         9
-#define HIVE_GPIO_AS3683_GPIO_P0_PIN_NR                       1
-#define HIVE_GPIO_AS3683_DATA_P1_PIN_NR                       2
-#define HIVE_GPIO_AS3683_CLK_P2_PIN_NR                        3
-#define HIVE_GPIO_AS3683_T1_F0_PIN_NR                         4
-#define HIVE_GPIO_AS3683_SFL_F1_PIN_NR                        5
-#define HIVE_GPIO_AS3683_STROBE_F2_PIN_NR                     6
-#define HIVE_GPIO_MAX1577_EN1_PIN_NR                          1
-#define HIVE_GPIO_MAX1577_EN2_PIN_NR                          2
-#define HIVE_GPIO_MAX8685A_EN_PIN_NR                          3
-#define HIVE_GPIO_MAX8685A_TRIG_PIN_NR                        4*/
-
 #define HIVE_GPIO_STROBE_TRIGGER_PIN		2
 
 #endif /* __GPIO_GLOBAL_H_INCLUDED__ */
diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gpio_local.h b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gpio_local.h
deleted file mode 100644
index 14013733f826..000000000000
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gpio_local.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Support for Intel Camera Imaging ISP subsystem.
- * Copyright (c) 2010-2015, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- */
-
-#ifndef __GPIO_LOCAL_H_INCLUDED__
-#define __GPIO_LOCAL_H_INCLUDED__
-
-#include "gpio_global.h"
-
-#endif /* __GPIO_LOCAL_H_INCLUDED__ */
diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gpio_private.h b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gpio_private.h
index cc60bed71ddb..85fcde0b8615 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gpio_private.h
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gpio_private.h
@@ -16,13 +16,10 @@
 #ifndef __GPIO_PRIVATE_H_INCLUDED__
 #define __GPIO_PRIVATE_H_INCLUDED__
 
-#include "gpio_public.h"
-
+#include "assert_support.h"
 #include "device_access.h"
 
-#include "assert_support.h"
-
-STORAGE_CLASS_GPIO_C void gpio_reg_store(
+static inline void gpio_reg_store(
     const gpio_ID_t	ID,
     const unsigned int		reg,
     const hrt_data			value)
@@ -33,7 +30,7 @@ STORAGE_CLASS_GPIO_C void gpio_reg_store(
 	return;
 }
 
-STORAGE_CLASS_GPIO_C hrt_data gpio_reg_load(
+static inline hrt_data gpio_reg_load(
     const gpio_ID_t	ID,
     const unsigned int		reg)
 {
diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_include/gpio.h b/drivers/staging/media/atomisp/pci/hive_isp_css_include/gpio.h
deleted file mode 100644
index 6f16ca77cf75..000000000000
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_include/gpio.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Support for Intel Camera Imaging ISP subsystem.
- * Copyright (c) 2015, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- */
-
-#ifndef __GPIO_H_INCLUDED__
-#define __GPIO_H_INCLUDED__
-
-/*
- * This file is included on every cell {SP,ISP,host} and on every system
- * that uses the input system device(s). It defines the API to DLI bridge
- *
- * System and cell specific interfaces and inline code are included
- * conditionally through Makefile path settings.
- *
- *  - .        system and cell agnostic interfaces, constants and identifiers
- *	- public:  system agnostic, cell specific interfaces
- *	- private: system dependent, cell specific interfaces & inline implementations
- *	- global:  system specific constants and identifiers
- *	- local:   system and cell specific constants and identifiers
- */
-
-#include "system_local.h"
-#include "gpio_local.h"
-
-#ifndef __INLINE_GPIO__
-#define STORAGE_CLASS_GPIO_H extern
-#define STORAGE_CLASS_GPIO_C
-#include "gpio_public.h"
-#else  /* __INLINE_GPIO__ */
-#define STORAGE_CLASS_GPIO_H static inline
-#define STORAGE_CLASS_GPIO_C static inline
-#include "gpio_private.h"
-#endif /* __INLINE_GPIO__ */
-
-#endif /* __GPIO_H_INCLUDED__ */
diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_include/host/gpio_public.h b/drivers/staging/media/atomisp/pci/hive_isp_css_include/host/gpio_public.h
deleted file mode 100644
index 13df9b57a5fb..000000000000
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_include/host/gpio_public.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Support for Intel Camera Imaging ISP subsystem.
- * Copyright (c) 2015, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- */
-
-#ifndef __GPIO_PUBLIC_H_INCLUDED__
-#define __GPIO_PUBLIC_H_INCLUDED__
-
-#include "system_local.h"
-
-/*! Write to a control register of GPIO[ID]
-
- \param	ID[in]				GPIO identifier
- \param	reg_addr[in]		register byte address
- \param value[in]			The data to be written
-
- \return none, GPIO[ID].ctrl[reg] = value
- */
-STORAGE_CLASS_GPIO_H void gpio_reg_store(
-    const gpio_ID_t	ID,
-    const unsigned int		reg_addr,
-    const hrt_data			value);
-
-/*! Read from a control register of GPIO[ID]
-
- \param	ID[in]				GPIO identifier
- \param	reg_addr[in]		register byte address
- \param value[in]			The data to be written
-
- \return GPIO[ID].ctrl[reg]
- */
-STORAGE_CLASS_GPIO_H hrt_data gpio_reg_load(
-    const gpio_ID_t	ID,
-    const unsigned int		reg_addr);
-
-#endif /* __GPIO_PUBLIC_H_INCLUDED__ */
diff --git a/drivers/staging/media/atomisp/pci/sh_css.c b/drivers/staging/media/atomisp/pci/sh_css.c
index e2497fc4dfc9..01f0b8a33c99 100644
--- a/drivers/staging/media/atomisp/pci/sh_css.c
+++ b/drivers/staging/media/atomisp/pci/sh_css.c
@@ -66,8 +66,8 @@
 #include "sp.h"			/* cnd_sp_irq_enable() */
 #include "isp.h"		/* cnd_isp_irq_enable, ISP_VEC_NELEMS */
 #include "gp_device.h"		/* gp_device_reg_store() */
-#define __INLINE_GPIO__
-#include "gpio.h"
+#include <gpio_global.h>
+#include <gpio_private.h>
 #include "timed_ctrl.h"
 #include "ia_css_inputfifo.h"
 #define WITH_PC_MONITORING  0
@@ -1363,10 +1363,8 @@ ia_css_init(struct device *dev, const struct ia_css_env *env,
 
 	ia_css_device_access_init(&env->hw_access_env);
 
-	select = gpio_reg_load(GPIO0_ID, _gpio_block_reg_do_select)
-	& (~GPIO_FLASH_PIN_MASK);
-	enable = gpio_reg_load(GPIO0_ID, _gpio_block_reg_do_e)
-	| GPIO_FLASH_PIN_MASK;
+	select = gpio_reg_load(GPIO0_ID, _gpio_block_reg_do_select) & ~GPIO_FLASH_PIN_MASK;
+	enable = gpio_reg_load(GPIO0_ID, _gpio_block_reg_do_e) | GPIO_FLASH_PIN_MASK;
 	sh_css_mmu_set_page_table_base_index(mmu_l1_base);
 
 	my_css_save.mmu_base = mmu_l1_base;
-- 
2.43.0.rc1.1336.g36b5255a03ac


