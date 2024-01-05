Return-Path: <linux-kernel+bounces-18051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F068E8257D7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5471F21CBB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B1F3174F;
	Fri,  5 Jan 2024 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="0Qd0YOWt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A0C2E833
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a28b1095064so203046266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 08:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1704471346; x=1705076146; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9XSaiyQmm79NWYYZKXvu1jjvp4q3CpLJczn8LJj/R3M=;
        b=0Qd0YOWtUCwI3IwfBQhRUUV3z50CnbU4jorPRmyQ/t878DbzAz7r5qzuDiYIXfbob/
         NVpdLMdVSJ1qRdKbknZERqagYDp3cKWCjwnbLaZmDFdvvWQZHE4WkGAkUOGrXz3VWKD6
         gc3UpO70038BHxzMKPo93CZ3/CRuxfkgxEuuoQUVcRNiTK3uvCvUfSsTCpXQWI+G13xT
         ZXsvc0KoiRFKba5ZJolHz4nYmYQ8oPuWL3ZTdcf94dBIZivqTJ6geGX3Eir8SwKS0T/i
         Zdp8BnJP/ymBB8EQk5ozLLHQ/zcpMLQyn8y6SicvYR3hlM7pG3WrHUNpvmtL+XRdUSze
         Oxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704471346; x=1705076146;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XSaiyQmm79NWYYZKXvu1jjvp4q3CpLJczn8LJj/R3M=;
        b=UD8DFWbhtyIiLB3sif25dMH/OTdb7bRoROJu5JG6QXBOai19+xsVz2qM5L6NszrZjK
         YOjJp/drZyv0RvzHDjxf71woTMBEFV0/U89PHxDB4TS2Ru722yNNrAtobfgYVGpO7zC+
         weur9qaNH/RPp164yTG18Sqvi980eUXc5WBeWuT52aJUABSXYfo/vm+FHvPAoCsLXWPe
         dP1LU0B3Fw17a/9d4+U6+NfcnIQysST4o1XDQ7/v5i92zuEs4l0DUJtMqO2ZnQrWIuai
         nv21h/BbsugEl/CvXP4O1bRXb7+2XjxNooLtavGZuG3lfOqrqiYvuehwX9cMn7OTUDVZ
         9cvg==
X-Gm-Message-State: AOJu0Yxpy5aKSaiq6zpRBOAgCvz9LgO/Xx9TFgft17YUoN3nol7KzNqT
	tOyIu0AiUeVD5hDIcVfvEw6h7wmuFcwYhQ==
X-Google-Smtp-Source: AGHT+IFM6ysmp2Xr9DCU3Vuei4JMO0dEao78HnyRDX+jACWcpbdpi/2nDdNYBR7DbrmN5GkY4BhKSw==
X-Received: by 2002:a17:906:7483:b0:a28:fc8a:5da5 with SMTP id e3-20020a170906748300b00a28fc8a5da5mr461903ejl.121.1704471346155;
        Fri, 05 Jan 2024 08:15:46 -0800 (PST)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id ft33-20020a170907802100b00a26a5632d8fsm1031726ejc.13.2024.01.05.08.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 08:15:45 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/2] Add Crypto Engine support for SM6350
Date: Fri, 05 Jan 2024 17:15:42 +0100
Message-Id: <20240105-sm6350-qce-v1-0-416e5c7319ac@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC4rmGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQwNT3eJcM2NTA93C5FTdZDMjY+PEpKQ0U5M0JaCGgqLUtMwKsGHRsbW
 1AP+rrvZcAAAA
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.4

Add the compatible and nodes for the QCE found on SM6350 SoC.

Not completely sure how to fully test it but "kcapi-speed --all" shows
no issues. Let me know if I can/should test this more.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (2):
      dt-bindings: qcom-qce: Add compatible for SM6350
      arm64: dts: qcom: sm6350: Add Crypto Engine

 .../devicetree/bindings/crypto/qcom-qce.yaml       |  1 +
 arch/arm64/boot/dts/qcom/sm6350.dtsi               | 31 ++++++++++++++++++++++
 2 files changed, 32 insertions(+)
---
base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
change-id: 20240105-sm6350-qce-c6233abbf54f

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


