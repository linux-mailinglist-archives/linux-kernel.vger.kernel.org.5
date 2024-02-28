Return-Path: <linux-kernel+bounces-85236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B26986B2B7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31580284E00
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D652515B96C;
	Wed, 28 Feb 2024 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Luxv3QRq"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CCB14D44E;
	Wed, 28 Feb 2024 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132890; cv=none; b=J3vYB4J72teVRWCLKxveKgH1YzCDJYbAyKPKVcUG6wCAVrzbASGIiLoiF9rGaAkwWCl3cprp9y7J6qm5gL6JMLR6VuapZb5Qv8xIO11fzZ/WNgmrTv06lhDOblBF9XI2sStRDq4ZTGAlaGtlD/CK9uxoFa/1S6oS9h6770WYdsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132890; c=relaxed/simple;
	bh=6TpfHuAVAIVbbzEGJHgz5XZqL+s7ttCnwdiEU6ZTC0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CJR0lHgXB/0I40feTURhcWTNBuEp2EJ12xOIvh4SWsnAowRPr6AlZjXwDfaaf7lCnxAWRrwLYRKHXtkOzxS+VAOiBVnE2JABpE9A7Bq/2EqrODx4nlersY6W/1pcr1OGy0O706hu6aVGRG/aFb/mJ0sclXraGQSxFP7h8GVaSEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Luxv3QRq; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 3076187D84;
	Wed, 28 Feb 2024 16:07:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709132885;
	bh=c0q84ew0DF4BFK2bDVbPcWaz4zRABjtcE679uWhgCvA=;
	h=From:To:Cc:Subject:Date:From;
	b=Luxv3QRqBpe0cW+ja2r3v6Cm7jh1688fCjiuHwA44FpcpmvAaUZnTECm7rvSZ0mVR
	 /5jHTlFtbmBiaXletMKyUp59ll8Q06KtWxwAgKXIQnKg3kly4Bu8TuzF00bxmc2eEL
	 EWxZiSIdW+JZrML3fh0XboK1a9XJ0uJtm4qFGXCKvDQqgZzuLm2wpicofYO/SlkZGQ
	 hEZ4dFNgBaTCtNgXUq5ippw2ymzQYx2yAnFjU34y89vFoSsMilLMZugLc9Tk3Z2eTL
	 dMUeowPkYMNYeS2vt7RaYt4FR1dVjWpzwFpLfNWEDyAjngNcKDd0KR2lyhyNwUckA0
	 2lrRtpIvfdCZQ==
From: Lukasz Majewski <lukma@denx.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Simon Horman <horms@kernel.org>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ziyang Xuan <william.xuanziyang@huawei.com>,
	Kristian Overskeid <koverskeid@gmail.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [RFC] net: hsr: Provide RedBox support
Date: Wed, 28 Feb 2024 16:07:35 +0100
Message-Id: <20240228150735.3647892-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This patch is the RFC for providing RedBox support (HSR-SAN to be more
precise) for HSR networks. It implements the 'Mode U' without
optimizations for traffic reduction.

The corresponding patch to modify iptable2 sources has already been sent:
https://lore.kernel.org/netdev/20240226124110.37892211@hermes.local/T/

Some issues for clarification:
------------------------------
The standard IEC (62439-3:2022) says that RedBox shall work as a "proxy",
but there are no hints on the actual implementation.
Pseudo code for HSR-SAN Redbox (points 5.4.2/3/4) just mentions about
removing or adding HSR tag to the ETH frame (for respecitve ports).

With this patch implementation - the non-RedBox node's NodeTable will
also have information about SAN nodes in it.

Moreover, according to standard - the RedBox's ProxyNodeTable shall have
only SAN addresses as well as NodeTable only those available in the HSR
ring. Now only ProxyNodeTable is correctly filled, as NodeTable requires
SAN addresses for handling "outside" (i.e. SAN) traffic.

As I've written in the other mail - the approach with using "bridge" driver
and hsrX device seems to be far less optimal than this one:
https://www.spinics.net/lists/netdev/msg973057.html

Testing procedure:
------------------
The EVB-KSZ9477 has been used for testing on net-next branch
(SHA1: 709776ea8562).

Ports 4/5 were used for SW managed HSR (hsr1) as first hsr0 for ports 1/2
(with HW offloading for ksz9477) was created. Port 3 has been used as
interlink port.

Configuration - RedBox (EVB-KSZ9477):
ifconfig lan1 down;ifconfig lan2 down
ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45 version 1
ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 interlink lan3 supervision 45 version 1
ifconfig lan4 up;ifconfig lan5 up
ifconfig lan3 up
ifconfig hsr1 192.168.0.11 up

Configuration - DAN-H (EVB-KSZ9477):

ifconfig lan1 down;ifconfig lan2 down
ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45 version 1
ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 supervision 45 version 1
ifconfig lan4 up;ifconfig lan5 up
ifconfig hsr1 192.168.0.12 up


Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 include/uapi/linux/if_link.h |  1 +
 net/hsr/hsr_debugfs.c        | 32 ++++++++++++++++++++
 net/hsr/hsr_device.c         | 44 ++++++++++++++++++++++------
 net/hsr/hsr_device.h         |  4 +--
 net/hsr/hsr_forward.c        | 24 +++++++++++----
 net/hsr/hsr_framereg.c       | 57 ++++++++++++++++++++++++++++++++++++
 net/hsr/hsr_framereg.h       |  6 ++++
 net/hsr/hsr_main.h           |  6 ++++
 net/hsr/hsr_netlink.c        | 28 ++++++++++++++++--
 net/hsr/hsr_slave.c          |  1 +
 10 files changed, 183 insertions(+), 20 deletions(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index ab9bcff96e4d..b93a3acdd83f 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1770,6 +1770,7 @@ enum {
 	IFLA_HSR_PROTOCOL,		/* Indicate different protocol than
 					 * HSR. For example PRP.
 					 */
+	IFLA_HSR_INTERLINK,		/* HSR interlink network device */
 	__IFLA_HSR_MAX,
 };
 
diff --git a/net/hsr/hsr_debugfs.c b/net/hsr/hsr_debugfs.c
index 1a195efc79cd..dce87e32ae1d 100644
--- a/net/hsr/hsr_debugfs.c
+++ b/net/hsr/hsr_debugfs.c
@@ -52,7 +52,26 @@ hsr_node_table_show(struct seq_file *sfp, void *data)
 	return 0;
 }
 
+/* hsr_proxy_node_table_show - Formats and prints proxy node_table entries */
+static int
+hsr_proxy_node_table_show(struct seq_file *sfp, void *data)
+{
+	struct hsr_priv *priv = (struct hsr_priv *)sfp->private;
+	struct hsr_node *node;
+
+	seq_printf(sfp, "Proxy Node Table entries for HSR device\n");
+	seq_puts(sfp, "MAC-Address-SAN,        time_in\n");
+	rcu_read_lock();
+	list_for_each_entry_rcu(node, &priv->proxy_node_db, mac_list) {
+		seq_printf(sfp, "%pM ", &node->macaddress_A[0]);
+		seq_printf(sfp, "%10lx\n", node->time_in[HSR_PT_INTERLINK]);
+	}
+	rcu_read_unlock();
+	return 0;
+}
+
 DEFINE_SHOW_ATTRIBUTE(hsr_node_table);
+DEFINE_SHOW_ATTRIBUTE(hsr_proxy_node_table);
 
 void hsr_debugfs_rename(struct net_device *dev)
 {
@@ -95,6 +114,19 @@ void hsr_debugfs_init(struct hsr_priv *priv, struct net_device *hsr_dev)
 		priv->node_tbl_root = NULL;
 		return;
 	}
+
+	if (!priv->redbox)
+		return;
+
+	de = debugfs_create_file("proxy_node_table", S_IFREG | 0444,
+				 priv->node_tbl_root, priv,
+				 &hsr_proxy_node_table_fops);
+	if (IS_ERR(de)) {
+		pr_err("Cannot create hsr proxy node_table file\n");
+		debugfs_remove(priv->node_tbl_root);
+		priv->node_tbl_root = NULL;
+		return;
+	}
 }
 
 /* hsr_debugfs_term - Tear down debugfs intrastructure
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 9d71b66183da..3a5585b38107 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -142,30 +142,32 @@ static int hsr_dev_open(struct net_device *dev)
 {
 	struct hsr_priv *hsr;
 	struct hsr_port *port;
-	char designation;
+	char *designation = NULL;
 
 	hsr = netdev_priv(dev);
-	designation = '\0';
 
 	hsr_for_each_port(hsr, port) {
 		if (port->type == HSR_PT_MASTER)
 			continue;
 		switch (port->type) {
 		case HSR_PT_SLAVE_A:
-			designation = 'A';
+			designation = "Slave A";
 			break;
 		case HSR_PT_SLAVE_B:
-			designation = 'B';
+			designation = "Slave B";
+			break;
+		case HSR_PT_INTERLINK:
+			designation = "Interlink";
 			break;
 		default:
-			designation = '?';
+			designation = "Unknown";
 		}
 		if (!is_slave_up(port->dev))
-			netdev_warn(dev, "Slave %c (%s) is not up; please bring it up to get a fully working HSR network\n",
+			netdev_warn(dev, "%s (%s) is not up; please bring it up to get a fully working HSR network\n",
 				    designation, port->dev->name);
 	}
 
-	if (designation == '\0')
+	if (designation == NULL)
 		netdev_warn(dev, "No slave devices configured\n");
 
 	return 0;
@@ -296,6 +298,7 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
 	struct hsr_priv *hsr = master->hsr;
 	__u8 type = HSR_TLV_LIFE_CHECK;
 	struct hsr_sup_payload *hsr_sp;
+	struct hsr_sup_tlv *hsr_stlv;
 	struct hsr_sup_tag *hsr_stag;
 	struct sk_buff *skb;
 
@@ -335,6 +338,16 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
 	hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
 	ether_addr_copy(hsr_sp->macaddress_A, master->dev->dev_addr);
 
+	if (hsr->redbox) {
+		hsr_stlv = skb_put(skb, sizeof(struct hsr_sup_tlv));
+		hsr_stlv->HSR_TLV_type = PRP_TLV_REDBOX_MAC;
+		hsr_stlv->HSR_TLV_length = sizeof(struct hsr_sup_payload);
+
+		/* Payload: MacAddressRedBox */
+		hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
+		ether_addr_copy(hsr_sp->macaddress_A, hsr->macaddress_redbox);
+	}
+
 	if (skb_put_padto(skb, ETH_ZLEN)) {
 		spin_unlock_bh(&hsr->seqnr_lock);
 		return;
@@ -545,8 +558,8 @@ static const unsigned char def_multicast_addr[ETH_ALEN] __aligned(2) = {
 };
 
 int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
-		     unsigned char multicast_spec, u8 protocol_version,
-		     struct netlink_ext_ack *extack)
+		     struct net_device *interlink, unsigned char multicast_spec,
+		     u8 protocol_version, struct netlink_ext_ack *extack)
 {
 	bool unregister = false;
 	struct hsr_priv *hsr;
@@ -555,6 +568,7 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 	hsr = netdev_priv(hsr_dev);
 	INIT_LIST_HEAD(&hsr->ports);
 	INIT_LIST_HEAD(&hsr->node_db);
+	INIT_LIST_HEAD(&hsr->proxy_node_db);
 	spin_lock_init(&hsr->list_lock);
 
 	eth_hw_addr_set(hsr_dev, slave[0]->dev_addr);
@@ -615,6 +629,18 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 	if (res)
 		goto err_unregister;
 
+	if (interlink) {
+		res = hsr_add_port(hsr, interlink, HSR_PT_INTERLINK, extack);
+		if (res)
+			goto err_unregister;
+
+		hsr->redbox = true;
+		ether_addr_copy(hsr->macaddress_redbox, interlink->dev_addr);
+		timer_setup(&hsr->prune_proxy_timer, hsr_prune_proxy_nodes, 0);
+		mod_timer(&hsr->prune_proxy_timer,
+			  jiffies + msecs_to_jiffies(PRUNE_PROXY_PERIOD));
+	}
+
 	hsr_debugfs_init(hsr, hsr_dev);
 	mod_timer(&hsr->prune_timer, jiffies + msecs_to_jiffies(PRUNE_PERIOD));
 
diff --git a/net/hsr/hsr_device.h b/net/hsr/hsr_device.h
index 9060c92168f9..655284095b78 100644
--- a/net/hsr/hsr_device.h
+++ b/net/hsr/hsr_device.h
@@ -16,8 +16,8 @@
 void hsr_del_ports(struct hsr_priv *hsr);
 void hsr_dev_setup(struct net_device *dev);
 int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
-		     unsigned char multicast_spec, u8 protocol_version,
-		     struct netlink_ext_ack *extack);
+		     struct net_device *interlink, unsigned char multicast_spec,
+		     u8 protocol_version, struct netlink_ext_ack *extack);
 void hsr_check_carrier_and_operstate(struct hsr_priv *hsr);
 int hsr_get_max_mtu(struct hsr_priv *hsr);
 #endif /* __HSR_DEVICE_H */
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 5d68cb181695..400b7d00f5af 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -393,6 +393,13 @@ bool hsr_drop_frame(struct hsr_frame_info *frame, struct hsr_port *port)
 	if (port->dev->features & NETIF_F_HW_HSR_FWD)
 		return prp_drop_frame(frame, port);
 
+	/* RedBox specific frames dropping policies
+	 *
+	 * Do not send HSR supervisory frames to SAN devices
+	 */
+	if (frame->is_supervision && port->type == HSR_PT_INTERLINK)
+		return true;
+
 	return false;
 }
 
@@ -448,13 +455,14 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
 		}
 
 		/* Check if frame is to be dropped. Eg. for PRP no forward
-		 * between ports.
+		 * between ports, or sending HSR supervision to RedBox.
 		 */
 		if (hsr->proto_ops->drop_frame &&
 		    hsr->proto_ops->drop_frame(frame, port))
 			continue;
 
-		if (port->type != HSR_PT_MASTER)
+		if (port->type == HSR_PT_SLAVE_A ||
+		    port->type == HSR_PT_SLAVE_B)
 			skb = hsr->proto_ops->create_tagged_frame(frame, port);
 		else
 			skb = hsr->proto_ops->get_untagged_frame(frame, port);
@@ -469,7 +477,9 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
 			hsr_deliver_master(skb, port->dev, frame->node_src);
 		} else {
 			if (!hsr_xmit(skb, port, frame))
-				sent = true;
+				if (port->type == HSR_PT_SLAVE_A ||
+				    port->type == HSR_PT_SLAVE_B)
+					sent = true;
 		}
 	}
 }
@@ -574,9 +584,11 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 
 	memset(frame, 0, sizeof(*frame));
 	frame->is_supervision = is_supervision_frame(port->hsr, skb);
-	frame->node_src = hsr_get_node(port, &hsr->node_db, skb,
-				       frame->is_supervision,
-				       port->type);
+	frame->node_src = hsr_get_node(port,
+				      port->type == HSR_PT_INTERLINK ?
+				      &hsr->proxy_node_db : &hsr->node_db, skb,
+				      frame->is_supervision, port->type);
+
 	if (!frame->node_src)
 		return -1; /* Unknown node and !is_supervision, or no mem */
 
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 6d14d935ee82..55320dea341a 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -71,6 +71,14 @@ static struct hsr_node *find_node_by_addr_A(struct list_head *node_db,
 	return NULL;
 }
 
+/* Check if node for a given MAC address is already present in data base
+ */
+bool hsr_is_node_in_db(struct list_head *node_db,
+		       const unsigned char addr[ETH_ALEN])
+{
+	return !!find_node_by_addr_A(node_db, addr);
+}
+
 /* Helper for device init; the self_node is used in hsr_rcv() to recognize
  * frames from self that's been looped over the HSR ring.
  */
@@ -557,6 +565,55 @@ void hsr_prune_nodes(struct timer_list *t)
 		  jiffies + msecs_to_jiffies(PRUNE_PERIOD));
 }
 
+void hsr_prune_proxy_nodes(struct timer_list *t)
+{
+	struct hsr_priv *hsr = from_timer(hsr, t, prune_proxy_timer);
+	struct hsr_node *node;
+	struct hsr_node *tmp;
+	struct hsr_port *port;
+	unsigned long timestamp;
+	unsigned long time_c;
+
+	spin_lock_bh(&hsr->list_lock);
+	list_for_each_entry_safe(node, tmp, &hsr->proxy_node_db, mac_list) {
+
+		time_c = node->time_in[HSR_PT_INTERLINK];
+
+		/* Check for timestamps old enough to risk wrap-around */
+		if (time_after(jiffies, time_c + MAX_JIFFY_OFFSET / 2))
+			node->time_in_stale[HSR_PT_INTERLINK] = true;
+
+		timestamp = time_c;
+		/* Warn of ring error only as long as we get frames at all */
+		if (time_is_after_jiffies(timestamp +
+				msecs_to_jiffies(1.5 * MAX_SLAVE_DIFF))) {
+			rcu_read_lock();
+			port = get_late_port(hsr, node);
+			if (port)
+				hsr_nl_ringerror(hsr, node->macaddress_A, port);
+			rcu_read_unlock();
+		}
+
+		/* Prune old entries */
+		if (time_is_before_jiffies(timestamp +
+				msecs_to_jiffies(HSR_PROXY_NODE_FORGET_TIME))) {
+			hsr_nl_nodedown(hsr, node->macaddress_A);
+			if (!node->removed) {
+				list_del_rcu(&node->mac_list);
+				node->removed = true;
+				/* Note that we need to free this entry later: */
+				kfree_rcu(node, rcu_head);
+			}
+		}
+	}
+
+	spin_unlock_bh(&hsr->list_lock);
+
+	/* Restart timer */
+	mod_timer(&hsr->prune_proxy_timer,
+		  jiffies + msecs_to_jiffies(PRUNE_PROXY_PERIOD));
+}
+
 void *hsr_get_next_node(struct hsr_priv *hsr, void *_pos,
 			unsigned char addr[ETH_ALEN])
 {
diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
index b23556251d62..67456a75d8fe 100644
--- a/net/hsr/hsr_framereg.h
+++ b/net/hsr/hsr_framereg.h
@@ -46,6 +46,7 @@ int hsr_register_frame_out(struct hsr_port *port, struct hsr_node *node,
 			   u16 sequence_nr);
 
 void hsr_prune_nodes(struct timer_list *t);
+void hsr_prune_proxy_nodes(struct timer_list *t);
 
 int hsr_create_self_node(struct hsr_priv *hsr,
 			 const unsigned char addr_a[ETH_ALEN],
@@ -63,10 +64,15 @@ int hsr_get_node_data(struct hsr_priv *hsr,
 		      int *if2_age,
 		      u16 *if2_seq);
 
+void hsr_handle_san_frame(bool san, enum hsr_port_type port,
+			  struct hsr_node *node);
 void prp_handle_san_frame(bool san, enum hsr_port_type port,
 			  struct hsr_node *node);
 void prp_update_san_info(struct hsr_node *node, bool is_sup);
 
+bool hsr_is_node_in_db(struct list_head *node_db,
+		       const unsigned char addr[ETH_ALEN]);
+
 struct hsr_node {
 	struct list_head	mac_list;
 	/* Protect R/W access to seq_out */
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 18e01791ad79..3fb5b07f8f25 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -21,6 +21,7 @@
  */
 #define HSR_LIFE_CHECK_INTERVAL		 2000 /* ms */
 #define HSR_NODE_FORGET_TIME		60000 /* ms */
+#define HSR_PROXY_NODE_FORGET_TIME	60000 /* ms */
 #define HSR_ANNOUNCE_INTERVAL		  100 /* ms */
 #define HSR_ENTRY_FORGET_TIME		  400 /* ms */
 
@@ -35,6 +36,7 @@
  * HSR_NODE_FORGET_TIME?
  */
 #define PRUNE_PERIOD			 3000 /* ms */
+#define PRUNE_PROXY_PERIOD		 3000 /* ms */
 #define HSR_TLV_EOT				   0  /* End of TLVs */
 #define HSR_TLV_ANNOUNCE		   22
 #define HSR_TLV_LIFE_CHECK		   23
@@ -192,9 +194,11 @@ struct hsr_priv {
 	struct rcu_head		rcu_head;
 	struct list_head	ports;
 	struct list_head	node_db;	/* Known HSR nodes */
+	struct list_head	proxy_node_db;	/* RedBox HSR proxy nodes */
 	struct hsr_self_node	__rcu *self_node;	/* MACs of slaves */
 	struct timer_list	announce_timer;	/* Supervision frame dispatch */
 	struct timer_list	prune_timer;
+	struct timer_list	prune_proxy_timer;
 	int announce_count;
 	u16 sequence_nr;
 	u16 sup_sequence_nr;	/* For HSRv1 separate seq_nr for supervision */
@@ -209,6 +213,8 @@ struct hsr_priv {
 				 * of lan_id
 				 */
 	bool fwd_offloaded;	/* Forwarding offloaded to HW */
+	bool redbox;            /* Device supports HSR RedBox */
+	unsigned char		macaddress_redbox[ETH_ALEN];
 	unsigned char		sup_multicast_addr[ETH_ALEN] __aligned(sizeof(u16));
 				/* Align to u16 boundary to avoid unaligned access
 				 * in ether_addr_equal
diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index 78fe40eb9f01..183ec9ddb86d 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -23,6 +23,7 @@ static const struct nla_policy hsr_policy[IFLA_HSR_MAX + 1] = {
 	[IFLA_HSR_SUPERVISION_ADDR]	= { .len = ETH_ALEN },
 	[IFLA_HSR_SEQ_NR]		= { .type = NLA_U16 },
 	[IFLA_HSR_PROTOCOL]		= { .type = NLA_U8 },
+	[IFLA_HSR_INTERLINK]		= { .type = NLA_U32 },
 };
 
 /* Here, it seems a netdevice has already been allocated for us, and the
@@ -35,8 +36,8 @@ static int hsr_newlink(struct net *src_net, struct net_device *dev,
 	enum hsr_version proto_version;
 	unsigned char multicast_spec;
 	u8 proto = HSR_PROTOCOL_HSR;
-	struct net_device *link[2];
 
+	struct net_device *link[2], *interlink = NULL;
 	if (!data) {
 		NL_SET_ERR_MSG_MOD(extack, "No slave devices specified");
 		return -EINVAL;
@@ -67,6 +68,20 @@ static int hsr_newlink(struct net *src_net, struct net_device *dev,
 		return -EINVAL;
 	}
 
+	if (data[IFLA_HSR_INTERLINK])
+		interlink = __dev_get_by_index(src_net,
+				       nla_get_u32(data[IFLA_HSR_INTERLINK]));
+
+	if (interlink && interlink == link[0]) {
+		NL_SET_ERR_MSG_MOD(extack, "Interlink and Slave1 are the same");
+		return -EINVAL;
+	}
+
+	if (interlink && interlink == link[1]) {
+		NL_SET_ERR_MSG_MOD(extack, "Interlink and Slave2 are the same");
+		return -EINVAL;
+	}
+
 	if (!data[IFLA_HSR_MULTICAST_SPEC])
 		multicast_spec = 0;
 	else
@@ -96,10 +111,17 @@ static int hsr_newlink(struct net *src_net, struct net_device *dev,
 		}
 	}
 
-	if (proto == HSR_PROTOCOL_PRP)
+	if (proto == HSR_PROTOCOL_PRP) {
 		proto_version = PRP_V1;
+		if (interlink) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Interlink only works with HSR");
+			return -EINVAL;
+		}
+	}
 
-	return hsr_dev_finalize(dev, link, multicast_spec, proto_version, extack);
+	return hsr_dev_finalize(dev, link, interlink, multicast_spec,
+				proto_version, extack);
 }
 
 static void hsr_dellink(struct net_device *dev, struct list_head *head)
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index e5742f2a2d52..136e3917f477 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -55,6 +55,7 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
 	protocol = eth_hdr(skb)->h_proto;
 
 	if (!(port->dev->features & NETIF_F_HW_HSR_TAG_RM) &&
+	    port->type != HSR_PT_INTERLINK &&
 	    hsr->proto_ops->invalid_dan_ingress_frame &&
 	    hsr->proto_ops->invalid_dan_ingress_frame(protocol))
 		goto finish_pass;
-- 
2.20.1


