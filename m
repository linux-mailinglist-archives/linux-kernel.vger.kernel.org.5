Return-Path: <linux-kernel+bounces-80697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C860A866B64
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F101B21557
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676461BF50;
	Mon, 26 Feb 2024 07:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrodU2zL"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A751BDD8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708933958; cv=none; b=PLkgjNmOHqM0Iahb8hN2vzGTxyJBu+ZUVTc+/VT6vkzOsn5cjJKCET5eR30k7ud07Kl5GD/W7iV+WrmLVvLnpArsjro/58hNNOAKxS9jXHUAbcv1o5N5Oke3jqkyqtiGSAFmOAJdVdf+zzXGna106Jae1PzUYfrTdXoa8Gy55Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708933958; c=relaxed/simple;
	bh=79IFNXtUb0pKOStZ3CnUgtwtP/UJl7nrruMLfiTiZ4I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BKTmtnSUXkNvGcQJUTEDrC3ogBBhJ1iJWvtZ8tgWKEqDuRGFqA+9rUZXelBsNoCZ1gvSaUieDgrnyzcirw1erun530KbTU85XP4GiklBwTa+LNzyKA04wnvyjoxhA9PXJQoL4SyaZXeU3Iy3i11GKk0BQnNKshn86ETM0zctGvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrodU2zL; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33dc3fe739aso688262f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 23:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708933955; x=1709538755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPQ+HZG9ZH8pgTa6BFUHg2MQy0OsY1NDbVY61HuOvvM=;
        b=ZrodU2zL+mpi/4Ak/M0e21kaQ0sMDyDeLFMz8lopiT22u4U8ww3yi1kYJ78u6o+1rt
         YBf3RElJZTVnEYaOWTQFpb5h86pKf7695PWaHejrVUMo3Fy/ypEiZhgCt638bEmhAexX
         AbOi5d1NHlGXvx9NrERYNgY4VTGSTwM2XnDQn3XqgU35NNrZl86FaVgfC9N3xEGuXQmd
         eBeyZqf6ToC1+Td0137Wx1VzD/qyDSvbsWwz75Xybal54uDqk9BirQzTHfxWiIvBJ/kz
         KUDAWokaTcqqMyO+KHCB1eeWH8jDVd1/qg4rIoKMqgfd/A5zxu5QDKlQ88VXECsO0yrk
         2ROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708933955; x=1709538755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPQ+HZG9ZH8pgTa6BFUHg2MQy0OsY1NDbVY61HuOvvM=;
        b=rZvbSfC2oWEeS85ZcXg5aHNMMTJpOpDFWZDhVet/OBoHMIgtGikEvV6zXiAiGkGxxr
         Dz2rr/EfgE62ZhVa5ImczGacWqYlb6Kqk/iqgPgPuPH4ICwxV+JFNaCZKqypWmeCFOK+
         MgmDcyKtY2BFyKJr+GKlARUM09GgSii+0HyZUHJ1yRYMoM9m3PYDCz8zz5la6iv81UA3
         5a+yKUHu4c4OW4WxkQMntQ7/I2TTCSYAIOCjjpG9C4/Em/gf5+AqQ5WEtrA2lxboEu8j
         xh4i9FFEvRDRZx14A0J5jk3NGvTjRsi1bE49+90RtjWQM9ytpkSSXNk1M8En/xlDSxuo
         WggQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmO9NVJGnU5gve/vJ7ahjw1EmO+sFY3iOs2vlZZ9g7VKJ7kmkmPZdDcSxharrl4wgrdtxN0FM4movN/uw4Vh7LXUCE1BcV3+zAf8Xm
X-Gm-Message-State: AOJu0YwUoeL5gPIWTUwo6JlnCm6fCD+n1V82ZK+pyJsgyfQCDtMtka1h
	ULHOQIUzITZYkjzD7uewXERPeYIRC5I7fe9Kexxv/MfIt0AA+6Rh
X-Google-Smtp-Source: AGHT+IFaQ6sNsZyzhrO0DhVowwdLlWEGJHqFGcrFAghi/l+k+EEJbC6GBWulh3qLj9alsBg0etlpBg==
X-Received: by 2002:a5d:528f:0:b0:33d:dd41:674c with SMTP id c15-20020a5d528f000000b0033ddd41674cmr704870wrv.28.1708933954756;
        Sun, 25 Feb 2024 23:52:34 -0800 (PST)
Received: from Ubuntu22.myguest.virtualbox.org ([46.121.140.152])
        by smtp.gmail.com with ESMTPSA id bj20-20020a0560001e1400b0033db0c866f7sm7436968wrb.11.2024.02.25.23.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 23:52:34 -0800 (PST)
Received: by Ubuntu22.myguest.virtualbox.org (sSMTP sendmail emulation); Mon, 26 Feb 2024 09:52:31 +0200
From: Meir Elisha <meir6264@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Meir Elisha <meir6264@gmail.com>
Subject: [PATCH v3] Staging: rtl8723bs: Remove spaces before tabs in rtw_set_auth
Date: Mon, 26 Feb 2024 09:52:25 +0200
Message-Id: <20240226075225.44881-1-meir6264@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove spaces before tabs to improve coding style.

Signed-off-by: Meir Elisha <meir6264@gmail.com>
---
Changes in v3: subject and description changed, revert dead code changes
Changes in v2: remove dead code

 drivers/staging/rtl8723bs/core/rtw_mlme.c | 48 +++++++++++------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 5568215b35bd..5379393349fe 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -169,7 +169,7 @@ void _rtw_free_network(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwor
 {
 	unsigned int delta_time;
 	u32 lifetime = SCANQUEUE_LIFETIME;
-/* 	_irqL irqL; */
+/*	_irqL irqL; */
 	struct __queue *free_queue = &(pmlmepriv->free_bss_pool);
 
 	if (!pnetwork)
@@ -389,7 +389,7 @@ int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst, u8 fea
 	d_cap = le16_to_cpu(tmpd);
 
 	return (src->ssid.ssid_length == dst->ssid.ssid_length) &&
-		/* 	(src->configuration.ds_config == dst->configuration.ds_config) && */
+		/* (src->configuration.ds_config == dst->configuration.ds_config) && */
 			((!memcmp(src->mac_address, dst->mac_address, ETH_ALEN))) &&
 			((!memcmp(src->ssid.ssid, dst->ssid.ssid, src->ssid.ssid_length))) &&
 			((s_cap & WLAN_CAPABILITY_IBSS) ==
@@ -627,11 +627,11 @@ void rtw_add_network(struct adapter *adapter, struct wlan_bssid_ex *pnetwork)
 }
 
 /* select the desired network based on the capability of the (i)bss. */
-/*  check items: (1) security */
-/* 			   (2) network_type */
-/* 			   (3) WMM */
-/* 			   (4) HT */
-/*                      (5) others */
+/* check items: (1) security */
+/* (2) network_type */
+/* (3) WMM */
+/* (4) HT */
+/* (5) others */
 int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwork);
 int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwork)
 {
@@ -1054,9 +1054,9 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 			memset((u8 *)&psta->dot11rxpn, 0, sizeof(union pn48));
 		}
 
-		/* 	Commented by Albert 2012/07/21 */
-		/* 	When doing the WPS, the wps_ie_len won't equal to 0 */
-		/* 	And the Wi-Fi driver shouldn't allow the data packet to be transmitted. */
+		/* Commented by Albert 2012/07/21 */
+		/* When doing the WPS, the wps_ie_len won't equal to 0 */
+		/* And the Wi-Fi driver shouldn't allow the data packet to be transmitted. */
 		if (padapter->securitypriv.wps_ie_len != 0) {
 			psta->ieee8021x_blocked = true;
 			padapter->securitypriv.wps_ie_len = 0;
@@ -1916,10 +1916,10 @@ signed int rtw_set_auth(struct adapter *adapter, struct security_priv *psecurity
 signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, signed int keyid, u8 set_tx, bool enqueue)
 {
 	u8 keylen;
-	struct cmd_obj		*pcmd;
-	struct setkey_parm	*psetkeyparm;
-	struct cmd_priv 	*pcmdpriv = &(adapter->cmdpriv);
-	signed int	res = _SUCCESS;
+	struct cmd_obj *pcmd;
+	struct setkey_parm *psetkeyparm;
+	struct cmd_priv *pcmdpriv = &(adapter->cmdpriv);
+	signed int res = _SUCCESS;
 
 	psetkeyparm = rtw_zmalloc(sizeof(struct setkey_parm));
 	if (!psetkeyparm) {
@@ -2023,8 +2023,8 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 /*  */
 /*  Search by BSSID, */
 /*  Return Value: */
-/* 		-1		:if there is no pre-auth key in the  table */
-/* 		>= 0		:if there is pre-auth key, and   return the entry id */
+/*  -1 :if there is no pre-auth key in the  table */
+/*  >= 0 :if there is pre-auth key, and   return the entry id */
 /*  */
 /*  */
 
@@ -2187,7 +2187,7 @@ void rtw_joinbss_reset(struct adapter *padapter)
 	u8 threshold;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 
 	/* todo: if you want to do something io/reg/hw setting before join_bss, please add code here */
 
@@ -2213,11 +2213,11 @@ void rtw_joinbss_reset(struct adapter *padapter)
 
 void rtw_ht_use_default_setting(struct adapter *padapter)
 {
-	struct mlme_priv 	*pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
-	bool		bHwLDPCSupport = false, bHwSTBCSupport = false;
-	bool		bHwSupportBeamformer = false, bHwSupportBeamformee = false;
+	bool bHwLDPCSupport = false, bHwSTBCSupport = false;
+	bool bHwSupportBeamformer = false, bHwSupportBeamformee = false;
 
 	if (pregistrypriv->wifi_spec)
 		phtpriv->bss_coexist = 1;
@@ -2288,7 +2288,7 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 	u8 cbw40_enable = 0, stbc_rx_enable = 0, operation_bw = 0;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	phtpriv->ht_option = false;
@@ -2417,7 +2417,7 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 	struct ieee80211_ht_cap *pht_capie;
 	/* struct recv_reorder_ctrl *preorder_ctrl; */
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	/* struct recv_priv *precvpriv = &padapter->recvpriv; */
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	/* struct wlan_network *pcur_network = &(pmlmepriv->cur_network);; */
@@ -2546,7 +2546,7 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 void rtw_append_exented_cap(struct adapter *padapter, u8 *out_ie, uint *pout_len)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	u8 cap_content[8] = {0};
 
 	if (phtpriv->bss_coexist)
-- 
2.34.1


