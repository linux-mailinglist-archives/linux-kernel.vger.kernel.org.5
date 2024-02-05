Return-Path: <linux-kernel+bounces-52346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2DF8496FB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12F351F2138E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7A7134B2;
	Mon,  5 Feb 2024 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Tl7VOTlo"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED38B12E67
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707126706; cv=none; b=nMz5yO92+1o9esHk9cm0HsRUt8DaJ7zK/m4mB3abLOZNrhOUjmNHvEcn3/7hwSRTyiQnI4Noz3mEK0WyXAzyLMnxUULbqnHMOXBzcVORpgoac7l1otP5aLFrsunHOXikSd0uwQJo1yHmQfLtV0nqr7JsAzLH7gef2UKsbR2iEhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707126706; c=relaxed/simple;
	bh=lhqnaM4mv85+e6ISI7d0OhPBJrI3dKxaikVHcrxkSBk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bSM+GVwNilRkpDvuvRd8nv/xqUlUdjTUC1AS0+7efK9clkciN8TMLJ1CD89Qqt71zDWmTKez5gWjrTOLwxyPuJqsJQonRgC14YwiG/8mMIx0h2Qwx32jyhsi9vhWpZYW25TvZB3bMLEaVoj4Ci3Q/elQUjVvjp+jPjF+ioMgZGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Tl7VOTlo; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40fd6c24812so8920695e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1707126701; x=1707731501; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7MqLMnIRBYQd7R/nZwH9ZxqSodjOOLBq1/JAXOO+J5Y=;
        b=Tl7VOTloh3JhtrFEBJETDI6W07KyA0WwbgNDjKbmKrSs8S3L2sILx07tCjDqHlhdHn
         e0685Sw6Aeh5YyIbAQsXeolQfgz61ubyAiTMXTi2KzE7ttdjJy4fNmORSBJA9RHgGUDC
         LzCChhOJxba/+zBIDHcZYOZdfXfCXrIAM2qaB43XzkUoYPqEtYP+tDek5cegUSqSWPPL
         n0Veq7TPhDTmXxWHoAf5hkb8Knr9LIYlPhwqZAqbkK01CkyIGZcYlh0I2RMHvSAV31fW
         dTHX+3nvxgOPVcXvOvjBAMeQmaV8bvSKBqgtZZ4g8kCBq9vHF4TEv2KqmH6mdmCjn2uN
         Hrcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707126701; x=1707731501;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7MqLMnIRBYQd7R/nZwH9ZxqSodjOOLBq1/JAXOO+J5Y=;
        b=N01yl3LrQPLx/ZAuYFLtRmxaxeS82BV1scZAkA2LP+fRdcMSH+YycMDtSzOchfuyL+
         dlJyfokpNmCxFVQ7g7D4+nWJbuz7w5MbuS0SRexcAY6v9Vr5cLuu6QYR2pHL8E7STXvZ
         k1ISF9dduN0WJkhefRk2lfTvxl0V4wpRKI981P4kSOi/EO82kjmNoJ3Wam/Jns/DiNlD
         SVGUrpUIFL1cSf3hC2FtoyvbwGk3TXtaF/pT/z9+50tWZp7HIJqBAblNtelfTt9XVJ/b
         qnYhyqBLKm7Xwaf2lWe4Wg2a5+gn/lLOZdtUsLWSATYeRXmevmeRBslNMBFZFwGEbKUV
         iF6A==
X-Gm-Message-State: AOJu0YxwqG/8uq4zPWLRGOzytE0fTrsUlpgw8bToILXVA3Udc0M7rXbz
	a79PrOP5ioD1ZLBvYU4p4oPtMQ3GbPZh2oMRHmufARUmBMDV6mT5a0Ur/Tz+u85ZgKmfO5fmjN4
	TbR0=
X-Google-Smtp-Source: AGHT+IHVD0GAMkuebfAaiFcSXDgdm9NOHodL49BEWfhNzmxnZGq4r1vny0RMFxJaL2ikqWklU2NBzQ==
X-Received: by 2002:a05:600c:468c:b0:40f:dc4e:69e8 with SMTP id p12-20020a05600c468c00b0040fdc4e69e8mr1108853wmo.27.1707126701483;
        Mon, 05 Feb 2024 01:51:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVFzdq9qdEjY7bS1DpVfFS5j4lS08duBC0ToDwYGWb0m8l6H1OAxmT3bU8o+GH2FJl/IHjcdiRzQf9Kw+PEB4N0+MVs6gDZ1tlDICAf36vkDoZb7taKNRAxmYb1Hr272GwwQLxTEpR/rKCpx0qKDRhRkHVbOOCpnBPFq5k6nZf39gPp4EVWWpWmjlvC0qj3tq69U3wjcG2Camsmhg+juSOOpfbIByfgJRHXypHOpo4qCd/QiXnIReAaEqfxXsPII+lSS0vx0ZQwhxastha4n6c0Alj0lQKK8rg60hnZh+rQgmb7MCdPlYTRAYmuo4/8DQJQ3Ptms2PY6OuszDcH8YUlcnAx2MyVjyQp9Vi9xGiTPlNwuEuQTZhP6LQyLdRIi8V+hgQEzBJl0ZJde52DCGxXtreU+IpnFG6Enk17cQfNdWG1oRTAFcJJ4BbGzMDAVmoGzzFIylHEP/8YQT5/uPcohXztejIdZ2TW8drvuSuvabWbuy7bh4hP1PoZbVAfZTLU3Z8wwD5kIj5jWSBZFHqmrgAH
Received: from otso.luca.vpn.lucaweiss.eu ([2a02:a03f:6aef:6800:2f37:ce90:b91c:e85a])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d400c000000b0033b3c2e73e2sm2278283wrp.113.2024.02.05.01.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:51:41 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/3] Add PPG support for PMI632 LPG dtsi
Date: Mon, 05 Feb 2024 10:51:37 +0100
Message-Id: <20240205-pmi632-ppg-v1-0-e236c95a2099@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKmvwGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQ0Nz3YLcTDNjI92CgnTdNMPUtCQTY0MLcyMjJaCGgqLUtMwKsGHRsbW
 1AB+PYgNcAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.4

Hook up the PBS & SDAM to the PMI632 LPG so that we can use the
hw_pattern for the LEDs.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (3):
      dt-bindings: mfd: qcom,spmi-pmic: Add pbs to SPMI device types
      arm64: dts: qcom: pmi632: Add PBS client and use in LPG node
      arm64: defconfig: Enable QCOM PBS

 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
 arch/arm64/boot/dts/qcom/pmi632.dtsi                      | 9 +++++++++
 arch/arm64/configs/defconfig                              | 1 +
 3 files changed, 14 insertions(+)
---
base-commit: 1f790ac9c84028d89ef4dbb28ecc5771fc352e25
change-id: 20240117-pmi632-ppg-f1efb4318722

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


