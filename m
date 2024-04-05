Return-Path: <linux-kernel+bounces-132522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D181A899635
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2B91C22E8A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EB72D022;
	Fri,  5 Apr 2024 07:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnXsY36u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA5F25630;
	Fri,  5 Apr 2024 07:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712300829; cv=none; b=AhmaRM9JaULiEN/gF+3YsZvw6X3CfmR0eHg4A9DX9ZPLAsXnN+BU0PkmBcf+bl/BfVMHf/RjJo8YEpIuUoCyCp4+0hHTrbSTzEQrGIaj0/OW2QFp+CR0VuCvAc4Prg9EzJtIywVnKf1c6oH8c3M0RdjsqnKoeoovqv/Kez8s6+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712300829; c=relaxed/simple;
	bh=eFbZjuPGi6Na6U6LwNei9ExbpD+uf9+X+EC2RgTV5CM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sfrTBj1ao+1tELO+xOioax9UtKuEPkoTocIFpygMW/w+UCDAtj8uAOolxWYzN4mU37Fe4O8dL2PHi082sL9mZ+VaMXxZHUSYCWme9RAkv9/849TuVlpLVqjyxS4IOskPIqU5+ppItwLsQ5TIIkpAI/EW7H/A5UHYm41b95PWpBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnXsY36u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3948BC43390;
	Fri,  5 Apr 2024 07:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712300829;
	bh=eFbZjuPGi6Na6U6LwNei9ExbpD+uf9+X+EC2RgTV5CM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nnXsY36uZf2C1ON6EI2d143eNQ8uVoeMlV1y+bZsqzX+xu55ChbPhy9xZl3g7BVjp
	 +gEWVtkGCuS/J6kUNKdEWTCr2BIyAG/Q+FT4sKD2i8J+vC8ArDDSe7w++GcFfWOuYH
	 xuKpzGhOinG/tMlw96/RvpYOh0Gex6ZdjWOntnuxnbED0vluWOILAnEywpwBROKWIb
	 iGbwtxVb0GSv9gCMNpeM4DFfvBLpBnReiGw9/JCGAVOOeJn9cgVf5OHheoiGitTf0e
	 JD8/Ufknvi8iF+4/vtzdqmlcZrYUlxZoqvSEpLM6RfsXaaVqDeQwuu/WueD8m8be2/
	 yI3hJwzaPIKew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A61DCD11C2;
	Fri,  5 Apr 2024 07:07:09 +0000 (UTC)
From: John Bauer via B4 Relay <devnull+johnebgood.securitylive.com@kernel.org>
Date: Fri, 05 Apr 2024 02:06:27 -0500
Subject: [PATCH 2/2] Made recommended changes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-uvc-fix-relative-ptz-speed-v1-2-c32cdb2a899d@securitylive.com>
References: <20240405-uvc-fix-relative-ptz-speed-v1-0-c32cdb2a899d@securitylive.com>
In-Reply-To: <20240405-uvc-fix-relative-ptz-speed-v1-0-c32cdb2a899d@securitylive.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linh.tp.vu@gmail.com, ribalda@chromium.org, soyer@irl.hu, 
 John Bauer <johnebgood@securitylive.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712300828; l=3193;
 i=johnebgood@securitylive.com; s=20240325; h=from:subject:message-id;
 bh=dkpSlKoCDtmfrbNkIxv1oPQWyuGKeMw/uk3W29umIHU=;
 b=6tng+UXVo6Ae0n1yJViOQl2QeJHJCQVlCTuAZGRo6HdeoKOcpZD/VaGqxvRuorgKv7ny3eFEI
 +PILC7HsCN4AdhBouZdPjMXV5WRnRIYLIEld+BiluMkrEq4fDm5zjoi
X-Developer-Key: i=johnebgood@securitylive.com; a=ed25519;
 pk=RN31Fmrxbidp1TwtZGNmQwTDjUWMPnewQJfA/ug2P9E=
X-Endpoint-Received: by B4 Relay for johnebgood@securitylive.com/20240325
 with auth_id=143
X-Original-From: John Bauer <johnebgood@securitylive.com>
Reply-To: johnebgood@securitylive.com

From: John Bauer <johnebgood@securitylive.com>

Moved control checks to helper function and removed
dead code per recommendations from Ricardo.

Signed-off-by: John Bauer <johnebgood@securitylive.com>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 53 +++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index b389ab3ee05d..34a9a29b0754 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -441,7 +441,6 @@ static s32 uvc_ctrl_get_rel_speed(struct uvc_control_mapping *mapping,
 		return (rel == 0) ? 0 : (rel > 0 ? data[first+1]
 						 : -data[first+1]);
 	case UVC_GET_MIN:
-		return -data[first+1];
 	case UVC_GET_MAX:
 	case UVC_GET_RES:
 	case UVC_GET_DEF:
@@ -1233,6 +1232,17 @@ static u32 uvc_get_ctrl_bitmap(struct uvc_control *ctrl,
 	return ~0;
 }
 
+static bool is_relative_ptz_ctrl(__u32 ctrl_id)
+{
+	switch (ctrl_id) {
+	case V4L2_CID_ZOOM_CONTINUOUS:
+	case V4L2_CID_PAN_SPEED:
+	case V4L2_CID_TILT_SPEED:
+		return true;
+	}
+	return false;
+}
+
 static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 	struct uvc_control *ctrl,
 	struct uvc_control_mapping *mapping,
@@ -1322,30 +1332,23 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 		break;
 	}
 
+	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX)
+		v4l2_ctrl->maximum = mapping->get(mapping, UVC_GET_MAX,
+				     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
+
 	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN) {
-		switch (v4l2_ctrl->id) {
-		case V4L2_CID_ZOOM_CONTINUOUS:
-		case V4L2_CID_PAN_SPEED:
-		case V4L2_CID_TILT_SPEED:
-			/*
-			 * For the relative speed implementation the minimum
-			 * value cannot be probed so it becomes the additive
-			 * inverse of maximum.
-			 */
-			v4l2_ctrl->minimum = -1 * mapping->get(mapping, UVC_GET_MAX,
-						uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
-			break;
-		default:
+		/*
+		 * For the relative speed implementation the minimum
+		 * value cannot be probed so it becomes the additive
+		 * inverse of maximum.
+		 */
+		if (is_relative_ptz_ctrl(v4l2_ctrl->id))
+			v4l2_ctrl->minimum = -v4l2_ctrl->maximum;
+		else
 			v4l2_ctrl->minimum = mapping->get(mapping, UVC_GET_MIN,
 						uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
-			break;
-		}
 	}
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX)
-		v4l2_ctrl->maximum = mapping->get(mapping, UVC_GET_MAX,
-				     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
-
 	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)
 		v4l2_ctrl->step = mapping->get(mapping, UVC_GET_RES,
 				  uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
@@ -1936,14 +1939,8 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 		 * value cannot be probed so it becomes the additive
 		 * inverse of maximum.
 		 */
-		switch (xctrl->id) {
-		case V4L2_CID_ZOOM_CONTINUOUS:
-		case V4L2_CID_PAN_SPEED:
-		case V4L2_CID_TILT_SPEED:
-			min = max * -1;
-		default:
-			break;
-		}
+		if (is_relative_ptz_ctrl(xctrl->id))
+			min = -max;
 
 		step = mapping->get(mapping, UVC_GET_RES,
 				    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));

-- 
2.34.1



