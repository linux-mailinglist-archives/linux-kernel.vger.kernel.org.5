Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F1E7A9D86
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjIUTjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjIUTir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:38:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52DBA0C1E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695319055; x=1726855055;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zasYRfWXsYur9eNYrfG33BQQNdIZEYY/Xi5N1N8P2TU=;
  b=Nz11IaphBSMtPstlivTbQbIodZHcUlUhk1BC1OGOMtNKfeT+A3lMVjNj
   dhrRYNd1VoJX5w4oTDUT1hsvnKFNUQkJeK/nSN5uxJeyZ2DUaaJnNn/e3
   nYcpUT/C5VBQT6B4p9rb99I2cNy+nrUCPw6LqbuibOMmgBYuvL8PNQY5k
   ZcZB+l/wmV3bw602hFGuB9CUw3qBxEl8odUzKhr0fmU4dx7RB5iBJj+tF
   PFdHqKMPKARdaDkH80/l9InSM6TUhGI72XZSitQOMbeRMVOmd3TzW9oFF
   tP5U8z9vuTKspv+eQLcqM565Ismum9yzaO11ckYKZsdnx0+53mP83J+p8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="383281997"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="383281997"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 07:08:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="1077899614"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="1077899614"
Received: from xiao-desktop.sh.intel.com ([10.239.46.158])
  by fmsmga005.fm.intel.com with ESMTP; 21 Sep 2023 07:08:16 -0700
From:   Xiao Wang <xiao.w.wang@intel.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        david@redhat.com, Xiao Wang <xiao.w.wang@intel.com>
Subject: [PATCH] riscv/mm: Fix the comment for swap pte format
Date:   Thu, 21 Sep 2023 22:16:52 +0800
Message-Id: <20230921141652.2657054-1-xiao.w.wang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Swap type takes bits 7-11 and swap offset should start from bit 12.

Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
---
 arch/riscv/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index e05b5dc1f0cb..e94a2998e81e 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -812,7 +812,7 @@ extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
  *	bit            5:	_PAGE_PROT_NONE (zero)
  *	bit            6:	exclusive marker
  *	bits      7 to 11:	swap type
- *	bits 11 to XLEN-1:	swap offset
+ *	bits 12 to XLEN-1:	swap offset
  */
 #define __SWP_TYPE_SHIFT	7
 #define __SWP_TYPE_BITS		5
-- 
2.25.1

