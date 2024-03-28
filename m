Return-Path: <linux-kernel+bounces-123718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117AE890D0C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11E928E2D1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDE7140E22;
	Thu, 28 Mar 2024 22:07:00 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3ED13B7AA;
	Thu, 28 Mar 2024 22:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663620; cv=none; b=gpT8Qms/4Jmzx8At34qbfy7tVS6ed3pK6SfEa1mj4ckwzvA0U6cm/GdAgG11X3xQzdNuPnRs92Yzcss/pBz+a/HlnBSn1IA4mhxeJdkxg8MoZtn5ocBUsfeeoKZYgcgC01vT/9IvjWeJopUdEhOIMGp8MsezcknKLwKW7rvvIdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663620; c=relaxed/simple;
	bh=P1p4NxpNqAGzrvewOBn4+y+vjnDBjJiJTGyS4fUdk+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eTDSGA+en0wBH/gaefjEzhzkSbwNtTctW6Vxnt4cXpyIShLdp17tLB9p6T3Z34sJrbGzt57DgPK/IqZxUVO9TgOOsPKjjhpvsFGU8jCT3HchPpbWTfCsm8Asvvn/Tof2moqJ2FGV5Zd4K5NJT3KNDoDWPfBQfm/iLJnAWipQLKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BE2C43394;
	Thu, 28 Mar 2024 22:06:58 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:05:51 +0100
Subject: [PATCH 13/52] USB: serial: garmin_gps: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-13-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=765;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=P1p4NxpNqAGzrvewOBn4+y+vjnDBjJiJTGyS4fUdk+s=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenGvvOwPSi4YvHIsa8cTT32irS7BO2l2f2SW
 DzxRHOi1OSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXpxgAKCRDBN2bmhouD
 15MKD/9uhwfZYDuyQZ+fAZVEmMtBIY9Y5XhCeyyMGhKyrSRAo8/GXow2wvLkttY3ikYXqkfORrQ
 uEys0ZcAqKYaFq17ijBJWixaZ83yyZHwC8bJjJ7Ky4Z6ZDov9Csjb0L6XfGBYhM+zHPV2WCpp/n
 TO0d1eTyxBsNbS7H7B3pALxHnPIovaZKOBDk4lTezeTzO9NKg/mXNJDG2kV6IBFDUD7SWCbP9wk
 4KzMNdmLzcG2X0H8IysPoQE4P4/bjafKUNQETvGjS99wpYk4Gca1o3nGs+lqUkHh3IRRa69/efu
 y2BazEhE1JobX9kdMSw8VhmdRr8cQpTLQL/fmBYXSA5+/ViwvKVpoxfi+D7hAJHvqv9+vTgK7WQ
 Jzoy5XfbBtuolBdCw9nGVcYvVhIcF0fAGN/sbdFzdqYtiER7WhlzOvZnboJAT32mCaQpprrUPCx
 veD9AUeiD/kPavJA/OeoUMcoInTnjzlKJSWWTkKfI+uEvo79Dc4Py4vgEEZV/x9ajp/oP+7KUrF
 4JExLE2JADSpLw/8G1tQ+6oKwwwu2W+YzWf9yulCHdClsNmGM668TNrPQRk39DbdUKaibLlw7I1
 ifsgvFKgew84PVUjYHymgVR9Z6YddhQ3uhaIaNWNBFz7FYHOx9pxdaSApmvl2vbwNr1q7pn6Uul
 e/hSgcuJ2ArojJw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/garmin_gps.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/garmin_gps.c b/drivers/usb/serial/garmin_gps.c
index 670e942fdaaa..5e1244d87cf7 100644
--- a/drivers/usb/serial/garmin_gps.c
+++ b/drivers/usb/serial/garmin_gps.c
@@ -1413,7 +1413,6 @@ static void garmin_port_remove(struct usb_serial_port *port)
 /* All of the device info needed */
 static struct usb_serial_driver garmin_device = {
 	.driver = {
-		.owner       = THIS_MODULE,
 		.name        = "garmin_gps",
 	},
 	.description         = "Garmin GPS usb/tty",

-- 
2.34.1


