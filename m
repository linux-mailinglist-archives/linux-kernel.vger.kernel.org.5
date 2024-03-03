Return-Path: <linux-kernel+bounces-89933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA8886F773
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 23:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30C13B20BE4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A687B3E7;
	Sun,  3 Mar 2024 22:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmSkDn5c"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A56D7A71B;
	Sun,  3 Mar 2024 22:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709505306; cv=none; b=tmhDvE/dbd62ePf0M30bkVyXOJgPyaVyoShH7eCGtBmAXbCyKc+fsItilub0TDSfJAq3jkgOEOZxT8A2V8vwr3gPmgkkEUJpQJZ6Qyz++eV6fwzXHETPotCV3kH3fsFstsl+rYKqNfTjnhIsVzppVpT6Vk263NkdpuL6wh2Edvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709505306; c=relaxed/simple;
	bh=uxOHYTUIDNZtxym54MJ4KWGaL/3jfluXSg7XgXyRNKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MbteirRewAo0cZosaFz0Avw7EJyqp/LhqJ6X4rlMpAt3Jh/4/LWfkj/kX1THKbk1S0Fo0FrLOmkMJcDxRVgv5Fsir9j/24lwfAtkuYf3zAv6PO2zw+bJTtxb9Aji2Xrw2HJJeUT4rnEGjxz2mtWpjHcBU9TQrDCevHBxpHqD/SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmSkDn5c; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a44db6c5144so143830566b.3;
        Sun, 03 Mar 2024 14:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709505302; x=1710110102; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K25iWeoQwshT7vgS7weC4R0luoK6Av4sdvxlo5qLywU=;
        b=RmSkDn5cTAWOY/AngA5YaMku3eZpKzCYTDzbQD4jMqZtpZKSpQSIZMpTNVKjqlHjxM
         oP/mDmujSZhdYnWgrZ9fiTnRfTlncd/LAWzXsHo8eptyLSmwwUe/oz24emEiLs0r52WS
         afvL++P0VWyuLBykMeNqG+bnXJVdmSWgH+YV0/Ni7KeUEGO2FkEmLz1g6ZUTXAUZOFhA
         rq3Oq4/V8jrs5e5it1QDeAGeQvMqvRZa+2rk5uny1QkC4ii819IyEeKjlhoAZzTY8Mft
         0ogzuusVRGsaVq2ruNF1Stptc+OXCi2E58AZHFrvCHgG84VvyfUOs5hy1dXm2/A579F5
         K4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709505302; x=1710110102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K25iWeoQwshT7vgS7weC4R0luoK6Av4sdvxlo5qLywU=;
        b=OHf9yzXqyzSkULUxnPyLd4s5mxiXCMekjPrvfsKpzrJrs4OyjQXOugFAjruTUvcTO3
         bDeW8E4KYigLGsDZ3gjyjgUCkklXWwCqDN0oNRTMMigGi+UOGj3R86UAAlxqzDvn2eei
         0p9PlQGMG/thnuTiho/svhfRhWcJJ6f53QJO0VRVi5EaceB0Ur4EM9zn2EoqUMJpvYy7
         c7+52Dul9SaalSUK4m5Pxlejns51GfpVkR5cSsaHkOTXyw1KBhzI8nmgCLTgSLb2sW9+
         P31XKY20AZBwlYd6vUxFlc0MLZsbIpltMHysXGym5kvzATbMnDo+T25Ju6ywZoZk0WmC
         XenQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZDJlhzpZyU4PGnjiabJc+59x44W3fdOU129bNL/NU0siXS6eb/AUs4S7Dj08FxUb/36uomKhZRHfAyxmiStLyUyNQIFjiZv/e1uCAKmcjok+1t7Yb95UACr3vac35EaAy0PypYVv1
X-Gm-Message-State: AOJu0YyN6Wxvgd6TzuVEExR7Jbnds1mMrbTGrO08GhKxCxO32ySa8NNU
	HkeiBp7xzaAV95Uo+Calws9bydYFKC1ZCX2+3pjp8Aas3hkAlUTOV2USKw5xD+L8UQ==
X-Google-Smtp-Source: AGHT+IEUy08uXH8IfqoNNG9jxD0szuT7RxWdCw4kdgoYel5Vjgq5TcsF/FensbsGLw/VW17WjdtMtw==
X-Received: by 2002:a17:906:fb0e:b0:a45:153a:e2b7 with SMTP id lz14-20020a170906fb0e00b00a45153ae2b7mr1550758ejb.28.1709505302688;
        Sun, 03 Mar 2024 14:35:02 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b3d8-5b4b-5188-4373.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b3d8:5b4b:5188:4373])
        by smtp.gmail.com with ESMTPSA id v23-20020a170906565700b00a455ff77e7bsm82204ejr.88.2024.03.03.14.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 14:35:02 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 03 Mar 2024 23:34:40 +0100
Subject: [PATCH 2/4] io: light: st_uvis25: drop casting to void in
 dev_set_drvdata
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240303-void_in_dev_set_drvdata-v1-2-ae39027d740b@gmail.com>
References: <20240303-void_in_dev_set_drvdata-v1-0-ae39027d740b@gmail.com>
In-Reply-To: <20240303-void_in_dev_set_drvdata-v1-0-ae39027d740b@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michal Simek <michal.simek@amd.com>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709505298; l=843;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=uxOHYTUIDNZtxym54MJ4KWGaL/3jfluXSg7XgXyRNKo=;
 b=9U56gnbrtl58hQhPEivthV+gdebX1FTESKQOFsHbDZcAIYEYXNyD4DqIIg/zESPYzTcM5/JvZ
 bzjOzfq1cVPDeJvdw53D3AYNGJ6Bqpm11MMs3vko4DCb2aUNw8Bjeuq
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The C standard specifies that there is no need to cast from a pointer to
void [1]. Therefore, it can be safely dropped.

[1] C Standard Committee: https://c0x.shape-of-code.com/6.3.2.3.html

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/st_uvis25_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
index 50f95c5d2060..d4e17079b2f4 100644
--- a/drivers/iio/light/st_uvis25_core.c
+++ b/drivers/iio/light/st_uvis25_core.c
@@ -291,7 +291,7 @@ int st_uvis25_probe(struct device *dev, int irq, struct regmap *regmap)
 	if (!iio_dev)
 		return -ENOMEM;
 
-	dev_set_drvdata(dev, (void *)iio_dev);
+	dev_set_drvdata(dev, iio_dev);
 
 	hw = iio_priv(iio_dev);
 	hw->irq = irq;

-- 
2.40.1


