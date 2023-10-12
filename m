Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8357C6513
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377329AbjJLGDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377308AbjJLGDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:03:23 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA83D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:03:18 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3175e1bb38cso67864f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697090597; x=1697695397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KukZ0tzE84dJ5AJr1KRIaqdGGLYRgHtX61fFFpt8ADk=;
        b=C5/IzQIS4HVzbpXJj547WaUMKqHsXOtjhOlK6wpC9tAaJRI4Wd7KSsy3uyyFR8DvOL
         j58TJL2G252eutdTVUBdjlFaLzzr2ah8466aDV1vXazsDDfv7TvD4lYFlzaZxR3khr9e
         9z15Oims8dZcpTPQHLheB87S5dqn1WIwBlydRsru9ltsJKLj/dUkClShwhArXvR7dQE2
         6QGTNR2liQXn1TYlQR7Y0NMi/ZiMUdEX3StA6J0lTHk9gMmt1Aj7It6/GmexQKKrxV8r
         WENEKg6J1g4XLCNsVQCqMrzKQrXOQ+nyRXqdIheGNHhlN2kIF99HZlReUnWXN2yL2S/U
         Z4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697090597; x=1697695397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KukZ0tzE84dJ5AJr1KRIaqdGGLYRgHtX61fFFpt8ADk=;
        b=BJKWXpATkVZVLB8r+ufEtH+NTAJaQ0e0fxqw5Rkvb6D1AHuzQ1gfPirRPs8ZYssfuj
         tzaNJcjPpdYTgljKP+k1Y6+9eoW+drDybjRh7Deqj2d4AWid2borfXVc0aEpmqoA0G4x
         E6a6XOOtdbNAxUGq17BGXr78ZOW84BL8hlr3i2f3Aq6DjtU82/GSuQqc1irWizaRo8I3
         rWTdQ7UgJRzBX/FMnNZNh14B6Rf9BGDi3lrfWkh+lNOzG5FlQWG4tdpEr76CyGJjKW05
         Np3ZLdQCQSXUxMo3cqCSRZvMt6mMZ+QeuBfVMHiMLnT80WxFL0ylITY+nK0MWs+WAsew
         WZJA==
X-Gm-Message-State: AOJu0YxM1rWmAcpkSx0PZZahs2I8OPY5jCMLzi+EXbKp2g2Lz1O2BWk3
        wd3BT6EHRb7/uLesMXgCtRqzTVUJuJg=
X-Google-Smtp-Source: AGHT+IFB2oSKIwYOcPSVuc0SCaCm/kBAADGpf7YVFPSak9Ctn5S/X9uqzQq9jYYiYEg0JCubzmoy3A==
X-Received: by 2002:adf:a457:0:b0:32d:8be3:f3fe with SMTP id e23-20020adfa457000000b0032d8be3f3femr1153754wra.7.1697090597162;
        Wed, 11 Oct 2023 23:03:17 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id j16-20020adff010000000b0032008f99216sm17285530wro.96.2023.10.11.23.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 23:03:16 -0700 (PDT)
Date:   Thu, 12 Oct 2023 08:03:15 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] staging: rtl8192u: Fix sleeping kzalloc() called
 from invalid context
Message-ID: <42f7b8728a5d9ada8c0432e1c11c30d13627fba7.1697089416.git.philipp.g.hortmann@gmail.com>
References: <cover.1697089416.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697089416.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sleeping kzalloc() called from invalid context leads to a crash of the
system.

Fixes: 061e390b7c87f ("staging: rtl8192u: ieee80211_softmac: Move a large data struct onto the heap")
Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
Tested with rtl8192u (Belkin F5D8053) in Mode n (12.5 MB/s)

Dump of Error:
[ 2141.025340] ================================
[ 2141.025341] WARNING: inconsistent lock state
[ 2141.025343] 6.6.0-rc1+ #15 Tainted: G         C OE
[ 2141.025345] --------------------------------
[ 2141.025346] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
[ 2141.025348] gnome-shell/3018 [HC0[0]:SC1[1]:HE1:SE0] takes:
[ 2141.025350] ffffffffbbe6b600 (fs_reclaim){+.?.}-{0:0}, at: __kmem_cache_alloc_node+0x48/0x720
[ 2141.025360] {SOFTIRQ-ON-W} state was registered at:
[ 2141.025362]   lock_acquire+0xdc/0x2c0
[ 2141.025368]   fs_reclaim_acquire+0xaa/0xe0
[ 2141.025371]   __kmem_cache_alloc_node+0x48/0x720
[ 2141.025374]   __kmalloc_node+0x57/0x1a0
[ 2141.025376]   alloc_cpumask_var_node+0x1f/0x30
[ 2141.025380]   smp_prepare_cpus_common+0xce/0x180
[ 2141.025385]   native_smp_prepare_cpus+0xe/0xd0
[ 2141.025387]   kernel_init_freeable+0x284/0x560
[ 2141.025391]   kernel_init+0x1a/0x140
[ 2141.025395]   ret_from_fork+0x3c/0x60
[ 2141.025398]   ret_from_fork_asm+0x1b/0x30
[ 2141.025402] irq event stamp: 53750354
[ 2141.025404] hardirqs last  enabled at (53750354): [<ffffffffbb1fbd21>] _raw_spin_unlock_irqrestore+0x31/0x70
[ 2141.025408] hardirqs last disabled at (53750353): [<ffffffffbb1fb9b4>] _raw_spin_lock_irqsave+0x84/0xa0
[ 2141.025411] softirqs last  enabled at (53750290): [<ffffffffbb1fd6cd>] __do_softirq+0x2cd/0x3b7
[ 2141.025415] softirqs last disabled at (53750323): [<ffffffffba2d3fb0>] irq_exit_rcu+0xa0/0xe0
[ 2141.025419]
               other info that might help us debug this:
[ 2141.025420]  Possible unsafe locking scenario:

[ 2141.025422]        CPU0
[ 2141.025423]        ----
[ 2141.025424]   lock(fs_reclaim);
[ 2141.025426]   <Interrupt>
[ 2141.025427]     lock(fs_reclaim);
[ 2141.025429]
                *** DEADLOCK ***

[ 2141.025430] no locks held by gnome-shell/3018.
[ 2141.025432]
               stack backtrace:
[ 2141.025433] CPU: 2 PID: 3018 Comm: gnome-shell Tainted: G         C OE      6.6.0-rc1+ #15
[ 2141.025436] Hardware name: FUJITSU ESPRIMO P710/D3161-A1, BIOS V4.6.5.3 R1.16.0 for D3161-A1x 10/29/2012
[ 2141.025438] Call Trace:
[ 2141.025439]  <TASK>
[ 2141.025441]  dump_stack_lvl+0x5c/0xa0
[ 2141.025445]  dump_stack+0x10/0x20
[ 2141.025447]  print_usage_bug+0x22f/0x2c0
[ 2141.025452]  mark_lock.part.0+0x6bf/0x8a0
[ 2141.025456]  ? sched_clock_noinstr+0x9/0x10
[ 2141.025461]  __lock_acquire+0xb75/0x1de0
[ 2141.025465]  ? sched_clock_noinstr+0x9/0x10
[ 2141.025469]  lock_acquire+0xdc/0x2c0
[ 2141.025473]  ? __kmem_cache_alloc_node+0x48/0x720
[ 2141.025478]  fs_reclaim_acquire+0xaa/0xe0
[ 2141.025481]  ? __kmem_cache_alloc_node+0x48/0x720
[ 2141.025484]  __kmem_cache_alloc_node+0x48/0x720
[ 2141.025487]  ? ieee80211_rx_frame_softmac+0x2d3/0x1a10 [r8192u_usb]
[ 2141.025508]  kmalloc_trace+0x2a/0xc0
[ 2141.025510]  ? kmalloc_trace+0x2a/0xc0
[ 2141.025513]  ieee80211_rx_frame_softmac+0x2d3/0x1a10 [r8192u_usb]
[ 2141.025527]  ? ehci_urb_enqueue+0x12a/0x1020
[ 2141.025534]  ieee80211_rx+0xf44/0x1e60 [r8192u_usb]
[ 2141.025549]  ? __lock_acquire+0xbf3/0x1de0
[ 2141.025552]  ? __lock_acquire+0xbf3/0x1de0
[ 2141.025558]  rtl8192_rx_nomal+0x583/0x1180 [r8192u_usb]
[ 2141.025570]  ? sched_clock_noinstr+0x9/0x10
[ 2141.025573]  ? exc_page_fault+0x1b0/0x210
[ 2141.025580]  rtl8192_irq_rx_tasklet+0x8a/0xc0 [r8192u_usb]
[ 2141.025593]  tasklet_action_common.isra.0+0x10a/0x290
[ 2141.025597]  tasklet_action+0x2d/0x40
[ 2141.025600]  __do_softirq+0xca/0x3b7
[ 2141.025605]  irq_exit_rcu+0xa0/0xe0
[ 2141.025608]  common_interrupt+0x68/0xe0
[ 2141.025611]  asm_common_interrupt+0x27/0x40
[ 2141.025614] RIP: 0033:0x7f31fcbc5634
[ 2141.025617] Code: 89 c9 48 c7 c6 3f 00 00 00 48 d3 ef 48 85 ff 0f 84 96 fe ff ff 48 0f bc cf 0f b6 04 08 0f b6 14 0a 29 d0 c3 66 90 38 c8 75 1c <48> 83 c2 01 48 83 fa 40 0f 84 23 fe ff ff 0f b6 04 17 0f b6 0c 16
[ 2141.025620] RSP: 002b:00007fff36dad668 EFLAGS: 00000246
[ 2141.025623] RAX: 0000000000000072 RBX: 0000000000000000 RCX: 0000000000000072
[ 2141.025624] RDX: 0000000000000008 RSI: 0000563837956fc0 RDI: 000056383759c230
[ 2141.025626] RBP: 0000563837956fc0 R08: 000000000000e000 R09: 0000000000000000
[ 2141.025628] R10: 0000000000000001 R11: 00007f31fccca2e4 R12: 0000000000000012
[ 2141.025629] R13: 000056383759c270 R14: 0000563837e1a5a0 R15: 0000563837956fc0
[ 2141.025634]  </TASK>
[ 2141.025644] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
[ 2141.025647] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3018, name: gnome-shell
[ 2141.025650] preempt_count: 100, expected: 0
[ 2141.025651] RCU nest depth: 0, expected: 0
[ 2141.025653] INFO: lockdep is turned off.
[ 2141.025654] Preemption disabled at:
[ 2141.025655] [<ffffffffbb1fd45e>] __do_softirq+0x5e/0x3b7
[ 2141.025659] CPU: 2 PID: 3018 Comm: gnome-shell Tainted: G         C OE      6.6.0-rc1+ #15
[ 2141.025662] Hardware name: FUJITSU ESPRIMO P710/D3161-A1, BIOS V4.6.5.3 R1.16.0 for D3161-A1x 10/29/2012
[ 2141.025663] Call Trace:
[ 2141.025664]  <TASK>
[ 2141.025666]  dump_stack_lvl+0x7d/0xa0
[ 2141.025669]  dump_stack+0x10/0x20
[ 2141.025672]  __might_resched+0x1be/0x2e0
[ 2141.025676]  __might_sleep+0x43/0x70
[ 2141.025679]  __kmem_cache_alloc_node+0x568/0x720
[ 2141.025682]  ? ieee80211_rx_frame_softmac+0x2d3/0x1a10 [r8192u_usb]
[ 2141.025698]  kmalloc_trace+0x2a/0xc0
[ 2141.025700]  ? kmalloc_trace+0x2a/0xc0
[ 2141.025703]  ieee80211_rx_frame_softmac+0x2d3/0x1a10 [r8192u_usb]
[ 2141.025716]  ? ehci_urb_enqueue+0x12a/0x1020
[ 2141.025721]  ieee80211_rx+0xf44/0x1e60 [r8192u_usb]
[ 2141.025735]  ? __lock_acquire+0xbf3/0x1de0
[ 2141.025738]  ? __lock_acquire+0xbf3/0x1de0
[ 2141.025744]  rtl8192_rx_nomal+0x583/0x1180 [r8192u_usb]
[ 2141.025756]  ? sched_clock_noinstr+0x9/0x10
[ 2141.025758]  ? exc_page_fault+0x1b0/0x210
[ 2141.025765]  rtl8192_irq_rx_tasklet+0x8a/0xc0 [r8192u_usb]
[ 2141.025778]  tasklet_action_common.isra.0+0x10a/0x290
[ 2141.025782]  tasklet_action+0x2d/0x40
[ 2141.025785]  __do_softirq+0xca/0x3b7
[ 2141.025790]  irq_exit_rcu+0xa0/0xe0
[ 2141.025793]  common_interrupt+0x68/0xe0
[ 2141.025796]  asm_common_interrupt+0x27/0x40
[ 2141.025798] RIP: 0033:0x7f31fcbc5634
[ 2141.025800] Code: 89 c9 48 c7 c6 3f 00 00 00 48 d3 ef 48 85 ff 0f 84 96 fe ff ff 48 0f bc cf 0f b6 04 08 0f b6 14 0a 29 d0 c3 66 90 38 c8 75 1c <48> 83 c2 01 48 83 fa 40 0f 84 23 fe ff ff 0f b6 04 17 0f b6 0c 16
[ 2141.025802] RSP: 002b:00007fff36dad668 EFLAGS: 00000246
[ 2141.025804] RAX: 0000000000000072 RBX: 0000000000000000 RCX: 0000000000000072
[ 2141.025806] RDX: 0000000000000008 RSI: 0000563837956fc0 RDI: 000056383759c230
[ 2141.025807] RBP: 0000563837956fc0 R08: 000000000000e000 R09: 0000000000000000
[ 2141.025809] R10: 0000000000000001 R11: 00007f31fccca2e4 R12: 0000000000000012
[ 2141.025811] R13: 000056383759c270 R14: 0000563837e1a5a0 R15: 0000563837956fc0
[ 2141.025815]  </TASK>
---
 .../rtl8192u/ieee80211/ieee80211_softmac.c    | 19 ++++++++-----------
 drivers/staging/rtl8192u/r8192U.h             |  1 +
 drivers/staging/rtl8192u/r8192U_core.c        |  6 ++++++
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 92001cb36730..ff5d6f5aeed1 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -12,6 +12,7 @@
  * Copyright who own it's copyright.
  */
 #include "ieee80211.h"
+#include "../r8192U.h"
 
 #include <linux/random.h>
 #include <linux/delay.h>
@@ -1892,6 +1893,8 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 			   u16 stype)
 {
 	struct rtl_80211_hdr_3addr *header = (struct rtl_80211_hdr_3addr *)skb->data;
+	struct net_device *dev = ieee->dev;
+	struct r8192_priv *priv = ieee80211_priv(dev);
 	u16 errcode;
 	int aid;
 	struct ieee80211_assoc_response_frame *assoc_resp;
@@ -1917,12 +1920,7 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 		if ((ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) &&
 		    ieee->state == IEEE80211_ASSOCIATING_AUTHENTICATED &&
 		    ieee->iw_mode == IW_MODE_INFRA) {
-			struct ieee80211_network *network;
-
-			network = kzalloc(sizeof(*network), GFP_KERNEL);
-			if (!network)
-				return -ENOMEM;
-
+			memset(priv->network, 0, sizeof(struct ieee80211_network));
 			errcode = assoc_parse(ieee, skb, &aid);
 			if (!errcode) {
 				ieee->state = IEEE80211_LINKED;
@@ -1934,15 +1932,15 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 					assoc_resp = (struct ieee80211_assoc_response_frame *)skb->data;
 					if (ieee80211_parse_info_param(ieee, assoc_resp->info_element,\
 								       rx_stats->len - sizeof(*assoc_resp), \
-								       network, rx_stats)) {
+								       priv->network, rx_stats)) {
 						return 1;
 					} else {
 						//filling the PeerHTCap. //maybe not necessary as we can get its info from current_network.
-						memcpy(ieee->pHTInfo->PeerHTCapBuf, network->bssht.bdHTCapBuf, network->bssht.bdHTCapLen);
-						memcpy(ieee->pHTInfo->PeerHTInfoBuf, network->bssht.bdHTInfoBuf, network->bssht.bdHTInfoLen);
+						memcpy(ieee->pHTInfo->PeerHTCapBuf, priv->network->bssht.bdHTCapBuf, priv->network->bssht.bdHTCapLen);
+						memcpy(ieee->pHTInfo->PeerHTInfoBuf, priv->network->bssht.bdHTInfoBuf, priv->network->bssht.bdHTInfoLen);
 					}
 					if (ieee->handle_assoc_response)
-						ieee->handle_assoc_response(ieee->dev, (struct ieee80211_assoc_response_frame *)header, network);
+						ieee->handle_assoc_response(ieee->dev, (struct ieee80211_assoc_response_frame *)header, priv->network);
 				}
 				ieee80211_associate_complete(ieee);
 			} else {
@@ -1957,7 +1955,6 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 				else
 					ieee80211_associate_abort(ieee);
 			}
-			kfree(network);
 		}
 		break;
 
diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index ff0ada00bf41..672bd19e4db7 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -908,6 +908,7 @@ typedef struct r8192_priv {
 
 	struct	ChnlAccessSetting  ChannelAccessSetting;
 	struct work_struct reset_wq;
+	struct ieee80211_network *network;
 
 /**********************************************************/
 	/* For rtl819xUsb */
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index bf6d93de7a74..060475017d0d 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -1990,6 +1990,10 @@ static int rtl8192_init_priv_variable(struct net_device *dev)
 	if (!priv->pFirmware)
 		return -ENOMEM;
 
+	priv->network = kzalloc(sizeof(*priv->network), GFP_KERNEL);
+	if (!priv->network)
+		return -ENOMEM;
+
 	/* rx related queue */
 	skb_queue_head_init(&priv->rx_queue);
 	skb_queue_head_init(&priv->skb_queue);
@@ -4572,6 +4576,8 @@ static int rtl8192_usb_probe(struct usb_interface *intf,
 fail:
 	kfree(priv->pFirmware);
 	priv->pFirmware = NULL;
+	kfree(priv->network);
+	priv->network = NULL;
 	rtl8192_usb_deleteendpoints(dev);
 	msleep(10);
 	free_ieee80211(dev);
-- 
2.42.0

