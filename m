Return-Path: <linux-kernel+bounces-123752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62A1890D57
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0309B1C30EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9D114883D;
	Thu, 28 Mar 2024 22:08:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6B6148859;
	Thu, 28 Mar 2024 22:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663687; cv=none; b=ZwVv6s5oxZ8+RWOcdT/uqgh2exm9yhJB1tVuJikgxuRJaRMrz6/PHzBlwV0/kxDXz2hp7xR7JQGD3j+rU4mQXGuJpk4e6/8cBjOKIbzvUxtM89QPNME0qHJOxrVJ97bdzKTv5gwuC8UHmtWZ1cAm8cXTjY/R7wJ/JHQwB53uswk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663687; c=relaxed/simple;
	bh=n3zijUgkOy1RFrWHNpOAx1LckHQYBnfP4zAFe7Dyi/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TKDvWcn4cOkHAXwU8O02qeKcZYORbShmOFGmFq3qZTsVhj+k6uJNLS9QkbuwymTXD1b3xXJdSn0QgptAFr7RcpPsGfAdifnaJMtNXFdfgANmSSuA6midvz11k7rcOiaNweACKXAtYKJPGeMO2ViLvVJGv/ciRQUDd7eCBNp9KK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D871CC433F1;
	Thu, 28 Mar 2024 22:08:05 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:24 +0100
Subject: [PATCH 46/52] USB: serial: simple: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-46-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=772;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=n3zijUgkOy1RFrWHNpOAx1LckHQYBnfP4zAFe7Dyi/g=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenjISGCtzYDkaDAVmJFdgxKNzVGNydxZcQSA
 4C4qVdE6KWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXp4wAKCRDBN2bmhouD
 19XGD/9/6IE3Lg6Hn3ocoUIfgt1hXVDvWL9Gd1kUg88VlLAv+mm/TG2+bDYGeLOP6eTuzSSG2jI
 KzWNA2lctCnkNX9+2VDLo+o7KE/GRHWqxX2oantRYnbnBItvcpRiyHFQ0wsH7QebZyHm80BS/61
 zfyihBvfvW0hdRur1B3zlIFFugeRODPwvuCbjU7CCJxJo+3ReinW3w+4lWkS23YLCHrFYG6Xnbt
 CHWG/hH/MgF0h6QUMtk3cH2OmuxF3Xvc+ClriM+LDUQ9j/jj1qEBm5FLa5JFKXQdQfXR0BhyHKq
 keX/CTZGMkMIMtiUNKOcZq7uGY/hOia4Qor2t8UMUtSuRpy4xi9/g2cbNe53lfRFPBy2ofektpY
 vmCvHBxCLn+HB3LVrrej9kZxp+gkM9OBJQCw77ccQ7xfsPd4YRvrixHjmSCD31xYyIO50CCWbP4
 RiDeXjoSC7gnKZB0HV2Bu4UVPsxFx9nEXPbUAXgrHvSOJAGvNSrYcgZq+DUXKB67gxBc65NisoO
 3BdeZHHp5rFFlxu8uQzmUzM5Juk70oeQxNKWWkCSSo2jzD2AiLEdSQ1CwchcEmS+7uZdCS1NEDJ
 YAu79VfJvkMqzVWY5hyn1YV23NRtyMaDg/53gSBQaPk2TMRPMz0SJDmE5DtizxISgLFzXIkclj6
 DgXsk6nvwv+DwCQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/usb-serial-simple.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/usb-serial-simple.c
index 24b8772a345e..d733b31fe51b 100644
--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -24,7 +24,6 @@ static const struct usb_device_id vendor##_id_table[] = {	\
 };								\
 static struct usb_serial_driver vendor##_device = {		\
 	.driver = {						\
-		.owner =	THIS_MODULE,			\
 		.name =		#vendor,			\
 	},							\
 	.id_table =		vendor##_id_table,		\

-- 
2.34.1


