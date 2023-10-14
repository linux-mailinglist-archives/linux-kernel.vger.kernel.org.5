Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7367C9674
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 23:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjJNVNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 17:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjJNVND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 17:13:03 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B60CE;
        Sat, 14 Oct 2023 14:13:00 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5079c846dcfso1987693e87.2;
        Sat, 14 Oct 2023 14:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697317978; x=1697922778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y0kP5eY/UA3bzuOu4DpvQfR2TaaataaNhpPQGnL7330=;
        b=ndvlOupfmxT1Fy5dfv5QyO5AJGyVs/VhgnoLJQXBB7H/VgVHw2KGEGTsGIGjtrBzOO
         nRF27rVkM23zjoVXTEEGafQcrIyN4ATCfIiSLZV62iDhler5ZdH02/sILUY4B9FrWE27
         LBGSkwWYKXT+eYkeqI2lL0EYxq5XRT9ee587dyO84hUT2esctL4QTt9oQ7xcCVHKNXT1
         1v0BTiMerTCQet7B1iNJiXnmEHE30JHLMY0jDCUP+POyKubfmpl/27+7u22ykMs9b/VK
         K5UgkffqSL5bY8G99TxvTl2LLHl5t60z6p716lPsnwfti1nqYLC/EumtfwxupADxxJf0
         +sPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697317978; x=1697922778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y0kP5eY/UA3bzuOu4DpvQfR2TaaataaNhpPQGnL7330=;
        b=rqVU1vtOAN7Eh0NQ6eOo/C2MSLAsqwTk9J2nRj2vj2ifiYGM+b9Kj+J8+RtgQRCAZZ
         +D0km36PH99Pr5ZxaTBRacdrdy83oeqplzgMls9C+tjPA8RJpbpC3QK244Rim+UGgqlQ
         fKvkwAjfoIFDRvMw7xyeZM5aee1ox5cMYi3pCDHvko1hZiOzTMhuQRWGgJgbcKpu9vD8
         xBET44Dg2N08Swk6NeDryrT9Sc4B9tiOgeET64W+d/BVcBkQde7JCteKV/MvMPiozL31
         lNG1CuYYPIj1ckzTZbjBO2/KoSo4c820VTVF7FJJCkkWH35cOv6I/IPlpQXN9H7+r/VH
         xNnw==
X-Gm-Message-State: AOJu0YxRjURfUWVFeShxCUhPIFA8RavLkPsU5qvrTI0HvlyRs7jrftQD
        gvAP/0qCBGGPz1Poew+EGL0=
X-Google-Smtp-Source: AGHT+IFreEc1NpIWamPWW00rUTFFa62be+gcxqUaXCLRh3Bg+lWCNoZ8k4EVxWuZItpxD74Ci3+hHA==
X-Received: by 2002:a05:6512:794:b0:502:cc8d:f1fc with SMTP id x20-20020a056512079400b00502cc8df1fcmr22437887lfr.37.1697317978149;
        Sat, 14 Oct 2023 14:12:58 -0700 (PDT)
Received: from fr.lan ([46.31.31.132])
        by smtp.googlemail.com with ESMTPSA id g3-20020a056512118300b00507a9b2eff4sm78759lfr.22.2023.10.14.14.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 14:12:57 -0700 (PDT)
From:   Ivan Mikhaylov <fr0st61te@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: [PATCH v6 0/2] Add maxim max34408/34409 ADC driver and yaml
Date:   Sun, 15 Oct 2023 00:12:52 +0300
Message-ID: <20231014211254.16719-1-fr0st61te@gmail.com>
X-Mailer: git-send-email 2.42.0
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

Changes from v5:
   - name and minor changes to properties in yaml from Rob's comments
   - shtdn-enable-gpios -> powerdown-status-gpios from Krzysztof and
     Jonathan comments in yaml
   - minor changes to driver

Ivan Mikhaylov (2):
  dt-bindings: adc: provide max34408/9 device tree binding document
  iio: adc: Add driver support for MAX34408/9

 .../bindings/iio/adc/maxim,max34408.yaml      | 139 +++++++++
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max34408.c                    | 276 ++++++++++++++++++
 4 files changed, 427 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
 create mode 100644 drivers/iio/adc/max34408.c

-- 
2.42.0

