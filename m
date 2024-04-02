Return-Path: <linux-kernel+bounces-127945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1520989531F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D761F26727
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C98880C0C;
	Tue,  2 Apr 2024 12:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iq9CgbTy"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67D25E091;
	Tue,  2 Apr 2024 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061351; cv=none; b=oOB5DNbQAE1apG6HkCdsaBh/FZbWQTW7yPOim+2p8K1WYyIHfpyftjGP/jMCUlKbyhvOAzOLDf7HoA/Uu8NgJGzq2JISrbCJtYT4ESniBQXmydKd75+qh0grNLWefk00jeDvfPK4j89nGlfvhubodre9fSfi+9Y2orHNTkVWh6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061351; c=relaxed/simple;
	bh=yttntcbGv1rjrMQwihDL4ilF0mWCvexOhZ1EdVdFMdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TkoHDkFpg+/yNj+bIc3WLRo/KuuGsmUb/+KMpfK8oxxk3L9geZuHI/0Wt55hSI7Aq5Dq3AvdLNgSpR4B2630mT9aHJnO5aGj6eB9G0Feh7r72ZHe1EZ5mhf1mIz9x0ErMsmk0JuwKFNCi2x6le3rlrIZNS5I5UOUfgXVQVGOmHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iq9CgbTy; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a46ba938de0so674674866b.3;
        Tue, 02 Apr 2024 05:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712061347; x=1712666147; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mO0VYY/uUQKVe3GaMZmIbsUsCB+b3zhOgmSKs8mfWUc=;
        b=iq9CgbTyDFIRcf6VxLRkc38d6CQ1ctjYWHT9jYsXVndVhg25w8b8DECHNB89PKm/5q
         XMpc65AQ4xMegwQtE77RS6b/EjXiRvYvQSqf1zT4Aa4DnN9eG7P+ZIpLJb/dzYZyAd8R
         J6E/AJsEdksu0dwMXVVCtAIpbjQyRKt3GG2yQ6qlsc/tESk2ntHBa/vW+lPb3P0n5z15
         k4cJZl4V/9gKytTRht4GLmUsoKOLd0+jL3qmZzz57/VHJEU0yKC9LT+qVzZi1NxCGA8x
         EDUuLUoa7Il3/82QfYtoPGw7UPaaqCjrg74DcwRwc6V5KiQbmziWTF33RUcZHHxT/Tu/
         oDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712061347; x=1712666147;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mO0VYY/uUQKVe3GaMZmIbsUsCB+b3zhOgmSKs8mfWUc=;
        b=H0B7DduO+NPjsytU1t9I0ai42seFMrvm75+ktnrwivNA9ioYwUScEijUcXp8XGOzzt
         2Ow8aEDNNwWuKK2VLOl5HJk5aF7nwlJXp25RIeIkle7Az9/zyfjNk1/tNFs5g3t3pdqV
         27YppCZLsWT1E2VXIJgfxViRMcJhtL9FscAxNJ46VgvNDOeNY2n48VtIk/VbaKh7rWrs
         7tThNmCAlMErC7lfJbR0qDjsekLhaBA6uSiyNptAIE5Ophk00uLgyMW5QrI1SktU0sKe
         b94k1YSwgc1/Cy7LoXmPcwjbE5ptOJz9+n7hSPnkLZ6nMTIibEOaoXH4BVH6xX8d9NrB
         JuoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4dIB4ltE2ncLkg5qgpdRt+C5C2UheQE5ufR/jcxk9+IDKs2wXltuNHrd4g3vbspgqhxs+IaPRswBsquz3d9oAK0CIOQTCH6RBtjwDLqb3A4jqSU9yWArm7SV6uqVANS8oIlA5PxOHp7fyFW4UQZIDRRzzq9K+nDNQIt9tTuV72tDObZG0180=
X-Gm-Message-State: AOJu0YxiX7wkTIEv0B5N/NWJWVPHMngb5r4FJu0b/1GvGRDXwb0INxew
	mesedejwe1dMoWmyt/Wk1W8aDIQSjcBGv878ihCzGzuT3e8mFUBP2MH89OJCRQo=
X-Google-Smtp-Source: AGHT+IF8oLB9vfdG3q5IIijqVLtZpBQOAI/Or52cw8Unoegbf2HaSAuZp0breyTnxt0qv+2+UvSX7Q==
X-Received: by 2002:a17:907:174b:b0:a4e:2543:29f1 with SMTP id lf11-20020a170907174b00b00a4e254329f1mr9249630ejc.2.1712061347503;
        Tue, 02 Apr 2024 05:35:47 -0700 (PDT)
Received: from [127.0.0.1] (net-93-65-126-18.cust.vodafonedsl.it. [93.65.126.18])
        by smtp.googlemail.com with ESMTPSA id x18-20020a1709060a5200b00a46ab3adea5sm6467506ejf.113.2024.04.02.05.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 05:35:47 -0700 (PDT)
From: Gianluca Boiano <morf3089@gmail.com>
Date: Tue, 02 Apr 2024 14:35:42 +0200
Subject: [PATCH 1/3] leds: qcom-lpg: Add support for PMI8950 PWM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-pmi8950-pwm-support-v1-1-1a66899eeeb3@gmail.com>
References: <20240402-pmi8950-pwm-support-v1-0-1a66899eeeb3@gmail.com>
In-Reply-To: <20240402-pmi8950-pwm-support-v1-0-1a66899eeeb3@gmail.com>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Gianluca Boiano <morf3089@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712061344; l=1292;
 i=morf3089@gmail.com; s=20240402; h=from:subject:message-id;
 bh=yttntcbGv1rjrMQwihDL4ilF0mWCvexOhZ1EdVdFMdw=;
 b=CgD8vsF+5yZPAgO4fIcSCzHI6meFW5vzh5De2I0Cwo5gClwLkvTQFuxFd2+0t79M/g8YDnGA/
 Fln/Y7qao5KAXIeskzzVRaEcfYlKYDoj2G6AoZZUj5koLzaiTtGw+FJ
X-Developer-Key: i=morf3089@gmail.com; a=ed25519;
 pk=HsGrEQ3ia8BGGGO8/nUM2K2UX9JKvRPV+nbrVDGrYhA=

The PMI8950 PMIC contains 1 PWM channel

Signed-off-by: Gianluca Boiano <morf3089@gmail.com>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 6bdc5b923f98..9467c796bd04 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -1693,6 +1693,13 @@ static const struct lpg_data pm8941_lpg_data = {
 	},
 };
 
+static const struct lpg_data pmi8950_pwm_data = {
+	.num_channels = 1,
+	.channels = (const struct lpg_channel_data[]) {
+		{ .base = 0xb000 },
+	},
+};
+
 static const struct lpg_data pm8994_lpg_data = {
 	.lut_base = 0xb000,
 	.lut_size = 64,
@@ -1819,6 +1826,7 @@ static const struct of_device_id lpg_of_table[] = {
 	{ .compatible = "qcom,pm8941-lpg", .data = &pm8941_lpg_data },
 	{ .compatible = "qcom,pm8994-lpg", .data = &pm8994_lpg_data },
 	{ .compatible = "qcom,pmi632-lpg", .data = &pmi632_lpg_data },
+	{ .compatible = "qcom,pmi8950-pwm", .data = &pmi8950_pwm_data },
 	{ .compatible = "qcom,pmi8994-lpg", .data = &pmi8994_lpg_data },
 	{ .compatible = "qcom,pmi8998-lpg", .data = &pmi8998_lpg_data },
 	{ .compatible = "qcom,pmc8180c-lpg", .data = &pm8150l_lpg_data },

-- 
2.44.0


