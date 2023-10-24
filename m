Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494DD7D5701
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbjJXP42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbjJXP4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:56:24 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06A610A
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:56:20 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4083f613275so38113625e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698162979; x=1698767779; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8htt2DTofVr0nXIIYWPlYVfC5BJ8mEQa00r/zVp9Ss=;
        b=B/62KdW/caV/u2EYUdlyRyPwi91YljjUorjt+OoegAW5DsWtq2xyL3fpCYYqaE67iI
         b98xD/86IBE6hPSQfFpUoWLMRax3SbT7mEk3UDaDeEhdPuabbB92MP7UAivdfnGkyr8g
         wpeAAp1TlIurh7W0hJss34sIGb7qpauvDVcjEhABk0y99fqc9JX70mP6Z1mG+mWEo+kX
         B02IAnY7o5hIAQkDJUxLAusWeLZUWX7WZ7n+pIIuaQ8W71ZZweeGVrLZWm0s+9/nDogX
         Dk4oVAeaRjBNLe+v5fHRVUHR28KurS8GWSn2XmCcSNeILJs6r6ynfC5D1icHk/GeqO5v
         vLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698162979; x=1698767779;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y8htt2DTofVr0nXIIYWPlYVfC5BJ8mEQa00r/zVp9Ss=;
        b=krosDgd+MHC3TM8O901XsWaoVirBLGWpsMnDdAkTM90ptUSstqu8rAlS1y12jd5DRo
         CbQiaf7bnUnSpqCAl720cjqWvuju0hygAejpM0seY+b/SZyc+yE/ntjlTc8dtYLfGiP5
         IcRqceoOCMnom8iMnbB/3UpCemR4H48L3mnLPaYer9h3QuIixPYuawZJuGr+IFxC6/sB
         NqNh6w7EOxCaXNXG9D7kCFx8sszkTwdiI3HLH+5WN7Fjb1QkADo0plO6XdGhmuVjoXnX
         3lpUsxdnVQFiCzLJ88ngViDNbQ9vugC9dgijbI3QwKLRwD+XNCbq7/fNRm4Al567OrUR
         f/tA==
X-Gm-Message-State: AOJu0Yx/IdBg3K6a92056zaAQjNpVBWTHyjpSqfM0c636Qsjo7O/EwTI
        qHRHNVdalDU94M6jncP56+otUw==
X-Google-Smtp-Source: AGHT+IHzzVeXBq9eXFNJPi3lvpcsN+5kmAC4tbcfdViwVcdiohYn29anLlYnG26yWXFbsAzsQVRsug==
X-Received: by 2002:a05:600c:1d1e:b0:408:4160:150a with SMTP id l30-20020a05600c1d1e00b004084160150amr10157626wms.33.1698162979325;
        Tue, 24 Oct 2023 08:56:19 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id e7-20020a05600c218700b00407efbc4361sm16939479wme.9.2023.10.24.08.56.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 08:56:18 -0700 (PDT)
Message-ID: <f9043e8e-a061-a33e-7904-a157f09146b1@linaro.org>
Date:   Tue, 24 Oct 2023 17:56:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     bero@baylibre.com, Markus Schneider-Pargmann <msp@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Priyansh Jain <quic_priyjain@quicinc.com>,
        Minjie Du <duminjie@vivo.com>,
        Kuan-Wei Chiu <visitorckw@gmail.com>,
        Fabio Estevam <festevam@denx.de>,
        Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal for v6.7-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,


The following changes since commit d3bff6277087c77a12ae6458d6da44d725f6fbaf:

   Merge branch 'thermal-misc' (2023-10-12 20:08:28 +0200)

are available in the Git repository at:

 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.7-rc1

for you to fetch changes up to 9618efe343ead954ca5c23856ae23d0a29e7d4b9:

   thermal/qcom/tsens: Drop ops_v0_1 (2023-10-19 17:13:12 +0200)

----------------------------------------------------------------
- Add support for Mediatek LVTS MT8192 driver along with the
   suspend/resume routines (Balsam Chihi)

- Fix probe for THERMAL_V2 for the Mediatek LVTS driver (Markus
   Schneider-Pargmann)

- Remove duplicate error message in the max76620 driver when
   thermal_of_zone_register() fails as the sub routine already show one
   (Thierry Reding)

- Add i.MX7D compatible bindings to fix a warning from dtbs_check for
   the imx6ul platform (Alexander Stein)

- Add sa8775p compatible for the QCom tsens driver (Priyansh Jain)

- Fix error check in lvts_debugfs_init() which is checking against
   NULL instead of PTR_ERR() on the LVTS Mediatek driver (Minjie Du)

- Remove unused variable in the thermal/tools (Kuan-Wei Chiu)

- Document the imx8dl thermal sensor (Fabio Estevam)

- Add variable names in callback prototypes to prevent warning from
   checkpatch.pl for the imx8mm driver (Bragatheswaran Manickavel)

- Add missing unevaluatedProperties on child node schemas for tegra124
   (Rob Herring)

- Add mt7988 support for the Mediatek LVTS driver (Frank Wunderlich)

----------------------------------------------------------------
Alexander Stein (3):
       dt-bindings: imx-thermal: Add #thermal-sensor-cells property
       dt-bindings: net: microchip: Allow nvmem-cell usage
       dt-bindings: timer: add imx7d compatible

Balsam CHIHI (4):
       dt-bindings: thermal: mediatek: Add LVTS thermal controller 
definition for mt8192
       thermal/drivers/mediatek/lvts_thermal: Add suspend and resume
       thermal/drivers/mediatek/lvts_thermal: Add mt8192 support
       thermal/drivers/mediatek/lvts_thermal: Update calibration data 
documentation

Bragatheswaran Manickavel (1):
       thermal/drivers/imx8mm_thermal: Fix function pointer declaration 
by adding identifier name

Dmitry Baryshkov (1):
       thermal/qcom/tsens: Drop ops_v0_1

Fabio Estevam (1):
       dt-bindings: thermal: fsl,scu-thermal: Document imx8dl

Frank Wunderlich (4):
       dt-bindings: thermal: mediatek: Add mt7988 lvts compatible
       dt-bindings: thermal: mediatek: Add LVTS thermal sensors for mt7988
       thermal/drivers/mediatek/lvts_thermal: Make coeff configurable
       thermal/drivers/mediatek/lvts_thermal: Add mt7988 support

Kuan-Wei Chiu (1):
       tools/thermal: Remove unused 'mds' and 'nrhandler' variables

Markus Schneider-Pargmann (1):
       thermal/drivers/mediatek: Fix probe for THERMAL_V2

Minjie Du (1):
       thermal/drivers/mediatek/lvts_thermal: Fix error check in 
lvts_debugfs_init()

Priyansh Jain (1):
       dt-bindings: thermal: tsens: Add sa8775p compatible

Rob Herring (1):
       dt-bindings: thermal: nvidia,tegra124-soctherm: Add missing 
unevaluatedProperties on child node schemas

Thierry Reding (1):
       thermal/drivers/max77620: Remove duplicate error message

  .../devicetree/bindings/net/microchip,lan95xx.yaml |   2 +
  .../bindings/thermal/fsl,scu-thermal.yaml          |   4 +-
  .../devicetree/bindings/thermal/imx-thermal.yaml   |   7 +
  .../bindings/thermal/mediatek,lvts-thermal.yaml    |   1 +
  .../bindings/thermal/nvidia,tegra124-soctherm.yaml |   5 +
  .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
  .../devicetree/bindings/timer/fsl,imxgpt.yaml      |   4 +-
  drivers/thermal/imx8mm_thermal.c                   |   2 +-
  drivers/thermal/max77620_thermal.c                 |   8 +-
  drivers/thermal/mediatek/auxadc_thermal.c          |   2 +-
  drivers/thermal/mediatek/lvts_thermal.c            | 254 
+++++++++++++++++++--
  drivers/thermal/qcom/tsens-v0_1.c                  |   6 -
  .../dt-bindings/thermal/mediatek,lvts-thermal.h    |  28 +++
  tools/thermal/lib/mainloop.c                       |  16 --
  14 files changed, 288 insertions(+), 52 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
