Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FAB7E423C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbjKGO6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbjKGO5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:57:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD073D47;
        Tue,  7 Nov 2023 06:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699369068; x=1730905068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gZq/xU5HPMr+7bL2m3UNHQGfAGkvgf+PBtN9vzhZEYs=;
  b=bPVa0yzyi56gJRfYYE9LoW/wuvwpss3xJVAr3NuCcrb9K8B6MlTn5x5Q
   ybKvIn+gZEU5tXUlpGdogdwAMe1UUpV2S1Wy0z183MyT8Jr6x8XdOP69M
   j2+5jDjtInlUPjUJ+Jx4GhMtzYiHEzt0lkWBpypGALNYNMhg3SqWa1L9L
   btBq7jON+tuCRhoHwddL6PYJ1AAc4P6eCI0Wy4TkE2+89Z5+TcHVF3DW/
   4B+cNchsVdL1DxXc1r7P6HFpF+u9HtMSwfZB5hWhBaX6Xr5GnQ7dHW+Uf
   1wHAcuNraNBO8dZhyADncs9zUFOG0pO/pB1hb/xwcIeY0XzSsWO4VK2ha
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="374555692"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="374555692"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:57:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="10443958"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:57:44 -0800
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com,
        hang.yuan@intel.com, tina.zhang@intel.com
Subject: [PATCH v17 008/116] [MARKER] The start of TDX KVM patch series: TDX architectural definitions
Date:   Tue,  7 Nov 2023 06:55:34 -0800
Message-Id: <1cba6d95689da1c9d5a5cfd423338482b01f68f7.1699368322.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1699368322.git.isaku.yamahata@intel.com>
References: <cover.1699368322.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

This empty commit is to mark the start of patch series of TDX architectural
definitions.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 Documentation/virt/kvm/index.rst              |  2 ++
 .../virt/kvm/intel-tdx-layer-status.rst       | 29 +++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 Documentation/virt/kvm/intel-tdx-layer-status.rst

diff --git a/Documentation/virt/kvm/index.rst b/Documentation/virt/kvm/index.rst
index ad13ec55ddfe..ccff56dca2b1 100644
--- a/Documentation/virt/kvm/index.rst
+++ b/Documentation/virt/kvm/index.rst
@@ -19,3 +19,5 @@ KVM
    vcpu-requests
    halt-polling
    review-checklist
+
+   intel-tdx-layer-status
diff --git a/Documentation/virt/kvm/intel-tdx-layer-status.rst b/Documentation/virt/kvm/intel-tdx-layer-status.rst
new file mode 100644
index 000000000000..f11ea701dc19
--- /dev/null
+++ b/Documentation/virt/kvm/intel-tdx-layer-status.rst
@@ -0,0 +1,29 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================
+Intel Trust Dodmain Extensions(TDX)
+===================================
+
+Layer status
+============
+What qemu can do
+----------------
+- TDX VM TYPE is exposed to Qemu.
+- Qemu can try to create VM of TDX VM type and then fails.
+
+Patch Layer status
+------------------
+  Patch layer                          Status
+
+* TDX, VMX coexistence:                 Applied
+* TDX architectural definitions:        Applying
+* TD VM creation/destruction:           Not yet
+* TD vcpu creation/destruction:         Not yet
+* TDX EPT violation:                    Not yet
+* TD finalization:                      Not yet
+* TD vcpu enter/exit:                   Not yet
+* TD vcpu interrupts/exit/hypercall:    Not yet
+
+* KVM MMU GPA shared bits:              Not yet
+* KVM TDP refactoring for TDX:          Not yet
+* KVM TDP MMU hooks:                    Not yet
-- 
2.25.1

