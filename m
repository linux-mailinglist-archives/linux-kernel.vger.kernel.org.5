Return-Path: <linux-kernel+bounces-109697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1442881C89
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E18D1F21FDD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CC94CDEC;
	Thu, 21 Mar 2024 06:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xnhe1zhW"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B11481D3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 06:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711003127; cv=none; b=RK5ZlYA4s6iM1ywU1ZC+ecZ3rujhvZXprPXTxykJUzghcVyHJba5l76Haht66ZgERZh1Nqt1/pkTN4T5rMRjNBrfc6DMhhUL0Xf9H7XMB9XqqADbSqohL2pfT9FT7D9rFr3p+YRuqbnNYjX4HMNJg3NAt6mdmlYpW13KfxB7dgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711003127; c=relaxed/simple;
	bh=YbgeCnjIUVi5GtTDPEGswB6RMCMBOV39XcZrT3taDIM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mo0/95IxDjPl7BFsAASnplZ0Y2vPAa0B3Qe+l963+lk7LEcjuwGXZHnP6xszZQ0aughiJCvxuisdHxu8eDwiYoSZBYBjkwjRK68iLemq321V+0Zv8/nDQXSrWQQdGVnKLIoBhx4vFhQIiuvbAQ/2u3DZW6RZnHYCg9cXrLQUg/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xnhe1zhW; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4141156f245so4221465e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711003123; x=1711607923; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P4hwGF+QXFX1Vxi6snkUitGB1YN98VjNP9St3h6PXDQ=;
        b=Xnhe1zhWr/ctT4VSATHHth64Y1oyivJsUpq0Klfm7KMmAYWqhD76eqWtnTtikXm/+E
         dQ0gRymXH6wWm9TrNUBQL4bBG+KPOTrr0s9V+ytgOvN30ED/2KnThPTse6F0YuM75KsB
         0FFVYUwg40Bq5MRsyvTp7XtjMkBpoc8jb1SMWAKzsP/buuhd+qMMMQw5WND8737LIUf3
         prSeMSTJl9mu0beZTotT2yvuAMlyKjs3yvC4G/afBklIAG2JsopDogIcVJrfdKiqr34m
         jy/71hz2/p1k1B5LCNC9WzXdcNGCCHhfu/hOx+rQmhmI2CwfZvB2qGcFReNK30/hUPi2
         8Ygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711003123; x=1711607923;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P4hwGF+QXFX1Vxi6snkUitGB1YN98VjNP9St3h6PXDQ=;
        b=h+FsHFkSLdC14c70UQo7iv/d7p5ri0o5zNLK7rbpKIjiBYYyaSqu5PcXBx/y5JR+28
         9d3N3dZYQ9nFidc1eO9wUq6vfZuRRrkzURy7uEn3kLb7E4IoUrhboMOzs6s+Pz4P/2My
         ZFMEV1ZmpZgSaMUKoHlYvYJ0w+GxXLMs1TmQHWk8qYfLS3MIPHrNI2JKDpTpsx5gt+h/
         bdoC5eno215JLW2hW1MxHTUATM6hKsKCZDNZiqXpkMat1r2S/pCSA9YFp0ngt2JNFhuo
         wYd3l1pg6whaun8G9xJOAY6zXCNjektA3XsQTHTg3EoZrpUmYhKX5bsHmB5sKlLa9DiJ
         3YAg==
X-Forwarded-Encrypted: i=1; AJvYcCX4B7YD4LWBzuVjORGo2kRlkOHo5G75gzBWfepbGcLNNL4+5Pf9CQelp23s7hJOhI8E+i3PgEF4+k1i//44i3fYMhhQr091RKHBn7PW
X-Gm-Message-State: AOJu0YziWkHQj8XwGLc8Y7T+o7DOSwi1k0zXNNogsf9dxSvP7rxb3ApB
	XmealXi/WPmxYfV2nkVBZ+GQ4vKw7Ismj4EAwm6Qx4f/qxf1LFiUcdOJ7mxr3tc=
X-Google-Smtp-Source: AGHT+IEDUPehHJz4ek7JwafnO4x+wLZIk1n91Eb6COngAaFGxoPjYaT3KfsS4Jezl5GNE0okIbeNVw==
X-Received: by 2002:a05:600c:2484:b0:412:e50f:acaf with SMTP id 4-20020a05600c248400b00412e50facafmr615178wms.24.1711003123461;
        Wed, 20 Mar 2024 23:38:43 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id l5-20020a05600c1d0500b004146a1bf590sm4502963wms.32.2024.03.20.23.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 23:38:43 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:38:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] pinctrl: core: delete incorrect free in pinctrl_enable()
Message-ID: <578fbe56-44e9-487c-ae95-29b695650f7c@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "pctldev" struct is allocated in devm_pinctrl_register_and_init().
It's a devm_ managed pointer that is freed by devm_pinctrl_dev_release(),
so freeing it in pinctrl_enable() will lead to a double free.

The devm_pinctrl_dev_release() function frees the pindescs and destroys
the mutex as well.

Fixes: 6118714275f0 ("pinctrl: core: Fix pinctrl_register_and_init() with pinctrl_enable()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
I spotted this during code review and have not tested it.

 drivers/pinctrl/core.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 6649357637ff..cffeb869130d 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -2124,13 +2124,7 @@ int pinctrl_enable(struct pinctrl_dev *pctldev)
 
 	error = pinctrl_claim_hogs(pctldev);
 	if (error) {
-		dev_err(pctldev->dev, "could not claim hogs: %i\n",
-			error);
-		pinctrl_free_pindescs(pctldev, pctldev->desc->pins,
-				      pctldev->desc->npins);
-		mutex_destroy(&pctldev->mutex);
-		kfree(pctldev);
-
+		dev_err(pctldev->dev, "could not claim hogs: %i\n", error);
 		return error;
 	}
 
-- 
2.43.0


