Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E977DDB4F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 04:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346401AbjKADFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 23:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345437AbjKADFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 23:05:05 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847E4A4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 20:05:02 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54357417e81so7108a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 20:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698807901; x=1699412701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9N2UA9dR/oUEBgRu3zdeV9HEhaEPwCrVnYcXhdTWnNc=;
        b=CzRkdDNLwVf8a0C/3qEEfONTclZx+Us/aYW8ttUBJqYzhPFbi5kGsFoyVTBxmpcTRz
         H+PU4NuLjitGtzj+LAlxqEeK3/WSMOi08/0ORvug+pxn8NH5J38YWDdtfeLRPKt14YW8
         JbYiAXa0FdvqqkcmJa1P5YO/4QoWnfXIdhtc7sYkGbSVrX27Bvbwh8PDURY5EzoRNKYN
         gDZu/eMcXGnv26ttjPITIWQNTr4nnxBGd63dYU8QnIW97skjvZevcFaxhjCqnDrFjyD0
         EtsIELn4Sv7pnh4tS90bFgJqYCW6irEPY2zDLXbrv88IlnES0+whnLz5IsjvvNd776LC
         qAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698807901; x=1699412701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9N2UA9dR/oUEBgRu3zdeV9HEhaEPwCrVnYcXhdTWnNc=;
        b=OTDJyGdZDAYXLydmRwpFFId+ifwAJN2rm4ueKVID1nC4XFNZIP7S9X+t4nXtNuuWcd
         xEsy1ZkuNWEVYgABuOsodHsLeEwRsAfIuE0/sS5XbZhA1VQg05CTurmPoooTO36/Kscq
         bUQZ3VUxStzTr7lT5ifklwVKhOjoxNtAYADMQwRPIlywlpj6eE5dkwu8bmsG9fFkoPpA
         8ZhKqSJuiT+bokOWnbu2sOjZfTxbfxsZBe9ay8HOiHkmkrAo9mvj2TrOcavQclGp0rwN
         lR1zMwncmZUJUbjrztk5PnUFJfYoGvG5uidYMOYhQAtDtUQrI+RP/KiaVZg6l2bW1OCJ
         rzFw==
X-Gm-Message-State: AOJu0Ywf+QSsadOhOHbQlc++KkfT5L35ukJnSdF5F1l20i2Esm1yrpsC
        1fB4e1IUFBEIKxDjNDna84FmpW+NoPVpWXv5UQEVKg==
X-Google-Smtp-Source: AGHT+IGojXNIkUFRDI7lZE8wBZW9PuUSLclcXnwZFhs9D+DoWIraauxXRymU9sglhfserqB4aW93J8O9zRz+r61TZyo=
X-Received: by 2002:a05:6402:1943:b0:543:74af:dfee with SMTP id
 f3-20020a056402194300b0054374afdfeemr195528edz.5.1698807900776; Tue, 31 Oct
 2023 20:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231031090613.2872700-1-dapeng1.mi@linux.intel.com>
 <20231031090613.2872700-2-dapeng1.mi@linux.intel.com> <CALMp9eR_BFdNNTXhSpbuH66jXcRLVB8VvD8V+kY245NbusN2+g@mail.gmail.com>
 <c3f0e4ac-1790-40c1-a09e-209a09e3d230@linux.intel.com>
In-Reply-To: <c3f0e4ac-1790-40c1-a09e-209a09e3d230@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 31 Oct 2023 20:04:45 -0700
Message-ID: <CALMp9eTDAiJ=Kuh7KkwdAY8x1BL2ZjdgFiPFRHXSSVCpcXp9rw@mail.gmail.com>
Subject: Re: [Patch 1/2] KVM: x86/pmu: Add Intel CPUID-hinted TopDown slots event
To:     "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhang Xiong <xiong.y.zhang@intel.com>,
        Mingwei Zhang <mizhang@google.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Dapeng Mi <dapeng1.mi@intel.com>, Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 6:59=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
> On 11/1/2023 2:22 AM, Jim Mattson wrote:
> > On Tue, Oct 31, 2023 at 1:58=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.int=
el.com> wrote:
> >> This patch adds support for the architectural topdown slots event whic=
h
> >> is hinted by CPUID.0AH.EBX.
> > Can't a guest already program an event selector to count event select
> > 0xa4, unit mask 1, unless the event is prohibited by
> > KVM_SET_PMU_EVENT_FILTER?
>
> Actually defining this new slots arch event is to do the sanity check
> for supported arch-events which is enumerated by CPUID.0AH.EBX.
> Currently vPMU would check if the arch event from guest is supported by
> KVM. If not, it would be rejected just like intel_hw_event_available()
> shows.
>
> If we don't add the slots event in the intel_arch_events[] array, guest
> may program the slots event and pass the sanity check of KVM on a
> platform which actually doesn't support slots event and program the
> event on a real GP counter and got an invalid count. This is not correct.

On physical hardware, it is possible to program a GP counter with the
event selector and unit mask of the slots event whether or not the
platform supports it. Isn't KVM wrong to disallow something that a
physical CPU allows?

> >
> > AFAICT, this change just enables event filtering based on
> > CPUID.0AH:EBX[bit 7] (though it's not clear to me why two independent
> > mechanisms are necessary for event filtering).
>
>
> IMO, these are two different things. this change is just to enable the
> supported arch events check for slot events, the event filtering is
> another thing.

How is clearing CPUID.0AH:EBX[bit 7] any different from putting {event
select 0xa4, unit mask 1} in a deny list with the PMU event filter?
