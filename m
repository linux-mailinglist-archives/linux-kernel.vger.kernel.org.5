Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBEF7517BF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjGMEyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjGMEyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:54:20 -0400
Received: from out-55.mta0.migadu.com (out-55.mta0.migadu.com [IPv6:2001:41d0:1004:224b::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90621BF9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:54:17 -0700 (PDT)
Date:   Wed, 12 Jul 2023 21:54:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689224055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jvatkfDYHCzc/v6qAGFyRVg8w34hfubtE7G647tEMHw=;
        b=mA/uVKEvJgw2M8wAYWYl+WGAYZ/R/QfRxWBlDDWZB8+SwLbUbpICDlE6XivZmtOpWh6iIH
        TzjVbCXe3Mz78JIzu8M7rzjwIgEYOmR7Qme0Vdv1eIdpzlm4FrWiJCSgupkVx+1Zm3mU6P
        hA1AK5Dx2EI3X59RUf2T6nDYEQ9IsDg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     chenqingyun001@208suo.com
Cc:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
        james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Subject: Re: [PATCH] KVM: arm64:Use #include <linux/cpufeature.h> instead of
 <asm/cpufeature.h>        trailing whitespace     braces {} are not
 necessary for any arm of this statement
Message-ID: <ZK+DhMfudVdhXnm2@thinky-boi>
References: <tencent_1B7BA6D8EFD533563E01F8EB64A145417008@qq.com>
 <ef2ecfd960b2141b143003cc41ee551a@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef2ecfd960b2141b143003cc41ee551a@208suo.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qingyun,

I'm guessing you did not read our developer documentation, nor did you
run scripts/checkpatch.pl... 

 - The shortlog should be at most 75 characters, but ideally less.

 - The body should not be a restatement of the shortlog, and actually
   provide meaningful information to the reader not yet captured in the
   shortlog.

[*] https://www.kernel.org/doc/html/latest/process/submitting-patches.html

On Thu, Jul 13, 2023 at 11:03:44AM +0800, chenqingyun001@208suo.com wrote:
> include <linux/cpufeature.h> is a generic
> Having extra spaces or tabs has no real effect
> If there is only one statement in the if branch,
> curly braces {} can be omitted
> 
> Signed-off-by: Qingyun Chen <chenqingyun001@208suo.com>
> ---
>  arch/arm64/kvm/reset.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index b5dee8e57e77..4e6305dd1909 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -19,7 +19,7 @@
> 
>  #include <kvm/arm_arch_timer.h>
> 
> -#include <asm/cpufeature.h>
> +#include <linux/cpufeature.h>

Changing the include provides absolutely nothing of value. All the
things this compilation unit depends on are described in the asm header.
Furthermore, use of the asm header appears all throughout the arm64
code.

>  #include <asm/cputype.h>
>  #include <asm/fpsimd.h>
>  #include <asm/ptrace.h>
> @@ -122,7 +122,7 @@ static int kvm_vcpu_finalize_sve(struct kvm_vcpu *vcpu)
>          kfree(buf);
>          return ret;
>      }
> -
> +
>      vcpu->arch.sve_state = buf;
>      vcpu_set_flag(vcpu, VCPU_SVE_FINALIZED);
>      return 0;
> @@ -308,9 +308,9 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
> 
>      switch (vcpu->arch.target) {
>      default:
> -        if (vcpu_el1_is_32bit(vcpu)) {
> +        if (vcpu_el1_is_32bit(vcpu))
>              pstate = VCPU_RESET_PSTATE_SVC;
> -        } else if (vcpu_has_nv(vcpu)) {
> +        else if (vcpu_has_nv(vcpu)) {

No. What we have matches the kernel style guide. If one branch of a
conditional statement requires braces, _all_ branches get braces.

[*] https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-braces-and-spaces

I strongly suggest you read up on the kernel developer documentation
before your next contribution, as you're unlikely to win any favors with
reviewers with problematic submissions such as this.

--
Thanks,
Oliver
