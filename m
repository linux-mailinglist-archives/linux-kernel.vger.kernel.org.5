Return-Path: <linux-kernel+bounces-94112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D8C873A28
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0787A1F26A91
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF2A135A79;
	Wed,  6 Mar 2024 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DNfBhfan"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0643134CE3;
	Wed,  6 Mar 2024 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737533; cv=none; b=WFvlqFKkWImzQ/aQz/zyz+3ayt0lAqLVcq1T4NKFQcTz6TBUTZMKu2XuD3t8qTCFQ+lZTy4dowjCJVHY0Cyu9bhO6BurIslrxBywPRpcQDO7I7V0ZYhmJHOHoGOa09NJJ+C3Dndrm8+zsvez5ashIc+qFM2SAOSRIWvLYW6UgVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737533; c=relaxed/simple;
	bh=a8hjemTJ7yefZ4w8iYxSntJrZAK2n7PJ+n/P3RVgn7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoM2ipr0aRVwRV/uhNSufOdWvSFDtQX05Iz3Gj17gpVHa20afMe6+2iMdtfRmwil9YM/g2nIMYDY+dT3FL8jcZUhPKG4NOA5dbWiVqUxuNeIoT6ajiMx0VWRMHfm/qtXLVFstNqhF3YMioi/t+mfkxl4QPqvEIoRXG7+7ZNQtS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DNfBhfan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240CFC43390;
	Wed,  6 Mar 2024 15:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709737532;
	bh=a8hjemTJ7yefZ4w8iYxSntJrZAK2n7PJ+n/P3RVgn7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DNfBhfan8YUm6ZJgb63Ns6dlQ0oFlsBuFh5CfmHNTmKtFZaDAmax7yvobGemVed0u
	 9XTAOdc1fsYgO8AmS+jng/qi9mTooITbQasD0mvc9I+bb61tDKY3hviF4nVMdluh8+
	 yvrEB6kAU+25ITTrmlefWeDTtEYUx3852n0YKOpY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.309
Date: Wed,  6 Mar 2024 15:05:24 +0000
Message-ID: <2024030624-tumble-tamale-83b8@gregkh>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024030624-arise-voltage-4cf5@gregkh>
References: <2024030624-arise-voltage-4cf5@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 63b99860a450..9648c95ee320 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 308
+SUBLEVEL = 309
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
index 94aae1e67c99..43fefab75524 100644
--- a/drivers/firmware/efi/capsule-loader.c
+++ b/drivers/firmware/efi/capsule-loader.c
@@ -293,7 +293,7 @@ static int efi_capsule_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 	}
 
-	cap_info->phys = kzalloc(sizeof(void *), GFP_KERNEL);
+	cap_info->phys = kzalloc(sizeof(phys_addr_t), GFP_KERNEL);
 	if (!cap_info->phys) {
 		kfree(cap_info->pages);
 		kfree(cap_info);
diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
index fb7b620763a2..a47897f2a83d 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -132,8 +132,6 @@ static int gen_74x164_probe(struct spi_device *spi)
 	if (IS_ERR(chip->gpiod_oe))
 		return PTR_ERR(chip->gpiod_oe);
 
-	gpiod_set_value_cansleep(chip->gpiod_oe, 1);
-
 	spi_set_drvdata(spi, chip);
 
 	chip->gpio_chip.label = spi->modalias;
@@ -158,6 +156,8 @@ static int gen_74x164_probe(struct spi_device *spi)
 		goto exit_destroy;
 	}
 
+	gpiod_set_value_cansleep(chip->gpiod_oe, 1);
+
 	ret = gpiochip_add_data(&chip->gpio_chip, chip);
 	if (!ret)
 		return 0;
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 745a4b07faff..2f1d615eb83a 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -994,10 +994,12 @@ static int mmc_select_bus_width(struct mmc_card *card)
 	static unsigned ext_csd_bits[] = {
 		EXT_CSD_BUS_WIDTH_8,
 		EXT_CSD_BUS_WIDTH_4,
+		EXT_CSD_BUS_WIDTH_1,
 	};
 	static unsigned bus_widths[] = {
 		MMC_BUS_WIDTH_8,
 		MMC_BUS_WIDTH_4,
+		MMC_BUS_WIDTH_1,
 	};
 	struct mmc_host *host = card->host;
 	unsigned idx, bus_width = 0;
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index a8664d181aa0..3f4e20a9ce9a 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1381,26 +1381,26 @@ static int __init gtp_init(void)
 
 	get_random_bytes(&gtp_h_initval, sizeof(gtp_h_initval));
 
-	err = rtnl_link_register(&gtp_link_ops);
+	err = register_pernet_subsys(&gtp_net_ops);
 	if (err < 0)
 		goto error_out;
 
-	err = register_pernet_subsys(&gtp_net_ops);
+	err = rtnl_link_register(&gtp_link_ops);
 	if (err < 0)
-		goto unreg_rtnl_link;
+		goto unreg_pernet_subsys;
 
 	err = genl_register_family(&gtp_genl_family);
 	if (err < 0)
-		goto unreg_pernet_subsys;
+		goto unreg_rtnl_link;
 
 	pr_info("GTP module loaded (pdp ctx size %zd bytes)\n",
 		sizeof(struct pdp_ctx));
 	return 0;
 
-unreg_pernet_subsys:
-	unregister_pernet_subsys(&gtp_net_ops);
 unreg_rtnl_link:
 	rtnl_link_unregister(&gtp_link_ops);
+unreg_pernet_subsys:
+	unregister_pernet_subsys(&gtp_net_ops);
 error_out:
 	pr_err("error loading GTP module loaded\n");
 	return err;
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 055664a26f7a..625525275539 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -729,6 +729,7 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
 				   tun->tfiles[tun->numqueues - 1]);
 		ntfile = rtnl_dereference(tun->tfiles[index]);
 		ntfile->queue_index = index;
+		ntfile->xdp_rxq.queue_index = index;
 		rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
 				   NULL);
 
diff --git a/drivers/net/usb/dm9601.c b/drivers/net/usb/dm9601.c
index 5aad26600b03..9b7db5fd9e08 100644
--- a/drivers/net/usb/dm9601.c
+++ b/drivers/net/usb/dm9601.c
@@ -231,7 +231,7 @@ static int dm9601_mdio_read(struct net_device *netdev, int phy_id, int loc)
 	err = dm_read_shared_word(dev, 1, loc, &res);
 	if (err < 0) {
 		netdev_err(dev->net, "MDIO read error: %d\n", err);
-		return err;
+		return 0;
 	}
 
 	netdev_dbg(dev->net,
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index a44968d5cac4..c0fff40a98bb 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2581,7 +2581,8 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 	if (dev->chipid == ID_REV_CHIP_ID_7801_)
 		buf &= ~MAC_CR_GMII_EN_;
 
-	if (dev->chipid == ID_REV_CHIP_ID_7800_) {
+	if (dev->chipid == ID_REV_CHIP_ID_7800_ ||
+	    dev->chipid == ID_REV_CHIP_ID_7850_) {
 		ret = lan78xx_read_raw_eeprom(dev, 0, 1, &sig);
 		if (!ret && sig != EEPROM_INDICATOR) {
 			/* Implies there is no external eeprom. Set mac speed */
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 0fbc221ee50e..f5870b349309 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -217,7 +217,9 @@ static int bq27xxx_battery_i2c_remove(struct i2c_client *client)
 {
 	struct bq27xxx_device_info *di = i2c_get_clientdata(client);
 
-	free_irq(client->irq, di);
+	if (client->irq)
+		free_irq(client->irq, di);
+
 	bq27xxx_battery_teardown(di);
 
 	mutex_lock(&battery_mutex);
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 4d1d2657d70c..7cf4d5aaa4e8 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -535,6 +535,23 @@ int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+static int btrfs_check_replace_dev_names(struct btrfs_ioctl_dev_replace_args *args)
+{
+	if (args->start.srcdevid == 0) {
+		if (memchr(args->start.srcdev_name, 0,
+			   sizeof(args->start.srcdev_name)) == NULL)
+			return -ENAMETOOLONG;
+	} else {
+		args->start.srcdev_name[0] = 0;
+	}
+
+	if (memchr(args->start.tgtdev_name, 0,
+		   sizeof(args->start.tgtdev_name)) == NULL)
+	    return -ENAMETOOLONG;
+
+	return 0;
+}
+
 int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
 			    struct btrfs_ioctl_dev_replace_args *args)
 {
@@ -547,10 +564,9 @@ int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
 	default:
 		return -EINVAL;
 	}
-
-	if ((args->start.srcdevid == 0 && args->start.srcdev_name[0] == '\0') ||
-	    args->start.tgtdev_name[0] == '\0')
-		return -EINVAL;
+	ret = btrfs_check_replace_dev_names(args);
+	if (ret < 0)
+		return ret;
 
 	ret = btrfs_dev_replace_start(fs_info, args->start.tgtdev_name,
 					args->start.srcdevid,
diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
index 4a717d400807..9b34d46bf8ee 100644
--- a/fs/cachefiles/bind.c
+++ b/fs/cachefiles/bind.c
@@ -249,6 +249,8 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 	kmem_cache_free(cachefiles_object_jar, fsdef);
 error_root_object:
 	cachefiles_end_secure(cache, saved_cred);
+	put_cred(cache->cache_cred);
+	cache->cache_cred = NULL;
 	pr_err("Failed to register: %d\n", ret);
 	return ret;
 }
@@ -269,6 +271,7 @@ void cachefiles_daemon_unbind(struct cachefiles_cache *cache)
 
 	dput(cache->graveyard);
 	mntput(cache->mnt);
+	put_cred(cache->cache_cred);
 
 	kfree(cache->rootdirname);
 	kfree(cache->secctx);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4d89e38dceec..f455a503f5b0 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2217,6 +2217,7 @@ static void hci_error_reset(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev, error_reset);
 
+	hci_dev_hold(hdev);
 	BT_DBG("%s", hdev->name);
 
 	if (hdev->hw_error)
@@ -2224,10 +2225,10 @@ static void hci_error_reset(struct work_struct *work)
 	else
 		bt_dev_err(hdev, "hardware error 0x%2.2x", hdev->hw_error_code);
 
-	if (hci_dev_do_close(hdev))
-		return;
+	if (!hci_dev_do_close(hdev))
+		hci_dev_do_open(hdev);
 
-	hci_dev_do_open(hdev);
+	hci_dev_put(hdev);
 }
 
 void hci_uuids_clear(struct hci_dev *hdev)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9d01874e6b93..481185525926 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4337,9 +4337,12 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-	if (!conn || !hci_conn_ssp_enabled(conn))
+	if (!conn || !hci_dev_test_flag(hdev, HCI_SSP_ENABLED))
 		goto unlock;
 
+	/* Assume remote supports SSP since it has triggered this event */
+	set_bit(HCI_CONN_SSP_ENABLED, &conn->flags);
+
 	hci_conn_hold(conn);
 
 	if (!hci_dev_test_flag(hdev, HCI_MGMT))
@@ -5638,6 +5641,10 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
 		return send_conn_param_neg_reply(hdev, handle,
 						 HCI_ERROR_UNKNOWN_CONN_ID);
 
+	if (max > hcon->le_conn_max_interval)
+		return send_conn_param_neg_reply(hdev, handle,
+						 HCI_ERROR_INVALID_LL_PARAMS);
+
 	if (hci_check_conn_params(min, max, latency, timeout))
 		return send_conn_param_neg_reply(hdev, handle,
 						 HCI_ERROR_INVALID_LL_PARAMS);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9346fae5d664..b6c726976d1b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5313,7 +5313,13 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 
 	memset(&rsp, 0, sizeof(rsp));
 
-	err = hci_check_conn_params(min, max, latency, to_multiplier);
+	if (max > hcon->le_conn_max_interval) {
+		BT_DBG("requested connection interval exceeds current bounds.");
+		err = -EINVAL;
+	} else {
+		err = hci_check_conn_params(min, max, latency, to_multiplier);
+	}
+
 	if (err)
 		rsp.result = cpu_to_le16(L2CAP_CONN_PARAM_REJECTED);
 	else
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 72936d154c96..1fe9b4a04b22 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -160,7 +160,7 @@ static inline u32 netlink_group_mask(u32 group)
 static struct sk_buff *netlink_to_full_skb(const struct sk_buff *skb,
 					   gfp_t gfp_mask)
 {
-	unsigned int len = skb_end_offset(skb);
+	unsigned int len = skb->len;
 	struct sk_buff *new;
 
 	new = alloc_skb(len, gfp_mask);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f79700e5d801..df2989c35fd8 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3174,6 +3174,8 @@ static int nl80211_set_interface(struct sk_buff *skb, struct genl_info *info)
 
 		if (ntype != NL80211_IFTYPE_MESH_POINT)
 			return -EINVAL;
+		if (otype != NL80211_IFTYPE_MESH_POINT)
+			return -EINVAL;
 		if (netif_running(dev))
 			return -EBUSY;
 
diff --git a/sound/core/Makefile b/sound/core/Makefile
index d123587c0fd8..bc04acf4a45c 100644
--- a/sound/core/Makefile
+++ b/sound/core/Makefile
@@ -32,7 +32,6 @@ snd-pcm-dmaengine-objs := pcm_dmaengine.o
 snd-rawmidi-objs  := rawmidi.o
 snd-timer-objs    := timer.o
 snd-hrtimer-objs  := hrtimer.o
-snd-rtctimer-objs := rtctimer.o
 snd-hwdep-objs    := hwdep.o
 snd-seq-device-objs := seq_device.o
 

