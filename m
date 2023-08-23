Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFDE785CC5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237365AbjHWP6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236557AbjHWP6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:58:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFBBE67;
        Wed, 23 Aug 2023 08:58:50 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31768ce2e81so5152138f8f.1;
        Wed, 23 Aug 2023 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692806329; x=1693411129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cqANpwiBLFO/+zBl+efuFRUCoFUnDbnW5Jz+Aqzujhg=;
        b=NmBreOAouBwInrbuubsXKFj63xNuuARD1tQqi6OeME9Gx+qTP1TKUUkSQEn1CWX6li
         a/KXUfiLdfchMK3WQSUmxv9x2UUEh74/HLGi0JZkDVqQAQzqTpzUmqUlHhSuIbC5A1CV
         q6VXcjCbdOhbiwNmEPg/qpglrbxDfKkp5UN2v4/toPXVFm5PUq1FZ8ta80HpFIbFRjC+
         TM2V9Jk3ly3XqnmkBoaZkAM70KE9rAlMGTWBP+ZX+Qk8NW3PvYgzC35WPYA+w6/aIHFW
         CA+17lLYhmxsJo1Ra4k0RxTsWx/lDu/l+36nJadjqIYW6R+ZC18RAeY69lOJC6/jLpI1
         6dDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692806329; x=1693411129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqANpwiBLFO/+zBl+efuFRUCoFUnDbnW5Jz+Aqzujhg=;
        b=Z2oCETGfX1rWQam993ipe0sUc+3IVL+LDVgxDNoSRX5WNPVi+A4uXusTWng9cGvWfo
         DQuVto1NonXYmt40XCQ6VqR6LYFMWbo+8QgS1FLL1hFfjJD3uqrYTi3/7bVXd1SHVsK0
         ja7KL5DiO6VDlW+Y6WL8G1PhcWjU1fB8WHBIOM3dlZIfEpegq1FuKIc5QUr7c5JlhB80
         W4YEaXFP1rb0rKIrNs+b52rk36/kec3UmwTXQOubaFBp8ib3mQv/LQkBY/1tIJSnHuYJ
         BGXyjtES8OuCEwRJjl8mi5w0D3RXM+LEzXEp9R8zmDQE/uJAXpGCs1+k76dz7wAE08+N
         LmVg==
X-Gm-Message-State: AOJu0YwprH2kbVe2foMJiQELwu/9Uom51iqXC4I8VCdrU+tyXfpRosBU
        Rr+XiKqlPfHBW/OqxmjgZ+Dr+fx2EPQ=
X-Google-Smtp-Source: AGHT+IFU2G6DN68syczwGyZtJBtSN4YH4lSSP8JPIT474RwGaqwyyYmvrQ1KvbabpgrV7VOyKbMnwQ==
X-Received: by 2002:a5d:530a:0:b0:314:15a8:7879 with SMTP id e10-20020a5d530a000000b0031415a87879mr10269498wrv.34.1692806328672;
        Wed, 23 Aug 2023 08:58:48 -0700 (PDT)
Received: from localhost.localdomain (35.red-83-35-63.dynamicip.rima-tde.net. [83.35.63.35])
        by smtp.gmail.com with ESMTPSA id t24-20020a7bc3d8000000b003fe195cecb3sm17044613wmj.38.2023.08.23.08.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 08:58:48 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/3] iio: pressure: bmp280: Add support for BMP390
Date:   Wed, 23 Aug 2023 17:58:04 +0200
Message-ID: <cover.1692805377.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for the Bosch BMP390 pressure sensors. This new series shares
the regmap present on the BMP380 family of sensors.

Changelog from v1:
- Added patch 1 optimizing data type used to store device ids (from
  unsigned integer to unsigned 8-bit integer).
- Enhanced implementation and fixed error string building on patch 2
  pointed by Andy Shevchenko <andriy.shevchenko@linux.intel.com>.
- Reorder IDs definitions on shared sensor header file on patch 3.
- Include a link to the datasheet for the bmp390 sensor in patch 3.

Previous versions:
v1:
https://lore.kernel.org/all/cover.1692305434.git.ang.iglesiasg@gmail.com/

Angel Iglesias (3):
  iio: pressure: bmp280: Use uint8 to store chip ids
  iio: pressure: bmp280: Allow multiple chips id per family of devices
  iio: pressure: bmp280: Add support for BMP390

 drivers/iio/pressure/bmp280-core.c | 54 ++++++++++++++++++++++++------
 drivers/iio/pressure/bmp280.h      |  4 ++-
 2 files changed, 47 insertions(+), 11 deletions(-)


base-commit: 14b7447cec15ee8dfdfe0da66ba1e280ded7e00a
-- 
2.42.0

