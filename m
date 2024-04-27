Return-Path: <linux-kernel+bounces-160897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237E28B4442
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 07:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC8F28210F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 05:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF1842047;
	Sat, 27 Apr 2024 05:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daACo6GI"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AC541C77;
	Sat, 27 Apr 2024 05:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714194722; cv=none; b=fMq/J5QHqYDoadWn6C/J3+nWjI7GBv16mnzVyLCRDQY7Mawx2eRavU/zxd7RqB4fu+3dGDXijhfq1qmxDFRhk5BvgHyx0xMYUv9dyVxva4zBghw5jlEArbr8kD4bUFkKt8bQfksOlpH28fRKnIjPWPgvxuLAS/x/bVR1WedDFsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714194722; c=relaxed/simple;
	bh=unEu2ov0/p061boxS/jHeqd8/98Q4YNURM7psfpSEsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V2zLXzdcu7Pk2AwiAiIP/pU1lKygnEaiFWYfXD8M465hks842xekBieSBHb2YL9WxV1Il3zTyTS2F0P8Osim1CWGcPHvA/pzeQEZQnEOpadf+rUVL9PaE+7hPwb6+E0bC7q/gEmQNL8k4Xq8NUkpubbgA/+2FiZIoKlxr6p6sWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daACo6GI; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2330f85c2ebso1804267fac.1;
        Fri, 26 Apr 2024 22:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714194719; x=1714799519; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1tFFOM2BNNcF6kFjAZAYzjxKXqPKbwgTTfL8YgC9R0=;
        b=daACo6GIe+tHnxY1HxZuq7zcTqc4UE4qMzmDwIsIwhkNgJNVNl7rAN7PSZpDiAYXOl
         j9IgV1PaLUq0ORmoBbi56r3awreatXqiVs6WzHnWUHIp8Pi6Fc0yH79p4eP+D2ehU8Cx
         rn3IqUDoOExi5ovQqK5Q6Bwl0r+FSUgkIosvEdHerLZP/u7wO4y5C4pFJgAw2hqTT/eJ
         TkYsLJgWndMRjzPq+dTXnwzTpaGPu4TOTe+xYTC1dqEZ+OAnXPCTyLcaUC961sYopvxV
         7zmhvSX7x62cU43mDEs0WkD8sjtOolIfdp+WH+XU2eenFFvwMEMrr/GNgMh78Q92Nxrf
         jNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714194719; x=1714799519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1tFFOM2BNNcF6kFjAZAYzjxKXqPKbwgTTfL8YgC9R0=;
        b=tHpBMg9WVg2QzK7VkhcxAh0jWnAnToouRSEY1t4VDCPaI5nl9kq0Xm7QkgRVyCQlv9
         1TCpNMQp+EbINMC4V6IWAFAUJyZrFaACIh9DHa2GfzOWhBQo775a551Eiy2fKPjIUB4c
         tz9Bk4jJ1CWiS9cz6hObkmzJMAvmh5Q8sVZZuDzd9FvCrRQuSu/+u9LpemFcuPXFhwlw
         j5nv7fQRwmmMcf3RCnaeE9BWOxVaWWAO/ZzdxGmdObv0laEyFmM6npJCqAoc27nOEJHm
         kri0crjVttipPtop743YUvD8Bd8TyUcYK5LsTHhzcXZpZtvbdhiC4bbsZkL0VuV6b07a
         zF7A==
X-Forwarded-Encrypted: i=1; AJvYcCV3MesX3BITdj3Anq1waeU933m5Pqik1hvOBF81Ufj8DFC0XoppTbeIE+2T61SRIxtlzCynJEvKyHU+/CeMF7enTsDjOu1IE7E5wPp/cdXtqRQe41wN6xixEA6HMG+JZtbQi7399icaaQ==
X-Gm-Message-State: AOJu0YzJIU1Gjn7ti1hs+DBYsW1BQVj887x6Jmqnh8gC78CrRn64GaAV
	68r12RB5ssR/yvNnAKXQKySZrKXvLn20CTVaPdOtWIdZIwX6KjlUUCnmrueG
X-Google-Smtp-Source: AGHT+IEPMu04DKORokflJnBxOev89wV/M8ptjbRUBGMwGMHV+llPN+FusnJP3/iQOauZdFA3o04FsQ==
X-Received: by 2002:a05:6870:a7a1:b0:23c:49b:7fb7 with SMTP id x33-20020a056870a7a100b0023c049b7fb7mr1511258oao.13.1714194719241;
        Fri, 26 Apr 2024 22:11:59 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([189.34.32.15])
        by smtp.gmail.com with ESMTPSA id cb17-20020a056a02071100b0060063c4be3bsm8108513pgb.14.2024.04.26.22.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 22:11:58 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 27 Apr 2024 02:11:29 -0300
Subject: [PATCH net-next v2 2/3] net: dsa: realtek: do not assert reset on
 remove
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240427-realtek-led-v2-2-5abaddc32cf6@gmail.com>
References: <20240427-realtek-led-v2-0-5abaddc32cf6@gmail.com>
In-Reply-To: <20240427-realtek-led-v2-0-5abaddc32cf6@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1651; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=unEu2ov0/p061boxS/jHeqd8/98Q4YNURM7psfpSEsI=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBmLIkLL1IdWPzzEGXHuoHyo7kfcSM7oI7H8/9rH
 23nMrszd4qJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZiyJCwAKCRC7Edu60Qc7
 VjCxB/48YvcKOG5mCRFWHEpsT3pIGK8wRCcEwTsmofJppI7asXvytlavkDz795QXBzxSAof/orx
 hdPc3kVkr8COdRjMfEU0Wp9wkoHQvZ+ZdIUGtPAQBS5f4/m/Y7jwr4UfeedUU6AVSTx8/9iaxL5
 +NUTSfL62SPvm+HYPw0xX9Rte/M4zHxrUfegAyAj11wjqcw/6bwaPkcm/9jvDSM/3kj4tWmFaNn
 tC68x/+CPGgxNgOVd03rZnHAUy3ri5DGoANu4L8RCBXX0IBVkjv21J10VFrczYRmfT1j9r+XrMc
 k/wlIPlfewPOxlzoUf6JiJ5AOxQ3yT55GJcze9tziROVcM0F
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

The necessity of asserting the reset on removal was previously
questioned, as DSA's own cleanup methods should suffice to prevent
traffic leakage[1].

When a driver has subdrivers controlled by devres, they will be
unregistered after the main driver's .remove is executed. If it asserts
a reset, the subdrivers will be unable to communicate with the hardware
during their cleanup. For LEDs, this means that they will fail to turn
off, resulting in a timeout error.

[1] https://lore.kernel.org/r/20240123215606.26716-9-luizluca@gmail.com/

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/dsa/realtek/rtl83xx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index d2e876805393..a9c1702431ef 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -290,16 +290,13 @@ EXPORT_SYMBOL_NS_GPL(rtl83xx_shutdown, REALTEK_DSA);
  * rtl83xx_remove() - Cleanup a realtek switch driver
  * @priv: realtek_priv pointer
  *
- * If a method is provided, this function asserts the hard reset of the switch
- * in order to avoid leaking traffic when the driver is gone.
+ * Placehold for common cleanup procedures.
  *
- * Context: Might sleep if priv->gdev->chip->can_sleep.
+ * Context: Any
  * Return: nothing
  */
 void rtl83xx_remove(struct realtek_priv *priv)
 {
-	/* leave the device reset asserted */
-	rtl83xx_reset_assert(priv);
 }
 EXPORT_SYMBOL_NS_GPL(rtl83xx_remove, REALTEK_DSA);
 

-- 
2.44.0


