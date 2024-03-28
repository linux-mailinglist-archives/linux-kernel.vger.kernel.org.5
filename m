Return-Path: <linux-kernel+bounces-123728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2E7890D21
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C9E2964F9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2E114388C;
	Thu, 28 Mar 2024 22:07:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F219013BC02;
	Thu, 28 Mar 2024 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663641; cv=none; b=q45fMJQA0kmfinQdDI+TrveDjfaaq31x73bUnonYRKpIAgy7t/H+sbNLg9svAg33t2Lo9CoyBzZn6a1CPw2zldhLPl3268KhQG5H4icwvAo4lilKESfSsOcL/zpoL7FyAaP1JElbJqRVF8j1+cAxHZtIFqzmrkd0nCGWR9ml5zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663641; c=relaxed/simple;
	bh=Iy2/nIEYmqgfbMhHUyDOjap6nlukPpnP1yviXS1LU6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hNoF0mVn2TV5r0J/HGuRyv9byAuG4xXK3SZSn1tIEvQS0HnJ7t1yhfcsMWuqrv7p04j0Axvf6dDtHQPEE1zKw80ZVMsFU9JY9mUO0h69UBnwSv01ZQtMsDscJ15LQfXsJqzzIm2CJw0sxFCbDKsCrAfF6yLEQB1PAI4IPtQ/aq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B83BC433C7;
	Thu, 28 Mar 2024 22:07:19 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:01 +0100
Subject: [PATCH 23/52] USB: serial: kl5kusb105: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-23-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=695;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Iy2/nIEYmqgfbMhHUyDOjap6nlukPpnP1yviXS1LU6k=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenPWh89LXXSzXdLMXjF/2EzDUFGcKncT1ydj
 d7qbnjYMGWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXpzwAKCRDBN2bmhouD
 18EKD/9HFtn85jpXcTAYgEXI5YU0OIPP+5ibrUvSHmC0AdkwmhbpI7j4KPBGB5xy0ZFvPaJLPL5
 99TUn0v7EdaQp2HgCyOypiDNc3mepAmmQBdAOQbD/7DCWBYhnGBBH5JG10TviycTe1tGL49adtI
 CWcB21tGICq9w536Z9VcZCyjf74LWm5Xgkdpv+Vx3nbmJnTae8PhDIcqYAvrOa2093Ppp/wSDs1
 T5f6bjbhM6dWit69BagVysDThayZJUc0GZKdTS2G751WXYVbQR+isqRZKUKYxIDV/MZrhS3+vuN
 CLq/pL6J48FlftbpeosMP3YjKEc3ystDA2trOtdyhTgV1FkEuCNH+1RGXAM0JVelVPXBhawZL6R
 eKf6tHlAuQxvHJgQGLY2PGWJC6yw6o63jNTsy9FFZP57PIUTp7or7AOU9Ob4lfF1d4Bh8GmSeo6
 LwAYhvreq2gU8LzT6x2jOC33sku4eYYCNIePsh5KztqIl3dXCLJcjX9TsIC1t7ocIeckecGx3/c
 ErCOmjww5+/CV+WNW65O//zdzjlD9r/11qixbgZMLBGi0CiRt1B8xCfCrMOKonyOFoDdlIXYsuJ
 iVvajvai8Ozfw2JsW+o7tZxIwdjOIKF3NZezhfqhILCONGQq9PGwuoccSI/TD/1Ac6WB4PpFN2R
 EXf1sd/Gyq1qsuw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/kl5kusb105.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/kl5kusb105.c b/drivers/usb/serial/kl5kusb105.c
index 394b3189e003..a2c0bebc041f 100644
--- a/drivers/usb/serial/kl5kusb105.c
+++ b/drivers/usb/serial/kl5kusb105.c
@@ -75,7 +75,6 @@ MODULE_DEVICE_TABLE(usb, id_table);
 
 static struct usb_serial_driver kl5kusb105d_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"kl5kusb105d",
 	},
 	.description =		"KL5KUSB105D / PalmConnect",

-- 
2.34.1


