Return-Path: <linux-kernel+bounces-123517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C08C890A25
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D20A1C2CE4F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C66C13CFA7;
	Thu, 28 Mar 2024 19:51:44 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F036C1327FC;
	Thu, 28 Mar 2024 19:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655504; cv=none; b=YIjCPCdbSI7hBGaSRUolF7VYsGGL67LyovhZWzbol8Z8fSXm+EdYl4vjGD7wExzDp15WdJEi8nLyxpsutN9G5XM5TrOAF9NZGlnSPK1rD5tTS2i+NiB4d0snwvx92wr4qzMZy9g5QIgH43dGkRrChR9SCYgpA37kHkdrksSiETQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655504; c=relaxed/simple;
	bh=xvwjO1ctpRWgQ8uQfCIcwduTfHPgjwW7cbfiixA0wVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GqgtdiPy9a7NLLqfQYSTwycn0DLXEtF7pPfVpG2+Am2RZzORwkVVkg7vRT2Wqii90PM32fLxsJhV4QOUsTY1Gf41tWU4AhlcDlNmyKVgWhMxHOB5HOZQ1w5vpO2ekhTGz+XyuapSpIYFNaSf3LkO6rAeNA3/SZHEX+dZJMs1UCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298E0C433A6;
	Thu, 28 Mar 2024 19:51:34 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 20:49:23 +0100
Subject: [PATCH v2 13/19] platform/x86/toshiba_acpi: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-module-owner-acpi-v2-13-1e5552c2c69f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=821;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=xvwjO1ctpRWgQ8uQfCIcwduTfHPgjwW7cbfiixA0wVE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBcnJVUxyXi5Mws/ocE69olyJ+xaVkcKyeNGMT
 JccvU07jBqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXJyQAKCRDBN2bmhouD
 13+kD/9INzAMbfdMa5tKi+EMiEfR2+pSxEON1/iFLoiqdEqJKLxl2Qi09lUb///xM0A7vUkN7Tc
 d4dlFHZuEzFNtrBeRlxUQ8ycxr161rwcTVt2tXRfuRzHMw8aIFeGOcsC76tY6DSl4nUT8cfSKav
 mB9QuG8BmkwH9ANZvs225Xl+y0PW32ioUs1f8W+M57RTRfmb1tqPzzHfYG1BMSVW7hu3Y/79miM
 t4zAoVrz2FA64ZnJ2Fi9KTuPLy7ievqEIk7FuqFuZPbf2a42OG8yFJ5hWP54JTd3d8QereDbGvy
 SXFIuRuNqESWFUNwzMi8QEZuJKxez7FK8bgXykWlmn+P7qp3LkRt0+OM61nmMIOuDAO4KZcNzwf
 YnVm1nfq/Jm2yWFa3Nzd+OatnlLat693vsHVmO77urCFDTWMEoe5MQHqPcTPqANIg0EdYtnBQ6d
 GXXBLNrf3i4F8yvHK6xAo1jVqw4j02pjehuul0FU7Yw23pmb/lHIHmj3zt6RzAxsJN4ywhv62Jd
 mHP11YzL/Hba0UdKPdzPRgFmJHpmxKmKFCyeFR/vCqpa5EZYYqp9R4wNicj8g69Dcuy0odXx/q5
 UM7GBkSkKIHrySTuzQLesC/NK+DCnsO9IKN95cOXRcCcaRfQz6T/GygOr2CJkvU+EM1J/wkGtCy
 maYyiF/0wYu+/tQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Acked-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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


