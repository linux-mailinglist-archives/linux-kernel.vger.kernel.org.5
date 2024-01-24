Return-Path: <linux-kernel+bounces-37779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC3383B4F3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18DA1F21B73
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE4F13BEA7;
	Wed, 24 Jan 2024 22:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="ekjMSMY/"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462C713B79D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136310; cv=none; b=uiG5aE9pgpDcCL9vVW/i0y+JW4v3xQtDhXEXAgdb6iHKdrnvwNmGwGICGAPeS8nujR/+HGJP7AkUYRNt/lmPrSvxncNB0dD1zn0ZkO2ICTa3uAaQqzWWhxA83WOx3jJl32OQU5v5fkFTKG+3UaV/+6UYoRo+oqlYWktf09o2q+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136310; c=relaxed/simple;
	bh=+cP4t/OPevl84lEdP4szFceY5NLbMzWC8dsMPnnt/TU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YYtXOJAbTo55FCRDX68a4hMLJgoj7WZsEqLtRuVnke1Ucqa1AdcvFWIHl9YqgaD7XrP1009sYmaIIpKDL9rD/95NlyL/W78k0NvImLsDZQbMSY2tuaq+WSgzr3bPZPTQh5bRkLa1IjDZcpW5oorFHvomgNHi3axc6TVVfREkf0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=ekjMSMY/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d70b0e521eso44379485ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706136308; x=1706741108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtBjG1Apfhx7pBdMhXK8rtOHkvOwtEpOApdgYpd3hWY=;
        b=ekjMSMY/eNfyLM7jnwuXJvv1anJASCcWQ2uJ9MX8u4LRTxLUiiqufkwp0bkZqBhlMR
         ozpUrv8B1Ym97qUvmxfB/V5rFzPj4kkjLa7eoto5kqnHv55zUN3W+d1Y6Nqc8flkK5Us
         lP4j6WNB0kl8QfnIPoN4VFafU22Jll5/+JWyWTPpJYXZa+l6c2lnJYkKM2xXRih3zI7r
         +FFGPztikxlLmdsZTKuZooSbBeRzh8kEgDLSFmKSISOvfgKY5krb+l/Zyen8uGFVALPy
         xPgDEjjCilPf+7BMxKZELs3jtNA8WPI+kkdB7EI5NrUz1AqBgOBqwLeRRM6Rbykn1SVj
         SPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706136308; x=1706741108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtBjG1Apfhx7pBdMhXK8rtOHkvOwtEpOApdgYpd3hWY=;
        b=ZTpCtID0DgTTcu+rCdNrkV89fI/Ptrfexakf5oM0L21G6uIEQX12kGWikRmo+TTJVT
         +n/5i05LJgF6eosUDFL5/cpTi17MQ4j/Bg4brq/FipsPYRHDdny91KxcQe+/ijAfU7tN
         X+9cgL1eQ93fuIENgpL1riYt1dgLVqG7rPCbBbIotmUcQByn36DwTeTGhdJtkruEGuYy
         UBp9cac7bPMN/eC7nZxMSihQAiXOkBiaff3+nakI9h7jw2WnU/JFyS0MMKFnGwW2YhoS
         4apd70it3BvN7uQLfGvqOVzpnJFBEGObqLJyjwpRQpUZeBkO5VzeGBveITFOdnzynf7O
         crEA==
X-Gm-Message-State: AOJu0YzgsA/s05V0edwMNO7e11Mix9PEl3T4xoIoYaql2AhvACmvfdlC
	Auj5IukzU5iHDZb65spAXWVeH8Wk60UjtVqp4y12YEqQbVNN7cuMjLUcBueFkYI=
X-Google-Smtp-Source: AGHT+IGeVctv8uX5A9KjXwUmbEEwQjrkreN3EKUpGNhs9bneQnJjatGwhGLMPjsTLzmy3IeYq5zU6w==
X-Received: by 2002:a17:902:ba8f:b0:1d4:25d5:5a75 with SMTP id k15-20020a170902ba8f00b001d425d55a75mr90163pls.74.1706136308677;
        Wed, 24 Jan 2024 14:45:08 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902c28500b001d73a2acc0csm6743987pld.283.2024.01.24.14.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:45:07 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 14/18] Staging: rtl8192e: Fix if statement alignment with open parenthesis
Date: Wed, 24 Jan 2024 14:44:48 -0800
Message-Id: <20240124224452.968724-15-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124224452.968724-1-tdavies@darkphysics.net>
References: <20240124224452.968724-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a space in front of statement to fix checkpatch warning:
Alignment should match open parenthesis

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index dc91e59f1bc2..5281138ad468 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1207,7 +1207,7 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 				    ieee->current_network.flags);
 
 			if ((rtllib_act_scanning(ieee, false)) &&
-			   !(ieee->softmac_features & IEEE_SOFTMAC_SCAN))
+			    !(ieee->softmac_features & IEEE_SOFTMAC_SCAN))
 				rtllib_stop_scan_syncro(ieee);
 
 			ht_reset_iot_setting(ieee->ht_info);
-- 
2.39.2


