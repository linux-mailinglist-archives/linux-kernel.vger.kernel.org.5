Return-Path: <linux-kernel+bounces-52639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B378849AC5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB67E2847CB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361F72D042;
	Mon,  5 Feb 2024 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZfGlqtpx"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9812E2C1A9
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137129; cv=none; b=PH/NSNMrY5Kt+z2OX+LO7Zbz0cufnVcLD9tlLkS1Yxta9ALNEr/gEcNZK0pQNfhZsRv+ng1ioTaJQZbdAhE5d2vDroD3Ln+C5U198v0FEgRIfK+/gCGyIHkJT0rFW/rramHCelvuBvrsGwh526PM8FjsA700xXptDGwxfvY/mWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137129; c=relaxed/simple;
	bh=SPrCOsQxxjla/vMCkgij7H48llhpPtwGBfHWI5X5uAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsK+/92ma43DFFxqqmco4emzFVhe8Nqx4qJLAw8xVEY0skH16Q38foMYJFzNoqwqPMbl2y4VKaE2V2+NAtNVpSxpMztonjpiGPe/oUjl8iaDiN01wrR1/KKcSETCcs78Q+fP5pmVthIu33cIlGOsAriCydUsh8C8KlYaIZzYlrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZfGlqtpx; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40fd55c7f93so12811645e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707137126; x=1707741926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndgta4k+G5qoRIAYZxQhEjhM69MpnMv+KGVE1CZejWY=;
        b=ZfGlqtpxLtJd0qx/y5lf5tCx1gxaMalot3xUWWAqgaA5SJo1YxByJ/U26RgrU2F3Zh
         whyfPgzFxB5GIRvLzhRsKcIrwLGz0966XxRjnZDrTIfbjjVd52JmnCKTjJgJcEhByo+w
         P9+AL7saEACZxC7nc2qtxBp7z0kcI9yXCkXY9LmykgCCVA/TirPmT7/0qe0rYL1O9/iF
         RFaldB0ZsUYEjhPnsV4KxQXZrFiCHXxBO8GrNJpxbcurP1w8l+8nfWBqqPamytIaOreH
         qK5pebaMJcG/iday4cloGEEMY36SjcwVL9zrF/A8UHg8JhUEdg+K6UgQ/DL0jqG7Qqmk
         3eTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137126; x=1707741926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndgta4k+G5qoRIAYZxQhEjhM69MpnMv+KGVE1CZejWY=;
        b=dmsZ6qprhFC0Sjj7g4h0ammOD1nSHecIDlxZ5376jTTmGVPVMSdNt5jgFy28+MVGjV
         xtnOa6rjJAQ8/hj6qm0boc77YuMCFbRoPGcYZdg+vMKY/vdGKWCr+/kk0NyXu7SGHgGq
         rI6YsOn4YZoPDV48TAkrMEAzm5z9blI1TeOfMg7JnNLwkAUqakLdpxTr+d/h/CwNB0t+
         S9v0Aml+iPWY70x0kG3Lc1ZkCnYDe0rWCDCR0ZfoCLIb4x/Tz1k/EBquiARKIkTWWtRv
         WyHhuRbaKAbg80b4IWD7HWGoDDQpCb698iazKsltk/42OCl6fWj7hmazqg2kHyVgcl4C
         wkzQ==
X-Gm-Message-State: AOJu0YyIJf33gr2xh/p9Qpxqk3bndSoW28mUqJZuR5Po5SWmWVU470cb
	rvTRKIJ+//joVyQKbkCZAYly09u0S5h1qTXsoszKESFq+cj4Dsi18EQndzUM0qU=
X-Google-Smtp-Source: AGHT+IFfo3cQQL9/HnpiLvwbqAwEr44KXp0C33JXwRj/iVJj6s2NcvsGUE72XOVRphi8QHeffBQCgg==
X-Received: by 2002:a5d:42c5:0:b0:33b:2464:9d8f with SMTP id t5-20020a5d42c5000000b0033b24649d8fmr5556272wrr.58.1707137125934;
        Mon, 05 Feb 2024 04:45:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX4JJNaf1yBR7JlAEEqs/vM1bpQHP5WCL3yheh+1Kk+jWGt1qmnjBQBaHyqiZZQd+WQry3owsObYdswipM/LUbjc4iKp+vCyWMu0+PIKN4x5dzcFLRn9rPoqXXdHAOzymMl/Hw5G6vuBwa3A47LFDQ6m4ja1R8p0RkwUW8INsVUpTDkDR9RIGLQvZOabOu9aLo3xeCQnh0ueBq9FZeUpz0utDS2DCj35GvobxhpwJynTO61ixqSBBVNmXKMduQdzModeSLGlpXGmpoucJ/zNDcIhTSlcBBc1oDAI6Lts550pcPIy+IjfeYN3PFOGRxW/n5it04PIzIwudWyr731/vX4KUoqEw/fZgK9qBzj3VEQ0gMVBD3aMort8hvdp3lMHB4ZXnc/0Jf1vo2ZutfSR6EvcGdXWmdxKaIwnhNBRn+YQnkf1fqlbluaeFnPujHNe6aHc8CCeZAWOzmN7fhVyk4dxIshW1N9XDtPm7D3jG0MOO3nO7VCbsXmybO+FA==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id n9-20020adff089000000b0033b35da384fsm3650812wro.33.2024.02.05.04.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:45:25 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 09/16] spi: s3c64xx: check return code of dmaengine_slave_config()
Date: Mon,  5 Feb 2024 12:45:06 +0000
Message-ID: <20240205124513.447875-10-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240205124513.447875-1-tudor.ambarus@linaro.org>
References: <20240205124513.447875-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return code of dmaengine_slave_config().

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index fcc1f16d3ad1..43b9792988b6 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -302,7 +302,9 @@ static int prepare_dma(struct s3c64xx_spi_dma_data *dma,
 		config.dst_maxburst = 1;
 	}
 	config.direction = dma->direction;
-	dmaengine_slave_config(dma->ch, &config);
+	ret = dmaengine_slave_config(dma->ch, &config);
+	if (ret)
+		return ret;
 
 	desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
 				       dma->direction, DMA_PREP_INTERRUPT);
-- 
2.43.0.594.gd9cf4e227d-goog


