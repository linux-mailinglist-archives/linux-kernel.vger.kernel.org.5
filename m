Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364EF7E4317
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343630AbjKGPOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbjKGPOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:14:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9B41FFA;
        Tue,  7 Nov 2023 07:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699369261; x=1730905261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J0qMXx4Z1bmL0Bo7ShUuSxkVx6XY1Y4HAlOmBvk4LIo=;
  b=V8+oReH8UHO3uleZQkBsczee1k6YNbbDGYtF2tA6VaLHyMDdtbefcsh0
   ZNGuRz/5PeBHBWMRNOMuHvZLERHsE81zcvsT5GvCw5x/5YkdI17hmzS+P
   tgv1Okusy4cheRMV9yIm09X9QCKlQSrUlj7b1d1pwviYygKuliDKB4X4H
   qAtIArXwQt36IM+qKiaMM9YZsyu2HADvHqq0seG3W4A2ulCDvm4+AsRE8
   Rq+i+VYt1TuMZMiq04MNz5uiuYwuFBsZO/2eBk9YhI3WxYPjnbla1XTvp
   B3K2d27H7vsT36KtTYJqxTLRGTYAfzrwOW2PmKKvrQ5j9jFxyYGkrD4Gz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="2462450"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="2462450"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:58:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="10851468"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:58:18 -0800
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
Subject: [PATCH v17 068/116] [MARKER] The start of TDX KVM patch series: TD vcpu exits/interrupts/hypercalls
Date:   Tue,  7 Nov 2023 06:56:34 -0800
Message-Id: <26fbe3f05922ac0458835d6f1605d458226cab0c.1699368322.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1699368322.git.isaku.yamahata@intel.com>
References: <cover.1699368322.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

This empty commit is to mark the start of patch series of TD vcpu
exits, interrupts, and hypercalls.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 Documentation/virt/kvm/intel-tdx-layer-status.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/intel-tdx-layer-status.rst b/Documentation/virt/kvm/intel-tdx-layer-status.rst
index 33e107bcb5cf..7a16fa284b6f 100644
--- a/Documentation/virt/kvm/intel-tdx-layer-status.rst
+++ b/Documentation/virt/kvm/intel-tdx-layer-status.rst
@@ -13,6 +13,7 @@ What qemu can do
 - Qemu can create/destroy vcpu of TDX vm type.
 - Qemu can populate initial guest memory image.
 - Qemu can finalize guest TD.
+- Qemu can start to run vcpu. But vcpu can not make progress yet.
 
 Patch Layer status
 ------------------
@@ -24,7 +25,7 @@ Patch Layer status
 * TD vcpu creation/destruction:         Applied
 * TDX EPT violation:                    Applied
 * TD finalization:                      Applied
-* TD vcpu enter/exit:                   Applying
+* TD vcpu enter/exit:                   Applied
 * TD vcpu interrupts/exit/hypercall:    Not yet
 
 * KVM MMU GPA shared bits:              Applied
-- 
2.25.1

