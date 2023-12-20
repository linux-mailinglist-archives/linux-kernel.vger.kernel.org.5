Return-Path: <linux-kernel+bounces-6873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3319819EBF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C13287371
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2643A38F9F;
	Wed, 20 Dec 2023 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eWwyjF15"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4518D38F89
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703074324;
	bh=o5VygW2F7/dS/7MDJfHNbT3yI/+OvM90k1Msadpf4uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eWwyjF15SvtXp/ZxTBm2Nsl7Jwjq0tr2ptKcIRwgyNUAHJDcx96FAbQX9FW1EPjzV
	 UO4qPeKpcr7cIAu9Z+d2CiM4X3MBHWjY5t1LThv6Upybpqpk06F+DiMJVjWh8ehLZr
	 lDgrP8vH6CWxGsq4cgtgkN8v8Ci6EkRhQQYCdxSd9awlbnWJsEYMpugAOmvlcou+E0
	 G6L/ZgaKI8j4Ch1yd0aS4cGv+pYDg3qWm+avQGWN8QC/zKyOQee3+e05y6s0nHrpwE
	 LFLLzc/nzKxyQPn28SaAKmGKBJNhxolKGkzPFQrw0OLqBIPt8jkh0kJrfP4K8BPCIY
	 k12gasUBKmZPw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BB48C3781FD5;
	Wed, 20 Dec 2023 12:11:59 +0000 (UTC)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: helen.koike@collabora.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	daniels@collabora.com
Cc: david.heidelberg@collabora.com,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	emma@anholt.net,
	robdclark@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/8] MAINTAINERS: drm/ci: xfails: add entry for panfrost
Date: Wed, 20 Dec 2023 17:41:08 +0530
Message-Id: <20231220121110.1441160-7-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231220121110.1441160-1-vignesh.raman@collabora.com>
References: <20231220121110.1441160-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DRM CI tests panfrost drivers, and track of which tests
are failing, flaking or being skipped by the ci in the
expectations files. So add entry for these files, so
that the corresponding driver maintainer can be notified
when they change.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d959a6881f7..bcdc17d1aa26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1645,6 +1645,7 @@ L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/gpu/panfrost.rst
+F:	drivers/gpu/drm/ci/xfails/panfrost*
 F:	drivers/gpu/drm/panfrost/
 F:	include/uapi/drm/panfrost_drm.h
 
-- 
2.40.1


