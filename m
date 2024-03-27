Return-Path: <linux-kernel+bounces-120454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3036088D7BC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4E51F29F72
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E324CE17;
	Wed, 27 Mar 2024 07:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DtutZk8+"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357EA481C4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525520; cv=none; b=As1IcFxv8xxkaZbt4uKuzyHAc1Sk042bF6Le6cmMC2wyrHXuqoKHgQoEa4NRO1R+/SuCjSLhSaI25oI6rUS42xoQ9ibecWkkvf+zh+R1nb5jon/MOdA4D/k1fXgK5LuLT3z0MgEeI4rfOyc6iCTePcgSdcA6b2psNMTHAT6KH8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525520; c=relaxed/simple;
	bh=PW/2fVtuT04T/hFzkPAyArLp9KqHq/nQAVkBdLFHDts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b80VykJdmyvRLBVhresQaSZ636oaB3mzldraP6Oj3DudSDXhkPF7D03L3CdUEMfVPJbc238/fVzGqeQKKMOPgPE0DxfZYqvEm9jehmGz6YSZ62hOyxH7RKhlckPXMFu96Oxs03LT8YeYQuFP1dsAdo1/Z07bxXQa3wVXkwyoap8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DtutZk8+; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a46d0a8399aso95646166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 00:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711525516; x=1712130316; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fuO0aVJ5zsguZWp2jlt4KOMyVYGLs3YtOGuM2wXyJQ=;
        b=DtutZk8+pK6XmXPIUBP6c+69JR/50RXi1kFIEETqxiRDcBZOaAXLOccCtOFi2nH12e
         ed0cZ6ZgvgBRbuX+pyTv4xXZogxpTOreygdtvipn9NcEOU+61RuVxdjfPiEqWkurkmjv
         F/7zuF0XxzyJOG0u0PQyUBv7wJUZa2QmFgpd71bvFUINi8zStd/3wZiY5IfOKLI0TnST
         zuuAumIlYta4/NyubbGS7dSaSiOyAvvV+wZSofB73yQd8C9Mj6iL5E69F1slRQtkCIN3
         ziFA9lsqYa51qgIVgf6iqNEpugkVT0vM8u7d5zjTUrrLL5ILgvipedvY7rlD2CKN9u/r
         yg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711525516; x=1712130316;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fuO0aVJ5zsguZWp2jlt4KOMyVYGLs3YtOGuM2wXyJQ=;
        b=U1aAC7Kt/4jlpJXu3zIFmnFtyffifAhNtYZQOPTRMqP0LlPcYP9xWibpq3YImz8ucK
         cq+2Vpx3PBggfIHZHheEDzQ0xvHXL7Cm8F+vOXAjwypd+3r3VTkXi1XUbvNqifuY645l
         4DjoWTh7IWjE+5b6y7DvxzIVO1GEo/ncTCIUex5QNvX+/gN7X6h6k8KntogGy1zWqU8I
         X7KFgXhdyzvrWTtPE072f323ju02ExH8Ss8CcBo1k00IvUzePsRfhurxC7/NxNUlOP6I
         CC/2ByHqQ54Y1QnprIQpQ71AK0s5qwMzDVGBLtIQKDePKrb4nh9/Sqf/jzz/DkBBBEZP
         HR4A==
X-Forwarded-Encrypted: i=1; AJvYcCUx/B9W/03mgKC2SgEx2tNC8sHRBaJssDFz0xFioNnx0lEE0U2y6iRgLgt2eNo1QfACzG6xWSEmZDxYozlVc7r5NCworQZ034IPGV9f
X-Gm-Message-State: AOJu0YzIHpUYNHhSYmSvijqNk6E1LggviZzN7wDlCRRM6cExZ24/L61V
	B6TWZCbQxvJu7Hiub0nEcASLppcb4AxiYisfGIFfDjGIowR2ru4JgWpVHPZJtYw=
X-Google-Smtp-Source: AGHT+IEf9mqRIAJRMhFzviKd4mfvQGxUdPTjyL+U+5kLTi87+cq9Snxf1rUTq49s0l+wrsTSugWUaA==
X-Received: by 2002:a17:906:fe44:b0:a4e:e4:7b66 with SMTP id wz4-20020a170906fe4400b00a4e00e47b66mr1440886ejb.19.1711525516651;
        Wed, 27 Mar 2024 00:45:16 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id am11-20020a170906568b00b00a474690a946sm4671745ejc.48.2024.03.27.00.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 00:45:15 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 08:43:55 +0100
Subject: [PATCH 08/19] platform/x86/eeepc: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-b4-module-owner-acpi-v1-8-725241a2d224@linaro.org>
References: <20240327-b4-module-owner-acpi-v1-0-725241a2d224@linaro.org>
In-Reply-To: <20240327-b4-module-owner-acpi-v1-0-725241a2d224@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Corentin Chary <corentin.chary@gmail.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, 
 Daniel Oliveira Nascimento <don@syst.com.br>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Matan Ziv-Av <matan@svgalib.org>, Mattia Dongili <malattia@linux.it>, 
 Azael Avalos <coproscefalo@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, Jeff Sipek <jsipek@vmware.com>, 
 Ajay Kaher <akaher@vmware.com>, Alexey Makhalov <amakhalov@vmware.com>, 
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, 
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, linux-input@vger.kernel.org, 
 netdev@vger.kernel.org, chrome-platform@lists.linux.dev, 
 platform-driver-x86@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=738;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=PW/2fVtuT04T/hFzkPAyArLp9KqHq/nQAVkBdLFHDts=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmA85R3NeP7hgTLvLTuy582cYHdnOO/ArH6qiOe
 Q/c9zsRUQ2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgPOUQAKCRDBN2bmhouD
 14knEACIdFJb+BHEHgOs09aeO+Gjp6mPKSgHliuLHdNRTp5DU/kjlgWX2ZApgzYlSkzCFyyF2VJ
 MX7jfkufvyOk4RmOVyErHMxKkzUD0ezTqI0BXK4nlE1Wv9J1qcXg9Yu4BUN1dEV+fbFXPJayzmE
 wGXaPt8FX67cIToW4yYq/dhBZ+4e8YmNzDhYoF9mAMM/u7jQbF+AQ7BEGwh+KAzoGk90tPr3Uiu
 XX23YPDfBwKSJ+in67Wt4WabrHjQUhpubtLmzmr71gAL4kOr+9OOugA/GTx53v0+lO8+bWtUHyo
 r+MDJRcb2z0dc39FpuR3/WYsObktTjcKHJE6Y5EreLKY/ZYC7oumjMsM/7fQq2ZUvTO5C9Xhmnf
 7ME3DAgyel5EPoT5C4PvIThnlqw4eMC23uQmThfg7tu4kt/ChtIk4+N4jcgUvRrmMtB0rvn1HrD
 lBkSjGgY5fENOlhR54NqfxC+KpgI8zuBbU42m9h4bwSHYbgExqOmpPmLe7wc4hKqLCjZbxVwwaH
 RXVPw6XGFdJ0XvdBLAP8CEkyLY45kWcGaHPtaon7DCHk6gJZ3VjFb5IHDfz2HGFLHkRgBRA5+Yo
 E5iApBKkt7s7lVBcJsP4MwfgaR+ZNS8aJRK4o1P6Da162e+HYeSU6vcg6a0vVHC8yyV9qkwwAjp
 QpGOmRtLGiun7dg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/platform/x86/eeepc-laptop.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index ff1b70269ccb..447364bed249 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -1463,7 +1463,6 @@ MODULE_DEVICE_TABLE(acpi, eeepc_device_ids);
 static struct acpi_driver eeepc_acpi_driver = {
 	.name = EEEPC_LAPTOP_NAME,
 	.class = EEEPC_ACPI_CLASS,
-	.owner = THIS_MODULE,
 	.ids = eeepc_device_ids,
 	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops = {

-- 
2.34.1


