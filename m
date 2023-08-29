Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62DB78BD94
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 06:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbjH2Et4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 00:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbjH2Etx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 00:49:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B1711C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 21:49:50 -0700 (PDT)
Received: from nazgul.tnic (unknown [78.130.214.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5D9841EC0513;
        Tue, 29 Aug 2023 06:49:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1693284588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZWf55GxkQgns9LPb7YHeI7mUpkD2EcIov8GntqvrJI4=;
        b=mcv7KMb5t8CnwzCro0HVb58BNsoHMypoQJifpZpHJpp8cWvaHlNN+MBtFEWQUEQPh/oaWa
        gM3rz7CpeMtG+pYpYtnEIIJtV5P6ghyuh0khJvi+mTs942DPESnCe5bnEc8gRaLSH7B3gC
        d0vTfVgrOtuL4w1Z0Zpb/srPzd1fxzE=
Date:   Tue, 29 Aug 2023 06:49:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/microcode for v6.6-rc1
Message-ID: <20230829044955.GBZO1486V0PJKFAoSv@fat_crate.local>
References: <20230828122533.GBZOySPQIjw25NiUqI@fat_crate.local>
 <CAHk-=wjPNoHZm4ukpSXRCpxoCSb59GLgiDZBTgs-yn0=082TFw@mail.gmail.com>
 <CAHk-=wgYsC7XcPRwekr5RcqAn4EkjyhpjzB34i-GfyVe-unTbA@mail.gmail.com>
 <CAHk-=wjnKqHf3RCJuid_deMa6MHaARZVMg9LFMsx16R-wVUzqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjnKqHf3RCJuid_deMa6MHaARZVMg9LFMsx16R-wVUzqQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 05:11:09PM -0700, Linus Torvalds wrote:
> .. actually, I have now gotten around to Ingo's "Misc x86 cleanups"
> tree, and there I find the declaration movement to <asm/processor.h>
> by Arnd.
> 
> So I ended up just making my tree match at that point.

Yap, looks good, thanks.

The logic was to have the declarations in the processor.h header as the
definition is in the processor-specific file cpu/amd.c.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
