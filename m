Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F05D76F8DD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 06:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjHDEQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 00:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjHDEQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 00:16:45 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547AA3595
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 21:16:18 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9cbaee7a9so26646921fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 21:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691122576; x=1691727376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDFuCPil4pEoLXHYo0Ls7o77K/H32wrnIMBAQN1MPHk=;
        b=hlmtKbG2KrbEEPRHkFHomIqd3it6JQzSyCXO8KEnc7gH627jiD/g1QCZY2teTeo2tN
         gNcFOuNVfd/1LTIoyAZqGEXs9cLWYiJVOKfumFUC4g/ZSl/JAylvGdy3RK7t7fDO6gnE
         ylkutQ7MeB5QQDH+l8yYEHBNssCTEYh1nZ+F5IjhYsNBirqO4sgKkYJRjpd6fPZF0+4s
         vd4ErP5Y2wCVSfZgXxM6xmRLfVTnVjS0By9Ae+rsexsgIaXU0Xxcgcv2CBrSGjsred+F
         VH93jsHGvJgRoFwaHepHrMXJhMLBDdmlcOpr5WhHyNf7N/QEP3Ey1lOagS95r3l536mM
         Ha+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691122576; x=1691727376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDFuCPil4pEoLXHYo0Ls7o77K/H32wrnIMBAQN1MPHk=;
        b=VS90GbhVUPMGbGHd9+6rE03Kpm6wNwBFLw2Fp6AMMRGmfNmS0dwaP4maaV33gb5gHU
         40tFbuPu1Ae/mQvxYd3HANrbuhNnppNbgzzgFUUq1xSONPOAayidis5bPwdCQ5bAtVtx
         lBSQiKVtR8MSQC61tyhOvVMHvQ2xE1tFz74aTDPxzD/KesoRrLyr6SctuS3raHKG+Vzr
         3GSpKNk2pNOAF+WOG+y55IuAZt+e4o2++ChWfbN97WLpPees8S7hRAqD6o8HHpYR6GW1
         tiEasA6ARs7eTRD/8/8eE2U9aiLDWHK1C4ZDZ6OfKoZU717PnlQLqbeCTvQToaDs96/i
         6GIQ==
X-Gm-Message-State: AOJu0YxqCQATymoMixiMX//ft8H/HQjse1itAGpqVvnyRrfukxd5ZjX3
        8HQfjVjeLjQwIlWgHhQ7+qsryAPtlhkPMl/H8expwA==
X-Google-Smtp-Source: AGHT+IHbAuP+LciwG2AIp+kFI5TMnvMEJLCNUx4sEUfKirQwmvhTnp6ylv/Nzsk5Ug9B6Q6iguTXEydIdwA5RfhCyI0=
X-Received: by 2002:a2e:97d7:0:b0:2b9:f3b4:6808 with SMTP id
 m23-20020a2e97d7000000b002b9f3b46808mr554724ljj.29.1691122576570; Thu, 03 Aug
 2023 21:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230803140441.53596-1-huangjie.albert@bytedance.com> <a144aa6351412e25bbdf866c0d31b550e6ff3e8a.camel@redhat.com>
In-Reply-To: <a144aa6351412e25bbdf866c0d31b550e6ff3e8a.camel@redhat.com>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Fri, 4 Aug 2023 12:16:05 +0800
Message-ID: <CABKxMyMj4+9r44GFO3PM15516Pkmr=g8WBVhdjv7tk231fGqWg@mail.gmail.com>
Subject: Re: [External] Re: [RFC Optimizing veth xsk performance 00/10]
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Richard Gobert <richardbgobert@gmail.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=883=E6=97=A5=
=E5=91=A8=E5=9B=9B 22:20=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, 2023-08-03 at 22:04 +0800, huangjie.albert wrote:
> > AF_XDP is a kernel bypass technology that can greatly improve performan=
ce.
> > However, for virtual devices like veth, even with the use of AF_XDP soc=
kets,
> > there are still many additional software paths that consume CPU resourc=
es.
> > This patch series focuses on optimizing the performance of AF_XDP socke=
ts
> > for veth virtual devices. Patches 1 to 4 mainly involve preparatory wor=
k.
> > Patch 5 introduces tx queue and tx napi for packet transmission, while
> > patch 9 primarily implements zero-copy, and patch 10 adds support for
> > batch sending of IPv4 UDP packets. These optimizations significantly re=
duce
> > the software path and support checksum offload.
> >
> > I tested those feature with
> > A typical topology is shown below:
> > veth<-->veth-peer                                    veth1-peer<--->vet=
h1
> >       1       |                                                  |   7
> >               |2                                                6|
> >               |                                                  |
> >             bridge<------->eth0(mlnx5)- switch -eth1(mlnx5)<--->bridge1
> >                   3                    4                 5
> >              (machine1)                              (machine2)
> > AF_XDP socket is attach to veth and veth1. and send packets to physical=
 NIC(eth0)
> > veth:(172.17.0.2/24)
> > bridge:(172.17.0.1/24)
> > eth0:(192.168.156.66/24)
> >
> > eth1(172.17.0.2/24)
> > bridge1:(172.17.0.1/24)
> > eth0:(192.168.156.88/24)
> >
> > after set default route . snat . dnat. we can have a tests
> > to get the performance results.
> >
> > packets send from veth to veth1:
> > af_xdp test tool:
> > link:https://github.com/cclinuxer/libxudp
> > send:(veth)
> > ./objs/xudpperf send --dst 192.168.156.88:6002 -l 1300
> > recv:(veth1)
> > ./objs/xudpperf recv --src 172.17.0.2:6002
> >
> > udp test tool:iperf3
> > send:(veth)
> > iperf3 -c 192.168.156.88 -p 6002 -l 1300 -b 60G -u
>
> Should be: '-b 0' otherwise you will experience additional overhead.
>

with -b 0:
performance:
performance:(test weth libxdp lib)
UDP                              : 320 Kpps (with 100% cpu)
AF_XDP   no  zerocopy + no batch : 480 Kpps (with ksoftirqd 100% cpu)
AF_XDP  with zerocopy + no batch : 540 Kpps (with ksoftirqd 100% cpu)
AF_XDP  with  batch  +  zerocopy : 1.5 Mpps (with ksoftirqd 15% cpu)

thanks.

> And you would likely pin processes and irqs to ensure BH and US run on
> different cores of the same numa node.
>
> Cheers,
>
> Paolo
>
