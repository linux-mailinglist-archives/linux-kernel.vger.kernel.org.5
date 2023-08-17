Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F9677FF80
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355158AbjHQVHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355162AbjHQVGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:06:35 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBCD3598;
        Thu, 17 Aug 2023 14:06:33 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe4cdb724cso2934045e9.1;
        Thu, 17 Aug 2023 14:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692306391; x=1692911191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A/n5gsGN3X6wqKs4QWYhwyWFk9n8jh5yT11xGhWly7s=;
        b=coGw6ozWft6aN/ahlyTkG8tr4JRUnqxCL287rcKXlTg7bw35prvS+KUODKdaHAQfKK
         eqEoxd9qD64ksNz+k2rXtB0A0dn3Sr0PoH7H1ggeB/zLiamXN2stRlCQcWeyP5uKxv5D
         Wy7BZhVZjbd/tag+2FQyoPFpGXwFzxL5q3owFdjLoPegqGVbXm0NS2kKbDWpPuK4RRlg
         wefHXZyDP58utEdf1rjcpz4cyoru6CxsYL8q3hcrF8rrA2u9XfXjdnzg699SNKdMYNRv
         rv4JFasjUZGc8WPf2VjLbtueeJsv314mUE8frNSfd42qnf+axzSpew2A+qMNhi/3bOG6
         u7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692306391; x=1692911191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/n5gsGN3X6wqKs4QWYhwyWFk9n8jh5yT11xGhWly7s=;
        b=bw5EjuQXUijwQrPQpU+fAIygL9AvyQjHDtgcxtgw0Jf84pRDOgXW00KNHxI4K8pEP+
         +1NN3vRJ2DRZGM7Y5sB1cLZcqfhHbdHYIUoDph5R5rY+E46t0Fz5WfMAw2dpWzDQs6g7
         xXZ/KO9QiNoF7LXoL6rMWD5YFUkjsqtozNlctpdpu0CF0rY7Hq6rTREo+TqnEqkPY1W5
         CnwtjaWjkMuvMS/YdE7vlQbkMFy+ea79xUsUNKkVxk5IB8OHdmZJ9WPtFehZd772N0hK
         y0KlldA0M3bal+WwabxsRi6ZxlUZECmYHSUoQ/FSQL5A4ir0BaaTeI4/+y80Ojl2Mj4C
         M9+Q==
X-Gm-Message-State: AOJu0YxykeDnhS92MBtWKSwE2idF2Nm4q1HBQZ9aSt+AG1WtEKYwtLbe
        EoSOWRvBtOFY1rB2RZaJVe9WvlxfbhA=
X-Google-Smtp-Source: AGHT+IHsEjPOYvH9B7b/8EMDeJyy0luDEtweHWC/veol8UzAuntX7d4LmrO3Lg0ZHhnaa0sPwlfJVQ==
X-Received: by 2002:a7b:ce0f:0:b0:3fe:20ef:1d32 with SMTP id m15-20020a7bce0f000000b003fe20ef1d32mr622709wmc.10.1692306391066;
        Thu, 17 Aug 2023 14:06:31 -0700 (PDT)
Received: from localhost.localdomain (35.red-83-35-63.dynamicip.rima-tde.net. [83.35.63.35])
        by smtp.gmail.com with ESMTPSA id b15-20020a05600c11cf00b003fe215e4492sm669727wmi.4.2023.08.17.14.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 14:06:30 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 0/2] iio: pressure: bmp280: Add support for BMP390
Date:   Thu, 17 Aug 2023 23:05:20 +0200
Message-ID: <cover.1692305434.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for the Bosch BMP390 pressure sensors. This new series shares
the regmap present on the BMP380 family of sensors.

Patch 1 introduces a minor refactor to allow multiple device IDs per
family of chip_info, making room for extended sensor families with
various IDs sharing the same regmap.
Patch 2 adds the BMP390 id to the list of BMP380 devices id list.

Angel Iglesias (2):
  iio: pressure: bmp280: Allow multiple chips id per family of devices
  iio: pressure: bmp280: Add support for BMP390

 drivers/iio/pressure/bmp280-core.c | 51 ++++++++++++++++++++++++------
 drivers/iio/pressure/bmp280.h      |  4 ++-
 2 files changed, 44 insertions(+), 11 deletions(-)


base-commit: 14b7447cec15ee8dfdfe0da66ba1e280ded7e00a
-- 
2.41.0

