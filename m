Return-Path: <linux-kernel+bounces-123750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE13890D53
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C28B2B23C18
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD114148829;
	Thu, 28 Mar 2024 22:08:03 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721F613B29F;
	Thu, 28 Mar 2024 22:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663683; cv=none; b=iVHyvNwpDY3BODDtXrPqchRtfKm6ni4UeccqSIjc+b4qyFMUjiJ90q3O9tWU1PkOxZSzodi3noq2ZlwuOreeYFG9EFSKHNJK3Hg/Hl1nc/Mm2tmfLx3PUQ1AARScIFNs+w3QL/RF3geJWAOhDKacjYC7aOO8Yxk/O5aH7LVrxkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663683; c=relaxed/simple;
	bh=Z5DlnbUr8G+qcFQBgBzjcHM9HuIpnWv9wjU/Zhwm4zY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iZQvxfb/CtnCX9GZNn4hwWp9AK9j1ryJDVVUhYhzuQWIeAywNrOzZons93I4llZ3q891iDX7xub2g0NPi3Cqn8FOgW/TX/21NhX7GuyUfGIiEzScXRxYXSI1FqJLFN5KKNaSqsH4UQ3epUE2MriUxHA+8svz6NnXVUd4fw9X0Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76BFC43390;
	Thu, 28 Mar 2024 22:08:01 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:22 +0100
Subject: [PATCH 44/52] USB: serial: ti_usb_3410_5052: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-44-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Z5DlnbUr8G+qcFQBgBzjcHM9HuIpnWv9wjU/Zhwm4zY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenhm6sUOW608c8pQ+qYpyS+UFE41uzt0vA6r
 b8WrlgX1ZCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXp4QAKCRDBN2bmhouD
 1yhND/97zJ5jCi2Nx9vg1BKkssn1OVHz/78HKURATVDVsaIMBoyqFy1aXE8LUckOFyKmrihcczl
 43EkJiW1HWfJjU0pwTr2YjmChOOoKQKwC9Vo19Lm9bd7hRfkOLsmRcZl2rvL/grCrCM77wmQbsU
 hSf4pWo6meIwWTF9H8wX842CveOvv1+Oy33lWPpUp9jp7yEFcQLLsNFT8OxAxXjbKYa/n2Yn6ts
 poBVF57uuXGvvazLuZruRd025QOKkGeqvr2lTgW8ks50KejywbYT/q4g8WZD024J/o6fpSfVEsB
 2NDB/fj25nKLNZqjamYoKY8g0J84zcALSVkcJL0JXGSPjYxA5bPtgorPprnDcKFj3XR6awD14eG
 UB+5rfN8zqO685CqUIKksKuMGNBnawr/CiRFK10V/RqAuohjfP0i6a7yu1c5JtRwJssniIDprha
 6mK8sIDhaumjiahQTTKprSdKQfvGDpPoS+txdQspkGPlnbruYQpsnJfeP7ZDNGZpD9gKVBz9j5a
 hn1ppDFR9TcfOXcZM/MJB2qT2CSHe/nWCMKF4OFv5vff7DCP0G9IuohyY3tRwvoQiiZiVdeoKoS
 NOiAWcKHdhw8KHfWA5Cu2YGXO0jcUx10T0SpSgYaDNi5hHBaljM/6yxwhv4wVV+Qj1HF5UcHlpx
 SQLAHD4Rs4BpCZA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/ti_usb_3410_5052.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_usb_3410_5052.c
index 0fba25abf671..a0c244bc77c0 100644
--- a/drivers/usb/serial/ti_usb_3410_5052.c
+++ b/drivers/usb/serial/ti_usb_3410_5052.c
@@ -417,7 +417,6 @@ static const struct usb_device_id ti_id_table_combined[] = {
 
 static struct usb_serial_driver ti_1port_device = {
 	.driver = {
-		.owner		= THIS_MODULE,
 		.name		= "ti_usb_3410_5052_1",
 	},
 	.description		= "TI USB 3410 1 port adapter",
@@ -450,7 +449,6 @@ static struct usb_serial_driver ti_1port_device = {
 
 static struct usb_serial_driver ti_2port_device = {
 	.driver = {
-		.owner		= THIS_MODULE,
 		.name		= "ti_usb_3410_5052_2",
 	},
 	.description		= "TI USB 5052 2 port adapter",

-- 
2.34.1


