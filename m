Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1C07E4246
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbjKGO6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbjKGO54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:57:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC1B10C0;
        Tue,  7 Nov 2023 06:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699369072; x=1730905072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DLPNi9jXjbr4HdbjAnuHBOpBxwIVUIeOA5wtFcSAGOI=;
  b=C5SmEOhyt9glq3App3nWTXgh6jTN2ZsE5Ej94ExoPWBUtp1SbK8lx63g
   /WkHxazPg/zQ4/r7Oc2v9I/WdDWIhhEu1KtcQAbmozrshlGIRwcxKdHRF
   v+oW8lrMvEclEzESZ63zYpvUN2is/O52uhNXThqwLElZlGYDsO0D+9QEH
   dcUnMHo/lUcnFkJMkdXiAaWZ9RpTPdlHyNovoHZ+S+DIQxa78EOP3cjhS
   lUHQeOPxgOkQTtRktzb8IUnw7nh158Ma12fwDfCdTrqNdYKLXsFJYPYRe
   01JQ1H9nIy7jsnUHoWeQ9JgrdrK7SP8bZyUgU2QwL3uL4Nv8W+MOmnweZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="374555749"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="374555749"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:57:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="10444021"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:57:49 -0800
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
Subject: [PATCH v17 014/116] [MARKER] The start of TDX KVM patch series: TD VM creation/destruction
Date:   Tue,  7 Nov 2023 06:55:40 -0800
Message-Id: <f18be59ff17324d1400f1a68819e7b1869766d35.1699368322.git.isaku.yamahata@intel.com>
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

This empty commit is to mark the start of patch series of TD VM
creation/destruction.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 Documentation/virt/kvm/intel-tdx-layer-status.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/intel-tdx-layer-status.rst b/Documentation/virt/kvm/intel-tdx-layer-status.rst
index f11ea701dc19..098150da6ea2 100644
--- a/Documentation/virt/kvm/intel-tdx-layer-status.rst
+++ b/Documentation/virt/kvm/intel-tdx-layer-status.rst
@@ -16,8 +16,8 @@ Patch Layer status
   Patch layer                          Status
 
 * TDX, VMX coexistence:                 Applied
-* TDX architectural definitions:        Applying
-* TD VM creation/destruction:           Not yet
+* TDX architectural definitions:        Applied
+* TD VM creation/destruction:           Applying
 * TD vcpu creation/destruction:         Not yet
 * TDX EPT violation:                    Not yet
 * TD finalization:                      Not yet
-- 
2.25.1

