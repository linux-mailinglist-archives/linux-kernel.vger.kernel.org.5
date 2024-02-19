Return-Path: <linux-kernel+bounces-71355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBFA85A3EE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4FD28523E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEA531A79;
	Mon, 19 Feb 2024 12:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oma2XsIY"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58B22E844
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347301; cv=none; b=oIi/haTMOmAVyQDtKw9U10NOQacUF5ZncUPr88zJLvpfptMq98H3MbwEwVSzTiW17FBkU15b86CBUUCfWTUiR4yiKpNZ17+RtXwmykWFYLjopxe+5U/iiPoRSL/FUUJPaqMOnNxxIwm0z/7Fpcm5gPOtEH53uDJgq8ahA2VTjdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347301; c=relaxed/simple;
	bh=hSBsjVnDq4V/SaD5QrTbaSrUiQ2o7wo0Gts4ho71hgw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YPsxG8ko7qKs2VAvztTeplMxsX5H7SPi+qF36whTv8slRT9WhNYBbnMkET3qale8iMU7y5S9LxriBgDFsxd0Zeb/0yM5q07OkBFR/+DuAHGf3VaM0u9yPghmX/gpwUO2wNwHTveg9GgIXzfdmFrerxNjTKDO6FgiTut3sUqDMyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oma2XsIY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41267d9d6faso4876955e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708347297; x=1708952097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a6B2DruJerLZbkIuvRU8f0cBof8KbpMYUSV8dqn0q2g=;
        b=oma2XsIYTPEEH2cTCTebgFW0WNDwBs446XfKHcPOofp2PXTT4GXsLgpHNo98ZcwiPV
         VfSwNlpghors5DOpkoeNT77D4MboAFO4Y4vppu/aYN3dBTjxonC3+3N8d6zyqgiQ1zyI
         8v+iIu227pbSpeRYj9y5/MyLuSCW829spZKGc8kEvuekf44a0BfM5plO2XXPd0XH5rh2
         X6YqgLvBSFvNvvRBxyJlQDjW3ctTXpHqgJBExySUDPGlou5dxvN8To4abFVuHMlU57AH
         kZdBVWLRHB0LtKOtTjklATNnnfQHbY7Ftjino9knLysapgfsIrixrK3AbDKLuPKStepf
         qcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708347297; x=1708952097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6B2DruJerLZbkIuvRU8f0cBof8KbpMYUSV8dqn0q2g=;
        b=CtqAFWqOVPiFKt+CShiDQktiW6LMdrwszfD433jGpRKlLLE5pU5EECGz1e/qInF3ZL
         cy3k93bBIOrsrJmJw3JXYeuJ1hUx43q4ePRomFQ62hTY4vBLvGy3g1SVA9kOTkqIZSDe
         TQv21Lmx17c/hOT02tk2gECTCi5i8rZl/yQzQZdkx9/cIA5u3uiZqVti6QJPZ/RwXz5k
         Pw5cFp8tS8AmzGnGTn/rDmAS8/dG8UGKOAxpzWLGY+rDE88culWQUnjoDmkMDJDcZoiM
         lOul5tXOqOf95umqj75Rl0OL4MERSJoxNK357KGrc0uVY9iiWI4OfAxXuU4nK8CQNOWU
         49pg==
X-Forwarded-Encrypted: i=1; AJvYcCUQxJDqjdU/m4sUFEypV7/fw/h0WkFpJQ8CdjWTrWe80HnYCy8aORMH7CLXEcf/gL1GSpWRw8GOKsczG43wTcuWE1ydRwWfnb8W/BYD
X-Gm-Message-State: AOJu0YwAUBNdk/sdX9b8ZVjrmwhhlHoBnBx96TnkVmRuFfF8QZg2vCxm
	mCF/RFIipRqFn+butK6CWbh6rIkSYMk4EEhurROQitVw+4VeKQkJ7PCd+pjrt9Q=
X-Google-Smtp-Source: AGHT+IEIv5BtZVO+FqLBERhY0mbMiI6B12HVtWh8EH0ZzyLDVS+rqzvTu7JiEtbiqXaNJAReIfKO2w==
X-Received: by 2002:a05:600c:3549:b0:411:ff38:aa13 with SMTP id i9-20020a05600c354900b00411ff38aa13mr9228779wmq.27.1708347297209;
        Mon, 19 Feb 2024 04:54:57 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600c350500b004124219a8c9sm11006918wmq.32.2024.02.19.04.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:54:56 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] MAINTAINERS: samsung: gs101: match patches touching Google Tensor SoC
Date: Mon, 19 Feb 2024 13:54:53 +0100
Message-Id: <20240219125453.103692-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Maintainers of Google Tensor SoC should be aware of all driver patches
having that name.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

This allows to spot easier such weird drivers (weird because they claim they are
for hardware, but they omit entirely hardware part) like:
https://lore.kernel.org/all/20240219061008.1761102-3-pumahsu@google.com/
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 36fac6b3499a..69fb1ae94897 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9126,6 +9126,7 @@ F:	Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
 F:	arch/arm64/boot/dts/exynos/google/
 F:	drivers/clk/samsung/clk-gs101.c
 F:	include/dt-bindings/clock/google,gs101.h
+K:	[gG]oogle.?[tT]ensor
 
 GPD POCKET FAN DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
-- 
2.34.1


