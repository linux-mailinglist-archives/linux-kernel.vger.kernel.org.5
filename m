Return-Path: <linux-kernel+bounces-120937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1F688E0B6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2F6FB252FB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC9C14D43D;
	Wed, 27 Mar 2024 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAnJHGme"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB75114D2BE;
	Wed, 27 Mar 2024 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541635; cv=none; b=j4pQ9GnYyPIGoacOahIkhgdlDqBvLJhz95+up/gm2kSgUKFEGrqfAIDf+ideLl57efUEAsoMuFz2VNwx11k7Aw0IkYuP5Y8yfRJPFKQ2eLyGuKUXXhFUlXclSlDa9l5Sz6N2Aa9ZCdDMNif2xPzNjaUo6FSm4q2kdn+ZyWpTc10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541635; c=relaxed/simple;
	bh=JsFu3wR3DhF000KcrA8afqUCDSA8XExED+j71OfMf/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SNwJs7kGRs+ns5X0bsceLIA5+h4Qwe9bNdDXM+QEpPrP+pjdiMcXnFSVR7PB/3mtAwllnM7EFUqDjheaZq4lsaNDph6upshTw1UMurNCdSXx8+Rk+IaYmdd62lnyNt+HBERgvk/PmOtGo6GjtnNe3bmcWJ3+A8QrkclVxc7PjC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAnJHGme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA759C433F1;
	Wed, 27 Mar 2024 12:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541634;
	bh=JsFu3wR3DhF000KcrA8afqUCDSA8XExED+j71OfMf/U=;
	h=From:To:Cc:Subject:Date:From;
	b=HAnJHGmeN5xIf2DgHZlRthESGuTZPBlZOv3hC5DpbReefGpRyJKondDOHknSxQ+6o
	 sT391gKG7CeIZel1AMlZ6lX80ZNiBy0Og1jitWHnMGv1IPAKdJwVp0NrWy+qMBQFu0
	 9NvuK18f5UQiGdJ8VfpfsGLpJiHKapPCHv93yUn+0ahpxKKX8KlN2j93VHHsT+BqBj
	 eA3GDkc4qybwwJAbPuWFs/p3jpJ07mK9FxnT4Dl5xGJh1Q9orC9I512Jy+IbzlUqNe
	 RkzL/d/IW3jspjQ0wwcXAJE3APEoj+Wy5ggzE2wGXWXHLiqjlwKGWaSAEM6QJTq7yA
	 kLOo3beCX1fvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	laurent.pinchart@ideasonboard.com
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	linux-media@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "media: nxp: imx8-isi: Mark all crossbar sink pads as MUST_CONNECT" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:13:52 -0400
Message-ID: <20240327121352.2830698-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9b71021b2ea537632b01e51e3f003df24a637858 Mon Sep 17 00:00:00 2001
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 15 Jan 2024 04:16:29 +0200
Subject: [PATCH] media: nxp: imx8-isi: Mark all crossbar sink pads as
 MUST_CONNECT

All the sink pads of the crossbar switch require an active link if
they're part of the pipeline. Mark them with the
MEDIA_PAD_FL_MUST_CONNECT flag to fail pipeline validation if they're
not connected. This allows removing a manual check when translating
streams.

Cc: stable@vger.kernel.org # 6.1
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 .../media/platform/nxp/imx8-isi/imx8-isi-crossbar.c    | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
index 1bb1334ec6f2b..93a55c97cd173 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
@@ -160,13 +160,6 @@ mxc_isi_crossbar_xlate_streams(struct mxc_isi_crossbar *xbar,
 	}
 
 	pad = media_pad_remote_pad_first(&xbar->pads[sink_pad]);
-	if (!pad) {
-		dev_dbg(xbar->isi->dev,
-			"no pad connected to crossbar input %u\n",
-			sink_pad);
-		return ERR_PTR(-EPIPE);
-	}
-
 	sd = media_entity_to_v4l2_subdev(pad->entity);
 	if (!sd) {
 		dev_dbg(xbar->isi->dev,
@@ -475,7 +468,8 @@ int mxc_isi_crossbar_init(struct mxc_isi_dev *isi)
 	}
 
 	for (i = 0; i < xbar->num_sinks; ++i)
-		xbar->pads[i].flags = MEDIA_PAD_FL_SINK;
+		xbar->pads[i].flags = MEDIA_PAD_FL_SINK
+				    | MEDIA_PAD_FL_MUST_CONNECT;
 	for (i = 0; i < xbar->num_sources; ++i)
 		xbar->pads[i + xbar->num_sinks].flags = MEDIA_PAD_FL_SOURCE;
 
-- 
2.43.0





