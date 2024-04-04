Return-Path: <linux-kernel+bounces-131036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4CC898242
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8129B27576
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D325D731;
	Thu,  4 Apr 2024 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zJikKwsA"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEB11CD3C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 07:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215904; cv=none; b=ZH2fPGptWA84tsi5rhHs11q5fnFj6IPi/y08ILdOvi7SXCd3usPy+KqZOuvE/MhyrYlcOgRyVykFA/W0C5PxU9Kr77/RUUjr5K98szLOr3E5u7YNvmbiyTPVjK2w/g1Yyn/6I85/gU6R1mN+z0u4z1lEgA2XWlMa2kV1omoSzPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215904; c=relaxed/simple;
	bh=zVyGWF1iveaM9nRdNRBaWoSVHzX2upsrKArTedHzmbM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AvzHZFluFjxhcOxoCC5eXbVtLe5TN0mF74+yXqR+wzjpFeR7I5xBdmKXr5UdS6uaCekfkpiWvLy+6u13mUxSD/kgPrr6dF96WDj9u6iktLzA0K9HyEGuoarHV2/DxunKbwBWn0SnAjiwB3yBSa3X969OLu0J00DAjnAV7yeq2IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zJikKwsA; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d82713f473so10876991fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 00:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712215901; x=1712820701; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vu3+4crI0+2uxroxmdzmWagiwHkz9rJOougDEXvD4hk=;
        b=zJikKwsAcweayZ9Lc7v6y4hljX7aC8cNMkOoGzJbKLQfpYNalPAFeRJ/s3uPD8ap1m
         NW+Fm1aHeIUYbnaKU7Uk6VX4OnmPxX4Y3yltC1mXsprtRewDwD5QHxW/shgmIOLi+k0a
         VqvNLcuxFWmydH4ZuCR2PTNb8lqprqESr3azMSru3ls0obEoPmQnD68MHPRqFgaY4FEM
         4KUL304MaPVAR6OM7wlQX71hA9+cHAbdN8o79B9DKQrBG8mZoZptW0po1ek2W0i5bd1A
         jJyn7PJh7O8AgYStNRHBdHcKuFSsGmXBox+ek5SLLgEfJ/FjrO2Q5OVzsgV2EZx0tWgb
         kZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712215901; x=1712820701;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vu3+4crI0+2uxroxmdzmWagiwHkz9rJOougDEXvD4hk=;
        b=CgofiHg8l5xaCBRSezOMTzl2Ia2+RXtGhFwTwL/qyNyMXMjwyPmCuOq0Q6vbgK6f3N
         lR5yPnMoG9NymzKDqCJzMTErY6Mg4Akhim6I+gS61aI7hSe6Yk12/itn2ozqB1vhk7ZB
         lmIYsYx0w4yQg6Wz5F9HXD9IgGGJ5iGFyvZkGhk8zpjRzEHPKe+Qy73aFn08MItBvI9X
         xiF3lKA1DpnKlU0d8dL1lpQ9r5SUT05IDL1nAhGwhKAVJK54ZtQTdnjPfU5uqYfR9xG/
         AF1XdxegufscWDSWGMo/ozbeCo+JuizpwsDj+92u/T2Efxc+B0dVaDf5E6QdElkPX279
         CGxw==
X-Forwarded-Encrypted: i=1; AJvYcCWKXNdG2I7qjiGWzQDCTZO+zOahxOqR0nt185hdId0CC+BQ9KO1VRvihSRfqyx5lhxj6x0udvFGBHMM8ysO2jIIGN7AUCOaP3oHIdfy
X-Gm-Message-State: AOJu0YzfeJUKHNd/IS6iwuwXvMFC0RCNIsYqZA2xoaKXibYYxbJPfQtb
	c6lC4hgyS4dP5L5eK2zXNhHtLOKMZ2bb2yUj8AIfGBf36GQRV3+hbmicy+6ejfU=
X-Google-Smtp-Source: AGHT+IGiE75e3sow3qx8AU7LvCSgmcUGI1nvrGeSu7KhuHffLa4dHJlju06ThA2DLfKY1Ea1b1TWvA==
X-Received: by 2002:a2e:b04c:0:b0:2d8:41c5:ad64 with SMTP id d12-20020a2eb04c000000b002d841c5ad64mr1540458ljl.13.1712215900612;
        Thu, 04 Apr 2024 00:31:40 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id u14-20020a170906780e00b00a46c8dbd5e4sm8625495ejm.7.2024.04.04.00.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 00:31:40 -0700 (PDT)
Date: Thu, 4 Apr 2024 10:31:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Walle <michael@walle.cc>, Andy Shevchenko <andy@kernel.org>,
	Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: adc: ad7173: Fix ! vs ~ typo in ad7173_sel_clk()
Message-ID: <5401c681-c4aa-4fab-8c8c-8f0a379e2687@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This was obviously supposed to be a bitwise negate instead of logical.

Fixes: 76a1e6a42802 ("iio: adc: ad7173: add AD7173 driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/iio/adc/ad7173.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 4ff6ce46b02c..b1d6ea17ced3 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -835,7 +835,7 @@ static unsigned long ad7173_sel_clk(struct ad7173_state *st,
 {
 	int ret;
 
-	st->adc_mode &= !AD7173_ADC_MODE_CLOCKSEL_MASK;
+	st->adc_mode &= ~AD7173_ADC_MODE_CLOCKSEL_MASK;
 	st->adc_mode |= FIELD_PREP(AD7173_ADC_MODE_CLOCKSEL_MASK, clk_sel);
 	ret = ad_sd_write_reg(&st->sd, AD7173_REG_ADC_MODE, 0x2, st->adc_mode);
 
-- 
2.43.0


