Return-Path: <linux-kernel+bounces-8950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C798081BE76
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8F61C24649
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1FF65196;
	Thu, 21 Dec 2023 18:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="quEBFpEC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11C41E48C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B295A3F73A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1703184531;
	bh=BqBKBOeKyM6VAC5gTMFoFwN8t4KFUppkArby5BxDwho=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=quEBFpECHpVj1pmV67Dj/Tbo5fAJUvDBsWdBYAB587db76Me7yfLccVOyqEqD89/d
	 HbqOluN6I/qPP1xvAEZLgPm1Hk6BK1O/PJ8E/DN2CIMiIlI++KpMrdBG4oNqfPOcNZ
	 ufQvtB4sFDct3MR5WCvi+8MpK9v51MTtVn1pSPuuFk71/Yfq/CsN3LaNSKhXOmMl/4
	 xBFrAeepb+RkjHFy5V6YinW7nxn58YQYG4hG633l8Z+4OcePianmlq+FZ0owSesaOC
	 JmiTVVeBQI/N4YDmuO6VVkhDBY/8XmSJLpnWgjwHycnUGg/I0zw9/0VHuDzM8+PtCO
	 9EJNhBkJawWyQ==
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5ca2b4038f7so480712a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:48:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703184530; x=1703789330;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BqBKBOeKyM6VAC5gTMFoFwN8t4KFUppkArby5BxDwho=;
        b=AWL85v3cT4AoRZj2wrAMKmWQjvsSaFhGPns5Kx7a2v9sL772L83YPtvGpz/05uwyb/
         zLut3y5zmfjG69/hjTYRuUPpWp2WyTQNXSazBFupABOykUh2bYPd+KdL7pI6ABMPTWhy
         oyBF9b6dfjniAPLsBB8t4RwRxxpNavqOpR8+TR2U6DFcr+dbQFobBne5lBpGTojyKlo6
         vFIOI69RdiiRVtx5tDPWeEjChAxnBu2+75vK/vSHM3BRR3j5KfXNv/cH4aeCusNbNnyQ
         GCkuCrftKX7sRNNUlwYofECHcC0KiJGB+kNfhJSxcOW6wNIJo3H5e0WeGWZfOpIlwyvJ
         RMiw==
X-Gm-Message-State: AOJu0YxEib4lM9/nHAA0uU6ZfR1pQlac1P7vQnRJpHwCvJHmJU2aZawe
	umit+EON62Wfm1SA4v7ta8qjDKCHE+PBZb3thWiS7QWT4seUPu0uTaJnZsG36cw67PsNdnsx3+q
	Hliq944o3rSapdakmu+Tmmk5/cVdzp2gfwVayyoQ8CpQ11SRM
X-Received: by 2002:a05:6a20:3ca6:b0:195:2618:aa89 with SMTP id b38-20020a056a203ca600b001952618aa89mr112712pzj.94.1703184529789;
        Thu, 21 Dec 2023 10:48:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEG7aGiRQ9NHdpwOeYhtQLf27nQqVbBXkQHSESPcoasTcvUUzY5bFF1P5YWhSMTsQIydryZ4g==
X-Received: by 2002:a05:6a20:3ca6:b0:195:2618:aa89 with SMTP id b38-20020a056a203ca600b001952618aa89mr112698pzj.94.1703184529340;
        Thu, 21 Dec 2023 10:48:49 -0800 (PST)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id i26-20020aa78b5a000000b006cdb17f9ffdsm1950523pfd.66.2023.12.21.10.48.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Dec 2023 10:48:49 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 80E695FF14; Thu, 21 Dec 2023 10:48:48 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 7A7499F85F;
	Thu, 21 Dec 2023 10:48:48 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Aahil Awatramani <aahila@google.com>
cc: Mahesh Bandewar <maheshb@google.com>,
    Andy Gospodarek <andy@greyhouse.net>,
    "David S . Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Martin KaFai Lau <martin.lau@kernel.org>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] bonding: Extending LACP MUX State Machine to include a Collecting State.
In-reply-to: <20231221023650.3208767-1-aahila@google.com>
References: <20231221023650.3208767-1-aahila@google.com>
Comments: In-reply-to Aahil Awatramani <aahila@google.com>
   message dated "Thu, 21 Dec 2023 02:36:50 +0000."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21528.1703184528.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 Dec 2023 10:48:48 -0800
Message-ID: <21529.1703184528@famine>

Aahil Awatramani <aahila@google.com> wrote:

>Introduces two new states, AD_MUX_COLLECTING and AD_MUX_DISTRIBUTING in
>the LACP MUX state machine for separated handling of an initial
>Collecting state before the Collecting and Distributing state. This
>enables a port to be in a state where it can receive incoming packets
>while not still distributing. This is useful for reducing packet loss whe=
n
>a port begins distributing before its partner is able to collect.
>Additionally this also brings the 802.3ad bonding driver's implementation
>closer to the LACP specification which already predefined this behaviour.

	To be clear, the current implementation (that combines
COLLECTING and DISTRIBUTING into a single state) is compliant with the
standard, which defines the current logic as "coupled control," per IEEE
802.1AX-2008, 5.4.15 or 802.1AX-2020, 6.4.13.

	I haven't read the patch in detail yet, but my overall question
is: why do we need this?  This adds significant complexity to the state
machine logic.  What real problem is this solving, i.e., what examples
do you have of systems where a port is "in a state where it can receive
incoming packets while not still distributing"?

	For the nomenclature, I would prefer to use the naming from the
standard.  Thus, instead of "lacp_extended_mux" my preference would be
"coupled_control", which would be enabled by default.  This extends to
the naming of variables or constants within the code as well.

	Lastly, in order to be accepted, this needs to include an update
to the bonding documentation.

	-J

>With this change, 802.3ad mode will use new
>bond_set_slave_txrx_{enabled|disabled}_flags() set of functions only
>instead of the earlier one (bond_set_slave_{active|inactive}_flags).
>Additionally, it adds new functions such as
>bond_set_slave_tx_disabled_flags and bond_set_slave_rx_enabled_flags to
>precisely manage the port's collecting and distributing states.
>Previously, there was no dedicated method to disable TX while keeping RX
>enabled, which this patch addresses.
>
>Note that the regular flow process in the kernel's bonding driver remains
>unaffected by this patch. The extension requires explicit opt-in by the
>user (in order to ensure no disruptions for existing setups) via netlink
>or sysfs support using the new bonding parameter lacp_extended_mux. The
>default value for lacp_extended_mux is set to 0 so as to preserve existin=
g
>behaviour.
>
>Signed-off-by: Aahil Awatramani <aahila@google.com>
>---
> drivers/net/bonding/bond_3ad.c     | 155 +++++++++++++++++++++++++++--
> drivers/net/bonding/bond_main.c    |  22 ++--
> drivers/net/bonding/bond_netlink.c |  16 +++
> drivers/net/bonding/bond_options.c |  26 ++++-
> drivers/net/bonding/bond_sysfs.c   |  12 +++
> include/net/bond_3ad.h             |   2 +
> include/net/bond_options.h         |   1 +
> include/net/bonding.h              |  33 ++++++
> include/uapi/linux/if_link.h       |   1 +
> tools/include/uapi/linux/if_link.h |   1 +
> 10 files changed, 254 insertions(+), 15 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3a=
d.c
>index c99ffe6c683a..38a7aa6e4edd 100644
>--- a/drivers/net/bonding/bond_3ad.c
>+++ b/drivers/net/bonding/bond_3ad.c
>@@ -106,6 +106,9 @@ static void ad_agg_selection_logic(struct aggregator =
*aggregator,
> static void ad_clear_agg(struct aggregator *aggregator);
> static void ad_initialize_agg(struct aggregator *aggregator);
> static void ad_initialize_port(struct port *port, int lacp_fast);
>+static void ad_enable_collecting(struct port *port);
>+static void ad_disable_distributing(struct port *port,
>+				    bool *update_slave_arr);
> static void ad_enable_collecting_distributing(struct port *port,
> 					      bool *update_slave_arr);
> static void ad_disable_collecting_distributing(struct port *port,
>@@ -171,32 +174,64 @@ static inline int __agg_has_partner(struct aggregat=
or *agg)
> 	return !is_zero_ether_addr(agg->partner_system.mac_addr_value);
> }
> =

>+/**
>+ * __disable_distributing_port - disable the port's slave for distributi=
ng.
>+ * Port will still be able to collect.
>+ * @port: the port we're looking at
>+ *
>+ * This will disable only distributing on the port's slave.
>+ */
>+static inline void __disable_distributing_port(struct port *port)
>+{
>+	bond_set_slave_tx_disabled_flags(port->slave, BOND_SLAVE_NOTIFY_LATER);
>+}
>+
>+/**
>+ * __enable_collecting_port - enable the port's slave for collecting,
>+ * if it's up
>+ * @port: the port we're looking at
>+ *
>+ * This will enable only collecting on the port's slave.
>+ */
>+static inline void __enable_collecting_port(struct port *port)
>+{
>+	struct slave *slave =3D port->slave;
>+
>+	if (slave->link =3D=3D BOND_LINK_UP && bond_slave_is_up(slave))
>+		bond_set_slave_rx_enabled_flags(slave, BOND_SLAVE_NOTIFY_LATER);
>+}
>+
> /**
>  * __disable_port - disable the port's slave
>  * @port: the port we're looking at
>+ *
>+ * This will disable both collecting and distributing on the port's slav=
e.
>  */
> static inline void __disable_port(struct port *port)
> {
>-	bond_set_slave_inactive_flags(port->slave, BOND_SLAVE_NOTIFY_LATER);
>+	bond_set_slave_txrx_disabled_flags(port->slave, BOND_SLAVE_NOTIFY_LATER=
);
> }
> =

> /**
>  * __enable_port - enable the port's slave, if it's up
>  * @port: the port we're looking at
>+ *
>+ * This will enable both collecting and distributing on the port's slave=
.
>  */
> static inline void __enable_port(struct port *port)
> {
> 	struct slave *slave =3D port->slave;
> =

> 	if ((slave->link =3D=3D BOND_LINK_UP) && bond_slave_is_up(slave))
>-		bond_set_slave_active_flags(slave, BOND_SLAVE_NOTIFY_LATER);
>+		bond_set_slave_txrx_enabled_flags(slave, BOND_SLAVE_NOTIFY_LATER);
> }
> =

> /**
>- * __port_is_enabled - check if the port's slave is in active state
>+ * __port_is_collecting_distributing - check if the port's slave is in t=
he
>+ * combined collecting/distributing state
>  * @port: the port we're looking at
>  */
>-static inline int __port_is_enabled(struct port *port)
>+static inline int __port_is_collecting_distributing(struct port *port)
> {
> 	return bond_is_active_slave(port->slave);
> }
>@@ -942,6 +977,7 @@ static int ad_marker_send(struct port *port, struct b=
ond_marker *marker)
>  */
> static void ad_mux_machine(struct port *port, bool *update_slave_arr)
> {
>+	struct bonding *bond =3D __get_bond_by_port(port);
> 	mux_states_t last_state;
> =

> 	/* keep current State Machine state to compare later if it was
>@@ -999,9 +1035,13 @@ static void ad_mux_machine(struct port *port, bool =
*update_slave_arr)
> 			if ((port->sm_vars & AD_PORT_SELECTED) &&
> 			    (port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) &&
> 			    !__check_agg_selection_timer(port)) {
>-				if (port->aggregator->is_active)
>-					port->sm_mux_state =3D
>-					    AD_MUX_COLLECTING_DISTRIBUTING;
>+				if (port->aggregator->is_active) {
>+					int state =3D AD_MUX_COLLECTING_DISTRIBUTING;
>+
>+					if (bond->params.lacp_extended_mux)
>+						state =3D AD_MUX_COLLECTING;
>+					port->sm_mux_state =3D state;
>+				}
> 			} else if (!(port->sm_vars & AD_PORT_SELECTED) ||
> 				   (port->sm_vars & AD_PORT_STANDBY)) {
> 				/* if UNSELECTED or STANDBY */
>@@ -1031,7 +1071,52 @@ static void ad_mux_machine(struct port *port, bool=
 *update_slave_arr)
> 				 */
> 				if (port->aggregator &&
> 				    port->aggregator->is_active &&
>-				    !__port_is_enabled(port)) {
>+				    !__port_is_collecting_distributing(port)) {
>+					__enable_port(port);
>+					*update_slave_arr =3D true;
>+				}
>+			}
>+			break;
>+		case AD_MUX_COLLECTING:
>+			if (!(port->sm_vars & AD_PORT_SELECTED) ||
>+			    (port->sm_vars & AD_PORT_STANDBY) ||
>+			    !(port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) ||
>+			    !(port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION)) {
>+				port->sm_mux_state =3D AD_MUX_ATTACHED;
>+			} else if ((port->sm_vars & AD_PORT_SELECTED) &&
>+			    (port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) &&
>+			    (port->partner_oper.port_state & LACP_STATE_COLLECTING)) {
>+				port->sm_mux_state =3D AD_MUX_DISTRIBUTING;
>+			} else {
>+				/* If port state hasn't changed, make sure that a collecting
>+				 * port is enabled for an active aggregator.
>+				 */
>+				if (port->aggregator &&
>+				    port->aggregator->is_active) {
>+					struct slave *slave =3D port->slave;
>+
>+					if (bond_is_slave_rx_disabled(slave) !=3D 0) {
>+						ad_enable_collecting(port);
>+						*update_slave_arr =3D true;
>+					}
>+				}
>+			}
>+			break;
>+		case AD_MUX_DISTRIBUTING:
>+			if (!(port->sm_vars & AD_PORT_SELECTED) ||
>+			    (port->sm_vars & AD_PORT_STANDBY) ||
>+			    !(port->partner_oper.port_state & LACP_STATE_COLLECTING) ||
>+			    !(port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) ||
>+			    !(port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION)) {
>+				port->sm_mux_state =3D AD_MUX_COLLECTING;
>+			} else {
>+				/* if port state hasn't changed make
>+				 * sure that a collecting distributing
>+				 * port in an active aggregator is enabled
>+				 */
>+				if (port->aggregator &&
>+				    port->aggregator->is_active &&
>+				    !__port_is_collecting_distributing(port)) {
> 					__enable_port(port);
> 					*update_slave_arr =3D true;
> 				}
>@@ -1082,6 +1167,20 @@ static void ad_mux_machine(struct port *port, bool=
 *update_slave_arr)
> 							  update_slave_arr);
> 			port->ntt =3D true;
> 			break;
>+		case AD_MUX_COLLECTING:
>+			port->actor_oper_port_state |=3D LACP_STATE_COLLECTING;
>+			port->actor_oper_port_state &=3D ~LACP_STATE_DISTRIBUTING;
>+			port->actor_oper_port_state |=3D LACP_STATE_SYNCHRONIZATION;
>+			ad_enable_collecting(port);
>+			ad_disable_distributing(port, update_slave_arr);
>+			port->ntt =3D true;
>+			break;
>+		case AD_MUX_DISTRIBUTING:
>+			port->actor_oper_port_state |=3D LACP_STATE_DISTRIBUTING;
>+			port->actor_oper_port_state |=3D LACP_STATE_SYNCHRONIZATION;
>+			ad_enable_collecting_distributing(port,
>+							  update_slave_arr);
>+			break;
> 		default:
> 			break;
> 		}
>@@ -1906,6 +2005,46 @@ static void ad_initialize_port(struct port *port, =
int lacp_fast)
> 	}
> }
> =

>+/**
>+ * ad_enable_collecting - enable a port's receive
>+ * @port: the port we're looking at
>+ * @update_slave_arr: Does slave array need update?
>+ *
>+ * Enable @port if it's in an active aggregator
>+ */
>+static void ad_enable_collecting(struct port *port)
>+{
>+	if (port->aggregator->is_active) {
>+		struct slave *slave =3D port->slave;
>+
>+		slave_dbg(slave->bond->dev, slave->dev,
>+			  "Enabling collecting on port %d (LAG %d)\n",
>+			  port->actor_port_number,
>+			  port->aggregator->aggregator_identifier);
>+		__enable_collecting_port(port);
>+	}
>+}
>+
>+/**
>+ * ad_disable_distributing - disable a port's transmit
>+ * @port: the port we're looking at
>+ * @update_slave_arr: Does slave array need update?
>+ */
>+static void ad_disable_distributing(struct port *port, bool *update_slav=
e_arr)
>+{
>+	if (port->aggregator &&
>+	    !MAC_ADDRESS_EQUAL(&port->aggregator->partner_system,
>+			       &(null_mac_addr))) {
>+		slave_dbg(port->slave->bond->dev, port->slave->dev,
>+			  "Disabling distributing on port %d (LAG %d)\n",
>+			  port->actor_port_number,
>+			  port->aggregator->aggregator_identifier);
>+		__disable_distributing_port(port);
>+		/* Slave array needs an update */
>+		*update_slave_arr =3D true;
>+	}
>+}
>+
> /**
>  * ad_enable_collecting_distributing - enable a port's transmit/receive
>  * @port: the port we're looking at
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 8e6cc0e133b7..6b8f001a51a5 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -2119,7 +2119,7 @@ int bond_enslave(struct net_device *bond_dev, struc=
t net_device *slave_dev,
> 		 * will activate the slaves in the selected
> 		 * aggregator
> 		 */
>-		bond_set_slave_inactive_flags(new_slave, BOND_SLAVE_NOTIFY_NOW);
>+		bond_set_slave_txrx_disabled_flags(new_slave, BOND_SLAVE_NOTIFY_NOW);
> 		/* if this is the first slave */
> 		if (!prev_slave) {
> 			SLAVE_AD_INFO(new_slave)->id =3D 1;
>@@ -2381,7 +2381,10 @@ static int __bond_release_one(struct net_device *b=
ond_dev,
> 		return -EINVAL;
> 	}
> =

>-	bond_set_slave_inactive_flags(slave, BOND_SLAVE_NOTIFY_NOW);
>+	if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD)
>+		bond_set_slave_txrx_disabled_flags(slave, BOND_SLAVE_NOTIFY_NOW);
>+	else
>+		bond_set_slave_inactive_flags(slave, BOND_SLAVE_NOTIFY_NOW);
> =

> 	bond_sysfs_slave_del(slave);
> =

>@@ -2763,11 +2766,14 @@ static void bond_miimon_commit(struct bonding *bo=
nd)
> 			bond_set_slave_link_state(slave, BOND_LINK_DOWN,
> 						  BOND_SLAVE_NOTIFY_NOW);
> =

>-			if (BOND_MODE(bond) =3D=3D BOND_MODE_ACTIVEBACKUP ||
>-			    BOND_MODE(bond) =3D=3D BOND_MODE_8023AD)
>+			if (BOND_MODE(bond) =3D=3D BOND_MODE_ACTIVEBACKUP)
> 				bond_set_slave_inactive_flags(slave,
> 							      BOND_SLAVE_NOTIFY_NOW);
> =

>+			if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD)
>+				bond_set_slave_txrx_disabled_flags(slave,
>+								   BOND_SLAVE_NOTIFY_NOW);
>+
> 			slave_info(bond->dev, slave->dev, "link status definitely down, disab=
ling slave\n");
> =

> 			bond_miimon_link_change(bond, slave, BOND_LINK_DOWN);
>@@ -4276,8 +4282,12 @@ static int bond_open(struct net_device *bond_dev)
> 		bond_for_each_slave(bond, slave, iter) {
> 			if (bond_uses_primary(bond) &&
> 			    slave !=3D rcu_access_pointer(bond->curr_active_slave)) {
>-				bond_set_slave_inactive_flags(slave,
>-							      BOND_SLAVE_NOTIFY_NOW);
>+				if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD)
>+					bond_set_slave_txrx_disabled_flags(slave,
>+									   BOND_SLAVE_NOTIFY_NOW);
>+				else
>+					bond_set_slave_inactive_flags(slave,
>+								      BOND_SLAVE_NOTIFY_NOW);
> 			} else if (BOND_MODE(bond) !=3D BOND_MODE_8023AD) {
> 				bond_set_slave_active_flags(slave,
> 							    BOND_SLAVE_NOTIFY_NOW);
>diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bon=
d_netlink.c
>index cfa74cf8bb1a..1e671f504fc1 100644
>--- a/drivers/net/bonding/bond_netlink.c
>+++ b/drivers/net/bonding/bond_netlink.c
>@@ -122,6 +122,7 @@ static const struct nla_policy bond_policy[IFLA_BOND_=
MAX + 1] =3D {
> 	[IFLA_BOND_PEER_NOTIF_DELAY]    =3D NLA_POLICY_FULL_RANGE(NLA_U32, &del=
ay_range),
> 	[IFLA_BOND_MISSED_MAX]		=3D { .type =3D NLA_U8 },
> 	[IFLA_BOND_NS_IP6_TARGET]	=3D { .type =3D NLA_NESTED },
>+	[IFLA_BOND_LACP_EXTENDED_MUX]   =3D { .type =3D NLA_U8 },
> };
> =

> static const struct nla_policy bond_slave_policy[IFLA_BOND_SLAVE_MAX + 1=
] =3D {
>@@ -549,6 +550,16 @@ static int bond_changelink(struct net_device *bond_d=
ev, struct nlattr *tb[],
> 			return err;
> 	}
> =

>+	if (data[IFLA_BOND_LACP_EXTENDED_MUX]) {
>+		int lacp_extended_mux =3D nla_get_u8(data[IFLA_BOND_LACP_EXTENDED_MUX]=
);
>+
>+		bond_opt_initval(&newval, lacp_extended_mux);
>+		err =3D __bond_opt_set(bond, BOND_OPT_LACP_EXTENDED_MUX, &newval,
>+				     data[IFLA_BOND_LACP_EXTENDED_MUX], extack);
>+		if (err)
>+			return err;
>+	}
>+
> 	return 0;
> }
> =

>@@ -615,6 +626,7 @@ static size_t bond_get_size(const struct net_device *=
bond_dev)
> 						/* IFLA_BOND_NS_IP6_TARGET */
> 		nla_total_size(sizeof(struct nlattr)) +
> 		nla_total_size(sizeof(struct in6_addr)) * BOND_MAX_NS_TARGETS +
>+		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_LACP_EXTENDED_MUX */
> 		0;
> }
> =

>@@ -774,6 +786,10 @@ static int bond_fill_info(struct sk_buff *skb,
> 		       bond->params.missed_max))
> 		goto nla_put_failure;
> =

>+	if (nla_put_u8(skb, IFLA_BOND_LACP_EXTENDED_MUX,
>+		       bond->params.lacp_extended_mux))
>+		goto nla_put_failure;
>+
> 	if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD) {
> 		struct ad_info info;
> =

>diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bon=
d_options.c
>index f3f27f0bd2a6..c9997e42d045 100644
>--- a/drivers/net/bonding/bond_options.c
>+++ b/drivers/net/bonding/bond_options.c
>@@ -84,7 +84,8 @@ static int bond_option_ad_user_port_key_set(struct bond=
ing *bond,
> 					    const struct bond_opt_value *newval);
> static int bond_option_missed_max_set(struct bonding *bond,
> 				      const struct bond_opt_value *newval);
>-
>+static int bond_option_lacp_extended_mux_set(struct bonding *bond,
>+					     const struct bond_opt_value *newval);
> =

> static const struct bond_opt_value bond_mode_tbl[] =3D {
> 	{ "balance-rr",    BOND_MODE_ROUNDROBIN,   BOND_VALFLAG_DEFAULT},
>@@ -232,6 +233,12 @@ static const struct bond_opt_value bond_missed_max_t=
bl[] =3D {
> 	{ NULL,		-1,	0},
> };
> =

>+static const struct bond_opt_value bond_lacp_extended_mux_tbl[] =3D {
>+	{ "off", 0,  BOND_VALFLAG_DEFAULT},
>+	{ "on",  1,  0},
>+	{ NULL,  -1, 0},
>+};
>+
> static const struct bond_option bond_opts[BOND_OPT_LAST] =3D {
> 	[BOND_OPT_MODE] =3D {
> 		.id =3D BOND_OPT_MODE,
>@@ -496,6 +503,14 @@ static const struct bond_option bond_opts[BOND_OPT_L=
AST] =3D {
> 		.desc =3D "Delay between each peer notification on failover event, in =
milliseconds",
> 		.values =3D bond_peer_notif_delay_tbl,
> 		.set =3D bond_option_peer_notif_delay_set
>+	},
>+	[BOND_OPT_LACP_EXTENDED_MUX] =3D {
>+		.id =3D BOND_OPT_LACP_EXTENDED_MUX,
>+		.name =3D "lacp_extended_mux",
>+		.desc =3D "Opt into using extended MUX for LACP states",
>+		.unsuppmodes =3D BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
>+		.values =3D bond_lacp_extended_mux_tbl,
>+		.set =3D bond_option_lacp_extended_mux_set,
> 	}
> };
> =

>@@ -1692,3 +1707,12 @@ static int bond_option_ad_user_port_key_set(struct=
 bonding *bond,
> 	bond->params.ad_user_port_key =3D newval->value;
> 	return 0;
> }
>+
>+static int bond_option_lacp_extended_mux_set(struct bonding *bond,
>+					     const struct bond_opt_value *newval)
>+{
>+	netdev_info(bond->dev, "Setting lacp_extended_mux to %s (%llu)\n",
>+		    newval->string, newval->value);
>+	bond->params.lacp_extended_mux =3D newval->value;
>+	return 0;
>+}
>diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_=
sysfs.c
>index 2805135a7205..62e264010998 100644
>--- a/drivers/net/bonding/bond_sysfs.c
>+++ b/drivers/net/bonding/bond_sysfs.c
>@@ -753,6 +753,17 @@ static ssize_t bonding_show_ad_user_port_key(struct =
device *d,
> static DEVICE_ATTR(ad_user_port_key, 0644,
> 		   bonding_show_ad_user_port_key, bonding_sysfs_store_option);
> =

>+static ssize_t bonding_show_lacp_extended_mux(struct device *d,
>+					      struct device_attribute *attr,
>+					      char *buf)
>+{
>+	struct bonding *bond =3D to_bond(d);
>+
>+	return sprintf(buf, "%d\n", bond->params.lacp_extended_mux);
>+}
>+static DEVICE_ATTR(lacp_extended_mux, 0644,
>+		   bonding_show_lacp_extended_mux, bonding_sysfs_store_option);
>+
> static struct attribute *per_bond_attrs[] =3D {
> 	&dev_attr_slaves.attr,
> 	&dev_attr_mode.attr,
>@@ -792,6 +803,7 @@ static struct attribute *per_bond_attrs[] =3D {
> 	&dev_attr_ad_actor_system.attr,
> 	&dev_attr_ad_user_port_key.attr,
> 	&dev_attr_arp_missed_max.attr,
>+	&dev_attr_lacp_extended_mux.attr,
> 	NULL,
> };
> =

>diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
>index c5e57c6bd873..9ce5ac2bfbad 100644
>--- a/include/net/bond_3ad.h
>+++ b/include/net/bond_3ad.h
>@@ -54,6 +54,8 @@ typedef enum {
> 	AD_MUX_DETACHED,	/* mux machine */
> 	AD_MUX_WAITING,		/* mux machine */
> 	AD_MUX_ATTACHED,	/* mux machine */
>+	AD_MUX_COLLECTING,	/* mux machine */
>+	AD_MUX_DISTRIBUTING,	/* mux machine */
> 	AD_MUX_COLLECTING_DISTRIBUTING	/* mux machine */
> } mux_states_t;
> =

>diff --git a/include/net/bond_options.h b/include/net/bond_options.h
>index 69292ecc0325..8d1e9cb28684 100644
>--- a/include/net/bond_options.h
>+++ b/include/net/bond_options.h
>@@ -76,6 +76,7 @@ enum {
> 	BOND_OPT_MISSED_MAX,
> 	BOND_OPT_NS_TARGETS,
> 	BOND_OPT_PRIO,
>+	BOND_OPT_LACP_EXTENDED_MUX,
> 	BOND_OPT_LAST
> };
> =

>diff --git a/include/net/bonding.h b/include/net/bonding.h
>index 5b8b1b644a2d..b31880d53d76 100644
>--- a/include/net/bonding.h
>+++ b/include/net/bonding.h
>@@ -148,6 +148,7 @@ struct bond_params {
> #if IS_ENABLED(CONFIG_IPV6)
> 	struct in6_addr ns_targets[BOND_MAX_NS_TARGETS];
> #endif
>+	int lacp_extended_mux;
> =

> 	/* 2 bytes of padding : see ether_addr_equal_64bits() */
> 	u8 ad_actor_system[ETH_ALEN + 2];
>@@ -167,6 +168,7 @@ struct slave {
> 	u8     backup:1,   /* indicates backup slave. Value corresponds with
> 			      BOND_STATE_ACTIVE and BOND_STATE_BACKUP */
> 	       inactive:1, /* indicates inactive slave */
>+	       rx_disabled:1, /* indicates whether slave's Rx is disabled */
> 	       should_notify:1, /* indicates whether the state changed */
> 	       should_notify_link:1; /* indicates whether the link changed */
> 	u8     duplex;
>@@ -570,6 +572,19 @@ static inline void bond_set_slave_inactive_flags(str=
uct slave *slave,
> 		slave->inactive =3D 1;
> }
> =

>+static inline void bond_set_slave_txrx_disabled_flags(struct slave *slav=
e,
>+						 bool notify)
>+{
>+	bond_set_slave_state(slave, BOND_STATE_BACKUP, notify);
>+	slave->rx_disabled =3D 1;
>+}
>+
>+static inline void bond_set_slave_tx_disabled_flags(struct slave *slave,
>+						 bool notify)
>+{
>+	bond_set_slave_state(slave, BOND_STATE_BACKUP, notify);
>+}
>+
> static inline void bond_set_slave_active_flags(struct slave *slave,
> 					       bool notify)
> {
>@@ -577,11 +592,29 @@ static inline void bond_set_slave_active_flags(stru=
ct slave *slave,
> 	slave->inactive =3D 0;
> }
> =

>+static inline void bond_set_slave_txrx_enabled_flags(struct slave *slave=
,
>+					       bool notify)
>+{
>+	bond_set_slave_state(slave, BOND_STATE_ACTIVE, notify);
>+	slave->rx_disabled =3D 0;
>+}
>+
>+static inline void bond_set_slave_rx_enabled_flags(struct slave *slave,
>+					       bool notify)
>+{
>+	slave->rx_disabled =3D 0;
>+}
>+
> static inline bool bond_is_slave_inactive(struct slave *slave)
> {
> 	return slave->inactive;
> }
> =

>+static inline bool bond_is_slave_rx_disabled(struct slave *slave)
>+{
>+	return slave->rx_disabled;
>+}
>+
> static inline void bond_propose_link_state(struct slave *slave, int stat=
e)
> {
> 	slave->link_new_state =3D state;
>diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
>index 29ff80da2775..e8fb30da9110 100644
>--- a/include/uapi/linux/if_link.h
>+++ b/include/uapi/linux/if_link.h
>@@ -976,6 +976,7 @@ enum {
> 	IFLA_BOND_AD_LACP_ACTIVE,
> 	IFLA_BOND_MISSED_MAX,
> 	IFLA_BOND_NS_IP6_TARGET,
>+	IFLA_BOND_LACP_EXTENDED_MUX,
> 	__IFLA_BOND_MAX,
> };
> =

>diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linu=
x/if_link.h
>index a0aa05a28cf2..f641f55dbbc4 100644
>--- a/tools/include/uapi/linux/if_link.h
>+++ b/tools/include/uapi/linux/if_link.h
>@@ -974,6 +974,7 @@ enum {
> 	IFLA_BOND_AD_LACP_ACTIVE,
> 	IFLA_BOND_MISSED_MAX,
> 	IFLA_BOND_NS_IP6_TARGET,
>+	IFLA_BOND_LACP_EXTENDED_MUX,
> 	__IFLA_BOND_MAX,
> };
> =

>-- =

>2.43.0.472.g3155946c3a-goog
>
>

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

