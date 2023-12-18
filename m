Return-Path: <linux-kernel+bounces-3410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A80816BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C969F28431F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FB11A27E;
	Mon, 18 Dec 2023 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fL2/6P8R"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F411A27A;
	Mon, 18 Dec 2023 11:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a233a60f8feso150085866b.0;
        Mon, 18 Dec 2023 03:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702897611; x=1703502411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YMMP/qsVfdoJtEElBLyEEO9c305KOAYJqUkekDdPZs=;
        b=fL2/6P8R0UcYLbOSWLmu4ATxTxGp1TZd+yy+wyKCn2VNyb8/99PfkiKQLd54VMrrsA
         tvT444JcjZBo2GS7kMGsIKNQ/xtf0MOG8ZxHzswWO/xReQ08bQK0WQcricsN4rVfuZBA
         7692wJcJxepOgx0bfOBg1PnQCNSvb07v/u8La2sby7sxr5Bleq0CRN3CSYbFAon3p5Oe
         /tLosjBeV98XjUtsfHA5iKL7o6XmriSewDQ0nzTMpIvUr8HMYzfJkqmmlC08I5o8WqY6
         zBiUHHH4hyPmy/xbonM932XFQC/BIXLusLtXXrFJ2qTRO1SkCVvC3GL/JmnD/sIEiLSn
         gi1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702897611; x=1703502411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YMMP/qsVfdoJtEElBLyEEO9c305KOAYJqUkekDdPZs=;
        b=fV7mhh8ZyWG7H7rsOCPMACnrNJduBfPWVfve92QDk92lT/vJCFJFKa58RXIBRRnfI+
         EOuel6K3MyhrKRo2JtNMMJXQKViDX08o5VwK6BHl26vPLK+hRk7O3eFgDkQsYXuH/pP3
         JXFlJ33biPvEUTna2P7bub0gBEoCAgZbkiNikzmGA+EynFu9rVab0BvMSgNOVDBsAxiq
         GdIUpehPZ6bdYvm6Ig4+bCCbmq24tjR/xto4i9oLyV+MNgL5iz01t7Gj3LV8aMCKoXQG
         8xdOli34d7BSaHQ6jvSAY/3jHuLtD/LpBp1It9u2TT85PM/kczRiG+G/ylt8X9LpUU/d
         Aa4Q==
X-Gm-Message-State: AOJu0Yyv4g8MCw5Zrn002dLreCcoqkqaUQUNWh7NgVgkzE5sX8Y1LxhT
	ayn2aUxUx6QwosvEfKpJo3I=
X-Google-Smtp-Source: AGHT+IFvCQuixkVNgpJoy4iekrTbntIvFyqQXesXqFyDPHUVUrNSA7K6fhKQ0zABch1KMEk0awPKmQ==
X-Received: by 2002:a17:907:6094:b0:9fe:5d39:41c6 with SMTP id ht20-20020a170907609400b009fe5d3941c6mr8647546ejc.51.1702897611128;
        Mon, 18 Dec 2023 03:06:51 -0800 (PST)
Received: from localhost.localdomain ([154.72.163.164])
        by smtp.gmail.com with ESMTPSA id pj4-20020a170906d78400b00a2353af1f7bsm1406769ejb.92.2023.12.18.03.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 03:06:50 -0800 (PST)
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
Subject: [PATCH v2 3/5] cpufreq: sun50i: Add D1 support
Date: Mon, 18 Dec 2023 12:05:41 +0100
Message-Id: <20231218110543.64044-4-fusibrandon13@gmail.com>
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

Add support for D1 based devices to the Allwinner H6 cpufreq
driver

Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
---
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 32a9c88f8..ccf83780f 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -160,6 +160,7 @@ static struct platform_driver sun50i_cpufreq_driver = {
 
 static const struct of_device_id sun50i_cpufreq_match_list[] = {
 	{ .compatible = "allwinner,sun50i-h6" },
+	{ .compatible = "allwinner,sun20i-d1" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun50i_cpufreq_match_list);
-- 
2.30.2


