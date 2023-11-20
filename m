Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B19A7F0FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjKTKDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjKTKDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:03:05 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D9E95
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:03:01 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c5056059e0so56629611fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700474579; x=1701079379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hg4iUdv1qOzfMKdHlqA4NidrBnEmUd5kiYhnaCQ/qFE=;
        b=KdwCFp2Qk1NKZqF5AMMZHjE+sb51l7I0A4A0OeciwZeHKeb4e88pPteF8WD3IrhpIp
         Tim5edihXx2AI61W/BSbj+SPvAJC4cEAoyUHvmzrdXopPSP8wDwxRyHJF1MhfzeAvDTw
         0fUyHcpPX4Gt4WvfuwV4RjPtgjxAbnlZQ0vJFtIq+oO01Jyuua7+E9rJPfz5/mVqiT4i
         xkcjHWmKxWmqA3L7bK8vIXXZUNfcOuDsgc1A3OrewMCMmOecqRGvqSx+QF0KJjYJB8Gv
         aOmNEwWZqN7sAW/h4YS70+fnCa2jAeYbKspzVPHsyuOSeAsTSrzqJTOZKaK71+SD8VD7
         6efQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700474579; x=1701079379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hg4iUdv1qOzfMKdHlqA4NidrBnEmUd5kiYhnaCQ/qFE=;
        b=X5cbYFgTYPHaomvx/RrkuUqPtZ69KiEGI5XjeV9be11dnRdTJLotgXmxgvhfHrzGOC
         aQkv9R1cBP33ilObtnEx3yGCEGHTn1Cg+EK+rdSz+hInTCmk1FddW5jvP4hDBEUUdq1S
         b62B0ZTjwfhjdomkNGwBVk0Pmf0Z6iTJDZr/jsGrUaYcwIyncV7Mmy+k9CGhclxQ348W
         XA3fCwTrQTbplpuREWohFszKIcZJJwNYJDJ+tPqTtYWoi5rAsa04mUBDScZcDlu9SyIX
         buuYBNmZHfTS+BmZ+SCNDdWfXoRIOpqflaYSomJGS05NqSmHvEMnRLIEM+eudfUZUzyu
         +30w==
X-Gm-Message-State: AOJu0Yx/LY/S/VPX548WH6W6THWI632TM9pjUqNHiqrpBgn7kaZHBJTS
        4WLhcOCOCyEfb50OHRVl5S2ex7mDfy9IPAKYzHx6lw==
X-Google-Smtp-Source: AGHT+IGOGzsxb9JzoTvfjQfhK63XDXa5QAto8SzapsM1POYVzgQm+Sd10mobBmXLkGcgr1PH4L1jqpTpPPL6XWlXN4E=
X-Received: by 2002:a2e:8e32:0:b0:2c8:7665:9ede with SMTP id
 r18-20020a2e8e32000000b002c876659edemr3437930ljk.19.1700474579085; Mon, 20
 Nov 2023 02:02:59 -0800 (PST)
MIME-Version: 1.0
References: <20231116114150.48639-1-huangjie.albert@bytedance.com>
 <ZVcxmwm/DRTB8QwO@lore-desk> <CABKxMyPMboVYs01KfPEdxPbx-LT88Qe1pcDMaT0NiNWhA-5emg@mail.gmail.com>
 <ZVssMWXZYxM0eKiY@lore-desk>
In-Reply-To: <ZVssMWXZYxM0eKiY@lore-desk>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Mon, 20 Nov 2023 18:02:47 +0800
Message-ID: <CABKxMyPNYS=6BHhaMDOSSMu8F0C5jkoa5Tck1dE6QnLa6--6UQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH net] veth: fix ethtool statistical errors
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Toshiaki Makita <toshiaki.makita1@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8820=
=E6=97=A5=E5=91=A8=E4=B8=80 17:52=E5=86=99=E9=81=93=EF=BC=9A
>
> > Lorenzo Bianconi <lorenzo@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=88=
17=E6=97=A5=E5=91=A8=E4=BA=94 17:26=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > > if peer->real_num_rx_queues > 1, the ethtool -s command for
> > > > veth network device will display some error statistical values.
> > > > The value of tx_idx is reset with each iteration, so even if
> > > > peer->real_num_rx_queues is greater than 1, the value of tx_idx
> > > > will remain constant. This results in incorrect statistical values.
> > > > To fix this issue, assign the value of pp_idx to tx_idx.
> > > >
> > > > Fixes: 5fe6e56776ba ("veth: rely on peer veth_rq for ndo_xdp_xmit a=
ccounting")
> > > > Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> > > > ---
> > > >  drivers/net/veth.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > > > index 0deefd1573cf..3a8e3fc5eeb5 100644
> > > > --- a/drivers/net/veth.c
> > > > +++ b/drivers/net/veth.c
> > > > @@ -225,7 +225,7 @@ static void veth_get_ethtool_stats(struct net_d=
evice *dev,
> > > >       for (i =3D 0; i < peer->real_num_rx_queues; i++) {
> > > >               const struct veth_rq_stats *rq_stats =3D &rcv_priv->r=
q[i].stats;
> > > >               const void *base =3D (void *)&rq_stats->vs;
> > > > -             unsigned int start, tx_idx =3D idx;
> > > > +             unsigned int start, tx_idx =3D pp_idx;
> > > >               size_t offset;
> > > >
> > > >               tx_idx +=3D (i % dev->real_num_tx_queues) * VETH_TQ_S=
TATS_LEN;
> > > > --
> > > > 2.20.1
> > > >
> > >
> > > Hi Albert,
> > >
> > > Can you please provide more details about the issue you are facing?
> > > In particular, what is the number of configured tx and rx queues for =
both
> > > peers?
> >
> > Hi, Lorenzo
> > I found this because I wanted to add more echo information in ethttool=
=EF=BC=88for veth,
> > but I found that the information was incorrect. That's why I paid
> > attention here.
>
> ack. Could you please share the veth pair tx/rx queue configuration?
>

dev: tx --->4.  rx--->4
peer: tx--->1 rx---->1

Could the following code still be problematic? pp_idx not updated correctly=
.
page_pool_stats:
veth_get_page_pool_stats(dev, &data[pp_idx]);

BR
Albert

> Rergards,
> Lorenzo
>
> >
> > > tx_idx is the index of the current (local) tx queue and it must resta=
rt from
> > > idx in each iteration otherwise we will have an issue when
> > > peer->real_num_rx_queues is greater than dev->real_num_tx_queues.
> > >
> > OK. I don't know if this is a known issue.
> >
> > BR
> > Albert
> >
> >
> > > Regards,
> > > Lorenzo
