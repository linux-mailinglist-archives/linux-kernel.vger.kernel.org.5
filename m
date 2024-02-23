Return-Path: <linux-kernel+bounces-78505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4A1861444
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56E31F21B95
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5975B8F44;
	Fri, 23 Feb 2024 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y57VezJD"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C919C883C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699093; cv=none; b=BCmOFoMVCn2DFSpUPz4PkgaBDEGcludJ8llG5Z+N+muk6sR19YZxqi41PdP0jlvCnNy+OOphrqumFOSbxCnwCB3eAdKh42+7ZxvFSlEqkvxHqyHLEDWWcewAeii+KoJxnF9KsGN8wjWLmJpGXZhSQ5/N/a/D8x/J5H471E+Oxt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699093; c=relaxed/simple;
	bh=vSQ/Cl3MyhUvN3l5UgZesa4xz46YadYb540aPO5Hivg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z0hazGnuqsR143d0PNID6xeFjN/qmF+ohRB49cV44aUrUKL+qp/mAFcYTgcBiwEcWgXoY8A66eCP3dCnw8u/92yMnwgGIvGMIaa5qjw4JU7rk71Lp+GdHn2473JOwnNW5jecYIdLx2kfhi9lcq3iySDCuuDFdpQw4kZbwaYLSig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y57VezJD; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-564a53b8133so550797a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 06:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708699090; x=1709303890; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qk8L0fuVMP30u16wdE7ApM5IoQqVSEw1Vy3IBCdJBlg=;
        b=y57VezJDbnlpaGr7eSHNXW+qipMZ8wvGeYpCU5L99Vj8coHdLLpULsLNSYFf4LriuD
         00E2Ix2A8QPez/jrdmDb0yOoVQ9S8M4ymBpb9YZ28ON6wzuIPeiOc15pA4qk+mYuLx9X
         D6lxLPBFOPgkmNiupc4fii9njJkRarwF+XcUfD+mzc6tTX0wl6yhZ84sPG7JEF2VY0hA
         9RVyHAEab4q2DlrqucxQyk/d8qwCe9BuiyP3DL31cT2tlaCFvM1b71kxdOImHKaCP54f
         +zOfR6KPD0J9Hv9KlT2zmepTuwNKh+J/dEwvyiNn7Nh0AlTyat9OezNomMH3S6/KKXJ4
         lvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708699090; x=1709303890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qk8L0fuVMP30u16wdE7ApM5IoQqVSEw1Vy3IBCdJBlg=;
        b=E4MWklWNVSAlxsspIKLEqQa3FfWQ76ae2mJOZLa7zBs18dBkw+roOQRNlxxHeGtkQV
         iMKGW1J54M/REIzzRqUCS4yuaib8yMFgqLz3c08Ho6Y+Vhx5Gczg7JjS/t7oCHg7yKXT
         B+PxQMBYqB7gSUwrvFm15v7v43RcAus9dPbd6GvCZCXnjaSd+eSRHvCtJDzhoLtb00Yf
         IRfQs/U2sQojUUQ3HHpt6aZOkvctHbjZ3L7xzRBbnB1/wUCh6G/odEHQOGe6iYcA3e3i
         Ki/QJHirEkgxg3kJa3M/gKV0NWp/kBjnUDIKyIX+YnWmBgejkYRX6hovla00Y38I6qd7
         lK5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/9AmcOoWhPTw/6o9MzVh+0e2BBkJBNgNymrJqnCP0AFu50IswZEbJEzr/lD2Ld7du9sngmzMbC6ABEsiiIdxRTFCWcYJFd2F1ye1l
X-Gm-Message-State: AOJu0YxJhV3+UPbaJF54FTPCqdv5/GOlZcaEmOIls/3f515iUfiKeG+F
	JMEKHK5Wpv8Rd+EwntIgzAcqrw8+EDX0OtSk4ONn7RyAifIij0dm73MoKDRqhuLGjInw9gC23VX
	I
X-Google-Smtp-Source: AGHT+IF1M+6eYRsPBs4s5BigpWjZQHgAKf0TfSO4GRCG/F0i4z2w9aYcUP+LD9OEtKewbwA32jifOg==
X-Received: by 2002:aa7:d741:0:b0:565:6f16:4dac with SMTP id a1-20020aa7d741000000b005656f164dacmr19591eds.2.1708699090095;
        Fri, 23 Feb 2024 06:38:10 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id p27-20020a056402501b00b00562d908daf4sm6637536eda.84.2024.02.23.06.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 06:38:09 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 23 Feb 2024 16:37:57 +0200
Subject: [PATCH 3/3] soc: qcom: socinfo: Add SMB2360 PMIC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-x1e80100-socinfo-v1-3-be581ca60f27@linaro.org>
References: <20240223-x1e80100-socinfo-v1-0-be581ca60f27@linaro.org>
In-Reply-To: <20240223-x1e80100-socinfo-v1-0-be581ca60f27@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=552; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=vSQ/Cl3MyhUvN3l5UgZesa4xz46YadYb540aPO5Hivg=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl2K3Med7+oSvj6YjE8+EPSgTLXamR9GReetEzI
 hONDAIZngyJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZditzAAKCRAbX0TJAJUV
 VsY7EACLK1wdaiMmzo1XRU0VGTx8fzMrX8vggovG6bUiCOYLmT+DyDXPPdHTPDOKKQNHVj1deAh
 fho7Hs6iL6l9IMCkeurm4qKnL3tNVd8nuU++ekKJUngwwPnHrOfo0q5j+T/iIsjCmgje0nTBvtF
 wtXwz0KxPIlw3TQ2BHjek9r1uXSeVrpMu8qpA81p3XEc7EAOMl+iMHmlTYig6NOV4UFbAVNm8ic
 +fRnDbkFNhLx3b//w7ylNzM7lBuVw40hQZtOBq7Htrq1R0f+XtMv+UvYHxrTIPyseFQ29h3zEC8
 3YcyLZXwSPjXXkgbS8lDV1QzFyYa9/cV6bpv+BdnCOsJHqnfcbjxrOgVIAi+W6kc3mimusBeuqe
 dJrD8soZwqYGHFZrrKx25nt0urHOt4t8PxS/52AgyFeqCmVChI700SjdGrvTJEshNYgeOHiA96B
 LOIhDeSGf5zjaYlZElkDGfGmoJ4PxerVpK/LBjphIp4eGov3/+0KQ7eYdVqtxwugb0cGe5g8lyF
 mfPZmL2Mqs83UuL9rq1Vp4PhHn5vuoGO8EE85JDNicH6Yp44bzHr+vupa9Lj2MwYSPgGuDxY4Ij
 Qe+n9HFDvrI2iFq79W5kKSLgsESSgsi+a4ztElokzrvBM5gGeCKcAciPvAxAGVa4U8qt+8sJrvf
 hAcdA0K1+a6P0EQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The SMB2360 PMIC is used on boards with X1E80100.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/soc/qcom/socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index c8e968d7a620..277c07a6603d 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -133,6 +133,7 @@ static const char *const pmic_models[] = {
 	[72] = "PMR735D",
 	[73] = "PM8550",
 	[74] = "PMK8550",
+	[82] = "SMB2360",
 };
 
 struct socinfo_params {

-- 
2.34.1


