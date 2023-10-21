Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD237D1A66
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 03:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjJUBzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 21:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJUBzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 21:55:13 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C245D71
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 18:55:11 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-533d31a8523so2041983a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 18:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697853309; x=1698458109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JH5LtROyHsoyvdQlfciX/YIIP+g5BUcp9Wprz46IPng=;
        b=Ru1zx9w1F7KCDav6hXCQsvCa2gKz7T/xUIxQ8G6yNVAcQbtjkbbZm78mhrwVpoNHqG
         2w24h7ZO2qMwIE+uD6P1qDZpHl/wAutGwRqeROhc6FjH3CeeBjRPZe0+PK9lEBWZoEci
         azuaAi2FeHYuFUGoejPt8tIQSiLkQbpd6Zb+B1WRS7sx9QafjtfYtuOpFATyM+KhKQlT
         KRf3gEhTIkUo9LAzSl+LMvo9PQS8JN8NgmM2BNz1mY1C9C7ukMv0pz4iew67mXDWUl0E
         ZmiG9yr95ZKOCSmC2yEIctOXshqWmcpdPHWwR2VaflKGJTn4J6TNVpprIkjEHZfyPFCd
         atig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697853309; x=1698458109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JH5LtROyHsoyvdQlfciX/YIIP+g5BUcp9Wprz46IPng=;
        b=pv+Jv63AgUBFP87BS6WnO+DhJG2opADm5+YZVpGcCGTt3ZvbP/4hF5nIC4MDKt6XYX
         9vE1hRe13rQ5M1DX2aa1Ku7QA4Yy9q71xW5fn0gtyhpeGtzjSfU3zBerFeRjY53/k8Jd
         l1zc30PXuLIhp5h/08O8shhouB5FAdfVbL6ZyEWTJtWI65XZZSILuHaAt2wvRrODYjJa
         yigzjARaBvO+yd/VwhZzUcu+uXawdIHvkGukFZaARDDFCpJhMpiIDXFSB/wSahDTJy3I
         Q+tmdVZUJ4SdvXEoxfQ6qm8dMqN8pBQooX0fA8onzIbc/ND6Pmaz+IL8Y+99DF+gU/DB
         ZD6w==
X-Gm-Message-State: AOJu0Yx/NkP1d7lmEwFsxzNjBxctHz60noEe9zQW6F2RR23kue2BrINJ
        x5N/3Ce68s0u2kcZXfQo6Of2hQjJapV87b1aM3zjZg==
X-Google-Smtp-Source: AGHT+IHfzZoBBIFbyGVFi+WJLCWldC4YeNWcvN2JVCOYO/nAq4GNioWhiVOJ1A8rXvnHllciLnlAfqUSO8KcqQOG8d0=
X-Received: by 2002:a17:907:9282:b0:9ae:5120:5147 with SMTP id
 bw2-20020a170907928200b009ae51205147mr2467893ejc.38.1697853309282; Fri, 20
 Oct 2023 18:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231006011255.4163884-1-vannapurve@google.com>
 <ZSnIKQ4bUavAtBz6@google.com> <ZSnMfS9A9HgW--YE@google.com>
In-Reply-To: <ZSnMfS9A9HgW--YE@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Sat, 21 Oct 2023 07:24:55 +0530
Message-ID: <CAGtprH8-jiC+wsy2LgmZimrRUT6kuntD6EJso2Mvx5Y42za9Dw@mail.gmail.com>
Subject: Re: [PATCH] x86/tdx: Override the tsc calibration for TDX VMs
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Sagi Shahar <sagis@google.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 4:32=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Oct 13, 2023, Sean Christopherson wrote:
> > On Fri, Oct 06, 2023, Vishal Annapurve wrote:
> > > TSC calibration for native execution gets the TSC frequency from CPUI=
D,
> > > but also ends up setting lapic_timer_period. When using oneshot mode
> > > with lapic timer, predefined value of lapic_timer_period causes lapic
> > > timer calibration to be skipped with wrong multipliers set for lapic
> > > timer.
> > >
> > > To avoid this issue, override the TSC calibration step for TDX VMs to
> > > just calculate the TSC frequency using cpuid values.
> >
> > This is a hack to workaround a KVM TDX bug.  Per Intel's SDM:
> >
> >   The APIC timer frequency will be the processor=E2=80=99s bus clock or=
 core crystal
> >   clock frequency (when TSC/core crystal clock ratio is enumerated in C=
PUID
> >   leaf 0x15) divided by the value specified in the divide configuration=
 register.
> >
> > TDX hardcodes the core crystal frequency to 25Mhz, whereas KVM hardcode=
s the APIC
> > bus frequency to 1Ghz.  Upstream KVM's *current* behavior is fine, beca=
use KVM
> > doesn't advertise support for CPUID 0x15, i.e. doesn't announce to host=
 userspace
> > that it's safe to expose CPUID 0x15 to the guest.  Because TDX makes ex=
posing
> > CPUID 0x15 mandatory, KVM needs to be taught to correctly emulate the g=
uest's
> > APIC bus frequency, a.k.a. the TDX guest core crystal frequency of 25Mh=
z.
> >

Ack, makes sense to pursue this fix from the KVM TDX side instead of
guest changes as per your suggestion.

>
>
> > I.e. tmict_to_ns() needs to replace APIC_BUS_CYCLE_NS with some math th=
at makes
> > the guest's APIC timer actually run at 25Mhz given whatever the host AP=
IC bus
> > runs at.
> >
> >   static inline u64 tmict_to_ns(struct kvm_lapic *apic, u32 tmict)
> >   {
> >       return (u64)tmict * APIC_BUS_CYCLE_NS * (u64)apic->divide_count;
> >   }
>
