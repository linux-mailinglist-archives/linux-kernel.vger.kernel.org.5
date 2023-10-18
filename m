Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65627CEB8E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjJRXCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJRXC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:02:29 -0400
Received: from out-194.mta1.migadu.com (out-194.mta1.migadu.com [95.215.58.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD588115
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:02:26 -0700 (PDT)
Date:   Wed, 18 Oct 2023 23:02:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697670145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ft+pD73y1DZJ0lr84BaYHS65HwUeeV6y2PWxZKiyGhI=;
        b=Wg42NwHNgzVDbDgnArXZZAoUwHBK/hgIyaDqG5nq8vqIh+7Mp1o+vZg3avfvXMhkLxTCh0
        N0ULhb4wF9MfBoho/Ioa81IHw6gaVALGwDvVbqO9BvqnEczyuOU+cLQw64BhyYfFOMACOH
        fQ0GRWHDsPJIlzTiT5+U/UWydlQL2Xk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <ZTBj_DSqJDGemykz@linux.dev>
References: <20231017123017.3907baac@canb.auug.org.au>
 <ZS5sPNRe3GaOVN23@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS5sPNRe3GaOVN23@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 12:13:00PM +0100, Catalin Marinas wrote:
> On Tue, Oct 17, 2023 at 12:30:17PM +1100, Stephen Rothwell wrote:
> > Today's linux-next merge of the kvm-arm tree got a conflict in:
> > 
> >   arch/arm64/kvm/arm.c
> > 
> > between commit:
> > 
> >   d8569fba1385 ("arm64: kvm: Use cpus_have_final_cap() explicitly")
> > 
> > from the arm64 tree and commit:
> > 
> >   ef150908b6bd ("KVM: arm64: Add generic check for system-supported vCPU features")
> > 
> > from the kvm-arm tree.
> > 
> > I fixed it up (I just used the latter) and can carry the fix as
> > necessary.
> 
> Thanks Stephen. The fix looks fine, removing the
> cpus_have_final_cap(ARM64_HAS_32BIT_EL1) check in
> kvm_vcpu_init_check_features().

Agreed, I was moving this cap around in ef150908b6bd ("KVM: arm64: Add
generic check for system-supported vCPU features") and went ahead with
the conversion per Mark's series.

-- 
Thanks,
Oliver
