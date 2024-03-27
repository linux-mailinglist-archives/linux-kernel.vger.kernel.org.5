Return-Path: <linux-kernel+bounces-120458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A4688D7D3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758EF1C25B6E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D447A52F85;
	Wed, 27 Mar 2024 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JlL7TfST"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C116524A7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525536; cv=none; b=fdg1cSpIsn6WREqasJk8B0PMGir720renT2TFntFAPyiSWKWlUd4k6rwCkATHiCsd859OrMPGvv75HDVWFDVyqoS05W2HSrDcbd8oUO7BqeLbUKL9XbIQ9kYHRdketTCsjrsukxnkuYgRRjfCMLH3fkgiYVcpJsxKRjOfQYnXLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525536; c=relaxed/simple;
	bh=x5aBOi8571kgH/70+hqSUTH/KgH7MbeR57HwVOqbl9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LrC/FFqDBt2Jj2xn0pfx3WiRJhe1iwT8Bv1msyvpKSrAeOgmlMKkA2vd4xFGJVhDxCWPNnllf0IHl3ivYW0cxp+smEMWLCi2EoZ4NL9hdDEHC/fx49hfInoEB3wkDVoMammaK8PZsP+idM4CLteDuVdd9EB7bD/DHB3IQGkZbsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JlL7TfST; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513ccc70a6dso11051680e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 00:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711525532; x=1712130332; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUVarvI29GYf8qbvusCvjKrNApOji+ZWbF/VfN3ERLQ=;
        b=JlL7TfSTI7IzJF7wlaMV36/JAZagPWDX0zxD7r6koBVDMZBiDo3Z+ATDX5UVdbM4s0
         pThU5kwgU4NwXlMQfFFutc8AfMZQyZx8MqAgpZ6sRofxgcISJUnOqa4HteB5DT5FYelR
         501hymjzrkxcREr3m2g++cmqj5FeQV6uzFWNkxPn+V8oqpDMtlxPjbCeLlyWQZQ5r3JY
         Zm8EQ3Md+W5Cih43ny//onibDHBsi1JE5FWTe8R4ktQpldf59XCLhoJqrh1RMXT2ojNI
         wqvy/iEG3nTLRMx7CdsyCi4NXsRnQMZNTezodw2O/LeRytY86AO8spRicxTzRQBdJS4o
         nDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711525532; x=1712130332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bUVarvI29GYf8qbvusCvjKrNApOji+ZWbF/VfN3ERLQ=;
        b=bxVBK5kKGtVIRsdr2kusLehUgJ0tp9bSTm2kSB3DBNu1UK/tk4dwgCcSjBJECPODuB
         0V9b+QhKSdWUhanqh8vTue/tdpQfaqPwlE3HlYDp2gEYYPgsh3zqRhqo5XBEUg4dcETQ
         KXXSbp2TvYsdDbfVFUVvOjbUybrkwQLhR51FtTx+Dk0IB+jxJ1FhVmSStmmumiCBrhzf
         nZjmF6mB3LAEb4VQobB3eRLebwt4Gv9gpeLdskvYQC9XWzv6y90dona+OJbn0VevBcp2
         3Rj3LSdlDh7oUhPFgt9Nd0YpxK2GPq0DqlOFmOQYczhp1hQ4URnu/0dpoRR0P8omm9LW
         LiXg==
X-Forwarded-Encrypted: i=1; AJvYcCWiKB4nz5fCt6cUEP761nw4i85yF88LGcJhg8XDKwrZdB+i+XunFoy85F90i3r4iZF7sb5SyjfQm1XVuhJaOGyb2RduHIBrWaape8x4
X-Gm-Message-State: AOJu0YzpiwbObXn7OYg7dhcV7tC6c17m0vecMTHALE/myIFb0o42KTRY
	I67XdVeV8pb5P2keiUgJtRcx2ifP4XZvpiBS+psazXofoTgd5z23S+lsJinozqQ=
X-Google-Smtp-Source: AGHT+IH43p45oeCz29sanitb4HfB/d5qNm5GGwH5K1q6QtQ2IhsVB/nu/NZBEW4M+613n7w7MV8gog==
X-Received: by 2002:a05:6512:3d1:b0:515:a9d5:aab6 with SMTP id w17-20020a05651203d100b00515a9d5aab6mr1344695lfp.18.1711525532566;
        Wed, 27 Mar 2024 00:45:32 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id am11-20020a170906568b00b00a474690a946sm4671745ejc.48.2024.03.27.00.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 00:45:32 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 08:44:00 +0100
Subject: [PATCH 13/19] platform/x86/toshiba_acpi: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-b4-module-owner-acpi-v1-13-725241a2d224@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=716;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=x5aBOi8571kgH/70+hqSUTH/KgH7MbeR57HwVOqbl9w=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmA85WYaPnCni2SJTIfYMu6nl8u8HCpyEBx/zm+
 akXWB+YnymJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgPOVgAKCRDBN2bmhouD
 1zwaEACAjYbKdJXrMSUbxc4nKtGoFPWrLCKVqSibV0vxi34qgJolGqwGNMlDf1EbR7zNuWkRWf1
 SAkSo/ZjSy9ljMZTB+PVf/rBCZhEjLGaVJcUcu4lvaHpjYqA3flInybJXH/dnis6s7GQJEjwCbI
 Urg4xT3YL+pEwOQEaxZ+RR784CtgfPRcRZJ/y2hZHbLqGolVcrygiCisFvxmNBfyX2IgW8qzVtw
 ZC9sexJanCjRdDdeSqqoW8HfiFLv3kL6o5lvq01gJQ+Ch0QEcyMkKF69nwS+99sLA+gczGBSIdO
 HA/LUt7UtZGA5BqNtXGRxvIHU3JcNctMDbgUNU51zZTuMLPOR5zAy+pZPbScboBEobH8u3buYyI
 0MazJJzSYkzF1E9pEayUzam31VNJzF9LDQdXf71xL7c5hQvhEOgLrdYtd+NHHcT8QJ6KyGkXlJq
 S8ohVQ33OfFfZmCqNmFeUuE6sgFOi3yXk3mCrwgakKm0j9xool6qTEqAYFK35jBiH1RZjMS2/3b
 20vZcrPTTv/1steGsyfHnqoRnmquIwWJU7cpmZtp7sfrP9VtakfLAk/Skb4bey9hgdxJa0dQ2Nd
 /jAUhNyL/u5mTZ8NAZuDN7KrPv8hyTPaqwNDWOE/y2HXvWNm321FRUqeoMm/Zu3myuyaUrVfESB
 n7esZW5XGAls0CA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/platform/x86/toshiba_acpi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 291f14ef6702..6f9bd675f044 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -3581,7 +3581,6 @@ static SIMPLE_DEV_PM_OPS(toshiba_acpi_pm,
 
 static struct acpi_driver toshiba_acpi_driver = {
 	.name	= "Toshiba ACPI driver",
-	.owner	= THIS_MODULE,
 	.ids	= toshiba_device_ids,
 	.flags	= ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops	= {

-- 
2.34.1


