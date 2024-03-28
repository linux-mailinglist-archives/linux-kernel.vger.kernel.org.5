Return-Path: <linux-kernel+bounces-122700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D2888FBB9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2321C2E9E4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095247C6C8;
	Thu, 28 Mar 2024 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MLHdlc3P"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FBD6A332;
	Thu, 28 Mar 2024 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711618489; cv=none; b=mTMaXsI2wHV/LWerJaCTnCX+oKyo7zUc+0RZnFlRgDKtnxgnqeF9dVg2mMIXYqbZ5cVoKAFkOF27QacIQkp6Z8ZvC+D3vlCxCxPjFU7cZlZ6sbJgFsU44WTp4y2HGO2vu3urVpWhaICQsk96N2k1AHglV2gdXZFFR04EHApO/i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711618489; c=relaxed/simple;
	bh=rzOR/SQyYYN02F8+nxnnUUb/7ROlgWUvJTqH3GuWMSo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L0cbCUhgq65p/RjNbtM6Lq9qM1mZzSJW4PstOJUJx+XB67CL6iubwI6XcBMAFbJZSapCLyQHS1A15PX5eD55gx0D0UY3gHwGOEOD/OIXgEo01eNehMFGkGNmsROClhw0TBNDmo66wcuC8vMmj7/bXO0HGGPfS7bckLuDD4+KAxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MLHdlc3P; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711618485;
	bh=rzOR/SQyYYN02F8+nxnnUUb/7ROlgWUvJTqH3GuWMSo=;
	h=From:To:Cc:Subject:Date:From;
	b=MLHdlc3P+nix/YLt9j0iEfYhWBPXeREvzJFFpz9oDGuMr8XKIb/xq3u4X6FYl3CjQ
	 IxKLc2gLiAdvRMBFwumNh/6GnwTF1xi9zwXVpCVQ5JdTMIcwonkUQiLwSXZ3lNwefq
	 xoI7hZCxXpvqTtgThR+QNd56hUgS4gV791tdtEXMq9hXK9SV15Uke8TZ7Ku8sB30mk
	 youFGeB5CT8bX6hVEQDThp+D7agEOFzDBkoiqHHWppoXQZh471tVvocOJcgJ5kz3G4
	 Be3ELSeOwQ2F+Ns/RMAMfEt+hHnN8GjKYqF6kvAnopYOGt4hya2O2ywCxUvtM2926f
	 +W+JsW2F05NoQ==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 654D13782112;
	Thu, 28 Mar 2024 09:34:45 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de,
	mchehab@kernel.org,
	heiko@sntech.de
Cc: linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH] media: verisilicon: AV1: Be more fexible on postproc capabilities
Date: Thu, 28 Mar 2024 10:34:38 +0100
Message-Id: <20240328093439.18712-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RK3588 post-processor block is able to convert 10 bits streams
into 8 bits pixels format.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Fixes: 003afda97c65 ("media: verisilicon: Enable AV1 decoder on rk3588")
---
 drivers/media/platform/verisilicon/rockchip_vpu_hw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
index f97527670783..964122e7c355 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
@@ -82,7 +82,6 @@ static const struct hantro_fmt rockchip_vpu981_postproc_fmts[] = {
 	{
 		.fourcc = V4L2_PIX_FMT_NV12,
 		.codec_mode = HANTRO_MODE_NONE,
-		.match_depth = true,
 		.postprocessed = true,
 		.frmsize = {
 			.min_width = ROCKCHIP_VPU981_MIN_SIZE,
-- 
2.40.1


