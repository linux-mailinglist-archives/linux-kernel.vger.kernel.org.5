Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6EC787530
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242484AbjHXQXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242482AbjHXQXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:23:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572041BE;
        Thu, 24 Aug 2023 09:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692894191; x=1724430191;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uPZl3A1E/HN3ZBXL6HTSeqA4Zt056qb4CBV9knYq6wA=;
  b=hG4iO3BEpPfTtH5nD1k5gFnpwagB3JPPBxXHN23p6Q5+vWF1HZ8xYaFt
   BSX3x+gGZC5T/NBUMPq/U4J94NQAaxiU7CbO87Lw5vAjsNeDRYJQjS8bw
   vbXvZUgn0HH0xyzsoSmt3EfKVzGD/N7PlpRN8oi6KBXLJ4ggskraaRCH5
   nU2ODdz/Th89ifZ6n9qDmRy16FfMMO3FEoRHblYdH+rkiSGtJhBuzuOqH
   eIA+mNMxE5/gLAcleOCgiefMLufQ3Fz4Bqff/MO/JIWWZ7IgC/H8XqmxH
   HKuk6ZgLDyx1O/Z8rEA4R0VtoOAGFptb1pWoiK8rvE3Ph/SG3rCpwDUf1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="359487447"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="359487447"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 09:22:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="766599818"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="766599818"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 24 Aug 2023 09:22:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CAFE4F4; Thu, 24 Aug 2023 19:22:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/3] spidev: A few cleanups
Date:   Thu, 24 Aug 2023 19:22:06 +0300
Message-Id: <20230824162209.2890440-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
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

A few cleanups to the spidev.c to utilize existing APIs and make it
use less amount of Lines of Code. No functional change intended.

Andy Shevchenko (3):
  spidev: Decrease indentation level in spidev_ioctl() SPI_IOC_RD_MODE*
  spidev: Switch to use spi_get_csgpiod()
  spidev: Simplify SPI_IOC_RD_MODE* cases in spidev_ioctl()

 drivers/spi/spidev.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

