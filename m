Return-Path: <linux-kernel+bounces-113331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B2E888378
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51671C2398C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CDA19669D;
	Sun, 24 Mar 2024 22:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UU+DogfM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7187919598E;
	Sun, 24 Mar 2024 22:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320132; cv=none; b=K/dV7f85zvJh0CB0v6c6H5I2wNGsRbuwyCsCS14wzYuRa2pIL4KouDGJ4JrHuJFSVp+eJF5KehT/ygyuMc/RPX+2xpEpIQbouCNOt5GeScTG1+r3BaTWYvBuOA1ETn5GPPY/5xUS8qohoii8Jm5NICqoduFAmHxArO5UVSSjF/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320132; c=relaxed/simple;
	bh=lh1tWZ+Q5ip5maxsWS3cRTsoCijckQtevMH31uUa3aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0cE2h6tag0IJpkmda0ZgopWiCeZa9NMtA1AFX4kzcAB2HquxdI9B/WkOH384WcvDwCVQVE8gttYF0g5hLmdsyaTWzTv/gTB2AnRf/z3XuoUYhuGomHvZkj6hAOJBP0FbpUodPAdSMMNlTgI/c2x+D6zY7yM1ArsFUPl+2rLfCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UU+DogfM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1527C43394;
	Sun, 24 Mar 2024 22:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320132;
	bh=lh1tWZ+Q5ip5maxsWS3cRTsoCijckQtevMH31uUa3aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UU+DogfMzs5yI8fL+6/M7hzKW5uJcARubNPTQOgGrxTPKlE+d09F+Vx2RCtc9Nj4P
	 /ekEEaW12FxGu0DXNGC3q84JfmM+vdJxTA2Oeg2RwThy2GjKGyrhZSIn98uJfmL/hk
	 h/m8Z9KQ6yOoYZxX9gYpdrjQ+z5jGmLsCxJfSEstVjKwn9Wgkc3sfL2k70uINn+rjn
	 o/IQ3eP1JCHGuSOQs1TbrnGsGTXmu12SD1L5lm/dO2Ei+zz8v58RaoVZlTc0XeseOG
	 cUnLD9CX3W/ms3zDO4ircQNNyNm6SWtdlyV+M2ssm8ZXwLmhgJN7Q3ZpCoRzW+VWTx
	 6tcBTwESdwizw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniil Dulov <d.dulov@aladdin.ru>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 440/715] media: pvrusb2: remove redundant NULL check
Date: Sun, 24 Mar 2024 18:30:19 -0400
Message-ID: <20240324223455.1342824-441-sashal@kernel.org>
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
index c04ab7258d645..d195bd6a2248b 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
@@ -1198,11 +1198,6 @@ static void pvr2_v4l2_dev_init(struct pvr2_v4l2_dev *dip,
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


