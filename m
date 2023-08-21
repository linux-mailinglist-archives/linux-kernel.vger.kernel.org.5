Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC1C7827E1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjHUL1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjHUL1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:27:33 -0400
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C939C3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1692617251;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+GjJMJBMnIjNb7IoAj9YQgAPR3WDw+7KrmPdjN04OSU=;
  b=XbXvcC7Iowb8/IRiyP5p2McMBWG7gZLgIkEsrog07b8SqOnWdWCVdizj
   YhPp3BDsAHZye1x4eoDSfeTnbuq0HzHDK4o8CULtW1eAhqeZgmCcHS0U2
   oEfqZh90+i/272LO2hpv+2tstK726Nb+hkBlyaVhgZkb/RbdAByyc88x+
   g=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 120127124
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:vDiPLqnUr5A85LKB/mRw22no5gwoJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIbXjzQbq6IN2H1fNEnPYu1oB8Gv8SHnNY1SVdrrSxgFSMWpZLJC+rCIxarNUt+DCFhoGFPt
 JxCN4aafKjYaleG+39B55C49SEUOZmgH+a6U6icfHgqH2eIcQ954Tp7gek1n4V0ttawBgKJq
 LvartbWfVSowFaYCEpNg064gE0p5K2aVA8w5ARkPqgb5gaGzRH5MbpETU2PByqgKmVrNrbSq
 9brlNmR4m7f9hExPdKp+p6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTbZLwXXx/mTSR9+2d/
 f0W3XCGpaXFCYWX8AgVe0Ew/yiTpsSq8pefSZS0mZT7I0Er7xIAahihZa07FdRwxwp5PY1B3
 eEVKTI3RR6Ku/mdn/G2QMh8oMoRMMa+aevzulk4pd3YJfMvQJSFSKTW/95Imjw3g6iiH96HO
 ZBfM2A2Kk2dPVsWYAx/5JEWxY9EglHWdTFCpU3Tjq0w+2XJlyR60aT3McqTcduPLSlQth/C/
 jucoD2jXnn2MvTA9BSgyE/9h9SMgDGqYd8ICpqk3OB11Qj7Kms7V0RNCArTTeOCokq/Xc9Pb
 k8Z4CwjqYAs+0GxCNrwRRu1pDiDpBF0c9BIO+Q+6QyLmuzY7m6xHmUYQyRTQN0gutU/STEj2
 hmOhdyBLSw/7pWWRGib+7PSqim9UQAXNWgDYCUDQCMG7sPlrYV1iQjAJv5pGaSoyNjyFjzq6
 zmPoG41gLB7peICyaS3u3POmzaloLDASwJz7QLSNkqj7wA/bom/Zpev93DA8O1Nao2eSzGps
 2IJlMuexOQPC4ydmiuQRukEALCu4bCCKjK0qUJgG4kJ8zWr5mK5eoZR8HdyKS9U3t0sIGGzJ
 hWJ4EUIucEVZSHxBUNqX26vI9knzKraPtrsauv/MZlDaLlhUgG14C47MCZ8wFvRuEQrlKg+P
 7KSfsCtEWsWBMxb8damewsO+eR1n35jnAs/Ubi+lk36iuTGOBZ5XJ9faDOzgvYFALRoSek/2
 /JWLIO0xhpWS4USiQGHoNdIfTjmwZXWbK0aSvC7lMbYe2KK+0l7UZc9JI/NnKQ8xMxoeh/gp
 C3VZ6Oh4AOXaYf7AQuLcGt/T7jkQIxyq3k2VQR1YwfyhiV9PdnysftOH3fSQVXA3LY/pcOYs
 tFfI5nQahixYmqvF8shgWnV89U5KUXDafOmNCu5ejkvF6OMtCSQkuIIijDHrXFUZgLu7JtWn
 lFV/l+DKXb1b1g4XZm+hTPG5w/ZgEXxb8orABuVc4cLKRSzmGWoQgSo5sIKzwg3AU2r7lOnO
 8y+WH/0ecGlT1cJzeT0
IronPort-HdrOrdr: A9a23:bhfiSas6KOves1Icygs5RCza7skDWNV00zEX/kB9WHVpm62j+P
 xG+c5x6faaskd3ZJhNo7G90dC7MBbhHP1Oj7X5Q43SODUO41HYT72KhLGKq1eMdxEWkNQts5
 uIGJIfNDSfNykAsS/S2njbL/8QhPWB7aC0laP/4h5WPHtXgnhbnn5E49CgYzVLeDU=
X-Talos-CUID: =?us-ascii?q?9a23=3AjDuopGlX38Uv+QJOTTRCl9heH5rXOWDQzXXqCEG?=
 =?us-ascii?q?xNX1CF/6YQ36A3q1Wj8U7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ACITEng+HKLBi+WbaD3pFT/mQf5hVzYGUNREMqtY?=
 =?us-ascii?q?bqZi9aDZuHCu3kiviFw=3D=3D?=
X-IronPort-AV: E=Sophos;i="6.01,190,1684814400"; 
   d="scan'208";a="120127124"
From:   Andrew Cooper <andrew.cooper3@citrix.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Andrew Cooper <andrew.cooper3@citrix.com>, <x86@kernel.org>,
        "Borislav Petkov" <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Babu Moger <babu.moger@amd.com>, <David.Kaplan@amd.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/4] x86/srso: Reduce overhead of the mitigation
Date:   Mon, 21 Aug 2023 12:27:19 +0100
Message-ID: <20230821112723.3995187-1-andrew.cooper3@citrix.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main point of this series is patch 4 to remove one taken branch from every
function return.  Everything else is cleanup.

Patch 3 has an issue that sadly may invalidate this as a technique.  Patch 4
needs some objtool whispering to fix.

Based on x86/urgent but I suspect this may want rebasing around other fixes in
flight.

Andrew Cooper (4):
  x86/srso: Rename srso_alias_*() to srso_fam19_*()
  x86/srso: Rename fam17 SRSO infrastructure to srso_fam17_*()
  x86/ret-thunk: Support CALL-ing to the ret-thunk
  x86/srso: Use CALL-based return thunks to reduce overhead

 arch/x86/include/asm/nospec-branch.h |  9 ++--
 arch/x86/kernel/alternative.c        |  4 +-
 arch/x86/kernel/cpu/bugs.c           |  9 ++--
 arch/x86/kernel/ftrace.c             |  8 +--
 arch/x86/kernel/static_call.c        | 10 ++--
 arch/x86/kernel/vmlinux.lds.S        | 10 ++--
 arch/x86/lib/retpoline.S             | 75 ++++++++++++----------------
 arch/x86/net/bpf_jit_comp.c          |  5 +-
 8 files changed, 67 insertions(+), 63 deletions(-)


base-commit: 6405b72e8d17bd1875a56ae52d23ec3cd51b9d66
-- 
2.30.2

