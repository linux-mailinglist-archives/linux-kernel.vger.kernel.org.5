Return-Path: <linux-kernel+bounces-123520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8993890A34
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C13293854
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE3213E02A;
	Thu, 28 Mar 2024 19:52:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B676213699F;
	Thu, 28 Mar 2024 19:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655530; cv=none; b=fhXSq+WSXdz7DtpGmy47f1Y0cQ/c6eMPOe7oibUk7c94BHSt9PLa1bbKtpDsmmUiCjzIFFTMfY/I2xnAace7FTnZ+lhr/7X6UL74l6G+gvTYxc5TJ/gL+DaZq/rm377KKfsB6VMKgHnyEdZu/XScpTPiSWTcXlWqam6hyJ+ctSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655530; c=relaxed/simple;
	bh=9J7YSUOv2ZQVmETXiMXLHTxbVV+WzglKLXMRl654O48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a+2Poec3bLN6lJpJNY18wYuEDWtoh9U8HD+ikArnocBEDXmZJ9JADQ7oRydIXLfB2s6v9qUXEUj/J959oD1vW00YP5sUEmAWqLlKPn0u1spG/nT/hBpa+m15DD99yOGUQuPL1pf9I+61lXtqQDigSSZ/hJinXlVSw9d0IRzVYq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B80C433C7;
	Thu, 28 Mar 2024 19:52:02 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 20:49:26 +0100
Subject: [PATCH v2 16/19] platform/x86/wireless-hotkey: drop owner
 assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-module-owner-acpi-v2-16-1e5552c2c69f@linaro.org>
References: <20240328-b4-module-owner-acpi-v2-0-1e5552c2c69f@linaro.org>
In-Reply-To: <20240328-b4-module-owner-acpi-v2-0-1e5552c2c69f@linaro.org>
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
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Matan Ziv-Av <matan@svgalib.org>, Mattia Dongili <malattia@linux.it>, 
 Azael Avalos <coproscefalo@gmail.com>, Ajay Kaher <akaher@vmware.com>, 
 Alexey Makhalov <amakhalov@vmware.com>, 
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, 
 Richard Cochran <richardcochran@gmail.com>, Theodore Ts'o <tytso@mit.edu>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, linux-input@vger.kernel.org, 
 netdev@vger.kernel.org, chrome-platform@lists.linux.dev, 
 platform-driver-x86@vger.kernel.org, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=792;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=9J7YSUOv2ZQVmETXiMXLHTxbVV+WzglKLXMRl654O48=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBcnMXnuyx29d5rYRAoJY98Lg+JpIibGaHEYe4
 iAf5wFXhCGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXJzAAKCRDBN2bmhouD
 1+8lEACBTzY3YaXGddrJo9OA/wZDaxmZ9nG+vH4DTkj5bAAVuFUuNjy55z4WolK/Qy1p8FG7GVd
 v6M181Fr/aoNp6PzRAUk+99BRUTlt7oZocxQW9905HJnq9qeinoaIgJzoY/rpkk0k/50sxA+MAa
 S0qrMAVvpO8w8GjGJWQrhGjeSR2de+YMq1bC6y6llZTPT6Twp8TRwUTSiO8FttE+lvSLTuAw0Tc
 1dEZkLh5U0kW83xh7C6ev6eBsPLhVbXJ6K3HiCU+NGT7nMfBvpb8ICpHeNgAGQVL6aS/geTEX5I
 Rx9irwahAkQfN4UO7UE4SHuoGM2eZ2ofTQ4tD5JdsaZnplzkzo6eeOr38pg15wyJ2FkgN/PsIfg
 p0Ne7uyR3zfVJat5oI56YZLvMmG4eReiSSo7sNj/NqEEbT6Mqxxiz6JC9q34qGI34mX1H9WVLMv
 kc9rpsjKcc8QC4vy8wydAm7ebKrPqkR7bjjHgfr4i5HnxUXOumC42UQ/PseQAv17er4LorMpuo+
 EgILkcnuou3YHq8XTnb3CCYGA5S3gAPW3TMjC3sWq0Gd0llxYcB1OI/aH/BXVrnrWzMSMvKIyG1
 u7vukoql29QBDWkgg58W7WJxHyrEWrDhHTu59NITe/iRwzUcjjJIfX5NjKy6ztn6mSJHwCPICcA
 ZMhqK4FyusFecSA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Acked-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/platform/x86/wireless-hotkey.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/wireless-hotkey.c b/drivers/platform/x86/wireless-hotkey.c
index 4422863f47bb..e95cdbbfb708 100644
--- a/drivers/platform/x86/wireless-hotkey.c
+++ b/drivers/platform/x86/wireless-hotkey.c
@@ -110,7 +110,6 @@ static void wl_remove(struct acpi_device *device)
 
 static struct acpi_driver wl_driver = {
 	.name	= "wireless-hotkey",
-	.owner	= THIS_MODULE,
 	.ids	= wl_ids,
 	.ops	= {
 		.add	= wl_add,

-- 
2.34.1


