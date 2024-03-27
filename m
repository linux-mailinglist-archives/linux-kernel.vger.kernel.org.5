Return-Path: <linux-kernel+bounces-121754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324F388ED43
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62CF01C32373
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B89152193;
	Wed, 27 Mar 2024 17:48:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A61B14E2CD
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561730; cv=none; b=hNMkvc7hLsS7VJgm/ErWMvFjCo55HBDZjEsPPty5LYMkosSmFRLC66CQ8OGa0YiSsmyIRqIn4ZDfYzJ2WN7opl1tf7UAJJ4Mg2i2wbNFraCiPPI7mgzYOw8IJ7AtJ8WtG1MWZtCBK5gLq1D/R7KPGAgJNFTLSfZiXHqm0wAQb5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561730; c=relaxed/simple;
	bh=gFADQVy69syMwzNL+JMhqNmW0BvcG9lVZG78YQ1xYoo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hhPFRriekYJuN+fytw+5b3RMMeP6TaQl6csGup50PWtN1axxFd7ggXxm9YUzY9jNuuI+v32YfV0ZmgpBgW1zaidiktdGQdZ3wZO/p34ufj7X5HJVoZ5sdjpMzV1a8APqJsJoieM2zy7SyFdlwT58iwlh7M7PtQyn2UMTMetlmfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157ACC433C7;
	Wed, 27 Mar 2024 17:48:46 +0000 (UTC)
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
Subject: [PATCH 1/4] drm/tiny: ili9225: drop driver owner assignment
Date: Wed, 27 Mar 2024 18:48:39 +0100
Message-Id: <20240327174842.519758-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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
 drivers/gpu/drm/tiny/ili9225.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/ili9225.c b/drivers/gpu/drm/tiny/ili9225.c
index dd8b0a181be9..eb1213352bce 100644
--- a/drivers/gpu/drm/tiny/ili9225.c
+++ b/drivers/gpu/drm/tiny/ili9225.c
@@ -447,7 +447,6 @@ static void ili9225_shutdown(struct spi_device *spi)
 static struct spi_driver ili9225_spi_driver = {
 	.driver = {
 		.name = "ili9225",
-		.owner = THIS_MODULE,
 		.of_match_table = ili9225_of_match,
 	},
 	.id_table = ili9225_id,
-- 
2.34.1


