Return-Path: <linux-kernel+bounces-94521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F528740FE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9431F237E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBCF140E5B;
	Wed,  6 Mar 2024 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="g2RVWGhN"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F68140386
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755416; cv=none; b=Q2JCILILOX21pupfErImYYhBCdP6RYyS9t9SM4C6oI9pssCTWzFW7+3dQaQjcc4Z53//S7lyQmiC19ZMns6dTrM2CvxqfKEH3bZDudSguq8g7lVkQRAEpdVVxA1AitRguOx0RM0/M5nzAjuZH/UEvvMbxSGeDK3KwzJXa7WWOj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755416; c=relaxed/simple;
	bh=j/vS7DsxV/D4GunL1vou/Gx6H9hRsoQaXd6e18HvHpA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TTgs3bcg8IV158hBuYhilDFNc65M2G6DOd84fx9yvMGSCnLXhEwH8j2wsRWsPhgDNMqSyUGbr58LnoE5uXEF0RGjW+GK2Jh4EWFO67N3XgYQv1c9aKFbCKdNtu8WAuxzhDUVPU15PRpBi5/60WZVn1hzf6tmcYL8gOzqJHdc0Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=g2RVWGhN; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4Tqjzh0rjCzDqKq;
	Wed,  6 Mar 2024 20:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1709755408; bh=j/vS7DsxV/D4GunL1vou/Gx6H9hRsoQaXd6e18HvHpA=;
	h=From:Subject:Date:To:Cc:From;
	b=g2RVWGhN0Sxa5zndei+PgdrWdIFzhcDxdWzUG/8aQC5Tl/aktt9Xp60qlG4c9lsew
	 U+yjbH3OdLYtgrqCfEk8AtVlqQGKAF+FFe0SnGTVDTF5Ddw3jQDuQxdhGsjM0v/wq0
	 cqKnM+C95jakxigCMhf6kb0wGzXx1WZgbdHOjBe4=
X-Riseup-User-ID: 872E29627DD76E4FF5C5DF32076E0D07298CC61DEAD3E272343D93186CA056E9
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4TqjzY0ZRFzFvsg;
	Wed,  6 Mar 2024 20:03:20 +0000 (UTC)
From: Arthur Grillo <arthurgrillo@riseup.net>
Subject: [PATCH 0/7] Additions to "Reimplement line-per-line pixel
 conversion for plane reading" series
Date: Wed, 06 Mar 2024 17:03:07 -0300
Message-Id: <20240306-louis-vkms-conv-v1-0-5bfe7d129fdd@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPvL6GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYwMz3Zz80sxi3bLs3GLd5Py8Ml0zQ2Mzo7Q0Q6PEJAsloK6CotS0zAq
 widGxtbUA+r/I92EAAAA=
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, arthurgrillo@riseup.net, 
 Jonathan Corbet <corbet@lwn.net>, pekka.paalanen@haloniitty.fi, 
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com, 
 nicolejadeyee@google.com, Pekka Paalanen <pekka.paalanen@collabora.com>

These are some patches that add some fixes/features to the series by
Louis Chauvet[1], it was based on top of the patches from v4.

Patches #2 and #3 should be amended to "[PATCH v4 11/14] drm/vkms: Add
YUV support". To make patch #3 work, we need patch #1. So, please, add
it before the patch that #2 and #3 amend to.

Patches #4 to #6 should be amended to "[PATCH v4 14/14] drm/vkms: Create
KUnit tests for YUV conversions". While doing the additions, I found
some compilation issues, so I fixed them (patch #4). That's when I
thought that it would be good to add some documentation on how to run
them (patch #7), this patch should be added to the series as new patch.

[1]: https://lore.kernel.org/r/20240304-yuv-v4-0-76beac8e9793@bootlin.com

To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Melissa Wen <melissa.srw@gmail.com>
To: Maíra Canal <mairacanal@riseup.net>
To: Haneen Mohammed <hamohammed.sa@gmail.com>
To: Daniel Vetter <daniel@ffwll.ch>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: arthurgrillo@riseup.net
To: Jonathan Corbet <corbet@lwn.net>
To: pekka.paalanen@haloniitty.fi
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: jeremie.dautheribes@bootlin.com
Cc: miquel.raynal@bootlin.com
Cc: thomas.petazzoni@bootlin.com
Cc: seanpaul@google.com
Cc: marcheu@google.com
Cc: nicolejadeyee@google.com

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
---
Arthur Grillo (7):
      drm: Fix drm_fixp2int_round() making it add 0.5
      drm/vkms: Add comments
      drm/vkmm: Use drm_fixed api
      drm/vkms: Fix compilation issues
      drm/vkms: Add comments to format tests
      drm/vkms: Change the gray RGB representation
      drm/vkms: Add how to run the Kunit tests

 Documentation/gpu/vkms.rst                    |  11 +++
 drivers/gpu/drm/vkms/tests/vkms_format_test.c |  81 +++++++++++++++++++--
 drivers/gpu/drm/vkms/vkms_drv.h               |   4 +
 drivers/gpu/drm/vkms/vkms_formats.c           | 101 +++++++++++++++++++-------
 include/drm/drm_fixed.h                       |   2 +-
 5 files changed, 165 insertions(+), 34 deletions(-)
---
base-commit: 9658aba38ae9f3f3068506c9c8e93e85b500fcb4
change-id: 20240306-louis-vkms-conv-61362ff12ab8

Best regards,
-- 
Arthur Grillo <arthurgrillo@riseup.net>


