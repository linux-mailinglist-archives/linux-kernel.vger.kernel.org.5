Return-Path: <linux-kernel+bounces-123508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C75F48909E6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30ECD2A2825
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE35D13AD3F;
	Thu, 28 Mar 2024 19:50:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D287D074;
	Thu, 28 Mar 2024 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655427; cv=none; b=teix9+zMbSvBJHstoUG1/hw9i23QGz6RSjYfFdLUKe3ffrsa+422ZRe/fN9mDKHU2UrgCt5EfpBM2QRKyEeM7rVW3CJ77M3OvgvAM1ciynPlQggKPO5+L2M5PwQ8F/1nuM5l8B3h2w9bcvmEqyCLabrZpNjmGNOPDn4SgieTEys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655427; c=relaxed/simple;
	bh=/NV9RwZj2kQUDNzPiFSFiACsXVlCd0SjuRkQZxhr5AQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EETnVDLWu4gCMbR+YZdia2XxxpjIawlS0kErIOYINGmbAX2ifspDpASfQKb0mxR2gg6zvtWCLiNGYvT3il2sMgVUbnbGoSTmgr5IPfQUUnFmPoLcswJ8BaSwv951EW+0UPNaxqLJUlrjN9IJecyKs8Sir0+BXdFFLeLHp1vcGgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBF6C43399;
	Thu, 28 Mar 2024 19:50:16 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 20:49:14 +0100
Subject: [PATCH v2 04/19] platform/chrome: wilco_ec: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-module-owner-acpi-v2-4-1e5552c2c69f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=834;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=/NV9RwZj2kQUDNzPiFSFiACsXVlCd0SjuRkQZxhr5AQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBcnBH1Z1m9oJl12YabWZbbf1tCq3Tw6YlAdIX
 eYRlb4mBLGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXJwQAKCRDBN2bmhouD
 1/O/D/9XEe7R8IhSrQJGhJcev+mGl/s0mztRh3JJNQmYbIetiBPaWWZDPzxXBTMpHnJW6j/j1aK
 w/+hY9nBrpswWJE1xfZt7OO8uKpsq1X6TtyRoEWOlQTnIZMPrA/Ou4r05ekJB+S1/19DFD7mQAE
 Cn6cL1B2OuOybF0Oq0Bq+SgrBVAHhmB+5L1C9oc0l1AOO/CCquqPISnzLbrh2WyT0USeU+msvbZ
 Ep/4f0o88n0I/uo1+ae4K2L1KaO/cT5e1YpX3FTnM/y0CuAxfN2JWSDYeZdMSiwpSxpPeffrt5T
 UqAIbqg5bFgeTM+iJvRwj4+d9ov3koTkY5zSQPYWJk6XH1mHFoaPW2RZnQvzsv0bw07gXaIrHfa
 5cdXEq4QjbUXPfucbIgQkq+YQXunVav9O44Hmj2yiBD1Tch7LmIT0v+HOb1td1NdLwR2xpyk1L6
 djR2mss+ShIIcDjPXUfTtKDMQ3eLG4H7vBda4/G3SAsCA5YsTN8DvwbJWgMQeBqRix7n6djjjz2
 HbVUfIaOKG8YNwnmipcWqH/DUQGR3nsjAW61Q07ZdByZFH+pgyRpx7nrPYNI0Y1yIuRL12SlDoj
 VoVe6lJGLgWZTlxkZbi5nJApHY75iXt03potqV8OqpKURS2rFEUo5hcAde/26vIJhrn1mxb705K
 onHmENN6xvPycwg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Depends on the first patch.
---
 drivers/platform/chrome/wilco_ec/event.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
index 13291fb4214e..ae34e81c5d18 100644
--- a/drivers/platform/chrome/wilco_ec/event.c
+++ b/drivers/platform/chrome/wilco_ec/event.c
@@ -523,7 +523,6 @@ static struct acpi_driver event_driver = {
 		.notify = event_device_notify,
 		.remove = event_device_remove,
 	},
-	.owner = THIS_MODULE,
 };
 
 static int __init event_module_init(void)

-- 
2.34.1


