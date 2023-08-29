Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABCB78C9F0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbjH2QwQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Aug 2023 12:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236421AbjH2Qvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:51:43 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F5AB8;
        Tue, 29 Aug 2023 09:51:39 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-56e280cc606so904896eaf.1;
        Tue, 29 Aug 2023 09:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693327899; x=1693932699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=py8M/AaptzZRIkwjGpgtjECb2gZ1mnpcCUEmEGnuC0c=;
        b=UIA/s3KfN8va0DSLkanuUSr4kddhCtu3Q/vXyc2baeREfDvT1khqkdxcASdPEBq6kV
         lt/nGCRSTmK8zVOmcAh5US67K/pSdwRCQhmr2btDQjW2iDkBxp6qYnqO4RQWvgDxNHEm
         MGeS43KJSDTxh55Az6FB2U5TUmSeG89ceQRxPeaz+ecp1rNS4NSuOUPiz8Fh7bu6BbGh
         KwQt7/jZIwOQqo9YpLM/3GmLyUZGEYXeF/e3mHD7fuAOi+I8fk6W80pPGt3SBi7yT/Bj
         3f75c7Rt1spSagvOKzSKruYCWcOn1xasHLlfr9pC2A4RI9sWT1Fv1RqX75J/RJPd5l0r
         ZfWw==
X-Gm-Message-State: AOJu0Yy9Qz48QpgxAdKtP0i1EJPDzwkBRdHiAxX0v08/c44EljgSGDIB
        2oWILrSsPajp+O9YE/X7ufpvzoAxn4axGbggeBA=
X-Google-Smtp-Source: AGHT+IF6cNBaER+yk77Bw9dyXOzdm1gDguFFajOqVO6CKVIHx5taxM5lBFbbSQ+Pik4fLudoXTm5SrNrgcGm76x5H6M=
X-Received: by 2002:a4a:a681:0:b0:573:3a3b:594b with SMTP id
 f1-20020a4aa681000000b005733a3b594bmr13825584oom.1.1693327898911; Tue, 29 Aug
 2023 09:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <153c9f98-8d8f-a933-dca4-c3ce19ee1f6b@linaro.org>
In-Reply-To: <153c9f98-8d8f-a933-dca4-c3ce19ee1f6b@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 29 Aug 2023 18:51:27 +0200
Message-ID: <CAJZ5v0gHbbs+ipB1D37vBGHwpgN9qSW29K_mCJCSqBD1sjvkKA@mail.gmail.com>
Subject: Re: [GIT PULL] thermal material for v6.6-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mikko Perttunen <mperttunen@nvidia.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Tue, Aug 29, 2023 at 3:11 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> please consider this pull request for the thermal material
>
> Thanks
>
> The following changes since commit f6a756e8fb12923f0e3996a575e935e94f3594eb:
>
>    thermal: Explicitly include correct DT includes (2023-07-31 20:03:42
> +0200)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v6.6-rc1
>
> for you to fetch changes up to 1ef5a9f61457b921158ef03f3a2b3e789b41be9f:
>
>    thermal/drivers/tegra-bpmp: Check if BPMP supports trip points
> (2023-08-22 19:10:28 +0200)
>
> ----------------------------------------------------------------
> - Check if the Tegra BPMP supports the trip points in order to set the
>    .set_trips callback (Mikko Perttunen)
>
> - Add the new Loongson-2 thermal sensor along with the DT bindings
>    (Yinbo Zhu)
>
> - Use IS_ERR_OR_NULL helper to replace a double test on the TI bandgap
>    sensor (Li Zetao)
>
> - Remove the call to platform_set_drvdata() as there is no call to
>    platform_get_drvdata() in a bunch of drivers where that happens
>    (Andrei Coardos)
>
> - Switch the Mediatek LVTS mode to filtered in order to enable the
>    interrupts (Nícolas F. R. A. Prado)
>
> - Fix Wvoid-pointer-to-enum-cast warning on the Exynos TMU (Krzysztof
>    Kozlowski)
>
> - Remove redundant usage of of_match_ptr() as the driver db8500
>    already depends on CONFIG_OF (Ruan Jinjie)
>
> - Remove redundant dev_err_probe() because the underlying function
>    already called it in the Mediatek sensor (Chen Jiahao)
>
> - Free calibration nvmem after reading it on sun8i (Mark Brown)
>
> - Remove useless comment in the code on sun8i (Yangtao Li)
>
> - Make tsens_xxxx_nvmem static to fix sparse warning on QCom tsens
> (Min-Hua Chen)
>
> - Remove error message at probe deferral on imx8mm (Ahmad Fatoum)
>
> - Fix parameter check in lvts_debugfs_init with IS_ERR on Mediatek
>    LVTS (Minjie Du)
>
> - Fix the interrupt routine and configuratoin for the Mediatek LVTS
>    (Nícolas F. R. A. Prado)
>
> ----------------------------------------------------------------
> Ahmad Fatoum (1):
>        thermal/drivers/imx8mm: Suppress log message on probe deferral
>
> Andrei Coardos (8):
>        thermal/drivers/broadcom/sr-thermal: Removed call to
> platform_set_drvdata()
>        thermal/drivers/k3_j72xx_bandgap: Removed unneeded call to
> platform_set_drvdata()
>        thermal/drivers/k3_bandgap: Remove unneeded call to
> platform_set_drvdata()
>        thermal/drivers/broadcom/brcstb_thermal: Removed unneeded
> platform_set_drvdata()
>        thermal/drivers/sun8i_thermal: Remove unneeded call to
> platform_set_drvdata()
>        thermal/drivers/mediatek/auxadc_thermal: Removed call to
> platform_set_drvdata()
>        thermal/drivers/max77620_thermal: Removed unneeded call to
> platform_set_drvdata()
>        thermal/drivers/generic-adc: Removed unneeded call to
> platform_set_drvdata()
>
> Chen Jiahao (1):
>        thermal/drivers/mediatek: Clean up redundant dev_err_probe()
>
> Krzysztof Kozlowski (1):
>        thermal/drivers/samsung: Fix Wvoid-pointer-to-enum-cast warning
>
> Li Zetao (1):
>        thermal/drivers/ti-soc-thermal: Use helper function IS_ERR_OR_NULL()
>
> Mark Brown (1):
>        thermal/drivers/sun8i: Free calibration nvmem after reading it
>
> Mikko Perttunen (1):
>        thermal/drivers/tegra-bpmp: Check if BPMP supports trip points
>
> Min-Hua Chen (1):
>        thermal/drivers/tsens: Make tsens_xxxx_nvmem static
>
> Minjie Du (1):
>        thermal/drivers/mediatek/lvts: Fix parameter check in
> lvts_debugfs_init()
>
> Nícolas F. R. A. Prado (7):
>        thermal/drivers/mediatek/lvts_thermal: Handle IRQ on all controllers
>        thermal/drivers/mediatek/lvts_thermal: Honor sensors in immediate
> mode
>        thermal/drivers/mediatek/lvts_thermal: Use offset threshold for IRQ
>        thermal/drivers/mediatek/lvts_thermal: Disable undesired interrupts
>        thermal/drivers/mediatek/lvts_thermal: Don't leave threshold zeroed
>        thermal/drivers/mediatek/lvts_thermal: Manage threshold between
> sensors
>        thermal/drivers/mediatek/lvts_thermal: Make readings valid in
> filtered mode
>
> Ruan Jinjie (1):
>        thermal/drivers/db8500: Remove redundant of_match_ptr()
>
> Yangtao Li (1):
>        thermal/drivers/sun8i: Remove unneeded comments
>
> Yinbo Zhu (2):
>        thermal/drivers/loongson-2: Add thermal management support
>        thermal: dt-bindings: add loongson-2 thermal

Pulled, merged into the thermal branch and added to the linux-next
branch in linux-pm.git.

Thanks!
