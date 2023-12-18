Return-Path: <linux-kernel+bounces-3411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E889A816BEE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4A91F2377E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7CD1BDEE;
	Mon, 18 Dec 2023 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/jTV9lw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20A218C30;
	Mon, 18 Dec 2023 11:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cc5e48779aso17283191fa.2;
        Mon, 18 Dec 2023 03:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702897622; x=1703502422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SZpEgDuZF0Kd57Q/v4Kq9sCIukMURy5kzt0ohYZmr8=;
        b=S/jTV9lwoRvLKVEi3dfPE/aRV8rSmCa43/YIt+9SvkXYNnXLnX9SpkXsDlmdftHEUM
         yWX3VoEsg3X3Z8WUezvWorKrL9iTXCCo29tSdhc57n+ZZ+TZLwSi04pghO66QVuCS0Ts
         XXtKHZ7IElSkAYYPkhHQabwBZxel39lxqFV0OPehsPnrd0G5xMnwRm38UhL6rX3CT+4K
         bYNMVAfrq7/9eXd3A7mu6b9ia8jrSWlvlmdFkGK0sD7Qs9ePUbAX02x/VxR/OAn0RC1o
         +6HGAjygFy7959dFuDZJIqjmKKFndxYWBD1fhyiZEoLOEu7iVyYZ57am6vuCSKouXnVI
         cn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702897622; x=1703502422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SZpEgDuZF0Kd57Q/v4Kq9sCIukMURy5kzt0ohYZmr8=;
        b=AS3Gr7HQ5EAi0p7inVmk8QwqHyALTapoDw4MYt6UofLGPEjyyJpvqD4I0nUgvTHAQm
         QgDKGTzftkkZNTmmw2633IiYVPniQqMKKbZe6MJzDSqkTjtsLI3/WuxDzM1RdAhDHrdb
         377eh4bgvXJPyL7kQmAedmLdGyHMGfmxvNGHVEN4TozITtAb14Ae0+WMsF9azPHK+dxr
         VvIftwi+PCnRNM03TNrNC0X1xXRi5I9Du2jL49r90VxWKQ7UWYbdE+EzNr2D1iPV9biT
         qYUbVD07A6kr5NLaFi3rZWQKQeaJgMdBHDqnybC5HuKjjReFrRqkdDtwsPhq5M3b2/MV
         Na6w==
X-Gm-Message-State: AOJu0YzVuWHVmO/brliES0J3ULb+I/UcM9Mw54W2Vz0KMts9cmZyojZL
	/xL4Xg7QrYCD3DPdPrOOnLI=
X-Google-Smtp-Source: AGHT+IEEPpv4PbOGki1wpFYE/FNbr0LMBpvRkHRipU02IysiUzOQcuXrBHqB/ytN1/Alf/94bokq8Q==
X-Received: by 2002:ac2:4d12:0:b0:50e:3dc2:ad16 with SMTP id r18-20020ac24d12000000b0050e3dc2ad16mr142258lfi.232.1702897621400;
        Mon, 18 Dec 2023 03:07:01 -0800 (PST)
Received: from localhost.localdomain ([154.72.163.164])
        by smtp.gmail.com with ESMTPSA id pj4-20020a170906d78400b00a2353af1f7bsm1406769ejb.92.2023.12.18.03.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 03:07:00 -0800 (PST)
From: Brandon Cheo Fusi <fusibrandon13@gmail.com>
To: Yangtao Li <tiny.windzz@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>
Subject: [PATCH v2 4/5] cpufreq: dt-platdev: Blocklist allwinner,sun20i-d1 SoC
Date: Mon, 18 Dec 2023 12:05:42 +0100
Message-Id: <20231218110543.64044-5-fusibrandon13@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231218110543.64044-1-fusibrandon13@gmail.com>
References: <20231218110543.64044-1-fusibrandon13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner D1 uses H6 cpufreq driver. Add it to blocklist
so the "cpufreq-dt" device is not created twice.

Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index bd1e1357c..2febcfc2c 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -104,6 +104,7 @@ static const struct of_device_id allowlist[] __initconst = {
  */
 static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "allwinner,sun50i-h6", },
+	{ .compatible = "allwinner,sun20i-d1", },
 
 	{ .compatible = "apple,arm-platform", },
 
-- 
2.30.2


