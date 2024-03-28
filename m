Return-Path: <linux-kernel+bounces-123743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC370890D41
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B7A1F21875
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98E9146D53;
	Thu, 28 Mar 2024 22:07:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D56E13C9D4;
	Thu, 28 Mar 2024 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663672; cv=none; b=EciTRTvgbT4tKJbEW97aPrQIkEAOfpduStKVGAncaxwaS+1fJ7ccJW5vgzoBUkiNei9y3L6nl9jS2KkjSbh9o2MFIWcF3pek//XTxFfPDqZ4z5jwE5vt48c/t9i7rRzEXJ25KCrv9mUuOS1dQehCf0ABYKLuiT6Iu9FQNq9TRpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663672; c=relaxed/simple;
	bh=XcQOZGaL0Yd+aEed1NQNuf3VIPxc2hnk3DbX7QY0i0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qoZca5+faSzmf6vmJAfAK8z+sWyqIsV6UKMRgMR5HhIxHSmah2Usa0Esa6PsBDGuCG/wQ/0S7Dlgpo61+COHQGoH1vjGrDCfCmXS6ijp5/zfoZXdtn/1iJAbkP/PA10RwpMB8R0IDRwiXu49LiVaANbhYmE+tN60RNjxPLwOC9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FB4C43394;
	Thu, 28 Mar 2024 22:07:50 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:16 +0100
Subject: [PATCH 38/52] USB: serial: quatech2: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-38-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=678;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=XcQOZGaL0Yd+aEed1NQNuf3VIPxc2hnk3DbX7QY0i0E=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBencfYh42do3AVOKVststvoAZotFMBJxot8bL
 nsNChLHO5qJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXp3AAKCRDBN2bmhouD
 14ymEACAAkTB7g3h7OhJshUcW768KDSMPuQQpG9vClH7soNLSZSapMAhqhGIxFLqjr9I4FP34tw
 jljYaUDu3j24Zccj/Es6r/aavOvXsnSnqIwRmnsVMKm0Vxq/xPrJ95kO8C0gmEEE23lkBtdrzPD
 VeD/ZCuHkBfKbiuEwsmGEdj+ENggDkXEakeJ0rfogaMW+sqTxGRDsGH3Ub+1OGXnAZdjpbmZA6k
 +ow4KcBORpZ6x+7rH7vkuaMk/697JCsn9K67Im0TNwhdLUki0gu6+ME4Z5NkyqlxxqSM5AIAcOZ
 0SCMHuyrp93BDxW1Ia2mhKPoSNU3d71J4bbRhdiP7UP95flyXaEmneLsokQqmYd65IykszGIzg8
 zQp4IVug7xr5klqn24g9C2huiteIKGtZiQxp5rHn+MlmX2+x52vPQ+f6Ux5s5MGhnVIHfjqT1Gg
 CYfOL/OZGbuopHgtThGEzPOYlwx8MyQEnAZuvyzAxSN0blPi67vBk9NkAewO19JUilo3wkHtrrG
 c5U/giYLyWA3Np21goPYvW8jcKXAVaEjtkVCkHFYUyThEcscu3lrWuBmTShiWMhPnC4LB2GH3w2
 CckJCSA7uffzZtURIXmB/ApZpceo+kHnTeJXbHQo+xC1lEca11tumX7ZNlKHEhOysD0aMpJnXNS
 CdORpqKdwumIxgQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/quatech2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/quatech2.c b/drivers/usb/serial/quatech2.c
index 821f25e52ec2..4167a45d1be3 100644
--- a/drivers/usb/serial/quatech2.c
+++ b/drivers/usb/serial/quatech2.c
@@ -924,7 +924,6 @@ static int qt2_write(struct tty_struct *tty,
 
 static struct usb_serial_driver qt2_device = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "quatech-serial",
 	},
 	.description	     = DRIVER_DESC,

-- 
2.34.1


