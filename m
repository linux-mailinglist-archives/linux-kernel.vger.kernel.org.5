Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B19F7A89FC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbjITRDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbjITRDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:03:30 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B869AF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 10:03:21 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-317c3ac7339so49750f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 10:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695229400; x=1695834200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pzNel1zOyPD8jvFnOCDGMVW3XENbkKI8LKl3iDeBXhU=;
        b=ozS/Kh09apWYpNP/gakkPbfX1ycxUwxHt6Cmi0RUd6fuD3UQqxjAtAOm9sbttnrQto
         Lsf+H/RYhmrqIyulWmFBc8xsDwzujdi1n5QEl+mdEE0GOKPOFvjzZfUFHTxk4jLkQoAS
         z4NNNc7cRVwE5MjHcFyLMLoHHqv4rEL/QKoKRO2Bpusq9cTyGdsQu2eeF+T7fXBmv60o
         nJ4YV+J8vXPPIadv9+AninTbH7TGyBNpBOYUqIZ5YuitZLOmKp8RNN/eGlLrfRDWEPBM
         +ZKVRd+dJ2Ttqoh17CvI34c3XlqPyYbaHYls+CKnEVI53ZHupoizo7375QLy+p6UC2FG
         ldSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695229400; x=1695834200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzNel1zOyPD8jvFnOCDGMVW3XENbkKI8LKl3iDeBXhU=;
        b=Wlf4O3TXrY63SOuDfrBHkIQqX57xlC7vvMMXLDuNh49GaRpawzyFJv33OdRNwPI0LD
         PI10MWUgDUavzWfk10fDSWG/OVkYNNfuh+Kbh8cZrwzJAhmw5S5ZhMJ3J9G/UgK96yZD
         38HqeybjO6daREjApUIG3Gm6KEJkbi1hSbEGwh+utsktndHK9gHaRphqS/sn2MNnVs0t
         9LL/nIEuSo44CiWthJfjGs4VcU5dEVKSV7HnAm4scly/WycLFlbmdQYHW2DstgOcZVuk
         xjiyeF/BQY3bHzFmFkLxADXMSQgj+APzzyrbwngfGeetYYO3rdhkV2NQPSDkDoXT8UOL
         vSCA==
X-Gm-Message-State: AOJu0YxgnnxMBwx71ObYt07B8f6O1kxEQtLp7/0tNqK6fo4O4RjtRjth
        o0IkUi1cLrsazsbAOE5HwEcJNA==
X-Google-Smtp-Source: AGHT+IGLyeIpQl9NNPRbLsBra2rs2kV6nI+E9NrsPDtsxmGqu6O9tusTkTI8Yb9Uk9XuYyYnXwOByw==
X-Received: by 2002:a5d:6282:0:b0:321:4ca9:ee86 with SMTP id k2-20020a5d6282000000b003214ca9ee86mr3182467wru.53.1695229398985;
        Wed, 20 Sep 2023 10:03:18 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id g10-20020adff3ca000000b003200c918c81sm11221089wrp.112.2023.09.20.10.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 10:03:18 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     David Lechner <dlechner@baylibre.com>,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>
Subject: [PATCH 0/4] iio: resolver: move ad2s1210 out of staging
Date:   Wed, 20 Sep 2023 12:02:49 -0500
Message-Id: <20230920170253.203395-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series moves the ad2s1210 resolver driver out of staging (after 13 years!).

We have made quite a few fixes and improvements to the driver (specifics are
listed in "iio: resolver: add new driver for AD2S1210"). The driver has been
tested on actual hardware using a EVAL-AD2S1210 evaluation board. (Note: not
all device tree features have been implemented in the driver since the eval
board doesn't support them out of the box. We plan to add them later if needed.)

One thing left over from the staging driver that probably needs more attention
still is the fault handling (both the fault threshold attributes and how
userspace gets notified of fault conditions). We considered adding these as
events, but the fault conditions are related to internal measurements in the
chip that aren't available as channels. 

Since the chip is designed to read the fault register each time we read the
data registers for one of the two channels it seems like faults should be
associated with channels one way or another. Would it make sense to add extra
channels for the internal signals that only have fault events (mostly with
IIO_EV_TYPE_THRESH)? Or would it make sense to add a new "flags" channel type
where the "raw" value is bit flags? Or something else?

Here is the table of available faults for context. Sine/cosine inputs are
internal signals.

| Bit | Description
+-----+------------
| D7  |  Sine/cosine inputs clipped
| D6  |  Sine/cosine inputs below LOS threshold
| D5  |  Sine/cosine inputs exceed DOS overrange threshold
| D4  |  Sine/cosine inputs exceed DOS mismatch threshold
| D3  |  Tracking error exceeds LOT threshold
| D2  |  Velocity exceeds maximum tracking rate
| D1  |  Phase error exceeds phase lock range
| D0  |  Configuration parity error


David Lechner (4):
  dt-bindings: iio: resolver: add devicetree bindings for ad2s1210
  iio: sysfs: add IIO_DEVICE_ATTR_NAMED_RW macro
  staging: iio: resolver: remove ad2s1210 driver
  iio: resolver: add new driver for AD2S1210

 .../testing/sysfs-bus-iio-resolver-ad2s1210   | 109 ++
 .../bindings/iio/resolver/adi,ad2s1210.yaml   | 150 +++
 drivers/iio/resolver/Kconfig                  |  13 +
 drivers/iio/resolver/Makefile                 |   1 +
 drivers/iio/resolver/ad2s1210.c               | 948 ++++++++++++++++++
 drivers/staging/iio/Kconfig                   |   1 -
 drivers/staging/iio/Makefile                  |   1 -
 drivers/staging/iio/resolver/Kconfig          |  18 -
 drivers/staging/iio/resolver/Makefile         |   6 -
 drivers/staging/iio/resolver/ad2s1210.c       | 716 -------------
 include/linux/iio/sysfs.h                     |   4 +
 11 files changed, 1225 insertions(+), 742 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-resolver-ad2s1210
 create mode 100644 Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml
 create mode 100644 drivers/iio/resolver/ad2s1210.c
 delete mode 100644 drivers/staging/iio/resolver/Kconfig
 delete mode 100644 drivers/staging/iio/resolver/Makefile
 delete mode 100644 drivers/staging/iio/resolver/ad2s1210.c

-- 
2.34.1

