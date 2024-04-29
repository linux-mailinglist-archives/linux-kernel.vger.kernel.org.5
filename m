Return-Path: <linux-kernel+bounces-162749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA038B6008
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40CF1F21761
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94131272B5;
	Mon, 29 Apr 2024 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LkRvuc5b"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8AE86652
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714411739; cv=none; b=FlBW/WjUiUBQ86QwtZGO+7aBrvPrCUTg0cf+CCILYWPNxB44wyjuQw5Ie+BHweQTxaLBvx1VLXQBOPj5X/4o1sFJvGMQC3UZjFkH1s4BVCyoJKJA6fZzZvfWxNI3W1CFdnar2G/TJiBbfzLcd2IB18R3L+mARiCq4tu08qDNqjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714411739; c=relaxed/simple;
	bh=PxWdf9Kkj0n6VHhFtbztMb/tWZE85qZYX2SkOsfKcdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCrA57epaCp7suQlpkhl6P20vrM3D7AZ6x0mhmqPoWrnCWQLabgvFRRa0ZT+sc9wb3qmpoLEQVPKQ4n+DWU158rZ/tYnAuwGS6MmKmN2S3RBomWqAlru4AA3Co8IkVa6j83Dp5TKdYoGjBHnD2K1bEQbP/Wh671whtM97fz5Cmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LkRvuc5b; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a524ecaf215so600749666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714411736; x=1715016536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfvUr/npMdZ/GS2t3ldGkKTtvFh58aymblnh7l1bHtk=;
        b=LkRvuc5b4mfRBsVCtYHEsW3AUOr4XzTrBwrQM4GJAPaetanel39BIpomj4KajuonWE
         YNDDNuwQ1bb0NS3vr3/g7y5kO+26ZkXUpBMw1xOq9+C9uTOjraBA/4YKudZIS7Ddy5Dd
         40iahqwfribZlNqm7nrhvN5QIaTpGwlfPRzSCu5+uO1wNVYhIyXOqWjCCGyMW6TzS7tP
         pF8n+k4w8kJIs7nMAjIXb3L3+MZXRkA9YXqgEWxAqaAVuGPSZJ/kyRC9yAukUuRW9hJ4
         gwSI29RgWWVrSIneuLuFuDizwaulTdn5zXQiY6bVCkFpsDWWH1048utt43BOp76vzds5
         S+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714411736; x=1715016536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfvUr/npMdZ/GS2t3ldGkKTtvFh58aymblnh7l1bHtk=;
        b=r88LqJF12Bd7pQU1FhKefgYVFMLkOxGdB3pz0yDQcZcvwTtOMQlwJn3BY0WbjilKvJ
         n2L+rQ62945Nf7NQ5W7Ze4BtOgreQcIzb6cG3bZwKVsIBPnU2HH5gyFFfs5UHU4+MrS6
         fnmpP4eArwUxoX2B6N4Wmrmu6qm2Tkp0rtCRduh5t5Iqo0nqm7JNz9EGzKuQKx3xUF+a
         SOpFWUp6GZGjo6gcAcNNwmUTxRD++TPX6N8/64UtTRk+6VaIHrORHuIbH2x+uATQpERU
         AqU86lNZa8cpss9diGxers5ziAmi9PMeg8msREwVdmxcqmku/K70G1C8sNZPUMOma0Kk
         +CcA==
X-Forwarded-Encrypted: i=1; AJvYcCVTta6m0mVRXbOABvod5JqhfTRFCy27uuex9R2BUnaULqdqp+CWhmaHkMEHH3uM/CPC8lcW8jZcY1zsp7A57AH8u9Nd3UpNrnG+EVUj
X-Gm-Message-State: AOJu0YzI9PhESU9GSiAkp9gIXsEWb+z9xuIoHUPtA5DEJZDdLH0UrONi
	DiGdaiBCv5QJCqoKocj8Th0BhOZOIbLAKUPL4JkowYF5zTlmiKlyLQtP3yFXLGQ=
X-Google-Smtp-Source: AGHT+IHXKKToeyb3BoIe7riCQypv2ZercpV0O3E7vrpAKyMXse2leBAsPr7FdPKCLzbfNcuNrVeftw==
X-Received: by 2002:a17:906:3bcf:b0:a55:5ed2:44d5 with SMTP id v15-20020a1709063bcf00b00a555ed244d5mr7457851ejf.68.1714411735610;
        Mon, 29 Apr 2024 10:28:55 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id u8-20020a170906654800b00a58f15b070dsm2556560ejn.43.2024.04.29.10.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 10:28:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	kernel-team@android.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] clock support for Samsung Exynos pin controller (Google Tensor gs101)
Date: Mon, 29 Apr 2024 19:28:50 +0200
Message-ID: <171441172281.306662.17546797534297489946.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240426-samsung-pinctrl-busclock-v3-0-adb8664b8a7e@linaro.org>
References: <20240426-samsung-pinctrl-busclock-v3-0-adb8664b8a7e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 26 Apr 2024 14:25:13 +0100, André Draszik wrote:
> This series enables clock support on the Samsung Exynos pin controller
> driver.
> 
> This is required on Socs like Google Tensor gs101, which implement
> fine-grained clock control / gating, and as such a running bus clock is
> required for register access to work.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: pinctrl: samsung: google,gs101-pinctrl needs a clock
      https://git.kernel.org/pinctrl/samsung/c/dff9f3fb6ba4f74eb805bc172cc16ff2c91648bf
[2/2] pinctrl: samsung: support a bus clock
      https://git.kernel.org/pinctrl/samsung/c/f9c74474797351c60e009ebc59a798fcfd93ee57

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

