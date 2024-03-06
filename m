Return-Path: <linux-kernel+bounces-94534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F29EF87411D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228881C23EDA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C3A1448F8;
	Wed,  6 Mar 2024 20:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="sxaH4jB+"
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF0414403F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755444; cv=none; b=GHEGrwLWN6kOo50oIxJCja6Ne6TfkegJnXkNtnbnzGG5jFLr7AEoVl9N/sKWikXang+ufrXBmnRhFNy9dUuFEEUMGPpIn7238LO9T6ef3Qs1mYBGcSUme3sISE6wknz1h0KyyPYwblRQ4zpLWyNP1I629kCW+AlSybj4jtHG12I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755444; c=relaxed/simple;
	bh=yXbuN+CoZuGbUAgSQaHGYWiyhuige5NUNnLWq/soBQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GjH1Lj+ZAGbABeVXc+bhX6rZYRXG7BzVeGm170z5ep9hekMS5UGWe17rpDNC3HxlJzXdk24HntvGHtL+CjgppJq+y+u8kNRUjWiqHwVszRFHgY+ZqFuFBODD+EUQhWX1vYjhKDZ/z16Bdra/fG43sQgDNoDGf9F5oPHcgUZu2Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=sxaH4jB+; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4Tqk0K6DYWz9wLd;
	Wed,  6 Mar 2024 20:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1709755442; bh=yXbuN+CoZuGbUAgSQaHGYWiyhuige5NUNnLWq/soBQM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sxaH4jB+I12ibLBpFeegaJT5HHbr9J8j1ezVHJuBPLXC0BVfhqvbjVfBxb7b+6JCI
	 RF+vx+UTTLk3b4s5BI5Cgwr8C4mYoO4uDa7hqYuCbn5M1k0l3wstsYoi8P4YgWHp8U
	 nRXk71dhMWSTZSUIgsT3Kya+Z+5R8JgDdDarHqyQ=
X-Riseup-User-ID: 8880DFCE1D029D93798CB6476356726EB753FBDD344B564393D9FDDA451E06DC
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4Tqk0D2vmCzFvsZ;
	Wed,  6 Mar 2024 20:03:56 +0000 (UTC)
From: Arthur Grillo <arthurgrillo@riseup.net>
Date: Wed, 06 Mar 2024 17:03:13 -0300
Subject: [PATCH 6/7] drm/vkms: Change the gray RGB representation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-louis-vkms-conv-v1-6-5bfe7d129fdd@riseup.net>
References: <20240306-louis-vkms-conv-v1-0-5bfe7d129fdd@riseup.net>
In-Reply-To: <20240306-louis-vkms-conv-v1-0-5bfe7d129fdd@riseup.net>
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
 nicolejadeyee@google.com

Using the drm_fixed calls, this needs to be changed. Which in fact is
more correct, colour.YCbCr_to_RGB() gives 0x8080 for same the yuv
parameters.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
---
 drivers/gpu/drm/vkms/tests/vkms_format_test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
index 66cdd83c3d25..49125cf76eb5 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_format_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
@@ -48,7 +48,7 @@ static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[] = {
 		.n_colors = 6,
 		.colors = {
 			{"white", {0xff, 0x80, 0x80}, {0xffff, 0xffff, 0xffff, 0xffff}},
-			{"gray",  {0x80, 0x80, 0x80}, {0xffff, 0x8000, 0x8000, 0x8000}},
+			{"gray",  {0x80, 0x80, 0x80}, {0xffff, 0x8080, 0x8080, 0x8080}},
 			{"black", {0x00, 0x80, 0x80}, {0xffff, 0x0000, 0x0000, 0x0000}},
 			{"red",   {0x4c, 0x55, 0xff}, {0xffff, 0xffff, 0x0000, 0x0000}},
 			{"green", {0x96, 0x2c, 0x15}, {0xffff, 0x0000, 0xffff, 0x0000}},
@@ -71,7 +71,7 @@ static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[] = {
 		.n_colors = 6,
 		.colors = {
 			{"white", {0xeb, 0x80, 0x80}, {0xffff, 0xffff, 0xffff, 0xffff}},
-			{"gray",  {0x7e, 0x80, 0x80}, {0xffff, 0x8000, 0x8000, 0x8000}},
+			{"gray",  {0x7e, 0x80, 0x80}, {0xffff, 0x8080, 0x8080, 0x8080}},
 			{"black", {0x10, 0x80, 0x80}, {0xffff, 0x0000, 0x0000, 0x0000}},
 			{"red",   {0x51, 0x5a, 0xf0}, {0xffff, 0xffff, 0x0000, 0x0000}},
 			{"green", {0x91, 0x36, 0x22}, {0xffff, 0x0000, 0xffff, 0x0000}},
@@ -94,7 +94,7 @@ static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[] = {
 		.n_colors = 4,
 		.colors = {
 			{"white", {0xff, 0x80, 0x80}, {0xffff, 0xffff, 0xffff, 0xffff}},
-			{"gray",  {0x80, 0x80, 0x80}, {0xffff, 0x8000, 0x8000, 0x8000}},
+			{"gray",  {0x80, 0x80, 0x80}, {0xffff, 0x8080, 0x8080, 0x8080}},
 			{"black", {0x00, 0x80, 0x80}, {0xffff, 0x0000, 0x0000, 0x0000}},
 			{"red",   {0x36, 0x63, 0xff}, {0xffff, 0xffff, 0x0000, 0x0000}},
 			{"green", {0xb6, 0x1e, 0x0c}, {0xffff, 0x0000, 0xffff, 0x0000}},
@@ -117,7 +117,7 @@ static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[] = {
 		.n_colors = 4,
 		.colors = {
 			{"white", {0xeb, 0x80, 0x80}, {0xffff, 0xffff, 0xffff, 0xffff}},
-			{"gray",  {0x7e, 0x80, 0x80}, {0xffff, 0x8000, 0x8000, 0x8000}},
+			{"gray",  {0x7e, 0x80, 0x80}, {0xffff, 0x8080, 0x8080, 0x8080}},
 			{"black", {0x10, 0x80, 0x80}, {0xffff, 0x0000, 0x0000, 0x0000}},
 			{"red",   {0x3f, 0x66, 0xf0}, {0xffff, 0xffff, 0x0000, 0x0000}},
 			{"green", {0xad, 0x2a, 0x1a}, {0xffff, 0x0000, 0xffff, 0x0000}},
@@ -140,7 +140,7 @@ static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[] = {
 		.n_colors = 4,
 		.colors = {
 			{"white", {0xff, 0x80, 0x80}, {0xffff, 0xffff, 0xffff, 0xffff}},
-			{"gray",  {0x80, 0x80, 0x80}, {0xffff, 0x8000, 0x8000, 0x8000}},
+			{"gray",  {0x80, 0x80, 0x80}, {0xffff, 0x8080, 0x8080, 0x8080}},
 			{"black", {0x00, 0x80, 0x80}, {0xffff, 0x0000, 0x0000, 0x0000}},
 			{"red",   {0x43, 0x5c, 0xff}, {0xffff, 0xffff, 0x0000, 0x0000}},
 			{"green", {0xad, 0x24, 0x0b}, {0xffff, 0x0000, 0xffff, 0x0000}},
@@ -163,7 +163,7 @@ static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[] = {
 		.n_colors = 4,
 		.colors = {
 			{"white", {0xeb, 0x80, 0x80}, {0xffff, 0xffff, 0xffff, 0xffff}},
-			{"gray",  {0x7e, 0x80, 0x80}, {0xffff, 0x8000, 0x8000, 0x8000}},
+			{"gray",  {0x7e, 0x80, 0x80}, {0xffff, 0x8080, 0x8080, 0x8080}},
 			{"black", {0x10, 0x80, 0x80}, {0xffff, 0x0000, 0x0000, 0x0000}},
 			{"red",   {0x4a, 0x61, 0xf0}, {0xffff, 0xffff, 0x0000, 0x0000}},
 			{"green", {0xa4, 0x2f, 0x19}, {0xffff, 0x0000, 0xffff, 0x0000}},

-- 
2.43.0


