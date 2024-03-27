Return-Path: <linux-kernel+bounces-121755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9303C88ED45
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFB31F32FFE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC9514E2CD;
	Wed, 27 Mar 2024 17:48:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56FB152513
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561734; cv=none; b=GDBybLpRLFwEpsi/Oj6xNzDLEkdGj5A4OUAWrgMNGTkq8ivLkPRHid9YJ4aqg8nzUiemgLPcxSzEa9j2QNbak5Ll+HznQGjjw/BOI4YoJsqemKYwapsbl3KWwsVokK1ey36Gtx6EjYGBc5udSo6gbMsglKoFxS+Pg8q2+Fk7zGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561734; c=relaxed/simple;
	bh=5VSCG4pMr6wJB3jMyBNb7McAs7ASQRlkyCPbTCTaKRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E/5AIdnTbMbLnEjAtUwZnvhcMtCNO75mz313MSYiJXehN6gm8NrVak7DaZrZL5pl1fTl4lrfk5p23lliFjrh1bhB7hA1t5IaPt6+/FCasbVG3K6yZxIAF/MRTIx/DYlZyj4nveMAci9+R+6LWDjQmfz+mLNQhJoS8LnarrpF0Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7A8C433F1;
	Wed, 27 Mar 2024 17:48:50 +0000 (UTC)
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
Subject: [PATCH 2/4] drm/tiny: mi0283qt: drop driver owner assignment
Date: Wed, 27 Mar 2024 18:48:40 +0100
Message-Id: <20240327174842.519758-2-krzysztof.kozlowski@linaro.org>
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
 drivers/gpu/drm/tiny/mi0283qt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/mi0283qt.c b/drivers/gpu/drm/tiny/mi0283qt.c
index 01ff43c8ac3f..05509e519518 100644
--- a/drivers/gpu/drm/tiny/mi0283qt.c
+++ b/drivers/gpu/drm/tiny/mi0283qt.c
@@ -263,7 +263,6 @@ static const struct dev_pm_ops mi0283qt_pm_ops = {
 static struct spi_driver mi0283qt_spi_driver = {
 	.driver = {
 		.name = "mi0283qt",
-		.owner = THIS_MODULE,
 		.of_match_table = mi0283qt_of_match,
 		.pm = &mi0283qt_pm_ops,
 	},
-- 
2.34.1


