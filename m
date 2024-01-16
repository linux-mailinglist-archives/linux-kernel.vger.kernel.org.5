Return-Path: <linux-kernel+bounces-27513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6386D82F16A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1276D285F33
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24E21C28C;
	Tue, 16 Jan 2024 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk1oCerd"
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6F81C280;
	Tue, 16 Jan 2024 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-40e800461baso13734165e9.3;
        Tue, 16 Jan 2024 07:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705418639; x=1706023439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5kUve3GsK0Znh1zMTbIWNl2BlOdDI5b4S54T/wpdaMo=;
        b=Kk1oCerdi+DrzE/PMMqVOMudVvCUirCS36KK7xFXrx//MxjqrdV49m2ho+PC2okaxG
         IpLbF1J9XZe1ghAvEKAohcQJCpfJoiHd9gsM1ok/O5AJ2gwx+wMSZdZMkqkwEuvit2xz
         ukQKafuvNyB+qizDbHzu1slax7ImsC+a0OrGuQyXDLbggQE8+gf2gb2BA47bQgkWuwUw
         LuFrJM763hnFVfml0tcNoqOWYrlt2T3Gd4+B+2HkDMIPjuUXiSfBpiAVA6jvfmN3yYXI
         hLq0iT24N6FdtI2kBpbeJsoMFHGB8nkgrCbGyiAPkynHMycxjW0/ebpA6FMWYeY1ZVpC
         0RHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705418639; x=1706023439;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5kUve3GsK0Znh1zMTbIWNl2BlOdDI5b4S54T/wpdaMo=;
        b=G54W4yOcpbvVM8a1bUe6D0YraKR5xY3Mq5cQvAciXuIufcV168WDFo5AdWibcFilj6
         zo+z4hW83FeaqyjOUoQsLTCJizo5syYOGCOnRgFv1mnqwVagarZYhfddt+dvRsaxzht2
         X5csRdCXPRuftpginKWaQfKfuSLarPET0mpHmSirSrYau2oFTDk9WCojL4vWzEmjgefV
         Xu5YaI598jxG/pgPvGt5PKD83I5W+++enbzmBXKa9SXIFNy+OvdAZQcMhKF9pZQtM9gf
         ieG/4XTjP45FmOJWHGAr8/33lSpptcLg7tB0J8Aa5TtIKQPi4L5+L11X0LTq33B5G6Yj
         pRTg==
X-Gm-Message-State: AOJu0YzU1F540zou1c/ACPxqqFpW3egG9FZ3DOw+bRHykpiJrOSdVphS
	tQ/LdzRbeU3QNOIrqlOG0K2bCJHJ8MitIxkFCQYrBZsjTbytXjgJ
X-Google-Smtp-Source: AGHT+IFxsCcYJGqh+Tmk1XLGzHq0yRdix6WX1WWglSGvdRMML25l4OzfRV0eYXqS6Jg6E1Hty+uPgELLsGppPofl3yI=
X-Received: by 2002:a05:600c:84c3:b0:40d:6f33:601c with SMTP id
 er3-20020a05600c84c300b0040d6f33601cmr2113490wmb.17.1705418638806; Tue, 16
 Jan 2024 07:23:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Petar Stoykov <pd.pstoykov@gmail.com>
Date: Tue, 16 Jan 2024 16:23:48 +0100
Message-ID: <CADFWO8EjGHq4Y=xnK30acmakgWdtzxJvLBE-i5YZAFNUM13nNQ@mail.gmail.com>
Subject: [PATCH 0/3] Add support for Sensirion SDP500
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Angel Iglesias <ang.iglesiasg@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch series introduces support for Sensirion SDP500 in the IIO
subsystem. The series is split into three patches:

1. The first patch adds the device tree bindings.
2. The second patch implements the device driver.
3. The third patch updates the MAINTAINERS file.

The driver is relatively simple. It provides a way to read the measured
differential pressure directly in Pa, as the device has a fixed scale
factor of 1/60. When an applications wants to read the pressure value,
3 bytes are read from the device, 2 are data and 1 is CRC8. If the crc
check passes, the calculated pressure value is returned in Pa units.

The initialization of the device just starts the measurement process.

We have been using this device and driver in a product development for
almost a year now. There the pressure is read every 25ms and is used in a
control loop. We have not even seen crc errors. We are using the
"linux-imx" repository and not the mainline one but I see no risky kernel
functions in use so it should be fine here too.

All feedback is appreciated! Thank you for taking the time to review this.

Petar Stoykov (3):
  dt-bindings: iio: pressure: Add Sensirion SDP500
  iio: pressure: Add driver for Sensirion SDP500
  MAINTAINERS: Add Sensirion SDP500

 .../bindings/iio/pressure/sdp500.yaml         |  38 ++++
 MAINTAINERS                                   |   6 +
 drivers/iio/pressure/Kconfig                  |   9 +
 drivers/iio/pressure/Makefile                 |   1 +
 drivers/iio/pressure/sdp500.c                 | 201 ++++++++++++++++++
 5 files changed, 255 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/sdp500.yaml
 create mode 100644 drivers/iio/pressure/sdp500.c

-- 
2.30.2

