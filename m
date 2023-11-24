Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BEE7F8582
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 22:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbjKXVb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 16:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjKXVbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 16:31:12 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A9A19A8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:31:18 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54b0a9fffa4so136783a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700861477; x=1701466277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DyqSTfLJlN88c/SvS3E14EIDuuTHtFX/UzdV/6o/zM8=;
        b=fSz+fgv+tnNu0ccBgF/J879ETncvu3OP3h+5TTOOfTsCHER4SJJR2MbLilMAuG/7Lh
         Ip4NYLbHLVLFzgl/n9QBfXyaOTA1ZlZXjGwtMNO6bqZ1J2WP6U1P3gFEz2a36U7fMLmS
         AwB3n9zdXMLMMw1XR5sI4b4mKU8uyw6lOIwI1TZLrlO4C12W8CPca4o98uSnidEJB5GK
         YneT5bMMD6/Yi8g60/jQCNv0XuvjshTZT5bt3eDn28YMf1ZEzPR+aT3eGIWuMGgmmjuf
         VHYilc1N+hlkYImK6cf9aFQciO2XfmM0QhETOdOYn50p4+wO/iKWU+v8sjoXQjQDzHGq
         yykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700861477; x=1701466277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyqSTfLJlN88c/SvS3E14EIDuuTHtFX/UzdV/6o/zM8=;
        b=T7UnuNjjUVOplVqG46+panWu+/CHv1FQlEGECjMysUb2Eu8K3kKiFtfTgiX7O+s121
         H2iCZv7XuerbkEwRSwQOLazUDBW6wakE/ZQbogY2PELyxEZyeZdB20WaC7IgP+AzJ4j9
         lqpZ776ylHVxBWEqJq421wXsxmxdi/S9uzNjT1U9D1BPmILFrpEDCjRdsczboWNBomNx
         eDG9rLfI8ksZ50xYTZXKvQghx3fY+si2eDCztNCyLlZQJo5uCYxYEZDN3VDNAD8LR75T
         psKwxFt0UY1gi+EGzWKKkZqCQwsNyM+riKiWNSTlvA7cMZx+8etZ4lVHz2iZgHlarAjb
         ZrVQ==
X-Gm-Message-State: AOJu0YwEUHkOqNXoM5vrTO91oI1LRlpwcbq9tj02vtrPPHHkEP6qgZ2/
        hMhevVO067ktrjmi7acabfQ=
X-Google-Smtp-Source: AGHT+IHrHPi58qXc5j3ILPT28jROxOczly3sw4sv0zRu2cJGZpENgvHS5Q9O1WF07W3ItU9Ud4N6BA==
X-Received: by 2002:a05:6402:17db:b0:542:1ba5:68a4 with SMTP id s27-20020a05640217db00b005421ba568a4mr2990119edy.1.1700861476770;
        Fri, 24 Nov 2023 13:31:16 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id t24-20020aa7d718000000b0053ff311f388sm2196289edq.23.2023.11.24.13.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 13:31:16 -0800 (PST)
Date:   Fri, 24 Nov 2023 22:31:15 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] staging: rtl8192e: Remove unused function
 rtllib_probe_resp()
Message-ID: <be709ffea087df6f960075a51c0eab89f86ef8b2.1700860759.git.philipp.g.hortmann@gmail.com>
References: <cover.1700860758.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700860758.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function rtllib_probe_resp().

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 146 ----------------------
 1 file changed, 146 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 8c7ad56d4402..d20970652432 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -632,152 +632,6 @@ rtllib_authentication_req(struct rtllib_network *beacon,
 	return skb;
 }
 
-static struct sk_buff *rtllib_probe_resp(struct rtllib_device *ieee,
-					 const u8 *dest)
-{
-	u8 *tag;
-	int beacon_size;
-	struct rtllib_probe_response *beacon_buf;
-	struct sk_buff *skb = NULL;
-	int encrypt;
-	int atim_len, erp_len;
-	struct lib80211_crypt_data *crypt;
-
-	char *ssid = ieee->current_network.ssid;
-	int ssid_len = ieee->current_network.ssid_len;
-	int rate_len = ieee->current_network.rates_len + 2;
-	int rate_ex_len = ieee->current_network.rates_ex_len;
-	int wpa_ie_len = ieee->wpa_ie_len;
-	u8 erpinfo_content = 0;
-
-	u8 *tmp_ht_cap_buf = NULL;
-	u8 tmp_ht_cap_len = 0;
-	u8 *tmp_ht_info_buf = NULL;
-	u8 tmp_ht_info_len = 0;
-	struct rt_hi_throughput *ht_info = ieee->ht_info;
-	u8 *tmp_generic_ie_buf = NULL;
-	u8 tmp_generic_ie_len = 0;
-
-	if (rate_ex_len > 0)
-		rate_ex_len += 2;
-
-	if (ieee->current_network.capability & WLAN_CAPABILITY_IBSS)
-		atim_len = 4;
-	else
-		atim_len = 0;
-
-	if ((ieee->current_network.mode == WIRELESS_MODE_G) ||
-	   (ieee->current_network.mode == WIRELESS_MODE_N_24G &&
-	   ieee->ht_info->bCurSuppCCK)) {
-		erp_len = 3;
-		erpinfo_content = 0;
-		if (ieee->current_network.buseprotection)
-			erpinfo_content |= ERP_UseProtection;
-	} else {
-		erp_len = 0;
-	}
-
-	crypt = ieee->crypt_info.crypt[ieee->crypt_info.tx_keyidx];
-	encrypt = crypt && crypt->ops &&
-		((strcmp(crypt->ops->name, "R-WEP") == 0 || wpa_ie_len));
-	if (ieee->ht_info->current_ht_support) {
-		tmp_ht_cap_buf = (u8 *)&(ieee->ht_info->SelfHTCap);
-		tmp_ht_cap_len = sizeof(ieee->ht_info->SelfHTCap);
-		tmp_ht_info_buf = (u8 *)&(ieee->ht_info->SelfHTInfo);
-		tmp_ht_info_len = sizeof(ieee->ht_info->SelfHTInfo);
-		HTConstructCapabilityElement(ieee, tmp_ht_cap_buf,
-					     &tmp_ht_cap_len, encrypt, false);
-		HTConstructInfoElement(ieee, tmp_ht_info_buf, &tmp_ht_info_len,
-				       encrypt);
-
-		if (ht_info->reg_rt2rt_aggregation) {
-			tmp_generic_ie_buf = ieee->ht_info->sz_rt2rt_agg_buf;
-			tmp_generic_ie_len =
-				 sizeof(ieee->ht_info->sz_rt2rt_agg_buf);
-			HTConstructRT2RTAggElement(ieee, tmp_generic_ie_buf,
-						   &tmp_generic_ie_len);
-		}
-	}
-
-	beacon_size = sizeof(struct rtllib_probe_response) + 2 +
-		ssid_len + 3 + rate_len + rate_ex_len + atim_len + erp_len
-		+ wpa_ie_len + ieee->tx_headroom;
-	skb = dev_alloc_skb(beacon_size);
-	if (!skb)
-		return NULL;
-
-	skb_reserve(skb, ieee->tx_headroom);
-
-	beacon_buf = skb_put(skb, (beacon_size - ieee->tx_headroom));
-	ether_addr_copy(beacon_buf->header.addr1, dest);
-	ether_addr_copy(beacon_buf->header.addr2, ieee->dev->dev_addr);
-	ether_addr_copy(beacon_buf->header.addr3, ieee->current_network.bssid);
-
-	beacon_buf->header.duration_id = 0;
-	beacon_buf->beacon_interval =
-		cpu_to_le16(ieee->current_network.beacon_interval);
-	beacon_buf->capability =
-		cpu_to_le16(ieee->current_network.capability &
-		WLAN_CAPABILITY_IBSS);
-	beacon_buf->capability |=
-		cpu_to_le16(ieee->current_network.capability &
-		WLAN_CAPABILITY_SHORT_PREAMBLE);
-
-	if (ieee->current_network.capability & WLAN_CAPABILITY_SHORT_SLOT_TIME)
-		beacon_buf->capability |=
-			cpu_to_le16(WLAN_CAPABILITY_SHORT_SLOT_TIME);
-
-	crypt = ieee->crypt_info.crypt[ieee->crypt_info.tx_keyidx];
-	if (encrypt)
-		beacon_buf->capability |= cpu_to_le16(WLAN_CAPABILITY_PRIVACY);
-
-	beacon_buf->header.frame_control = cpu_to_le16(IEEE80211_STYPE_PROBE_RESP);
-	beacon_buf->info_element[0].id = MFIE_TYPE_SSID;
-	beacon_buf->info_element[0].len = ssid_len;
-
-	tag = (u8 *)beacon_buf->info_element[0].data;
-
-	memcpy(tag, ssid, ssid_len);
-
-	tag += ssid_len;
-
-	*(tag++) = MFIE_TYPE_RATES;
-	*(tag++) = rate_len - 2;
-	memcpy(tag, ieee->current_network.rates, rate_len - 2);
-	tag += rate_len - 2;
-
-	*(tag++) = MFIE_TYPE_DS_SET;
-	*(tag++) = 1;
-	*(tag++) = ieee->current_network.channel;
-
-	if (atim_len) {
-		u16 val16;
-		*(tag++) = MFIE_TYPE_IBSS_SET;
-		*(tag++) = 2;
-		val16 = ieee->current_network.atim_window;
-		memcpy((u8 *)tag, (u8 *)&val16, 2);
-		tag += 2;
-	}
-
-	if (erp_len) {
-		*(tag++) = MFIE_TYPE_ERP;
-		*(tag++) = 1;
-		*(tag++) = erpinfo_content;
-	}
-	if (rate_ex_len) {
-		*(tag++) = MFIE_TYPE_RATES_EX;
-		*(tag++) = rate_ex_len - 2;
-		memcpy(tag, ieee->current_network.rates_ex, rate_ex_len - 2);
-		tag += rate_ex_len - 2;
-	}
-
-	if (wpa_ie_len) {
-		memcpy(tag, ieee->wpa_ie, ieee->wpa_ie_len);
-		tag += ieee->wpa_ie_len;
-	}
-	return skb;
-}
-
 static struct sk_buff *rtllib_null_func(struct rtllib_device *ieee, short pwr)
 {
 	struct sk_buff *skb;
-- 
2.42.0

