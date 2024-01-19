Return-Path: <linux-kernel+bounces-31077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA2C83287B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B2E287597
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CA44D102;
	Fri, 19 Jan 2024 11:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p+mWiE6Q"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9704CB27
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705662713; cv=none; b=htoyHdZYKYrEkqkMcvg1oiR5wDpULWuUf9TyfLAo9iz8n3JhAT0CxIVCgkj4Bgo7peehCSgPYRCqP9l4tW6HEQDovJauS/LsiBcECT94M6XoJlCpWQVeBDYY+bEGwoogzObj6azQiOUnjjLI/mlKRUyqm9IuuwgTvx5CWQiD+mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705662713; c=relaxed/simple;
	bh=Q1QOlBpvgW2lI3s9WzUF/2MwY4ank0KkttexA0jdNsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/tO5NhwwNWrNajmLsATtZgE/apdmGVuVYETbv4lVzsgoTUtMC9Nnh9FpYuTVWWkNMm8hoO/bUrJEDq3m2zoLYIYjXSQHlR2+Uaze20lglR37OrASw42Mn+CSD5Jl9WRlOBaYzbgo+jwQ1y+I+3MBF0Rs6gEQM7r4b76KzLAvsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p+mWiE6Q; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-337d58942c9so644886f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 03:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705662709; x=1706267509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrfLoymuWUhsr76oTazWVDUYhWCX3sd9OJ85HADWWNI=;
        b=p+mWiE6Q2Ezb8fir6WhV3WFBpmpDTALVEks1BGz8jqx+Myqu4KD0Eb3HQbddpUc9X6
         l6LkuAv4r1TjMO2tP1xJmTL5gqPSY4LeKRCkAiXpGUUjeeDD4GsWvl5ah97/zHzd+H5q
         pStGCTJ0YihkYmHbch56ik1XyFe09VPASKPTUkIotQk6n0oPryhRlLAUdPmYdarijjoK
         aHQ4mh2u3QXIj/RfawvqR4MgmemzOhE234eWgyGaqgExabU1gh/AH8LGLcJan/Ray/5L
         eDoH4w8LqXCYA2eG9+KWuAOIxIYd84nKqCraiyqkU7jC6tJZYc8z/JehagnVFUe4qvUx
         td2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705662709; x=1706267509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrfLoymuWUhsr76oTazWVDUYhWCX3sd9OJ85HADWWNI=;
        b=AL8xdOllOBEB0WnyZk1ouxFZq6YyJQjE1liweJXNwLcjEg0AxpsmOmcDDoQUEpCDYp
         Q8/YmIB0pPW2BKMrMNHxtU0Ld3N01DMAymta7Dp8BcRwEEvoOoEjw4FC2r/guMeXAn9b
         52gF3LE/XqFzJHXHDBhxiY5tSEbI8wFp+FSPiTLg9zk5xBoT/QT4lcb0kkjoZCcsncqP
         H/aYHgoYxbZn3V4j6xyQlAMenS7O2lg6RYcyeycm00YFcXGFOixCE2E8Gvxf24wR5Gze
         92fyon6SbjAnzI1G3XFFa/D0M1kLfNL3aM71EGZgjuMmPoZxqfjIDtH6MS598OOHEv/C
         9yLw==
X-Gm-Message-State: AOJu0YxJO63v/4TPwFpRWgACcPsabihGr26uXEVeI7PhOPRilZN5nfUf
	qJwbWTU7oKo1hZSN3pZ+XFRxMFGflh7IouO+5hP0mD0f69UIVbU0H+EoJbagkRU=
X-Google-Smtp-Source: AGHT+IF8b3Ntvez/7FhtUFVXpwKWJ5oukJOvrp5B/i9t3tP0V/2tMqFw13SH7EBSfEwPVE+l+w369Q==
X-Received: by 2002:adf:e303:0:b0:337:c0b9:f6f5 with SMTP id b3-20020adfe303000000b00337c0b9f6f5mr1301770wrj.102.1705662709072;
        Fri, 19 Jan 2024 03:11:49 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d62ca000000b00337d4ce6ab4sm3341868wrv.20.2024.01.19.03.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 03:11:48 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: peter.griffin@linaro.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: andi.shyti@kernel.org,
	alim.akhtar@samsung.com,
	s.nawrocki@samsung.com,
	tomasz.figa@gmail.com,
	cw00.choi@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	andre.draszik@linaro.org,
	semen.protsenko@linaro.org,
	willmcvicker@google.com,
	kernel-team@android.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Wolfram Sang <wsa@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/8] dt-bindings: i2c: exynos5: add google,gs101-hsi2c compatible
Date: Fri, 19 Jan 2024 11:11:26 +0000
Message-ID: <20240119111132.1290455-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240119111132.1290455-1-tudor.ambarus@linaro.org>
References: <20240119111132.1290455-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add google,gs101-hsi2c dedicated compatible for representing
I2C of Google GS101 SoC.

Acked-by: Wolfram Sang <wsa@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml b/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml
index df9c57bca2a8..cc8bba5537b9 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml
@@ -33,6 +33,7 @@ properties:
           - const: samsung,exynos7-hsi2c
       - items:
           - enum:
+              - google,gs101-hsi2c
               - samsung,exynos850-hsi2c
           - const: samsung,exynosautov9-hsi2c
       - const: samsung,exynos5-hsi2c    # Exynos5250 and Exynos5420
-- 
2.43.0.429.g432eaa2c6b-goog


