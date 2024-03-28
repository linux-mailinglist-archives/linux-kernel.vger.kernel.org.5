Return-Path: <linux-kernel+bounces-123518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E475890A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD73E29294C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2962D13D60C;
	Thu, 28 Mar 2024 19:51:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A024A1384A6;
	Thu, 28 Mar 2024 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655511; cv=none; b=LJQSzPNmwKFExp1Fn372CjG065YSUI5IWwSGb6fscxQBkDedpPLAfyc5n4ILYv3L0Agm/MFON5VIgkaKMvmnmN7x8r+pHd+OGRhNhDPNNTffYz7sdhDAhK8AYf1ISAID+wac+/ntv7hwV2baJO/vG6F0AEHLO7mVNEQ/AO5S8lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655511; c=relaxed/simple;
	bh=xaDWPbF3frEm1uj4xeWNfQgH8jWx3tNApRXczJ9I94s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G35Xdp1/Sel6+KkyBeI97zEMaMmIgFbHsw+p/IVO+RoexZB9xcgm5GU148NTYUILXsVonwutwpytx026+SsmCNUzE73LPowsweXa2kK1yYnBkYH9RGK7KO7Jns556/ZS7q49+72tpxgsZduZB5rIHOy3bKE2teP8/FjG7Jp45GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF318C433B2;
	Thu, 28 Mar 2024 19:51:43 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 20:49:24 +0100
Subject: [PATCH v2 14/19] platform/x86/toshiba_bluetooth: drop owner
 assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-module-owner-acpi-v2-14-1e5552c2c69f@linaro.org>
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
 bh=xaDWPbF3frEm1uj4xeWNfQgH8jWx3tNApRXczJ9I94s=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBcnK7Vo+PbCSX5qCpKPIYeIzy8wo5XJl6wCj5
 toe79KnvZCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXJygAKCRDBN2bmhouD
 1w4TD/9QqkzQGZlRE+LOaL8Zr57uL9X38ieV9q3eJKgYyeuPMIxsMGyeGtXLzLz0GmbdMJPdvzu
 7g3bZFPdbO+ac0Vn0tAMnhF3HdJEfHX8W/ecH/CkMSIhfoaE6/++8bv1nFenekF9T9wntUTnLwK
 jPevIqhU5qhnnPRvXb3oTB4+WXVkx/wIPUQrae75/me8AJQ9R3M5msMSwAQJnH4p1UuY4puY7yO
 4X5oRHvHOJbxBgpT0LLmUOMS4z3u7Cujg0bXBDkxtlXGCMog6LHQuCA85F5jyBgsjCURO9OxLzO
 PoUdNrILTBme668nUQ6Pk1b0DN4yIcRo29tHQZEtSqgdnIaQb3ID1HSNtuo3X8Ion1tZ9x8v5YN
 TdKqBVc2wYdabpbSySU5Sm/azgZfhBiNwaW/QyWps4L/9xoavO8sIWMnoIO+FRY+uibsdUE2gay
 KvFeHX72fYPwK0TgFQXWAiG+E2Vx5gFVgyd1GuMWgWMiF/5P/DgNEbpPvg6Yj0ESk6UXSC8PZ2R
 IpRUh3SI/isLSKGpWKgKHSS6qd+a0rZ6/CsXtetVKEaqfm+LhE5FWN06ocK42vh+nVX6x1kAbjn
 K0XTUslzPPeItoCzkWr2Ii2FxEJE4xPpZrvlvLqG7mTQhyktwiy/zhKSL1ZGI3DOfAemAeimPd1
 Tj5rtgVEPPDumwg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Acked-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/platform/x86/toshiba_bluetooth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/toshiba_bluetooth.c b/drivers/platform/x86/toshiba_bluetooth.c
index d8f81962a240..dad2c3e55904 100644
--- a/drivers/platform/x86/toshiba_bluetooth.c
+++ b/drivers/platform/x86/toshiba_bluetooth.c
@@ -59,7 +59,6 @@ static struct acpi_driver toshiba_bt_rfkill_driver = {
 				.remove =	toshiba_bt_rfkill_remove,
 				.notify =	toshiba_bt_rfkill_notify,
 			},
-	.owner = 	THIS_MODULE,
 	.drv.pm =	&toshiba_bt_pm,
 };
 

-- 
2.34.1


