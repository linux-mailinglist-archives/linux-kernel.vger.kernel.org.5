Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FDF75DEC4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 23:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjGVV7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 17:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjGVV67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 17:58:59 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C852680
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:58:53 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-34574eb05f4so15172825ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690063133; x=1690667933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4RHWRuMZ9AdFIutMNVpmAc8uN14s1z4APTsWvUfDsw=;
        b=Gn1HLbMzKGVIpgfqyhOYsXSMrI+w4YT0mngPqwmVOD4RIzqJ2+zdjLh1dfhup1Vqs/
         IDSOZNcwZYG7feS9Cn+vrLmUblGthennt2TsiI5e/H7UnZO10DyLMClUhZu3b3dKBJKz
         CJcrXirEWPqJcpFGAH0RnAJz0RW95pYJ9AzHrc9AZzPYS3NDAAFqXOZdYYxjJmDH+SnI
         gZ1qGnsenXuVn8CLlQnTLLwrqUS1ms1s/uGffna4n8Afs4XVJ6LjNW/7kpdTqsbTeOFL
         gBOCBPXEgZGN+6d2diP7mbPsloa42xh7Lsjn1eAnKsljt73Xak6sjuuGUzqYBJMdGFRg
         TclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690063133; x=1690667933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4RHWRuMZ9AdFIutMNVpmAc8uN14s1z4APTsWvUfDsw=;
        b=JQGGRMnQgs/dwuo8fejcTjBYFvxpuGdbQ0t2h+cNPdOaQxL9EHq60jTqaEXMIUY22J
         Qz+yZmq1xs6fhJlR9wX6GXQFFc3r3uAkd4ISg1+m0amDgDU0stcHWFBgD2VTnMoxIoXQ
         IU1mP6DyqIkbnc8r6QRXKLE3EZ1ysETexpJ7gcbKxQTVZVcJcGS6157afvQ0/1ZcNKww
         iok0nhqiipltG36nF5QJQDglA5B+bQnJsq2g+xJvD8DbTRI+A0m2mZVGCm20t79JVUfu
         r3zglSu2V/2zGgfdQ0xrVn0oGg4YtvSQuRKx6ECqx5Z7kx/S5NXpU8T0Eh28J5PUMEmS
         zCNA==
X-Gm-Message-State: ABy/qLZOgwuuAyviI2ssbGzsQ8GIgWZnClGdYz22kWhDKhI6FM96T+kG
        WPORTJxJbOXpsqh4NDLY/NM=
X-Google-Smtp-Source: APBJJlHFyYkKrYJ+OO3xzWGaiRJzncDksKg4hvsFaaQYlSCYhpMjI09oYOIs6a1x9HHHn/LB4zs4Gg==
X-Received: by 2002:a92:c7d0:0:b0:345:e1be:1567 with SMTP id g16-20020a92c7d0000000b00345e1be1567mr2903362ilk.25.1690063132889;
        Sat, 22 Jul 2023 14:58:52 -0700 (PDT)
Received: from localhost.localdomain ([161.97.244.155])
        by smtp.gmail.com with ESMTPSA id f19-20020a02b793000000b0042673ad37b1sm1892965jam.52.2023.07.22.14.58.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Jul 2023 14:58:52 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
To:     franziska.naepelt@googlemail.com
Cc:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 6/9] staging: rtl8723bs: ioctl_linux: Remove unnecessary parentheses
Date:   Sat, 22 Jul 2023 23:58:50 +0200
Message-Id: <20230722215850.4353-1-franziska.naepelt@googlemail.com>
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

Fix the following checkpatch issue:
- CHECK: Unnecessary parentheses around ...

Signed-off-by: Franziska Naepelt <franziska.naepelt@googlemail.com>
---
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 58 +++++++++----------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index cde2c5d1e92c..e4c5e249df98 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -125,7 +125,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 				goto exit;
 			}

-			memcpy(&(psecuritypriv->dot11DefKey[wep_key_idx].skey[0]), pwep->key_material, pwep->key_length);
+			memcpy(&psecuritypriv->dot11DefKey[wep_key_idx].skey[0], pwep->key_material, pwep->key_length);
 			psecuritypriv->dot11DefKeylen[wep_key_idx] = pwep->key_length;
 			rtw_set_key(padapter, psecuritypriv, wep_key_idx, 0, true);
 		}
@@ -156,8 +156,8 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,

 					if (strcmp(param->u.crypt.alg, "TKIP") == 0) { /* set mic key */
 						/* DEBUG_ERR(("\nset key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len)); */
-						memcpy(psta->dot11tkiptxmickey.skey, &(param->u.crypt.key[16]), 8);
-						memcpy(psta->dot11tkiprxmickey.skey, &(param->u.crypt.key[24]), 8);
+						memcpy(psta->dot11tkiptxmickey.skey, &param->u.crypt.key[16], 8);
+						memcpy(psta->dot11tkiprxmickey.skey, &param->u.crypt.key[24], 8);

 						padapter->securitypriv.busetkipkey = false;
 						/* _set_timer(&padapter->securitypriv.tkip_timer, 50); */
@@ -169,8 +169,8 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 						memcpy(padapter->securitypriv.dot118021XGrpKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 						/* only TKIP group key need to install this */
 						if (param->u.crypt.key_len > 16) {
-							memcpy(padapter->securitypriv.dot118021XGrptxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[16]), 8);
-							memcpy(padapter->securitypriv.dot118021XGrprxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[24]), 8);
+							memcpy(padapter->securitypriv.dot118021XGrptxmickey[param->u.crypt.idx].skey, &param->u.crypt.key[16], 8);
+							memcpy(padapter->securitypriv.dot118021XGrprxmickey[param->u.crypt.idx].skey, &param->u.crypt.key[24], 8);
 						}
 						padapter->securitypriv.binstallGrpkey = true;

@@ -518,7 +518,7 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 	struct sta_info *psta = NULL, *pbcmc_sta = NULL;
 	struct adapter *padapter = rtw_netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct security_priv *psecuritypriv = &(padapter->securitypriv);
+	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	char *txkey = padapter->securitypriv.dot118021XGrptxmickey[param->u.crypt.idx].skey;
 	char *rxkey = padapter->securitypriv.dot118021XGrprxmickey[param->u.crypt.idx].skey;
@@ -597,7 +597,7 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,

 			psecuritypriv->dot11PrivacyKeyIndex = wep_key_idx;

-			memcpy(&(psecuritypriv->dot11DefKey[wep_key_idx].skey[0]), pwep->key_material, pwep->key_length);
+			memcpy(&psecuritypriv->dot11DefKey[wep_key_idx].skey[0], pwep->key_material, pwep->key_length);

 			psecuritypriv->dot11DefKeylen[wep_key_idx] = pwep->key_length;

@@ -606,7 +606,7 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 			/* don't update "psecuritypriv->dot11PrivacyAlgrthm" and */
 			/* psecuritypriv->dot11PrivacyKeyIndex =keyid", but can rtw_set_key to cam */

-			memcpy(&(psecuritypriv->dot11DefKey[wep_key_idx].skey[0]), pwep->key_material, pwep->key_length);
+			memcpy(&psecuritypriv->dot11DefKey[wep_key_idx].skey[0], pwep->key_material, pwep->key_length);

 			psecuritypriv->dot11DefKeylen[wep_key_idx] = pwep->key_length;

@@ -632,8 +632,8 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,

 				/* DEBUG_ERR("set key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len); */
 				/* set mic key */
-				memcpy(txkey, &(param->u.crypt.key[16]), 8);
-				memcpy(psecuritypriv->dot118021XGrprxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[24]), 8);
+				memcpy(txkey, &param->u.crypt.key[16], 8);
+				memcpy(psecuritypriv->dot118021XGrprxmickey[param->u.crypt.idx].skey, &param->u.crypt.key[24], 8);

 				psecuritypriv->busetkipkey = true;

@@ -677,8 +677,8 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,

 					/* DEBUG_ERR("set key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len); */
 					/* set mic key */
-					memcpy(psta->dot11tkiptxmickey.skey, &(param->u.crypt.key[16]), 8);
-					memcpy(psta->dot11tkiprxmickey.skey, &(param->u.crypt.key[24]), 8);
+					memcpy(psta->dot11tkiptxmickey.skey, &param->u.crypt.key[16], 8);
+					memcpy(psta->dot11tkiprxmickey.skey, &param->u.crypt.key[24], 8);

 					psecuritypriv->busetkipkey = true;

@@ -706,8 +706,8 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,

 					/* DEBUG_ERR("set key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len); */
 					/* set mic key */
-					memcpy(txkey, &(param->u.crypt.key[16]), 8);
-					memcpy(rxkey, &(param->u.crypt.key[24]), 8);
+					memcpy(txkey, &param->u.crypt.key[16], 8);
+					memcpy(rxkey, &param->u.crypt.key[24], 8);

 					psecuritypriv->busetkipkey = true;

@@ -746,7 +746,7 @@ static int rtw_set_beacon(struct net_device *dev, struct ieee_param *param, int
 {
 	int ret = 0;
 	struct adapter *padapter = rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	unsigned char *pbuf = param->u.bcn_ie.buf;

@@ -784,7 +784,7 @@ static int rtw_add_sta(struct net_device *dev, struct ieee_param *param)
 	int ret = 0;
 	struct sta_info *psta = NULL;
 	struct adapter *padapter = rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;

 	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
@@ -849,7 +849,7 @@ static int rtw_del_sta(struct net_device *dev, struct ieee_param *param)
 	int ret = 0;
 	struct sta_info *psta = NULL;
 	struct adapter *padapter = rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;

 	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
@@ -886,7 +886,7 @@ static int rtw_ioctl_get_sta_data(struct net_device *dev, struct ieee_param *par
 	int ret = 0;
 	struct sta_info *psta = NULL;
 	struct adapter *padapter = rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct ieee_param_ex *param_ex = (struct ieee_param_ex *)param;
 	struct sta_data *psta_data = (struct sta_data *)param_ex->data;
@@ -945,7 +945,7 @@ static int rtw_get_sta_wpaie(struct net_device *dev, struct ieee_param *param)
 	int ret = 0;
 	struct sta_info *psta = NULL;
 	struct adapter *padapter = rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;

 	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
@@ -983,8 +983,8 @@ static int rtw_set_wps_beacon(struct net_device *dev, struct ieee_param *param,
 	int ret = 0;
 	unsigned char wps_oui[4] = {0x0, 0x50, 0xf2, 0x04};
 	struct adapter *padapter = rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	int ie_len;

 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
@@ -1015,7 +1015,7 @@ static int rtw_set_wps_probe_resp(struct net_device *dev, struct ieee_param *par
 {
 	int ret = 0;
 	struct adapter *padapter = rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	int ie_len;

 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
@@ -1042,7 +1042,7 @@ static int rtw_set_wps_assoc_resp(struct net_device *dev, struct ieee_param *par
 {
 	int ret = 0;
 	struct adapter *padapter = rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	int ie_len;

 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
@@ -1069,9 +1069,9 @@ static int rtw_set_hidden_ssid(struct net_device *dev, struct ieee_param *param,
 {
 	int ret = 0;
 	struct adapter *adapter = rtw_netdev_priv(dev);
-	struct mlme_priv *mlmepriv = &(adapter->mlmepriv);
-	struct mlme_ext_priv *mlmeext = &(adapter->mlmeextpriv);
-	struct mlme_ext_info *mlmeinfo = &(mlmeext->mlmext_info);
+	struct mlme_priv *mlmepriv = &adapter->mlmepriv;
+	struct mlme_ext_priv *mlmeext = &adapter->mlmeextpriv;
+	struct mlme_ext_info *mlmeinfo = &mlmeext->mlmext_info;
 	int ie_len;
 	u8 *ssid_ie;
 	char ssid[NDIS_802_11_LENGTH_SSID + 1];
@@ -1108,7 +1108,7 @@ static int rtw_set_hidden_ssid(struct net_device *dev, struct ieee_param *param,
 static int rtw_ioctl_acl_remove_sta(struct net_device *dev, struct ieee_param *param, int len)
 {
 	struct adapter *padapter = rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;

 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
 		return -EINVAL;
@@ -1126,7 +1126,7 @@ static int rtw_ioctl_acl_remove_sta(struct net_device *dev, struct ieee_param *p
 static int rtw_ioctl_acl_add_sta(struct net_device *dev, struct ieee_param *param, int len)
 {
 	struct adapter *padapter = rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;

 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
 		return -EINVAL;
@@ -1144,7 +1144,7 @@ static int rtw_ioctl_set_macaddr_acl(struct net_device *dev, struct ieee_param *
 {
 	int ret = 0;
 	struct adapter *padapter = rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;

 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
 		return -EINVAL;
--
2.39.2 (Apple Git-143)

