Return-Path: <linux-kernel+bounces-134686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA4A89B505
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF071C20AD9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CBE23A0;
	Mon,  8 Apr 2024 01:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tpAWew1r"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34AC7F8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 01:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712538262; cv=none; b=u1zOnnr8CJjvfa+fRFXedQHsKacCWGYMODmpRjiMyM0ygULk7P7jppSKx8FSLAX1A15RwiVtP4tEHDTg1KE+l+sKym+5NUO5PubCR9EWAYJqrIkgGotsDOJAj4dO+F633Zv2py9M8F5Rai7qWhOtBCY6IhcwqlBhNr7v2pvK1ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712538262; c=relaxed/simple;
	bh=s33RZGEgwzC1Gzmvtyej0nFCi4RDWjdOM+NcM4qSbic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cgpA3zkZWEWqTeSvZWF6rCGB/Fo1QorraWxVPuZ6UIEtG8sVfEh19szoSfzriZCDR1IligKMWmiJ436qx6ZP0xcHXRmqZMgleJayHjW+RAVIJdZDR1zp2a95WNqp+QqFRfcpsWiCFceIulRCkyG0obNmTDbmFIFn/QLu8mX1+3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tpAWew1r; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d8129797fcso51830481fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 18:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712538259; x=1713143059; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTHBa3/xySk1w4WlhRSYrG1ip6R3tbTiUm7wjb7zoMA=;
        b=tpAWew1rIDKSRcGeTGxN+GPfcGKvELuglzbaciDshzQQNChExeMAzSV5tWYqFsR4ak
         DxLWHmpRghDcztSPd5rOCWC08UMi7UGsupqf+OpYHObmUKrnKaAvj6j0/kKel9J0ltJZ
         Z9SDZ2e/kbVZgwEfjEvW4Jrb6+af332Hvw0SIpeELLLfk+YYM7b+9R/n1pSsIT/8bJ8y
         q274vFcseRYwNl086PU4wbb5dGm7RM++o96+3u/V/UceCe5qrNoECWLz7j17l/KSbrXK
         BZ7eQcRon+nvuieqGN3V2qkS7NPuIVIRqd/BcRpcB1Xz3WCYWStbDoeFCQs1WgezW8ze
         vh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712538259; x=1713143059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTHBa3/xySk1w4WlhRSYrG1ip6R3tbTiUm7wjb7zoMA=;
        b=vlqB6NTljn2SiO3V5qPPvgqWGBLCzANmiUhYfyIBM7lw894IjzFWNDaqjOS5d4v5/a
         M4b1HjVE57I0waGatMPV7ls7U4/HYT4tzQenc3lK0k7FrRhBI99SRq4KUuPyuefbT8GJ
         ZEI/sJu+5InsWmPlRuBg9+l++NqbYryyMHifiS4SFiONsEMVhxGjndQA+AiKsSb1UMgX
         Nq6QnC3H7sM75OGPFzrTEgQG60RUHvP3s2bQMoR2PAMs7v6ALRshhcL2NVsgTopkBeow
         PcDTvS48GncMB8jyOARmZu2M7keX024aA4mYIhMRDrXbk/ouxjckE3EXlVJiM6hrkVhy
         5u/w==
X-Forwarded-Encrypted: i=1; AJvYcCWp4YiMg/AGKGhWs2EyzXRKxPGWLEBQUzRWNVbIRnZVvqt7fgvempkZNSz+eZMxEotsPu0bd8o1aVYh/JXOQrvNmTvD2apSUpSXrIN4
X-Gm-Message-State: AOJu0Yw+O1qmFr8xCIDvLS1U5taiAJd8fQqSjGkGgrLDABIT/+dF6IzM
	Lslfp1y5+Ad5TlQNsEf+y3ZdpcXv4oSXBXRCXw/N5ZqWo5JEmrxdm5jAm6kvZNidp9Qc+wEgaA/
	k
X-Google-Smtp-Source: AGHT+IH3u3/B0zIlKOQ4GKAMsNk1tEk5PZcdbk/YMayNB5gDSCrQerWl4ZS9DMtinyQHyAq2WQrpzA==
X-Received: by 2002:ac2:4db2:0:b0:515:d31f:ce2b with SMTP id h18-20020ac24db2000000b00515d31fce2bmr5347091lfe.15.1712538259082;
        Sun, 07 Apr 2024 18:04:19 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id m29-20020a19435d000000b00516dc765e00sm674034lfj.7.2024.04.07.18.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 18:04:18 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 08 Apr 2024 04:04:15 +0300
Subject: [PATCH 1/3] usb: typec: ucsi_glink: enable the
 UCSI_DELAY_DEVICE_PDOS quirk on qcm6490
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-qcom-ucsi-fixes-bis-v1-1-716c145ca4b1@linaro.org>
References: <20240408-qcom-ucsi-fixes-bis-v1-0-716c145ca4b1@linaro.org>
In-Reply-To: <20240408-qcom-ucsi-fixes-bis-v1-0-716c145ca4b1@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1248;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=s33RZGEgwzC1Gzmvtyej0nFCi4RDWjdOM+NcM4qSbic=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmE0KRQyOhFT8nKM/JhWE4LGLevh22hkfK04kTP
 +vTscL+29yJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZhNCkQAKCRCLPIo+Aiko
 1UvCB/9066B/QSH+M7g/mfZocsMcOrqBmesJjVaxV9PD7qYSB2X2/8gsXpJTu9VA/AlOlJkjoOu
 SToK54Oot+nOCU0OJq/aHXjg/t3iZZ1qmfM5N/HQVouMfyy3Uze4ubPQ6aus9KSADxbBUpl+u6K
 QOPbxc2LaEAjYfaqKYwrzHHCzDfL2tbuSyqWhhac1pSi71VqvfrOZCVTP5iFIV4g19aqp9awDAd
 1pW9gEP9e2fnyt9bXeSYe0itvqfKBiYYbvll0P1VqiE8VlYfpsbHFTf+a/RF06UeQ7cpNo5cI8A
 1Amszwfqi5CUD3PpEZ10NnKM/64lUNeEa8u8OuTb+HdQyh1Q
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Enable the UCSI_DELAY_DEVICE_PDOS quirk on Qualcomm QCM6490. This
platform also doesn't correctly handle reading PD capabilities until PD
partner is connected.

Fixes: 5da727f75823 ("usb: typec: ucsi_glink: enable the UCSI_DELAY_DEVICE_PDOS quirk")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index ef00a6563c88..9bd80a2218e4 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -316,7 +316,7 @@ static unsigned long quirk_sc8280xp = UCSI_NO_PARTNER_PDOS | UCSI_DELAY_DEVICE_P
 static unsigned long quirk_sm8450 = UCSI_DELAY_DEVICE_PDOS;
 
 static const struct of_device_id pmic_glink_ucsi_of_quirks[] = {
-	{ .compatible = "qcom,qcm6490-pmic-glink", .data = &quirk_sc8180x, },
+	{ .compatible = "qcom,qcm6490-pmic-glink", .data = &quirk_sc8280xp, },
 	{ .compatible = "qcom,sc8180x-pmic-glink", .data = &quirk_sc8180x, },
 	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = &quirk_sc8280xp, },
 	{ .compatible = "qcom,sm8350-pmic-glink", .data = &quirk_sc8180x, },

-- 
2.39.2


