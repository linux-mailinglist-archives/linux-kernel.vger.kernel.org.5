Return-Path: <linux-kernel+bounces-157552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 499C38B12C4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD13C1F25497
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1F8210E6;
	Wed, 24 Apr 2024 18:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F+O8Rs4T"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34FF18E1E;
	Wed, 24 Apr 2024 18:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713984292; cv=none; b=tO1bR42qBcvn1/85LnyEpE7gdcZEtfGdFvZLRmDbydLd15fjopnr0k4GD8DG7SPixHewZ4487A98KlP3FW/A1/3pTo3l9L4HGTHzGwiooa3UONaSoDePwYFWCWAUYqiG60gTnHStYATMDoOLgMtGPOCFFWrdaS81O41V/e/tfmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713984292; c=relaxed/simple;
	bh=bmEgJm+nWhZMSv9rSMU0KsmGx3A8cxIRW9yvR1peY04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OadZYd0ykMlkyUU18CrgR7q8VBYRpyMKxvWqIpbEP+d/H8Fb1cbqF1V6nwtwpoFkprCY62/iaHHWQ0JgRbL6AbivsGWvF1vXobjwtvElvNewg2oNQVWO1DhZDUfUSynYzuxJ0ZJjAXLp8YDtS4iXM9Nwvie627RMoo76Zb+pCXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F+O8Rs4T; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713984291; x=1745520291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bmEgJm+nWhZMSv9rSMU0KsmGx3A8cxIRW9yvR1peY04=;
  b=F+O8Rs4TjRUZd4PPscrG8D+EQ5xH+tfsVoxmRWi6yi6qQyRmnzOJAZa8
   uwEdeba0ERUlzMwGKvZI7VxpfH+3EXbRNf4HPYvJycboG/vN6AqCi4arp
   hW1570NWdFhoGusv8A0oehFQsLkz0mFv6jIgwe1OzKYJ2GB2yuu+Yed8j
   b84nBKZpR+IGLm8OhfyedrWWrgf6KLtqMQX8MxbfJWnpP66G3mGeGG1D0
   eEoVeCiM5xMfJO+drYj4jBAVVxTDqPPuhnDHWor+oZw74wG0vMY8QNDxg
   y+5CMiksnbSvpljbPKXtyudaIZKuN7KZDtX/dEvh1IlNa8hOzncZTcJaR
   g==;
X-CSE-ConnectionGUID: grh0sztBSuaTLbR8ABDO4Q==
X-CSE-MsgGUID: AEGJcnydR6WVTbjXpANFlQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9507791"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="9507791"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:44:48 -0700
X-CSE-ConnectionGUID: M2nEi21gQnS4YT7a2+hl8A==
X-CSE-MsgGUID: lMG9HcRzRS2DwIEOAED5Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="24810441"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 24 Apr 2024 11:44:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DCBC553E; Wed, 24 Apr 2024 21:44:22 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kate Hsuan <hpa@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 2/2] media: atomisp: Replace COMPILATION_ERROR_IF() by static_assert()
Date: Wed, 24 Apr 2024 21:43:32 +0300
Message-ID: <20240424184421.1737776-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240424184421.1737776-1-andriy.shevchenko@linux.intel.com>
References: <20240424184421.1737776-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace COMPILATION_ERROR_IF() by static_assert().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../circbuf/interface/ia_css_circbuf_comm.h   |  6 +++
 .../pci/hive_isp_css_include/assert_support.h | 23 -----------
 .../pci/hive_isp_css_include/type_support.h   |  5 ++-
 drivers/staging/media/atomisp/pci/ia_css_3a.h |  4 ++
 .../staging/media/atomisp/pci/ia_css_dvs.h    |  4 ++
 .../media/atomisp/pci/ia_css_metadata.h       |  4 ++
 .../staging/media/atomisp/pci/ia_css_types.h  |  2 +
 .../spctrl/interface/ia_css_spctrl_comm.h     |  4 ++
 drivers/staging/media/atomisp/pci/sh_css.c    | 38 -------------------
 .../media/atomisp/pci/sh_css_internal.h       | 15 +++++++-
 10 files changed, 40 insertions(+), 65 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/base/circbuf/interface/ia_css_circbuf_comm.h b/drivers/staging/media/atomisp/pci/base/circbuf/interface/ia_css_circbuf_comm.h
index 6fa6da859158..b0f20563c3a3 100644
--- a/drivers/staging/media/atomisp/pci/base/circbuf/interface/ia_css_circbuf_comm.h
+++ b/drivers/staging/media/atomisp/pci/base/circbuf/interface/ia_css_circbuf_comm.h
@@ -16,6 +16,8 @@
 #ifndef _IA_CSS_CIRCBUF_COMM_H
 #define _IA_CSS_CIRCBUF_COMM_H
 
+#include <linux/build_bug.h>
+
 #include <type_support.h>  /* uint8_t, uint32_t */
 
 #define IA_CSS_CIRCBUF_PADDING 1 /* The circular buffer is implemented in lock-less manner, wherein
@@ -45,6 +47,8 @@ struct ia_css_circbuf_desc_s {
 #define SIZE_OF_IA_CSS_CIRCBUF_DESC_S_STRUCT				\
 	(4 * sizeof(uint8_t))
 
+static_assert(sizeof(struct ia_css_circbuf_desc_s) == SIZE_OF_IA_CSS_CIRCBUF_DESC_S_STRUCT);
+
 /**
  * @brief Data structure for the circular buffer element.
  */
@@ -56,4 +60,6 @@ struct ia_css_circbuf_elem_s {
 #define SIZE_OF_IA_CSS_CIRCBUF_ELEM_S_STRUCT				\
 	(sizeof(uint32_t))
 
+static_assert(sizeof(struct ia_css_circbuf_elem_s) == SIZE_OF_IA_CSS_CIRCBUF_ELEM_S_STRUCT);
+
 #endif /*_IA_CSS_CIRCBUF_COMM_H*/
diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_include/assert_support.h b/drivers/staging/media/atomisp/pci/hive_isp_css_include/assert_support.h
index 7382c0bbf7cb..d294ac402de8 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_include/assert_support.h
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_include/assert_support.h
@@ -16,29 +16,6 @@
 #ifndef __ASSERT_SUPPORT_H_INCLUDED__
 #define __ASSERT_SUPPORT_H_INCLUDED__
 
-/**
- * The following macro can help to test the size of a struct at compile
- * time rather than at run-time. It does not work for all compilers; see
- * below.
- *
- * Depending on the value of 'condition', the following macro is expanded to:
- * - condition==true:
- *     an expression containing an array declaration with negative size,
- *     usually resulting in a compilation error
- * - condition==false:
- *     (void) 1; // C statement with no effect
- *
- * example:
- *  COMPILATION_ERROR_IF( sizeof(struct host_sp_queues) != SIZE_OF_HOST_SP_QUEUES_STRUCT);
- *
- * verify that the macro indeed triggers a compilation error with your compiler:
- *  COMPILATION_ERROR_IF( sizeof(struct host_sp_queues) != (sizeof(struct host_sp_queues)+1) );
- *
- * Not all compilers will trigger an error with this macro; use a search engine to search for
- * BUILD_BUG_ON to find other methods.
- */
-#define COMPILATION_ERROR_IF(condition) ((void)sizeof(char[1 - 2 * !!(condition)]))
-
 /* Compile time assertion */
 #ifndef CT_ASSERT
 #define CT_ASSERT(cnd) ((void)sizeof(char[(cnd) ? 1 :  -1]))
diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_include/type_support.h b/drivers/staging/media/atomisp/pci/hive_isp_css_include/type_support.h
index b996ee54d4a5..9a640f18eed9 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_include/type_support.h
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_include/type_support.h
@@ -33,9 +33,10 @@
 
 #define CHAR_BIT (8)
 
-#include <linux/types.h>
-#include <linux/limits.h>
 #include <linux/errno.h>
+#include <linux/limits.h>
+#include <linux/types.h>
+
 #define HOST_ADDRESS(x) (unsigned long)(x)
 
 #endif /* __TYPE_SUPPORT_H_INCLUDED__ */
diff --git a/drivers/staging/media/atomisp/pci/ia_css_3a.h b/drivers/staging/media/atomisp/pci/ia_css_3a.h
index 506910dd5c18..fc2075c7bd01 100644
--- a/drivers/staging/media/atomisp/pci/ia_css_3a.h
+++ b/drivers/staging/media/atomisp/pci/ia_css_3a.h
@@ -20,6 +20,8 @@
  * This file contains types used for 3A statistics
  */
 
+#include <linux/build_bug.h>
+
 #include <math_support.h>
 #include <type_support.h>
 #include "ia_css_types.h"
@@ -80,6 +82,8 @@ struct ia_css_isp_3a_statistics {
 	 SIZE_OF_IA_CSS_PTR +						\
 	 4 * sizeof(uint32_t))
 
+static_assert(sizeof(struct ia_css_isp_3a_statistics) == SIZE_OF_IA_CSS_ISP_3A_STATISTICS_STRUCT);
+
 /* Map with host-side pointers to ISP-format statistics.
  * These pointers can either be copies of ISP data or memory mapped
  * ISP pointers.
diff --git a/drivers/staging/media/atomisp/pci/ia_css_dvs.h b/drivers/staging/media/atomisp/pci/ia_css_dvs.h
index 3367dfd64050..41a81561bbef 100644
--- a/drivers/staging/media/atomisp/pci/ia_css_dvs.h
+++ b/drivers/staging/media/atomisp/pci/ia_css_dvs.h
@@ -20,6 +20,8 @@
  * This file contains types for DVS statistics
  */
 
+#include <linux/build_bug.h>
+
 #include <type_support.h>
 #include "ia_css_types.h"
 #include "ia_css_err.h"
@@ -55,6 +57,8 @@ struct ia_css_isp_skc_dvs_statistics;
 	((3 * SIZE_OF_IA_CSS_PTR) +					\
 	 (4 * sizeof(uint32_t)))
 
+static_assert(sizeof(struct ia_css_isp_dvs_statistics) == SIZE_OF_IA_CSS_ISP_DVS_STATISTICS_STRUCT);
+
 /* Map with host-side pointers to ISP-format statistics.
  * These pointers can either be copies of ISP data or memory mapped
  * ISP pointers.
diff --git a/drivers/staging/media/atomisp/pci/ia_css_metadata.h b/drivers/staging/media/atomisp/pci/ia_css_metadata.h
index 9eb1b76a3b2a..a3e759a3eee7 100644
--- a/drivers/staging/media/atomisp/pci/ia_css_metadata.h
+++ b/drivers/staging/media/atomisp/pci/ia_css_metadata.h
@@ -20,6 +20,8 @@
  * This file contains structure for processing sensor metadata.
  */
 
+#include <linux/build_bug.h>
+
 #include <type_support.h>
 #include "ia_css_types.h"
 #include "ia_css_stream_format.h"
@@ -50,6 +52,8 @@ struct ia_css_metadata {
 
 #define SIZE_OF_IA_CSS_METADATA_STRUCT sizeof(struct ia_css_metadata)
 
+static_assert(sizeof(struct ia_css_metadata) == SIZE_OF_IA_CSS_METADATA_STRUCT);
+
 /* @brief Allocate a metadata buffer.
  * @param[in]   metadata_info Metadata info struct, contains details on metadata buffers.
  * @return      Pointer of metadata buffer or NULL (if error)
diff --git a/drivers/staging/media/atomisp/pci/ia_css_types.h b/drivers/staging/media/atomisp/pci/ia_css_types.h
index 6e34d401f9df..f5df564c86e8 100644
--- a/drivers/staging/media/atomisp/pci/ia_css_types.h
+++ b/drivers/staging/media/atomisp/pci/ia_css_types.h
@@ -84,6 +84,8 @@ struct ia_css_state_memory_offsets;
 /* Virtual address within the CSS address space. */
 typedef u32 ia_css_ptr;
 
+#define SIZE_OF_IA_CSS_PTR		sizeof(uint32_t)
+
 /* Generic resolution structure.
  */
 struct ia_css_resolution {
diff --git a/drivers/staging/media/atomisp/pci/runtime/spctrl/interface/ia_css_spctrl_comm.h b/drivers/staging/media/atomisp/pci/runtime/spctrl/interface/ia_css_spctrl_comm.h
index 78e0f3096f60..de68616482f0 100644
--- a/drivers/staging/media/atomisp/pci/runtime/spctrl/interface/ia_css_spctrl_comm.h
+++ b/drivers/staging/media/atomisp/pci/runtime/spctrl/interface/ia_css_spctrl_comm.h
@@ -16,6 +16,8 @@
 #ifndef __IA_CSS_SPCTRL_COMM_H__
 #define __IA_CSS_SPCTRL_COMM_H__
 
+#include <linux/build_bug.h>
+
 #include <type_support.h>
 
 /* state of SP */
@@ -43,4 +45,6 @@ struct ia_css_sp_init_dmem_cfg {
 	(4 * sizeof(uint32_t)) +		\
 	(1 * sizeof(sp_ID_t))
 
+static_assert(sizeof(struct ia_css_sp_init_dmem_cfg) == SIZE_OF_IA_CSS_SP_INIT_DMEM_CFG_STRUCT);
+
 #endif /* __IA_CSS_SPCTRL_COMM_H__ */
diff --git a/drivers/staging/media/atomisp/pci/sh_css.c b/drivers/staging/media/atomisp/pci/sh_css.c
index 42a69b26db01..e2497fc4dfc9 100644
--- a/drivers/staging/media/atomisp/pci/sh_css.c
+++ b/drivers/staging/media/atomisp/pci/sh_css.c
@@ -1345,47 +1345,9 @@ ia_css_init(struct device *dev, const struct ia_css_env *env,
 {
 	int err;
 	ia_css_spctrl_cfg spctrl_cfg;
-
 	void (*flush_func)(struct ia_css_acc_fw *fw);
 	hrt_data select, enable;
 
-	/*
-	 * The C99 standard does not specify the exact object representation of structs;
-	 * the representation is compiler dependent.
-	 *
-	 * The structs that are communicated between host and SP/ISP should have the
-	 * exact same object representation. The compiler that is used to compile the
-	 * firmware is hivecc.
-	 *
-	 * To check if a different compiler, used to compile a host application, uses
-	 * another object representation, macros are defined specifying the size of
-	 * the structs as expected by the firmware.
-	 *
-	 * A host application shall verify that a sizeof( ) of the struct is equal to
-	 * the SIZE_OF_XXX macro of the corresponding struct. If they are not
-	 * equal, functionality will break.
-	 */
-
-	/* Check struct sh_css_ddr_address_map */
-	COMPILATION_ERROR_IF(sizeof(struct sh_css_ddr_address_map)		!= SIZE_OF_SH_CSS_DDR_ADDRESS_MAP_STRUCT);
-	/* Check struct host_sp_queues */
-	COMPILATION_ERROR_IF(sizeof(struct host_sp_queues)			!= SIZE_OF_HOST_SP_QUEUES_STRUCT);
-	COMPILATION_ERROR_IF(sizeof(struct ia_css_circbuf_desc_s)		!= SIZE_OF_IA_CSS_CIRCBUF_DESC_S_STRUCT);
-	COMPILATION_ERROR_IF(sizeof(struct ia_css_circbuf_elem_s)		!= SIZE_OF_IA_CSS_CIRCBUF_ELEM_S_STRUCT);
-
-	/* Check struct host_sp_communication */
-	COMPILATION_ERROR_IF(sizeof(struct host_sp_communication)		!= SIZE_OF_HOST_SP_COMMUNICATION_STRUCT);
-	COMPILATION_ERROR_IF(sizeof(struct sh_css_event_irq_mask)		!= SIZE_OF_SH_CSS_EVENT_IRQ_MASK_STRUCT);
-
-	/* Check struct sh_css_hmm_buffer */
-	COMPILATION_ERROR_IF(sizeof(struct sh_css_hmm_buffer)			!= SIZE_OF_SH_CSS_HMM_BUFFER_STRUCT);
-	COMPILATION_ERROR_IF(sizeof(struct ia_css_isp_3a_statistics)		!= SIZE_OF_IA_CSS_ISP_3A_STATISTICS_STRUCT);
-	COMPILATION_ERROR_IF(sizeof(struct ia_css_isp_dvs_statistics)		!= SIZE_OF_IA_CSS_ISP_DVS_STATISTICS_STRUCT);
-	COMPILATION_ERROR_IF(sizeof(struct ia_css_metadata)			!= SIZE_OF_IA_CSS_METADATA_STRUCT);
-
-	/* Check struct ia_css_init_dmem_cfg */
-	COMPILATION_ERROR_IF(sizeof(struct ia_css_sp_init_dmem_cfg)		!= SIZE_OF_IA_CSS_SP_INIT_DMEM_CFG_STRUCT);
-
 	if (!env)
 		return -EINVAL;
 
diff --git a/drivers/staging/media/atomisp/pci/sh_css_internal.h b/drivers/staging/media/atomisp/pci/sh_css_internal.h
index bef2b8c5132b..1501046cebb9 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_internal.h
+++ b/drivers/staging/media/atomisp/pci/sh_css_internal.h
@@ -16,11 +16,13 @@
 #ifndef _SH_CSS_INTERNAL_H_
 #define _SH_CSS_INTERNAL_H_
 
+#include <linux/build_bug.h>
+#include <linux/stdarg.h>
+
 #include <system_global.h>
 #include <math_support.h>
 #include <type_support.h>
 #include <platform_support.h>
-#include <linux/stdarg.h>
 
 #include "input_formatter.h"
 #include "input_system.h"
@@ -104,7 +106,6 @@
  */
 #define CALC_ALIGNMENT_MEMBER(x, y)	(CEIL_MUL(x, y) - x)
 #define SIZE_OF_HRT_VADDRESS		sizeof(hive_uint32)
-#define SIZE_OF_IA_CSS_PTR		sizeof(uint32_t)
 
 /* Number of SP's */
 #define NUM_OF_SPS 1
@@ -202,6 +203,8 @@ struct sh_css_ddr_address_map {
 	(SH_CSS_MAX_STAGES * IA_CSS_NUM_MEMORIES * SIZE_OF_HRT_VADDRESS) +	\
 	(16 * SIZE_OF_HRT_VADDRESS))
 
+static_assert(sizeof(struct sh_css_ddr_address_map) == SIZE_OF_SH_CSS_DDR_ADDRESS_MAP_STRUCT);
+
 /* xmem address map allocation per pipeline */
 struct sh_css_ddr_address_map_size {
 	size_t isp_param;
@@ -705,6 +708,8 @@ struct sh_css_hmm_buffer {
 	SIZE_OF_IA_CSS_CLOCK_TICK_STRUCT +			\
 	CALC_ALIGNMENT_MEMBER(SIZE_OF_IA_CSS_CLOCK_TICK_STRUCT, 8))
 
+static_assert(sizeof(struct sh_css_hmm_buffer) == SIZE_OF_SH_CSS_HMM_BUFFER_STRUCT);
+
 enum sh_css_queue_type {
 	sh_css_invalid_queue_type = -1,
 	sh_css_host2sp_buffer_queue,
@@ -724,6 +729,8 @@ struct sh_css_event_irq_mask {
 #define SIZE_OF_SH_CSS_EVENT_IRQ_MASK_STRUCT				\
 	(2 * sizeof(uint16_t))
 
+static_assert(sizeof(struct sh_css_event_irq_mask) == SIZE_OF_SH_CSS_EVENT_IRQ_MASK_STRUCT);
+
 struct host_sp_communication {
 	/*
 	 * Don't use enum host2sp_commands, because the sizeof an enum is
@@ -761,6 +768,8 @@ struct host_sp_communication {
 	((3 + N_CSI_PORTS) * sizeof(uint32_t)) +						\
 	(NR_OF_PIPELINES * SIZE_OF_SH_CSS_EVENT_IRQ_MASK_STRUCT))
 
+static_assert(sizeof(struct host_sp_communication) == SIZE_OF_HOST_SP_COMMUNICATION_STRUCT);
+
 struct host_sp_queues {
 	/*
 	 * Queues for the dynamic frame information,
@@ -831,6 +840,8 @@ struct host_sp_queues {
 #define SIZE_OF_HOST_SP_QUEUES_STRUCT		\
 	(SIZE_OF_QUEUES_ELEMS + SIZE_OF_QUEUES_DESC)
 
+static_assert(sizeof(struct host_sp_queues) == SIZE_OF_HOST_SP_QUEUES_STRUCT);
+
 extern int  __printf(1, 0) (*sh_css_printf)(const char *fmt, va_list args);
 
 static inline void  __printf(1, 2) sh_css_print(const char *fmt, ...)
-- 
2.43.0.rc1.1336.g36b5255a03ac


