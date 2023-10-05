Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184F17B9998
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 03:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244295AbjJEB3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 21:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjJEB3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 21:29:50 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E52C6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 18:29:46 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f7d109926so6221447b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 18:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696469385; x=1697074185; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=seOtURC6fBxwejJy6k6WWhSAcd7bSEPQZUE94/fyJ08=;
        b=mk4Ts3hk9+gNSaj9j1fALfv2XOxIpoXKA1wjNfttziQRjOwmpee+SLP/tE9bmk5S1m
         70hR7OtsylHTPeJDRP0JASE0VtKMvsFYthfslrdRwIwk2F23AOJP94yPGF5zgyUNcGs2
         eOQRt5JJSO9GL41t5pAABACAL0XHeFyxWGTLgFz0JRX7IA7zJmDED1PwP8u74OutNHus
         0c1JqhIyrfty29Sjy7194BvaBnkOlnmxeyRaoPPeKesDVbsOEgWtGezbp3Rlg4ti7lDD
         Ivpn70uEJxUsLg4FDoB1sG3wvNvtbyEUjphfTGHjQcPU6u3/4b23m0GotFSO+cXnFp2+
         bSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696469385; x=1697074185;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=seOtURC6fBxwejJy6k6WWhSAcd7bSEPQZUE94/fyJ08=;
        b=ipbRSOTyHzUZyA3mk4J4M8bGUItZz9LtupdsRI7osDtFir0B6OcXFgpyI0x5PK0hUr
         lUTcfFyHfFu/YJQhfJh6/Ijidq+/h5c16vo8WXznZ7eE+iYpdAfPaK21OYWTP2YehLRW
         H+j5GRMEw5iRdVMGRybL3DbkVh/GF4LKF6wUqzuNukNLKEcflxdoqwxD95+cnBkEcoc+
         wZDElmnVMmco8MFBMBpoaSgUOC59G5mdH4wsgmWnTQ2biz9uuvPop84Fc6339IU4ZZ+n
         ntqWONtR2gjPobMqfUrxLytJS8jWV1W11MBNBaiClDGsSSNr4yrBAB1VZpFMYPf4gH2k
         zPOA==
X-Gm-Message-State: AOJu0Yw+8PE+jZVqrRMrnTiCwFzRYG9l2fVvH3CQ902Y7M71YKhQPdiG
        Ob2ffyVBY8CzBySylOF+mflsY39OaLG3FNTVaw==
X-Google-Smtp-Source: AGHT+IHGlUdBnRQgAUkJbTUD5bhZpKVCzmIJHzuIezZEtvNkFHMjMTUnquqEGw5iJVx3Upqhvllv2Qm2UrKMLjL1QQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:d42:0:b0:d7f:8e0a:4b3f with SMTP
 id 63-20020a250d42000000b00d7f8e0a4b3fmr58588ybn.3.1696469385723; Wed, 04 Oct
 2023 18:29:45 -0700 (PDT)
Date:   Thu, 05 Oct 2023 01:29:45 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIgRHmUC/x2NzQqDMBCEX0X23IUk/rV9FfEgybYuSJTdIIr47
 k16mfm+y8wFSsKk8K4uENpZeY1Z7KMCP0/xS8ghOzjjamtMi5ok+u3EILyTKEZKSGkmKTAVWDX 3cpRw6DE8++7VtKGrGwt5dhP68PG/HMb7/gGZNBCkggAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696469384; l=2106;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=X2VGMiD2VyU3UNmwOeb3Zcy55vlwL+eXR2GtGCju9sw=; b=Na69FtdFYr6hWbOU/LN2ileJHX4Vn+VWR5fpviGG/UesKWcaHIRD05Hj/H0r1oeNn8TTEdQYY
 5SCvfX7QZAGB2eaD8GVNAjSMnK+zuim5ZrxZ1T4ZtpSiUZXLb5qHBAr
X-Mailer: b4 0.12.3
Message-ID: <20231005-strncpy-drivers-net-ethernet-atheros-atlx-atl2-c-v1-1-493f113ebfc7@google.com>
Subject: [PATCH] net: atheros: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Chris Snook <chris.snook@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect netdev->name to be NUL-terminated based on its use with format
strings and dev_info():
|     dev_info(&adapter->pdev->dev,
|             "%s link is up %d Mbps %s\n",
|             netdev->name, adapter->link_speed,
|             adapter->link_duplex == FULL_DUPLEX ?
|             "full duplex" : "half duplex");

Furthermore, NUL-padding is not required as netdev is already
zero-initialized through alloc_etherdev().

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/ethernet/atheros/atlx/atl2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/atheros/atlx/atl2.c b/drivers/net/ethernet/atheros/atlx/atl2.c
index 1b487c071cb6..bcfc9488125b 100644
--- a/drivers/net/ethernet/atheros/atlx/atl2.c
+++ b/drivers/net/ethernet/atheros/atlx/atl2.c
@@ -1377,7 +1377,7 @@ static int atl2_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->watchdog_timeo = 5 * HZ;
 	netdev->min_mtu = 40;
 	netdev->max_mtu = ETH_DATA_LEN + VLAN_HLEN;
-	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
+	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
 
 	netdev->mem_start = mmio_start;
 	netdev->mem_end = mmio_start + mmio_len;

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231005-strncpy-drivers-net-ethernet-atheros-atlx-atl2-c-d876945d6341

Best regards,
--
Justin Stitt <justinstitt@google.com>

