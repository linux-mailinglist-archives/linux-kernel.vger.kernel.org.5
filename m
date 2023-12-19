Return-Path: <linux-kernel+bounces-5260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666E38188AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F7E284945
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECD919464;
	Tue, 19 Dec 2023 13:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L12IDQRy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CA21A58F;
	Tue, 19 Dec 2023 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40c29f7b068so50310835e9.0;
        Tue, 19 Dec 2023 05:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702992617; x=1703597417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LPGXcnXLsTRr4zXKeLNyGpG31p97iOHAL2nwIpna9XE=;
        b=L12IDQRyLLXXfVpB7Xz+KugntpJqXwsk2no+9jGFlrhkfAkDsMvw4wu74o1P7kc4f8
         Y6UiqGVl5mhr6ZDr026JkwSKDh0kd98pjgdat98Si9HHy1J/5Tz/enLvqW7aGHQMnpYc
         Q5LdjtczceiMR9mpyGVuRU+xO73bkdesAoee2f0uYnojodkLg1zffkH3l2eWuHVk2L3Z
         IaeXAYMP/Y8GPpSP2d3s9JYezn/ulUtBYe3ZW6JMua2ATV6r21OISQ3cWAGbFvyBnszW
         Ft4A1LI1QGQvynkSNLxvfqOTgpgcjqqk82guWGLz9K1uZnUdkKX4ck2KU/pOTpkFo502
         uf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702992617; x=1703597417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPGXcnXLsTRr4zXKeLNyGpG31p97iOHAL2nwIpna9XE=;
        b=la50Tytj56FDSHlu4AaX7EDVfP6NirIU5WNPtygeikM/7ztJ/BQdvM/HwlMeAw7aSE
         Uu3gX6f+m+lsODBMALwU+8mfnxVaf2VgSnlwrr1mbxxka7/IlshzIcYzHSArTs4slpEz
         I/vkox0Q9BQreFIp00/4noFhPOKFKz1riv9A19IZ7JIEi0rn09gV5xboZdyQE4JPyf0k
         R0RUK/upxuJ7nJ5ArVa8eLNE8112tB/t3QrkQ8rK2/WGO9CCRbS4H27dWsyZhPCP8ToI
         ZV0u3sfritbKm4883NaKjl8chybPHYX4UEqYZgXNTEVrW2YK2nNVEGgNBQ3JKK6eKBuP
         wR8A==
X-Gm-Message-State: AOJu0YwLdKwfzM85RS/QoIIGfRhc/aETSBeAAvurTGmIWIWaI90MAbEA
	5Hbp3vwZnr/P64NGKZZv0vY=
X-Google-Smtp-Source: AGHT+IEZzjq/G5Zg1g+9ar72peh3/wAdRvBAKoyeCDm9r01/tpkelivmuSqGPHySwcycCAFbfB58mQ==
X-Received: by 2002:a05:600c:5129:b0:40b:5e1e:b3ad with SMTP id o41-20020a05600c512900b0040b5e1eb3admr9542046wms.43.1702992616828;
        Tue, 19 Dec 2023 05:30:16 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r1-20020a5d4e41000000b0033672971fabsm1575778wrt.115.2023.12.19.05.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 05:30:16 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	William Breathitt Gray <william.gray@linaro.org>,
	linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] tools/counter: Fix spelling mistake "componend" -> "component"
Date: Tue, 19 Dec 2023 13:30:15 +0000
Message-Id: <20231219133015.365943-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are two spelling mistakes in the help text. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/counter/counter_watch_events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/counter/counter_watch_events.c b/tools/counter/counter_watch_events.c
index 3898fe7e35ec..37d1b4b3e63d 100644
--- a/tools/counter/counter_watch_events.c
+++ b/tools/counter/counter_watch_events.c
@@ -120,8 +120,8 @@ static void print_usage(void)
 		"  evt_capture                (COUNTER_EVENT_CAPTURE)\n"
 		"\n"
 		"  chan=<n>                   channel <n> for this watch [default: 0]\n"
-		"  id=<n>                     componend id <n> for this watch [default: 0]\n"
-		"  parent=<n>                 componend parent <n> for this watch [default: 0]\n"
+		"  id=<n>                     component id <n> for this watch [default: 0]\n"
+		"  parent=<n>                 component parent <n> for this watch [default: 0]\n"
 		"\n"
 		"Example with two watched events:\n\n"
 		"counter_watch_events -d \\\n"
-- 
2.39.2


