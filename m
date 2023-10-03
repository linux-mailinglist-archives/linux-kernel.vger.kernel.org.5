Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117437B66CC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239698AbjJCKx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjJCKx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:53:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0AAAC;
        Tue,  3 Oct 2023 03:53:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86458C433C9;
        Tue,  3 Oct 2023 10:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696330403;
        bh=7d34zM3dSi1EmvJgpJwjtxHg10NsCJyhiek6+F843Y8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EQkQHDTWT6z/gaHpgwuStT/S52T8Nf29hPQfCJKSE2XJbSh/Ogui1YytZKzCtp+pj
         hFNwP/3NfIErcPYeZLgMPUXOSM0LieiWUTTRRdbv2t479UsM7KQaN5JwVj3Y4psTrl
         3vv/YvkSB+zhumtPcoRaNQVsch+QZuxiszfRnvUSd7zmJe0bbEyplLW6QF5fzEH9Ef
         K/oVVp3cHe9UOoL3F9vNLFxk2+j1R+KyQ7EFUyobNXBjrBehiuj2+DZ+nzjQvq1xko
         lAbRDroglCpBQpE+Q8r3rkx60q7rN9zcGUvFk6so4sTTWoF1VhaLXYA9kGOYEiL9AV
         kUd0WjV4h9dbw==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5a1d0fee86aso9389107b3.2;
        Tue, 03 Oct 2023 03:53:23 -0700 (PDT)
X-Gm-Message-State: AOJu0YysggT8ssBDVcsDXLS2a8b3BzFtBC9QnGt59Dvpff/y8V8xj+Yq
        1vzhcWwr3BQi3X00bX/ajFKbvr+h72IkhMDz7y4=
X-Google-Smtp-Source: AGHT+IF2TuEXNqjyoHzZJGiFNKYpH2AwuP2gHprrQtMQX2U5OKpI9sE1JlSk05NcXqJediHv3nKNXAV+lZv4RAW+0sg=
X-Received: by 2002:a81:4f88:0:b0:5a1:cc37:7c91 with SMTP id
 d130-20020a814f88000000b005a1cc377c91mr15138418ywb.19.1696330402461; Tue, 03
 Oct 2023 03:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <SEYPR03MB704641091854162959578D7E9AFFA@SEYPR03MB7046.apcprd03.prod.outlook.com>
 <CA+VMnFyhp9D8cjtvLVzdKGETouOuH=MKgjOu1pn00WDRB=5oUg@mail.gmail.com>
 <CAFCwf12sUL5bcXhYKwRkMxLtSDtLfTK003oxkRDVmThx1ARV-A@mail.gmail.com>
 <SEYPR03MB70462A385A52A317427E93B59AFCA@SEYPR03MB7046.apcprd03.prod.outlook.com>
 <CAFCwf11hxBpg3T6MoVrL0GaOD_=xB+-dWeEtDH0cCyzyQ-q1tg@mail.gmail.com>
 <SEYPR03MB70463AEED951A0E2C18481099AC2A@SEYPR03MB7046.apcprd03.prod.outlook.com>
 <CAFCwf13ZiYYoXE+S_wQ_EhjiACPGJGT+70_stwpY_=aD=VYa4A@mail.gmail.com>
 <SEYPR03MB704690FD9116A31D6FBCF32A9AC1A@SEYPR03MB7046.apcprd03.prod.outlook.com>
 <CAFCwf128vYZ+EGHvZD0_ND2CGBzwMKk6OyhVRW_z=xCOSmi47w@mail.gmail.com> <SEYPR03MB7046F74834B7D789C2DD4E459AC1A@SEYPR03MB7046.apcprd03.prod.outlook.com>
In-Reply-To: <SEYPR03MB7046F74834B7D789C2DD4E459AC1A@SEYPR03MB7046.apcprd03.prod.outlook.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Tue, 3 Oct 2023 13:52:56 +0300
X-Gmail-Original-Message-ID: <CAFCwf10HAi+HEEWy=C4395eaHh_iSmcW1v87A+1J8QN9_P7tUQ@mail.gmail.com>
Message-ID: <CAFCwf10HAi+HEEWy=C4395eaHh_iSmcW1v87A+1J8QN9_P7tUQ@mail.gmail.com>
Subject: Re: kernel.org 6.5.4 , NPU driver, --not support (RFC)
To:     Cancan Chang <Cancan.Chang@amlogic.com>
Cc:     Jagan Teki <jagan@edgeble.ai>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 11:16=E2=80=AFAM Cancan Chang <Cancan.Chang@amlogic=
.com> wrote:
>
> =E2=80=9CWhat happens if you call this again without waiting for the prev=
ious
> inference to complete ?=E2=80=9D
>    --- There is a work-queue in the driver to manage inference tasks.
>          When two consecutive inference tasks occur, the second inference=
 task will be add to
>          the "pending list". While the previous inference task ends, the =
second inference task will
>          switch to the "scheduled list", and be executed.
>          Each inference task has an id,  "inferece" and "wait until finis=
h" are paired.
>
>          thanks
Thanks for the clarification.
I'll wait for your driver's code link. It doesn't have to be a patch
series at this point. A link to a git repo is enough.
I just want to do a quick pass.

Thanks,
Oded



>
> ________________________________________
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Oded Gabbay <ogabbay@kernel.org>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2023=E5=B9=B49=E6=9C=8828=E6=97=A5 =
15:40
> =E6=94=B6=E4=BB=B6=E4=BA=BA: Cancan Chang
> =E6=8A=84=E9=80=81: Jagan Teki; linux-media; linux-kernel; Dave Airlie; D=
aniel Vetter
> =E4=B8=BB=E9=A2=98: Re: kernel.org 6.5.4 , NPU driver, --not support (RFC=
)
>
> [ EXTERNAL EMAIL ]
>
> On Thu, Sep 28, 2023 at 10:25=E2=80=AFAM Cancan Chang <Cancan.Chang@amlog=
ic.com> wrote:
> >
> > =E2=80=9CCould you please post a link to the driver's source code ?
> > In addition, could you please elaborate which userspace libraries
> > exists that work with your driver ? Are any of them open-source ?=E2=80=
=9D
> > --- We will prepare the adla driver link after the holiday on October 6=
th.
> >      It's a pity that there is no open-source userspace library.
> >      But you can probably understand it through a workflow, which can b=
e simplified as:
> >      1. create model context
> >           ret =3D ioctl(context->fd, ADLAK_IOCTL_REGISTER_NETWORK, &des=
c);
> >      2.  set inputs
> >      3.  inference
> >            ret =3D ioctl(context->fd, ADLAK_IOCTL_INVOKE, &invoke_dec);
> What happens if you call this again without waiting for the previous
> inference to complete ?
> Oded
> >      4.  wait for the inference to complete
> >            ret =3D ioctl(context->fd, ADLAK_IOCTL_WAIT_UNTIL_FINISH, &s=
tat_req_desc);
> >      5.  destroy model context
> >            ret =3D ioctl(context->fd, ADLAK_IOCTL_DESTROY_NETWORK, &sub=
mit_del);
> >
> >
> >       thanks
> >
> >
> > ________________________________________
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Oded Gabbay <ogabbay@kernel.org>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2023=E5=B9=B49=E6=9C=8828=E6=97=
=A5 13:28
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Cancan Chang
> > =E6=8A=84=E9=80=81: Jagan Teki; linux-media; linux-kernel; Dave Airlie;=
 Daniel Vetter
> > =E4=B8=BB=E9=A2=98: Re: kernel.org 6.5.4 , NPU driver, --not support (R=
FC)
> >
> > [ EXTERNAL EMAIL ]
> >
> > On Wed, Sep 27, 2023 at 10:01=E2=80=AFAM Cancan Chang <Cancan.Chang@aml=
ogic.com> wrote:
> > >
> > > =E2=80=9COr do you handle one cmd at a time, where the user sends a c=
md buffer
> > > to the driver and the driver then submit it by writing to a couple of
> > > registers and polls on some status register until its done, or waits
> > > for an interrupt to mark it as done ?=E2=80=9D
> > >   --- yes=EF=BC=8C user sends a cmd buffer to driver, and driver trig=
gers hardware by writing to register,
> > >         and then, waits for an interrupt to mark it  as done.
> > >
> > >     My current driver is very different from drm, so I want to know i=
f I have to switch to drm=EF=BC=9F
> > Could you please post a link to the driver's source code ?
> > In addition, could you please elaborate which userspace libraries
> > exists that work with your driver ? Are any of them open-source ?
> >
> > >     Maybe I can refer to /driver/accel/habanalabs.
> > That's definitely a possibility.
> >
> > Oded
> > >
> > > thanks
> > >
> > > ________________________________________
> > > =E5=8F=91=E4=BB=B6=E4=BA=BA: Oded Gabbay <ogabbay@kernel.org>
> > > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2023=E5=B9=B49=E6=9C=8826=E6=97=
=A5 20:54
> > > =E6=94=B6=E4=BB=B6=E4=BA=BA: Cancan Chang
> > > =E6=8A=84=E9=80=81: Jagan Teki; linux-media; linux-kernel; Dave Airli=
e; Daniel Vetter
> > > =E4=B8=BB=E9=A2=98: Re: kernel.org 6.5.4 , NPU driver, --not support =
(RFC)
> > >
> > > [ EXTERNAL EMAIL ]
> > >
> > > On Mon, Sep 25, 2023 at 12:29=E2=80=AFPM Cancan Chang <Cancan.Chang@a=
mlogic.com> wrote:
> > > >
> > > > Thank you for your reply from Jagan & Oded.
> > > >
> > > > It is very appropritate for my driver to be placed in driver/accel.
> > > >
> > > > My accelerator is named ADLA(Amlogic Deep Learning Accelerator).
> > > > It is an IP in SOC,mainly used for neural network models accelerati=
on.
> > > > It will split and compile the neural network model into a private f=
ormat cmd buffer,
> > > > and submit this cmd buffer to ADLA hardware. It is not programmable=
 device.
> > > What exactly does it mean to "submit this cmd buffer to ADLA hardware=
" ?
> > >
> > > Does your h/w provides queues for the user/driver to put their
> > > workloads/cmd-bufs on them ? And does it provide some completion queu=
e
> > > to notify when the work is completed?
> > >
> > > Or do you handle one cmd at a time, where the user sends a cmd buffer
> > > to the driver and the driver then submit it by writing to a couple of
> > > registers and polls on some status register until its done, or waits
> > > for an interrupt to mark it as done ?
> > >
> > > >
> > > > ADLA includes four hardware engines:
> > > > RS engines             : working for the reshape operators
> > > > MAC engines         : working for the convolution operators
> > > > DW engines           : working for the planer & Elementwise operato=
rs
> > > > Activation engines : working for activation operators(ReLu,tanh..)
> > > >
> > > > By the way, my IP is mainly used for SOC, and the current driver re=
gistration is through the platform_driver,
> > > > is it necessary to switch to drm?
> > > This probably depends on the answer to my question above. btw, there
> > > are drivers in drm that handle IPs that are part of an SOC, so
> > > platform_driver is supported.
> > >
> > > Oded
> > >
> > > >
> > > > thanks.
> > > >
> > > > ________________________________________
> > > > =E5=8F=91=E4=BB=B6=E4=BA=BA: Oded Gabbay <ogabbay@kernel.org>
> > > > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2023=E5=B9=B49=E6=9C=8822=E6=
=97=A5 23:08
> > > > =E6=94=B6=E4=BB=B6=E4=BA=BA: Jagan Teki
> > > > =E6=8A=84=E9=80=81: Cancan Chang; linux-media; linux-kernel; Dave A=
irlie; Daniel Vetter
> > > > =E4=B8=BB=E9=A2=98: Re: kernel.org 6.5.4 , NPU driver, --not suppor=
t (RFC)
> > > >
> > > > [=E4=BD=A0=E9=80=9A=E5=B8=B8=E4=B8=8D=E4=BC=9A=E6=94=B6=E5=88=B0=E6=
=9D=A5=E8=87=AA ogabbay@kernel.org =E7=9A=84=E7=94=B5=E5=AD=90=E9=82=AE=E4=
=BB=B6=E3=80=82=E8=AF=B7=E8=AE=BF=E9=97=AE https://aka.ms/LearnAboutSenderI=
dentification=EF=BC=8C=E4=BB=A5=E4=BA=86=E8=A7=A3=E8=BF=99=E4=B8=80=E7=82=
=B9=E4=B8=BA=E4=BB=80=E4=B9=88=E5=BE=88=E9=87=8D=E8=A6=81]
> > > >
> > > > [ EXTERNAL EMAIL ]
> > > >
> > > > On Fri, Sep 22, 2023 at 12:38=E2=80=AFPM Jagan Teki <jagan@edgeble.=
ai> wrote:
> > > > >
> > > > > On Fri, 22 Sept 2023 at 15:04, Cancan Chang <Cancan.Chang@amlogic=
.com> wrote:
> > > > > >
> > > > > > Dear Media Maintainers:
> > > > > >      Thanks for your attention. Before describing my problem=EF=
=BC=8Clet me introduce to you what I  mean by NPU.
> > > > > >      NPU is Neural Processing Unit, It is designed for deep lea=
rning acceleration, It is also called TPU, APU ..
> > > > > >
> > > > > >      The real problems:
> > > > > >       When I was about to upstream my NPU driver codes to linux=
 mainline, i meet two problems:
> > > > > >         1.  According to my research, There is no NPU module pa=
th in the linux (base on linux 6.5.4) , I have searched all linux projects =
and found no organization or comany that has submitted NPU code. Is there a=
 path prepared for NPU driver currently?
> > > > > >         2.   If there is no NPU driver path currently, I am goi=
ng to put my NPU driver code in the drivers/media/platform/amlogic/ =EF=BB=
=BF, because my NPU driver belongs to amlogic. and amlogic NPU is mainly us=
ed for AI vision applications. Is this plan suitabe for you?
> > > > >
> > > > > If I'm correct about the discussion with Oded Gabby before. I thi=
nk
> > > > > the drivers/accel/ is proper for AI Accelerators including NPU.
> > > > >
> > > > > + Oded in case he can comment.
> > > > >
> > > > > Thanks,
> > > > > Jagan.
> > > > Thanks Jagan for adding me to this thread. Adding Dave & Daniel as =
well.
> > > >
> > > > Indeed, the drivers/accel is the place for Accelerators, mainly for
> > > > AI/Deep-Learning accelerators.
> > > > We currently have 3 drivers there already.
> > > >
> > > > The accel subsystem is part of the larger drm subsystem. Basically,=
 to
> > > > get into accel, you need to integrate your driver with the drm at t=
he
> > > > basic level (registering a device, hooking up with the proper
> > > > callbacks). ofc the more you use code from drm, the better.
> > > > You can take a look at the drivers under accel for some examples on
> > > > how to do that.
> > > >
> > > > Could you please describe in a couple of sentences what your
> > > > accelerator does, which engines it contains, how you program it. i.=
e.
> > > > Is it a fixed-function device where you write to a couple of regist=
ers
> > > > to execute workloads, or is it a fully programmable device where yo=
u
> > > > load compiled code into it (GPU style) ?
> > > >
> > > > For better background on the accel subsystem, please read the follo=
wing:
> > > > https://docs.kernel.org/accel/introduction.html
> > > > This introduction also contains links to other important email thre=
ads
> > > > and to Dave Airlie's BOF summary in LPC2022.
> > > >
> > > > Thanks,
> > > > Oded
