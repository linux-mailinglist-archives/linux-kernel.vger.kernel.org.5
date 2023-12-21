Return-Path: <linux-kernel+bounces-8181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6507C81B33C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23167288441
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B1651C3F;
	Thu, 21 Dec 2023 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWHNVVzp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2904F60D;
	Thu, 21 Dec 2023 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2335397e64so71533966b.2;
        Thu, 21 Dec 2023 02:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703153450; x=1703758250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GF5s6M+Wn1BIKkAOEW/8xBSTlKtmOm9F7gA3mT6ZChs=;
        b=hWHNVVzpb4I9vfmqA2i09xrQ8uVOJau79HYcujTVprv4RwesGSdTx6OlX72L1Wo+5y
         6y/SvVBvzZ8z7kvx+S7fTfPkcDxqea8I9Nhdkju8/cMfIZKegEArenG+T2tjJUlneqTF
         0zoe6GgwxnwoIL+EYEUiKlCLXzmt3HLXuHdg0LP8vWI3qzxvWP44iD/wuper1LRNrk0o
         2SVqs3FoFk4eBcWqB3UiOugB8iKu6Fl4NDKKz9YOglfGCShUnBI+HEzPPeququu9a3su
         b6qfXmiKWeFnmdd+PLovD+Ido4cSSWxupJXxQDbTHYCLRh1SuastiMsCv6AbUiIYeEYA
         de/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703153450; x=1703758250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GF5s6M+Wn1BIKkAOEW/8xBSTlKtmOm9F7gA3mT6ZChs=;
        b=Sea9DwuYaZ6n48HVRLo+FbW85aK0aQvb9tnm6Ko7P9X/FA+cOEovHKlqMIU6WD49PW
         1G0vXCBmfaCsT3svyAhE6LEeTP8AWal9OMLU93QCLUiodOuU3j5YGfr6vos4h/weNJmK
         AH5gQ+dGlsPTMnryzKhfQeI8p/qSqdRPRI9swZelgSMo5ISDoPAHfnUqWhcLpoMb/d4A
         uZXw4nEb8iDaFeHxcFTENM1FA9hESwyAtWVokF29enrLpbxoW/6+mHhHPnsx8GjbduTv
         VJKLo779fmOIGFAFZCldFnWq3FyNpkJNMa1TZEhLE4rr1vx3H+ybeDLppc2hw5GQaJWM
         kcsA==
X-Gm-Message-State: AOJu0Yw6GtZ2YT4jXDyIuaVhcMJb0GkUv7Gm0qloxcmP3WSyeFYRvxHQ
	M6OLj/dplMr2/hAEc6isaxE=
X-Google-Smtp-Source: AGHT+IHL1Ma08mPb9cC1GlQdvGSlGcloQ/GpQp0NxOsffwhypNZRsAeFEGADJz/75DK6viyXViInjg==
X-Received: by 2002:a17:907:3f9f:b0:a26:a1a7:a67d with SMTP id hr31-20020a1709073f9f00b00a26a1a7a67dmr675031ejc.46.1703153450118;
        Thu, 21 Dec 2023 02:10:50 -0800 (PST)
Received: from localhost.localdomain ([154.72.163.204])
        by smtp.gmail.com with ESMTPSA id x7-20020a170906b08700b00a25f5dba09dsm784928ejy.145.2023.12.21.02.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 02:10:49 -0800 (PST)
From: Brandon Cheo Fusi <fusibrandon13@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>
Subject: [RFC PATCH v2 2/3] cpufreq: sun50i: Add support for D1's speed bin decoding
Date: Thu, 21 Dec 2023 11:10:12 +0100
Message-Id: <20231221101013.67204-3-fusibrandon13@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231221101013.67204-1-fusibrandon13@gmail.com>
References: <20231221101013.67204-1-fusibrandon13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds support for decoding the efuse value read from D1 efuse speed
bins, and factors out equivalent code for sun50i.

The algorithm is gotten from

https://github.com/Tina-Linux/linux-5.4/blob/master/drivers/cpufreq/sun50i-cpufreq-nvmem.c#L293-L338

and maps an efuse value to either 0 or 1, with 1 meaning stable at
a lower supply voltage for the same clock frequency.

Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
---
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 34 ++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index fc509fc49..b1cb95308 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -29,6 +29,33 @@ struct sunxi_cpufreq_data {
 	u32 (*efuse_xlate)(u32 *speedbin, size_t len);
 };
 
+static u32 sun20i_efuse_xlate(u32 *speedbin, size_t len)
+{
+	u32 ret, efuse_value = 0;
+	int i;
+
+	for (i = 0; i < len; i++)
+		efuse_value |= ((u32)speedbin[i] << (i * 8));
+
+	switch (efuse_value) {
+	case 0x5e00:
+		/* QFN package */
+		ret = 0;
+		break;
+	case 0x5c00:
+	case 0x7400:
+		/* QFN package */
+		ret = 1;
+		break;
+	case 0x5000:
+	default:
+		/* BGA package */
+		ret = 0;
+	}
+
+	return ret;
+}
+
 static u32 sun50i_efuse_xlate(u32 *speedbin, size_t len)
 {
 	u32 efuse_value = 0;
@@ -46,6 +73,10 @@ static u32 sun50i_efuse_xlate(u32 *speedbin, size_t len)
 		return 0;
 }
 
+struct sunxi_cpufreq_data sun20i_cpufreq_data = {
+	.efuse_xlate = sun20i_efuse_xlate,
+};
+
 struct sunxi_cpufreq_data sun50i_cpufreq_data = {
 	.efuse_xlate = sun50i_efuse_xlate,
 };
@@ -54,6 +85,9 @@ static const struct of_device_id cpu_opp_match_list[] = {
 	{ .compatible = "allwinner,sun50i-h6-operating-points",
 	  .data = &sun50i_cpufreq_data,
 	},
+	{ .compatible = "allwinner,sun20i-d1-operating-points",
+	  .data = &sun20i_cpufreq_data,
+	},
 	{}
 };
 
-- 
2.30.2


