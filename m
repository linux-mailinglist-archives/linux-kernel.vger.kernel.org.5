Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6211E787DDF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242395AbjHYClY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242150AbjHYCkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:40:51 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781821BF1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:40:48 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7927f241772so11618939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692931248; x=1693536048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mGesezR2GxD1T9cDe5R/6CNi6KNWzNxxi1cx+VsVIYY=;
        b=ktkQrEF3v9HiEmQX5RQhZ63uq0LUhhUc3RxO5obGT/Waj8S9mJjT/dtmj9EIucQtFJ
         Kk2aizxxeGduIezBAah0HRXpAMLmj/nyya6sQPvD/FO9dRVtiYX6kXoJK8r+ukpDT44r
         NBmosFev5QXflPgO+bJfcDGx8qSVFzuZeemfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692931248; x=1693536048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGesezR2GxD1T9cDe5R/6CNi6KNWzNxxi1cx+VsVIYY=;
        b=c2RvHcC+ckkxSoKqaBPR+Tg4cAdGJ8FGU6IRF5zriBRhRtuOh8bIE8wgts3OP/gtPi
         n9r4HjHZUX+s38D/rpT1QVWpFKYn3UhT+Qumh9KBXgYxPwyeaZlqvT/N5DYLsAoDE+Le
         IxYysEGNHhAC9WP072O5H774j/YACHOmDYn89i1JveBu2t4CEE5lT3X7YHol4T6xaZbX
         O4XJ0XgIRG9TfQS2MFHafLl15F2SP3EQMDuyOtxw9rIrE4N1mfWXsuTWI1sGq/DAd8at
         z3wqfrY9fvMoV1W8rDPi6jVFllfpGBnv1RIAL+q8q8XXbJJl4LVm7wll/uJUWdMaBx8b
         ELug==
X-Gm-Message-State: AOJu0YwVb6x6cyEcyXlVMRodQYsIMzZuUoapN168ySQzYT5WS3T5XSu3
        Gise76FaypFG5dWwZ/ccYd1GmQ==
X-Google-Smtp-Source: AGHT+IE/m57D/hIK3KnDvCR0H9xZWB45FyuDwifpXgAXpmWvgL3bF9YTNiZIm32H56PIcXGN03xAGQ==
X-Received: by 2002:a6b:dd16:0:b0:790:fa58:69d2 with SMTP id f22-20020a6bdd16000000b00790fa5869d2mr7421626ioc.20.1692931247845;
        Thu, 24 Aug 2023 19:40:47 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id n23-20020a056602221700b0078714764ca0sm192341ion.40.2023.08.24.19.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 19:40:47 -0700 (PDT)
Date:   Fri, 25 Aug 2023 02:40:46 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.1 00/15] 6.1.48-rc1 review
Message-ID: <20230825024046.GD4008060@google.com>
References: <20230824141447.155846739@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824141447.155846739@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 04:14:56PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.48 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 26 Aug 2023 14:14:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.48-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

For RCU,
Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> 
> -------------
> Pseudo-Shortlog of commits:
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 6.1.48-rc1
> 
> Borislav Petkov (AMD) <bp@alien8.de>
>     x86/srso: Correct the mitigation status when SMT is disabled
> 
> Peter Zijlstra <peterz@infradead.org>
>     objtool/x86: Fixup frame-pointer vs rethunk
> 
> Petr Pavlu <petr.pavlu@suse.com>
>     x86/retpoline,kprobes: Fix position of thunk sections with CONFIG_LTO_CLANG
> 
> Borislav Petkov (AMD) <bp@alien8.de>
>     x86/srso: Disable the mitigation on unaffected configurations
> 
> Borislav Petkov (AMD) <bp@alien8.de>
>     x86/CPU/AMD: Fix the DIV(0) initial fix attempt
> 
> Sean Christopherson <seanjc@google.com>
>     x86/retpoline: Don't clobber RFLAGS during srso_safe_ret()
> 
> Peter Zijlstra <peterz@infradead.org>
>     x86/static_call: Fix __static_call_fixup()
> 
> Borislav Petkov (AMD) <bp@alien8.de>
>     x86/srso: Explain the untraining sequences a bit more
> 
> Peter Zijlstra <peterz@infradead.org>
>     x86/cpu: Cleanup the untrain mess
> 
> Peter Zijlstra <peterz@infradead.org>
>     x86/cpu: Rename srso_(.*)_alias to srso_alias_\1
> 
> Peter Zijlstra <peterz@infradead.org>
>     x86/cpu: Rename original retbleed methods
> 
> Peter Zijlstra <peterz@infradead.org>
>     x86/cpu: Clean up SRSO return thunk mess
> 
> Peter Zijlstra <peterz@infradead.org>
>     x86/alternative: Make custom return thunk unconditional
> 
> Peter Zijlstra <peterz@infradead.org>
>     x86/cpu: Fix up srso_safe_ret() and __x86_return_thunk()
> 
> Peter Zijlstra <peterz@infradead.org>
>     x86/cpu: Fix __x86_return_thunk symbol type
> 
> 
> -------------
> 
> Diffstat:
> 
>  Documentation/admin-guide/hw-vuln/srso.rst |   4 +-
>  Makefile                                   |   4 +-
>  arch/x86/include/asm/entry-common.h        |   1 +
>  arch/x86/include/asm/nospec-branch.h       |  28 +++---
>  arch/x86/kernel/cpu/amd.c                  |   1 +
>  arch/x86/kernel/cpu/bugs.c                 |  28 +++++-
>  arch/x86/kernel/static_call.c              |  13 +++
>  arch/x86/kernel/traps.c                    |   2 -
>  arch/x86/kernel/vmlinux.lds.S              |  20 ++--
>  arch/x86/kvm/svm/svm.c                     |   2 +
>  arch/x86/lib/retpoline.S                   | 141 ++++++++++++++++++++---------
>  tools/objtool/arch/x86/decode.c            |   2 +-
>  tools/objtool/check.c                      |  21 +++--
>  13 files changed, 182 insertions(+), 85 deletions(-)
> 
> 
