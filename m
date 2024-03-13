Return-Path: <linux-kernel+bounces-102027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 528D187ADB9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8E79B21B27
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BF0664AD;
	Wed, 13 Mar 2024 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1pGaa55"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B115165BCD;
	Wed, 13 Mar 2024 16:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348406; cv=none; b=MXjKDjKoRxIEBzIEz1ZuT3Kn5uL3p2866uLvGB4uzlgl4g8lMbmHg35PFaFbnH8gaWOskv7ba0OIR6WVfW+msPleP/tljBkjThsGsMrkSiH58rr2LaRxfADt9VqF9f5rXlaYWzlGVmBZW4O4LQvsn8GFBWYFzoSospz16wc/164=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348406; c=relaxed/simple;
	bh=O9RtS8FWhtxlW5ztN8AWDTv8q6f95o+zJ5QEMBwRT6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VP/UCYx68zfgzGmdFzHe58bpLqoLBhvljBTBm9/gyexhad794fDO/UEjH2hsa3BxbvtHKq6phUvcgfiE9M44J0QNlzn0960UOO9dQsbuIWcjl1yv5ci2O3jIfdAWG75MLc+0gHNLcGhDpcnPCNRKSR1H6jUPb5rOVCho+ZRqQYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1pGaa55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6048C433F1;
	Wed, 13 Mar 2024 16:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348406;
	bh=O9RtS8FWhtxlW5ztN8AWDTv8q6f95o+zJ5QEMBwRT6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B1pGaa55E+QqEwwrOten6Z7DkP7IgVn38NMbkEUx/7pSt+1GtAONCSUaD94wcl41w
	 aW0/jexQIZ/IBNZTj5PcKwjYkHLQW3XKbkGGm00/uOLYRO8FFp72bX+puxO0V2QjM8
	 dhMCsCNL6uvHC0kHk3GEf64I2/oDdHhToeq3APiIlDXe8tjoy2qMtHOrYaWwYeJNiA
	 h9OL29QUw+ehSMpkp5IH2+CrmJbQn+2EU1DYF1Rbt0QwOqfCvNUEz+1PsPhsWS/KP/
	 RMNmabn4rvYyDzIRVc/z7bMiuBau0a/8tE41dDpSO2AHaavbToSozvHo8A5ZWi4hmr
	 uyWgKC+lvSJnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Efstathiades <john.efstathiades@pebblebay.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 03/73] lan78xx: Fix white space and style issues
Date: Wed, 13 Mar 2024 12:45:30 -0400
Message-ID: <20240313164640.616049-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: John Efstathiades <john.efstathiades@pebblebay.com>

[ Upstream commit 9ceec7d33adf9647293f24d2fd9a055b89c63864 ]

Fix white space and code style issues identified by checkpatch.

Signed-off-by: John Efstathiades <john.efstathiades@pebblebay.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 1eecc7ab82c4 ("net: lan78xx: fix runtime PM count underflow on link stop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/lan78xx.c | 80 ++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index c5a666bb86ee4..00424f3375528 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -385,7 +385,7 @@ struct lan78xx_net {
 	struct usb_anchor	deferred;
 
 	struct mutex		phy_mutex; /* for phy access */
-	unsigned		pipe_in, pipe_out, pipe_intr;
+	unsigned int		pipe_in, pipe_out, pipe_intr;
 
 	u32			hard_mtu;	/* count any extra framing */
 	size_t			rx_urb_size;	/* size for rx urbs */
@@ -395,7 +395,7 @@ struct lan78xx_net {
 	wait_queue_head_t	*wait;
 	unsigned char		suspend_count;
 
-	unsigned		maxpacket;
+	unsigned int		maxpacket;
 	struct timer_list	delay;
 	struct timer_list	stat_monitor;
 
@@ -504,7 +504,7 @@ static int lan78xx_read_stats(struct lan78xx_net *dev,
 	if (likely(ret >= 0)) {
 		src = (u32 *)stats;
 		dst = (u32 *)data;
-		for (i = 0; i < sizeof(*stats)/sizeof(u32); i++) {
+		for (i = 0; i < sizeof(*stats) / sizeof(u32); i++) {
 			le32_to_cpus(&src[i]);
 			dst[i] = src[i];
 		}
@@ -518,10 +518,11 @@ static int lan78xx_read_stats(struct lan78xx_net *dev,
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
@@ -847,9 +848,9 @@ static int lan78xx_read_raw_otp(struct lan78xx_net *dev, u32 offset,
 
 	for (i = 0; i < length; i++) {
 		lan78xx_write_reg(dev, OTP_ADDR1,
-					((offset + i) >> 8) & OTP_ADDR1_15_11);
+				  ((offset + i) >> 8) & OTP_ADDR1_15_11);
 		lan78xx_write_reg(dev, OTP_ADDR2,
-					((offset + i) & OTP_ADDR2_10_3));
+				  ((offset + i) & OTP_ADDR2_10_3));
 
 		lan78xx_write_reg(dev, OTP_FUNC_CMD, OTP_FUNC_CMD_READ_);
 		lan78xx_write_reg(dev, OTP_CMD_GO, OTP_CMD_GO_GO_);
@@ -903,9 +904,9 @@ static int lan78xx_write_raw_otp(struct lan78xx_net *dev, u32 offset,
 
 	for (i = 0; i < length; i++) {
 		lan78xx_write_reg(dev, OTP_ADDR1,
-					((offset + i) >> 8) & OTP_ADDR1_15_11);
+				  ((offset + i) >> 8) & OTP_ADDR1_15_11);
 		lan78xx_write_reg(dev, OTP_ADDR2,
-					((offset + i) & OTP_ADDR2_10_3));
+				  ((offset + i) & OTP_ADDR2_10_3));
 		lan78xx_write_reg(dev, OTP_PRGM_DATA, data[i]);
 		lan78xx_write_reg(dev, OTP_TST_CMD, OTP_TST_CMD_PRGVRFY_);
 		lan78xx_write_reg(dev, OTP_CMD_GO, OTP_CMD_GO_GO_);
@@ -962,7 +963,7 @@ static int lan78xx_dataport_wait_not_busy(struct lan78xx_net *dev)
 		usleep_range(40, 100);
 	}
 
-	netdev_warn(dev->net, "lan78xx_dataport_wait_not_busy timed out");
+	netdev_warn(dev->net, "%s timed out", __func__);
 
 	return -EIO;
 }
@@ -975,7 +976,7 @@ static int lan78xx_dataport_write(struct lan78xx_net *dev, u32 ram_select,
 	int i, ret;
 
 	if (usb_autopm_get_interface(dev->intf) < 0)
-			return 0;
+		return 0;
 
 	mutex_lock(&pdata->dataport_mutex);
 
@@ -1048,9 +1049,9 @@ static void lan78xx_deferred_multicast_write(struct work_struct *param)
 	for (i = 1; i < NUM_OF_MAF; i++) {
 		lan78xx_write_reg(dev, MAF_HI(i), 0);
 		lan78xx_write_reg(dev, MAF_LO(i),
-					pdata->pfilter_table[i][1]);
+				  pdata->pfilter_table[i][1]);
 		lan78xx_write_reg(dev, MAF_HI(i),
-					pdata->pfilter_table[i][0]);
+				  pdata->pfilter_table[i][0]);
 	}
 
 	lan78xx_write_reg(dev, RFE_CTL, pdata->rfe_ctl);
@@ -1069,11 +1070,12 @@ static void lan78xx_set_multicast(struct net_device *netdev)
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
@@ -1267,9 +1269,10 @@ static void lan78xx_status(struct lan78xx_net *dev, struct urb *urb)
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
@@ -1358,7 +1361,7 @@ static void lan78xx_get_wol(struct net_device *netdev,
 	struct lan78xx_priv *pdata = (struct lan78xx_priv *)(dev->data[0]);
 
 	if (usb_autopm_get_interface(dev->intf) < 0)
-			return;
+		return;
 
 	ret = lan78xx_read_reg(dev, USB_CFG0, &buf);
 	if (unlikely(ret < 0)) {
@@ -1980,7 +1983,7 @@ static int lan8835_fixup(struct phy_device *phydev)
 
 	/* RGMII MAC TXC Delay Enable */
 	lan78xx_write_reg(dev, MAC_RGMII_ID,
-				MAC_RGMII_ID_TXC_DELAY_EN_);
+			  MAC_RGMII_ID_TXC_DELAY_EN_);
 
 	/* RGMII TX DLL Tune Adjust */
 	lan78xx_write_reg(dev, RGMII_TX_BYP_DLL, 0x3D00);
@@ -3334,9 +3337,10 @@ static void lan78xx_tx_bh(struct lan78xx_net *dev)
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
@@ -3437,7 +3441,7 @@ static void lan78xx_delayedwork(struct work_struct *work)
 		unlink_urbs(dev, &dev->rxq);
 		status = usb_autopm_get_interface(dev->intf);
 		if (status < 0)
-				goto fail_halt;
+			goto fail_halt;
 		status = usb_clear_halt(dev->udev, dev->pipe_in);
 		usb_autopm_put_interface(dev->intf);
 		if (status < 0 &&
@@ -3610,8 +3614,8 @@ static int lan78xx_probe(struct usb_interface *intf,
 	struct net_device *netdev;
 	struct usb_device *udev;
 	int ret;
-	unsigned maxp;
-	unsigned period;
+	unsigned int maxp;
+	unsigned int period;
 	u8 *buf = NULL;
 
 	udev = interface_to_usbdev(intf);
@@ -3842,10 +3846,10 @@ static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
 		/* set WUF_CFG & WUF_MASK for IPv4 Multicast */
 		crc = lan78xx_wakeframe_crc16(ipv4_multicast, 3);
 		lan78xx_write_reg(dev, WUF_CFG(mask_index),
-					WUF_CFGX_EN_ |
-					WUF_CFGX_TYPE_MCAST_ |
-					(0 << WUF_CFGX_OFFSET_SHIFT_) |
-					(crc & WUF_CFGX_CRC16_MASK_));
+				  WUF_CFGX_EN_ |
+				  WUF_CFGX_TYPE_MCAST_ |
+				  (0 << WUF_CFGX_OFFSET_SHIFT_) |
+				  (crc & WUF_CFGX_CRC16_MASK_));
 
 		lan78xx_write_reg(dev, WUF_MASK0(mask_index), 7);
 		lan78xx_write_reg(dev, WUF_MASK1(mask_index), 0);
@@ -3856,10 +3860,10 @@ static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
 		/* for IPv6 Multicast */
 		crc = lan78xx_wakeframe_crc16(ipv6_multicast, 2);
 		lan78xx_write_reg(dev, WUF_CFG(mask_index),
-					WUF_CFGX_EN_ |
-					WUF_CFGX_TYPE_MCAST_ |
-					(0 << WUF_CFGX_OFFSET_SHIFT_) |
-					(crc & WUF_CFGX_CRC16_MASK_));
+				  WUF_CFGX_EN_ |
+				  WUF_CFGX_TYPE_MCAST_ |
+				  (0 << WUF_CFGX_OFFSET_SHIFT_) |
+				  (crc & WUF_CFGX_CRC16_MASK_));
 
 		lan78xx_write_reg(dev, WUF_MASK0(mask_index), 3);
 		lan78xx_write_reg(dev, WUF_MASK1(mask_index), 0);
@@ -3886,10 +3890,10 @@ static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
 		 */
 		crc = lan78xx_wakeframe_crc16(arp_type, 2);
 		lan78xx_write_reg(dev, WUF_CFG(mask_index),
-					WUF_CFGX_EN_ |
-					WUF_CFGX_TYPE_ALL_ |
-					(0 << WUF_CFGX_OFFSET_SHIFT_) |
-					(crc & WUF_CFGX_CRC16_MASK_));
+				  WUF_CFGX_EN_ |
+				  WUF_CFGX_TYPE_ALL_ |
+				  (0 << WUF_CFGX_OFFSET_SHIFT_) |
+				  (crc & WUF_CFGX_CRC16_MASK_));
 
 		lan78xx_write_reg(dev, WUF_MASK0(mask_index), 0x3000);
 		lan78xx_write_reg(dev, WUF_MASK1(mask_index), 0);
@@ -4034,7 +4038,7 @@ static int lan78xx_resume(struct usb_interface *intf)
 	if (!--dev->suspend_count) {
 		/* resume interrupt URBs */
 		if (dev->urb_intr && test_bit(EVENT_DEV_OPEN, &dev->flags))
-				usb_submit_urb(dev->urb_intr, GFP_NOIO);
+			usb_submit_urb(dev->urb_intr, GFP_NOIO);
 
 		spin_lock_irq(&dev->txq.lock);
 		while ((res = usb_get_from_anchor(&dev->deferred))) {
-- 
2.43.0


