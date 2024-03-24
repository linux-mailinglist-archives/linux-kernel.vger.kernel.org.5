Return-Path: <linux-kernel+bounces-113352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC20A8883A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE8B1C239FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA3719A61A;
	Sun, 24 Mar 2024 22:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LidR+aS3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B0B19A5FF;
	Sun, 24 Mar 2024 22:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320152; cv=none; b=m3n6QTdbMCkCP7VpiMK6ByIxE5aTYKTUO23VW469rn+UZUWlE9+NPuSO5TGDa5OTlYYjSU2ct1PBqWQipv9B6hFYqKdt5+3jN/0/aMa7C/kqwBcM+WccQOggppSCB6udVxjyGh1it00UphF52BhsVkIEUduHNsm785YOz5b1pl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320152; c=relaxed/simple;
	bh=BjcuebaRPfYPlAqyCr+uValv4NECtfJPw+lWn86FniE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrubJ5WOQ6nLwadUPdFpNkIZ580i09AOFzUze1VJjdz6DLV+Dc3j0mUum2I1zZUIo3frqQ11NVnNLVeJ8NhSa08Y9C1iOB9UR1IFZLxN+MsQi9J+IFVwMGzPgxBNm24LAu5CTo9psoKHu1bTuI2ErP2CFhgSGjftm7cf98ndhGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LidR+aS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D471DC433C7;
	Sun, 24 Mar 2024 22:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320152;
	bh=BjcuebaRPfYPlAqyCr+uValv4NECtfJPw+lWn86FniE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LidR+aS36zpYRMvgB0h7lRwWJToY7OuQ5aE/hBFB0mbp4mimu9j7XxfwS8NdVdpYM
	 Ufy3ljHc7owgV0dZfh3e9pgwGVc5m7lVyLsbEzSN1De6RiO2apgU/Uw2VYyRWD6etX
	 CPdB0t1qencaRUlC0zt7/8l/fdoztgd9LiIPYE20IW7F94fn8fBg6gm/xfi5g5BrpG
	 2vXw/T/T1JDLTCvBEroBAzC32xmGaHIs/lPFcY6dIPltdiwoowNmEok5u5/0f17SH2
	 LIMd8EGWj/t5rQFNtR7EwHGiGkfqryRcsd4Ch3vRpHi9ZIhgFLRSUsqs4QAVfUhY9F
	 yt0aiK8NHCU5Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 461/715] media: i2c: imx290: Fix IMX920 typo
Date: Sun, 24 Mar 2024 18:30:40 -0400
Message-ID: <20240324223455.1342824-462-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 9967f34774334..4150e6e4b9a63 100644
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


