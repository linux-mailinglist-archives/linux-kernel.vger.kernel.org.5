Return-Path: <linux-kernel+bounces-10703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E491F81D8FD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 12:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76636B217C3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 11:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F0514F6D;
	Sun, 24 Dec 2023 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hx4/6cTm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333EE11190
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-554909ac877so815057a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 03:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703418572; x=1704023372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CrVT5u4n/IC0zfDww/SiIGFgrbay7ubnhd7vT2k8No=;
        b=hx4/6cTmyZe28lsSxcGeRVDo28RRvxBkiIMKTesJFb9KqgBQd16ericwRXpTPPTRQZ
         R1kGcRhUbAine9rQ5GvSWPhMUPFupt8yRUhcD48WScVTnq21tQmMte8TQenXkgnabE/e
         4EUMZbPXL79Gv4KqB7PmnWhUKnoMjYqynURA3Ahf0mW3BRGUpBUgwTUMC1vVUXYSm5gl
         w7fjnfmgBVdCY588/v7nKR9zZRFJk9C98nNOVsBQMobWA6ADj+j3buqTEWUSoHatFSgL
         BpZMCGo7cdNXBoY4Nu+YXOug8XwVOVuqPIfFlGZwllMRg3RwJ1UzXmIGoLvPIA6aRjmP
         9ILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703418572; x=1704023372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CrVT5u4n/IC0zfDww/SiIGFgrbay7ubnhd7vT2k8No=;
        b=cWWJDlWBxufdFCfZKUBvlKKaiNZR0Ev0eevlQQqwAJO/jkx84Ie+N1M1rXVOlaw0ew
         ei1PO89pG6RWnciuHHI8khvJ0ny3QWcy+5Rl2bxyf/2gnicruzW0AWajwRn8ZWrNZZl8
         DfCDOP//c/PzLxK+31fKXF1PhSUB1Dzy/V4lWh3piPeAKbPOEV05WFK8eCwlTMrVDrry
         BJzA08NLsfeWmhdWhBTsKWDH91/SV51bXY6XZNnur+/oEiHj7JgT0vJ9l8qqRqNmxzw6
         Kk/IjQInYxktI6RN/dZXFHLac9Y3apPU7GMHz+MfAhAj756UiHc3ICjACdCFmbyU/WxF
         G40A==
X-Gm-Message-State: AOJu0YzbMutjtKRI2EUlh5EhLmODwat1rbyuXqoJwfG2+ktqBgERc9ht
	XvbWj3nytNo97ir4qIERKqYBF8FNFksjMQ==
X-Google-Smtp-Source: AGHT+IHDghY2YF04IGnVIvlWdChgrgXx922/zpgzFWBd6w3LhebOaWYsGls08rqqyjHx6kRIsMASFA==
X-Received: by 2002:a50:d00a:0:b0:554:7b04:f889 with SMTP id j10-20020a50d00a000000b005547b04f889mr1861601edf.18.1703418572580;
        Sun, 24 Dec 2023 03:49:32 -0800 (PST)
Received: from krzk-bin.. ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id z23-20020aa7c657000000b0054ccac03945sm4999771edr.12.2023.12.24.03.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 03:49:32 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] media: fimc-is: constify local pointers to fimc_vid_cap
Date: Sun, 24 Dec 2023 12:49:15 +0100
Message-Id: <20231224114916.111433-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231224114916.111433-1-krzysztof.kozlowski@linaro.org>
References: <20231224114916.111433-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Constify the local variables pointing to "struct fimc_vid_cap" to
annotate the function is not modifying pointed data.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/platform/samsung/exynos4-is/fimc-reg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-reg.c b/drivers/media/platform/samsung/exynos4-is/fimc-reg.c
index 0ed6e22e6c47..edff6e5179cf 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-reg.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-reg.c
@@ -598,7 +598,7 @@ static const struct mbus_pixfmt_desc pix_desc[] = {
 int fimc_hw_set_camera_source(struct fimc_dev *fimc,
 			      struct fimc_source_info *source)
 {
-	struct fimc_vid_cap *vc = &fimc->vid_cap;
+	const struct fimc_vid_cap *vc = &fimc->vid_cap;
 	struct fimc_frame *f = &vc->ctx->s_frame;
 	u32 bus_width, cfg = 0;
 	int i;
@@ -670,7 +670,7 @@ void fimc_hw_set_camera_offset(struct fimc_dev *fimc, const struct fimc_frame *f
 int fimc_hw_set_camera_type(struct fimc_dev *fimc,
 			    const struct fimc_source_info *source)
 {
-	struct fimc_vid_cap *vid_cap = &fimc->vid_cap;
+	const struct fimc_vid_cap *vid_cap = &fimc->vid_cap;
 	u32 csis_data_alignment = 32;
 	u32 cfg, tmp;
 
-- 
2.34.1


