Return-Path: <linux-kernel+bounces-86976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AC186CDC5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80BBF1C20E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B82151CCB;
	Thu, 29 Feb 2024 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/1NhnRD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CF670AD9;
	Thu, 29 Feb 2024 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221788; cv=none; b=FJ6YlEpd/eu+V8cjEOnz/66aFN1U3ut2XvscmFihGJ4TjgE3gqmedfp7fgL4KI/UJIMeOS4jNkrrg+1HDPifPVLE7n4Vy7OwsX+TYnl57FbGQ36cta99TrfZZKqJ9o9lVHliEbHI98azGqFvvZnT8FuSnEuTA8kWEey7UwgTW0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221788; c=relaxed/simple;
	bh=WjyUUH4IyA8kfmC6HN4ybuY6b7RS7b5tdCPSoD9L/Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N/DPa3Qq8Nq9AadTYXqHfkT7RRn7ihQNRqiKa3AivNWDARDEW8exGWxFbGG1n+pKHfe+6Cv5xZvzxJKCSN8u8dhs9q1F1Dw2+zVphvatBlSaW/aLLrBHDMmS3+8d+apVBTAy8EvZPmayL0cJbZZZoePs4TMkjNSEFSuoPk34rek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/1NhnRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39ADC433C7;
	Thu, 29 Feb 2024 15:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221788;
	bh=WjyUUH4IyA8kfmC6HN4ybuY6b7RS7b5tdCPSoD9L/Bk=;
	h=From:To:Cc:Subject:Date:From;
	b=t/1NhnRDEz+m+mps36X0hOseC+DJOSA++I5U8nRDkc6/I4VDZoSk5dAnBzeYZmp0h
	 SeHP++XE8Z1K0Eydmlbv2umUjr1SwrrLkaOFvNF4vLzBvdA4TLyFOFizRosVlzq7jH
	 WZ9HGejqsrdtBjnq5AgBVQGByuu8VUh88zoEj7lcNXvZsnNMGcocdmqjyHdvStDwzv
	 51aQax1Jpz0Khvg+hQ4CQe2ypa0CrbcefEFGC3/ks1X2uefOk66bQDnwG66Y4txNwK
	 BQC8u0CZNyDEEvgGrxILer3NiuSOv/EchFXzJLMXPV3IQMHFwO5W6PQwRoBt8iVj2W
	 EHY6P8HXgEF3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Mikhail Rudenko <mike.rudenko@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dafna@fastmail.com,
	heiko@sntech.de,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 01/21] media: Revert "media: rkisp1: Drop IRQF_SHARED"
Date: Thu, 29 Feb 2024 10:49:21 -0500
Message-ID: <20240229154946.2850012-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
Content-Transfer-Encoding: 8bit

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit a107d643b2a3382e0a2d2c4ef08bf8c6bff4561d ]

This reverts commit 85d2a31fe4d9be1555f621ead7a520d8791e0f74.

The rkisp1 does share interrupt lines on some platforms, after all. Thus
we need to revert this, and implement a fix for the rkisp1 shared irq
handling in a follow-up patch.

Closes: https://lore.kernel.org/all/87o7eo8vym.fsf@gmail.com/
Link: https://lore.kernel.org/r/20231218-rkisp-shirq-fix-v1-1-173007628248@ideasonboard.com

Reported-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
index f96f821a7b50d..acc559652d6eb 100644
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
2.43.0


