Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5E77D8835
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbjJZSWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbjJZSWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:22:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5436D1A5;
        Thu, 26 Oct 2023 11:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698344535; x=1729880535;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=02I76JtMV/XP4d15n66jEAIUs4W3dxCXExoFps3S0L8=;
  b=BF9nzejVTcUgK4l7If54aBpstnUdXPtHhlMNMdYSUdvwtzyuiqngarim
   WmDnXVNbwrd6Hte+ahcfDq0N5DwGoehsJtX6HDMz+5+TdFHrGv+g5lsQb
   6zvoi2EV2Ufa79Tha24wHKnM+EHFUPPEVGNnDsfhxr6N6YwGLpy8E1Z88
   pEbvzf4bW8B+B1H6C27ef4JTLtZhM+8C1hzQA4hkZIdXJEP8yFl2Dfw0U
   MHMintCuQpKMQXzeQxHMVeR5+sNtEF0UhSJ6VovtOSUBNlo2Ua5dFRWgN
   W3DZOKTkbwfCaLXTCsz1mVLxPpXXyBG2Q8wCZYJBIo0heT2k6VydXq7EB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="418733770"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="418733770"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 11:21:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="825087497"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="825087497"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.121.242])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 11:21:41 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Thu, 26 Oct 2023 11:21:38 -0700
Subject: [PATCH RFC v2 1/3] cxl/trace: Remove uuid from event trace known
 events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-cxl-cper-v2-1-314d9c36ab02@intel.com>
References: <20230601-cxl-cper-v2-0-314d9c36ab02@intel.com>
In-Reply-To: <20230601-cxl-cper-v2-0-314d9c36ab02@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-0f7f0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698344500; l=2585;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=02I76JtMV/XP4d15n66jEAIUs4W3dxCXExoFps3S0L8=;
 b=CKvEpXKIbY/dAxkg4WCPjxnCXBuvWVSmAGHO/n41Ty89HNrAlwzzP0qYpu+5lB88O5sej2CZw
 QdvLqi3WJQjCLuHbvRrqE7uXOnU5Ru+goXbQURXnXwcZSoUK8T5ew35
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uuid printed in the well known events is redundant.  The uuid
defines what the event was.

Remove the uuid from the known events and only report it in the generic
event as it remains informative there.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/trace.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index a0b5819bc70b..79ed03637604 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -189,7 +189,6 @@ TRACE_EVENT(cxl_overflow,
 	__string(memdev, dev_name(&cxlmd->dev))			\
 	__string(host, dev_name(cxlmd->dev.parent))		\
 	__field(int, log)					\
-	__field_struct(uuid_t, hdr_uuid)			\
 	__field(u64, serial)					\
 	__field(u32, hdr_flags)					\
 	__field(u16, hdr_handle)				\
@@ -203,7 +202,6 @@ TRACE_EVENT(cxl_overflow,
 	__assign_str(host, dev_name((cxlmd)->dev.parent));			\
 	__entry->log = (l);							\
 	__entry->serial = (cxlmd)->cxlds->serial;				\
-	memcpy(&__entry->hdr_uuid, &(hdr).id, sizeof(uuid_t));			\
 	__entry->hdr_length = (hdr).length;					\
 	__entry->hdr_flags = get_unaligned_le24((hdr).flags);			\
 	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
@@ -212,12 +210,12 @@ TRACE_EVENT(cxl_overflow,
 	__entry->hdr_maint_op_class = (hdr).maint_op_class
 
 #define CXL_EVT_TP_printk(fmt, ...) \
-	TP_printk("memdev=%s host=%s serial=%lld log=%s : time=%llu uuid=%pUb "	\
+	TP_printk("memdev=%s host=%s serial=%lld log=%s : time=%llu "		\
 		"len=%d flags='%s' handle=%x related_handle=%x "		\
 		"maint_op_class=%u : " fmt,					\
 		__get_str(memdev), __get_str(host), __entry->serial,		\
 		cxl_event_log_type_str(__entry->log),				\
-		__entry->hdr_timestamp, &__entry->hdr_uuid, __entry->hdr_length,\
+		__entry->hdr_timestamp, __entry->hdr_length,			\
 		show_hdr_flags(__entry->hdr_flags), __entry->hdr_handle,	\
 		__entry->hdr_related_handle, __entry->hdr_maint_op_class,	\
 		##__VA_ARGS__)
@@ -231,15 +229,17 @@ TRACE_EVENT(cxl_generic_event,
 
 	TP_STRUCT__entry(
 		CXL_EVT_TP_entry
+		__field_struct(uuid_t, hdr_uuid)
 		__array(u8, data, CXL_EVENT_RECORD_DATA_LENGTH)
 	),
 
 	TP_fast_assign(
 		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
+		memcpy(&__entry->hdr_uuid, &rec->hdr.id, sizeof(uuid_t));
 		memcpy(__entry->data, &rec->data, CXL_EVENT_RECORD_DATA_LENGTH);
 	),
 
-	CXL_EVT_TP_printk("%s",
+	CXL_EVT_TP_printk("uuid=%pUb %s", &__entry->hdr_uuid,
 		__print_hex(__entry->data, CXL_EVENT_RECORD_DATA_LENGTH))
 );
 

-- 
2.41.0

