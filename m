Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0147F0F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjKTJvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjKTJvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:51:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA638F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:51:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEC5C433C8;
        Mon, 20 Nov 2023 09:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700473909;
        bh=TV25DohQMrEGWPZRjX0RacFKMm4hRFAcqopvFP8hYwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=evn177yYwwW/a5I8QrF7Psp+mK6S0rqPvr2rd6lE/6InVnMuxg89YKyCaF5ZvDT0q
         OxUA2K2zBcrbVbGRqHk0C7XVjYfNty8q1TL1/6Kt5pMJG0CAKkCaOKQjcZ4OM057Mv
         Q3ybusUxms5RpNLJ6J7F/7GNUZkoKcWBRObnv7ke6Sm3yvjMp6+nbNe4MlGfivFaAJ
         gTJvP/F35uIgnCXBRW83XHAb7OI01kJHMfFmvB4Mo2pjdy5f2SRj+jZffENbwF7pCO
         8gPCLKBWHS7tl4NNwFte3j7TUyD833np5aB0BFto8NUtBKPcfNyI/8/3i9NadEd6K8
         48IMeKHj0VaKA==
Date:   Mon, 20 Nov 2023 10:51:45 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     =?utf-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Toshiaki Makita <toshiaki.makita1@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH net] veth: fix ethtool statistical errors
Message-ID: <ZVssMWXZYxM0eKiY@lore-desk>
References: <20231116114150.48639-1-huangjie.albert@bytedance.com>
 <ZVcxmwm/DRTB8QwO@lore-desk>
 <CABKxMyPMboVYs01KfPEdxPbx-LT88Qe1pcDMaT0NiNWhA-5emg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VZMxcV+xIR+W6tFj"
Content-Disposition: inline
In-Reply-To: <CABKxMyPMboVYs01KfPEdxPbx-LT88Qe1pcDMaT0NiNWhA-5emg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VZMxcV+xIR+W6tFj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8817=
=E6=97=A5=E5=91=A8=E4=BA=94 17:26=E5=86=99=E9=81=93=EF=BC=9A
> >
> > > if peer->real_num_rx_queues > 1, the ethtool -s command for
> > > veth network device will display some error statistical values.
> > > The value of tx_idx is reset with each iteration, so even if
> > > peer->real_num_rx_queues is greater than 1, the value of tx_idx
> > > will remain constant. This results in incorrect statistical values.
> > > To fix this issue, assign the value of pp_idx to tx_idx.
> > >
> > > Fixes: 5fe6e56776ba ("veth: rely on peer veth_rq for ndo_xdp_xmit acc=
ounting")
> > > Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> > > ---
> > >  drivers/net/veth.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > > index 0deefd1573cf..3a8e3fc5eeb5 100644
> > > --- a/drivers/net/veth.c
> > > +++ b/drivers/net/veth.c
> > > @@ -225,7 +225,7 @@ static void veth_get_ethtool_stats(struct net_dev=
ice *dev,
> > >       for (i =3D 0; i < peer->real_num_rx_queues; i++) {
> > >               const struct veth_rq_stats *rq_stats =3D &rcv_priv->rq[=
i].stats;
> > >               const void *base =3D (void *)&rq_stats->vs;
> > > -             unsigned int start, tx_idx =3D idx;
> > > +             unsigned int start, tx_idx =3D pp_idx;
> > >               size_t offset;
> > >
> > >               tx_idx +=3D (i % dev->real_num_tx_queues) * VETH_TQ_STA=
TS_LEN;
> > > --
> > > 2.20.1
> > >
> >
> > Hi Albert,
> >
> > Can you please provide more details about the issue you are facing?
> > In particular, what is the number of configured tx and rx queues for bo=
th
> > peers?
>=20
> Hi, Lorenzo
> I found this because I wanted to add more echo information in ethttool=EF=
=BC=88for veth,
> but I found that the information was incorrect. That's why I paid
> attention here.

ack. Could you please share the veth pair tx/rx queue configuration?

Rergards,
Lorenzo

>=20
> > tx_idx is the index of the current (local) tx queue and it must restart=
 from
> > idx in each iteration otherwise we will have an issue when
> > peer->real_num_rx_queues is greater than dev->real_num_tx_queues.
> >
> OK. I don't know if this is a known issue.
>=20
> BR
> Albert
>=20
>=20
> > Regards,
> > Lorenzo

--VZMxcV+xIR+W6tFj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZVssMQAKCRA6cBh0uS2t
rOdWAPsG9iBF4iqCk1hj4Vo7HUDtpFulSUqaXmU6X6jFvBuxAAD7BTR4ocKKXDqC
MJMd9CBLhHzJGZg0xMaedYS/Ie7spwg=
=msjy
-----END PGP SIGNATURE-----

--VZMxcV+xIR+W6tFj--
