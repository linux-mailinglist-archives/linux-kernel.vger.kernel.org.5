Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6D97E981B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 09:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjKMIyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 03:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjKMIyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 03:54:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5AED79;
        Mon, 13 Nov 2023 00:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699865647; x=1731401647;
  h=from:to:cc:subject:date:message-id;
  bh=TUXq65hX8ZhAZuLbrHnY5jHl84bfioxI0R8GCbx3UHk=;
  b=mbqjS3PJyueFM3JLcsA83/P0THXE+DClswLB0C4OSzlh0f9Sl10t+EDD
   97GGkzvxHqAefMJtHPl9BPSke6vUn1OSGwDeyAYraWtppNXS2/f8oA8Sj
   6l6kzqS1UlD+ii2OQmh4n5LBMV6pLx/JBCMDZo16BJMpXQfhEWkXSkJ7g
   EVbfb1tpEVE5+TyZmT5LFEsUI/HB479xtbOW36dNdPUX4Jw5+6JiZm5KI
   jJvPR3EE7740lSzxGFPUSe0zs2Ukzq3o0vKij6seLv46rFfAZwnKgUT4T
   IMtCULL4ps0hkJ8JXaTSb2r4BZT8A64Qlyj4mDg2D1msfxE4/NJPW/eiE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="9044549"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="9044549"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 00:54:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="937688003"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="937688003"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 00:54:03 -0800
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] EDAC/igen6: Add EDAC support for several Intel SoCs with IBECC
Date:   Mon, 13 Nov 2023 16:53:13 +0800
Message-Id: <20231113085318.26783-1-qiuxu.zhuo@intel.com>
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

As these SoCs share similar IBECC registers, most of them are having
compute die IDs added for EDAC support. There are some minor differences
among them regarding IBECC presence detection, the number of memory
controllers, and the most significant bit of the error address.

[ Patch 1 serves as a preparation for Patch 4. ]

Qiuxu Zhuo (5):
  EDAC/igen6: Make get_mchbar() helper function
  EDAC/igen6: Add Intel Alder Lake-N SoCs support
  EDAC/igen6: Add Intel Raptor Lake-P SoCs support
  EDAC/igen6: Add Intel Meteor Lake-PS SoCs support
  EDAC/igen6: Add Intel Meteor Lake-P SoCs support

 drivers/edac/igen6_edac.c | 194 ++++++++++++++++++++++++++++++++++----
 1 file changed, 177 insertions(+), 17 deletions(-)


base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.17.1

