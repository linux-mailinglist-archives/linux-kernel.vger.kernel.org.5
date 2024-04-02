Return-Path: <linux-kernel+bounces-128402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74270895A73
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A3C7B2AEA0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0903A15A491;
	Tue,  2 Apr 2024 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MtlVgSy7"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7758D132C38
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712077636; cv=none; b=OHV80hnn6HFCDSyDApwXX3rLnDgsqaB7o52gYZX2YWDmw2W0VqP6XzaC+QpocKhqWMuXkzlPZVLaju2QtEHNQahkOdeguRWECCJLTLYbClOFHbr/QzKBTu4zL/MbdbAw6+q5uY7N4Tue/0T7TVcW6MgoXSyBSLOD97y55jm2C/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712077636; c=relaxed/simple;
	bh=ejmSEr+ZHoU5wnJwcbG/1U4o9s3XeOrkLnjOGLvJUFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NKGybOouErKc1gSzUSdXgtfChgJBiFB87qa94IXymgW48JR0W1B2IOd+b8TGGtU8BIzo6ng5Jw1BBQ+U1OIKImGT3M0zEhOyI3Sjd6fF1hHnyr1EPNkE5vovev8et4grS8OGax8Vos6d7YRzHJaTPnKiV+rXgKzaTiJcm6MMAs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MtlVgSy7; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513d717269fso6466957e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 10:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712077633; x=1712682433; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dumrdNqn3JF7d5ovI58YhJ6DvrUhsKO8CpryfKF1GQ4=;
        b=MtlVgSy79Ny0ToWMg/c5x2jKEQ6mnAcZ32Ffj59NF1zIRGdiyEmxohVnX7A7IhIaGZ
         70SHaWEQ5atgg4OJ9vc8BcSKOBb6Dl2L8u150MFGY6rYWV1/TcoQmOYZrmSMAtWCuU0y
         B9VjNA/EnWFD3FapYoxM1wXbGpsuNR5i0hB+2YOD+Ma9erTb2WqPyLmRVAzW8S4d+elH
         sK8y5JGkitZ1Rn5chhLk6r64UbOZPoxlDo5XEqp9ppnElXlAq9C9kY2PBV4HdkUZgP8Y
         AP1inMINJaMSoAKKB+Uk/dQxEYGU2ef/hJHtbhBglqUnftjdQZiIf6xy8c1PL8/RljDb
         ZStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712077633; x=1712682433;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dumrdNqn3JF7d5ovI58YhJ6DvrUhsKO8CpryfKF1GQ4=;
        b=ZOooOI0yBHAPsFa3ySH7sq/DvQ9M+CN94kBV1Lb3ziXvLiM9hWRiJkzimy2E7m9l6/
         Gup34k7j6RqOFCJeY63K61b6pdqV3QxsywdsxXxPEx1ENy80BiI/3lCm6hUPNS4Gv2eR
         tarvFNLuRsSF1ANh/463kGOSQaFDhD9WDFlye/hDCzzWl8ZgmbXAixfJn/DIWY6EagbA
         epJsxKUoLXDUgMObxqc5EltrGwMQXqmacCe/674Q0aIRgpdQak51uAzI7l4kYNr4W27w
         x0w15Lyd6ZuUm2ztuY8ibFAdi6DlfU7+dAQquxpGwpnhgoxToPoxZX4qjpH6WtdzPJ8i
         MXoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIhBl4znMsLx6IfqMeLXgcocHdzV6tR1Jb42dJY1SKEXOcEbTsi8bvomeCmzWCMHngBKuzQQnJE3Fg5+IxlesFn1h1sPn4s8XqYbzk
X-Gm-Message-State: AOJu0Yxx6Kk+8yfPsfv1Yq2zkUpMtVqfaxaLj1E4WuoeySIRLU0Rn2I+
	EQAfu8J2MQ9YJ6D6raSQH7ARQA1vDl2+pZS6Oq5sqol7MTFvZxyk0dqcD38XPmE=
X-Google-Smtp-Source: AGHT+IH3LKUsswPAmj67uOpsid2F9krDfs/O9BSSs9cp+RSDJODfoiCwo9O2MoqGi0ibFWMRTVqNew==
X-Received: by 2002:a19:5e11:0:b0:515:d3e4:7d9f with SMTP id s17-20020a195e11000000b00515d3e47d9fmr7130874lfb.21.1712077632657;
        Tue, 02 Apr 2024 10:07:12 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id e12-20020ac2546c000000b00515cc53c5b3sm1603486lfn.125.2024.04.02.10.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 10:07:12 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 02 Apr 2024 20:07:06 +0300
Subject: [PATCH 1/2] soc: qcom: pmic_glink: don't traverse clients list
 without a lock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-pmic-glink-fix-clients-v1-1-885440b81c65@linaro.org>
References: <20240402-pmic-glink-fix-clients-v1-0-885440b81c65@linaro.org>
In-Reply-To: <20240402-pmic-glink-fix-clients-v1-0-885440b81c65@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=973;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=ejmSEr+ZHoU5wnJwcbG/1U4o9s3XeOrkLnjOGLvJUFs=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQxqPtd2tWzcXdWQpx9kYimw3bOCJvNvIUmu4vPgBY8WRa
 A53falORmMWBkYuBlkxRRafgpapMZuSwz7smFoPM4iVCWQKAxenAEzkhhn7L+YJzPULfv7lK4xZ
 n97Qb5H+kF3tcolJrf/P+p87ZjAFHLIQt+7/3dNxn0XgxJSeSS8Kt+oLfJEK/C4eM+vLmaUbPt6
 Smr+5IXLpuouuf7fXJ0r0bU6WE+X0fZJUx14se+9h46eryxaoFnKIeTubmUessfS1X35fu+XjOq
 nlq2xUy5JfHd/gy9HxIf+gemt15KNtC2SMX7qoRataiJoleF4ss62stjlR/rOgIZdPPE45UuVZm
 f+F3yZGz1MM2w8vMgu6rNnz74vNrfLooyomenYO2ot/MmZ/fJ1Sv+yqT+FSmayvu3MKDwZXVjzR
 0K5WsLJMeX5m35eTWe/TmevPmXeHXNfvt9OOLsy9dxsA
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Take the client_lock before traversing the clients list at the
pmic_glink_state_notify_clients() function. This is required to keep the
list traversal safe from concurrent modification.

Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/soc/qcom/pmic_glink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index f913e9bd57ed..c999358771b3 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -168,8 +168,10 @@ static void pmic_glink_state_notify_clients(struct pmic_glink *pg)
 	}
 
 	if (new_state != pg->client_state) {
+		mutex_lock(&pg->client_lock);
 		list_for_each_entry(client, &pg->clients, node)
 			client->pdr_notify(client->priv, new_state);
+		mutex_unlock(&pg->client_lock);
 		pg->client_state = new_state;
 	}
 }

-- 
2.39.2


