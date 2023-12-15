Return-Path: <linux-kernel+bounces-269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D89A813E7A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DCCB1C21EEA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE0113AEB;
	Fri, 15 Dec 2023 00:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OzzTrlU6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA5718C17
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 00:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ca0f21e48cso898161fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 16:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702598473; x=1703203273; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eBSKuYKxzigP8b5WXvqXz0s0p/VS3DncP3fDxmRu3Ww=;
        b=OzzTrlU6Xo/rfjVbFbRzo5gjJ8PpRpxVQC1Q0UFlxI+ZFl64CjAtWPqJV2kkwQchl8
         HGyIESLqbX1244mBiPB+iW3PKtnP+JW+SBPZcqbnyZBHe2gndiLk71dIg7M+fCoj5wtl
         AO5Dk69ROfxvaJ9n5gdl2kr0ZVyWNFg3gP5Lx6Hofh2zOT/uMTEl8TNeifMvKbvBkiCQ
         0+jT/QvHE7MXyRDtdvJ105n36NTCE8uKEY/QvAQersqgXdv9wgDKqcHkWZOjkFA2vU8W
         i5HIAnOBA0SstMGG73cKXTWDG5ygcE+UhELq3D5NV2aQR0muMWBzoc3noArRQfve/Aoz
         0JMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702598473; x=1703203273;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eBSKuYKxzigP8b5WXvqXz0s0p/VS3DncP3fDxmRu3Ww=;
        b=rLM7/T37pRpbTYFlA7OmFVH4GD0xSG7H6cA79Vo7eBG7I0d/42OJAByCSOFNhlRBC8
         SaTTODxY+JqAxX7SBzwD7XaIcftQioLoatNb/PE2bAGN6XMSBWQqAnCFXhmDPg6sUixU
         kVf6YUCPb0A09vqie21XWED/hud2m5v3bXKV8Uj9k/VfDeW+N8pk8ntaT10pC/mIo9/C
         wAtPMyI5oDi3pb8hD9aR8JMiD3fwhY8WEzdjTwaOtwKHU5XAKu5gybWUYfjPVidWa0Eh
         KDqcsGVp8DnG9Hd4kMH4tNe34SK69fkwvvWmfOXc33+IORHIELwd7UbuR11bqxMlXZM0
         XFAg==
X-Gm-Message-State: AOJu0YyHn1zmXTY2+jZmq+52cBqlY6vqLObhhKdXhQJpHnoaZEr0CWVG
	I+vqPy/Iw29dYmySjIL3h6XM+dTkpnJhJgmweHc/qQ==
X-Google-Smtp-Source: AGHT+IGC4AkqHA4O7vY5jj4a3VkRdVMCQIKyJctbrqXdk3Ym+s/R62mwcLbSPKMvibSgZZwuTJDyzQ==
X-Received: by 2002:a05:651c:2228:b0:2cc:1fb4:6ae2 with SMTP id y40-20020a05651c222800b002cc1fb46ae2mr4701586ljq.28.1702598473582;
        Thu, 14 Dec 2023 16:01:13 -0800 (PST)
Received: from [127.0.1.1] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id v6-20020a2e2f06000000b002c9f939598csm2184518ljv.70.2023.12.14.16.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 16:01:13 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/3] MPM hooking upping
Date: Fri, 15 Dec 2023 01:01:07 +0100
Message-Id: <20231215-topic-mpm_dt-v1-0-c6636fc75ce3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEOXe2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDI0NT3ZL8gsxk3dyC3PiUEl1jC0NDcyOD5DQLCxMloJaCotS0zAqwcdG
 xtbUA8u6CPV4AAAA=
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c

This series hooks up MPM (which can finally be done after winning the
lengthy bindings fight) on 6375, 8996 and 2290 as a good start.

The hardware in question is present on all RPM SMD SoCs (so, roughly
msm8974 and up), which means many more platforms are there to come.

MPM is one of the key pieces for allowing full system power collapse
(and perhaps as importantly, resume) and serves roughly the same role
as PDC on RPMh SoCs for this purpose.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (3):
      arm64: dts: qcom: sm6375: Hook up MPM
      arm64: dts: qcom: msm8996: Hook up MPM
      arm64: dts: qcom: qcm2290: Hook up MPM

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 39 +++++++++++++++++++++++++++-----
 arch/arm64/boot/dts/qcom/qcm2290.dtsi | 42 +++++++++++++++++++++++++++++------
 arch/arm64/boot/dts/qcom/sm6375.dtsi  | 41 ++++++++++++++++++++++++++++------
 3 files changed, 102 insertions(+), 20 deletions(-)
---
base-commit: 11651f8cb2e88372d4ed523d909514dc9a613ea3
change-id: 20231215-topic-mpm_dt-3811720cf884

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


