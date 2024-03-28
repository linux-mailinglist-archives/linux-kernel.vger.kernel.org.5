Return-Path: <linux-kernel+bounces-123713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF33C890D02
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CA4C1C2E227
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A891D13E6D3;
	Thu, 28 Mar 2024 22:06:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C6D13E6C0;
	Thu, 28 Mar 2024 22:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663612; cv=none; b=gTkdWsxao8rVdf5Z3u05C6ZMO1QynHwzCNILvkELXzXGKNvY3RoHi+f49zY5s26MfMs9by37dqmmyrvkgZfenp8WIlLPrYxLn+j2mcwIzh4fqkxduqL3iD/MZ8kpBf65iCkgdtMDO25DbOj/p9LrKhygEgF2fysc/kxMKoFo+mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663612; c=relaxed/simple;
	bh=3XIAy3qHNIx/EqDRPAs8SQMBW/EjnKKYlWaVgP+Qdjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LS1GdovS5/27Ex7bYDw9exJUo1cgvnTEBBJkId8hFvw3uVdMG6MhmGGh6Zh1Pm+gVQubRvhgD+f4Z0ln/JJzT/ulfL9j4vE9akBIdLlXaavMWoeDgR/aSRKhDhToZhl5OhRrhOb+NwodNddkWn34T8CBO9gUGmmQgI3x8sJ6FXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B91C433C7;
	Thu, 28 Mar 2024 22:06:50 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:05:47 +0100
Subject: [PATCH 09/52] USB: serial: digi_acceleport: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-9-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=3XIAy3qHNIx/EqDRPAs8SQMBW/EjnKKYlWaVgP+Qdjs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenCG7HaWG9XJw9AtHvtaFYlczAacewJqaoeb
 b4fNQy+lMOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXpwgAKCRDBN2bmhouD
 1+eHD/9j096adE1weczvi83KFWPs9F1b3iJmc0sWvUzGGhNM4z/6GvhxNNZspvW4PO/NR81Qv3A
 rE7oSCM7g/dZ80SE8RAe90alT+dk3UFpn81PXpXBVjyfCPECkFwAFZZAeeCh0QTOcynigv/jxvb
 Z8aiAmCdO0c+RVFmjM/7Vm9keNFJ5YaENs928L/vhjTkAgUfbT6I5Q19Id7p7UviCB68ZFdXvFi
 K8YYPQGVXIBq1gaI8G0ZJpNA+MCyBrfFG6Afy4DU2TIXY4cNtWsgOiRnoptPXluom9QTmA6iPle
 5Mu4/0RarkJx/4Zd8z1lYSacGgr4V7//Mo6+s5AiDiAAuwTIQkN6qbBrp+VaXXSHEB4x7QxpSBN
 bx6gBFZvXElWt4O7/2k65CgQS9yyXiEP6RIkhXHH14b1jRs/j+E94D8ZjJtAlgwBhjPinSyeyjk
 qAO2Rcn6d2gBDLf6YhV/3KDezO9AxFo74v020IDAxhmyz5sI51FOu1l0s+NfUweEz8tq84c/kBH
 S3hDN10xf4MQ/Rg/aXhLpBLmMj44BpHAnj+KHptYccZuYuwSgvemJlD+GSo9hV3hESAWAmjG5Un
 MvBaeDTCX0zH7VgRvf1rN6DJvPfJ66sbPVLN2orl++IsiElOJFoE06LdFO/BPUheN5xKEfZdCxO
 u6AZUKAbLa5SC5g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/digi_acceleport.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index d1dea3850576..a06485965412 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -262,7 +262,6 @@ MODULE_DEVICE_TABLE(usb, id_table_combined);
 
 static struct usb_serial_driver digi_acceleport_2_device = {
 	.driver = {
-		.owner =		THIS_MODULE,
 		.name =			"digi_2",
 	},
 	.description =			"Digi 2 port USB adapter",
@@ -293,7 +292,6 @@ static struct usb_serial_driver digi_acceleport_2_device = {
 
 static struct usb_serial_driver digi_acceleport_4_device = {
 	.driver = {
-		.owner =		THIS_MODULE,
 		.name =			"digi_4",
 	},
 	.description =			"Digi 4 port USB adapter",

-- 
2.34.1


