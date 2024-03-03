Return-Path: <linux-kernel+bounces-89918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A7286F74C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5148C1F21184
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 21:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99E77A71F;
	Sun,  3 Mar 2024 21:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5NQQIZe"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89066BA33;
	Sun,  3 Mar 2024 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709502867; cv=none; b=VB+s+iKoe+Sz2qx2Z9gNc+uEjmcToYtYm7r7/8wb+90Pz6We533FksQDd0tyTPf82048oOL21zOpOk7yCZzQs+t31U++pUvIe7KH3BjOrxZhzKfzU3s+oDRGm7bk7D1uBLKpudAgprsnU2PFPffQvJ8jjN/9OYilgDagzRHHsTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709502867; c=relaxed/simple;
	bh=J4/vUGcKMLRc7eKsXpAfRNOfuulhtF8ewzuI27Q8VaE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AohibKXxK+9pdxMaf+OJYJWYD8ofPCBrxd+4ffRF943dHzPr9MQVfR3Ik/0h4kPx9fGXOLezXgK3S95DEC3KbslKkjhkZPe2bUcEUcmKgV0EDXtXj+3r4DueCcqZ7b5cggMrYnD0aXAchY/A7Nj/ce8MbgZ/M33slr4nwFKukIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5NQQIZe; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-566e869f631so2421241a12.0;
        Sun, 03 Mar 2024 13:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709502863; x=1710107663; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jtiYH4zwlx8zDDEXeMfd+INoXxmmkFyqY1aEjdjWv3c=;
        b=F5NQQIZeLBvEaFplE9GMbcLHGyz/1/RuZDY8Y9UHlEp1SX7o9zNH9x9sYfUQ1Ya4oF
         uiW3+XLk9c2OgKxJInvFzzXUEMq/4YY48hwZI5pxLGsVWkjyYFh1CfuBGrlVT3w9BLO6
         rn5y1OJ3uRoK1DVHU69XTVgM4jdq1Cz6Cfw6nbUPt0D9V1z+hz4SedyI4Wizq0lxBq0D
         EH9K92S52/m9+zzlyYONXW5rW8mHsgjrCvSrb1h7XhQwDb0GjawRy8Lkue7fNoMYUd7V
         mOtOpGWnRZddXe9q3jV2cbv8D669ophiDWH8eWadlkKSOvhM0g9z3WkwSexYbo6f/yGE
         nUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709502863; x=1710107663;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jtiYH4zwlx8zDDEXeMfd+INoXxmmkFyqY1aEjdjWv3c=;
        b=MFwrnCIE4GX6f4nmR+82x7LNoY46g3aI7DzsV5ZRU6cZ4RO9MVfaP4m8NzAKXxJGAV
         uVBf8Ki6mmjjTjU7fExuPy54KFNvv934au/Bn/DNwTpo1He/skF2ZsNK32w2bka5fbXO
         1LpuPA+H5t9fIuuT4+JOoK+84FBraelxEa4Ovi2ptmweeedkL5Wh7xU6PYtJmq3R963J
         9KS35bmBAyEOjogTUnVQphX/ZPpywxwp6Qr1zRsEUwuUqkd3QszSHK+w0TwOLZcS6qIe
         UcC+NOJ2faxNjINPce9A5I8vFoeOETDG2g0sTauOIC84krP4pYry0NKZuXJBti8BHqGO
         Aokg==
X-Forwarded-Encrypted: i=1; AJvYcCVz/gA0YC5Q8yzWVoSwIO6/ckGnXQlKtJjea1ByqP4+aKJTy3jOH19drCiNNMnRi8ctR+J/oopkZ5q0W7wa7Z1Ubu/0QAlLy/ha5hKhbJxWv8g/TINs8YhyyW3JwE+FB0s5dW3VN1WriM49c97a5eaFKlQTiP5fhVBj8CFw7PZ6W1KByA==
X-Gm-Message-State: AOJu0YwFBqQ+INh87xf0UxssMhbfIwZbfB61lskcVoN1Cxdi5gI2ynOu
	1xAEj+mfKl3YlbpOx45deP8QeUakKPyUBx4oTYEnLa/05odfe9jPtJxZ3KmKJpK4BA==
X-Google-Smtp-Source: AGHT+IFURnvfsrmdeeT7oJVpTrft22PDN45pKLs5QXJHtXM4qffTQRge1FoZTpt4WidDmrD1ZbxixA==
X-Received: by 2002:a50:c943:0:b0:563:c54e:f1 with SMTP id p3-20020a50c943000000b00563c54e00f1mr5296169edh.2.1709502863284;
        Sun, 03 Mar 2024 13:54:23 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b3d8-5b4b-5188-4373.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b3d8:5b4b:5188:4373])
        by smtp.gmail.com with ESMTPSA id n22-20020a05640205d600b00566d6950d14sm2783250edx.92.2024.03.03.13.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 13:54:22 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v3 0/3] iio: humidity: hdc3020: add power and reset
 management
Date: Sun, 03 Mar 2024 22:54:19 +0100
Message-Id: <20240303-hdc3020-pm-v3-0-48bc02b5241b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIvx5GUC/1XMQQrCMBCF4auUWRuZJJKkrryHuGiTsR2wtiQSl
 NK7mxYXdfkefP8MiSJTgnM1Q6TMicdnGfpQge+bZ0eCQ9mgUJ1QSSv64DUqFNMgpLW104G0b1o
 oYIp05/cWu97K7jm9xvjZ2lmu7y9T+C6TpUARHBkMLdma6ks3NPw4+nGANZPVnpo/qgr15I01B
 p0ht6fLsnwBeGXZIN8AAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Li peiyu <579lpy@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709502861; l=2134;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=J4/vUGcKMLRc7eKsXpAfRNOfuulhtF8ewzuI27Q8VaE=;
 b=dpPmkVmCIKpkL4MlOOZHOMbSnBSGNk6MMVhwhsPilqxiM4EG4Mj9kok7iobbAONnePvk968KC
 P+g4TXVJ/RACZcEo4TcUdmaLgkDRdU3wvn7Mu0dJk1+aT7z4H2do92J
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

This series adds power management for the hdc3020 humidity and
temperature sensor as well as control over the reset signal the device
provides.

The hdc3020 carries out measurements automatically, which is not
necessary in low-power modes. Furthermore, if the low-power
configuration turns off the device, proper initialization is required to
account for the setup times and initial status register value.

This device provides an active low reset signal that must be handled if
connected. This signal can be used by the driver to keep the device
under minimal power consumption during low-power modes if the power
supply stays active.

This series uses char-misc-next as basis to include the last additions
to the driver to handle events [1] as well as the fix to include the
entries in the Makefile and Kconfig files [2].

[1] https://lore.kernel.org/linux-iio/20240214085350.19382-1-dima.fedrau@gmail.com/
[2] https://lore.kernel.org/linux-iio/20240121135123.71506-1-jic23@kernel.org/

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v3:
- Drop unnecessary casting to void in dev_set_drvdata.
- Call devm_add_action_or_reset right after powering on.
- Link to v2: https://lore.kernel.org/r/20240226-hdc3020-pm-v2-0-cec6766086e8@gmail.com

Changes in v2:
- Trigger power off sequence if the power on sequence fails.
- Check return value of hdc3020_power_on() in the probe.
- Remove type casting for void pointer.
- Link to v1: https://lore.kernel.org/r/20240220-hdc3020-pm-v1-0-d8e60dbe79e9@gmail.com

---
Javier Carrasco (3):
      iio: humidity: hdc3020: add power management
      dt-bindings: iio: humidity: hdc3020: add reset-gpios
      iio: humidity: hdc3020: add reset management

 .../bindings/iio/humidity/ti,hdc3020.yaml          |   5 +
 drivers/iio/humidity/hdc3020.c                     | 111 +++++++++++++++++----
 2 files changed, 97 insertions(+), 19 deletions(-)
---
base-commit: d4551c189d6e6a3fcf7f625bd4b273e770fad35a
change-id: 20240217-hdc3020-pm-177983de3cab

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


