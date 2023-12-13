Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0FD810A56
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 07:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378620AbjLMGbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 01:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378610AbjLMGbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 01:31:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30673E4;
        Tue, 12 Dec 2023 22:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702449104; x=1733985104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=cYOq7AZDrqOem5EFBS27D9w2EDbODgEUDb6Vlfdk2EM=;
  b=f3eJqOC/bDbmO3zWUeOgov91fD3ZQM9Ratix29Q5JuNoHjTeixzNwqOE
   qECF5M79adV3YXr+i+7Y2sh2tDke1RyR7kMq0LWWUi/GW8MImpsrfVtUV
   o/8rwY5HA08n30dCGmn8xUEFcl+tUei0Thag6Jb+tkN481Vor+jr3hyVJ
   eYNojx5QazuAnGmr0fONvJHeGkBVzoHXdVWEpkxfSJaDH/6TTsVxqrokw
   dU8MNw0y3P6P4cUOYNKlHwGWtz/sQ0E1uhXW4q4PYFHgSiYb7JpWC/ZgH
   qGZclvEtsCjtO/hQvDDdQvWl40aQsM7tmdVsc9pcnWaa1SFCOQlrxpvNP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="8281310"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="8281310"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 22:31:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="947065772"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="947065772"
Received: from srikandan-ilbpg12.png.intel.com ([10.88.229.69])
  by orsmga005.jf.intel.com with ESMTP; 12 Dec 2023 22:31:40 -0800
From:   nandhini.srikandan@intel.com
To:     fancer.lancer@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com
Subject: [PATCH v1 2/2] spi: dw: Remove Intel Thunder Bay SOC support
Date:   Wed, 13 Dec 2023 14:08:36 +0800
Message-Id: <20231213060836.29203-3-nandhini.srikandan@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231213060836.29203-1-nandhini.srikandan@intel.com>
References: <20231213060836.29203-1-nandhini.srikandan@intel.com>
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

Remove Intel Thunder Bay specific code as the product got cancelled and
there are no end customers or users.

Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index 6348a387a21c..fde3776a558b 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -72,8 +72,6 @@ properties:
           - const: snps,dw-apb-ssi
       - description: Intel Keem Bay SPI Controller
         const: intel,keembay-ssi
-      - description: Intel Thunder Bay SPI Controller
-        const: intel,thunderbay-ssi
       - description: Intel Mount Evans Integrated Management Complex SPI Controller
         const: intel,mountevans-imc-ssi
       - description: AMD Pensando Elba SoC SPI Controller
-- 
2.17.1

