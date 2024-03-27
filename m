Return-Path: <linux-kernel+bounces-121744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4A888ED4E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57831B244A7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72401509B0;
	Wed, 27 Mar 2024 17:47:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8EE14EC68;
	Wed, 27 Mar 2024 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561641; cv=none; b=bWnCqO2nza4EiIU0d/XmS+9qk/7FI4PKB7jKofR2GjG68BXaOUtXN29N3Y75K/OF/2DgZw0dRbZGJBjH2regGd9j/222v0xhvF4uyoRUym+6AfZX2GJS5czMIjy2mRdv9cQrPgVzaJKoc8+DSZ9CXE4JnNuQNrpa+DsA27nTKi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561641; c=relaxed/simple;
	bh=+W4DNFs358mk2D6gSk1lk59MLplYtBcTu0rcooJlTpE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DFVOUCnBM+v3G+y9CPOWxQSqvqluU2VssymfFhKDxGD9EDdnOiNM4BGkXkv70fmOVltUS2jBQKyOUK5VE1HjUGmcLL/0gnhIdjYXMh7cxJJkShgvKIWoAmXGKUFhSocgPVAyO/RaCWXQ8ri/qbUxviPts3VZ9+/wBc2RSaLXzgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31ECDC43390;
	Wed, 27 Mar 2024 17:47:17 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] video: backlight: otm3225a: drop driver owner assignment
Date: Wed, 27 Mar 2024 18:47:14 +0100
Message-Id: <20240327174714.519577-1-krzysztof.kozlowski@linaro.org>
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
 drivers/video/backlight/otm3225a.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/backlight/otm3225a.c b/drivers/video/backlight/otm3225a.c
index 2472e2167aae..4568020abf3c 100644
--- a/drivers/video/backlight/otm3225a.c
+++ b/drivers/video/backlight/otm3225a.c
@@ -239,7 +239,6 @@ static int otm3225a_probe(struct spi_device *spi)
 static struct spi_driver otm3225a_driver = {
 	.driver = {
 		.name = "otm3225a",
-		.owner = THIS_MODULE,
 	},
 	.probe = otm3225a_probe,
 };
-- 
2.34.1


