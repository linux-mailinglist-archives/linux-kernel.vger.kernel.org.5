Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DDD7E75A7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345520AbjKJAG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbjKJAGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:06:11 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EAC7699
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 16:02:22 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so23974a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 16:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699574541; x=1700179341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Uct5fRuxJFXU94Tz4PJyyKXoirMBsA5N0Xtf3w4zUY=;
        b=muls4XTzCZdRaCLbi1mKgfOQLC6iEI5ko+ddp1S/B7aonU4H+HjUBqgKKTsdZLVMdP
         63AOEXHHoubx9GbBWUSRFgU1VyLsXriNSIgZYGavhSX2zLMF+X8mRispLWEjxE6yDqMO
         hMOpEn8M07ZjuUfGgcaTmdQO9xRdfuj328y+l9axtSxGaH8SKVWoHMGlGeGprU5aNvLo
         P8t+s6vlt/1C36zQBNzNVFbCdSUF+RCk5hU+Dt2WCMSqZzBYcgkXshWbwYZjvd1QKmSq
         1LTrQ4tijlKgbL5YycrJSI9nlF7A+vcxxDWaNEDv2jweFTVJ6O89+X/+dxpI9sKgLt4u
         vylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574541; x=1700179341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Uct5fRuxJFXU94Tz4PJyyKXoirMBsA5N0Xtf3w4zUY=;
        b=jAb51r50YP6PkiShVYhJvnlUIUQRNaRZrYhhcvbc810pwpHZkKnu/3HNUcyr5VZAR0
         YBHVyN+k6lLVIkOwfzwdjzdBHVrtOgjDk9NrYKSowClRvvphGwVN8mA4M3lK5O8RJbCv
         1A+i+/7Lrpu15WSf7QbOz9Auqmi0IXnbR10tsSXrF2ICh+S8WaGSVO3JhhvyJJ2MEI+J
         +DFNhhbaGpbDcPDJfeguJPawCjp0m5EQLR39Ush1K8MKAETzA71iWMvnc7l1RVdk+p59
         HaUXqQPWScpXvEsXSCvb2ZURO2lH/vr6HalVC25mfe2j3kHH2BYZKdRYMzqNI6293mux
         snuQ==
X-Gm-Message-State: AOJu0YyPJ0NbcPZXp/6K38QzeNlAhQM6K77+zquTKloBuUUYJWGipm86
        Tk7YdSZR3bifyto61z18eNnwrz7VC1rtzKK1LAc48A==
X-Google-Smtp-Source: AGHT+IEHIZYWQkUEDtEIX15uWrgumO5VpPvdRBCVvSyu74zpWG4zw0fFjNzBuEEUSoHTadwmW69UqTf920Rp6Z+RYq0=
X-Received: by 2002:a05:6402:114d:b0:545:2921:d217 with SMTP id
 g13-20020a056402114d00b005452921d217mr284759edw.6.1699574540886; Thu, 09 Nov
 2023 16:02:20 -0800 (PST)
MIME-Version: 1.0
References: <20231109180646.2963718-1-khorenko@virtuozzo.com>
 <be70080d-fe76-4bd1-87b9-131eca8c7af1@virtuozzo.com> <CALMp9eSg=DZrFcq1ERGMeoEngFLRFtmnQN6t-noFT8T596NAYA@mail.gmail.com>
 <09116ed9-3409-4fbf-9c4f-7a94d8f620aa@virtuozzo.com>
In-Reply-To: <09116ed9-3409-4fbf-9c4f-7a94d8f620aa@virtuozzo.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 9 Nov 2023 16:02:05 -0800
Message-ID: <CALMp9eRC_suWQ+NCH1bREfg0iFHJtGeuB0x-wZ-MpZh3HXFNcg@mail.gmail.com>
Subject: Re: KVM: x86/vPMU/AMD: Can we detect PMU is off for a VM?
To:     "Denis V. Lunev" <den@virtuozzo.com>
Cc:     Konstantin Khorenko <khorenko@virtuozzo.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 3:46=E2=80=AFPM Denis V. Lunev <den@virtuozzo.com> w=
rote:
>
> On 11/9/23 23:52, Jim Mattson wrote:
> > On Thu, Nov 9, 2023 at 10:18=E2=80=AFAM Konstantin Khorenko
> > <khorenko@virtuozzo.com> wrote:
> >> Hi All,
> >>
> >> as a followup for my patch: i have noticed that
> >> currently Intel kernel code provides an ability to detect if PMU is to=
tally disabled for a VM
> >> (pmu->version =3D=3D 0 in this case), but for AMD code pmu->version is=
 never 0,
> >> no matter if PMU is enabled or disabled for a VM (i mean <pmu state=3D=
'off'/> in the VM config which
> >> results in "-cpu pmu=3Doff" qemu option).
> >>
> >> So the question is - is it possible to enhance the code for AMD to als=
o honor PMU VM setting or it is
> >> impossible by design?
> > The AMD architectural specification prior to AMD PMU v2 does not allow
> > one to describe a CPU (via CPUID or MSRs) that has fewer than 4
> > general purpose PMU counters. While AMD PMU v2 does allow one to
> > describe such a CPU, legacy software that knows nothing of AMD PMU v2
> > can expect four counters regardless.
> >
> > Having said that, KVM does provide a per-VM capability for disabling
> > the virtual PMU: KVM_CAP_PMU_CAPABILITY(KVM_PMU_CAP_DISABLE). See
> > section 8.35 in Documentation/virt/kvm/api.rst.
> But this means in particular that QEMU should immediately
> use this KVM_PMU_CAP_DISABLE if this capability is supported and
> PMU=3Doff. I am not seeing this code thus I believe that we have missed
> this. I think that this change worth adding. We will measure the impact
> :-) Den

At present, KVM will still blindly cycle through each GP counter (4
minimum for AMD) until it checks vcpu->kvm->arch.enable_pmu at the top
of get_gp_pmc_amd().

Sean's proposal to clear the metadata should eliminate the overhead
for VMs with the virtual PMU disabled. My proposal should eliminate
the overhead even for VMs with the virtual PMU enabled, as long as no
counters are programmed for "instructions retired."
