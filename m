Return-Path: <linux-kernel+bounces-123755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA367890D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1301C30F63
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CFD149C55;
	Thu, 28 Mar 2024 22:08:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B86E149C46;
	Thu, 28 Mar 2024 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663693; cv=none; b=aSy+sPAZA9DdHpHm5wTUlMxhssxGg2tiQZphIjjYiV1i0QiXYzc+XPLLFJy4cE9Ov0x9xginENNWAXKVSpxB1LUBGVCaQG8bEhSLRb3228SRbDb+wRcv9SQHsw8u4TubTsGRISIxUBsE4YuFASWcJmE0n6ZX2qYzgzOpcrg/NDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663693; c=relaxed/simple;
	bh=q48hSjcgCVk3GMV1sSMZLNfkOyG0fmboF3YaOfhGgUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gp1entdMHTEpSMH2ffYQQPv00BYjK0QrbpKOHpJGdX6IcWgC3H+M4g2HDpPSSZ8IDDZlNqk74Es5TxhIL0WPz5fClvUYr/AxbqiQGlTtMLUEN/0ikgy/fMiUbex9y1dDJCdWFR99gjVS3rXESPSigs7VBDjVNY4Sd/Yp/WgOqa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C3BC433F1;
	Thu, 28 Mar 2024 22:08:11 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:27 +0100
Subject: [PATCH 49/52] USB: serial: whiteheat: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-49-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1012;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=q48hSjcgCVk3GMV1sSMZLNfkOyG0fmboF3YaOfhGgUM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenlXqrQCwBqlkKd8A12xHE5HaQcXRQwC0egX
 c4s+VxQR/CJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXp5QAKCRDBN2bmhouD
 10YGD/0TFb8d+56rj2w81e9TjiecVpF8DKP5swGq5P5EKU2Rz4BYqenGHwyJrX13jGduynD9nfe
 8N2121RX+Ij4uDmv04pnhAyMz8BkKXsY87ZOuXYjSHa2lFG67k19sghfbrx3ETBjN3ewHi97XSW
 lJQ3AvFo5bU7LjyNxFzZNbDNqrkjC+X50QV5fQtxhPUrGxBixR9v5QvMGpFO0Ku+eXZvqfr1Nuh
 hWgL6TbCIJXbpsU9lhgr/00qKJHzk36bAD121z0OcqKMCBqxSCuU7lolMKZcyn7au0YSrPtue6p
 m83YAsW1lm3RJlHlUVJV/qqVfz5UmU5OMAdkJnorx2F3fd3Lrjlo0NJrmGqSPNlKev4UJev7ViC
 brPFSUhqh/qMlx6Yx8OB6TV64VoJwDfwOUcMBJjq0W4OiL7Qw9pVinugBsPdkHnuZOVYghO0LB3
 cUGLSDnHxIJi6Xc+RD7Odcj6XiJDrl6ERIjkAAGqkkiRsdmWiMOgunudAcPbpdmPrPZPgxLCxUv
 MBB4YjMHKMjuJuPbTqs/JYTkJ1UjkDTANweVySdA3ykQEFMldruge48r3vyZzdx0i9QfmLgyayR
 kweubFmSbVQwF9rjoElwFeCh2PrMasgr2x5akIAehOlxnEZCTX9cG0jfDcMzmCs+2iKUKOq9KLj
 12vo2AkGG6LiW0Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/whiteheat.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/serial/whiteheat.c b/drivers/usb/serial/whiteheat.c
index ca48e90a8e81..009faeb2ef55 100644
--- a/drivers/usb/serial/whiteheat.c
+++ b/drivers/usb/serial/whiteheat.c
@@ -91,7 +91,6 @@ static int whiteheat_break_ctl(struct tty_struct *tty, int break_state);
 
 static struct usb_serial_driver whiteheat_fake_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"whiteheatnofirm",
 	},
 	.description =		"Connect Tech - WhiteHEAT - (prerenumeration)",
@@ -103,7 +102,6 @@ static struct usb_serial_driver whiteheat_fake_device = {
 
 static struct usb_serial_driver whiteheat_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"whiteheat",
 	},
 	.description =		"Connect Tech - WhiteHEAT",

-- 
2.34.1


