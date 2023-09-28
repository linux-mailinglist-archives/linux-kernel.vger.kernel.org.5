Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0ED7B1218
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 07:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjI1F3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 01:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1F3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 01:29:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD2098;
        Wed, 27 Sep 2023 22:29:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BB8C433CA;
        Thu, 28 Sep 2023 05:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695878958;
        bh=5boNtUVXoBezK9qrfar7T1jFAW/Qiscp5SjTTLfehhk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qpYevJdrmaraBa1IyayVVw441Xc4/eTxuTmlpAmlKqLfyxn3TGC9PNVINhnSUT8MQ
         67xaoX5zyVBFK8kPJ7lXoyKhaChN0XURIzfBrfMfx0IRNG7Yj0stPN2TS50OFWyKEA
         hO7j3LlbCfx6WjuqRYRFPI3fkosbVWa1KVdCZEccrP4DRRLpsBcYZyzLXJ1EDQ/yIi
         yQRTg9adBsCRuZTOsJBPa4797QVl5IAU/ffCQrBBo0mk0JyrLKTbWeY79iYP3sa1M7
         8TTPSulijGJFI/SAtQBugNskVFkIWbW6bO9eBQso7lPzwPGHb5fOyhaLX0EnG4qNNV
         /eogUg65/EQSg==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-59bebd5bdadso156978767b3.0;
        Wed, 27 Sep 2023 22:29:18 -0700 (PDT)
X-Gm-Message-State: AOJu0YxEfUhY1jPrHldhqDg+PJST+P0C85LUyG2Lu2Kjnrqbe+8WineY
        0eBTx9M6cazohwBy/kxm7zRBW/+CKl0whWF/hy8=
X-Google-Smtp-Source: AGHT+IH+lJQAsQ16d51/ZVB/Z75rTRuHBRY2hyoV/jwea6Pv3AG487NEXQNi3VK6LtTFqdy8NWkNn4ODuJyFgshD5HQ=
X-Received: by 2002:a81:53c2:0:b0:59a:f131:50fa with SMTP id
 h185-20020a8153c2000000b0059af13150famr215091ywb.47.1695878957842; Wed, 27
 Sep 2023 22:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <SEYPR03MB704641091854162959578D7E9AFFA@SEYPR03MB7046.apcprd03.prod.outlook.com>
 <CA+VMnFyhp9D8cjtvLVzdKGETouOuH=MKgjOu1pn00WDRB=5oUg@mail.gmail.com>
 <CAFCwf12sUL5bcXhYKwRkMxLtSDtLfTK003oxkRDVmThx1ARV-A@mail.gmail.com>
 <SEYPR03MB70462A385A52A317427E93B59AFCA@SEYPR03MB7046.apcprd03.prod.outlook.com>
 <CAFCwf11hxBpg3T6MoVrL0GaOD_=xB+-dWeEtDH0cCyzyQ-q1tg@mail.gmail.com> <SEYPR03MB70463AEED951A0E2C18481099AC2A@SEYPR03MB7046.apcprd03.prod.outlook.com>
In-Reply-To: <SEYPR03MB70463AEED951A0E2C18481099AC2A@SEYPR03MB7046.apcprd03.prod.outlook.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Thu, 28 Sep 2023 08:28:51 +0300
X-Gmail-Original-Message-ID: <CAFCwf13ZiYYoXE+S_wQ_EhjiACPGJGT+70_stwpY_=aD=VYa4A@mail.gmail.com>
Message-ID: <CAFCwf13ZiYYoXE+S_wQ_EhjiACPGJGT+70_stwpY_=aD=VYa4A@mail.gmail.com>
Subject: Re: kernel.org 6.5.4 , NPU driver, --not support (RFC)
To:     Cancan Chang <Cancan.Chang@amlogic.com>
Cc:     Jagan Teki <jagan@edgeble.ai>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 10:01=E2=80=AFAM Cancan Chang <Cancan.Chang@amlogic=
.com> wrote:
>
> =E2=80=9COr do you handle one cmd at a time, where the user sends a cmd b=
uffer
> to the driver and the driver then submit it by writing to a couple of
> registers and polls on some status register until its done, or waits
> for an interrupt to mark it as done ?=E2=80=9D
>   --- yes=EF=BC=8C user sends a cmd buffer to driver, and driver triggers=
 hardware by writing to register,
>         and then, waits for an interrupt to mark it  as done.
>
>     My current driver is very different from drm, so I want to know if I =
have to switch to drm=EF=BC=9F
Could you please post a link to the driver's source code ?
In addition, could you please elaborate which userspace libraries
exists that work with your driver ? Are any of them open-source ?

>     Maybe I can refer to /driver/accel/habanalabs.
That's definitely a possibility.

Oded
>
> thanks
>
> ________________________________________
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Oded Gabbay <ogabbay@kernel.org>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2023=E5=B9=B49=E6=9C=8826=E6=97=A5 =
20:54
> =E6=94=B6=E4=BB=B6=E4=BA=BA: Cancan Chang
> =E6=8A=84=E9=80=81: Jagan Teki; linux-media; linux-kernel; Dave Airlie; D=
aniel Vetter
> =E4=B8=BB=E9=A2=98: Re: kernel.org 6.5.4 , NPU driver, --not support (RFC=
)
>
> [ EXTERNAL EMAIL ]
>
> On Mon, Sep 25, 2023 at 12:29=E2=80=AFPM Cancan Chang <Cancan.Chang@amlog=
ic.com> wrote:
> >
> > Thank you for your reply from Jagan & Oded.
> >
> > It is very appropritate for my driver to be placed in driver/accel.
> >
> > My accelerator is named ADLA(Amlogic Deep Learning Accelerator).
> > It is an IP in SOC,mainly used for neural network models acceleration.
> > It will split and compile the neural network model into a private forma=
t cmd buffer,
> > and submit this cmd buffer to ADLA hardware. It is not programmable dev=
ice.
> What exactly does it mean to "submit this cmd buffer to ADLA hardware" ?
>
> Does your h/w provides queues for the user/driver to put their
> workloads/cmd-bufs on them ? And does it provide some completion queue
> to notify when the work is completed?
>
> Or do you handle one cmd at a time, where the user sends a cmd buffer
> to the driver and the driver then submit it by writing to a couple of
> registers and polls on some status register until its done, or waits
> for an interrupt to mark it as done ?
>
> >
> > ADLA includes four hardware engines:
> > RS engines             : working for the reshape operators
> > MAC engines         : working for the convolution operators
> > DW engines           : working for the planer & Elementwise operators
> > Activation engines : working for activation operators(ReLu,tanh..)
> >
> > By the way, my IP is mainly used for SOC, and the current driver regist=
ration is through the platform_driver,
> > is it necessary to switch to drm?
> This probably depends on the answer to my question above. btw, there
> are drivers in drm that handle IPs that are part of an SOC, so
> platform_driver is supported.
>
> Oded
>
> >
> > thanks.
> >
> > ________________________________________
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Oded Gabbay <ogabbay@kernel.org>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2023=E5=B9=B49=E6=9C=8822=E6=97=
=A5 23:08
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Jagan Teki
> > =E6=8A=84=E9=80=81: Cancan Chang; linux-media; linux-kernel; Dave Airli=
e; Daniel Vetter
> > =E4=B8=BB=E9=A2=98: Re: kernel.org 6.5.4 , NPU driver, --not support (R=
FC)
> >
> > [=E4=BD=A0=E9=80=9A=E5=B8=B8=E4=B8=8D=E4=BC=9A=E6=94=B6=E5=88=B0=E6=9D=
=A5=E8=87=AA ogabbay@kernel.org =E7=9A=84=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=
=B6=E3=80=82=E8=AF=B7=E8=AE=BF=E9=97=AE https://aka.ms/LearnAboutSenderIden=
tification=EF=BC=8C=E4=BB=A5=E4=BA=86=E8=A7=A3=E8=BF=99=E4=B8=80=E7=82=B9=
=E4=B8=BA=E4=BB=80=E4=B9=88=E5=BE=88=E9=87=8D=E8=A6=81]
> >
> > [ EXTERNAL EMAIL ]
> >
> > On Fri, Sep 22, 2023 at 12:38=E2=80=AFPM Jagan Teki <jagan@edgeble.ai> =
wrote:
> > >
> > > On Fri, 22 Sept 2023 at 15:04, Cancan Chang <Cancan.Chang@amlogic.com=
> wrote:
> > > >
> > > > Dear Media Maintainers:
> > > >      Thanks for your attention. Before describing my problem=EF=BC=
=8Clet me introduce to you what I  mean by NPU.
> > > >      NPU is Neural Processing Unit, It is designed for deep learnin=
g acceleration, It is also called TPU, APU ..
> > > >
> > > >      The real problems:
> > > >       When I was about to upstream my NPU driver codes to linux mai=
nline, i meet two problems:
> > > >         1.  According to my research, There is no NPU module path i=
n the linux (base on linux 6.5.4) , I have searched all linux projects and =
found no organization or comany that has submitted NPU code. Is there a pat=
h prepared for NPU driver currently?
> > > >         2.   If there is no NPU driver path currently, I am going t=
o put my NPU driver code in the drivers/media/platform/amlogic/ =EF=BB=BF, =
because my NPU driver belongs to amlogic. and amlogic NPU is mainly used fo=
r AI vision applications. Is this plan suitabe for you?
> > >
> > > If I'm correct about the discussion with Oded Gabby before. I think
> > > the drivers/accel/ is proper for AI Accelerators including NPU.
> > >
> > > + Oded in case he can comment.
> > >
> > > Thanks,
> > > Jagan.
> > Thanks Jagan for adding me to this thread. Adding Dave & Daniel as well=
.
> >
> > Indeed, the drivers/accel is the place for Accelerators, mainly for
> > AI/Deep-Learning accelerators.
> > We currently have 3 drivers there already.
> >
> > The accel subsystem is part of the larger drm subsystem. Basically, to
> > get into accel, you need to integrate your driver with the drm at the
> > basic level (registering a device, hooking up with the proper
> > callbacks). ofc the more you use code from drm, the better.
> > You can take a look at the drivers under accel for some examples on
> > how to do that.
> >
> > Could you please describe in a couple of sentences what your
> > accelerator does, which engines it contains, how you program it. i.e.
> > Is it a fixed-function device where you write to a couple of registers
> > to execute workloads, or is it a fully programmable device where you
> > load compiled code into it (GPU style) ?
> >
> > For better background on the accel subsystem, please read the following=
:
> > https://docs.kernel.org/accel/introduction.html
> > This introduction also contains links to other important email threads
> > and to Dave Airlie's BOF summary in LPC2022.
> >
> > Thanks,
> > Oded
