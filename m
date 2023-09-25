Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9371F7AD7B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjIYMIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjIYMIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:08:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2D210B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695643661; x=1727179661;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EiFYvJBANXRWei66/+2vn5xdrrHtRl9Ccl5+XMV9cds=;
  b=Dzg6P1QHeMhobU0z6tmwB25h6V3si3qEWF/fxHyaQVr3FS0BkYfwO+CX
   0bpnuZDRTBDqWQO2VJupefPfEPp7NY+wKeuw1q/6q0fgyewnssyrzluoB
   jzz8m4jcr8gsCJhD1d0XhcbYtOpU7LthkW8G/C5M/Q40td2CdwU+QLEjY
   qD2C5N2vPSnsgaNH0dPjrhWZtAsOU+tItEIeN69kamMT4CyreyyX3HyMa
   BhLhSqa0kOg6SKDzBdVDBfWvBWtVKvKDrRw7w8h+SlDFczGq8OJCLsq3V
   PZBIhIEt6gvhlvOmfqXpJKSnXDagpjaVxd2dcdQGQLQ6aVNVrCUbeLJlJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="380110405"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="380110405"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 05:07:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="741907331"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="741907331"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga007.jf.intel.com with ESMTP; 25 Sep 2023 05:07:32 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] [PULL REQUEST] iommu/vt-d: Fixes for v6.6-rc4
Date:   Mon, 25 Sep 2023 20:04:16 +0800
Message-Id: <20230925120417.55977-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

A quick fix has been queued for v6.6. It aims to:

- Fix a suspend/hibernation problem in iommu_suspend()

Please consider it for the iommu/fix branch.

Best regards,
Lu Baolu

Zhang Rui (1):
  iommu/vt-d: Avoid memory allocation in iommu_suspend()

 drivers/iommu/intel/iommu.h |  2 +-
 drivers/iommu/intel/iommu.c | 16 ----------------
 2 files changed, 1 insertion(+), 17 deletions(-)

-- 
2.34.1

