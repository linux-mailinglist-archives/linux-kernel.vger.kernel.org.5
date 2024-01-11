Return-Path: <linux-kernel+bounces-24047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9941382B5F6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3BB1B221D5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E1358138;
	Thu, 11 Jan 2024 20:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="4e12qt33"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE15258128
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 20:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bbd6e37af4so4592895b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705005162; x=1705609962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMCmvD1wsXSyFJvueOTyWcCuCTp90cW2pik4IChjScc=;
        b=4e12qt33iF1Wpo5ZiB43rQHzjfTUNXqKpm3BTMe7M9eM4D+GrP5rz25h8tHLFDXFLB
         xzveazpz6xtvRD01K5tRM94nwgWmny9AGCL8mNlSX49/KhnIxIKsriqCaVV/YNGM50mY
         Ul7H2Lk2aQOjs7gE/0iY4JZTmj8OfKjQrwI8JQc2XqQnMWkwalfZcXYV/UnXu+UocXAJ
         0bdNsv0/rLXcZhGpmXGN4oL1MrBs3Jf2CRqse56v8lOtPI3Dciygjl3GbbBKYbmoJkZ4
         TjDVD2suyPrry5A4IbuF3ZIPU1ioNhgpDFlw4pT+i9SCCoPWy5cU9rNwBJ0ZOq46osfh
         z6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705005162; x=1705609962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMCmvD1wsXSyFJvueOTyWcCuCTp90cW2pik4IChjScc=;
        b=LJAyuoU+P6MHNf3TZfWALagQkj4JDkbV1KbdT2aBzu2ZRbB0vT7eevW9lfNzwnz5Nj
         02xHO3fYktqF+OYTT8XOKH4zccwU6dp5X112frkEtEg+HU0ehVo6mCgy8uCEcagg8fZt
         GVVzS7aW8CjSVaO+eKnAlSclI3P3GygNIAGh+SkossoeviRk8yL4GME1BWhN2oBaXsve
         vo6mFCr4wuc1vOMclha94k7nP9fZUvaUY2CbBjpcyN+ZgaIelqFYMi4pmvCMXJkyQFe+
         QaMqLp1vkrYkbRtuP/zW1YuneBf2MF50KnVyiXkVVJg/Or9E8u7+9TViqkWJ4MRCjhTt
         f5xw==
X-Gm-Message-State: AOJu0YzjalXOdi06JFGbVoqwA95SzC3mGRHmgcN/0v6IXAn/0MXk2dGD
	UQNyZXUXPS4twuohPH3HDOJOJfsrLU+G14iLt/nX7ZxX2XlH
X-Google-Smtp-Source: AGHT+IG8EdeDcIVn4sxEsXqWwRgsOTi3Z3ISf/Bfb5AuUlGeqyjrhib6SLEuhaZ8R2hJ75bZJXj8zyNeOe05YnfXUC8=
X-Received: by 2002:a05:6808:3296:b0:3bd:437f:1db9 with SMTP id
 cg22-20020a056808329600b003bd437f1db9mr224702oib.33.1705005161731; Thu, 11
 Jan 2024 12:32:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105000632.2484182-1-aahila@google.com> <20240105000632.2484182-2-aahila@google.com>
 <11225.1704418546@famine>
In-Reply-To: <11225.1704418546@famine>
From: Aahil Awatramani <aahila@google.com>
Date: Thu, 11 Jan 2024 12:32:30 -0800
Message-ID: <CAGfWUPxuqJCQgdAj-3TUrXWtY05oji7mN+0aBkhYDbF-qGg1sA@mail.gmail.com>
Subject: Re: [PATCH 2/2 net-next v2] bonding: Extending LACP MUX State Machine
 to include a Collecting State.
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: David Dillow <dave@thedillows.org>, Mahesh Bandewar <maheshb@google.com>, 
	Andy Gospodarek <andy@greyhouse.net>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>         I think this last sentence is (a) unclear, and (b) should be
> first in the paragraph; I'd suggest something like:
>
> Add support for the independent control state machine per IEEE
> 802.1AX-2008 5.4.15 in addition to the existing implementation of the
> coupled control state machine.
>
>         The Subject should change in a similar way, e.g., "Add
> independent control state machine."

Done, I have made the suggested changes.

>         How did you test this to insure that the new logic works
> correctly against both coupled and independent control implementations?

I toggled between coupled and independent control modes. In each I
manually went through multiple test scenarios (host reboots, switch
link-flaps and link up/down from host side) by controlling
peer/switch. I used tcpdump to ensure the correct transitioning of the
LACP states for the given modes.

>         This name seems suboptimal, perhaps __port_should_goto_attached_s=
tate?
>
>         I'll also note that every use of this function then immediately
> executes "port->sm_mux_state =3D AD_MUX_ATTACHED", this could plausibly b=
e
> combined into a __port_move_to_attached_state function that returns true
> or false, e.g.,
>
>                         if (__port_should_mux_attached(port)) {
>                                 port->sm_mux_state =3D AD_MUX_ATTACHED;
>                         } else {
>                                 /* if port state hasn't changed make
>                                  * sure that a collecting distributing
>                                  * port in an active aggregator is enable=
d
>                                  */
>                                 if (port->aggregator &&
>                                     port->aggregator->is_active &&
>
>         would become something like:
>
>                         if (!__port_move_to_attached_state(port)) {
>                                 /* if port state hasn't changed make
>                                  * sure that a collecting distributing
>                                  * port in an active aggregator is enable=
d
>                                  */
>                                 if (port->aggregator &&
>                                     port->aggregator->is_active &&
>
>

Done, I have made the suggested changes.

>         Is it possible for port->aggregator to be NULL here?  I don't
> think it's possible for a port to get to this state and not be attached
> to an aggregator (it has to be SELECTED by this point).

I think you are right, I do not think it is possible for a port to be
in this state and not be attached to an aggregator. Initially I was
preserving the previous logic but now I have removed the NULL check in
both places.

>         The "!=3D 0" is superfluous here as bond_is_slave_rx_disabled()
> returns a boolean.

Done.

>         I believe this should permit changes to coupled_control only if
> the bond is down, or up with no interfaces attached to it.  The two
> state machines are not interchangable.

I added the BOND_OPTFLAG_IFDOWN flag to the coupled_control
bond_option. I think we should keep it such that we can only permit
changes when the bond is down similar to mode selection.

On Thu, Jan 4, 2024 at 5:35=E2=80=AFPM Jay Vosburgh <jay.vosburgh@canonical=
com> wrote:
>
> Aahil Awatramani <aahila@google.com> wrote:
>
> >Introduces two new states, AD_MUX_COLLECTING and AD_MUX_DISTRIBUTING in
> >the LACP MUX state machine for separated handling of an initial
> >Collecting state before the Collecting and Distributing state. This
> >enables a port to be in a state where it can receive incoming packets
> >while not still distributing. This is useful for reducing packet loss wh=
en
> >a port begins distributing before its partner is able to collect.
> >Additionally this also brings the 802.3ad bonding driver's implementatio=
n
> >closer to the LACP specification which already predefined this behaviour=
,
> >that is currently the implementation only supports coupled control.
>
>         I think this last sentence is (a) unclear, and (b) should be
> first in the paragraph; I'd suggest something like:
>
> Add support for the independent control state machine per IEEE
> 802.1AX-2008 5.4.15 in addition to the existing implementation of the
> coupled control state machine.
>
>         The Subject should change in a similar way, e.g., "Add
> independent control state machine."
>
> >Added new functions such as bond_set_slave_tx_disabled_flags and
> >bond_set_slave_rx_enabled_flags to precisely manage the port's collectin=
g
> >and distributing states. Previously, there was no dedicated method to
> >disable TX while keeping RX enabled, which this patch addresses.
> >
> >Note that the regular flow process in the kernel's bonding driver remain=
s
> >unaffected by this patch. The extension requires explicit opt-in by the
> >user (in order to ensure no disruptions for existing setups) via netlink
> >support using the new bonding parameter coupled_control. The default val=
ue
> >for coupled_control is set to 1 so as to preserve existing behaviour.
>
>         How did you test this to insure that the new logic works
> correctly against both coupled and independent control implementations?
>
> >Signed-off-by: Aahil Awatramani <aahila@google.com>
> >---
> > drivers/net/bonding/bond_3ad.c     | 159 +++++++++++++++++++++++++++--
> > drivers/net/bonding/bond_main.c    |   1 +
> > drivers/net/bonding/bond_netlink.c |  16 +++
> > drivers/net/bonding/bond_options.c |  26 ++++-
> > include/net/bond_3ad.h             |   2 +
> > include/net/bond_options.h         |   1 +
> > include/net/bonding.h              |  23 +++++
> > include/uapi/linux/if_link.h       |   1 +
> > tools/include/uapi/linux/if_link.h |   1 +
> > 9 files changed, 222 insertions(+), 8 deletions(-)
> >
> >diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3=
ad.c
> >index c99ffe6c683a..c2a658f2aaa3 100644
> >--- a/drivers/net/bonding/bond_3ad.c
> >+++ b/drivers/net/bonding/bond_3ad.c
> >@@ -106,6 +106,9 @@ static void ad_agg_selection_logic(struct aggregator=
 *aggregator,
> > static void ad_clear_agg(struct aggregator *aggregator);
> > static void ad_initialize_agg(struct aggregator *aggregator);
> > static void ad_initialize_port(struct port *port, int lacp_fast);
> >+static void ad_enable_collecting(struct port *port);
> >+static void ad_disable_distributing(struct port *port,
> >+                                  bool *update_slave_arr);
> > static void ad_enable_collecting_distributing(struct port *port,
> >                                             bool *update_slave_arr);
> > static void ad_disable_collecting_distributing(struct port *port,
> >@@ -171,9 +174,38 @@ static inline int __agg_has_partner(struct aggregat=
or *agg)
> >       return !is_zero_ether_addr(agg->partner_system.mac_addr_value);
> > }
> >
> >+/**
> >+ * __disable_distributing_port - disable the port's slave for distribut=
ing.
> >+ * Port will still be able to collect.
> >+ * @port: the port we're looking at
> >+ *
> >+ * This will disable only distributing on the port's slave.
> >+ */
> >+static inline void __disable_distributing_port(struct port *port)
> >+{
> >+      bond_set_slave_tx_disabled_flags(port->slave, BOND_SLAVE_NOTIFY_L=
ATER);
> >+}
> >+
> >+/**
> >+ * __enable_collecting_port - enable the port's slave for collecting,
> >+ * if it's up
> >+ * @port: the port we're looking at
> >+ *
> >+ * This will enable only collecting on the port's slave.
> >+ */
> >+static inline void __enable_collecting_port(struct port *port)
> >+{
> >+      struct slave *slave =3D port->slave;
> >+
> >+      if (slave->link =3D=3D BOND_LINK_UP && bond_slave_is_up(slave))
> >+              bond_set_slave_rx_enabled_flags(slave, BOND_SLAVE_NOTIFY_=
LATER);
> >+}
> >+
> > /**
> >  * __disable_port - disable the port's slave
> >  * @port: the port we're looking at
> >+ *
> >+ * This will disable both collecting and distributing on the port's sla=
ve.
> >  */
> > static inline void __disable_port(struct port *port)
> > {
> >@@ -183,6 +215,8 @@ static inline void __disable_port(struct port *port)
> > /**
> >  * __enable_port - enable the port's slave, if it's up
> >  * @port: the port we're looking at
> >+ *
> >+ * This will enable both collecting and distributing on the port's slav=
e.
> >  */
> > static inline void __enable_port(struct port *port)
> > {
> >@@ -193,10 +227,24 @@ static inline void __enable_port(struct port *port=
)
> > }
> >
> > /**
> >- * __port_is_enabled - check if the port's slave is in active state
> >+ * __port_should_mux_attached - check if port should transition back to=
 attached
> >+ * state.
> >  * @port: the port we're looking at
> >  */
> >-static inline int __port_is_enabled(struct port *port)
> >+static inline int __port_should_mux_attached(struct port *port)
>
>         This name seems suboptimal, perhaps __port_should_goto_attached_s=
tate?
>
>         I'll also note that every use of this function then immediately
> executes "port->sm_mux_state =3D AD_MUX_ATTACHED", this could plausibly b=
e
> combined into a __port_move_to_attached_state function that returns true
> or false, e.g.,
>
>                         if (__port_should_mux_attached(port)) {
>                                 port->sm_mux_state =3D AD_MUX_ATTACHED;
>                         } else {
>                                 /* if port state hasn't changed make
>                                  * sure that a collecting distributing
>                                  * port in an active aggregator is enable=
d
>                                  */
>                                 if (port->aggregator &&
>                                     port->aggregator->is_active &&
>
>         would become something like:
>
>                         if (!__port_move_to_attached_state(port)) {
>                                 /* if port state hasn't changed make
>                                  * sure that a collecting distributing
>                                  * port in an active aggregator is enable=
d
>                                  */
>                                 if (port->aggregator &&
>                                     port->aggregator->is_active &&
>
>
> >+{
> >+      return !(port->sm_vars & AD_PORT_SELECTED) ||
> >+              (port->sm_vars & AD_PORT_STANDBY) ||
> >+              !(port->partner_oper.port_state & LACP_STATE_SYNCHRONIZAT=
ION) ||
> >+              !(port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATIO=
N);
> >+}
> >+
> >+/**
> >+ * __port_is_collecting_distributing - check if the port's slave is in =
the
> >+ * combined collecting/distributing state
> >+ * @port: the port we're looking at
> >+ */
> >+static inline int __port_is_collecting_distributing(struct port *port)
> > {
> >       return bond_is_active_slave(port->slave);
> > }
> >@@ -942,6 +990,7 @@ static int ad_marker_send(struct port *port, struct =
bond_marker *marker)
> >  */
> > static void ad_mux_machine(struct port *port, bool *update_slave_arr)
> > {
> >+      struct bonding *bond =3D __get_bond_by_port(port);
> >       mux_states_t last_state;
> >
> >       /* keep current State Machine state to compare later if it was
> >@@ -999,9 +1048,13 @@ static void ad_mux_machine(struct port *port, bool=
 *update_slave_arr)
> >                       if ((port->sm_vars & AD_PORT_SELECTED) &&
> >                           (port->partner_oper.port_state & LACP_STATE_S=
YNCHRONIZATION) &&
> >                           !__check_agg_selection_timer(port)) {
> >-                              if (port->aggregator->is_active)
> >-                                      port->sm_mux_state =3D
> >-                                          AD_MUX_COLLECTING_DISTRIBUTIN=
G;
> >+                              if (port->aggregator->is_active) {
> >+                                      int state =3D AD_MUX_COLLECTING_D=
ISTRIBUTING;
> >+
> >+                                      if (!bond->params.coupled_control=
)
> >+                                              state =3D AD_MUX_COLLECTI=
NG;
> >+                                      port->sm_mux_state =3D state;
> >+                              }
> >                       } else if (!(port->sm_vars & AD_PORT_SELECTED) ||
> >                                  (port->sm_vars & AD_PORT_STANDBY)) {
> >                               /* if UNSELECTED or STANDBY */
> >@@ -1019,11 +1072,50 @@ static void ad_mux_machine(struct port *port, bo=
ol *update_slave_arr)
> >                       }
> >                       break;
> >               case AD_MUX_COLLECTING_DISTRIBUTING:
> >+                      if (__port_should_mux_attached(port)) {
> >+                              port->sm_mux_state =3D AD_MUX_ATTACHED;
> >+                      } else {
> >+                              /* if port state hasn't changed make
> >+                               * sure that a collecting distributing
> >+                               * port in an active aggregator is enable=
d
> >+                               */
> >+                              if (port->aggregator &&
> >+                                  port->aggregator->is_active &&
>
>         Is it possible for port->aggregator to be NULL here?  I don't
> think it's possible for a port to get to this state and not be attached
> to an aggregator (it has to be SELECTED by this point).
>
>         This test logic could also be moved into a helper function if
> the NULL check is necessary.
>
> >+                                  !__port_is_collecting_distributing(po=
rt)) {
> >+                                      __enable_port(port);
> >+                                      *update_slave_arr =3D true;
> >+                              }
> >+                      }
> >+                      break;
> >+              case AD_MUX_COLLECTING:
> >+                      if (__port_should_mux_attached(port)) {
> >+                              port->sm_mux_state =3D AD_MUX_ATTACHED;
> >+                      } else if ((port->sm_vars & AD_PORT_SELECTED) &&
> >+                          (port->partner_oper.port_state & LACP_STATE_S=
YNCHRONIZATION) &&
> >+                          (port->partner_oper.port_state & LACP_STATE_C=
OLLECTING)) {
> >+                              port->sm_mux_state =3D AD_MUX_DISTRIBUTIN=
G;
> >+                      } else {
> >+                              /* If port state hasn't changed, make sur=
e that a collecting
> >+                               * port is enabled for an active aggregat=
or.
> >+                               */
> >+                              if (port->aggregator &&
> >+                                  port->aggregator->is_active) {
>
>         Same comment as previous.
>
> >+                                      struct slave *slave =3D port->sla=
ve;
> >+
> >+                                      if (bond_is_slave_rx_disabled(sla=
ve) !=3D 0) {
>
>         The "!=3D 0" is superfluous here as bond_is_slave_rx_disabled()
> returns a boolean.
>
> >+                                              ad_enable_collecting(port=
);
> >+                                              *update_slave_arr =3D tru=
e;
> >+                                      }
> >+                              }
> >+                      }
> >+                      break;
> >+              case AD_MUX_DISTRIBUTING:
> >                       if (!(port->sm_vars & AD_PORT_SELECTED) ||
> >                           (port->sm_vars & AD_PORT_STANDBY) ||
> >+                          !(port->partner_oper.port_state & LACP_STATE_=
COLLECTING) ||
> >                           !(port->partner_oper.port_state & LACP_STATE_=
SYNCHRONIZATION) ||
> >                           !(port->actor_oper_port_state & LACP_STATE_SY=
NCHRONIZATION)) {
> >-                              port->sm_mux_state =3D AD_MUX_ATTACHED;
> >+                              port->sm_mux_state =3D AD_MUX_COLLECTING;
> >                       } else {
> >                               /* if port state hasn't changed make
> >                                * sure that a collecting distributing
> >@@ -1031,7 +1123,7 @@ static void ad_mux_machine(struct port *port, bool=
 *update_slave_arr)
> >                                */
> >                               if (port->aggregator &&
> >                                   port->aggregator->is_active &&
> >-                                  !__port_is_enabled(port)) {
> >+                                  !__port_is_collecting_distributing(po=
rt)) {
> >                                       __enable_port(port);
> >                                       *update_slave_arr =3D true;
> >                               }
> >@@ -1082,6 +1174,20 @@ static void ad_mux_machine(struct port *port, boo=
l *update_slave_arr)
> >                                                         update_slave_ar=
r);
> >                       port->ntt =3D true;
> >                       break;
> >+              case AD_MUX_COLLECTING:
> >+                      port->actor_oper_port_state |=3D LACP_STATE_COLLE=
CTING;
> >+                      port->actor_oper_port_state &=3D ~LACP_STATE_DIST=
RIBUTING;
> >+                      port->actor_oper_port_state |=3D LACP_STATE_SYNCH=
RONIZATION;
> >+                      ad_enable_collecting(port);
> >+                      ad_disable_distributing(port, update_slave_arr);
> >+                      port->ntt =3D true;
> >+                      break;
> >+              case AD_MUX_DISTRIBUTING:
> >+                      port->actor_oper_port_state |=3D LACP_STATE_DISTR=
IBUTING;
> >+                      port->actor_oper_port_state |=3D LACP_STATE_SYNCH=
RONIZATION;
> >+                      ad_enable_collecting_distributing(port,
> >+                                                        update_slave_ar=
r);
> >+                      break;
> >               default:
> >                       break;
> >               }
> >@@ -1906,6 +2012,45 @@ static void ad_initialize_port(struct port *port,=
 int lacp_fast)
> >       }
> > }
> >
> >+/**
> >+ * ad_enable_collecting - enable a port's receive
> >+ * @port: the port we're looking at
> >+ *
> >+ * Enable @port if it's in an active aggregator
> >+ */
> >+static void ad_enable_collecting(struct port *port)
> >+{
> >+      if (port->aggregator->is_active) {
> >+              struct slave *slave =3D port->slave;
> >+
> >+              slave_dbg(slave->bond->dev, slave->dev,
> >+                        "Enabling collecting on port %d (LAG %d)\n",
> >+                        port->actor_port_number,
> >+                        port->aggregator->aggregator_identifier);
> >+              __enable_collecting_port(port);
> >+      }
> >+}
> >+
> >+/**
> >+ * ad_disable_distributing - disable a port's transmit
> >+ * @port: the port we're looking at
> >+ * @update_slave_arr: Does slave array need update?
> >+ */
> >+static void ad_disable_distributing(struct port *port, bool *update_sla=
ve_arr)
> >+{
> >+      if (port->aggregator &&
> >+          !MAC_ADDRESS_EQUAL(&port->aggregator->partner_system,
> >+                             &(null_mac_addr))) {
> >+              slave_dbg(port->slave->bond->dev, port->slave->dev,
> >+                        "Disabling distributing on port %d (LAG %d)\n",
> >+                        port->actor_port_number,
> >+                        port->aggregator->aggregator_identifier);
> >+              __disable_distributing_port(port);
> >+              /* Slave array needs an update */
> >+              *update_slave_arr =3D true;
> >+      }
> >+}
> >+
> > /**
> >  * ad_enable_collecting_distributing - enable a port's transmit/receive
> >  * @port: the port we're looking at
> >diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_=
main.c
> >index 8e6cc0e133b7..30f4b0ff01c0 100644
> >--- a/drivers/net/bonding/bond_main.c
> >+++ b/drivers/net/bonding/bond_main.c
> >@@ -6331,6 +6331,7 @@ static int __init bond_check_params(struct bond_pa=
rams *params)
> >       params->ad_actor_sys_prio =3D ad_actor_sys_prio;
> >       eth_zero_addr(params->ad_actor_system);
> >       params->ad_user_port_key =3D ad_user_port_key;
> >+      params->coupled_control =3D 1;
> >       if (packets_per_slave > 0) {
> >               params->reciprocal_packets_per_slave =3D
> >                       reciprocal_value(packets_per_slave);
> >diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bo=
nd_netlink.c
> >index cfa74cf8bb1a..29b4c3d1b9b6 100644
> >--- a/drivers/net/bonding/bond_netlink.c
> >+++ b/drivers/net/bonding/bond_netlink.c
> >@@ -122,6 +122,7 @@ static const struct nla_policy bond_policy[IFLA_BOND=
_MAX + 1] =3D {
> >       [IFLA_BOND_PEER_NOTIF_DELAY]    =3D NLA_POLICY_FULL_RANGE(NLA_U32=
, &delay_range),
> >       [IFLA_BOND_MISSED_MAX]          =3D { .type =3D NLA_U8 },
> >       [IFLA_BOND_NS_IP6_TARGET]       =3D { .type =3D NLA_NESTED },
> >+      [IFLA_BOND_COUPLED_CONTROL]     =3D { .type =3D NLA_U8 },
> > };
> >
> > static const struct nla_policy bond_slave_policy[IFLA_BOND_SLAVE_MAX + =
1] =3D {
> >@@ -549,6 +550,16 @@ static int bond_changelink(struct net_device *bond_=
dev, struct nlattr *tb[],
> >                       return err;
> >       }
> >
> >+      if (data[IFLA_BOND_COUPLED_CONTROL]) {
> >+              int coupled_control =3D nla_get_u8(data[IFLA_BOND_COUPLED=
_CONTROL]);
> >+
> >+              bond_opt_initval(&newval, coupled_control);
> >+              err =3D __bond_opt_set(bond, BOND_OPT_COUPLED_CONTROL, &n=
ewval,
> >+                                   data[IFLA_BOND_COUPLED_CONTROL], ext=
ack);
> >+              if (err)
> >+                      return err;
> >+      }
> >+
> >       return 0;
> > }
> >
> >@@ -615,6 +626,7 @@ static size_t bond_get_size(const struct net_device =
*bond_dev)
> >                                               /* IFLA_BOND_NS_IP6_TARGE=
T */
> >               nla_total_size(sizeof(struct nlattr)) +
> >               nla_total_size(sizeof(struct in6_addr)) * BOND_MAX_NS_TAR=
GETS +
> >+              nla_total_size(sizeof(u8)) +    /* IFLA_BOND_COUPLED_CONT=
ROL */
> >               0;
> > }
> >
> >@@ -774,6 +786,10 @@ static int bond_fill_info(struct sk_buff *skb,
> >                      bond->params.missed_max))
> >               goto nla_put_failure;
> >
> >+      if (nla_put_u8(skb, IFLA_BOND_COUPLED_CONTROL,
> >+                     bond->params.coupled_control))
> >+              goto nla_put_failure;
> >+
> >       if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD) {
> >               struct ad_info info;
> >
> >diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bo=
nd_options.c
> >index f3f27f0bd2a6..af5d3c57700b 100644
> >--- a/drivers/net/bonding/bond_options.c
> >+++ b/drivers/net/bonding/bond_options.c
> >@@ -84,7 +84,8 @@ static int bond_option_ad_user_port_key_set(struct bon=
ding *bond,
> >                                           const struct bond_opt_value *=
newval);
> > static int bond_option_missed_max_set(struct bonding *bond,
> >                                     const struct bond_opt_value *newval=
);
> >-
> >+static int bond_option_coupled_control_set(struct bonding *bond,
> >+                                         const struct bond_opt_value *n=
ewval);
> >
> > static const struct bond_opt_value bond_mode_tbl[] =3D {
> >       { "balance-rr",    BOND_MODE_ROUNDROBIN,   BOND_VALFLAG_DEFAULT},
> >@@ -232,6 +233,12 @@ static const struct bond_opt_value bond_missed_max_=
tbl[] =3D {
> >       { NULL,         -1,     0},
> > };
> >
> >+static const struct bond_opt_value bond_coupled_control_tbl[] =3D {
> >+      { "on",  1,  BOND_VALFLAG_DEFAULT},
> >+      { "off", 0,  0},
> >+      { NULL,  -1, 0},
> >+};
> >+
> > static const struct bond_option bond_opts[BOND_OPT_LAST] =3D {
> >       [BOND_OPT_MODE] =3D {
> >               .id =3D BOND_OPT_MODE,
> >@@ -496,6 +503,14 @@ static const struct bond_option bond_opts[BOND_OPT_=
LAST] =3D {
> >               .desc =3D "Delay between each peer notification on failov=
er event, in milliseconds",
> >               .values =3D bond_peer_notif_delay_tbl,
> >               .set =3D bond_option_peer_notif_delay_set
> >+      },
> >+      [BOND_OPT_COUPLED_CONTROL] =3D {
> >+              .id =3D BOND_OPT_COUPLED_CONTROL,
> >+              .name =3D "coupled_control",
> >+              .desc =3D "Opt into using coupled control MUX for LACP st=
ates",
> >+              .unsuppmodes =3D BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
> >+              .values =3D bond_coupled_control_tbl,
> >+              .set =3D bond_option_coupled_control_set,
> >       }
> > };
> >
> >@@ -1692,3 +1707,12 @@ static int bond_option_ad_user_port_key_set(struc=
t bonding *bond,
> >       bond->params.ad_user_port_key =3D newval->value;
> >       return 0;
> > }
> >+
> >+static int bond_option_coupled_control_set(struct bonding *bond,
> >+                                         const struct bond_opt_value *n=
ewval)
> >+{
> >+      netdev_info(bond->dev, "Setting coupled_control to %s (%llu)\n",
> >+                  newval->string, newval->value);
> >+      bond->params.coupled_control =3D newval->value;
> >+      return 0;
> >+}
>
>         I believe this should permit changes to coupled_control only if
> the bond is down, or up with no interfaces attached to it.  The two
> state machines are not interchangable.
>
>         -J
>
> >diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
> >index c5e57c6bd873..9ce5ac2bfbad 100644
> >--- a/include/net/bond_3ad.h
> >+++ b/include/net/bond_3ad.h
> >@@ -54,6 +54,8 @@ typedef enum {
> >       AD_MUX_DETACHED,        /* mux machine */
> >       AD_MUX_WAITING,         /* mux machine */
> >       AD_MUX_ATTACHED,        /* mux machine */
> >+      AD_MUX_COLLECTING,      /* mux machine */
> >+      AD_MUX_DISTRIBUTING,    /* mux machine */
> >       AD_MUX_COLLECTING_DISTRIBUTING  /* mux machine */
> > } mux_states_t;
> >
> >diff --git a/include/net/bond_options.h b/include/net/bond_options.h
> >index 69292ecc0325..473a0147769e 100644
> >--- a/include/net/bond_options.h
> >+++ b/include/net/bond_options.h
> >@@ -76,6 +76,7 @@ enum {
> >       BOND_OPT_MISSED_MAX,
> >       BOND_OPT_NS_TARGETS,
> >       BOND_OPT_PRIO,
> >+      BOND_OPT_COUPLED_CONTROL,
> >       BOND_OPT_LAST
> > };
> >
> >diff --git a/include/net/bonding.h b/include/net/bonding.h
> >index 5b8b1b644a2d..b61fb1aa3a56 100644
> >--- a/include/net/bonding.h
> >+++ b/include/net/bonding.h
> >@@ -148,6 +148,7 @@ struct bond_params {
> > #if IS_ENABLED(CONFIG_IPV6)
> >       struct in6_addr ns_targets[BOND_MAX_NS_TARGETS];
> > #endif
> >+      int coupled_control;
> >
> >       /* 2 bytes of padding : see ether_addr_equal_64bits() */
> >       u8 ad_actor_system[ETH_ALEN + 2];
> >@@ -167,6 +168,7 @@ struct slave {
> >       u8     backup:1,   /* indicates backup slave. Value corresponds w=
ith
> >                             BOND_STATE_ACTIVE and BOND_STATE_BACKUP */
> >              inactive:1, /* indicates inactive slave */
> >+             rx_disabled:1, /* indicates whether slave's Rx is disabled=
 */
> >              should_notify:1, /* indicates whether the state changed */
> >              should_notify_link:1; /* indicates whether the link change=
d */
> >       u8     duplex;
> >@@ -568,6 +570,14 @@ static inline void bond_set_slave_inactive_flags(st=
ruct slave *slave,
> >               bond_set_slave_state(slave, BOND_STATE_BACKUP, notify);
> >       if (!slave->bond->params.all_slaves_active)
> >               slave->inactive =3D 1;
> >+      if (BOND_MODE(slave->bond) =3D=3D BOND_MODE_8023AD)
> >+              slave->rx_disabled =3D 1;
> >+}
> >+
> >+static inline void bond_set_slave_tx_disabled_flags(struct slave *slave=
,
> >+                                               bool notify)
> >+{
> >+      bond_set_slave_state(slave, BOND_STATE_BACKUP, notify);
> > }
> >
> > static inline void bond_set_slave_active_flags(struct slave *slave,
> >@@ -575,6 +585,14 @@ static inline void bond_set_slave_active_flags(stru=
ct slave *slave,
> > {
> >       bond_set_slave_state(slave, BOND_STATE_ACTIVE, notify);
> >       slave->inactive =3D 0;
> >+      if (BOND_MODE(slave->bond) =3D=3D BOND_MODE_8023AD)
> >+              slave->rx_disabled =3D 0;
> >+}
> >+
> >+static inline void bond_set_slave_rx_enabled_flags(struct slave *slave,
> >+                                             bool notify)
> >+{
> >+      slave->rx_disabled =3D 0;
> > }
> >
> > static inline bool bond_is_slave_inactive(struct slave *slave)
> >@@ -582,6 +600,11 @@ static inline bool bond_is_slave_inactive(struct sl=
ave *slave)
> >       return slave->inactive;
> > }
> >
> >+static inline bool bond_is_slave_rx_disabled(struct slave *slave)
> >+{
> >+      return slave->rx_disabled;
> >+}
> >+
> > static inline void bond_propose_link_state(struct slave *slave, int sta=
te)
> > {
> >       slave->link_new_state =3D state;
> >diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> >index 29ff80da2775..7a54fcff2eec 100644
> >--- a/include/uapi/linux/if_link.h
> >+++ b/include/uapi/linux/if_link.h
> >@@ -976,6 +976,7 @@ enum {
> >       IFLA_BOND_AD_LACP_ACTIVE,
> >       IFLA_BOND_MISSED_MAX,
> >       IFLA_BOND_NS_IP6_TARGET,
> >+      IFLA_BOND_COUPLED_CONTROL,
> >       __IFLA_BOND_MAX,
> > };
> >
> >diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/lin=
ux/if_link.h
> >index a0aa05a28cf2..f0d71b2a3f1e 100644
> >--- a/tools/include/uapi/linux/if_link.h
> >+++ b/tools/include/uapi/linux/if_link.h
> >@@ -974,6 +974,7 @@ enum {
> >       IFLA_BOND_AD_LACP_ACTIVE,
> >       IFLA_BOND_MISSED_MAX,
> >       IFLA_BOND_NS_IP6_TARGET,
> >+      IFLA_BOND_COUPLED_CONTROL,
> >       __IFLA_BOND_MAX,
> > };
> >
> >--
> >2.43.0.472.g3155946c3a-goog
> >
> >
>
> ---
>         -Jay Vosburgh, jay.vosburgh@canonical.com

