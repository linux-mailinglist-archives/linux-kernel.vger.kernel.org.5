Return-Path: <linux-kernel+bounces-123737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18CC890D35
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3D21C2F975
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69068143898;
	Thu, 28 Mar 2024 22:07:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA201145B18;
	Thu, 28 Mar 2024 22:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663660; cv=none; b=vD4gXc7I6eWCSrVSqIRpLokzdg2xxIGPErNxO6bL3tRxWOAj/UEu4wXxnfSHVaacnu6+DhP8aI1ivnvX9+YDkYCi4NrUOJiQv26oig3NlVpEeZerMd5eBSd0abr/Hkdgyw+QEbZfYsFEQcwvN9jZuYoJepfdFonHd6eBmM3dhUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663660; c=relaxed/simple;
	bh=LRctIqyTEwThUZvMjgFYFi++ZZSrS7HQe7DXt+mTpok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EoaPfxF7iEWF2yazRNOPghyCeysyszy5gp8zUU35XwjznRe+nT1hRqjdABrk+7E1VPNtyUtC5K38NAOxGLPNpXL/klLcKO+eUMfNNxZdcrmGQbiZQB36LQqOy0VipGQk0rcnHA0cn8OP7Z4eA9FhnivVnOIHWd8gA+Yo5lsqfA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8574AC43394;
	Thu, 28 Mar 2024 22:07:38 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:10 +0100
Subject: [PATCH 32/52] USB: serial: opticon: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-32-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=678;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=LRctIqyTEwThUZvMjgFYFi++ZZSrS7HQe7DXt+mTpok=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenWXp5/Ai8WVgpIFIBVBg1aldnsv3WDqQitD
 jxQrxlgEPGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXp1gAKCRDBN2bmhouD
 10EnEACXys7h6QJLTa65XVerAgW5/0DAsfvBCsFn+ZpPRPExQrFmEoCopnMsKVvqY51MFQlTvHK
 ljafxKdwwcg7RY4V0yua6T+xcXPpuVCYI9Nj3Lmpvm8adhuUpavMYr9ETp28E/RPlSrrnaur7o/
 n0Y9vxk53KH0hxWG24S3DIP8VMGDLXjrV9Jk+hkquxHk94nAevH9tzG39X8dLPPFjmHUR4j8005
 1Xrz9TG+6lH2TW833CFUGhbpG3wWN6KStE8EN/JXJ7mT1ij1eiFrgrjiuQXT5g2t6LQNJOGYsOs
 z7H68wau9EWKTx0XwJ2xrTiLrT/WrKHaqkejAOE2yiKloVhMQdaG2T7k8bOvsd8QS8UT6MHKqXR
 8wWkKpV9QOWfo7XM1GSDbzO89nyA9FUcCoqC5/Tnzi5XKXmyAmB7IuEGNroXCKeSMz6efNRsEls
 TUbgSWfqXlc2SXqQ1oESwoXZE+Lw5+zdYdfzft1CMEAw9gZ1wrdUzKtBmv34MZwKEMk9akLcXoD
 JAHcSmifRxKiPCX7Q3CGOg54aUP1oT/zF5weKvpK0aWPAGKdKPl8iMxtTDc5QNeh+kC9yK7g/is
 fwztziaIlcC7WTlxA/oWgI+59bZU0de10/VtQSOJ8WPP3kFGp7obvd6mGewt20nseF34W95L1yJ
 4soLUIH238HtN2g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/opticon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/opticon.c b/drivers/usb/serial/opticon.c
index e31a6d77da3a..1ee84ccc4bbd 100644
--- a/drivers/usb/serial/opticon.c
+++ b/drivers/usb/serial/opticon.c
@@ -375,7 +375,6 @@ static void opticon_port_remove(struct usb_serial_port *port)
 
 static struct usb_serial_driver opticon_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"opticon",
 	},
 	.id_table =		id_table,

-- 
2.34.1


