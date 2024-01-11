Return-Path: <linux-kernel+bounces-23181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 951D182A8B7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C226283026
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBEBE55F;
	Thu, 11 Jan 2024 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="e6bo09kf"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95872DF78
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5f68af028afso43744467b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 00:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1704960254; x=1705565054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQncb391kWdT9kycBYQWZOv9Cd1CkvyWqEu5gVDzVD8=;
        b=e6bo09kffWbAuJwUdo/eokYpucqGlyHlajQr+0ngUAbJHA/M5zYPNg69btP2PkiS+B
         q8iYxrw/LL4psGJF46D35zsPc6JKxU7acBZa0FS0NunLSZvkcX4Lcf2GuxHQ8fbMkKOA
         DcT/Qk567hcgSNIjkmb5YWzmwQlJGsWTcMbAyJM0nZZksFL8gQZfr2zia8ACbbAa6JVG
         qs4LNTR8shWF8gKsU5Lh7lAvCGFwaI/LFVe3H5WsyJbTdCGwLZF632rM2nZQrpI1sAsX
         TuNqeRV54ob3K66xVCmrcTgTD5dJ3nNCOyoz3CAjrQ9xG9IzmKUvGiccg6jsrq5nsddx
         b30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704960254; x=1705565054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQncb391kWdT9kycBYQWZOv9Cd1CkvyWqEu5gVDzVD8=;
        b=V/ila09IGNZ4IUi9EB+SPdO+y7vE1riAYhCBBa0Z1kotRnv2h6VPrgeQrR0C6xsCRc
         eYMsIibuM6NMxD4pHyWyRA8/UstVeJbR9uwIobgCAMVxV3sf5l7X0J5rNLXnXuVPBB7l
         qQcRTYSZvut+hOxUmo60xsQrhAN+Wzse9eAUaYo7mOl4K+TLvMOIv+1hsD0iQz6VWCSk
         vpYsHtfp0nxmfXF8XHHYrzTvSWcAZxbae7pHdefUSDzVLffUspeAWgdrg8gNOzZfCoHl
         vU1QUBvPnEZR8EWgYXVUUuydjG0XxNdhd5Vw/yorUly/s5YDhTSxS8eltbqsEXRmfU1R
         jOxg==
X-Gm-Message-State: AOJu0YzhIqmfX+kNpVh1F6mFAS3yg514rC8XVfAs/NCpGPj/6sCA6/iK
	JJFCyNTsetJbPpLNTcZkERhDQ9egOlBsonsuVV44l61OLFhyng==
X-Google-Smtp-Source: AGHT+IGw8Anvnwhd6esANRM5i2hYc1+o0EUSI84bS2doe8GctqVUDHhegCXm2GV0LA+Gvkm5ZwOpTQ==
X-Received: by 2002:a05:690c:a16:b0:5e9:9e43:2038 with SMTP id cg22-20020a05690c0a1600b005e99e432038mr179894ywb.44.1704960254355;
        Thu, 11 Jan 2024 00:04:14 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id ci24-20020a05690c0a9800b005f93cc31ff0sm218336ywb.72.2024.01.11.00.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 00:04:13 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dbed71baa91so3750044276.0;
        Thu, 11 Jan 2024 00:04:13 -0800 (PST)
X-Received: by 2002:a5b:907:0:b0:dbd:72cc:75d8 with SMTP id
 a7-20020a5b0907000000b00dbd72cc75d8mr619816ybq.71.1704960253641; Thu, 11 Jan
 2024 00:04:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SEYPR03MB704641091854162959578D7E9AFFA@SEYPR03MB7046.apcprd03.prod.outlook.com>
 <CA+VMnFyhp9D8cjtvLVzdKGETouOuH=MKgjOu1pn00WDRB=5oUg@mail.gmail.com>
 <CAFCwf12sUL5bcXhYKwRkMxLtSDtLfTK003oxkRDVmThx1ARV-A@mail.gmail.com>
 <SEYPR03MB70462A385A52A317427E93B59AFCA@SEYPR03MB7046.apcprd03.prod.outlook.com>
 <CAFCwf11hxBpg3T6MoVrL0GaOD_=xB+-dWeEtDH0cCyzyQ-q1tg@mail.gmail.com>
 <SEYPR03MB70463AEED951A0E2C18481099AC2A@SEYPR03MB7046.apcprd03.prod.outlook.com>
 <CAFCwf13ZiYYoXE+S_wQ_EhjiACPGJGT+70_stwpY_=aD=VYa4A@mail.gmail.com>
 <SEYPR03MB704690FD9116A31D6FBCF32A9AC1A@SEYPR03MB7046.apcprd03.prod.outlook.com>
 <CAFCwf128vYZ+EGHvZD0_ND2CGBzwMKk6OyhVRW_z=xCOSmi47w@mail.gmail.com>
 <SEYPR03MB7046F74834B7D789C2DD4E459AC1A@SEYPR03MB7046.apcprd03.prod.outlook.com>
 <CAFCwf10HAi+HEEWy=C4395eaHh_iSmcW1v87A+1J8QN9_P7tUQ@mail.gmail.com> <SEYPR03MB704698F40D90FF6B50D72AC39AC8A@SEYPR03MB7046.apcprd03.prod.outlook.com>
In-Reply-To: <SEYPR03MB704698F40D90FF6B50D72AC39AC8A@SEYPR03MB7046.apcprd03.prod.outlook.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Thu, 11 Jan 2024 09:04:02 +0100
X-Gmail-Original-Message-ID: <CAAObsKBpD3D76_ugTYDT8p-Fhb6zXOmQQP0yb7qj9jK+=JrqgA@mail.gmail.com>
Message-ID: <CAAObsKBpD3D76_ugTYDT8p-Fhb6zXOmQQP0yb7qj9jK+=JrqgA@mail.gmail.com>
Subject: Re: kernel.org 6.5.4 , NPU driver, --not support (RFC)
To: Cancan Chang <Cancan.Chang@amlogic.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jagan Teki <jagan@edgeble.ai>, 
	linux-media <linux-media@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oded,

Out of curiosity, did you end up taking a look at Amlogic's driver?

Cheers,

Tomeu

On Sat, Oct 7, 2023 at 8:37=E2=80=AFAM Cancan Chang <Cancan.Chang@amlogic.c=
om> wrote:
>
> Oded,
>        You can get the driver code from  github link=EF=BC=9A https://git=
hub.com/OldDaddy9/driver
>         e.g.  git clone https://github.com/OldDaddy9/driver.git
>
> ________________________________________
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Oded Gabbay <ogabbay@kernel.org>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2023=E5=B9=B410=E6=9C=883=E6=97=A5 =
18:52
> =E6=94=B6=E4=BB=B6=E4=BA=BA: Cancan Chang
> =E6=8A=84=E9=80=81: Jagan Teki; linux-media; linux-kernel; Dave Airlie; D=
aniel Vetter
> =E4=B8=BB=E9=A2=98: Re: kernel.org 6.5.4 , NPU driver, --not support (RFC=
)
>
> [ EXTERNAL EMAIL ]
>
> On Thu, Sep 28, 2023 at 11:16=E2=80=AFAM Cancan Chang <Cancan.Chang@amlog=
ic.com> wrote:
> >
> > =E2=80=9CWhat happens if you call this again without waiting for the pr=
evious
> > inference to complete ?=E2=80=9D
> >    --- There is a work-queue in the driver to manage inference tasks.
> >          When two consecutive inference tasks occur, the second inferen=
ce task will be add to
> >          the "pending list". While the previous inference task ends, th=
e second inference task will
> >          switch to the "scheduled list", and be executed.
> >          Each inference task has an id,  "inferece" and "wait until fin=
ish" are paired.
> >
> >          thanks
> Thanks for the clarification.
> I'll wait for your driver's code link. It doesn't have to be a patch
> series at this point. A link to a git repo is enough.
> I just want to do a quick pass.
>
> Thanks,
> Oded
>
>
>
> >
> > ________________________________________
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Oded Gabbay <ogabbay@kernel.org>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2023=E5=B9=B49=E6=9C=8828=E6=97=
=A5 15:40
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Cancan Chang
> > =E6=8A=84=E9=80=81: Jagan Teki; linux-media; linux-kernel; Dave Airlie;=
 Daniel Vetter
> > =E4=B8=BB=E9=A2=98: Re: kernel.org 6.5.4 , NPU driver, --not support (R=
FC)
> >
> > [ EXTERNAL EMAIL ]
> >
> > On Thu, Sep 28, 2023 at 10:25=E2=80=AFAM Cancan Chang <Cancan.Chang@aml=
ogic.com> wrote:
> > >
> > > =E2=80=9CCould you please post a link to the driver's source code ?
> > > In addition, could you please elaborate which userspace libraries
> > > exists that work with your driver ? Are any of them open-source ?=E2=
=80=9D
> > > --- We will prepare the adla driver link after the holiday on October=
 6th.
> > >      It's a pity that there is no open-source userspace library.
> > >      But you can probably understand it through a workflow, which can=
 be simplified as:
> > >      1. create model context
> > >           ret =3D ioctl(context->fd, ADLAK_IOCTL_REGISTER_NETWORK, &d=
esc);
> > >      2.  set inputs
> > >      3.  inference
> > >            ret =3D ioctl(context->fd, ADLAK_IOCTL_INVOKE, &invoke_dec=
);
> > What happens if you call this again without waiting for the previous
> > inference to complete ?
> > Oded
> > >      4.  wait for the inference to complete
> > >            ret =3D ioctl(context->fd, ADLAK_IOCTL_WAIT_UNTIL_FINISH, =
&stat_req_desc);
> > >      5.  destroy model context
> > >            ret =3D ioctl(context->fd, ADLAK_IOCTL_DESTROY_NETWORK, &s=
ubmit_del);
> > >
> > >
> > >       thanks
> > >
> > >
> > > ________________________________________
> > > =E5=8F=91=E4=BB=B6=E4=BA=BA: Oded Gabbay <ogabbay@kernel.org>
> > > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2023=E5=B9=B49=E6=9C=8828=E6=97=
=A5 13:28
> > > =E6=94=B6=E4=BB=B6=E4=BA=BA: Cancan Chang
> > > =E6=8A=84=E9=80=81: Jagan Teki; linux-media; linux-kernel; Dave Airli=
e; Daniel Vetter
> > > =E4=B8=BB=E9=A2=98: Re: kernel.org 6.5.4 , NPU driver, --not support =
(RFC)
> > >
> > > [ EXTERNAL EMAIL ]
> > >
> > > On Wed, Sep 27, 2023 at 10:01=E2=80=AFAM Cancan Chang <Cancan.Chang@a=
mlogic.com> wrote:
> > > >
> > > > =E2=80=9COr do you handle one cmd at a time, where the user sends a=
 cmd buffer
> > > > to the driver and the driver then submit it by writing to a couple =
of
> > > > registers and polls on some status register until its done, or wait=
s
> > > > for an interrupt to mark it as done ?=E2=80=9D
> > > >   --- yes=EF=BC=8C user sends a cmd buffer to driver, and driver tr=
iggers hardware by writing to register,
> > > >         and then, waits for an interrupt to mark it  as done.
> > > >
> > > >     My current driver is very different from drm, so I want to know=
 if I have to switch to drm=EF=BC=9F
> > > Could you please post a link to the driver's source code ?
> > > In addition, could you please elaborate which userspace libraries
> > > exists that work with your driver ? Are any of them open-source ?
> > >
> > > >     Maybe I can refer to /driver/accel/habanalabs.
> > > That's definitely a possibility.
> > >
> > > Oded
> > > >
> > > > thanks
> > > >
> > > > ________________________________________
> > > > =E5=8F=91=E4=BB=B6=E4=BA=BA: Oded Gabbay <ogabbay@kernel.org>
> > > > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2023=E5=B9=B49=E6=9C=8826=E6=
=97=A5 20:54
> > > > =E6=94=B6=E4=BB=B6=E4=BA=BA: Cancan Chang
> > > > =E6=8A=84=E9=80=81: Jagan Teki; linux-media; linux-kernel; Dave Air=
lie; Daniel Vetter
> > > > =E4=B8=BB=E9=A2=98: Re: kernel.org 6.5.4 , NPU driver, --not suppor=
t (RFC)
> > > >
> > > > [ EXTERNAL EMAIL ]
> > > >
> > > > On Mon, Sep 25, 2023 at 12:29=E2=80=AFPM Cancan Chang <Cancan.Chang=
@amlogic.com> wrote:
> > > > >
> > > > > Thank you for your reply from Jagan & Oded.
> > > > >
> > > > > It is very appropritate for my driver to be placed in driver/acce=
l.
> > > > >
> > > > > My accelerator is named ADLA(Amlogic Deep Learning Accelerator).
> > > > > It is an IP in SOC,mainly used for neural network models accelera=
tion.
> > > > > It will split and compile the neural network model into a private=
 format cmd buffer,
> > > > > and submit this cmd buffer to ADLA hardware. It is not programmab=
le device.
> > > > What exactly does it mean to "submit this cmd buffer to ADLA hardwa=
re" ?
> > > >
> > > > Does your h/w provides queues for the user/driver to put their
> > > > workloads/cmd-bufs on them ? And does it provide some completion qu=
eue
> > > > to notify when the work is completed?
> > > >
> > > > Or do you handle one cmd at a time, where the user sends a cmd buff=
er
> > > > to the driver and the driver then submit it by writing to a couple =
of
> > > > registers and polls on some status register until its done, or wait=
s
> > > > for an interrupt to mark it as done ?
> > > >
> > > > >
> > > > > ADLA includes four hardware engines:
> > > > > RS engines             : working for the reshape operators
> > > > > MAC engines         : working for the convolution operators
> > > > > DW engines           : working for the planer & Elementwise opera=
tors
> > > > > Activation engines : working for activation operators(ReLu,tanh..=
)
> > > > >
> > > > > By the way, my IP is mainly used for SOC, and the current driver =
registration is through the platform_driver,
> > > > > is it necessary to switch to drm?
> > > > This probably depends on the answer to my question above. btw, ther=
e
> > > > are drivers in drm that handle IPs that are part of an SOC, so
> > > > platform_driver is supported.
> > > >
> > > > Oded
> > > >
> > > > >
> > > > > thanks.
> > > > >
> > > > > ________________________________________
> > > > > =E5=8F=91=E4=BB=B6=E4=BA=BA: Oded Gabbay <ogabbay@kernel.org>
> > > > > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2023=E5=B9=B49=E6=9C=8822=
=E6=97=A5 23:08
> > > > > =E6=94=B6=E4=BB=B6=E4=BA=BA: Jagan Teki
> > > > > =E6=8A=84=E9=80=81: Cancan Chang; linux-media; linux-kernel; Dave=
 Airlie; Daniel Vetter
> > > > > =E4=B8=BB=E9=A2=98: Re: kernel.org 6.5.4 , NPU driver, --not supp=
ort (RFC)
> > > > >
> > > > > [=E4=BD=A0=E9=80=9A=E5=B8=B8=E4=B8=8D=E4=BC=9A=E6=94=B6=E5=88=B0=
=E6=9D=A5=E8=87=AA ogabbay@kernel.org =E7=9A=84=E7=94=B5=E5=AD=90=E9=82=AE=
=E4=BB=B6=E3=80=82=E8=AF=B7=E8=AE=BF=E9=97=AE https://aka.ms/LearnAboutSend=
erIdentification=EF=BC=8C=E4=BB=A5=E4=BA=86=E8=A7=A3=E8=BF=99=E4=B8=80=E7=
=82=B9=E4=B8=BA=E4=BB=80=E4=B9=88=E5=BE=88=E9=87=8D=E8=A6=81]
> > > > >
> > > > > [ EXTERNAL EMAIL ]
> > > > >
> > > > > On Fri, Sep 22, 2023 at 12:38=E2=80=AFPM Jagan Teki <jagan@edgebl=
e.ai> wrote:
> > > > > >
> > > > > > On Fri, 22 Sept 2023 at 15:04, Cancan Chang <Cancan.Chang@amlog=
ic.com> wrote:
> > > > > > >
> > > > > > > Dear Media Maintainers:
> > > > > > >      Thanks for your attention. Before describing my problem=
=EF=BC=8Clet me introduce to you what I  mean by NPU.
> > > > > > >      NPU is Neural Processing Unit, It is designed for deep l=
earning acceleration, It is also called TPU, APU ..
> > > > > > >
> > > > > > >      The real problems:
> > > > > > >       When I was about to upstream my NPU driver codes to lin=
ux mainline, i meet two problems:
> > > > > > >         1.  According to my research, There is no NPU module =
path in the linux (base on linux 6.5.4) , I have searched all linux project=
s and found no organization or comany that has submitted NPU code. Is there=
 a path prepared for NPU driver currently?
> > > > > > >         2.   If there is no NPU driver path currently, I am g=
oing to put my NPU driver code in the drivers/media/platform/amlogic/ =EF=
=BB=BF, because my NPU driver belongs to amlogic. and amlogic NPU is mainly=
 used for AI vision applications. Is this plan suitabe for you?
> > > > > >
> > > > > > If I'm correct about the discussion with Oded Gabby before. I t=
hink
> > > > > > the drivers/accel/ is proper for AI Accelerators including NPU.
> > > > > >
> > > > > > + Oded in case he can comment.
> > > > > >
> > > > > > Thanks,
> > > > > > Jagan.
> > > > > Thanks Jagan for adding me to this thread. Adding Dave & Daniel a=
s well.
> > > > >
> > > > > Indeed, the drivers/accel is the place for Accelerators, mainly f=
or
> > > > > AI/Deep-Learning accelerators.
> > > > > We currently have 3 drivers there already.
> > > > >
> > > > > The accel subsystem is part of the larger drm subsystem. Basicall=
y, to
> > > > > get into accel, you need to integrate your driver with the drm at=
 the
> > > > > basic level (registering a device, hooking up with the proper
> > > > > callbacks). ofc the more you use code from drm, the better.
> > > > > You can take a look at the drivers under accel for some examples =
on
> > > > > how to do that.
> > > > >
> > > > > Could you please describe in a couple of sentences what your
> > > > > accelerator does, which engines it contains, how you program it. =
i.e.
> > > > > Is it a fixed-function device where you write to a couple of regi=
sters
> > > > > to execute workloads, or is it a fully programmable device where =
you
> > > > > load compiled code into it (GPU style) ?
> > > > >
> > > > > For better background on the accel subsystem, please read the fol=
lowing:
> > > > > https://docs.kernel.org/accel/introduction.html
> > > > > This introduction also contains links to other important email th=
reads
> > > > > and to Dave Airlie's BOF summary in LPC2022.
> > > > >
> > > > > Thanks,
> > > > > Oded

