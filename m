Return-Path: <linux-kernel+bounces-16807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A3F824428
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3E11F22982
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D750241FF;
	Thu,  4 Jan 2024 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NiiynNiA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620BE2376D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-556ab8b85e3so976015a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 06:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704379949; x=1704984749; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMnAxGfIQiueQAO1wNW7BfacgEmomUHtgI56o8wKSTE=;
        b=NiiynNiA3Eay6BKt3cpSbKLlds4Wk1/7Vsh9mBxzi8ux7VcshaF/nnTCx41XmFAApu
         OTalK9K/bYogtJlzGrbjEfSjOZW9ycMy3xlsjsXcUCYOe/CypY7PMWdRkpgZlzSpCNyL
         oBdU82H6TTZSMEY0zdsGODT2LyBrBKjZgK3OOYG3dP7wMTNehQI0uZ2uYmi9fKmCiJHb
         MbftYPf5SDZr9uQesQJ+ZpSK67+CNDfwLcFZqtL+D3f1A/ujKAisK4sXkdZF/EEW0APM
         Hsi1kRQNPtAsyL6iLFT/vFmmIMoaRniJXxBZpjL+Wgej040NLQxsdz/yk03nVFC3Jooc
         4Q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704379949; x=1704984749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMnAxGfIQiueQAO1wNW7BfacgEmomUHtgI56o8wKSTE=;
        b=M+GFFPTrGuwS7c+Aw6nQpziMkcGfQ3fyTw7rOKrzx/uCkbd8l26qAjfseINgbVCt6n
         0zMcikhkR+kwXcjLrUVHT6yCCZG4Oz3eW9qZKZElu7vLgRxeYuGTo6chMHbCvOnDQasQ
         qBaFvLSElTVmEQNCe3lcOW/P7CJeEUwbiYcH0u0bErQrYpkVoZFt5awfDvJAHE1Xs/dq
         SATj1v3N5hl/0DcVol2iTK2Z5+ZmetZObT3viVzL/YJ8skPnT3ZrGc8Koz38J9Ainmr+
         /owUoa8zSHTvtixBNBhZ+2G9HYif7gssR/FRi5TvirzmKAIt2+4TKpc+mUXWqCAVd3jI
         O+lw==
X-Gm-Message-State: AOJu0YzTIh8ZUUEobtUXaoN1CQ7zku1hd8rNDozhKcpRYAzWe2r1JRaO
	H1FZA3OXl5o/1VI1Hlw7ikZJfDxdJPRiV4wzrcFkKnzQPAw=
X-Google-Smtp-Source: AGHT+IHxyKF/EBhfovNxx2TGbkmvEiT1DyA5/F7/jc3DbI567b0y9mKHoTS0J4Otk1IiJ8CKBJ/Yxw==
X-Received: by 2002:a50:9b54:0:b0:556:e101:535 with SMTP id a20-20020a509b54000000b00556e1010535mr827944edj.37.1704379949460;
        Thu, 04 Jan 2024 06:52:29 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id k24-20020a056402049800b00555e52fed52sm7970592edv.91.2024.01.04.06.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 06:52:29 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 04 Jan 2024 16:52:12 +0200
Subject: [PATCH 2/2] phy: qualcomm: eusb2-repeater: Drop the redundant
 zeroing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240104-phy-qcom-eusb2-repeater-fixes-v1-2-047b7b6b8333@linaro.org>
References: <20240104-phy-qcom-eusb2-repeater-fixes-v1-0-047b7b6b8333@linaro.org>
In-Reply-To: <20240104-phy-qcom-eusb2-repeater-fixes-v1-0-047b7b6b8333@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1320; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=7AliMaAdWROGg3fLvttKSstNZBNXuERKP+7k1vLYxm4=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBllsYpqEYuM2KFJzq7R2FAgGA1XjlIL61uSTuld
 ETLicqGGsiJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZZbGKQAKCRAbX0TJAJUV
 VkEmEAChX0fzzAbkg03l5iDp/SItTko3VZiDt+fJiOAGDqb7RIzW/6ArWDo/rAuhn2wZB/27VKe
 Y9i+hnWURv+aQRwNm5QWPYTVo0v8HL+PndukPgbiFMW4muElu+5haOTMvRNz3hlZpVKPbGI8uq5
 AdhIR9bDhMgZ0QSjVTHYUJ5WbdXk8Rnrz2eGfFh7Rski5mwZ/ohmdLZpfKo+Yo00ifhCZnydKQP
 yjnXj3pvKMecr5pv+XTcDm03VV0FUz5kTCS4nohhfvOxx9Uaw6UoTh4qYZIMmUNLg3TV8vgQxrK
 ykUXwjoToQ1v/53g1z55TuC49hZ5E//K8zhJUuzBnVeY0XrTnd0ANFna1+wdGxROhmuDAOynmC2
 pqPZqohLa8xDZsjQdhSk26YGbCsSZnXEOOpsbg6JiuTQHdSM9D9Vms72w8Tw42HYD3UTp4/aDDC
 L3Sjar4ix9hnLqz6UJXit/z9ImfZ2JBaj0ukTGLbPRsJ83eT9F4nYm+I8CyuoQ5koZh8PbkvdRb
 hrIwocC3wdlw8IvuddLdX8DW6gnflCONLYAmpceXCtT6baaWRlTjm43hFmzDbpT4cy1Fm7uXWMI
 Md0oThk0u7OHeRUJCFE1dlRqzkZIDoliMWbPo2LGr8212BBNsHplafdVeMCUUxrNo9wP+I7rWHX
 tMfpJMiu+mZjgsw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The local init_tlb is already zero initialized, so the entire zeroing loop
is useless in this case, since the initial values are copied over anyway,
before being written.

Fixes: 99a517a582fc ("phy: qualcomm: phy-qcom-eusb2-repeater: Zero out untouched tuning regs")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
index 5f5862a68b73..3060c0749797 100644
--- a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
+++ b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
@@ -156,16 +156,6 @@ static int eusb2_repeater_init(struct phy *phy)
 
 	regmap_field_update_bits(rptr->regs[F_EN_CTL1], EUSB2_RPTR_EN, EUSB2_RPTR_EN);
 
-	for (i = 0; i < F_NUM_TUNE_FIELDS; i++) {
-		if (init_tbl[i]) {
-			regmap_field_update_bits(rptr->regs[i], init_tbl[i], init_tbl[i]);
-		} else {
-			/* Write 0 if there's no value set */
-			u32 mask = GENMASK(regfields[i].msb, regfields[i].lsb);
-
-			regmap_field_update_bits(rptr->regs[i], mask, 0);
-		}
-	}
 	memcpy(init_tbl, rptr->cfg->init_tbl, sizeof(init_tbl));
 
 	if (!of_property_read_u8(np, "qcom,tune-usb2-amplitude", &override))

-- 
2.34.1


