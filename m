Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195E680322D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjLDMIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbjLDMIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:08:45 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9741F0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:08:47 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6d855efb920so2367622a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701691727; x=1702296527; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IAe9GaCJ0H5vY1B6g7SXdKDaasEFIEo0v3Vb6EsU02M=;
        b=hbbvKPKpKMeBxZJRrYw5ZC4METKpBkGd3y9IHK4Sqc3ohdwfV/BRaSWuAaV3B+PUTs
         DuAKw4npdBh8X1Qo30EFXMbPaoc/d4iuMW7K/o6tlQcspx8klUIebUGH7tr5fUcwFMBr
         3qsPHNsJ5rmjsPtR+ug4DC1AkvfcZePkaAgJj6xUF0vgWPNO79f03ZOj9IO3krSWtvnf
         8PpPFE9GwJgIW68YiGt/UG5uD99LKF+hRTtGfXoKdNYrPYkGzEct9FqrAwCFF1v8POyu
         3Ik2v/rVKrwfd4Lg8RqxfUr4Dn217aM81MaGKT49/7sm/BW1llKwj3Y6nys8YcOTUUnO
         GNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701691727; x=1702296527;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IAe9GaCJ0H5vY1B6g7SXdKDaasEFIEo0v3Vb6EsU02M=;
        b=Ht53Mn1NX76wfRmJNumDWMg1UbD5JHcL2eesaC6MIB9Wi4BuOHSAXmvHvRjEUx3vi9
         Ukfcqc3199g9UN2GEm/vwQoGZfC7a/E+OLKGjeLON3ptXuvcBRoxd1wC2AP9hlkb7BXf
         dPM8bVW+qo3cQqF/FWTyoYKKd27gY06CpQYLf4nXFw3PZLB8cL9gNyIeynuL2QJbj96O
         eEtoLDoPE8yTcXg9trpvVTg0kPs7cQLeI5t08Z9Rc6c8HSZYrJojJu1OrWvEBPikLon/
         PgnY0CvijntdvLMKQfBMs4S/rwAMxv9mu89Hpzo0JqI+6tcz8ROnK5tv1sMB22tF/o0z
         voVw==
X-Gm-Message-State: AOJu0Yxe665auJdcyH/4yf7FmeqQo57aUmPjNAnjHDbhEyFxuCDaPFsB
        dybtRfOQA8bk42ZhkF6K1oP8MVVfXumABVSRNAlnXA==
X-Google-Smtp-Source: AGHT+IGpxhG9ncEHtpz4tZmgtmPIk7IOrxR6wBSf/VSlVIlLP3HqVCGl9n1/Gfb0hG0y3KjTRRQ8IEEqRzi+yhZ9cYg=
X-Received: by 2002:a9d:75cc:0:b0:6d9:9e2f:e743 with SMTP id
 c12-20020a9d75cc000000b006d99e2fe743mr1360919otl.16.1701691727048; Mon, 04
 Dec 2023 04:08:47 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 4 Dec 2023 17:38:36 +0530
Message-ID: <CA+G9fYs1g2Pt=DQeaJC+3ZJTeMwKAs9GuGJ9k6BcwKwEXcn5kQ@mail.gmail.com>
Subject: arm: gcc-8: drivers/pinctrl/mediatek/../core.h:211:21: error:
 initializer element is not constant (struct group_desc)
To:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Linux Regressions <regressions@lists.linux.dev>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, sean.wang@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following build errors noticed on Linux next-20231204 tag with gcc-8 toolchain
for arm and arm64.

## Test Regressions (compared to next-20231201)
* arm, build
  - gcc-8-defconfig

* arm64, build
  - gcc-8-defconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log arm and arm64:
------------
In file included from drivers/pinctrl/mediatek/pinctrl-moore.h:21,
                 from drivers/pinctrl/mediatek/pinctrl-mt7623.c:11:
drivers/pinctrl/mediatek/../core.h:211:21: error: initializer element
is not constant
 (struct group_desc) {      \
                     ^

Links:
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2Z43zPIMN6vxVKd9rKJFdOKXpox/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231204/testrun/21472198/suite/build/test/gcc-8-defconfig/details/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231204/testrun/21472585/suite/build/test/gcc-8-defconfig/details/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231204/testrun/21472800/suite/build/test/gcc-8-defconfig/history/

Steps to reproduce:
---------------
# tuxmake --runtime podman --target-arch arm64 --toolchain gcc-8
--kconfig defconfig



--
Linaro LKFT
https://lkft.linaro.org
