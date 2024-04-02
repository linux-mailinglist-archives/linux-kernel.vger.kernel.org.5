Return-Path: <linux-kernel+bounces-128801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71846895FBD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12AA31F25546
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64644F602;
	Tue,  2 Apr 2024 22:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="R2Mv59eh"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5394207D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712097831; cv=none; b=Z3eCsQ8zUayUXYvMbvelASNh1ZDpcsXpEJ4eOCbt55oUpIPkupoPXr/kI+9s86uZ4KfPiJkJB2UpQNYDzG3I9zQ8mcJ7+W8gStPOR/p+anW7eQGxkCHWraSvVpvB9U6RM80Mv+jXGg5UMeOD7mwQbiXIy25ILetsd//l6abbeBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712097831; c=relaxed/simple;
	bh=XIFJFDCnMih7GLxIKrMXNc/ZOU0eJjY9LF1DqMUOk2Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=og/cLjJ1jTC10QvxhI6B7C56wpG4vjJqa5T43cb1KSjHW2aBNnw3R4F6kAsVvufqzVfIOaQevQQ16Sf9sYiUmIXi79YgyszL3OD3BYs90uDlrmvuHwMqJEqO6qmL2z4tUeqAEBUctLpKzgEJPhlLp4U5O+HX4I6k2m0v4p3bDj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=R2Mv59eh; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1712097821; x=1712357021;
	bh=F0SQdHHWp6QcFExmIqpo0ogahH8H5BOigMCQ40qcicw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=R2Mv59ehoIyH/WQrnuI8OI18xL8joPaY08/tXAePLDtkmo8Rkyj8LrPH7TazRoRBw
	 cUEf1fc78ZcGBp1Z557S1L4JP44fUn3PuoOV8nB4k+6uLLOm+pa6MfYtndIapCgTus
	 waJou+wgPiA91UA9p0W6ECX7qzkBAuTjLYuoYj8cdvk4/QgXgl6qZZTg3mKkH6upRA
	 iH5g87hHwL0AehQRx+IOtuc/n6pWKD8sVIm4UtNMRM2XQbnDSdesijK9ZPPFWtZpg3
	 VqyY45S9gCcW88LYjc7mT8+dhjrJTfaASwfXFI3ytvMuKGgzxQsieNLi5dQhIaZVL2
	 q3Cb7x7IrPycQ==
Date: Tue, 02 Apr 2024 22:43:34 +0000
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From: Nicolas Devos <ndevos-dev@pm.me>
Cc: Nicolas Devos <ndevos-dev@pm.me>
Subject: [PATCH 1/4] gpu/drm: Add SPDX-license-Identifier tag
Message-ID: <20240402224320.12146-2-ndevos-dev@pm.me>
In-Reply-To: <20240402224320.12146-1-ndevos-dev@pm.me>
References: <20240402224320.12146-1-ndevos-dev@pm.me>
Feedback-ID: 76711691:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This commit fixes following checkpatch warning:
WARNING: Missing or malformed SPDX-License-Identifier tag

Signed-off-by: Nicolas Devos <ndevos-dev@pm.me>
---
 drivers/gpu/drm/drm_connector.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connecto=
r.c
index b0516505f7ae..40350256b1f6 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
 /*
  * Copyright (c) 2016 Intel Corporation
  *
--=20
2.42.0



