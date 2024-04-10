Return-Path: <linux-kernel+bounces-138000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B24389EAF8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9BF51F21529
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633993A29B;
	Wed, 10 Apr 2024 06:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bssWlidK"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106CA28370;
	Wed, 10 Apr 2024 06:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730981; cv=none; b=qh4oC2IVqn+qhAPGL6Va4vZEFDlj+ZHchvWkYF+6LdFSTtxRkkgTcbEmrpz1GRl3vQP+fpgMmejr6eaif2RQ9cnT4nn3C/lMAkEZiXI/TPIn2fr2Zg920tun0XZGGYPhuaPYOtgo3yYaZhuPrmXsSe1vPStp4BjpdhGbhiw2GJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730981; c=relaxed/simple;
	bh=WeaqZzn7oUQvOtMGOO/T8nOZBMyxUgnAl7tXB0ABHeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jPj9unFjVbv8DvZQ6pfJHTTeOlAT8+kEyQHVlTREnuN9AIZNTaUipZ2wiz601t3KqVUAD7zB9oAG3VuGr28z2leB7bqeOMy3E22v6VqyfJz74VjVjLdJinLmlw+FAxSfj8iS2voylGffBlrKh7XbTmBnLNvv0+6GdU4UM0eRnXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bssWlidK; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712730975; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=jh2BrX7/cmi+9OhfJLQBIO/Try21wS3X87KwHZzLpJ0=;
	b=bssWlidK4cKjQoNGL/TFa66ZbaXKkP0Ng1yu8dxVEL96PV1b7F58kja9lg0GGxz8rGgy7ookRkY4GDj0hptnRqDJnHvU7HckqFr4KursK1dvlApCxp6mlkJo9PD6lUnHf/ivJ6mPdJkaDQkSwoD53dNKJpzTViqhNGakF2wnR1s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W4Gs1zM_1712730973;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0W4Gs1zM_1712730973)
          by smtp.aliyun-inc.com;
          Wed, 10 Apr 2024 14:36:15 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	tianruidong@linux.alibaba.com
Subject: [PATCH v2 1/2] ACPICA: AEST: Fix coding style at struct definition
Date: Wed, 10 Apr 2024 14:36:01 +0800
Message-Id: <20240410063602.41540-2-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240410063602.41540-1-tianruidong@linux.alibaba.com>
References: <20240410063602.41540-1-tianruidong@linux.alibaba.com>
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
index f237269bd1cb..f89b23b3d2aa 100644
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


