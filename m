Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32E17906D2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 11:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351933AbjIBJKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 05:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351902AbjIBJKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 05:10:36 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC575172E
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 02:10:15 -0700 (PDT)
Received: from nazgul.tnic (dynamic-046-114-142-117.46.114.pool.telefonica.de [46.114.142.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 24FB41EC0865;
        Sat,  2 Sep 2023 11:10:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1693645813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IeAXA2DInhokU9eRZqPvxwd1VOJ4KTX+ZqS/K0m/I8E=;
        b=MMmfhajZ1SNF3466DEVZbAsdLyDZq22TyirDEXvpboQmPnXaWceBmvgE8bxOwW3NqtZCqw
        9SrXdKJKgyJBugJfViaQsf4tbSJkhvIkELre3+HiGZ0XA1I1nICAG27l+1zoqF/+36LRWh
        nT+bM5/6QWiqjglpFAPz2p003e3gTxw=
Date:   Sat, 2 Sep 2023 11:10:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 18/23] x86/srso: Remove redundant X86_FEATURE_ENTRY_IBPB
 check
Message-ID: <20230902091021.GBZPL7/UhPLiOmf2Fg@fat_crate.local>
References: <cover.1692919072.git.jpoimboe@kernel.org>
 <9b671422643939792afe05c625e93ef40d9b57b5.1692919072.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b671422643939792afe05c625e93ef40d9b57b5.1692919072.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 12:01:49AM -0700, Josh Poimboeuf wrote:
> The X86_FEATURE_ENTRY_IBPB check is redundant here due to the above
> RETBLEED_MITIGATION_IBPB check.  RETBLEED_MITIGATION_IBPB already
> implies X86_FEATURE_ENTRY_IBPB.  So if we got here and 'has_microcode'
> is true, it means X86_FEATURE_ENTRY_IBPB is not set.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/x86/kernel/cpu/bugs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I still don't like this one:

https://lore.kernel.org/r/20230825070936.GEZOhTsPiTLhY1i9xH@fat_crate.local

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
