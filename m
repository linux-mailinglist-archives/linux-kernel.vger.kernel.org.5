Return-Path: <linux-kernel+bounces-114324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 114858889CA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B866B1F21251
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297C316F267;
	Sun, 24 Mar 2024 23:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDd0v/2u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961EA211D05;
	Sun, 24 Mar 2024 23:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321712; cv=none; b=PdQGFKbTzv52acx8kkMc6ZpLl/57tbiVon7f6BfzIZo2sntHv4j2bRoVECui8FI9RVWaIo7GLdgArPX/6HaMMzIxnFaOhxDyiyou/hLPppVbaKyXVS8xhx1WPFBDSOEcJpd+I2QXRQlGs7kg4GOp6r8/ftMd9hIzkr9at8Nw1Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321712; c=relaxed/simple;
	bh=OOhIOyqFS4mQvDxA/ImwVYkd2JK0f+nUbxqOUBhllr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dwv/rRPJR47HHzE1WJIow7v9PQ0X4UGAPCJzdiecYU4EJBQ6wf5uAVEzlPQ/pyrcRxF+qhF/097bOB2O2Ma5tf4y/Z1LJHZo/y7ywl4Y2poCIQIBfAOT+8sHJUEKlS6ZVWyYDk5mqaCwF97FwLihJHEQLXJCVwsmqvd6iUjOxG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDd0v/2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D00DC43390;
	Sun, 24 Mar 2024 23:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321711;
	bh=OOhIOyqFS4mQvDxA/ImwVYkd2JK0f+nUbxqOUBhllr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IDd0v/2ui7e59UeX51rSEoBfizZu2W3+bPfpIPnJAE087Po38h9AOTUyab45ErLs4
	 KIlz+QfcJGnI4Id6KwEui3kTKxNbPWLuJNXwv5HF+2G/3ET8fwWoIpq82Np7z6yype
	 lPt2IQH3cSGbepHZv7ICtjQekNHKNliQdiwBrlGA//X+hV0cTKjYPmPwPHL+XrqH/v
	 l9qE89SJnb4zboBifl4TzqFzK9TO4MPQzoB6oVS8EWa7x/g64BynV3I9S7N29/c3zH
	 Vu7VQ3MvDnAT5xFZH0hVcaYt5yIYcEr6cRG9iSHmcEyz6T54Mt0/IlL8wlAEgb7f/B
	 UW5b61CrNbTrw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 440/638] media: i2c: imx290: Fix IMX920 typo
Date: Sun, 24 Mar 2024 18:57:57 -0400
Message-ID: <20240324230116.1348576-441-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit 6fc62efa266b0918c7b226f45c2eccfcf99a6d8e ]

Replace IMX920 by IMX290.

Fixes: b4ab57b07c5b9 ("media: i2c: imx290: Add crop selection targets support")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/imx290.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
index c6fea5837a19f..6dacd38ae947a 100644
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -150,10 +150,10 @@
 
 #define IMX290_PIXEL_ARRAY_WIDTH			1945
 #define IMX290_PIXEL_ARRAY_HEIGHT			1097
-#define IMX920_PIXEL_ARRAY_MARGIN_LEFT			12
-#define IMX920_PIXEL_ARRAY_MARGIN_RIGHT			13
-#define IMX920_PIXEL_ARRAY_MARGIN_TOP			8
-#define IMX920_PIXEL_ARRAY_MARGIN_BOTTOM		9
+#define IMX290_PIXEL_ARRAY_MARGIN_LEFT			12
+#define IMX290_PIXEL_ARRAY_MARGIN_RIGHT			13
+#define IMX290_PIXEL_ARRAY_MARGIN_TOP			8
+#define IMX290_PIXEL_ARRAY_MARGIN_BOTTOM		9
 #define IMX290_PIXEL_ARRAY_RECORDING_WIDTH		1920
 #define IMX290_PIXEL_ARRAY_RECORDING_HEIGHT		1080
 
@@ -1161,10 +1161,10 @@ static int imx290_get_selection(struct v4l2_subdev *sd,
 		 * The sensor moves the readout by 1 pixel based on flips to
 		 * keep the Bayer order the same.
 		 */
-		sel->r.top = IMX920_PIXEL_ARRAY_MARGIN_TOP
+		sel->r.top = IMX290_PIXEL_ARRAY_MARGIN_TOP
 			   + (IMX290_PIXEL_ARRAY_RECORDING_HEIGHT - format->height) / 2
 			   + imx290->vflip->val;
-		sel->r.left = IMX920_PIXEL_ARRAY_MARGIN_LEFT
+		sel->r.left = IMX290_PIXEL_ARRAY_MARGIN_LEFT
 			    + (IMX290_PIXEL_ARRAY_RECORDING_WIDTH - format->width) / 2
 			    + imx290->hflip->val;
 		sel->r.width = format->width;
@@ -1183,8 +1183,8 @@ static int imx290_get_selection(struct v4l2_subdev *sd,
 		return 0;
 
 	case V4L2_SEL_TGT_CROP_DEFAULT:
-		sel->r.top = IMX920_PIXEL_ARRAY_MARGIN_TOP;
-		sel->r.left = IMX920_PIXEL_ARRAY_MARGIN_LEFT;
+		sel->r.top = IMX290_PIXEL_ARRAY_MARGIN_TOP;
+		sel->r.left = IMX290_PIXEL_ARRAY_MARGIN_LEFT;
 		sel->r.width = IMX290_PIXEL_ARRAY_RECORDING_WIDTH;
 		sel->r.height = IMX290_PIXEL_ARRAY_RECORDING_HEIGHT;
 
-- 
2.43.0


