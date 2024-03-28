Return-Path: <linux-kernel+bounces-123724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5E4890D19
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77748296021
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD466142659;
	Thu, 28 Mar 2024 22:07:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE1E13BAE3;
	Thu, 28 Mar 2024 22:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663633; cv=none; b=jj6vWTrIu3+5AbdvkMwlFrzt5R99ZraUltSrM+bLBQnbiuk5O60zVt4h1+BjYwj0D8/i8SuthYnM9LN/fbHurLeuZMf+Ri9vy/inEyE1sYj3kNu3G+MvMU080gsKZ0tkqVcmF/j1gIY39wzlb5mhecz+LhPDV+M8O9V6Kmhvqlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663633; c=relaxed/simple;
	bh=6D2Tzo1vEWg7Q1gpE+glrutUGUZa3SJiFRTsEETM7JQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kceRB/osYwT1Bsp4SZWG+ODHytjvDa2erTSvV/vTAGfn3c03QRbj+p5sg2CvGaPDsRjQ/ty7EOttMCD7TjrzXgKpcuz1ykaEf2NC9OGVv373JurWrlrMBnxxE/EQKxehq3f1/cs99ahdvv1jQbsLI/PPeCFfTSto0MR0hS8OFR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5C9C43390;
	Thu, 28 Mar 2024 22:07:10 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:05:57 +0100
Subject: [PATCH 19/52] USB: serial: ir-usb: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-19-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=647;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=6D2Tzo1vEWg7Q1gpE+glrutUGUZa3SJiFRTsEETM7JQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenLL7kTdfvlfwKgd4petLj8Bo9aDzm4RO4I2
 aOU2RT7a/KJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXpywAKCRDBN2bmhouD
 16OgD/4/IlsFhobWtiLQDBymL2xicQH03g5MIt+6DxA3VCK7B87bdMqt7gpX7/oXfiuFfIp4MdF
 Q1YgNOMN2M0X9rpON3n0BoK3Ic28lYOkYIfEMXDPxLJTqNFLXGwN4A0V4mESd5PXxmpWvcMYTkO
 2r8Pi3SMleTBOCvxxEl/Xvn3KqxhkEWL1fzFTNUJGr4qpqaIhPVOMZ9rXpLdBUruW4fdWkZCuIr
 koXEoll02sorFvDJ2HWOunH6e5UIf2+fsInjUEe0hkULvCnEaC+4D3z6x8G0KJNWPZt3oztIJu7
 luGXoPPQ/YNdIalwEblt6MQzlKNP1uFjyHGr3buErd0MOQUPLvpoi5Ve8zILjKbSNDgqjxfs8cG
 Vd0OkYH9E+h0g0M8Cod2O+ykvRLAydIPd3Nk/C/oah/SOpDDNBFVBeljOvO169qjRKVURVEohGT
 RzXubnfEAbyHX+b2HIZu+i3/Tw7X37hC7xJdTyfTGC1BoruVHe9qc5SwxLERMPhCkSPFgkCFcul
 DDcMl0PQpvGTA92qfxQ1Ddb6A6LGVxZjAq1dEdqWY/zW2nagw/ES8Ss8P4ht8O5yAXkpJOEbutr
 sbVRCS5fg3LtD2t+bXS1VksKESnrjP/W20CPDy2UYl05kX83Q8YT2uSAgjWkETJG375SLr5/jA/
 TH/cs8Sz4ZCAGvA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/ir-usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/ir-usb.c b/drivers/usb/serial/ir-usb.c
index 82f108134e6f..a106b71e698f 100644
--- a/drivers/usb/serial/ir-usb.c
+++ b/drivers/usb/serial/ir-usb.c
@@ -71,7 +71,6 @@ MODULE_DEVICE_TABLE(usb, ir_id_table);
 
 static struct usb_serial_driver ir_device = {
 	.driver	= {
-		.owner	= THIS_MODULE,
 		.name	= "ir-usb",
 	},
 	.description		= "IR Dongle",

-- 
2.34.1


