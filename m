Return-Path: <linux-kernel+bounces-113862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CB2888703
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262BA1F25808
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AED208999;
	Sun, 24 Mar 2024 23:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3zzRLhu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D571DCC81;
	Sun, 24 Mar 2024 22:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320909; cv=none; b=F/WGvCOAabCZzf9h17fHlDM2cX6t9btinIWwIIZDQKGqITD9D7NPyBl5/Pk5WEGJKxmyTt2N2ZKrDVqpmrMVHvpImt2alHi4V33R77iFFMNaa1fq+C5A8Sq1/BwlOwxkb7fdHlWitzvM+WtekBvtU48g7wOz0anrlOSs/AJSKzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320909; c=relaxed/simple;
	bh=lh1tWZ+Q5ip5maxsWS3cRTsoCijckQtevMH31uUa3aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHp9n3ITjGr5/hz79gqNkTc1lVDonjfHE2+NB4BVANVCqec04ACKf0EhqzzjXpdeeFLeBstXs3uO3EVNovaWMyKQGsXgYfjjbSi5ZYqV8uf+sNlblzEfBt5YgAMGCl6mLmbkix9pF49cJroYxgrm6dOsQ/o7bZ/nHB2Ev07wCJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3zzRLhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD1FC433F1;
	Sun, 24 Mar 2024 22:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320907;
	bh=lh1tWZ+Q5ip5maxsWS3cRTsoCijckQtevMH31uUa3aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t3zzRLhuDDQVDNYeUZgK7hBB+SfCFCD0aXPLyP39WSSemDh6i9jN9W5l81YdY73Es
	 AUgUgWJ/vjv1erA5BqZuK3r8Q4t387lSk2Bt7m6u9i/EWnp3NY6FMKUu9Fjl+2XSAJ
	 TbRW3YJojhiJ7oiBZUjcN9YkhP8dk/yJJFURVfqt0jgYhV4M7riV+LD190n42eWR1P
	 5crzb6s3aTOVVlsZABFSTeuuLdLKa1R6N9rXHZwx9FUefhkQDWII2AhAgmNQIGSYyo
	 bnx/+9MACYiFfuPMmzZSkJaqJ/zIC1947NXGOwlw181ZAKwgUKLRAPAL3Iyh0r03R4
	 v1/LKjz+eAiFA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniil Dulov <d.dulov@aladdin.ru>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 471/713] media: pvrusb2: remove redundant NULL check
Date: Sun, 24 Mar 2024 18:43:17 -0400
Message-ID: <20240324224720.1345309-472-sashal@kernel.org>
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


