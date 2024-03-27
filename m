Return-Path: <linux-kernel+bounces-121757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D3D88ED47
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AA221F32EFA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06507155744;
	Wed, 27 Mar 2024 17:49:03 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BCE14F11E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 17:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561742; cv=none; b=lAYo4K6eMnPMWzgR2Rt1lv4Aoezw+1K5oyZh7AI284+/y8iwmFDDpw4r4KkucuHUE5DkUswxEdW7TQu/tYCVrilJ8iccNNSuwRqhoq3se5D41/sLfbPaczX4QkDA/C2hG6DGywHVMPg2alE9lf9AdRVPPBzypAyBMie/uChYsao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561742; c=relaxed/simple;
	bh=aI0fgGFWwSvGDEoc3r2vvepfyN05vjH/RcpefbQoeVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=isHnyHR0A3VuU9DjgmpWRpgt3NYtalsHPkCD6XuR4rt/iUhzlL93E2YlhNCAMIR4O1yo7jtuAHplJeV1FG1xZFYOeyMJyQeXd7KLjzsTd1cOdhWIWfyE+kUR9y2udNUqjxAmHeEojOmPBjx/poOb/cz8ZM8piRJXT5dpAwVJX6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9F5C433F1;
	Wed, 27 Mar 2024 17:48:58 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: David Lechner <david@lechnology.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	=?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] drm/tiny: st7586: drop driver owner assignment
Date: Wed, 27 Mar 2024 18:48:42 +0100
Message-Id: <20240327174842.519758-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327174842.519758-1-krzysztof.kozlowski@linaro.org>
References: <20240327174842.519758-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in spi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/tiny/st7586.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/st7586.c b/drivers/gpu/drm/tiny/st7586.c
index 7336fa1ddaed..c4ad8340180e 100644
--- a/drivers/gpu/drm/tiny/st7586.c
+++ b/drivers/gpu/drm/tiny/st7586.c
@@ -392,7 +392,6 @@ static void st7586_shutdown(struct spi_device *spi)
 static struct spi_driver st7586_spi_driver = {
 	.driver = {
 		.name = "st7586",
-		.owner = THIS_MODULE,
 		.of_match_table = st7586_of_match,
 	},
 	.id_table = st7586_id,
-- 
2.34.1


