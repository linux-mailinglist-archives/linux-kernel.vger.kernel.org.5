Return-Path: <linux-kernel+bounces-123706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB4E890CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BE05B23CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ABD13BC30;
	Thu, 28 Mar 2024 22:06:41 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527E113BC1B;
	Thu, 28 Mar 2024 22:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663601; cv=none; b=TyAw27xQTkvIszjdqeeZXFttvLOfXpgbFauuR/GPKzzAM2OpIzXk3Y9iDVZsVVbKryk36iBhPqNtPIef5WQ3zppZSF9wOasUI5es3mSrogt+DcbtJkhpUnQ1g6nuF2C4iZLBHGVZNrDdZExxz7HGRkR735FwWmYOwYdTGA2whPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663601; c=relaxed/simple;
	bh=aVs92Pn3fz//2SxqIxN7OiSE+GcvPzVCynAbnw6GSuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H4D5R2sGi40qGZvX/GaZ7dh7TFaVJb2YxfPPdfxq1OX3awnSgAltMOJ2YJuG0AQhMRz/zRO78urGddYvNceccoAqn86fnwjpVAetxO8a3jenvWUrPv8pj9SHGuvzVDnd8zfBgf2hxAeoY+sme60n3GbHH60y2S7X+CRNCa8A9QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF53C433A6;
	Thu, 28 Mar 2024 22:06:39 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:05:41 +0100
Subject: [PATCH 03/52] USB: serial: ark3116: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-3-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=670;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=aVs92Pn3fz//2SxqIxN7OiSE+GcvPzVCynAbnw6GSuQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBem9IAcEgnB12Aty1DPTcELbl/0fcdBkuKWt/
 W/vtoEyT4mJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXpvQAKCRDBN2bmhouD
 14ClD/9Xs5bTIIcJuCEH7FOuZtRz9Pzj9IJFSJoiViCYkr234fI9TZsCKyl/FuhYxEYKmMP8fMt
 1ydc/RkSCGWoOdHViJbvkSSx864xxVpof10YHdpm2Qi0xXVQjJ/brcv2tsMeCCmydrCfiH+Jw/G
 PkRz07nCH7VbQFzuM77ycBVLxW9qRR2b1j0Jgm9ohhrlolSSm3Z3mj5cnt/qPEEZz5KJZxC9lQB
 YaSInfGBVaRBc1D+iVsAthsuLkL4eBaDXEe1JvAbX/e6d8FEl7koTd54SQbrh7+BdtR2923ZHJ2
 kKza0mCzwRUnVCpaaBJjA8Ppp+dGyx+Ed2gAFJyUbjBfE2bSgTZQsIg+UC4C+ZkllauRF32HQsU
 86bGLo0h5d36pehH+GwY2ZBK1NlSU09ga4FtFz58bB9xxGQvM9W9Uem8UQG+bmiJ9o4YzPbD+z3
 nScRMYSofHDC+X77re/7/EFr7YmYsFgehOJYWNgSTJcfYTm5rwhRuQh2na3REA9R+ROd0Jhy4CF
 Th8pQj5Jtzwk3wqkUm6L6lOpAz38nN6mTlgH4iodnviNWTxvVdLcfEIMM5fShD6QEpqUaoCsGgj
 nH5Ln30wmPYHzmbBY40tG/2uTyuibcmdUtlZpfKZZLsd5tyCh5Z87rgo2QTo4yd3brtNDgs1NUh
 xcfcX0HdOzqpSsw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/ark3116.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/ark3116.c b/drivers/usb/serial/ark3116.c
index 67a07cc007f0..800b04fe37fa 100644
--- a/drivers/usb/serial/ark3116.c
+++ b/drivers/usb/serial/ark3116.c
@@ -599,7 +599,6 @@ static void ark3116_process_read_urb(struct urb *urb)
 
 static struct usb_serial_driver ark3116_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"ark3116",
 	},
 	.id_table =		id_table,

-- 
2.34.1


