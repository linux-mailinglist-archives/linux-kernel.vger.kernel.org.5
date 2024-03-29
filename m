Return-Path: <linux-kernel+bounces-124430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D874589177E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163771C2257D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFE869E1E;
	Fri, 29 Mar 2024 11:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NU1GrEP8"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693704439E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711710964; cv=none; b=AxmJLonk5zozrNYEQ7d3pQ6SQ0O/eryGhulaNWa0tvVfnK0l+zSyh0Wo44y3ZGKDRpmOcRDim+LRYRdC7Lr+ueD0Ef9a7ht4nAu33IZM7fipHhJUrKZ9bCNH897Qhw4ieglU+AFQkvGUe4XZiJ5kE3CpF6ZRnlYpApLdyYwi+3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711710964; c=relaxed/simple;
	bh=9qFCQ24+WMyGwKG9pNLGqMNb6w125Z61rcL+j5/le40=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UB1lEeUxCVIzf3MS6KclEwp+VSBXvNT1569e18MXSaMMJQFiK3tyPXtEhEL7GcTg4ATK0ZdlnG1NkDnQ2Lt+IKS5M5/lYQPr4AJmgD6k3N2J1FoNuaX7n1bPvKAav1k1D+ggm5vXFoPIDMCldKu3BdsXq5D1zbFn+s3XGAgzs7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NU1GrEP8; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33ec7e38b84so1312210f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 04:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711710959; x=1712315759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cSRTNdeJ0rKAdmni1uoS6PPPrRP+OSa+PK1yc6fqCg=;
        b=NU1GrEP8G9o0RVY4vkRsy2Kf+p3L+rZCC7Z3fGWdmtKuqXDyUnIjFImMxNchnxKFDf
         MyOZz8AxT718gxE+AF546dFCq2T2VCooFJUIv7HrCbFABhQXH/lElv7kIQeCX/+0CodF
         VRuwg023vlrAGeGNkEaHfjy9Mbuys7frQLw1yyJaumncV0hnrHMRXRVJ+RcJ/lwyE4XA
         pqHJqZM2p9VavQ9WtzitdQjKQYzqvAjcaVvgFm5SuTF6iq9MbryLliu/3JeJuXEtauVr
         ey9NYZhKOTR9FtIlluW+QyF14qdp/9ZgYmosEa1RSdcR7qd5qy8/zU7L9a5Z5MUqo8kr
         YumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711710959; x=1712315759;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cSRTNdeJ0rKAdmni1uoS6PPPrRP+OSa+PK1yc6fqCg=;
        b=E081GsvGYWQc57OdUNO7NC+mwQLK6F//ejK5SLcwi1hR054LZHCVq52ZVrJufCzu60
         X8EHUg0sqXCCPuAnJhRpGsiVRxhm97K6RJBJxghxrX9dCrpUtNzom0ccFKa5rk3kNqZI
         eFRtQ+slDxR8OGh+9/uVyiEKTSsWWge19s9l7rcrN2bpWeQqqyx5J61Z0J8QYTCyX8Vb
         WVQsaXxC87G6pHvT7Wmk2E2njtwwxIc1j5HBEsFseLLCsTh+2nOwMTbDesmLvQx1+h95
         fQhzU5A0JFpfx4RNrJF6dEw8VIGfn+R+ca/VJ/eqx5iqvibt7TSlyEF68IBzWV3JYw2S
         0OTA==
X-Forwarded-Encrypted: i=1; AJvYcCUwj/YurYXpcdP9LL+Dv2l97ysqmYjPlSTUXLdfPuNsvmMacSA/CQMMzOxd/KloXBWgy/9uINbc9JrCnEitDYaF0QAss09HYPi0/bjh
X-Gm-Message-State: AOJu0YzoGvCsARu2oeG2JKPb52F1I2OZs7SL2ehh9ivSMcfswKpE3JVC
	tLGQU/hQtEUQx1F1c6aLuSQ36l3AOIxu0rOAbD4dHytKlmcAf9ZpMDD0Eyafyuc=
X-Google-Smtp-Source: AGHT+IEQJ3nF483DRIx3ovQYuMQsN/YY2JEmHM4jst0i0/VT097BhrM9JqARNl4Cnfbc36mkEMPz7w==
X-Received: by 2002:adf:e011:0:b0:33e:7896:a9d7 with SMTP id s17-20020adfe011000000b0033e7896a9d7mr1233872wrh.67.1711710959408;
        Fri, 29 Mar 2024 04:15:59 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:f8f5:63d4:de5b:e4de])
        by smtp.googlemail.com with ESMTPSA id l14-20020adfa38e000000b0033e93e00f68sm3985741wrb.61.2024.03.29.04.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 04:15:58 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: neil.armstrong@linaro.org, mturquette@baylibre.com, 
 khilman@baylibre.com, martin.blumenstingl@googlemail.com, sboyd@kernel.org, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: kernel@salutedevices.com, rockosov@gmail.com, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240320155512.3544-1-ddrokosov@salutedevices.com>
References: <20240320155512.3544-1-ddrokosov@salutedevices.com>
Subject: Re: [PATCH v1 0/4] clk: meson: treewide: define maximum register
 in regmap config
Message-Id: <171171095856.1276233.8031713051223267564.b4-ty@baylibre.com>
Date: Fri, 29 Mar 2024 12:15:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

Applied to clk-meson (v6.10/drivers), thanks!

[1/4] clk: meson: a1: peripherals: determine maximum register in regmap config
      https://github.com/BayLibre/clk-meson/commit/b6e2c6548074
[2/4] clk: meson: a1: pll: determine maximum register in regmap config
      https://github.com/BayLibre/clk-meson/commit/acc628adc363
[3/4] clk: meson: s4: peripherals: determine maximum register in regmap config
      https://github.com/BayLibre/clk-meson/commit/32fba1c16576
[4/4] clk: meson: s4: pll: determine maximum register in regmap config
      https://github.com/BayLibre/clk-meson/commit/5995a2f26f83

Best regards,
--
Jerome


