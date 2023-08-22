Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014257845CD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbjHVPlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbjHVPlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:41:17 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B9FCCB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:41:15 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79093c0c68bso164830539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692718874; x=1693323674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tn7nkSrWXbXku1ODgk8wfdLDeOTehgmcPalY1uMz8AY=;
        b=gpug5IfgCivCUZsgAgdDuqCYvXDaVr401EXfkX7z6W1sqF7p6Ii8QNoT23dksDCYFI
         kqz8y4nDEX65KHR2HaSvE2XiUlnaRDdyC/5tCk46Ox6TvC5mBVQ15D7v1C/6t2/3REmj
         ZrfhtEskuEkx59PjPqNxKa3V5yl+tKoolqsW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692718874; x=1693323674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tn7nkSrWXbXku1ODgk8wfdLDeOTehgmcPalY1uMz8AY=;
        b=bPh6Ow38O94EVDvhcXOFlQNRqwgdyMoTaWtD2VFfUnVk41kxXnwv6Qw+3m1F2QfWju
         6CSEWVH/8aMwzUaSH8/OxJjEw0wVH5Qt76sqXD8veNdLgkuBc2oNzsqqRPKciXl/VcmR
         x1AlsWNOQc+otn7JV6EfNaTAoQqlhEBfpRq1MzENFWWlksfdQqViz8djCZ+R3FJ0o15t
         erPanGzMMZLOQwI3IyJCT3bCddfjLWvmdCtQntMfliAubtVrEBxAWHwSx0F6r3hwqWkF
         PreNa2Dz3xotv+C80NoQof7Xn+9JfJ9hLzr5+X1Nyq/54dMJgC5gc7PRgDMNG8cM237V
         Io7A==
X-Gm-Message-State: AOJu0Yxb47FmylTrRz9iZJKNmX/US4ecFdpXqluXEvccfJoZMgojj2oS
        BA33wv1QaWaaqCYsNf4MesPQqg==
X-Google-Smtp-Source: AGHT+IGsdCfmdMIsALfUa907rbPCmZtSaf+HHNZgUKnCitrXcqrUq22DU6KhztevtOtu/EKXYx3xOw==
X-Received: by 2002:a05:6602:2154:b0:787:1d0a:ce87 with SMTP id y20-20020a056602215400b007871d0ace87mr54898ioy.17.1692718874462;
        Tue, 22 Aug 2023 08:41:14 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id i6-20020a5e8506000000b00791e6ae3aa4sm3355099ioj.23.2023.08.22.08.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 08:41:14 -0700 (PDT)
Date:   Tue, 22 Aug 2023 15:41:13 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.1 000/194] 6.1.47-rc1 review
Message-ID: <20230822154113.GA74437@google.com>
References: <20230821194122.695845670@linuxfoundation.org>
 <20230821225853.GB651285@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821225853.GB651285@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 10:58:53PM +0000, Joel Fernandes wrote:
> On Mon, Aug 21, 2023 at 09:39:39PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.1.47 release.
> > There are 194 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 23 Aug 2023 19:40:45 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.47-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> For RCU,
> Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>

I am getting the following warning which started after my last
successful 6.1.47-rc1 run. Looks like others already reported it, but
I am just archiving my finding here:

Thanks.

[    2.169887] ------------[ cut here ]------------
[    2.170593] missing return thunk: __alt_instructions_end+0x2256/0x227c-srso_untrain_ret+0x0/0x2: e9 c7 a0 ed fe
[    2.171678] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:572 apply_returns+0x1fb/0x230
[    2.173592] Modules linked in:
[    2.174625] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.1.47-rc1-g9beeea9636e6 #299
[    2.175608] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    2.176593] RIP: 0010:apply_returns+0x1fb/0x230
[    2.177592] Code: a5 01 00 0f 85 ef fe ff ff 49 89 d8 b9 05 00 00 00 4c 89 f2 48 89 de 48 c7 c7 60 3e 9d ad c6 05 fa 2c a5 01 01 e8 45 2d 04 00 <0f> 0b e9 c7 fe ff ff c7 84 24 89 00 00 00 cc cc cc cc 42 c7 84 04
[    2.179589] RSP: 0000:ffffffffadc03e28 EFLAGS: 00010286
[    2.180592] RAX: 0000000000000000 RBX: ffffffffae5292f2 RCX: 0000000000000000
[    2.181591] RDX: 0000000000000003 RSI: 0000000000000001 RDI: 00000000ffffffff
[    2.182595] RBP: 0000000000000000 R08: 00000000ffffdfff R09: 00000000ffffdfff
[    2.184589] R10: ffffffffadc574a0 R11: ffffffffadc574a0 R12: ffffffffadc03e40
[    2.185591] R13: ffffffffae520414 R14: ffffffffad4033be R15: ffffffffae5203f0
[    2.186650] FS:  0000000000000000(0000) GS:ffff953a5ca00000(0000) knlGS:0000000000000000
[    2.187637] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.188592] CR2: ffff953a5fa01000 CR3: 000000001ee0c000 CR4: 00000000000006f0
[    2.189639] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    2.191589] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    2.192593] Call Trace:
[    2.194683]  <TASK>
[    2.195595]  ? __warn+0x78/0xc0
[    2.197592]  ? apply_returns+0x1fb/0x230
[    2.198593]  ? report_bug+0xe6/0x170
[    2.199592]  ? console_unlock+0x1a3/0x210
[    2.200594]  ? handle_bug+0x3c/0x70
[    2.201594]  ? exc_invalid_op+0x13/0x60
[    2.202594]  ? asm_exc_invalid_op+0x16/0x20
[    2.203595]  ? retbleed_return_thunk+0x7e/0x7e
[    2.205593]  ? apply_returns+0x1fb/0x230
[    2.206594]  ? apply_returns+0x1fb/0x230
[    2.207596]  alternative_instructions+0x43/0xf2
[    2.208672]  arch_cpu_finalize_init+0x28/0x47
[    2.210595]  start_kernel+0x5f9/0x6a5
[    2.211597]  secondary_startup_64_no_verify+0xe0/0xeb
[    2.213649]  </TASK>> 

