Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B647BB5C2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjJFK7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjJFK7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:59:50 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766CACE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 03:59:45 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5335725cf84so3616020a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 03:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696589984; x=1697194784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAuuYKt1AgIPyV6uxItWEA2AncLhqXC4C5AM+mIo8z0=;
        b=gyoLuVp2V3+erT/+L4SkKZMM5fEIBFkdW0Lf5cT4jWvPZ/uXnDgHE66xNFunFBO7Co
         RZx2QOutdLka2TptTXDIv0TfiuQXlbbPCCMo/if8utiFYdXfRNiCjTXFfeKze+vzMYpj
         5simal4qY/laxmI+GSXSjcKKpMXYFh6jON24o0pSZpmcPhQoA6aw/XvBW6ZFdMDY+kBX
         OjVyDOFCysondwuMS+NfAtGYqhI+amVkXsuyBUTRo109cqp2kXEtrMYYQsBHk3ayP9BK
         L8mZWl0y00qPCSnqRCYv0Yf9HVmf1unPp0r5yaZvvddqM+NapHS+oItv49RG7JmJaXQl
         jV2w==
X-Gm-Message-State: AOJu0YzIODY55XZywtJbTI9EgIX2KLxwo3yMyY+sFLljiKL0cge15Le0
        rdZfxjkwdqzQ+fl4MGz9Ws/39/hIANM=
X-Google-Smtp-Source: AGHT+IFf2FQsn9AXzxNxCXar1vrjQNt3kFz2IQq0VUCg2GqPLtb9flOIgIfwACr9pyXMHVJOghrtKQ==
X-Received: by 2002:aa7:d9cd:0:b0:533:49d2:dc8f with SMTP id v13-20020aa7d9cd000000b0053349d2dc8fmr6473773eds.17.1696589983603;
        Fri, 06 Oct 2023 03:59:43 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-009.fbsv.net. [2a03:2880:31ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id c6-20020aa7c746000000b00537f5e85ea0sm2393308eds.13.2023.10.06.03.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 03:59:43 -0700 (PDT)
Date:   Fri, 6 Oct 2023 03:59:39 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86/bugs: Add a separate config for each mitigation
Message-ID: <ZR/om/SzaPCwzYv7@gmail.com>
References: <20230628142129.2468174-1-leitao@debian.org>
 <ZRV1bIuSXjZ+uPKB@gmail.com>
 <20231005162545.GFZR7jiUNyNkscijUl@fat_crate.local>
 <CAHk-=wjTHeQjsqtHcBGvy9TaJQ5uAm5HrCDuOD9v7qA9U1Xr4w@mail.gmail.com>
 <20231006095410.GBZR/ZQmaako5yMhVs@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006095410.GBZR/ZQmaako5yMhVs@fat_crate.local>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 11:54:10AM +0200, Borislav Petkov wrote:
> On Thu, Oct 05, 2023 at 11:29:02AM -0700, Linus Torvalds wrote:
> > ...
> > "complex" conditionals may also be annoying, but dammit, they are
> > important documentation about why we do those things, and unlike just
> > comments that will inevitably bit-rot, they have semantics and get
> > tested.
> 
> Thanks for explaining - it does make sense to me.
Thanks for clarifying it.

> So, from the looks of it, we're halfway there:
> 
>  - SPECULATION_MITIGATIONS is there for people who want to whack off the
>    whole crap
> 
>  - the separate Kconfig switches are for people who want to do
>    a finer-grained control. And yeah, they might be annoying the first
>    time but you do them once and then you use the .config forever, like
>    with anything else.
> 
> So yeah, sounds like a plan. Breno, please add Linus' explanation to the
> commit message why we're doing it this way, when sending your new
> version.

Sure, I will update the version 3 of the patchset[1] and add Linus'
explanation plus some new mitigation that showed up in the meantime.

[1] https://lore.kernel.org/all/20230628142129.2468174-1-leitao@debian.org/

