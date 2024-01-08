Return-Path: <linux-kernel+bounces-19195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FEC82699C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5FF91F21227
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F93C2E6;
	Mon,  8 Jan 2024 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gq4D9Z2p"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FDA1173E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2ac304e526so37089466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 00:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704703081; x=1705307881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmR9KxQP8dD4PzUTQD7z34F00y2gKvodpqxcPdEO1Jc=;
        b=gq4D9Z2pMuu990PveRM7Ho9mA8QXwLC9Wup3I/2NYHu2KB9aMvNQeZp4/R26ZKZzVt
         GDPoL5FY+8ZDO/HqfSyVQplqqPr4wNenh3ADokOXiJE6TaRyOyVArRYfesyLCyzeBEXH
         z5skURwFU3hhRR+oUv0b0VcLRNNgR9uyR6lIVOq41lQErNPGYqMC08WKrVI+6hmx26Nb
         pttdftgY6XIrhCFUPXwDChN1TC6Y067JCPbY4MPiBnKdQfslzIocQIoZT5prcAQB3pLL
         gnf0dp7QD0lYqzszEBmM5wtZr3wOfuaAHH2c3AHWBbXLT/1r+wjVipSE/AsUfSZjq2/p
         Bq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704703081; x=1705307881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmR9KxQP8dD4PzUTQD7z34F00y2gKvodpqxcPdEO1Jc=;
        b=vExrCoUqbbxogKeqs2WY6ACb009rcLQIqHE669HJtA50TK9SZb+/ACT4IBOQ4gK5RG
         +uexIPbj1GxOYIZMbE8Zl/AussYtqLUp/PydRZnlN1iehHO6dKviKI9fRpjvB9CGB0n7
         5YQzlbu6iJQ4MJLaEIdccfMP5fwJlBgeuyMpNgyU8T9OK5xqeX/CfJS6JSpmz0qXTqNc
         SnyhseUs693IRIf9pF+bNDRU1qJwh2VT4olGMhuP9iIiEj+OCJyGNhjtz/TpYjJRZ8Yd
         YTAppXvy2zz773TfJy73T15cNx4gEGKjKhqJxbEMq4D6L/lizZDdFudWSvVoa9caWlym
         1tkQ==
X-Gm-Message-State: AOJu0YzcmkgPCR4oQD0xKNyzZa5FsSuf395Z0D6Re/mz6gQ7qjli/PAY
	3HDdX7mIbfAmiD2hgJZTIitdhaGCOrYaOg==
X-Google-Smtp-Source: AGHT+IGwcyCWtQRwsq6lSM5m0WxXOX7TwKM4rEruLlGVkTCEypoJJzCsLna7iMU3sCXtgk8sZbKDWg==
X-Received: by 2002:a17:907:969e:b0:a26:9d95:a347 with SMTP id hd30-20020a170907969e00b00a269d95a347mr1631096ejc.25.1704703080980;
        Mon, 08 Jan 2024 00:38:00 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id ws6-20020a170907704600b00a2a360d719fsm1683504ejb.221.2024.01.08.00.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 00:37:59 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 2/2] docs: dt: submitting-patches: add commit subject prefix in reversed format
Date: Mon,  8 Jan 2024 09:37:50 +0100
Message-Id: <20240108083750.16350-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108083750.16350-1-krzysztof.kozlowski@linaro.org>
References: <20240108083750.16350-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ASoC, media, regulators and SPI subsystems prefer commits starting with
subsystem name (e.g. "spi: dt-bindings:"), so document this to avoid
confusing contributors.

Cc: Mark Brown <broonie@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/submitting-patches.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/submitting-patches.rst b/Documentation/devicetree/bindings/submitting-patches.rst
index b460ebffee42..a64f21a5f299 100644
--- a/Documentation/devicetree/bindings/submitting-patches.rst
+++ b/Documentation/devicetree/bindings/submitting-patches.rst
@@ -15,6 +15,11 @@ I. For patch submitters
 
        "dt-bindings: <binding dir>: ..."
 
+     Few subsystems, like ASoC, media, regulators and SPI, expect reverse order
+     of the prefixes::
+
+       "<binding dir>: dt-bindings: ..."
+
      The 80 characters of the subject are precious. It is recommended to not
      use "Documentation" or "doc" because that is implied. All bindings are
      docs. Repeating "binding" again should also be avoided.
-- 
2.34.1


