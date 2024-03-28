Return-Path: <linux-kernel+bounces-123729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB448890D23
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B26291EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB699143C58;
	Thu, 28 Mar 2024 22:07:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DE813BC09;
	Thu, 28 Mar 2024 22:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663643; cv=none; b=M/ELK/4hjEcQFzBR27ZK/vHseG3uHg9x4oGNYUSG2G94eEDPAGfgYBtEcYvREI+4ewAkIiZftQQ6vi+BHSONgDzTdW1IzOV7a/I4r3fpzPRgMmRx4HClahu2GPDBQZAGEhGC7yunXkm4pOzSc3e58tlSo28HPTzMxtEcW9it2Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663643; c=relaxed/simple;
	bh=bH3mJzQHi6eJ2pPg4eXL+fN80tx4duv9X5OGbAlhRac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TrBPsln8tod2DYjwotK0uwd5ciK3bRBN9skS7HdyqXwwtrrs0Pzgf2ioNvssu1o/+jx4u31NVHGKWVVuhxUk711wv++Yisl7F2mWerNNQnPv2Tgotiwd5q7PNGGBC+TKKdG6V//dWFgdGm4L8kNDwrWHVmgWHJotCBV3yTDpWKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A0DC433F1;
	Thu, 28 Mar 2024 22:07:20 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:02 +0100
Subject: [PATCH 24/52] USB: serial: kobil_sct: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-24-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=682;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=bH3mJzQHi6eJ2pPg4eXL+fN80tx4duv9X5OGbAlhRac=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenPG6jeiFt1bW2c6nkZF1/O72B7v5Se0H7bx
 Ml8wPuKonOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXpzwAKCRDBN2bmhouD
 1zaxD/9TYK/8dAh9kCX24LAz7dDQgnnuMcoTR3bPB6e8L/2ABx7POpfEKQAR36QsdbYtFMSzBOM
 rejAmgj/OQi9kdeTvTfht/v4mF8kTddwHl1Xs3ZwB24Hh0B+yJY1he1o/Xf38oNI/BXy+cIFnam
 YEpnwW90jw33hMl/j6zRs3SNsloffGX/pSP3Kg0ACeWoOf2EbB3u6lu4ZQdlQVt3dRurlL2L85J
 BGwrSvb9vSPmx5hReLTQP8GgHQ+yEtub+hkrOtBo6J1DAbN0ZJOw6kQ5JepzFlF7vl2fGnrmEdp
 3YCmsu99SVeuXrqSFbhtxmVfy7Swsk3m/hcCeVMMhM8JqpbIKVbmLRKC1gydiXN1L8YUDUvWot+
 4+VIrA8AlQQb8YpP5IpAOLOYmsoNjXGPnF0vV69WBDh2u+hgxWEv+RR4qpsKLmUnmx6JWWc/KQy
 ZlSE5DwLeCEZ8rP0aLRpvfuL1WKavnKGqXhNxFyHVEpDLqEG2LSJ7vE37d//RuFFpFpd5ebRZPP
 YVfhz/DSP1kNlcOLYe6wWcyo1+ypYAVyBLCDFIXf5CWh+mkCb6NT68/Qj/OhZuEhkI+lpLPSYin
 EkE27HeGJ83ylVA+EeY/rm8DQoWTvSOSvtzPw9dFJB88AD1IHtxeklx7aYrYXZmUSoOqFZO7vB4
 P3XnU5UpRf4QzIQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/kobil_sct.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/kobil_sct.c b/drivers/usb/serial/kobil_sct.c
index 5e775f68fcb8..5eb59ac3e564 100644
--- a/drivers/usb/serial/kobil_sct.c
+++ b/drivers/usb/serial/kobil_sct.c
@@ -77,7 +77,6 @@ MODULE_DEVICE_TABLE(usb, id_table);
 
 static struct usb_serial_driver kobil_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"kobil",
 	},
 	.description =		"KOBIL USB smart card terminal",

-- 
2.34.1


