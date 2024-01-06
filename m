Return-Path: <linux-kernel+bounces-18493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE20825E5D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C383C284FAE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 05:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3506C6ADC;
	Sat,  6 Jan 2024 05:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="FClDYXPu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A095232
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 05:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bbc755167fso321623b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 21:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1704520570; x=1705125370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcpBhKPXVjKfWcfCaYYKt8+x28tLO44v27oA5X8COYY=;
        b=FClDYXPuWQyK7hXdhuSmz6KEdJI+6kgYnfxEIL+h7mfEruVTs5/myMc0C8V2NSON6r
         6iwQp4+ztNn15SEgURhUB9n6Q40jq3yFUoHQqiyXxVem72C4jlDnA1680z5RNwrhu3Bt
         SduOMoHwTsfx+y/uJHbIpLffuCm6OfqYTL+ubXrMCkYr+6JWlKnUE1w/ra1WIMBZbAT5
         i+v9SbV9UTz43r9juJavRLPxXJamjy9MWHHyRKTOVV/2h2MzrWwqGWAzZzudF0HcZCwf
         whcJQP3ZddBcitmqzIALe9NczfXb3DgdNGz1kFIixj1a6okwnr6lYwmgARzmtCQbSGrE
         r7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704520570; x=1705125370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcpBhKPXVjKfWcfCaYYKt8+x28tLO44v27oA5X8COYY=;
        b=PJ5rl1FIJ4E8PvEIdm4JQE/pT946HnbPeciZUuTw8Mr68fJ5WSU4ThqOBHov54+gjE
         zmP+3/ENovdb4tHkQHFWoQbFz8ZsDeWfsT53F8ob+eYxkG6pI2OZq6NVp/8MIziNfVMQ
         sqM+XGfPX+Eo9bU1VlmT/YMoL6nkCVDG0Esm/XM1Fjh4NsV4loVP1juxT3hkb8X6TwMg
         O9WLoZZ8rutYESyvXTah/zCb+J38are2W/j7bshPGj4lvvBzFFB99JiGMcIlkylhl9lw
         jRiLZkwUCoeHyW9JsW1usb2zIpCBKl8SJmhmzNZbzZmaxQgupcXX7SsgLzs44k2JWSax
         1LqA==
X-Gm-Message-State: AOJu0YzKiGLKYQzIPQHpC/MMSeMwqXYClWxwwHGMd2tB/SmlxUPFHnKx
	HqboMGri2Ddvv0attLM1DOLEhThimZ+WTl+B4B+BhWVq0rc=
X-Google-Smtp-Source: AGHT+IHvdrvWpmJwR9dlWUDkGQfLW/+8q7oGljtk3GWj7thWBCKcApXp8wgBYrerP51ZiM06yvi1yw==
X-Received: by 2002:a05:6808:221a:b0:3bc:2777:397b with SMTP id bd26-20020a056808221a00b003bc2777397bmr731939oib.41.1704520570290;
        Fri, 05 Jan 2024 21:56:10 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id y29-20020a056a00181d00b006d99d986624sm2280873pfa.151.2024.01.05.21.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 21:56:09 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 03/21] Staging: rtl8192e: Rename function rtllib_MgntDisconnectAP()
Date: Fri,  5 Jan 2024 21:55:38 -0800
Message-Id: <20240106055556.430948-4-tdavies@darkphysics.net>
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

Rename function rtllib_MgntDisconnectAP to rtllib_mgnt_disconnect_ap
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 1d490704389e..6f730242728a 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2265,7 +2265,7 @@ static void rtllib_MlmeDisassociateRequest(struct rtllib_device *rtllib,
 	}
 }
 
-static void rtllib_MgntDisconnectAP(struct rtllib_device *rtllib, u8 asRsn)
+static void rtllib_mgnt_disconnect_ap(struct rtllib_device *rtllib, u8 asRsn)
 {
 	bool bFilterOutNonAssociatedBSSID = false;
 
@@ -2285,7 +2285,7 @@ bool rtllib_MgntDisconnect(struct rtllib_device *rtllib, u8 asRsn)
 
 	if (rtllib->link_state == MAC80211_LINKED) {
 		if (rtllib->iw_mode == IW_MODE_INFRA)
-			rtllib_MgntDisconnectAP(rtllib, asRsn);
+			rtllib_mgnt_disconnect_ap(rtllib, asRsn);
 	}
 
 	return true;
-- 
2.39.2


