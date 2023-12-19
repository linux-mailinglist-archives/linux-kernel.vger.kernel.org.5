Return-Path: <linux-kernel+bounces-5942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43F48191C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60C9E285F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356163B79C;
	Tue, 19 Dec 2023 20:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KrOfjr8H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1366439FFB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 20:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40c580ba223so62832615e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703019337; x=1703624137; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5pi6I7RcndY+6sf6sOBcp0JxUojgCI4aZoyVC3XiObE=;
        b=KrOfjr8Hw5NhNANKrsypq8cDeQMWH6MyZIXCIuok8d0KByQRT6g3EKVtNMihpT1c7k
         j9EI3NzIH1zksesvu4AXgCb2Tp0EMfn2Kbmby9xIhRGPKuQGUrS3oEZRYGQS4KBMbslz
         H72OrCdLUmqVFRVvtmj5jSHG4tgxwhr2r+y6bavCFY5hT3N+kWW2zHFKbDk/3kQZYleO
         srDzZqg/Nx99va0e4xsKf/LkxbTGG+UJTdQkHtmg7LemNIZABz236y5vZZWJ706H9JeT
         /2KPrUJULIeo7wGbPPHvNUxZOy9ziHHGBO0ZCqkjfOOqHQl+LEt0YKueEhODgobHNmEH
         2yXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703019337; x=1703624137;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pi6I7RcndY+6sf6sOBcp0JxUojgCI4aZoyVC3XiObE=;
        b=IKkyNuyEhGsC5a3JjPHbaDcR7mdqfaf/rfmtzLmz1910vuiFJNxlOJPypjT2PdedSi
         Gi//USHAu3eC/thJaDSAYlyVPvWMehsjOyTav4nlfAkre5c2R6EkZfXOUJ66LMqapB/i
         fmtSO7iPQboZ13b33I/8ilElhmDb05+XsrwNYPsqfGhr8GI0BhPO2N8lelyMfZmp/yM5
         O7uz9kJFtmgtEHDzl5tij07oo3Onkuzhzf/YjWEMaoN0w+20G20fiY7JTRDRP2F+K+9q
         pOWjxBZRzOZeely9sKKDdnHUaaLM66p4gU20id7gfNyLT56ZGBhFpir+kyuZnYIG5JCc
         RWgg==
X-Gm-Message-State: AOJu0YzCaYFL9jz4gO+807s4LaAt6MmwAkWff03Yula0t2NcqtlJ+yVG
	wIcqhw4r4c7puOdx+Lbr5QzI/A==
X-Google-Smtp-Source: AGHT+IFrs+t21q1UFgsRZ5h6S9jToMWIlbzWMCwBBw1ahionkg6Ugq9YfDvjKJ8/emZoegeUwMBHrA==
X-Received: by 2002:a7b:cd96:0:b0:40b:22de:b89a with SMTP id y22-20020a7bcd96000000b0040b22deb89amr11265178wmj.31.1703019337194;
        Tue, 19 Dec 2023 12:55:37 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id v16-20020a05600c471000b0040c4886f254sm4460701wmo.13.2023.12.19.12.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 12:55:36 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 19 Dec 2023 22:55:23 +0200
Subject: [PATCH 2/3] phy: Add PHY Embedded DisplayPort mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-x1e80100-phy-edp-compatible-refactor-v1-2-f9e77752953d@linaro.org>
References: <20231219-x1e80100-phy-edp-compatible-refactor-v1-0-f9e77752953d@linaro.org>
In-Reply-To: <20231219-x1e80100-phy-edp-compatible-refactor-v1-0-f9e77752953d@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan@kernel.org>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=548; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=iGeFTqzs15DB20OSaW0GNTWB3LDTKk0WKgnlPfHO7SI=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlggNDVuSQOMzcFMsNOLBAexyTcim0YGusXvB5u
 jtV0tRRs/SJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZYIDQwAKCRAbX0TJAJUV
 VjEmD/0a8VbhWcTkFszcFPFquWH9IPyH5K5oDIV/dPNZ+44skMr2+ti/Y0qAXs+79xVP9Q47tAX
 zrm9/fsKOiSLR2MQsomKjxJMiN+bsM5KE9IOHAX1mtuoS/lblh5zfxGU4s2hPl2lqp/sdzIs2zP
 zrDYCN+vUzxGOamzFxO1sHVCClM96jZByM8H70ja8QpSlFKE2HVMESjKGWhD0Z9fCNEuNib4jj/
 YZkqVVrgHVcUMbNB9+AEz7S40HP593Qoy+4mQieuEd/V0kKzN2vczXWsrn7XSY4NhIXqMWRfGUk
 vidV6VL5SPxGO/U32RkksOEoXWd8l/SvOE3afVq0xH2YuijF9BGRWxvhOPDV77mzTihzEWUisNP
 qiKRMY68h2iFbrUk9VprYmXNNHXNf7Xus9hcHG4i6l9p5LsFW+fsmTMHyjYxSjph/OGo+oyqvUB
 nJ0+8lL62dk+5Q7aawayJBsDvUjd7EapvNcVhaF4WnBLOdUmH/BwcgOXoR9sa0TQYYMHTCzsiiV
 29Qqv+OOHcUhVKro7liyd4MjyhfoYgYKMlrX0GbFNrgs7Td/BmbBN9yHF9P2sGy344D+/F96O2X
 7C5ahwOePjOVySntjBcsLujiVKUuFfCGAe0Kv3mzuip60VP7n/AqO2w6VEJZsPz4YnN20o6SVn0
 VxTfcHo0CtsRy0A==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add definition for Embedded DisplayPort (eDP) phy mode.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 include/linux/phy/phy.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index f6d607ef0e80..bea532711906 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -42,7 +42,8 @@ enum phy_mode {
 	PHY_MODE_MIPI_DPHY,
 	PHY_MODE_SATA,
 	PHY_MODE_LVDS,
-	PHY_MODE_DP
+	PHY_MODE_DP,
+	PHY_MODE_EDP
 };
 
 enum phy_media {

-- 
2.34.1


