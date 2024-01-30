Return-Path: <linux-kernel+bounces-44411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE148421BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D58C1C25A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A497567A05;
	Tue, 30 Jan 2024 10:43:55 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85860679FF;
	Tue, 30 Jan 2024 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611435; cv=none; b=sB3L8dkGAnbWXtKPcOg2ZOj1ff12rf5MfFpMLnEPLm8nU8t0lrnhKNYLqgzhdVpLydfa6QNNk51z4VHkoPpmyFGW/LrUZOcJhhsStjtKzzaER3hSJFfuUls2v0DlNEx9e4l2Aphmq1gUsNuNtv94jzwD8yMxit5Qm1+jV2TfsMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611435; c=relaxed/simple;
	bh=6/zPyHCjOysxp4BceH7lIBdERxHNJ7sl55MbOWKAdxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FBbH69PJpwooI/6QjxzrfqWL/cSqhAUImadX/MYJvV9KlDJ8rlG5n6QBRmHJfrll/iVjdR7MedFd/oJEFDU2C3cmRZFRTZld3rxjCt4+8z2d9AMGSU/mMi/WZNST7LUt4qTtR924P4RRDBmZtScG7oE3uuLKBz+SiDHw9PvtEs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55ad2a47b7aso3881722a12.3;
        Tue, 30 Jan 2024 02:43:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706611431; x=1707216231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGidONtgTcC3mg8Z/dch3MAVxBE6VowMMnHBLOSFwMk=;
        b=PjgthwNbIFotOwlHjmNrFNygOXgJhiEoxII6ZGFXsxCDw7CUjepRoc56cORmrFdSXm
         JuO5ShbaFKrQyejxtSoK3r4dqLbodQF9SPOLOd2L92gKO6fv8fvz4QPGfZYBytGI+aDf
         mCD/EajwXmpgRTyCxR4GUC8B3CYDTLsbQErU0Kl4n78FAqzJFYDkSwRWBivYlwv0+ing
         WLcJ4LHthFiOAD9CUIZdTQeStpdE962TVMi5JcXwsJPDNZkbT/ncpp9Fx2uG8uCCbUlg
         xs9rMTeLctBYpJkxDDkgNxKuE3nPr6qPgRSYIZZWMblTR8oRWaKy7I82jkFjz+RabuCD
         wI7Q==
X-Gm-Message-State: AOJu0YwKUNRss5zy+yrI6sHnBzbd4L/DeST0snp0bhcLLUv1N3lHf3sU
	cA4sBS3WpzgZA3lW9D+Bko+rGEWpa7FqfqoGVqMAVguLaKkAJH8GpTgTZ6sTz7un0w==
X-Google-Smtp-Source: AGHT+IHkquS72S+Pdcn0a5QgpEJo3OIgZ/1TfW5RBqrbBNa8Z+6bTh/xcXowMwU3c1LsPaZLswFXJg==
X-Received: by 2002:a17:906:1b09:b0:a27:6e73:a248 with SMTP id o9-20020a1709061b0900b00a276e73a248mr5598302ejg.68.1706611431610;
        Tue, 30 Jan 2024 02:43:51 -0800 (PST)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id ti12-20020a170907c20c00b00a360eb62afdsm822894ejc.32.2024.01.30.02.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:43:51 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Arend van Spriel <aspriel@gmail.com>,
	Franky Lin <franky.lin@broadcom.com>,
	Hante Meuleman <hante.meuleman@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	andrew@lunn.ch,
	leit@fb.com,
	linux-wireless@vger.kernel.org (open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER),
	brcm80211-dev-list.pdl@broadcom.com (open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER)
Subject: [PATCH net 3/9] wifi: fill in MODULE_DESCRIPTION()s for Broadcom WLAN
Date: Tue, 30 Jan 2024 02:42:37 -0800
Message-Id: <20240130104243.3025393-4-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240130104243.3025393-1-leitao@debian.org>
References: <20240130104243.3025393-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the Broadcom FullMac WLAN drivers.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c | 1 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c | 1 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
index d55f3271d619..4f0c1e1a8e60 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
@@ -20,6 +20,7 @@ static void __exit brcmf_bca_exit(void)
 	brcmf_fwvid_unregister_vendor(BRCMF_FWVENDOR_BCA, THIS_MODULE);
 }
 
+MODULE_DESCRIPTION("Broadcom FullMAC WLAN driver plugin for Broadcom AP chipsets");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_IMPORT_NS(BRCMFMAC);
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c
index f82fbbe3ecef..90d06cda03a2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c
@@ -20,6 +20,7 @@ static void __exit brcmf_cyw_exit(void)
 	brcmf_fwvid_unregister_vendor(BRCMF_FWVENDOR_CYW, THIS_MODULE);
 }
 
+MODULE_DESCRIPTION("Broadcom FullMAC WLAN driver plugin for Cypress/Infineon chipsets");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_IMPORT_NS(BRCMFMAC);
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c
index 02918d434556..b66135e3cff4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c
@@ -20,6 +20,7 @@ static void __exit brcmf_wcc_exit(void)
 	brcmf_fwvid_unregister_vendor(BRCMF_FWVENDOR_WCC, THIS_MODULE);
 }
 
+MODULE_DESCRIPTION("Broadcom FullMAC WLAN driver plugin for Broadcom mobility chipsets");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_IMPORT_NS(BRCMFMAC);
 
-- 
2.39.3


