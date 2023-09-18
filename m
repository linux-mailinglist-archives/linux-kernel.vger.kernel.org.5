Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489547A553D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 23:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjIRVvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 17:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjIRVvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 17:51:02 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1738D8E;
        Mon, 18 Sep 2023 14:50:53 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40472f9db24so50054975e9.2;
        Mon, 18 Sep 2023 14:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695073851; x=1695678651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T9pQraSrxCP9H752XlcoHY3GbT8ld49DA6Yl5bf/bRs=;
        b=SnLmtn2eUIw0cM7vLDvAg0GljWKLPP8cSGPVJA+Duc+N2h+tVzCqnbFv1oh/SANO7k
         IzSNs7yHV/MWrMuU7cCpV+zUIjqt6q9zEe//ZjUikiiH74uAX7RR5bAPp6HbdTke+v0R
         4jxuXv/Dmu34xcjxJjIdHoR0NPwDxN1P7va2MYhKXy5cdisJNrlOPV2xOLAxblWJAVQj
         q+sIHioVdGsj7KxtnK7aw6q+R4k/rh2jtBzOOUpfr4+vFXrb66wYsHyAUn6xE7OBkqZc
         0Gd9X6DvA7q20EpWOnMryVgLMKtUFgMoO9BkmnMwPoIdPeTq3MfB2H7CaNywndw4naOM
         nZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695073851; x=1695678651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9pQraSrxCP9H752XlcoHY3GbT8ld49DA6Yl5bf/bRs=;
        b=l0ED385zdzslJPzllvEl9GHIt29do8zymdg1+9VRx6mX7x3PbXllQSG9My1IL/H432
         UTRXHlPIRJrOweLr1Yb4WRMGvbg3LxHBhGi5rsmfwOOD55cLXGdWxZrLDj9G6C1A7XIP
         pk1j/hSA5vBS+i/hR50nGsk7qH7zUYjP4WYmEt1JsTRlbR6JUGXP+rRF17759R8+0tWU
         okuXD4SV+6g8eTLhDhgMnATfoOrRW/Eksm3KnOhYdvV1Auv2ykbbtqBWZ9/stR5j94qv
         9KE7i8Pm2TjP3432aOv0juBp0tmGbGrdFD8hL/NqLLTqx6/Ik8P/L0l5h/c4AhQhVj08
         hObg==
X-Gm-Message-State: AOJu0Ywoj7eGMHzbS9xICB4zMU0v5lSJnAATDNF0q5kLJw7rOX7Hu2wz
        RIl/80LQJyCzIIbf4KbdwgE=
X-Google-Smtp-Source: AGHT+IHdkoQIcy5seBfG9O9q1UrMhM2SqPRhbOy7K0lYQqTpyXWgS1/8CnF6dvbmp+KqxZc470YOqA==
X-Received: by 2002:a1c:ed19:0:b0:401:c0ef:c287 with SMTP id l25-20020a1ced19000000b00401c0efc287mr8528812wmh.27.1695073851300;
        Mon, 18 Sep 2023 14:50:51 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a301:7000:13e1:e47b:904a:6f81])
        by smtp.gmail.com with ESMTPSA id t9-20020a7bc3c9000000b003fe23b10fdfsm16323715wmj.36.2023.09.18.14.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 14:50:50 -0700 (PDT)
From:   alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisadariana@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] iio: adc: ad7192: Add improvements and new feature
Date:   Tue, 19 Sep 2023 00:48:51 +0300
Message-Id: <20230918214854.252781-1-alisadariana@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alisa-Dariana Roman <alisadariana@gmail.com>

Dear maintainers,

I am submitting a series of patches to improve the ad7192 driver. I
would like to highlight that patch 3 is dependent on patch 2. For patch
3 to be applied, patch 2 needs to be applied beforehand. Also, patch 1
upgrades the driver to match the style of the last two patches.

Please consider applying these patches in order.

Thank you for your time and attention.

Sincerely,

Alisa-Dariana Roman (3):
  iio: adc: ad7192: Use bitfield access macros
  iio: adc: ad7192: Improve f_order computation
  iio: adc: ad7192: Add fast settling support

 .../ABI/testing/sysfs-bus-iio-adc-ad7192      |  18 ++
 drivers/iio/adc/ad7192.c                      | 230 +++++++++++++++---
 2 files changed, 208 insertions(+), 40 deletions(-)

-- 
2.34.1

