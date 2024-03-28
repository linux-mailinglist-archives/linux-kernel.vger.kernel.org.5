Return-Path: <linux-kernel+bounces-123509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 952288909FB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59891C2321A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9624613B2B3;
	Thu, 28 Mar 2024 19:50:36 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1917113957B;
	Thu, 28 Mar 2024 19:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655436; cv=none; b=rcFVFTVYLIj2IDAcHDYDLnHXKSJcSQnNo8uhNbwFXbOfaBVmB0BpIbnQNRGhAaumJcxhud2wLtBaOmwF2LwLt+4EeQIF/0Dcda6AOC40pJB0Ho770KTruVMjpF/F8H3V5OJ9ubVZl8wxAawPMoel8NQwXHyyrFbOrCMwZQu7CJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655436; c=relaxed/simple;
	bh=CplXi5ddRdGAmFTTmllZMxAkwaZoXheOIjXAp7bwP24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=luW3IjBVse3s1z/3GX5HwDqCrq1VdOSKU7foQ5fHnCnK7PJzvg4Mwex3hMhMZsd3ux5NcXdJN/vsgaMM6bjLiktGziK1mLt3BbZ206yLc2Kg/dqoUvoyjh8+lqXGUGb57XTvmd8NRU8Fr5dMJ5FD5Zsa6aGluauvh7/d2AeChiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975ABC433F1;
	Thu, 28 Mar 2024 19:50:26 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 20:49:15 +0100
Subject: [PATCH v2 05/19] platform: asus-laptop: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-module-owner-acpi-v2-5-1e5552c2c69f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=871;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=CplXi5ddRdGAmFTTmllZMxAkwaZoXheOIjXAp7bwP24=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBcnCmuDvA8IKhuCT0VBw+tyVZgkU/Vx1D2NIr
 oDzp6L90pyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXJwgAKCRDBN2bmhouD
 14fSD/9lQBoY4FvjQPD6qEXslCNZpQSPZBhFyLoxI9R6YKA28vCJHYvSHwAdgaDVQrvS0KQv9sq
 SE6HDCkWlFjbwLDc+uMiq25ICq9zSOvMs0Uhnnkcu6lLTb9Je+csVF9yN0wZxrJeTy3QK8A4WEo
 myTJWxgOguRsK2yVudMD4H9Eg5nUcguqkuapiz76A6lsGWjn97Wx2oK12HN+S0nA5YIxDu3AReY
 7EMileDBqzt3JOHRiLvxnuowczGcpzEISwx0waYSc8FbXv402oy788Rvsc0d4bDUjmph1v/KhK+
 l3UBPaE/rlRAFwDb0hEfiRdg4b5CCiEyigC07XmgSQr+/hDw6H9gdEbDuZ535ijkKxy5y6R/3D6
 NzhxjeQ0N8dctTsX/9WWYVNbctcOgdkhHm3rD3jPIw+WFFJB7ynrtklq06HkQhn2IX0gU3golZ1
 xp2v6LxzLpnKnpfCLeYtgUOJ8pvIP4eJy7k84oQOlAZoiqChRJfnRvJyeqyjcfJWhiwI3tfi+Wf
 iHercYl1t/Zv2RrTdcUrgLF80EyP9UPtvQtqGyjc79uDnNSpS3aMInZtmgb5MknuBTNa7GjR3Xd
 uFKv9xmd1RPyvddpYrFQExlcyMQCkKtcdduCi9wCj2OAdZnO5WSgY8QChslDXWkJfNTeVTFGieT
 ii8wfCaUfYnhfKg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Acked-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Depends on the first patch.
---
 drivers/platform/x86/asus-laptop.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index bf03ea1b1274..78c42767295a 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -1925,7 +1925,6 @@ MODULE_DEVICE_TABLE(acpi, asus_device_ids);
 static struct acpi_driver asus_acpi_driver = {
 	.name = ASUS_LAPTOP_NAME,
 	.class = ASUS_LAPTOP_CLASS,
-	.owner = THIS_MODULE,
 	.ids = asus_device_ids,
 	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops = {

-- 
2.34.1


