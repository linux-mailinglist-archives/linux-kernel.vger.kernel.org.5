Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AE57859EB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbjHWOBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbjHWNcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:32:43 -0400
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8045E69;
        Wed, 23 Aug 2023 06:32:17 -0700 (PDT)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso3932605a12.3;
        Wed, 23 Aug 2023 06:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692797415; x=1693402215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=67eR0XKV1cIlXfm6z6Fca6SQKuHaMk/U6YOTAoJA9D0=;
        b=Uj6qKyLqzuSjkS1Xf+lekrhwQCQ2L93SaNeAIohnQxhrfrfaN+J27XPkY8Lf4vgyoo
         On9XdPcJmWNsKqRGLyaPfzXM/yMESEkbw4svnBiLdfrz3Tre/FnnXhTd/SnGWYeDnMdI
         SAOg6ep2+q1CVGZt7xPHl3qbobUC91lrc4zI3MPHnOQpYKn16oOxRAx9KcmB5T0i6lNm
         ZXmGUFgssLSp7W4H/BSzVedPHV1My0RDlzIq+6QEtgRDP8vHOefR3OUjwWTE0RKt5fL0
         LxVr+32EaHYl58+zedBXv6CwRloBejIKs47YvDDySmTWlHuuDtV632lrY5BTYvrK7H63
         qGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797415; x=1693402215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67eR0XKV1cIlXfm6z6Fca6SQKuHaMk/U6YOTAoJA9D0=;
        b=LUfxJr3xjay0maH7SrSah7DqoNfbsDP1Veh7ry6KUqcNB+UFpVrhg+vxU5A8ICbEQQ
         tofkQYRgfuevxD2nok344y2yz1EB5P7n5xlwugtk8Qv0hANCTzTzBcCtMkbyv729ILQ+
         3HGX8xY5RS/tqIDJjl50ySoP7E2XDRUy06j9/J7MDVx0zgd7/eGZS8xj57PSpHKqCadt
         YO4zyWOs/4NJTBU5kZXiHo1NM7F/qKf3VKY4sxfWnmRR62h6llS6E/CEE2dEhsZL6jLQ
         DKPsDHw5KwCEuqfS+Ll/SItPkGxvtnzscuKAS8+Lgiu9i7kK/1Rk+Hb4/ePKVOR7t44T
         RDpw==
X-Gm-Message-State: AOJu0YxXIUEM6bmvx8GX8c5BhOUkZ85fU5aFNf+1umxZZdmoteX3ZqSd
        L5oCe5zLx5FHYIoIsD87d/Y=
X-Google-Smtp-Source: AGHT+IFP5oobQMnDXiUdLaaatQk3CCNsv+09Y4/zjUDdAC34eBKJ9inGiI2iDr8BzaWRDeZMOtTRsw==
X-Received: by 2002:a17:90a:fa01:b0:262:e84f:ad80 with SMTP id cm1-20020a17090afa0100b00262e84fad80mr11253168pjb.9.1692797414821;
        Wed, 23 Aug 2023 06:30:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gx3-20020a17090b124300b0026b45fb4443sm11519465pjb.4.2023.08.23.06.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:30:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 23 Aug 2023 06:30:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/194] 6.1.47-rc1 review
Message-ID: <2d8a5f48-6c50-4c12-8a3d-23e621c6b722@roeck-us.net>
References: <20230821194122.695845670@linuxfoundation.org>
 <991b93d2-9fde-4233-97d5-1133a9360d02@roeck-us.net>
 <2023082309-veggie-unwoven-a7df@gregkh>
 <CA+G9fYvwxuVpSn24YvtdNXaofg2JtZDREatOpDsKTVJX+nFN3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvwxuVpSn24YvtdNXaofg2JtZDREatOpDsKTVJX+nFN3Q@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 01:47:39PM +0530, Naresh Kamboju wrote:
> On Wed, 23 Aug 2023 at 12:33, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Aug 22, 2023 at 05:49:54PM -0700, Guenter Roeck wrote:
> > > On Mon, Aug 21, 2023 at 09:39:39PM +0200, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 6.1.47 release.
> > > > There are 194 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Wed, 23 Aug 2023 19:40:45 +0000.
> > > > Anything received after that time might be too late.
> > > >
> > >
> > > Build results:
> > >       total: 157 pass: 156 fail: 1
> > > Failed builds:
> > >       m68k:sun3_defconfig
> > > Qemu test results:
> > >       total: 521 pass: 519 fail: 2
> > > Failed tests:
> > >       arm:fuji-bmc:aspeed_g5_defconfig:notests:mem1G:mtd128,0,8,1:net,nic:aspeed-bmc-facebook-fuji:f2fs
> > >       arm:bletchley-bmc,fmc-model=mt25qu02g,spi-model=mt25qu02g:aspeed_g5_defconfig:notests:mem1G:mtd256:net,nic:aspeed-bmc-facebook-bletchley:f2fs
> > >
> > > The m68k build failure is
> > >
> > > Inconsistent kallsyms data
> > > Try make KALLSYMS_EXTRA_PASS=1 as a workaround
> > >
> > > I already have KALLSYMS_EXTRA_PASS=1 enabled, so that doesn't help.
> > > Nothing to worry about. The f2fs crashes are still seen. They
> > > also happen for other architectures, so it is not just an arm problem.
> > > I'll probably just disable all f2fs testing going forward. If so I'll
> > > send a note clarifying that the lack of reported test failures doesn't
> > > mean that it works.
> >
> > I'll look into this later this week, next week to resolve the f2fs
> > stuff.  I wanted to get to the other known bug fixes first.
> >
> > > For x86 I get the same runtime warning as everyone else.
> >
> > Yeah, this is troubling...
> >
> > Is it clang only?  I'll dig into this today...
> 
> It is seen with gcc-13 and clang-17 with few extra configs.
> We are not booting defconfig.
> 
> The Kconfigs are enabled with KFENCE.
> 
I have KFENCE enabled as well, so it may well be that this triggers
the warning. I don't see it in 6.4.y or upstream, though.

Guenter
