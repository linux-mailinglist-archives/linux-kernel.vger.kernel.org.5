Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A81D7CC194
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbjJQLNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjJQLNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:13:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9B5A2;
        Tue, 17 Oct 2023 04:13:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8141CC433C8;
        Tue, 17 Oct 2023 11:13:03 +0000 (UTC)
Date:   Tue, 17 Oct 2023 12:13:00 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>
Subject: Re: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <ZS5sPNRe3GaOVN23@arm.com>
References: <20231017123017.3907baac@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017123017.3907baac@canb.auug.org.au>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 12:30:17PM +1100, Stephen Rothwell wrote:
> Today's linux-next merge of the kvm-arm tree got a conflict in:
> 
>   arch/arm64/kvm/arm.c
> 
> between commit:
> 
>   d8569fba1385 ("arm64: kvm: Use cpus_have_final_cap() explicitly")
> 
> from the arm64 tree and commit:
> 
>   ef150908b6bd ("KVM: arm64: Add generic check for system-supported vCPU features")
> 
> from the kvm-arm tree.
> 
> I fixed it up (I just used the latter) and can carry the fix as
> necessary.

Thanks Stephen. The fix looks fine, removing the
cpus_have_final_cap(ARM64_HAS_32BIT_EL1) check in
kvm_vcpu_init_check_features().

-- 
Catalin
