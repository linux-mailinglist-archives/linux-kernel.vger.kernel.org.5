Return-Path: <linux-kernel+bounces-113877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14438888712
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45E111C2636D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6541A1386DC;
	Sun, 24 Mar 2024 23:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSJBdrAR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3C912AAD7;
	Sun, 24 Mar 2024 22:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320929; cv=none; b=AEtFvvCQSTQQaoUBTurz0aZ05rR9U48q3643XjBVlY9LNi8r7ZcAQK89TL4dENp5eBG/nlKE6fMjNyCwurPwyDdcA3CCqIATwts4Ro7wIDVmdaj3swz71vJutfLVn/hHGjgilkQbAl+E8dbZR56NirpeeeHCcQgA62R4thNl0ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320929; c=relaxed/simple;
	bh=OOhIOyqFS4mQvDxA/ImwVYkd2JK0f+nUbxqOUBhllr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mD2+TGWGg1WUidKDerWb3IYh9qkUApeNFGBZ/uIMRLnhZkfWbYAfAnIinicTP+mj9ENoMdj5T/VuZ+8Iq94OyC1rn28nWczJnoie8A+GrXhIpJR1R/boYZ7YZithokI17k3h2HngnTCVBs7ITzzSQquXOr0YPMDmum16M4K3kjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSJBdrAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6A7C43390;
	Sun, 24 Mar 2024 22:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320928;
	bh=OOhIOyqFS4mQvDxA/ImwVYkd2JK0f+nUbxqOUBhllr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mSJBdrARY/dPbxr7KlNq7kpdOWZF+xSNVCwfy0ECeWvsf2+hQdMjo2q7Qe+f4ZlOI
	 o0gTKvGPzbvenmCX8LL3uVLgi6q1xMJwHvNcMh4RAJhjlAGR8LMmXS60Udrk4RUopr
	 RF+PlIaZT/D2FkzkE5SbN5kpVVruJ1uszJILD1tUIIBmFbD1aOJ03JFez6OvYocyGc
	 QPt7MbbOkK6EfvxYCUJvdH/pzGWrG/pNC2ARDfhKxYSjrzqNyNPVf54sQ4lQoVR42c
	 Rxb65+MdiIaS0nRWdT9ViDOBQT5kloUwLwgzQtSLrMXh6H6zmmnsFtLJHdEZnrdPdz
	 WRnEVAG7PrrAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 492/713] media: i2c: imx290: Fix IMX920 typo
Date: Sun, 24 Mar 2024 18:43:38 -0400
Message-ID: <20240324224720.1345309-493-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


