Return-Path: <linux-kernel+bounces-116278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3402889DF3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4A151C2CD81
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE591327F4;
	Mon, 25 Mar 2024 03:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dri6hP20"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895B5181BBE;
	Sun, 24 Mar 2024 23:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324121; cv=none; b=GOXOaaYQgHTm2PAb8jKgXqRkuoms3bHusMBBr4vVSR3aPFRLvxrdZheDajxAzsWuOXf6VBtxhytCp08UZDeCoIADxZany0porysN2rpsdZcX/fRrXBylIwTdqKU497qhzUI83jEY6AqKIOQ5B8AkktzfDt2tC6fOksObyR2i3YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324121; c=relaxed/simple;
	bh=F94zCIHM1waXUDSLk5g9afMxrIzvcf1IbqIyFK2zXMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgFPJgXkoDpJkrkkpJ4GID0RcPS7X1e5UzLk718m/VCrwSg2Gd43WYdmSHQq3pbLxgNjqnpK+kkFN65/HLUe3zofrddzrpJjMrT+9+41Ht2HbrZvNeoX+jYyAjg8veACSdh4Uua/ygGCI1SKoOT2/+K6B0OvBj3SrZ3fEXaCoH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dri6hP20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D79C43143;
	Sun, 24 Mar 2024 23:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324121;
	bh=F94zCIHM1waXUDSLk5g9afMxrIzvcf1IbqIyFK2zXMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dri6hP20jWUUUv17ddev9mainN6x0HBTArSEQT30vheF6rsulOFUjbhcMzZnEzAs2
	 /33DyaCQE6KJ9zUTrU9C8kO9p7ijCOtNo8/15c4jcb5O4XIwofKeEzGLzdg84icBAT
	 qTHZ3YKjgNRXhZv1debbedlXRdWTo4p8TumeMOS04YlonCzetZiRib6kqOetwr5EkL
	 HlHRvkLRvI+vj+H8DUC2/PPRIFGPCqpfHeASoX6M73S9c2B4APzv7Gl1ImeQYuulXE
	 aMzNxsXYFJJCzfRsLjtNBP7hihO1/jSBiO+kANJXTiMQxshipLcTxvqkELM+ITDK4J
	 NJFjP6QZ/lStg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniil Dulov <d.dulov@aladdin.ru>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 119/183] media: pvrusb2: remove redundant NULL check
Date: Sun, 24 Mar 2024 19:45:32 -0400
Message-ID: <20240324234638.1355609-120-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Daniil Dulov <d.dulov@aladdin.ru>

[ Upstream commit 95ac1210fb2753f968ebce0730d4fbc553c2a3dc ]

Pointer dip->stream cannot be NULL due to a shift, thus remove redundant
NULL check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c74e0062684b ("V4L/DVB (5059): Pvrusb2: Be smarter about mode restoration")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
index eaa08c7999d4f..d79b4083c9d4a 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
@@ -1202,11 +1202,6 @@ static void pvr2_v4l2_dev_init(struct pvr2_v4l2_dev *dip,
 		dip->minor_type = pvr2_v4l_type_video;
 		nr_ptr = video_nr;
 		caps |= V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_AUDIO;
-		if (!dip->stream) {
-			pr_err(KBUILD_MODNAME
-				": Failed to set up pvrusb2 v4l video dev due to missing stream instance\n");
-			return;
-		}
 		break;
 	case VFL_TYPE_VBI:
 		dip->config = pvr2_config_vbi;
-- 
2.43.0


