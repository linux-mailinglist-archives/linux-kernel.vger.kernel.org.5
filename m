Return-Path: <linux-kernel+bounces-18506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6920825E6A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 07:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F9728327A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2764510967;
	Sat,  6 Jan 2024 05:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Dr0aCyg0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55458101E9
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 05:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cdfed46372so191291a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 21:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1704520582; x=1705125382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YazXYBV00NUviHMUP5diek19QFt20KFYBc0SM+UoYHc=;
        b=Dr0aCyg0e6eRyi5CHYPU64Iz44prSjOZu/TbFN3RDpjOaFPBeoWhbXitqQ2J9Jvn+9
         imcf2opq2FIMOSUBUisQAoQ8Bat4nq+aWyWnkl8u+7sq4qnRBLuWG7fbY6nUfCUbbrdA
         jRrJX7uwbTxe2t9eDSHwXVKQyZYjaW4Ha6vED7ZN2kmqYg0980CJkhDaqKEFEfGwbtH/
         OJ4M+glXF6XSvZ/FPqlWlgbF5eeNT2KFldSi/fg22mtmInxO0KhelBfLQkOBosmAwF3x
         ZvTlWbB/4PPpqwJvRy6aUr0TwzkX0MAGqlQFEOa+QnQIhoOEUdpLJYVXLLTBNr/4+o2n
         d5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704520582; x=1705125382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YazXYBV00NUviHMUP5diek19QFt20KFYBc0SM+UoYHc=;
        b=KmFycAQGEdvnvtN0P+Emy5JdMgNRrsgbAOq5ckAczoEGMcdGVDlP+ueZGI9XDITl4D
         8sH1HQN9IOjgXlEGILnOkKS8tw/ziSUuI0RZTOAjVtJsBzxQhDA1Nhf+CRqlJNWjQTDw
         bk0ypAZXJyyRJD1rVb1d3XuDdZABXYPerW2BJ4QI5mKnzbur1AzGphIV/2UrG+sxQEqk
         kTOyfWPUMtYLIdo/oNY7TrqJdWrY3rkedq4zm2oN+yQ6g+ubR2hIq1sIM98RFWzUU6Ap
         DDfdG+01bROUCb0u0Z/LFVnRpGgkw4Un9dn0YMosJ4bjNQpUb/K78dS9BE49Atl0vRvf
         p8Jg==
X-Gm-Message-State: AOJu0YyP0K5o4oYtXldxkF1fHptqDmX9VzXlhMshYDJ2FCLymMxNnMfy
	tB7M/Ud4cKiDbW+roMNMlbpbuQfV+YmtIUtRunS/Y+GoI5s=
X-Google-Smtp-Source: AGHT+IFI4X4pVxc+VC1ljTNtP3J9gSJFFVFxxspE37j1jX/QVdxXH5sxzF19R7+HEDqXq4qnLjxIQQ==
X-Received: by 2002:a05:6a20:840f:b0:196:8a96:e558 with SMTP id c15-20020a056a20840f00b001968a96e558mr607247pzd.92.1704520581816;
        Fri, 05 Jan 2024 21:56:21 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id y29-20020a056a00181d00b006d99d986624sm2280873pfa.151.2024.01.05.21.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 21:56:21 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 16/21] Staging: rtl8192e: Rename function rtllib_MlmeDisassociateRequest()
Date: Fri,  5 Jan 2024 21:55:51 -0800
Message-Id: <20240106055556.430948-17-tdavies@darkphysics.net>
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

Rename function rtllib_MlmeDisassociateRequest to
rtllib_mlme_disassociate_request to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index ff43697768cb..7c5056f9f6f5 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2241,7 +2241,7 @@ u8 rtllib_ap_sec_type(struct rtllib_device *ieee)
 	}
 }
 
-static void rtllib_MlmeDisassociateRequest(struct rtllib_device *rtllib,
+static void rtllib_mlme_disassociate_request(struct rtllib_device *rtllib,
 					   u8 *asSta, u8 asRsn)
 {
 	u8 i;
@@ -2272,7 +2272,7 @@ static void rtllib_mgnt_disconnect_ap(struct rtllib_device *rtllib, u8 asRsn)
 	filter_out_nonassociated_bssid = false;
 	rtllib->SetHwRegHandler(rtllib->dev, HW_VAR_CECHK_BSSID,
 				(u8 *)(&filter_out_nonassociated_bssid));
-	rtllib_MlmeDisassociateRequest(rtllib, rtllib->current_network.bssid,
+	rtllib_mlme_disassociate_request(rtllib, rtllib->current_network.bssid,
 				       asRsn);
 
 	rtllib->link_state = MAC80211_NOLINK;
-- 
2.39.2


