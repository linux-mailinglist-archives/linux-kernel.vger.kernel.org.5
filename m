Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCABA75211D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjGMMUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbjGMMT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:19:59 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FF026B3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:19:47 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1tvy14zHzBRSV9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:19:42 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689250782; x=1691842783; bh=r7J75gJn0L5wuugvzGABNEIG4Fd
        2ejoVXDfNg+ybWRw=; b=SRGvJb4ymU2AbaiXP/PxsqgSiY8feDCP51hCM3h8k7M
        YYvDPyV9M+rPZ5CdgXMHmYVrW/DJ+6tZMqucWZKz9ENoYZUzZSGWFambaFvawKCM
        swzKN/97U7hORR7HVP621PbBZBDtemvoYznEjR9OM3t7hB7+WtZqqExjgPpv9jnM
        Z1l9qbVPjiKxsEFpb8LvZ0/A3ur2mNHB8YxQz6+wgEWR/j/K17vsKbuwgPbSRgOn
        8fv8HEkVlKGZN4Q75xgF0xJUI/jclx3/ZlPkuNTHBVmj0N1fCLj9FNuWaTNr/qQ3
        JEa1b4enX/mKxL8ZPa38z2VJhUYEBNyFGhgpXqLT1ew==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id L56yPDs3IT7r for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jul 2023 20:19:42 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1tvx4g1wzBRRLw;
        Thu, 13 Jul 2023 20:19:41 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 13 Jul 2023 20:19:41 +0800
From:   chenqingyun001@208suo.com
To:     maz@kernel.org, oliver.upton@linux.dev, catalin.marinas@arm.com,
        will@kernel.org
Cc:     kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
        james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Subject: [PATCH] KVM: arm64:space prohibited between function name         and
 open parenthesis '(';space required       before the open parenthesis '('
In-Reply-To: <tencent_A24E3EC2F8CE6474455D704AA667EF103308@qq.com>
References: <tencent_A24E3EC2F8CE6474455D704AA667EF103308@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <a9d6a2ccfa775c0ea91032ac5c76ea8e@208suo.com>
X-Sender: chenqingyun001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using spaces can affect the readability and consistency
of your code. If you use a space between the function name
and the opening parenthesis, it may be mistaken for the
function name instead of the actual function name.
Use spaces between keywords and opening parentheses to
distinguish function calls from control statements

Signed-off-by: Qingyun Chen <chenqingyun001@208suo.com>
---
  arch/arm64/kvm/hyp/exception.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/exception.c 
b/arch/arm64/kvm/hyp/exception.c
index 424a5107cddb..46888dba3def 100644
--- a/arch/arm64/kvm/hyp/exception.c
+++ b/arch/arm64/kvm/hyp/exception.c
@@ -16,7 +16,7 @@
  #include <asm/kvm_mmu.h>
  #include <asm/kvm_nested.h>

-#if !defined (__KVM_NVHE_HYPERVISOR__) && !defined 
(__KVM_VHE_HYPERVISOR__)
+#if !defined(__KVM_NVHE_HYPERVISOR__) && 
!defined(__KVM_VHE_HYPERVISOR__)
  #error Hypervisor code only!
  #endif

@@ -295,7 +295,7 @@ static void enter_exception32(struct kvm_vcpu *vcpu, 
u32 mode, u32 vect_offset)
      return_address  += return_offsets[vect_offset >> 2][is_thumb];

      /* KVM only enters the ABT and UND modes, so only deal with those 
*/
-    switch(mode) {
+    switch (mode) {
      case PSR_AA32_MODE_ABT:
          __vcpu_write_spsr_abt(vcpu, host_spsr_to_spsr32(spsr));
          vcpu_gp_regs(vcpu)->compat_lr_abt = return_address;
