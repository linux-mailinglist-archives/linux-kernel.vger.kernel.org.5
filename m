Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F80F7C9DE5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 05:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjJPDcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 23:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjJPDcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 23:32:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED365AD
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 20:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697427129; x=1728963129;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DxiPARvF786GMcRwOlSI1TqYVHXVvDCyQYStCbvWKqo=;
  b=IcCOy7wU1pAdGKuOOblU0v4QHtj/4noMaOCEGp/GBcNwEnPjj5otvPyK
   GK6QxobJSa5slqZEAQudkwWYulgauyWb7ARdzuv+y1S+5AF8UXDnzTnP4
   6Lj8+/jTI3smei5tD7yuZxWhkHDF4We/RnCSIqP5kx1lb8YrJN86fifpy
   cTPEKSML6CBJMIpjVH1gOMu+w51OvV3GlKSvwa2kLDFyKm2Y6TDEM0Fe2
   vTeZDNMVLco5ORlZs9kDHv4NakU3jXF9dXyYhe3b6RKEed4pFhLORN7Bl
   xq+abeS8gUo8PW6embDhvTBuLCZj9/IgKnI20T93I3Uxhk/FYxQEQS145
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365701119"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="365701119"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 20:32:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="705444244"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="705444244"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga003.jf.intel.com with ESMTP; 15 Oct 2023 20:32:07 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jingqi Liu <Jingqi.liu@intel.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] [PULL REQUEST] Intel IOMMU updates for Linux v6.7
Date:   Mon, 16 Oct 2023 11:28:26 +0800
Message-Id: <20231016032830.101321-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

The following patches have been queued for v6.7. They aim to:

 - Enable debugfs to dump domain attached to a pasid
 - Remove an unnecessary inline function.

All patches are based on v6.6-rc5. The series is also available at:
https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v6.7

Please consider them for v6.7.

Best regards,
Baolu

Jiapeng Chong (1):
  iommu/vt-d: Remove unused function

Jingqi Liu (3):
  iommu/vt-d: debugfs: Dump entry pointing to huge page
  iommu/vt-d: debugfs: Create/remove debugfs file per {device, pasid}
  iommu/vt-d: debugfs: Support dumping a specified page table

 drivers/iommu/intel/iommu.h   |  14 +++
 drivers/iommu/intel/debugfs.c | 215 +++++++++++++++++++++++++++-------
 drivers/iommu/intel/iommu.c   |   7 ++
 drivers/iommu/intel/pasid.c   |   9 --
 4 files changed, 195 insertions(+), 50 deletions(-)

-- 
2.34.1

