Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF247E5A2E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbjKHPhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjKHPhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:37:35 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98A3138;
        Wed,  8 Nov 2023 07:37:32 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so11868076a12.0;
        Wed, 08 Nov 2023 07:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699457851; x=1700062651; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I3v/qTt5Ljh3hBbEGrTycTHSp+Yzgj9Ls2qqRIGxJao=;
        b=M8hONW4tLmM4lA3mj70M2Qt7apQyy3O9hgTFa1PMuwOYds9arW/n3gu6wGhvGQ5Ew4
         9ML0zFbZlrfVpsMQGL/Dd68/MIhjwspH/xSNPav0eLRWcMGYzwmlbCsiD3L8G+1p+81M
         SJBa6pniky8AFwvYXUi/X75Qo01Y5HNe8OXd3aqTT1nIDXRvCpG5J/lzHfxz9CX8VBrT
         /99roWaESmQXQhq4Qchf2mn4f0mbpY1uO47OwNHVB5NsrqdVsH5iKPcFur9vtIPyVRQY
         zjt6f8mLqEykBt2eU92FAfULbCgA+l1Y3xk2RQYMPUqqDunOKy4jLh5JflezYp3/X14n
         T4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699457851; x=1700062651;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I3v/qTt5Ljh3hBbEGrTycTHSp+Yzgj9Ls2qqRIGxJao=;
        b=dm076Z2hw8XguHaoO7/I0/v+n59oiEgMrRymCp+EFMVZ0G2XRGpIrxhitK4cs+39k4
         9mxPd/ntm2jht+WT5ssB7rRT8JYb3ubaS4uiEqDgNJlTRx3ghZrOT3BXR31TumC5Q+Q2
         vfCR+nWK3w7lOmSdVEJWbHZBPFdaiEN7CcPp0DWMax5eLafLE5vTxZm4KYnDcZ90gH/C
         kIDnLg3oh9rpPWKTjx7tqKRBHTqRnHmz3YOHZOdUxLNvqXxjgVeUJcPgFh42g4PjThEt
         Ciuqtr9Dix4mrzOhPha7R48tLdktun2YffrrxiB95bsBY3Rt0P2lnIr9uh875Qhftdvm
         t7NQ==
X-Gm-Message-State: AOJu0Yx6VvTbsl9ygFT205tyxm0YsOEMl3tNIW5blV+fJHtUGNtKb/4l
        Dq6cMW+FJ9qcLYN/0mL2g0M=
X-Google-Smtp-Source: AGHT+IFgjSomn5YIoZuSz/TiNggvCkPLex2HMq1HqIb6TjfOqnRW8O0zm1fW5m1y02CQQIj5APjZ6w==
X-Received: by 2002:a50:8acf:0:b0:543:52be:e6ad with SMTP id k15-20020a508acf000000b0054352bee6admr1902290edk.5.1699457851030;
        Wed, 08 Nov 2023 07:37:31 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-840c-82c6-68fb-9a49.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:840c:82c6:68fb:9a49])
        by smtp.gmail.com with ESMTPSA id j28-20020a508a9c000000b0053e3839fc79sm7009966edj.96.2023.11.08.07.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 07:37:30 -0800 (PST)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/4] hwmon: Add support for Amphenol ChipCap 2
Date:   Wed, 08 Nov 2023 16:37:26 +0100
Message-Id: <20231020-topic-chipcap2-v2-0-f5c325966fdb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADarS2UC/3WNQQ6CMBBFr0K6dkw7YERX3sOwKNORTiK0aQnRE
 O5uYe/y/Z+Xt6rMSTire7WqxItkCVMBPFWKvJ0GBnGFFWqsjUYNc4hCQF4i2YjA6Npbe2lqTai
 K1NvM0Cc7kd+10eaZ037ExC/5HKVnV9hLnkP6HuHF7OvfxmJAg26vjMY1vWH3GEYr7zOFUXXbt
 v0AkYYpoMUAAAA=
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699457849; l=2893;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=ayH9nA5zCQkeDYMrIDR2SC44crJoyCpng8mBNefEHdQ=;
 b=f1ArRNO2o4kyjeliZffTZRopfo4+79/RxiamfoDoOPpQggHW+lIaTxxjpl0T4tDALeTRQgc0B
 pvIQVn6ygMQCLGZik5qt5lGUaJq65oSm1Gh0v/6Gc4zaFtDeWOlQ6R5
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support and documentation for the Amphenol ChipCap 2
humidity and temperature sensor in its digital version.

This I2C device provides 14-bit humidity and temperature measurements as
well as low (minimum) and high (maximum) humidity alarms. A ready signal
is also available to reduce delays while fetching data.

The proposed driver implements the logic to perform measurements with
and without the ready signal, EEPROM configuration and alarm signaling.

The features this driver does not support (I2C address and command
window length modification) have been documented in the "Known Issues"
section.

The complete supported functionality has been tested with a CC2D33S
sensor (a 'sleep' device) connected to a Raspberry Pi Zero 2 w.
Different device tree node definitions (with and without regulator,
ready and/or alarm signals) have been positively tested.

The non-sleep measurement mechanism has been inferred from the first
measurement, which is carried out automatically and it is common for all
part numbers. Any testing or improvements with a non-sleep device is
more than welcome.

The tests have also covered the properties added to the hwmon core to
account for minimum and maximum humidity alarms.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- vendor-prefixes: full company name in the vendor description (Krzystof
  Kozlowski)
- chipcap2.c: proper i2c_device_id table, coding style fixes, cleaner
  error path in the probe function (Krzystof Kozlowski)
- dt-bindings: per-item description and lowercase names (Krzystof
  Kozlowski)
- MAINTAINERS: fix manufacturer name (Krzystof Kozlowski)
- Link to v1: https://lore.kernel.org/r/20231020-topic-chipcap2-v1-0-087e21d4b1ed@gmail.com

---
Javier Carrasco (4):
      dt-bindings: vendor-prefixes: add Amphenol
      hwmon: (core) Add support for humidity min/max alarm
      hwmon: Add support for Amphenol ChipCap 2
      dt-bindings: hwmon: Add Amphenol ChipCap 2

 .../bindings/hwmon/amphenol,chipcap2.yaml          |   68 ++
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 Documentation/hwmon/chipcap2.rst                   |   73 ++
 Documentation/hwmon/index.rst                      |    1 +
 MAINTAINERS                                        |    8 +
 drivers/hwmon/Kconfig                              |   10 +
 drivers/hwmon/Makefile                             |    1 +
 drivers/hwmon/chipcap2.c                           | 1022 ++++++++++++++++++++
 drivers/hwmon/hwmon.c                              |    2 +
 include/linux/hwmon.h                              |    4 +
 10 files changed, 1191 insertions(+)
---
base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
change-id: 20231020-topic-chipcap2-e2d8985430c2

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

