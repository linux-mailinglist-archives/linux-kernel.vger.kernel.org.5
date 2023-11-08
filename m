Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1087E5833
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjKHN5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjKHN5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:57:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43091BEF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 05:57:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E97CC43391;
        Wed,  8 Nov 2023 13:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699451849;
        bh=oAMyGLNvlEk2Z3kcyrMLZHtZ2K7CmXV47NgxDhyFDAI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TLLvN3zbeCodFityx/4ypnt/Ii/fLaigJHu+596F82grUSxrOKhUp5VnJ10ovHhGv
         TQVt+OifIzv1INb3RTscv+PKfnTR/VZ8VqSq7/ZL66e4nDpmbbBAPs7YOBrYmZnGlO
         qF/ZUayfqAma1ZWC5m63Ga58DPZ99AmzuijezXivJABvO1R0GUBdOomF7mVGJ5DcPD
         SatYDtXoRSRvA2oZRCgQjl+dEgpfDW1nV+g1uZLgS2hEEu8CerEmr+rFNBtjpTaqsv
         XzS65rJj1xOOVKWSPvaaJUKjsWRz/XhhvcYjMSAefJnHMH/E/5ioxrSdzr1Td/5o/U
         AmTn32Jy6Wjfg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-507ad511315so9991958e87.0;
        Wed, 08 Nov 2023 05:57:29 -0800 (PST)
X-Gm-Message-State: AOJu0YwHrkJ5csqhd4zb3ihEruA5yGxTE5EufmxkrNjMbvsscjqt2ms7
        3tpZxYznzF8FEarKSW2IStkf1vUk1rc6Wtq9Cw==
X-Google-Smtp-Source: AGHT+IGuwHUp+aEG6CZkAVv9OagCbfM3Ciyh9iJ50ppoxMFJJ3ItGNnVmTiHOsiB5o//EA7YPSpGzVzEkTMc7343V6w=
X-Received: by 2002:ac2:5397:0:b0:507:b9db:61dc with SMTP id
 g23-20020ac25397000000b00507b9db61dcmr1259652lfh.48.1699451847501; Wed, 08
 Nov 2023 05:57:27 -0800 (PST)
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org> <20230926194242.2732127-2-sjg@chromium.org>
 <CAPnjgZ0Xf3U1aj32LbU-xiU1AqwnM3JL1F8xX-wZ18oEmg+irw@mail.gmail.com>
 <CAMj1kXEXcX7BkDyfy-6_5Vnch=N+onza-yfWfsVaGLE93h2c+Q@mail.gmail.com>
 <CAPnjgZ2SEby-ndrs=W_afBJH56eqc=-mhp1F1nwkvWks+=B54Q@mail.gmail.com>
 <CAMj1kXED3S+0cq+VT7naBrmWrUwT=HZAaZOBRMv8Ui1Pey1QNQ@mail.gmail.com>
 <CAPnjgZ0LrsJ2_ENTYoBrnyFaH3UKdHs3D2XWY=TzBuBpBoTXZA@mail.gmail.com>
 <CAL_Jsq+DQugkEDESW5wySFbLLN8HNqGDJCio8Wpi6fe0LeHKUA@mail.gmail.com>
 <CAPnjgZ0cmKP5hoGCyQ_Rp8ZQXUVwaPYJMWyidXuOOjMVkDoMDw@mail.gmail.com>
 <CAL_JsqJH=vJ40PNTg_i0LoKA-c0hhMJkL8zCC3_bB-tOkFWWsw@mail.gmail.com>
 <CAPnjgZ1FrdGKjGAxUbkQoL2vHwhC_2Oa2KT+0cm25dQAuAjxAQ@mail.gmail.com>
 <CAPnjgZ19-xR6QxS=fR53skz0VuAty2Z2w2vQTjP7g=tbTFpaqw@mail.gmail.com>
 <CAL_JsqL+X1DatsGk_Cn1HsbG2GV9AngFWXVysWTiNRu_d9tDqw@mail.gmail.com> <CAMj1kXHfh40wxerZGjOn2JJ5Skm5C--Rz2jy8p3XZ2UXKGjw+g@mail.gmail.com>
In-Reply-To: <CAMj1kXHfh40wxerZGjOn2JJ5Skm5C--Rz2jy8p3XZ2UXKGjw+g@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 8 Nov 2023 07:57:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLpea+FU4gXpaSUSeBP70szJ+mRjJtFei=QW2VoHCFOuA@mail.gmail.com>
Message-ID: <CAL_JsqLpea+FU4gXpaSUSeBP70szJ+mRjJtFei=QW2VoHCFOuA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Simon Glass <sjg@chromium.org>, devicetree@vger.kernel.org,
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 5:38=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Tue, 7 Nov 2023 at 19:07, Rob Herring <robh@kernel.org> wrote:
> >
> >
> > All of this:
> >
>
> > > On Mon, 16 Oct 2023 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > It is not specific to EDK2. Imagine this boot sequence:
> > > >
> > > > - Platform Init (U-Boot) starts up
> > > > - U-Boot uses its platform knowledge to sets some ACPI tables and p=
ut
> > > > various things in memory
> > > > - U-Boot sets up some runtime code and data for the OS
> > > > - U-Boot jumps to the Tianocore payload **
> > > > - Payload (Tianocore) wants to know where the ACPI tables are, for =
example
> > > > - Tianocore needs to provide boot services to the OS, so needs to k=
now
> > > > the memory map, etc.
> > > >
> > > > ** At this point we want to use DT to pass the required information=
.
> > > >
> > > > Of course, Platform Init could be coreboot or Tianocore or some
> > > > strange private binary. Payload could be U-Boot or something else.
> > > > That is the point of this effort, to build interoperability.
> >
> > [...]
> >
> > > > Perhaps the problem here is that Linux has tied itself up in knots
> > > > with its EFI stuff and DT fixups and what-not. But this is not that=
.
> > > > It is a simple handoff between two pieces of firmware, Platform Ini=
t
> > > > and Payload. It has nothing to do with the OS. With Tianocore they =
are
> > > > typically combined, but with this usage they are split, and we can
> > > > swap out one project for another on either side of the DT interface=
.
> >
> > Is perhaps the clearest description of the problem you want to solve.
> > It's clearly related to EFI though not the interface to the OS. IIRC,
> > "platform init" and "payload" are terms in the UEFI spec, right?
>
> No they are not. This is from the universal payload specification that
> is being drafted here
>
> https://universalpayload.github.io/spec/index.html
>
> but the UEFI specification does not use this terminology.

Then I'm confused as to what this is:

https://uefi.org/specs/PI/1.8/index.html

Rob
