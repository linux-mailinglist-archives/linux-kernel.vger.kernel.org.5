Return-Path: <linux-kernel+bounces-123734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E209890D2F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00121C30117
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74857144D35;
	Thu, 28 Mar 2024 22:07:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0594213BC2C;
	Thu, 28 Mar 2024 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663654; cv=none; b=QKb10GKZ/o7guAHr1IBs4PXj2SgOwY/48MJr8IR9ZyUVYZiJKNuEcJ0CsfciMwthm5h20PkDPex9c2GnygvZaYq2cz8L57f43P7KRUAb4s48uzDKrB1TsaB098c/696t+mzAp08K+VYrmb4Pb8FMNn6FOdeRHZ6XGCKDzxdWasI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663654; c=relaxed/simple;
	bh=dhKId5uKmWwZV0wLbZRkCNNADvFZWOC144SETj8Vbds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lT5EesMIQSF/eUEjq9gFUc9sidSjAWg0Dfd787qwVShNBmyW15ezSeyB+6F9biuKwZBYZN6zOj2qG+n9xyYnDeWRwkGX2xPLoNSw5TEmVryvMnICFd+GluZlDONRszcjsroftKVyOPDmYW9WR1OLUXaNUxXHJqKiH3+BpfGZzDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F8AC43390;
	Thu, 28 Mar 2024 22:07:31 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:07 +0100
Subject: [PATCH 29/52] USB: serial: mxuport: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-29-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=678;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=dhKId5uKmWwZV0wLbZRkCNNADvFZWOC144SETj8Vbds=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenUVowQakeifdBbPFrxnGbC/9XECBIdZlX14
 K0B4xzYLqeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXp1AAKCRDBN2bmhouD
 13MaEACOV5Ga/zaIVZIZuK8gSA77Nmjbs2j80yFM6sExA5PWXCFsG7xx1Xm0+s7JToJA/dBe/kF
 Jgl0PR07cf1M4BjK5v0rsusGUWylMG/LZKt0Drd0iK5uDvIoULQJhkA/OJbLd2L3Dr78E17v8CE
 Mt5PUO/yNPnFLYThyNiLEAv5Q3Bf+F9ZTBpvWLEt8bh9UY2yR6ODJoANuAV/pTIPJnJFmRHEpim
 GjPMFPo/ZS4c8kppr1tRwjxMwzvwEG2hroyDqSFDc4Q4/hGdOi4ZMBHK9W94W+i+Dr/O71DMNpY
 523mK1I1ObC2sRtFNcXaAWXbrqytBCLZMicHMDTOXy7hwOPMOqRJLUR/94dRXFrVPhwVx85rxWv
 wxgjPYU5UxDiXEUbdt/KVDqbCyvLnqFgrwgaFXhAhKu8DThmEBkk3oWNfBvLXRripaYtNN0S2zT
 ITUUqknVk+YcRt2imxVOD3eB2anas90vMl/QEXKVwBrFL5Zvxm4zzmnxj05Jf7puQUZNIEaa1K5
 ZUwvfdDvo3CGdfeeRWWpOzzPrcH4dpu7E0Ldi1rmN/9Im9StMhIzzGjlOKUnE8uydZknzbHp956
 Z79NGq9dnShoFnZ7rG0SEGGgtOv6kK8ejo4MSyZmRpqspW7/ilYlRfyxT3EXkEHOWbvAKNhKUqR
 B6nOvUuaVq//cKg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/mxuport.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/mxuport.c b/drivers/usb/serial/mxuport.c
index 1f7bb3e4fcf2..2188e9668c41 100644
--- a/drivers/usb/serial/mxuport.c
+++ b/drivers/usb/serial/mxuport.c
@@ -1278,7 +1278,6 @@ static int mxuport_resume(struct usb_serial *serial)
 
 static struct usb_serial_driver mxuport_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"mxuport",
 	},
 	.description		= "MOXA UPort",

-- 
2.34.1


