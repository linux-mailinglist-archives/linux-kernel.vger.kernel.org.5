Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA1778CD7F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240483AbjH2UUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240543AbjH2UUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:20:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954F31BB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693340417; x=1724876417;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9UpVrqG/z0ep55/hBj3A93fcY3XRqVjCUcQc1HHcn5M=;
  b=nxqQ98astXRgHZbFg2IgeSbjCMhfx6uyzFBS7UgQpDwgr1LEFpoH58VZ
   EiHKfALb8LNUctS3gyfqLJMYFcZSZ1TPjKcb7DCiNxCKErRas8PzCywUi
   oBe/qL9U7uNgM0lfUNYDsavmKKnYUG7Z7psqZc49Se0mJZa5RXnWZVZQn
   dkadvWQR13Gzr5jsY565goTF5JizUqNvhXdR/yw1q1hvuPGJr9/IRZprc
   bP1mbEFC5LaLMV0jsk/R4HqS3afYrlcGp3vBvtrZ4PlYpQ3v/ExcmA82g
   ahZhbe4+zhAl/OXbpQDb5QhiNM2i015TEQYRwQJRKAMhvUUEtTvxxYmlm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="374371539"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="374371539"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 13:20:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="804252729"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="804252729"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by fmsmga008.fm.intel.com with ESMTP; 29 Aug 2023 13:20:17 -0700
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/mm for 6.6-rc1
Date:   Tue, 29 Aug 2023 13:20:13 -0700
Message-Id: <20230829202013.2380560-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull a pair of small x86/mm changes for 6.6-rc1.  The INVPCID
one is purely a cleanup.  The PAT one fixes a real issue, albeit a
relatively obscure one (graphics device passthrough under Xen).  The
fix also makes the code much more readable.

--

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_6.6-rc1

for you to fetch changes up to 54e3d9434ef61b97fd3263c141b928dc5635e50d:

  x86/mm: Remove "INVPCID single" feature tracking (2023-08-03 10:34:05 -0700)

----------------------------------------------------------------
 - Remove unnecessary "INVPCID single" feature tracking
 - Include PAT in page protection modify mask

----------------------------------------------------------------
Dave Hansen (1):
      x86/mm: Remove "INVPCID single" feature tracking

Janusz Krzysztofik (1):
      x86/mm: Fix PAT bit missing from page protection modify mask

 arch/x86/include/asm/cpufeatures.h   |  1 -
 arch/x86/include/asm/pgtable_types.h | 11 ++++++-----
 arch/x86/mm/init.c                   |  9 ---------
 arch/x86/mm/tlb.c                    | 19 +++++++++++++------
 4 files changed, 19 insertions(+), 21 deletions(-)
