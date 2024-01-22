Return-Path: <linux-kernel+bounces-34016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5888371ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203D11C2A6D6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520DC5FEF9;
	Mon, 22 Jan 2024 18:46:56 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1555FEF6;
	Mon, 22 Jan 2024 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949215; cv=none; b=MfmyLuaRubymCz1aQrAGUUoVnfgfDWkbuAb3gzr466lSVVuxrciLYHdKBrobJ/ChLIVZJGoDG0wyeIqwARgK7F3FWVuz7mfv3ZxKO+6Zf6/NcA6xTJVjGfl+zZInmrJPMa8ZyDx+gLbq4MCUuEO0OhsAr5G4Umrz8E0/XEv4t1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949215; c=relaxed/simple;
	bh=IAO0bq8NdXctB6RwqgtGOmJBnOSHvF6vE6fP+iSwCvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aqZqcBMM+Bd/rm30Z7Hx/s4p19C50XCM+XS+o3J/AlO8S+Qrjw5IF6ogCOxtrkR16gGhKkWKkJ5nRwbnJGZDUbzWu9YTGv81b2/PuHk/W/OSmqjP0rm3cpeyCIyqa+f9hjODmemG4HXR3wZpAThLTVtQ8S8zFyRmvcG5jO0dBOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40eb033c1b0so10258665e9.2;
        Mon, 22 Jan 2024 10:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705949213; x=1706554013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8L91jKcfBzrl91mfEsUSGfI247bF8lCKcDxXU3Y2FQ=;
        b=wNR/SlEr5RGjMmcyACxd2lIgb+XWQ8c3hGylAnW2uvIm511bLxR9phoYDtIcXRi/pJ
         BBjnzyuc1zib25Em/U34CkNYk8FnnrhQL8vcscEsqGNiOPE87+iVlnaL04VIEiQYsOuE
         hhjhEsYWl0bXZihBeswGnxlL/P385kiLn/dfLsUXRcJUby5M/sFBHx+f9CvI47wO30Ug
         5l+aCOve7N8VGlrHJrvaFStlHYVnVh8Q1BudNByF+BkAsGtDYLJ6nQ6PBQ+M/ECI2Opr
         MhD79hjuAy+mDXYthJYEEyJY5ANYEJ/WZ9oWvNhhlA87H7e5QkCqwkttJ5NEqA8DmoZA
         oSSw==
X-Gm-Message-State: AOJu0YxgfUlnRc3hpGFtbNye7IkaihO4beX/jnYOhHw5gTpAnVKnoyKv
	tD2il2Egyc9IT4D/9vC6nx3zcQmM6Fc5FhOAJJS8xdgZT7bLsJqz2Ux3hbKKfKelKP6F
X-Google-Smtp-Source: AGHT+IH/O7nLFDu84MSARdAiREs6OT2VjJKlGW+5Khnt3SRfKZTSv/sMi7bxzjtryHUpGJISsKn7Bw==
X-Received: by 2002:a05:600c:340a:b0:40e:5d36:8bba with SMTP id y10-20020a05600c340a00b0040e5d368bbamr2568049wmp.44.1705949212649;
        Mon, 22 Jan 2024 10:46:52 -0800 (PST)
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id x27-20020a170906299b00b00a2c0fec4240sm13694877eje.158.2024.01.22.10.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:46:52 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	abeni@redhat.com,
	edumazet@google.com,
	Arend van Spriel <aspriel@gmail.com>,
	Franky Lin <franky.lin@broadcom.com>,
	Hante Meuleman <hante.meuleman@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	linux-wireless@vger.kernel.org (open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER),
	brcm80211-dev-list.pdl@broadcom.com (open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 17/22] net: fill in MODULE_DESCRIPTION()s for Broadcom WLAN
Date: Mon, 22 Jan 2024 10:45:38 -0800
Message-Id: <20240122184543.2501493-18-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240122184543.2501493-1-leitao@debian.org>
References: <20240122184543.2501493-1-leitao@debian.org>
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
index d55f3271d619..c1f91dc151c2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
@@ -20,6 +20,7 @@ static void __exit brcmf_bca_exit(void)
 	brcmf_fwvid_unregister_vendor(BRCMF_FWVENDOR_BCA, THIS_MODULE);
 }
 
+MODULE_DESCRIPTION("Broadcom FullMAC WLAN BCA driver");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_IMPORT_NS(BRCMFMAC);
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c
index f82fbbe3ecef..09fadfc147f1 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c
@@ -20,6 +20,7 @@ static void __exit brcmf_cyw_exit(void)
 	brcmf_fwvid_unregister_vendor(BRCMF_FWVENDOR_CYW, THIS_MODULE);
 }
 
+MODULE_DESCRIPTION("Broadcom FullMAC WLAN CYW driver");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_IMPORT_NS(BRCMFMAC);
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c
index 02918d434556..54426a80e2c8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c
@@ -20,6 +20,7 @@ static void __exit brcmf_wcc_exit(void)
 	brcmf_fwvid_unregister_vendor(BRCMF_FWVENDOR_WCC, THIS_MODULE);
 }
 
+MODULE_DESCRIPTION("Broadcom FullMAC WLAN WCC driver");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_IMPORT_NS(BRCMFMAC);
 
-- 
2.39.3


