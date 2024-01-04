Return-Path: <linux-kernel+bounces-17325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59511824BCD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2D78B236B1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D842D601;
	Thu,  4 Jan 2024 23:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HG0Z8JMO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ECA2D602
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 23:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bbd6e3795eso706939b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 15:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704410776; x=1705015576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7YC5gxh53HaVB8bG0KYrVyNbkWh9ueGrs5JllzhvC0=;
        b=HG0Z8JMONu9AlAAVLmcifRn+pcb3BxHd7kQImVoQIvX3mXCDqyWjU3lmGHQtdoCmai
         lbk/cF3G9Xtu21Ed6aOAy1VUn2Mv83TohjpjISyeYoe5umN9gte1Y/dMLoturINZp18h
         HIG3jhbLykFbqutQh/ljcqxOFohk1bjm4gIVEfM5mJ9HafUfm572SXxEx5SSGEKxzur3
         rxAZDoMOjzkC+x/oHMLKgCIHC9DtXkM9ueIVCbUzQcfPolT2x8exFAMAT/aKWTBh7wpF
         q3Dt3tTyzADHQn+5QLeyHCGsId6WAdewJl3f+a5CHOKTUhH2mBwoDBUfWVbhwg4+Svkt
         WZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704410776; x=1705015576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7YC5gxh53HaVB8bG0KYrVyNbkWh9ueGrs5JllzhvC0=;
        b=ruB0dcVdZ/SVPD3Kt+nGF719ov5ug/3/iGw/8cUQ/wmBOl8m/SoUf5q+uBpcaOlA2Q
         SnPxILhxQHltXq/e5hkRiVBp65lHtte+iPug49/kTteOF2/y8KQs5uVqy5uNiKO+1PXK
         uPsanBojh+JhoLWnJfdD6F45qeWwqbIX2aoznghevP8IllvCQ7NSKP7noBA5JZoZNu3z
         iSVsiz9vw65/9uX+vRLzM43so6/nwmtwSLdWhgS2Neos0AwU/BO/YCMY8uxBFJH1E7X3
         0AxiSjIkh6I4wgE69ocw4+b/++5nkNqD++OLmSY8tmfD2GyUHJ9K0IL4/3mdzx3o6UJ/
         1Cpg==
X-Gm-Message-State: AOJu0YwGF22uDFPa/wDDINHAYCQR4Rn0QBTGQGlRyCTxGcQgJK6uoOEy
	e5c17FBBaRJt4SDbSQBArhIeitJW5igbsmoanEKpU5cMm7+3
X-Google-Smtp-Source: AGHT+IGzVma0//Hfa9jD5GxHQPmtSyOocPgwCfDWYCnJE667xjb404/uAn1gDd15K8wcGHzjP6unsGTls0/3ezxiyds=
X-Received: by 2002:a05:6808:650c:b0:3bb:fc6d:1905 with SMTP id
 fm12-20020a056808650c00b003bbfc6d1905mr1157046oib.106.1704410776194; Thu, 04
 Jan 2024 15:26:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221023650.3208767-1-aahila@google.com> <ZYUBP6h3H6U5T8HG@Laptop-X1>
In-Reply-To: <ZYUBP6h3H6U5T8HG@Laptop-X1>
From: Aahil Awatramani <aahila@google.com>
Date: Thu, 4 Jan 2024 15:26:04 -0800
Message-ID: <CAGfWUPzGyLeR_MtPvpoE7wRTmsnxXos+FvjvqVP8T_Wm8J5KZw@mail.gmail.com>
Subject: Re: [PATCH next] bonding: Extending LACP MUX State Machine to include
 a Collecting State.
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Mahesh Bandewar <maheshb@google.com>, Jay Vosburgh <j.vosburgh@gmail.com>, 
	Andy Gospodarek <andy@greyhouse.net>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Hangbin, I have made the changes that you have suggested in v2
of the patch.

> Is it possible that a port in DISTRIBUTING state while no LACP_STATE_SYNC=
HRONIZATION flag?
> It should has this flag since COLLECTING.

This is correct, I kept the LACP_STATE_SYNCHRONIZATION flag check to
be consistent with
what the previous Collecting and Distributing states were checking as
well as what the IEEE
802.1AX-2020 state diagram checks for.

> The bond_set_slave_inactive_flags() also has all_slaves_active() checks.
> I don't think you can replace all the bond_set_slave_inactive_flags() to =
this one directly.
> How about update the bond_set_slave_inactive_flags() with a 8023ad check,=
 e.g.

I have followed up with your suggestion here as well as also done it
similarly for
bond_set_slave_active_flags.

On Thu, Dec 21, 2023 at 7:23=E2=80=AFPM Hangbin Liu <liuhangbin@gmail.com> =
wrote:
>
> Hi Aahil,
>
> On Thu, Dec 21, 2023 at 02:36:50AM +0000, Aahil Awatramani wrote:
> > Introduces two new states, AD_MUX_COLLECTING and AD_MUX_DISTRIBUTING in
> > the LACP MUX state machine for separated handling of an initial
> > Collecting state before the Collecting and Distributing state. This
> > enables a port to be in a state where it can receive incoming packets
> > while not still distributing. This is useful for reducing packet loss w=
hen
> > a port begins distributing before its partner is able to collect.
> > Additionally this also brings the 802.3ad bonding driver's implementati=
on
> > closer to the LACP specification which already predefined this behaviou=
r.
> >
> > Note that the regular flow process in the kernel's bonding driver remai=
ns
> > unaffected by this patch. The extension requires explicit opt-in by the
> > user (in order to ensure no disruptions for existing setups) via netlin=
k
> > or sysfs support using the new bonding parameter lacp_extended_mux. The
>
> Sysfs is deprecated. We should only use netlink API.
>
> > default value for lacp_extended_mux is set to 0 so as to preserve exist=
ing
> > behaviour.
>
> As Jay said, please update the document for new parameter. It also would =
be
> good to add a selftest in tools/testing/selftests/drivers/net/bonding to =
make
> sure the Mux machine changes correctly. You can use scapy to send the par=
tner
> state. This could be used for both bonding/teaming testing, which is valu=
able.
>
> >
> > Signed-off-by: Aahil Awatramani <aahila@google.com>
> > ---
> >  drivers/net/bonding/bond_3ad.c     | 155 +++++++++++++++++++++++++++--
> >  drivers/net/bonding/bond_main.c    |  22 ++--
> >  drivers/net/bonding/bond_netlink.c |  16 +++
> >  drivers/net/bonding/bond_options.c |  26 ++++-
> >  drivers/net/bonding/bond_sysfs.c   |  12 +++
> >  include/net/bond_3ad.h             |   2 +
> >  include/net/bond_options.h         |   1 +
> >  include/net/bonding.h              |  33 ++++++
> >  include/uapi/linux/if_link.h       |   1 +
> >  tools/include/uapi/linux/if_link.h |   1 +
> >  10 files changed, 254 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_=
3ad.c
> > index c99ffe6c683a..38a7aa6e4edd 100644
> > --- a/drivers/net/bonding/bond_3ad.c
> > +++ b/drivers/net/bonding/bond_3ad.c
> > @@ -106,6 +106,9 @@ static void ad_agg_selection_logic(struct aggregato=
r *aggregator,
> >  static void ad_clear_agg(struct aggregator *aggregator);
> >  static void ad_initialize_agg(struct aggregator *aggregator);
> >  static void ad_initialize_port(struct port *port, int lacp_fast);
> > +static void ad_enable_collecting(struct port *port);
> > +static void ad_disable_distributing(struct port *port,
> > +                                 bool *update_slave_arr);
> >  static void ad_enable_collecting_distributing(struct port *port,
> >                                             bool *update_slave_arr);
> >  static void ad_disable_collecting_distributing(struct port *port,
> > @@ -171,32 +174,64 @@ static inline int __agg_has_partner(struct aggreg=
ator *agg)
> >       return !is_zero_ether_addr(agg->partner_system.mac_addr_value);
> >  }
> >
> > +/**
> > + * __disable_distributing_port - disable the port's slave for distribu=
ting.
> > + * Port will still be able to collect.
> > + * @port: the port we're looking at
> > + *
> > + * This will disable only distributing on the port's slave.
> > + */
> > +static inline void __disable_distributing_port(struct port *port)
> > +{
> > +     bond_set_slave_tx_disabled_flags(port->slave, BOND_SLAVE_NOTIFY_L=
ATER);
> > +}
> > +
> > +/**
> > + * __enable_collecting_port - enable the port's slave for collecting,
> > + * if it's up
> > + * @port: the port we're looking at
> > + *
> > + * This will enable only collecting on the port's slave.
> > + */
> > +static inline void __enable_collecting_port(struct port *port)
> > +{
> > +     struct slave *slave =3D port->slave;
> > +
> > +     if (slave->link =3D=3D BOND_LINK_UP && bond_slave_is_up(slave))
> > +             bond_set_slave_rx_enabled_flags(slave, BOND_SLAVE_NOTIFY_=
LATER);
> > +}
> > +
> >  /**
> >   * __disable_port - disable the port's slave
> >   * @port: the port we're looking at
> > + *
> > + * This will disable both collecting and distributing on the port's sl=
ave.
> >   */
> >  static inline void __disable_port(struct port *port)
> >  {
> > -     bond_set_slave_inactive_flags(port->slave, BOND_SLAVE_NOTIFY_LATE=
R);
> > +     bond_set_slave_txrx_disabled_flags(port->slave, BOND_SLAVE_NOTIFY=
_LATER);
> >  }
>
> Can we replace bond_set_slave_inactive_flags() directly?
> bond_set_slave_inactive_flags() also checks the all_slaves_active paramet=
er.
> Please see more comments under bond_set_slave_txrx_disabled_flags() funct=
ion.
>
> >
> >  /**
> >   * __enable_port - enable the port's slave, if it's up
> >   * @port: the port we're looking at
> > + *
> > + * This will enable both collecting and distributing on the port's sla=
ve.
> >   */
> >  static inline void __enable_port(struct port *port)
> >  {
> >       struct slave *slave =3D port->slave;
> >
> >       if ((slave->link =3D=3D BOND_LINK_UP) && bond_slave_is_up(slave))
> > -             bond_set_slave_active_flags(slave, BOND_SLAVE_NOTIFY_LATE=
R);
> > +             bond_set_slave_txrx_enabled_flags(slave, BOND_SLAVE_NOTIF=
Y_LATER);
> >  }
> >
> >  /**
> > - * __port_is_enabled - check if the port's slave is in active state
> > + * __port_is_collecting_distributing - check if the port's slave is in=
 the
> > + * combined collecting/distributing state
> >   * @port: the port we're looking at
> >   */
> > -static inline int __port_is_enabled(struct port *port)
> > +static inline int __port_is_collecting_distributing(struct port *port)
> >  {
> >       return bond_is_active_slave(port->slave);
> >  }
> > @@ -942,6 +977,7 @@ static int ad_marker_send(struct port *port, struct=
 bond_marker *marker)
> >   */
> >  static void ad_mux_machine(struct port *port, bool *update_slave_arr)
> >  {
> > +     struct bonding *bond =3D __get_bond_by_port(port);
> >       mux_states_t last_state;
> >
> >       /* keep current State Machine state to compare later if it was
> > @@ -999,9 +1035,13 @@ static void ad_mux_machine(struct port *port, boo=
l *update_slave_arr)
> >                       if ((port->sm_vars & AD_PORT_SELECTED) &&
> >                           (port->partner_oper.port_state & LACP_STATE_S=
YNCHRONIZATION) &&
> >                           !__check_agg_selection_timer(port)) {
> > -                             if (port->aggregator->is_active)
> > -                                     port->sm_mux_state =3D
> > -                                         AD_MUX_COLLECTING_DISTRIBUTIN=
G;
> > +                             if (port->aggregator->is_active) {
> > +                                     int state =3D AD_MUX_COLLECTING_D=
ISTRIBUTING;
> > +
> > +                                     if (bond->params.lacp_extended_mu=
x)
> > +                                             state =3D AD_MUX_COLLECTI=
NG;
> > +                                     port->sm_mux_state =3D state;
> > +                             }
> >                       } else if (!(port->sm_vars & AD_PORT_SELECTED) ||
> >                                  (port->sm_vars & AD_PORT_STANDBY)) {
> >                               /* if UNSELECTED or STANDBY */
> > @@ -1031,7 +1071,52 @@ static void ad_mux_machine(struct port *port, bo=
ol *update_slave_arr)
> >                                */
> >                               if (port->aggregator &&
> >                                   port->aggregator->is_active &&
> > -                                 !__port_is_enabled(port)) {
> > +                                 !__port_is_collecting_distributing(po=
rt)) {
> > +                                     __enable_port(port);
> > +                                     *update_slave_arr =3D true;
> > +                             }
> > +                     }
> > +                     break;
> > +             case AD_MUX_COLLECTING:
> > +                     if (!(port->sm_vars & AD_PORT_SELECTED) ||
> > +                         (port->sm_vars & AD_PORT_STANDBY) ||
> > +                         !(port->partner_oper.port_state & LACP_STATE_=
SYNCHRONIZATION) ||
> > +                         !(port->actor_oper_port_state & LACP_STATE_SY=
NCHRONIZATION)) {
>
> Both AD_MUX_COLLECTING_DISTRIBUTING and AD_MUX_COLLECTING check these, ma=
ybe
> we can add a function like port_should_mux_attached() to do the checks.
>
> > +                             port->sm_mux_state =3D AD_MUX_ATTACHED;
> > +                     } else if ((port->sm_vars & AD_PORT_SELECTED) &&
> > +                         (port->partner_oper.port_state & LACP_STATE_S=
YNCHRONIZATION) &&
> > +                         (port->partner_oper.port_state & LACP_STATE_C=
OLLECTING)) {
> > +                             port->sm_mux_state =3D AD_MUX_DISTRIBUTIN=
G;
> > +                     } else {
> > +                             /* If port state hasn't changed, make sur=
e that a collecting
> > +                              * port is enabled for an active aggregat=
or.
> > +                              */
> > +                             if (port->aggregator &&
> > +                                 port->aggregator->is_active) {
> > +                                     struct slave *slave =3D port->sla=
ve;
> > +
> > +                                     if (bond_is_slave_rx_disabled(sla=
ve) !=3D 0) {
> > +                                             ad_enable_collecting(port=
);
> > +                                             *update_slave_arr =3D tru=
e;
> > +                                     }
> > +                             }
> > +                     }
> > +                     break;
> > +             case AD_MUX_DISTRIBUTING:
> > +                     if (!(port->sm_vars & AD_PORT_SELECTED) ||
> > +                         (port->sm_vars & AD_PORT_STANDBY) ||
> > +                         !(port->partner_oper.port_state & LACP_STATE_=
COLLECTING) ||
> > +                         !(port->partner_oper.port_state & LACP_STATE_=
SYNCHRONIZATION) ||
> > +                         !(port->actor_oper_port_state & LACP_STATE_SY=
NCHRONIZATION)) {
>
> Is it possible that a port in DISTRIBUTING state while no LACP_STATE_SYNC=
HRONIZATION flag?
> It should has this flag since COLLECTING.
>
> > +                             port->sm_mux_state =3D AD_MUX_COLLECTING;
> > +                     } else {
> > +                             /* if port state hasn't changed make
> > +                              * sure that a collecting distributing
> > +                              * port in an active aggregator is enable=
d
> > +                              */
> > +                             if (port->aggregator &&
> > +                                 port->aggregator->is_active &&
> > +                                 !__port_is_collecting_distributing(po=
rt)) {
> >                                       __enable_port(port);
> >                                       *update_slave_arr =3D true;
> >                               }
> > @@ -1082,6 +1167,20 @@ static void ad_mux_machine(struct port *port, bo=
ol *update_slave_arr)
> >                                                         update_slave_ar=
r);
>
> ...
>
> > @@ -2763,11 +2766,14 @@ static void bond_miimon_commit(struct bonding *=
bond)
> >                       bond_set_slave_link_state(slave, BOND_LINK_DOWN,
> >                                                 BOND_SLAVE_NOTIFY_NOW);
> >
> > -                     if (BOND_MODE(bond) =3D=3D BOND_MODE_ACTIVEBACKUP=
 ||
> > -                         BOND_MODE(bond) =3D=3D BOND_MODE_8023AD)
> > +                     if (BOND_MODE(bond) =3D=3D BOND_MODE_ACTIVEBACKUP=
)
> >                               bond_set_slave_inactive_flags(slave,
> >                                                             BOND_SLAVE_=
NOTIFY_NOW);
> >
> > +                     if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD)
> > +                             bond_set_slave_txrx_disabled_flags(slave,
> > +                                                                BOND_S=
LAVE_NOTIFY_NOW);
> > +
> >                       slave_info(bond->dev, slave->dev, "link status de=
finitely down, disabling slave\n");
> >
> >                       bond_miimon_link_change(bond, slave, BOND_LINK_DO=
WN);
> > @@ -4276,8 +4282,12 @@ static int bond_open(struct net_device *bond_dev=
)
> >               bond_for_each_slave(bond, slave, iter) {
> >                       if (bond_uses_primary(bond) &&
> >                           slave !=3D rcu_access_pointer(bond->curr_acti=
ve_slave)) {
> > -                             bond_set_slave_inactive_flags(slave,
> > -                                                           BOND_SLAVE_=
NOTIFY_NOW);
> > +                             if (BOND_MODE(bond) =3D=3D BOND_MODE_8023=
AD)
>
> The bond_uses_primary() only returns true for ab/tlb/alb mode, there won'=
t be
> 8023ad mode.
>
> > +                                     bond_set_slave_txrx_disabled_flag=
s(slave,
> > +                                                                      =
  BOND_SLAVE_NOTIFY_NOW);
> > +                             else
> > +                                     bond_set_slave_inactive_flags(sla=
ve,
> > +                                                                   BON=
D_SLAVE_NOTIFY_NOW);
> >                       } else if (BOND_MODE(bond) !=3D BOND_MODE_8023AD)=
 {
> >                               bond_set_slave_active_flags(slave,
> >                                                           BOND_SLAVE_NO=
TIFY_NOW);
>
> ...
>
> >
> > diff --git a/include/net/bonding.h b/include/net/bonding.h
> > index 5b8b1b644a2d..b31880d53d76 100644
> > --- a/include/net/bonding.h
> > +++ b/include/net/bonding.h
> > @@ -148,6 +148,7 @@ struct bond_params {
> >  #if IS_ENABLED(CONFIG_IPV6)
> >       struct in6_addr ns_targets[BOND_MAX_NS_TARGETS];
> >  #endif
> > +     int lacp_extended_mux;
> >
> >       /* 2 bytes of padding : see ether_addr_equal_64bits() */
> >       u8 ad_actor_system[ETH_ALEN + 2];
> > @@ -167,6 +168,7 @@ struct slave {
> >       u8     backup:1,   /* indicates backup slave. Value corresponds w=
ith
> >                             BOND_STATE_ACTIVE and BOND_STATE_BACKUP */
> >              inactive:1, /* indicates inactive slave */
> > +            rx_disabled:1, /* indicates whether slave's Rx is disabled=
 */
> >              should_notify:1, /* indicates whether the state changed */
> >              should_notify_link:1; /* indicates whether the link change=
d */
> >       u8     duplex;
> > @@ -570,6 +572,19 @@ static inline void bond_set_slave_inactive_flags(s=
truct slave *slave,
> >               slave->inactive =3D 1;
> >  }
> >
> > +static inline void bond_set_slave_txrx_disabled_flags(struct slave *sl=
ave,
> > +                                              bool notify)
> > +{
> > +     bond_set_slave_state(slave, BOND_STATE_BACKUP, notify);
> > +     slave->rx_disabled =3D 1;
> > +}
>
> The bond_set_slave_inactive_flags() also has all_slaves_active() checks.
> I don't think you can replace all the bond_set_slave_inactive_flags() to =
this one directly.
> How about update the bond_set_slave_inactive_flags() with a 8023ad check,=
 e.g.
>
> diff --git a/include/net/bonding.h b/include/net/bonding.h
> index 5b8b1b644a2d..ab70c46119a0 100644
> --- a/include/net/bonding.h
> +++ b/include/net/bonding.h
> @@ -568,6 +568,8 @@ static inline void bond_set_slave_inactive_flags(stru=
ct slave *slave,
>                 bond_set_slave_state(slave, BOND_STATE_BACKUP, notify);
>         if (!slave->bond->params.all_slaves_active)
>                 slave->inactive =3D 1;
> +       if (BOND_MODE(slave->bond) =3D=3D BOND_MODE_8023AD)
> +               slave->rx_disabled =3D 1;
>  }
>
> Thanks
> Hangbin

