Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DBE769F55
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjGaRVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjGaRUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:20:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD107210D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:19:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d064a458dd5so3596038276.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690823989; x=1691428789;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gdb7QzlYcOc7UWmxcegrKrVqMfFsYHZFCwi2LL3my64=;
        b=zBusOqyPc9Ltaaqmju2VylABq68z3gA0yH658LtIHqnM7muXRoiPK7Z+lJWtWm/VN7
         8whOaU6x9OiXazWcYr8fAVYmvIyO6TYz06QaVHcaE8EQS9KLvJWFds1kXHPR5gfyol/T
         hwExr3eIMCbASZqYoMXC5wv7UZF1Mp2U4BBszuz1saEchMHIrtLN7I0wmDOtomAyfGK4
         Jb/4sUIrkAMy5yEhhybvRPtzSFoc+rBWIZvDZCJzlFd/cD+b3RLT1Lug7yCp0xC4QWhy
         NI1FLe1nSeay7t1G8coFkWiO2qxxWysi0sKSxyJbI8pSaEUs+h67fGOJLF0xb0FIQUeT
         6ssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823989; x=1691428789;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gdb7QzlYcOc7UWmxcegrKrVqMfFsYHZFCwi2LL3my64=;
        b=UKu4kikvi4Ndt99WGvXyeQbcJUe7y8EfI4BOGH4Wa/8YfWIMOsW7UhQxBi6RtTjQqU
         WKfSTS2Ygen8QBNR4w32/0ncWrjfU01vz7M/jxhmQ7fe3B7X15CxEJ4EfUfFjt7I5rKy
         3lm30Aio+MmiH6UXJ5riKX6Qt7TQlwdoQDR07lK+VX5uR6BUwiafnOyN6olFah6WTKSR
         DB0DPbD/w1zFFJZk2iRwogR0+HZ0DDmQXoQIlnepFL2ceEUZ7zIEZkGyz+6OxrmknQpE
         IHmB06ZV668jTT+gBBhHfBOyQq6IWmDEWKgeTNor4FVjX6gZP1zI6gyC/xsTBMfiJ/jn
         /q5w==
X-Gm-Message-State: ABy/qLbP21jNT/1FqIgErEFy+0+Vwm5im/WAuZHJBYpLx5NEsYxS2ENB
        MBiSXFca79QAzrh4+f8FcVPSkw5KPQg=
X-Google-Smtp-Source: APBJJlGDPfFjSpxr1qlDSkpPLfZlx10bTCXz+EMu9wyIQgv1N0AgtgkGqemxSj6OVMzULEQvuuVcsCXfoZ4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:abe3:0:b0:d22:4059:b2bd with SMTP id
 v90-20020a25abe3000000b00d224059b2bdmr62850ybi.1.1690823989036; Mon, 31 Jul
 2023 10:19:49 -0700 (PDT)
Date:   Mon, 31 Jul 2023 10:19:47 -0700
In-Reply-To: <ZMfpgu8bHH0jA8Si@google.com>
Mime-Version: 1.0
References: <20230729003643.1053367-1-seanjc@google.com> <20230729003643.1053367-10-seanjc@google.com>
 <20230731-91b64a6b787ba7e23b285785@orel> <ZMfpgu8bHH0jA8Si@google.com>
Message-ID: <ZMftM3qz/VqalbPg@google.com>
Subject: Re: [PATCH v4 09/34] KVM: selftests: Add a selftest for guest prints
 and formatted asserts
From:   Sean Christopherson <seanjc@google.com>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Thomas Huth <thuth@redhat.com>,
        "Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=" <philmd@linaro.org>,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023, Sean Christopherson wrote:
> On Mon, Jul 31, 2023, Andrew Jones wrote:
> > diff --git a/tools/testing/selftests/kvm/include/ucall_common.h b/tools/testing/selftests/kvm/include/ucall_common.h
> > index 4cf69fa8bfba..4adf526dc378 100644
> > --- a/tools/testing/selftests/kvm/include/ucall_common.h
> > +++ b/tools/testing/selftests/kvm/include/ucall_common.h
> > @@ -6,8 +6,19 @@
> >   */
> >  #ifndef SELFTEST_KVM_UCALL_COMMON_H
> >  #define SELFTEST_KVM_UCALL_COMMON_H
> > +#include <linux/kvm.h>
> >  #include "test_util.h"
> >  
> > +#if defined(__aarch64__)
> > +#define UCALL_EXIT_REASON      KVM_EXIT_MMIO
> > +#elif defined(__x86_64__)
> > +#define UCALL_EXIT_REASON      KVM_EXIT_IO
> > +#elif defined(__s390x__)
> > +#define UCALL_EXIT_REASON      KVM_EXIT_S390_SIEIC
> > +#elif defined(__riscv)
> > +#define UCALL_EXIT_REASON      KVM_EXIT_RISCV_SBI
> > +#endif
> > +
> >  /* Common ucalls */
> >  enum {
> >         UCALL_NONE,
> > 
> > and then compiled the test for riscv and it passed. I also ran all other
> > riscv tests successfully.
> 
> Can I have your SoB for the ucall_common.h patch?  I'll write a changelog and fold
> in a separate prep patch for that change.

On second thought, I take that back.  I think it makes more sense to add a ucall.h
for each arch and #define the exit type there.  All then move all of the
ucall_arch_do_ucall() implementations to ucall.h (except maybe x86 while it has
the horrific save/restore GPRs hack...).  That way the #define is colocated with
the code that generates the exit reason.
