Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D617A6FE2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 02:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjITAeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 20:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjITAeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 20:34:16 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41589AB;
        Tue, 19 Sep 2023 17:34:11 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4050bd2e33aso28651075e9.2;
        Tue, 19 Sep 2023 17:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695170049; x=1695774849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qOsZEQWKHaP3SvKumoiwwIoHcS7r6XQ7tcGMeMMbVXE=;
        b=MBrXN/+QYmU7kXzWxCvheKH+E7t0RGtF/V/SRsJq8nJ6SLIlG+o/QhnW3ALI5ywYm/
         amssRyVhJxLReLLX27vIy39QFtIJRQ94ZgoWqIlMnkKRnf1N5U4QG/EhOqyQJy2+QAyw
         sRFRQJYjtjoMQjBSiMe0ycVPnAMMlHe4d8p5Uu/rTT7ZcYq3ORJTKaTHPN7uB7PWYTqQ
         SDvra9p2Z9bsFJDs3ZadXzL4tNvc7xvy2ZAOCYc1uBM4ellOhtMtteXi6arxEcEQ3CpJ
         QeYOoZ1KakqGrWE8gUqkDFnZ6FV/0xhyux3IVYop/K004UtJFPwQH+IekgzTXofICTWw
         Ko2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695170049; x=1695774849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOsZEQWKHaP3SvKumoiwwIoHcS7r6XQ7tcGMeMMbVXE=;
        b=kbkoH43Og/87IN0ov1Kive5gLz43xPPq/FVlM3bbOkcTEu/ZQtI3EPx8z/Bj5n2jf8
         gAMtlBSnTTR3pvQGtsREb6raWDbrJj1x2Z7hTKv/q5K4iBGTh5lFFJ/sUTgFKqF+6lca
         JCAY+M8HzFJFMgR23pea8XzV7uwJgQGw/yqUGTofDmmc7U5hS7GY2KpmfnrQsGhqER8R
         WUZEejgpCn1eDsect1a5HhY3eBap6vzKMv0nRa94Iw7VTS9pn/iqoH9u8UP2DyLzYeE9
         ljQ/2CY2G/T68zPkBTMO285SAw5H24OofeTzPwlMR0G+UrSWP+z1NgDO0EyvtKTZBkbH
         ZRxg==
X-Gm-Message-State: AOJu0YxG4E2lNV3Yqohz7JSRrMxBfyS5A01jNyrWNshCTRPpi5w+jUFR
        EPoOEq/9h2n0ejI7QdHZCck=
X-Google-Smtp-Source: AGHT+IHqtHvLBuZ7JUQoLV6vTpVdgWEz5O+7DjgzIMjIU7cpAwqUxGNanRWldcX0AnxyC3HDFtbXRg==
X-Received: by 2002:a1c:ed14:0:b0:401:eb0:a98d with SMTP id l20-20020a1ced14000000b004010eb0a98dmr1108164wmh.24.1695170049425;
        Tue, 19 Sep 2023 17:34:09 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a301:7000:7838:74ca:1f92:5a36])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c310700b003fe15ac0934sm506343wmo.1.2023.09.19.17.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 17:34:09 -0700 (PDT)
From:   alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisadariana@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] iio: adc: ad7192: Add improvements and feature
Date:   Wed, 20 Sep 2023 03:33:39 +0300
Message-Id: <20230920003342.118813-1-alisadariana@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alisa-Dariana Roman <alisadariana@gmail.com>

Hello again,

Thank you Jonathan for the feedback! Here is the updated series of
patches for the ad7192 driver.

Quick reminder that the patches need to be applied in order.

v2 -> v1
	- replace old macros with FIELD_PREP() in commit "Use bitfield
	  access macros"
	- update the other commits accordingly

Kind regards,

Alisa-Dariana Roman (3):
  iio: adc: ad7192: Use bitfield access macros
  iio: adc: ad7192: Improve f_order computation
  iio: adc: ad7192: Add fast settling support

 .../ABI/testing/sysfs-bus-iio-adc-ad7192      |  18 ++
 drivers/iio/adc/ad7192.c                      | 241 ++++++++++++++----
 2 files changed, 206 insertions(+), 53 deletions(-)

-- 
2.34.1

