Return-Path: <linux-kernel+bounces-123512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0166890A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59EC128756B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D813B13B7BE;
	Thu, 28 Mar 2024 19:51:00 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E4813A267;
	Thu, 28 Mar 2024 19:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655460; cv=none; b=hqMnOg2lSB2Qd4kx11CjTt6dWXBe8DVb/hEpQW3FNAJuafafH7bJVzmzPtMVz0ur2KAifyKnDD3CPP1t/BGB3FU4sMVn4dr2esm/SJLVBX+nmX+hshqhWiJ4FTnYX9CaqMKZffO0D6gkkRaD0bt1SRkYosT7vTdRUECUcWZBoq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655460; c=relaxed/simple;
	bh=3DBlcw5Uc+lUgavKBCn/PyGF+yjz7VdivcFuSZC/Ml4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BlI585987Uph2+/PdVph8nEEHATS5XitpPlo3wFDtvn92F6jJxbq+vYvkST6p33mWL65b0IdTLUl/Me5IYJVmN1Dgljkbzd1pW7ZPORW8JqufizgFbA3BDPfCA3yPrJzFgkp/nkp5iMZkKyeaRcuXGx3XDyYtHfBD3SKJ2LaL+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5298C43390;
	Thu, 28 Mar 2024 19:50:52 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 20:49:18 +0100
Subject: [PATCH v2 08/19] platform/x86/eeepc: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-module-owner-acpi-v2-8-1e5552c2c69f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=843;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=3DBlcw5Uc+lUgavKBCn/PyGF+yjz7VdivcFuSZC/Ml4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBcnF4TCFoCX2OG7IvrYWNINl4P1WQDwKPPeBq
 MCuTEmFg0WJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXJxQAKCRDBN2bmhouD
 1/iUD/9E0L2SN23OQ0KbFtk6ov6hSt6CoxrR2cl7lu0il6sEsl4VU18vauvLcqEerNMeDDUeL4M
 VHWN/flV2KjayvwcXZCjFlUuoqdojOSzVqFuZ538oClVbb9PIeBIAmY4+3Nxwn+GvlhaMB2FThg
 uVZ63qp0nTLQ4Iindi9uD9tosomBofDNk2gnA4TWKchN+d8MgWPSMgjS3cQ5uvHqMCIfRF21JVv
 IYwpvhdJZEpqw8cGfOE5br/1gASHOE9X7V0a9S4Y3ts0Fp4c73AkPSbBoAzdWf35i7IAQ1fEhxB
 IuRwq8srR2S3LgpibWI5r5sroWLLArg79acbVT9smUg75FDqqJdERtQTQOXA8OeT3CX5RkOQhag
 riYrk8FC6HUMPCwrWdLDL/X1LN5Ofb7pa4J2bFGzr6R8KgoyXSSA/YT6iJ7SYz9MjoyR9+kIYBb
 0xk1Wkq3Lgt7PJgsa3aB4kK2BGC37Ja7wo47osObCQ0lsVJmfSytUEgonLyqRKU1DiXs6Y0iKlD
 8IA3L0CaRYnXpr62YhoXZkMCmDcBWomX5QApQQmTzGq8lcrPkcv3L5zqb1g8OXL/rMfLfixex1k
 SJi4+dkageqwbK5fACVD/9OGUDfzGn+Ed591/gQ9iz2kQ9h79zVQKrUyV9b4qnuY32PXS1wLRIO
 r3StYfNSCnAOLMw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Acked-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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


