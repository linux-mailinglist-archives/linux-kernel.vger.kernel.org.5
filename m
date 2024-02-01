Return-Path: <linux-kernel+bounces-48287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB0A84599D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46E71F236EC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8936F6215F;
	Thu,  1 Feb 2024 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NA2NhwM3"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29D45F468
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796318; cv=none; b=t7cEa4nEY0A+Dk69CAyKk9F8s9D+pc825XFBse9TnNZPil9gozcq3g8sCF43iE+KwzfhyGhjFPVTjitWMhxoQyh+gWnhAY6wOwmlB2HRf44NRrbswtb8gqeOh22HzviOepyD/kYFH4nEY+toWC/+GPmibtM3rtnhbUmHbWLhcIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796318; c=relaxed/simple;
	bh=S7eCi4dmp4U/oslPvMevXeGz/cIPZTfZBrTIN/zvD8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QgkCE0YOSohR4+DR3BROmUzrIyIF8DSBl11yDptfi4oRnsFPYNtWokHM1tLDLGefoscjGvlByEXkoLX8zDRtTNRgkriekO1yDRr9IB0PqcKaBqbQHto3Gsnpxmxk/1i360PnVZZlbIxdlJbs/XIrZ6TraWhKw9DW4FRStBf+VII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NA2NhwM3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e76626170so8384595e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 06:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706796315; x=1707401115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ctDN3byxe4TbH3N9GmMLJ2KHRNsvXbEW2nKhaJo2sU=;
        b=NA2NhwM3HOaN/W+DQHZcl7gdbANmXgYMPrtpK6WNrrXDPrrn5DztS/w7Ff1hOjpRI0
         RryvTsbmxMQgF9BnknuBECYuXnzchWme6LzkK+TL3ZxRKyj2SDHlc/TDGuL0p77WR+q2
         pf/u5vGDrDuBfP1tbJEhdsWRvY4uvhgS7G6gIV480i1M3OjLW4nVpfn5aPjVW2VqDs3u
         WSAsklRxG7C8pUrn3R3F00a3cO3u7+iavZvv53i4u83JKGXv/3xS5S40a69FJ3GqK0Fs
         wAkjybRsfXCxBEeRuvzgWrVnZHjWiW0b+Z1Xv0OVY/JBg15SzCjiXbvrqgkJQfzdTEEr
         JvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706796315; x=1707401115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ctDN3byxe4TbH3N9GmMLJ2KHRNsvXbEW2nKhaJo2sU=;
        b=a9DPPzgx/NQFBR//2cpu/lHuUjafH1cU5z75f6RhEx5FWwy9+cBqkRqm/RzJwoz7OY
         vSJqHQZ89GcxVEzXwrA6yLmTDDHKw7/CmiZzbfJRWOqSJv4noRg74SWBkFJLN/NS2cWA
         FgL97n9d8FsvUOImeIlNG9BTQulQRTO4VTtHsfpJTR9nnqc8e4inZk1HV58MOKXYHKK9
         QMb501PTvwaM1KRX2AtuBY3NnaIsE4Pt0WZYlZTvbEAfIy336vUH8qdOn5qWhddjw2Nu
         A36oLdqLze4ZQe282dDm3vJwwNyr6SLQaw5to42FwOwAf0egf/I+Br8beX/E/kS9hNX9
         K7Mw==
X-Gm-Message-State: AOJu0YwX0zdkILTySLv6CIgxfjFCCSka0BMwIjX2Z3iYy6vaeU5Coc9X
	Py+hyRe6iG7MXPIlv2F94+AtQBniflHqQco4NK6qZ/MvBJnX6mnY
X-Google-Smtp-Source: AGHT+IEXi9tX5unokNuh16s/KYwEPKhbuRykkYd3MrJtVY7KRUCOQfmSgyKMi3qMbKjpGWaEsHcbbg==
X-Received: by 2002:a5d:6112:0:b0:339:feca:9428 with SMTP id v18-20020a5d6112000000b00339feca9428mr3439111wrt.40.1706796314749;
        Thu, 01 Feb 2024 06:05:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXMLL8N2G164AOa72Vj3ESqzjabvtFtZPUSYj/K9q8fFq22DPTxYsvCcZA37k4qOxUmRA4ejMyjygzIpq+3pphdijnBaTthWqtnbUXLLS0AGxAU2IkSl6A+XSsTaDkg4RP2gXKixKxA9HCMJYzuNAmWIp100dG1HLjTrDqfz5tsY+714YyUf93TD01rNQFF44AMNr7Tv0u8j6FnwE4B9eO5af4acnTJ
Received: from Ubuntu22.myguest.virtualbox.org ([46.121.140.152])
        by smtp.gmail.com with ESMTPSA id bt3-20020a056000080300b0033ae6fa7f20sm13467563wrb.65.2024.02.01.06.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 06:05:14 -0800 (PST)
From: Meir Elisha <meir6264@gmail.com>
X-Google-Original-From: Meir Elisha <meir6264@Gmail.com>
Received: by Ubuntu22.myguest.virtualbox.org (sSMTP sendmail emulation); Thu, 01 Feb 2024 16:05:11 +0200
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Meir Elisha <meir6264@Gmail.com>
Subject: [PATCH v2 3/4] Staging: rtl8723bs: Fix block comments warning
Date: Thu,  1 Feb 2024 16:04:58 +0200
Message-Id: <20240201140459.438479-4-meir6264@Gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201140459.438479-1-meir6264@Gmail.com>
References: <20240201140459.438479-1-meir6264@Gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix checkpatch warning: Block comments use * on subsequent lines

Signed-off-by: Meir Elisha <meir6264@Gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 121 +++++++---------------
 1 file changed, 38 insertions(+), 83 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 44b77c1ba992..13bc0ebca247 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -109,32 +109,6 @@ void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 	}
 }
 
-/*
-struct	wlan_network *_rtw_dequeue_network(struct __queue *queue)
-{
-	_irqL irqL;
-
-	struct wlan_network *pnetwork;
-
-	spin_lock_bh(&queue->lock);
-
-	if (list_empty(&queue->queue))
-
-		pnetwork = NULL;
-
-	else
-	{
-		pnetwork = container_of(get_next(&queue->queue), struct wlan_network, list);
-
-		list_del_init(&(pnetwork->list));
-	}
-
-	spin_unlock_bh(&queue->lock);
-
-	return pnetwork;
-}
-*/
-
 struct	wlan_network *rtw_alloc_network(struct	mlme_priv *pmlmepriv)
 {
 	struct	wlan_network	*pnetwork;
@@ -217,10 +191,9 @@ void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *
 }
 
 /*
-	return the wlan_network with the matching addr
-
-	Shall be called under atomic context... to avoid possible racing condition...
-*/
+ * return the wlan_network with the matching addr *
+ * Shall be called under atomic context... to avoid possible racing condition...
+ */
 struct wlan_network *_rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 {
 	struct list_head	*phead, *plist;
@@ -320,15 +293,6 @@ void rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 	_rtw_free_mlme_priv(pmlmepriv);
 }
 
-/*
-static struct	wlan_network *rtw_dequeue_network(struct __queue *queue)
-{
-	struct wlan_network *pnetwork;
-
-	pnetwork = _rtw_dequeue_network(queue);
-	return pnetwork;
-}
-*/
 
 void rtw_free_network_nolock(struct adapter *padapter, struct wlan_network *pnetwork);
 void rtw_free_network_nolock(struct adapter *padapter, struct wlan_network *pnetwork)
@@ -338,10 +302,9 @@ void rtw_free_network_nolock(struct adapter *padapter, struct wlan_network *pnet
 }
 
 /*
-	return the wlan_network with the matching addr
-
-	Shall be called under atomic context... to avoid possible racing condition...
-*/
+ * return the wlan_network with the matching addr
+ * Shall be called under atomic context... to avoid possible racing condition...
+ */
 struct	wlan_network *rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 {
 	struct	wlan_network *pnetwork = _rtw_find_network(scanned_queue, addr);
@@ -501,8 +464,8 @@ static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex
 }
 
 /*
-Caller must hold pmlmepriv->lock first.
-*/
+ * Caller must hold pmlmepriv->lock first.
+ */
 void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *target)
 {
 	struct list_head	*plist, *phead;
@@ -536,12 +499,11 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 	}
 
 	/* If we didn't find a match, then get a new network slot to initialize
-	 * with this beacon's information */
-	/* if (phead == plist) { */
+	 * with this beacon's information
+	 */
 	if (!target_find) {
 		if (list_empty(&pmlmepriv->free_bss_pool.queue)) {
 			/* If there are no more slots, expire the oldest */
-			/* list_del_init(&oldest->list); */
 			pnetwork = oldest;
 			if (!pnetwork)
 				goto exit;
@@ -880,8 +842,8 @@ static void find_network(struct adapter *adapter)
 }
 
 /*
-*rtw_free_assoc_resources: the caller has to lock pmlmepriv->lock
-*/
+ * rtw_free_assoc_resources: the caller has to lock pmlmepriv->lock
+ */
 void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 {
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
@@ -916,8 +878,8 @@ void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 }
 
 /*
-*rtw_indicate_connect: the caller has to lock pmlmepriv->lock
-*/
+ * rtw_indicate_connect: the caller has to lock pmlmepriv->lock
+ */
 void rtw_indicate_connect(struct adapter *padapter)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -937,8 +899,8 @@ void rtw_indicate_connect(struct adapter *padapter)
 }
 
 /*
-*rtw_indicate_disconnect: the caller has to lock pmlmepriv->lock
-*/
+ * rtw_indicate_disconnect: the caller has to lock pmlmepriv->lock
+ */
 void rtw_indicate_disconnect(struct adapter *padapter)
 {
 	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -1522,9 +1484,9 @@ void rtw_wmm_event_callback(struct adapter *padapter, u8 *pbuf)
 }
 
 /*
-* _rtw_join_timeout_handler - Timeout/failure handler for CMD JoinBss
-* @adapter: pointer to struct adapter structure
-*/
+ * _rtw_join_timeout_handler - Timeout/failure handler for CMD JoinBss
+ * @adapter: pointer to struct adapter structure
+ */
 void _rtw_join_timeout_handler(struct timer_list *t)
 {
 	struct adapter *adapter = from_timer(adapter, t,
@@ -1566,9 +1528,9 @@ void _rtw_join_timeout_handler(struct timer_list *t)
 }
 
 /*
-* rtw_scan_timeout_handler - Timeout/Failure handler for CMD SiteSurvey
-* @adapter: pointer to struct adapter structure
-*/
+ * rtw_scan_timeout_handler - Timeout/Failure handler for CMD SiteSurvey
+ * @adapter: pointer to struct adapter structure
+ */
 void rtw_scan_timeout_handler(struct timer_list *t)
 {
 	struct adapter *adapter = from_timer(adapter, t,
@@ -1686,10 +1648,10 @@ void rtw_set_scan_deny(struct adapter *adapter, u32 ms)
 }
 
 /*
-* Select a new roaming candidate from the original @param candidate and @param competitor
-* @return true: candidate is updated
-* @return false: candidate is not updated
-*/
+ * Select a new roaming candidate from the original @param candidate and @param competitor
+ * @return true: candidate is updated
+ * @return false: candidate is not updated
+ */
 static int rtw_check_roaming_candidate(struct mlme_priv *mlme
 	, struct wlan_network **candidate, struct wlan_network *competitor)
 {
@@ -1769,12 +1731,13 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 }
 
 /*
-* Select a new join candidate from the original @param candidate and @param competitor
-* @return true: candidate is updated
-* @return false: candidate is not updated
-*/
-static int rtw_check_join_candidate(struct mlme_priv *mlme
-	, struct wlan_network **candidate, struct wlan_network *competitor)
+ * Select a new join candidate from the original @param candidate and @param competitor
+ * @return true: candidate is updated
+ * @return false: candidate is not updated
+ */
+static int rtw_check_join_candidate(struct mlme_priv *mlme,
+				    struct wlan_network **candidate,
+				    struct wlan_network *competitor)
 {
 	int updated = false;
 	struct adapter *adapter = container_of(mlme, struct adapter, mlmepriv);
@@ -1813,11 +1776,11 @@ static int rtw_check_join_candidate(struct mlme_priv *mlme
 }
 
 /*
-Calling context:
-The caller of the sub-routine will be in critical section...
-The caller must hold the following spinlock
-pmlmepriv->lock
-*/
+ * Calling context:
+ * The caller of the sub-routine will be in critical section...
+ * The caller must hold the following spinlock
+ * pmlmepriv->lock
+ */
 
 int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 {
@@ -2084,14 +2047,6 @@ signed int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, u
 	} else if ((authmode == WLAN_EID_VENDOR_SPECIFIC) || (authmode == WLAN_EID_RSN)) {
 		/* copy RSN or SSN */
 		memcpy(&out_ie[ielength], &psecuritypriv->supplicant_ie[0], psecuritypriv->supplicant_ie[1]+2);
-		/* debug for CONFIG_IEEE80211W
-		{
-			int jj;
-			printk("supplicant_ie_length =%d &&&&&&&&&&&&&&&&&&&\n", psecuritypriv->supplicant_ie[1]+2);
-			for (jj = 0; jj < psecuritypriv->supplicant_ie[1]+2; jj++)
-				printk(" %02x ", psecuritypriv->supplicant_ie[jj]);
-			printk("\n");
-		}*/
 		ielength += psecuritypriv->supplicant_ie[1]+2;
 		rtw_report_sec_ie(adapter, authmode, psecuritypriv->supplicant_ie);
 	}
-- 
2.34.1


