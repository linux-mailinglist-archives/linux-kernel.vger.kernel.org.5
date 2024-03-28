Return-Path: <linux-kernel+bounces-123716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFF3890D09
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8CE21F26614
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589AD13F44F;
	Thu, 28 Mar 2024 22:06:56 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AAB13F43D;
	Thu, 28 Mar 2024 22:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663615; cv=none; b=XVH03iedkQegzlHYxuf89E8Ai8v+XynH/I1JZGQbQNwUHckKfYMjHveOax8/xqUAWcvH11M9J8e8ABFErFJ1zEf1NzOhnPJwAZxMFZBfSe8kAni6W8cMQTivX+Bnnb9fXHqTxg+6ewhHVK3yKJhCGvoHU6U6RQ6GW4skESpcpoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663615; c=relaxed/simple;
	bh=cKOxMhAZxm89Ryjch4R9DrdB0cUfFYBxuwdaOEf5HsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sk7ZLd4aknE4t5bas+BhyVXUxq+s6IuWfwu/T3/7lBCoslinM64NjMKmT9tGMEqoiQwyF1EIieQI7+6TuMQccwoUpkLX/TFctouwPk4GIC1j/7phXqPW+rb2x32rROAM8Ad4ZB/BunwXGLczygAx3MlnFdQqaL4sgRB1NdWPcH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EBEC433C7;
	Thu, 28 Mar 2024 22:06:54 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:05:49 +0100
Subject: [PATCH 11/52] USB: serial: f81232: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-11-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=902;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=cKOxMhAZxm89Ryjch4R9DrdB0cUfFYBxuwdaOEf5HsQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenE/Rtby9gGebtZIna4XSpdBSz6nvf39gIZ7
 HCcLpRQM6GJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXpxAAKCRDBN2bmhouD
 17kBEACMI9t4wmSmegKoiE+nqOe1y9XJxzm7+7Qj4e8Dqy1xE1jJz/2h/9b5zYjSSsve6UDLODQ
 6zkPAgdGzwAhoxiyeyql1GKYbPKr/LMv0JXn8slTZgTlDmg0wh512Qr5/jUVINOb2jyEnAC+lA9
 3+hZI6TVgRFXTgzMws0ajyP8cRz0Nml1Wv3anh0t3IjK+MUN/TFjSBRU4rG5dk2TYx1o04prGbe
 CxMyaX/FRiOxbSnUjmVNU1KQ/OXOMrzUv87UQC6JRr78t1UcfEFc8biVhibjRRwL50XHuhqqfl7
 dtfjAqVEJ8X6HlTxlFKBmZMxxAMsWPGC5DMFE6TKQCFR8biESmWDq8TpXiC3GMJoG6tuUJLDvWC
 kv1wiW/NzW13Q93nF44K4YFcFBZmyv40AsLfYWNyiIAstd+nRnONvbE9yfaSutA9ip30KWWQdqz
 1rShnYcobgiUNERqpSZCir6rb5LAQ4fEtS2IT18hqi9kjEaWxIPLqFw3IyJoILjCsVYkJRJESMd
 B3MZhzy64a7uLJAOWAIsa5EvBpTk1sH9Cp+XVDb5G6nw8hB9B/O0YnnAuhSt2O1D8GcEsdruORw
 17GPrxw3znOyY4QG+OmmN4J10lP9ksk9dci2lyIAG6Xs9lXkr5bTmBQPmIR367OwGWI3jOMsJc5
 KmZYwj+QF9S8ItA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/f81232.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 5f7a46bcace6..530b77fc2f78 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -967,7 +967,6 @@ static int f81232_resume(struct usb_serial *serial)
 
 static struct usb_serial_driver f81232_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"f81232",
 	},
 	.id_table =		f81232_id_table,
@@ -994,7 +993,6 @@ static struct usb_serial_driver f81232_device = {
 
 static struct usb_serial_driver f81534a_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"f81534a",
 	},
 	.id_table =		f81534a_id_table,

-- 
2.34.1


