Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935B77C8D32
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 20:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjJMSlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 14:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMSk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 14:40:59 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0ED95
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 11:40:57 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4063bfc6c03so11665e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 11:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697222455; x=1697827255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZVpY21cwcAndxPn7pzCSjYxGXGWx8Hqaw1X1tXYIQU=;
        b=q/vc+ogZ+B5EtNLKdU707XhriCbzKWIUdNBo7W98lOtogu+I0Yyvc27CjXu98n8cDc
         F5GQQcB1NkoRbaTb769mbmtRLHnmb3m04imEbQHa4vIIUCN0IWaYgQy8lHf/CEQ2r06y
         kud6QsCdt3dZO7lb6e53XSR1cwssRG2V19hiZEGlzSfFabG7M9dovlA/6xvXSHUASobL
         GgcbJOBiWkc6e0tu52GyO41mfZr89E5xL5uipmWYi9oQUaKmxLf53fbrnyOAKy696ASM
         dEHkV9PNrQGtXjxSsb4yoqHYEZriGExfUt0zqybXe5WluIQomddL3eO2YTm7GJS7fXrP
         39sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697222455; x=1697827255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZVpY21cwcAndxPn7pzCSjYxGXGWx8Hqaw1X1tXYIQU=;
        b=U9ykBUMMfrowIoKFU0UHyUzesEf55QLHvj5OvmfJXj7xWFNHXjrgcmNVhSctDGY5sk
         yHlGf3YfC1seed4siHq1qfeAuK64x+lDJ/rxlf90dvPxhzCEFZgoi4RdBI2kq2AqevOZ
         W0RRq0hVakAez5JFeO5xi3oLuAR3G29Qn7STsbTHJzZKPr8dDt/FJgacSTIgd7dij9PO
         T8qzyoTseyQ4XaQXn6ZFJFZL2zetJEGqz9zx87tn86B2Xuzkv9EmTvJG4wlDylPcYjrW
         67ePM4NFGwNOZR+RS2+94TShKWh+2bia6o97264ZOdwVg7dc5DQNkmPaFLhQyz2mfsyM
         pXAQ==
X-Gm-Message-State: AOJu0YwTFcuqv4XJehFXhOS6IK5TcFd+qGyeD80sEL6xOd/DtXfjJWD/
        YmCx5OyUjFJMx05Rvoxg4EMU+2lzmOoIGrQ4K4ZT1Q==
X-Google-Smtp-Source: AGHT+IFij3kUIEY1BA2tygafsY+JsIAU1kQX7FEzzpuiNxVWSLwUvRtg15t59Kf03RgWZZ5plcxH5PrA7Icv7vV7DWE=
X-Received: by 2002:a7b:cb54:0:b0:406:4e80:b8ef with SMTP id
 v20-20020a7bcb54000000b004064e80b8efmr3512wmj.6.1697222455333; Fri, 13 Oct
 2023 11:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231009142005.21338-1-quic_kriskura@quicinc.com>
 <20231009142005.21338-2-quic_kriskura@quicinc.com> <CANP3RGfEk2DqZ3biyN78ycQYbDxCEG+H1me2vnEYuwXkNdXnTA@mail.gmail.com>
 <CANP3RGcCpNOuVpdV9n0AFxZo-wsfwi8OfYgBk1WHNHaEd-4V-Q@mail.gmail.com>
 <CANP3RGdY4LsOA6U5kuccApHCzL0_jBnY=pLOYrUuYtMZFTvnbw@mail.gmail.com>
 <d19d9d08-c119-4991-b460-49925f601d15@quicinc.com> <fad5a7fb-cce1-46bc-a0af-72405c76d107@quicinc.com>
 <CANP3RGcqWBYd9FqAX47rE9pFgBTB8=0CGdwkScm-OH1epHcVWQ@mail.gmail.com>
 <8ff92053-52ff-4950-95c8-0e986f6a028a@quicinc.com> <CANP3RGd4G4dkMOyg6wSX29NYP2mp=LhMhmZpoG=rgoCz=bh1=w@mail.gmail.com>
In-Reply-To: <CANP3RGd4G4dkMOyg6wSX29NYP2mp=LhMhmZpoG=rgoCz=bh1=w@mail.gmail.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Fri, 13 Oct 2023 11:40:43 -0700
Message-ID: <CANP3RGfDf4mUR4UAMF8283vPZBxYmGxe0D_02NhWDR2JjHCtmg@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: gadget: ncm: Add support to update
 wMaxSegmentSize via configfs
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        onathan Corbet <corbet@lwn.net>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 11:39=E2=80=AFAM Maciej =C5=BBenczykowski <maze@goo=
gle.com> wrote:
>
> On Thu, Oct 12, 2023 at 8:40=E2=80=AFAM Krishna Kurapati PSSNV
> <quic_kriskura@quicinc.com> wrote:
> >
> >
> >
> > On 10/12/2023 6:02 PM, Maciej =C5=BBenczykowski wrote:
> > > On Thu, Oct 12, 2023 at 1:48=E2=80=AFAM Krishna Kurapati PSSNV
> > >
> > > Could you paste the full patch?
> > > This is hard to review without looking at much more context then emai=
l
> > > is providing
> > > (or, even better, send me a link to a CL in gerrit somewhere - for
> > > example aosp ACK mainline tree)
> >
> > Sure. Will provide a gerrit on ACK for review before posting v2.
> >
> > The intent of posting the diff was two fold:
> >
> > 1. The question Greg asked regarding why the max segment size was
> > limited to 15014 was valid. When I thought about it, I actually wanted
> > to limit the max MTU to 15000, so the max segment size automatically
> > needs to be limited to 15014.
>
> Note that this is a *very* abstract value.
> I get you want L3 MTU of 10 * 1500, but this value is not actually meanin=
gful.
>
> IPv4/IPv6 fragmentation and IPv4/IPv6 TCP segmentation
> do not result in a trivial multiplication of the standard 1500 byte
> ethernet L3 MTU.
> Indeed aggregating 2 1500 L3 mtu frames results in *different* sized
> frames depending on which type of aggregation you do.
> (and for tcp it even depends on the number and size of tcp options,
> though it is often assumed that those take up 12 bytes, since that's the
> normal for Linux-to-Linux tcp connections)
>
> For example if you aggregate N standard Linux ipv6/tcp L3 1500 mtu frames=
,
> this means you have
> N frames: ethernet (14) + ipv6 (40) + tcp (20) + tcp options (12) +
> payload (1500-12-20-40=3D1500-72=3D1428)
> post aggregation:
> 1 frame: ethernet (14) + ipv6 (40) + tcp (20) + tcp options (12) +
> payload (N*1428)
>
> so N * 1500 =3D=3D N * (72 + 1428) --> 1 * (72 + N * 1428)

As you can see, for N=3D10, this isn't 15000, it's 72+10*1428 =3D 14352

>
> That value of 72 is instead 52 for 'standard Linux ipv4/tcp),
> it's 40/60 if there's no tcp options (which I think happens when
> talking to windows)
> it's different still with ipv4 fragmentation... and again different
> with ipv6 fragmentation...
> etc.
>
> ie. 15000 L3 mtu is exactly as meaningless as 14000 L3 mtu.
> Either way you don't get full frames.
>
> As such I'd recommend going with whatever is the largest mtu that can
> be meaningfully made to fit in 16K with all the NCM header overhead.
> That's likely closer to 15500-16000 (though I have *not* checked).
>
> > But my commit text didn't mention this
> > properly which was a mistake on my behalf. But when I looked at the
> > code, limiting the max segment size 15014 would force the practical
> > max_mtu to not cross 15000 although theoretical max_mtu was set to:
> > (GETHER_MAX_MTU_SIZE - 15412) during registration of net device.
> >
> > So my assumption of limiting it to 15000 was wrong. It must be limited
> > to 15412 as mentioned in u_ether.c  This inturn means we must limit
> > max_segment_size to:
> > GETHER_MAX_ETH_FRAME_LEN (GETHER_MAX_MTU_SIZE + ETH_HLEN)
> > as mentioned in u_ether.c.
> >
> > I wanted to confirm that setting MAX_DATAGRAM_SIZE to
> > GETHER_MAX_ETH_FRAME_LEN was correct.
> >
> > 2. I am not actually able to test with MTU beyond 15000. When my host
> > device is a linux machine, the cdc_ncm.c limits max_segment_size to:
> > CDC_NCM_MAX_DATAGRAM_SIZE               8192    /* bytes */
>
> In practice you get 50% of the benefits of infinitely large mtu by
> going from 1500 to ~2980.
> you get 75% of the benefits by going to ~6K
> you get 87.5% of the benefits by going to ~12K
> the benefits of going even higher are smaller and smaller...
>
> If the host side is limited to 8192, maybe we should match that here too?
>
> But the host side limitation of 8192 doesn't seem particularly sane eithe=
r...
> Maybe we should relax that instead?
>
> (especially since for things like tcp zero copy you want an mtu which
> is slighly more then N * 4096,
> ie. around 4.5KB, 8.5KB, 12.5KB or something like that)
>
> > When connected to windows machine, I am able to set the mtu to a max
> > value of 15000. So not sure how to test the patch if I set the
> > max_segment_size to GETHER_MAX_ETH_FRAME_LEN.
> >
> > By pasting the diff, I wanted to confirm both the above queries.
> >
> > And you are right, while assigning value to ecm.wMaxSegmentSize, we mus=
t
> > use cpu_to_le16(...). Will ensure to make this change in v2. It worked
> > without that too, not sure how.Maciej =C5=BBenczykowski, Kernel Network=
ing Developer @ Google
