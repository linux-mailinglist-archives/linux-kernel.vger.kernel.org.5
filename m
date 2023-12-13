Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40433810A4E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 07:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378599AbjLMGbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 01:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378598AbjLMGbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 01:31:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5417BE4;
        Tue, 12 Dec 2023 22:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702449097; x=1733985097;
  h=from:to:cc:subject:date:message-id;
  bh=OQ7WzdvD05NPItZLW1pLFQ5aeAJVE0IdbApen3gJr6c=;
  b=fVLg6Dg4/RDm4b2Q1wkVYwNQ/aKDMH3GKoMPdgosnw+chUDbVK948pHy
   Ziw2Y8FlzeaiJMuvs5+bH3rs/466EiQJc035NTQry614Vpl1IUaoACpfm
   FNwWJIGSiU6uj3OTc74AxW1PWB1RGlxBOEU2egniO5dKFbNB0eRnRixr4
   C4oMZuiOW3gXD5uYZjb6XzLqedszMCQjy/tS/mJELsEGaL10xkWo0QWl4
   Y2YJGWuYCqO963gkVZOTBaQSox9fhb3OoNRy82o2gZy4JRny5D2EHVwBZ
   IWOq/fKz9YE6BgJGiWGXKTBqXmmngT+Aoeaf+8gV6wrKqZ7f7qc/qnlQX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="8281303"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="8281303"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 22:31:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="947065763"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="947065763"
Received: from srikandan-ilbpg12.png.intel.com ([10.88.229.69])
  by orsmga005.jf.intel.com with ESMTP; 12 Dec 2023 22:31:32 -0800
From:   nandhini.srikandan@intel.com
To:     fancer.lancer@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com
Subject: [PATCH v1 0/2] Remove Intel Thunder Bay SOC support                       
Date:   Wed, 13 Dec 2023 14:08:34 +0800
Message-Id: <20231213060836.29203-1-nandhini.srikandan@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nandhini Srikandan <nandhini.srikandan@intel.com>

This patch set removes Intel Thunder Bay specific code as the product              
got cancelled and there are no end customers.                                      
                                                                                   
Patch 1: Remove Intel Thunder Bay spi dw binding specific code.                    
Patch 2: Remove Intel Thunder Bay spi dw binding Documentation.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Nandhini Srikandan (2):
  spi: dw: Remove Intel Thunder Bay SOC support
  spi: dw: Remove Intel Thunder Bay SOC support

 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 --
 drivers/spi/spi-dw-mmio.c                                  | 1 -
 2 files changed, 3 deletions(-)

-- 
2.17.1

