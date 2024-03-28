Return-Path: <linux-kernel+bounces-104838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C70187D460
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92D7D1C21B15
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A914D9FE;
	Fri, 15 Mar 2024 19:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tr/WcH2p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCF751033;
	Fri, 15 Mar 2024 19:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710529857; cv=none; b=uiGCNS3bMu6l/b+lsfu7DQ+NO7+iSgwfXRijtpLzwp6ij853DN+bfSbmzIgGMhWo9Fe5v3poUr2vkIKRBM/PqCj/rvDHbhPYpGZuZgkhnMccYJVAEIKQlK96CDWA7q6baxBChWOMDfQSrglfjn+QKwmyi/w0i9HOhIdy4vGWXmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710529857; c=relaxed/simple;
	bh=eh6GC8WWkj5fXPS2fEjqpHZgkDzymujP6hE1KUorULQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pxxbkm6OEZCrgK5HzgIZrBYHMIlZKniWS00j4P8HVKYC/WviIcfuo/aglNnbi+QwFrTJDXBH1H7lzc5aEeB8sd6rhX8E0R7OM4gZBruX6xmUbbLzM6n0kUq3OlPUQ5fdUjHQCysZ0/8HsGoLnssCyozDHkNoWv9V79MedtLMGI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tr/WcH2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62BEC433C7;
	Fri, 15 Mar 2024 19:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710529856;
	bh=eh6GC8WWkj5fXPS2fEjqpHZgkDzymujP6hE1KUorULQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tr/WcH2p2Gj4mHW9kNQxJ+oEcgnPOMV9vk+pXUKzbSUMaO0iyLTXUlgAnfqiolTSc
	 WrMPNNS9gUw+35TDxMdu2qIOc3GnY9JegIdhSyQMn/oxt1tgdcAPJzjnh89zA9C5gK
	 rdZUJUI6YbtQnnEB3yRBRpvB4a1kUD9qzW9O0fi8h1rSTedNdkoSsYLTVVkNfp6ZYO
	 Ks3/Y1WYZI//qoEzmTURDVYMMkLpsMDIvo6ucNTKhQNLNmpvtcwz6p/vit4Bv8ag3+
	 KtlOwRwticvncIy19X0MKuALjW/CCd97KG7pIZjzQka/2blFm+oxukuznuMEwR8+gL
	 m+BUKQQgeA/bg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Re: Linux 4.19.310
Date: Fri, 15 Mar 2024 15:10:53 -0400
Message-ID: <20240315191053.1844191-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315191053.1844191-1-sashal@kernel.org>
References: <20240315191053.1844191-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 9648c95ee3201..96be210bd42b9 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 309
+SUBLEVEL = 310
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index cff52d8ffdb12..d5694f263dd61 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -964,7 +964,7 @@ put_tv32(struct timeval32 __user *o, struct timespec64 *i)
 }
 
 static inline long
-put_tv_to_tv32(struct timeval32 __user *o, struct timeval *i)
+put_tv_to_tv32(struct timeval32 __user *o, struct __kernel_old_timeval *i)
 {
 	return copy_to_user(o, &(struct timeval32){
 				.tv_sec = i->tv_sec,
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 8f0cb28099392..251c77474e7b8 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -88,6 +88,19 @@ config LD_SCRIPT_DYN
 	depends on !LD_SCRIPT_STATIC
         select MODULE_REL_CRCS if MODVERSIONS
 
+config LD_SCRIPT_DYN_RPATH
+	bool "set rpath in the binary" if EXPERT
+	default y
+	depends on LD_SCRIPT_DYN
+	help
+	  Add /lib (and /lib64 for 64-bit) to the linux binary's rpath
+	  explicitly.
+
+	  You may need to turn this off if compiling for nix systems
+	  that have their libraries in random /nix directories and
+	  might otherwise unexpected use libraries from /lib or /lib64
+	  instead of the desired ones.
+
 config HOSTFS
 	tristate "Host filesystem"
 	help
diff --git a/arch/um/Makefile b/arch/um/Makefile
index ab1066c38944e..439edee0b2878 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -119,7 +119,8 @@ archheaders:
 archprepare: include/generated/user_constants.h
 
 LINK-$(CONFIG_LD_SCRIPT_STATIC) += -static
-LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib $(call cc-option, -no-pie)
+LINK-$(CONFIG_LD_SCRIPT_DYN) += $(call cc-option, -no-pie)
+LINK-$(CONFIG_LD_SCRIPT_DYN_RPATH) += -Wl,-rpath,/lib
 
 CFLAGS_NO_HARDENING := $(call cc-option, -fno-PIC,) $(call cc-option, -fno-pic,) \
 	$(call cc-option, -fno-stack-protector,) \
diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index 91085a08de6cb..8bc3d493d429a 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -51,7 +51,7 @@ ELF_FORMAT := elf64-x86-64
 
 # Not on all 64-bit distros /lib is a symlink to /lib64. PLD is an example.
 
-LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib64
+LINK-$(CONFIG_LD_SCRIPT_DYN_RPATH) += -Wl,-rpath,/lib64
 LINK-y += -m64
 
 # Do unit-at-a-time unconditionally on x86_64, following the host
diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 06d99931519bd..ce9209f336957 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -1183,6 +1183,12 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 					SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOLOOP |
 					SERIO_QUIRK_NOPNP)
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "NS5x_7xPU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOAUX)
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index a19e04f8bcc8f..8aa04b37c5fe0 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -217,7 +217,7 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
 	struct metadata_dst *tun_dst = NULL;
 	struct pcpu_sw_netstats *stats;
 	unsigned int len;
-	int err = 0;
+	int nh, err = 0;
 	void *oiph;
 
 	if (ip_tunnel_collect_metadata() || gs->collect_md) {
@@ -261,9 +261,23 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
 		goto drop;
 	}
 
-	oiph = skb_network_header(skb);
+	/* Save offset of outer header relative to skb->head,
+	 * because we are going to reset the network header to the inner header
+	 * and might change skb->head.
+	 */
+	nh = skb_network_header(skb) - skb->head;
+
 	skb_reset_network_header(skb);
 
+	if (!pskb_inet_may_pull(skb)) {
+		DEV_STATS_INC(geneve->dev, rx_length_errors);
+		DEV_STATS_INC(geneve->dev, rx_errors);
+		goto drop;
+	}
+
+	/* Get the outer header. */
+	oiph = skb->head + nh;
+
 	if (geneve_get_sk_family(gs) == AF_INET)
 		err = IP_ECN_decapsulate(oiph, skb);
 #if IS_ENABLED(CONFIG_IPV6)
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index ce17917b6f76f..e24513e34306c 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -54,6 +54,10 @@
 #define LINKCHANGE_INT (2 * HZ)
 #define VF_TAKEOVER_INT (HZ / 10)
 
+/* Macros to define the context of vf registration */
+#define VF_REG_IN_PROBE		1
+#define VF_REG_IN_NOTIFIER	2
+
 static unsigned int ring_size __ro_after_init = 128;
 module_param(ring_size, uint, 0444);
 MODULE_PARM_DESC(ring_size, "Ring buffer size (# of pages)");
@@ -2025,7 +2029,7 @@ static rx_handler_result_t netvsc_vf_handle_frame(struct sk_buff **pskb)
 }
 
 static int netvsc_vf_join(struct net_device *vf_netdev,
-			  struct net_device *ndev)
+			  struct net_device *ndev, int context)
 {
 	struct net_device_context *ndev_ctx = netdev_priv(ndev);
 	int ret;
@@ -2048,7 +2052,11 @@ static int netvsc_vf_join(struct net_device *vf_netdev,
 		goto upper_link_failed;
 	}
 
-	schedule_delayed_work(&ndev_ctx->vf_takeover, VF_TAKEOVER_INT);
+	/* If this registration is called from probe context vf_takeover
+	 * is taken care of later in probe itself.
+	 */
+	if (context == VF_REG_IN_NOTIFIER)
+		schedule_delayed_work(&ndev_ctx->vf_takeover, VF_TAKEOVER_INT);
 
 	call_netdevice_notifiers(NETDEV_JOIN, vf_netdev);
 
@@ -2141,8 +2149,17 @@ static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
 		if (!ndev_ctx->vf_alloc)
 			continue;
 
-		if (ndev_ctx->vf_serial == serial)
-			return hv_get_drvdata(ndev_ctx->device_ctx);
+		if (ndev_ctx->vf_serial != serial)
+			continue;
+
+		ndev = hv_get_drvdata(ndev_ctx->device_ctx);
+		if (ndev->addr_len != vf_netdev->addr_len ||
+		    memcmp(ndev->perm_addr, vf_netdev->perm_addr,
+			   ndev->addr_len) != 0)
+			continue;
+
+		return ndev;
+
 	}
 
 	/* Fallback path to check synthetic vf with help of mac addr.
@@ -2177,7 +2194,7 @@ static int netvsc_prepare_bonding(struct net_device *vf_netdev)
 	return NOTIFY_DONE;
 }
 
-static int netvsc_register_vf(struct net_device *vf_netdev)
+static int netvsc_register_vf(struct net_device *vf_netdev, int context)
 {
 	struct net_device_context *net_device_ctx;
 	struct netvsc_device *netvsc_dev;
@@ -2216,7 +2233,7 @@ static int netvsc_register_vf(struct net_device *vf_netdev)
 
 	netdev_info(ndev, "VF registering: %s\n", vf_netdev->name);
 
-	if (netvsc_vf_join(vf_netdev, ndev) != 0)
+	if (netvsc_vf_join(vf_netdev, ndev, context) != 0)
 		return NOTIFY_DONE;
 
 	dev_hold(vf_netdev);
@@ -2276,10 +2293,31 @@ static int netvsc_unregister_vf(struct net_device *vf_netdev)
 	return NOTIFY_OK;
 }
 
+static int check_dev_is_matching_vf(struct net_device *event_ndev)
+{
+	/* Skip NetVSC interfaces */
+	if (event_ndev->netdev_ops == &device_ops)
+		return -ENODEV;
+
+	/* Avoid non-Ethernet type devices */
+	if (event_ndev->type != ARPHRD_ETHER)
+		return -ENODEV;
+
+	/* Avoid Vlan dev with same MAC registering as VF */
+	if (is_vlan_dev(event_ndev))
+		return -ENODEV;
+
+	/* Avoid Bonding master dev with same MAC registering as VF */
+	if (netif_is_bond_master(event_ndev))
+		return -ENODEV;
+
+	return 0;
+}
+
 static int netvsc_probe(struct hv_device *dev,
 			const struct hv_vmbus_device_id *dev_id)
 {
-	struct net_device *net = NULL;
+	struct net_device *net = NULL, *vf_netdev;
 	struct net_device_context *net_device_ctx;
 	struct netvsc_device_info *device_info = NULL;
 	struct netvsc_device *nvdev;
@@ -2382,6 +2420,30 @@ static int netvsc_probe(struct hv_device *dev,
 	}
 
 	list_add(&net_device_ctx->list, &netvsc_dev_list);
+
+	/* When the hv_netvsc driver is unloaded and reloaded, the
+	 * NET_DEVICE_REGISTER for the vf device is replayed before probe
+	 * is complete. This is because register_netdevice_notifier() gets
+	 * registered before vmbus_driver_register() so that callback func
+	 * is set before probe and we don't miss events like NETDEV_POST_INIT
+	 * So, in this section we try to register the matching vf device that
+	 * is present as a netdevice, knowing that its register call is not
+	 * processed in the netvsc_netdev_notifier(as probing is progress and
+	 * get_netvsc_byslot fails).
+	 */
+	for_each_netdev(dev_net(net), vf_netdev) {
+		ret = check_dev_is_matching_vf(vf_netdev);
+		if (ret != 0)
+			continue;
+
+		if (net != get_netvsc_byslot(vf_netdev))
+			continue;
+
+		netvsc_prepare_bonding(vf_netdev);
+		netvsc_register_vf(vf_netdev, VF_REG_IN_PROBE);
+		__netvsc_vf_setup(net, vf_netdev);
+		break;
+	}
 	rtnl_unlock();
 
 	kfree(device_info);
@@ -2474,29 +2536,17 @@ static int netvsc_netdev_event(struct notifier_block *this,
 			       unsigned long event, void *ptr)
 {
 	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
+	int ret = 0;
 
-	/* Skip our own events */
-	if (event_dev->netdev_ops == &device_ops)
-		return NOTIFY_DONE;
-
-	/* Avoid non-Ethernet type devices */
-	if (event_dev->type != ARPHRD_ETHER)
-		return NOTIFY_DONE;
-
-	/* Avoid Vlan dev with same MAC registering as VF */
-	if (is_vlan_dev(event_dev))
-		return NOTIFY_DONE;
-
-	/* Avoid Bonding master dev with same MAC registering as VF */
-	if ((event_dev->priv_flags & IFF_BONDING) &&
-	    (event_dev->flags & IFF_MASTER))
+	ret = check_dev_is_matching_vf(event_dev);
+	if (ret != 0)
 		return NOTIFY_DONE;
 
 	switch (event) {
 	case NETDEV_POST_INIT:
 		return netvsc_prepare_bonding(event_dev);
 	case NETDEV_REGISTER:
-		return netvsc_register_vf(event_dev);
+		return netvsc_register_vf(event_dev, VF_REG_IN_NOTIFIER);
 	case NETDEV_UNREGISTER:
 		return netvsc_unregister_vf(event_dev);
 	case NETDEV_UP:
diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index 7863918592db9..954935a38f186 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -59,12 +59,6 @@
 #include <net/net_namespace.h>
 #include <linux/u64_stats_sync.h>
 
-struct pcpu_lstats {
-	u64			packets;
-	u64			bytes;
-	struct u64_stats_sync	syncp;
-};
-
 /* The higher levels take care of making this non-reentrant (it's
  * called with bh's disabled).
  */
diff --git a/drivers/net/nlmon.c b/drivers/net/nlmon.c
index 4b22955de1918..dd0db7534cb32 100644
--- a/drivers/net/nlmon.c
+++ b/drivers/net/nlmon.c
@@ -6,12 +6,6 @@
 #include <linux/if_arp.h>
 #include <net/rtnetlink.h>
 
-struct pcpu_lstats {
-	u64 packets;
-	u64 bytes;
-	struct u64_stats_sync syncp;
-};
-
 static netdev_tx_t nlmon_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	int len = skb->len;
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index c0fff40a98bb8..f56f45c924de0 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -101,6 +101,12 @@
 /* statistic update interval (mSec) */
 #define STAT_UPDATE_TIMER		(1 * 1000)
 
+/* time to wait for MAC or FCT to stop (jiffies) */
+#define HW_DISABLE_TIMEOUT		(HZ / 10)
+
+/* time to wait between polling MAC or FCT state (ms) */
+#define HW_DISABLE_DELAY_MS		1
+
 /* defines interrupts from interrupt EP */
 #define MAX_INT_EP			(32)
 #define INT_EP_INTEP			(31)
@@ -395,8 +401,9 @@ struct lan78xx_net {
 	struct urb		*urb_intr;
 	struct usb_anchor	deferred;
 
+	struct mutex		dev_mutex; /* serialise open/stop wrt suspend/resume */
 	struct mutex		phy_mutex; /* for phy access */
-	unsigned		pipe_in, pipe_out, pipe_intr;
+	unsigned int		pipe_in, pipe_out, pipe_intr;
 
 	u32			hard_mtu;	/* count any extra framing */
 	size_t			rx_urb_size;	/* size for rx urbs */
@@ -406,7 +413,7 @@ struct lan78xx_net {
 	wait_queue_head_t	*wait;
 	unsigned char		suspend_count;
 
-	unsigned		maxpacket;
+	unsigned int		maxpacket;
 	struct timer_list	delay;
 	struct timer_list	stat_monitor;
 
@@ -490,6 +497,26 @@ static int lan78xx_write_reg(struct lan78xx_net *dev, u32 index, u32 data)
 	return ret;
 }
 
+static int lan78xx_update_reg(struct lan78xx_net *dev, u32 reg, u32 mask,
+			      u32 data)
+{
+	int ret;
+	u32 buf;
+
+	ret = lan78xx_read_reg(dev, reg, &buf);
+	if (ret < 0)
+		return ret;
+
+	buf &= ~mask;
+	buf |= (mask & data);
+
+	ret = lan78xx_write_reg(dev, reg, buf);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int lan78xx_read_stats(struct lan78xx_net *dev,
 			      struct lan78xx_statstage *data)
 {
@@ -515,7 +542,7 @@ static int lan78xx_read_stats(struct lan78xx_net *dev,
 	if (likely(ret >= 0)) {
 		src = (u32 *)stats;
 		dst = (u32 *)data;
-		for (i = 0; i < sizeof(*stats)/sizeof(u32); i++) {
+		for (i = 0; i < sizeof(*stats) / sizeof(u32); i++) {
 			le32_to_cpus(&src[i]);
 			dst[i] = src[i];
 		}
@@ -529,10 +556,11 @@ static int lan78xx_read_stats(struct lan78xx_net *dev,
 	return ret;
 }
 
-#define check_counter_rollover(struct1, dev_stats, member) {	\
-	if (struct1->member < dev_stats.saved.member)		\
-		dev_stats.rollover_count.member++;		\
-	}
+#define check_counter_rollover(struct1, dev_stats, member)		\
+	do {								\
+		if ((struct1)->member < (dev_stats).saved.member)	\
+			(dev_stats).rollover_count.member++;		\
+	} while (0)
 
 static void lan78xx_check_stat_rollover(struct lan78xx_net *dev,
 					struct lan78xx_statstage *stats)
@@ -835,20 +863,19 @@ static int lan78xx_read_raw_otp(struct lan78xx_net *dev, u32 offset,
 				u32 length, u8 *data)
 {
 	int i;
-	int ret;
 	u32 buf;
 	unsigned long timeout;
 
-	ret = lan78xx_read_reg(dev, OTP_PWR_DN, &buf);
+	lan78xx_read_reg(dev, OTP_PWR_DN, &buf);
 
 	if (buf & OTP_PWR_DN_PWRDN_N_) {
 		/* clear it and wait to be cleared */
-		ret = lan78xx_write_reg(dev, OTP_PWR_DN, 0);
+		lan78xx_write_reg(dev, OTP_PWR_DN, 0);
 
 		timeout = jiffies + HZ;
 		do {
 			usleep_range(1, 10);
-			ret = lan78xx_read_reg(dev, OTP_PWR_DN, &buf);
+			lan78xx_read_reg(dev, OTP_PWR_DN, &buf);
 			if (time_after(jiffies, timeout)) {
 				netdev_warn(dev->net,
 					    "timeout on OTP_PWR_DN");
@@ -858,18 +885,18 @@ static int lan78xx_read_raw_otp(struct lan78xx_net *dev, u32 offset,
 	}
 
 	for (i = 0; i < length; i++) {
-		ret = lan78xx_write_reg(dev, OTP_ADDR1,
-					((offset + i) >> 8) & OTP_ADDR1_15_11);
-		ret = lan78xx_write_reg(dev, OTP_ADDR2,
-					((offset + i) & OTP_ADDR2_10_3));
+		lan78xx_write_reg(dev, OTP_ADDR1,
+				  ((offset + i) >> 8) & OTP_ADDR1_15_11);
+		lan78xx_write_reg(dev, OTP_ADDR2,
+				  ((offset + i) & OTP_ADDR2_10_3));
 
-		ret = lan78xx_write_reg(dev, OTP_FUNC_CMD, OTP_FUNC_CMD_READ_);
-		ret = lan78xx_write_reg(dev, OTP_CMD_GO, OTP_CMD_GO_GO_);
+		lan78xx_write_reg(dev, OTP_FUNC_CMD, OTP_FUNC_CMD_READ_);
+		lan78xx_write_reg(dev, OTP_CMD_GO, OTP_CMD_GO_GO_);
 
 		timeout = jiffies + HZ;
 		do {
 			udelay(1);
-			ret = lan78xx_read_reg(dev, OTP_STATUS, &buf);
+			lan78xx_read_reg(dev, OTP_STATUS, &buf);
 			if (time_after(jiffies, timeout)) {
 				netdev_warn(dev->net,
 					    "timeout on OTP_STATUS");
@@ -877,7 +904,7 @@ static int lan78xx_read_raw_otp(struct lan78xx_net *dev, u32 offset,
 			}
 		} while (buf & OTP_STATUS_BUSY_);
 
-		ret = lan78xx_read_reg(dev, OTP_RD_DATA, &buf);
+		lan78xx_read_reg(dev, OTP_RD_DATA, &buf);
 
 		data[i] = (u8)(buf & 0xFF);
 	}
@@ -889,20 +916,19 @@ static int lan78xx_write_raw_otp(struct lan78xx_net *dev, u32 offset,
 				 u32 length, u8 *data)
 {
 	int i;
-	int ret;
 	u32 buf;
 	unsigned long timeout;
 
-	ret = lan78xx_read_reg(dev, OTP_PWR_DN, &buf);
+	lan78xx_read_reg(dev, OTP_PWR_DN, &buf);
 
 	if (buf & OTP_PWR_DN_PWRDN_N_) {
 		/* clear it and wait to be cleared */
-		ret = lan78xx_write_reg(dev, OTP_PWR_DN, 0);
+		lan78xx_write_reg(dev, OTP_PWR_DN, 0);
 
 		timeout = jiffies + HZ;
 		do {
 			udelay(1);
-			ret = lan78xx_read_reg(dev, OTP_PWR_DN, &buf);
+			lan78xx_read_reg(dev, OTP_PWR_DN, &buf);
 			if (time_after(jiffies, timeout)) {
 				netdev_warn(dev->net,
 					    "timeout on OTP_PWR_DN completion");
@@ -912,21 +938,21 @@ static int lan78xx_write_raw_otp(struct lan78xx_net *dev, u32 offset,
 	}
 
 	/* set to BYTE program mode */
-	ret = lan78xx_write_reg(dev, OTP_PRGM_MODE, OTP_PRGM_MODE_BYTE_);
+	lan78xx_write_reg(dev, OTP_PRGM_MODE, OTP_PRGM_MODE_BYTE_);
 
 	for (i = 0; i < length; i++) {
-		ret = lan78xx_write_reg(dev, OTP_ADDR1,
-					((offset + i) >> 8) & OTP_ADDR1_15_11);
-		ret = lan78xx_write_reg(dev, OTP_ADDR2,
-					((offset + i) & OTP_ADDR2_10_3));
-		ret = lan78xx_write_reg(dev, OTP_PRGM_DATA, data[i]);
-		ret = lan78xx_write_reg(dev, OTP_TST_CMD, OTP_TST_CMD_PRGVRFY_);
-		ret = lan78xx_write_reg(dev, OTP_CMD_GO, OTP_CMD_GO_GO_);
+		lan78xx_write_reg(dev, OTP_ADDR1,
+				  ((offset + i) >> 8) & OTP_ADDR1_15_11);
+		lan78xx_write_reg(dev, OTP_ADDR2,
+				  ((offset + i) & OTP_ADDR2_10_3));
+		lan78xx_write_reg(dev, OTP_PRGM_DATA, data[i]);
+		lan78xx_write_reg(dev, OTP_TST_CMD, OTP_TST_CMD_PRGVRFY_);
+		lan78xx_write_reg(dev, OTP_CMD_GO, OTP_CMD_GO_GO_);
 
 		timeout = jiffies + HZ;
 		do {
 			udelay(1);
-			ret = lan78xx_read_reg(dev, OTP_STATUS, &buf);
+			lan78xx_read_reg(dev, OTP_STATUS, &buf);
 			if (time_after(jiffies, timeout)) {
 				netdev_warn(dev->net,
 					    "Timeout on OTP_STATUS completion");
@@ -975,7 +1001,7 @@ static int lan78xx_dataport_wait_not_busy(struct lan78xx_net *dev)
 		usleep_range(40, 100);
 	}
 
-	netdev_warn(dev->net, "lan78xx_dataport_wait_not_busy timed out");
+	netdev_warn(dev->net, "%s timed out", __func__);
 
 	return -EIO;
 }
@@ -988,7 +1014,7 @@ static int lan78xx_dataport_write(struct lan78xx_net *dev, u32 ram_select,
 	int i, ret;
 
 	if (usb_autopm_get_interface(dev->intf) < 0)
-			return 0;
+		return 0;
 
 	mutex_lock(&pdata->dataport_mutex);
 
@@ -1051,7 +1077,6 @@ static void lan78xx_deferred_multicast_write(struct work_struct *param)
 			container_of(param, struct lan78xx_priv, set_multicast);
 	struct lan78xx_net *dev = pdata->dev;
 	int i;
-	int ret;
 
 	netif_dbg(dev, drv, dev->net, "deferred multicast write 0x%08x\n",
 		  pdata->rfe_ctl);
@@ -1060,14 +1085,14 @@ static void lan78xx_deferred_multicast_write(struct work_struct *param)
 			       DP_SEL_VHF_HASH_LEN, pdata->mchash_table);
 
 	for (i = 1; i < NUM_OF_MAF; i++) {
-		ret = lan78xx_write_reg(dev, MAF_HI(i), 0);
-		ret = lan78xx_write_reg(dev, MAF_LO(i),
-					pdata->pfilter_table[i][1]);
-		ret = lan78xx_write_reg(dev, MAF_HI(i),
-					pdata->pfilter_table[i][0]);
+		lan78xx_write_reg(dev, MAF_HI(i), 0);
+		lan78xx_write_reg(dev, MAF_LO(i),
+				  pdata->pfilter_table[i][1]);
+		lan78xx_write_reg(dev, MAF_HI(i),
+				  pdata->pfilter_table[i][0]);
 	}
 
-	ret = lan78xx_write_reg(dev, RFE_CTL, pdata->rfe_ctl);
+	lan78xx_write_reg(dev, RFE_CTL, pdata->rfe_ctl);
 }
 
 static void lan78xx_set_multicast(struct net_device *netdev)
@@ -1083,11 +1108,12 @@ static void lan78xx_set_multicast(struct net_device *netdev)
 			    RFE_CTL_DA_PERFECT_ | RFE_CTL_MCAST_HASH_);
 
 	for (i = 0; i < DP_SEL_VHF_HASH_LEN; i++)
-			pdata->mchash_table[i] = 0;
+		pdata->mchash_table[i] = 0;
+
 	/* pfilter_table[0] has own HW address */
 	for (i = 1; i < NUM_OF_MAF; i++) {
-			pdata->pfilter_table[i][0] =
-			pdata->pfilter_table[i][1] = 0;
+		pdata->pfilter_table[i][0] = 0;
+		pdata->pfilter_table[i][1] = 0;
 	}
 
 	pdata->rfe_ctl |= RFE_CTL_BCAST_EN_;
@@ -1137,7 +1163,6 @@ static int lan78xx_update_flowcontrol(struct lan78xx_net *dev, u8 duplex,
 				      u16 lcladv, u16 rmtadv)
 {
 	u32 flow = 0, fct_flow = 0;
-	int ret;
 	u8 cap;
 
 	if (dev->fc_autoneg)
@@ -1160,10 +1185,10 @@ static int lan78xx_update_flowcontrol(struct lan78xx_net *dev, u8 duplex,
 		  (cap & FLOW_CTRL_RX ? "enabled" : "disabled"),
 		  (cap & FLOW_CTRL_TX ? "enabled" : "disabled"));
 
-	ret = lan78xx_write_reg(dev, FCT_FLOW, fct_flow);
+	lan78xx_write_reg(dev, FCT_FLOW, fct_flow);
 
 	/* threshold value should be set before enabling flow */
-	ret = lan78xx_write_reg(dev, FLOW, flow);
+	lan78xx_write_reg(dev, FLOW, flow);
 
 	return 0;
 }
@@ -1178,7 +1203,7 @@ static int lan78xx_link_reset(struct lan78xx_net *dev)
 	/* clear LAN78xx interrupt status */
 	ret = lan78xx_write_reg(dev, INT_STS, INT_STS_PHY_INT_);
 	if (unlikely(ret < 0))
-		return -EIO;
+		return ret;
 
 	mutex_lock(&phydev->lock);
 	phy_read_status(phydev);
@@ -1191,11 +1216,11 @@ static int lan78xx_link_reset(struct lan78xx_net *dev)
 		/* reset MAC */
 		ret = lan78xx_read_reg(dev, MAC_CR, &buf);
 		if (unlikely(ret < 0))
-			return -EIO;
+			return ret;
 		buf |= MAC_CR_RST_;
 		ret = lan78xx_write_reg(dev, MAC_CR, buf);
 		if (unlikely(ret < 0))
-			return -EIO;
+			return ret;
 
 		del_timer(&dev->stat_monitor);
 	} else if (link && !dev->link_on) {
@@ -1207,18 +1232,30 @@ static int lan78xx_link_reset(struct lan78xx_net *dev)
 			if (ecmd.base.speed == 1000) {
 				/* disable U2 */
 				ret = lan78xx_read_reg(dev, USB_CFG1, &buf);
+				if (ret < 0)
+					return ret;
 				buf &= ~USB_CFG1_DEV_U2_INIT_EN_;
 				ret = lan78xx_write_reg(dev, USB_CFG1, buf);
+				if (ret < 0)
+					return ret;
 				/* enable U1 */
 				ret = lan78xx_read_reg(dev, USB_CFG1, &buf);
+				if (ret < 0)
+					return ret;
 				buf |= USB_CFG1_DEV_U1_INIT_EN_;
 				ret = lan78xx_write_reg(dev, USB_CFG1, buf);
+				if (ret < 0)
+					return ret;
 			} else {
 				/* enable U1 & U2 */
 				ret = lan78xx_read_reg(dev, USB_CFG1, &buf);
+				if (ret < 0)
+					return ret;
 				buf |= USB_CFG1_DEV_U2_INIT_EN_;
 				buf |= USB_CFG1_DEV_U1_INIT_EN_;
 				ret = lan78xx_write_reg(dev, USB_CFG1, buf);
+				if (ret < 0)
+					return ret;
 			}
 		}
 
@@ -1236,6 +1273,8 @@ static int lan78xx_link_reset(struct lan78xx_net *dev)
 
 		ret = lan78xx_update_flowcontrol(dev, ecmd.base.duplex, ladv,
 						 radv);
+		if (ret < 0)
+			return ret;
 
 		if (!timer_pending(&dev->stat_monitor)) {
 			dev->delta = 1;
@@ -1246,7 +1285,7 @@ static int lan78xx_link_reset(struct lan78xx_net *dev)
 		tasklet_schedule(&dev->bh);
 	}
 
-	return ret;
+	return 0;
 }
 
 /* some work can't be done in tasklets, so we use keventd
@@ -1283,9 +1322,10 @@ static void lan78xx_status(struct lan78xx_net *dev, struct urb *urb)
 			generic_handle_irq(dev->domain_data.phyirq);
 			local_irq_enable();
 		}
-	} else
+	} else {
 		netdev_warn(dev->net,
 			    "unexpected interrupt: 0x%08x\n", intdata);
+	}
 }
 
 static int lan78xx_ethtool_get_eeprom_len(struct net_device *netdev)
@@ -1374,7 +1414,7 @@ static void lan78xx_get_wol(struct net_device *netdev,
 	struct lan78xx_priv *pdata = (struct lan78xx_priv *)(dev->data[0]);
 
 	if (usb_autopm_get_interface(dev->intf) < 0)
-			return;
+		return;
 
 	ret = lan78xx_read_reg(dev, USB_CFG0, &buf);
 	if (unlikely(ret < 0)) {
@@ -1694,11 +1734,10 @@ static int lan78xx_ioctl(struct net_device *netdev, struct ifreq *rq, int cmd)
 static void lan78xx_init_mac_address(struct lan78xx_net *dev)
 {
 	u32 addr_lo, addr_hi;
-	int ret;
 	u8 addr[6];
 
-	ret = lan78xx_read_reg(dev, RX_ADDRL, &addr_lo);
-	ret = lan78xx_read_reg(dev, RX_ADDRH, &addr_hi);
+	lan78xx_read_reg(dev, RX_ADDRL, &addr_lo);
+	lan78xx_read_reg(dev, RX_ADDRH, &addr_hi);
 
 	addr[0] = addr_lo & 0xFF;
 	addr[1] = (addr_lo >> 8) & 0xFF;
@@ -1731,12 +1770,12 @@ static void lan78xx_init_mac_address(struct lan78xx_net *dev)
 			  (addr[2] << 16) | (addr[3] << 24);
 		addr_hi = addr[4] | (addr[5] << 8);
 
-		ret = lan78xx_write_reg(dev, RX_ADDRL, addr_lo);
-		ret = lan78xx_write_reg(dev, RX_ADDRH, addr_hi);
+		lan78xx_write_reg(dev, RX_ADDRL, addr_lo);
+		lan78xx_write_reg(dev, RX_ADDRH, addr_hi);
 	}
 
-	ret = lan78xx_write_reg(dev, MAF_LO(0), addr_lo);
-	ret = lan78xx_write_reg(dev, MAF_HI(0), addr_hi | MAF_HI_VALID_);
+	lan78xx_write_reg(dev, MAF_LO(0), addr_lo);
+	lan78xx_write_reg(dev, MAF_HI(0), addr_hi | MAF_HI_VALID_);
 
 	ether_addr_copy(dev->net->dev_addr, addr);
 }
@@ -1870,7 +1909,7 @@ static void lan78xx_remove_mdio(struct lan78xx_net *dev)
 static void lan78xx_link_status_change(struct net_device *net)
 {
 	struct phy_device *phydev = net->phydev;
-	int ret, temp;
+	int temp;
 
 	/* At forced 100 F/H mode, chip may fail to set mode correctly
 	 * when cable is switched between long(~50+m) and short one.
@@ -1881,7 +1920,7 @@ static void lan78xx_link_status_change(struct net_device *net)
 		/* disable phy interrupt */
 		temp = phy_read(phydev, LAN88XX_INT_MASK);
 		temp &= ~LAN88XX_INT_MASK_MDINTPIN_EN_;
-		ret = phy_write(phydev, LAN88XX_INT_MASK, temp);
+		phy_write(phydev, LAN88XX_INT_MASK, temp);
 
 		temp = phy_read(phydev, MII_BMCR);
 		temp &= ~(BMCR_SPEED100 | BMCR_SPEED1000);
@@ -1895,7 +1934,7 @@ static void lan78xx_link_status_change(struct net_device *net)
 		/* enable phy interrupt back */
 		temp = phy_read(phydev, LAN88XX_INT_MASK);
 		temp |= LAN88XX_INT_MASK_MDINTPIN_EN_;
-		ret = phy_write(phydev, LAN88XX_INT_MASK, temp);
+		phy_write(phydev, LAN88XX_INT_MASK, temp);
 	}
 }
 
@@ -1949,14 +1988,13 @@ static void lan78xx_irq_bus_sync_unlock(struct irq_data *irqd)
 	struct lan78xx_net *dev =
 			container_of(data, struct lan78xx_net, domain_data);
 	u32 buf;
-	int ret;
 
 	/* call register access here because irq_bus_lock & irq_bus_sync_unlock
 	 * are only two callbacks executed in non-atomic contex.
 	 */
-	ret = lan78xx_read_reg(dev, INT_EP_CTL, &buf);
+	lan78xx_read_reg(dev, INT_EP_CTL, &buf);
 	if (buf != data->irqenable)
-		ret = lan78xx_write_reg(dev, INT_EP_CTL, data->irqenable);
+		lan78xx_write_reg(dev, INT_EP_CTL, data->irqenable);
 
 	mutex_unlock(&data->irq_lock);
 }
@@ -2023,7 +2061,6 @@ static void lan78xx_remove_irq_domain(struct lan78xx_net *dev)
 static int lan8835_fixup(struct phy_device *phydev)
 {
 	int buf;
-	int ret;
 	struct lan78xx_net *dev = netdev_priv(phydev->attached_dev);
 
 	/* LED2/PME_N/IRQ_N/RGMII_ID pin to IRQ_N mode */
@@ -2033,11 +2070,11 @@ static int lan8835_fixup(struct phy_device *phydev)
 	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x8010, buf);
 
 	/* RGMII MAC TXC Delay Enable */
-	ret = lan78xx_write_reg(dev, MAC_RGMII_ID,
-				MAC_RGMII_ID_TXC_DELAY_EN_);
+	lan78xx_write_reg(dev, MAC_RGMII_ID,
+			  MAC_RGMII_ID_TXC_DELAY_EN_);
 
 	/* RGMII TX DLL Tune Adjust */
-	ret = lan78xx_write_reg(dev, RGMII_TX_BYP_DLL, 0x3D00);
+	lan78xx_write_reg(dev, RGMII_TX_BYP_DLL, 0x3D00);
 
 	dev->interface = PHY_INTERFACE_MODE_RGMII_TXID;
 
@@ -2217,28 +2254,27 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 
 static int lan78xx_set_rx_max_frame_length(struct lan78xx_net *dev, int size)
 {
-	int ret = 0;
 	u32 buf;
 	bool rxenabled;
 
-	ret = lan78xx_read_reg(dev, MAC_RX, &buf);
+	lan78xx_read_reg(dev, MAC_RX, &buf);
 
 	rxenabled = ((buf & MAC_RX_RXEN_) != 0);
 
 	if (rxenabled) {
 		buf &= ~MAC_RX_RXEN_;
-		ret = lan78xx_write_reg(dev, MAC_RX, buf);
+		lan78xx_write_reg(dev, MAC_RX, buf);
 	}
 
 	/* add 4 to size for FCS */
 	buf &= ~MAC_RX_MAX_SIZE_MASK_;
 	buf |= (((size + 4) << MAC_RX_MAX_SIZE_SHIFT_) & MAC_RX_MAX_SIZE_MASK_);
 
-	ret = lan78xx_write_reg(dev, MAC_RX, buf);
+	lan78xx_write_reg(dev, MAC_RX, buf);
 
 	if (rxenabled) {
 		buf |= MAC_RX_RXEN_;
-		ret = lan78xx_write_reg(dev, MAC_RX, buf);
+		lan78xx_write_reg(dev, MAC_RX, buf);
 	}
 
 	return 0;
@@ -2301,7 +2337,11 @@ static int lan78xx_change_mtu(struct net_device *netdev, int new_mtu)
 	if ((ll_mtu % dev->maxpacket) == 0)
 		return -EDOM;
 
-	ret = lan78xx_set_rx_max_frame_length(dev, new_mtu + VLAN_ETH_HLEN);
+	ret = usb_autopm_get_interface(dev->intf);
+	if (ret < 0)
+		return ret;
+
+	lan78xx_set_rx_max_frame_length(dev, new_mtu + VLAN_ETH_HLEN);
 
 	netdev->mtu = new_mtu;
 
@@ -2316,6 +2356,8 @@ static int lan78xx_change_mtu(struct net_device *netdev, int new_mtu)
 		}
 	}
 
+	usb_autopm_put_interface(dev->intf);
+
 	return 0;
 }
 
@@ -2324,7 +2366,6 @@ static int lan78xx_set_mac_addr(struct net_device *netdev, void *p)
 	struct lan78xx_net *dev = netdev_priv(netdev);
 	struct sockaddr *addr = p;
 	u32 addr_lo, addr_hi;
-	int ret;
 
 	if (netif_running(netdev))
 		return -EBUSY;
@@ -2341,12 +2382,12 @@ static int lan78xx_set_mac_addr(struct net_device *netdev, void *p)
 	addr_hi = netdev->dev_addr[4] |
 		  netdev->dev_addr[5] << 8;
 
-	ret = lan78xx_write_reg(dev, RX_ADDRL, addr_lo);
-	ret = lan78xx_write_reg(dev, RX_ADDRH, addr_hi);
+	lan78xx_write_reg(dev, RX_ADDRL, addr_lo);
+	lan78xx_write_reg(dev, RX_ADDRH, addr_hi);
 
 	/* Added to support MAC address changes */
-	ret = lan78xx_write_reg(dev, MAF_LO(0), addr_lo);
-	ret = lan78xx_write_reg(dev, MAF_HI(0), addr_hi | MAF_HI_VALID_);
+	lan78xx_write_reg(dev, MAF_LO(0), addr_lo);
+	lan78xx_write_reg(dev, MAF_HI(0), addr_hi | MAF_HI_VALID_);
 
 	return 0;
 }
@@ -2358,7 +2399,6 @@ static int lan78xx_set_features(struct net_device *netdev,
 	struct lan78xx_net *dev = netdev_priv(netdev);
 	struct lan78xx_priv *pdata = (struct lan78xx_priv *)(dev->data[0]);
 	unsigned long flags;
-	int ret;
 
 	spin_lock_irqsave(&pdata->rfe_ctl_lock, flags);
 
@@ -2382,7 +2422,7 @@ static int lan78xx_set_features(struct net_device *netdev,
 
 	spin_unlock_irqrestore(&pdata->rfe_ctl_lock, flags);
 
-	ret = lan78xx_write_reg(dev, RFE_CTL, pdata->rfe_ctl);
+	lan78xx_write_reg(dev, RFE_CTL, pdata->rfe_ctl);
 
 	return 0;
 }
@@ -2474,26 +2514,186 @@ static void lan78xx_init_ltm(struct lan78xx_net *dev)
 	lan78xx_write_reg(dev, LTM_INACTIVE1, regs[5]);
 }
 
+static int lan78xx_start_hw(struct lan78xx_net *dev, u32 reg, u32 hw_enable)
+{
+	return lan78xx_update_reg(dev, reg, hw_enable, hw_enable);
+}
+
+static int lan78xx_stop_hw(struct lan78xx_net *dev, u32 reg, u32 hw_enabled,
+			   u32 hw_disabled)
+{
+	unsigned long timeout;
+	bool stopped = true;
+	int ret;
+	u32 buf;
+
+	/* Stop the h/w block (if not already stopped) */
+
+	ret = lan78xx_read_reg(dev, reg, &buf);
+	if (ret < 0)
+		return ret;
+
+	if (buf & hw_enabled) {
+		buf &= ~hw_enabled;
+
+		ret = lan78xx_write_reg(dev, reg, buf);
+		if (ret < 0)
+			return ret;
+
+		stopped = false;
+		timeout = jiffies + HW_DISABLE_TIMEOUT;
+		do  {
+			ret = lan78xx_read_reg(dev, reg, &buf);
+			if (ret < 0)
+				return ret;
+
+			if (buf & hw_disabled)
+				stopped = true;
+			else
+				msleep(HW_DISABLE_DELAY_MS);
+		} while (!stopped && !time_after(jiffies, timeout));
+	}
+
+	ret = stopped ? 0 : -ETIME;
+
+	return ret;
+}
+
+static int lan78xx_flush_fifo(struct lan78xx_net *dev, u32 reg, u32 fifo_flush)
+{
+	return lan78xx_update_reg(dev, reg, fifo_flush, fifo_flush);
+}
+
+static int lan78xx_start_tx_path(struct lan78xx_net *dev)
+{
+	int ret;
+
+	netif_dbg(dev, drv, dev->net, "start tx path");
+
+	/* Start the MAC transmitter */
+
+	ret = lan78xx_start_hw(dev, MAC_TX, MAC_TX_TXEN_);
+	if (ret < 0)
+		return ret;
+
+	/* Start the Tx FIFO */
+
+	ret = lan78xx_start_hw(dev, FCT_TX_CTL, FCT_TX_CTL_EN_);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int lan78xx_stop_tx_path(struct lan78xx_net *dev)
+{
+	int ret;
+
+	netif_dbg(dev, drv, dev->net, "stop tx path");
+
+	/* Stop the Tx FIFO */
+
+	ret = lan78xx_stop_hw(dev, FCT_TX_CTL, FCT_TX_CTL_EN_, FCT_TX_CTL_DIS_);
+	if (ret < 0)
+		return ret;
+
+	/* Stop the MAC transmitter */
+
+	ret = lan78xx_stop_hw(dev, MAC_TX, MAC_TX_TXEN_, MAC_TX_TXD_);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/* The caller must ensure the Tx path is stopped before calling
+ * lan78xx_flush_tx_fifo().
+ */
+static int lan78xx_flush_tx_fifo(struct lan78xx_net *dev)
+{
+	return lan78xx_flush_fifo(dev, FCT_TX_CTL, FCT_TX_CTL_RST_);
+}
+
+static int lan78xx_start_rx_path(struct lan78xx_net *dev)
+{
+	int ret;
+
+	netif_dbg(dev, drv, dev->net, "start rx path");
+
+	/* Start the Rx FIFO */
+
+	ret = lan78xx_start_hw(dev, FCT_RX_CTL, FCT_RX_CTL_EN_);
+	if (ret < 0)
+		return ret;
+
+	/* Start the MAC receiver*/
+
+	ret = lan78xx_start_hw(dev, MAC_RX, MAC_RX_RXEN_);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int lan78xx_stop_rx_path(struct lan78xx_net *dev)
+{
+	int ret;
+
+	netif_dbg(dev, drv, dev->net, "stop rx path");
+
+	/* Stop the MAC receiver */
+
+	ret = lan78xx_stop_hw(dev, MAC_RX, MAC_RX_RXEN_, MAC_RX_RXD_);
+	if (ret < 0)
+		return ret;
+
+	/* Stop the Rx FIFO */
+
+	ret = lan78xx_stop_hw(dev, FCT_RX_CTL, FCT_RX_CTL_EN_, FCT_RX_CTL_DIS_);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/* The caller must ensure the Rx path is stopped before calling
+ * lan78xx_flush_rx_fifo().
+ */
+static int lan78xx_flush_rx_fifo(struct lan78xx_net *dev)
+{
+	return lan78xx_flush_fifo(dev, FCT_RX_CTL, FCT_RX_CTL_RST_);
+}
+
 static int lan78xx_reset(struct lan78xx_net *dev)
 {
 	struct lan78xx_priv *pdata = (struct lan78xx_priv *)(dev->data[0]);
-	u32 buf;
-	int ret = 0;
 	unsigned long timeout;
+	int ret;
+	u32 buf;
 	u8 sig;
 
 	ret = lan78xx_read_reg(dev, HW_CFG, &buf);
+	if (ret < 0)
+		return ret;
+
 	buf |= HW_CFG_LRST_;
+
 	ret = lan78xx_write_reg(dev, HW_CFG, buf);
+	if (ret < 0)
+		return ret;
 
 	timeout = jiffies + HZ;
 	do {
 		mdelay(1);
 		ret = lan78xx_read_reg(dev, HW_CFG, &buf);
+		if (ret < 0)
+			return ret;
+
 		if (time_after(jiffies, timeout)) {
 			netdev_warn(dev->net,
 				    "timeout on completion of LiteReset");
-			return -EIO;
+			ret = -ETIMEDOUT;
+			return ret;
 		}
 	} while (buf & HW_CFG_LRST_);
 
@@ -2501,13 +2701,22 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 
 	/* save DEVID for later usage */
 	ret = lan78xx_read_reg(dev, ID_REV, &buf);
+	if (ret < 0)
+		return ret;
+
 	dev->chipid = (buf & ID_REV_CHIP_ID_MASK_) >> 16;
 	dev->chiprev = buf & ID_REV_CHIP_REV_MASK_;
 
 	/* Respond to the IN token with a NAK */
 	ret = lan78xx_read_reg(dev, USB_CFG0, &buf);
+	if (ret < 0)
+		return ret;
+
 	buf |= USB_CFG_BIR_;
+
 	ret = lan78xx_write_reg(dev, USB_CFG0, buf);
+	if (ret < 0)
+		return ret;
 
 	/* Init LTM */
 	lan78xx_init_ltm(dev);
@@ -2530,53 +2739,105 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 	}
 
 	ret = lan78xx_write_reg(dev, BURST_CAP, buf);
+	if (ret < 0)
+		return ret;
+
 	ret = lan78xx_write_reg(dev, BULK_IN_DLY, DEFAULT_BULK_IN_DELAY);
+	if (ret < 0)
+		return ret;
 
 	ret = lan78xx_read_reg(dev, HW_CFG, &buf);
+	if (ret < 0)
+		return ret;
+
 	buf |= HW_CFG_MEF_;
+
 	ret = lan78xx_write_reg(dev, HW_CFG, buf);
+	if (ret < 0)
+		return ret;
 
 	ret = lan78xx_read_reg(dev, USB_CFG0, &buf);
+	if (ret < 0)
+		return ret;
+
 	buf |= USB_CFG_BCE_;
+
 	ret = lan78xx_write_reg(dev, USB_CFG0, buf);
+	if (ret < 0)
+		return ret;
 
 	/* set FIFO sizes */
 	buf = (MAX_RX_FIFO_SIZE - 512) / 512;
+
 	ret = lan78xx_write_reg(dev, FCT_RX_FIFO_END, buf);
+	if (ret < 0)
+		return ret;
 
 	buf = (MAX_TX_FIFO_SIZE - 512) / 512;
+
 	ret = lan78xx_write_reg(dev, FCT_TX_FIFO_END, buf);
+	if (ret < 0)
+		return ret;
 
 	ret = lan78xx_write_reg(dev, INT_STS, INT_STS_CLEAR_ALL_);
+	if (ret < 0)
+		return ret;
+
 	ret = lan78xx_write_reg(dev, FLOW, 0);
+	if (ret < 0)
+		return ret;
+
 	ret = lan78xx_write_reg(dev, FCT_FLOW, 0);
+	if (ret < 0)
+		return ret;
 
 	/* Don't need rfe_ctl_lock during initialisation */
 	ret = lan78xx_read_reg(dev, RFE_CTL, &pdata->rfe_ctl);
+	if (ret < 0)
+		return ret;
+
 	pdata->rfe_ctl |= RFE_CTL_BCAST_EN_ | RFE_CTL_DA_PERFECT_;
+
 	ret = lan78xx_write_reg(dev, RFE_CTL, pdata->rfe_ctl);
+	if (ret < 0)
+		return ret;
 
 	/* Enable or disable checksum offload engines */
-	lan78xx_set_features(dev->net, dev->net->features);
+	ret = lan78xx_set_features(dev->net, dev->net->features);
+	if (ret < 0)
+		return ret;
 
 	lan78xx_set_multicast(dev->net);
 
 	/* reset PHY */
 	ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
+	if (ret < 0)
+		return ret;
+
 	buf |= PMT_CTL_PHY_RST_;
+
 	ret = lan78xx_write_reg(dev, PMT_CTL, buf);
+	if (ret < 0)
+		return ret;
 
 	timeout = jiffies + HZ;
 	do {
 		mdelay(1);
 		ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
+		if (ret < 0)
+			return ret;
+
 		if (time_after(jiffies, timeout)) {
 			netdev_warn(dev->net, "timeout waiting for PHY Reset");
-			return -EIO;
+			ret = -ETIMEDOUT;
+			return ret;
 		}
 	} while ((buf & PMT_CTL_PHY_RST_) || !(buf & PMT_CTL_READY_));
 
 	ret = lan78xx_read_reg(dev, MAC_CR, &buf);
+	if (ret < 0)
+		return ret;
+
 	/* LAN7801 only has RGMII mode */
 	if (dev->chipid == ID_REV_CHIP_ID_7801_)
 		buf &= ~MAC_CR_GMII_EN_;
@@ -2591,27 +2852,13 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 		}
 	}
 	ret = lan78xx_write_reg(dev, MAC_CR, buf);
-
-	ret = lan78xx_read_reg(dev, MAC_TX, &buf);
-	buf |= MAC_TX_TXEN_;
-	ret = lan78xx_write_reg(dev, MAC_TX, buf);
-
-	ret = lan78xx_read_reg(dev, FCT_TX_CTL, &buf);
-	buf |= FCT_TX_CTL_EN_;
-	ret = lan78xx_write_reg(dev, FCT_TX_CTL, buf);
+	if (ret < 0)
+		return ret;
 
 	ret = lan78xx_set_rx_max_frame_length(dev,
 					      dev->net->mtu + VLAN_ETH_HLEN);
 
-	ret = lan78xx_read_reg(dev, MAC_RX, &buf);
-	buf |= MAC_RX_RXEN_;
-	ret = lan78xx_write_reg(dev, MAC_RX, buf);
-
-	ret = lan78xx_read_reg(dev, FCT_RX_CTL, &buf);
-	buf |= FCT_RX_CTL_EN_;
-	ret = lan78xx_write_reg(dev, FCT_RX_CTL, buf);
-
-	return 0;
+	return ret;
 }
 
 static void lan78xx_init_stats(struct lan78xx_net *dev)
@@ -2645,9 +2892,13 @@ static int lan78xx_open(struct net_device *net)
 	struct lan78xx_net *dev = netdev_priv(net);
 	int ret;
 
+	netif_dbg(dev, ifup, dev->net, "open device");
+
 	ret = usb_autopm_get_interface(dev->intf);
 	if (ret < 0)
-		goto out;
+		return ret;
+
+	mutex_lock(&dev->dev_mutex);
 
 	phy_start(net->phydev);
 
@@ -2663,6 +2914,20 @@ static int lan78xx_open(struct net_device *net)
 		}
 	}
 
+	ret = lan78xx_flush_rx_fifo(dev);
+	if (ret < 0)
+		goto done;
+	ret = lan78xx_flush_tx_fifo(dev);
+	if (ret < 0)
+		goto done;
+
+	ret = lan78xx_start_tx_path(dev);
+	if (ret < 0)
+		goto done;
+	ret = lan78xx_start_rx_path(dev);
+	if (ret < 0)
+		goto done;
+
 	lan78xx_init_stats(dev);
 
 	set_bit(EVENT_DEV_OPEN, &dev->flags);
@@ -2673,9 +2938,11 @@ static int lan78xx_open(struct net_device *net)
 
 	lan78xx_defer_kevent(dev, EVENT_LINK_RESET);
 done:
-	usb_autopm_put_interface(dev->intf);
+	mutex_unlock(&dev->dev_mutex);
+
+	if (ret < 0)
+		usb_autopm_put_interface(dev->intf);
 
-out:
 	return ret;
 }
 
@@ -2692,38 +2959,56 @@ static void lan78xx_terminate_urbs(struct lan78xx_net *dev)
 	temp = unlink_urbs(dev, &dev->txq) + unlink_urbs(dev, &dev->rxq);
 
 	/* maybe wait for deletions to finish. */
-	while (!skb_queue_empty(&dev->rxq) &&
-	       !skb_queue_empty(&dev->txq) &&
-	       !skb_queue_empty(&dev->done)) {
+	while (!skb_queue_empty(&dev->rxq) ||
+	       !skb_queue_empty(&dev->txq)) {
 		schedule_timeout(msecs_to_jiffies(UNLINK_TIMEOUT_MS));
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		netif_dbg(dev, ifdown, dev->net,
-			  "waited for %d urb completions\n", temp);
+			  "waited for %d urb completions", temp);
 	}
 	set_current_state(TASK_RUNNING);
 	dev->wait = NULL;
 	remove_wait_queue(&unlink_wakeup, &wait);
+
+	while (!skb_queue_empty(&dev->done)) {
+		struct skb_data *entry;
+		struct sk_buff *skb;
+
+		skb = skb_dequeue(&dev->done);
+		entry = (struct skb_data *)(skb->cb);
+		usb_free_urb(entry->urb);
+		dev_kfree_skb(skb);
+	}
 }
 
 static int lan78xx_stop(struct net_device *net)
 {
 	struct lan78xx_net		*dev = netdev_priv(net);
 
+	netif_dbg(dev, ifup, dev->net, "stop device");
+
+	mutex_lock(&dev->dev_mutex);
+
 	if (timer_pending(&dev->stat_monitor))
 		del_timer_sync(&dev->stat_monitor);
 
-	if (net->phydev)
-		phy_stop(net->phydev);
-
 	clear_bit(EVENT_DEV_OPEN, &dev->flags);
 	netif_stop_queue(net);
+	tasklet_kill(&dev->bh);
+
+	lan78xx_terminate_urbs(dev);
 
 	netif_info(dev, ifdown, dev->net,
 		   "stop stats: rx/tx %lu/%lu, errs %lu/%lu\n",
 		   net->stats.rx_packets, net->stats.tx_packets,
 		   net->stats.rx_errors, net->stats.tx_errors);
 
-	lan78xx_terminate_urbs(dev);
+	/* ignore errors that occur stopping the Tx and Rx data paths */
+	lan78xx_stop_tx_path(dev);
+	lan78xx_stop_rx_path(dev);
+
+	if (net->phydev)
+		phy_stop(net->phydev);
 
 	usb_kill_urb(dev->urb_intr);
 
@@ -2733,12 +3018,17 @@ static int lan78xx_stop(struct net_device *net)
 	 * can't flush_scheduled_work() until we drop rtnl (later),
 	 * else workers could deadlock; so make workers a NOP.
 	 */
-	dev->flags = 0;
+	clear_bit(EVENT_TX_HALT, &dev->flags);
+	clear_bit(EVENT_RX_HALT, &dev->flags);
+	clear_bit(EVENT_LINK_RESET, &dev->flags);
+	clear_bit(EVENT_STAT_UPDATE, &dev->flags);
+
 	cancel_delayed_work_sync(&dev->wq);
-	tasklet_kill(&dev->bh);
 
 	usb_autopm_put_interface(dev->intf);
 
+	mutex_unlock(&dev->dev_mutex);
+
 	return 0;
 }
 
@@ -2864,6 +3154,9 @@ lan78xx_start_xmit(struct sk_buff *skb, struct net_device *net)
 	struct lan78xx_net *dev = netdev_priv(net);
 	struct sk_buff *skb2 = NULL;
 
+	if (test_bit(EVENT_DEV_ASLEEP, &dev->flags))
+		schedule_delayed_work(&dev->wq, 0);
+
 	if (skb) {
 		skb_tx_timestamp(skb);
 		skb2 = lan78xx_tx_prep(dev, skb, GFP_ATOMIC);
@@ -3394,9 +3687,10 @@ static void lan78xx_tx_bh(struct lan78xx_net *dev)
 		if (skb)
 			dev_kfree_skb_any(skb);
 		usb_free_urb(urb);
-	} else
+	} else {
 		netif_dbg(dev, tx_queued, dev->net,
 			  "> tx, len %d, type 0x%x\n", length, skb->protocol);
+	}
 }
 
 static void lan78xx_rx_bh(struct lan78xx_net *dev)
@@ -3472,18 +3766,17 @@ static void lan78xx_delayedwork(struct work_struct *work)
 
 	dev = container_of(work, struct lan78xx_net, wq.work);
 
+	if (usb_autopm_get_interface(dev->intf) < 0)
+		return;
+
 	if (test_bit(EVENT_TX_HALT, &dev->flags)) {
 		unlink_urbs(dev, &dev->txq);
-		status = usb_autopm_get_interface(dev->intf);
-		if (status < 0)
-			goto fail_pipe;
+
 		status = usb_clear_halt(dev->udev, dev->pipe_out);
-		usb_autopm_put_interface(dev->intf);
 		if (status < 0 &&
 		    status != -EPIPE &&
 		    status != -ESHUTDOWN) {
 			if (netif_msg_tx_err(dev))
-fail_pipe:
 				netdev_err(dev->net,
 					   "can't clear tx halt, status %d\n",
 					   status);
@@ -3493,18 +3786,14 @@ static void lan78xx_delayedwork(struct work_struct *work)
 				netif_wake_queue(dev->net);
 		}
 	}
+
 	if (test_bit(EVENT_RX_HALT, &dev->flags)) {
 		unlink_urbs(dev, &dev->rxq);
-		status = usb_autopm_get_interface(dev->intf);
-		if (status < 0)
-				goto fail_halt;
 		status = usb_clear_halt(dev->udev, dev->pipe_in);
-		usb_autopm_put_interface(dev->intf);
 		if (status < 0 &&
 		    status != -EPIPE &&
 		    status != -ESHUTDOWN) {
 			if (netif_msg_rx_err(dev))
-fail_halt:
 				netdev_err(dev->net,
 					   "can't clear rx halt, status %d\n",
 					   status);
@@ -3518,16 +3807,9 @@ static void lan78xx_delayedwork(struct work_struct *work)
 		int ret = 0;
 
 		clear_bit(EVENT_LINK_RESET, &dev->flags);
-		status = usb_autopm_get_interface(dev->intf);
-		if (status < 0)
-			goto skip_reset;
 		if (lan78xx_link_reset(dev) < 0) {
-			usb_autopm_put_interface(dev->intf);
-skip_reset:
 			netdev_info(dev->net, "link reset failed (%d)\n",
 				    ret);
-		} else {
-			usb_autopm_put_interface(dev->intf);
 		}
 	}
 
@@ -3541,6 +3823,8 @@ static void lan78xx_delayedwork(struct work_struct *work)
 
 		dev->delta = min((dev->delta * 2), 50);
 	}
+
+	usb_autopm_put_interface(dev->intf);
 }
 
 static void intr_complete(struct urb *urb)
@@ -3670,8 +3954,8 @@ static int lan78xx_probe(struct usb_interface *intf,
 	struct net_device *netdev;
 	struct usb_device *udev;
 	int ret;
-	unsigned maxp;
-	unsigned period;
+	unsigned int maxp;
+	unsigned int period;
 	u8 *buf = NULL;
 
 	udev = interface_to_usbdev(intf);
@@ -3700,6 +3984,7 @@ static int lan78xx_probe(struct usb_interface *intf,
 	skb_queue_head_init(&dev->rxq_pause);
 	skb_queue_head_init(&dev->txq_pend);
 	mutex_init(&dev->phy_mutex);
+	mutex_init(&dev->dev_mutex);
 
 	tasklet_init(&dev->bh, lan78xx_bh, (unsigned long)dev);
 	INIT_DELAYED_WORK(&dev->wq, lan78xx_delayedwork);
@@ -3843,38 +4128,119 @@ static u16 lan78xx_wakeframe_crc16(const u8 *buf, int len)
 	return crc;
 }
 
-static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
+static int lan78xx_set_auto_suspend(struct lan78xx_net *dev)
 {
 	u32 buf;
 	int ret;
-	int mask_index;
-	u16 crc;
-	u32 temp_wucsr;
-	u32 temp_pmt_ctl;
+
+	ret = lan78xx_stop_tx_path(dev);
+	if (ret < 0)
+		return ret;
+
+	ret = lan78xx_stop_rx_path(dev);
+	if (ret < 0)
+		return ret;
+
+	/* auto suspend (selective suspend) */
+
+	ret = lan78xx_write_reg(dev, WUCSR, 0);
+	if (ret < 0)
+		return ret;
+	ret = lan78xx_write_reg(dev, WUCSR2, 0);
+	if (ret < 0)
+		return ret;
+	ret = lan78xx_write_reg(dev, WK_SRC, 0xFFF1FF1FUL);
+	if (ret < 0)
+		return ret;
+
+	/* set goodframe wakeup */
+
+	ret = lan78xx_read_reg(dev, WUCSR, &buf);
+	if (ret < 0)
+		return ret;
+
+	buf |= WUCSR_RFE_WAKE_EN_;
+	buf |= WUCSR_STORE_WAKE_;
+
+	ret = lan78xx_write_reg(dev, WUCSR, buf);
+	if (ret < 0)
+		return ret;
+
+	ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
+	if (ret < 0)
+		return ret;
+
+	buf &= ~PMT_CTL_RES_CLR_WKP_EN_;
+	buf |= PMT_CTL_RES_CLR_WKP_STS_;
+	buf |= PMT_CTL_PHY_WAKE_EN_;
+	buf |= PMT_CTL_WOL_EN_;
+	buf &= ~PMT_CTL_SUS_MODE_MASK_;
+	buf |= PMT_CTL_SUS_MODE_3_;
+
+	ret = lan78xx_write_reg(dev, PMT_CTL, buf);
+	if (ret < 0)
+		return ret;
+
+	ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
+	if (ret < 0)
+		return ret;
+
+	buf |= PMT_CTL_WUPS_MASK_;
+
+	ret = lan78xx_write_reg(dev, PMT_CTL, buf);
+	if (ret < 0)
+		return ret;
+
+	ret = lan78xx_start_rx_path(dev);
+
+	return ret;
+}
+
+static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
+{
 	const u8 ipv4_multicast[3] = { 0x01, 0x00, 0x5E };
 	const u8 ipv6_multicast[3] = { 0x33, 0x33 };
 	const u8 arp_type[2] = { 0x08, 0x06 };
+	u32 temp_pmt_ctl;
+	int mask_index;
+	u32 temp_wucsr;
+	u32 buf;
+	u16 crc;
+	int ret;
 
-	ret = lan78xx_read_reg(dev, MAC_TX, &buf);
-	buf &= ~MAC_TX_TXEN_;
-	ret = lan78xx_write_reg(dev, MAC_TX, buf);
-	ret = lan78xx_read_reg(dev, MAC_RX, &buf);
-	buf &= ~MAC_RX_RXEN_;
-	ret = lan78xx_write_reg(dev, MAC_RX, buf);
+	ret = lan78xx_stop_tx_path(dev);
+	if (ret < 0)
+		return ret;
+	ret = lan78xx_stop_rx_path(dev);
+	if (ret < 0)
+		return ret;
 
 	ret = lan78xx_write_reg(dev, WUCSR, 0);
+	if (ret < 0)
+		return ret;
 	ret = lan78xx_write_reg(dev, WUCSR2, 0);
+	if (ret < 0)
+		return ret;
 	ret = lan78xx_write_reg(dev, WK_SRC, 0xFFF1FF1FUL);
+	if (ret < 0)
+		return ret;
 
 	temp_wucsr = 0;
 
 	temp_pmt_ctl = 0;
+
 	ret = lan78xx_read_reg(dev, PMT_CTL, &temp_pmt_ctl);
+	if (ret < 0)
+		return ret;
+
 	temp_pmt_ctl &= ~PMT_CTL_RES_CLR_WKP_EN_;
 	temp_pmt_ctl |= PMT_CTL_RES_CLR_WKP_STS_;
 
-	for (mask_index = 0; mask_index < NUM_OF_WUF_CFG; mask_index++)
+	for (mask_index = 0; mask_index < NUM_OF_WUF_CFG; mask_index++) {
 		ret = lan78xx_write_reg(dev, WUF_CFG(mask_index), 0);
+		if (ret < 0)
+			return ret;
+	}
 
 	mask_index = 0;
 	if (wol & WAKE_PHY) {
@@ -3908,11 +4274,22 @@ static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
 					WUF_CFGX_TYPE_MCAST_ |
 					(0 << WUF_CFGX_OFFSET_SHIFT_) |
 					(crc & WUF_CFGX_CRC16_MASK_));
+		if (ret < 0)
+			return ret;
 
 		ret = lan78xx_write_reg(dev, WUF_MASK0(mask_index), 7);
+		if (ret < 0)
+			return ret;
 		ret = lan78xx_write_reg(dev, WUF_MASK1(mask_index), 0);
+		if (ret < 0)
+			return ret;
 		ret = lan78xx_write_reg(dev, WUF_MASK2(mask_index), 0);
+		if (ret < 0)
+			return ret;
 		ret = lan78xx_write_reg(dev, WUF_MASK3(mask_index), 0);
+		if (ret < 0)
+			return ret;
+
 		mask_index++;
 
 		/* for IPv6 Multicast */
@@ -3922,11 +4299,22 @@ static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
 					WUF_CFGX_TYPE_MCAST_ |
 					(0 << WUF_CFGX_OFFSET_SHIFT_) |
 					(crc & WUF_CFGX_CRC16_MASK_));
+		if (ret < 0)
+			return ret;
 
 		ret = lan78xx_write_reg(dev, WUF_MASK0(mask_index), 3);
+		if (ret < 0)
+			return ret;
 		ret = lan78xx_write_reg(dev, WUF_MASK1(mask_index), 0);
+		if (ret < 0)
+			return ret;
 		ret = lan78xx_write_reg(dev, WUF_MASK2(mask_index), 0);
+		if (ret < 0)
+			return ret;
 		ret = lan78xx_write_reg(dev, WUF_MASK3(mask_index), 0);
+		if (ret < 0)
+			return ret;
+
 		mask_index++;
 
 		temp_pmt_ctl |= PMT_CTL_WOL_EN_;
@@ -3952,11 +4340,22 @@ static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
 					WUF_CFGX_TYPE_ALL_ |
 					(0 << WUF_CFGX_OFFSET_SHIFT_) |
 					(crc & WUF_CFGX_CRC16_MASK_));
+		if (ret < 0)
+			return ret;
 
 		ret = lan78xx_write_reg(dev, WUF_MASK0(mask_index), 0x3000);
+		if (ret < 0)
+			return ret;
 		ret = lan78xx_write_reg(dev, WUF_MASK1(mask_index), 0);
+		if (ret < 0)
+			return ret;
 		ret = lan78xx_write_reg(dev, WUF_MASK2(mask_index), 0);
+		if (ret < 0)
+			return ret;
 		ret = lan78xx_write_reg(dev, WUF_MASK3(mask_index), 0);
+		if (ret < 0)
+			return ret;
+
 		mask_index++;
 
 		temp_pmt_ctl |= PMT_CTL_WOL_EN_;
@@ -3965,6 +4364,8 @@ static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
 	}
 
 	ret = lan78xx_write_reg(dev, WUCSR, temp_wucsr);
+	if (ret < 0)
+		return ret;
 
 	/* when multiple WOL bits are set */
 	if (hweight_long((unsigned long)wol) > 1) {
@@ -3973,35 +4374,47 @@ static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
 		temp_pmt_ctl |= PMT_CTL_SUS_MODE_0_;
 	}
 	ret = lan78xx_write_reg(dev, PMT_CTL, temp_pmt_ctl);
+	if (ret < 0)
+		return ret;
 
 	/* clear WUPS */
 	ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
+	if (ret < 0)
+		return ret;
+
 	buf |= PMT_CTL_WUPS_MASK_;
+
 	ret = lan78xx_write_reg(dev, PMT_CTL, buf);
+	if (ret < 0)
+		return ret;
 
-	ret = lan78xx_read_reg(dev, MAC_RX, &buf);
-	buf |= MAC_RX_RXEN_;
-	ret = lan78xx_write_reg(dev, MAC_RX, buf);
+	ret = lan78xx_start_rx_path(dev);
 
-	return 0;
+	return ret;
 }
 
 static int lan78xx_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct lan78xx_net *dev = usb_get_intfdata(intf);
-	struct lan78xx_priv *pdata = (struct lan78xx_priv *)(dev->data[0]);
-	u32 buf;
+	bool dev_open;
 	int ret;
 	int event;
 
 	event = message.event;
 
-	if (!dev->suspend_count++) {
+	mutex_lock(&dev->dev_mutex);
+
+	netif_dbg(dev, ifdown, dev->net,
+		  "suspending: pm event %#x", message.event);
+
+	dev_open = test_bit(EVENT_DEV_OPEN, &dev->flags);
+
+	if (dev_open) {
 		spin_lock_irq(&dev->txq.lock);
 		/* don't autosuspend while transmitting */
 		if ((skb_queue_len(&dev->txq) ||
 		     skb_queue_len(&dev->txq_pend)) &&
-			PMSG_IS_AUTO(message)) {
+		    PMSG_IS_AUTO(message)) {
 			spin_unlock_irq(&dev->txq.lock);
 			ret = -EBUSY;
 			goto out;
@@ -4010,129 +4423,207 @@ static int lan78xx_suspend(struct usb_interface *intf, pm_message_t message)
 			spin_unlock_irq(&dev->txq.lock);
 		}
 
-		/* stop TX & RX */
-		ret = lan78xx_read_reg(dev, MAC_TX, &buf);
-		buf &= ~MAC_TX_TXEN_;
-		ret = lan78xx_write_reg(dev, MAC_TX, buf);
-		ret = lan78xx_read_reg(dev, MAC_RX, &buf);
-		buf &= ~MAC_RX_RXEN_;
-		ret = lan78xx_write_reg(dev, MAC_RX, buf);
+		/* stop RX */
+		ret = lan78xx_stop_rx_path(dev);
+		if (ret < 0)
+			goto out;
 
-		/* empty out the rx and queues */
+		ret = lan78xx_flush_rx_fifo(dev);
+		if (ret < 0)
+			goto out;
+
+		/* stop Tx */
+		ret = lan78xx_stop_tx_path(dev);
+		if (ret < 0)
+			goto out;
+
+		/* empty out the Rx and Tx queues */
 		netif_device_detach(dev->net);
 		lan78xx_terminate_urbs(dev);
 		usb_kill_urb(dev->urb_intr);
 
 		/* reattach */
 		netif_device_attach(dev->net);
-	}
 
-	if (test_bit(EVENT_DEV_ASLEEP, &dev->flags)) {
 		del_timer(&dev->stat_monitor);
 
 		if (PMSG_IS_AUTO(message)) {
-			/* auto suspend (selective suspend) */
-			ret = lan78xx_read_reg(dev, MAC_TX, &buf);
-			buf &= ~MAC_TX_TXEN_;
-			ret = lan78xx_write_reg(dev, MAC_TX, buf);
-			ret = lan78xx_read_reg(dev, MAC_RX, &buf);
-			buf &= ~MAC_RX_RXEN_;
-			ret = lan78xx_write_reg(dev, MAC_RX, buf);
+			ret = lan78xx_set_auto_suspend(dev);
+			if (ret < 0)
+				goto out;
+		} else {
+			struct lan78xx_priv *pdata;
 
-			ret = lan78xx_write_reg(dev, WUCSR, 0);
-			ret = lan78xx_write_reg(dev, WUCSR2, 0);
-			ret = lan78xx_write_reg(dev, WK_SRC, 0xFFF1FF1FUL);
+			pdata = (struct lan78xx_priv *)(dev->data[0]);
+			netif_carrier_off(dev->net);
+			ret = lan78xx_set_suspend(dev, pdata->wol);
+			if (ret < 0)
+				goto out;
+		}
+	} else {
+		/* Interface is down; don't allow WOL and PHY
+		 * events to wake up the host
+		 */
+		u32 buf;
 
-			/* set goodframe wakeup */
-			ret = lan78xx_read_reg(dev, WUCSR, &buf);
+		set_bit(EVENT_DEV_ASLEEP, &dev->flags);
 
-			buf |= WUCSR_RFE_WAKE_EN_;
-			buf |= WUCSR_STORE_WAKE_;
+		ret = lan78xx_write_reg(dev, WUCSR, 0);
+		if (ret < 0)
+			goto out;
+		ret = lan78xx_write_reg(dev, WUCSR2, 0);
+		if (ret < 0)
+			goto out;
 
-			ret = lan78xx_write_reg(dev, WUCSR, buf);
+		ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
+		if (ret < 0)
+			goto out;
 
-			ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
+		buf &= ~PMT_CTL_RES_CLR_WKP_EN_;
+		buf |= PMT_CTL_RES_CLR_WKP_STS_;
+		buf &= ~PMT_CTL_SUS_MODE_MASK_;
+		buf |= PMT_CTL_SUS_MODE_3_;
 
-			buf &= ~PMT_CTL_RES_CLR_WKP_EN_;
-			buf |= PMT_CTL_RES_CLR_WKP_STS_;
+		ret = lan78xx_write_reg(dev, PMT_CTL, buf);
+		if (ret < 0)
+			goto out;
 
-			buf |= PMT_CTL_PHY_WAKE_EN_;
-			buf |= PMT_CTL_WOL_EN_;
-			buf &= ~PMT_CTL_SUS_MODE_MASK_;
-			buf |= PMT_CTL_SUS_MODE_3_;
+		ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
+		if (ret < 0)
+			goto out;
 
-			ret = lan78xx_write_reg(dev, PMT_CTL, buf);
+		buf |= PMT_CTL_WUPS_MASK_;
 
-			ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
+		ret = lan78xx_write_reg(dev, PMT_CTL, buf);
+		if (ret < 0)
+			goto out;
+	}
+
+	ret = 0;
+out:
+	mutex_unlock(&dev->dev_mutex);
+
+	return ret;
+}
 
-			buf |= PMT_CTL_WUPS_MASK_;
+static bool lan78xx_submit_deferred_urbs(struct lan78xx_net *dev)
+{
+	bool pipe_halted = false;
+	struct urb *urb;
+
+	while ((urb = usb_get_from_anchor(&dev->deferred))) {
+		struct sk_buff *skb = urb->context;
+		int ret;
+
+		if (!netif_device_present(dev->net) ||
+		    !netif_carrier_ok(dev->net) ||
+		    pipe_halted) {
+			usb_free_urb(urb);
+			dev_kfree_skb(skb);
+			continue;
+		}
 
-			ret = lan78xx_write_reg(dev, PMT_CTL, buf);
+		ret = usb_submit_urb(urb, GFP_ATOMIC);
 
-			ret = lan78xx_read_reg(dev, MAC_RX, &buf);
-			buf |= MAC_RX_RXEN_;
-			ret = lan78xx_write_reg(dev, MAC_RX, buf);
+		if (ret == 0) {
+			netif_trans_update(dev->net);
+			lan78xx_queue_skb(&dev->txq, skb, tx_start);
 		} else {
-			lan78xx_set_suspend(dev, pdata->wol);
+			usb_free_urb(urb);
+			dev_kfree_skb(skb);
+
+			if (ret == -EPIPE) {
+				netif_stop_queue(dev->net);
+				pipe_halted = true;
+			} else if (ret == -ENODEV) {
+				netif_device_detach(dev->net);
+			}
 		}
 	}
 
-	ret = 0;
-out:
-	return ret;
+	return pipe_halted;
 }
 
 static int lan78xx_resume(struct usb_interface *intf)
 {
 	struct lan78xx_net *dev = usb_get_intfdata(intf);
-	struct sk_buff *skb;
-	struct urb *res;
+	bool dev_open;
 	int ret;
-	u32 buf;
 
-	if (!timer_pending(&dev->stat_monitor)) {
-		dev->delta = 1;
-		mod_timer(&dev->stat_monitor,
-			  jiffies + STAT_UPDATE_TIMER);
-	}
+	mutex_lock(&dev->dev_mutex);
 
-	if (!--dev->suspend_count) {
-		/* resume interrupt URBs */
-		if (dev->urb_intr && test_bit(EVENT_DEV_OPEN, &dev->flags))
-				usb_submit_urb(dev->urb_intr, GFP_NOIO);
+	netif_dbg(dev, ifup, dev->net, "resuming device");
+
+	dev_open = test_bit(EVENT_DEV_OPEN, &dev->flags);
+
+	if (dev_open) {
+		bool pipe_halted = false;
+
+		ret = lan78xx_flush_tx_fifo(dev);
+		if (ret < 0)
+			goto out;
+
+		if (dev->urb_intr) {
+			int ret = usb_submit_urb(dev->urb_intr, GFP_KERNEL);
 
-		spin_lock_irq(&dev->txq.lock);
-		while ((res = usb_get_from_anchor(&dev->deferred))) {
-			skb = (struct sk_buff *)res->context;
-			ret = usb_submit_urb(res, GFP_ATOMIC);
 			if (ret < 0) {
-				dev_kfree_skb_any(skb);
-				usb_free_urb(res);
-				usb_autopm_put_interface_async(dev->intf);
-			} else {
-				netif_trans_update(dev->net);
-				lan78xx_queue_skb(&dev->txq, skb, tx_start);
+				if (ret == -ENODEV)
+					netif_device_detach(dev->net);
+
+			netdev_warn(dev->net, "Failed to submit intr URB");
 			}
 		}
 
+		spin_lock_irq(&dev->txq.lock);
+
+		if (netif_device_present(dev->net)) {
+			pipe_halted = lan78xx_submit_deferred_urbs(dev);
+
+			if (pipe_halted)
+				lan78xx_defer_kevent(dev, EVENT_TX_HALT);
+		}
+
 		clear_bit(EVENT_DEV_ASLEEP, &dev->flags);
+
 		spin_unlock_irq(&dev->txq.lock);
 
-		if (test_bit(EVENT_DEV_OPEN, &dev->flags)) {
-			if (!(skb_queue_len(&dev->txq) >= dev->tx_qlen))
-				netif_start_queue(dev->net);
-			tasklet_schedule(&dev->bh);
+		if (!pipe_halted &&
+		    netif_device_present(dev->net) &&
+		    (skb_queue_len(&dev->txq) < dev->tx_qlen))
+			netif_start_queue(dev->net);
+
+		ret = lan78xx_start_tx_path(dev);
+		if (ret < 0)
+			goto out;
+
+		tasklet_schedule(&dev->bh);
+
+		if (!timer_pending(&dev->stat_monitor)) {
+			dev->delta = 1;
+			mod_timer(&dev->stat_monitor,
+				  jiffies + STAT_UPDATE_TIMER);
 		}
+
+	} else {
+		clear_bit(EVENT_DEV_ASLEEP, &dev->flags);
 	}
 
 	ret = lan78xx_write_reg(dev, WUCSR2, 0);
+	if (ret < 0)
+		goto out;
 	ret = lan78xx_write_reg(dev, WUCSR, 0);
+	if (ret < 0)
+		goto out;
 	ret = lan78xx_write_reg(dev, WK_SRC, 0xFFF1FF1FUL);
+	if (ret < 0)
+		goto out;
 
 	ret = lan78xx_write_reg(dev, WUCSR2, WUCSR2_NS_RCD_ |
 					     WUCSR2_ARP_RCD_ |
 					     WUCSR2_IPV6_TCPSYN_RCD_ |
 					     WUCSR2_IPV4_TCPSYN_RCD_);
+	if (ret < 0)
+		goto out;
 
 	ret = lan78xx_write_reg(dev, WUCSR, WUCSR_EEE_TX_WAKE_ |
 					    WUCSR_EEE_RX_WAKE_ |
@@ -4141,23 +4632,32 @@ static int lan78xx_resume(struct usb_interface *intf)
 					    WUCSR_WUFR_ |
 					    WUCSR_MPR_ |
 					    WUCSR_BCST_FR_);
+	if (ret < 0)
+		goto out;
 
-	ret = lan78xx_read_reg(dev, MAC_TX, &buf);
-	buf |= MAC_TX_TXEN_;
-	ret = lan78xx_write_reg(dev, MAC_TX, buf);
+	ret = 0;
+out:
+	mutex_unlock(&dev->dev_mutex);
 
-	return 0;
+	return ret;
 }
 
 static int lan78xx_reset_resume(struct usb_interface *intf)
 {
 	struct lan78xx_net *dev = usb_get_intfdata(intf);
+	int ret;
 
-	lan78xx_reset(dev);
+	netif_dbg(dev, ifup, dev->net, "(reset) resuming device");
+
+	ret = lan78xx_reset(dev);
+	if (ret < 0)
+		return ret;
 
 	phy_start(dev->net->phydev);
 
-	return lan78xx_resume(intf);
+	ret = lan78xx_resume(intf);
+
+	return ret;
 }
 
 static const struct usb_device_id products[] = {
diff --git a/drivers/net/vsockmon.c b/drivers/net/vsockmon.c
index c28bdce14fd5e..7bad5c95551fd 100644
--- a/drivers/net/vsockmon.c
+++ b/drivers/net/vsockmon.c
@@ -11,12 +11,6 @@
 #define DEFAULT_MTU (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + \
 		     sizeof(struct af_vsockmon_hdr))
 
-struct pcpu_lstats {
-	u64 rx_packets;
-	u64 rx_bytes;
-	struct u64_stats_sync syncp;
-};
-
 static int vsockmon_dev_init(struct net_device *dev)
 {
 	dev->lstats = netdev_alloc_pcpu_stats(struct pcpu_lstats);
@@ -56,8 +50,8 @@ static netdev_tx_t vsockmon_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct pcpu_lstats *stats = this_cpu_ptr(dev->lstats);
 
 	u64_stats_update_begin(&stats->syncp);
-	stats->rx_bytes += len;
-	stats->rx_packets++;
+	stats->bytes += len;
+	stats->packets++;
 	u64_stats_update_end(&stats->syncp);
 
 	dev_kfree_skb(skb);
@@ -80,8 +74,8 @@ vsockmon_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 
 		do {
 			start = u64_stats_fetch_begin_irq(&vstats->syncp);
-			tbytes = vstats->rx_bytes;
-			tpackets = vstats->rx_packets;
+			tbytes = vstats->bytes;
+			tpackets = vstats->packets;
 		} while (u64_stats_fetch_retry_irq(&vstats->syncp, start));
 
 		packets += tpackets;
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index b26739d0e991b..7bb816a6d1e19 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -891,8 +891,10 @@ int btrfs_ref_tree_mod(struct btrfs_root *root, u64 bytenr, u64 num_bytes,
 out_unlock:
 	spin_unlock(&root->fs_info->ref_verify_lock);
 out:
-	if (ret)
+	if (ret) {
+		btrfs_free_ref_cache(fs_info);
 		btrfs_clear_opt(fs_info->mount_opt, REF_VERIFY);
+	}
 	return ret;
 }
 
@@ -1021,8 +1023,8 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
 		}
 	}
 	if (ret) {
-		btrfs_clear_opt(fs_info->mount_opt, REF_VERIFY);
 		btrfs_free_ref_cache(fs_info);
+		btrfs_clear_opt(fs_info->mount_opt, REF_VERIFY);
 	}
 	btrfs_free_path(path);
 	return ret;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ac87fcc4d44b4..89155d171b567 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2383,6 +2383,12 @@ struct pcpu_sw_netstats {
 	struct u64_stats_sync   syncp;
 };
 
+struct pcpu_lstats {
+	u64 packets;
+	u64 bytes;
+	struct u64_stats_sync syncp;
+};
+
 #define __netdev_alloc_pcpu_stats(type, gfp)				\
 ({									\
 	typeof(type) __percpu *pcpu_stats = alloc_percpu_gfp(type, gfp);\
diff --git a/include/uapi/linux/resource.h b/include/uapi/linux/resource.h
index cc00fd0796317..74ef57b38f9f5 100644
--- a/include/uapi/linux/resource.h
+++ b/include/uapi/linux/resource.h
@@ -22,8 +22,8 @@
 #define	RUSAGE_THREAD	1		/* only the calling thread */
 
 struct	rusage {
-	struct timeval ru_utime;	/* user time used */
-	struct timeval ru_stime;	/* system time used */
+	struct __kernel_old_timeval ru_utime;	/* user time used */
+	struct __kernel_old_timeval ru_stime;	/* system time used */
 	__kernel_long_t	ru_maxrss;	/* maximum resident set size */
 	__kernel_long_t	ru_ixrss;	/* integral shared memory size */
 	__kernel_long_t	ru_idrss;	/* integral unshared data size */
diff --git a/kernel/sys.c b/kernel/sys.c
index 3548467f6459b..62930aac0bad7 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1717,73 +1717,86 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	struct task_struct *t;
 	unsigned long flags;
 	u64 tgutime, tgstime, utime, stime;
-	unsigned long maxrss = 0;
+	unsigned long maxrss;
+	struct mm_struct *mm;
+	struct signal_struct *sig = p->signal;
+	unsigned int seq = 0;
 
-	memset((char *)r, 0, sizeof (*r));
+retry:
+	memset(r, 0, sizeof(*r));
 	utime = stime = 0;
+	maxrss = 0;
 
 	if (who == RUSAGE_THREAD) {
 		task_cputime_adjusted(current, &utime, &stime);
 		accumulate_thread_rusage(p, r);
-		maxrss = p->signal->maxrss;
-		goto out;
+		maxrss = sig->maxrss;
+		goto out_thread;
 	}
 
-	if (!lock_task_sighand(p, &flags))
-		return;
+	flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
 
 	switch (who) {
 	case RUSAGE_BOTH:
 	case RUSAGE_CHILDREN:
-		utime = p->signal->cutime;
-		stime = p->signal->cstime;
-		r->ru_nvcsw = p->signal->cnvcsw;
-		r->ru_nivcsw = p->signal->cnivcsw;
-		r->ru_minflt = p->signal->cmin_flt;
-		r->ru_majflt = p->signal->cmaj_flt;
-		r->ru_inblock = p->signal->cinblock;
-		r->ru_oublock = p->signal->coublock;
-		maxrss = p->signal->cmaxrss;
+		utime = sig->cutime;
+		stime = sig->cstime;
+		r->ru_nvcsw = sig->cnvcsw;
+		r->ru_nivcsw = sig->cnivcsw;
+		r->ru_minflt = sig->cmin_flt;
+		r->ru_majflt = sig->cmaj_flt;
+		r->ru_inblock = sig->cinblock;
+		r->ru_oublock = sig->coublock;
+		maxrss = sig->cmaxrss;
 
 		if (who == RUSAGE_CHILDREN)
 			break;
 
 	case RUSAGE_SELF:
-		thread_group_cputime_adjusted(p, &tgutime, &tgstime);
-		utime += tgutime;
-		stime += tgstime;
-		r->ru_nvcsw += p->signal->nvcsw;
-		r->ru_nivcsw += p->signal->nivcsw;
-		r->ru_minflt += p->signal->min_flt;
-		r->ru_majflt += p->signal->maj_flt;
-		r->ru_inblock += p->signal->inblock;
-		r->ru_oublock += p->signal->oublock;
-		if (maxrss < p->signal->maxrss)
-			maxrss = p->signal->maxrss;
-		t = p;
-		do {
+		r->ru_nvcsw += sig->nvcsw;
+		r->ru_nivcsw += sig->nivcsw;
+		r->ru_minflt += sig->min_flt;
+		r->ru_majflt += sig->maj_flt;
+		r->ru_inblock += sig->inblock;
+		r->ru_oublock += sig->oublock;
+		if (maxrss < sig->maxrss)
+			maxrss = sig->maxrss;
+
+		rcu_read_lock();
+		__for_each_thread(sig, t)
 			accumulate_thread_rusage(t, r);
-		} while_each_thread(p, t);
+		rcu_read_unlock();
+
 		break;
 
 	default:
 		BUG();
 	}
-	unlock_task_sighand(p, &flags);
 
-out:
-	r->ru_utime = ns_to_timeval(utime);
-	r->ru_stime = ns_to_timeval(stime);
+	if (need_seqretry(&sig->stats_lock, seq)) {
+		seq = 1;
+		goto retry;
+	}
+	done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
 
-	if (who != RUSAGE_CHILDREN) {
-		struct mm_struct *mm = get_task_mm(p);
+	if (who == RUSAGE_CHILDREN)
+		goto out_children;
 
-		if (mm) {
-			setmax_mm_hiwater_rss(&maxrss, mm);
-			mmput(mm);
-		}
+	thread_group_cputime_adjusted(p, &tgutime, &tgstime);
+	utime += tgutime;
+	stime += tgstime;
+
+out_thread:
+	mm = get_task_mm(p);
+	if (mm) {
+		setmax_mm_hiwater_rss(&maxrss, mm);
+		mmput(mm);
 	}
+
+out_children:
 	r->ru_maxrss = maxrss * (PAGE_SIZE / 1024); /* convert pages to KBs */
+	r->ru_utime = ns_to_kernel_old_timeval(utime);
+	r->ru_stime = ns_to_kernel_old_timeval(stime);
 }
 
 SYSCALL_DEFINE2(getrusage, int, who, struct rusage __user *, ru)
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 9dbc9c0cbc5a3..b4d9acb1bc101 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4516,25 +4516,19 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 	err_nh = NULL;
 	list_for_each_entry(nh, &rt6_nh_list, next) {
 		err = __ip6_ins_rt(nh->fib6_info, info, extack);
-		fib6_info_release(nh->fib6_info);
-
-		if (!err) {
-			/* save reference to last route successfully inserted */
-			rt_last = nh->fib6_info;
-
-			/* save reference to first route for notification */
-			if (!rt_notif)
-				rt_notif = nh->fib6_info;
-		}
 
-		/* nh->fib6_info is used or freed at this point, reset to NULL*/
-		nh->fib6_info = NULL;
 		if (err) {
 			if (replace && nhn)
 				ip6_print_replace_route_err(&rt6_nh_list);
 			err_nh = nh;
 			goto add_errout;
 		}
+		/* save reference to last route successfully inserted */
+		rt_last = nh->fib6_info;
+
+		/* save reference to first route for notification */
+		if (!rt_notif)
+			rt_notif = nh->fib6_info;
 
 		/* Because each route is added like a single route we remove
 		 * these flags after the first nexthop: if there is a collision,
@@ -4572,8 +4566,7 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 
 cleanup:
 	list_for_each_entry_safe(nh, nh_safe, &rt6_nh_list, next) {
-		if (nh->fib6_info)
-			fib6_info_release(nh->fib6_info);
+		fib6_info_release(nh->fib6_info);
 		list_del(&nh->next);
 		kfree(nh);
 	}
diff --git a/net/netfilter/nf_conntrack_h323_asn1.c b/net/netfilter/nf_conntrack_h323_asn1.c
index 4c2ef42e189cb..82dae553a5fc7 100644
--- a/net/netfilter/nf_conntrack_h323_asn1.c
+++ b/net/netfilter/nf_conntrack_h323_asn1.c
@@ -536,6 +536,8 @@ static int decode_seq(struct bitstr *bs, const struct field_t *f,
 	/* Get fields bitmap */
 	if (nf_h323_error_boundary(bs, 0, f->sz))
 		return H323_ERROR_BOUND;
+	if (f->sz > 32)
+		return H323_ERROR_RANGE;
 	bmp = get_bitmap(bs, f->sz);
 	if (base)
 		*(unsigned int *)base = bmp;
@@ -592,6 +594,8 @@ static int decode_seq(struct bitstr *bs, const struct field_t *f,
 	bmp2_len = get_bits(bs, 7) + 1;
 	if (nf_h323_error_boundary(bs, 0, bmp2_len))
 		return H323_ERROR_BOUND;
+	if (bmp2_len > 32)
+		return H323_ERROR_RANGE;
 	bmp2 = get_bitmap(bs, bmp2_len);
 	bmp |= bmp2 >> f->sz;
 	if (base)
diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index 146550ce0ac6f..9e48ce56f085c 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -456,16 +456,16 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 	nr_init_timers(sk);
 
 	nr->t1     =
-		msecs_to_jiffies(sysctl_netrom_transport_timeout);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_timeout));
 	nr->t2     =
-		msecs_to_jiffies(sysctl_netrom_transport_acknowledge_delay);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_acknowledge_delay));
 	nr->n2     =
-		msecs_to_jiffies(sysctl_netrom_transport_maximum_tries);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_maximum_tries));
 	nr->t4     =
-		msecs_to_jiffies(sysctl_netrom_transport_busy_delay);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_busy_delay));
 	nr->idle   =
-		msecs_to_jiffies(sysctl_netrom_transport_no_activity_timeout);
-	nr->window = sysctl_netrom_transport_requested_window_size;
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_no_activity_timeout));
+	nr->window = READ_ONCE(sysctl_netrom_transport_requested_window_size);
 
 	nr->bpqext = 1;
 	nr->state  = NR_STATE_0;
@@ -957,7 +957,7 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
 		 * G8PZT's Xrouter which is sending packets with command type 7
 		 * as an extension of the protocol.
 		 */
-		if (sysctl_netrom_reset_circuit &&
+		if (READ_ONCE(sysctl_netrom_reset_circuit) &&
 		    (frametype != NR_RESET || flags != 0))
 			nr_transmit_reset(skb, 1);
 
diff --git a/net/netrom/nr_dev.c b/net/netrom/nr_dev.c
index 988f542481a83..fa845edad7bf6 100644
--- a/net/netrom/nr_dev.c
+++ b/net/netrom/nr_dev.c
@@ -84,7 +84,7 @@ static int nr_header(struct sk_buff *skb, struct net_device *dev,
 	buff[6] |= AX25_SSSID_SPARE;
 	buff    += AX25_ADDR_LEN;
 
-	*buff++ = sysctl_netrom_network_ttl_initialiser;
+	*buff++ = READ_ONCE(sysctl_netrom_network_ttl_initialiser);
 
 	*buff++ = NR_PROTO_IP;
 	*buff++ = NR_PROTO_IP;
diff --git a/net/netrom/nr_in.c b/net/netrom/nr_in.c
index fbfdae452ff9a..01ccd00d1c005 100644
--- a/net/netrom/nr_in.c
+++ b/net/netrom/nr_in.c
@@ -100,7 +100,7 @@ static int nr_state1_machine(struct sock *sk, struct sk_buff *skb,
 		break;
 
 	case NR_RESET:
-		if (sysctl_netrom_reset_circuit)
+		if (READ_ONCE(sysctl_netrom_reset_circuit))
 			nr_disconnect(sk, ECONNRESET);
 		break;
 
@@ -131,7 +131,7 @@ static int nr_state2_machine(struct sock *sk, struct sk_buff *skb,
 		break;
 
 	case NR_RESET:
-		if (sysctl_netrom_reset_circuit)
+		if (READ_ONCE(sysctl_netrom_reset_circuit))
 			nr_disconnect(sk, ECONNRESET);
 		break;
 
@@ -266,7 +266,7 @@ static int nr_state3_machine(struct sock *sk, struct sk_buff *skb, int frametype
 		break;
 
 	case NR_RESET:
-		if (sysctl_netrom_reset_circuit)
+		if (READ_ONCE(sysctl_netrom_reset_circuit))
 			nr_disconnect(sk, ECONNRESET);
 		break;
 
diff --git a/net/netrom/nr_out.c b/net/netrom/nr_out.c
index 00fbf1419ec6b..213bddab6e74f 100644
--- a/net/netrom/nr_out.c
+++ b/net/netrom/nr_out.c
@@ -207,7 +207,7 @@ void nr_transmit_buffer(struct sock *sk, struct sk_buff *skb)
 	dptr[6] |= AX25_SSSID_SPARE;
 	dptr += AX25_ADDR_LEN;
 
-	*dptr++ = sysctl_netrom_network_ttl_initialiser;
+	*dptr++ = READ_ONCE(sysctl_netrom_network_ttl_initialiser);
 
 	if (!nr_route_frame(skb, NULL)) {
 		kfree_skb(skb);
diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index 53ced34a1fdd2..744c19a7a469c 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -156,7 +156,7 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 		nr_neigh->digipeat = NULL;
 		nr_neigh->ax25     = NULL;
 		nr_neigh->dev      = dev;
-		nr_neigh->quality  = sysctl_netrom_default_path_quality;
+		nr_neigh->quality  = READ_ONCE(sysctl_netrom_default_path_quality);
 		nr_neigh->locked   = 0;
 		nr_neigh->count    = 0;
 		nr_neigh->number   = nr_neigh_no++;
@@ -728,7 +728,7 @@ void nr_link_failed(ax25_cb *ax25, int reason)
 	nr_neigh->ax25 = NULL;
 	ax25_cb_put(ax25);
 
-	if (++nr_neigh->failed < sysctl_netrom_link_fails_count) {
+	if (++nr_neigh->failed < READ_ONCE(sysctl_netrom_link_fails_count)) {
 		nr_neigh_put(nr_neigh);
 		return;
 	}
@@ -766,7 +766,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 	if (ax25 != NULL) {
 		ret = nr_add_node(nr_src, "", &ax25->dest_addr, ax25->digipeat,
 				  ax25->ax25_dev->dev, 0,
-				  sysctl_netrom_obsolescence_count_initialiser);
+				  READ_ONCE(sysctl_netrom_obsolescence_count_initialiser));
 		if (ret)
 			return ret;
 	}
@@ -780,7 +780,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 		return ret;
 	}
 
-	if (!sysctl_netrom_routing_control && ax25 != NULL)
+	if (!READ_ONCE(sysctl_netrom_routing_control) && ax25 != NULL)
 		return 0;
 
 	/* Its Time-To-Live has expired */
diff --git a/net/netrom/nr_subr.c b/net/netrom/nr_subr.c
index a7d3a265befb9..b5cee72b8c985 100644
--- a/net/netrom/nr_subr.c
+++ b/net/netrom/nr_subr.c
@@ -185,7 +185,8 @@ void nr_write_internal(struct sock *sk, int frametype)
 		*dptr++ = nr->my_id;
 		*dptr++ = frametype;
 		*dptr++ = nr->window;
-		if (nr->bpqext) *dptr++ = sysctl_netrom_network_ttl_initialiser;
+		if (nr->bpqext)
+			*dptr++ = READ_ONCE(sysctl_netrom_network_ttl_initialiser);
 		break;
 
 	case NR_DISCREQ:
@@ -239,7 +240,7 @@ void __nr_transmit_reply(struct sk_buff *skb, int mine, unsigned char cmdflags)
 	dptr[6] |= AX25_SSSID_SPARE;
 	dptr += AX25_ADDR_LEN;
 
-	*dptr++ = sysctl_netrom_network_ttl_initialiser;
+	*dptr++ = READ_ONCE(sysctl_netrom_network_ttl_initialiser);
 
 	if (mine) {
 		*dptr++ = 0;
diff --git a/net/rds/rdma.c b/net/rds/rdma.c
index 9882cebfcad60..2632f3f3aa284 100644
--- a/net/rds/rdma.c
+++ b/net/rds/rdma.c
@@ -278,6 +278,9 @@ static int __rds_rdma_map(struct rds_sock *rs, struct rds_get_mr_args *args,
 			put_page(sg_page(&sg[i]));
 		kfree(sg);
 		ret = PTR_ERR(trans_private);
+		/* Trigger connection so that its ready for the next retry */
+		if (ret == -ENODEV)
+			rds_conn_connect_if_down(cp->cp_conn);
 		goto out;
 	}
 
diff --git a/net/rds/send.c b/net/rds/send.c
index 26e2c2305f7aa..c856e6c963af9 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1300,12 +1300,8 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 
 	/* Parse any control messages the user may have included. */
 	ret = rds_cmsg_send(rs, rm, msg, &allocated_mr, &vct);
-	if (ret) {
-		/* Trigger connection so that its ready for the next retry */
-		if (ret ==  -EAGAIN)
-			rds_conn_connect_if_down(conn);
+	if (ret)
 		goto out;
-	}
 
 	if (rm->rdma.op_active && !conn->c_trans->xmit_rdma) {
 		printk_ratelimited(KERN_NOTICE "rdma_op %p conn xmit_rdma %p\n",
diff --git a/tools/testing/selftests/vm/map_hugetlb.c b/tools/testing/selftests/vm/map_hugetlb.c
index 9b777fa95f090..c65c55b7a789f 100644
--- a/tools/testing/selftests/vm/map_hugetlb.c
+++ b/tools/testing/selftests/vm/map_hugetlb.c
@@ -15,6 +15,7 @@
 #include <unistd.h>
 #include <sys/mman.h>
 #include <fcntl.h>
+#include "vm_util.h"
 
 #define LENGTH (256UL*1024*1024)
 #define PROTECTION (PROT_READ | PROT_WRITE)
@@ -23,6 +24,14 @@
 #define MAP_HUGETLB 0x40000 /* arch specific */
 #endif
 
+#ifndef MAP_HUGE_SHIFT
+#define MAP_HUGE_SHIFT 26
+#endif
+
+#ifndef MAP_HUGE_MASK
+#define MAP_HUGE_MASK 0x3f
+#endif
+
 /* Only ia64 requires this */
 #ifdef __ia64__
 #define ADDR (void *)(0x8000000000000000UL)
@@ -37,20 +46,20 @@ static void check_bytes(char *addr)
 	printf("First hex is %x\n", *((unsigned int *)addr));
 }
 
-static void write_bytes(char *addr)
+static void write_bytes(char *addr, size_t length)
 {
 	unsigned long i;
 
-	for (i = 0; i < LENGTH; i++)
+	for (i = 0; i < length; i++)
 		*(addr + i) = (char)i;
 }
 
-static int read_bytes(char *addr)
+static int read_bytes(char *addr, size_t length)
 {
 	unsigned long i;
 
 	check_bytes(addr);
-	for (i = 0; i < LENGTH; i++)
+	for (i = 0; i < length; i++)
 		if (*(addr + i) != (char)i) {
 			printf("Mismatch at %lu\n", i);
 			return 1;
@@ -58,12 +67,35 @@ static int read_bytes(char *addr)
 	return 0;
 }
 
-int main(void)
+int main(int argc, char **argv)
 {
 	void *addr;
 	int ret;
+	size_t hugepage_size;
+	size_t length = LENGTH;
+	int flags = FLAGS;
+	int shift = 0;
+
+	hugepage_size = default_huge_page_size();
+	/* munmap with fail if the length is not page aligned */
+	if (hugepage_size > length)
+		length = hugepage_size;
+
+	if (argc > 1)
+		length = atol(argv[1]) << 20;
+	if (argc > 2) {
+		shift = atoi(argv[2]);
+		if (shift)
+			flags |= (shift & MAP_HUGE_MASK) << MAP_HUGE_SHIFT;
+	}
+
+	if (shift)
+		printf("%u kB hugepages\n", 1 << (shift - 10));
+	else
+		printf("Default size hugepages\n");
+	printf("Mapping %lu Mbytes\n", (unsigned long)length >> 20);
 
-	addr = mmap(ADDR, LENGTH, PROTECTION, FLAGS, -1, 0);
+	addr = mmap(ADDR, length, PROTECTION, flags, -1, 0);
 	if (addr == MAP_FAILED) {
 		perror("mmap");
 		exit(1);
@@ -71,11 +103,11 @@ int main(void)
 
 	printf("Returned address is %p\n", addr);
 	check_bytes(addr);
-	write_bytes(addr);
-	ret = read_bytes(addr);
+	write_bytes(addr, length);
+	ret = read_bytes(addr, length);
 
 	/* munmap() length of MAP_HUGETLB memory must be hugepage aligned */
-	if (munmap(addr, LENGTH)) {
+	if (munmap(addr, length)) {
 		perror("munmap");
 		exit(1);
 	}

