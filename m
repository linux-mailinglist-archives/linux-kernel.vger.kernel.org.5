Return-Path: <linux-kernel+bounces-38182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B749B83BC18
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71382285904
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C52717735;
	Thu, 25 Jan 2024 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wivu03eQ"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD42C17BD4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706171715; cv=none; b=MCKmBxdbPOiNXNi7AkV4tdn2L5+lWqlWLGYF9aUzMf57X7gwFHXQ/STCG767vDEi0nmT71CDtPG2u2QuESgLG4oJatIrTuPPHkpkJgRCx+0dO3VpPA/r8wr7DM2QFp9t2kfexC8dnOfuZ82S2Ir1AVQKbb8utNJ2i6YnWmNxzmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706171715; c=relaxed/simple;
	bh=yi/4Czfks9LIWr5CkZUzmlQI1+oB5EfuKTiOSgTBaH4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=e2rmsTQhVN/bBZUzZQWqRilp3mtJLNoskyTfFIUuEuQAtHWLvwoLY+lJQE4cm8gi1rlWUIu/Dr+5URKG7de4HcyY3R5aM5janOA3Fa9HVEu7jeKT0Fx/fxwLWOJZC99wmj07/PpiF3FbodZVxO8tNPgTYl+RwW3fOT7zeH3DqpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wivu03eQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e60e135a7so63255015e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706171710; x=1706776510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r7cb1ndwKgmJR9epTnoZNNIKyvDAN1904iU4WrDFcng=;
        b=wivu03eQIK/7YqSYXj04yMQptdU1+igmE3F0+A7hBlTceyGJyEcA7Wkgml7Q64cEYK
         F8mERcOIY/EIJBpPFmnxEeZwj5P+CbokimNJ04YTW/5Iga9joBwGcJE3uCL8bFyncJW0
         JAaYgzn+ua8G8qPuOnFOnMIgLjwQYRWclQZ2sZufZYAYO0eZ4pS602pwmHE4Khzi6cYu
         WgqJr7eiD020lCF/xkkM6/kJfT8jOwbAzzO7JIL+E4k0VUYeCZdpP7HjaMP2b79Mywlm
         qRdSLhffMW1VMKbbvGAoFRKBgr4QnHR7v+ypEp4hyD0lUl19ldfTaTODDJXJt7rt4/TB
         SQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706171710; x=1706776510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7cb1ndwKgmJR9epTnoZNNIKyvDAN1904iU4WrDFcng=;
        b=Ood271E3vDOSWQ/+5zKUsUSzMOL/cbRltKHernSoa9rJh+J0PhPdSrQOWGsCBFRKFH
         oGh5hKd8okqMnvmA2nOv8ck9RuuAMXfJBGg/vxfkmXW+F8l1NMBINtg8D2flYVIBOWl/
         JcmEyTCBwbfhyLxyUCxNKuweS2mqBLQZhSxwLgfq4C6MrOcoeuNDg+MB1649vVhC6s8I
         s5b9HJSdP2399NsMnMwIV25SiKxs9xGCO6vKII6TSxFhRQj2rxwb7fuysNS/5e8IMbVM
         faejut5mLZ2JZ32lnZVqBYv9tWkVnBvlF1Ko2M0vOjh+bpMKUBDFsiGrWAr5TEEGj2zH
         tmAw==
X-Gm-Message-State: AOJu0YzbPBhI/qjgG7oZHJLXgpVhvX330aYo07bS74f2G/A108jm9DH7
	okVdDDRKIAFB1iv3K0zXE0mJMdFpYEgsFhq3LmuZ9XLlEGhlFmFXx8k5NWBHfrY=
X-Google-Smtp-Source: AGHT+IEhTd+knmYT5ge0F8Dk7Hl9LXxICTxlv+/zSYtcEvZDA79lZLulIp9/0fBqOZ39iDPOfMhYWg==
X-Received: by 2002:a05:600c:511d:b0:40e:50ac:d24e with SMTP id o29-20020a05600c511d00b0040e50acd24emr402802wms.13.1706171710048;
        Thu, 25 Jan 2024 00:35:10 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:5c05:1552:a486:c7ef])
        by smtp.gmail.com with ESMTPSA id w15-20020adfec4f000000b00338a3325331sm15435858wrn.69.2024.01.25.00.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 00:35:09 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	=?UTF-8?q?Jos=C3=A9=20Guilherme=20de=20Castro=20Rodrigues?= <joseguilhermebh@hotmail.com>
Subject: [PATCH v2] gpio: improve the API contract for setting direction
Date: Thu, 25 Jan 2024 09:35:07 +0100
Message-Id: <20240125083507.25213-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

If a GPIO driver returns a positive integer from one of the direction
setter callbacks, we'll end up propagating it to user-space. Whether we
should sanitize the values returned by callbacks is a different question
but let's first improve the documentation and fortify the contract with
GPIO providers.

Reported-by: José Guilherme de Castro Rodrigues <joseguilhermebh@hotmail.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
v1 -> v2:
- add a mention of 0 being return on success

 include/linux/gpio/driver.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 9a5c6c76e653..90cd57796b36 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -335,10 +335,12 @@ struct gpio_irq_chip {
  *	(same as GPIO_LINE_DIRECTION_OUT / GPIO_LINE_DIRECTION_IN),
  *	or negative error. It is recommended to always implement this
  *	function, even on input-only or output-only gpio chips.
- * @direction_input: configures signal "offset" as input, or returns error
- *	This can be omitted on input-only or output-only gpio chips.
- * @direction_output: configures signal "offset" as output, or returns error
- *	This can be omitted on input-only or output-only gpio chips.
+ * @direction_input: configures signal "offset" as input, returns 0 on success
+ *	or a negative error number. This can be omitted on input-only or
+ *	output-only gpio chips.
+ * @direction_output: configures signal "offset" as output, returns 0 on
+ *	success or a negative error number. This can be omitted on input-only
+ *	or output-only gpio chips.
  * @get: returns value for signal "offset", 0=low, 1=high, or negative error
  * @get_multiple: reads values for multiple signals defined by "mask" and
  *	stores them in "bits", returns 0 on success or negative error
-- 
2.40.1


