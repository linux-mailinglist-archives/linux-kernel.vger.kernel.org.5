Return-Path: <linux-kernel+bounces-123756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1247A890D5F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFCEB29C443
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2F6149C7E;
	Thu, 28 Mar 2024 22:08:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5103B149C6E;
	Thu, 28 Mar 2024 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663695; cv=none; b=IOTFnkKoYYU9jR/00k+qcaDGrozzT1HF3wbmghIThKWyD9rlUVqx7neCMnWAshQWTxXRCf7fyIswY9MI8dp9gKt36J/oDsvFQIm91OV8Tk8A2QH3SmNCdhIYghnRCQKXI7yVj0rLYWk+WBYOPPw76rsZDdzyBrj2w5+7+uYW6/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663695; c=relaxed/simple;
	bh=Ntu7n1xOjCq/mVBXr3t57SyMIZ0n5JxdlqFdu5/5rF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P7QkmYunN3GqRDCIVGoT9sgsX3BoA2Xh9cCE+2Tu0FAp+mUDVVfL2qoGudvTL3Z2FvTV2KwzKJ5atkrRGS7q5eDEd+FqQC9KeepOl4lkNmcxRqz82xCfm/Ejx+VqPTLCvBLfqzzPHBSDD7v9f833PZO4GWNPFW/3kg4je1PWGDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A00C43399;
	Thu, 28 Mar 2024 22:08:13 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:28 +0100
Subject: [PATCH 50/52] USB: serial: wishbone: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-50-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=734;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Ntu7n1xOjCq/mVBXr3t57SyMIZ0n5JxdlqFdu5/5rF8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenmb+xIndqymh2LBhPq8PPmr/B9D/XXfhst5
 Y8zlTy6qSGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXp5gAKCRDBN2bmhouD
 1yAvD/9oB23i5bRDGVDSqQObiWapMvRyPHwl/0v2zUnDhYSw/xA5z09OTa/8DUaH1CYICTPboGy
 JFqazy4sx3juZqrrsJbtb3taJqnOHKWEB2pPUVO/n5sbJJ3azYq/K1p1vrfwqdJ4R/88bnMBznD
 F/diOW/Dphd5+GjWAdmtQnOwOWoUm6mt3OIq4XtD6d/YvoxBzONtS3xN67YgraoAsr9ARP5uhKu
 6PN0ddNPFy3fwLRibfXZ+Qnp/4PSyV1KDDqrM4LhEYqk+Wv3VAs0w8Y/dBlx0obNi/St/qwzQs0
 Dfpy91D1KFOnO7R670p/TY68qWT2akYdDkqO2BiQWqduCJdtlPEpREbsDLCOkq8AyMXhZmEdoUH
 PDw3fD20ATVp9bHLG7QztEbl8NZCKZRbZP3MS9gnai3CuQKn8wSwD05hoEmbXbZyqshj59mQJr2
 0PjYSgPTrlB6CbHeiTLs4nSgFcZLHrMQaliNBBDcluPJ0LdhyLwYkGIMu6IIaBYuJo77tHxCmYJ
 nYLpIiXArjlfCNJkp3DB6g3iuoNGBTuSN1F0dMNRJkVMDYGYdKxX+gnhmf68f1DdyNeUEOod8F4
 PjijreC/y9Aw3tyWYk8U4Y1SOit5CvGB3d2m0qOV7QwkVzqK7O3Gm1gANLLG9PdVI1doCA8z+Cb
 NmtTE9ZfIOSWIqA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/wishbone-serial.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/wishbone-serial.c b/drivers/usb/serial/wishbone-serial.c
index ff4092f9b33c..670d573f6b63 100644
--- a/drivers/usb/serial/wishbone-serial.c
+++ b/drivers/usb/serial/wishbone-serial.c
@@ -70,7 +70,6 @@ static void wishbone_serial_close(struct usb_serial_port *port)
 
 static struct usb_serial_driver wishbone_serial_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"wishbone_serial",
 	},
 	.id_table =		id_table,

-- 
2.34.1


