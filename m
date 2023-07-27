Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5802F765B28
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjG0SGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjG0SGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:06:44 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDBA30ED
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690481202; x=1722017202;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Nn/+97mXokNFhGc4n8F4TMZQ782vpORbU0AqQNg977U=;
  b=g/Tfxyv/3yzO79MI8zeW4L9sTAlrBXoIsfq1Rkv5FyZ71cdabvEGq3cy
   lw/ov1URAta9SHjtcpH2yHttOdxKhK4awJXKAs7EoWFMLWbELEKShUUB+
   W5VGKXkAJgQ/f97w7jb0z2a1TI52kbL78BdvRe3ebuydQfvrL1RiKD1Li
   Bq8z2lH+OOMXGVrjE2izQqJzPybwp0/RqQhbZAacrYjTPQsE+dyjUEUau
   xY6VVAv/TZww21eMHlL3Lujs87djfBWx8fIef7BK2r4A8OHXinUzxz5ih
   90qxQvUanQwjkzcCLmlAiajt8sU+lA180Ul1K4nuiG/BDQ36jw1Bq2E/g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="454760077"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="454760077"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 11:06:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="870523911"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jul 2023 11:06:43 -0700
From:   Sohil Mehta <sohil.mehta@intel.com>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] x86/smpboot: Minor cleanup
Date:   Thu, 27 Jul 2023 18:05:30 +0000
Message-Id: <20230727180533.3119660-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These cleanup patches are minor and fairly independent. I have put them in a
series to make it easier to review. Please feel free to apply any of them.

I found these mainly through code inspection.

v2:
 - Added 2 more patches
 - Rebased to 6.5-rc3
 - Improved commit message
 
v1: https://lore.kernel.org/lkml/20230614201301.1308363-1-sohil.mehta@intel.com/

Sohil Mehta (3):
  x86/smpboot: Remove a stray comment about CPU hotplug
  x86/smp: Remove a non-existent function declaration
  x86/smpboot: Change smp_store_boot_cpu_info() to static

 arch/x86/include/asm/smp.h | 3 ---
 arch/x86/kernel/smpboot.c  | 6 ++----
 2 files changed, 2 insertions(+), 7 deletions(-)

-- 
2.34.1

