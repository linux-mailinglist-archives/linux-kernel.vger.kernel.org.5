Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCEA7D8BF2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 00:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjJZW4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 18:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjJZW4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 18:56:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C4C19A7;
        Thu, 26 Oct 2023 15:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698360970; x=1729896970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mc7kQfl3lsKa9cHbrKVWe9ASJRPZQ1HJXSWoLjPrDt8=;
  b=Kn4jIAJqvvYG4SeRZ0rBiZKCdLMntuHabAXm3Xltp5gHhHTrSFqL/pr4
   rtP9zqEXb43ntwFqPWnYnv3JWf+gKkFsANW1iWgK8nxqzpH30jftdDHdB
   P+QkTINaYnQWe1GRcQ76GOJIetdHqVwFsMApCqdpKZsS/aebWrD5h5Qvp
   9N8TelZvwJw0XYifG8E1B7LRBDwZyTv3DEtrsPtXvkaWwsFo/Q81hkOs+
   Txry+60R36VkoOcDmHv8sEtHqCzxkTign90vfFJyzzKddZjhI/lT+mQ7a
   3Yy+4rentjSqPet6NnQgCe/0X1EijNJRykU5ICE2KafkQon+HjjgVVz0M
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="367012866"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="367012866"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 15:56:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="752917106"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="752917106"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orsmga007.jf.intel.com with ESMTP; 26 Oct 2023 15:56:09 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     tip-bot2@linutronix.de
Cc:     #@tip-bot2.tec.linutronix.de, haitao.huang@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        mingo@kernel.org, stable@vger.kernel.org,
        v6.0+@tip-bot2.tec.linutronix.de, x86@kernel.org
Subject: [PATCH] Revert "x86/sgx: Return VM_FAULT_SIGBUS instead of VM_FAULT_OOM for EPC exhaustion"
Date:   Thu, 26 Oct 2023 15:55:28 -0700
Message-Id: <20231026225528.5738-1-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <169778941056.3135.14169781154210769341.tip-bot2@tip-bot2>
References: <169778941056.3135.14169781154210769341.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 6b7b71a70af6d75e0a9eddf4b01e4383a78b8a5e.
That patch was a mistake.

link: https://lore.kernel.org/all/op.2dfkbh2iwjvjmi@hhuan26-mobl.amr.corp.intel.com/

Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
Sorry for the trouble. Please use this to revert or drop it from the
the tip/x86/urgent branch.
---
 arch/x86/kernel/cpu/sgx/encl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index d13b7e4ad0f5..279148e72459 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -322,7 +322,7 @@ struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
  * ENCLS[EAUG] instruction.
  *
  * Returns: Appropriate vm_fault_t: VM_FAULT_NOPAGE when PTE was installed
- * successfully, VM_FAULT_SIGBUS as error otherwise.
+ * successfully, VM_FAULT_SIGBUS or VM_FAULT_OOM as error otherwise.
  */
 static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
 				     struct sgx_encl *encl, unsigned long addr)
@@ -348,7 +348,7 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
 	secinfo_flags = SGX_SECINFO_R | SGX_SECINFO_W | SGX_SECINFO_X;
 	encl_page = sgx_encl_page_alloc(encl, addr - encl->base, secinfo_flags);
 	if (IS_ERR(encl_page))
-		return VM_FAULT_SIGBUS;
+		return VM_FAULT_OOM;
 
 	mutex_lock(&encl->lock);
 
-- 
2.25.1

