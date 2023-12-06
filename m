Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB188079CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442850AbjLFUtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379478AbjLFUtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:49:16 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888BB98
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 12:49:22 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a1caddd6d28so22854866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 12:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1701895761; x=1702500561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wUeyqX/7tinAhfhJl7JN2l+NlOEIPq4fW0+aMdie9nM=;
        b=oC5W4j+y/855dGadXgaofL/sNSSiTxRS8A6uIM0PCLuSkSzCljnKsnp/TTF4/BcmbH
         cxsODrOidXpTQpIHsrpHrzLs/BSZkcOb6+BLtJhu0uxdwLV6w6ZLO34Rd5lio4cuhKcz
         gkSaF0tXh15d/Rgogi3RyKhoVPjddsWf93bidFWhUxaWwtD+uSKXJ7LU81DjO3dKSA5U
         sT15Wsk/wDONm37hnDnOBlD2b2fiTL0wunQTskp5ZVseBlWxP29cNRmT0uZuLIxJO+JQ
         4tJpI0uFK9yPq8+N7Skowjh1vBd2X7wiZU5mzhAxe+FS2nM9JekFDgc8+6dq6CgXfa6s
         iPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701895761; x=1702500561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUeyqX/7tinAhfhJl7JN2l+NlOEIPq4fW0+aMdie9nM=;
        b=JQpuXaLZ1Et+vjkD/7ZqntQZltGuUMWp1sFSgSavvH0xqja+YvfYcc2B9YaX7+5op6
         21iftPJl5Tshk+xgU7YWvfkw08qkxhCsaFcdvWL+MbVABKRf3nsRljsgKK308F7xsQ28
         NYCrvDYOQ2bVZNxMpuLn1LI1ltTu93iImsrUPv+EFxPsDa4d32ptgrbyttxmsQpWoc64
         cWBItRSALiMsh5LSmx2v6pwRbh1QrVR8yd9oFMev6aZskLhR0/5dl9DNLZKgFjq30DHP
         Dylr6pFvoYMS6tlhnPpOe3Zi/HqNgPOmOELztSFEIqfIIfs0ypXU5be9vJ/qhFFQkQuB
         +8qg==
X-Gm-Message-State: AOJu0YxxOpcxPY1V+io2kRp4QDjqVxLk6smLFKGe7iaflcdQn2XhD/2K
        mZ6FnXk38EPi/uI5n5etdtZdRA==
X-Google-Smtp-Source: AGHT+IHlcNnemycI/ZiRuvOl+ZQP/ecAZmabJ8q5ZVQmffJnZ4GvA64G4q3YbfZxNRFJsoEz2rTRQA==
X-Received: by 2002:a17:907:7157:b0:a1c:5257:bfaa with SMTP id zs23-20020a170907715700b00a1c5257bfaamr522612ejb.50.1701895761032;
        Wed, 06 Dec 2023 12:49:21 -0800 (PST)
Received: from localhost.localdomain (d54c3956f.access.telenet.be. [84.195.149.111])
        by smtp.gmail.com with ESMTPSA id gx16-20020a170906f1d000b00a1dc4307ec5sm380267ejb.199.2023.12.06.12.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 12:49:20 -0800 (PST)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andrew Hepp <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Crt Mori <cmo@melexis.com>
Subject: [PATCH v3 0/2] iio: temperature: mlx90635 Driver for MLX90635 IR temperature sensor
Date:   Wed,  6 Dec 2023 21:42:55 +0100
Message-Id: <cover.1701872051.git.cmo@melexis.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

There is a new contactless sensor in Melexis portfolio. MLX90635 is just
1.8x1.8mm in size, but with factory calibration offers instant usage
in every project. It offers wide refresh rate range that is configurable
between 100ms and 4s.

Driver currently provides temperature calculations, power management and
changes to the refresh rate. Since sensor is aimed towards the consumer
market there is really low number of EEPROM write cycles available, so
driver changes refresh rate only in run time registers to avoid writing
to EEPROM. Reading EEPROM is not available in Sleep Step mode, so I am
using caching at the driver initialization to ensure that measurements
can still be taken in Sleep Step mode.

Changes v2 -> v3:

  - add separate regmap for eeprom to make caching more obvious
  - fix some style comments from Jonathan Cameron

Changes v1 -> v2:
  - dt-bindings are now enum according to the comments from
    Krzysztof Kozlowski
  - expand the path recipient list for the patches using
    get_maintainers.pl
  - driver cache and probe (and some style) adjusted according to
    comments from Jonathan Cameron
  - improve DSP version detection (make it clearer)

Crt Mori (2):
  iio: temperature: mlx90635 MLX90635 IR Temperature sensor
  dt-bindings: iio: temperature: add MLX90635 device

 .../iio/temperature/melexis,mlx90632.yaml     |   19 +-
 MAINTAINERS                                   |    7 +
 drivers/iio/temperature/Kconfig               |   12 +
 drivers/iio/temperature/Makefile              |    1 +
 drivers/iio/temperature/mlx90635.c            | 1097 +++++++++++++++++
 5 files changed, 1134 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/temperature/mlx90635.c

-- 
2.40.1

