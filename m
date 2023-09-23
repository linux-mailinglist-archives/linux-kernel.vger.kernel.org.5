Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45A77AC169
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 13:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjIWLuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 07:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjIWLuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 07:50:03 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43BD19E
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 04:49:56 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9a9cd066db5so474407666b.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 04:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695469795; x=1696074595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7bX8G2i5J1ALZVJ03xHMbBXo1RYMNHbxXzPAX+U85OE=;
        b=trwxj07XNKdKs0y3gbtJBP34FgUJBrHbdQcQ7OHk+F3t+Lx09wuzFcvcHSVDonjlj6
         ZEdYJdCBQ3096GMYe/q+TvyUoi6tbnOH6KzHtXCpU7W68UvSYr96oMq+2exLRaiSrQl5
         L0UNpi3y33K1B4TFbm9GE8268vaicP6s01zGDHDD0hB/uEHYITzkvplQHbJ3FZH4wV2N
         wSWpzlAYk6FC8Wfwl1f5HDZGT/8UJQ5jo+dVzcFpIiDoO/un3Jzzm8mIU0P1mjczjiUv
         L3G7A2VW0ZCFwjxF4KSGCmkFmJ7tpRu1Ux2hO9cKDnTewSZyTo8ujlxEa/c27/9O63Ss
         8z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695469795; x=1696074595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bX8G2i5J1ALZVJ03xHMbBXo1RYMNHbxXzPAX+U85OE=;
        b=lIZTIAdcgrO4B7XMoUgYXYyilmT/YpJmEPiTeiBNt9PZtJLLEjCc3gC5RvGDmE5+F1
         /1iewy2iIK0YqPsSXK+O2E1aaHYrL6HF6UoiaN33hjgWgrI1wNhUy/Zhq+wO0caCoeLL
         8Eaj9TmUuEE2kOmrzZT3n5TJA77kNYjn7Pnq0d3ZnlFkdd59sSUAMhlKyYN+nmE/RSU0
         sLcoU1s38nDDWXgm13oILcODWM8laBH7L2QpxnTl12VAK/kr5YzG6UJ9WWMmMfzX4fF0
         v3opYQePQZ0LxyUe6rogehLQmEdU45Lp4WJNRYihROi4a3clRy9pIxHIwHvRQBxNSpH6
         blOw==
X-Gm-Message-State: AOJu0YzUXfAnuWC5c+ybO+SHJySI4cHYjEbtWb7vIQ1YYYCLWQilXED+
        dHeJLom1ni/Hvhvc2Lbdi8063sflZdYMZUtCA7LeNg==
X-Google-Smtp-Source: AGHT+IG8DLjJo91vVqlschipubLLnfmElr6jL7EewmfjZ4KVex04FVEQhHfctFNvKnTMuL13HbeIvw==
X-Received: by 2002:a17:906:ae81:b0:9ae:961a:de7f with SMTP id md1-20020a170906ae8100b009ae961ade7fmr1782614ejb.30.1695469795336;
        Sat, 23 Sep 2023 04:49:55 -0700 (PDT)
Received: from hackbox.lan ([86.120.16.169])
        by smtp.gmail.com with ESMTPSA id qk8-20020a170906d9c800b009ad89697c86sm3889110ejb.144.2023.09.23.04.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 04:49:54 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: [RESEND v3 0/5] PM: domains: Add control for switching back and forth to HW control
Date:   Sat, 23 Sep 2023 14:49:45 +0300
Message-Id: <20230923114950.1697701-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a resend of v3:
https://lore.kernel.org/lkml/20230823114528.3677667-1-abel.vesa@linaro.org/

Just added Ulf's R-b tag to the 2nd patch. No other changes.

Abel Vesa (1):
  PM: domains: Add the domain HW-managed mode to the summary

Jagadeesh Kona (3):
  clk: qcom: gdsc: Add set and get hwmode callbacks to switch GDSC mode
  clk: qcom: Use HW_CTRL_TRIGGER flag to switch video GDSC to HW mode
  venus: pm_helpers: Use dev_pm_genpd_set_hwmode to switch GDSC mode

Ulf Hansson (1):
  PM: domains: Allow devices attached to genpd to be managed by HW

 drivers/base/power/domain.c                   | 84 ++++++++++++++++++-
 drivers/clk/qcom/gdsc.c                       | 32 +++++++
 drivers/clk/qcom/gdsc.h                       |  1 +
 drivers/clk/qcom/videocc-sc7180.c             |  2 +-
 drivers/clk/qcom/videocc-sc7280.c             |  2 +-
 drivers/clk/qcom/videocc-sdm845.c             |  4 +-
 drivers/clk/qcom/videocc-sm8250.c             |  4 +-
 drivers/clk/qcom/videocc-sm8550.c             |  4 +-
 drivers/media/platform/qcom/venus/core.c      |  4 +
 drivers/media/platform/qcom/venus/core.h      |  1 +
 .../media/platform/qcom/venus/pm_helpers.c    | 47 +++++------
 include/linux/pm_domain.h                     | 17 ++++
 12 files changed, 165 insertions(+), 37 deletions(-)

-- 
2.34.1

