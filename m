Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AB177AABE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 21:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjHMTEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 15:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjHMTEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 15:04:44 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091B8EA;
        Sun, 13 Aug 2023 12:04:46 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3179ed1dfbbso3302378f8f.1;
        Sun, 13 Aug 2023 12:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691953484; x=1692558284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YiVx73zMIwhMYy+6WCs90BoQ2EToUuMEWAY2N9/qEm4=;
        b=UXW7PvnsMJqgGosXqg2bPu0hDF2COZgOaVhMppGHWrflPea2ziMvEPjTJvFmIYoqpR
         zRFbIc5O/uPJ3+xDSK3V0DJCQRzZG+6fNQ5uqZX2PpwRBSlCvslt+5Nug0rN5syvr+l9
         WZw0QLZm6oT3EOt7G1q+LUUf/3iidJ3WVABlU2EKEzHG6hlD03ObmfCejJ9Kv75sg5fv
         dRIWmTa1vA1AFc23Jx0Mf9mq/1+YZkGcbrHcAomtVqQOrNOKGiJFXTlW87bpLzLYD97Y
         eZAhVT2K8HImy0zdvVF84uHJC0/IoTiQLvJNlmSVwi2gmC5FY9tndvKMNXUHYitdyUsb
         Xgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691953484; x=1692558284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YiVx73zMIwhMYy+6WCs90BoQ2EToUuMEWAY2N9/qEm4=;
        b=GnymGz245dkSl/MjIVO5nlAodcjW9mBIfsv/dQGxgNmwKsNJjeooNAxiermXyo4ZGk
         v3abKl8QqIhCDtlU4wUObb1H9BumEw8Qi6d7i6RrGdJVYIVdOE2T7afih7CkSI1Tq17t
         +utn7gBZhHP6lA1WMXp2GQdasLvAJkk57jBn4rZW+Dr1BqLxr1W0/CyWpKLm6sqiwBr9
         8G/rIxeSdqem+IdE7W0ikXMQaxBAQjiabtfRQ/jZyFs5AiPDLkRMTpYwMIQymwH7wiUS
         0tLKvHRfqkVXdpHFZaxrSpKGxLStH9wzBLzJ1RTk+jE0dvYASKX+rWnmQPTOPi10a4fv
         yX7g==
X-Gm-Message-State: AOJu0YzXfYor6kupG8eY6x8bIy2cwteN644l9DCEXuBCbhEbJdptcul1
        rehrIaUMkdCbwIGeyf1vgtVlLZu3Jh0=
X-Google-Smtp-Source: AGHT+IE8rgt9Q9AVla+6aOEZLJrAMcNpss0uhbUi/cV+1g2EBid1dqsSQaWcTpEjbmINj/M3J+NExg==
X-Received: by 2002:adf:fdce:0:b0:317:6992:855c with SMTP id i14-20020adffdce000000b003176992855cmr6427267wrs.19.1691953484015;
        Sun, 13 Aug 2023 12:04:44 -0700 (PDT)
Received: from localhost.localdomain (35.red-83-35-63.dynamicip.rima-tde.net. [83.35.63.35])
        by smtp.gmail.com with ESMTPSA id a2-20020a5d4d42000000b00317ca89f6c5sm12111678wru.107.2023.08.13.12.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 12:04:43 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 0/3] iio: pressure: bmp280: Small driver cleanup
Date:   Sun, 13 Aug 2023 21:03:53 +0200
Message-ID: <cover.1691952005.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Minor cleanup of BMP280 i2c code and migration to the new helper functions
i2c_get_match_data() and spi_get_device_match_data().

Revise driver coding style to follow reverse christmas tree.

Changelog v2:
- Added patch 3 adopting spi_get_device_match_data().
- Updated patch 2 following advice from Uwe Kleine-König
  <u.kleine-koenig@pengutronix.de> regarding unintentioned driver semantic
  changes.
- Revised thoroughfully driver coding style and update more functions.

v1:
https://lore.kernel.org/all/cover.1691276610.git.ang.iglesiasg@gmail.com/

Angel Iglesias (3):
  iio: pressure: bmp280: i2c: Rearrange vars in reverse xmas tree order
  iio: pressure: bmp280: Use i2c_get_match_data
  iio: pressure: bmp280: Use spi_get_device_match_data()

 drivers/iio/pressure/bmp280-core.c |  4 ++--
 drivers/iio/pressure/bmp280-i2c.c  |  8 +++-----
 drivers/iio/pressure/bmp280-spi.c  | 10 +++-------
 3 files changed, 8 insertions(+), 14 deletions(-)


base-commit: 14b7447cec15ee8dfdfe0da66ba1e280ded7e00a
-- 
2.41.0

