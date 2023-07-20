Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A296C75B0F5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjGTONw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjGTONo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:13:44 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77B1211D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 07:13:43 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-444c5209861so328549137.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 07:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689862422; x=1690467222;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LYeTnX0ktaD2hs8ft560UZNiRm51amQas2cIgUUmFfI=;
        b=kAn24OTQ4vb0TF3yTtDLq9PWfO6GyVuCDDvkwEKkXgSEN5b36cRSrw1pKxpALm9CKA
         rWKWHPiuSU2E4JZcWe2yPU8oXCDhbqvjprZJDNMoPG8hxd4S/6f5FLguNUUui5QOVCw6
         u5zW9BdjCmNznhLIdxjwk+OgI4pIcxGLAAze1VTDBv7YuH/9rZ94ca3q1e1DWwClBjbq
         h/hHEcPr7oUhFhB7u7rfLxP8ezyi2Avc4nhQNvltIIZzoTrQp0TrMqW36X6VjjB2E5nu
         /vvOTMDBIQB57UDS1r6iY7saMOAnO9TXQ2Oz+tkkeU4ViSfpa4y8axg/EZKNTHQNYd0E
         F6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689862422; x=1690467222;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LYeTnX0ktaD2hs8ft560UZNiRm51amQas2cIgUUmFfI=;
        b=duEO6SD80BtwAWCv6yoBgElo5UhvAPsa2qsVBgkUDcpvMV75c9Uavp3p9WrgDN6gh6
         FHqfR92Z0yOlqTI+GrtVb4S7gUTGEDiDPEVRFT1YxXW6MDfmDpKsdZ++wlrjzC3o+SwV
         F0hqRGChWqnnbwheoUm10lE8AShUoeEN9L1gPv831oXEt5KgZ0sttcS7AgQjhtyv9vi7
         opMYuxGsK0Hs48tuLJyp0brb0escMQk+tnEOpggTl8jdb8P6TlHfmo5cpCz5EKiDlO61
         F934WnCPvsoza53zYSPW/Ol+RbpwEXdHyLkZJBD6a3tVNyQ6spgGMLdvFKMpsrPtvhnY
         sSAQ==
X-Gm-Message-State: ABy/qLbtzCTYOTv1lziNgJcAXGZ2ybAUpvp5awHk86UIqktD5OxJOOBQ
        OZNPKgL84yMfyn2E+T0lFel/bzUwXtKOm0SnnujY0nUYBm+ziWeNVD8=
X-Google-Smtp-Source: APBJJlGJ9epJUV2htxdaWBnegz8aVGpAucsS8qRau2RZHnQGzhDGv2JOguFaJ50KJJKHiJTEuXV65HIcF1KuyMzNQo4=
X-Received: by 2002:a67:eac2:0:b0:443:8eab:c664 with SMTP id
 s2-20020a67eac2000000b004438eabc664mr5433670vso.13.1689862422250; Thu, 20 Jul
 2023 07:13:42 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 20 Jul 2023 19:43:31 +0530
Message-ID: <CA+G9fYsfziBmQGQMGAKojhemCXssFyiNgk6aNjVXpJNNFh_5mg@mail.gmail.com>
Subject: next: arm: dtbs/exynos4212-tab3-3g8.dts', needed by '__dtbs_install'.
To:     open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Artur Weber <aweber.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following build errors noticed while making dtbs_install for arm on
Linux next-20230720 tag.

Regressions found on arm:

 - build/gcc-12-exynos_defconfig
 - build/gcc-8-exynos_defconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

make[4]: *** No rule to make target
'/home/tuxbuild/.cache/tuxmake/builds/1/build/dtbsinstall/dtbs/exynos4212-tab3-3g8.dts',
needed by '__dtbs_install'.
make[4]: *** No rule to make target
'/home/tuxbuild/.cache/tuxmake/builds/1/build/dtbsinstall/dtbs/exynos4212-tab3-lte8.dts',
needed by '__dtbs_install'.
make[4]: *** No rule to make target
'/home/tuxbuild/.cache/tuxmake/builds/1/build/dtbsinstall/dtbs/exynos4212-tab3-wifi8.dts',
needed by '__dtbs_install'.
make[4]: Target '__dtbs_install' not remade because of errors.


Links,
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230720/testrun/18470052/suite/build/test/gcc-8-defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230720/testrun/18470065/suite/build/tests/


--
Linaro LKFT
https://lkft.linaro.org
