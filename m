Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEB98122BC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 00:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjLMXSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 18:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjLMXSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 18:18:36 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130D3AD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 15:18:43 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so5473a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 15:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702509521; x=1703114321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtO9cW/bS+T4J2DvUT4r9uDI2FISmZm46NtsOlUjLfk=;
        b=gEMmEMI4zDG3ms5JSyMCGI8dKWw4l+cb3b17NjP+xghWg9KpVVYAtCDh8mtYCx7WuB
         8iSxOIOKKgU0z8a31nXvfw8aCi/VavJFtceBJ+7jFGdy+dZ1bSjm06NeIz4DAgd5d3Sq
         af2b/IzRfF9Fb3Yt1e+JOx6gcHhbXYFW0WycpX/aQI9SOglXhXZPlScuz6TPdxFpg7Ro
         +pAFEQng4gDyyWEktI4ysG1AF/obOwDWCs3GJ4rLTShYGEMzNqyFODtWEi+CFVjGPxfj
         PsScc5RnyTUAIfKA9RVeZDRMVVxzV0MzK2VmbtcjS850SDlptpJFaAN5iVn80GoXhR6h
         vKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702509521; x=1703114321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtO9cW/bS+T4J2DvUT4r9uDI2FISmZm46NtsOlUjLfk=;
        b=XK7j6dQo4M2rcEfJ66PMyP0sFgxYc4i1kDMIfjVuIJMwW7VD/xhe3Z3in7mPM5unNX
         bz4bWI+udCkGjNdfnwbnkQo3yrEF9sUSX0YeWRM4gS/aUmSWZGG83M2T1sRoNCKjmBxD
         Xfu9XX6/tXV7gw+DXDLgFVjMy9gQKiDKPfFCKK2FhDRqopAu2gtHz0P5yfEQLkUW9mhR
         W34A6GYv+kGoxZqOCzSh3XmGGfKI5blYm+szH15NW0XsVsj1W7KrlSCG7ZOwjD9wvhid
         t4cSRHLxNdzEV0AuIu2OPl7UgPYikg6veewvuowfmGKA586ZG8eVd9CWhKZPQaTPS+aj
         P/fQ==
X-Gm-Message-State: AOJu0Yx7pM3ANUBiMrQ3s6sXomG1KeQuho6BsdfeC+P9F7tKY4gszHMs
        v1KoEuQrIO9xKTtuP85UBkeV7MnYMnMuWnXvatbMgQ==
X-Google-Smtp-Source: AGHT+IHJlijaS4jp5pajI4NmOiafXFWdXV2A3PlgtibtORBNW9UNjAL2V2BgHeLDv+VyAiVat1lsNy4sHnzcE+xRGIA=
X-Received: by 2002:a50:d7ca:0:b0:54a:ee8b:7a8c with SMTP id
 m10-20020a50d7ca000000b0054aee8b7a8cmr550601edj.0.1702509521358; Wed, 13 Dec
 2023 15:18:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699936040.git.isaku.yamahata@intel.com>
 <1c12f378af7de16d7895f8badb18c3b1715e9271.1699936040.git.isaku.yamahata@intel.com>
 <938efd3cfcb25d828deab0cc0ba797177cc69602.camel@redhat.com> <ZXo54VNuIqbMsYv-@google.com>
In-Reply-To: <ZXo54VNuIqbMsYv-@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 13 Dec 2023 15:18:25 -0800
Message-ID: <CALMp9eQUs44tq-3mbqGxcnXjmAx=-jHOLxmW+DuMfeVXGVSDzg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] KVM: x86: Make the hardcoded APIC bus frequency vm variable
To:     Sean Christopherson <seanjc@google.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, isaku.yamahata@intel.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
        erdemaktas@google.com, Vishal Annapurve <vannapurve@google.com>
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

On Wed, Dec 13, 2023 at 3:10=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Dec 14, 2023, Maxim Levitsky wrote:
> > On Mon, 2023-11-13 at 20:35 -0800, isaku.yamahata@intel.com wrote:
> > > From: Isaku Yamahata <isaku.yamahata@intel.com>
> > >
> > > TDX virtualizes the advertised APIC bus frequency to be 25MHz.
> >
> > Can you explain a bit better why TDX needs this? I am not familiar
> > with TDX well enough yet to fully understand.
>
> TDX (the module/architecture) hardcodes the core crystal frequency to 25M=
hz,
> whereas KVM hardcodes the APIC bus frequency to 1Ghz.  And TDX (again, th=
e module)
> *unconditionally* enumerates CPUID 0x15 to TDX guests, i.e. _tells_ the g=
uest that
> the frequency is 25MHz regardless of what the VMM/hypervisor actually emu=
lates.
> And so the guest skips calibrating the APIC timer, which results in the g=
uest
> scheduling timer interrupts waaaaaaay too frequently, i.e. the guest ends=
 up
> gettings interrupts at 40x the rate it wants.
>
> Upstream KVM's non-TDX behavior is fine, because KVM doesn't advertise su=
pport
> for CPUID 0x15, i.e. doesn't announce to host userspace that it's safe to=
 expose
> CPUID 0x15 to the guest.  Because TDX makes exposing CPUID 0x15 mandatory=
, KVM
> needs to be taught to correctly emulate the guest's APIC bus frequency, a=
.k.a.
> the TDX guest core crystal frequency of 25Mhz.

Aside from placating a broken guest infrastructure that ignores a
17-year old contract between KVM and its guests, what are the
advantages to supporting a range of APIC bus frequencies?

> I halfheartedly floated the idea of "fixing" the TDX module/architecture =
to either
> use 1Ghz as the base frequency (off list), but it definitely isn't a hill=
 worth
> dying on since the KVM changes are relatively simple.

Not making the KVM changes is even simpler. :)
