Return-Path: <linux-kernel+bounces-20071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6988278F2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AFDB2838B6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9800A55E4B;
	Mon,  8 Jan 2024 20:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fSgBxzVA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0D555C30
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-204301f2934so1807876fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 12:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704744429; x=1705349229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a0ZAlEBjGplq0TA4rGOIY+Fm8QMufuog3/zNcBtCWCI=;
        b=fSgBxzVA4vq96FX+88exQkx5hJryrSG7uFche4O7prAgEzLQHz+GlgM4U+N2iJj2U+
         rMf9pnDqszKcv8dq2s6uWLV9QyjUiwQCyyymOr8bnS7YHmO7U62GPju18wVy5m0ZJbE/
         0uVmKzoHBfKDIhPOJnDEgx7azjsAxAZmqi+5w+IZ+MbCfC/2pvqwa3povvcd/Z5oWykA
         R7dW2Z1VSN3e8fyB15RBZF5OV1GR4ERaoP+znBdChCDSva3npLKENZbw/dXVGQDsnpGa
         p+IoeWP7uVRNiLpWamFivdi3j9rnPD73GUlmteZ6/qEbfJArj+rIYVIH6UO1Q1AFnmr8
         2f+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704744429; x=1705349229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0ZAlEBjGplq0TA4rGOIY+Fm8QMufuog3/zNcBtCWCI=;
        b=qU5GeDemZqDw1resm2pmyjkDXdt1yG530O+nmfGpz0CB05i2hLlRnBqtwR00Naci9z
         IQMV6jT98vWPMaHkszdr5Ve6ZrJqg0NXPg89NkAnyW+kHo+IsR2OrFLNAm0WMvKCCz6Z
         mt1Y/z7cnMZe5xkiNJJGIrysqoauSr4J5gCfqtuZytgy5CDuGGlNC/8egpMeVoWzAiaA
         bvHEmo+vID4CAd9HWf7KFELtRDu6wIt/4NNJZFvD4zXeIqcE+lkvO5aq54zlpqER1vSo
         j9tYYVZBLsI5LEPD97FXfvjBxdNpy/Ce94dPeGMzkRGT1r5HCAq06n1m/CmZGohwBYpr
         LZAA==
X-Gm-Message-State: AOJu0YyfFKFI2XRPHVRpOZia+uhyKNQr9suRdTbmqbZbH1cuFrqIX3wc
	NTsNJD5dGESCxTdL3mI2n4SEUV8I+PsnWQ==
X-Google-Smtp-Source: AGHT+IFRf9wPQBcL+YChPl9qGlJTPQwrSBs87PEmn2B68yZaTNOlcnjG9lNRoF4WnjWBlFf7r1Vf1g==
X-Received: by 2002:a05:6870:ac8f:b0:204:44a9:a342 with SMTP id ns15-20020a056870ac8f00b0020444a9a342mr5712141oab.32.1704744429373;
        Mon, 08 Jan 2024 12:07:09 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id d14-20020a056830138e00b006dc0f1f0b34sm101468otq.18.2024.01.08.12.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 12:07:08 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: core: use INDIO_ALL_BUFFER_MODES in iio_buffer_enabled()
Date: Mon,  8 Jan 2024 14:06:44 -0600
Message-ID: <20240108200647.3916681-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This replaces use of individual buffer mode flags with
INDIO_ALL_BUFFER_MODES in the iio_buffer_enabled() function.

This simplifies the code and makes it robust in case of the addition of
new buffer modes.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/industrialio-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index c77745b594bd..8855d377d710 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -210,9 +210,7 @@ bool iio_buffer_enabled(struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 
-	return iio_dev_opaque->currentmode &
-	       (INDIO_BUFFER_HARDWARE | INDIO_BUFFER_SOFTWARE |
-		INDIO_BUFFER_TRIGGERED);
+	return iio_dev_opaque->currentmode & INDIO_ALL_BUFFER_MODES;
 }
 EXPORT_SYMBOL_GPL(iio_buffer_enabled);
 
-- 
2.43.0


