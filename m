Return-Path: <linux-kernel+bounces-145812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8688A5B37
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560191F21CB6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4724416C423;
	Mon, 15 Apr 2024 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LfHIP3YS"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80EE1635CC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209705; cv=none; b=UoxawEri3rejokbxQ5cEPpgQ0vSjwtndmqrOSUZeOzecbiPpivvKyTJmFcKCaFPbnmVhd5jbzAm2YPgIdOdjnrzmm14RU8+qAVZ46Pj71GplbYKR3v3PQxEaeTCc9ji4Pf1CUvrF2IeOrlvv/7tgzyDh9+JMzBjyYzL3muywt2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209705; c=relaxed/simple;
	bh=VhbJFqc8QmLlbHWJnEENrvmuq+ozcGe5o6fFyH1YYQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E5gnjfO1hjAcyqAbLqVBgcPzDW0/n/6mV1l2TfFMhg8zbeu8M8SR2tpLDjST0/QQXYbKg55BIKPImM4RkivkPZmrLh5C50v3eWLjPmbBCjTiYwZj5SDPNq9rHUIS7Lqf/q0aJJTCQMEktrkXt7FO1GAkhbRkG4eyq1Z5z3sC8jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LfHIP3YS; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78d620408f8so295553785a.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713209700; x=1713814500; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OhmQYYxWMuudLBjdJjOGHKHYUzO1QQEhFUDY1X02X9Q=;
        b=LfHIP3YS/F+mTAzygDVHslx5fAuRJQnA2sSJ5ftryYm2qeaCsuA7qFlI+6p9qUxdkL
         GuJ9mP67JlIOKKIPlIcpEvUvKrahgJfXZ2/yGY/pppGNfmjI/IW5WlCChJSzsdgMAgwb
         oMUzsZcPcHH5obx5uHQ2Eq2tJlkHdq4Lai9No=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713209700; x=1713814500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhmQYYxWMuudLBjdJjOGHKHYUzO1QQEhFUDY1X02X9Q=;
        b=BzB1waqrK9UJ/fBsCZAD+8PkkLK8iakpI0cQ8LD6N81yFt4C8cx74Y1t4OiwjQa0f1
         zHmo4kJidhdVMyENBdG1Ev4atVXXhzgOVukugermLydeqse+3pmd91CJqKHvb9I7pg6p
         78CIJwJHqFrd5mutyySEwdvm36NEXSjDdnZy7slotlo7Ku3ufYpvZ/xZqESrt8YTbxXS
         KJrH+DXS/uL4LH5rOPMaBGSNTu9UccBsPx3cfH7ZExnOP2u0chRAoIWzhus1yfp2KKDe
         ms2OfzTRCKF4SNGPrXYVGXwP1mD8C6R71nnCVBQ16rzQ3RHmANFDmBc+pStnp/jnJMpp
         MDZg==
X-Forwarded-Encrypted: i=1; AJvYcCXpLu4wDC8w3w1K7cbK4Jut5g9242qoc9ngO+BZUp5c74mqUd7R9iECbkuLrHqfJG7z6VTwiDlfK2rDTf7E+MO6PMmWsCD89nMl1oEU
X-Gm-Message-State: AOJu0YwYAMtNA5ZsrUZXxLl/w9IltN7vaYm7vESU8A0PrOLhWDyMqMZN
	cYKzfbwOWcZLRmWu4Ay6O9BdG5IMyUU0Lyl0K7Wt21i31ruuipT3+pFBJwESyQ==
X-Google-Smtp-Source: AGHT+IExc3kiGm+hEFRw+kQDfViul4woHzF6WRs96subTZ4c8qoJuWqvczLaOhJGq/Hyw06BNYyVfg==
X-Received: by 2002:a05:620a:3182:b0:78e:dcc4:339e with SMTP id bi2-20020a05620a318200b0078edcc4339emr7592795qkb.11.1713209700585;
        Mon, 15 Apr 2024 12:35:00 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id s26-20020ae9f71a000000b0078d3b54eb76sm6718055qkg.78.2024.04.15.12.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 12:35:00 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 15 Apr 2024 19:34:46 +0000
Subject: [PATCH 29/35] media: i2c: rdacm20: Refator return path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-fix-cocci-v1-29-477afb23728b@chromium.org>
References: <20240415-fix-cocci-v1-0-477afb23728b@chromium.org>
In-Reply-To: <20240415-fix-cocci-v1-0-477afb23728b@chromium.org>
To: Martin Tuma <martin.tuma@digiteqautomotive.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Hugues Fruchet <hugues.fruchet@foss.st.com>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hans Verkuil <hverkuil@xs4all.nl>, Sergey Kozlov <serjk@netup.ru>, 
 Abylay Ospan <aospan@netup.ru>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Dmitry Osipenko <digetx@gmail.com>, 
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Benjamin Mugnier <benjamin.mugnier@foss.st.com>, 
 Sylvain Petinot <sylvain.petinot@foss.st.com>, 
 Jacopo Mondi <jacopo+renesas@jmondi.org>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
 Pavel Machek <pavel@ucw.cz>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

This is a nop, but let cocci now that this is not a good candidate for
min()

drivers/media/i2c/rdacm20.c:363:12-13: WARNING opportunity for min()

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/rdacm20.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/rdacm20.c b/drivers/media/i2c/rdacm20.c
index b4647bda8c21..b40d40b0cdd4 100644
--- a/drivers/media/i2c/rdacm20.c
+++ b/drivers/media/i2c/rdacm20.c
@@ -360,7 +360,10 @@ static int __ov10635_write(struct rdacm20_device *dev, u16 reg, u8 val)
 	dev_dbg(dev->dev, "%s(0x%04x, 0x%02x)\n", __func__, reg, val);
 
 	ret = i2c_master_send(dev->sensor, buf, 3);
-	return ret < 0 ? ret : 0;
+
+	if (ret < 0)
+		return ret;
+	return 0;
 }
 
 static int ov10635_write(struct rdacm20_device *dev, u16 reg, u8 val)

-- 
2.44.0.683.g7961c838ac-goog


