Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84347BCA91
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 01:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjJGXs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 19:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJGXsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 19:48:51 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9249B9;
        Sat,  7 Oct 2023 16:48:46 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bffd6c1460so39205901fa.3;
        Sat, 07 Oct 2023 16:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696722525; x=1697327325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8ks13CH2P8HB9Lhw96RBJaDRb016JT/2wf8+AM60Gk=;
        b=lOGaSjWP/j625+UeYhfQlh9h1TfHh72UP9qD9fEphq+3M80RcFKiLYFsWRgAnjGsUv
         /B2dQ/99/nD4PXg3Bc1hFAlU0BFYYj7H0kPCU8AiVBoTwpcT2WTrMwodUcw7lF5VYigD
         M0qg+pqO23wl+So/hEiN/NPGzJg8MY2+5XTOj44ijhPncKl89AQVKdg42i5lF+28c0if
         g7cQcRWCXGaVG8Q5T3WjyvK7Dqlhpy8v0+ADqyo9dnV0b03+FSb4oFJg9S82T321syf5
         DBjh9a9OGSJ5chS8R2MaJeiPmot+6nhvmI4w+Vh6edctRxKcvL0poj0D/xXXPTXqkCaN
         uApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696722525; x=1697327325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z8ks13CH2P8HB9Lhw96RBJaDRb016JT/2wf8+AM60Gk=;
        b=ozbTAHQTHr3KCrYh4uaI8VkriZ2Guo40JoY44DKYV9W32N9ckpo8dsqC3GFrnue3xU
         thXDAieVyw4mscad1RhUW6wu5Of0sUJQMQKjqkfciHQsCvWEkAoDPutYgZKK1Ynu3rTB
         iXPEKcMTw06geTTwvheLWBhMThKI/n01tH736iRuFMpjG1lwNQXejn/wOWVzAvHr5kvz
         17Eru5oJZhWuD+9cdr4W/L+BJLyPSMJb9W4yJoXPQQUyYQLTK3JvbyldUXYJB6fHSLBZ
         djE0NI/PomPFFWyY43t1tqayLIoZJfPBhnyWi0UAq+v+Ra2JCQj4L5zzmGC6gHqUXv7E
         zVZQ==
X-Gm-Message-State: AOJu0YzopGaLEn2upDIjPsJf6Db3FK1sXfKSmGw5tw44TqWQLvHO0Z6R
        cRVf/dRJleGcfP8SJ+aV0C+UiJUMKIYkTqS9/7w=
X-Google-Smtp-Source: AGHT+IGS7nEmTf3cidl+rNO7f+1JByk7touGUV35eqP8aMO2DsO6rnjLJdjqKOp7yCgEOfNrRZyxfw==
X-Received: by 2002:a2e:914e:0:b0:2c1:7d85:73e3 with SMTP id q14-20020a2e914e000000b002c17d8573e3mr10995854ljg.49.1696722524411;
        Sat, 07 Oct 2023 16:48:44 -0700 (PDT)
Received: from fr.lan ([46.31.31.132])
        by smtp.googlemail.com with ESMTPSA id k7-20020a2e8887000000b002c0336f0f27sm1359871lji.119.2023.10.07.16.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 16:48:43 -0700 (PDT)
From:   Ivan Mikhaylov <fr0st61te@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: [PATCH v5 0/2] Add maxim max34408/34409 ADC driver and yaml
Date:   Sun,  8 Oct 2023 02:48:36 +0300
Message-ID: <20231007234838.8748-1-fr0st61te@gmail.com>
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

Add Maxim max34408/34409 ADC driver and yaml for it. Until now it
supports only current monitioring function without overcurrent
threshold/delay, shutdown delay configuration, alert interrupt.

Changes from v1:
   - minor changes from Rob's comments for yaml
   - add ena, shtdn and make 4 inputs for R sense from Jonathan's comments for yaml
   - add _REG suffix and make prefix for bitmasks and statuses
   - add SCALE/OFFSET instead of AVG/PROCESSED from Jonathan and
     Lars-Peter comments
   - add chip data from Jonathan and Lars-Peter comments
   - minor changes from Lars-Peter and Jonathan comments for driver

Changes from v2:
   - add channels into hardware description into yaml
   - add rsense property per channel
   - rename pins for shtdn and ena pins
   - make one array for input_rsense values

Changes from v3:
   - change *_34408_OCT3 and 4 to *_34409_OCT3 and 4
   - change of_property_read_u32 to fwnode family calls
   - add i2c dev table
   - change of_match_device to i2c_of_match_device
   - change match->data to i2c_get_match_data 

Changes from v4:
   - minor changes in yaml

Ivan Mikhaylov (2):
  dt-bindings: adc: provide max34408/9 device tree binding document
  iio: adc: Add driver support for MAX34408/9

 .../bindings/iio/adc/maxim,max34408.yaml      | 141 +++++++++
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max34408.c                    | 278 ++++++++++++++++++
 4 files changed, 431 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
 create mode 100644 drivers/iio/adc/max34408.c

-- 
2.42.0

