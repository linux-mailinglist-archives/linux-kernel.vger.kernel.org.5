Return-Path: <linux-kernel+bounces-136616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71E789D631
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61B8E28423B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A7C80BF0;
	Tue,  9 Apr 2024 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l5kE49th"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9267F482
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657083; cv=none; b=LEHwxG68kFzXeg4t4O9vDBifE+bhvhWTCStKRt+sZ1cg2RTS//kozDShYpYtXsZQe6yDTkS8rMtr/zGhOBzAVr33zP8kJ6OeICJHWIJDt1sfVEYixIwtBFn7Wo2b5Gy4AVLA25Ehmxuqt5z6swFJlIxBqzHt67s24ep2Y9q6XQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657083; c=relaxed/simple;
	bh=A9Ti38Ukw9P6xGFh6Uafw+LqnapiDQLHjycZFMYCGjA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QMvM/eUl/hIjLcUUv8lMAA6mszETaMakQu8gZ/WIY0Ogc9uP4ayk7wJR8r9WyWX9u2Gg+0KwCLi9uT3G6TLZn4aCKIt28ps/O/7krWAq5+uGpMVZlApVVgo6TJfMA+tFsLwTTdG0MbzxL5pZB9RePdUWaFBHsBBIAU32ZNSuReo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l5kE49th; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D1ABDC0004;
	Tue,  9 Apr 2024 10:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712657079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P5KyQ86XhO4c/3+mfHw2niwhZfwjRkHxeV4U9txDECY=;
	b=l5kE49thnJ8IPQ9eWvCMMsRjMF9ggPVbo6CBNh53YyJnE4ecYuDpWb5yyF99Ym0dB81bwL
	YSpnD5hID1Xau2EC3Fus4/nK9U297/2DBbeP3kvNh2W5uJjA3cr6qAcUsYdc4XZaraHVD6
	A1q0H/42dGCyyjaA93fHCEZVEbYi+U4tRIsblYjAYqG/SxfEXuyqtOi2/tu2D+a7ld+FSh
	hndlFXKRruIDuyGFux31Ro4R+dOZQgWt2jjeeKaMxt61bNYcFs6zfX4003+PcdanUHj2w8
	RXzPOT/kHHObPlPdXSFGp0F98JfLCW0U2DfcCDQWx+1No5W/Trot5WPQP+4XoA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: [PATCH 0/3] drm: Multiple documentation update
Date: Tue, 09 Apr 2024 12:04:04 +0200
Message-Id: <20240409-google-drm-doc-v1-0-033d55cc8250@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJQSFWYC/x3MQQqAIBBA0avErBvIqZC6SrQIHW2gNBQikO6et
 HyL/wtkTsIZ5qZA4luyxFCh2gbMvgXPKLYaqKOh60mjj9EfjDadaKNBY0mPNCk9kYMaXYmdPP9
 wWd/3A+ZwsedgAAAA
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com, 
 pekka.paalanen@collabora.com, thomas.petazzoni@bootlin.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1518;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=A9Ti38Ukw9P6xGFh6Uafw+LqnapiDQLHjycZFMYCGjA=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmFRK0BYQm4E+T5uIr0+BUqoaEiKB4cnuyp07Zw
 lslOHYVuLyJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZhUStAAKCRAgrS7GWxAs
 4h+QEADAbw1aGPIH/ZJAe6VyK24l2kQqCVjGqekjvcqxAGDaoI+Wum4ONRdb4VJ/94X8qdDGlCn
 GZmHFLpNBSVsgsNAI+5BYLjJI6I3u72OZAPGWN7X+H6ND7PrjHmGhN8+RRmG6oTelIxlv6CjhZz
 jP6a0zIyuMK44VKHDL4x/6dxSpboEwjtTqAEhz5VZ9awic7yf2L6maFgZZHfLnaz5ECwfyX9cy0
 tQmHIsA1+5yJbJzB7UVM9NXJzL0aLMxLtkC/Ya7u1urAp8uWOTtn6sD9rYWn0UtcM5I1STQLaiX
 hB5TnOaN5YYXA0VGW+/zSIDHdmG3qWvh3VtgU7+DKlEarKkxBH+IDKWDgJre6gcLWOqoppskW4V
 TRnDKXGcnwB7FW9H+m1OcZ0MIqt9GJeGc0AtB58IQCoyxj2720BFalKyzzVY0UX2X2B0vcPjXnT
 QrNCjfGCKtvpu8NSGpTYNiFjgQ3l37KHxvIL7SnZiPvFWO9d9oqy8ZP8E24h5VmbtMuNtR+F+5A
 StQXcdhzywdoHy2cq1Wj/4mvGWrxRUPjLFKsis6/a8+ktx7FRncFRxQ3AZxrb5irDTJszU2Y7F7
 ea4YR1UDUZbBm/sNvkTmpME0kl00fGX5WLnzpAdkkY84zrE2nQzeVP2X0us9WXZTEHju7JUZsY1
 WDtLWbeAys9vHBw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

PATCH 1 and PATCH 2 focus on the rotation property. The rotation property 
can be challenging to understand, especially when it is combined with 
reflections. These patches aim to provide clearer explanations and 
examples to aid in comprehension.

Patch 3 relates to the fourcc property. It includes additional details 
about block and char_per_block to provide a more comprehensive 
understanding of this feature.

Regarding PATCH 1, I would appreciate some feedback on the expected 
behavior. During a recent VKMS refactor, I used drm_rect_rotate as a 
reference for the rotation. However, during my testing phase, I noticed 
that the original VKMS implementation interpreted the rotation 
differently. Therefore, I kindly request that someone validate or 
invalidate my interpretation before proceeding with the merge.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
Louis Chauvet (3):
      drm: drm_blend.c: Add precision in drm_rotation_simplify kernel doc
      drm: drm_blend.c: Improve drm_plane_create_rotation_property kernel doc
      drm/fourcc: Add documentation around drm_format_info

 drivers/gpu/drm/drm_blend.c | 57 ++++++++++++++++++++++++++++++++++-----------
 include/drm/drm_fourcc.h    | 45 +++++++++++++++++++++++++++++------
 2 files changed, 81 insertions(+), 21 deletions(-)
---
base-commit: e495e523b888a6155f82c767d34c8d712a41ee54
change-id: 20240327-google-drm-doc-cd275291792f

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


