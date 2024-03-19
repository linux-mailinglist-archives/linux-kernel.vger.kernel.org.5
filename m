Return-Path: <linux-kernel+bounces-107793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 451878801BA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0199628445D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BA284A2B;
	Tue, 19 Mar 2024 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tnb9Cit5"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B930083CA1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864832; cv=none; b=Wh7WFeEMhtSf8AC4W7WV04PyRX839vFv2osZHNlev0FHxlLly8csIHM98v/GzA50XmGN1BXkqkEQcmvx66LKbgVa7v0WSHlregzuE5XpjjPcPQP1IvnTMawn72RecPMKim/UGkp3VC5KG6L7YnCAJGDw/ZFycb6aoz2HAMPrH0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864832; c=relaxed/simple;
	bh=rqTT2LFE/EriY/sI55NVs82+QuhEPrh1quGlno/eeng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=duJgxdjjmRGIVRO83rmFMZwtTfF81PavbQ2mC9uFIzCinh3vYVVRF03fyFnrAkS1Dj5nQ7JIjXsN6hemSXp2pquN/drM2rvN1aTPvs0ltlDAtJ5oafHSyuNmhCgR/+e/4pQelb521h2+o2RZCcJpqm0TVusDBVOHT7ZDSI3CjUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tnb9Cit5; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513dc9d6938so5076031e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710864829; x=1711469629; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CaO4eTXrc8bS0xtP0sgmAWvsE/xaS0w0srPaY2mNrgU=;
        b=Tnb9Cit5A1+0LGRYXHFNbMuPQ3FANcLt1pEyXbEcL5t3RK/jBtTnWdbOK700Pq1gow
         ULOoGlLOdkiSJmQiBMpwBz45uWOb+Rcsca6Rjn8I3JAXUr2Hixjz1CSCsGKCbeFWjk/v
         7kpidzXVml4+U10rzFTDi+JGueyh7lxPI66qikcuEnhnjY7aWPKvNqbHkNRtOp8DUncS
         +M2odqCDnGFp2M13KsZPGl2KzTnyoWWvZy+d6SJLYiYF5voc/mWh/TD8NhOz/6mnfE/P
         m5PUIKXKxGd3yI92G6c0tD7i9M5RrjRvpp99radzs9XFsUJ6ZLeYu0xIgPRQ7E8eZ06b
         YSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864829; x=1711469629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaO4eTXrc8bS0xtP0sgmAWvsE/xaS0w0srPaY2mNrgU=;
        b=C3w2/mBg3qaq/MkmEI3ixvlM1uLEnx/pcEMyIHscTNi3pNmExhQDDFfYQSjwlhDM/T
         v6ENAhpCeFM5F80rJKWg2Ur0U/VeChljiGd9EGhpDYpDqM2PkQJzIouB12hQD7br1uAC
         RVMuyIa0h4kUsA9Gje7XT7SgbsuDNPDsAmOOjRCiipUFOHcaXq4Qpc/z7UMrvBK3UtPd
         1mR9pEaAzfhNEuLvcSy3ChFov5ga2za7Yo+eKBTDpckG7vtmmI91DDKxOYu6w0TPHoOw
         LRT+jQfegwWRI8H8Xh0Tqy/P3XU1IiEicE2DSDtyyMeJWjNsRogVJZXCPUu8p5PoE5v+
         RgYw==
X-Forwarded-Encrypted: i=1; AJvYcCWskfSkKCzOtR3A8nebOIj10yFvvvLNUpWv7lLXpv7cax0Efe15NnrAEtZQdnmJF2cXwhEi7p9NPwJbLIaJwep+zCDD70xrP/34TpLC
X-Gm-Message-State: AOJu0Yx1Gp4LWg9USvMV1IVccrKDJ7VZlmi5iHiRWel2R06W15ch4UOd
	6iPAxkz8w5r0c52XRwoRLnSmbxWy67Vi4KLFrk6DMKM8DYUmTUgQmzz0jIENl0I=
X-Google-Smtp-Source: AGHT+IEpdYlptaBm4VHg/aEwjg5gYcaCyCqLlerLuNKxFlHCamxxx7hc+yN5zx7MrQiLGznoqGSQzQ==
X-Received: by 2002:ac2:4d91:0:b0:513:c53b:90db with SMTP id g17-20020ac24d91000000b00513c53b90dbmr10684237lfe.8.1710864829101;
        Tue, 19 Mar 2024 09:13:49 -0700 (PDT)
Received: from [127.0.1.1] (netpanel-87-246-222-29.pol.akademiki.lublin.pl. [87.246.222.29])
        by smtp.gmail.com with ESMTPSA id dx9-20020a0565122c0900b00513ee207982sm607686lfb.198.2024.03.19.09.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:13:48 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 19 Mar 2024 17:13:40 +0100
Subject: [PATCH 10/31] arm64: dts: qcom: pm7550ba: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-topic-msm-polling-cleanup-v1-10-e0aee1dbcd78@linaro.org>
References: <20240319-topic-msm-polling-cleanup-v1-0-e0aee1dbcd78@linaro.org>
In-Reply-To: <20240319-topic-msm-polling-cleanup-v1-0-e0aee1dbcd78@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c

All of the thermal zone suppliers are interrupt-driven, remove the
bogus and unnecessary polling that only wastes CPU time.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm7550ba.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm7550ba.dtsi b/arch/arm64/boot/dts/qcom/pm7550ba.dtsi
index 8b00ece987d1..05fcd8591367 100644
--- a/arch/arm64/boot/dts/qcom/pm7550ba.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm7550ba.dtsi
@@ -9,9 +9,6 @@
 / {
 	thermal-zones {
 		pm7550ba-thermal {
-			polling-delay-passive = <100>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&pm7550ba_temp_alarm>;
 
 			trips {

-- 
2.40.1


