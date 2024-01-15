Return-Path: <linux-kernel+bounces-25734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44BB82D516
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8144B207B1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1105163AE;
	Mon, 15 Jan 2024 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="eNOGAj4E"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A3D63AA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbd99c08cd6so6648277276.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 00:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1705307400; x=1705912200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aX5XgOO/eqYd3tRcUkQuXkO+wee+bTCTX9/vVUGYMGk=;
        b=eNOGAj4EF6RgBDWpXbNBt7UHjss24pCEVWv71mpRP7hchNCOY4vnHxLUzdrvVCeXYk
         +k6hOxoRrYnw9xRAQW2zijW4Xt89ovQGO7OFBAcVc7YTKmYA3QTx4yX1X89xD9M3wXLx
         33s3DWVKjGJJiuOe9n8fy7RT9Agvf71R4ksMY1tbrNqSPTS1X48c3WQtnBc9hXoI+6SA
         3ymJDILqETdUMrwNf6xwu7jcn3N5EpeSLGbJxkqjdj8u/MHQgSVG2/gPhyzdueiOvOGQ
         f1d5ygS8UJUfJLSQz9ftSiozKzb4SFjAB7f+6wO2ivuoCc2oSdx0ht8LfRb0cBxYtcBJ
         cqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705307400; x=1705912200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aX5XgOO/eqYd3tRcUkQuXkO+wee+bTCTX9/vVUGYMGk=;
        b=F8Gpet6zKmof1teUnUJHF4ADqOGdx2RSohcQ4qgwAYd/uWHBpHNEgvWoPUyEOhZAxq
         1xZqcfabqW+/oMrGEU241KDyJcGMPIE0zhGu1g9LA5Zw3QLpIOCmMO0Xjl5SgA5wN2No
         ziclcbmtWeq1dy/6dKiUPk0AbbNHTUiUBPj+heHNfhUYEfxqgAw/qQRnrE9dsoREj4Bx
         qM7jZxvwHsoGVoD7ejfaqa0D5aPr6yYFSngcfk8zbNNhcnd+xOfqNuPZ/vfZRoE1D4/w
         cioqebT1m/0fwOqERtYGWrr7CX9VCVHVJiVWN5F7LMjDS260MRDazITUAnSm0YMc5nUA
         Tt7w==
X-Gm-Message-State: AOJu0YyKVXKSSA3+nUVJgl1s8hR0JwzeTnwRp4MbP1Eo3a5I/FVkTq8L
	pN3cbU6Tp30Ni5LLuSgNZSaUO2VWR+0Xow==
X-Google-Smtp-Source: AGHT+IEb0Di7aCYFTZNW7v7L6RwS8kYArxZFWX4AAMQKR30xnby7AgYIM2GXPer8joAsSokWw5j/MQ==
X-Received: by 2002:a25:3628:0:b0:dbd:98d5:b0ba with SMTP id d40-20020a253628000000b00dbd98d5b0bamr2196838yba.129.1705307400097;
        Mon, 15 Jan 2024 00:30:00 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id bt6-20020a056902136600b00dbf4303e9cfsm3265551ybb.9.2024.01.15.00.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 00:29:59 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbed430ef5eso6616670276.1;
        Mon, 15 Jan 2024 00:29:59 -0800 (PST)
X-Received: by 2002:a05:6902:2008:b0:dbc:fb03:6ec with SMTP id
 dh8-20020a056902200800b00dbcfb0306ecmr2712467ybb.125.1705307399298; Mon, 15
 Jan 2024 00:29:59 -0800 (PST)
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
 <CAFCwf10HAi+HEEWy=C4395eaHh_iSmcW1v87A+1J8QN9_P7tUQ@mail.gmail.com>
 <SEYPR03MB704698F40D90FF6B50D72AC39AC8A@SEYPR03MB7046.apcprd03.prod.outlook.com>
 <CAAObsKBpD3D76_ugTYDT8p-Fhb6zXOmQQP0yb7qj9jK+=JrqgA@mail.gmail.com> <96719046-d391-42be-8abc-564c9c909b97@kernel.org>
In-Reply-To: <96719046-d391-42be-8abc-564c9c909b97@kernel.org>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Mon, 15 Jan 2024 09:29:47 +0100
X-Gmail-Original-Message-ID: <CAAObsKDegsjsUQAKWqLDU+jqzzuX2gzYv5wgqjP_u6MNLc3GMQ@mail.gmail.com>
Message-ID: <CAAObsKDegsjsUQAKWqLDU+jqzzuX2gzYv5wgqjP_u6MNLc3GMQ@mail.gmail.com>
Subject: Re: kernel.org 6.5.4 , NPU driver, --not support (RFC)
To: Oded Gabbay <ogabbay@kernel.org>
Cc: Cancan Chang <Cancan.Chang@amlogic.com>, Jagan Teki <jagan@edgeble.ai>, 
	linux-media <linux-media@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 2:14=E2=80=AFPM Oded Gabbay <ogabbay@kernel.org> wr=
ote:
>
> On 11/01/2024 10:04, Tomeu Vizoso wrote:
> > Hi Oded,
> >
> > Out of curiosity, did you end up taking a look at Amlogic's driver?
> >
> > Cheers,
> >
> > Tomeu
> Hi Tomeu,
> Yes, I have looked at the driver's code. It was not an in-depth review,
> but I tried to mainly understand the features the driver provide to the
> user and how much complex it is.
>
>  From what I could see, this is a full-fledged accelerator which
> requires command submission/completion handling, memory management,
> information and debug capabilities and more.
>
> Therefore, I do think the correct place is in the accel sub-system,
> which will require you to convert the driver to use drm (we can discuss
> exactly what is the level of integration required).
>
> As I said, I didn't do a full-fledged review, but please note the driver
> has a lot of OS-wrapper code, which is not acceptable in the Linux
> kernel, so you will have to clean all the up.

Thanks, Oded.

I'm wondering now about the requirement for open userspace. Do we have
it for this one?

Cheers,

Tomeu

> Thanks,
> Oded
>
> >
> > On Sat, Oct 7, 2023 at 8:37=E2=80=AFAM Cancan Chang <Cancan.Chang@amlog=
ic.com> wrote:
> >>
> >> Oded,
> >>         You can get the driver code from  github link=EF=BC=9A https:/=
/github.com/OldDaddy9/driver
> >>          e.g.  git clone https://github.com/OldDaddy9/driver.git
> >>
> >> ________________________________________
> >> =E5=8F=91=E4=BB=B6=E4=BA=BA: Oded Gabbay <ogabbay@kernel.org>
> >> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2023=E5=B9=B410=E6=9C=883=E6=97=
=A5 18:52
> >> =E6=94=B6=E4=BB=B6=E4=BA=BA: Cancan Chang
> >> =E6=8A=84=E9=80=81: Jagan Teki; linux-media; linux-kernel; Dave Airlie=
; Daniel Vetter
> >> =E4=B8=BB=E9=A2=98: Re: kernel.org 6.5.4 , NPU driver, --not support (=
RFC)
> >>
> >> [ EXTERNAL EMAIL ]
> >>
> >> On Thu, Sep 28, 2023 at 11:16=E2=80=AFAM Cancan Chang <Cancan.Chang@am=
logic.com> wrote:
> >>>
> >>> =E2=80=9CWhat happens if you call this again without waiting for the =
previous
> >>> inference to complete ?=E2=80=9D
> >>>     --- There is a work-queue in the driver to manage inference tasks=
.
> >>>           When two consecutive inference tasks occur, the second infe=
rence task will be add to
> >>>           the "pending list". While the previous inference task ends,=
 the second inference task will
> >>>           switch to the "scheduled list", and be executed.
> >>>           Each inference task has an id,  "inferece" and "wait until =
finish" are paired.
> >>>
> >>>           thanks
> >> Thanks for the clarification.
> >> I'll wait for your driver's code link. It doesn't have to be a patch
> >> series at this point. A link to a git repo is enough.
> >> I just want to do a quick pass.
> >>
> >> Thanks,
> >> Oded
> >>
> >>
> >>
> >>>
> >>> ________________________________________
> >>> =E5=8F=91=E4=BB=B6=E4=BA=BA: Oded Gabbay <ogabbay@kernel.org>
> >>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2023=E5=B9=B49=E6=9C=8828=E6=97=
=A5 15:40
> >>> =E6=94=B6=E4=BB=B6=E4=BA=BA: Cancan Chang
> >>> =E6=8A=84=E9=80=81: Jagan Teki; linux-media; linux-kernel; Dave Airli=
e; Daniel Vetter
> >>> =E4=B8=BB=E9=A2=98: Re: kernel.org 6.5.4 , NPU driver, --not support =
(RFC)
> >>>
> >>> [ EXTERNAL EMAIL ]
> >>>
> >>> On Thu, Sep 28, 2023 at 10:25=E2=80=AFAM Cancan Chang <Cancan.Chang@a=
mlogic.com> wrote:
> >>>>
> >>>> =E2=80=9CCould you please post a link to the driver's source code ?
> >>>> In addition, could you please elaborate which userspace libraries
> >>>> exists that work with your driver ? Are any of them open-source ?=E2=
=80=9D
> >>>> --- We will prepare the adla driver link after the holiday on Octobe=
r 6th.
> >>>>       It's a pity that there is no open-source userspace library.
> >>>>       But you can probably understand it through a workflow, which c=
an be simplified as:
> >>>>       1. create model context
> >>>>            ret =3D ioctl(context->fd, ADLAK_IOCTL_REGISTER_NETWORK, =
&desc);
> >>>>       2.  set inputs
> >>>>       3.  inference
> >>>>             ret =3D ioctl(context->fd, ADLAK_IOCTL_INVOKE, &invoke_d=
ec);
> >>> What happens if you call this again without waiting for the previous
> >>> inference to complete ?
> >>> Oded
> >>>>       4.  wait for the inference to complete
> >>>>             ret =3D ioctl(context->fd, ADLAK_IOCTL_WAIT_UNTIL_FINISH=
, &stat_req_desc);
> >>>>       5.  destroy model context
> >>>>             ret =3D ioctl(context->fd, ADLAK_IOCTL_DESTROY_NETWORK, =
&submit_del);
> >>>>
> >>>>
> >>>>        thanks
> >>>>
> >>>>
> >>>> ________________________________________
> >>>> =E5=8F=91=E4=BB=B6=E4=BA=BA: Oded Gabbay <ogabbay@kernel.org>
> >>>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2023=E5=B9=B49=E6=9C=8828=E6=
=97=A5 13:28
> >>>> =E6=94=B6=E4=BB=B6=E4=BA=BA: Cancan Chang
> >>>> =E6=8A=84=E9=80=81: Jagan Teki; linux-media; linux-kernel; Dave Airl=
ie; Daniel Vetter
> >>>> =E4=B8=BB=E9=A2=98: Re: kernel.org 6.5.4 , NPU driver, --not support=
 (RFC)
> >>>>
> >>>> [ EXTERNAL EMAIL ]
> >>>>
> >>>> On Wed, Sep 27, 2023 at 10:01=E2=80=AFAM Cancan Chang <Cancan.Chang@=
amlogic.com> wrote:
> >>>>>
> >>>>> =E2=80=9COr do you handle one cmd at a time, where the user sends a=
 cmd buffer
> >>>>> to the driver and the driver then submit it by writing to a couple =
of
> >>>>> registers and polls on some status register until its done, or wait=
s
> >>>>> for an interrupt to mark it as done ?=E2=80=9D
> >>>>>    --- yes=EF=BC=8C user sends a cmd buffer to driver, and driver t=
riggers hardware by writing to register,
> >>>>>          and then, waits for an interrupt to mark it  as done.
> >>>>>
> >>>>>      My current driver is very different from drm, so I want to kno=
w if I have to switch to drm=EF=BC=9F
> >>>> Could you please post a link to the driver's source code ?
> >>>> In addition, could you please elaborate which userspace libraries
> >>>> exists that work with your driver ? Are any of them open-source ?
> >>>>
> >>>>>      Maybe I can refer to /driver/accel/habanalabs.
> >>>> That's definitely a possibility.
> >>>>
> >>>> Oded
> >>>>>
> >>>>> thanks
> >>>>>
> >>>>> ________________________________________
> >>>>> =E5=8F=91=E4=BB=B6=E4=BA=BA: Oded Gabbay <ogabbay@kernel.org>
> >>>>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2023=E5=B9=B49=E6=9C=8826=E6=
=97=A5 20:54
> >>>>> =E6=94=B6=E4=BB=B6=E4=BA=BA: Cancan Chang
> >>>>> =E6=8A=84=E9=80=81: Jagan Teki; linux-media; linux-kernel; Dave Air=
lie; Daniel Vetter
> >>>>> =E4=B8=BB=E9=A2=98: Re: kernel.org 6.5.4 , NPU driver, --not suppor=
t (RFC)
> >>>>>
> >>>>> [ EXTERNAL EMAIL ]
> >>>>>
> >>>>> On Mon, Sep 25, 2023 at 12:29=E2=80=AFPM Cancan Chang <Cancan.Chang=
@amlogic.com> wrote:
> >>>>>>
> >>>>>> Thank you for your reply from Jagan & Oded.
> >>>>>>
> >>>>>> It is very appropritate for my driver to be placed in driver/accel=
.
> >>>>>>
> >>>>>> My accelerator is named ADLA(Amlogic Deep Learning Accelerator).
> >>>>>> It is an IP in SOC,mainly used for neural network models accelerat=
ion.
> >>>>>> It will split and compile the neural network model into a private =
format cmd buffer,
> >>>>>> and submit this cmd buffer to ADLA hardware. It is not programmabl=
e device.
> >>>>> What exactly does it mean to "submit this cmd buffer to ADLA hardwa=
re" ?
> >>>>>
> >>>>> Does your h/w provides queues for the user/driver to put their
> >>>>> workloads/cmd-bufs on them ? And does it provide some completion qu=
eue
> >>>>> to notify when the work is completed?
> >>>>>
> >>>>> Or do you handle one cmd at a time, where the user sends a cmd buff=
er
> >>>>> to the driver and the driver then submit it by writing to a couple =
of
> >>>>> registers and polls on some status register until its done, or wait=
s
> >>>>> for an interrupt to mark it as done ?
> >>>>>
> >>>>>>
> >>>>>> ADLA includes four hardware engines:
> >>>>>> RS engines             : working for the reshape operators
> >>>>>> MAC engines         : working for the convolution operators
> >>>>>> DW engines           : working for the planer & Elementwise operat=
ors
> >>>>>> Activation engines : working for activation operators(ReLu,tanh..)
> >>>>>>
> >>>>>> By the way, my IP is mainly used for SOC, and the current driver r=
egistration is through the platform_driver,
> >>>>>> is it necessary to switch to drm?
> >>>>> This probably depends on the answer to my question above. btw, ther=
e
> >>>>> are drivers in drm that handle IPs that are part of an SOC, so
> >>>>> platform_driver is supported.
> >>>>>
> >>>>> Oded
> >>>>>
> >>>>>>
> >>>>>> thanks.
> >>>>>>
> >>>>>> ________________________________________
> >>>>>> =E5=8F=91=E4=BB=B6=E4=BA=BA: Oded Gabbay <ogabbay@kernel.org>
> >>>>>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2023=E5=B9=B49=E6=9C=8822=E6=
=97=A5 23:08
> >>>>>> =E6=94=B6=E4=BB=B6=E4=BA=BA: Jagan Teki
> >>>>>> =E6=8A=84=E9=80=81: Cancan Chang; linux-media; linux-kernel; Dave =
Airlie; Daniel Vetter
> >>>>>> =E4=B8=BB=E9=A2=98: Re: kernel.org 6.5.4 , NPU driver, --not suppo=
rt (RFC)
> >>>>>>
> >>>>>> [=E4=BD=A0=E9=80=9A=E5=B8=B8=E4=B8=8D=E4=BC=9A=E6=94=B6=E5=88=B0=
=E6=9D=A5=E8=87=AA ogabbay@kernel.org =E7=9A=84=E7=94=B5=E5=AD=90=E9=82=AE=
=E4=BB=B6=E3=80=82=E8=AF=B7=E8=AE=BF=E9=97=AE https://aka.ms/LearnAboutSend=
erIdentification=EF=BC=8C=E4=BB=A5=E4=BA=86=E8=A7=A3=E8=BF=99=E4=B8=80=E7=
=82=B9=E4=B8=BA=E4=BB=80=E4=B9=88=E5=BE=88=E9=87=8D=E8=A6=81]
> >>>>>>
> >>>>>> [ EXTERNAL EMAIL ]
> >>>>>>
> >>>>>> On Fri, Sep 22, 2023 at 12:38=E2=80=AFPM Jagan Teki <jagan@edgeble=
ai> wrote:
> >>>>>>>
> >>>>>>> On Fri, 22 Sept 2023 at 15:04, Cancan Chang <Cancan.Chang@amlogic=
com> wrote:
> >>>>>>>>
> >>>>>>>> Dear Media Maintainers:
> >>>>>>>>       Thanks for your attention. Before describing my problem=EF=
=BC=8Clet me introduce to you what I  mean by NPU.
> >>>>>>>>       NPU is Neural Processing Unit, It is designed for deep lea=
rning acceleration, It is also called TPU, APU ..
> >>>>>>>>
> >>>>>>>>       The real problems:
> >>>>>>>>        When I was about to upstream my NPU driver codes to linux=
 mainline, i meet two problems:
> >>>>>>>>          1.  According to my research, There is no NPU module pa=
th in the linux (base on linux 6.5.4) , I have searched all linux projects =
and found no organization or comany that has submitted NPU code. Is there a=
 path prepared for NPU driver currently?
> >>>>>>>>          2.   If there is no NPU driver path currently, I am goi=
ng to put my NPU driver code in the drivers/media/platform/amlogic/ =EF=BB=
=BF, because my NPU driver belongs to amlogic. and amlogic NPU is mainly us=
ed for AI vision applications. Is this plan suitabe for you?
> >>>>>>>
> >>>>>>> If I'm correct about the discussion with Oded Gabby before. I thi=
nk
> >>>>>>> the drivers/accel/ is proper for AI Accelerators including NPU.
> >>>>>>>
> >>>>>>> + Oded in case he can comment.
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>> Jagan.
> >>>>>> Thanks Jagan for adding me to this thread. Adding Dave & Daniel as=
 well.
> >>>>>>
> >>>>>> Indeed, the drivers/accel is the place for Accelerators, mainly fo=
r
> >>>>>> AI/Deep-Learning accelerators.
> >>>>>> We currently have 3 drivers there already.
> >>>>>>
> >>>>>> The accel subsystem is part of the larger drm subsystem. Basically=
, to
> >>>>>> get into accel, you need to integrate your driver with the drm at =
the
> >>>>>> basic level (registering a device, hooking up with the proper
> >>>>>> callbacks). ofc the more you use code from drm, the better.
> >>>>>> You can take a look at the drivers under accel for some examples o=
n
> >>>>>> how to do that.
> >>>>>>
> >>>>>> Could you please describe in a couple of sentences what your
> >>>>>> accelerator does, which engines it contains, how you program it. i=
e.
> >>>>>> Is it a fixed-function device where you write to a couple of regis=
ters
> >>>>>> to execute workloads, or is it a fully programmable device where y=
ou
> >>>>>> load compiled code into it (GPU style) ?
> >>>>>>
> >>>>>> For better background on the accel subsystem, please read the foll=
owing:
> >>>>>> https://docs.kernel.org/accel/introduction.html
> >>>>>> This introduction also contains links to other important email thr=
eads
> >>>>>> and to Dave Airlie's BOF summary in LPC2022.
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Oded
>
>

