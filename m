Return-Path: <linux-kernel+bounces-58697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE0B84EA15
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FAB1F2B42B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686DD4F211;
	Thu,  8 Feb 2024 21:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="J61Jenx/"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374B94C3C6
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707426373; cv=none; b=t06I85ONtwIg1PjTMv8yJnDMUniWsycgnpkQ7CIHO2qk7hQoTwaZGjsTZZpBwgFCDWhq8KT0JmiFqGKICn/muMEt8/JYUUi5fOfd9naxab8ZKDKqGnIpH23HwnXhtqnfKMDcXFBdxGf4olBWPZyWW5KRkxYvmqceYOmrJO0IjhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707426373; c=relaxed/simple;
	bh=y80heCwbhAQqqtJAfYk/nrQDwtR1qybFYBcIOVhCOMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JGaW/D34mWl26ScK+avBQ0w6/g0yCLtbug23VW5OkjuN4BSzVa58QXHvVbBaS7gxMaNK/1uMzIuXAYjR5QURUWyq6spXUnvS7HRSJVL1tLRst8Er0LElVS3UELAQxxY/GrkS8d+KHWRn7EAEiRJ+X+L32d7wSuxyqYHFNa4tFVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=J61Jenx/; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=yRF44PAwuObJjETXmhstoHPr/yI6S4jcqxgx+14ydL0=; b=J61Jenx/HaJYWYqd/VGI/U5XXh
	5tMpKP4qZHsUksJhROrMMPNBUbz3Usk08vFTccJIUnbR60OuXjjwR2kZBYw/Ef3Fub8zGvV26dl12
	gVu5GM+vv1Kavx3MYD3ieYb/3MOhMvfIU4rJS8gL9Jm0Mvj3XWR0VjFfUWhMybgL/smWHnRyQenk5
	anlb+6wQNeGtEyNk91yEdt6MpbG6NdQ8gAqtaNgcfTb/EdH7jc2SC2nrxxjfUrGTk/29VDON+zNYO
	ahkoCaDLKBlsYbqr4MWIqAz2HmYlu8LHtKGRiV9MQ5iqsdxiz1/NYKWis5vrDY8IJk52BZg5/vA0F
	op0SNmgg==;
Received: from [177.45.63.184] (helo=steammachine.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rYBax-00FMBk-3H; Thu, 08 Feb 2024 22:06:07 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: kernel-dev@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Simon Ser <contact@emersion.fr>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	daniel@ffwll.ch,
	Daniel Stone <daniel@fooishbar.org>,
	=?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
	Dave Airlie <airlied@gmail.com>,
	ville.syrjala@linux.intel.com,
	Xaver Hugl <xaver.hugl@gmail.com>,
	Joshua Ashton <joshua@froggi.es>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v4 3/3] drm/amdgpu: Make it possible to async flip overlay planes
Date: Thu,  8 Feb 2024 18:05:42 -0300
Message-ID: <20240208210542.550626-4-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208210542.550626-1-andrealmeid@igalia.com>
References: <20240208210542.550626-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

amdgpu can handle async flips on overlay planes, so mark it as true
during the plane initialization.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
v4: new patch

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 8a4c40b4c27e..dc5392c08a87 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1708,6 +1708,7 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 	} else if (plane->type == DRM_PLANE_TYPE_OVERLAY) {
 		unsigned int zpos = 1 + drm_plane_index(plane);
 		drm_plane_create_zpos_property(plane, zpos, 1, 254);
+		plane->async_flip = true;
 	} else if (plane->type == DRM_PLANE_TYPE_CURSOR) {
 		drm_plane_create_zpos_immutable_property(plane, 255);
 	}
-- 
2.43.0


