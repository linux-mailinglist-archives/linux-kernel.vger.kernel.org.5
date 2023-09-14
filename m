Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71BB79F67E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 03:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjINBsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 21:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjINBsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:48:52 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C8E1727
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 18:48:48 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c3f97f2239so3666535ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 18:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694656127; x=1695260927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7G9SEUQPbBc7hK7MqcgeahM6vrAJ1AHKjUYjsBXeK4U=;
        b=XHurYXWaDyYScXpqXdlWf/P1sKzKTwdH4BhS4nVfIF6rNJ/yYvt/35J1Lp4z58pGtO
         Fn/l5J+bmPuGTSaok+0z9wxj3lK5ursZ/nLVZMWQkccnVDyRqgbC8I4gfx0CpDpJ/XHP
         0Pem6KbO6/8hXEHbqb7tD5uM1tiAhPRKPEr+iIjDwviY9weeX7ukZ71MDJtsU84KarYs
         YltcP3L28WPBnaIZYNDm1gPdzPEuNc1JFoP+eDqTapzCNkEsVyqLEMZ2EVMuTYpMAXGu
         JWuQ2gAuXxOVaW8OBjR4bCzu8PT3ArMJN/XsQegPII83Krmc09dX8OLGTWSbtSq59YFZ
         J8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694656127; x=1695260927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7G9SEUQPbBc7hK7MqcgeahM6vrAJ1AHKjUYjsBXeK4U=;
        b=r1VkHmtBxTsB/eNrSPjZbNJ4V87FoyB4qbrazFensQIfjPMBjFLwqVOchbzGlzHJod
         8ycVx2ZBQIx9YMR7ZD1++LKL2jTQr0iiUB8tXtl5jo6r7wDob3GnJ85nLvvFsARK7LN+
         ygJ2rb7MMfESLY5s0hAWKX12uLzXGYGke4LH33qltjKx6TUMDkNa/bm00mL6OLhmbi8E
         txo6pjqBR/9tbJfbv7YWn78tYBkSHj53pg+jhAJytn3twfhaKrLOKt+YVeHblIYnQXR7
         5QUqT+bBc57F0MKsp3iadjAvHl8584FuAZnwrmV5774EkeI27PBD9d3o77IFtPLAa7A3
         2DmQ==
X-Gm-Message-State: AOJu0YzSm1XZ09wqO7T5Q+478tTpyO9//R4Zw6XZXCRUBxaTW7Frl3El
        69VXkkwOLQ7kvyGms7EQ0e3iaRPy7VM=
X-Google-Smtp-Source: AGHT+IFbGFW+3U06+CjLKFiFdLo5Zi8mm499sOVRPGgccCDsmopa8SPAeHzdu/6vPihn8fjldwF1Cw==
X-Received: by 2002:a17:903:2442:b0:1bd:d911:2a85 with SMTP id l2-20020a170903244200b001bdd9112a85mr5308501pls.12.1694656126867;
        Wed, 13 Sep 2023 18:48:46 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:82b1:d7c2:2eaf:61e7])
        by smtp.gmail.com with ESMTPSA id jw12-20020a170903278c00b001b89891bfc4sm261985plb.199.2023.09.13.18.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 18:48:46 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: import ESP32 core variant
Date:   Wed, 13 Sep 2023 18:48:29 -0700
Message-Id: <20230914014829.683779-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Import processor configuration for the Xtensa core found in Espressif
ESP32 SoC.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 .../variants/esp32/include/variant/core.h     | 655 ++++++++++++++++++
 .../variants/esp32/include/variant/tie-asm.h  | 323 +++++++++
 .../variants/esp32/include/variant/tie.h      | 182 +++++
 3 files changed, 1160 insertions(+)
 create mode 100644 arch/xtensa/variants/esp32/include/variant/core.h
 create mode 100644 arch/xtensa/variants/esp32/include/variant/tie-asm.h
 create mode 100644 arch/xtensa/variants/esp32/include/variant/tie.h

diff --git a/arch/xtensa/variants/esp32/include/variant/core.h b/arch/xtensa/variants/esp32/include/variant/core.h
new file mode 100644
index 000000000000..f3f4e45f001f
--- /dev/null
+++ b/arch/xtensa/variants/esp32/include/variant/core.h
@@ -0,0 +1,655 @@
+/* 
+ * xtensa/config/core-isa.h -- HAL definitions that are dependent on Xtensa
+ *				processor CORE configuration
+ *
+ *  See <xtensa/config/core.h>, which includes this file, for more details.
+ */
+
+/* Xtensa processor core configuration information.
+
+   Copyright (c) 1999-2016 Tensilica Inc.
+
+   Permission is hereby granted, free of charge, to any person obtaining
+   a copy of this software and associated documentation files (the
+   "Software"), to deal in the Software without restriction, including
+   without limitation the rights to use, copy, modify, merge, publish,
+   distribute, sublicense, and/or sell copies of the Software, and to
+   permit persons to whom the Software is furnished to do so, subject to
+   the following conditions:
+
+   The above copyright notice and this permission notice shall be included
+   in all copies or substantial portions of the Software.
+
+   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
+   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  */
+
+#ifndef _XTENSA_CORE_CONFIGURATION_H
+#define _XTENSA_CORE_CONFIGURATION_H
+
+
+/****************************************************************************
+	    Parameters Useful for Any Code, USER or PRIVILEGED
+ ****************************************************************************/
+
+/*
+ *  Note:  Macros of the form XCHAL_HAVE_*** have a value of 1 if the option is
+ *  configured, and a value of 0 otherwise.  These macros are always defined.
+ */
+
+
+/*----------------------------------------------------------------------
+				ISA
+  ----------------------------------------------------------------------*/
+
+#define XCHAL_HAVE_BE			0	/* big-endian byte ordering */
+#define XCHAL_HAVE_WINDOWED		1	/* windowed registers option */
+#define XCHAL_NUM_AREGS			64	/* num of physical addr regs */
+#define XCHAL_NUM_AREGS_LOG2		6	/* log2(XCHAL_NUM_AREGS) */
+#define XCHAL_MAX_INSTRUCTION_SIZE	3	/* max instr bytes (3..8) */
+#define XCHAL_HAVE_DEBUG		1	/* debug option */
+#define XCHAL_HAVE_DENSITY		1	/* 16-bit instructions */
+#define XCHAL_HAVE_LOOPS		1	/* zero-overhead loops */
+#define XCHAL_LOOP_BUFFER_SIZE		256	/* zero-ov. loop instr buffer size */
+#define XCHAL_HAVE_NSA			1	/* NSA/NSAU instructions */
+#define XCHAL_HAVE_MINMAX		1	/* MIN/MAX instructions */
+#define XCHAL_HAVE_SEXT			1	/* SEXT instruction */
+#define XCHAL_HAVE_DEPBITS		0	/* DEPBITS instruction */
+#define XCHAL_HAVE_CLAMPS		1	/* CLAMPS instruction */
+#define XCHAL_HAVE_MUL16		1	/* MUL16S/MUL16U instructions */
+#define XCHAL_HAVE_MUL32		1	/* MULL instruction */
+#define XCHAL_HAVE_MUL32_HIGH		1	/* MULUH/MULSH instructions */
+#define XCHAL_HAVE_DIV32		1	/* QUOS/QUOU/REMS/REMU instructions */
+#define XCHAL_HAVE_L32R			1	/* L32R instruction */
+#define XCHAL_HAVE_ABSOLUTE_LITERALS	0	/* non-PC-rel (extended) L32R */
+#define XCHAL_HAVE_CONST16		0	/* CONST16 instruction */
+#define XCHAL_HAVE_ADDX			1	/* ADDX#/SUBX# instructions */
+#define XCHAL_HAVE_WIDE_BRANCHES	0	/* B*.W18 or B*.W15 instr's */
+#define XCHAL_HAVE_PREDICTED_BRANCHES	0	/* B[EQ/EQZ/NE/NEZ]T instr's */
+#define XCHAL_HAVE_CALL4AND12		1	/* (obsolete option) */
+#define XCHAL_HAVE_ABS			1	/* ABS instruction */
+/*#define XCHAL_HAVE_POPC		0*/	/* POPC instruction */
+/*#define XCHAL_HAVE_CRC		0*/	/* CRC instruction */
+#define XCHAL_HAVE_RELEASE_SYNC		1	/* L32AI/S32RI instructions */
+#define XCHAL_HAVE_S32C1I		1	/* S32C1I instruction */
+#define XCHAL_HAVE_SPECULATION		0	/* speculation */
+#define XCHAL_HAVE_FULL_RESET		1	/* all regs/state reset */
+#define XCHAL_NUM_CONTEXTS		1	/* */
+#define XCHAL_NUM_MISC_REGS		4	/* num of scratch regs (0..4) */
+#define XCHAL_HAVE_TAP_MASTER		0	/* JTAG TAP control instr's */
+#define XCHAL_HAVE_PRID			1	/* processor ID register */
+#define XCHAL_HAVE_EXTERN_REGS		1	/* WER/RER instructions */
+#define XCHAL_HAVE_MX			0	/* MX core (Tensilica internal) */
+#define XCHAL_HAVE_MP_INTERRUPTS	0	/* interrupt distributor port */
+#define XCHAL_HAVE_MP_RUNSTALL		0	/* core RunStall control port */
+#define XCHAL_HAVE_PSO			0	/* Power Shut-Off */
+#define XCHAL_HAVE_PSO_CDM		0	/* core/debug/mem pwr domains */
+#define XCHAL_HAVE_PSO_FULL_RETENTION	0	/* all regs preserved on PSO */
+#define XCHAL_HAVE_THREADPTR		1	/* THREADPTR register */
+#define XCHAL_HAVE_BOOLEANS		1	/* boolean registers */
+#define XCHAL_HAVE_CP			1	/* CPENABLE reg (coprocessor) */
+#define XCHAL_CP_MAXCFG			8	/* max allowed cp id plus one */
+#define XCHAL_HAVE_MAC16		1	/* MAC16 package */
+
+#define XCHAL_HAVE_FUSION		 0	/* Fusion*/
+#define XCHAL_HAVE_FUSION_FP	 0	        /* Fusion FP option */
+#define XCHAL_HAVE_FUSION_LOW_POWER 0	/* Fusion Low Power option */
+#define XCHAL_HAVE_FUSION_AES	 0	        /* Fusion BLE/Wifi AES-128 CCM option */
+#define XCHAL_HAVE_FUSION_CONVENC	 0       /* Fusion Conv Encode option */
+#define XCHAL_HAVE_FUSION_LFSR_CRC	 0	/* Fusion LFSR-CRC option */
+#define XCHAL_HAVE_FUSION_BITOPS	 0	/* Fusion Bit Operations Support option */
+#define XCHAL_HAVE_FUSION_AVS	 0	/* Fusion AVS option */
+#define XCHAL_HAVE_FUSION_16BIT_BASEBAND	 0	/* Fusion 16-bit Baseband option */
+#define XCHAL_HAVE_FUSION_VITERBI        0     /* Fusion Viterbi option */
+#define XCHAL_HAVE_FUSION_SOFTDEMAP      0   /* Fusion Soft Bit Demap option */
+#define XCHAL_HAVE_HIFIPRO		0	/* HiFiPro Audio Engine pkg */
+#define XCHAL_HAVE_HIFI4		0	/* HiFi4 Audio Engine pkg */
+#define XCHAL_HAVE_HIFI4_VFPU		0	/* HiFi4 Audio Engine VFPU option */
+#define XCHAL_HAVE_HIFI3		0	/* HiFi3 Audio Engine pkg */
+#define XCHAL_HAVE_HIFI3_VFPU		0	/* HiFi3 Audio Engine VFPU option */
+#define XCHAL_HAVE_HIFI2		0	/* HiFi2 Audio Engine pkg */
+#define XCHAL_HAVE_HIFI2EP		0	/* HiFi2EP */
+#define XCHAL_HAVE_HIFI_MINI		0	
+
+
+#define XCHAL_HAVE_VECTORFPU2005	0	/* vector or user floating-point pkg */
+#define XCHAL_HAVE_USER_DPFPU         0       /* user DP floating-point pkg */
+#define XCHAL_HAVE_USER_SPFPU         0       /* user DP floating-point pkg */
+#define XCHAL_HAVE_FP                 1      /* single prec floating point */
+#define XCHAL_HAVE_FP_DIV             1  /* FP with DIV instructions */
+#define XCHAL_HAVE_FP_RECIP           1        /* FP with RECIP instructions */
+#define XCHAL_HAVE_FP_SQRT            1 /* FP with SQRT instructions */
+#define XCHAL_HAVE_FP_RSQRT           1        /* FP with RSQRT instructions */
+#define XCHAL_HAVE_DFP                        0     /* double precision FP pkg */
+#define XCHAL_HAVE_DFP_DIV            0 /* DFP with DIV instructions */
+#define XCHAL_HAVE_DFP_RECIP          0       /* DFP with RECIP instructions*/
+#define XCHAL_HAVE_DFP_SQRT           0        /* DFP with SQRT instructions */
+#define XCHAL_HAVE_DFP_RSQRT          0       /* DFP with RSQRT instructions*/
+#define XCHAL_HAVE_DFP_ACCEL		1	/* double precision FP acceleration pkg */
+#define XCHAL_HAVE_DFP_accel		XCHAL_HAVE_DFP_ACCEL				/* for backward compatibility */
+
+#define XCHAL_HAVE_DFPU_SINGLE_ONLY    1                 	/* DFPU Coprocessor, single precision only */
+#define XCHAL_HAVE_DFPU_SINGLE_DOUBLE  0               	/* DFPU Coprocessor, single and double precision */
+#define XCHAL_HAVE_VECTRA1		0	/* Vectra I  pkg */
+#define XCHAL_HAVE_VECTRALX		0	/* Vectra LX pkg */
+#define XCHAL_HAVE_PDX4		        0	/* PDX4 */
+#define XCHAL_HAVE_CONNXD2		0	/* ConnX D2 pkg */
+#define XCHAL_HAVE_CONNXD2_DUALLSFLIX   0	/* ConnX D2 & Dual LoadStore Flix */
+#define XCHAL_HAVE_BBE16		0	/* ConnX BBE16 pkg */
+#define XCHAL_HAVE_BBE16_RSQRT		0	/* BBE16 & vector recip sqrt */
+#define XCHAL_HAVE_BBE16_VECDIV		0	/* BBE16 & vector divide */
+#define XCHAL_HAVE_BBE16_DESPREAD	0	/* BBE16 & despread */
+#define XCHAL_HAVE_BBENEP		0	/* ConnX BBENEP pkgs */
+#define XCHAL_HAVE_BSP3			0	/* ConnX BSP3 pkg */
+#define XCHAL_HAVE_BSP3_TRANSPOSE	0	/* BSP3 & transpose32x32 */
+#define XCHAL_HAVE_SSP16		0	/* ConnX SSP16 pkg */
+#define XCHAL_HAVE_SSP16_VITERBI	0	/* SSP16 & viterbi */
+#define XCHAL_HAVE_TURBO16		0	/* ConnX Turbo16 pkg */
+#define XCHAL_HAVE_BBP16		0	/* ConnX BBP16 pkg */
+#define XCHAL_HAVE_FLIX3		0	/* basic 3-way FLIX option */
+#define XCHAL_HAVE_GRIVPEP              0   /*  GRIVPEP is General Release of IVPEP */
+#define XCHAL_HAVE_GRIVPEP_HISTOGRAM    0   /* Histogram option on GRIVPEP */
+
+
+/*----------------------------------------------------------------------
+				MISC
+  ----------------------------------------------------------------------*/
+
+#define XCHAL_NUM_LOADSTORE_UNITS	1	/* load/store units */
+#define XCHAL_NUM_WRITEBUFFER_ENTRIES	4	/* size of write buffer */
+#define XCHAL_INST_FETCH_WIDTH		4	/* instr-fetch width in bytes */
+#define XCHAL_DATA_WIDTH		4	/* data width in bytes */
+#define XCHAL_DATA_PIPE_DELAY		2	/* d-side pipeline delay
+						   (1 = 5-stage, 2 = 7-stage) */
+#define XCHAL_CLOCK_GATING_GLOBAL	1	/* global clock gating */
+#define XCHAL_CLOCK_GATING_FUNCUNIT	1	/* funct. unit clock gating */
+/*  In T1050, applies to selected core load and store instructions (see ISA): */
+#define XCHAL_UNALIGNED_LOAD_EXCEPTION	0	/* unaligned loads cause exc. */
+#define XCHAL_UNALIGNED_STORE_EXCEPTION	0	/* unaligned stores cause exc.*/
+#define XCHAL_UNALIGNED_LOAD_HW		1	/* unaligned loads work in hw */
+#define XCHAL_UNALIGNED_STORE_HW	1	/* unaligned stores work in hw*/
+
+#define XCHAL_SW_VERSION		1100003	/* sw version of this header */
+
+#define XCHAL_CORE_ID			"esp32_v3_49_prod"	/* alphanum core name
+						   (CoreID) set in the Xtensa
+						   Processor Generator */
+
+#define XCHAL_BUILD_UNIQUE_ID		0x0005FE96	/* 22-bit sw build ID */
+
+/*
+ *  These definitions describe the hardware targeted by this software.
+ */
+#define XCHAL_HW_CONFIGID0		0xC2BCFFFE	/* ConfigID hi 32 bits*/
+#define XCHAL_HW_CONFIGID1		0x1CC5FE96	/* ConfigID lo 32 bits*/
+#define XCHAL_HW_VERSION_NAME		"LX6.0.3"	/* full version name */
+#define XCHAL_HW_VERSION_MAJOR		2600	/* major ver# of targeted hw */
+#define XCHAL_HW_VERSION_MINOR		3	/* minor ver# of targeted hw */
+#define XCHAL_HW_VERSION		260003	/* major*100+minor */
+#define XCHAL_HW_REL_LX6		1
+#define XCHAL_HW_REL_LX6_0		1
+#define XCHAL_HW_REL_LX6_0_3		1
+#define XCHAL_HW_CONFIGID_RELIABLE	1
+/*  If software targets a *range* of hardware versions, these are the bounds: */
+#define XCHAL_HW_MIN_VERSION_MAJOR	2600	/* major v of earliest tgt hw */
+#define XCHAL_HW_MIN_VERSION_MINOR	3	/* minor v of earliest tgt hw */
+#define XCHAL_HW_MIN_VERSION		260003	/* earliest targeted hw */
+#define XCHAL_HW_MAX_VERSION_MAJOR	2600	/* major v of latest tgt hw */
+#define XCHAL_HW_MAX_VERSION_MINOR	3	/* minor v of latest tgt hw */
+#define XCHAL_HW_MAX_VERSION		260003	/* latest targeted hw */
+
+
+/*----------------------------------------------------------------------
+				CACHE
+  ----------------------------------------------------------------------*/
+
+#define XCHAL_ICACHE_LINESIZE		4	/* I-cache line size in bytes */
+#define XCHAL_DCACHE_LINESIZE		4	/* D-cache line size in bytes */
+#define XCHAL_ICACHE_LINEWIDTH		2	/* log2(I line size in bytes) */
+#define XCHAL_DCACHE_LINEWIDTH		2	/* log2(D line size in bytes) */
+
+#define XCHAL_ICACHE_SIZE		0	/* I-cache size in bytes or 0 */
+#define XCHAL_DCACHE_SIZE		0	/* D-cache size in bytes or 0 */
+
+#define XCHAL_DCACHE_IS_WRITEBACK	0	/* writeback feature */
+#define XCHAL_DCACHE_IS_COHERENT	0	/* MP coherence feature */
+
+#define XCHAL_HAVE_PREFETCH		0	/* PREFCTL register */
+#define XCHAL_HAVE_PREFETCH_L1		0	/* prefetch to L1 dcache */
+#define XCHAL_PREFETCH_CASTOUT_LINES	0	/* dcache pref. castout bufsz */
+#define XCHAL_PREFETCH_ENTRIES		0	/* cache prefetch entries */
+#define XCHAL_PREFETCH_BLOCK_ENTRIES	0	/* prefetch block streams */
+#define XCHAL_HAVE_CACHE_BLOCKOPS	0	/* block prefetch for caches */
+#define XCHAL_HAVE_ICACHE_TEST		0	/* Icache test instructions */
+#define XCHAL_HAVE_DCACHE_TEST		0	/* Dcache test instructions */
+#define XCHAL_HAVE_ICACHE_DYN_WAYS	0	/* Icache dynamic way support */
+#define XCHAL_HAVE_DCACHE_DYN_WAYS	0	/* Dcache dynamic way support */
+
+
+
+
+/****************************************************************************
+    Parameters Useful for PRIVILEGED (Supervisory or Non-Virtualized) Code
+ ****************************************************************************/
+
+
+#ifndef XTENSA_HAL_NON_PRIVILEGED_ONLY
+
+/*----------------------------------------------------------------------
+				CACHE
+  ----------------------------------------------------------------------*/
+
+#define XCHAL_HAVE_PIF			1	/* any outbound PIF present */
+#define XCHAL_HAVE_AXI			0	/* AXI bus */
+
+#define XCHAL_HAVE_PIF_WR_RESP			0	/* pif write response */
+#define XCHAL_HAVE_PIF_REQ_ATTR			0	/* pif attribute */
+
+/*  If present, cache size in bytes == (ways * 2^(linewidth + setwidth)).  */
+
+/*  Number of cache sets in log2(lines per way):  */
+#define XCHAL_ICACHE_SETWIDTH		0
+#define XCHAL_DCACHE_SETWIDTH		0
+
+/*  Cache set associativity (number of ways):  */
+#define XCHAL_ICACHE_WAYS		1
+#define XCHAL_DCACHE_WAYS		1
+
+/*  Cache features:  */
+#define XCHAL_ICACHE_LINE_LOCKABLE	0
+#define XCHAL_DCACHE_LINE_LOCKABLE	0
+#define XCHAL_ICACHE_ECC_PARITY		0
+#define XCHAL_DCACHE_ECC_PARITY		0
+
+/*  Cache access size in bytes (affects operation of SICW instruction):  */
+#define XCHAL_ICACHE_ACCESS_SIZE	1
+#define XCHAL_DCACHE_ACCESS_SIZE	1
+
+#define XCHAL_DCACHE_BANKS		0	/* number of banks */
+
+/*  Number of encoded cache attr bits (see <xtensa/hal.h> for decoded bits):  */
+#define XCHAL_CA_BITS			4
+
+
+/*----------------------------------------------------------------------
+			INTERNAL I/D RAM/ROMs and XLMI
+  ----------------------------------------------------------------------*/
+
+#define XCHAL_NUM_INSTROM		1	/* number of core instr. ROMs */
+#define XCHAL_NUM_INSTRAM		2	/* number of core instr. RAMs */
+#define XCHAL_NUM_DATAROM		1	/* number of core data ROMs */
+#define XCHAL_NUM_DATARAM		2	/* number of core data RAMs */
+#define XCHAL_NUM_URAM			0	/* number of core unified RAMs*/
+#define XCHAL_NUM_XLMI			1	/* number of core XLMI ports */
+
+/*  Instruction ROM 0:  */
+#define XCHAL_INSTROM0_VADDR		0x40800000	/* virtual address */
+#define XCHAL_INSTROM0_PADDR		0x40800000	/* physical address */
+#define XCHAL_INSTROM0_SIZE		4194304	/* size in bytes */
+#define XCHAL_INSTROM0_ECC_PARITY	0	/* ECC/parity type, 0=none */
+
+/*  Instruction RAM 0:  */
+#define XCHAL_INSTRAM0_VADDR		0x40000000	/* virtual address */
+#define XCHAL_INSTRAM0_PADDR		0x40000000	/* physical address */
+#define XCHAL_INSTRAM0_SIZE		4194304	/* size in bytes */
+#define XCHAL_INSTRAM0_ECC_PARITY	0	/* ECC/parity type, 0=none */
+
+/*  Instruction RAM 1:  */
+#define XCHAL_INSTRAM1_VADDR		0x40400000	/* virtual address */
+#define XCHAL_INSTRAM1_PADDR		0x40400000	/* physical address */
+#define XCHAL_INSTRAM1_SIZE		4194304	/* size in bytes */
+#define XCHAL_INSTRAM1_ECC_PARITY	0	/* ECC/parity type, 0=none */
+
+/*  Data ROM 0:  */
+#define XCHAL_DATAROM0_VADDR		0x3F400000	/* virtual address */
+#define XCHAL_DATAROM0_PADDR		0x3F400000	/* physical address */
+#define XCHAL_DATAROM0_SIZE		4194304	/* size in bytes */
+#define XCHAL_DATAROM0_ECC_PARITY	0	/* ECC/parity type, 0=none */
+#define XCHAL_DATAROM0_BANKS		1	/* number of banks */
+
+/*  Data RAM 0:  */
+#define XCHAL_DATARAM0_VADDR		0x3FF80000	/* virtual address */
+#define XCHAL_DATARAM0_PADDR		0x3FF80000	/* physical address */
+#define XCHAL_DATARAM0_SIZE		524288	/* size in bytes */
+#define XCHAL_DATARAM0_ECC_PARITY	0	/* ECC/parity type, 0=none */
+#define XCHAL_DATARAM0_BANKS		1	/* number of banks */
+
+/*  Data RAM 1:  */
+#define XCHAL_DATARAM1_VADDR		0x3F800000	/* virtual address */
+#define XCHAL_DATARAM1_PADDR		0x3F800000	/* physical address */
+#define XCHAL_DATARAM1_SIZE		4194304	/* size in bytes */
+#define XCHAL_DATARAM1_ECC_PARITY	0	/* ECC/parity type, 0=none */
+#define XCHAL_DATARAM1_BANKS		1	/* number of banks */
+
+/*  XLMI Port 0:  */
+#define XCHAL_XLMI0_VADDR		0x3FF00000	/* virtual address */
+#define XCHAL_XLMI0_PADDR		0x3FF00000	/* physical address */
+#define XCHAL_XLMI0_SIZE		524288	/* size in bytes */
+#define XCHAL_XLMI0_ECC_PARITY	0	/* ECC/parity type, 0=none */
+
+#define XCHAL_HAVE_IMEM_LOADSTORE	1	/* can load/store to IROM/IRAM*/
+
+
+/*----------------------------------------------------------------------
+			INTERRUPTS and TIMERS
+  ----------------------------------------------------------------------*/
+
+#define XCHAL_HAVE_INTERRUPTS		1	/* interrupt option */
+#define XCHAL_HAVE_HIGHPRI_INTERRUPTS	1	/* med/high-pri. interrupts */
+#define XCHAL_HAVE_NMI			1	/* non-maskable interrupt */
+#define XCHAL_HAVE_CCOUNT		1	/* CCOUNT reg. (timer option) */
+#define XCHAL_NUM_TIMERS		3	/* number of CCOMPAREn regs */
+#define XCHAL_NUM_INTERRUPTS		32	/* number of interrupts */
+#define XCHAL_NUM_INTERRUPTS_LOG2	5	/* ceil(log2(NUM_INTERRUPTS)) */
+#define XCHAL_NUM_EXTINTERRUPTS		26	/* num of external interrupts */
+#define XCHAL_NUM_INTLEVELS		6	/* number of interrupt levels
+						   (not including level zero) */
+#define XCHAL_EXCM_LEVEL		3	/* level masked by PS.EXCM */
+	/* (always 1 in XEA1; levels 2 .. EXCM_LEVEL are "medium priority") */
+
+/*  Masks of interrupts at each interrupt level:  */
+#define XCHAL_INTLEVEL1_MASK		0x000637FF
+#define XCHAL_INTLEVEL2_MASK		0x00380000
+#define XCHAL_INTLEVEL3_MASK		0x28C08800
+#define XCHAL_INTLEVEL4_MASK		0x53000000
+#define XCHAL_INTLEVEL5_MASK		0x84010000
+#define XCHAL_INTLEVEL6_MASK		0x00000000
+#define XCHAL_INTLEVEL7_MASK		0x00004000
+
+/*  Masks of interrupts at each range 1..n of interrupt levels:  */
+#define XCHAL_INTLEVEL1_ANDBELOW_MASK	0x000637FF
+#define XCHAL_INTLEVEL2_ANDBELOW_MASK	0x003E37FF
+#define XCHAL_INTLEVEL3_ANDBELOW_MASK	0x28FEBFFF
+#define XCHAL_INTLEVEL4_ANDBELOW_MASK	0x7BFEBFFF
+#define XCHAL_INTLEVEL5_ANDBELOW_MASK	0xFFFFBFFF
+#define XCHAL_INTLEVEL6_ANDBELOW_MASK	0xFFFFBFFF
+#define XCHAL_INTLEVEL7_ANDBELOW_MASK	0xFFFFFFFF
+
+/*  Level of each interrupt:  */
+#define XCHAL_INT0_LEVEL		1
+#define XCHAL_INT1_LEVEL		1
+#define XCHAL_INT2_LEVEL		1
+#define XCHAL_INT3_LEVEL		1
+#define XCHAL_INT4_LEVEL		1
+#define XCHAL_INT5_LEVEL		1
+#define XCHAL_INT6_LEVEL		1
+#define XCHAL_INT7_LEVEL		1
+#define XCHAL_INT8_LEVEL		1
+#define XCHAL_INT9_LEVEL		1
+#define XCHAL_INT10_LEVEL		1
+#define XCHAL_INT11_LEVEL		3
+#define XCHAL_INT12_LEVEL		1
+#define XCHAL_INT13_LEVEL		1
+#define XCHAL_INT14_LEVEL		7
+#define XCHAL_INT15_LEVEL		3
+#define XCHAL_INT16_LEVEL		5
+#define XCHAL_INT17_LEVEL		1
+#define XCHAL_INT18_LEVEL		1
+#define XCHAL_INT19_LEVEL		2
+#define XCHAL_INT20_LEVEL		2
+#define XCHAL_INT21_LEVEL		2
+#define XCHAL_INT22_LEVEL		3
+#define XCHAL_INT23_LEVEL		3
+#define XCHAL_INT24_LEVEL		4
+#define XCHAL_INT25_LEVEL		4
+#define XCHAL_INT26_LEVEL		5
+#define XCHAL_INT27_LEVEL		3
+#define XCHAL_INT28_LEVEL		4
+#define XCHAL_INT29_LEVEL		3
+#define XCHAL_INT30_LEVEL		4
+#define XCHAL_INT31_LEVEL		5
+#define XCHAL_DEBUGLEVEL		6	/* debug interrupt level */
+#define XCHAL_HAVE_DEBUG_EXTERN_INT	1	/* OCD external db interrupt */
+#define XCHAL_NMILEVEL			7	/* NMI "level" (for use with
+						   EXCSAVE/EPS/EPC_n, RFI n) */
+
+/*  Type of each interrupt:  */
+#define XCHAL_INT0_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+#define XCHAL_INT1_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+#define XCHAL_INT2_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+#define XCHAL_INT3_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+#define XCHAL_INT4_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+#define XCHAL_INT5_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+#define XCHAL_INT6_TYPE 	XTHAL_INTTYPE_TIMER
+#define XCHAL_INT7_TYPE 	XTHAL_INTTYPE_SOFTWARE
+#define XCHAL_INT8_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+#define XCHAL_INT9_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+#define XCHAL_INT10_TYPE 	XTHAL_INTTYPE_EXTERN_EDGE
+#define XCHAL_INT11_TYPE 	XTHAL_INTTYPE_PROFILING
+#define XCHAL_INT12_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+#define XCHAL_INT13_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+#define XCHAL_INT14_TYPE 	XTHAL_INTTYPE_NMI
+#define XCHAL_INT15_TYPE 	XTHAL_INTTYPE_TIMER
+#define XCHAL_INT16_TYPE 	XTHAL_INTTYPE_TIMER
+#define XCHAL_INT17_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+#define XCHAL_INT18_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+#define XCHAL_INT19_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+#define XCHAL_INT20_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+#define XCHAL_INT21_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+#define XCHAL_INT22_TYPE 	XTHAL_INTTYPE_EXTERN_EDGE
+#define XCHAL_INT23_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+#define XCHAL_INT24_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+#define XCHAL_INT25_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+#define XCHAL_INT26_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+#define XCHAL_INT27_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+#define XCHAL_INT28_TYPE 	XTHAL_INTTYPE_EXTERN_EDGE
+#define XCHAL_INT29_TYPE 	XTHAL_INTTYPE_SOFTWARE
+#define XCHAL_INT30_TYPE 	XTHAL_INTTYPE_EXTERN_EDGE
+#define XCHAL_INT31_TYPE 	XTHAL_INTTYPE_EXTERN_LEVEL
+
+/*  Masks of interrupts for each type of interrupt:  */
+#define XCHAL_INTTYPE_MASK_UNCONFIGURED	0x00000000
+#define XCHAL_INTTYPE_MASK_SOFTWARE	0x20000080
+#define XCHAL_INTTYPE_MASK_EXTERN_EDGE	0x50400400
+#define XCHAL_INTTYPE_MASK_EXTERN_LEVEL	0x8FBE333F
+#define XCHAL_INTTYPE_MASK_TIMER	0x00018040
+#define XCHAL_INTTYPE_MASK_NMI		0x00004000
+#define XCHAL_INTTYPE_MASK_WRITE_ERROR	0x00000000
+#define XCHAL_INTTYPE_MASK_PROFILING	0x00000800
+
+/*  Interrupt numbers assigned to specific interrupt sources:  */
+#define XCHAL_TIMER0_INTERRUPT		6	/* CCOMPARE0 */
+#define XCHAL_TIMER1_INTERRUPT		15	/* CCOMPARE1 */
+#define XCHAL_TIMER2_INTERRUPT		16	/* CCOMPARE2 */
+#define XCHAL_TIMER3_INTERRUPT		XTHAL_TIMER_UNCONFIGURED
+#define XCHAL_NMI_INTERRUPT		14	/* non-maskable interrupt */
+#define XCHAL_PROFILING_INTERRUPT	11	/* profiling interrupt */
+
+/*  Interrupt numbers for levels at which only one interrupt is configured:  */
+#define XCHAL_INTLEVEL7_NUM		14
+/*  (There are many interrupts each at level(s) 1, 2, 3, 4, 5.)  */
+
+
+/*
+ *  External interrupt mapping.
+ *  These macros describe how Xtensa processor interrupt numbers
+ *  (as numbered internally, eg. in INTERRUPT and INTENABLE registers)
+ *  map to external BInterrupt<n> pins, for those interrupts
+ *  configured as external (level-triggered, edge-triggered, or NMI).
+ *  See the Xtensa processor databook for more details.
+ */
+
+/*  Core interrupt numbers mapped to each EXTERNAL BInterrupt pin number:  */
+#define XCHAL_EXTINT0_NUM		0	/* (intlevel 1) */
+#define XCHAL_EXTINT1_NUM		1	/* (intlevel 1) */
+#define XCHAL_EXTINT2_NUM		2	/* (intlevel 1) */
+#define XCHAL_EXTINT3_NUM		3	/* (intlevel 1) */
+#define XCHAL_EXTINT4_NUM		4	/* (intlevel 1) */
+#define XCHAL_EXTINT5_NUM		5	/* (intlevel 1) */
+#define XCHAL_EXTINT6_NUM		8	/* (intlevel 1) */
+#define XCHAL_EXTINT7_NUM		9	/* (intlevel 1) */
+#define XCHAL_EXTINT8_NUM		10	/* (intlevel 1) */
+#define XCHAL_EXTINT9_NUM		12	/* (intlevel 1) */
+#define XCHAL_EXTINT10_NUM		13	/* (intlevel 1) */
+#define XCHAL_EXTINT11_NUM		14	/* (intlevel 7) */
+#define XCHAL_EXTINT12_NUM		17	/* (intlevel 1) */
+#define XCHAL_EXTINT13_NUM		18	/* (intlevel 1) */
+#define XCHAL_EXTINT14_NUM		19	/* (intlevel 2) */
+#define XCHAL_EXTINT15_NUM		20	/* (intlevel 2) */
+#define XCHAL_EXTINT16_NUM		21	/* (intlevel 2) */
+#define XCHAL_EXTINT17_NUM		22	/* (intlevel 3) */
+#define XCHAL_EXTINT18_NUM		23	/* (intlevel 3) */
+#define XCHAL_EXTINT19_NUM		24	/* (intlevel 4) */
+#define XCHAL_EXTINT20_NUM		25	/* (intlevel 4) */
+#define XCHAL_EXTINT21_NUM		26	/* (intlevel 5) */
+#define XCHAL_EXTINT22_NUM		27	/* (intlevel 3) */
+#define XCHAL_EXTINT23_NUM		28	/* (intlevel 4) */
+#define XCHAL_EXTINT24_NUM		30	/* (intlevel 4) */
+#define XCHAL_EXTINT25_NUM		31	/* (intlevel 5) */
+/*  EXTERNAL BInterrupt pin numbers mapped to each core interrupt number:  */
+#define XCHAL_INT0_EXTNUM		0	/* (intlevel 1) */
+#define XCHAL_INT1_EXTNUM		1	/* (intlevel 1) */
+#define XCHAL_INT2_EXTNUM		2	/* (intlevel 1) */
+#define XCHAL_INT3_EXTNUM		3	/* (intlevel 1) */
+#define XCHAL_INT4_EXTNUM		4	/* (intlevel 1) */
+#define XCHAL_INT5_EXTNUM		5	/* (intlevel 1) */
+#define XCHAL_INT8_EXTNUM		6	/* (intlevel 1) */
+#define XCHAL_INT9_EXTNUM		7	/* (intlevel 1) */
+#define XCHAL_INT10_EXTNUM		8	/* (intlevel 1) */
+#define XCHAL_INT12_EXTNUM		9	/* (intlevel 1) */
+#define XCHAL_INT13_EXTNUM		10	/* (intlevel 1) */
+#define XCHAL_INT14_EXTNUM		11	/* (intlevel 7) */
+#define XCHAL_INT17_EXTNUM		12	/* (intlevel 1) */
+#define XCHAL_INT18_EXTNUM		13	/* (intlevel 1) */
+#define XCHAL_INT19_EXTNUM		14	/* (intlevel 2) */
+#define XCHAL_INT20_EXTNUM		15	/* (intlevel 2) */
+#define XCHAL_INT21_EXTNUM		16	/* (intlevel 2) */
+#define XCHAL_INT22_EXTNUM		17	/* (intlevel 3) */
+#define XCHAL_INT23_EXTNUM		18	/* (intlevel 3) */
+#define XCHAL_INT24_EXTNUM		19	/* (intlevel 4) */
+#define XCHAL_INT25_EXTNUM		20	/* (intlevel 4) */
+#define XCHAL_INT26_EXTNUM		21	/* (intlevel 5) */
+#define XCHAL_INT27_EXTNUM		22	/* (intlevel 3) */
+#define XCHAL_INT28_EXTNUM		23	/* (intlevel 4) */
+#define XCHAL_INT30_EXTNUM		24	/* (intlevel 4) */
+#define XCHAL_INT31_EXTNUM		25	/* (intlevel 5) */
+
+
+/*----------------------------------------------------------------------
+			EXCEPTIONS and VECTORS
+  ----------------------------------------------------------------------*/
+
+#define XCHAL_XEA_VERSION		2	/* Xtensa Exception Architecture
+						   number: 1 == XEA1 (old)
+							   2 == XEA2 (new)
+							   0 == XEAX (extern) or TX */
+#define XCHAL_HAVE_XEA1			0	/* Exception Architecture 1 */
+#define XCHAL_HAVE_XEA2			1	/* Exception Architecture 2 */
+#define XCHAL_HAVE_XEAX			0	/* External Exception Arch. */
+#define XCHAL_HAVE_EXCEPTIONS		1	/* exception option */
+#define XCHAL_HAVE_HALT			0	/* halt architecture option */
+#define XCHAL_HAVE_BOOTLOADER		0	/* boot loader (for TX) */
+#define XCHAL_HAVE_MEM_ECC_PARITY	0	/* local memory ECC/parity */
+#define XCHAL_HAVE_VECTOR_SELECT	1	/* relocatable vectors */
+#define XCHAL_HAVE_VECBASE		1	/* relocatable vectors */
+#define XCHAL_VECBASE_RESET_VADDR	0x40000000  /* VECBASE reset value */
+#define XCHAL_VECBASE_RESET_PADDR	0x40000000
+#define XCHAL_RESET_VECBASE_OVERLAP	0
+
+#define XCHAL_RESET_VECTOR0_VADDR	0x50000000
+#define XCHAL_RESET_VECTOR0_PADDR	0x50000000
+#define XCHAL_RESET_VECTOR1_VADDR	0x40000400
+#define XCHAL_RESET_VECTOR1_PADDR	0x40000400
+#define XCHAL_RESET_VECTOR_VADDR	0x40000400
+#define XCHAL_RESET_VECTOR_PADDR	0x40000400
+#define XCHAL_USER_VECOFS		0x00000340
+#define XCHAL_USER_VECTOR_VADDR		0x40000340
+#define XCHAL_USER_VECTOR_PADDR		0x40000340
+#define XCHAL_KERNEL_VECOFS		0x00000300
+#define XCHAL_KERNEL_VECTOR_VADDR	0x40000300
+#define XCHAL_KERNEL_VECTOR_PADDR	0x40000300
+#define XCHAL_DOUBLEEXC_VECOFS		0x000003C0
+#define XCHAL_DOUBLEEXC_VECTOR_VADDR	0x400003C0
+#define XCHAL_DOUBLEEXC_VECTOR_PADDR	0x400003C0
+#define XCHAL_WINDOW_OF4_VECOFS		0x00000000
+#define XCHAL_WINDOW_UF4_VECOFS		0x00000040
+#define XCHAL_WINDOW_OF8_VECOFS		0x00000080
+#define XCHAL_WINDOW_UF8_VECOFS		0x000000C0
+#define XCHAL_WINDOW_OF12_VECOFS	0x00000100
+#define XCHAL_WINDOW_UF12_VECOFS	0x00000140
+#define XCHAL_WINDOW_VECTORS_VADDR	0x40000000
+#define XCHAL_WINDOW_VECTORS_PADDR	0x40000000
+#define XCHAL_INTLEVEL2_VECOFS		0x00000180
+#define XCHAL_INTLEVEL2_VECTOR_VADDR	0x40000180
+#define XCHAL_INTLEVEL2_VECTOR_PADDR	0x40000180
+#define XCHAL_INTLEVEL3_VECOFS		0x000001C0
+#define XCHAL_INTLEVEL3_VECTOR_VADDR	0x400001C0
+#define XCHAL_INTLEVEL3_VECTOR_PADDR	0x400001C0
+#define XCHAL_INTLEVEL4_VECOFS		0x00000200
+#define XCHAL_INTLEVEL4_VECTOR_VADDR	0x40000200
+#define XCHAL_INTLEVEL4_VECTOR_PADDR	0x40000200
+#define XCHAL_INTLEVEL5_VECOFS		0x00000240
+#define XCHAL_INTLEVEL5_VECTOR_VADDR	0x40000240
+#define XCHAL_INTLEVEL5_VECTOR_PADDR	0x40000240
+#define XCHAL_INTLEVEL6_VECOFS		0x00000280
+#define XCHAL_INTLEVEL6_VECTOR_VADDR	0x40000280
+#define XCHAL_INTLEVEL6_VECTOR_PADDR	0x40000280
+#define XCHAL_DEBUG_VECOFS		XCHAL_INTLEVEL6_VECOFS
+#define XCHAL_DEBUG_VECTOR_VADDR	XCHAL_INTLEVEL6_VECTOR_VADDR
+#define XCHAL_DEBUG_VECTOR_PADDR	XCHAL_INTLEVEL6_VECTOR_PADDR
+#define XCHAL_NMI_VECOFS		0x000002C0
+#define XCHAL_NMI_VECTOR_VADDR		0x400002C0
+#define XCHAL_NMI_VECTOR_PADDR		0x400002C0
+#define XCHAL_INTLEVEL7_VECOFS		XCHAL_NMI_VECOFS
+#define XCHAL_INTLEVEL7_VECTOR_VADDR	XCHAL_NMI_VECTOR_VADDR
+#define XCHAL_INTLEVEL7_VECTOR_PADDR	XCHAL_NMI_VECTOR_PADDR
+
+
+/*----------------------------------------------------------------------
+				DEBUG MODULE
+  ----------------------------------------------------------------------*/
+
+/*  Misc  */
+#define XCHAL_HAVE_DEBUG_ERI		1	/* ERI to debug module */
+#define XCHAL_HAVE_DEBUG_APB		1	/* APB to debug module */
+#define XCHAL_HAVE_DEBUG_JTAG		1	/* JTAG to debug module */
+
+/*  On-Chip Debug (OCD)  */
+#define XCHAL_HAVE_OCD			1	/* OnChipDebug option */
+#define XCHAL_NUM_IBREAK		2	/* number of IBREAKn regs */
+#define XCHAL_NUM_DBREAK		2	/* number of DBREAKn regs */
+#define XCHAL_HAVE_OCD_DIR_ARRAY	0	/* faster OCD option (to LX4) */
+#define XCHAL_HAVE_OCD_LS32DDR		1	/* L32DDR/S32DDR (faster OCD) */
+
+/*  TRAX (in core)  */
+#define XCHAL_HAVE_TRAX			1	/* TRAX in debug module */
+#define XCHAL_TRAX_MEM_SIZE		16384	/* TRAX memory size in bytes */
+#define XCHAL_TRAX_MEM_SHAREABLE	1	/* start/end regs; ready sig. */
+#define XCHAL_TRAX_ATB_WIDTH		32	/* ATB width (bits), 0=no ATB */
+#define XCHAL_TRAX_TIME_WIDTH		0	/* timestamp bitwidth, 0=none */
+
+/*  Perf counters  */
+#define XCHAL_NUM_PERF_COUNTERS		2	/* performance counters */
+
+
+/*----------------------------------------------------------------------
+				MMU
+  ----------------------------------------------------------------------*/
+
+/*  See core-matmap.h header file for more details.  */
+
+#define XCHAL_HAVE_TLBS			1	/* inverse of HAVE_CACHEATTR */
+#define XCHAL_HAVE_SPANNING_WAY		1	/* one way maps I+D 4GB vaddr */
+#define XCHAL_SPANNING_WAY		0	/* TLB spanning way number */
+#define XCHAL_HAVE_IDENTITY_MAP		1	/* vaddr == paddr always */
+#define XCHAL_HAVE_CACHEATTR		0	/* CACHEATTR register present */
+#define XCHAL_HAVE_MIMIC_CACHEATTR	1	/* region protection */
+#define XCHAL_HAVE_XLT_CACHEATTR	0	/* region prot. w/translation */
+#define XCHAL_HAVE_PTP_MMU		0	/* full MMU (with page table
+						   [autorefill] and protection)
+						   usable for an MMU-based OS */
+/*  If none of the above last 4 are set, it's a custom TLB configuration.  */
+
+#define XCHAL_MMU_ASID_BITS		0	/* number of bits in ASIDs */
+#define XCHAL_MMU_RINGS			1	/* number of rings (1..4) */
+#define XCHAL_MMU_RING_BITS		0	/* num of bits in RING field */
+
+#endif /* !XTENSA_HAL_NON_PRIVILEGED_ONLY */
+
+
+#endif /* _XTENSA_CORE_CONFIGURATION_H */
+
diff --git a/arch/xtensa/variants/esp32/include/variant/tie-asm.h b/arch/xtensa/variants/esp32/include/variant/tie-asm.h
new file mode 100644
index 000000000000..831d8676ae2c
--- /dev/null
+++ b/arch/xtensa/variants/esp32/include/variant/tie-asm.h
@@ -0,0 +1,323 @@
+/* 
+ * tie-asm.h -- compile-time HAL assembler definitions dependent on CORE & TIE
+ *
+ *  NOTE:  This header file is not meant to be included directly.
+ */
+
+/* This header file contains assembly-language definitions (assembly
+   macros, etc.) for this specific Xtensa processor's TIE extensions
+   and options.  It is customized to this Xtensa processor configuration.
+
+   Customer ID=11657; Build=0x5fe96; Copyright (c) 1999-2016 Cadence Design Systems Inc.
+
+   Permission is hereby granted, free of charge, to any person obtaining
+   a copy of this software and associated documentation files (the
+   "Software"), to deal in the Software without restriction, including
+   without limitation the rights to use, copy, modify, merge, publish,
+   distribute, sublicense, and/or sell copies of the Software, and to
+   permit persons to whom the Software is furnished to do so, subject to
+   the following conditions:
+
+   The above copyright notice and this permission notice shall be included
+   in all copies or substantial portions of the Software.
+
+   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
+   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  */
+
+#ifndef _XTENSA_CORE_TIE_ASM_H
+#define _XTENSA_CORE_TIE_ASM_H
+
+/*  Selection parameter values for save-area save/restore macros:  */
+/*  Option vs. TIE:  */
+#define XTHAL_SAS_TIE	0x0001	/* custom extension or coprocessor */
+#define XTHAL_SAS_OPT	0x0002	/* optional (and not a coprocessor) */
+#define XTHAL_SAS_ANYOT	0x0003	/* both of the above */
+/*  Whether used automatically by compiler:  */
+#define XTHAL_SAS_NOCC	0x0004	/* not used by compiler w/o special opts/code */
+#define XTHAL_SAS_CC	0x0008	/* used by compiler without special opts/code */
+#define XTHAL_SAS_ANYCC	0x000C	/* both of the above */
+/*  ABI handling across function calls:  */
+#define XTHAL_SAS_CALR	0x0010	/* caller-saved */
+#define XTHAL_SAS_CALE	0x0020	/* callee-saved */
+#define XTHAL_SAS_GLOB	0x0040	/* global across function calls (in thread) */
+#define XTHAL_SAS_ANYABI	0x0070	/* all of the above three */
+/*  Misc  */
+#define XTHAL_SAS_ALL	0xFFFF	/* include all default NCP contents */
+#define XTHAL_SAS3(optie,ccuse,abi)	( ((optie) & XTHAL_SAS_ANYOT)  \
+					| ((ccuse) & XTHAL_SAS_ANYCC)  \
+					| ((abi)   & XTHAL_SAS_ANYABI) )
+
+
+    /*
+      *  Macro to store all non-coprocessor (extra) custom TIE and optional state
+      *  (not including zero-overhead loop registers).
+      *  Required parameters:
+      *      ptr         Save area pointer address register (clobbered)
+      *                  (register must contain a 4 byte aligned address).
+      *      at1..at4    Four temporary address registers (first XCHAL_NCP_NUM_ATMPS
+      *                  registers are clobbered, the remaining are unused).
+      *  Optional parameters:
+      *      continue    If macro invoked as part of a larger store sequence, set to 1
+      *                  if this is not the first in the sequence.  Defaults to 0.
+      *      ofs         Offset from start of larger sequence (from value of first ptr
+      *                  in sequence) at which to store.  Defaults to next available space
+      *                  (or 0 if <continue> is 0).
+      *      select      Select what category(ies) of registers to store, as a bitmask
+      *                  (see XTHAL_SAS_xxx constants).  Defaults to all registers.
+      *      alloc       Select what category(ies) of registers to allocate; if any
+      *                  category is selected here that is not in <select>, space for
+      *                  the corresponding registers is skipped without doing any store.
+      */
+    .macro xchal_ncp_store  ptr at1 at2 at3 at4  continue=0 ofs=-1 select=XTHAL_SAS_ALL alloc=0
+	xchal_sa_start	\continue, \ofs
+	// Optional global registers used by default by the compiler:
+	.ifeq (XTHAL_SAS_OPT | XTHAL_SAS_CC | XTHAL_SAS_GLOB) & ~(\select)
+	xchal_sa_align	\ptr, 0, 1016, 4, 4
+	rur.THREADPTR	\at1		// threadptr option
+	s32i	\at1, \ptr, .Lxchal_ofs_+0
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 4
+	.elseif ((XTHAL_SAS_OPT | XTHAL_SAS_CC | XTHAL_SAS_GLOB) & ~(\alloc)) == 0
+	xchal_sa_align	\ptr, 0, 1016, 4, 4
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 4
+	.endif
+	// Optional caller-saved registers used by default by the compiler:
+	.ifeq (XTHAL_SAS_OPT | XTHAL_SAS_CC | XTHAL_SAS_CALR) & ~(\select)
+	xchal_sa_align	\ptr, 0, 1012, 4, 4
+	rsr.ACCLO	\at1		// MAC16 option
+	s32i	\at1, \ptr, .Lxchal_ofs_+0
+	rsr.ACCHI	\at1		// MAC16 option
+	s32i	\at1, \ptr, .Lxchal_ofs_+4
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 8
+	.elseif ((XTHAL_SAS_OPT | XTHAL_SAS_CC | XTHAL_SAS_CALR) & ~(\alloc)) == 0
+	xchal_sa_align	\ptr, 0, 1012, 4, 4
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 8
+	.endif
+	// Optional caller-saved registers not used by default by the compiler:
+	.ifeq (XTHAL_SAS_OPT | XTHAL_SAS_NOCC | XTHAL_SAS_CALR) & ~(\select)
+	xchal_sa_align	\ptr, 0, 996, 4, 4
+	rsr.BR	\at1		// boolean option
+	s32i	\at1, \ptr, .Lxchal_ofs_+0
+	rsr.SCOMPARE1	\at1		// conditional store option
+	s32i	\at1, \ptr, .Lxchal_ofs_+4
+	rsr.M0	\at1		// MAC16 option
+	s32i	\at1, \ptr, .Lxchal_ofs_+8
+	rsr.M1	\at1		// MAC16 option
+	s32i	\at1, \ptr, .Lxchal_ofs_+12
+	rsr.M2	\at1		// MAC16 option
+	s32i	\at1, \ptr, .Lxchal_ofs_+16
+	rsr.M3	\at1		// MAC16 option
+	s32i	\at1, \ptr, .Lxchal_ofs_+20
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 24
+	.elseif ((XTHAL_SAS_OPT | XTHAL_SAS_NOCC | XTHAL_SAS_CALR) & ~(\alloc)) == 0
+	xchal_sa_align	\ptr, 0, 996, 4, 4
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 24
+	.endif
+	// Custom caller-saved registers not used by default by the compiler:
+	.ifeq (XTHAL_SAS_TIE | XTHAL_SAS_NOCC | XTHAL_SAS_CALR) & ~(\select)
+	xchal_sa_align	\ptr, 0, 1008, 4, 4
+	rur.F64R_LO	\at1		// ureg 234
+	s32i	\at1, \ptr, .Lxchal_ofs_+0
+	rur.F64R_HI	\at1		// ureg 235
+	s32i	\at1, \ptr, .Lxchal_ofs_+4
+	rur.F64S	\at1		// ureg 236
+	s32i	\at1, \ptr, .Lxchal_ofs_+8
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 12
+	.elseif ((XTHAL_SAS_TIE | XTHAL_SAS_NOCC | XTHAL_SAS_CALR) & ~(\alloc)) == 0
+	xchal_sa_align	\ptr, 0, 1008, 4, 4
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 12
+	.endif
+    .endm	// xchal_ncp_store
+
+    /*
+      *  Macro to load all non-coprocessor (extra) custom TIE and optional state
+      *  (not including zero-overhead loop registers).
+      *  Required parameters:
+      *      ptr         Save area pointer address register (clobbered)
+      *                  (register must contain a 4 byte aligned address).
+      *      at1..at4    Four temporary address registers (first XCHAL_NCP_NUM_ATMPS
+      *                  registers are clobbered, the remaining are unused).
+      *  Optional parameters:
+      *      continue    If macro invoked as part of a larger load sequence, set to 1
+      *                  if this is not the first in the sequence.  Defaults to 0.
+      *      ofs         Offset from start of larger sequence (from value of first ptr
+      *                  in sequence) at which to load.  Defaults to next available space
+      *                  (or 0 if <continue> is 0).
+      *      select      Select what category(ies) of registers to load, as a bitmask
+      *                  (see XTHAL_SAS_xxx constants).  Defaults to all registers.
+      *      alloc       Select what category(ies) of registers to allocate; if any
+      *                  category is selected here that is not in <select>, space for
+      *                  the corresponding registers is skipped without doing any load.
+      */
+    .macro xchal_ncp_load  ptr at1 at2 at3 at4  continue=0 ofs=-1 select=XTHAL_SAS_ALL alloc=0
+	xchal_sa_start	\continue, \ofs
+	// Optional global registers used by default by the compiler:
+	.ifeq (XTHAL_SAS_OPT | XTHAL_SAS_CC | XTHAL_SAS_GLOB) & ~(\select)
+	xchal_sa_align	\ptr, 0, 1016, 4, 4
+	l32i	\at1, \ptr, .Lxchal_ofs_+0
+	wur.THREADPTR	\at1		// threadptr option
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 4
+	.elseif ((XTHAL_SAS_OPT | XTHAL_SAS_CC | XTHAL_SAS_GLOB) & ~(\alloc)) == 0
+	xchal_sa_align	\ptr, 0, 1016, 4, 4
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 4
+	.endif
+	// Optional caller-saved registers used by default by the compiler:
+	.ifeq (XTHAL_SAS_OPT | XTHAL_SAS_CC | XTHAL_SAS_CALR) & ~(\select)
+	xchal_sa_align	\ptr, 0, 1012, 4, 4
+	l32i	\at1, \ptr, .Lxchal_ofs_+0
+	wsr.ACCLO	\at1		// MAC16 option
+	l32i	\at1, \ptr, .Lxchal_ofs_+4
+	wsr.ACCHI	\at1		// MAC16 option
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 8
+	.elseif ((XTHAL_SAS_OPT | XTHAL_SAS_CC | XTHAL_SAS_CALR) & ~(\alloc)) == 0
+	xchal_sa_align	\ptr, 0, 1012, 4, 4
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 8
+	.endif
+	// Optional caller-saved registers not used by default by the compiler:
+	.ifeq (XTHAL_SAS_OPT | XTHAL_SAS_NOCC | XTHAL_SAS_CALR) & ~(\select)
+	xchal_sa_align	\ptr, 0, 996, 4, 4
+	l32i	\at1, \ptr, .Lxchal_ofs_+0
+	wsr.BR	\at1		// boolean option
+	l32i	\at1, \ptr, .Lxchal_ofs_+4
+	wsr.SCOMPARE1	\at1		// conditional store option
+	l32i	\at1, \ptr, .Lxchal_ofs_+8
+	wsr.M0	\at1		// MAC16 option
+	l32i	\at1, \ptr, .Lxchal_ofs_+12
+	wsr.M1	\at1		// MAC16 option
+	l32i	\at1, \ptr, .Lxchal_ofs_+16
+	wsr.M2	\at1		// MAC16 option
+	l32i	\at1, \ptr, .Lxchal_ofs_+20
+	wsr.M3	\at1		// MAC16 option
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 24
+	.elseif ((XTHAL_SAS_OPT | XTHAL_SAS_NOCC | XTHAL_SAS_CALR) & ~(\alloc)) == 0
+	xchal_sa_align	\ptr, 0, 996, 4, 4
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 24
+	.endif
+	// Custom caller-saved registers not used by default by the compiler:
+	.ifeq (XTHAL_SAS_TIE | XTHAL_SAS_NOCC | XTHAL_SAS_CALR) & ~(\select)
+	xchal_sa_align	\ptr, 0, 1008, 4, 4
+	l32i	\at1, \ptr, .Lxchal_ofs_+0
+	wur.F64R_LO	\at1		// ureg 234
+	l32i	\at1, \ptr, .Lxchal_ofs_+4
+	wur.F64R_HI	\at1		// ureg 235
+	l32i	\at1, \ptr, .Lxchal_ofs_+8
+	wur.F64S	\at1		// ureg 236
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 12
+	.elseif ((XTHAL_SAS_TIE | XTHAL_SAS_NOCC | XTHAL_SAS_CALR) & ~(\alloc)) == 0
+	xchal_sa_align	\ptr, 0, 1008, 4, 4
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 12
+	.endif
+    .endm	// xchal_ncp_load
+
+
+#define XCHAL_NCP_NUM_ATMPS	1
+
+    /* 
+     *  Macro to store the state of TIE coprocessor FPU.
+     *  Required parameters:
+     *      ptr         Save area pointer address register (clobbered)
+     *                  (register must contain a 4 byte aligned address).
+     *      at1..at4    Four temporary address registers (first XCHAL_CP0_NUM_ATMPS
+     *                  registers are clobbered, the remaining are unused).
+     *  Optional parameters are the same as for xchal_ncp_store.
+     */
+#define xchal_cp_FPU_store	xchal_cp0_store
+    .macro	xchal_cp0_store  ptr at1 at2 at3 at4  continue=0 ofs=-1 select=XTHAL_SAS_ALL alloc=0
+	xchal_sa_start \continue, \ofs
+	// Custom caller-saved registers not used by default by the compiler:
+	.ifeq (XTHAL_SAS_TIE | XTHAL_SAS_NOCC | XTHAL_SAS_CALR) & ~(\select)
+	xchal_sa_align	\ptr, 0, 948, 4, 4
+	rur.FCR	\at1		// ureg 232
+	s32i	\at1, \ptr, .Lxchal_ofs_+0
+	rur.FSR	\at1		// ureg 233
+	s32i	\at1, \ptr, .Lxchal_ofs_+4
+	ssi	f0, \ptr, .Lxchal_ofs_+8
+	ssi	f1, \ptr, .Lxchal_ofs_+12
+	ssi	f2, \ptr, .Lxchal_ofs_+16
+	ssi	f3, \ptr, .Lxchal_ofs_+20
+	ssi	f4, \ptr, .Lxchal_ofs_+24
+	ssi	f5, \ptr, .Lxchal_ofs_+28
+	ssi	f6, \ptr, .Lxchal_ofs_+32
+	ssi	f7, \ptr, .Lxchal_ofs_+36
+	ssi	f8, \ptr, .Lxchal_ofs_+40
+	ssi	f9, \ptr, .Lxchal_ofs_+44
+	ssi	f10, \ptr, .Lxchal_ofs_+48
+	ssi	f11, \ptr, .Lxchal_ofs_+52
+	ssi	f12, \ptr, .Lxchal_ofs_+56
+	ssi	f13, \ptr, .Lxchal_ofs_+60
+	ssi	f14, \ptr, .Lxchal_ofs_+64
+	ssi	f15, \ptr, .Lxchal_ofs_+68
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 72
+	.elseif ((XTHAL_SAS_TIE | XTHAL_SAS_NOCC | XTHAL_SAS_CALR) & ~(\alloc)) == 0
+	xchal_sa_align	\ptr, 0, 948, 4, 4
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 72
+	.endif
+    .endm	// xchal_cp0_store
+
+    /* 
+     *  Macro to load the state of TIE coprocessor FPU.
+     *  Required parameters:
+     *      ptr         Save area pointer address register (clobbered)
+     *                  (register must contain a 4 byte aligned address).
+     *      at1..at4    Four temporary address registers (first XCHAL_CP0_NUM_ATMPS
+     *                  registers are clobbered, the remaining are unused).
+     *  Optional parameters are the same as for xchal_ncp_load.
+     */
+#define xchal_cp_FPU_load	xchal_cp0_load
+    .macro	xchal_cp0_load  ptr at1 at2 at3 at4  continue=0 ofs=-1 select=XTHAL_SAS_ALL alloc=0
+	xchal_sa_start \continue, \ofs
+	// Custom caller-saved registers not used by default by the compiler:
+	.ifeq (XTHAL_SAS_TIE | XTHAL_SAS_NOCC | XTHAL_SAS_CALR) & ~(\select)
+	xchal_sa_align	\ptr, 0, 948, 4, 4
+	l32i	\at1, \ptr, .Lxchal_ofs_+0
+	wur.FCR	\at1		// ureg 232
+	l32i	\at1, \ptr, .Lxchal_ofs_+4
+	wur.FSR	\at1		// ureg 233
+	lsi	f0, \ptr, .Lxchal_ofs_+8
+	lsi	f1, \ptr, .Lxchal_ofs_+12
+	lsi	f2, \ptr, .Lxchal_ofs_+16
+	lsi	f3, \ptr, .Lxchal_ofs_+20
+	lsi	f4, \ptr, .Lxchal_ofs_+24
+	lsi	f5, \ptr, .Lxchal_ofs_+28
+	lsi	f6, \ptr, .Lxchal_ofs_+32
+	lsi	f7, \ptr, .Lxchal_ofs_+36
+	lsi	f8, \ptr, .Lxchal_ofs_+40
+	lsi	f9, \ptr, .Lxchal_ofs_+44
+	lsi	f10, \ptr, .Lxchal_ofs_+48
+	lsi	f11, \ptr, .Lxchal_ofs_+52
+	lsi	f12, \ptr, .Lxchal_ofs_+56
+	lsi	f13, \ptr, .Lxchal_ofs_+60
+	lsi	f14, \ptr, .Lxchal_ofs_+64
+	lsi	f15, \ptr, .Lxchal_ofs_+68
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 72
+	.elseif ((XTHAL_SAS_TIE | XTHAL_SAS_NOCC | XTHAL_SAS_CALR) & ~(\alloc)) == 0
+	xchal_sa_align	\ptr, 0, 948, 4, 4
+	.set	.Lxchal_ofs_, .Lxchal_ofs_ + 72
+	.endif
+    .endm	// xchal_cp0_load
+
+#define XCHAL_CP0_NUM_ATMPS	1
+#define XCHAL_SA_NUM_ATMPS	1
+
+	/*  Empty macros for unconfigured coprocessors:  */
+	.macro xchal_cp1_store	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+	.macro xchal_cp1_load	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+	.macro xchal_cp2_store	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+	.macro xchal_cp2_load	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+	.macro xchal_cp3_store	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+	.macro xchal_cp3_load	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+	.macro xchal_cp4_store	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+	.macro xchal_cp4_load	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+	.macro xchal_cp5_store	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+	.macro xchal_cp5_load	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+	.macro xchal_cp6_store	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+	.macro xchal_cp6_load	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+	.macro xchal_cp7_store	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+	.macro xchal_cp7_load	p a b c d continue=0 ofs=-1 select=-1 ; .endm
+
+#endif /*_XTENSA_CORE_TIE_ASM_H*/
+
diff --git a/arch/xtensa/variants/esp32/include/variant/tie.h b/arch/xtensa/variants/esp32/include/variant/tie.h
new file mode 100644
index 000000000000..e178799708e2
--- /dev/null
+++ b/arch/xtensa/variants/esp32/include/variant/tie.h
@@ -0,0 +1,182 @@
+/* 
+ * tie.h -- compile-time HAL definitions dependent on CORE & TIE configuration
+ *
+ *  NOTE:  This header file is not meant to be included directly.
+ */
+
+/* This header file describes this specific Xtensa processor's TIE extensions
+   that extend basic Xtensa core functionality.  It is customized to this
+   Xtensa processor configuration.
+
+   Customer ID=11657; Build=0x5fe96; Copyright (c) 1999-2016 Cadence Design Systems Inc.
+
+   Permission is hereby granted, free of charge, to any person obtaining
+   a copy of this software and associated documentation files (the
+   "Software"), to deal in the Software without restriction, including
+   without limitation the rights to use, copy, modify, merge, publish,
+   distribute, sublicense, and/or sell copies of the Software, and to
+   permit persons to whom the Software is furnished to do so, subject to
+   the following conditions:
+
+   The above copyright notice and this permission notice shall be included
+   in all copies or substantial portions of the Software.
+
+   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
+   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  */
+
+#ifndef _XTENSA_CORE_TIE_H
+#define _XTENSA_CORE_TIE_H
+
+#define XCHAL_CP_NUM			1	/* number of coprocessors */
+#define XCHAL_CP_MAX			1	/* max CP ID + 1 (0 if none) */
+#define XCHAL_CP_MASK			0x01	/* bitmask of all CPs by ID */
+#define XCHAL_CP_PORT_MASK		0x00	/* bitmask of only port CPs */
+
+/*  Basic parameters of each coprocessor:  */
+#define XCHAL_CP0_NAME			"FPU"
+#define XCHAL_CP0_IDENT			FPU
+#define XCHAL_CP0_SA_SIZE		72	/* size of state save area */
+#define XCHAL_CP0_SA_ALIGN		4	/* min alignment of save area */
+#define XCHAL_CP_ID_FPU             	0	/* coprocessor ID (0..7) */
+
+/*  Filler info for unassigned coprocessors, to simplify arrays etc:  */
+#define XCHAL_CP1_SA_SIZE		0
+#define XCHAL_CP1_SA_ALIGN		1
+#define XCHAL_CP2_SA_SIZE		0
+#define XCHAL_CP2_SA_ALIGN		1
+#define XCHAL_CP3_SA_SIZE		0
+#define XCHAL_CP3_SA_ALIGN		1
+#define XCHAL_CP4_SA_SIZE		0
+#define XCHAL_CP4_SA_ALIGN		1
+#define XCHAL_CP5_SA_SIZE		0
+#define XCHAL_CP5_SA_ALIGN		1
+#define XCHAL_CP6_SA_SIZE		0
+#define XCHAL_CP6_SA_ALIGN		1
+#define XCHAL_CP7_SA_SIZE		0
+#define XCHAL_CP7_SA_ALIGN		1
+
+/*  Save area for non-coprocessor optional and custom (TIE) state:  */
+#define XCHAL_NCP_SA_SIZE		48
+#define XCHAL_NCP_SA_ALIGN		4
+
+/*  Total save area for optional and custom state (NCP + CPn):  */
+#define XCHAL_TOTAL_SA_SIZE		128	/* with 16-byte align padding */
+#define XCHAL_TOTAL_SA_ALIGN		4	/* actual minimum alignment */
+
+/*
+ * Detailed contents of save areas.
+ * NOTE:  caller must define the XCHAL_SA_REG macro (not defined here)
+ * before expanding the XCHAL_xxx_SA_LIST() macros.
+ *
+ * XCHAL_SA_REG(s,ccused,abikind,kind,opt,name,galign,align,asize,
+ *		dbnum,base,regnum,bitsz,gapsz,reset,x...)
+ *
+ *	s = passed from XCHAL_*_LIST(s), eg. to select how to expand
+ *	ccused = set if used by compiler without special options or code
+ *	abikind = 0 (caller-saved), 1 (callee-saved), or 2 (thread-global)
+ *	kind = 0 (special reg), 1 (TIE user reg), or 2 (TIE regfile reg)
+ *	opt = 0 (custom TIE extension or coprocessor), or 1 (optional reg)
+ *	name = lowercase reg name (no quotes)
+ *	galign = group byte alignment (power of 2) (galign >= align)
+ *	align = register byte alignment (power of 2)
+ *	asize = allocated size in bytes (asize*8 == bitsz + gapsz + padsz)
+ *	  (not including any pad bytes required to galign this or next reg)
+ *	dbnum = unique target number f/debug (see <xtensa-libdb-macros.h>)
+ *	base = reg shortname w/o index (or sr=special, ur=TIE user reg)
+ *	regnum = reg index in regfile, or special/TIE-user reg number
+ *	bitsz = number of significant bits (regfile width, or ur/sr mask bits)
+ *	gapsz = intervening bits, if bitsz bits not stored contiguously
+ *	(padsz = pad bits at end [TIE regfile] or at msbits [ur,sr] of asize)
+ *	reset = register reset value (or 0 if undefined at reset)
+ *	x = reserved for future use (0 until then)
+ *
+ *  To filter out certain registers, e.g. to expand only the non-global
+ *  registers used by the compiler, you can do something like this:
+ *
+ *  #define XCHAL_SA_REG(s,ccused,p...)	SELCC##ccused(p)
+ *  #define SELCC0(p...)
+ *  #define SELCC1(abikind,p...)	SELAK##abikind(p)
+ *  #define SELAK0(p...)		REG(p)
+ *  #define SELAK1(p...)		REG(p)
+ *  #define SELAK2(p...)
+ *  #define REG(kind,tie,name,galn,aln,asz,csz,dbnum,base,rnum,bsz,rst,x...) \
+ *		...what you want to expand...
+ */
+
+#define XCHAL_NCP_SA_NUM	12
+#define XCHAL_NCP_SA_LIST(s)	\
+ XCHAL_SA_REG(s,1,2,1,1,      threadptr, 4, 4, 4,0x03E7,  ur,231, 32,0,0,0) \
+ XCHAL_SA_REG(s,1,0,0,1,          acclo, 4, 4, 4,0x0210,  sr,16 , 32,0,0,0) \
+ XCHAL_SA_REG(s,1,0,0,1,          acchi, 4, 4, 4,0x0211,  sr,17 ,  8,0,0,0) \
+ XCHAL_SA_REG(s,0,0,0,1,             br, 4, 4, 4,0x0204,  sr,4  , 16,0,0,0) \
+ XCHAL_SA_REG(s,0,0,0,1,      scompare1, 4, 4, 4,0x020C,  sr,12 , 32,0,0,0) \
+ XCHAL_SA_REG(s,0,0,0,1,             m0, 4, 4, 4,0x0220,  sr,32 , 32,0,0,0) \
+ XCHAL_SA_REG(s,0,0,0,1,             m1, 4, 4, 4,0x0221,  sr,33 , 32,0,0,0) \
+ XCHAL_SA_REG(s,0,0,0,1,             m2, 4, 4, 4,0x0222,  sr,34 , 32,0,0,0) \
+ XCHAL_SA_REG(s,0,0,0,1,             m3, 4, 4, 4,0x0223,  sr,35 , 32,0,0,0) \
+ XCHAL_SA_REG(s,0,0,1,0,        f64r_lo, 4, 4, 4,0x03EA,  ur,234, 32,0,0,0) \
+ XCHAL_SA_REG(s,0,0,1,0,        f64r_hi, 4, 4, 4,0x03EB,  ur,235, 32,0,0,0) \
+ XCHAL_SA_REG(s,0,0,1,0,           f64s, 4, 4, 4,0x03EC,  ur,236, 32,0,0,0)
+
+#define XCHAL_CP0_SA_NUM	18
+#define XCHAL_CP0_SA_LIST(s)	\
+ XCHAL_SA_REG(s,0,0,1,0,            fcr, 4, 4, 4,0x03E8,  ur,232, 32,0,0,0) \
+ XCHAL_SA_REG(s,0,0,1,0,            fsr, 4, 4, 4,0x03E9,  ur,233, 32,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,             f0, 4, 4, 4,0x0030,   f,0  , 32,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,             f1, 4, 4, 4,0x0031,   f,1  , 32,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,             f2, 4, 4, 4,0x0032,   f,2  , 32,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,             f3, 4, 4, 4,0x0033,   f,3  , 32,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,             f4, 4, 4, 4,0x0034,   f,4  , 32,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,             f5, 4, 4, 4,0x0035,   f,5  , 32,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,             f6, 4, 4, 4,0x0036,   f,6  , 32,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,             f7, 4, 4, 4,0x0037,   f,7  , 32,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,             f8, 4, 4, 4,0x0038,   f,8  , 32,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,             f9, 4, 4, 4,0x0039,   f,9  , 32,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,            f10, 4, 4, 4,0x003A,   f,10 , 32,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,            f11, 4, 4, 4,0x003B,   f,11 , 32,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,            f12, 4, 4, 4,0x003C,   f,12 , 32,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,            f13, 4, 4, 4,0x003D,   f,13 , 32,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,            f14, 4, 4, 4,0x003E,   f,14 , 32,0,0,0) \
+ XCHAL_SA_REG(s,0,0,2,0,            f15, 4, 4, 4,0x003F,   f,15 , 32,0,0,0)
+
+#define XCHAL_CP1_SA_NUM	0
+#define XCHAL_CP1_SA_LIST(s)	/* empty */
+
+#define XCHAL_CP2_SA_NUM	0
+#define XCHAL_CP2_SA_LIST(s)	/* empty */
+
+#define XCHAL_CP3_SA_NUM	0
+#define XCHAL_CP3_SA_LIST(s)	/* empty */
+
+#define XCHAL_CP4_SA_NUM	0
+#define XCHAL_CP4_SA_LIST(s)	/* empty */
+
+#define XCHAL_CP5_SA_NUM	0
+#define XCHAL_CP5_SA_LIST(s)	/* empty */
+
+#define XCHAL_CP6_SA_NUM	0
+#define XCHAL_CP6_SA_LIST(s)	/* empty */
+
+#define XCHAL_CP7_SA_NUM	0
+#define XCHAL_CP7_SA_LIST(s)	/* empty */
+
+/* Byte length of instruction from its first nibble (op0 field), per FLIX.  */
+#define XCHAL_OP0_FORMAT_LENGTHS	3,3,3,3,3,3,3,3,2,2,2,2,2,2,3,3
+/* Byte length of instruction from its first byte, per FLIX.  */
+#define XCHAL_BYTE0_FORMAT_LENGTHS	\
+	3,3,3,3,3,3,3,3,2,2,2,2,2,2,3,3, 3,3,3,3,3,3,3,3,2,2,2,2,2,2,3,3,\
+	3,3,3,3,3,3,3,3,2,2,2,2,2,2,3,3, 3,3,3,3,3,3,3,3,2,2,2,2,2,2,3,3,\
+	3,3,3,3,3,3,3,3,2,2,2,2,2,2,3,3, 3,3,3,3,3,3,3,3,2,2,2,2,2,2,3,3,\
+	3,3,3,3,3,3,3,3,2,2,2,2,2,2,3,3, 3,3,3,3,3,3,3,3,2,2,2,2,2,2,3,3,\
+	3,3,3,3,3,3,3,3,2,2,2,2,2,2,3,3, 3,3,3,3,3,3,3,3,2,2,2,2,2,2,3,3,\
+	3,3,3,3,3,3,3,3,2,2,2,2,2,2,3,3, 3,3,3,3,3,3,3,3,2,2,2,2,2,2,3,3,\
+	3,3,3,3,3,3,3,3,2,2,2,2,2,2,3,3, 3,3,3,3,3,3,3,3,2,2,2,2,2,2,3,3,\
+	3,3,3,3,3,3,3,3,2,2,2,2,2,2,3,3, 3,3,3,3,3,3,3,3,2,2,2,2,2,2,3,3
+
+#endif /*_XTENSA_CORE_TIE_H*/
+
-- 
2.30.2

