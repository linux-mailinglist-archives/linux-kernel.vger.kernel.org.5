Return-Path: <linux-kernel+bounces-123742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EB0890D3F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DDC9298BDF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04A6146A93;
	Thu, 28 Mar 2024 22:07:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3435E1465AA;
	Thu, 28 Mar 2024 22:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663670; cv=none; b=d2QgF1bTNW4eFj/eL8AiqX2N+FoNq7JfjhHCdvFbeskt4izr9bUiKrDVJrNwm0eCpXgkYaJoFGjVs2fB4BxREk9U9mh0QXZ6RoRXFMGYuCMLzkwMUIc9/7EVPIRHPyzkDBuBwct/pFzvcSUU7g1qnXvyjKnabp+oehRXB0SJVIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663670; c=relaxed/simple;
	bh=ue3GNO2h0HqEC0SdkrGG1DtUtk/JahT/0ntolEG1bW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FpJbqMuUBf3EtsKhLpsKb4RQNJK2j2Jrt5rSi4ysSzc3+skddkCdaMGgOvP6z9cfJek1WxlorP14eMoQLSsigcgvgVr24/kMl3rLN7TdpYjdzLVuFICGxsqKppaWO98yZkEAwgMJi7e6zF3w2tz/cnzleWGzfSHtzd3evLGvAh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3EAC43390;
	Thu, 28 Mar 2024 22:07:48 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:15 +0100
Subject: [PATCH 37/52] USB: serial: qcserial: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-37-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=696;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ue3GNO2h0HqEC0SdkrGG1DtUtk/JahT/0ntolEG1bW8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenbQkzxqSsztrG/GohMYl9ZG6j1XOI6qOuaU
 aOcYrk7ibWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXp2wAKCRDBN2bmhouD
 1yqVD/97OE94Q2vZ1JqwPz3Nj4JTNz6llw6C6RZiHInTkZUZm+YQK0GXlV/B6GGzqHIKiye+Pvy
 jo8O+RR+ejOsTVd52k3EnxShDu0h+vG7ZW1DDJFvvF8lZtxqzCxgAZDaTbFW0Dy5eXGRh9tZi+R
 4D3+D8+/4Sw40AyuhaXnfi1OxKGPNKNn3++6E/JAUXPge5w0hutPhNAh2Ix/ZlPmxB1v7IgpTUj
 5MjlWGiYbc+9RS5RIjyNR7MX4CZ8GhUhpoknZql5+Mtn2N15oMba7iOImbRL1ByyfGYDDxiclg5
 inM5mMFFcBwYcgfrBh/CUgLcGy8Rq7mbotdwVBzWrf/UVYuaGRl9t7WL+Mhwse6TbgsfWWrIUjt
 2ez2H14/hqX3Ewn4VJTk+uXi8hV7HoL03vOOHJos1Z0IvQ1QXzjO0kjzV9e0AALHWy4QodBOo9b
 TL2ob9ZEcTu7Ne3cG7URdMK/U6vZGDsydZFKHYVXTRn6NMKHNuWSygMbTcSiTTh/PYrTY/26RUu
 ONuJfYaz04jawpyUGJMaeD+kMM/YA09Wo3fmB7JmWwQobmer2JkMnOIIEok032vTUOLrRGDvhRO
 R61t6Zk3IidZOUwc2zr953pSaKON0o5BdvVuBGHMP6IacXCrOwOgWfOTdMzMfK76yNrB7I6hxTf
 pAmBC26/IcCMhcw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/qcserial.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index 703a9c563557..c7de9585feb2 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -454,7 +454,6 @@ static void qc_release(struct usb_serial *serial)
 
 static struct usb_serial_driver qcdevice = {
 	.driver = {
-		.owner     = THIS_MODULE,
 		.name      = "qcserial",
 	},
 	.description         = "Qualcomm USB modem",

-- 
2.34.1


