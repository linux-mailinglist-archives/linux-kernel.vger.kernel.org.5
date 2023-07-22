Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BB675DEC2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 23:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjGVV6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 17:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjGVV6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 17:58:34 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD10F2111
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:58:27 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-783549ef058so158104139f.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690063107; x=1690667907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YL49790jkqNe6T1q+uxDrJ1BBK7ge7fgG7lO4/q27+I=;
        b=PZtNr9l6RAhiNNeUbXlGFAjaE+gFxLCzOMfO+2PTjUnGqkWJvajWMqyA5GVI/tVESz
         o6MTpzIfvjeLZLHvJCn/B1BsAtSmfPTMcJizWSKsYvUNnmqhSAnp08dpfTcf4Wh1rgfH
         Q3ZaGcE7M41gXic90j3MrKlmxdF1k7057S+gObt3JuRELWMqJjKmHw0wTx34x51iMYC3
         BOae6sdQJ+57pcW7w+RcziVGBA7YgdHCiizsrzeBh14XamRnK04QIcgtkE7s44zVP5j9
         5zluux9xw87GmyM3IrhTfAgWqwv9s7ODgni5qeF4H56L89M3WlHOjxDOe2j6vIZtuJLt
         m2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690063107; x=1690667907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YL49790jkqNe6T1q+uxDrJ1BBK7ge7fgG7lO4/q27+I=;
        b=Dmr5U+7+WQNJovzyokXid59ui6E7PhVrvOEQ/aoXJZAwLoGGTGzVEXrVHri25kvKoB
         Ef9iWvlh1uuoE2NWmmwFuORmNgLbAX2ihXL/1kZcNPVpm1WJzwJQ0RQgsOoHFlVDJLSn
         rP9L+EKETizuD8yp0RmqBSL0aOp6y91PDPeF4Jtd+DdNFr6+qnGG31h/JC2Dv+JnGWtt
         djm4hDlzsnCt5PYea/wxn/7cDhstFf2DOH18IrnGw882ou8EB7DM/pLMPGlOH71WygdO
         ZOYhJx9xdyhEw7z4kFoJhujvfv2i3LBJC4fRcVebU7hF/k5No0aSXTerMRdcqpdQuR0h
         B97A==
X-Gm-Message-State: ABy/qLYUmJB0gqoEZB1E8c/OqLbQRp8RGqf7KErv/g7nlVLTB+RSQyCr
        fKFxrq0YAahbHJIFYO7sDP0=
X-Google-Smtp-Source: APBJJlG8iU0E+aXVtjwVob0J199siBx8CwKifG84WgH8SDXd7hE1tOsWU+ORXndrcuLNomQTs8TKOA==
X-Received: by 2002:a05:6e02:1d86:b0:345:af82:dc3a with SMTP id h6-20020a056e021d8600b00345af82dc3amr4795337ila.14.1690063106811;
        Sat, 22 Jul 2023 14:58:26 -0700 (PDT)
Received: from localhost.localdomain ([161.97.244.155])
        by smtp.gmail.com with ESMTPSA id f16-20020a02cad0000000b0042b2d9fbbecsm1874165jap.119.2023.07.22.14.58.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Jul 2023 14:58:26 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
To:     franziska.naepelt@googlemail.com
Cc:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 4/9] staging: rtl8723bs: ioctl_linux: Remove multiple blank lines
Date:   Sat, 22 Jul 2023 23:58:24 +0200
Message-Id: <20230722215824.4281-1-franziska.naepelt@googlemail.com>
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
- CHECK: Please don't use multiple blank lines

Signed-off-by: Franziska Naepelt <franziska.naepelt@googlemail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 088d29b9ea03..16ff55d75687 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -426,11 +426,8 @@ static int wpa_set_param(struct net_device *dev, u8 name, u32 value)
 
 	default:
 
-
-
 		ret = -EOPNOTSUPP;
 
-
 		break;
 
 	}
@@ -570,7 +567,6 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 		goto exit;
 	}
 
-
 	if (strcmp(param->u.crypt.alg, "WEP") == 0 && !psta) {
 		wep_key_idx = param->u.crypt.idx;
 		wep_key_len = param->u.crypt.key_len;
@@ -580,7 +576,6 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 			goto exit;
 		}
 
-
 		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, key_material);
@@ -609,7 +604,6 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 				psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
 			}
 
-
 			psecuritypriv->dot11PrivacyKeyIndex = wep_key_idx;
 
 			memcpy(&(psecuritypriv->dot11DefKey[wep_key_idx].skey[0]), pwep->key_material, pwep->key_length);
@@ -632,7 +626,6 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 	}
 
-
 	if (!psta && check_fwstate(pmlmepriv, WIFI_AP_STATE)) { /*  group key */
 		if (param->u.crypt.set_tx == 1) {
 			if (strcmp(param->u.crypt.alg, "WEP") == 0) {
@@ -778,13 +771,11 @@ static int rtw_set_beacon(struct net_device *dev, struct ieee_param *param, int
 	if ((pstapriv->max_num_sta > NUM_STA) || (pstapriv->max_num_sta <= 0))
 		pstapriv->max_num_sta = NUM_STA;
 
-
 	if (rtw_check_beacon_data(padapter, pbuf,  (len-12-2)) == _SUCCESS)/*  12 = param header, 2:no packed */
 		ret = 0;
 	else
 		ret = -EINVAL;
 
-
 	return ret;
 
 }
@@ -837,7 +828,6 @@ static int rtw_add_sta(struct net_device *dev, struct ieee_param *param)
 
 		memcpy(psta->bssrateset, param->u.add_sta.tx_supp_rates, 16);
 
-
 		/* check wmm cap. */
 		if (WLAN_STA_WME&flags)
 			psta->qos_option = 1;
@@ -861,7 +851,6 @@ static int rtw_add_sta(struct net_device *dev, struct ieee_param *param)
 
 		update_sta_info_apmode(padapter, psta);
 
-
 	} else {
 		ret = -ENOMEM;
 	}
@@ -962,7 +951,6 @@ static int rtw_ioctl_get_sta_data(struct net_device *dev, struct ieee_param *par
 		psta_data->tx_bytes = psta->sta_stats.tx_bytes;
 		psta_data->tx_drops = psta->sta_stats.tx_drops;
 
-
 	} else {
 		ret = -1;
 	}
@@ -1024,7 +1012,6 @@ static int rtw_set_wps_beacon(struct net_device *dev, struct ieee_param *param,
 
 	ie_len = len-12-2;/*  12 = param header, 2:no packed */
 
-
 	kfree(pmlmepriv->wps_beacon_ie);
 	pmlmepriv->wps_beacon_ie = NULL;
 
@@ -1041,7 +1028,6 @@ static int rtw_set_wps_beacon(struct net_device *dev, struct ieee_param *param,
 		pmlmeext->bstart_bss = true;
 	}
 
-
 	return ret;
 
 }
@@ -1058,7 +1044,6 @@ static int rtw_set_wps_probe_resp(struct net_device *dev, struct ieee_param *par
 
 	ie_len = len-12-2;/*  12 = param header, 2:no packed */
 
-
 	kfree(pmlmepriv->wps_probe_resp_ie);
 	pmlmepriv->wps_probe_resp_ie = NULL;
 
@@ -1071,7 +1056,6 @@ static int rtw_set_wps_probe_resp(struct net_device *dev, struct ieee_param *par
 		memcpy(pmlmepriv->wps_probe_resp_ie, param->u.bcn_ie.buf, ie_len);
 	}
 
-
 	return ret;
 
 }
@@ -1088,7 +1072,6 @@ static int rtw_set_wps_assoc_resp(struct net_device *dev, struct ieee_param *par
 
 	ie_len = len-12-2;/*  12 = param header, 2:no packed */
 
-
 	kfree(pmlmepriv->wps_assoc_resp_ie);
 	pmlmepriv->wps_assoc_resp_ie = NULL;
 
@@ -1101,7 +1084,6 @@ static int rtw_set_wps_assoc_resp(struct net_device *dev, struct ieee_param *par
 		memcpy(pmlmepriv->wps_assoc_resp_ie, param->u.bcn_ie.buf, ie_len);
 	}
 
-
 	return ret;
 
 }
-- 
2.39.2 (Apple Git-143)

