Return-Path: <linux-kernel+bounces-120271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B6688D524
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14D63B22C3B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E39422F19;
	Wed, 27 Mar 2024 03:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KtLz88Md"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72AD23775;
	Wed, 27 Mar 2024 03:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711511122; cv=none; b=flBhEBNy2Y9UNZtzZo8KKVtev5YG7GPDkJPIndG26dUI3c1hAy3LAQMgxiQ0oS7Ty+36NJyBFmymaUqbkSkwcHCsT3MAO/hrXDXqqVdl+DG+uWuGNAc21SERVBzm7Qt3WsJkf8Gbx4AerUjWaPDoLZ2P7LYdpdyux5DzyCLQ/jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711511122; c=relaxed/simple;
	bh=KuhaToY0pnSer8l7LmdO1BYdg4X1cESqPqxsiTiWM9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S2PCZAkrSXgLCJeR1adjm0uuW6Jsjrs1KosIbd4ByvhRU4HlggET48UbegUH6WHgpGZm8+rHGZMtQC/QuW8S7Rs8nt32TjR1TB8wzytju/91nlWnJDkGPX/2srqTdi7c3n/iydCI/S4BuhxMp7NQR8a4YElnqNTaJc4hVY/HWj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KtLz88Md; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711511111; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=bufF6x1T2H32EvFgYBhPmQfSD25Igr+N5RI/zTUl+yE=;
	b=KtLz88MdyrJCBlWCzHSFpt3IFadzHK1PindfVMOuRbhOsJHd7pVdT7rT7f0mS5p4scAfvAMhHCOZib3OXf2xL1siU6F5yVC50AygVV9DEQdvK4XoqXiilqb5w7/RLc1Y66wJ+DthO4Q4lS/4aLjdxfRRUTA7j7qHml/wGEUaB9Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W3NLs2o_1711511108;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0W3NLs2o_1711511108)
          by smtp.aliyun-inc.com;
          Wed, 27 Mar 2024 11:45:11 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	tianruidond@linux.alibaba.com,
	Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH 1/2] ACPICA: AEST: Fix coding style at struct definition
Date: Wed, 27 Mar 2024 11:44:59 +0800
Message-Id: <20240327034500.95601-2-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240327034500.95601-1-tianruidong@linux.alibaba.com>
References: <20240327034500.95601-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delete unnecessary blank lines and typedef to follow Kernel coding
style.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 include/acpi/actbl2.h | 50 +++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 9775384d61c6..c32e97855031 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -116,15 +116,14 @@ struct acpi_aest_hdr {
 
 /* 0: Processor Error */
 
-typedef struct acpi_aest_processor {
+struct acpi_aest_processor {
 	u32 processor_id;
 	u8 resource_type;
 	u8 reserved;
 	u8 flags;
 	u8 revision;
 	u64 processor_affinity;
-
-} acpi_aest_processor;
+};
 
 /* Values for resource_type above, related structs below */
 
@@ -135,11 +134,10 @@ typedef struct acpi_aest_processor {
 
 /* 0R: Processor Cache Resource Substructure */
 
-typedef struct acpi_aest_processor_cache {
+struct acpi_aest_processor_cache {
 	u32 cache_reference;
 	u32 reserved;
-
-} acpi_aest_processor_cache;
+};
 
 /* Values for cache_type above */
 
@@ -150,50 +148,44 @@ typedef struct acpi_aest_processor_cache {
 
 /* 1R: Processor TLB Resource Substructure */
 
-typedef struct acpi_aest_processor_tlb {
+struct acpi_aest_processor_tlb {
 	u32 tlb_level;
 	u32 reserved;
-
-} acpi_aest_processor_tlb;
+};
 
 /* 2R: Processor Generic Resource Substructure */
 
-typedef struct acpi_aest_processor_generic {
+struct acpi_aest_processor_generic {
 	u32 resource;
-
-} acpi_aest_processor_generic;
+};
 
 /* 1: Memory Error */
 
-typedef struct acpi_aest_memory {
+struct acpi_aest_memory {
 	u32 srat_proximity_domain;
-
-} acpi_aest_memory;
+};
 
 /* 2: Smmu Error */
 
-typedef struct acpi_aest_smmu {
+struct acpi_aest_smmu {
 	u32 iort_node_reference;
 	u32 subcomponent_reference;
-
-} acpi_aest_smmu;
+};
 
 /* 3: Vendor Defined */
 
-typedef struct acpi_aest_vendor {
+struct acpi_aest_vendor {
 	u32 acpi_hid;
 	u32 acpi_uid;
 	u8 vendor_specific_data[16];
-
-} acpi_aest_vendor;
+};
 
 /* 4: Gic Error */
 
-typedef struct acpi_aest_gic {
+struct acpi_aest_gic {
 	u32 interface_type;
 	u32 instance_id;
-
-} acpi_aest_gic;
+};
 
 /* Values for interface_type above */
 
@@ -205,7 +197,7 @@ typedef struct acpi_aest_gic {
 
 /* Node Interface Structure */
 
-typedef struct acpi_aest_node_interface {
+struct acpi_aest_node_interface {
 	u8 type;
 	u8 reserved[3];
 	u32 flags;
@@ -215,8 +207,7 @@ typedef struct acpi_aest_node_interface {
 	u64 error_record_implemented;
 	u64 error_status_reporting;
 	u64 addressing_mode;
-
-} acpi_aest_node_interface;
+};
 
 /* Values for Type field above */
 
@@ -226,15 +217,14 @@ typedef struct acpi_aest_node_interface {
 
 /* Node Interrupt Structure */
 
-typedef struct acpi_aest_node_interrupt {
+struct acpi_aest_node_interrupt {
 	u8 type;
 	u8 reserved[2];
 	u8 flags;
 	u32 gsiv;
 	u8 iort_id;
 	u8 reserved1[3];
-
-} acpi_aest_node_interrupt;
+};
 
 /* Values for Type field above */
 
-- 
2.33.1


