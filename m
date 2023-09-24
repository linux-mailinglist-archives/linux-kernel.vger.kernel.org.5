Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1627ACC1A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 23:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjIXVw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 17:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjIXVwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 17:52:25 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E69CF;
        Sun, 24 Sep 2023 14:52:19 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31ff985e292so4883533f8f.1;
        Sun, 24 Sep 2023 14:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695592337; x=1696197137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NSCEBssBikQzY5aYKeN0gHTQNX/uGtO0UC9XEC97/7Y=;
        b=CjdSUzlogm6OGqrIRYGpOzvHEhbifotUtn9M5gg6+S6+q8V6KTOfxkbOFHovzZFH0N
         FFVLIMOYhULXVFGyNd6h3BlGIeANQgN7dIq0e1oJHNsJkXGbv9HLe0X8K0muU1WzVdRj
         JAu91Bgo+pCQECKfxlhBNmg7f+5wIaFzNA7pYskXP8k/7X2DatX7pA7PDnj3PBQfzsRy
         EuM14CKUKpk/4MKmxGg0JYwz0dkPppjvPzNAXxNGBG7Nfyr+cAjw8QSrSp9T+UOXxwaP
         MXzw7RRd2cBJ/iUXeXZOlofArk1NeF4ZAPb3QI/qIKkaCCepz7jNQwnjPpTnoMpWO5xQ
         8naw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695592337; x=1696197137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NSCEBssBikQzY5aYKeN0gHTQNX/uGtO0UC9XEC97/7Y=;
        b=EcfQ1tU4YwsFW8GFe1CA35hTKR3rfK/JC74TMRsIYOzeO6CwT7CBgxWv/uxEAC/FXA
         R7TTIYmQ2FIiXED6u+z+G+FaIe+ha7OfEOajOP1IK4xiwlqJ8n/6iymBs7dZ9PMK/HgC
         xKNCMLkFUTMa9TpJ5qmm65A+/2fNnlgsbTJdK/yyxU+NoEBSdl+017Q0adhTfNN9sNmM
         U4FR7Ur2rJr9UKn1teUvvzCGiPBzqw0/AxGYcUtZrGJibd5cSqRtlL/iHyK3mD5yUD3y
         6XBVqYx2+2reryYGa4cCX7jyQCVY6xHWlSlA4AYheWTJAQmysMx/5t2QiNi8wx0eYhXD
         NVfg==
X-Gm-Message-State: AOJu0Yzy2ctCoiO8pLbUndocbtJEDU8vJ9uTFOQCwVNkKGxJna99vhF2
        ZyNQPQ7WCwsLhEXpG5e8Q7k=
X-Google-Smtp-Source: AGHT+IFdCn2dmRcwfphz4wodGO2Ivx3qIBwaXfOPeCGfL6EnxE/x/4F2pPdMzoB9WpIQsXhylu9CmQ==
X-Received: by 2002:adf:cb8e:0:b0:323:22d9:4930 with SMTP id q14-20020adfcb8e000000b0032322d94930mr1333958wrh.33.1695592337484;
        Sun, 24 Sep 2023 14:52:17 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a301:7000:1bc9:cab8:e784:6ddb])
        by smtp.gmail.com with ESMTPSA id c10-20020a5d4f0a000000b0031f3ad17b2csm10144444wru.52.2023.09.24.14.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 14:52:17 -0700 (PDT)
From:   alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisa.roman@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] iio: adc: ad7192: Add improvements and feature
Date:   Mon, 25 Sep 2023 00:51:45 +0300
Message-Id: <20230924215148.102491-1-alisadariana@gmail.com>
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

From: Alisa-Dariana Roman <alisa.roman@analog.com>

Hello again,

Thank you Jonathan for the feedback! Here is the updated series of
patches for the ad7192 driver.

Quick reminder that the patches need to be applied in order.

v2 -> v3
	- move comment line above
	- correct FIELD_PREP to FIELD_GET where needed
	- remove unnecessary !!
	- "rms" -> "RMS"
	Link: https://lore.kernel.org/all/20230920003342.118813-1-alisadariana@gmail.com/

v1 -> v2
	- replace old macros with FIELD_PREP() in commit "Use bitfield
	  access macros"
	- update the other commits accordingly
	Link: https://lore.kernel.org/all/20230918214854.252781-1-alisadariana@gmail.com/

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

