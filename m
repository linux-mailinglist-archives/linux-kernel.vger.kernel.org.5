Return-Path: <linux-kernel+bounces-69787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AC6858E8C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391A61C21119
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CC01EF15;
	Sat, 17 Feb 2024 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rUTVc7hK"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097551DFFD
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708164195; cv=none; b=oT8wqcUGJPra355cdDd81WcHnnCeReP0xPekHFf3PvFu78Bs84sqcXWeW4F3dhuVh1w7lBf7w7uBfTKSHTA9hOmvlRs+RavRmCFFIlyFAK8NDBzYacX1XNtIn/9B18OgOp7RCJrms5VXLl8IpIUk4tUHH0xOU1kAaDgW1YeSEmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708164195; c=relaxed/simple;
	bh=A+8Z4F2C+Jafe+RXMmROAWtPHvoM9Qp4Vx4sW0hunfg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tFY/UD89+xfgm2Vkqi6P3J43dPD9zLwkK4Dsz4NR8eU42m0uhqS2Q/DN31CErK/anH+iWPnqYHlJ7I3b1i3DKo4NqTEAi9FeeLY7S3VXSEdUArxHnL6PcgtHJcttfsGkieopRwLJLvgsGvHj9UlL/jigVIPCsF9CPpROho7k/WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rUTVc7hK; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3d0d26182dso308727466b.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 02:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708164188; x=1708768988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9YKX8C3qTGETErqkeCa13vk3aSbkZKOlK79FCs1RlfM=;
        b=rUTVc7hKJTdknUxy8QRv5PMaU1rwGqMJQjWX1GhFqg3v1Pt6yFd4PsD12WPZby20wF
         BYV9+FqGYD3keqKdva41RfCg9cSiRuuoa1NUJwA/Cxta2kY8Ygt0ufrqATpC9eAl+nTQ
         5wMLAfPA7vKqOjFYc3mjtUp8t00NgVdS+qJI4mXxnO/6S5GNhAk+OpR0sZXGOtTblbzD
         rAlOVwIrmT4artZVY+C+LcyLmNV4bCaju9Ne8SYTTeuzlmg/JF+0mwq9J4rU99tcHs2V
         pZzWQFIrCS1YOBhEZ2qmLPruVyDeFrtI9rcgv5zRMld0ND8MbA7zRDDe+QbIiDUaAhGV
         dAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708164188; x=1708768988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9YKX8C3qTGETErqkeCa13vk3aSbkZKOlK79FCs1RlfM=;
        b=r7gk9gV26DV9l4U0isuYYPOCuJsZ9y0L7kj2ndDYW/+6qRRU+Q0Rj/KplQeOXA+0qI
         sLthnApZiQvLvtTRUxZCGW3CWl/RoLwBI/qQHZvyye4h1TpsUQg/OAcfjVn6Zt0zneuH
         bEFk6vX/mawKuKAynhcLcabVqoQBSpZ+FLW7XC7kzebeAGlxGINbMK6yvtcXigKHfDtV
         qKyToid4KWJfl+VTqFEHv+tXbEDgC1kXboB27TqKOE9a/pufukBP70H/6Iydwhl4w31Y
         MLmpgvyRsRp1B2oUwbHGtGfV0q1qFONC8BFr17Lv01bMOBDtCJe0V7I8T3jn2SgrupFe
         X19Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7Qjt4cJAdS9P/37yqQdlqzas6AuhXy1Hfe8VKXRb/GgLxW0ipeFt0cJTo0vzj07M2Sjv86/qbxcy2Oc52XT0bwNJ36MtG3CMbLtqP
X-Gm-Message-State: AOJu0YxseORV8Cx6c2p3qfOaj0Nove/b5q07VERS1KK1vwOzdOzyXhmq
	TvskWe8YpNC3886hFw4nPtAdXI3H9RHbwTVXeUZ+daq85w7+oEHBatYgcN3vrYk=
X-Google-Smtp-Source: AGHT+IEB7coatVc1HZNyq1lKyqGs5tBMkLSGt/qgM6tjFvuATdq9Q/ZJKE3BoDsFElc7NBbg6Vl5JA==
X-Received: by 2002:a17:906:3d2:b0:a3c:e8f6:a399 with SMTP id c18-20020a17090603d200b00a3ce8f6a399mr4796446eja.29.1708164188372;
        Sat, 17 Feb 2024 02:03:08 -0800 (PST)
Received: from krzk-bin.. ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id fj6-20020a1709069c8600b00a3cfe376116sm844862ejc.57.2024.02.17.02.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 02:03:07 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH net-next] net: wan: framer: constify of_phandle_args in xlate
Date: Sat, 17 Feb 2024 11:03:06 +0100
Message-Id: <20240217100306.86740-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xlate callbacks are supposed to translate of_phandle_args to proper
provider without modifying the of_phandle_args.  Make the argument
pointer to const for code safety and readability.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/wan/framer/framer-core.c   |  9 +++++----
 include/linux/framer/framer-provider.h | 14 +++++++-------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wan/framer/framer-core.c b/drivers/net/wan/framer/framer-core.c
index c04dc88bda6c..33b358b99f70 100644
--- a/drivers/net/wan/framer/framer-core.c
+++ b/drivers/net/wan/framer/framer-core.c
@@ -384,7 +384,7 @@ static struct framer_provider *framer_provider_of_lookup(const struct device_nod
 	return ERR_PTR(-EPROBE_DEFER);
 }
 
-static struct framer *framer_of_get_from_provider(struct of_phandle_args *args)
+static struct framer *framer_of_get_from_provider(const struct of_phandle_args *args)
 {
 	struct framer_provider *framer_provider;
 	struct framer *framer;
@@ -735,7 +735,8 @@ EXPORT_SYMBOL_GPL(devm_framer_create);
  * should provide a custom of_xlate function that reads the *args* and returns
  * the appropriate framer.
  */
-struct framer *framer_provider_simple_of_xlate(struct device *dev, struct of_phandle_args *args)
+struct framer *framer_provider_simple_of_xlate(struct device *dev,
+					       const struct of_phandle_args *args)
 {
 	struct class_dev_iter iter;
 	struct framer *framer;
@@ -768,7 +769,7 @@ EXPORT_SYMBOL_GPL(framer_provider_simple_of_xlate);
 struct framer_provider *
 __framer_provider_of_register(struct device *dev, struct module *owner,
 			      struct framer *(*of_xlate)(struct device *dev,
-							 struct of_phandle_args *args))
+							 const struct of_phandle_args *args))
 {
 	struct framer_provider *framer_provider;
 
@@ -830,7 +831,7 @@ static void devm_framer_provider_of_unregister(struct device *dev, void *res)
 struct framer_provider *
 __devm_framer_provider_of_register(struct device *dev, struct module *owner,
 				   struct framer *(*of_xlate)(struct device *dev,
-							      struct of_phandle_args *args))
+							      const struct of_phandle_args *args))
 {
 	struct framer_provider **ptr, *framer_provider;
 
diff --git a/include/linux/framer/framer-provider.h b/include/linux/framer/framer-provider.h
index 782cd5fc83d5..f6fd2dd92591 100644
--- a/include/linux/framer/framer-provider.h
+++ b/include/linux/framer/framer-provider.h
@@ -93,7 +93,7 @@ struct framer_provider {
 	struct module		*owner;
 	struct list_head	list;
 	struct framer * (*of_xlate)(struct device *dev,
-				    struct of_phandle_args *args);
+				    const struct of_phandle_args *args);
 };
 
 static inline void framer_set_drvdata(struct framer *framer, void *data)
@@ -118,19 +118,19 @@ struct framer *devm_framer_create(struct device *dev, struct device_node *node,
 				  const struct framer_ops *ops);
 
 struct framer *framer_provider_simple_of_xlate(struct device *dev,
-					       struct of_phandle_args *args);
+					       const struct of_phandle_args *args);
 
 struct framer_provider *
 __framer_provider_of_register(struct device *dev, struct module *owner,
 			      struct framer *(*of_xlate)(struct device *dev,
-							 struct of_phandle_args *args));
+							 const struct of_phandle_args *args));
 
 void framer_provider_of_unregister(struct framer_provider *framer_provider);
 
 struct framer_provider *
 __devm_framer_provider_of_register(struct device *dev, struct module *owner,
 				   struct framer *(*of_xlate)(struct device *dev,
-							      struct of_phandle_args *args));
+							      const struct of_phandle_args *args));
 
 void framer_notify_status_change(struct framer *framer);
 
@@ -154,7 +154,7 @@ static inline struct framer *devm_framer_create(struct device *dev, struct devic
 }
 
 static inline struct framer *framer_provider_simple_of_xlate(struct device *dev,
-							     struct of_phandle_args *args)
+							     const struct of_phandle_args *args)
 {
 	return ERR_PTR(-ENOSYS);
 }
@@ -162,7 +162,7 @@ static inline struct framer *framer_provider_simple_of_xlate(struct device *dev,
 static inline struct framer_provider *
 __framer_provider_of_register(struct device *dev, struct module *owner,
 			      struct framer *(*of_xlate)(struct device *dev,
-							 struct of_phandle_args *args))
+							 const struct of_phandle_args *args))
 {
 	return ERR_PTR(-ENOSYS);
 }
@@ -174,7 +174,7 @@ void framer_provider_of_unregister(struct framer_provider *framer_provider)
 static inline struct framer_provider *
 __devm_framer_provider_of_register(struct device *dev, struct module *owner,
 				   struct framer *(*of_xlate)(struct device *dev,
-							      struct of_phandle_args *args))
+							      const struct of_phandle_args *args))
 {
 	return ERR_PTR(-ENOSYS);
 }
-- 
2.34.1


