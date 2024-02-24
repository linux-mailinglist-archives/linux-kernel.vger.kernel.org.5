Return-Path: <linux-kernel+bounces-79895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC4486280C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 23:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5482823EF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536454E1C1;
	Sat, 24 Feb 2024 22:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lspgwe/O"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F554D11B;
	Sat, 24 Feb 2024 22:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708815005; cv=none; b=WMAwy1RKZ17nb2lQjD9b7m/6VEnAs5jGa5OqEqLNiOceQGPRX4gOqgqo1ScdEZIVqdyrpCKF1kQryKB7Li6UhbM1oLSJLtuXDhDlff9C1aG3I/gE0/V7VGXv8bOTmVMaTZks8+Vdeoz2+gZnuLWGd8RB/75oZ7fmuKmq6YA/IBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708815005; c=relaxed/simple;
	bh=LqZLUJ4Kt9gL7yGBq5/WTF+5QKr1TTwkCx3SCqPdS1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpoabermQqmqApace75cMwlnByTlYHxeKjiBe86mRS5X0Eum1nU+Q4bcL5wb6h3xtQ/yXR0BysLUzSKeAcUWh+wG/fcSf9Hw1RYYZPyOOHniuPLQpsF6bjA2BL3aOjrjGRy/W/3uwobdPPBeZTXbcIeP127MwSAZChF2AxB+t1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lspgwe/O; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3e75e30d36so377942266b.1;
        Sat, 24 Feb 2024 14:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708815002; x=1709419802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgPRh2pCMQxvdaIAKISCXT6gieIymjX80GLulP6M7s8=;
        b=Lspgwe/O5nkpGzIgtCy6IcjHv2lb/zajgmCL33LYqokrhTW58jHbW+nyT8fa+whWkF
         0QxMKBMnX2PirV6jU1yFF8zSVeskM/d5NPmdLmwn+Vz8tKy9uXygSqa4p4nznGoLJ1pf
         tlf3XnKqbOJVoubcTy0DEjHiCIXjcx1HKh8cRqFAXtx77PB+/XCZR3VeDn4VPPRKYSYA
         acG6zXXq4ejNkye2PeODpFqu+k8yf4gwCOe80FUstHmcZfO2mN0B0Lp7boZAK5YCz0Mc
         /5QuY4mzAsDJAEZSnfOphDO9yCIa/K0mfEy+QN7HTlix4QudHP23jgfyTtBcgCP+KN9l
         W35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708815002; x=1709419802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgPRh2pCMQxvdaIAKISCXT6gieIymjX80GLulP6M7s8=;
        b=F6W/WHUxC1+Hl9LkRet9MgJtcR/usS6CB24NYjn3BEAMW37UpPIJ2SAQ6DNBsZ/RYs
         +PaRFrHk+s0tSennV1tD6vmptlWNDYBFxyoLrVgaK6PMNL4MNxebEo/t6zWUbPjhIywr
         n+GCGmMnEWSYLrADex6gImJ2k960ZSYs8uDxhANRsPXpXw2k4U8Um8XJ8fBgebBZQEr6
         kU522R/FmHjCL4W6wAKOMoAJbk9wEpyHtFDzRBw6htnuO2vmhYS7gItrURMWqdUY+4UR
         Dd9LXJ6oWajJT3KpyJdw5SF8H7KcUOvFIPqdQ/aE6IGjj939XNQg63dN/RhFnCW3ttWG
         dodw==
X-Forwarded-Encrypted: i=1; AJvYcCUaV1GO2t+wj/OWx//8pKiXMxbzRp8oPbhAe5pJdrDKV06aNKRggneXO6ZEq52vNDxa/qB0A0Td4rHkl8NTL7No0pQqdGmKdiwCb60IRmoRsG1P8a5LZ+rTZjYul0+1HK/m3+ey5wHQ5nWvkDvCR837w2Kgu+MV0D9aEJMMUG0ymR2CPfF9vBDYikSpVGgyd6VpYpUKYqNs8QCEJuZWzGo1c0bv
X-Gm-Message-State: AOJu0Yx+v1qoD1QphX+0FRhcn6ryHW5rWdvoTRTLuUziw7uY/aDnr+TM
	8BdGYv4vun/NuHUvrmL1jKGgzRDlFgR9sz5tSsebUwkilPeMh5YI
X-Google-Smtp-Source: AGHT+IECDSdHIAGB9XJDAQ0rPm3BGyKtzuyBwr7bYbKOvkJcKsbUQPmyQgM4hWXJKV4oaws9Vvtquw==
X-Received: by 2002:a17:906:408d:b0:a3c:5e17:1635 with SMTP id u13-20020a170906408d00b00a3c5e171635mr2658520ejj.30.1708815002635;
        Sat, 24 Feb 2024 14:50:02 -0800 (PST)
Received: from unknown.netbird.cloud ([37.161.229.181])
        by smtp.googlemail.com with ESMTPSA id ti6-20020a170907c20600b00a431cc4bd3dsm145672ejc.182.2024.02.24.14.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 14:50:02 -0800 (PST)
From: Gianluca Boiano <morf3089@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Gianluca Boiano <morf3089@gmail.com>
Subject: [PATCH 2/3] dt-bindings: leds: leds-qcom-lpg: Add support for PMI8950 PWM
Date: Sat, 24 Feb 2024 23:49:50 +0100
Message-ID: <20240224224951.1357644-2-morf3089@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240224224951.1357644-1-morf3089@gmail.com>
References: <20240224224951.1357644-1-morf3089@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update leds-qcom-lpg binding to support PMI8950 PWM.

Signed-off-by: Gianluca Boiano <morf3089@gmail.com>
---
 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
index 6649ca2ec805..ea617fad5a4e 100644
--- a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
@@ -27,6 +27,7 @@ properties:
           - qcom,pm8994-lpg
           - qcom,pmc8180c-lpg
           - qcom,pmi632-lpg
+          - qcom,pmi8950-pwm
           - qcom,pmi8994-lpg
           - qcom,pmi8998-lpg
           - qcom,pmk8550-pwm
-- 
2.44.0


