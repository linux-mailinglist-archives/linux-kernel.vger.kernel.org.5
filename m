Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9878F7E4329
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343887AbjKGPQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343889AbjKGPQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:16:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97078448E;
        Tue,  7 Nov 2023 07:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699369207; x=1730905207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R5wOuoM4Onpjff9OlffMGMEw35e7AU+j3x/NDTZE/oY=;
  b=e5FvrVH4lIcfuDLq2IzvlRi+U8EemuU2o6Lvyh30F4dNulCVIbJDTJl7
   +o2dD/w9Rv29ljgKD2cbp9e2lI9KooG+40Gkpm5IwkxwGpt0VbzArubEP
   5d7f6xzB1hQCwn634JwP+8RBzJw/FqHDze75xri0ZMznRA6K0NLz73R1A
   3OCrUsm+qGn9pIqBburP+m6rY4A/ty6honVEFSzLEs/5snSOiM3ddeMaZ
   px9SD8Qj42w9Ea9Su4DPzU4zpCw3nbVzLwOcCVeVEJAL1iWUSgFzBMqKy
   7gz632AP0xLNTdX6EFAk1QfgjEYZJ2aw4jIbyAxkvsGDgPv20rRfK7jCy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="2462414"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="2462414"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:58:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="10851446"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:58:17 -0800
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
Subject: [PATCH v17 061/116] [MARKER] The start of TDX KVM patch series: TD vcpu enter/exit
Date:   Tue,  7 Nov 2023 06:56:27 -0800
Message-Id: <0e40c79b8767c196cd73ef7556890984339d357b.1699368322.git.isaku.yamahata@intel.com>
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
enter/exit.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 Documentation/virt/kvm/intel-tdx-layer-status.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/intel-tdx-layer-status.rst b/Documentation/virt/kvm/intel-tdx-layer-status.rst
index 46ae049b6b85..33e107bcb5cf 100644
--- a/Documentation/virt/kvm/intel-tdx-layer-status.rst
+++ b/Documentation/virt/kvm/intel-tdx-layer-status.rst
@@ -12,6 +12,7 @@ What qemu can do
 - Qemu can create/destroy guest of TDX vm type.
 - Qemu can create/destroy vcpu of TDX vm type.
 - Qemu can populate initial guest memory image.
+- Qemu can finalize guest TD.
 
 Patch Layer status
 ------------------
@@ -22,8 +23,8 @@ Patch Layer status
 * TD VM creation/destruction:           Applied
 * TD vcpu creation/destruction:         Applied
 * TDX EPT violation:                    Applied
-* TD finalization:                      Applying
-* TD vcpu enter/exit:                   Not yet
+* TD finalization:                      Applied
+* TD vcpu enter/exit:                   Applying
 * TD vcpu interrupts/exit/hypercall:    Not yet
 
 * KVM MMU GPA shared bits:              Applied
-- 
2.25.1

