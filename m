Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AD17DDB7D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 04:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjKADZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 23:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjKADZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 23:25:07 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98663B4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 20:25:04 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54357417e81so7267a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 20:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698809103; x=1699413903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxmahLRvzF8Eu+4ttjDu+9ikN6d1g8PIZEzX9Tgb1Kc=;
        b=ZQCD45NCIt/qiK5oFeXdqxXonrzrdyRfV0rJx0FS4pM5A1CDal1RcYQEqN6DVoqs3J
         8EgXJYC5T/UM6a5BRc3fUpRmcmIpYw6f1Te0k3aTxGmKpXn8vc9WtyawOtv14mP45OoT
         gGR9gGfxjLezYppQ5L8ADBMTkjgVvQRZyj1np7fbFis0N0HVgnD8sH95xJlzRJT/h4aX
         BU0n4q3a78HKf8J6gwS25mM11KQDdpTMbCG7/sILhJ5AZ+L6QLCckUw1ZaFH6flMjjPs
         QO8vy7KqOu9OxZuT/HGIK1R83ihPSqn9ue/zpb3Q1gNJfqGyWWHkNiZjizJurKqiHsJI
         +vtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698809103; x=1699413903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxmahLRvzF8Eu+4ttjDu+9ikN6d1g8PIZEzX9Tgb1Kc=;
        b=Vw16IsIV/muckOz6DWIvCm6ITDDRiuVzvUUWCg2bhkcBo9Dgm4tpOWo0OboZ9YNUGG
         ZWorUqEbcnBy/XWEGHvWa3mC2ciITRCvgUZ2Vaen5cVLYlKOHvO9XHEUQ6ItSWuNNV+9
         kVmp6Xa3rv3tiS5fNLp0T+nytBQSpvkdpRyr5J798aiPxhR8lv+Eiv+/uYYeoQ+QPOHS
         QLWoSwXyp6xFOQnN+Pz3MJiDjOIM+ctpkxWJH1CAvET9q2MHS5FT+B5hYFNVjvujonnC
         pwDFXSn5CpOIPElDX7aXtyIuCYN2poDAfOjXZ/dNdO76KPhoBoPwJByklwMMIi+t8OiQ
         Q7rg==
X-Gm-Message-State: AOJu0YyP3bubLP3qegCncGouF46GaU3rerkapGXDHJACcLINMePvFG2v
        JUaQl3INpFwx8gKck0bhJb5cIsGPW8QkT5xOggRMQw==
X-Google-Smtp-Source: AGHT+IEra/nvtYgN5rP8Lvdrc9407UjYUrWsgxDuyIkvlTyeHvveL64nKUX5kPQEr4bz6d38nP0hJMFZlj7+h0yJU6k=
X-Received: by 2002:a50:f684:0:b0:540:e4c3:430 with SMTP id
 d4-20020a50f684000000b00540e4c30430mr222133edn.6.1698809102922; Tue, 31 Oct
 2023 20:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231031092921.2885109-1-dapeng1.mi@linux.intel.com>
 <20231031092921.2885109-5-dapeng1.mi@linux.intel.com> <CALMp9eQ4Xj5D-kgqVMKUNmdF37rLcMRXyDYdQU339sRCKZ7d9A@mail.gmail.com>
 <28796dd3-ac4e-4a38-b9e1-f79533b2a798@linux.intel.com> <CALMp9eRH5pttOA5BApdVeSbbkOU-kWcOWAoGMfK-9f=cy2Jf0g@mail.gmail.com>
 <fbad1983-5cde-4c7b-aaed-412110fe737f@linux.intel.com>
In-Reply-To: <fbad1983-5cde-4c7b-aaed-412110fe737f@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 31 Oct 2023 20:24:51 -0700
Message-ID: <CALMp9eQhUaATf=-7zGDCb_WMNwWx2edXH5Piy+D8QybEL0tyNg@mail.gmail.com>
Subject: Re: [kvm-unit-tests Patch v2 4/5] x86: pmu: Support validation for
 Intel PMU fixed counter 3
To:     "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhang Xiong <xiong.y.zhang@intel.com>,
        Mingwei Zhang <mizhang@google.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 8:16=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 11/1/2023 10:47 AM, Jim Mattson wrote:
> > On Tue, Oct 31, 2023 at 7:33=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.in=
tel.com> wrote:
> >>
> >> On 11/1/2023 2:47 AM, Jim Mattson wrote:
> >>> On Tue, Oct 31, 2023 at 2:22=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.i=
ntel.com> wrote:
> >>>> Intel CPUs, like Sapphire Rapids, introduces a new fixed counter
> >>>> (fixed counter 3) to counter/sample topdown.slots event, but current
> >>>> code still doesn't cover this new fixed counter.
> >>>>
> >>>> So this patch adds code to validate this new fixed counter can count
> >>>> slots event correctly.
> >>> I'm not convinced that this actually validates anything.
> >>>
> >>> Suppose, for example, that KVM used fixed counter 1 when the guest
> >>> asked for fixed counter 3. Wouldn't this test still pass?
> >>
> >> Per my understanding, as long as the KVM returns a valid count in the
> >> reasonable count range, we can think KVM works correctly. We don't nee=
d
> >> to entangle on how KVM really uses the HW, it could be impossible and
> >> unnecessary.
> > Now, I see how the Pentium FDIV bug escaped notice. Hey, the numbers
> > are in a reasonable range. What's everyone upset about?
> >
> >> Yeah, currently the predefined valid count range may be some kind of
> >> loose since I want to cover as much as hardwares and avoid to cause
> >> regression. Especially after introducing the random jump and clflush
> >> instructions, the cycles and slots become much more hard to predict.
> >> Maybe we can have a comparable restricted count range in the initial
> >> change, and we can loosen the restriction then if we encounter a failu=
re
> >> on some specific hardware. do you think it's better? Thanks.
> > I think the test is essentially useless, and should probably just be
> > deleted, so that it doesn't give a false sense of confidence.
>
> IMO, I can't say the tests are totally useless. Yes,  passing the tests
> doesn't mean the KVM vPMU must work correctly, but we can say there is
> something probably wrong if it fails to pass these tests. Considering
> the hardware differences, it's impossible to set an exact value for
> these events in advance and it seems there is no better method to verify
> the PMC count as well. I still prefer to keep these tests until we have
> a better method to verify the accuracy of the PMC count.

If it's impossible to set an exact value for these events in advance,
how does Intel validate the hardware PMU?
