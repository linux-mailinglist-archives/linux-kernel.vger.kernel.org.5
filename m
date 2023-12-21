Return-Path: <linux-kernel+bounces-7755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ED581ACAD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6631C22F53
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A003C0F;
	Thu, 21 Dec 2023 02:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bqSQbj/f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814D939E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 02:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aahila.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e20c9c4080so7015237b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 18:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703126220; x=1703731020; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ReLvpjxIeLuqm4KzPCkQ7iAEQpwV08JWb0NQLf5aI7s=;
        b=bqSQbj/fbz+xSfHvsn0yiIEal1ZGO53GkFjIWy2bZse2PMKVIXsCVX9i5bg0Cprlel
         pWLmr8qvQBpgLXcxI5m4+1rzoOG3KbVN9W8Enyx+YE9SGvEioRabnL041RATCtbQ7weU
         La71iOXyEy5BDCEAZb3WTxgrpG7AXVAGAxsGa+D7bf7AhFUQ/r8j7s9BkJTeeDmgrnYB
         51Ua/1cnGEiZ5qaLY4JcVSXzSwfR7m+1AgEnz2V0vt577SAgK1yAkbDAs3mV1eM6kZny
         1aNG4/X//zi369DQf405r/s0YME99ksaOasEWRY3FkexF/J43b7fOjtfq9NKjvVR50Sk
         GD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703126220; x=1703731020;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ReLvpjxIeLuqm4KzPCkQ7iAEQpwV08JWb0NQLf5aI7s=;
        b=nuH9vtQxqGmyT94D3TnoFFuvpb7ZiIo3YNhzKWcAlLeoA0zb4XQdVQMYG5Xw0zYTBI
         /LIcA1Yst+tjVf6327K3R0g+rpgLFac4dJ/WT2vfOrJYety+jjd8gOlBmfVOJciQBitX
         s8wDV3QMJhQZT8mJIPelI0sS7aPOGI29xIDKGXNjx+ozJEe8aZvqBEHxIF3nic3akoN+
         0GTJEEbnqT80zMJdPGLQPs72qrNTYMA/QUGDwrD/Fs60WUOHW11TV4RnY30+R5hA5Pu0
         adZo1U4jxVO5syWexrKEpTe0ItZePBbORh+q4j7QhP7G1cH03PrEn5NUJIt/fsJEhUry
         sp6Q==
X-Gm-Message-State: AOJu0YycYOnhv23hKWfockJr2fhFqhdQSvkbp/fAa1YSGSmVZFTUgHjP
	xKvDG9yJ5tyxGgTFgu01HziTNxore68=
X-Google-Smtp-Source: AGHT+IHHu2Lme03fCRTMUjP6gFg3bSa6l4JtFNbxxqZQ+xHw9nY5+fP2/WdSmsrzkCAC6GzOfUqT3097Pks=
X-Received: from aahila.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2f3])
 (user=aahila job=sendgmr) by 2002:a05:690c:3386:b0:5e8:90de:db6c with SMTP id
 fl6-20020a05690c338600b005e890dedb6cmr417927ywb.1.1703126220548; Wed, 20 Dec
 2023 18:37:00 -0800 (PST)
Date: Thu, 21 Dec 2023 02:36:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231221023650.3208767-1-aahila@google.com>
Subject: [PATCH next] bonding: Extending LACP MUX State Machine to include a
 Collecting State.
From: Aahil Awatramani <aahila@google.com>
To: Aahil Awatramani <aahila@google.com>, Mahesh Bandewar <maheshb@google.com>, 
	Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduces two new states, AD_MUX_COLLECTING and AD_MUX_DISTRIBUTING in
the LACP MUX state machine for separated handling of an initial
Collecting state before the Collecting and Distributing state. This
enables a port to be in a state where it can receive incoming packets
while not still distributing. This is useful for reducing packet loss when
a port begins distributing before its partner is able to collect.
Additionally this also brings the 802.3ad bonding driver's implementation
closer to the LACP specification which already predefined this behaviour.

With this change, 802.3ad mode will use new
bond_set_slave_txrx_{enabled|disabled}_flags() set of functions only
instead of the earlier one (bond_set_slave_{active|inactive}_flags).
Additionally, it adds new functions such as
bond_set_slave_tx_disabled_flags and bond_set_slave_rx_enabled_flags to
precisely manage the port's collecting and distributing states.
Previously, there was no dedicated method to disable TX while keeping RX
enabled, which this patch addresses.

Note that the regular flow process in the kernel's bonding driver remains
unaffected by this patch. The extension requires explicit opt-in by the
user (in order to ensure no disruptions for existing setups) via netlink
or sysfs support using the new bonding parameter lacp_extended_mux. The
default value for lacp_extended_mux is set to 0 so as to preserve existing
behaviour.

Signed-off-by: Aahil Awatramani <aahila@google.com>
---
 drivers/net/bonding/bond_3ad.c     | 155 +++++++++++++++++++++++++++--
 drivers/net/bonding/bond_main.c    |  22 ++--
 drivers/net/bonding/bond_netlink.c |  16 +++
 drivers/net/bonding/bond_options.c |  26 ++++-
 drivers/net/bonding/bond_sysfs.c   |  12 +++
 include/net/bond_3ad.h             |   2 +
 include/net/bond_options.h         |   1 +
 include/net/bonding.h              |  33 ++++++
 include/uapi/linux/if_link.h       |   1 +
 tools/include/uapi/linux/if_link.h |   1 +
 10 files changed, 254 insertions(+), 15 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index c99ffe6c683a..38a7aa6e4edd 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -106,6 +106,9 @@ static void ad_agg_selection_logic(struct aggregator *aggregator,
 static void ad_clear_agg(struct aggregator *aggregator);
 static void ad_initialize_agg(struct aggregator *aggregator);
 static void ad_initialize_port(struct port *port, int lacp_fast);
+static void ad_enable_collecting(struct port *port);
+static void ad_disable_distributing(struct port *port,
+				    bool *update_slave_arr);
 static void ad_enable_collecting_distributing(struct port *port,
 					      bool *update_slave_arr);
 static void ad_disable_collecting_distributing(struct port *port,
@@ -171,32 +174,64 @@ static inline int __agg_has_partner(struct aggregator *agg)
 	return !is_zero_ether_addr(agg->partner_system.mac_addr_value);
 }
 
+/**
+ * __disable_distributing_port - disable the port's slave for distributing.
+ * Port will still be able to collect.
+ * @port: the port we're looking at
+ *
+ * This will disable only distributing on the port's slave.
+ */
+static inline void __disable_distributing_port(struct port *port)
+{
+	bond_set_slave_tx_disabled_flags(port->slave, BOND_SLAVE_NOTIFY_LATER);
+}
+
+/**
+ * __enable_collecting_port - enable the port's slave for collecting,
+ * if it's up
+ * @port: the port we're looking at
+ *
+ * This will enable only collecting on the port's slave.
+ */
+static inline void __enable_collecting_port(struct port *port)
+{
+	struct slave *slave = port->slave;
+
+	if (slave->link == BOND_LINK_UP && bond_slave_is_up(slave))
+		bond_set_slave_rx_enabled_flags(slave, BOND_SLAVE_NOTIFY_LATER);
+}
+
 /**
  * __disable_port - disable the port's slave
  * @port: the port we're looking at
+ *
+ * This will disable both collecting and distributing on the port's slave.
  */
 static inline void __disable_port(struct port *port)
 {
-	bond_set_slave_inactive_flags(port->slave, BOND_SLAVE_NOTIFY_LATER);
+	bond_set_slave_txrx_disabled_flags(port->slave, BOND_SLAVE_NOTIFY_LATER);
 }
 
 /**
  * __enable_port - enable the port's slave, if it's up
  * @port: the port we're looking at
+ *
+ * This will enable both collecting and distributing on the port's slave.
  */
 static inline void __enable_port(struct port *port)
 {
 	struct slave *slave = port->slave;
 
 	if ((slave->link == BOND_LINK_UP) && bond_slave_is_up(slave))
-		bond_set_slave_active_flags(slave, BOND_SLAVE_NOTIFY_LATER);
+		bond_set_slave_txrx_enabled_flags(slave, BOND_SLAVE_NOTIFY_LATER);
 }
 
 /**
- * __port_is_enabled - check if the port's slave is in active state
+ * __port_is_collecting_distributing - check if the port's slave is in the
+ * combined collecting/distributing state
  * @port: the port we're looking at
  */
-static inline int __port_is_enabled(struct port *port)
+static inline int __port_is_collecting_distributing(struct port *port)
 {
 	return bond_is_active_slave(port->slave);
 }
@@ -942,6 +977,7 @@ static int ad_marker_send(struct port *port, struct bond_marker *marker)
  */
 static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 {
+	struct bonding *bond = __get_bond_by_port(port);
 	mux_states_t last_state;
 
 	/* keep current State Machine state to compare later if it was
@@ -999,9 +1035,13 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 			if ((port->sm_vars & AD_PORT_SELECTED) &&
 			    (port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) &&
 			    !__check_agg_selection_timer(port)) {
-				if (port->aggregator->is_active)
-					port->sm_mux_state =
-					    AD_MUX_COLLECTING_DISTRIBUTING;
+				if (port->aggregator->is_active) {
+					int state = AD_MUX_COLLECTING_DISTRIBUTING;
+
+					if (bond->params.lacp_extended_mux)
+						state = AD_MUX_COLLECTING;
+					port->sm_mux_state = state;
+				}
 			} else if (!(port->sm_vars & AD_PORT_SELECTED) ||
 				   (port->sm_vars & AD_PORT_STANDBY)) {
 				/* if UNSELECTED or STANDBY */
@@ -1031,7 +1071,52 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 				 */
 				if (port->aggregator &&
 				    port->aggregator->is_active &&
-				    !__port_is_enabled(port)) {
+				    !__port_is_collecting_distributing(port)) {
+					__enable_port(port);
+					*update_slave_arr = true;
+				}
+			}
+			break;
+		case AD_MUX_COLLECTING:
+			if (!(port->sm_vars & AD_PORT_SELECTED) ||
+			    (port->sm_vars & AD_PORT_STANDBY) ||
+			    !(port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) ||
+			    !(port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION)) {
+				port->sm_mux_state = AD_MUX_ATTACHED;
+			} else if ((port->sm_vars & AD_PORT_SELECTED) &&
+			    (port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) &&
+			    (port->partner_oper.port_state & LACP_STATE_COLLECTING)) {
+				port->sm_mux_state = AD_MUX_DISTRIBUTING;
+			} else {
+				/* If port state hasn't changed, make sure that a collecting
+				 * port is enabled for an active aggregator.
+				 */
+				if (port->aggregator &&
+				    port->aggregator->is_active) {
+					struct slave *slave = port->slave;
+
+					if (bond_is_slave_rx_disabled(slave) != 0) {
+						ad_enable_collecting(port);
+						*update_slave_arr = true;
+					}
+				}
+			}
+			break;
+		case AD_MUX_DISTRIBUTING:
+			if (!(port->sm_vars & AD_PORT_SELECTED) ||
+			    (port->sm_vars & AD_PORT_STANDBY) ||
+			    !(port->partner_oper.port_state & LACP_STATE_COLLECTING) ||
+			    !(port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) ||
+			    !(port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION)) {
+				port->sm_mux_state = AD_MUX_COLLECTING;
+			} else {
+				/* if port state hasn't changed make
+				 * sure that a collecting distributing
+				 * port in an active aggregator is enabled
+				 */
+				if (port->aggregator &&
+				    port->aggregator->is_active &&
+				    !__port_is_collecting_distributing(port)) {
 					__enable_port(port);
 					*update_slave_arr = true;
 				}
@@ -1082,6 +1167,20 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 							  update_slave_arr);
 			port->ntt = true;
 			break;
+		case AD_MUX_COLLECTING:
+			port->actor_oper_port_state |= LACP_STATE_COLLECTING;
+			port->actor_oper_port_state &= ~LACP_STATE_DISTRIBUTING;
+			port->actor_oper_port_state |= LACP_STATE_SYNCHRONIZATION;
+			ad_enable_collecting(port);
+			ad_disable_distributing(port, update_slave_arr);
+			port->ntt = true;
+			break;
+		case AD_MUX_DISTRIBUTING:
+			port->actor_oper_port_state |= LACP_STATE_DISTRIBUTING;
+			port->actor_oper_port_state |= LACP_STATE_SYNCHRONIZATION;
+			ad_enable_collecting_distributing(port,
+							  update_slave_arr);
+			break;
 		default:
 			break;
 		}
@@ -1906,6 +2005,46 @@ static void ad_initialize_port(struct port *port, int lacp_fast)
 	}
 }
 
+/**
+ * ad_enable_collecting - enable a port's receive
+ * @port: the port we're looking at
+ * @update_slave_arr: Does slave array need update?
+ *
+ * Enable @port if it's in an active aggregator
+ */
+static void ad_enable_collecting(struct port *port)
+{
+	if (port->aggregator->is_active) {
+		struct slave *slave = port->slave;
+
+		slave_dbg(slave->bond->dev, slave->dev,
+			  "Enabling collecting on port %d (LAG %d)\n",
+			  port->actor_port_number,
+			  port->aggregator->aggregator_identifier);
+		__enable_collecting_port(port);
+	}
+}
+
+/**
+ * ad_disable_distributing - disable a port's transmit
+ * @port: the port we're looking at
+ * @update_slave_arr: Does slave array need update?
+ */
+static void ad_disable_distributing(struct port *port, bool *update_slave_arr)
+{
+	if (port->aggregator &&
+	    !MAC_ADDRESS_EQUAL(&port->aggregator->partner_system,
+			       &(null_mac_addr))) {
+		slave_dbg(port->slave->bond->dev, port->slave->dev,
+			  "Disabling distributing on port %d (LAG %d)\n",
+			  port->actor_port_number,
+			  port->aggregator->aggregator_identifier);
+		__disable_distributing_port(port);
+		/* Slave array needs an update */
+		*update_slave_arr = true;
+	}
+}
+
 /**
  * ad_enable_collecting_distributing - enable a port's transmit/receive
  * @port: the port we're looking at
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 8e6cc0e133b7..6b8f001a51a5 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2119,7 +2119,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		 * will activate the slaves in the selected
 		 * aggregator
 		 */
-		bond_set_slave_inactive_flags(new_slave, BOND_SLAVE_NOTIFY_NOW);
+		bond_set_slave_txrx_disabled_flags(new_slave, BOND_SLAVE_NOTIFY_NOW);
 		/* if this is the first slave */
 		if (!prev_slave) {
 			SLAVE_AD_INFO(new_slave)->id = 1;
@@ -2381,7 +2381,10 @@ static int __bond_release_one(struct net_device *bond_dev,
 		return -EINVAL;
 	}
 
-	bond_set_slave_inactive_flags(slave, BOND_SLAVE_NOTIFY_NOW);
+	if (BOND_MODE(bond) == BOND_MODE_8023AD)
+		bond_set_slave_txrx_disabled_flags(slave, BOND_SLAVE_NOTIFY_NOW);
+	else
+		bond_set_slave_inactive_flags(slave, BOND_SLAVE_NOTIFY_NOW);
 
 	bond_sysfs_slave_del(slave);
 
@@ -2763,11 +2766,14 @@ static void bond_miimon_commit(struct bonding *bond)
 			bond_set_slave_link_state(slave, BOND_LINK_DOWN,
 						  BOND_SLAVE_NOTIFY_NOW);
 
-			if (BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP ||
-			    BOND_MODE(bond) == BOND_MODE_8023AD)
+			if (BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP)
 				bond_set_slave_inactive_flags(slave,
 							      BOND_SLAVE_NOTIFY_NOW);
 
+			if (BOND_MODE(bond) == BOND_MODE_8023AD)
+				bond_set_slave_txrx_disabled_flags(slave,
+								   BOND_SLAVE_NOTIFY_NOW);
+
 			slave_info(bond->dev, slave->dev, "link status definitely down, disabling slave\n");
 
 			bond_miimon_link_change(bond, slave, BOND_LINK_DOWN);
@@ -4276,8 +4282,12 @@ static int bond_open(struct net_device *bond_dev)
 		bond_for_each_slave(bond, slave, iter) {
 			if (bond_uses_primary(bond) &&
 			    slave != rcu_access_pointer(bond->curr_active_slave)) {
-				bond_set_slave_inactive_flags(slave,
-							      BOND_SLAVE_NOTIFY_NOW);
+				if (BOND_MODE(bond) == BOND_MODE_8023AD)
+					bond_set_slave_txrx_disabled_flags(slave,
+									   BOND_SLAVE_NOTIFY_NOW);
+				else
+					bond_set_slave_inactive_flags(slave,
+								      BOND_SLAVE_NOTIFY_NOW);
 			} else if (BOND_MODE(bond) != BOND_MODE_8023AD) {
 				bond_set_slave_active_flags(slave,
 							    BOND_SLAVE_NOTIFY_NOW);
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index cfa74cf8bb1a..1e671f504fc1 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -122,6 +122,7 @@ static const struct nla_policy bond_policy[IFLA_BOND_MAX + 1] = {
 	[IFLA_BOND_PEER_NOTIF_DELAY]    = NLA_POLICY_FULL_RANGE(NLA_U32, &delay_range),
 	[IFLA_BOND_MISSED_MAX]		= { .type = NLA_U8 },
 	[IFLA_BOND_NS_IP6_TARGET]	= { .type = NLA_NESTED },
+	[IFLA_BOND_LACP_EXTENDED_MUX]   = { .type = NLA_U8 },
 };
 
 static const struct nla_policy bond_slave_policy[IFLA_BOND_SLAVE_MAX + 1] = {
@@ -549,6 +550,16 @@ static int bond_changelink(struct net_device *bond_dev, struct nlattr *tb[],
 			return err;
 	}
 
+	if (data[IFLA_BOND_LACP_EXTENDED_MUX]) {
+		int lacp_extended_mux = nla_get_u8(data[IFLA_BOND_LACP_EXTENDED_MUX]);
+
+		bond_opt_initval(&newval, lacp_extended_mux);
+		err = __bond_opt_set(bond, BOND_OPT_LACP_EXTENDED_MUX, &newval,
+				     data[IFLA_BOND_LACP_EXTENDED_MUX], extack);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -615,6 +626,7 @@ static size_t bond_get_size(const struct net_device *bond_dev)
 						/* IFLA_BOND_NS_IP6_TARGET */
 		nla_total_size(sizeof(struct nlattr)) +
 		nla_total_size(sizeof(struct in6_addr)) * BOND_MAX_NS_TARGETS +
+		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_LACP_EXTENDED_MUX */
 		0;
 }
 
@@ -774,6 +786,10 @@ static int bond_fill_info(struct sk_buff *skb,
 		       bond->params.missed_max))
 		goto nla_put_failure;
 
+	if (nla_put_u8(skb, IFLA_BOND_LACP_EXTENDED_MUX,
+		       bond->params.lacp_extended_mux))
+		goto nla_put_failure;
+
 	if (BOND_MODE(bond) == BOND_MODE_8023AD) {
 		struct ad_info info;
 
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index f3f27f0bd2a6..c9997e42d045 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -84,7 +84,8 @@ static int bond_option_ad_user_port_key_set(struct bonding *bond,
 					    const struct bond_opt_value *newval);
 static int bond_option_missed_max_set(struct bonding *bond,
 				      const struct bond_opt_value *newval);
-
+static int bond_option_lacp_extended_mux_set(struct bonding *bond,
+					     const struct bond_opt_value *newval);
 
 static const struct bond_opt_value bond_mode_tbl[] = {
 	{ "balance-rr",    BOND_MODE_ROUNDROBIN,   BOND_VALFLAG_DEFAULT},
@@ -232,6 +233,12 @@ static const struct bond_opt_value bond_missed_max_tbl[] = {
 	{ NULL,		-1,	0},
 };
 
+static const struct bond_opt_value bond_lacp_extended_mux_tbl[] = {
+	{ "off", 0,  BOND_VALFLAG_DEFAULT},
+	{ "on",  1,  0},
+	{ NULL,  -1, 0},
+};
+
 static const struct bond_option bond_opts[BOND_OPT_LAST] = {
 	[BOND_OPT_MODE] = {
 		.id = BOND_OPT_MODE,
@@ -496,6 +503,14 @@ static const struct bond_option bond_opts[BOND_OPT_LAST] = {
 		.desc = "Delay between each peer notification on failover event, in milliseconds",
 		.values = bond_peer_notif_delay_tbl,
 		.set = bond_option_peer_notif_delay_set
+	},
+	[BOND_OPT_LACP_EXTENDED_MUX] = {
+		.id = BOND_OPT_LACP_EXTENDED_MUX,
+		.name = "lacp_extended_mux",
+		.desc = "Opt into using extended MUX for LACP states",
+		.unsuppmodes = BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
+		.values = bond_lacp_extended_mux_tbl,
+		.set = bond_option_lacp_extended_mux_set,
 	}
 };
 
@@ -1692,3 +1707,12 @@ static int bond_option_ad_user_port_key_set(struct bonding *bond,
 	bond->params.ad_user_port_key = newval->value;
 	return 0;
 }
+
+static int bond_option_lacp_extended_mux_set(struct bonding *bond,
+					     const struct bond_opt_value *newval)
+{
+	netdev_info(bond->dev, "Setting lacp_extended_mux to %s (%llu)\n",
+		    newval->string, newval->value);
+	bond->params.lacp_extended_mux = newval->value;
+	return 0;
+}
diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sysfs.c
index 2805135a7205..62e264010998 100644
--- a/drivers/net/bonding/bond_sysfs.c
+++ b/drivers/net/bonding/bond_sysfs.c
@@ -753,6 +753,17 @@ static ssize_t bonding_show_ad_user_port_key(struct device *d,
 static DEVICE_ATTR(ad_user_port_key, 0644,
 		   bonding_show_ad_user_port_key, bonding_sysfs_store_option);
 
+static ssize_t bonding_show_lacp_extended_mux(struct device *d,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct bonding *bond = to_bond(d);
+
+	return sprintf(buf, "%d\n", bond->params.lacp_extended_mux);
+}
+static DEVICE_ATTR(lacp_extended_mux, 0644,
+		   bonding_show_lacp_extended_mux, bonding_sysfs_store_option);
+
 static struct attribute *per_bond_attrs[] = {
 	&dev_attr_slaves.attr,
 	&dev_attr_mode.attr,
@@ -792,6 +803,7 @@ static struct attribute *per_bond_attrs[] = {
 	&dev_attr_ad_actor_system.attr,
 	&dev_attr_ad_user_port_key.attr,
 	&dev_attr_arp_missed_max.attr,
+	&dev_attr_lacp_extended_mux.attr,
 	NULL,
 };
 
diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
index c5e57c6bd873..9ce5ac2bfbad 100644
--- a/include/net/bond_3ad.h
+++ b/include/net/bond_3ad.h
@@ -54,6 +54,8 @@ typedef enum {
 	AD_MUX_DETACHED,	/* mux machine */
 	AD_MUX_WAITING,		/* mux machine */
 	AD_MUX_ATTACHED,	/* mux machine */
+	AD_MUX_COLLECTING,	/* mux machine */
+	AD_MUX_DISTRIBUTING,	/* mux machine */
 	AD_MUX_COLLECTING_DISTRIBUTING	/* mux machine */
 } mux_states_t;
 
diff --git a/include/net/bond_options.h b/include/net/bond_options.h
index 69292ecc0325..8d1e9cb28684 100644
--- a/include/net/bond_options.h
+++ b/include/net/bond_options.h
@@ -76,6 +76,7 @@ enum {
 	BOND_OPT_MISSED_MAX,
 	BOND_OPT_NS_TARGETS,
 	BOND_OPT_PRIO,
+	BOND_OPT_LACP_EXTENDED_MUX,
 	BOND_OPT_LAST
 };
 
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 5b8b1b644a2d..b31880d53d76 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -148,6 +148,7 @@ struct bond_params {
 #if IS_ENABLED(CONFIG_IPV6)
 	struct in6_addr ns_targets[BOND_MAX_NS_TARGETS];
 #endif
+	int lacp_extended_mux;
 
 	/* 2 bytes of padding : see ether_addr_equal_64bits() */
 	u8 ad_actor_system[ETH_ALEN + 2];
@@ -167,6 +168,7 @@ struct slave {
 	u8     backup:1,   /* indicates backup slave. Value corresponds with
 			      BOND_STATE_ACTIVE and BOND_STATE_BACKUP */
 	       inactive:1, /* indicates inactive slave */
+	       rx_disabled:1, /* indicates whether slave's Rx is disabled */
 	       should_notify:1, /* indicates whether the state changed */
 	       should_notify_link:1; /* indicates whether the link changed */
 	u8     duplex;
@@ -570,6 +572,19 @@ static inline void bond_set_slave_inactive_flags(struct slave *slave,
 		slave->inactive = 1;
 }
 
+static inline void bond_set_slave_txrx_disabled_flags(struct slave *slave,
+						 bool notify)
+{
+	bond_set_slave_state(slave, BOND_STATE_BACKUP, notify);
+	slave->rx_disabled = 1;
+}
+
+static inline void bond_set_slave_tx_disabled_flags(struct slave *slave,
+						 bool notify)
+{
+	bond_set_slave_state(slave, BOND_STATE_BACKUP, notify);
+}
+
 static inline void bond_set_slave_active_flags(struct slave *slave,
 					       bool notify)
 {
@@ -577,11 +592,29 @@ static inline void bond_set_slave_active_flags(struct slave *slave,
 	slave->inactive = 0;
 }
 
+static inline void bond_set_slave_txrx_enabled_flags(struct slave *slave,
+					       bool notify)
+{
+	bond_set_slave_state(slave, BOND_STATE_ACTIVE, notify);
+	slave->rx_disabled = 0;
+}
+
+static inline void bond_set_slave_rx_enabled_flags(struct slave *slave,
+					       bool notify)
+{
+	slave->rx_disabled = 0;
+}
+
 static inline bool bond_is_slave_inactive(struct slave *slave)
 {
 	return slave->inactive;
 }
 
+static inline bool bond_is_slave_rx_disabled(struct slave *slave)
+{
+	return slave->rx_disabled;
+}
+
 static inline void bond_propose_link_state(struct slave *slave, int state)
 {
 	slave->link_new_state = state;
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 29ff80da2775..e8fb30da9110 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -976,6 +976,7 @@ enum {
 	IFLA_BOND_AD_LACP_ACTIVE,
 	IFLA_BOND_MISSED_MAX,
 	IFLA_BOND_NS_IP6_TARGET,
+	IFLA_BOND_LACP_EXTENDED_MUX,
 	__IFLA_BOND_MAX,
 };
 
diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index a0aa05a28cf2..f641f55dbbc4 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -974,6 +974,7 @@ enum {
 	IFLA_BOND_AD_LACP_ACTIVE,
 	IFLA_BOND_MISSED_MAX,
 	IFLA_BOND_NS_IP6_TARGET,
+	IFLA_BOND_LACP_EXTENDED_MUX,
 	__IFLA_BOND_MAX,
 };
 
-- 
2.43.0.472.g3155946c3a-goog


