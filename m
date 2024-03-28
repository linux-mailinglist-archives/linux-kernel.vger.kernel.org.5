Return-Path: <linux-kernel+bounces-123751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640E7890D55
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4578B23E5D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2098F148847;
	Thu, 28 Mar 2024 22:08:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C4814883D;
	Thu, 28 Mar 2024 22:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663685; cv=none; b=gE33cFY9R9RKMRI6AswpsdlYYjD58MtWZoNLWS5YLLoY/Va19M1tVx4sCaXpfuNv5Q/yxoOqhxaTb6JVMoyOXS+/P3ti9iMS+Xz2TjGsRkEVGbBY97FtI9ZMgsLS6w53b9scpI52DPXfqQ0Yj1zwusnFJ09vPNVZx8dRgAeN/QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663685; c=relaxed/simple;
	bh=mF7psN+EswNE0qvj04SULuiCK6HE8Vl10yB9Iadw9rA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ItkWlJCw9FY+AnedP8SLDSPFZSngBt8wL4AXVOjq2uUPiHaO1UQsqYE99dqKhNz7OkEKZDFp8PVF4TJvnDSAFCx5HS0ZPnGoIc9TOy/YfPBqRt0kfZgYRUBKh03notGAbo5nA4EHOkyyJYXY3wGNYnJthDgI0YBXNBMTutVXMwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10596C433F1;
	Thu, 28 Mar 2024 22:08:03 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:23 +0100
Subject: [PATCH 45/52] USB: serial: upd78f0730: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-45-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=695;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=mF7psN+EswNE0qvj04SULuiCK6HE8Vl10yB9Iadw9rA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBeniPbkVBzEDhGSTWjWtMOVWYZFcDsqgly4Gx
 qeGpTqRdbmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXp4gAKCRDBN2bmhouD
 18EyD/9XHLoum6xilFXiFBpqbP2NJgnLk1e1pOBnkleE6YpVp/WYgteNWAw+hR3WMKboYK2Pv4E
 pjrqmfXU6SKGjGTKcLZAW15+70A7QUBKl2Fsq1DsDduhU0ZrYZRZnv9jH5VWMhVKH7XEd0X66Ur
 rs0II6QMlryDGBJ+dno2/4pJRrubbBj1BHxHad7EwK0gIiK9YcD95zeNPVfFwlXldfclNAyAD5u
 qzMneJqOTxtI84afkMXAAfqXVkAMQVAKD8ixrle+AZijSRWmmAmg9nC8zAPZLK8CbhiRbebLLQu
 f7gXDjv0byurAgd0UAMBxbENrUWONskdYcxTQYmCrWJR7G8pwchPgSM7Eg5cPHx97wtYH7R1HIg
 PqCTHqb0cltZRnkf/T9g/35crmZYtfveA3nh0PcHS8IMAGSMlNjdrb2R3kn2Iolf6WVjeYDbrfh
 Rsxrid9uhPyfRxZ5v8fYU+xjDmfM3vvziHhZZDj5haUwYEFPoVS4ZONpifnj55w8Kz0NbYbD0CO
 QqzrKL0uKon8tA55Ibd2jbozRcGSwP1wf8Nxwfr4Zb6LuNi4T6IRL/cdgQQEin6pBylF7/U0dE9
 YRacdLsE7oBbtGo+BYBtO7VfU/lDSoYYXAt24v4XKZWypZGYoO8FD+Ad/PIR7hH0o6c5i4/l7bB
 wBP0BGvZ6QKSBmg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/upd78f0730.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/upd78f0730.c b/drivers/usb/serial/upd78f0730.c
index 46952182e04f..15a17bf111f1 100644
--- a/drivers/usb/serial/upd78f0730.c
+++ b/drivers/usb/serial/upd78f0730.c
@@ -407,7 +407,6 @@ static void upd78f0730_close(struct usb_serial_port *port)
 
 static struct usb_serial_driver upd78f0730_device = {
 	.driver	 = {
-		.owner	= THIS_MODULE,
 		.name	= "upd78f0730",
 	},
 	.id_table	= id_table,

-- 
2.34.1


