Return-Path: <linux-kernel+bounces-123519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D80FE890A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92799292AC1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C960F13DDA9;
	Thu, 28 Mar 2024 19:52:02 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C5A13AA4E;
	Thu, 28 Mar 2024 19:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655522; cv=none; b=okbRMzgvHZwrsMFXZFY4pCZe5pseoYAYFvOYI8iHytKFyL6eJ/Cf4kOUxQrFOhT8UmFwK9OmR9THAYUf7wTg4Z5fZZsupoAlbUt/RI30FSjhKwCW0WNTTKvvMzcuyg+AWpCCslK7kMzy+5At+nojjjwXFyPUvdlC2IiLHChJmhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655522; c=relaxed/simple;
	bh=xGVJt6+/r9o89w/Ir7NAMrSCc/R/FBduUds9siGC4pM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BOD2R1hqXgR29Xd2mbhVPgOuTnBWUU+rOeh+5vQ87yC58rimZq1f0C4KpkyjltceyW0LWK8TWue7yiv5d6+bdz5aVUwlva1Emi2G/f9De/X4e3p8U6KlxYDx8CqzAZ3j1N1DdvtMsLQCv7GXEeK4NXNidJHEDHaAKVfqj3juxmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8FAC433F1;
	Thu, 28 Mar 2024 19:51:51 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 20:49:25 +0100
Subject: [PATCH v2 15/19] platform/x86/toshiba_haps: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-module-owner-acpi-v2-15-1e5552c2c69f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=811;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=xGVJt6+/r9o89w/Ir7NAMrSCc/R/FBduUds9siGC4pM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBcnLad1exuxqI2D7kiwMkCJvx2lTBCfdK/Cm8
 ZVKtMGKoA2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXJywAKCRDBN2bmhouD
 1xEJD/962FoUI4SiFXsTBY/p7Rcny9hCMRqQ7BndLrr2tIHNZLr+Trc0kEDsFmgnafqE7ST/nKR
 329oWwZXNohgeAMU3p/jXU7AOwdYmbaqvd5jebM0JrjsSKRvhbSpziNmTGXG6k/6QSawzJfeYEB
 VngtpD7vsQSS8jZA6WWsMN7xG7Kbab3dy2ltgw5+sxK+LyaQCyxLOMZiozrfi2uZzTejc6XpfaK
 MoeejQhSZ6IK0p0BqVdWzuKg+baDxSQTvvAkZmIpV1JRD1wM5GikD4za4OfOY5m3NVzsNqK7stB
 mmS87itzZKQ32TUO+eHTErjqV1Buq9VZa2TKVg3x1EPyJOH1zRTOgpu80YxvcdgGRnfO1sX8gU1
 qRiGWjV2H+8zK8X+H1unIseqmxre6jl2DmgdEicsTCr8P3LSuUkLC27hduAMzzVRag7mFqjTIaT
 728Z/ugg/QgivrdRfgHde4lMPjsAXMYMFcN4x/L726SIpEc33+aUjFwURQwwEYUk7wRK/NZNYn3
 vdM728Ot8MNYcr2YJuiia3Y+AsECYenuPlltQptgyAkbP+8LsqZPKUJEGfH06mC26+KJJ4hrBmb
 ZMXGX3tXCcsucbz5nm/YLUS7yz/oZSPVie4PNPYOZScAi72GXf+VKlS40Op3LzWdma4YvVWJdMM
 2uhztK6sngZyVGg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Acked-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/platform/x86/toshiba_haps.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/toshiba_haps.c b/drivers/platform/x86/toshiba_haps.c
index 8c9f76286b08..03dfddeee0c0 100644
--- a/drivers/platform/x86/toshiba_haps.c
+++ b/drivers/platform/x86/toshiba_haps.c
@@ -251,7 +251,6 @@ MODULE_DEVICE_TABLE(acpi, haps_device_ids);
 
 static struct acpi_driver toshiba_haps_driver = {
 	.name = "Toshiba HAPS",
-	.owner = THIS_MODULE,
 	.ids = haps_device_ids,
 	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops = {

-- 
2.34.1


