Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B57A78EBDC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346020AbjHaLTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbjHaLTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:19:22 -0400
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83836E5F;
        Thu, 31 Aug 2023 04:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1693480752; x=1725016752;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h/nMy0t4wtPt6LFAJDminDBn1Pn/Vgam85P5np4XTd4=;
  b=swCz9v3YRVTMd5259QHRH4KEnJ5nD9O+h/bouBOKcW9hWeTF38JyTTSI
   kPR8jDIPqnlPKgMU1VmUUnCa5+RFEz5/81NyMwwn8N9oSQ2r2z0P9e2lL
   MiUBG7wXNbn8m46gn/fRyiN0/4y4EJfUFmY9O48l0ejtvPYzLce3qpDlT
   8=;
X-IronPort-AV: E=Sophos;i="6.02,216,1688428800"; 
   d="scan'208";a="26125601"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 11:19:09 +0000
Received: from EX19MTAUWA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com (Postfix) with ESMTPS id 8D7A7808D7;
        Thu, 31 Aug 2023 11:19:08 +0000 (UTC)
Received: from EX19D002ANA003.ant.amazon.com (10.37.240.141) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 31 Aug 2023 11:19:01 +0000
Received: from b0f1d8753182.ant.amazon.com (10.106.83.27) by
 EX19D002ANA003.ant.amazon.com (10.37.240.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.37;
 Thu, 31 Aug 2023 11:18:57 +0000
From:   Takahiro Itazuri <itazur@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Takahiro Itazuri <zulinx86@gmail.com>,
        Takahiro Itazuri <itazur@amazon.com>
Subject: [PATCH v2] docs: Update desc of best effort mode
Date:   Thu, 31 Aug 2023 12:18:47 +0100
Message-ID: <20230831111847.71030-1-itazur@amazon.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.83.27]
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
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
---

v1 -> v2: https://lore.kernel.org/all/20230830144426.80258-1-itazur@amazon.com/
- Puts the desc into the table of the possible values.

---
 Documentation/admin-guide/hw-vuln/mds.rst     | 33 ++++++++-----------
 .../hw-vuln/processor_mmio_stale_data.rst     | 13 +++++++-
 .../admin-guide/hw-vuln/tsx_async_abort.rst   | 32 ++++++++----------
 3 files changed, 38 insertions(+), 40 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/mds.rst b/Documentation/admin-guide/hw-vuln/mds.rst
index 48ca0bd85..0fe98151a 100644
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
@@ -119,23 +129,6 @@ to the above information:
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
index 014167ef8..c6400fe6b 100644
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
@@ -106,24 +118,6 @@ The possible values in this file are:
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
 
 Mitigation mechanism
 --------------------
-- 
2.40.1

