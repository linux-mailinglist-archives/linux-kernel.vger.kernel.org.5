Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7C975BED6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjGUG1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGUG1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:27:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752672D45;
        Thu, 20 Jul 2023 23:26:57 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="453327512"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="453327512"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 23:26:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="727990179"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="727990179"
Received: from pglmail07.png.intel.com ([10.221.193.207])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jul 2023 23:26:52 -0700
Received: from localhost (pglc00300.png.intel.com [10.221.233.223])
        by pglmail07.png.intel.com (Postfix) with ESMTP id 968BA482B;
        Fri, 21 Jul 2023 14:26:51 +0800 (+08)
Received: by localhost (Postfix, from userid 11742525)
        id 909A580F8C4; Fri, 21 Jul 2023 14:26:51 +0800 (+08)
From:   Boon@ecsmtp.png.intel.com, Khai@ecsmtp.png.intel.com,
        "Ng <boon.khai.ng"@intel.com
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Boon Khai Ng <boon.khai.ng@intel.com>,
        Shevchenko Andriy <andriy.shevchenko@intel.com>,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Leong Ching Swee <leong.ching.swee@intel.com>,
        G Thomas Rohan <rohan.g.thomas@intel.com>,
        Shevchenko Andriy <andriy.shevchenko@linux.intel.com>
Subject: [Enable Designware XGMAC VLAN Stripping Feature 0/2]
Date:   Fri, 21 Jul 2023 14:26:15 +0800
Message-Id: <20230721062617.9810-1-boon.khai.ng@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_UNBAL1,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boon Khai Ng <boon.khai.ng@intel.com>

Hi,
The Designware 10G MAC(dwxgmac) driver has lack of vlan support
in term of hardware, such as the hardware accelerated VLAN stripping.
The driver was not draft from scratch, however it was ported from the
Ethernet Quality-of-Service (dwmac4) driver, it was tested working on
ourside.

Reviewed-by: Shevchenko Andriy <andriy.shevchenko@linux.intel.com>

Boon Khai Ng (2):
  dt-bindings: net: snps,dwmac: Add description for rx-vlan-offload
  net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping

 .../devicetree/bindings/net/snps,dwmac.yaml   |  5 +++
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    | 28 ++++++++++++++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 38 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  | 18 +++++++++
 drivers/net/ethernet/stmicro/stmmac/hwif.h    | 16 ++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 29 +++++++++++---
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  6 +++
 include/linux/stmmac.h                        |  1 +
 8 files changed, 136 insertions(+), 5 deletions(-)

-- 
2.25.1

