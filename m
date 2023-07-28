Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44455766986
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbjG1J5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjG1J5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:57:08 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441A430E1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:57:03 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bcc0adab4so278581866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1690538221; x=1691143021;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EaDqHuP1/L0EWrVmqB4LDOlJLLXlDAKqsrZaIwzPq3M=;
        b=CiZw0lQlVNebikYEyzCGQwxP6oTaockZvcNTF5lhpUssizJZ0bAA3EEuC6Tb9lcj3Y
         ULPlZJ2+qXx0oToN3wpzQyWpwzOaXu2TpcN7isx4h6mFOoTB5MWaCWIjQRo9TTzLFkCe
         GudPlPLWQwqmIzUprt5rUDEJYS8qdmq0BoTlcA4Dhf0HVqU80A9aZGkGQ6+bW6kNUewp
         hrqto0T0KRzWRPIu7GbyTh2rABfCdM6761meIXZP3jvaIk/Tw0UeMdME6VbrNMj6m5hL
         3mX/unrEmdBuN/L9rF8W7HsnwEDjbSY3BcVYkpC2IVfmpKYqW9i8cWMLMhNfe+xK6mMY
         +Lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690538221; x=1691143021;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EaDqHuP1/L0EWrVmqB4LDOlJLLXlDAKqsrZaIwzPq3M=;
        b=E4bMlrVrXbGGSI90SlVitTMOrDv3//SY7d7jF72awZIV0F9yypuexImtg3asS+hs+K
         V6JgdOcQS7+Md2mBkZAg8zqLC19qjli2tGMAOctOVZU1qLsZu2XA/s2mW7zY+FFfX1am
         d+X2BuU5PWbSYFpq1Se5Tbh56AGRxk0NDWpJ3Oitff6DcpcF2AOX20nLDyd9Zeij9ULt
         5Sx5OfYhLAOuhb+HQCmM486AYaWvhlZh/2D3TTmcDTZmvo6rJeIBHcJWk8ytIJnRhPKt
         YR+Q8HQRoeuGSKZm0fLDK7IKNaKKOM809KEOOMjoYPFCh2xk3IIMt+I1mlhTC2S4jV+j
         Vqsw==
X-Gm-Message-State: ABy/qLaE117k3AJ8Wr7uicMQ8ynniFwY0XaCfb3re4AACsCh+CwejDkR
        wpPtTQRpo9hcW8MEu8txbjbMAw==
X-Google-Smtp-Source: APBJJlHqWfBWRzK8qa3KtWSlfnaMwOND59ErRJQPppTu7WEQ5KiBxDjr8woTjRI48lVKdKnl5PO0Vw==
X-Received: by 2002:a17:906:9bf1:b0:99b:c952:309b with SMTP id de49-20020a1709069bf100b0099bc952309bmr1700096ejc.55.1690538221588;
        Fri, 28 Jul 2023 02:57:01 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id qk29-20020a170906d9dd00b0099b42c90830sm1866923ejb.36.2023.07.28.02.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 02:57:01 -0700 (PDT)
Date:   Fri, 28 Jul 2023 11:57:00 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Haibo Xu <xiaobo55x@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Vipin Sharma <vipinsh@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Jones <andrew.jones@linux.dev>,
        Vishal Annapurve <vannapurve@google.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kvm-riscv@lists.infradead.org
Subject: Re: [PATCH 0/4] RISCV: Add kvm Sstc timer selftest
Message-ID: <20230728-5b0f530eba70ad08e8f4a67d@orel>
References: <cover.1690364259.git.haibo1.xu@intel.com>
 <ZMKI8RknjjZBOaxf@google.com>
 <CAJve8o=GZnLLedT7TvCLvgd5Z3ZxJNfM6gG03Eyc+7krtMY--g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJve8o=GZnLLedT7TvCLvgd5Z3ZxJNfM6gG03Eyc+7krtMY--g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 09:37:36AM +0800, Haibo Xu wrote:
> On Thu, Jul 27, 2023 at 11:14 PM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Thu, Jul 27, 2023, Haibo Xu wrote:
> > > The sstc_timer selftest is used to validate Sstc timer functionality
> > > in a guest, which sets up periodic timer interrupts and check the
> > > basic interrupt status upon its receipt.
> > >
> > > This KVM selftest was ported from aarch64 arch_timer and tested
> > > with Linux v6.5-rc3 on a Qemu riscv64 virt machine.
> >
> > Would it be possible to extract the ARM bits from arch_timer and make the bulk of
> > the test common to ARM and RISC-V?  At a glance, there is quite a bit of copy+paste.
> 
> Sure, I will have a try to consolidate the common code for ARM and RISC-V in v2.
>

Yes, afaict, we should be able to make aarch64/arch_timer.c another "split
test", like we did for aarch64/get-reg-list.c, but before we do that, I'd
like to get an ack from the Arm maintainers on the get-reg-list split to
be sure that approach is acceptable.

Thanks,
drew
