Return-Path: <linux-kernel+bounces-123717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E63E890D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FBDB1C2EDD2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1286F13FD99;
	Thu, 28 Mar 2024 22:06:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC0D13FD81;
	Thu, 28 Mar 2024 22:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663617; cv=none; b=eMhMNzT1rM8il8XcZ0cPJKFf62jMps7uLeieqN+PbvK2XnnLnEZ0f+4ymxSKlZVDtHcBMP0DmPa4VnoAZ6/I3Y2IJ68eaw1SpgFZprlbtl65790nB2WEmKfgwxDJMy+encZVNV6XgZdzsfAo/S5D0Vxod6dswOQvEkL0Qcmxp+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663617; c=relaxed/simple;
	bh=HguW4G8iSnE65Rlf6nO4ZIVVV3ifHGTNNgRBc5itdU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BIGMGstM4Q3V5s2OgPOBN9o1dQGfx6iG6AEX5tajQ+TkSLU8Pwkzyov2ZVTESwg3kkjGEPp8CwUhwc+c1Rn/KMDza6osCBLJegpkPjUP1leGBPyk62xcESvDdikTWdyp3joYyuL8Pk4Z1fYv/xGbAXZoh08tTupYjNhvjEQbUGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17170C43390;
	Thu, 28 Mar 2024 22:06:55 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:05:50 +0100
Subject: [PATCH 12/52] USB: serial: ftdi_sio: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-12-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=672;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=HguW4G8iSnE65Rlf6nO4ZIVVV3ifHGTNNgRBc5itdU8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenFhqjYVlVRGPC53ciE8IoMm3Nl/TDYLjslt
 ZcP99F942aJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXpxQAKCRDBN2bmhouD
 14qgD/415Cb2yLAO4jyYb5mFZj1u6QwcMA17meMJyI2t5JwVU1i/rHHuFb6QDKG6stN+kAiairT
 nzwUSXihIkT3ApqDTGwFAPOy+LkudVCfgcoRPMR1sWt4OiEFH7WC2KCqYysVyJ+5hHNBLMG+BLY
 GCzsJxLWXrukco7FmqVBp9t2tDCuF0gsbJi9Um2QjDmFgUEUeoYuvoGoeV/t6ElcGJqn0tdcjIf
 7nIbOioBwFUegMCc21EEgrnub75m/qDSzLYr3McsyyTA5rktaXPyjEoc7l76jnQR6PAovZ8Il0f
 NjSs57qpCgcmHrzBCcd49q7to3h/buusB2FluwderUwAExShG7mAQO356ktVpdC3fxhZbS8hfFc
 HC0MY+mISubY9mJJ43x9omt/HBf9G5YyRVzi/yU/BzxeqHsVgeZmJ5ktRumPp2MrRi7C81Vm49A
 TWjI3oOo2EKFXEa77a8eqXQplxGuGs8z3Byp7DzNf33EBSTYzYaUMDrG0yTLaf+8+ZTmlpB/EBH
 4jeD8bSVasF+pXoP6e2Sknq6rjNl5iqaRrpevd+mQi517VlrhWUaStrW6PJbmOGOPiWpSQ65u0A
 /XSImXAu/EQHpZZoplhDQ5LCFtIioQIlfW3M6k5hAx3BQxXpPbo2NUcxV8oz0+u8X+a1qqQKkyN
 el9onhn09hvYyPg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/ftdi_sio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 76a04ab41100..c6f17d732b95 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -2871,7 +2871,6 @@ static int ftdi_ioctl(struct tty_struct *tty,
 
 static struct usb_serial_driver ftdi_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"ftdi_sio",
 		.dev_groups =	ftdi_groups,
 	},

-- 
2.34.1


