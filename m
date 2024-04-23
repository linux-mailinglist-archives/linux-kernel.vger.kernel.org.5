Return-Path: <linux-kernel+bounces-154617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6A58ADE76
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA871F234E4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2345A4D58E;
	Tue, 23 Apr 2024 07:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQYWBDjI"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABFE47796;
	Tue, 23 Apr 2024 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713858273; cv=none; b=seazVZXg2oKpHWZwJYHD1MwTax6txwYEmIRZQ7GzgD5ItNbHt15gH9yqfLLOlYsJcuYCn14Lx4gINuxUvEoxEJfETVCEgDOO9+3W28mcQPX6S1XWF3y8e1ESDe06jO8600nXDakkq7CVlhwVL9Rp4FGYWYCV1SdEIxN+7/RVyJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713858273; c=relaxed/simple;
	bh=HItHqTRaUd0d1MV6aM34J5b3KIbtrvkExB8EEd+pcws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=c7dg71aKSUGOFkIkup5Lu4KSk/FD8XwyzxXLYfGLrhyneHiX8b69ZjUV7m4GsXpcgNaFWCgFF0E4oKSEjRCt8ExcA9soI0K8RNzlIkjqv2wnkOeRKYdQeoX2cjewrPR9maS/KRDUbDCjJG7Mh13ad0GR0HbN1hnonzE+RELN8U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQYWBDjI; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-343e46ec237so4508528f8f.2;
        Tue, 23 Apr 2024 00:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713858270; x=1714463070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ICxLxoqLCPkVAEm/gWy9vaIt+Q7OZ1cgkkw+GcO4MNQ=;
        b=XQYWBDjINoOiuI6QckJxUby8VbeecY5M+OqUMFzXgK4T214zAsYq707qS4lbYPkQC/
         zzoCv/Z8Z3oHhpV3MX8kdwz8sqe7mntqP/ZeDGe+hLs9wCLWJ730QH2nAhYoGQIOxBGD
         f+Rebqs3wMuyUzh3pVrI+18AlCZsPkmyzLjpTJjkUTL26o0F3n5S02t8MvVv7mbGp293
         JK5ZeaTA36GIkK9/5b5gua8E+eI03R6JiqFj+VYKjl4rkZk78T5GfiOGs945MXJS1c5s
         JLK/NmF4XZ+HDSGUDGongHqEIBDGyi2ImGbTh0yBVsfg8ZTVfcT1jcNHnpLV+sBSLWvT
         VtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713858270; x=1714463070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ICxLxoqLCPkVAEm/gWy9vaIt+Q7OZ1cgkkw+GcO4MNQ=;
        b=k490jooS1+ifb08dkjDRZY1Q8qiJqFwBogs0fTUAiZ3dHE9JxT1PaDX29seVDVIYlm
         rwXNhzb4oxAP1KdBjB6KAzkMiI+mPjAjG8gJosja4fjCREswowQD6P3FvRGVO9MDYnUh
         wBdpjplapw1SmSiNAiUAVyHI5mSjZR2kSMOVMKEuHzt587XTUFOgdfieNMrj09tyrk25
         BW0XtNEt+ZU20ZEvZHeUxqUVyCz7JFYLW1nntUjNmREIAbZTjg9cju4KTC54u0uDy7dp
         c7KIly9Y0bXRXtVV3nhsAmZH6TZezJxdl5dohkWNz1oMcCzoZCHjQJ97D1Z9Km1oIGx1
         0KKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2ISyryo4NWFLe1qBHi5nr/6yuE+S5rOntDAelyNIKhw8zMF20qmMKryMSKCJc9oBDhjvKTbmLGd1D14FUCqi2LLv4zBtFIGkjbEJPor8/2AV/hqa7KUu+CKWWzTj+KEYwX+gHsY5RxQc=
X-Gm-Message-State: AOJu0Yy12/ZYqGHBvXJmxGc/pQsSxxI+/t7MsbzPlKcsTkSLKkA3Mqdw
	NLQuwlLtIrWt6Cdc+9pVU7ZlMQVKfTIMDuOFjk2zZuTqeLGrM034c8p69w==
X-Google-Smtp-Source: AGHT+IFM2SP8Nqxd1gHbttKIRjBJ47wvuHrP3Q9C4XUEFUGwVwtSO8/ZoFlInGPGW3r3ZGej1QYpkQ==
X-Received: by 2002:a5d:444b:0:b0:343:e02f:1a46 with SMTP id x11-20020a5d444b000000b00343e02f1a46mr9466936wrr.2.1713858270055;
        Tue, 23 Apr 2024 00:44:30 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id e5-20020adfe385000000b003455e5d2569sm14079241wrm.0.2024.04.23.00.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 00:44:29 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shenghao Ding <shenghao-ding@ti.com>,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoc: PCM6240: Fix spelling mistake: "deley" -> "delay"
Date: Tue, 23 Apr 2024 08:44:28 +0100
Message-Id: <20240423074428.1313777-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/codecs/pcm6240.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm6240.c b/sound/soc/codecs/pcm6240.c
index 93d592dbee66..86e126783a1d 100644
--- a/sound/soc/codecs/pcm6240.c
+++ b/sound/soc/codecs/pcm6240.c
@@ -1772,7 +1772,7 @@ static int pcmdev_delay(struct pcmdevice_priv *pcm_dev,
 	int offset = 2;
 
 	if (offset + 2 > sublocksize) {
-		dev_err(pcm_dev->dev, "%s: dev-%d deley out of boundary\n",
+		dev_err(pcm_dev->dev, "%s: dev-%d delay out of boundary\n",
 			__func__, devn);
 		return -EINVAL;
 	}
-- 
2.39.2


