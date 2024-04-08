Return-Path: <linux-kernel+bounces-134687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E215989B509
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FFAB1C209B8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259C54C63;
	Mon,  8 Apr 2024 01:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BibJ47Gu"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929FC811
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 01:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712538263; cv=none; b=FYFf3RphZQSofXj8sUwl3oqLiw58PjOj0PGSDMA/EQy5KTzPbM07YI4LUcZ8kPA0ad4i2JfTIzAfHFZhB/oJAGOlTw4CbPoYlJrKuXcF2obG3zc7OVVjWMJTSMNQ//g7eBLDUePAy5Ab7QwQn7A9NfzKJ/FTO+5tfouSaRh1fg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712538263; c=relaxed/simple;
	bh=12T0foa9TpAG3Uf1Tp0wQx8JMYcT/6X8Xh9Ou+tRPFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M2FgfqAunPFeZQrGOUwiCqEgdpTEJkuuYJhIlu9V47opXi82xNcfx/H0ZLYl11x9Q3qk5ShZN/WmD6Qgg6AVokAJUR787W8A0f0YF6Gqy/y0ZjAg8cZGB2BHyd0tXys59dZV7biGkoeCeIjTCZit7Oh1SFaMizCVsyS3kao1C0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BibJ47Gu; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516cbf3fe68so4710687e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 18:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712538260; x=1713143060; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+80ujqs2n4MhvbTeh1pKk29DikjMVcufqK0a2xgB6AY=;
        b=BibJ47GuvuvKnCqbBmdhqa0vjuQPPB8/yIgIp8dHTBe5lhNbWCg5WfF4slzD6CxN6E
         xygsEu8hqXohPNtYsYNhRplUq5MndWN1IQYNn5x0B63igmQdbva4MHS66EOjkEGBLp2X
         kdK0zlFPQu6syi4KT/X8lN/twiph8pEQXOdEq6HQBRyx7zIoqLYGqEQt1equFs7Xy8Kc
         0rNO0mKE39WLKFrIrwFltqGK/6Ffc5YGzb1zPzwA0x0oSl7Y1agYHJOTp/3Lg/lkl4Tk
         zT343dOfyd63m8PaQ1DMTdHbqZqZgixua7hbRJTkDlovWSsFvF4uAgKfL1zeGSM+qKqI
         GvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712538260; x=1713143060;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+80ujqs2n4MhvbTeh1pKk29DikjMVcufqK0a2xgB6AY=;
        b=BNgBhYbMik9SRLf0zDui8JaC3wlsezieloRpPe9nT2FtwVKNE8ynwAronOsmKzniYE
         1VgIG+BeHaQZy2Q6U3b/pr0hB6u/ZG0xlFf8TdJSDTCUPm8sDbDb8XwRhzKA01z8GeEJ
         xJ+VsWVIkeeZLGekdP50CaYsB2zBHNbkkI+dc0ghoUw6e8psIKYjWc7Yf2+JQ1Ty5d0R
         BYh73/Z5bWyvWGNBYfBxf7gTfGxO25h8T9XuALb3b7sGYXz2JCXSW8kR5rXII9bS3F4I
         /XQ2yMJ3J06MRdOJxUgsqD8rrZYFWcZO2EdKRGBVTf5CK4vR2x74dQMvXyx5aMFYUzDB
         4z4A==
X-Forwarded-Encrypted: i=1; AJvYcCW9NXOhP+bnZLBAEGWpPgsUBa61sdxjsr29O1enfIJbnhflxv/ePeTex1Ij96923JIDdFx55WC6kd/SCu0MvcbUwZCJ/hT67cxUiakk
X-Gm-Message-State: AOJu0YxBTh9gR5fkD4icLC3LWNAdTh9roNF8yf+r0oAP/iePOfk0Q8nQ
	YdoQ11wwTr0cpuZuVnIRh7CohJhPN2Uk1DL7VONMMV6UDdVJSKfXxpWfbfWLIRk=
X-Google-Smtp-Source: AGHT+IFPI9ElZoAigAzDwykeRoQWoOIRMt2gfxcdCfQYNY3kJcBMqUetR2u2JGuOOcNTwYY3kv2Txg==
X-Received: by 2002:ac2:47f3:0:b0:516:d187:8e3a with SMTP id b19-20020ac247f3000000b00516d1878e3amr4330331lfp.55.1712538259768;
        Sun, 07 Apr 2024 18:04:19 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id m29-20020a19435d000000b00516dc765e00sm674034lfj.7.2024.04.07.18.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 18:04:19 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 08 Apr 2024 04:04:16 +0300
Subject: [PATCH 2/3] usb: typec: ucsi_glink: drop NO_PARTNER_PDOS quirk for
 sm8550 / sm8650
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-qcom-ucsi-fixes-bis-v1-2-716c145ca4b1@linaro.org>
References: <20240408-qcom-ucsi-fixes-bis-v1-0-716c145ca4b1@linaro.org>
In-Reply-To: <20240408-qcom-ucsi-fixes-bis-v1-0-716c145ca4b1@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=12T0foa9TpAG3Uf1Tp0wQx8JMYcT/6X8Xh9Ou+tRPFU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmE0KRmutE73haDGp2zGC66J4lAtn6A/RjUlYX3
 hu58hfeYLCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZhNCkQAKCRCLPIo+Aiko
 1ZcgB/4iy5BKTnES0i1JSytr7sCptdD4nu1yE92kXxHGWQHGwE0pBFU4BevsFlOwQb68LFzeJ74
 hSTpkW6pdgObo/rAaAzJrSlxVrHU88oe4Hyez61KRPf8RfZ146EnVhGyBU03f0Fah3Rya+8AoUU
 UL9SQjKIjTJkSXst8KZs7detqABiWlmCIKiVbnTu79OlZUqZMLcEZcrtXhLEf/x5lK/WU4pVCkr
 Teyptzn5gRANVQ0JN3XNKmZVNKgAQTA0F8EVZcapHgP7bWsCjNq3mC8zyn7PJrQcOySalZkbZ/D
 euJcCbzfNc8AHGHk6PAB602xiMWpmBib2CuecYB/jCb6aUyr
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The Qualcomm SM8550 (and via a fallback compat SM8650) firmware properly
handles the GET_PDOS command, it sends the CCI_BUSY notification,
and then follows with the CCI_COMMAND_COMPLETE event. Stop using the quirk
for those two platforms.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 9bd80a2218e4..9ffea20020e7 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -321,7 +321,7 @@ static const struct of_device_id pmic_glink_ucsi_of_quirks[] = {
 	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = &quirk_sc8280xp, },
 	{ .compatible = "qcom,sm8350-pmic-glink", .data = &quirk_sc8180x, },
 	{ .compatible = "qcom,sm8450-pmic-glink", .data = &quirk_sm8450, },
-	{ .compatible = "qcom,sm8550-pmic-glink", .data = &quirk_sc8280xp, },
+	{ .compatible = "qcom,sm8550-pmic-glink", .data = &quirk_sm8450, },
 	{}
 };
 

-- 
2.39.2


