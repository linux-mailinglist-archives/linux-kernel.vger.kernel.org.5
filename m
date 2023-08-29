Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738DC78C4E9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbjH2NK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbjH2NKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:10:10 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBFA12D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:10:05 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fef56f7248so40650295e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693314604; x=1693919404;
        h=content-transfer-encoding:subject:to:cc:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERuj0UbkYPRY1zcvks4D/L5Z2fWR5ufBdvUt8JJSxYQ=;
        b=csP+/K27z6C6FIB+EUROM/Ma3nzoDchSlZ0rbfOWyhXBv+886u3v6jkdt+YUaQ/aDa
         9iKAxt0r3JEA6BkVhIpX7xFgnHlQhBZB4lR0ilMsstDzFE7QMSdBudDi6wfMjYhf4Ztc
         kYz9PEcF1CWKT2F0G9Sg6Rasp/zzbYPu/6YkND2ydHBtox+iNYZo6cq0Re9ZjYsFLc9c
         MWRf1DaRGCa37DkoIekPrxfh/1piggWECp1Fm59yQF6UgDhIBzxCgXyB2mVI1XGQrlqp
         NmyGTJ7B7qTUcOQdJ+s4roSEB1oXS1UkHEzQm6M7MMllJUlRZodNq1XS25KM1V/bcE4S
         L5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693314604; x=1693919404;
        h=content-transfer-encoding:subject:to:cc:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ERuj0UbkYPRY1zcvks4D/L5Z2fWR5ufBdvUt8JJSxYQ=;
        b=diBvUOlNCLSW5Uu74j8mom9rzRnO3Cwtf0/xuD3mrNaiku9Ul3EQAuPF2YcVSyeNql
         XwZUWoFy/kOw8I/NSHI/w1fKlXDdHY6q1Ct7R7NsbTlRalt3ot0Y/bwBxnns2+HpCcjZ
         4XZxSFVDfN2XPic+ttn5LByVo3ehBbImUOPj4oaohxChc85RPeAc3rvGSEhcoAyU9GwR
         TLEsZs4R7axB2G6C4LPldOGSU7lVNfApS6BiHj+aFcLKwe5aTMyPeJjm11832/fWkGfK
         iZg3rgepZz6KilQ2H9nuxRueeJH49yDy0Llq+DMvxCk/pQFSRymsEx96HQUm5rqnYxSe
         aMyQ==
X-Gm-Message-State: AOJu0Yz5IBoPW9Z/k11gf6VmV2NeQV1H0/P3HzAGnc1aS7k5EPGv9EIH
        TAvaHHpu2+0dPR2qF2Zsh4T8UA==
X-Google-Smtp-Source: AGHT+IHdrIpdyyBci0sFobR3J2gXt6Jabk+oMOFOz9HtuxSaRFvfuxEykW2aMkXrvQr+QllaHkJH4Q==
X-Received: by 2002:a7b:cc07:0:b0:3fb:a0fc:1ba1 with SMTP id f7-20020a7bcc07000000b003fba0fc1ba1mr22474856wmh.35.1693314603707;
        Tue, 29 Aug 2023 06:10:03 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id a16-20020a056000101000b003179d5aee67sm13711190wrx.94.2023.08.29.06.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 06:10:03 -0700 (PDT)
Message-ID: <153c9f98-8d8f-a933-dca4-c3ce19ee1f6b@linaro.org>
Date:   Tue, 29 Aug 2023 15:09:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Li Zetao <lizetao1@huawei.com>,
        Andrei Coardos <aboutphysycs@gmail.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Ruan Jinjie <ruanjinjie@huawei.com>,
        Chen Jiahao <chenjiahao16@huawei.com>,
        Mark Brown <broonie@kernel.org>,
        Yangtao Li <frank.li@vivo.com>,
        Min-Hua Chen <minhuadotchen@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Minjie Du <duminjie@vivo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [GIT PULL] thermal material for v6.6-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

please consider this pull request for the thermal material

Thanks

The following changes since commit f6a756e8fb12923f0e3996a575e935e94f3594eb:

   thermal: Explicitly include correct DT includes (2023-07-31 20:03:42 
+0200)

are available in the Git repository at:

 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.6-rc1

for you to fetch changes up to 1ef5a9f61457b921158ef03f3a2b3e789b41be9f:

   thermal/drivers/tegra-bpmp: Check if BPMP supports trip points 
(2023-08-22 19:10:28 +0200)

----------------------------------------------------------------
- Check if the Tegra BPMP supports the trip points in order to set the
   .set_trips callback (Mikko Perttunen)

- Add the new Loongson-2 thermal sensor along with the DT bindings
   (Yinbo Zhu)

- Use IS_ERR_OR_NULL helper to replace a double test on the TI bandgap
   sensor (Li Zetao)

- Remove the call to platform_set_drvdata() as there is no call to
   platform_get_drvdata() in a bunch of drivers where that happens
   (Andrei Coardos)

- Switch the Mediatek LVTS mode to filtered in order to enable the
   interrupts (Nícolas F. R. A. Prado)

- Fix Wvoid-pointer-to-enum-cast warning on the Exynos TMU (Krzysztof
   Kozlowski)

- Remove redundant usage of of_match_ptr() as the driver db8500
   already depends on CONFIG_OF (Ruan Jinjie)

- Remove redundant dev_err_probe() because the underlying function
   already called it in the Mediatek sensor (Chen Jiahao)

- Free calibration nvmem after reading it on sun8i (Mark Brown)

- Remove useless comment in the code on sun8i (Yangtao Li)

- Make tsens_xxxx_nvmem static to fix sparse warning on QCom tsens 
(Min-Hua Chen)

- Remove error message at probe deferral on imx8mm (Ahmad Fatoum)

- Fix parameter check in lvts_debugfs_init with IS_ERR on Mediatek
   LVTS (Minjie Du)

- Fix the interrupt routine and configuratoin for the Mediatek LVTS
   (Nícolas F. R. A. Prado)

----------------------------------------------------------------
Ahmad Fatoum (1):
       thermal/drivers/imx8mm: Suppress log message on probe deferral

Andrei Coardos (8):
       thermal/drivers/broadcom/sr-thermal: Removed call to 
platform_set_drvdata()
       thermal/drivers/k3_j72xx_bandgap: Removed unneeded call to 
platform_set_drvdata()
       thermal/drivers/k3_bandgap: Remove unneeded call to 
platform_set_drvdata()
       thermal/drivers/broadcom/brcstb_thermal: Removed unneeded 
platform_set_drvdata()
       thermal/drivers/sun8i_thermal: Remove unneeded call to 
platform_set_drvdata()
       thermal/drivers/mediatek/auxadc_thermal: Removed call to 
platform_set_drvdata()
       thermal/drivers/max77620_thermal: Removed unneeded call to 
platform_set_drvdata()
       thermal/drivers/generic-adc: Removed unneeded call to 
platform_set_drvdata()

Chen Jiahao (1):
       thermal/drivers/mediatek: Clean up redundant dev_err_probe()

Krzysztof Kozlowski (1):
       thermal/drivers/samsung: Fix Wvoid-pointer-to-enum-cast warning

Li Zetao (1):
       thermal/drivers/ti-soc-thermal: Use helper function IS_ERR_OR_NULL()

Mark Brown (1):
       thermal/drivers/sun8i: Free calibration nvmem after reading it

Mikko Perttunen (1):
       thermal/drivers/tegra-bpmp: Check if BPMP supports trip points

Min-Hua Chen (1):
       thermal/drivers/tsens: Make tsens_xxxx_nvmem static

Minjie Du (1):
       thermal/drivers/mediatek/lvts: Fix parameter check in 
lvts_debugfs_init()

Nícolas F. R. A. Prado (7):
       thermal/drivers/mediatek/lvts_thermal: Handle IRQ on all controllers
       thermal/drivers/mediatek/lvts_thermal: Honor sensors in immediate 
mode
       thermal/drivers/mediatek/lvts_thermal: Use offset threshold for IRQ
       thermal/drivers/mediatek/lvts_thermal: Disable undesired interrupts
       thermal/drivers/mediatek/lvts_thermal: Don't leave threshold zeroed
       thermal/drivers/mediatek/lvts_thermal: Manage threshold between 
sensors
       thermal/drivers/mediatek/lvts_thermal: Make readings valid in 
filtered mode

Ruan Jinjie (1):
       thermal/drivers/db8500: Remove redundant of_match_ptr()

Yangtao Li (1):
       thermal/drivers/sun8i: Remove unneeded comments

Yinbo Zhu (2):
       thermal/drivers/loongson-2: Add thermal management support
       thermal: dt-bindings: add loongson-2 thermal

  Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml | 
  44 +++++++++++++
  MAINTAINERS                                                          | 
   8 +++
  drivers/thermal/Kconfig                                              | 
  12 ++++
  drivers/thermal/Makefile                                             | 
   1 +
  drivers/thermal/broadcom/brcmstb_thermal.c                           | 
   1 -
  drivers/thermal/broadcom/sr-thermal.c                                | 
   1 -
  drivers/thermal/db8500_thermal.c                                     | 
   2 +-
  drivers/thermal/imx8mm_thermal.c                                     | 
   6 +-
  drivers/thermal/k3_bandgap.c                                         | 
   1 -
  drivers/thermal/k3_j72xx_bandgap.c                                   | 
   2 -
  drivers/thermal/loongson2_thermal.c                                  | 
169 ++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/thermal/max77620_thermal.c                                   | 
   2 -
  drivers/thermal/mediatek/auxadc_thermal.c                            | 
   2 -
  drivers/thermal/mediatek/lvts_thermal.c                              | 
175 +++++++++++++++++++++++++++++++++++++-------------
  drivers/thermal/qcom/tsens-v0_1.c                                    | 
   6 +-
  drivers/thermal/qcom/tsens-v1.c                                      | 
   2 +-
  drivers/thermal/samsung/exynos_tmu.c                                 | 
   2 +-
  drivers/thermal/sun8i_thermal.c                                      | 
   8 +--
  drivers/thermal/tegra/tegra-bpmp-thermal.c                           | 
  52 ++++++++++++++-
  drivers/thermal/thermal-generic-adc.c                                | 
   1 -
  drivers/thermal/ti-soc-thermal/ti-bandgap.c                          | 
   2 +-
  21 files changed, 426 insertions(+), 73 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
  create mode 100644 drivers/thermal/loongson2_thermal.c



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
