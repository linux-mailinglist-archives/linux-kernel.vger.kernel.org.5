Return-Path: <linux-kernel+bounces-98733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAC5877E86
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238692827B1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1656938DD2;
	Mon, 11 Mar 2024 11:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UMl7D/G9"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A59E1B599
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154862; cv=none; b=fgypzZR6gvB9Enp/HAGKVZc8TcKCfChnkSa0WgFtnXqeMn7GUsu9splp3vflFOlBxVKYwVolkeCES03FUIp1BO9mhC4gny4wXaKKmUMHKiIQ12YGZ5dlb8C/WS5sZ6oIy++SjiNKWTBqwOXPVzisvlUbkjsWaVymnZS7HzKmw98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154862; c=relaxed/simple;
	bh=EJwC2X4/a4PrYYGENHc96zyVnf31IyxcNikfeTn9Iqo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Oo222N5qQajvPunDj/i/ZBmdIxYxsqeqE0BRobSaY7KjeltDssua47BTaD5OIkBfPXCMJK79NBCQYPSx8U+VUN1Ax21uAZL1wb/YAGm1jCFK1P7RqI6XzIDbjKZcN06PjO9QZyHnXkBO4QVe1VKsKjmcysjZko6m4XYnJbCf0CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UMl7D/G9; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512f54fc2dbso3648562e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 04:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710154859; x=1710759659; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S1M9CrsxURK9osAlAJKJLTrbinlvddAx/ivsJ1lbXFE=;
        b=UMl7D/G9HQJXCSTp48O4jUirKGfQnk+0/h8/npTw9iNhoJVsbUOn1ZhGdeY3DaBSgR
         Sajq+hsljsPELgy5rCNZUabvKvVtw0yuzcw2tUAbw6MmrIJL+E1oObRDaxVCExNcS47+
         5SziGTwcfcoI23xcfAvzBXnTNz/i3ztdvUvOOrNtZPiOZNwcCaq3h2gYwEOS6TUt26/i
         io0p7hM4KcTDSvxWgXzg8aSrrMzJl3Htul5/NR/wg09KNvYDYEG/NY9qVuCeKkDaMY8V
         k9EeGAnv188eugy44RfrJimlcWHGQz3ydTyipkTrQMj01xKe8tTleMCaXaVTD8dR+hy2
         HNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710154859; x=1710759659;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S1M9CrsxURK9osAlAJKJLTrbinlvddAx/ivsJ1lbXFE=;
        b=i2JXkdgOqyt8CqYTC8kYVl+O38NIHMNJDI6tsubrgODFvANgEXOiZSBoD0PNMO+V+5
         eCBKPCbmnLdOuutA8EORJu1EEvom3yLYQVSFIGNPzbF09bDNZIZvL2jevKW6Nei5cyJ+
         z90MErRSEoGEzAzIhUvElSkswQntvEs0XMbCXeexe5pnD9vOEAe311MQbVSbCvA+KgSr
         7tYVCX6IdMbK3FqhzZGl7ZO4g0YZAZJQ+e5bXg/JgdlehChi959TczqlciijTT7oJlws
         mDu0FvVIu4D8C6M1hv6lGAoRG9GqOZO/bw9vBtww4P7ysszKeQm+TA2uTyi0kN0lJWO6
         yhOw==
X-Forwarded-Encrypted: i=1; AJvYcCX4GZusLQiieSvDUiFwLbdOmwXXFYwjxac9CupoIixkKI6hqHJ1qd8W3OeYLvHf+u6HGV78JZVjT4P24Te3lMNf/vnUkj64opD/dGHJ
X-Gm-Message-State: AOJu0YzW74w0PrcWCIwPM/T8D2xPVveC7oAskDKRBqaaL8bXJWrw4TFT
	02MorHKJKAAMxJnCHEzqJYLmXSEV8nRGAUNIKlwHN6mDC7wIPlIXC6V4IYIICw0=
X-Google-Smtp-Source: AGHT+IFwCGdoVdTpdQaznB2idQvFXubh9UWyyPMuumHmhiYMoRkMnvTiGe/Fhx2f7ORUyE/itJx+5g==
X-Received: by 2002:a05:6512:ea2:b0:513:b0d4:da40 with SMTP id bi34-20020a0565120ea200b00513b0d4da40mr706289lfb.20.1710154857841;
        Mon, 11 Mar 2024 04:00:57 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id eo5-20020a056512480500b00513179f6c22sm1045933lfb.96.2024.03.11.04.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 04:00:57 -0700 (PDT)
Date: Mon, 11 Mar 2024 14:00:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] gpio: nomadik: remove BUG_ON() in nmk_gpio_populate_chip()
Message-ID: <ae643df0-3a3e-4270-8dbf-be390ee4b478@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Using BUG_ON() is discouraged and also the check wasn't done early
enough to prevent an out of bounds access.  Check earlier and return
an error instead of calling BUG().

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpio/gpio-nomadik.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index 463a765620dc..5e2f9b51ece3 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -533,6 +533,11 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct fwnode_handle *fwnode,
 	}
 
 #ifdef CONFIG_PINCTRL_NOMADIK
+	if (id >= ARRAY_SIZE(nmk_gpio_chips)) {
+		dev_err(dev, "populate: invalid id: %u\n", id);
+		platform_device_put(gpio_pdev);
+		return ERR_PTR(-EINVAL);
+	}
 	/* Already populated? */
 	nmk_chip = nmk_gpio_chips[id];
 	if (nmk_chip) {
@@ -606,7 +611,6 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct fwnode_handle *fwnode,
 	}
 
 #ifdef CONFIG_PINCTRL_NOMADIK
-	BUG_ON(nmk_chip->bank >= ARRAY_SIZE(nmk_gpio_chips));
 	nmk_gpio_chips[id] = nmk_chip;
 #endif
 	return nmk_chip;
-- 
2.43.0


