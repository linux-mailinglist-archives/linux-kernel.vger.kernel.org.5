Return-Path: <linux-kernel+bounces-5211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2D3818803
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C74328BD79
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD43E19BCF;
	Tue, 19 Dec 2023 12:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="D++LY/he"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D69B1BDFD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33621d443a7so4633162f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1702990315; x=1703595115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXaZD+3T2oQG88d8EDnJHjPY4JBEWSVAIst6eVjqC04=;
        b=D++LY/he+xX3ZEv8GlXMlTif0dh6zVXpxf2Tf/YZ7q9wSrxPeBdZQtGt403QSyWZz2
         494z3VnwuR97qVu1Sp8+NYb8FXJrPUz7zsZ9VLyHU0PZDwju7G5uFwY5W0/Pu81qhobd
         MV4dT1qdyJ38X7DCYdOnAZmcXrRN3DsE08T8cAgMjBgMrE5/uvJbDh1uw/cOBWu4t45g
         JZLqKAcycbOq7O3kDPMZIjE/yd5b6H0NRFXtRppCESRAN08Q7y9cWrjgsMlVxIzHxVQr
         +uGBfyhkoTYXV0u5kz9viMl0U+TiCKhIx+2SqfK00TWC3NntywbfcvgcDO8Rl01CvBL/
         SMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702990315; x=1703595115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXaZD+3T2oQG88d8EDnJHjPY4JBEWSVAIst6eVjqC04=;
        b=oCFF/6VJ4PuTmR2OS760dVmJf4yxDXlAWBCvFRoN8tQq8tZXR6UObTZ02qFRqxofl8
         jgdHCkUgbi+a2Y8STY6iDnHiuTFi8d78gU9FYG8j4Y2cSyk2HYdeZAcY7BPz1n3w5OOu
         qnx7cjr51ad7/XrqVEVzgC4zpFsMv+nBow76/HhErZAO1ZTK2+E90QDIbbEOtWqOmNP4
         5z+al9YHRBe4wfqsl0st3/rLNPLNVjCeKDKBXpuF37yZA3NXxbcio1JCP2n3eX9fF0Yz
         0LONSg2oTSFzNvnV+SR3b9Ee1fn1e8cM663MjCgWHrLPBgau1XPnzjq5tY6O5Fdp9mta
         Bv8w==
X-Gm-Message-State: AOJu0YxX2Us0Pge4gXzVq23bEp6iJi5bZktqpvoHjxSzPFSqOuxFYoHZ
	/p+bX0FBe5Ik7CyI1LYfLr5Tig==
X-Google-Smtp-Source: AGHT+IFdr4D/yjVzRUJrpTqsD/Gy+YPCJ1wdOfpT5VmOvj3aHsMzwhymkD051zc3rZmSk2K9XgHv2w==
X-Received: by 2002:a05:600c:1705:b0:40b:5e21:bdd4 with SMTP id c5-20020a05600c170500b0040b5e21bdd4mr9170151wmn.99.1702990314979;
        Tue, 19 Dec 2023 04:51:54 -0800 (PST)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id l17-20020a5d4bd1000000b00336607f6630sm8311579wrt.47.2023.12.19.04.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 04:51:54 -0800 (PST)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: naresh.solanki@9elements.com,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] pinctrl: cy8c95x0: Fix get_pincfg
Date: Tue, 19 Dec 2023 13:51:18 +0100
Message-ID: <20231219125120.4028862-3-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219125120.4028862-1-patrick.rudolph@9elements.com>
References: <20231219125120.4028862-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Invert the register value for PIN_CONFIG_OUTPUT_ENABLE to return
the opposite of PIN_CONFIG_INPUT_ENABLE.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index b925789a035f..fe9545c630a2 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -715,6 +715,8 @@ static int cy8c95x0_gpio_get_pincfg(struct cy8c95x0_pinctrl *chip,
 	ret = regmap_read(chip->regmap, reg, &reg_val);
 	if (reg_val & bit)
 		arg = 1;
+	if (param == PIN_CONFIG_OUTPUT_ENABLE)
+		arg = !arg;
 
 	*config = pinconf_to_config_packed(param, (u16)arg);
 out:
-- 
2.43.0


