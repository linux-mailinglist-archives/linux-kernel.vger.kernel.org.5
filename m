Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33B47D87B8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjJZRn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjJZRn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:43:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD7910E;
        Thu, 26 Oct 2023 10:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698342205; x=1729878205;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=bJ7ZJe8f7jPO3PUFmCxwVjRw9/MIhrO/htOh9M0sRtE=;
  b=BNZQeYT0G72JZdUuwq5d4+0WdqkNv2AOzdVFDAt/p+LsahBvTpqcbaXZ
   zFq7jSUKcf7mvkZ88gAb7uh3g4aomHVdVn0VenpSeat1Q+TD11yRU//PO
   RsnivyOv6c+4u6fz8XfVH9YVA9Q+UXZgiDfI4/7SpsIoZA9lfiJFRllFU
   QwO5KFgrwOTkLOEQC6OGfiCOYwtxEh4pVqXzCT14OpQtySo+UnsUeHeDE
   7tSYW9wKekiIemBkDKryYEankXI/E/Txz4nSf3fIQ3R0KNrAe+BumQ3tW
   jJc3KzSIhsjsCpikKpGIymRBNlhSmBv3wtr/c0bAQAaWkGOBkrPGE5pUT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="387430081"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="387430081"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 10:43:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="7359449"
Received: from lsingh-mobl2.amr.corp.intel.com (HELO [192.168.1.200]) ([10.212.110.60])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 10:43:15 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Thu, 26 Oct 2023 11:43:20 -0600
Subject: [PATCH] MAINTAINERS: Add tools/testing/cxl files to CXL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231026-vv-mainteners-fix-v1-1-0a0f25634073@intel.com>
X-B4-Tracking: v=1; b=H4sIADelOmUC/x2MywqAIBAAf0X23IIPkuhXooPZWnvIQkMC6d+Tj
 jMwUyFTYsowigqJCmc+YwPVCfC7ixshr41BS22U1BZLwcNxvClSyhj4QaNVGBZlyZseWnclavp
 /TvP7fqhx+ZFjAAAA
To:     linux-cxl@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        alison.schofield@intel.com, Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=911;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=bJ7ZJe8f7jPO3PUFmCxwVjRw9/MIhrO/htOh9M0sRtE=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDKlWS21nek837o269/HMLUaVW9ornqsUnMmx1FfarH/30
 MZlC/x5OkpZGMS4GGTFFFn+7vnIeExuez5PYIIjzBxWJpAhDFycAjCRojBGhrXn77V9Nz+ptOdk
 09MbpZ/57RfruoZ1Tr9694b84/7KkGBGhtnuLu0PdzyxFDqbctj//mVX16gsleSd8XLxXH+dplo
 d5AQA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tools/testing/cxl contains the unit test infrastructure for mocking CXL
hierarchies. These are under the purview of the CXL subsystem maintainers.
Add the 'F:' entry for this to MAINTAINERS so that get_maintainer.pl
works as expected for patches to this area.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 35977b269d5e..b5efa53dc3d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5181,6 +5181,7 @@ L:	linux-cxl@vger.kernel.org
 S:	Maintained
 F:	drivers/cxl/
 F:	include/uapi/linux/cxl_mem.h
+F:	tools/testing/cxl/
 
 COMPUTE EXPRESS LINK PMU (CPMU)
 M:	Jonathan Cameron <jonathan.cameron@huawei.com>

---
base-commit: 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa
change-id: 20231026-vv-mainteners-fix-321f8b16ec35

Best regards,
-- 
Vishal Verma <vishal.l.verma@intel.com>

