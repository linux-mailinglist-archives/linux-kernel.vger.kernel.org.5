Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285C280E74B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346272AbjLLJT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346268AbjLLJTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:19:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF8BC7;
        Tue, 12 Dec 2023 01:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702372796; x=1733908796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KElv1O/IUdorWxDjj22wZ5Qh+UzhUxPzqiNhHcqI9y4=;
  b=j4MVVJgZOk/pnD5P5xW6U7ruBsD/u2uUnIF0bSc94wGFd1cEshcp08/n
   O3yO3qpJrdxQ9Ufs2pHOJs3uLu0uDWG0aBhbQnQtSMxm90mZLUYt9Gd4I
   LQs+ANkDMyTLT+hPNh2YalgKHUAMpPSTgVP9wfUXpAHE/nxWDlYgKOgaX
   DFUQO/0iV8mmjeuQ+rKRejL1GtOHVzQvYD/DqMz5oMXA45DHJnFAU/RfR
   pnU2KhXTDnie+GoOs/RZ2Znpi92lP4+wv6YbroEGNSHhLN5+EqkskTlpS
   yIhrr/rHdo7pY1JvAsLJKH2gXuxk7iRrENJyu6nV/WIlo84LCgOKiP/qm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="480974227"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="480974227"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 01:19:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="917212936"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="917212936"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 01:19:48 -0800
From:   Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, haibo1.xu@intel.com, ajones@ventanamicro.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        wchen <waylingii@gmail.com>, Jisheng Zhang <jszhang@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Minda Chen <minda.chen@starfivetech.com>,
        Sean Christopherson <seanjc@google.com>,
        Like Xu <likexu@tencent.com>, Peter Xu <peterx@redhat.com>,
        Vipin Sharma <vipinsh@google.com>,
        Thomas Huth <thuth@redhat.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: [PATCH v4 03/11] KVM: selftests: Add CONFIG_64BIT definition for the build
Date:   Tue, 12 Dec 2023 17:31:12 +0800
Message-Id: <227b86955b24583b5cacedc8480e8f5d7e4fabf8.1702371136.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1702371136.git.haibo1.xu@intel.com>
References: <cover.1702371136.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since only 64bit KVM selftests were supported on all architectures,
add the CONFIG_64BIT definition in kvm/Makefile to ensure only 64bit
definitions were available in the corresponding included files.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 tools/testing/selftests/kvm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 4838ea899bbb..bb03e278a163 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -225,7 +225,7 @@ else
 LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
 endif
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
-	-Wno-gnu-variable-sized-type-not-at-end -MD\
+	-Wno-gnu-variable-sized-type-not-at-end -MD -DCONFIG_64BIT \
 	-fno-builtin-memcmp -fno-builtin-memcpy -fno-builtin-memset \
 	-fno-builtin-strnlen \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
-- 
2.34.1

