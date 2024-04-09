Return-Path: <linux-kernel+bounces-137607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D56E89E492
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58EED283781
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96328158859;
	Tue,  9 Apr 2024 20:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UHzE1cSQ"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF69158846
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695202; cv=none; b=WjVMjAX5DkBsPc+0E1y2z6dfSCQAnL+iW6mSEs0Ik4xASTNbsKBFvfCNxrXQq0iPIl0RLuhq4J6NtFRhAA9pAYLLFGbr9CdrbqcHeiMe36xz/hJLbqT8ltqIAE7/HLL8kp3/i7AmScL5/i2IMw0JgUDEcib5vMkF2CBQR8at9YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695202; c=relaxed/simple;
	bh=yk2BDxM+7Y4i2zDVZmBIPZBAOJ1qHub6vL1uG2mZ+jk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A8CgM1x3F+G5YeCGF2jjxM/BFVBVaOBpgzJ9WttvaNUnJ3C0Lsinn8WQVlbXsVlgTphvUzuk6XQo0S1so6LcNPLlY1KnT3UG8Pb5Ck3uCAeWAYBqzDKjcwcUQLBkAAnEVHXWak6PtqSCMOlGMWSJUiP7H5VeXVaZsIJbjZGqLNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UHzE1cSQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41691fb4c8fso14312975e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 13:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712695199; x=1713299999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v4I8phARquuRtcJ9dGFSKVepYNDlwt0kz9QDOiZ7JmM=;
        b=UHzE1cSQKqEBp/pxy40KjElSwJJVlkuiCz15tbrinBYCAGS5lKxZriYqNqh1Ibnguy
         0GYZiPWSCmxu0niNsW0AthVlkCMDqhAFI5YM4+U1YGGMLuJl9ejSVYGGhsFBM/pjraaH
         vZ2rEbQx/5dhfqc7RQ4EFZea6HrNlkQM0W64v7anZvEn7dU0k7rExodTrQ9+dxkSU3tw
         8TkR6Yqpv1LLljzdNZOh2VomNb/vcR1JaUD/cUeSQpYMFDiqRSIBdMSlNhtmNokwrRBd
         i7dOCHJNwY0XoPnHuhowoNmtjnjk8EmOXcdaIoP8SfGA3ACehkw/GVtkO6itXZpP0Jyp
         tydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712695199; x=1713299999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4I8phARquuRtcJ9dGFSKVepYNDlwt0kz9QDOiZ7JmM=;
        b=XxzRwarV0731/9sN/UeJN/Ul2C++MZb/VFmONpFJXWeoSjZnKsIi3ivdLt+VYZe2vx
         2nWMJm2gTX8wm4+4Et+kpoLugs04ovLH55XMI0sj9oy9tlCK9UDVy8m/2ZjBaV6eDDUb
         udS82nq7cGFTrGiZSXAhygaYlKCS60LJyX/SuCul0fnTrGN0VNjKZA+QisnnD3crQ9YV
         gbrEqqvRJw7a2dDqsk2NOrmlqf6ougz9X3GvMZoQolgh+6RDM+UvdPx3p6G3wj+c8Vlq
         I5LgP/4BI86girJsOnPna9gzpHZ9tLOELsLOgNjGf5XHXjPVZkbEA3IKCJp9as4aJxJD
         x9rA==
X-Forwarded-Encrypted: i=1; AJvYcCXw/1LCK4Xkvk2Q4LPrA5Orfhxr0Q3UKnNswlp5DnuCwEy/lSrK1+A4UijX2owOub7x/q4LkuC9d/IboXq2wxq4d5Dhqi4vySxApDLf
X-Gm-Message-State: AOJu0YwoAE7sffbgPql9ggXxvCws/QzLCpsh7FfARlJ8ozJeHUirJc4L
	/GnlyCP8B64aDfWZZ9vPT4lntxAjz1vsYIPFl9/18P5HZzVczfnloUVDpSvbJQM=
X-Google-Smtp-Source: AGHT+IGeDCGRn+eN+K867Alrf3EerOJpky7viAd5Dpu+DzEMbQjNs30y2mzbObgPmejllvI8RirF0g==
X-Received: by 2002:a05:600c:310c:b0:414:102f:27b8 with SMTP id g12-20020a05600c310c00b00414102f27b8mr515611wmo.32.1712695199233;
        Tue, 09 Apr 2024 13:39:59 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id m5-20020a5d56c5000000b00341ce80ea66sm12267111wrw.82.2024.04.09.13.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 13:39:58 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Peter Wang <peter.wang@mediatek.com>,
	Stanley Jhu <chu.stanley@gmail.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-scsi@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Will McVicker <willmcvicker@google.com>
Subject: [PATCH] scsi: ufs: mediatek: fix module autoloading
Date: Tue,  9 Apr 2024 22:39:54 +0200
Message-Id: <20240409203954.80484-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
based on the alias from of_device_id table.

Cc: Will McVicker <willmcvicker@google.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/ufs/host/ufs-mediatek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index 0b0c923b1d7b..c4f997196c57 100644
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -52,6 +52,7 @@ static const struct of_device_id ufs_mtk_of_match[] = {
 	{ .compatible = "mediatek,mt8183-ufshci" },
 	{},
 };
+MODULE_DEVICE_TABLE(of, ufs_mtk_of_match);
 
 /*
  * Details of UIC Errors
-- 
2.34.1


