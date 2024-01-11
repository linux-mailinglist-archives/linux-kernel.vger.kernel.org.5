Return-Path: <linux-kernel+bounces-23830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D6E82B271
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33628283A26
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A192F4F88D;
	Thu, 11 Jan 2024 16:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BRv9/7oT"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1381F50243;
	Thu, 11 Jan 2024 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704989247;
	bh=XCK1CV/VSM6OTw5gCljrP86qEptdNtFM4Wvlklxvlgw=;
	h=From:To:Cc:Subject:Date:From;
	b=BRv9/7oTfeVU9WWFVnq9RsczL7aWbPG9zpNpsQ1fVr4Mt/j1I4T9AJIOYasxixuqi
	 GINOWppUl4JrnfHS9N4h1eqIDYQZegj1qG2YmatSsTuTbVsSZ8OZ+We7wdbiLQSVqy
	 rB26OqhbLVpyOj0FHkUF3i5s1Ln98Y3rLzJGsCxfAAbBPkkxtiBx2aPqeJ0MLYM5vR
	 P2CGDtii9S7W8pUgALNvftE4v/SNCCe5v4py3UACe6vYoHlMU+YNm3NzzXUxpBsW10
	 51Zv4NotFOumRBQuml0uBzNr9A9z2dtnhw5D+Vd2RinBPnNhVF4tqaKnMko0iE2d8h
	 7ilNQysjPUpDw==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D98E73781492;
	Thu, 11 Jan 2024 16:07:26 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: mchehab@kernel.org,
	p.zabel@pengutronix.de,
	hverkuil-cisco@xs4all.nl,
	nicolas.dufresne@collabora.com
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [RCF 0/2] Enumerate all pixels formats
Date: Thu, 11 Jan 2024 17:07:19 +0100
Message-Id: <20240111160721.50020-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The goal of this series is to let userland applications enumerate
all the supported pixels formats of a stateless decoder without
setting all the possible codec-dependent control.
That offer a simplest solution for applications to discover
supported pixels formats and possibly let them doing smarter
choice between stateless decoders.

Benjamin

Benjamin Gaignard (2):
  media: videodev2: Add V4L2_FMT_FLAG_ALL_FORMATS flag
  media: verisilicon: Use V4L2_FMT_FLAG_ALL_FORMATS flag

 .../media/v4l/dev-stateless-decoder.rst              |  3 +++
 .../userspace-api/media/v4l/vidioc-enum-fmt.rst      |  4 ++++
 .../userspace-api/media/videodev2.h.rst.exceptions   |  1 +
 drivers/media/platform/verisilicon/hantro_v4l2.c     | 12 +++++++++---
 drivers/media/v4l2-core/v4l2-ioctl.c                 |  2 +-
 include/uapi/linux/videodev2.h                       |  1 +
 6 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.40.1


