Return-Path: <linux-kernel+bounces-123516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84853890A20
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B58E91C2CA8F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7093013CC5C;
	Thu, 28 Mar 2024 19:51:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3BB1386D3;
	Thu, 28 Mar 2024 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655495; cv=none; b=ZVDHHSpnR3yxM9XmgoddVveCa9Gltx8U5IfA0MfgDDdDBgRP8tBy2sqQ/WJmMbIMoa2tFJyM2PXNq2+tba/fOnH8tonbMrTKvOTIQERPDOObUdfkI30HYZ7iT4VGUdieVk5h/dyZy2Dqfj58jECNcRa/oqp5V0g3LOOPxTeHjI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655495; c=relaxed/simple;
	bh=/fri/mbQzXv0DCaHIG5MYdobhipeSpfUI4L+XzGK7Yw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i/hGwMDIOx7dYvMHbnB+DdFybLfdA9az2grfAVmoxvrBIY9xxl6Ft4qx/iW1Yf6F35oVzjs4lKmJj9JyRcYy5xDclSu4CRd1yhM1ElVTNfug2lQvVW7D9lrXHjc9rJCwMWaO3sratm08w1yXzLs4YA78JphJdYz/CUGP64AHAWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376B1C433B1;
	Thu, 28 Mar 2024 19:51:26 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 20:49:22 +0100
Subject: [PATCH v2 12/19] platform/x86/sony-laptop: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-module-owner-acpi-v2-12-1e5552c2c69f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=/fri/mbQzXv0DCaHIG5MYdobhipeSpfUI4L+XzGK7Yw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBcnI+0P0nKPcDaw4xeIiValSm9HqzcE1SQ+rq
 AfAS2R9muiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXJyAAKCRDBN2bmhouD
 19fND/9VLlKtGjkucaO+i/FbQaPCBWDWn7z+YQBVAcDfniIehG6Xln3PvEYdhGRO96DaFnsfmEt
 Qimauwz6KvLLHNZPPLHbfd1l2zX2WUAVnCLzyDLUIVqgQzj5ARXgtr99Ep9n1KiICopK8fcmfoB
 /fIKMp5dPijIAm1Kdq8EZk7Aqgln0XKrB0j7ukBIWIai0wG/OIMO032JihbbRBfTVmzDOxRGqqV
 G0a7+Moo/BwMbsvhLarnpDOYWmrh6ZCne87N1nJg223Z4XoCL38raUnIwSY/F5kwDNbtr+qU3q8
 VM1sNfubREQYsuTzFDVdlrG5/RenSNM7j7pIxjTp4ht5WdWwbkYDa41H3+THJ2YFYMQ3kaAyWm+
 /nUjgFXbY0LeqCCEhsFEvx/3+Rf6lRK8NELHdoPXwC+PpvGhIH21tpaglOVe2iQmibtTOzzhf2l
 2qpiwF0b0zacpE5mBNK3eSwZnmBHFBsIbCoAGhMgwaocurU5/BcYOBMaEdOkWd5XgbFZfbr+22x
 +Nb0JOw2mkiLGZUUXAjEZaVt1xtOHib5QurGZzoDfoNelNuyIYE3+f8dfCHeP8gW9QI/LOwsJ3M
 F01CEERdyhlZHw8zyegjKNktYgSWvEK7KN8Svt1x9/htjR3lB3RegdXZWIywkmrHY+a7p6JkNzH
 8t1z5UR6fKas1Ow==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Acked-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/platform/x86/sony-laptop.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 40878e327afd..3e94fdd1ea52 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -3303,7 +3303,6 @@ static struct acpi_driver sony_nc_driver = {
 	.name = SONY_NC_DRIVER_NAME,
 	.class = SONY_NC_CLASS,
 	.ids = sony_nc_device_ids,
-	.owner = THIS_MODULE,
 	.ops = {
 		.add = sony_nc_add,
 		.remove = sony_nc_remove,
@@ -4844,7 +4843,6 @@ static struct acpi_driver sony_pic_driver = {
 	.name = SONY_PIC_DRIVER_NAME,
 	.class = SONY_PIC_CLASS,
 	.ids = sony_pic_device_ids,
-	.owner = THIS_MODULE,
 	.ops = {
 		.add = sony_pic_add,
 		.remove = sony_pic_remove,

-- 
2.34.1


