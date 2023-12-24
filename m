Return-Path: <linux-kernel+bounces-10693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD15481D8DF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 12:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA961F21894
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 11:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C955382;
	Sun, 24 Dec 2023 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aYixHiYJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3290A23C8
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2340c803c6so364098066b.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 03:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703418560; x=1704023360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mzCr6s+sUXGJX1TCqlhYC9rStKOi8VqlAp3Rk3HIOR0=;
        b=aYixHiYJQ4MJKLPry86OaWhN8UifopydlOUmHLtWUrO7gEt0qfhNaOZaGhTqRxtyd4
         jhEg9fdcEx57VGMg6YGMpO0tJEseNgjA9jCKXc5B8V9zPIfEthIdN3yY5oAeeww/8sTJ
         011JU3WB2V00wWCevTQeqIt11D5/SntmO4dqB5u8ZIhZhEUnNH1g//LAohD3nhWRuCF8
         AfcKM7p/Z+/+p/p3oQaAin6XB26xf7YPuSpc/Sj8Lz7Ef13n10naOZXyT5g8JL3RCSac
         ne0DhpFYEtQlUR9NDPg6u44NG+Qi2Ui6beg7jfOQ/oOG4COURdO6kquTF/74TxQTnGOt
         5JIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703418560; x=1704023360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mzCr6s+sUXGJX1TCqlhYC9rStKOi8VqlAp3Rk3HIOR0=;
        b=aJXyc6QwyJl2WN/prqfJkU+bHt93a/2TYwYb17U+xg+McYdY5NYCHLrdGo0SrLvWVT
         n23989RuJyEAbYGYUkj5tQEbcDdSVcadKgTA5R4Ujt8oj9JMi/R8LJx8LGTYPcF+l4MH
         SQC491ZRDxHA7lZ+Y4jmFHHQHYAosPKpx+vFuCjGNuCq7QrHPFGD3k7TlTU/s7TFYEss
         AbO+l/faO4EKmgcsf/rSwVAaBf64hhE/cqy7UysUKXEggZF1UZ2yvsYOfXppRfTyopUv
         nmOubgVqOgpaUpUsQCRmT9WIVLqeLbNdrPevfLWLW2dMqoYXouLlPg/RVSk+jQ7Nrbeb
         01ow==
X-Gm-Message-State: AOJu0Yy0FchxzxjMXgagUP62CaBU9PbG6aAqLdk6Agz3YHdwtjcgZbIJ
	0IabFtzAWNl/jrJXLvNXQbiu4lcD3cpzEg==
X-Google-Smtp-Source: AGHT+IGM0Y5645Zu1dPEnmVTVdZQEYcTnX/kb5UWJ1OjgBXkx1ByEUy4wQqaFm7kp+mEJGJUiKU+5Q==
X-Received: by 2002:a50:d49b:0:b0:552:85f4:ed39 with SMTP id s27-20020a50d49b000000b0055285f4ed39mr2643458edi.38.1703418559839;
        Sun, 24 Dec 2023 03:49:19 -0800 (PST)
Received: from krzk-bin.. ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id z23-20020aa7c657000000b0054ccac03945sm4999771edr.12.2023.12.24.03.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 03:49:19 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] media: fimc-lite: drop unused flite_hw_set_camera_polarity()
Date: Sun, 24 Dec 2023 12:49:05 +0100
Message-Id: <20231224114916.111433-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Function flite_hw_set_camera_polarity() is not defined, so drop its
declaration from the header.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/platform/samsung/exynos4-is/fimc-lite-reg.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-lite-reg.h b/drivers/media/platform/samsung/exynos4-is/fimc-lite-reg.h
index c5656e902750..3b8af3ce1838 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-lite-reg.h
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-lite-reg.h
@@ -134,8 +134,6 @@ void flite_hw_capture_start(struct fimc_lite *dev);
 void flite_hw_capture_stop(struct fimc_lite *dev);
 void flite_hw_set_camera_bus(struct fimc_lite *dev,
 			     struct fimc_source_info *s_info);
-void flite_hw_set_camera_polarity(struct fimc_lite *dev,
-				  struct fimc_source_info *cam);
 void flite_hw_set_window_offset(struct fimc_lite *dev, struct flite_frame *f);
 void flite_hw_set_source_format(struct fimc_lite *dev, struct flite_frame *f);
 
-- 
2.34.1


