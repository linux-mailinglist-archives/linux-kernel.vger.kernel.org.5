Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5207D47B6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 08:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjJXGtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 02:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbjJXGtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 02:49:50 -0400
Received: from out-198.mta1.migadu.com (out-198.mta1.migadu.com [IPv6:2001:41d0:203:375::c6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3135FD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 23:49:47 -0700 (PDT)
Date:   Tue, 24 Oct 2023 06:49:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698130185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kE8OYti4+LMxy0vL5HEZaS88Q3RDLe62P3e0AGdvy04=;
        b=mrnEzRW5SdcFfGfGvz3eR9k0Y57m2OuUFG9a3kyFu1GcjVEO4jjRSVvMJrOqClj+tdQcTf
        EBDnpod4e5DEc7VjzqvaKMlQYG0NM4fdmVshyYOsdXMGL8hNRHJxYNBw6QftPNFVI35R9k
        GD/sBInB77lE2QxcX2uHHaw3blXH62M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Vincent Donnefort <vdonnefort@google.com>
Subject: Re: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <ZTdpBDJcmIc6wFIE@linux.dev>
References: <20231024132835.3b885fb8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024132835.3b885fb8@canb.auug.org.au>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 01:28:35PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the kvm-arm tree got a conflict in:
> 
>   arch/arm64/kvm/mmu.c
> 
> between commits:
> 
>   0e0fb2f69c1b ("arm64: kvm: avoid CONFIG_PGTABLE_LEVELS for runtime levels")
>   8d35f7bcee55 ("arm64: kvm: Limit HYP VA and host S2 range to 48 bits when LPA2 is in effect")
> 
> from the arm64 tree and commit:
> 
>   bf92834e6f6e ("KVM: arm64: Use folio for THP adjustment")
> 
> from the kvm-arm tree.
> 
> I fixed it up (the latter removed the struct updated by the former, so
> I just did that) and can carry the fix as necessary.

Thanks Stephen, resolution looks good. I'll probably wind up pulling the
arm64 branch into the kvmarm tree.

-- 
Thanks,
Oliver
