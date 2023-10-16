Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B86F7CA0C5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjJPHhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjJPHhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:37:16 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AE5E8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:37:14 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99de884ad25so672405266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697441833; x=1698046633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HTyUQuoAbVjluxgr+h6sTqmqhDJGxpZB2IhyvmjXi6k=;
        b=Yzgt5ikvcI8rVGKsXsasXHUtt43axDil0nItBbVimWPB1Ca3fCEaryHvEfZPjA+/Lc
         WqrR6wBpLLwAWHlqgN/9ei9q/7bEhBIC3GOekxc4ulqFtKCqQHuaVfeW2gBgYEDUPG2l
         nfKZpne1xfFadylRS92yaMctL3JEN6JcuTolv7aY/6u7Vcdish7AXZ6vcZ+Mz+Q7lZTj
         8G6bt3E8/GxUdiM/oxuVMaQPtskzrfRlbYXFISayn4PzWq0yIw98wa7e+VQBQp+RnRXL
         v98zR/uIFcv47BCrVwhP+08iv2iSR4UCU2H/6i3x7tgkEpfjGCQ2a4+q4dobOCV0Zytz
         RAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697441833; x=1698046633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTyUQuoAbVjluxgr+h6sTqmqhDJGxpZB2IhyvmjXi6k=;
        b=MyWgTBNQ0k5wqrYtQbsez/PYlLr+9WVT4kglZOPq6ewSiEYOwNTSXlb9/+MmLcNPEM
         kIygrk+gGDhbYk8jbNi3UiDgq9X3XsPk3ZIHuHZyzig8snCklNqu6zAy7JOKFxcLbNc2
         8AHTVimKxfk2iqW8htb/RJgrIstKP48xEGrJLBYEk1KDFUIvLNULPkswJWspJ0ECv8mB
         k3038GmaK38wu1q4zQ7QwmOPMr/5JMCThUlCzBeOKcG+C3XZ6YwOTBdNzCLydiHdi/Kb
         30FI8w3vQxk96iN4Jrg4y4Sz36L4hy4/E6IPC451r/Ua5IlAvYk+WpD7fFynUHbfO3X4
         wKww==
X-Gm-Message-State: AOJu0Yy50xLUawRP5qiRw6d1Cz+PMW1RjHMIM/2ehzlPwBFUoiKozh6G
        rWsTnfHlpydg+3blXfTzOtRgpA==
X-Google-Smtp-Source: AGHT+IEv0uejqa5NJBXNL8LEnWXrDwz7b76fiOOhyJGmmtCK0e7+o9cqfbI1hF43wqrFAkSUSjwscw==
X-Received: by 2002:a17:906:538a:b0:9b2:b269:d563 with SMTP id g10-20020a170906538a00b009b2b269d563mr29105305ejo.63.1697441832837;
        Mon, 16 Oct 2023 00:37:12 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.154])
        by smtp.gmail.com with ESMTPSA id w17-20020a170907271100b009a5f1d15642sm3468031ejk.158.2023.10.16.00.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 00:37:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] pinctrl: samsung: drivers for v6.7
Date:   Mon, 16 Oct 2023 09:37:09 +0200
Message-Id: <20231016073709.27851-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tags/samsung-pinctrl-6.7

for you to fetch changes up to 8aec97decfd0f444a69a765b2f00d64b42752824:

  pinctrl: samsung: do not offset pinctrl numberspaces (2023-10-09 12:37:21 +0200)

----------------------------------------------------------------
Samsung pinctrl drivers changes for v6.7

Few cleanups, improvements (use __counted_by annotation) and finally
switch to dynamic allocation of GPIO numberspace.

----------------------------------------------------------------
Kees Cook (1):
      pinctrl: samsung: Annotate struct exynos_muxed_weint_data with __counted_by

Mateusz Majewski (4):
      pinctrl: samsung: defer pinctrl_enable
      pinctrl: samsung: use add_pin_ranges method to add pinctrl ranges
      pinctrl: samsung: choose GPIO numberspace base dynamically
      pinctrl: samsung: do not offset pinctrl numberspaces

 drivers/pinctrl/samsung/pinctrl-exynos.c  |  2 +-
 drivers/pinctrl/samsung/pinctrl-exynos.h  |  2 +-
 drivers/pinctrl/samsung/pinctrl-samsung.c | 56 ++++++++++++++++---------------
 drivers/pinctrl/samsung/pinctrl-samsung.h |  4 +--
 4 files changed, 33 insertions(+), 31 deletions(-)
