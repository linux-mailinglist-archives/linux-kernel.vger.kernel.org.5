Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5C5805DB9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345822AbjLESDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjLESDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:03:41 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C127490;
        Tue,  5 Dec 2023 10:03:47 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77d8f9159fbso323096485a.2;
        Tue, 05 Dec 2023 10:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701799427; x=1702404227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtqmpldzJhepZSlcxwawCnd6BYpTKMMQiQbo2+VQqDs=;
        b=jDzxqxX48qnzrFkI2Mjy7S6pIDdUytPY6+SEGY+S+x2V9kGMfDzFyXLXZs9BlnmsA9
         Mli8NEPpO2jZJRt/4iv8Yf75m38V4e8GvnL1tdjTPdR20nQ055CnxD51xsTvB6ksf7QG
         B/iBw15ASauQj4bNLB8gfQp0CaeTr7rOv3nuNqP4Se1cyxZMPRC7bNdN9MnwZ8vh0chv
         SYuTwk0nO/PzfRsjv7/7L+AXIsKhkRSITyPdzq4bhekioT88dDteUowXa6UlocvEGiJg
         WnmFBq1zwoSu/+pn0D8jLltI5RMj8d6PAEpnjyHKbnF/uFA6q8+5L16chsvxrjnjzZRC
         Bcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701799427; x=1702404227;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mtqmpldzJhepZSlcxwawCnd6BYpTKMMQiQbo2+VQqDs=;
        b=p4p2R5pERSh7xbYoQmwvHaQ88y89dLEw3r7/fFQDWxx26yJeS/LibxmS02hZxqSREZ
         6+8NBljyS+q0svZzoTDFXJQNOn8ktBGMZ3gEelUa7j+hiY6DdSy5fF7H5/MGAwdVoR1P
         T8K9ohgp+DJwzbAH/zMy9gOfeIkI527+Lkj+CyfG5EIYuxInks+Jl1odDFcqz8g0bpHd
         Do+sRZqse49gCFra9bKe0mK1zsGUaC7bXDHPLHg7sUAes+O9eI/0VNqc/cRxzl+WLVOe
         5JAztn+lObC6fDFpuUdLNZYQlVeYWLjeyMRMR+X7z7WkQZuhV3MKL3m1VlQOkSo6l568
         EcJg==
X-Gm-Message-State: AOJu0Yy4Fej501A++wEO5E8Iy9CZ5DWXOEnQByevhBdbxwJbW3/fxKnG
        AO8efFiAyQ81jbuIrgOAIZI=
X-Google-Smtp-Source: AGHT+IH5nvUqAJXOSA/slhx2XextBvezJuOqw3B1kWvu8x7p9HMI0Usz1QLdc8DahjbJUTB515nU3A==
X-Received: by 2002:a05:620a:349:b0:77e:fba3:7574 with SMTP id t9-20020a05620a034900b0077efba37574mr1530842qkm.108.1701799426793;
        Tue, 05 Dec 2023 10:03:46 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id qh13-20020a05620a668d00b0077d85d22e89sm5264273qkn.63.2023.12.05.10.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:03:46 -0800 (PST)
Date:   Tue, 05 Dec 2023 13:03:46 -0500
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     Stanislav Fomichev <sdf@google.com>,
        Florian Bezdeka <florian.bezdeka@siemens.com>
Cc:     "Song, Yoong Siang" <yoong.siang.song@intel.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Topel <bjorn@kernel.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Willem de Bruijn <willemb@google.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Message-ID: <656f66023f7bd_3dd6422942a@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAKH8qBuXL8bOYtfKKPS8y=KJqouDptyciCjr0wNKVHtNj6BmqA@mail.gmail.com>
References: <20231203165129.1740512-1-yoong.siang.song@intel.com>
 <20231203165129.1740512-3-yoong.siang.song@intel.com>
 <43b01013-e78b-417e-b169-91909c7309b1@kernel.org>
 <656de830e8d70_2e983e294ca@willemb.c.googlers.com.notmuch>
 <PH0PR11MB583000826591093B98BA841DD885A@PH0PR11MB5830.namprd11.prod.outlook.com>
 <5a0faf8cc9ec3ab0d5082c66b909c582c8f1eae6.camel@siemens.com>
 <CAKH8qBuXL8bOYtfKKPS8y=KJqouDptyciCjr0wNKVHtNj6BmqA@mail.gmail.com>
Subject: Re: [xdp-hints] Re: [PATCH bpf-next v3 2/3] net: stmmac: add Launch
 Time support to XDP ZC
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stanislav Fomichev wrote:
> On Tue, Dec 5, 2023 at 7:34=E2=80=AFAM Florian Bezdeka
> <florian.bezdeka@siemens.com> wrote:
> >
> > On Tue, 2023-12-05 at 15:25 +0000, Song, Yoong Siang wrote:
> > > On Monday, December 4, 2023 10:55 PM, Willem de Bruijn wrote:
> > > > Jesper Dangaard Brouer wrote:
> > > > >
> > > > >
> > > > > On 12/3/23 17:51, Song Yoong Siang wrote:
> > > > > > This patch enables Launch Time (Time-Based Scheduling) suppor=
t to XDP zero
> > > > > > copy via XDP Tx metadata framework.
> > > > > >
> > > > > > Signed-off-by: Song Yoong Siang<yoong.siang.song@intel.com>
> > > > > > ---
> > > > > >   drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 ++
> > > > >
> > > > > As requested before, I think we need to see another driver impl=
ementing
> > > > > this.
> > > > >
> > > > > I propose driver igc and chip i225.
> > >
> > > Sure. I will include igc patches in next version.
> > >
> > > > >
> > > > > The interesting thing for me is to see how the LaunchTime max 1=
 second
> > > > > into the future[1] is handled code wise. One suggestion is to a=
dd a
> > > > > section to Documentation/networking/xsk-tx-metadata.rst per dri=
ver that
> > > > > mentions/documents these different hardware limitations.  It is=
 natural
> > > > > that different types of hardware have limitations.  This is a c=
lose-to
> > > > > hardware-level abstraction/API, and IMHO as long as we document=
 the
> > > > > limitations we can expose this API without too many limitations=
 for more
> > > > > capable hardware.
> > >
> > > Sure. I will try to add hardware limitations in documentation.
> > >
> > > >
> > > > I would assume that the kfunc will fail when a value is passed th=
at
> > > > cannot be programmed.
> > > >
> > >
> > > In current design, the xsk_tx_metadata_request() dint got return va=
lue.
> > > So user won't know if their request is fail.
> > > It is complex to inform user which request is failing.
> > > Therefore, IMHO, it is good that we let driver handle the error sil=
ently.
> > >
> >
> > If the programmed value is invalid, the packet will be "dropped" / wi=
ll
> > never make it to the wire, right?

Programmable behavior is to either drop or cap to some boundary
value, such as the farthest programmable time in the future: the
horizon. In fq:

                /* Check if packet timestamp is too far in the future. */=

                if (fq_packet_beyond_horizon(skb, q, now)) {
                        if (q->horizon_drop) {
                                        q->stat_horizon_drops++;
                                        return qdisc_drop(skb, sch, to_fr=
ee);
                        }
                        q->stat_horizon_caps++;
                        skb->tstamp =3D now + q->horizon;
                }
                fq_skb_cb(skb)->time_to_send =3D skb->tstamp;

Drop is the more obviously correct mode.

Programming with a clock source that the driver does not support will
then be a persistent failure.

Preferably, this driver capability can be queried beforehand (rather
than only through reading error counters afterwards).

Perhaps it should not be a driver task to convert from possibly
multiple clock sources to the device native clock. Right now, we do
use per-device timecounters for this, implemented in the driver.

As for which clocks are relevant. For PTP, I suppose the device PHC,
converted to nsec. For pacing offload, TCP uses CLOCK_MONOTONIC.

> >
> > That is clearly a situation that the user should be informed about. F=
or
> > RT systems this normally means that something is really wrong regardi=
ng
> > timing / cycle overflow. Such systems have to react on that situation=
.
> =

> In general, af_xdp is a bit lacking in this 'notify the user that they
> somehow messed up' area :-(
> For example, pushing a tx descriptor with a wrong addr/len in zc mode
> will not give any visible signal back (besides driver potentially
> spilling something into dmesg as it was in the mlx case).
> We can probably start with having some counters for these events?

This is because the AF_XDP completion queue descriptor format is only
a u64 address?

Could error conditions be reported on tx completion in the metadata,
using xsk_tx_metadata_complete?

