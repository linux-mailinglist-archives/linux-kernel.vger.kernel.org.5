Return-Path: <linux-kernel+bounces-40930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E46B83E844
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B78228299C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A2DBE48;
	Sat, 27 Jan 2024 00:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7eOMz9N"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82B217C3
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 00:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706314787; cv=none; b=G/Kl58VGutNpnb/xB1KGZshZIJmSab//hcjRADEnMOC35oMXxl8vRKqL+/EF0i4y/QFcJEXHAITVfOk/TTMW8TDMkto/KLma+JgDBxLJC7xnByVlGVm4UiECKA+SQ+i6jyiHuvZFy827G1jjRXZ05weupOUawPEo4sryh+AH7NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706314787; c=relaxed/simple;
	bh=QCBcVoNTtEzs8YaN7v2UFqWn/6iZ4/+D+SQWJIRaEgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7sBFDs59oJfl7iUy52P5Kb0urBfXe7c6npIxyAH5NJLIojpO4m+8mQnCAr643EFKC9TQvzQKeq3Pj0FlpreBx+sqgnbpt76aXiLzmwTNX7ovu3h2WBFFOtM8KAX1M+s4jaVNtK6YATzolDs8bX8WIIMzf8nKsg6UYt3Jewf0RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F7eOMz9N; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a26fa294e56so98716266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706314783; x=1706919583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUTiJvJqAJFqpZq0PlR/xTJQ+sgK5+j4/7Vro1qj7Vg=;
        b=F7eOMz9NEri2UlbOPGhUwpOyHWK+0PAmepVVUkLdq2R/yqFgWDMITwtrD9fSwddTy/
         doxvJWOPsQaL0ut/vuHpD3Qa5/S6Cqq+06sKqJTo59Y1p1IlwVQm5YbQhlg8XcpPkrJI
         VV/l+OEyAyF962DzVDRyq/JOXsmCRUJZNj9mFrsSGVyBAr84vcYdlEJuB1GPLtBYd0Lt
         vGzXgkh0WE/RrG7rEUUWJUvXwn3oPSpuTvX5msvC8yitHLHHNoCcEvHEY2zcjsmDWU23
         emgOvxjqISTlr9NrEaSaOfOfCYHGP/IjyJfgeh8fQSQqehaUraZRp9GPw2mDi36Ypnd8
         cdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706314783; x=1706919583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUTiJvJqAJFqpZq0PlR/xTJQ+sgK5+j4/7Vro1qj7Vg=;
        b=Z08GqeW0vsoD2633rBb9EyljCLzca04FVncU42jsRfL04wg9cNgaoZED0+B+/1ruAf
         2HOXpRZR9CLsysbd/wLm9AbV6D2bQV+wapWdZ8W/gxTo10yQRu8awc/9Nl4w83Ly6ZAx
         L0P4DVzt8XbkNMRHOOXqcZZjj1EiBYvYR56ZEr5gKJxOP0iObR4MHxqNMJwKHSWbzjqQ
         hv5I6TC7oz0Y7PvKMFR6vyP2ryb2CVvMMGlxYhRJ2R8uC++Wn8aC/Ip55Xn2UZIfBZsW
         Ix9UyS8yPOs00aNIzGSm6zWBe5u8NQdHBxEPA1ouuVZEVVSq9uXrQxMIVp6IC0ubS/B8
         4yWQ==
X-Gm-Message-State: AOJu0Yyb7VKXUpcmzEFCk4K8e1NO4ED5neG3z31uW2lBQ8swJGMkE5PX
	+yzWCle1+SIkEiOxAXCL/66jgPfmXJkTxB80dGUDomGlbWwTepeBBUh49T/j1ZU=
X-Google-Smtp-Source: AGHT+IGkm39NfF0E/k3smX/KQGkNB8Zdyio6Yz3gDcfCSJPUy7NuuFl2uvO0Un5oFOG2oyg/lgq0ag==
X-Received: by 2002:a17:906:a456:b0:a31:7ed9:973b with SMTP id cb22-20020a170906a45600b00a317ed9973bmr289912ejb.65.1706314783163;
        Fri, 26 Jan 2024 16:19:43 -0800 (PST)
Received: from puffmais.c.googlers.com.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id x16-20020a170906135000b00a339d705a10sm1141359ejb.80.2024.01.26.16.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 16:19:42 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
To: peter.griffin@linaro.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	tudor.ambarus@linaro.org,
	willmcvicker@google.com,
	semen.protsenko@linaro.org,
	alim.akhtar@samsung.com,
	s.nawrocki@samsung.com,
	tomasz.figa@gmail.com,
	cw00.choi@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 7/9] dt-bindings: samsung: exynos-sysreg: gs101-peric1 requires a clock
Date: Sat, 27 Jan 2024 00:19:11 +0000
Message-ID: <20240127001926.495769-8-andre.draszik@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240127001926.495769-1-andre.draszik@linaro.org>
References: <20240127001926.495769-1-andre.draszik@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Otherwise it won't be accessible.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 .../devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
index 33d837ae4f45..c0c6ce8fc786 100644
--- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
@@ -73,6 +73,7 @@ allOf:
           contains:
             enum:
               - google,gs101-peric0-sysreg
+              - google,gs101-peric1-sysreg
               - samsung,exynos850-cmgp-sysreg
               - samsung,exynos850-peri-sysreg
               - samsung,exynos850-sysreg
-- 
2.43.0.429.g432eaa2c6b-goog


