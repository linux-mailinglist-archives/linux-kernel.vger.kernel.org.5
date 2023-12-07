Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4498092FD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjLGVF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443938AbjLGVFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:05:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE0F1718
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 13:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6mtDC5GyUcoPI4rKNkhKWA7ZG2rDUkEgJdjJjzhZ94c=; b=4q8mQkhll5nY6RobrfcUqzBcV5
        VXEEGiTi59nu5dDNL8//BSo9M8yFRxHcLVGtrZ5mi0URHztQo9Fo5j2gBKxQ1W9qxLJiHhw5vqMrI
        qgpqsAzIQSKPetUluyCwJWp/w266x6ialZVj1c0TO6/DD3d3C4dp6UzrxOmv2C/3Dda+fYsOXgBQD
        +BsS53MBUF6KMc62PN1Ra0LEMB7lgdWiqUmanbDXeeuguoS471rZLO+spMtBLskoeMv4FQbHZNsTs
        voZepPukBBx4Maeu0nQr5/aowabC55JmFH2Y84+l53vvgdRYG+QlSs/M5jI9RS/nCOSXYLZF1/u9V
        lQODa0aQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rBLZ6-00Duw1-0Q;
        Thu, 07 Dec 2023 21:05:48 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, nvdimm@lists.linux.dev
Subject: [PATCH 2/3] nvdimm/dimm_devs: fix kernel-doc for function params
Date:   Thu,  7 Dec 2023 13:05:44 -0800
Message-ID: <20231207210545.24056-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231207210545.24056-1-rdunlap@infradead.org>
References: <20231207210545.24056-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust kernel-doc notation to prevent warnings when using -Wall.

dimm_devs.c:59: warning: Function parameter or member 'ndd' not described in 'nvdimm_init_nsarea'
dimm_devs.c:59: warning: Excess function parameter 'nvdimm' description in 'nvdimm_init_nsarea'
dimm_devs.c:59: warning: No description found for return value of 'nvdimm_init_nsarea'
dimm_devs.c:728: warning: No description found for return value of 'nd_pmem_max_contiguous_dpa'
dimm_devs.c:773: warning: No description found for return value of 'nd_pmem_available_dpa'
dimm_devs.c:844: warning: Function parameter or member 'ndd' not described in 'nvdimm_allocated_dpa'
dimm_devs.c:844: warning: Excess function parameter 'nvdimm' description in 'nvdimm_allocated_dpa'
dimm_devs.c:844: warning: No description found for return value of 'nvdimm_allocated_dpa'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: nvdimm@lists.linux.dev
---
 drivers/nvdimm/dimm_devs.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff -- a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -53,7 +53,10 @@ static int validate_dimm(struct nvdimm_d
 
 /**
  * nvdimm_init_nsarea - determine the geometry of a dimm's namespace area
- * @nvdimm: dimm to initialize
+ * @ndd: dimm to initialize
+ *
+ * Returns: %0 if the area is already valid, -errno on error, otherwise an
+ * ND_CMD_* status code.
  */
 int nvdimm_init_nsarea(struct nvdimm_drvdata *ndd)
 {
@@ -722,6 +725,9 @@ static unsigned long dpa_align(struct nd
  *			   contiguous unallocated dpa range.
  * @nd_region: constrain available space check to this reference region
  * @nd_mapping: container of dpa-resource-root + labels
+ *
+ * Returns: %0 if there is an alignment error, otherwise the max
+ *		unallocated dpa range
  */
 resource_size_t nd_pmem_max_contiguous_dpa(struct nd_region *nd_region,
 					   struct nd_mapping *nd_mapping)
@@ -767,6 +773,8 @@ resource_size_t nd_pmem_max_contiguous_d
  *
  * Validate that a PMEM label, if present, aligns with the start of an
  * interleave set.
+ *
+ * Returns: %0 if there is an alignment error, otherwise the unallocated dpa
  */
 resource_size_t nd_pmem_available_dpa(struct nd_region *nd_region,
 				      struct nd_mapping *nd_mapping)
@@ -836,8 +844,10 @@ struct resource *nvdimm_allocate_dpa(str
 
 /**
  * nvdimm_allocated_dpa - sum up the dpa currently allocated to this label_id
- * @nvdimm: container of dpa-resource-root + labels
+ * @ndd: container of dpa-resource-root + labels
  * @label_id: dpa resource name of the form pmem-<human readable uuid>
+ *
+ * Returns: sum of the dpa allocated to the label_id
  */
 resource_size_t nvdimm_allocated_dpa(struct nvdimm_drvdata *ndd,
 		struct nd_label_id *label_id)
