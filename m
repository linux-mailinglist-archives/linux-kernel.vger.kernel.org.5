Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E02803192
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjLDLcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjLDLcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:32:23 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B65AB0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:32:27 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40bd5eaa66eso23410175e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 03:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701689545; x=1702294345; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k24kTPlVkd21kNiwlx5AXtWzxUb1iLhkKqVaC17WY/Y=;
        b=DgEI5NwvqWa1JxsCZlJaR1i7usMgEBVTqktWA5lLzSpDAcg/9u9JHtn97EJw7SLWs0
         NzN5cuU73wiRRJJbEjCVKgWXaZrf9H6A43Sq0++8tMDK7x0mosDfCklfJKB8YGXQX/A1
         buqijPUs8ySkWxQE80o7Ok3tINXSBmNi+12DjRuoYi8uROW6Sf7yv9bV8Wt7JL2pAG5n
         T8p+eda8XEiBS9DWIAnNuAiuuzunEyRrivbf1+x2BMz2TEnRhIlqdTxbDBttfHSqJmuM
         x1oFRM0fsN+q8UyLBJJ2O19jsoCODfZU/3WbkZbs0d3qHxdcC8znQr9p+E35Eis280MY
         5eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701689545; x=1702294345;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k24kTPlVkd21kNiwlx5AXtWzxUb1iLhkKqVaC17WY/Y=;
        b=VEATU+GWUZPnsi9Dl5ikptat5Tdzf4Pru6wgocJsH34NZXsTznvlHdHv6ETFVyBifS
         UlMkCrDecm6I9drMH/4MEVySTbvA7YDs2vQyILkd8YD0JAveHEyndmwLo+HWGRXra4ln
         BliLQyD33fxp3DREQji2eaQKCLP0L8XEYLfSheO7quHtrq/AjpSPWRzme4OPPfFr2Q0E
         a5JoS0rp61ivfvJDL9c7mEVvZw9DFXIB00RO7OeLLyyJOmQvR5h+BS+0VftRI/14pi3P
         G2zvsQSIglQMAmYK8KSWJKA2/2hP47UZkU2pIMnZIvM7E5xc/+yIScv/jzMdSjTfqeeH
         hh6A==
X-Gm-Message-State: AOJu0Yz0MqcRxBdAvXsOuXXlY3ddRIq/XR0ZnRxlp3Xe7rVRMC8KDjtO
        GrF3/14bU+6em+dGtG11b9Hr+A==
X-Google-Smtp-Source: AGHT+IErNZnZcr/TyviXxvsAwPQtN/v+Nlqzyb1HJSfOFwnV8njyLvYHhsJtg7HkXjuZQ5dLEL6OcQ==
X-Received: by 2002:a05:600c:5d5:b0:40b:5e21:ec33 with SMTP id p21-20020a05600c05d500b0040b5e21ec33mr2310718wmd.101.1701689545469;
        Mon, 04 Dec 2023 03:32:25 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id u2-20020a05600c138200b00405d9a950a2sm18390025wmf.28.2023.12.04.03.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 03:32:24 -0800 (PST)
Date:   Mon, 4 Dec 2023 12:32:24 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Haibo Xu <xiaobo55x@gmail.com>
Cc:     Haibo Xu <haibo1.xu@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v3 9/9] KVM: riscv: selftests: Add sstc timer test
Message-ID: <20231204-980c95cca344f718ac6a48b6@orel>
References: <cover.1694421911.git.haibo1.xu@intel.com>
 <64e0637cd6f22dd7557ed44bd2242001e7830d1c.1694421911.git.haibo1.xu@intel.com>
 <20230914-d2e594e7d84503ad14036e2d@orel>
 <CAJve8onhY534T=Hyncjfi4GfdZ+0D2xM+jRSaYCAWCdaKxPUcQ@mail.gmail.com>
 <CAJve8omitHDpijJaLV_wHk+5LXpsBUWF8_eTD4MeWKM-807Siw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJve8omitHDpijJaLV_wHk+5LXpsBUWF8_eTD4MeWKM-807Siw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 10:42:24AM +0800, Haibo Xu wrote:
> On Fri, Sep 15, 2023 at 2:21 PM Haibo Xu <xiaobo55x@gmail.com> wrote:
> >
> > On Thu, Sep 14, 2023 at 5:52 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> > >
> > > On Thu, Sep 14, 2023 at 09:37:03AM +0800, Haibo Xu wrote:
> > > > Add a KVM selftests to validate the Sstc timer functionality.
> > > > The test was ported from arm64 arch timer test.
> > >
> > > I just tried this test out. Running it over and over again on QEMU I see
> > > it works sometimes, but it frequently fails with the
> > > GUEST_ASSERT_EQ(config_iter + 1, irq_iter) assert and at least once I
> > > also saw the __GUEST_ASSERT(xcnt >= cmp) assert.
> > >
> >
> > Good catch!
> >
> > I can also reproduce this issue and it is a common problem for both
> > arm64 and riscv because it also happens in a arm64 Qemu VM.
> >
> > It seems like a synchronization issue between host and guest shared
> > variables. Will double check the test code.
> >
> > > Thanks,
> > > drew
> 
> Hi Andrew,
> 
> After several rounds of regression testing, some findings:
> 1. The intermittent failure also happened on ARM64 Qemu VM, and even
> in the initial arch_timer commit(4959d8650e9f4).
> 2. it didn't happen on a ARM64 HW(but a different failure occured
> during stress test)
> 3. The failure have a close relationship with
> TIMER_TEST_ERR_MARGIN_US(default 100), and after increasing
>      the macro to 300, the failure couldn't reproduced in 1000 loops
> stress test in RISC-V Qemu VM
> 
> So my suggestion is we can expose the TIMER_TEST_ERR_MARGIN_US
> parameter as an arch_timer test arg parameter
> and tune it based on a specific test environment.
> 
> What's your opinion?

The concept of "timeout for an interrupt to arrive" is always going to
leave us exposed to random failures. Your suggestion of making the
timeout user configurable is probably the best we can do. I would
suggest also adding more descriptive failure text and a hint about
trying to adjust the timeout.

Or, one thing we do in kvm-unit-tests, is to reduce typical delays while
allowing expected delays to be longer by looping over a shorter delay and
a non-fatal check, i.e.

 pass = false;
 for (i = 0; i < 10; i++) {
   udelay(100);
   if (check(...)) {
      pass = true;
      break;
   }
 }
 assert(pass);

We could try that approach here too.

Thanks,
drew
