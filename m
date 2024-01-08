Return-Path: <linux-kernel+bounces-19946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D73EC82773B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B081F2041B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977E656469;
	Mon,  8 Jan 2024 18:17:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9496C55E76;
	Mon,  8 Jan 2024 18:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e7c6e3c63so2023279e87.3;
        Mon, 08 Jan 2024 10:16:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704737817; x=1705342617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiHTO+vMR9qnsdbgTZyf9dtHyg1qTnThJCI4YmGdW6U=;
        b=KRjr0/N9bPExwkbNDT8QbqjiVvdE7pBYVUliadEXUaTSAmqWsx/OcgoAlGor7Bljn5
         Elg6mSRAC1/mk3q/7qHtq0suzsnnl60I+vHvC9pZLbuXzWRI3TZEICqllMrJesV418zW
         lKPf3MHxPPzGP0xFhdMlsTNZA8xSHroMZSs+2tp+jnUZk9t9xo16gFPGwMKCiu812h/S
         x/PA+LD7wrWjFIPtv70WDakhd4Mxpv0HXp1CVP76to9UMwOLv24/i7ogA9ciNtGhHLjk
         nnNGLwJ/lQRJFJbRxgk0qSn359EYWJS7i/8l1lZ5KfHBouhZma88Mr0Dr3PnZcL16hsR
         zwSw==
X-Gm-Message-State: AOJu0YzFzNRSxZgf9L4WMW58RoxoKOm8qWCnsSn2RBCawyOje+awANcD
	xZJhP84zYvIw7/oK9Oaolqo=
X-Google-Smtp-Source: AGHT+IF+F25Qmeh6335I+1JKl7zO64FInNZ+6zgj9dIV3yC7V1s4wbUCwngpLIm6oSvboG79MM8Cjg==
X-Received: by 2002:a05:6512:2351:b0:50e:b2f0:3daa with SMTP id p17-20020a056512235100b0050eb2f03daamr1048297lfu.239.1704737816711;
        Mon, 08 Jan 2024 10:16:56 -0800 (PST)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id i22-20020a170906091600b00a28148beabdsm127836ejd.102.2024.01.08.10.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 10:16:56 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Alexander Aring <alex.aring@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org (open list:6LOWPAN GENERIC (BTLE/IEEE 802.15.4)),
	linux-wpan@vger.kernel.org (open list:6LOWPAN GENERIC (BTLE/IEEE 802.15.4)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 07/10] net: fill in MODULE_DESCRIPTION()s for 6LoWPAN
Date: Mon,  8 Jan 2024 10:16:07 -0800
Message-Id: <20240108181610.2697017-8-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240108181610.2697017-1-leitao@debian.org>
References: <20240108181610.2697017-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to IPv6 over Low power Wireless Personal Area Network.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/6lowpan/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
index 7b3341cef926..80d83151ef29 100644
--- a/net/6lowpan/core.c
+++ b/net/6lowpan/core.c
@@ -178,5 +178,5 @@ static void __exit lowpan_module_exit(void)
 
 module_init(lowpan_module_init);
 module_exit(lowpan_module_exit);
-
+MODULE_DESCRIPTION("IPv6 over Low power Wireless Personal Area Network module");
 MODULE_LICENSE("GPL");
-- 
2.39.3


