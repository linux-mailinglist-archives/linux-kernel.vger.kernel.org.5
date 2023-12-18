Return-Path: <linux-kernel+bounces-3130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232218167C7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1165B20E03
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0A8101FE;
	Mon, 18 Dec 2023 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UZ0HkyAX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00BBE579;
	Mon, 18 Dec 2023 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-149-209.elisa-laajakaista.fi [91.158.149.209])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9FE2B15B5;
	Mon, 18 Dec 2023 08:53:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1702886022;
	bh=zKagm460JpwxYXaiONH9XZnoH9bqVXdR1WvL7VlcgPg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UZ0HkyAXp0K6m61+0qI4QyfcUIVUvcqLclmfDU67REsE8ZfqfcLgZ8gaVBBlg5M4e
	 RAHZwBKl7WoShNtHrcPaGP3Kaf+q1lLe2m3MEyJFlqKsUySXb4zDSugt44hAeiT7CN
	 h6oK/GfCuD7ajijxHZkrzIBzuQaCQ0XVq63a1A+g=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 18 Dec 2023 09:54:00 +0200
Subject: [PATCH 1/2] Revert "media: rkisp1: Drop IRQF_SHARED"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-rkisp-shirq-fix-v1-1-173007628248@ideasonboard.com>
References: <20231218-rkisp-shirq-fix-v1-0-173007628248@ideasonboard.com>
In-Reply-To: <20231218-rkisp-shirq-fix-v1-0-173007628248@ideasonboard.com>
To: Dafna Hirschfeld <dafna@fastmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Mikhail Rudenko <mike.rudenko@gmail.com>
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Paul Elder <paul.elder@ideasonboard.com>, linux-media@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1189;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=zKagm460JpwxYXaiONH9XZnoH9bqVXdR1WvL7VlcgPg=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBlf/q0m1ZIhyfN/VQk1p4R2SkQxrKhz3E9a2wPW
 6hvqYULuVaJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZX/6tAAKCRD6PaqMvJYe
 9bLNEACOty+4zxtY9WKiAGyTNrH8gGUraTQv7Lo+htgeNcqEo95ymQx18BlRQMdP1TtPRnentdv
 mzFgEFveizwSX3bnVOY5lcNQtxyKkW1B1p3np9srUTq6yiFZ97KMqBQbiieN230zTLZUB4dwM3o
 wl/QoUKqXtCG4ocCoNzeF+gN9TmY+qLZ+phCq+L4ARxS/60hDUAqGBC8d+cA2bPIqWHORLuc0qP
 v/QQvjd0ymziGbtraMevbf9EqR8PEi6silm42AorU4zKruoOsFdtxkmbmfFYV3bAAhlNc//J51T
 K2P6WhPAIfrI8sMa0Zg8zRYjuD1meRXk4P8BRFbDH48rCFvqXm0eTMorOdxeaSiY9A3z6graMtF
 GFX+baqtbsipwjCMRJcckdj02U7CQHBraMY221RcC0eFcQ/a6JrX+fNubr5LdcfIZTP5gO+B2Ry
 c2+xSKnYhJ+VGaap4sDz7gD3+N7d5+uH1oTVaNGwsfo1iH2LPs6lU7EusuQhD0bnBXgl27IsJCr
 /gymAeYlkfRAGFdBuv7WIrjTdvktUZvFOeCTPp55FoN9a1ZjF3GD5ABmspPd+7MlNfjb5MgnnfY
 9LNN3uspWtvTF8swjdCfgRJfPCAGP8piVIxyKd4jENI0abQiC7qJnrDeihBfSJAnrmcPIXKPxs9
 Ne7T6oN1g+q8z3Q==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

This reverts commit 85d2a31fe4d9be1555f621ead7a520d8791e0f74.

The rkisp1 does share interrupt lines on some platforms, after all. Thus
we need to revert this, and implement a fix for the rkisp1 shared irq
handling in a follow-up patch.

Reported-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Closes: https://lore.kernel.org/all/87o7eo8vym.fsf@gmail.com/
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
index f96f821a7b50..acc559652d6e 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
@@ -559,7 +559,7 @@ static int rkisp1_probe(struct platform_device *pdev)
 				rkisp1->irqs[il] = irq;
 		}
 
-		ret = devm_request_irq(dev, irq, info->isrs[i].isr, 0,
+		ret = devm_request_irq(dev, irq, info->isrs[i].isr, IRQF_SHARED,
 				       dev_driver_string(dev), dev);
 		if (ret) {
 			dev_err(dev, "request irq failed: %d\n", ret);

-- 
2.34.1


