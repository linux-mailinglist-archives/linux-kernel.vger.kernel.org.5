Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983B8774F69
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 01:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjHHXit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 19:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjHHXir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 19:38:47 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF21919AD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 16:38:44 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so10265257e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 16:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691537923; x=1692142723;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ytXUrmbGQxZiuOxpE+msM3CEna+MU5lJ9nyaPjsP9xk=;
        b=j9yslVGNbpSB21NuQJW5m7eziuPW6xLOT4dplz83lZBdkqWUXBXFwtJq9J3ReD2vXe
         cDo90KAdx+vU2Ho9h7Sg9hYFidDbxObD+JuJ32zBBTe1+Qf143wQy7w380NOFO84wkB/
         PX2HTp9Z6TGX6v00P+59LqHp0q3y61nnmvag+cLR29+zH69JfhIl8wmi2AhrY9bdvNFW
         3HwQ+j2AIkiCA+VxE5x0bWZ7XnasMChQIzBDyPjjxaZqv5xFWlJVjEDoUePh9pHzrPT5
         MXXRjfFi6FwRoAiKhvm5DK6/JUp+LcuZh9gik8TBPUMVCybPh3Mb7eMKgMWYbDYysGbR
         jiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691537923; x=1692142723;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ytXUrmbGQxZiuOxpE+msM3CEna+MU5lJ9nyaPjsP9xk=;
        b=Y6dzTagI+hbLVWjzCHzrszj7BH8w7/TPGMaLyK6c1GS+RN8qw/KsMuJc7OYbnSnCOI
         QsLWzC7CqxUeQS4nyTp9JCX6oNk26V15Vp7p0K0UYFjEUfEScnzbPN4zr0NjOMGjb3q0
         eX7SPGQ8sSv7EB/djZYAg9iETm//MPm3HamjPMuMkFKcpwbuaI748ANMv/+ARpWMckhW
         XmPR88mOcTpOz3N/fzDRZUFw8S3f2Uv6g2MnulEtRAaH4tlWiUK82pKl/jhG8BFypn/V
         645ZAp21I1HuqG+HPGXXkI/a0TEdeq/1Vwdowffpqrog3pWjFLAjMofUQVf0I/KRrKhk
         gpBA==
X-Gm-Message-State: AOJu0YwT6EoUVBoncH2eD5u+hcZRkTv+zd81iuDvR6g/yQHSsU3T+CHE
        aodhE1LBew7fO/rTrkG80rVpIw==
X-Google-Smtp-Source: AGHT+IEz2HLegPfNAvYDjru2oYALXto+xH1zIrH/qlyKsAvXOSr8mUzHzieHiA/n7ZyHAF7HlA38yw==
X-Received: by 2002:a05:6512:1142:b0:4fe:3724:fdb1 with SMTP id m2-20020a056512114200b004fe3724fdb1mr581477lfg.41.1691537922833;
        Tue, 08 Aug 2023 16:38:42 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id v24-20020ac25598000000b004fe1d770527sm2031871lfg.309.2023.08.08.16.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 16:38:42 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v10 0/2] Add Novatek NT36xxx touchscreen driver
Date:   Wed, 09 Aug 2023 01:38:27 +0200
Message-Id: <20230808-topic-nt36xxx-v10-0-dd135dfa0b5e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPPR0mQC/zWNwQrDIBAFfyV47oZVE5Ge+h+lB2M2UZJo0LQII
 f9eKfQ4A/PeyTIlT5ndm5Ml+vjsY6jA8dYw60yYCfxYBRMoJGrUcMTdWwiHVKUUMB0f0apu7A2
 x2gwmEwzJBOtqFd7rWuWeaPLl9/J8VZ5S3OBwicx/GjkKLQSXKFqlei2Bw+LiunD+mDfj19bGj
 V3XF9p0nH2wAAAA
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dang Huynh <danct12@riseup.net>,
        Amit Pundir <amit.pundir@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691537921; l=3972;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=D0PAwR5df/bodweenMRrHccWIEO0AX2dl/LrswhguEA=;
 b=A+GD6Np4uWEw02CMd+pHwDQctaPQNQGE8ae9ceGFSo2nPDhLj330j7O1/OUxpQWY28ub+WTaR
 0B5L+jzNsmOBSrZXJCsQ2+/7gdU3ZVbfW/speE6aXu3Hqia4UctkWaJ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am taking over this series from Angelo, as he's moved on to other
things, but there are still devices out there (and being made)
utilizing this class of ICs.

This patch series has been tested against the following devices:
 - Sony Xperia 10        (SDM630 Ganges Kirin)
 - Sony Xperia 10 Plus   (SDM636 Ganges Mermaid)

Changes in v2:
- Fixed sparse warnings from lkp kernel test robot

Changes in v3 (as requested by Dmitry Torokhov):
- Using shorthand u16/u32 (sorry for the overlook!)
- Now using more input and touchscreen APIs
- Fixed useless workqueue involvements
- Removed useless locking
- Switched reads and writes to use regmap
- Moved header contents to nt36xxx.c
- Fixed reset gpio handling
- Other cleanups
- P.S.: Thanks, Dmitry!

Changes in v4:
- Fixed regmap read length for CRC_ERR_FLAG final check
- Fixed YAML binding, as requested by Krzysztof Kozlowski

Changes in v5:
- Replaced subsystem maintainer's name with .. mine,
  usage of additionalProperties to unevaluatedProperties
  and a typo fix for reset-gpios as per Rob Herring's review
- Changed compatible string as per Krzysztof K. request
- Renamed the novatek,nt36xxx.yaml file to just nt36xxx.yaml
  in order to now reflect the driver name instead of the DT
  compatible
- Fixed blank line at EOF

Changes in v6:
- Removed include of_gpio.h, added mod_devicetable.h and
  gpio/consumer.h
- Added kerneldoc to relevant functions/enum
- Used traditional patterns for error checking where possible
- Documented calls to usleep/msleep
- Using be16_to_cpu / get_unaligned_be16 where possible
- Added helper for CRC error check on retrieved buffer
- Decreased indentation in the CRC reboot recovery function
- Removed instances of error code sum
- Dropped all likely/unlikely optimization as per request
- Removed redundant reset_gpio checks
- Dropped of_match_ptr and ifdefs for CONFIG_OF

Changes in v7:
- Fixed typo in nt36xxx.c

Changes in v8:
- Fixed typo reset-gpio -> reset-gpios in dt-bindings

Changes in v9:
- Includes are now sorted
- Used proposed sizeof variable instead of sizeof type
- Fixed a return value check for common pattern
- Added NULL check to devm_kasprintf call
- Returning ret on probe function to be consistent

Changes in v10:
- Take over this series from Angelo
- Update Angelo's e-mail address
- Rebase over linux-next
- Pick up tags
- Drop patch adding novatek vendor prefix (it's already there)
- Reword the bindings title and commit title (bindings describe the
  hardware yada yada)
- Solve trivial checkpatch warnings
- Adapt to i2c_probe arguments changing since 2020
- Open-code nt36xxx_mem_map assignments
- Make inline hex lowercase
- Indent nt36xxx_trim_table with tabs
- Add "-i2c" suffix to the compatible, as these chips also can be
  connected over SPI, keep bindings reviews in good faith
- Don't duplicate enum/struct definitions in .c and .h (how did that go
  unnoticed)
- Fix a couple typos
- Use pm_ptr()
- Use consistent whitespacing for defines
- Remove unused defines
- Include nt36xxx.h from nt36xxx.c (........)
- Re-tested on a Sony Xperia 10
Link to v9: https://lore.kernel.org/linux-input/20201028221302.66583-1-kholk11@gmail.com/

--
2.28.0

---
AngeloGioacchino Del Regno (2):
      dt-bindings: touchscreen: Add binding for Novatek NT36xxx ICs
      Input: Add Novatek NT36xxx touchscreen driver

 .../bindings/input/touchscreen/nt36xxx.yaml        |  59 ++
 drivers/input/touchscreen/Kconfig                  |  12 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/nt36xxx.c                | 847 +++++++++++++++++++++
 drivers/input/touchscreen/nt36xxx.h                |  89 +++
 5 files changed, 1008 insertions(+)
---
base-commit: 71cd4fc492ec41e4acd85e98bbf7a13753fc1e03
change-id: 20230808-topic-nt36xxx-a41d0c64d5ae

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

