Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2550378F9FA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345204AbjIAIag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjIAIaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:30:35 -0400
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22EE9E;
        Fri,  1 Sep 2023 01:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1693557031; x=1725093031;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yn40/F52PrZNKOQZ2H5d9y5yfXuLciO6u8/X0LdsjxI=;
  b=Pz9OMQLag54gQRrhFz0o9T4B8Hr1svJPi3GtWMjvlXwuaJgUXhrrtWKa
   O8/kFYnP8zu9po0eXTOljZA6TuiBKETOJc98IEjVYq0sELXclzFeZueQn
   tkOCehAmY1UT+wF5qHqhfrQtej3Vg2wtJrEiWcauw9zKQC3Yt7rpesdDn
   E=;
X-IronPort-AV: E=Sophos;i="6.02,219,1688428800"; 
   d="scan'208";a="669111413"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 08:30:25 +0000
Received: from EX19MTAUWB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com (Postfix) with ESMTPS id C214F8042F;
        Fri,  1 Sep 2023 08:30:14 +0000 (UTC)
Received: from EX19D002ANA003.ant.amazon.com (10.37.240.141) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 1 Sep 2023 08:30:14 +0000
Received: from b0f1d8753182.ant.amazon.com (10.106.83.26) by
 EX19D002ANA003.ant.amazon.com (10.37.240.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 1 Sep 2023 08:30:10 +0000
From:   Takahiro Itazuri <itazur@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Takahiro Itazuri <zulinx86@gmail.com>,
        Takahiro Itazuri <itazur@amazon.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH v3] docs/hw-vuln: Update desc of best effort mode
Date:   Fri, 1 Sep 2023 09:29:59 +0100
Message-ID: <20230901082959.28310-1-itazur@amazon.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.83.26]
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D002ANA003.ant.amazon.com (10.37.240.141)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moves the description of the best effort mitigation mode to the table of
the possible values in the mds and tsx_async_abort docs, and adds the
same one to the mmio_stale_data doc.

Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---

v2 -> v3: https://lore.kernel.org/all/20230831111847.71030-1-itazur@amazon.com/
- Changed the subject prefix to "docs/hw-vuln".
- Removed an extra newline left.

v1 -> v2: https://lore.kernel.org/all/20230830144426.80258-1-itazur@amazon.com/
- Moved the desc into the table of the possible values.

---
 Documentation/admin-guide/hw-vuln/mds.rst     | 34 +++++++------------
 .../hw-vuln/processor_mmio_stale_data.rst     | 13 ++++++-
 .../admin-guide/hw-vuln/tsx_async_abort.rst   | 33 +++++++-----------
 3 files changed, 38 insertions(+), 42 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/mds.rst b/Documentation/admin-guide/hw-vuln/mds.rst
index 48ca0bd85..48c7b0b72 100644
--- a/Documentation/admin-guide/hw-vuln/mds.rst
+++ b/Documentation/admin-guide/hw-vuln/mds.rst
@@ -102,9 +102,19 @@ The possible values in this file are:
      * - 'Vulnerable'
        - The processor is vulnerable, but no mitigation enabled
      * - 'Vulnerable: Clear CPU buffers attempted, no microcode'
-       - The processor is vulnerable but microcode is not updated.
-
-         The mitigation is enabled on a best effort basis. See :ref:`vmwerv`
+       - The processor is vulnerable but microcode is not updated. The
+         mitigation is enabled on a best effort basis.
+
+         If the processor is vulnerable but the availability of the microcode
+         based mitigation mechanism is not advertised via CPUID, the kernel
+         selects a best effort mitigation mode. This mode invokes the mitigation
+         instructions without a guarantee that they clear the CPU buffers.
+
+         This is done to address virtualization scenarios where the host has the
+         microcode update applied, but the hypervisor is not yet updated to
+         expose the CPUID to the guest. If the host has updated microcode the
+         protection takes effect; otherwise a few CPU cycles are wasted
+         pointlessly.
      * - 'Mitigation: Clear CPU buffers'
        - The processor is vulnerable and the CPU buffer clearing mitigation is
          enabled.
@@ -119,24 +129,6 @@ to the above information:
     'SMT Host state unknown'  Kernel runs in a VM, Host SMT state unknown
     ========================  ============================================
 
-.. _vmwerv:
-
-Best effort mitigation mode
-^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-  If the processor is vulnerable, but the availability of the microcode based
-  mitigation mechanism is not advertised via CPUID the kernel selects a best
-  effort mitigation mode.  This mode invokes the mitigation instructions
-  without a guarantee that they clear the CPU buffers.
-
-  This is done to address virtualization scenarios where the host has the
-  microcode update applied, but the hypervisor is not yet updated to expose
-  the CPUID to the guest. If the host has updated microcode the protection
-  takes effect otherwise a few cpu cycles are wasted pointlessly.
-
-  The state in the mds sysfs file reflects this situation accordingly.
-
-
 Mitigation mechanism
 -------------------------
 
diff --git a/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst b/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
index c98fd1190..1302fd1b5 100644
--- a/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
+++ b/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
@@ -225,8 +225,19 @@ The possible values in this file are:
      * - 'Vulnerable'
        - The processor is vulnerable, but no mitigation enabled
      * - 'Vulnerable: Clear CPU buffers attempted, no microcode'
-       - The processor is vulnerable, but microcode is not updated. The
+       - The processor is vulnerable but microcode is not updated. The
          mitigation is enabled on a best effort basis.
+
+         If the processor is vulnerable but the availability of the microcode
+         based mitigation mechanism is not advertised via CPUID, the kernel
+         selects a best effort mitigation mode. This mode invokes the mitigation
+         instructions without a guarantee that they clear the CPU buffers.
+
+         This is done to address virtualization scenarios where the host has the
+         microcode update applied, but the hypervisor is not yet updated to
+         expose the CPUID to the guest. If the host has updated microcode the
+         protection takes effect; otherwise a few CPU cycles are wasted
+         pointlessly.
      * - 'Mitigation: Clear CPU buffers'
        - The processor is vulnerable and the CPU buffer clearing mitigation is
          enabled.
diff --git a/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst b/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
index 014167ef8..444f84e22 100644
--- a/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
+++ b/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
@@ -98,7 +98,19 @@ The possible values in this file are:
    * - 'Vulnerable'
      - The CPU is affected by this vulnerability and the microcode and kernel mitigation are not applied.
    * - 'Vulnerable: Clear CPU buffers attempted, no microcode'
-     - The system tries to clear the buffers but the microcode might not support the operation.
+     - The processor is vulnerable but microcode is not updated. The
+       mitigation is enabled on a best effort basis.
+
+       If the processor is vulnerable but the availability of the microcode
+       based mitigation mechanism is not advertised via CPUID, the kernel
+       selects a best effort mitigation mode. This mode invokes the mitigation
+       instructions without a guarantee that they clear the CPU buffers.
+
+       This is done to address virtualization scenarios where the host has the
+       microcode update applied, but the hypervisor is not yet updated to
+       expose the CPUID to the guest. If the host has updated microcode the
+       protection takes effect; otherwise a few CPU cycles are wasted
+       pointlessly.
    * - 'Mitigation: Clear CPU buffers'
      - The microcode has been updated to clear the buffers. TSX is still enabled.
    * - 'Mitigation: TSX disabled'
@@ -106,25 +118,6 @@ The possible values in this file are:
    * - 'Not affected'
      - The CPU is not affected by this issue.
 
-.. _ucode_needed:
-
-Best effort mitigation mode
-^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-If the processor is vulnerable, but the availability of the microcode-based
-mitigation mechanism is not advertised via CPUID the kernel selects a best
-effort mitigation mode.  This mode invokes the mitigation instructions
-without a guarantee that they clear the CPU buffers.
-
-This is done to address virtualization scenarios where the host has the
-microcode update applied, but the hypervisor is not yet updated to expose the
-CPUID to the guest. If the host has updated microcode the protection takes
-effect; otherwise a few CPU cycles are wasted pointlessly.
-
-The state in the tsx_async_abort sysfs file reflects this situation
-accordingly.
-
-
 Mitigation mechanism
 --------------------
 
-- 
2.40.1

