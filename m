Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331A17ED910
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 02:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344450AbjKPBzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 20:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPBzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 20:55:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191EE193
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700099706; x=1731635706;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wT7dbjKEZPnJlKx0LG/sRI7UdmUYfosJsm3/37/KvOs=;
  b=PN2Yb2forat/avhek0PzXxIDZtUGdpEKHHTLaepTe2mND+YaJjUkFzgU
   gkhYgtGddaTD3wz/tlABo+YTtqfODRZ65Kg1aX4hXaZBXmSdTwnDqcqE+
   jJ2hFUjvLuwblmgsn78XqyY8WHEmjOCxj7m/XJTynMH/q1bloj6T2KVQW
   zs6k5eCJPxzwiHYclShWfaboHeDLR6CX75gfn4oIAhIUOXDQh102iWTX5
   0yKGlBiPe4APhfj7zs2aAxB1pNP3n4VbT9kE1mhFpl04uCPFpcGi30DBv
   9IxVkjd49ACaR7Zust0ROZ9OJ7ZokCODdU3R433GhHF/f0Nn81HxO5VnK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="381387673"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="381387673"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 17:55:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="13395413"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa001.fm.intel.com with ESMTP; 15 Nov 2023 17:55:03 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/4] iommu/vt-d: Miscellaneous cleanups
Date:   Thu, 16 Nov 2023 09:50:44 +0800
Message-Id: <20231116015048.29675-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes several miscellaneous cleanups that were discovered
during recent development. Please let me know if anything I have
overlooked. 

Best regards,
baolu

Lu Baolu (4):
  iommu/vt-d: Introduce dev_to_iommu()
  iommu/vt-d: Remove unused parameter of
    intel_pasid_setup_pass_through()
  iommu/vt-d: Remove unused vcmd interfaces
  iommu/vt-d: Move inline helpers to header files

 drivers/iommu/intel/iommu.h | 184 +++++++++++++++++++++++-
 drivers/iommu/intel/pasid.h | 213 +++++++++++++++++++++++++++-
 drivers/iommu/intel/iommu.c | 237 +++----------------------------
 drivers/iommu/intel/pasid.c | 274 +-----------------------------------
 drivers/iommu/intel/svm.c   |  20 +--
 5 files changed, 421 insertions(+), 507 deletions(-)

-- 
2.34.1

