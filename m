Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A497A233F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbjIOQHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbjIOQGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:06:48 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF491BC7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:06:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-404800222d2so1267715e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694794001; x=1695398801; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dRUCqTPE6auQEVTrtndtlI84Jy0D1OtStetAdLqgP7o=;
        b=TX7r/fW+Ebt1hE15hSpbaIYDO2LWa0X4+4ameCbkstwpDUDU9CXU0N3+FdfPSNRC2q
         hhRL43U4UTqUpznKbVFZmzknuc1hlX6V09iKgEIfzvsYp+c21rW8UHsxDDKQb/g8sFg1
         x8qwT8PQdPYNN1L5SGpJc2CoTvHNGQ7jr5IsdpKcXZBNitobUYqGHKWqrx6qHS0Dqhnt
         P3Ro4WRjTUw1uWHceeN8bOmhY9cEJA3/louxzgFKid69+9H1vex+xGFdltIpLLFxHTQV
         0DZfJFyulJa79bxn63J16pNnIWxSiR4TvxN6Ldi64PsyLtPu8J3NPh8BqARR7Um0PUxJ
         Aahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694794001; x=1695398801;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRUCqTPE6auQEVTrtndtlI84Jy0D1OtStetAdLqgP7o=;
        b=hemCtT13c8YZn9cPv7hfLK4WSw/OkRRQJAu34BuvhZalqQo4vVUo07hdAPlrvo96Jk
         MQj3Hhx+X5HTD39XZGUnwOZh3Yz2jOs3rsZ5ysQ4l8n+IBQ7okFHp9Ry6dFQBMKOGxCD
         umgXjAi23fuqrkpG2655ajxwHMILwRR7+iTUOGAH8CUDyetNqnHYbwTGbjSE1tgrW90+
         8xuGdGTQtmpzIY90Hs4XR8Y5NnGPnQiYrqGfjL7U6HcqGgS/qkPFBk3wyo5fFXTW0TTJ
         bZdWOC83rITzrm7jT2Q5TnoQlLz327hxDTC1Yeyh5A5B96iIzLKlAbLBUM96x/ALJ04V
         wu1w==
X-Gm-Message-State: AOJu0Yy+Yg3ncbWi3p6eRiv4RKppsOJmFE1BMj3/ONEEv0TPKkQL8xTV
        lNHASQiMI0WoMw43gRCOKGydq+sArmo8Jg==
X-Google-Smtp-Source: AGHT+IF1D5kQXidw8I5QOt1/oTEv1JnRn6u/Z4yHMvC0UGDBmEPXPH5VkrVfA8j4DH34d7Ot4foPlg==
X-Received: by 2002:a1c:7919:0:b0:401:db82:3eda with SMTP id l25-20020a1c7919000000b00401db823edamr1981061wme.1.1694794001023;
        Fri, 15 Sep 2023 09:06:41 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id v15-20020adff68f000000b0031433443265sm4777995wrp.53.2023.09.15.09.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 09:06:40 -0700 (PDT)
Date:   Fri, 15 Sep 2023 18:06:39 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/16] staging: rtl8192e: Replace struct rtllib_hdr_3addr
Message-ID: <cover.1694792595.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace struct rtllib_hdr_3addr and and similar structs.
Replace management subframe types constants with IEEE80211_* and
similar constants.

Tested with rtl8192e (WLL6130-D99) in Mode n (12.2 MB/s)
Transferred this patch over wlan connection of rtl8192e.

---
Here some tests regarding sizes of structs and one pointername change:
printk("size rtllib_hdr_3addr: %ld\n",sizeof(struct rtllib_hdr_3addr));
printk("size ieee80211_hdr_3addr: %ld\n",sizeof(struct ieee80211_hdr_3addr));
[ 7413.371188] size rtllib_hdr_3addr: 24
[ 7413.371196] size ieee80211_hdr_3addr: 24

delba = (struct rtllib_hdr_3addr *)skb->data;
delba_ph = (struct ieee80211_hdr_3addr *)skb->data;
pDelBaParamSet = (union delba_param_set *)&delba->payload[2];
pDelBaParamSet_ph = (union delba_param_set *)&delba_ph->seq_ctrl + 2;
int ph_payload = pDelBaParamSet - pDelBaParamSet_ph;
printk("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!diff: %d\n", ph_payload);
[ 5608.787297] !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!diff: 0

printk("ieee80211_hdr %ld\n",sizeof(struct ieee80211_hdr));
printk("rtllib_hdr_4addr %ld\n",sizeof(struct rtllib_hdr_4addr));
[ 8182.169990] ieee80211_hdr 30
[ 8182.170023] rtllib_hdr_4addr 30

printk("ieee80211_pspoll %ld\n",sizeof(struct ieee80211_pspoll));
printk("rtllib_pspoll_hdr %ld\n",sizeof(struct rtllib_pspoll_hdr));
[12277.846879] ieee80211_pspoll 16
[12277.846900] rtllib_pspoll_hdr 16

Philipp Hortmann (16):
  staging: rtl8192e: Replace struct rtllib_hdr_1addr with ieee80211_hdr
  staging: rtl8192e: Replace struct rtllib_hdr_3addr in rtllib_rx.c
  staging: rtl8192e: Replace struct rtllib_hdr_3addr in rtl819x_BAProc.c
  staging: rtl8192e: Replace struct rtllib_hdr_3addr in rtllib_softmac.c
  staging: rtl8192e: Replace struct rtllib_hdr_3addr in r8192E_dev.c
  staging: rtl8192e: Replace struct rtllib_hdr_3addr in structs of
    rtllib.h
  staging: rtl8192e: Remove unused struct rtllib_hdr and two enums
  staging: rtl8192e: Replace struct rtllib_hdr_4addr in rtllib_crypt*.c
  staging: rtl8192e: Remove struct rtllib_hdr_4addr
  staging: rtl8192e: Remove struct rtllib_hdr_3addrqos
  staging: rtl8192e: Remove struct rtllib_hdr_4addrqos
  staging: rtl8192e: Remove struct rtllib_pspoll_hdr
  staging: rtl8192e: Replace management subframe types with
    IEEE80211_STYPE_*
  staging: rtl8192e: Replace control subframe types with
    IEEE80211_STYPE_*
  staging: rtl8192e: Replace usage of RTLLIB_FCTL_DSTODS with function
  staging: rtl8192e: Replace frame control constants with
    IEEE80211_FCTL_*

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  18 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |   8 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c     |  48 ++--
 drivers/staging/rtl8192e/rtllib.h             | 183 ++--------------
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c  |  17 +-
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c  |  40 ++--
 drivers/staging/rtl8192e/rtllib_rx.c          | 206 +++++++++---------
 drivers/staging/rtl8192e/rtllib_softmac.c     | 100 ++++-----
 drivers/staging/rtl8192e/rtllib_tx.c          |  36 +--
 9 files changed, 257 insertions(+), 399 deletions(-)

-- 
2.42.0

