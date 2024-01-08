Return-Path: <linux-kernel+bounces-19942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA44827727
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548DF1F23B7F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D006455797;
	Mon,  8 Jan 2024 18:16:45 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F168855782;
	Mon,  8 Jan 2024 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a293f2280c7so230723866b.1;
        Mon, 08 Jan 2024 10:16:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704737802; x=1705342602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwBz/HdD1fTyIfaQS3zdnGwIPyRW86lw57CXGqjsLt8=;
        b=EDasFqeBFsT8eRb7OeW4FrJbBgVZs8lhSS705DlKcOJtmj6IddszJoN89sQCZJc6Os
         LrvrHPWwy2wwwQYq2tY5192K+/QrjOvK8KGrAzCGI+vJC+b07+x0ztE0A6CW6w66qj3L
         e4bnsvJ7xU74tLbebw+hGkouP+DNdtotFRNlU6DUESYM/G2Yyyu8G5qhyFVbHYEBJQ3t
         epB4NBPqZX48WmSbQoS1f9nhXfyfLslyDzsN3GcILKWbD3JvTkOGouaAAmG9Jym+xZxx
         ktiwtLFF8+TQIOvwUasdyDeGcWaKQP1PNXihWxT03lV6MRowqzQB0z07lJFrI+ppa5Tg
         pUKg==
X-Gm-Message-State: AOJu0Ywc7e+CpQg5DQMC1oE5TAf8w0m68tzWqAoo0lddUdydopd1ts3u
	2hqH4COGXYN7Dz1F0BlbPy8=
X-Google-Smtp-Source: AGHT+IEZqozRMuIY+gW0GX2J7pZxg8nZrxsTxgNOe92Oam0tfVm0tGbx4CiorPH1SZsVyDwIYwsliQ==
X-Received: by 2002:a17:907:7292:b0:a26:cab1:4076 with SMTP id dt18-20020a170907729200b00a26cab14076mr1093755ejc.125.1704737802132;
        Mon, 08 Jan 2024 10:16:42 -0800 (PST)
Received: from localhost (fwdproxy-lla-120.fbsv.net. [2a03:2880:30ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id s15-20020a1709067b8f00b00a28d2e95152sm126935ejo.129.2024.01.08.10.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 10:16:41 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 03/10] net: fill in MODULE_DESCRIPTION()s for HSR
Date: Mon,  8 Jan 2024 10:16:03 -0800
Message-Id: <20240108181610.2697017-4-leitao@debian.org>
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
Add descriptions to High-availability Seamless Redundancy (HSR) driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/hsr/hsr_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
index b099c3150150..cb83c8feb746 100644
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -167,4 +167,5 @@ static void __exit hsr_exit(void)
 
 module_init(hsr_init);
 module_exit(hsr_exit);
+MODULE_DESCRIPTION("High-availability Seamless Redundancy (HSR) driver");
 MODULE_LICENSE("GPL");
-- 
2.39.3


