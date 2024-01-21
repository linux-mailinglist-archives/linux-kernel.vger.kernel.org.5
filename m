Return-Path: <linux-kernel+bounces-31966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 612EA835489
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 06:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9753B217A2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 05:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E442A3612E;
	Sun, 21 Jan 2024 05:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="J2WFLoj3"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF7022063
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 05:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705814270; cv=none; b=fgARi2vftl4zjZDlQ5ymkcoIh7jdqD8SslUeooTKqTmW8rKkvsrO2/P4lqMZe4vKCC1/8coB/bKwid/7k4JqP/OuyCJDRDj/XbyuL5G+6TWur+cPm/RZQBjqB7ugSNocCJflYH5qPjWlguqJkrXsAU+7gUR9ZvEaQZYZB9FKSZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705814270; c=relaxed/simple;
	bh=ipSzNcsozIyMfm06SP86zDpf6H5Wpu46NsfyrOWklmw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SjTiVPINr4vYjMdL+Vs07SbrE2AxqmW8HM4WDBXFhZlsSqSe6wUXEx+FHOhS37MGWfHGFbU6KGaYoxst9IizOgwvdW/yN2EFWQAM3N6fhkj/Rd2N99Eemc7i1JKkM8ST9diDzefGs/tXsczaYcQTUdTnD7KkQeEv6PLZjq5m9G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=J2WFLoj3; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6dde290d09eso1520765a34.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 21:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1705814267; x=1706419067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=otpPQ8q+RYv1jY1aPkVNIU5dIBW1JVgH90JU2MjCsBQ=;
        b=J2WFLoj33LFLj0z7qmBk1JYhANnvrYTuHLAQp+c3ZowlSq542Hd8XbPduc/bA1qqqq
         /a3Y7S6d6fTfpZ4J6flWiGdt1eSab3rIl9UoZguTsJ0TeJ8G7gYeExopnXZvyDsP1/un
         sboQWcENthv1NUeFrHLqKATHyXQHrxDoJEKoEGlKG1tiLdNn0bXYZfcuEbK+XsyJhvqF
         ScRCuqGK6mCqNkR9AK1I9eLwb48v6Moo0YKan8ri31y7pO0QR4U8pm+NVMdNEvLFL2EZ
         ZYbZtSBWqlnc8eP/mfssFSMnROEBXpXV2NZ3JEcsIK3m31k4NbYGLs0Pbu1upx636MbG
         xo0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705814267; x=1706419067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=otpPQ8q+RYv1jY1aPkVNIU5dIBW1JVgH90JU2MjCsBQ=;
        b=tfeUVNgjXIucsp7mx4zwsTjcLOvmYUPdXwKblcuFM8aj3KPo/GTvLQcNlMGXpZCGxj
         e/7l/ookBVg8Azpew01PFS1WZzTMuiXGV8Zh4rqnLQwxm3JHEOl7KHU1FJk2Z1olxK0w
         gSuVgJsMlnjNnGP1EevLTQ6JmxcfOFis064UnMqU+rZguF5dg8sBEb/dtjcf5wEGgyj5
         mSUox42wmA4YegzcfHErnwCkXniYizPDrrAtnjEC8Fi7oWZVMTA98ulWrnqU95mIZR/s
         TU/90y3KWhb1ViRnMJmPcU4a/6DHrR4DALtJafgYHASZ/rt33zuY75kgvuymMcroaPHS
         U/HA==
X-Gm-Message-State: AOJu0YxO2YEVuqGlZnSzIT10wHS901fX/FAXCzRxBSKocAsqkVSRa+bl
	XlUJp0D0OumxaOp6n7kXCw1nFB8gPiKxK33IzEt8sAluc95hjcaz0/gmwFzumCk=
X-Google-Smtp-Source: AGHT+IFjrlRD3S7LUFUoGzjiX/iBPQs5LaZQu5bQcftam28+svxRNCxSKkXJ6A/wYG4uCIuOQlLlwQ==
X-Received: by 2002:a9d:64ca:0:b0:6d9:d144:c9a9 with SMTP id n10-20020a9d64ca000000b006d9d144c9a9mr2574521otl.22.1705814267257;
        Sat, 20 Jan 2024 21:17:47 -0800 (PST)
Received: from localhost.localdomain (2403-580d-82f4-0-3fa1-f9ce-6074-3bab.ip6.aussiebb.net. [2403:580d:82f4:0:3fa1:f9ce:6074:3bab])
        by smtp.gmail.com with ESMTPSA id f6-20020a056a000b0600b006d96d034befsm7547196pfu.30.2024.01.20.21.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 21:17:46 -0800 (PST)
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
Subject: [PATCH v5 0/3] Support for Avago APDS9306 Ambient Light Sensor
Date: Sun, 21 Jan 2024 15:47:31 +1030
Message-Id: <20240121051735.32246-1-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support for Avago APDS9306 Ambient Light Sensor

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

Following features are supported:
  - I2C interface
  - 2 channels - als and clear
  - Raw data for als and clear channels
  - Up to 20 bit resolution
  - 20 bit data register for each channel
  - Common Configurable items for both channels
    - Integration Time
    - Scale
  - Interrupt (event) interface
    - High and Low threshold interrupts for each channel
    - Selection of interrupt channels - als or clear
    - Selection of interrupt mode - threshold or adaptive
    - Level selection for adaptive threshold interrupts
    - Persistence (Period) level selection for interrupts

root@stm32mp1:~# tree -I 'dev|name|of_node|power|subsystem|uevent' \
/sys/bus/iio/devices/iio:device0/
|-- events
|   |-- in_illuminance_thresh_either_en
|   |-- in_intensity_clear_thresh_either_en
|   |-- thresh_adaptive_either_en
|   |-- thresh_adaptive_either_value
|   |-- thresh_adaptive_either_values_available
|   |-- thresh_either_period
|   |-- thresh_either_period_available
|   |-- thresh_falling_value
|   `-- thresh_rising_value
|-- in_illuminance_raw
|-- in_illuminance_scale
|-- in_illuminance_scale_available
|-- in_intensity_clear_raw
|-- integration_time
|-- integration_time_available
|-- sampling_frequency
|-- sampling_frequency_available
`-- waiting_for_supplier

1 directory, 18 files

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

Subhajit Ghosh (3):
  dt-bindings: iio: light: Squash APDS9300 and APDS9960 schemas
  dt-bindings: iio: light: Avago APDS9306
  iio: light: Add support for APDS9306 Light Sensor

 .../bindings/iio/light/avago,apds9300.yaml    |   20 +-
 .../bindings/iio/light/avago,apds9960.yaml    |   44 -
 drivers/iio/light/Kconfig                     |   12 +
 drivers/iio/light/Makefile                    |    1 +
 drivers/iio/light/apds9306.c                  | 1315 +++++++++++++++++
 5 files changed, 1343 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
 create mode 100644 drivers/iio/light/apds9306.c


base-commit: 9d1694dc91ce7b80bc96d6d8eaf1a1eca668d847
-- 
2.34.1


