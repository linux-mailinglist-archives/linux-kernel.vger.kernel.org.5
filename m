Return-Path: <linux-kernel+bounces-18497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFBE825E61
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51A98B23412
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 05:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D74C8829;
	Sat,  6 Jan 2024 05:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="C94NzbNr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1B56FD0
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 05:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6d9b13fe9e9so256570b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 21:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1704520574; x=1705125374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StnyJgFOT64M/Chcxu97Xz0SNkYawN5oNQ23pftyJ9s=;
        b=C94NzbNrPvmjl85S1R9JieHfjjFe0WSRy46EtW8Sd8PRtGWP1YLLIKeqXYO423V5D/
         bUgAsItzmcX5JtyUPeGpHy9EMgnNed7fEGzP/5qS6OPHb8upc2KH8REIU3MKzKsZ/d71
         GeaUPs0MYye4PAgds1OxI4Ud2h5sRHzf3yCm8fyVLR/uMyUbE3R462+Vf3pigutKOoKv
         9butqaRKl8Jyrlfe5SRcMrUr20cS8oeVSCowait3iUDMmAWk3bfSih+X7OTUPdgAd2xt
         sFrYShtf5rbegAovRMaw0xomXWok7pG2+iIFBHBSUn9YOYSVhjmJclUQ6ES70e5x/ZuP
         RvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704520574; x=1705125374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StnyJgFOT64M/Chcxu97Xz0SNkYawN5oNQ23pftyJ9s=;
        b=Ij2YcUw/pOjP4WPajpW8LMN8SO43IK4pOeSaYrzHIxVphJVd6gVMon52zNeaRqPGWo
         +VVK5rh0UKOel4pgy98y/977cHRg3tasgvkf1fjLNhah+DcsgldPwGM8s0SQVT7lnn+N
         x37CVXsAOUEl+rmozW1rhVW3wzubdb9SZHueeMx/8hHr+cgoQlP4DH7EiOP/ugEjg6R6
         TXXMWZsxhKsALOpuGj7VktJMSKax4QgCgmHWdUzk72vNdDrpXjJj5YcCi+gPjggcppbr
         Oza8xj4+OD84Wmpce/cHMlxuelOWmaxdQ72372d+O/1ALQnTw96Tp+0zKk7ze/jQf/Xs
         5TZg==
X-Gm-Message-State: AOJu0YyChG/DH9IOC4Zq/QwCzDgVc3S7Tixok+1YpOZr6+ZNs5hQY4xf
	bbAccTlCUasp+rYTir4uMJJlTTItXP1OnA==
X-Google-Smtp-Source: AGHT+IGHYzKL2jjs5bDEPHvlZnNLlDRAvqneSLlW81rUavWMoEaQa5Y5vl6ZtMdPyhiTa7dNbPhKyQ==
X-Received: by 2002:a05:6a00:4e57:b0:6d9:b320:94c9 with SMTP id gu23-20020a056a004e5700b006d9b32094c9mr540868pfb.33.1704520573848;
        Fri, 05 Jan 2024 21:56:13 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id y29-20020a056a00181d00b006d99d986624sm2280873pfa.151.2024.01.05.21.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 21:56:13 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 07/21] Staging: rtl8192e: Rename variable bSupportNmode
Date: Fri,  5 Jan 2024 21:55:42 -0800
Message-Id: <20240106055556.430948-8-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240106055556.430948-1-tdavies@darkphysics.net>
References: <20240106055556.430948-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bSupportNmode to support_nmode to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 08ff55c2f1be..85e6e727bec7 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1648,7 +1648,7 @@ static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
 	int errcode;
 	u8 *challenge;
 	int chlen = 0;
-	bool bSupportNmode = true, bHalfSupportNmode = false;
+	bool support_nmode = true, bHalfSupportNmode = false;
 
 	errcode = auth_parse(ieee->dev, skb, &challenge, &chlen);
 
@@ -1666,16 +1666,16 @@ static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
 		if (!(ieee->ht_info->iot_action & HT_IOT_ACT_PURE_N_MODE)) {
 			if (!ieee->GetNmodeSupportBySecCfg(ieee->dev)) {
 				if (is_ht_half_nmode_aps(ieee)) {
-					bSupportNmode = true;
+					support_nmode = true;
 					bHalfSupportNmode = true;
 				} else {
-					bSupportNmode = false;
+					support_nmode = false;
 					bHalfSupportNmode = false;
 				}
 			}
 		}
 		/* Dummy wirless mode setting to avoid encryption issue */
-		if (bSupportNmode) {
+		if (support_nmode) {
 			ieee->set_wireless_mode(ieee->dev,
 					      ieee->current_network.mode);
 		} else {
-- 
2.39.2


