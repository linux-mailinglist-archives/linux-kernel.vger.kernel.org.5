Return-Path: <linux-kernel+bounces-125229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88F2892278
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79531C2575A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8AE134412;
	Fri, 29 Mar 2024 17:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0o8yK8h"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB109537E7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 17:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711732265; cv=none; b=CyiHN64ZGNNrOUnZkNp5sdD9mGgzlPUGrDfLH/dJFWqb3CYAgoTQN0CO/EWhS9VSKaWxnDhxI6Gof3E8N5RvGII5VTF+8E+GZN5IalYDiYkzJ27iB22sCL0p7jzcHf6vJ/kbedBT2JmhDYZXCFljjeO+HOeq79N5MfeQsQxGdzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711732265; c=relaxed/simple;
	bh=iVuldd3zGuXruFJTlBanSQRHUsm+LTMasUSVVj1m7E8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QPzhwn9LE0/q0SznkRKlDeOv2BtX5hg4/lMmSwxCWvfshKcZFEDqGCLxD1NuN+JCzQpqV3v4WpNl29rk04B4pi7QWvOHBU8L9q/hSUTROMJ0BmSzh2apPritChpxlcluoIRhZbDsgzm3EY1WuWMfhMZzFQhuXUzSP8xmNUfAsJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B0o8yK8h; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34261edaf7eso1464211f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711732262; x=1712337062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JxYuhYq68BUhDKF2jZeLoM0cvM8ATn+yZuvCJEa55cQ=;
        b=B0o8yK8hniWca9euLOiPx2P352Xw4a/sKnGXJBOneSpFaHyTnb1zmEivIQ++/J5lrP
         FrJw14FMz8pDmGxwSE+93ezDfLGWGSNA4+H2/Ifw9N5nAZoWEclt0qCDqcSnWOHtuogo
         WCLwczfrKV8iEXncgPAGCRfQNvJToLTt4YcmkSu3TX5UehwFHBcjUdOobN4szQDDUUYL
         NI+uvfLXNJUVXnFJaR7E5cK/EsrnEJsdUYEH/6/yATaQWwrr3H+71ikjueB5dDdW6Wgx
         vkFVvDG8SQA9TFawONp39+tPwZ8EAlrLsOSqrPhoHYaUdXWdhQgl9P6E8Qxxy30rX3OO
         QPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711732262; x=1712337062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JxYuhYq68BUhDKF2jZeLoM0cvM8ATn+yZuvCJEa55cQ=;
        b=QSVVQk4kQZFedpkn5QsNcpq7TFv+cQASjlc2TMmnipU5tv0go3sPiFQCUVfQb9NU+s
         +wkM4ywvR/FQeceRbAIAa/ORvNrR/62Dsn8rUP3E6gmiOC6SSH5Yz2QWLVxCYFv/QlLF
         2gF9nSaiOklHy8d/irONjail1TiT2s7MJLlA4WicocY95s+6UO1/eHTjZM8eJ4UlT3i7
         wMTHzu1+h5HyYtjeF6Br2wPG24faOOGaDACuaw16Q65OTKJXIepRLKmWYXlFrWL3lva0
         6sc2nZbi1+JP9tW43o8EQgoaxv+LniTU5ury16a8d6WIdvc5Sxap/r98cHfXpHwLJGSk
         ISuA==
X-Forwarded-Encrypted: i=1; AJvYcCXbdg4hSQXvwxjxttcy21e1b3Uh/VXvSICI3+Hu4z74m5gG1Ookgx1G0WeiCHk8PlGcZR2hme9vBR3TKNNLSCsI4fwwIEKhvsyypjL6
X-Gm-Message-State: AOJu0YwZ37seWWVMA85OTEs+o6raNeLTKhlJTJAwdKuuuTsnITbioP/9
	5pyj5g1WWCCH8S8IPyA0EEP/CL3WKxEvnXoTpEqA/opcoC6kuEiFyIbE4ulK8a0XO1k60AEOcqE
	p
X-Google-Smtp-Source: AGHT+IEql1KWL7gbjAJiEVRC+a0bTlmY+nDECzR4kdrCYHwhtXISgDRBSpeCfAYP3beUvld2/mnGzg==
X-Received: by 2002:adf:f142:0:b0:341:7656:d358 with SMTP id y2-20020adff142000000b003417656d358mr1907415wro.38.1711732262206;
        Fri, 29 Mar 2024 10:11:02 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id l2-20020a5d4bc2000000b0033e7e9c8657sm4592161wrt.45.2024.03.29.10.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:11:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] staging: ks7010: replace open-coded module_sdio_driver()
Date: Fri, 29 Mar 2024 18:10:57 +0100
Message-Id: <20240329171057.63941-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use module_sdio_driver() instead of open-coding it.  No functional
difference.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/staging/ks7010/ks7010_sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
index f1d44e4955fc..8df0e77b57f6 100644
--- a/drivers/staging/ks7010/ks7010_sdio.c
+++ b/drivers/staging/ks7010/ks7010_sdio.c
@@ -1136,7 +1136,7 @@ static struct sdio_driver ks7010_sdio_driver = {
 	.remove = ks7010_sdio_remove,
 };
 
-module_driver(ks7010_sdio_driver, sdio_register_driver, sdio_unregister_driver);
+module_sdio_driver(ks7010_sdio_driver);
 MODULE_AUTHOR("Sang Engineering, Qi-Hardware, KeyStream");
 MODULE_DESCRIPTION("Driver for KeyStream KS7010 based SDIO cards");
 MODULE_LICENSE("GPL v2");
-- 
2.34.1


