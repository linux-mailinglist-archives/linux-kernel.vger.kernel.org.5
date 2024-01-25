Return-Path: <linux-kernel+bounces-37861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E996383B6AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1421F23199
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E6B10A21;
	Thu, 25 Jan 2024 01:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DyVLwgf4"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA488A3D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 01:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706146548; cv=none; b=DI6xe9kfFHFDLu9t+0f3kgA3vUcj63j6TF6ZsW+YOpBxm5TbD9+dUsDsj/18N10i6jJSvpuSy2NTuSk6bj1YDTbgRFbyeUNo3EejJprD5hmgeDoC9ckea+3/Cc7y0lB8XsieJJGI88EPH9YrhWaqXQia90NPYow3Ao2dKhaYWak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706146548; c=relaxed/simple;
	bh=gvS9OR872hMLDwjbJt9LD4SXHkhJWBAYwtl2RkaXhw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lhHBu0svqUS1CRE0ciWAl/zJQH5xrG6SMmcSP1ra887aea8Er8pmsatiXWYzQs1T/Y05Oat28xRg/F2EBWGYjk51yu8L/hSmD2TGfWkr5xEdy7b7iCq4iU1LfQc/c+Gn9yJBPJoI0heM1rxaKDnEO+hD8waG1w9LTnHUZqAbYcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DyVLwgf4; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-210cc863229so3177291fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706146545; x=1706751345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrTPIRFEFJl4D6usMUg96I/YEqaZ4s0DmE7WQLKQltI=;
        b=DyVLwgf4SMZKgX/HuWJm6AONwqK7BQUHZd2HZkW8dipo+ACRGZfRTofRCbttgFyJYF
         sLDRl4HEXbFYlTxlmtDN1NpB0+vVGSxDTA7rpKX5xkuvnH8bBuK2zySvaH5IMKeJcofu
         k2vvr8oThswxENpHeKvnyfRYVjUMzGi02/VCLMqHHCojSGOBeF7z/O5xD7Go9JmzGmbu
         2s6HbwFUYkBgNvJ3DJNb3kD2ZDL2imgOMRtjNx9gmUR97Y39kpM9uasx7NXz7gdfZeI9
         Zg6JNGN+faJAY11MveOtv+r4c0zZYieCE4JwwSJHQ+IZAqfP0ypeeNd31s0zJNPeMUii
         WieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706146545; x=1706751345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrTPIRFEFJl4D6usMUg96I/YEqaZ4s0DmE7WQLKQltI=;
        b=wZmGNbXyfKi3d10UfFO3HvIOZKoFbE+U9RkvvermOi8LPyWVbdy3lYp4Owb5YxOkHN
         mHplvlV7deVA8IRluSu+ALqVxkCmvToEBbI74BvejLSI3WfI8mzpkG2rYEibYCkPgc2q
         cvHjNujF2Ep7XfOaiA1S0E6R63TsrFWK4XTyvHl89aIFyMpiwt0J8k2dv8ah264Awc7E
         RzaF68JlmQUBRWJONuIXgMA/Nlk9G8P0+P04zatcpAuY98XQ6f3S9LAIJdAgx4ensezr
         cxYslxtbknNGoEbe7iSrso/vS7C9TDMq/srTzyO3TF5LKOrgPUB35vP8tRjGA3bKOAYe
         mgKw==
X-Gm-Message-State: AOJu0Yxa/1TjbaNBB4F/0BO5K0uTd4NsArPLffFiMTKmsHngho3m7NnE
	ONJnxWDp7Xd+sVUtPNtgFbpkEi39rqcv8E15XZ6rXLFWYTkcABxuEvxYY2tf65k=
X-Google-Smtp-Source: AGHT+IF3NwE0mZ28Ss+0PVwv8nCKU3mV6Ff3m1ZDji1UuD5XHmoV+07SSc21F/vfqXbluZjjyIrAbA==
X-Received: by 2002:a05:6870:817:b0:210:d5a5:7d37 with SMTP id fw23-20020a056870081700b00210d5a57d37mr190367oab.22.1706146545100;
        Wed, 24 Jan 2024 17:35:45 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id xa13-20020a0568707f0d00b00210d8274204sm2999081oab.23.2024.01.24.17.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 17:35:44 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] spi: dt-bindings: samsung: Add Exynos850 SPI
Date: Wed, 24 Jan 2024 19:35:42 -0600
Message-Id: <20240125013543.31067-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240125013543.31067-1-semen.protsenko@linaro.org>
References: <20240125013543.31067-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document samsung,exynos850-spi compatible which will be used on
Exynos850 SoC. Exynos850 doesn't have ioclk, so only two clocks are
needed (bus clock and functional SPI clock).

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Changes in v2:
  - Collected R-b tags
  - Changed bindings patch title to "spi: dt-bindings: ..."

 Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
index 79da99ca0e53..f71099852653 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
@@ -22,6 +22,7 @@ properties:
           - samsung,s5pv210-spi # for S5PV210 and S5PC110
           - samsung,exynos4210-spi
           - samsung,exynos5433-spi
+          - samsung,exynos850-spi
           - samsung,exynosautov9-spi
           - tesla,fsd-spi
       - const: samsung,exynos7-spi
-- 
2.39.2


