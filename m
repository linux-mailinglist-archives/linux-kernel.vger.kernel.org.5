Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38C17D95C8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345686AbjJ0K57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjJ0K55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:57:57 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF311AD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:57:54 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7b610279c8aso878437241.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698404273; x=1699009073; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3zQBT6jRuR5jxYiRAr8syfNhHciQ/BHcE4DZFyhdPwI=;
        b=PP7jMKs5l7SL5IZXsqTzLeRLyfOLcpy+3xxK0sjSj2gr1UTLLRnankwT5A+w5SwD0J
         gdsAWOGRAT6DiTXv0BClS3Yl9Wi00+cZACEFYyDhtub68RweVSeuAo7RrHWQj9KY1qH3
         85dswXIKUHhDyDKLTdgZi21nZ6z56YsM6/EgkEJb22uL7r1NqfWO0xuwda9WojuJNn6r
         /eP+ThfBybhRj/5O0jmwnMG98XfKSs9ldeITvRZoqhe/Sov2mGWdQK7BxvNXBi7WJUs6
         4zlADIeSrk6+xVCA10IP9WrxJfSMI1FwqIpNzFsyTRUi7FKHDFjncg/gy0vhcq+A7zeM
         sIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698404273; x=1699009073;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3zQBT6jRuR5jxYiRAr8syfNhHciQ/BHcE4DZFyhdPwI=;
        b=TSXoEYoKp5ZNGQG4Vtrvp3vdYsm4JYY3vmcS5IeIb8p7LKWTjarORhWWyn+RcpxryI
         UzFStKuksfAnfPCjDImxHiwbvu+hafcCRkcU9N6pGXd6Tj6nT02eJqOYQyGQ1y+XrbJZ
         6OkFtBpeu1PJGRuAzikccvB10K5CQuCXE38z8G9fnnwYE6767R2y6gmdSm1gaTB/J6nk
         YpH8CL9MetIi50cTZ8Ly2ksiI3JkzHJPoGt2kQ0u/d2USUnv+0HxFWyy95wtWKVsvR/w
         m1AymWJ3UIHBD6sIgj2CwMiw1UQrAtZPBNdt3gZIFb6OwCIYAioerRTKWC6RyyZpavf8
         f4aQ==
X-Gm-Message-State: AOJu0YyuuWCNvoViOSOd0iOBum7Etm1XbswKmLCMysLZr84NwwBvNvRx
        TjEdB4qFZcIfV+hdF9y/QnZomnfbCcZxvqc9158UKQ==
X-Google-Smtp-Source: AGHT+IHarNLCoFsdKNzL1a48n70a2eNgURLrsseEGHkrmEWYJ6n2/q05I2+4jQ74A/lQL0OqJP835LGQwXLk47ENiWU=
X-Received: by 2002:a05:6102:1592:b0:457:dbfc:5c69 with SMTP id
 g18-20020a056102159200b00457dbfc5c69mr2829666vsv.12.1698404273032; Fri, 27
 Oct 2023 03:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsCskpn_TNpSwLq9HGUgtT=aZpDzs7SVrqpa9WmyYFaxQ@mail.gmail.com>
 <ZTqGBzOQd4Oi3e9j@FVFF77S0Q05N.cambridge.arm.com> <CAMj1kXE8VrG6aPsjByd83kavw7He6vn=DszhJfAd-TfP9y8VBA@mail.gmail.com>
In-Reply-To: <CAMj1kXE8VrG6aPsjByd83kavw7He6vn=DszhJfAd-TfP9y8VBA@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 27 Oct 2023 16:27:41 +0530
Message-ID: <CA+G9fYuQxUhsrL_=uYSAdotU1_Wx7iu5PxFuG9EzWgBE2nMjcw@mail.gmail.com>
Subject: Re: qemu-arm64: handle_futex_death - kernel/futex/core.c:661 - Unable
 to handle kernel unknown 43 at virtual address
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        LTP List <ltp@lists.linux.it>, Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 at 21:09, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 26 Oct 2023 at 17:30, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Thu, Oct 26, 2023 at 08:11:26PM +0530, Naresh Kamboju wrote:
> > > Following kernel crash noticed on qemu-arm64 while running LTP syscalls
> > > set_robust_list test case running Linux next 6.6.0-rc7-next-20231026 and
> > > 6.6.0-rc7-next-20231025.
> > >
> > > BAD: next-20231025
> > > Good: next-20231024
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > >
> > > Log:
> > > ----
> > > <1>[  203.119139] Unable to handle kernel unknown 43 at virtual
> > > address 0001ffff9e2e7d78
> > > <1>[  203.119838] Mem abort info:
> > > <1>[  203.120064]   ESR = 0x000000009793002b
> > > <1>[  203.121040]   EC = 0x25: DABT (current EL), IL = 32 bits
> > > set_robust_list01    1  TPASS  :  set_robust_list: retval = -1
> > > (expected -1), errno = 22 (expected 22)
> > > set_robust_list01    2  TPASS  :  set_robust_list: retval = 0
> > > (expected 0), errno = 0 (expected 0)
> > > <1>[  203.124496]   SET = 0, FnV = 0
> > > <1>[  203.124778]   EA = 0, S1PTW = 0
> > > <1>[  203.125029]   FSC = 0x2b: unknown 43
> >
> > It looks like this is fallout from the LPA2 enablement.
> >
> > According to the latest ARM ARM (ARM DDI 0487J.a), page D19-6475, that "unknown
> > 43" (0x2b / 0b101011) is the DFSC for a level -1 translation fault:
> >
> >         0b101011 When FEAT_LPA2 is implemented:
> >                  Translation fault, level -1.
> >
> > It's triggered here by an LDTR in a get_user() on a bogus userspace address.
> > The exception is expected, and it's supposed to be handled via the exception
> > fixups, but the LPA2 patches didn't update the fault_info table entries for all
> > the level -1 faults, and so those all get handled by do_bad() and don't call
> > fixup_exception(), causing them to be fatal.
> >
> > It should be relatively simple to update the fault_info table for the level -1
> > faults, but given the other issues we're seeing I think it's probably worth
> > dropping the LPA2 patches for the moment.
> >
>
> Thanks for the analysis Mark.
>
> I agree that this should not be difficult to fix, but given the other
> CI problems and identified loose ends, I am not going to object to
> dropping this partially or entirely at this point. I'm sure everybody
> will be thrilled to go over those 60 patches again after I rebase them
> onto v6.7-rc1 :-)

I am happy to test any proposed fix patch.

- Naresh
