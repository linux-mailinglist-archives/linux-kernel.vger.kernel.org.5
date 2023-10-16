Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE6C7CAB81
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjJPOan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjJPOak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:30:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF31BB9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 07:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zarD/HuhsSVSqIGKf90N63+KfWcfgRI/tr5iKpowNVc=; b=O31yErO/+COk+OBHNtinP52gCk
        og8hkHJPGKWLTcgcbxxSQPnyQiyF6t0QrKFzc8FfgrEEPFWTJxKAl7tVKHzr1RD6HAimWz0kc09Dp
        C4V40cEFswAMnfHgKnJAIpN/M80N1bOi1qVHxmr4wA/Z1iKTxGYBDWPQt4yg2sJHnmBmLIXaJsf2B
        iNPxx8NT9U6ZT/LcwHzoQs/kt5hXhkPI0Drj+gJh4rCYwPBE8B85QutV5nXruYEwRZYPijTKg6YQy
        8jlaOq1cFlzuKl1rtutA9LWPZ/1lVft5pUDjEhYZrbhahTnp9cE5g+3aQ9n6FzTeeCsbiLoz/q+Ar
        jbwbwXCg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qsObn-0066IZ-0P;
        Mon, 16 Oct 2023 14:30:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 380FB300513; Mon, 16 Oct 2023 16:30:16 +0200 (CEST)
Date:   Mon, 16 Oct 2023 16:30:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] x86/paravirt: remove no longer needed paravirt
 patching code
Message-ID: <20231016143016.GF33217@noisy.programming.kicks-ass.net>
References: <20231016123933.17284-1-jgross@suse.com>
 <20231016123933.17284-5-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016123933.17284-5-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 02:39:33PM +0200, Juergen Gross wrote:
> Now that paravirt is using the alternatives patching infrastructure,
> remove the paravirt patching code.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/include/asm/paravirt.h       | 18 --------
>  arch/x86/include/asm/paravirt_types.h | 40 ----------------
>  arch/x86/include/asm/text-patching.h  | 12 -----
>  arch/x86/kernel/alternative.c         | 66 +--------------------------
>  arch/x86/kernel/paravirt.c            | 30 ------------
>  arch/x86/kernel/vmlinux.lds.S         | 13 ------
>  arch/x86/tools/relocs.c               |  2 +-
>  7 files changed, 3 insertions(+), 178 deletions(-)

More - more better! :-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
