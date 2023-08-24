Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12FE7873A2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242036AbjHXPIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242094AbjHXPIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:08:25 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1465EC7;
        Thu, 24 Aug 2023 08:08:23 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf092a16c9so172405ad.0;
        Thu, 24 Aug 2023 08:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692889702; x=1693494502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sEY3RKWdnw3zHmk1Y4mP82JEt/tjDoea5W8YztOyeHw=;
        b=OqscnWK/iN71B8aqV/S1gSoSBaakB0XKjG3SapdLFHmDaNy1pHSQpuaViCMTB0wXVp
         dSql06uupX5Hr1b+HaJNhUiMss0Z/LgoL3ugB5Z6p0fvPMjKoEkfzSyzlG3Sewt7z94N
         MoDGwZG7Ciulb2LvlWFDbmitVrGPuc6AHnNV1Z9G62ZzpJlcIKYUHK+o5KoNCfMc8pnD
         8rHBN8FjFYvepMqgYAQZFpimLjqTb3nqKcI57tMMVt7VoQ6utqdWUeiKERbWV/iAXwSV
         aSQeajGkF+uS4gURgOlUpEtmh6fXGvqP7lu5ny9RCbafoAm08/Qr9YQ8XzqacZXe00hL
         okQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692889702; x=1693494502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEY3RKWdnw3zHmk1Y4mP82JEt/tjDoea5W8YztOyeHw=;
        b=CG+IYO+2YhWXwaOjhOfP6OJ4mNHEbvlvFeswqyboiDxKYd0hUN9XguTACxH5g8pnVl
         qAAN64GFc0u+b8CHXb2vM3qbvPUU0BrNfGgaFQX7OCw/kAy6whp9+roletpTo6fXZC4l
         hxIzqK8dSv7TKOwt/CimI+ZIwJM0FlRwSB3KYXpHfZNCtq7VPP9U/AHv7P+Y0Pa2z7/f
         deGxBfNcgSxE1AT3AqZNfJRzWRMY6DsCJ3QlBna7+jaB5E4tEqIbSrvtW7ExXr5DQv7t
         OaXH6mY8i/N6N0ixjH+Fznpb9ZTR5CQtOie1lQUahK3bilc1bp4hGA9eRU//xQCTL6IG
         SQGw==
X-Gm-Message-State: AOJu0YzfIpd7UvtKcwASfE8VVxD7edeTtpRoIb0Ij7eOMANGgmDEYD8v
        r71KSpgGfXiwCm7sDvudSMY=
X-Google-Smtp-Source: AGHT+IHhbz4OiENBQD9ho4jGvAcV3lWptJhsLXIcHHgF06ECT95G/qnXnkSBw6LrvjVJCggl6U5QSQ==
X-Received: by 2002:a17:903:41c1:b0:1b8:88c5:2d2f with SMTP id u1-20020a17090341c100b001b888c52d2fmr19471562ple.64.1692889702305;
        Thu, 24 Aug 2023 08:08:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s2-20020a170902ea0200b001bc9bfaba3esm12900755plg.126.2023.08.24.08.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 08:08:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 24 Aug 2023 08:08:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/194] 6.1.47-rc1 review
Message-ID: <4b8fcb23-c5e3-4bf1-957f-f0cc717564be@roeck-us.net>
References: <20230821194122.695845670@linuxfoundation.org>
 <991b93d2-9fde-4233-97d5-1133a9360d02@roeck-us.net>
 <2023082309-veggie-unwoven-a7df@gregkh>
 <CA+G9fYvwxuVpSn24YvtdNXaofg2JtZDREatOpDsKTVJX+nFN3Q@mail.gmail.com>
 <2d8a5f48-6c50-4c12-8a3d-23e621c6b722@roeck-us.net>
 <2023082325-expansion-revoke-1f3a@gregkh>
 <2023082401-arrange-bulk-d42a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023082401-arrange-bulk-d42a@gregkh>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 03:35:55PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 23, 2023 at 05:50:42PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Aug 23, 2023 at 06:30:13AM -0700, Guenter Roeck wrote:
> > > On Wed, Aug 23, 2023 at 01:47:39PM +0530, Naresh Kamboju wrote:
> > > > On Wed, 23 Aug 2023 at 12:33, Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Tue, Aug 22, 2023 at 05:49:54PM -0700, Guenter Roeck wrote:
> > > > > > On Mon, Aug 21, 2023 at 09:39:39PM +0200, Greg Kroah-Hartman wrote:
> > > > > > > This is the start of the stable review cycle for the 6.1.47 release.
> > > > > > > There are 194 patches in this series, all will be posted as a response
> > > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > > let me know.
> > > > > > >
> > > > > > > Responses should be made by Wed, 23 Aug 2023 19:40:45 +0000.
> > > > > > > Anything received after that time might be too late.
> > > > > > >
> > > > > >
> > > > > > Build results:
> > > > > >       total: 157 pass: 156 fail: 1
> > > > > > Failed builds:
> > > > > >       m68k:sun3_defconfig
> > > > > > Qemu test results:
> > > > > >       total: 521 pass: 519 fail: 2
> > > > > > Failed tests:
> > > > > >       arm:fuji-bmc:aspeed_g5_defconfig:notests:mem1G:mtd128,0,8,1:net,nic:aspeed-bmc-facebook-fuji:f2fs
> > > > > >       arm:bletchley-bmc,fmc-model=mt25qu02g,spi-model=mt25qu02g:aspeed_g5_defconfig:notests:mem1G:mtd256:net,nic:aspeed-bmc-facebook-bletchley:f2fs
> > > > > >
> > > > > > The m68k build failure is
> > > > > >
> > > > > > Inconsistent kallsyms data
> > > > > > Try make KALLSYMS_EXTRA_PASS=1 as a workaround
> > > > > >
> > > > > > I already have KALLSYMS_EXTRA_PASS=1 enabled, so that doesn't help.
> > > > > > Nothing to worry about. The f2fs crashes are still seen. They
> > > > > > also happen for other architectures, so it is not just an arm problem.
> > > > > > I'll probably just disable all f2fs testing going forward. If so I'll
> > > > > > send a note clarifying that the lack of reported test failures doesn't
> > > > > > mean that it works.
> > > > >
> > > > > I'll look into this later this week, next week to resolve the f2fs
> > > > > stuff.  I wanted to get to the other known bug fixes first.
> > > > >
> > > > > > For x86 I get the same runtime warning as everyone else.
> > > > >
> > > > > Yeah, this is troubling...
> > > > >
> > > > > Is it clang only?  I'll dig into this today...
> > > > 
> > > > It is seen with gcc-13 and clang-17 with few extra configs.
> > > > We are not booting defconfig.
> > > > 
> > > > The Kconfigs are enabled with KFENCE.
> > > > 
> > > I have KFENCE enabled as well, so it may well be that this triggers
> > > the warning. I don't see it in 6.4.y or upstream, though.
> > 
> > Ok, let me rip out all the x86 and objtool patches from this release,
> > get it out the door with the good things in there that everyone else
> > needs, and then we can focus on this mess...
> > 
> > Maybe I'll just backport _all_ objtool changes to sync things up better,
> > last time I tried that it was a maze of twisty passages, all coated in
> > assembly...
> 
> I got lost in the maze again today, ick.
> 
> Anyway, I give up.  I'm just going to push out a -rc1 with just these
> changes in it today, and if people are upset about the runtime warning,
> then they can provide a working backport of this objtool patch.
> 

Or maybe just revert all srso patches.

> Ideally, the CPU vendor who is causing this mess will do that, as it's
> their issue we are spending all of this time on, not Linux's issue.
> 
> Also, oddly, I can not reproduce this problem here on my hardware at
> all.  Maybe because it's an AMD processor?  If so, makes sense, as the
> SRSO issue is only for Intel chips.
> 

Apparently I am lost in the maze as well. I am quite sure that SRSO
only applies to AMD CPUs, and

arch/x86/Kconfig:config CPU_SRSO
arch/x86/Kconfig:         Enable the SRSO mitigation needed on AMD Zen1-4 machines.

seems to confirm that. What am I missing ? Do you mean the warning that
was supposed to be fixed with the objtool patch(es) is only seen on Intel
chips ?

Thanks,
Guenter
