Return-Path: <linux-kernel+bounces-10382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F8D81D396
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 11:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33F21B226C9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 10:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F278FC2EB;
	Sat, 23 Dec 2023 10:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWt05BGt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E80CA43;
	Sat, 23 Dec 2023 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d4ebcc207so5510725e9.3;
        Sat, 23 Dec 2023 02:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703328376; x=1703933176; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VmCUTjEBhNnmIo8VJmDjPt4XMX91bTjsXLeGaAh5HxQ=;
        b=hWt05BGtMiRT/sPjFZ3P19JN7F4vMXBP0LabbBDzKJwxu5jqF+DJLSZ+pzZgNeH5YD
         VQLLbxUpEUb2NNo0VqoLl3rb+vtRVGm3WteoNLjX313Wg62J0hRE7nvI3wNDkr6LAhIF
         srsqsI7y1TZYvamTZC3RhiZFU3xi6YvKgZmZTMIhbzIRjKns3MOiPXpVVi8pHF+hOFIx
         gTzYLmsSpvrtR4Jxsx4vChr20sgEHRyEwagoVnEgQ7XGPbKkdqPSHu7Q82hoQKU14SKq
         zUhTVC0hQE0ZX4MlNQwNJmtYUV5aJXaDy5vFEglct33fsCIIa/BCSmuXvJapFWLmSAgW
         OdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703328376; x=1703933176;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VmCUTjEBhNnmIo8VJmDjPt4XMX91bTjsXLeGaAh5HxQ=;
        b=tm21FkH+aiqYfghT6QXZnPs5FTzUAX+2ea8hMjidf/gqKWs8SKq8pmYxQWs8+EQf8C
         Gve0BFDKg9T5OvNAqoe8IpIy42DZM20Phyb2ACwfpsG4zYA7EZBwXM4QFJv6FQz0mUGe
         oa2OOf5AUodOov/FlRhgTw4QUQa2PJ0VjwwTGz9LBKMq0v7I01GlRWo3fmj7GxCgXwkf
         ifYJOpcENXwsLTZwJu3m86QRbTq5jAv54ev0soa9yovXAcMZH7IdX8827668iLC5wYbt
         Y4dqWjqYyklHNuet8h8lJs8n9sCB0vWI6Gu999AVJ/vTx8xxZWsSPN7trC9nhiPjYQM/
         vAUQ==
X-Gm-Message-State: AOJu0YwK5v6a/viU5zC3tXsBMV8sx7KXWT7p+zQRGWtkAiNXngiP16SM
	174qLss2lUVX1s3xVN2Epj4=
X-Google-Smtp-Source: AGHT+IF8w817v8UHUMSa24J8ldDTncSwJjfvnwEEeGDJGzNe0RL7YL8ZRvaTOqBO1n4hRRKa6JHmyQ==
X-Received: by 2002:a05:600c:16c9:b0:40d:3076:1f25 with SMTP id l9-20020a05600c16c900b0040d30761f25mr1614458wmn.151.1703328375789;
        Sat, 23 Dec 2023 02:46:15 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-a224-d056-3f15-a90a.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:a224:d056:3f15:a90a])
        by smtp.gmail.com with ESMTPSA id fc13-20020a05600c524d00b0040b3867a297sm10045373wmb.36.2023.12.23.02.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 02:46:15 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] iio: light: add support for AMS AS7331
Date: Sat, 23 Dec 2023 11:46:12 +0100
Message-Id: <20231220-as7331-v1-0-745b73c27703@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHS6hmUC/x2M0QqDMAwAf0XybKFN0Ym/MnxIa7YGpJOGyUD89
 wUf7zjuBOUmrDB3JzQ+ROVTDULfQS5U3+xkNQb0GAOid6SPGIObJsIhM6dxXMHiRMouNaq5WF6
 /22Zyb/yS331/Ltf1B6hb6QJtAAAA
To: Christian Eggers <ceggers@arri.de>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703328374; l=1825;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=8Hyp8queNBcFh/suzXflHND+ylv1jwIwZ27x2YE62rg=;
 b=6NE7Xl6AdL5EkIJbfHTfNbI2lgxgHWUHVV7dKavVxSi8H80Mjbco2oifUAVLJ0fF/8uceKUdj
 dXJaYnKLZ5xACOm4p6ndGkX8zLv4V5gQ2qdD5EcUn2S5fnatJu/7y72
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The AMS AS7331 UV light sensor measures three ultraviolet bands (UVA,
UVB and UVC, also known as deep UV or DUV) as well as temperature.

This device is practically identical to the AMS AS73211 XYZ True Color
sensor that is already supported by the iio subsystem, except for the
photodiodes used to aquire the desired light wavelengths.

In order to reuse code and reduce maintenance load, this series extends
the AS73211 driver to support the AS7331 as well.

Note that the UVA and UVB light modifiers have not been merged into the
mainline kernel yet, but they are already available in Greg's char-misc
git tree which can be found at
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The original device AS73211 supported by the driver could only be tested
briefly due to the lack of hardware. Instead, the i2c-stub module has
been used to make sure that the driver registers the iio device properly
and the attributes exported to sysfs are correct. Some basic register
assignments reported the expected intensity scales and in principle
nothing else should have been affected by the modifications in the code.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      dt-bindings: iio: light: as73211: add support for as7331
      io: light: as73211: add support for as7331

 .../devicetree/bindings/iio/light/ams,as73211.yaml |   7 +-
 drivers/iio/light/Kconfig                          |   5 +-
 drivers/iio/light/as73211.c                        | 146 +++++++++++++++++----
 3 files changed, 127 insertions(+), 31 deletions(-)
---
base-commit: e9215fcca2561b208c78359110ee4009b454f761
change-id: 20231220-as7331-88a25ceeb66d

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


