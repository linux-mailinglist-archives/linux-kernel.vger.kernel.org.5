Return-Path: <linux-kernel+bounces-123730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6812E890D25
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947A71C2D9F2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D4813BC09;
	Thu, 28 Mar 2024 22:07:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE47143C6B;
	Thu, 28 Mar 2024 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663644; cv=none; b=Tere+/uXUuv2gIXN+8Pm4EoMyHNTDjz3MAMRwkVLsjT+5Fx2Lv6dlXIjEtr625TZooHYKjuRvgqe1BFJ6U2cduh9pjXi0WMGDSJlVGDQKVqAcKzj4Z+jUhk4PEIdRBFdqLHVfJ1Fn7O/tiXfrfd+RJUHjQbU2SImYcDKgjwPAdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663644; c=relaxed/simple;
	bh=exKzDOUySrxB6eqVneVDXfER1zJIVlsAChaAVBCcwlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HwSO/kvXfaQGotyIRbSwntiAy3gkNJBKRCdGSIBcEmvLqYCrF3rfw/cOb2z6lGe3WdWAeJV2G2LyD3bXqwTj2RH5g0jb8V49YVqItCOPPqFA37233eCkgLCAPc8YglYgyLIEPcd326AEx76XkkQbW7Jdz8xclLICsEg+Q6FVQJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A30C433F1;
	Thu, 28 Mar 2024 22:07:23 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:03 +0100
Subject: [PATCH 25/52] USB: serial: mct_u232: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-25-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=666;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=exKzDOUySrxB6eqVneVDXfER1zJIVlsAChaAVBCcwlM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenQw9s57DHZ5J9WIYlbyQgCNGUSNcmfI4L2P
 XFFR6ODLs6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXp0AAKCRDBN2bmhouD
 1+ZfD/9IBbJKjl81rJrmNTiEM1B6dtXkfdpedvlJTUGycDyNcVy7SieApNNeA4xFt2Je8jMESLJ
 HELVMXFn7lQhzS98kiuM1mlaYVLJ29UuIrvTVgnPEkoc/KOW3oDCv0CWilbdqlAqgNXnCzfAflS
 d84AeLt5KKTWAa6lW5vyzFLvepIvyxrZTafNySKvM3Cl2I8JjaVE9a1T5DmUiD9HJgchRgEf7KK
 SIbfoTf9vueekGyvqxKPXp3vrkvvPX7BouuLXzHqBYN+L7yMBv1gossogKvz09FKA9mqNH9X3t8
 oYOmdd2T9t9MMzMGea3iN9Wara0RKK1CoAELl+dmc/4Wg3XIXOTr/E7AgMYNfYa245wHLGO41qU
 YImYDa2bwx5UOI5j6S1ss2VJ8ZyiiHBELC8oh+fGCoSsMvZdGNrhdMTb9jNG0wVKckccI1GZcoq
 EsHHy3ZJM6r8s0cEBx0qDhHNioJAEFquqocmvxWdeMhfkqGtzSGjR14ENIgabbONroRWqcpyOXG
 WN6G/keRVos/w856qh8IoqByO6eqhjBa8wYib0/bWkjp1KBHx59j9DRvV1w0LLOWuko2Ut2JsDu
 cktrtq49AJLBql0DE9+ay9Gtd1iL9+KnSAgGOyK7+YwmTUul7bS8SUL0CPP40bwInaKzsclbErW
 VUhjLLbcFSbRNyw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/mct_u232.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/mct_u232.c b/drivers/usb/serial/mct_u232.c
index 6570c8817a80..e5a139ed5d90 100644
--- a/drivers/usb/serial/mct_u232.c
+++ b/drivers/usb/serial/mct_u232.c
@@ -69,7 +69,6 @@ MODULE_DEVICE_TABLE(usb, id_table);
 
 static struct usb_serial_driver mct_u232_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"mct_u232",
 	},
 	.description =	     "MCT U232",

-- 
2.34.1


