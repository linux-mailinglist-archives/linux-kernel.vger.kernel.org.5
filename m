Return-Path: <linux-kernel+bounces-156631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A35C8B05FF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7465284EC4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F65E158DCC;
	Wed, 24 Apr 2024 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M/MM6rWP"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EE8158D9A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713950883; cv=none; b=liPAWKJY880kYzAh7h5jIaZXF6rO4pXXlSK5PUmAzw1YkWWUNQpaIGWMYt1SDF2/4BoEEM1wDYoETBFuSfZzAX4TE+BdO2hI6BT5YNu40R3ljrPSxq+S1qRWN58v1r3qu0h3IwWOLVercuZvHYbd2CaFdtHDi2jvZKzXHFXFP00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713950883; c=relaxed/simple;
	bh=OSaaTloV3qTUv65Q5MV+1+bKbdFYs/aBBRehChJIAYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cQYGzVneGhwXeVvsb7+Y9eMgSdlCllnINIEn7ymEXjwYqqNOlggntG4xM62vHejVM505EU0BRLqN64wcuM0RhMCYZWa2EL8wGeUwFvSJgET+hTA/alzGwcrDJgJBWz8jmBy5pZwJxQ3xq/HSIAr58NUy9vlju3GmMYVMIjUKcO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M/MM6rWP; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2de2f5ca076so17340121fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713950880; x=1714555680; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVP3aG0NcRA85ZVF6oXusqwv7tzNPZN1nlYmyccmDwI=;
        b=M/MM6rWPHGe+1z1kG7WfRbKOpQIUtYrHJ87JpSebFhc1hmeK3hqJ9IWXZPVaOarKGz
         ONCb35woilijVro74V9kx0K8hEeGkewZVypLPyXNqtdlZL28m6Ht+FXwQr85ndc5BTlg
         KJbAvdOIJRqH1U34kMMIOtN219X+FXlX9kTDxlPNYEZxG3h/w5FO76x72KmvuP0CPIBq
         qgbEnWNQaNL7APJ9DW8KgSbIfjrjNBSe99+lJvRdONWnnJ+Zpd//gvSiSXD2dp9f7deh
         gLtVnMJgYuB+uwY6TgFzmOTFlkcaMeKIY2YBjrfEiisC3Kcg0eEV/kIUfUiSODZG0Jl2
         qsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713950880; x=1714555680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVP3aG0NcRA85ZVF6oXusqwv7tzNPZN1nlYmyccmDwI=;
        b=fexFVWJ1EKpNx6O1W5j54+tmiWiOREzhKVhjOhXWBG3N3VwarhIt+SRjb3SPCzHycg
         c+J5wfopl7ZOCRVjNBF10UfM1bxpU1tJgnaihOgSvXMb+rmtaCiYBQa3iha7pYXyeVKE
         xUSAnKzjW9Uk4Sl8UEpsqEzMSpoICjEicIyrhFnApbqkseGexiS2W+AcjwLa+BTe6Nuk
         yd7Oy9/cINdzk+kBq87ZnZIzXpjNyGm/MvSUnp5vZycVJBvlzqeBFUh6a+WdOeTDxFbY
         rmSJrxTdo6lgXy4GeBsGIuHx5rSRhh4mm+3Ujl0+aL3Ogz/4Rdhn2VSZqjVZrrYO/1ru
         HiIA==
X-Forwarded-Encrypted: i=1; AJvYcCUG3nbn9PjF3HY2GjW96/V5R5h2lTpi9aWoA9YcQp6XmyO+DJKWj0Yfvxhs4VKi70DV532+uO/taGu57fYSYeSTsHa1gTsORDp5b/l6
X-Gm-Message-State: AOJu0Yyq5beowbM+4s7RkMyZSH8T7agjwidgPiY2HlNoKcDvNPUxdkM0
	MaY0ud80sQ2+7oSV6EbRNb9j8MCINmEPH/gCP4ZXOuulUT+aVyMrIYRfwhwL8ZR7zaAu8ERxEv9
	7
X-Google-Smtp-Source: AGHT+IEHqr2lZGaBKa1MiPLKvem2gV6St90T7tmmwbeBqa+6DjJavqHtQEvbkp8gTXdere6jcfb+5g==
X-Received: by 2002:a2e:9a88:0:b0:2d8:da4c:5909 with SMTP id p8-20020a2e9a88000000b002d8da4c5909mr1025985lji.51.1713950879955;
        Wed, 24 Apr 2024 02:27:59 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id u2-20020a2e8442000000b002d8744903ebsm1916849ljh.68.2024.04.24.02.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 02:27:59 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 24 Apr 2024 12:27:57 +0300
Subject: [PATCH v7 1/6] soc: qcom: pdr: protect locator_addr with the main
 mutex
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-qcom-pd-mapper-v7-1-05f7fc646e0f@linaro.org>
References: <20240424-qcom-pd-mapper-v7-0-05f7fc646e0f@linaro.org>
In-Reply-To: <20240424-qcom-pd-mapper-v7-0-05f7fc646e0f@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>, 
 Xilin Wu <wuxilin123@gmail.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=OSaaTloV3qTUv65Q5MV+1+bKbdFYs/aBBRehChJIAYs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmKNCdlGg7OoLB653KFzavMEguVk4v/t+HfvrEv
 KuTkp88gZmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZijQnQAKCRCLPIo+Aiko
 1QhRB/wI8jCQzyswFja87BTkRioiKAY3pjM88Ho+fyDHUFV5p25Boh67bxlsLm8ryXPyDCexl06
 qJf0Ux+icXMAivSZNhXdhEXjAlK7IXAerNJuT3afPbKkmuZ6XTQTTV2R1UsqwLWweWh9RL2w5Ik
 JM3mRfbQ5RUFuOimZM73P7UXMQUdXy5/TpW4Bd9P40x4SgEfJ/v9WFPoc2FIt/Bf0jh1EA7LWt7
 2GO2kBGZzDZMpBgG/sGN6UWZrxNUpWST6YirsWIs9FYjaN60aitunxiCbCSOKSaQGgwNixnmU7C
 mDcqR98+7kCzvHPo0qzpKBzA/0y1X6W9zqCPzWErTdoMnJy0
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

If the service locator server is restarted fast enough, the PDR can
rewrite locator_addr fields concurrently. Protect them by placing
modification of those fields under the main pdr->lock.

Fixes: fbe639b44a82 ("soc: qcom: Introduce Protection Domain Restart helpers")
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/soc/qcom/pdr_interface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/pdr_interface.c b/drivers/soc/qcom/pdr_interface.c
index a1b6a4081dea..19cfe4b41235 100644
--- a/drivers/soc/qcom/pdr_interface.c
+++ b/drivers/soc/qcom/pdr_interface.c
@@ -76,12 +76,12 @@ static int pdr_locator_new_server(struct qmi_handle *qmi,
 					      locator_hdl);
 	struct pdr_service *pds;
 
+	mutex_lock(&pdr->lock);
 	/* Create a local client port for QMI communication */
 	pdr->locator_addr.sq_family = AF_QIPCRTR;
 	pdr->locator_addr.sq_node = svc->node;
 	pdr->locator_addr.sq_port = svc->port;
 
-	mutex_lock(&pdr->lock);
 	pdr->locator_init_complete = true;
 	mutex_unlock(&pdr->lock);
 
@@ -104,10 +104,10 @@ static void pdr_locator_del_server(struct qmi_handle *qmi,
 
 	mutex_lock(&pdr->lock);
 	pdr->locator_init_complete = false;
-	mutex_unlock(&pdr->lock);
 
 	pdr->locator_addr.sq_node = 0;
 	pdr->locator_addr.sq_port = 0;
+	mutex_unlock(&pdr->lock);
 }
 
 static const struct qmi_ops pdr_locator_ops = {

-- 
2.39.2


