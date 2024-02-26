Return-Path: <linux-kernel+bounces-81067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A76E1866FB8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0241F286EF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2292C5C90D;
	Mon, 26 Feb 2024 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuZGqgGV"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94A25B5D6;
	Mon, 26 Feb 2024 09:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940308; cv=none; b=otKLZojnNtzkojozxLIC1MyyYZQHYJsYKtXiinhftWd6KlEad0tDMb05nBQKmwVebJrKWrreXXwkm4lswggmGiP7lOJ94WKR81AJMO8aU7+NBM9Gzrdf9/3SRmVWI3PZEn9/yOqtGVJthNDadki2SRq/fYSOl045kITSiqeInD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940308; c=relaxed/simple;
	bh=SMs1Y+hialITWBjfQsUdDr8qHdCEWZ6zXD7jHaki0/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGOrWpn4wBO5BGPcTkpJynqQEfBiQo3MkFA1MrDMaDuN9bNEJej2cEgAglGXvGNqCzkTflLqr6tOigLnHfVSBeviZc34RDAS2QNnEeEnl3wiCt03K1wasF7mXuOqmUgkB62nDjDPkEWdWf7ZU26Q5SVfpmvAixZmOOCiX2W1dYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuZGqgGV; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso443999766b.1;
        Mon, 26 Feb 2024 01:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708940305; x=1709545105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEeXKLGrEyf0RjKWbIJdXt/9KeyZPE5HzwT6aiVEQEU=;
        b=JuZGqgGVn1zHJ5W3uQ0ciZGaYt08+o4qHD+Hj/sCUfXdF1xoxlPRez3cPwuWkWYcp9
         NPRg7pyVHqvl8tHNj+8Ou83BLhhyCtqrFt2BMDb5y5YPICYYBUQ9bp3woM6w5J73+ONJ
         yxV4rkb3MyvBActOuaPFgPDnzT36ZmBIeBm0D9flyd+bDZFqhV3B+6pZjTbm6ZGqkFiF
         CN0X04x/YlPJhfowBukwKRL2d0a/C6isdf1rz/m4lqxBmzwDaK/wCkA35b5i8WBuf78d
         i5cciTLNUEbArsw6Uc0vfC8NhzbOdLv8k4SPCMJ820UU08MGF9AoF+Ef18ZYg5gPYaPn
         Vq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708940305; x=1709545105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEeXKLGrEyf0RjKWbIJdXt/9KeyZPE5HzwT6aiVEQEU=;
        b=Trm5ClSVEcV2mSsUWcLDpckFhnmAfxmo29VfzATVSOEkXYA7+T2YpYBpi2hFkbtUrD
         GARuKNY/S2mCMRNJsyOta6HCqOF9BtYCKJQOhkrfXHQ6H3TuoPedj9c1Hxgku3AHrkSV
         GfONqdh4+EPH/U/jbTgLtgZXS6wlPD0jFOD0HloSQ0nb3vK01/tv9Zkvin+mKG6wYWR1
         1J0Z7orHANWAuOvpKqyK+qnJ5uJppVHn/g1oa7o5zTffSE1YoTd5dpU/wNOYNwqXIVyn
         gLx+UtFUnQ61gD1SkI5GV/YC3lTsCebeFHlsLpJzMNaJZ4ZUzyYyTxjCKZIPD2QS0rUy
         JVrA==
X-Forwarded-Encrypted: i=1; AJvYcCXwpgXL0b0HK8cvcc7D88nCQkA07t0cSLLSYDTvxGpwjaPzK2QpCZbRo1ulSYv2jyizuZSRaaVXzoHIkpEbTy+J0rjyGrYtqQBtIEmDKgjBrQO91/5CVlEvoeyYmmECNA61z0Mm6zFlRMWzFHuP4KTukVAs81tos10NrxophQbLCaKV0p65NM3zRAAleNVXal8uFNBtzzT0j9pcPNIM2rXMPpPL
X-Gm-Message-State: AOJu0YyYOFCVc52AUFb9ooB6JZLrrtQflKJC2MTmPdAHsyw3R9FEtmUy
	S0wJIfCB0uWZcC/UECEyejYUIkgSa6N6FMwuGTmE0AV4sIuMFNBAYoeNI2d1xmU=
X-Google-Smtp-Source: AGHT+IHFoYTXEtCWGW7uOxJhBsyYSKE5bYZdLPJ570cnBMrBR7xjMlIQusRknRCZjTi3pLm69JXraw==
X-Received: by 2002:a17:906:408d:b0:a3c:5e17:1635 with SMTP id u13-20020a170906408d00b00a3c5e171635mr5435997ejj.30.1708940304895;
        Mon, 26 Feb 2024 01:38:24 -0800 (PST)
Received: from unknown.netbird.cloud (net-93-65-126-20.cust.vodafonedsl.it. [93.65.126.20])
        by smtp.googlemail.com with ESMTPSA id fd13-20020a056402388d00b00562d908daf4sm2158595edb.84.2024.02.26.01.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:38:24 -0800 (PST)
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
Subject: [PATCH v2 3/3] dt-bindings: leds: leds-qcom-lpg: Add support for PMI8950 PWM
Date: Mon, 26 Feb 2024 10:37:32 +0100
Message-ID: <20240226093732.3478845-3-morf3089@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240226093732.3478845-1-morf3089@gmail.com>
References: <d17121a0-ca14-41fd-9802-bb4118629e34@linaro.org>
 <20240226093732.3478845-1-morf3089@gmail.com>
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
Changes in v2:
- Add missing entry for if
- Rebase on top of https://lore.kernel.org/linux-devicetree/20240226073713.19045-1-krzysztof.kozlowski@linaro.org/T/#t
- Link to v1: https://lore.kernel.org/all/20240224224951.1357644-2-morf3089@gmail.com/
---
 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
index 6649ca2ec805..e93e9b30660b 100644
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
@@ -148,6 +149,7 @@ allOf:
             enum:
               - qcom,pm8350c-pwm
               - qcom,pm8550-pwm
+              - qcom,pmi8950-pwm
     then:
       properties:
         nvmem:
-- 
2.44.0


