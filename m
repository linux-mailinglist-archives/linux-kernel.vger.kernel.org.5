Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F1B753641
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbjGNJRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235043AbjGNJRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:17:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7C01FC9;
        Fri, 14 Jul 2023 02:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689326269; x=1720862269;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q4kBfKspO7sFkiacFnREqVjDod6DUMgGpY8AF3efGsw=;
  b=ko0lO94N4D06e07HpiXC+7ya2TFCPK7o5T1hN977B7wanHD0oZzsRRws
   tVvVX76pTeznZXISLXecTP0aqCvlsoOCYWsFXRG95rkLxUkPLmc4AwIjM
   PABd5Zb3i+nOFxFoU2epF4+yycBrjFns9LkEwVSTesfiJl7GXa2j7ACA8
   E49YW44gRr3duRS5rIqB4xuNDHcsHdqnrb+TBSV5+KJrxEnrF+2F43CjB
   O4MOTjvO4qjrXANH5Hu8cjESEl3yu1j8x7iVOgD6SqPEkfDBbHTVMPpHU
   HFZKz+Y6zzdrUi7oYYjrPGB5AyJ8icsHk8o396gLxUP7y57QMANpKZeXr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="362897871"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="362897871"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 02:17:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="812357259"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="812357259"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jul 2023 02:17:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 74CA5379; Fri, 14 Jul 2023 12:17:50 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v4 0/4] spi: Header and core clean up and refactoring
Date:   Fri, 14 Jul 2023 12:17:44 +0300
Message-Id: <20230714091748.89681-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various cleanups and refactorings of the SPI header and core parts
united in a single series. It also touches drivers under SPI subsystem
folder on the pure renaming purposes of some constants.

No functional change intended (with some subtle shortcuts which are
explained in the respective commit messages).

Changelog v4:
- dropped applied patches
- added tag to patch 1 (Sebastian)

v3: 20230711171756.86736-1-andriy.shevchenko@linux.intel.com

Changelog v3:
- dropped controversial used to be patches 3,4,8,10 (Mark)
- amended many commit messages (Mark)
- added tag to patch 1 (AngeloGioacchino)
- split used to be patch 2 to patches 2 & 3 for better review (Mark)
- rewritten used to be patch 5 to patches 4 & 5 (Mark, Sebastian)
- added new patch 7
- fixed typos and added tag to patch 12 (Serge)

v2: 20230710154932.68377-1-andriy.shevchenko@linux.intel.com

Changelog v2:
- added new patches 3,4,5,10,13,14
- massaged comment and kernel doc in patch 9
- split used to be patch 4 to patches 11,12
- covered a few things in SPI core in patch 15
- amended commit message for above (Mark)
- reshuffled patches in the series for better logical grouping

Andy Shevchenko (4):
  spi: Remove code duplication in spi_add_device*()
  spi: Kill spi_add_device_locked()
  spi: Use BITS_TO_BYTES()
  spi: Use struct_size() helper

 drivers/spi/spi.c       | 51 +++++++++++++----------------------------
 include/linux/spi/spi.h | 15 +++++++-----
 2 files changed, 25 insertions(+), 41 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

