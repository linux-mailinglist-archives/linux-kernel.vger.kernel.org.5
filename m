Return-Path: <linux-kernel+bounces-35958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D168A839928
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE511C22773
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489F086AD8;
	Tue, 23 Jan 2024 19:04:13 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE1086ACA;
	Tue, 23 Jan 2024 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036652; cv=none; b=II4gHMnbDP4bJKX45XxS1Kkoq/1fNVqEX8Vt9KhDkaS0nBXDxIW5EnTD7+wEBYXJTgF89byrDdxVJCQohKwV9DvdkLTGy0vWEoXbewTGxoIErBOmdc5cNBcVEuqxEGgSob+BbPdVKmESkRd5D91fNPV/iRSadO7GJqSCmBeY6rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036652; c=relaxed/simple;
	bh=otC0oxYyfZVPzZX/zfwI8stSIJHDGA7ed6/sdnWLpD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RxvixjyvhutuIaDxxP4KKxV/zI/S+xUVzOipxe3BquwIPmN7o1ckytOMO1ojbbcb+SG0l7Yu4jSQAnLJxacTV31NZ50F3FVSFLtJr0aVs/kfzyICvYEmfaHDJ1MbYnCfehtNdz4K6Ozs2Jv5Ior8BKvraVuIe27BlaRegghkv60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cf19f65271so8051811fa.2;
        Tue, 23 Jan 2024 11:04:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706036649; x=1706641449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFgt0ozQbjnWYH5i2XF8dhHsvqD/EPeO+LGoxd7oSiw=;
        b=R/KgHPlqP1CIJKZuP1AY8Wv46I51xvjS5fWXj3cZPPdBWuuEL02cUoJDAfPOIy1ETI
         usPuoD0vN3rlk4/ZvvTeENL7Qut5QE8PMPxZvbml4zvR/MwshP/s+/4wwXkzlklwZRw1
         0AvMU5yF13M7Ubi3Q+NIxcCy2HYTD3t6EF0Ds1c4kGlyJQRmA/62ux2R9dp0HbTI85y1
         ORXqFHrHWGBJHXjRC2mFXipuliFafkxqOEBDp/FVQsMDDjQfWl7gRBSpJqH8Kllmu0X/
         I2zJuHUO11Cc5O2e/YyqjYTJMxV+Q+oVVFPzh03+QiIysxHSpEem0h2uVhmV4D3NMOW7
         XkhQ==
X-Gm-Message-State: AOJu0YzAIxvDiJ0iVXbnxA6PxML8eKUnxJkdTwcRBTIw7B5LeR6Btry0
	QSaTN2MvQ4W695HWm2JpFMmiGaCN/onJNKQSuKomG/MOQm4sj3M5
X-Google-Smtp-Source: AGHT+IHmyOkx2AJ2Y66bW7nW8Trva2zHaRsb+UzD9sWvu3tofqxBuxUNyyf7iPAZL91UxSTuMRoUwA==
X-Received: by 2002:a2e:b450:0:b0:2cc:7103:6b21 with SMTP id o16-20020a2eb450000000b002cc71036b21mr156200ljm.53.1706036649264;
        Tue, 23 Jan 2024 11:04:09 -0800 (PST)
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id j9-20020a508a89000000b00554930be765sm16115370edj.97.2024.01.23.11.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 11:04:09 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v2 03/10] net: fill in MODULE_DESCRIPTION()s for liquidio
Date: Tue, 23 Jan 2024 11:03:24 -0800
Message-Id: <20240123190332.677489-4-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240123190332.677489-1-leitao@debian.org>
References: <20240123190332.677489-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the Cavium Liquidio.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/cavium/liquidio/lio_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_core.c b/drivers/net/ethernet/cavium/liquidio/lio_core.c
index 9cc6303c82ff..f38d31bfab1b 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_core.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_core.c
@@ -27,6 +27,7 @@
 #include "octeon_network.h"
 
 MODULE_AUTHOR("Cavium Networks, <support@cavium.com>");
+MODULE_DESCRIPTION("Cavium LiquidIO Intelligent Server Adapter Core");
 MODULE_LICENSE("GPL");
 
 /* OOM task polling interval */
-- 
2.39.3


