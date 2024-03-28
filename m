Return-Path: <linux-kernel+bounces-123749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A86890D51
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB591F247A6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABA41487D3;
	Thu, 28 Mar 2024 22:08:01 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E74A13CC67;
	Thu, 28 Mar 2024 22:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663681; cv=none; b=QkdONg7waTh2jKJgthflPovDJfAxsZySFTAqnyE0IAyvFt6385Ac4CzyHUKjqlSjcr4xIQZdvNk6huXyIhyc1yyGhyoCectrXoFAVyZkvXn1KgAKkxSSEOiio5XdSdeUlR+4xF/4hBW+B19kDEkEPd/EVat4ugM9BbzkvWXDbZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663681; c=relaxed/simple;
	bh=fVzVNzGFi/8AlGMtN6vXpGfYvPIj2pfYAycd9VoAtS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ith5Iix88qQ9qgx0/X74ezNVESc+cECRDZ/Fix0ZrV+dHvXhpcFMMoRxe/qv2M/FkuH27nzX1rsR9d6vzvIfwCLARqQVsyo8zpW64UWEGgqYYFmSjL8yKw98g793Jv+sR/FEdwHpSiJCRt9g+lnaPbp4y+x/i7ZcLMRRGw4YIEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93989C433F1;
	Thu, 28 Mar 2024 22:07:59 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:21 +0100
Subject: [PATCH 43/52] USB: serial: symbol: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-43-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=700;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=fVzVNzGFi/8AlGMtN6vXpGfYvPIj2pfYAycd9VoAtS8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBengqO9TAzmQCjgfR0o96fBPHzjY16gT/xehy
 mdUYc4zG6mJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXp4AAKCRDBN2bmhouD
 1+43D/9zgdlVeKCCuVyW7VGnEdmYUxM6OC9Kv5see9YP7U5DmTfzq9IZf87ocIF7kZptHTwZmHr
 4Cyk7WEPk43FWy5qvZF8mrTLxzmhZWZ5FMP8APPj4qb7zW/4ZMDLshuAE8Bhlp3iPzlxvzX+KVQ
 yCrnuz9v2dNVaJEpJx+2zLSRDV7snQUvuxvzd8QBAjvW/f8tVauPk7QGN/4kQT8L6jMIAw5/Cfs
 R2Hw+pmtksWossmrR1oMrgIuZs3sbPia9qht5b772XqQHq2o7BRL9aeEI7AKTu3MXPyqqBg1Kpd
 dYK4Mn2krQUs9ggE9mYptjcyWYR/YbVe7aYco96fSjv2U3n9dsofVcKFy18YCMrVX8pfyGyWuMZ
 VHsMMdjv6kbv6QSMPq0tIJbZN8rqoZgrAPNXvMDiN1rjHlgo6QnV//rMsmdnk+LSoqjrjwaYZCG
 5kglPwgtg5jdE+1KFKg9DFJumM0ev7lvTHrMXYmmLLY6YFyvqhtrlYbrktfXWaHY5neExCbkQBY
 zlfDiQ5Pb67q6f95Z687SR2UbOEE0ZzKc/XRubm8iS5Xg34LJClN5X9Fxg5+L41Pkccu01Nof+J
 rv3cyVtrvRmtwyqJPdp6Iph1JUHITeAchFOGXAKA+H4mJhQBwNZLCHRH96n872wU9Q9/73qfY7g
 Lx0ugDcfA0YttHA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/symbolserial.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/symbolserial.c b/drivers/usb/serial/symbolserial.c
index d7f73ad6e778..52a73812afac 100644
--- a/drivers/usb/serial/symbolserial.c
+++ b/drivers/usb/serial/symbolserial.c
@@ -169,7 +169,6 @@ static void symbol_port_remove(struct usb_serial_port *port)
 
 static struct usb_serial_driver symbol_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"symbol",
 	},
 	.id_table =		id_table,

-- 
2.34.1


