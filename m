Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065F27B4966
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 21:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbjJATQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 15:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbjJATQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 15:16:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC72DC;
        Sun,  1 Oct 2023 12:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=alROJcP7o0E1u6xLhEGxZLifLD+CwBYH8E3z9ks3Ol0=; b=r1qwuLDjcy7E2l0qYQGQ5gqhhM
        om8bRwi4pfUxDqn57KpiyBq6WgtWom6DrDDMffH1lX5uerJIy/4PuBRTn6i3ARpyn4Mr78ZHbbUC3
        n8DrGrCD0N7ZPOM5nH8JrnauDcNsWw7vS2JetI4PKIPVCT/qLMSW++9Ur89w1C7KaxiMwQg2NGXVl
        zmwK7HnfUpGri7Jg5ygCXjs81y0bl6hqeoBNmeU6cpkx2+nqjDcFdcprUFzcDgnWzqu//f31v4hjJ
        U4jH7on2dHYR9gDp88RtX/cZ3jSdc1oyKALmZaQIAeBM1jL9pyVG/91nBhs7/R8/GBgWGDoMjYRk4
        n/O8Zosw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qn1ve-00BYlp-2H;
        Sun, 01 Oct 2023 19:16:34 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: [PATCH 2/3] wifi: mac80211: fix header kernel-doc typos
Date:   Sun,  1 Oct 2023 12:16:32 -0700
Message-ID: <20231001191633.19090-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231001191633.19090-1-rdunlap@infradead.org>
References: <20231001191633.19090-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct typos and fix run-on sentences.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
---
 include/net/mac80211.h |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff -- a/include/net/mac80211.h b/include/net/mac80211.h
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -79,7 +79,7 @@
  * helpers for sanity checking. Drivers must ensure all work added onto the
  * mac80211 workqueue should be cancelled on the driver stop() callback.
  *
- * mac80211 will flushed the workqueue upon interface removal and during
+ * mac80211 will flush the workqueue upon interface removal and during
  * suspend.
  *
  * All work performed on the mac80211 workqueue must not acquire the RTNL lock.
@@ -138,7 +138,7 @@
  * field to the frame RX timestamp and report the ack TX timestamp in the
  * ieee80211_rx_status struct.
  *
- * Similarly, To report hardware timestamps for Timing Measurement or Fine
+ * Similarly, to report hardware timestamps for Timing Measurement or Fine
  * Timing Measurement frame TX, the driver should set the SKB's hwtstamp field
  * to the frame TX timestamp and report the ack RX timestamp in the
  * ieee80211_tx_status struct.
@@ -3062,7 +3062,7 @@ void ieee80211_free_txskb(struct ieee802
  * The set_key() call for the %SET_KEY command should return 0 if
  * the key is now in use, -%EOPNOTSUPP or -%ENOSPC if it couldn't be
  * added; if you return 0 then hw_key_idx must be assigned to the
- * hardware key index, you are free to use the full u8 range.
+ * hardware key index. You are free to use the full u8 range.
  *
  * Note that in the case that the @IEEE80211_HW_SW_CRYPTO_CONTROL flag is
  * set, mac80211 will not automatically fall back to software crypto if
@@ -3072,7 +3072,7 @@ void ieee80211_free_txskb(struct ieee802
  * When the cmd is %DISABLE_KEY then it must succeed.
  *
  * Note that it is permissible to not decrypt a frame even if a key
- * for it has been uploaded to hardware, the stack will not make any
+ * for it has been uploaded to hardware. The stack will not make any
  * decision based on whether a key has been uploaded or not but rather
  * based on the receive flags.
  *
@@ -3087,7 +3087,7 @@ void ieee80211_free_txskb(struct ieee802
  * The update_tkip_key() call updates the driver with the new phase 1 key.
  * This happens every time the iv16 wraps around (every 65536 packets). The
  * set_key() call will happen only once for each key (unless the AP did
- * rekeying), it will not include a valid phase 1 key. The valid phase 1 key is
+ * rekeying); it will not include a valid phase 1 key. The valid phase 1 key is
  * provided by update_tkip_key only. The trigger that makes mac80211 call this
  * handler is software decryption with wrap around of iv16.
  *
@@ -3114,7 +3114,7 @@ void ieee80211_free_txskb(struct ieee802
  *
  * mac80211 has support for various powersave implementations.
  *
- * First, it can support hardware that handles all powersaving by itself,
+ * First, it can support hardware that handles all powersaving by itself;
  * such hardware should simply set the %IEEE80211_HW_SUPPORTS_PS hardware
  * flag. In that case, it will be told about the desired powersave mode
  * with the %IEEE80211_CONF_PS flag depending on the association status.
@@ -3139,12 +3139,12 @@ void ieee80211_free_txskb(struct ieee802
  * %IEEE80211_HW_PS_NULLFUNC_STACK flags. The hardware is of course still
  * required to pass up beacons. The hardware is still required to handle
  * waking up for multicast traffic; if it cannot the driver must handle that
- * as best as it can, mac80211 is too slow to do that.
+ * as best as it can; mac80211 is too slow to do that.
  *
  * Dynamic powersave is an extension to normal powersave in which the
  * hardware stays awake for a user-specified period of time after sending a
  * frame so that reply frames need not be buffered and therefore delayed to
- * the next wakeup. It's compromise of getting good enough latency when
+ * the next wakeup. It's a compromise of getting good enough latency when
  * there's data traffic and still saving significantly power in idle
  * periods.
  *
@@ -3209,7 +3209,7 @@ void ieee80211_free_txskb(struct ieee802
  * Note that change, for the sake of simplification, also includes information
  * elements appearing or disappearing from the beacon.
  *
- * Some hardware supports an "ignore list" instead, just make sure nothing
+ * Some hardware supports an "ignore list" instead. Just make sure nothing
  * that was requested is on the ignore list, and include commonly changing
  * information element IDs in the ignore list, for example 11 (BSS load) and
  * the various vendor-assigned IEs with unknown contents (128, 129, 133-136,
@@ -3220,7 +3220,7 @@ void ieee80211_free_txskb(struct ieee802
  * In addition to these capabilities, hardware should support notifying the
  * host of changes in the beacon RSSI. This is relevant to implement roaming
  * when no traffic is flowing (when traffic is flowing we see the RSSI of
- * the received data packets). This can consist in notifying the host when
+ * the received data packets). This can consist of notifying the host when
  * the RSSI changes significantly or when it drops below or rises above
  * configurable thresholds. In the future these thresholds will also be
  * configured by mac80211 (which gets them from userspace) to implement
@@ -3367,8 +3367,8 @@ void ieee80211_free_txskb(struct ieee802
  * period starts for any reason, @release_buffered_frames is called
  * with the number of frames to be released and which TIDs they are
  * to come from. In this case, the driver is responsible for setting
- * the EOSP (for uAPSD) and MORE_DATA bits in the released frames,
- * to help the @more_data parameter is passed to tell the driver if
+ * the EOSP (for uAPSD) and MORE_DATA bits in the released frames.
+ * To help the @more_data parameter is passed to tell the driver if
  * there is more data on other TIDs -- the TIDs to release frames
  * from are ignored since mac80211 doesn't know how many frames the
  * buffers for those TIDs contain.
@@ -3417,7 +3417,7 @@ void ieee80211_free_txskb(struct ieee802
  * Additionally, the driver has to then use these HW queue IDs for the queue
  * management functions (ieee80211_stop_queue() et al.)
  *
- * The driver is free to set up the queue mappings as needed, multiple virtual
+ * The driver is free to set up the queue mappings as needed; multiple virtual
  * interfaces may map to the same hardware queues if needed. The setup has to
  * happen during add_interface or change_interface callbacks. For example, a
  * driver supporting station+station and station+AP modes might decide to have
@@ -7256,7 +7256,7 @@ ieee80211_return_txq(struct ieee80211_hw
  *
  * This function is used to check whether given txq is allowed to transmit by
  * the airtime scheduler, and can be used by drivers to access the airtime
- * fairness accounting without going using the scheduling order enfored by
+ * fairness accounting without using the scheduling order enforced by
  * next_txq().
  *
  * Returns %true if the airtime scheduler thinks the TXQ should be allowed to
