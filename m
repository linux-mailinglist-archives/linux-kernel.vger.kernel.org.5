Return-Path: <linux-kernel+bounces-54980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AA784B5D3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3876428A7E9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1116130AC7;
	Tue,  6 Feb 2024 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="URZ0pJGF"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA5812F5B4
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224445; cv=none; b=oGp7uATtpxffJ97ai2uj9aGLu92yIVT1E6KyOrjhdQ54cOmxz8L2gS3/GX9lKYA/7EAAVqDpQKxj4VYK6FiJ4iIZ7Kj1NryAbD9Dvy4KFwJzEOivXSyk75FbPO4s/Xt72hXD0WvFzhcnYamb/9xu+9d777R0NAaUdSSU8cDPogU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224445; c=relaxed/simple;
	bh=1w7no4X/TSio5I2R4KQ+HCwjWlHzizWFvphNMRtKGCc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=okHC4lTvqBMro+mFGR6Ratzl4J0/6A8biqYVG14QqQPjMDt2QyErYjAiaKYrV0dTESwfXD3Ofwf3ex2IAuB3SW+OJF9Y/Mku+1tVmOMP2sWnZLChx8rCiuL8I9c7KZnLbtxBkqXpvZbqIBgVvfO23aDlKyGAuiBin5YjdNoqqNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=URZ0pJGF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d746ce7d13so45385695ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 05:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1707224441; x=1707829241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U01nK5h+ngo0dhzMF9UCzZZGiTta1rkOWaOLNJZe/+U=;
        b=URZ0pJGF/hFWwgeJRAEbkVrnGVTor6eW0gHTYA/YhTDL4ZVK+zcz6tGPvvatZWhtP7
         Taq90wGC/1BVcqXMO8/inoCv64HzyYRIO6RGLwyuMn9N4ck/976pi01CIBYfYSNSkWFN
         o3jSuRMVXMehy2L8Kt9vj3Z/a0pDF33oAVLnetbpdzJVzPCapUSN5Uy+fauHMWCO44C3
         vlxn6uYe4oQ6AwN1jv07D15aLgOeKS65XE+X88efG/FkDOFZBlTpI7xHd5k7ZWWDI5/K
         ADK07Lm5Ub7rdqnAtjbwTLphqw1rJJ2gM78jLv6/CH5IvuVL1u6WjTvB20Rxp2gGjb02
         x5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707224441; x=1707829241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U01nK5h+ngo0dhzMF9UCzZZGiTta1rkOWaOLNJZe/+U=;
        b=v9p8yJtHb3kbmhTCPFxwVPvJw/Rs+RrqubTmT0TQZ5cHYAtodOZr6owMZLVQOmDeTV
         HDu8qJMk8gWi65lUSBilC6qknADO5pFjIbDmhsdxNRz0laSWfyrQAwXMVPkVNw5GmLhs
         jSR9yQLQBRmUS6BtOZ82+xLX2Xpbcpg28wzxsHOSt12HuSSWiAfaFAxQNqkXkr4MUy2P
         C5F07pZ18gJSnquMCyVQQGtqTOdhxAfpifJvAnqjzIz8Ze8zbPeFnCu1Ycvm0lMyfici
         QIsRt0KTgWcb4nVSgbtdb59Js8paBXmdwYw34gvbj9pZ71Ggs4ZXjupa9YkeglXxHpTe
         Heqg==
X-Gm-Message-State: AOJu0YxNegMfSBUMS0S3rhFTNXuvCbJiZIlU3ZJmVPWjV6p69lQb0pyA
	hyD41CyR7gMmlytvK+NAbQ+NM/vgtAy2g8YlE2StgdiW8Z9++nXdb3DItRkLvfs=
X-Google-Smtp-Source: AGHT+IHFgHjBIvvXH43AzashyL+Nkfw1PtmIh93FS/4fpoAw1KGAydkF2t9AxzBQ48m86erUFiwWQw==
X-Received: by 2002:a17:902:ec82:b0:1d9:bfde:d635 with SMTP id x2-20020a170902ec8200b001d9bfded635mr1840947plg.18.1707224441315;
        Tue, 06 Feb 2024 05:00:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXOJQHJU9Oz3p9XWjTbHw/WyO+Rlhgcc+2HZgEMyidPNmSn/L8tiuqJqiqBpeLN5vT8Zh52uxfXYcGZubDu6QjGS1zwpTJCcXYfF2t3pxu6Xyx327nNCknP7EnMEGqp2cyK9NGDIl2Oxg+WzTifHJabltoTAPoFuSBWlF//1AZH5/sdJsFdn8nDyRJUMUWoLn5shFzGRbBLKGDfr5CxCOmfUhY4U0318peVENbBs0Oy+PnuXtNxUQDpldM3m5B1ZwjuWA7d+ygCvru11CqiEnLYIjJvtdmvJ+oXttAGI08V/cUbfRPfAjT94aayaAMSF5OKNCNYhY9Yd2k9Fv78MHmUsNjHinlrQTEw0mirbq3tfWRacfgh3S1rnZrTJFVW4LmqXRvGzki+BR+dSEzsP+L/Xy3fjedjFuOq63R/u4Umv0AgqUGssqKenP6G0V9q4xPZc/CQZPpIozmjULmTuEH3Zv905PLeQMSOvJ0ziUwe9Udx2WCFVVd6A6d7l6HWolo2AmWfalabNWNwseAghoZCjYX9hQ==
Received: from localhost.localdomain ([180.150.113.62])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902ea0100b001d958f8ab2bsm1782167plg.107.2024.02.06.05.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 05:00:40 -0800 (PST)
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marek Vasut <marex@denx.de>,
	Anshul Dalal <anshulusr@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Matt Ranostay <matt@ranostay.sg>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/5] Support for Avago APDS9306 Ambient Light Sensor
Date: Tue,  6 Feb 2024 23:30:12 +1030
Message-Id: <20240206130017.7839-1-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support for Avago APDS9306 Ambient Light Sensor.

Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor.
It has two channels - ALS and CLEAR. The ALS (Ambient Light Sensor)
channel approximates the response of the human-eye providing direct
read out where the output count is proportional to ambient light levels.
It is internally temperature compensated and rejects 50Hz and 60Hz flicker
caused by artificial light sources. Hardware interrupt configuration is
optional. It is a low power device with 20 bit resolution and has 
configurable adaptive interrupt mode and interrupt persistence mode.
The device also features inbuilt hardware gain, multiple integration time
selection options and sampling frequency selection options.

This driver also uses the IIO GTS (Gain Time Scale) Helpers Namespace for 
Scales, Gains and Integration time implementation.

Link: https://docs.broadcom.com/doc/AV02-4755EN

1 directory, 18 files

v5 -> v6:
 - Changes as per review
 - Update kernel doc for private data
 - Change IIO Event Spec definitions
 - Update guard mutex lock implementation
 - Add pm_runtime_get()
 - Update styling
   Link: https://lore.kernel.org/all/20240204134056.5dc64e8b@jic23-huawei/
 
v5 -> v6 Bindings
 - Write proper commit messages
 - Add vdd-supply in a separate commit
 - Add Interrupt macro in a separate commit
   Link: https://lore.kernel.org/all/1d0a80a6-dba5-4db8-a7a8-73d4ffe7a37e@linaro.org/

v2 -> v5:
 - Bumped up the version:
   RFC->v0->v1->v2->v3 (Earlier scheme)
   v1->v2->v3->v4->v5 (Scheme after review) (Current scheme)
   Link: https://lore.kernel.org/all/20231028143631.2545f93e@jic23-huawei/

 - Added separate patch to merge schemas for APDS9300 and APDS9906. Added
   APDS9306 support on top of that.
   Link: https://lore.kernel.org/lkml/4e785d2e-d310-4592-a75a-13549938dcef@linaro.org/
   Link: https://lore.kernel.org/lkml/20231028142944.7e210eb6@jic23-huawei/

 - Removed scale attribute for Intensity channel:
   Link: https://lore.kernel.org/all/20231204095108.22f89718@jic23-huawei/

 - Dropped caching of hardware gain, repeat rate and integration time and
   updated code as per earlier reviews.
   Link: https://lore.kernel.org/lkml/20231028142944.7e210eb6@jic23-huawei/

 - Added descriptive commit messages
 - Fixed wrongly formatted commit messages
 - Added changelog in right positions

 - Link to v2: 
   https://lore.kernel.org/lkml/20231027074545.6055-3-subhajit.ghosh@tweaklogic.com/

v2 -> v5 Bindings:
 - Removed 'required' for Interrupts and 'oneOf' for compatibility strings
   as per below reviews:
   Link: https://lore.kernel.org/lkml/20231028142944.7e210eb6@jic23-huawei/
   Link: https://lore.kernel.org/lkml/22e9e5e9-d26a-46e9-8986-5062bbfd72ec@linaro.org/

 - Implemented changes as per previous reviews:
   Link: https://lore.kernel.org/lkml/20231028142944.7e210eb6@jic23-huawei/
   Link: https://lore.kernel.org/lkml/22e9e5e9-d26a-46e9-8986-5062bbfd72ec@linaro.org/

Subhajit Ghosh (5):
  dt-bindings: iio: light: Merge APDS9300 and APDS9960 schemas
  dt-bindings: iio: light: adps9300: Add property vdd-supply
  dt-bindings: iio: light: adps9300: Update interrupt definitions
  dt-bindings: iio: light: Avago APDS9306
  iio: light: Add support for APDS9306 Light Sensor

 .../bindings/iio/light/avago,apds9300.yaml    |   20 +-
 .../bindings/iio/light/avago,apds9960.yaml    |   44 -
 drivers/iio/light/Kconfig                     |   12 +
 drivers/iio/light/Makefile                    |    1 +
 drivers/iio/light/apds9306.c                  | 1335 +++++++++++++++++
 5 files changed, 1363 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
 create mode 100644 drivers/iio/light/apds9306.c


base-commit: b555d191561a7f89b8d2108dff687d9bc4284e48
-- 
2.34.1


