Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562CB799A64
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 20:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239130AbjIISUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 14:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239043AbjIISUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 14:20:46 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8644E57
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 11:20:07 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-401314e7838so9061125e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 11:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694283604; x=1694888404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t0GJntv/tr8/Gm4ETuKdQjTd3AzrBQjbaRNLIIDonBY=;
        b=BJjDzbKNb5SIDFItOlBKEvjY6ltrFHAw9pexxkx/cMFeCYlFHX6zxfdUG5nx6nfAqH
         c3ErARLMSeILcIHdyAZLsKZKpd+Z4skk/zZUXSgwwA8YQ8LjVv9LlRKaWnwF553qw7/O
         C0pSLW8rdqugrPI7f3te4vRSvFrAl86ve8fakVevqySq2fDaTgPqOCsamLiimtczxanS
         DMf/nUFiijbSyJKd7xG8JCOd+myq2poeK8ubHr4CnuhBvFoHbed38KoqZFzmHRslnSxP
         drvbfg3fivtAzjurh1aOYgR3+dhf81d1u+Qi85eiCZnjQ7db8UcK+H5P7tNvES53W6LS
         AA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694283604; x=1694888404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0GJntv/tr8/Gm4ETuKdQjTd3AzrBQjbaRNLIIDonBY=;
        b=qlwGi+T2FMUohD8I1ZZ5FuFStV+4zLEvo5tluglUUWjpgnK0imAGPqCKwjmBRUEq+4
         Z8/SKytpjdK86o4tvtC+zvcjlWNhWqX5ywXGfitEZIcBVY4l7wKrAraFcTyeYir9jXba
         LBNvyzsWadFkSOKJTCIcp7rpnAFssNfH7bFkT7W5KaXUzOTfZnXriOP9l/1+Rhou/hx5
         jSKIJ0++rFw8JMKNchtC+Y4C1sNwBN30vZQ1WHsAXlxo6UKazIrg0OV2feMQJUHH6+dE
         JUdfZ3xyJZYA7DELnsA3EY/bUhUEZu4ti9fX+oKOzrL6A+ImtpxgvR3z0GsQ7MIejfu/
         QTJg==
X-Gm-Message-State: AOJu0YzfiJZAHBXbt23ubyF46hU8Rv7aD21iTJwRIqfNDsqeyuSxUFXs
        VL87/fGmlPiX69sZFNC+2TE=
X-Google-Smtp-Source: AGHT+IGVIBnE+056PTRWKmggLco2irpXki5yrAdaFey/hKmlCTT5C6E0jdbEVHOrytZ5i6374DkO0A==
X-Received: by 2002:a5d:654d:0:b0:317:3d36:b2c1 with SMTP id z13-20020a5d654d000000b003173d36b2c1mr4165167wrv.7.1694283604090;
        Sat, 09 Sep 2023 11:20:04 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d5589000000b003141e629cb6sm5330113wrv.101.2023.09.09.11.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 11:20:03 -0700 (PDT)
Date:   Sat, 9 Sep 2023 20:20:02 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] staging: rtl8192e: Use standard function in
 softmac_mgmt_xmit()
Message-ID: <caae14d46f7f5a3072ee3e53f80a27909c86fcbf.1694282907.git.philipp.g.hortmann@gmail.com>
References: <cover.1694282907.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694282907.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use standard function ieee80211_is_beacon() to avoid proprietary code to
identify beacon and to increase readability in softmac_mgmt_xmit() and
_rtl92e_translate_rx_signal_stats()

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 1 -
 drivers/staging/rtl8192e/rtllib_softmac.c      | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 58e90b7772ef..8adf53174239 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1584,7 +1584,7 @@ static void _rtl92e_translate_rx_signal_stats(struct net_device *dev,
 		 (!pstats->bHwError) && (!pstats->bCRC) && (!pstats->bICV));
 	bpacket_toself = bpacket_match_bssid &&		/* check this */
 			 ether_addr_equal(praddr, priv->rtllib->dev->dev_addr);
-	if (WLAN_FC_GET_FRAMETYPE(fc) == RTLLIB_STYPE_BEACON)
+	if (ieee80211_is_beacon(hdr->frame_ctl))
 		bPacketBeacon = true;
 	_rtl92e_process_phyinfo(priv, tmp_buf, &previous_stats, pstats);
 	_rtl92e_query_rxphystatus(priv, pstats, pdesc, pdrvinfo,
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 95c9f6679d71..7dfb93f0590c 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -459,7 +459,6 @@ enum _REG_PREAMBLE_MODE {
 #define WLAN_FC_GET_STYPE(fc) ((fc) & RTLLIB_FCTL_STYPE)
 #define WLAN_FC_MORE_DATA(fc) ((fc) & RTLLIB_FCTL_MOREDATA)
 
-#define WLAN_FC_GET_FRAMETYPE(fc) ((fc) & RTLLIB_FCTL_FRAMETYPE)
 #define WLAN_GET_SEQ_FRAG(seq) ((seq) & RTLLIB_SCTL_FRAG)
 #define WLAN_GET_SEQ_SEQ(seq)  (((seq) & RTLLIB_SCTL_SEQ) >> 4)
 
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index de1702491191..5de57331c1cf 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -197,7 +197,7 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct rtllib_device *ieee)
 	/* called with 2nd param 0, no mgmt lock required */
 	rtllib_sta_wakeup(ieee, 0);
 
-	if (le16_to_cpu(header->frame_ctl) == RTLLIB_STYPE_BEACON)
+	if (ieee80211_is_beacon(header->frame_ctl))
 		tcb_desc->queue_index = BEACON_QUEUE;
 	else
 		tcb_desc->queue_index = MGNT_QUEUE;
-- 
2.41.0

