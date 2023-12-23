Return-Path: <linux-kernel+bounces-10188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8A981D119
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1FC1F26491
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B854A79F2;
	Sat, 23 Dec 2023 01:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="QACwdue0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B533D9E
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3aa0321b5so20434585ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1703296790; x=1703901590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usonjnBG2njPou2HdeBz8fvEAliGcyLStCZ9ITDEc8c=;
        b=QACwdue0ywA/sftrDqjTLIfQsO9RJr0RsiEZ1whqUwSEx7do90L1YdMqxmbyB3LVqr
         CfISyhMwgLLM3iM/qHmayTkyhD5snBGRMsh4B3HRDj/IrnA6sUfHRfmYpAGmnbR7cSGf
         oD2c7qETYgqazgam4oBMgitu6sCdfUwnXuCjQy5gGFZK9Cbv9qPnQjlt6+aIS+WLc606
         rm3La6kKBsVMFeOfh2WA2UoeoiTR8xuKK35ycNTCVtFZJ24QyTtLnvu/RAZQ05QMHOnn
         ubZTVsN5I+byP0FSsg3xZg3+ur1iPHR+zrqXb23F73WCU8ecLvWxKuMUqOL6QU85yZjv
         5Izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296790; x=1703901590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usonjnBG2njPou2HdeBz8fvEAliGcyLStCZ9ITDEc8c=;
        b=eJ085uo/QMd8vb4zIy2p58OVA/JVGb3wF/WKneBh93rtmJmj3BCEnvarlpR+63np7O
         ynReLcrfqD43FIjWaUA4w2I+pwOEW6LeNV0GMgMFGqCejnjfbnEsCCz6uv4iimoek/T+
         5cB+BSMVQTTg7byslz8vH21z3bsP49zjrQrSGLqEEauFd+WoVajbAl80hwwrVkFveHfh
         sWncLpjDZxeTSVKX3icY4TOZ67cIG0TcKZ4JrQ7eAn0f8XVsejvvE3elSeO9NdGiHoz9
         lK4dzUTN4/Tp+3ITgCAehFdOdQDXP5Q6wv/d44yZK/N96kyEyhMdiifqCjwHumLHDEIG
         T0uQ==
X-Gm-Message-State: AOJu0YzNBKYmh4hNfJbjcHx5SE71irRjw64z/vG1VO0XEXUkgqZrLBAu
	oaVXaY3Ts4sSVKLVHoAPY5o6LhXevNnVvQ==
X-Google-Smtp-Source: AGHT+IG1XTO9xfo2wICSr6CN0C0CEnKwzISg3BBtWfVJz2soILdavBNKFvS3NFnDP0y2p6KmBkDo3Q==
X-Received: by 2002:a17:902:db03:b0:1d4:59f:c21e with SMTP id m3-20020a170902db0300b001d4059fc21emr2945365plx.32.1703296790299;
        Fri, 22 Dec 2023 17:59:50 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kg15-20020a170903060f00b001d3edef115dsm4106546plb.20.2023.12.22.17.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:59:49 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 05/20] Staging: rtl8192e: Remove unnecessary parenthesis in rtllib_ap_sec_type()
Date: Fri, 22 Dec 2023 17:59:27 -0800
Message-Id: <20231223015942.418263-6-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231223015942.418263-1-tdavies@darkphysics.net>
References: <20231223015942.418263-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove parnthesis to fix checkpatch Warning:
Unnecessary parentheses around ieee->wpa_ie[14]

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 208079c542ea..32760dc65961 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2231,7 +2231,7 @@ u8 rtllib_ap_sec_type(struct rtllib_device *ieee)
 		return SEC_ALG_WEP;
 	} else if ((wpa_ie_len != 0)) {
 		if (((ieee->wpa_ie[0] == 0xdd) &&
-		    (!memcmp(&(ieee->wpa_ie[14]), ccmp_ie, 4))) ||
+		    (!memcmp(&ieee->wpa_ie[14], ccmp_ie, 4))) ||
 		    ((ieee->wpa_ie[0] == 0x30) &&
 		    (!memcmp(&ieee->wpa_ie[10], ccmp_rsn_ie, 4))))
 			return SEC_ALG_CCMP;
-- 
2.39.2


