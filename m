Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF907AED48
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbjIZMyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjIZMys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:54:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05CCC9;
        Tue, 26 Sep 2023 05:54:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69531C433CB;
        Tue, 26 Sep 2023 12:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695732881;
        bh=aq7UFSyeuaXrrm2TboTSzTWWh+A6sTeSTdMoaAg1jV8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oHUrc6v4RYgfuQksgzNwp69Se3rKvxMvVgtb4/VxKba0D23wF3AwWVmc5MRwBPtX7
         N2vEjZzpwCmiq1RDWSawZXxAS1O28VaH4DR/K/NNwov7PCJ/bPfgHcv/fkBhT5JlHe
         Dbv/BORbiZPC1Ni8SII9zdGPuhy/wJ7OBsCTefBalLqshiKG4QUmx+IRUhjOAEiofe
         GRToLd+3C0HDKEiYyLSoqTyJbE31BalUOVe9iDyejT3tZyTD+fbRaISchWiSsXhCxx
         5p+YifVdpgYUlv13l8OPno78NlwYdq/KymurX4hJ1l9bh3EOpgcd+vzyxETj/zF1Tx
         hRlwbsdlD+JwA==
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d868d8363e6so5767997276.2;
        Tue, 26 Sep 2023 05:54:41 -0700 (PDT)
X-Gm-Message-State: AOJu0YwiJbJeSt80w3P/qD6IAc7imKWf+DBcwNZH4G/jnqSIYqrLdXeW
        mjNlFfzVjtYmkoSB5Z4AUu46ofRZHj0bvw++Xf0=
X-Google-Smtp-Source: AGHT+IFyofOQnLYQqQ0v1shxNMhN+66Ex/5veDCSSP/Jcmnm/MsOn6iV0JT5NJynPRlAs93HW1ZK3hSG0xPveWXN6FY=
X-Received: by 2002:a25:73d6:0:b0:d85:d2a3:8f58 with SMTP id
 o205-20020a2573d6000000b00d85d2a38f58mr8729100ybc.5.1695732880436; Tue, 26
 Sep 2023 05:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <SEYPR03MB704641091854162959578D7E9AFFA@SEYPR03MB7046.apcprd03.prod.outlook.com>
 <CA+VMnFyhp9D8cjtvLVzdKGETouOuH=MKgjOu1pn00WDRB=5oUg@mail.gmail.com>
 <CAFCwf12sUL5bcXhYKwRkMxLtSDtLfTK003oxkRDVmThx1ARV-A@mail.gmail.com> <SEYPR03MB70462A385A52A317427E93B59AFCA@SEYPR03MB7046.apcprd03.prod.outlook.com>
In-Reply-To: <SEYPR03MB70462A385A52A317427E93B59AFCA@SEYPR03MB7046.apcprd03.prod.outlook.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Tue, 26 Sep 2023 15:54:14 +0300
X-Gmail-Original-Message-ID: <CAFCwf11hxBpg3T6MoVrL0GaOD_=xB+-dWeEtDH0cCyzyQ-q1tg@mail.gmail.com>
Message-ID: <CAFCwf11hxBpg3T6MoVrL0GaOD_=xB+-dWeEtDH0cCyzyQ-q1tg@mail.gmail.com>
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

On Mon, Sep 25, 2023 at 12:29=E2=80=AFPM Cancan Chang <Cancan.Chang@amlogic=
.com> wrote:
>
> Thank you for your reply from Jagan & Oded.
>
> It is very appropritate for my driver to be placed in driver/accel.
>
> My accelerator is named ADLA(Amlogic Deep Learning Accelerator).
> It is an IP in SOC,mainly used for neural network models acceleration.
> It will split and compile the neural network model into a private format =
cmd buffer,
> and submit this cmd buffer to ADLA hardware. It is not programmable devic=
e.
What exactly does it mean to "submit this cmd buffer to ADLA hardware" ?

Does your h/w provides queues for the user/driver to put their
workloads/cmd-bufs on them ? And does it provide some completion queue
to notify when the work is completed?

Or do you handle one cmd at a time, where the user sends a cmd buffer
to the driver and the driver then submit it by writing to a couple of
registers and polls on some status register until its done, or waits
for an interrupt to mark it as done ?

>
> ADLA includes four hardware engines:
> RS engines             : working for the reshape operators
> MAC engines         : working for the convolution operators
> DW engines           : working for the planer & Elementwise operators
> Activation engines : working for activation operators(ReLu,tanh..)
>
> By the way, my IP is mainly used for SOC, and the current driver registra=
tion is through the platform_driver,
> is it necessary to switch to drm?
This probably depends on the answer to my question above. btw, there
are drivers in drm that handle IPs that are part of an SOC, so
platform_driver is supported.

Oded

>
> thanks.
>
> ________________________________________
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Oded Gabbay <ogabbay@kernel.org>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2023=E5=B9=B49=E6=9C=8822=E6=97=A5 =
23:08
> =E6=94=B6=E4=BB=B6=E4=BA=BA: Jagan Teki
> =E6=8A=84=E9=80=81: Cancan Chang; linux-media; linux-kernel; Dave Airlie;=
 Daniel Vetter
> =E4=B8=BB=E9=A2=98: Re: kernel.org 6.5.4 , NPU driver, --not support (RFC=
)
>
> [=E4=BD=A0=E9=80=9A=E5=B8=B8=E4=B8=8D=E4=BC=9A=E6=94=B6=E5=88=B0=E6=9D=A5=
=E8=87=AA ogabbay@kernel.org =E7=9A=84=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=
=E3=80=82=E8=AF=B7=E8=AE=BF=E9=97=AE https://aka.ms/LearnAboutSenderIdentif=
ication=EF=BC=8C=E4=BB=A5=E4=BA=86=E8=A7=A3=E8=BF=99=E4=B8=80=E7=82=B9=E4=
=B8=BA=E4=BB=80=E4=B9=88=E5=BE=88=E9=87=8D=E8=A6=81]
>
> [ EXTERNAL EMAIL ]
>
> On Fri, Sep 22, 2023 at 12:38=E2=80=AFPM Jagan Teki <jagan@edgeble.ai> wr=
ote:
> >
> > On Fri, 22 Sept 2023 at 15:04, Cancan Chang <Cancan.Chang@amlogic.com> =
wrote:
> > >
> > > Dear Media Maintainers:
> > >      Thanks for your attention. Before describing my problem=EF=BC=8C=
let me introduce to you what I  mean by NPU.
> > >      NPU is Neural Processing Unit, It is designed for deep learning =
acceleration, It is also called TPU, APU ..
> > >
> > >      The real problems:
> > >       When I was about to upstream my NPU driver codes to linux mainl=
ine, i meet two problems:
> > >         1.  According to my research, There is no NPU module path in =
the linux (base on linux 6.5.4) , I have searched all linux projects and fo=
und no organization or comany that has submitted NPU code. Is there a path =
prepared for NPU driver currently?
> > >         2.   If there is no NPU driver path currently, I am going to =
put my NPU driver code in the drivers/media/platform/amlogic/ =EF=BB=BF, be=
cause my NPU driver belongs to amlogic. and amlogic NPU is mainly used for =
AI vision applications. Is this plan suitabe for you?
> >
> > If I'm correct about the discussion with Oded Gabby before. I think
> > the drivers/accel/ is proper for AI Accelerators including NPU.
> >
> > + Oded in case he can comment.
> >
> > Thanks,
> > Jagan.
> Thanks Jagan for adding me to this thread. Adding Dave & Daniel as well.
>
> Indeed, the drivers/accel is the place for Accelerators, mainly for
> AI/Deep-Learning accelerators.
> We currently have 3 drivers there already.
>
> The accel subsystem is part of the larger drm subsystem. Basically, to
> get into accel, you need to integrate your driver with the drm at the
> basic level (registering a device, hooking up with the proper
> callbacks). ofc the more you use code from drm, the better.
> You can take a look at the drivers under accel for some examples on
> how to do that.
>
> Could you please describe in a couple of sentences what your
> accelerator does, which engines it contains, how you program it. i.e.
> Is it a fixed-function device where you write to a couple of registers
> to execute workloads, or is it a fully programmable device where you
> load compiled code into it (GPU style) ?
>
> For better background on the accel subsystem, please read the following:
> https://docs.kernel.org/accel/introduction.html
> This introduction also contains links to other important email threads
> and to Dave Airlie's BOF summary in LPC2022.
>
> Thanks,
> Oded
