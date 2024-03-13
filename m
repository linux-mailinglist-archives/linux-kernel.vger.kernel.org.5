Return-Path: <linux-kernel+bounces-101374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E31E87A642
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14DB01F224E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2EB3E47A;
	Wed, 13 Mar 2024 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PX5DDYBO"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F4E3B798
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327513; cv=none; b=t8VHZybfGIDorhMQVbNcGY0oJquNlGF0qiUZmPouHxl0pWu28cUEm52nRNThC82PvvN1e1MbqMM0AZQVSLmzq+9nnbswjEIscTtGTkdQ9LtxvzVnXB4UM8P4T+de12GvpKRRJUsqLdLtEZia6hXg6duxaC0b6ad/+zYg7MFHdNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327513; c=relaxed/simple;
	bh=GQzWZxCfHS0uKq1KU0iHmiPNc54xlpTgQpONYUeXORo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=prymg2bFim0nYWaKDCSwk6r9s8DyO4pGxnejZ3QX7DPkRP2RFp2Kt65q3noc2YEPrpEV3RWUy2G9PKDg/MWuT2FxwQNqKsDoc436aGjzw3OYkRx+qGws3CfpFMvfNqLJfBtWYrs8Qa7OsPfPZoTmUbV6m1EwnuQ1sHti6NR/fbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PX5DDYBO; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33e7946bddfso3771211f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 03:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710327511; x=1710932311; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IdUl28bu6wuHS6E18fGArN7xnZx8OvKOOgXrVCy3z4g=;
        b=PX5DDYBOq/D987jz6bwS3XIHkffDp7AUMl02zVzBQTGHDfF0Ns/UAqvL4Y9t2vl+RB
         tXZIrz0tMG7ltpuAPjWOTmrBVzmLYUNsbwR+DV4s3Vh2ySpzXqcOQ4UDNPY5VNEZfPd+
         9GrRMhNgUAOfCGBU+eNXqJMsN/msxFqNZQk5QfaFTXiCJC3Khff5rgy2iWJiHsmUTo1t
         L6Mj/GSsWdtkLqhSi+strnLk//I4m3ebZkT0JAKHRuLOa5SgVsPdsE/dHF8ToXB2yUEd
         5t+iF5ptU4lUTrI0Xz50+2mPxbRPkgX8LgpzBNkl1Uvu30OnDApnxwJkdc6U6kVW9n9f
         S+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710327511; x=1710932311;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IdUl28bu6wuHS6E18fGArN7xnZx8OvKOOgXrVCy3z4g=;
        b=OHiMVL0IrAyLd1XBrsaXOfEZHvpyC4UK3iCtH0ODS01dP9tmAzOWK5helYfNaGSVIb
         nhbkbcGu4Z06v/jDl7aZonLHQZeg4v+LPrI12UZkMpM9J/CCo9Ly55BcaWab4zpgf54b
         GT0BzCUJwWi1yXfAfudpbqeNaqlBO/qjeI08PmMBDbMpmfZhOgWKka5UY6zsyWsdqT+9
         9K05xgZN+wV7ed8rB75ZxJISG/oewxbr8q0/O4ifunuj6DXVPmcfUTM1bi0l99Dg02f6
         0NM+o5azhi5o2eMC3nJm0ap50NjLO7D6Y3knS/I+11LVxA3B3cT7sXdkzX0S8VavFxEh
         rDUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcNi7YnGKImjzuFkUOVraSPlsNes8CQrd5AOphoMOJa5JDX1DToUNiqTfKxbalGZX/O4afwm5tcV4VpCFma1Ity7LJwXIAHBoVhKTo
X-Gm-Message-State: AOJu0YwDTRDF9wJebgODr/m+ottpF+rYA5Z/Lmqp4j1/vtA13YeCOS0R
	ud/xb5B+59J3VkJ/YaM0I/r0TcwI2hWFzqH7IwYBdLmVwoTzZ3LE
X-Google-Smtp-Source: AGHT+IEB9UHcDIQ78guLQDf4AJj6xGqrC/YEpz8y0KYTa/Omd/1dnJn0o6WN5Cnnql4aLdNJ2NhtwQ==
X-Received: by 2002:a5d:6845:0:b0:33d:c3e6:109d with SMTP id o5-20020a5d6845000000b0033dc3e6109dmr1589334wrw.61.1710327510417;
        Wed, 13 Mar 2024 03:58:30 -0700 (PDT)
Received: from MOLeToid ([129.0.78.232])
        by smtp.gmail.com with ESMTPSA id d9-20020adf9c89000000b0033df46f70dbsm11597015wre.9.2024.03.13.03.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 03:58:30 -0700 (PDT)
Date: Wed, 13 Mar 2024 11:58:27 +0100
From: "Felix N. Kimbu" <felixkimbu1@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: outreachy@lists.linux.dev
Subject: [PATCH] staging: wlan-ng: Rename 'wlan_unsetup' to 'wlan_teardown'
Message-ID: <ZfGG093fyjI4G/ci@MOLeToid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Rename function identifier 'wlan_unsetup' to 'wlan_teardown' in files
p80211netdev.c, p80211netdev.h and prism2usb.c, a pairing function for
'wlan_setup' to match common kernel coding style.

Signed-off-by: Felix N. Kimbu <felixkimbu1@gmail.com>
---
 drivers/staging/wlan-ng/p80211netdev.c | 4 ++--
 drivers/staging/wlan-ng/p80211netdev.h | 2 +-
 drivers/staging/wlan-ng/prism2usb.c    | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
index 8634fc89a6c2..284c1c12e1d1 100644
--- a/drivers/staging/wlan-ng/p80211netdev.c
+++ b/drivers/staging/wlan-ng/p80211netdev.c
@@ -689,7 +689,7 @@ int wlan_setup(struct wlandevice *wlandev, struct device *physdev)
 }
 
 /*----------------------------------------------------------------
- * wlan_unsetup
+ * wlan_teardown
  *
  * This function is paired with the wlan_setup routine.  It should
  * be called after unregister_wlandev.  Basically, all it does is
@@ -708,7 +708,7 @@ int wlan_setup(struct wlandevice *wlandev, struct device *physdev)
  *	context of the kernel startup code.
  *----------------------------------------------------------------
  */
-void wlan_unsetup(struct wlandevice *wlandev)
+void wlan_teardown(struct wlandevice *wlandev)
 {
 	struct wireless_dev *wdev;
 
diff --git a/drivers/staging/wlan-ng/p80211netdev.h b/drivers/staging/wlan-ng/p80211netdev.h
index 485f2c697f5f..e3eefb67aae1 100644
--- a/drivers/staging/wlan-ng/p80211netdev.h
+++ b/drivers/staging/wlan-ng/p80211netdev.h
@@ -204,7 +204,7 @@ int wep_encrypt(struct wlandevice *wlandev, u8 *buf, u8 *dst, u32 len,
 		int keynum, u8 *iv, u8 *icv);
 
 int wlan_setup(struct wlandevice *wlandev, struct device *physdev);
-void wlan_unsetup(struct wlandevice *wlandev);
+void wlan_teardown(struct wlandevice *wlandev);
 int register_wlandev(struct wlandevice *wlandev);
 int unregister_wlandev(struct wlandevice *wlandev);
 void p80211netdev_rx(struct wlandevice *wlandev, struct sk_buff *skb);
diff --git a/drivers/staging/wlan-ng/prism2usb.c b/drivers/staging/wlan-ng/prism2usb.c
index 0e0ccef4871e..416127e5d713 100644
--- a/drivers/staging/wlan-ng/prism2usb.c
+++ b/drivers/staging/wlan-ng/prism2usb.c
@@ -128,7 +128,7 @@ static int prism2sta_probe_usb(struct usb_interface *interface,
 failed_register:
 	usb_put_dev(dev);
 failed_reset:
-	wlan_unsetup(wlandev);
+	wlan_teardown(wlandev);
 failed:
 	kfree(wlandev);
 	kfree(hw);
@@ -208,7 +208,7 @@ static void prism2sta_disconnect_usb(struct usb_interface *interface)
 
 		/* Unhook the wlandev */
 		unregister_wlandev(wlandev);
-		wlan_unsetup(wlandev);
+		wlan_teardown(wlandev);
 
 		usb_put_dev(hw->usb);
 
-- 
2.34.1


