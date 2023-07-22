Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4107275DEC6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 23:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjGVV7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 17:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjGVV7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 17:59:39 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37305213B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:59:19 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-345a8a78bcfso15125355ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690063158; x=1690667958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICetZO3eJiINHtdQ5D1OIXxRMuzgneIba8TDtaF3d6E=;
        b=igpp763ye/MqzfrVlap+d88m97CjjDSbCeJm4qM2yOg4Dwtmx5u8AdHOLXLkJCzkm8
         7DFM7SaC1F7H2GPAx7glIjuGmgq2JeKs7f69g/V6g0rvoEbaOEi1JCRFARaKnmXtkqSp
         /GEmm47vUybvNxMw7uWIabGvVXajEPZ4Oma8UGOpARHi8Ao3xQqlkan4d6Vl9KL0c961
         CQttcuwVX6BIQIOfZridUj9pUtxJNdoOi7osLW2fmsWIwCXNPofhHotnemBNKK1CdjoD
         yuyRm5bGtpnFUrDebwjZ4pVCHjdfJn5FWSFeBb47MSeKu7Sfr40eiyeNbny9j1kPMYtb
         MWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690063158; x=1690667958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICetZO3eJiINHtdQ5D1OIXxRMuzgneIba8TDtaF3d6E=;
        b=lrCBnn3rm583vH3OSZ9is/uYI5lZ7/uaiJqQZi429U7KMn1JxV/xK3pIfSGJsIaIv4
         iYW3BZfMbgeCZXEogQfu2n0rxq57gAzn9t6DPfVUh0l85u4kDnQO/bpJwRfJiu6M6teD
         xpNRpnT7abvNyEp2fEKN0kN410m6cSeeL5dJuZNWjl5xRzoRSMd8ztpZOtXPMPhtn1VZ
         y6883maU+5wBwhJNj1zsEsCXJh7KiIzI7GKRG5sRpeYWe7vJVXK3+frBku+DIofc7D2e
         5OUuDIOZzu8Q5LJKpa5ei7qhe9R1UEUi0N1ocMTPL0Das4Swa/0uAenJMaIMv/cnKwB8
         ZhNg==
X-Gm-Message-State: ABy/qLZI32JzK1dkHLbOVhvTaKbZwNkV3m3dY5TZtPuj+x8PfhomudXJ
        srLCF8VHY5thUekccyOKmpY=
X-Google-Smtp-Source: APBJJlHXV0jmg/1doLTbZ3FFNTvdBkhrS+Ce1zxiK5mVCmupiC8T+9vMTzdib9n7CCIgyNTl0x1CRw==
X-Received: by 2002:a05:6602:2993:b0:787:8fc:307d with SMTP id o19-20020a056602299300b0078708fc307dmr4086777ior.5.1690063158515;
        Sat, 22 Jul 2023 14:59:18 -0700 (PDT)
Received: from localhost.localdomain ([161.97.244.155])
        by smtp.gmail.com with ESMTPSA id t18-20020a02ccb2000000b0042af069eeefsm1869614jap.50.2023.07.22.14.59.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Jul 2023 14:59:18 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
To:     franziska.naepelt@googlemail.com
Cc:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 8/9] staging: rtl8723bs: ioctl_linux: Add preferred spaces
Date:   Sat, 22 Jul 2023 23:59:16 +0200
Message-Id: <20230722215916.4413-1-franziska.naepelt@googlemail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230722215330.4114-1-franziska.naepelt@googlemail.com>
References: <20230722215330.4114-1-franziska.naepelt@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch issues:
- CHECK: spaces preferred around that '+' (ctx:VxV)
- CHECK: spaces preferred around that '&' (ctx:VxV)
- CHECK: spaces preferred around that '|' (ctx:VxV)
- CHECK: spaces required around that ':' (ctx:VxV)

Signed-off-by: Franziska Naepelt <franziska.naepelt@googlemail.com>
---
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 88f560353df7..2896d64e13be 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -13,7 +13,7 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 
-#define RTL_IOCTL_WPA_SUPPLICANT	(SIOCIWFIRSTPRIV+30)
+#define RTL_IOCTL_WPA_SUPPLICANT	(SIOCIWFIRSTPRIV + 30)
 
 static int wpa_set_auth_algs(struct net_device *dev, u32 value)
 {
@@ -315,18 +315,18 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 			while (cnt < ielen) {
 				eid = buf[cnt];
 
-				if ((eid == WLAN_EID_VENDOR_SPECIFIC) && (!memcmp(&buf[cnt+2], wps_oui, 4))) {
-					padapter->securitypriv.wps_ie_len = ((buf[cnt+1]+2) < MAX_WPS_IE_LEN) ? (buf[cnt+1]+2):MAX_WPS_IE_LEN;
+				if ((eid == WLAN_EID_VENDOR_SPECIFIC) && (!memcmp(&buf[cnt + 2], wps_oui, 4))) {
+					padapter->securitypriv.wps_ie_len = ((buf[cnt + 1] + 2) < MAX_WPS_IE_LEN) ? (buf[cnt + 1] + 2) : MAX_WPS_IE_LEN;
 
 					memcpy(padapter->securitypriv.wps_ie, &buf[cnt], padapter->securitypriv.wps_ie_len);
 
 					set_fwstate(&padapter->mlmepriv, WIFI_UNDER_WPS);
 
-					cnt += buf[cnt+1]+2;
+					cnt += buf[cnt + 1] + 2;
 
 					break;
 				} else {
-					cnt += buf[cnt+1]+2; /* goto next */
+					cnt += buf[cnt + 1] + 2; /* goto next */
 				}
 			}
 		}
@@ -359,7 +359,7 @@ static int wpa_set_param(struct net_device *dev, u8 name, u32 value)
 
 		/* ret = ieee80211_wpa_enable(ieee, value); */
 
-		switch ((value)&0xff) {
+		switch ((value) & 0xff) {
 		case 1: /* WPA */
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPAPSK; /* WPA_PSK */
 			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption2Enabled;
@@ -758,7 +758,7 @@ static int rtw_set_beacon(struct net_device *dev, struct ieee_param *param, int
 	if ((pstapriv->max_num_sta > NUM_STA) || (pstapriv->max_num_sta <= 0))
 		pstapriv->max_num_sta = NUM_STA;
 
-	if (rtw_check_beacon_data(padapter, pbuf,  (len-12-2)) == _SUCCESS)/*  12 = param header, 2:no packed */
+	if (rtw_check_beacon_data(padapter, pbuf,  (len - 12 - 2)) == _SUCCESS)/*  12 = param header, 2:no packed */
 		ret = 0;
 	else
 		ret = -EINVAL;
@@ -787,7 +787,7 @@ static int rtw_add_sta(struct net_device *dev, struct ieee_param *param)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
-	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
+	if (check_fwstate(pmlmepriv, (_FW_LINKED | WIFI_AP_STATE)) != true)
 		return -EINVAL;
 
 	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
@@ -815,7 +815,7 @@ static int rtw_add_sta(struct net_device *dev, struct ieee_param *param)
 		memcpy(psta->bssrateset, param->u.add_sta.tx_supp_rates, 16);
 
 		/* check wmm cap. */
-		if (WLAN_STA_WME&flags)
+		if (WLAN_STA_WME & flags)
 			psta->qos_option = 1;
 		else
 			psta->qos_option = 0;
@@ -824,7 +824,7 @@ static int rtw_add_sta(struct net_device *dev, struct ieee_param *param)
 			psta->qos_option = 0;
 
 		/* chec 802.11n ht cap. */
-		if (WLAN_STA_HT&flags) {
+		if (WLAN_STA_HT & flags) {
 			psta->htpriv.ht_option = true;
 			psta->qos_option = 1;
 			memcpy((void *)&psta->htpriv.ht_cap, (void *)&param->u.add_sta.ht_cap, sizeof(struct ieee80211_ht_cap));
@@ -852,7 +852,7 @@ static int rtw_del_sta(struct net_device *dev, struct ieee_param *param)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
-	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
+	if (check_fwstate(pmlmepriv, (_FW_LINKED | WIFI_AP_STATE)) != true)
 		return -EINVAL;
 
 	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
@@ -891,7 +891,7 @@ static int rtw_ioctl_get_sta_data(struct net_device *dev, struct ieee_param *par
 	struct ieee_param_ex *param_ex = (struct ieee_param_ex *)param;
 	struct sta_data *psta_data = (struct sta_data *)param_ex->data;
 
-	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
+	if (check_fwstate(pmlmepriv, (_FW_LINKED | WIFI_AP_STATE)) != true)
 		return -EINVAL;
 
 	if (param_ex->sta_addr[0] == 0xff && param_ex->sta_addr[1] == 0xff &&
@@ -948,7 +948,7 @@ static int rtw_get_sta_wpaie(struct net_device *dev, struct ieee_param *param)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
-	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
+	if (check_fwstate(pmlmepriv, (_FW_LINKED | WIFI_AP_STATE)) != true)
 		return -EINVAL;
 
 	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
@@ -965,7 +965,7 @@ static int rtw_get_sta_wpaie(struct net_device *dev, struct ieee_param *param)
 
 			wpa_ie_len = psta->wpa_ie[1];
 
-			copy_len = ((wpa_ie_len+2) > sizeof(psta->wpa_ie)) ? (sizeof(psta->wpa_ie)):(wpa_ie_len+2);
+			copy_len = ((wpa_ie_len + 2) > sizeof(psta->wpa_ie)) ? (sizeof(psta->wpa_ie)) : (wpa_ie_len + 2);
 
 			param->u.wpa_ie.len = copy_len;
 
@@ -990,7 +990,7 @@ static int rtw_set_wps_beacon(struct net_device *dev, struct ieee_param *param,
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
 		return -EINVAL;
 
-	ie_len = len-12-2;/*  12 = param header, 2:no packed */
+	ie_len = len - 12 - 2;/*  12 = param header, 2:no packed */
 
 	kfree(pmlmepriv->wps_beacon_ie);
 	pmlmepriv->wps_beacon_ie = NULL;
@@ -1021,7 +1021,7 @@ static int rtw_set_wps_probe_resp(struct net_device *dev, struct ieee_param *par
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
 		return -EINVAL;
 
-	ie_len = len-12-2;/*  12 = param header, 2:no packed */
+	ie_len = len - 12 - 2;/*  12 = param header, 2:no packed */
 
 	kfree(pmlmepriv->wps_probe_resp_ie);
 	pmlmepriv->wps_probe_resp_ie = NULL;
@@ -1048,7 +1048,7 @@ static int rtw_set_wps_assoc_resp(struct net_device *dev, struct ieee_param *par
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
 		return -EINVAL;
 
-	ie_len = len-12-2;/*  12 = param header, 2:no packed */
+	ie_len = len - 12 - 2;/*  12 = param header, 2:no packed */
 
 	kfree(pmlmepriv->wps_assoc_resp_ie);
 	pmlmepriv->wps_assoc_resp_ie = NULL;
@@ -1086,14 +1086,14 @@ static int rtw_set_hidden_ssid(struct net_device *dev, struct ieee_param *param,
 
 	mlmeinfo->hidden_ssid_mode = ignore_broadcast_ssid = param->u.bcn_ie.reserved[1];
 
-	ie_len = len-12-2;/*  12 = param header, 2:no packed */
+	ie_len = len - 12 - 2;/*  12 = param header, 2:no packed */
 	ssid_ie = rtw_get_ie(param->u.bcn_ie.buf,  WLAN_EID_SSID, &ssid_len, ie_len);
 
 	if (ssid_ie && ssid_len > 0 && ssid_len <= NDIS_802_11_LENGTH_SSID) {
 		struct wlan_bssid_ex *pbss_network = &mlmepriv->cur_network.network;
 		struct wlan_bssid_ex *pbss_network_ext = &mlmeinfo->network;
 
-		memcpy(ssid, ssid_ie+2, ssid_len);
+		memcpy(ssid, ssid_ie + 2, ssid_len);
 		ssid[ssid_len] = 0x0;
 
 		memcpy(pbss_network->ssid.ssid, (void *)ssid, ssid_len);
-- 
2.39.2 (Apple Git-143)

