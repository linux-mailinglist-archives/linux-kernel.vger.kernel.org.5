Return-Path: <linux-kernel+bounces-69785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F24858E87
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07EF282CEF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA3D200C4;
	Sat, 17 Feb 2024 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FL5LdBvi"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577AE1D547
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708164143; cv=none; b=ElTTblUWtjQrSqk6TwipxWo5yY1DE4+yCa7wXxgvJKBTmfQYNtu8inKKlWILZhAYYQqxvHiWnlITeMAouH4Az18xCf1plHVCsQ6t2SvakuZZlApZg6YDdgtN9GI4/NXXmUNZy6zag8B7YzsqYlO7K7MRgZtF99Hg52EYx+akM6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708164143; c=relaxed/simple;
	bh=A+8Z4F2C+Jafe+RXMmROAWtPHvoM9Qp4Vx4sW0hunfg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=igTxIRgLvyBcdQvhJJBqJgI1vNfWUaFz/teGhwlZxPGIcCyMXBMgwJee9rhiVD/4Wa12W+zwTH0mYo1S+1NPpglPY5NQ6iRE3fUZ3WH5tgwGZ3YEtLdtzviVJK1H0Jgho6kHFd/jlQTL5Mu9F1+zSAawOTM4lZ2SAzrXzy++gso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FL5LdBvi; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso2437876a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 02:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708164135; x=1708768935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9YKX8C3qTGETErqkeCa13vk3aSbkZKOlK79FCs1RlfM=;
        b=FL5LdBvi/m97gh9NW+zPnFmky9YAncO/PODwi9UCL9OqmkyvkGlT6wcyz+p7b4ewx5
         uv79DylenemF/ntTBZl7SKyae+8AJYDOGaY7iYZED+8XgehmR9BNXEJmXr7WjQEO2A2F
         CltOVlDVhvFQ1aVL+zLNXTgDFbO1zhezNR5ictNe5Hl+on8qP3ZipVc1gl7lL6hIODLM
         rcntyqyuyn1UlHXgzxqfcrXBh01aaNO0DDybkxgXfxGeAoEV7ReiCGiUxGgkMRI7Zox3
         O/eB7qm44GQGce1Qm/wnfte1RegmaY1G+Y2tnRswEv4j4cL8BcdqN1mK1a4QTaLTzQlN
         WalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708164135; x=1708768935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9YKX8C3qTGETErqkeCa13vk3aSbkZKOlK79FCs1RlfM=;
        b=t04W2Grrx9nzkMcLrYzix64Qb1yPHlupTuVrBz4WUnZploDKbUB98sTuPEyK+NGZWd
         wxqt97/Vn/z0WnqekIS/5y3XgYBCXYVQj3xggDqVLDYWI6bR7b6iwT21HdZJnbdKcd8j
         CguQSzAZWO2lwsFB+1+Qu68cOAbNZWoePR2sLL2QRlQ64A9cAL3gfwOjqsHKZyQKSaXt
         /CtiyZoudWx6OKSWn6dOXrv89vnTnBsZvOtTZ1RYVpmNarVZMeVKsHrIPl7jMVHdsB+o
         7SLydCfI2R6hv29RE303ZRSnTCM9aU0++9XrKgdyy78yeoRIIG0rUKHwJjcroWiR3his
         pJQA==
X-Forwarded-Encrypted: i=1; AJvYcCVng4UOQwuYSPo/6z1Z5M880kwbvsWt01D/5xOhgvzrnqwAQqFG6erxw7pED/Jk5Q21XMi4JxPZoWF9M/2/in6MO5IbJNrWsuQU0JAf
X-Gm-Message-State: AOJu0Yy82gCXfjTeyXk5lyYGqpXhvQN6DjyXxNDKjvJeQV/dFTb3G+Zz
	naTKOKSGYKR8xhVcGZ/EgP/N9lMmsDb3Kwm98Ue3RcVFsIoEneyggNTT/jwOM64=
X-Google-Smtp-Source: AGHT+IHFx4WsHksXhnPI3a+HpoDvG4Ji6xGBMfnh27EAWdtnVSdLg19AlCXlef+284Bo9jnKXDMc/Q==
X-Received: by 2002:a17:906:e24d:b0:a3e:22dc:653c with SMTP id gq13-20020a170906e24d00b00a3e22dc653cmr853879ejb.44.1708164135549;
        Sat, 17 Feb 2024 02:02:15 -0800 (PST)
Received: from krzk-bin.. ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id cu2-20020a170906e00200b00a3e1939b24csm560335ejb.208.2024.02.17.02.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 02:02:15 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] net: wan: framer: constify of_phandle_args in xlate
Date: Sat, 17 Feb 2024 11:01:48 +0100
Message-Id: <20240217100148.86658-1-krzysztof.kozlowski@linaro.org>
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


