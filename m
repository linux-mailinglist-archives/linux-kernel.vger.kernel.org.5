Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFC8751697
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 05:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjGMDDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 23:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjGMDDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:03:50 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B75171D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:03:47 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1fZS54BfzBJkkL
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 11:03:44 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689217424; x=1691809425; bh=vC33ODhevtPw2XxKtonUFPkCRFb
        K3xlTcDVg2UQ4oi8=; b=cdPN4JJU8n+AxEqOGDqdy4BLQxYigHnPx8hpq23Fdfd
        1mgqwx22m97tfw9gWF0wx2MqQt4wWPFm+5xa8MlYC3rIqAb9zaDAZPAt94X0lWxk
        JROtb/G4pmOjiD9QKVtHSFIsinE41oHutxilFhHiAuZWT94gb88MuqZrIPrDRgW/
        soBLjg/yM1+oNjIDjRbJii/kJ944zyDrG2WlU9CYw+F/c/OkPGkEQZOaPUVmxTq8
        82kc3/HOeqbW40oisJyWkPEHfsuRBqz81hzV3Aja8+grqSwdmx8Vfr4eg7JnJY2n
        kCttxW9MBkfDTP9pQPUinOmPm8/hE7cEFwLfxF7A0nA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JniKFitXXnKU for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jul 2023 11:03:44 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1fZS0sb0zBJBXT;
        Thu, 13 Jul 2023 11:03:44 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 13 Jul 2023 11:03:44 +0800
From:   chenqingyun001@208suo.com
To:     maz@kernel.org, oliver.upton@linux.dev, catalin.marinas@arm.com,
        will@kernel.org
Cc:     kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
        james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Subject: [PATCH] KVM: arm64:Use #include <linux/cpufeature.h> instead of
 <asm/cpufeature.h>        trailing whitespace     braces {} are not necessary for
 any arm of this statement
In-Reply-To: <tencent_1B7BA6D8EFD533563E01F8EB64A145417008@qq.com>
References: <tencent_1B7BA6D8EFD533563E01F8EB64A145417008@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <ef2ecfd960b2141b143003cc41ee551a@208suo.com>
X-Sender: chenqingyun001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

include <linux/cpufeature.h> is a generic
Having extra spaces or tabs has no real effect
If there is only one statement in the if branch,
curly braces {} can be omitted

Signed-off-by: Qingyun Chen <chenqingyun001@208suo.com>
---
  arch/arm64/kvm/reset.c | 8 ++++----
  1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index b5dee8e57e77..4e6305dd1909 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -19,7 +19,7 @@

  #include <kvm/arm_arch_timer.h>

-#include <asm/cpufeature.h>
+#include <linux/cpufeature.h>
  #include <asm/cputype.h>
  #include <asm/fpsimd.h>
  #include <asm/ptrace.h>
@@ -122,7 +122,7 @@ static int kvm_vcpu_finalize_sve(struct kvm_vcpu 
*vcpu)
          kfree(buf);
          return ret;
      }
-
+
      vcpu->arch.sve_state = buf;
      vcpu_set_flag(vcpu, VCPU_SVE_FINALIZED);
      return 0;
@@ -308,9 +308,9 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)

      switch (vcpu->arch.target) {
      default:
-        if (vcpu_el1_is_32bit(vcpu)) {
+        if (vcpu_el1_is_32bit(vcpu))
              pstate = VCPU_RESET_PSTATE_SVC;
-        } else if (vcpu_has_nv(vcpu)) {
+        else if (vcpu_has_nv(vcpu)) {
              pstate = VCPU_RESET_PSTATE_EL2;
          } else {
              pstate = VCPU_RESET_PSTATE_EL1;
