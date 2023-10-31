Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561A67DD10D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344861AbjJaP4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344842AbjJaP4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:56:31 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877E0F1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 08:56:27 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50930f126b1so1417865e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 08:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698767786; x=1699372586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHMcOBdFYSE+8bQdxJLdLIEnklj/QhOLRUMvZvnsOnc=;
        b=GdwsHaQmdAHe2I0Taj1u1mh/wLZt11Jnqi1R62gjEeDVk04NACdjLSzLfaLpGl2LQI
         6ldScu2mPfJ12+dBMPho8c09y5KVROmb4ZbBn3zD4Dl1lE9AEazMZEBNP/426U8FFXr4
         WlGjjLbQlFUX6tXA9CFopPbhFUfUu5J4Z9xhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698767786; x=1699372586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHMcOBdFYSE+8bQdxJLdLIEnklj/QhOLRUMvZvnsOnc=;
        b=QBjLuAjL0GN+SHbxwPxg0Q03Tpchl19+qNMkGNqqhBv8vqOVwDs75Bppo5AG8Iib63
         sAwmM0lNrMIgCcGIGPoQUc93LOOvAwwfmdLozgaELElBCtDLKa3kiio5yymdlTkOthrM
         ASe5VP8xviBbZr7sUp/TFMxw0KSw/uSueJiooRswFqLBXBqpzgX0Gr1H7lROiC/OMfaq
         q4rxwYEIyn28FxcdKi1u8pihSTbh5IohoNo3WgjjKzOSSj1Mno//yKY771BXtN6cokz3
         gRlpL24AAWltopjkVR+EBMpN8nDTQJA7s61eq6vJXNvwiV8JuQjQwIMFjN4TkjzRdq8S
         5ysw==
X-Gm-Message-State: AOJu0YwYUEfpnFpy3MbUsrIv/WQabML1Gdn20pJDG5Ug44+CVYnrPtGm
        NUF57TkEXuEev7f1tcnaS5vrAaZCD+xZUW+A3DHnkhhw4iLFypvQ0hI=
X-Google-Smtp-Source: AGHT+IGbUvvv2le05LQXmClEzIoa9JudCW13DGRbovqjMaWYeHnLbrMVVPg93bjaAWyIqR5/AodlwAvye0YUGv26j1M=
X-Received: by 2002:a05:6512:3b87:b0:508:2b98:d6ce with SMTP id
 g7-20020a0565123b8700b005082b98d6cemr12268778lfv.45.1698767785185; Tue, 31
 Oct 2023 08:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org> <20230926194242.2732127-2-sjg@chromium.org>
 <CAPnjgZ0Xf3U1aj32LbU-xiU1AqwnM3JL1F8xX-wZ18oEmg+irw@mail.gmail.com>
 <CAMj1kXEXcX7BkDyfy-6_5Vnch=N+onza-yfWfsVaGLE93h2c+Q@mail.gmail.com>
 <CAPnjgZ2SEby-ndrs=W_afBJH56eqc=-mhp1F1nwkvWks+=B54Q@mail.gmail.com>
 <CAMj1kXED3S+0cq+VT7naBrmWrUwT=HZAaZOBRMv8Ui1Pey1QNQ@mail.gmail.com>
 <CAPnjgZ0LrsJ2_ENTYoBrnyFaH3UKdHs3D2XWY=TzBuBpBoTXZA@mail.gmail.com>
 <CAL_Jsq+DQugkEDESW5wySFbLLN8HNqGDJCio8Wpi6fe0LeHKUA@mail.gmail.com>
 <CAPnjgZ0cmKP5hoGCyQ_Rp8ZQXUVwaPYJMWyidXuOOjMVkDoMDw@mail.gmail.com>
 <CAL_JsqJH=vJ40PNTg_i0LoKA-c0hhMJkL8zCC3_bB-tOkFWWsw@mail.gmail.com> <CAPnjgZ1FrdGKjGAxUbkQoL2vHwhC_2Oa2KT+0cm25dQAuAjxAQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ1FrdGKjGAxUbkQoL2vHwhC_2Oa2KT+0cm25dQAuAjxAQ@mail.gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Tue, 31 Oct 2023 09:56:08 -0600
Message-ID: <CAPnjgZ19-xR6QxS=fR53skz0VuAty2Z2w2vQTjP7g=tbTFpaqw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
To:     Rob Herring <robh@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lean Sheng Tan <sheng.tan@9elements.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Dhaval Sharma <dhaval@rivosinc.com>,
        Maximilian Brune <maximilian.brune@9elements.com>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        Guo Dong <guo.dong@intel.com>, Tom Rini <trini@konsulko.com>,
        ron minnich <rminnich@gmail.com>, Gua Guo <gua.guo@intel.com>,
        Chiu Chasel <chasel.chiu@intel.com>,
        linux-acpi@vger.kernel.org,
        U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, 16 Oct 2023 at 15:54, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Rob,
>
> On Mon, 16 Oct 2023 at 10:50, Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Oct 13, 2023 at 4:09=E2=80=AFPM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi Rob,
> > >
> > > On Fri, 13 Oct 2023 at 13:42, Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Fri, Oct 6, 2023 at 7:03=E2=80=AFPM Simon Glass <sjg@chromium.or=
g> wrote:
> > > > >
> > > > > Hi Ard,
> > > > >
> > > > > On Fri, 6 Oct 2023 at 17:00, Ard Biesheuvel <ardb@kernel.org> wro=
te:
> > > > > >
> > > > > > On Fri, 6 Oct 2023 at 20:17, Simon Glass <sjg@chromium.org> wro=
te:
> > > > > > >
> > > > > > > Hi Ard,
> > > > > > >
> > > > > > > On Fri, 6 Oct 2023 at 11:33, Ard Biesheuvel <ardb@kernel.org>=
 wrote:
> > > > > > > >
> > > > > > > > On Mon, 2 Oct 2023 at 19:54, Simon Glass <sjg@chromium.org>=
 wrote:
> > > > > > > > >
> > > > > > > > > Hi Rob,
> > > > > > > > >
> > > > > > > > > On Tue, 26 Sept 2023 at 13:42, Simon Glass <sjg@chromium.=
org> wrote:
> > > > > > > > > >
> > > > > > > > > > It is common to split firmware into 'Platform Init', wh=
ich does the
> > > > > > > > > > initial hardware setup and a "Payload" which selects th=
e OS to be booted.
> > > > > > > > > > Thus an handover interface is required between these tw=
o pieces.
> > > > > > > > > >
> > > > > > > > > > Where UEFI boot-time services are not available, but UE=
FI firmware is
> > > > > > > > > > present on either side of this interface, information a=
bout memory usage
> > > > > > > > > > and attributes must be presented to the "Payload" in so=
me form.
> > > > > > > > > >
> > > > > > > > > > This aims to provide an small schema addition for the m=
emory mapping
> > > > > > > > > > needed to keep these two pieces working together well.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > ---
> > > > > > > > > >
> > > > > > > > > > Changes in v7:
> > > > > > > > > > - Rename acpi-reclaim to acpi
> > > > > > > > > > - Drop individual mention of when memory can be reclaim=
ed
> > > > > > > > > > - Rewrite the item descriptions
> > > > > > > > > > - Add back the UEFI text (with trepidation)
> > > > > > > > >
> > > > > > > > > I am again checking on this series. Can it be applied, pl=
ease?
> > > > > > > > >
> > > > > > > >
> > > > > > > > Apologies for the delay in response. I have been away.
> > > > > > >
> > > > > > > OK, I hope you had a nice trip.
> > > > > > >
> > > > > >
> > > > > > Thanks, it was wonderful!
> > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Changes in v6:
> > > > > > > > > > - Drop mention of UEFI
> > > > > > > > > > - Use compatible strings instead of node names
> > > > > > > > > >
> > > > > > > > > > Changes in v5:
> > > > > > > > > > - Drop the memory-map node (should have done that in v4=
)
> > > > > > > > > > - Tidy up schema a bit
> > > > > > > > > >
> > > > > > > > > > Changes in v4:
> > > > > > > > > > - Make use of the reserved-memory node instead of creat=
ing a new one
> > > > > > > > > >
> > > > > > > > > > Changes in v3:
> > > > > > > > > > - Reword commit message again
> > > > > > > > > > - cc a lot more people, from the FFI patch
> > > > > > > > > > - Split out the attributes into the /memory nodes
> > > > > > > > > >
> > > > > > > > > > Changes in v2:
> > > > > > > > > > - Reword commit message
> > > > > > > > > >
> > > > > > > > > >  .../reserved-memory/common-reserved.yaml      | 71 +++=
++++++++++++++++
> > > > > > > > > >  1 file changed, 71 insertions(+)
> > > > > > > > > >  create mode 100644 dtschema/schemas/reserved-memory/co=
mmon-reserved.yaml
> > > > > > > > > >
> > > > > > > > > > diff --git a/dtschema/schemas/reserved-memory/common-re=
served.yaml b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > > > > > > > > new file mode 100644
> > > > > > > > > > index 0000000..f7fbdfd
> > > > > > > > > > --- /dev/null
> > > > > > > > > > +++ b/dtschema/schemas/reserved-memory/common-reserved.=
yaml
> > > > > > > > > > @@ -0,0 +1,71 @@
> > > > > > > > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Claus=
e
> > > > > > > > > > +%YAML 1.2
> > > > > > > > > > +---
> > > > > > > > > > +$id: http://devicetree.org/schemas/reserved-memory/com=
mon-reserved.yaml#
> > > > > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > > > > +
> > > > > > > > > > +title: Common memory reservations
> > > > > > > > > > +
> > > > > > > > > > +description: |
> > > > > > > > > > +  Specifies that the reserved memory region can be use=
d for the purpose
> > > > > > > > > > +  indicated by its compatible string.
> > > > > > > > > > +
> > > > > > > > > > +  Clients may reuse this reserved memory if they under=
stand what it is for,
> > > > > > > > > > +  subject to the notes below.
> > > > > > > > > > +
> > > > > > > > > > +maintainers:
> > > > > > > > > > +  - Simon Glass <sjg@chromium.org>
> > > > > > > > > > +
> > > > > > > > > > +allOf:
> > > > > > > > > > +  - $ref: reserved-memory.yaml
> > > > > > > > > > +
> > > > > > > > > > +properties:
> > > > > > > > > > +  compatible:
> > > > > > > > > > +    description: |
> > > > > > > > > > +      This describes some common memory reservations, =
with the compatible
> > > > > > > > > > +      string indicating what it is used for:
> > > > > > > > > > +
> > > > > > > > > > +         acpi: Advanced Configuration and Power Interf=
ace (ACPI) tables
> > > > > > > > > > +         acpi-nvs: ACPI Non-Volatile-Sleeping Memory (=
NVS). This is reserved by
> > > > > > > > > > +           the firmware for its use and is required to=
 be saved and restored
> > > > > > > > > > +           across an NVS sleep
> > > > > > > > > > +         boot-code: Contains code used for booting whi=
ch is not needed by the OS
> > > > > > > > > > +         boot-code: Contains data used for booting whi=
ch is not needed by the OS
> > > > > > > > > > +         runtime-code: Contains code used for interact=
ing with the system when
> > > > > > > > > > +           running the OS
> > > > > > > > > > +         runtime-data: Contains data used for interact=
ing with the system when
> > > > > > > > > > +           running the OS
> > > > > > > > > > +
> > > > > > > > > > +    enum:
> > > > > > > > > > +      - acpi
> > > > > > > > > > +      - acpi-nvs
> > > > > > > > > > +      - boot-code
> > > > > > > > > > +      - boot-data
> > > > > > > > > > +      - runtime-code
> > > > > > > > > > +      - runtime-data
> > > > > > > > > > +
> > > > > > > >
> > > > > > > > As I mentioned a few times already, I don't think these com=
patibles
> > > > > > > > should be introduced here.
> > > > > > > >
> > > > > > > > A reserved region has a specific purpose, and the compatibl=
e should be
> > > > > > > > more descriptive than the enum above. If the consumer does =
not
> > > > > > > > understand this purpose, it should simply treat the memory =
as reserved
> > > > > > > > and not touch it. Alternatively, these regions can be refer=
enced from
> > > > > > > > other DT nodes using phandles if needed.
> > > > > > >
> > > > > > > We still need some description of what these regions are used=
 for, so
> > > > > > > that the payload can use the correct regions. I do not have a=
ny other
> > > > > > > solution to this problem. We are in v7 at present. At least e=
xplain
> > > > > > > where you want the compatible strings to be introduced.
> > > > > > >
> > > > > >
> > > > > > My point is really that by themselves, these regions are not us=
able by
> > > > > > either a payload or an OS that consumes this information. Unles=
s there
> > > > > > is some other information being provided (via DT I imagine) tha=
t
> > > > > > describes how these things are supposed to be used, they are no=
thing
> > > > > > more than memory reservations that should be honored, and provi=
ding
> > > > > > this arbitrary set of labels is unnecessary.
> > > > > >
> > > > > > > What sort of extra detail are you looking for? Please be spec=
ific and
> > > > > > > preferably add some suggestions so I can close this out ASAP.
> > > > > > >
> > > > > >
> > > > > > A payload or OS can do nothing with a memory reservation called
> > > > > > 'runtime-code' it it doesn't know what is inside.
> > > >
> > > > Agreed. The question is WHAT runtime-code? The compatible needs to =
answer that.
> > > >
> > > > For example, we have 'ramoops' as a compatible in reserved memory.
> > > > That tells us *exactly* what's there. We know how to parse it. If w=
e
> > > > know ramoops is not supported, then we know we can toss it out and
> > > > reclaim the memory.
> > >
> > > So if we said:
> > >
> > >    compatible =3D "runtime-code-efi"
> > >
> > > would that be OK? We seem to be in catch 22 here, because if I don't
> > > mention EFI unhappy, but if I do, Ard is unhappy.
> >
> > Better yes, because then it is for something specific. However, AIUI,
> > that's setup for the OS and defining that region is already defined by
> > the EFI memory map. That's Ard's issue. If there's a need outside of
> > the EFI to OS handoff,
>
> There is a need. Here is part of the commit message again. If there is
> something else you need to know, please ask.
>
> >>>>
> It is common to split firmware into 'Platform Init', which does the
> initial hardware setup and a "Payload" which selects the OS to be booted.
> Thus an handover interface is required between these two pieces.
>
> Where UEFI boot-time services are not available, but UEFI firmware is
> present on either side of this interface, information about memory usage
> and attributes must be presented to the "Payload" in some form.
> <<<
>
> > then you need to define what that usecase looks
> > like. Describe the problem rather than present your solution.
> >
> > If this is all specific to EDK2 then it should say that rather than
> > 'efi'. I imagine Ard would be happier with something tied to EDK2 than
> > *all* UEFI. Though maybe the problem could be any implementation? IDK.
> > Maybe it's TF-A that needs to define where the EFI runtime services
> > region is and that needs to be passed all the way thru to the EFI
> > implementation? So again, define the problem.
>
> It is not specific to EDK2. Imagine this boot sequence:
>
> - Platform Init (U-Boot) starts up
> - U-Boot uses its platform knowledge to sets some ACPI tables and put
> various things in memory
> - U-Boot sets up some runtime code and data for the OS
> - U-Boot jumps to the Tianocore payload **
> - Payload (Tianocore) wants to know where the ACPI tables are, for exampl=
e
> - Tianocore needs to provide boot services to the OS, so needs to know
> the memory map, etc.
>
> ** At this point we want to use DT to pass the required information.
>
> Of course, Platform Init could be coreboot or Tianocore or some
> strange private binary. Payload could be U-Boot or something else.
> That is the point of this effort, to build interoperability.
>
> >
> > > What about the boottime code....you want to know which project it is =
from?
> >
> > I think it is the same.
> >
> > >
> > > +      - acpi
> > > +      - acpi-nvs
> > >
> > > Those two should be enough info, right?
> >
> > I think so. NVS is not a term I've heard in relation to ACPI, but that
> > may just be my limited ACPI knowledge.
>
> Perhaps it is only an Intel thing. It stands for Non-Volatile-Sleeping
> Memory and it has various platform settings in a binary format that is
> normally SoC-specific.
>
> >
> > > +      - boot-code
> > > +      - boot-data
> > >
> > > For these, they don't pertain to the OS, so perhaps they are OK?
> >
> > Hard to tell that just from the name... 'boot' could be any component
> > involved in booting including the OS.
>
>  suggested that 'boot' should mean booting the OS. If the OS does lots
> of fixup stuff at the start of it, I don't know what that is called.
>
> So if boot-code is no good, what do you suggest?
>
> Alternatively I could remove these for now, if it will help make progress=
.
>
> >
> > > In
> > > any case, using a generic term like this makes some sense to me. We
> > > can always add a new compatible like "efi-boottime-services" later. I=
t
> > > may be that the boottime services would be handled by the payload, so
> > > not needed in all cases.
> >
> > Why later? You have a specific use in mind and I imagine Ard has
> > thoughts on that.
>
> Because we don't need it right away, and just want to make some progress.
>
> Perhaps the problem here is that Linux has tied itself up in knots
> with its EFI stuff and DT fixups and what-not. But this is not that.
> It is a simple handoff between two pieces of firmware, Platform Init
> and Payload. It has nothing to do with the OS. With Tianocore they are
> typically combined, but with this usage they are split, and we can
> swap out one project for another on either side of the DT interface.
>
> I do have views on the 'EFI' opt-out with reserved-memory, if you are
> interested, but that relates to the OS. If you are wanting to place
> some constraints on /reserved-memory and /memory we could do that
> e.g. that the DT and the map returned by EFI boot services must be
> consistent. But as it is, the nodes are ignored by the OS when booting
> with EFI, aren't they?

Can this be applied, please? If there are further comments, please let me k=
now.

Regards,
Simon
