Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C8B79777A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240020AbjIGQ0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239692AbjIGQ0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:26:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B411BE4;
        Thu,  7 Sep 2023 09:23:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B2DC433BD;
        Thu,  7 Sep 2023 16:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694103562;
        bh=8xL9UKeWnQPZGbaxtdP6Ukr1OU7J6mJQr4D0jC6AC/g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lyBtGMMElc2R+Io4u8Wep2zD/lmWekHuSRUCp1YpE3OVjkYf2sW+rsBCMSJ9YWRtE
         GZRo2iigNiswVCtKVqaj8mEMGPBhsperQTasRPydSVFZmZ6NECExkNBS2cxnGDgTaw
         Iqz6muBK8KAWwtSfElp54Q/+sIti0dHNBeqk0d9wguS1rUm7uIzvnrHXMi/ZHTSSge
         Okoo/kik8H8WaYPdYia9CW0di/aKC9PGhC1TpxtBu0zzaHlTM2+iSxnkUSlGlx8YOc
         QTE4JcshHcZEQsFq+DYhfvL+ukXHYo08seAwvbVpkbLLHWFO3ECZgz7Lh55GPNEqLj
         Lsi6g/SYoSnjA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50078eba7afso1985418e87.0;
        Thu, 07 Sep 2023 09:19:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YyMyY6ZxJm5cB+qyoosl9NFGl1xlQjasSzn+9j9ko2d2YNlf4A+
        8qljNEOJ0baQ7XTGXgeS4lTeyl7z8fel/1TFuzg=
X-Google-Smtp-Source: AGHT+IEntoDI6WdWiqX6iG/Or2tb56tRm4tbJxKHZmvEe87yv0rFwpn5s1iIPNpqv8+Pi/z4tI0Dq8i8g3FietCAW+E=
X-Received: by 2002:a05:6512:443:b0:500:aa41:9d69 with SMTP id
 y3-20020a056512044300b00500aa419d69mr4687299lfk.66.1694103560253; Thu, 07 Sep
 2023 09:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230830231758.2561402-1-sjg@chromium.org> <20230830231758.2561402-3-sjg@chromium.org>
 <CAMj1kXG5-aqoOtKdPFEdm=_5SdvgUTOhcDOBP1zdARAvKphJtg@mail.gmail.com>
 <CAL_JsqLx0KnXxFc8mFyT_RmA2qeBEutMXj_3nKo_g==cuSeYuQ@mail.gmail.com>
 <CAPnjgZ1U+Gy0Q_Sc63p0ixkWF9iJEEBLhV8-N9-sh7OGNy-OmQ@mail.gmail.com>
 <CAMj1kXG9vM0haSOu19j7ujQCBEN6CBeXVAH96nm+gixt9FmMrA@mail.gmail.com>
 <CAPnjgZ1oGF0Ni3RhK4fv6mJk40YjqyFVJxt6FfS9AW2rkcs9iA@mail.gmail.com>
 <CAMj1kXEZ4fDvbtgXKjF+L7si-=C-5E0XcjutoEF8pU9a-BGN-g@mail.gmail.com>
 <CAPnjgZ0vv+s00xvY2FqP+Fxb12tHuVWg-nwyWTrvuG+Mo4PaWg@mail.gmail.com>
 <CAMj1kXHGpCt8qkd6XYQF8mMdivQkTnEWjv6NzsFK=+N72LAn=Q@mail.gmail.com>
 <CAPnjgZ1vBaXfBa+FWvASi15=Py0DLbEK5XsRHLrJc02K2Yr_RQ@mail.gmail.com>
 <CAMj1kXFjVPwnu226R8bHbo0i0LZ7jQE+vLPNQa6cvrCYqGD+YA@mail.gmail.com> <CAPnjgZ1fVJE=ar_rB_So+vjkOZ_pDjaO5wwPn3pMKe=n3MmBeg@mail.gmail.com>
In-Reply-To: <CAPnjgZ1fVJE=ar_rB_So+vjkOZ_pDjaO5wwPn3pMKe=n3MmBeg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 7 Sep 2023 18:19:09 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF0J+eUC3BgCmf_ZNdpuH7gxYTUup8_AkfLEx0Co51LjQ@mail.gmail.com>
Message-ID: <CAMj1kXF0J+eUC3BgCmf_ZNdpuH7gxYTUup8_AkfLEx0Co51LjQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] schemas: Add some common reserved-memory usages
To:     Simon Glass <sjg@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
        Devicetree Discuss <devicetree@vger.kernel.org>,
        Maximilian Brune <maximilian.brune@9elements.com>,
        ron minnich <rminnich@gmail.com>,
        Tom Rini <trini@konsulko.com>,
        Dhaval Sharma <dhaval@rivosinc.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        linux-acpi@vger.kernel.org, Gua Guo <gua.guo@intel.com>,
        Lean Sheng Tan <sheng.tan@9elements.com>,
        Guo Dong <guo.dong@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Chiu Chasel <chasel.chiu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sept 2023 at 17:57, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ard,
>
> On Thu, 7 Sept 2023 at 09:07, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Thu, 7 Sept 2023 at 16:50, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ard,
> > >
> > > On Thu, 7 Sept 2023 at 08:12, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Thu, 7 Sept 2023 at 15:56, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Ard,
> > > > >
> > > > > On Thu, 7 Sept 2023 at 07:31, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > >
...
> > > > > >
> > > > > > I'm happy to help flesh this out, but you still have not provided us
> > > > > > with an actual use case, so I can only draw from my own experience
> > > > > > putting together firmware for virtual and physical ARM machines.
> > > > >
> > > > > I did explain that this is needed when Tianocore is on both sides of
> > > > > the interface, since Platform Init places some things in memory and
> > > > > the Payload needs to preserve them there, and/or know where they are.
> > > > >
> > > > > I think the problem might be that you don't agree with that, but it
> > > > > seems to be a fact, so I am not sure how I can alter it.
> > > > >
> > > > > Please can you clearly explain which part of the use case you are missing.
> > > > >
> > > >
> > > > 'Tianocore on both sides of the interface' means that Tianocore runs
> > > > as the platform init code, and uses a bespoke DT based protocol to
> > > > launch another instance of Tianocore as the payload, right?
> > >
> > > Not another instance, no. Just the other half of Tianocore. The first
> > > half does platform init and the second half does the loading of the
> > > OS.
> > >
> >
> > That doesn't make any sense to me.
> >
> > > >
> > > > Tianocore/EDK2 already implements methods to reinvoke itself if needed
> > > > (e.g., during a firmware update), and does so by launching a new DXE
> > > > core. So the boot sequence looks like
> > > >
> > > > SEC -> PEI -> DXE -> BDS -> app that invokes UpdateCapsule() -> DXE ->
> > > > firmware update
> > > >
> > > > So please elaborate on how this Tianocore on both sides of the
> > > > interface is put together when it uses this DT based handover. We
> > > > really need a better understanding of this in order to design a DT
> > > > binding that meets its needs.
> > >
> > > Are you familiar with building Tianocore as a coreboot payload, for
> > > example? That shows Tianocore running as just the Payload, with
> > > coreboot doing the platform init. So the use case I am talking about
> > > is similar to that.
> > >
> >
> > Yes I am familiar with that, and it is a completely different thing.
>
> Right, but that is my use case.
>

OK. You alluded to Tianocore <-> Tianocore being your use case, which
is why I kept asking for clarification, as using a DT with this
binding seems unusual at the very least.

So coreboot does the platform init, and then hands over to Tianocore.

I take it we are not talking about x86 here, so there are no Intel FSP
blobs that may have dependencies on Tianocore/EDK2 pieces, right? So
there are no UEFI semantics in the memory descriptions that coreboot
provides to Tianocore.

So coreboot provides information to TIanocore about
- the platform topology (DT as usual)
- DRAM memory banks
- memory reservations
- secure firmware services perhaps?
- anything else?


> >
> > As i explained before, there is already prior art for this in
> > Tianocore, i.e., launching a Tianocore build based on a DT description
> > of the platform, including /memory and /reserved-memory nodes.
>
> By prior art do you mean code, or an existing binding? In either case,
> can you please point me to it? Is this a generic binding used on x86
> as well, or just for ARM?
>
> My goal here is to augment the binding.
>

No I mean code.

There is

https://github.com/tianocore/edk2/tree/master/EmbeddedPkg/Drivers/FdtClientDxe

which encapsulates the DT received from the previous boot stage, and
exposes it as a DXE protocol.

There are other drivers that depend on this protocol, e.g., to
discover additional memory nodes, virtio-mmio drivers and PCI host
bridges.

https://github.com/tianocore/edk2/tree/master/OvmfPkg/Fdt

The bindings used are the ones documented in the Linux kernel tree -
no ad-hoc bindings are being used as far as I know.

But the point I was making before re prior art was really about using
existing bindings rather than inventing new ones. Since we are now
talking about augmenting /reserved-memory, I think we're already on
the same page in this regard (with the caveat that the EDK2 code does
not actually honour /reserved-memory at this point, but this is
because none of the platforms it is being used on today uses that
node)

> >
> > I argued that Tianocore never consumes memory reservations with UEFI
> > semantics, given that it supplants whatever UEFI functionality the
> > previous stage may have provided. But it shouldn't step on the code
> > and data regions used by the previous stage if it is still running in
> > the background (e.g., OS at EL1 and PSCI at EL2 on ARM)
> >
> > So this brings me back to the things I proposed in my previous reply:
> > - memory reservations should be described in detail so the consumer
> > knows what to do with it
>
> Yes I can add more detail, if that is all that is needed. But we seem
> to still not be aligned on the goal.
>
>

I do think we're converging, actually - it is just taking me some time
to get a clear mental picture of how this will be used.

> > - memory reservations should have attributes that describe how the
> > memory may be used if not for the described purpose
> >
> > I still don't see a reason for things like runtime-code and
> > runtime-data etc based on the above. If stage N describes the memory
> > it occupies itself as system memory, it should reserve it as well if
> > it needs to be preserved after stage N+1 has taken over, so perhaps it
> > should be described as a discardable memory reservation but I don't
> > think it necessarily needs a type in that case.
>
> Well if you can find another way to do this in the DT, that is fine.
>

It will all be under /reserved-memory, as far as I understand. We just
need to get to the right level of abstraction.
