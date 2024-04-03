Return-Path: <linux-kernel+bounces-128993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C038962D2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EDBD1F238A8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85163D98D;
	Wed,  3 Apr 2024 03:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ofLRt8vF"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DA71C684
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 03:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712113864; cv=none; b=TQuOsVXEPHMu9EanZdr9JQveVpkbEE/wQGPavyNcCW4AyPq/Jqive0rn70cJSWC/QE1GPhawzjK/dyIsrY3JMqG0FYNcdCcSz1b132CQZHCzPX727y3pBtxFmPNgfDR2L8QiNxA6oC5hkY3GOB0F9pIokJiRlApJDYPzd/e/vVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712113864; c=relaxed/simple;
	bh=OuT4Ms0hyGHoF8Nrz/OiAPjZGEMCazNleVYauL/3yDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y7UOSafTkT/MZdyNW3PI5nQX6o0bqzctEomijb6og/QJX16Qwaf1SgGKa/gWK1ccRqkODThnOKLHPCn3v9TOYuR7z3kaUJtUFK3cmcCAC0AMr18BtmKeF3bLLUMEx3ub6q140RjHEkbGmEeGXc/lNYMwAbTIb2DsaksGGkyGrk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ofLRt8vF; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d476d7972aso83967201fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 20:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712113860; x=1712718660; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wt3FSX8GBzUAFfEXsSOq4FgRCMLSgIuXafkffb5+jtk=;
        b=ofLRt8vFpJqVDqaPKzSIUvrWGf0YGFxd6WrCcYmBh/+0ryuhUtrX6DTWqJW/ANtaLV
         36iK49CoHthZd7m3YHsiGGnytQgg7LuNeVCypGCbZj6EvPO8o3jmBSN2CT/aW0xKUxHM
         +mB8ils00Y5/esC0g2TI9a90TQi6j5wGhv8WudP/aXHUhlw2kRciMR33/f5xHYTef+O7
         d3yympNL6YeSsdZM4CR2m3KQBJgElXjwHdrcTrW/Lv/jrNt+r/rE/tEE5HKggH8U8VRp
         kqG3x7xUF6VLP1EMTXEB1T9j/gwYXK/NNDSp+2CcaACw5oCRA6veo2aabhJzPewmxoY6
         nfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712113860; x=1712718660;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wt3FSX8GBzUAFfEXsSOq4FgRCMLSgIuXafkffb5+jtk=;
        b=F0ED8nkKxA0Q/fKz1rxDsD9ElMxg2SGcz1LJ2gcyO1wYGO4W9emzst8zFvHzfl9LFO
         ah2qO2mMTUrh+lb41gw7Ei9GPq+JnfMi2DPEQoirvD8Q3AS95kVBi4Bhwsd+Ed75bIp8
         wQD8zT3mRrsQB6YomGZh6fCmjwOQ6HU8ujmPpmmJxA663Ze+tsaSGsDuX62HBXwdoUS4
         tznvZDKePi1Q64uO72KUMbLXenolqUyqvw1Zg4FlJ/Z9gyrHNiwMS46u5NvmWT4YxUy9
         72CSqhd5uGsm17c8ifd98D5T448NM7cCCxoUAqgEl7eTFYkwnRsIPJbg7ED+tHHUgTfH
         tVUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsrIF+S+25OHoBY3DnEMXfbz0wU/rbJBY8edGn37YjQ+DcnW0wN5RedYAeAu6F44LxqA0Z5CIXzqnp9NfYyJwoFBxecsLcutAATxZS
X-Gm-Message-State: AOJu0YxELUb0kQmZxKMgB953n0Mmlux9Nfen4ihx4VN4qXqvvfAR5Gi4
	DOmjrejbfbuo2aVyXM1NWydKevBFr5XmuoyBX4d6VQ64IL1R1yMLI9Qv7YYVPUg=
X-Google-Smtp-Source: AGHT+IGRrhrBaYek4okkBS1ZQ287krmrf/K/uKSBMtjwg2p3QX38phzQHFOMG7BBJEC+YmYgvlaXwA==
X-Received: by 2002:a2e:82d7:0:b0:2d4:35d6:1984 with SMTP id n23-20020a2e82d7000000b002d435d61984mr9587317ljh.6.1712113860661;
        Tue, 02 Apr 2024 20:11:00 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id k11-20020a2ea26b000000b002d808b86073sm1056970ljm.78.2024.04.02.20.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 20:11:00 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 03 Apr 2024 06:10:58 +0300
Subject: [PATCH v2 2/2] soc: qcom: pmic_glink: notify clients about the
 current state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-pmic-glink-fix-clients-v2-2-aed4e02baacc@linaro.org>
References: <20240403-pmic-glink-fix-clients-v2-0-aed4e02baacc@linaro.org>
In-Reply-To: <20240403-pmic-glink-fix-clients-v2-0-aed4e02baacc@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=OuT4Ms0hyGHoF8Nrz/OiAPjZGEMCazNleVYauL/3yDY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmDMjCXwTVm+bM0YQpPVWy5ETBA6Gi5jc9LfqWv
 5Nt1GI7/Z+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZgzIwgAKCRCLPIo+Aiko
 1UyRB/9ejFH+A6ef/HfzL5au8cQ18WNJmIeffRbd0reatZmZj3ESY/KS443GfOi2FZbI/suogka
 hKEq9z/8bKGBYqjoQfHg4xOxJ/XtOq1iehzc3nZo6UZxLL024+MnuuXJO+opAGWE5ygpyThObEx
 v4p+fjExM/9J9Lf0Zx6GkSpAN0Y0d67vBFITKYbtcRLBVetRMIZs7/Oijcg+Q92VFGrpiN5ygEC
 15bXWXtkt5l241yZk3YEPm7CP0oNZuSo7KKDaail5NdjgnAocJjNUkluaBYLxM9E217oL/qzSbc
 IRnk5Y1QEOYWNRH+93XG6D4nKDhA8z3qDXuzpefTliW3PGaZ
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

In case the client is registered after the pmic-glink recived a response
from the Protection Domain mapper, it is going to miss the notification
about the state. Notify clients about the current state upon
registration.

Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/soc/qcom/pmic_glink.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index 2b2cdf479654..e85a12ec2aab 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -83,9 +83,14 @@ struct pmic_glink_client *devm_pmic_glink_register_client(struct device *dev,
 	client->pdr_notify = pdr;
 	client->priv = priv;
 
+	mutex_lock(&pg->state_lock);
 	mutex_lock(&pg->client_lock);
+
 	list_add(&client->node, &pg->clients);
+	client->pdr_notify(client->priv, pg->client_state);
+
 	mutex_unlock(&pg->client_lock);
+	mutex_unlock(&pg->state_lock);
 
 	devres_add(dev, client);
 

-- 
2.39.2


