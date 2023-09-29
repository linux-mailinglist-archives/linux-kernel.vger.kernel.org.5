Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993F07B33D6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbjI2Nj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbjI2NjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:39:16 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E4BCE3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 06:39:02 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53447d0241eso11239261a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 06:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695994740; x=1696599540; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N80cnpAhKZAQNAt0LvDi0BgqS0Cl+s+lMzHKGl0eRh4=;
        b=PB8XYtTt/2Krfplz+H6ZYkl33Gsq3y7RiFEHlwN2Fx5sYwSBaxmZHsI6PzDMLixWuc
         GimMf2klP1e394MhNDSs9zB2qqgttaiSiqf2pRNMMVdLfs/T0o4TWEvl+3e15n66gzM/
         CYBpPeMZL19lRhu4wjSNwX0iOpA3o2/IbTBsiddzUsZvETt4vrOknQXJx4bZAn5me3lV
         2Di6xELuCUHCPdiEHOppLqdr84AcwUTWqpX1TkHSz0T2zca84LRYWdF+7py9tG8Ks7eZ
         HOr0jX4+V2ZHpEXrR/djBjh1OU7DkUHGxdzSBiy1T5JKFCm63nQOaNWhbAI8QOYL2uWL
         fSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695994740; x=1696599540;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N80cnpAhKZAQNAt0LvDi0BgqS0Cl+s+lMzHKGl0eRh4=;
        b=u64ESEsvQfZL06AxOr2COZsppgReXjgh5Tac79fKbpdELEA8H3Hn/ZkQdgTmWco+6D
         l/ZVZ9nm0v1Y6d6e9vofpcyJnN8CEE9jQkzN4xXtgq5lPdLAYrBOKnGXI7n5qj7k8JLK
         APACHrpYU1gLFTeWKarZbKhYyZIqCQygzZE0NtFwVT3EZO9V/KrHDpIg/4HP8WgsVC9E
         Rf2o0zk5oL8Zjt1tjyurxag/njsjkeXiAfKI7jNQok4BU8Ry6Xa9Kfn8JgU8VQCRC2CE
         uNSZqplbOXpaaPpo1476bMUZ9OgwUgcgxl34A/LQok1osPj6dCRw27jleVNSzYOqazyC
         3yww==
X-Gm-Message-State: AOJu0Yy3XZ/GbC4ppJgoiya6vB6TpF5vBLVzSx8WtqVPHNCONVs7ETrt
        5kvxEGLAS3x++6rxf78NSLrwDA==
X-Google-Smtp-Source: AGHT+IHDZ7g5o9oqgsZvyPyN1QPbuYPFz8FvHA9hu9FRmuuDczT6e2mlFwjshH5KeTJNcUqMM0Qqbg==
X-Received: by 2002:aa7:c58d:0:b0:530:8d55:9c6f with SMTP id g13-20020aa7c58d000000b005308d559c6fmr3183409edq.2.1695994740560;
        Fri, 29 Sep 2023 06:39:00 -0700 (PDT)
Received: from [127.0.1.1] (178235177217.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.217])
        by smtp.gmail.com with ESMTPSA id cx14-20020a05640222ae00b005362bcc089csm2215701edb.67.2023.09.29.06.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 06:39:00 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] 8280 display ahb clk fixes
Date:   Fri, 29 Sep 2023 15:38:51 +0200
Message-Id: <20230929-topic-8280_ahbdisp-v1-0-72bdc38309b9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGvTFmUC/x3MMQqAMAxA0atIZgMxClqvIiK1Rs1SSysiiHe3O
 L7h/weSRJUEffFAlEuTHj6jKgtwu/WboC7ZwMQ1GTZ4HkEddtzRZPd50RRQqpaEnOWmYchhiLL
 q/U+H8X0/pz8Sc2QAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Little fixes to shut down disp ahb clk when dispss is not in use.

If possible, the dt patch should theoretically go in first, but x13s
worked fine regardless.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      arm64: dts: qcom: sc8280xp: Use the correct AHB clock for DISPSS1
      clk: qcom: gcc-sc8280xp: Don't keep display AHB clocks always-on

 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 4 ++--
 drivers/clk/qcom/gcc-sc8280xp.c        | 6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)
---
base-commit: df964ce9ef9fea10cf131bf6bad8658fde7956f6
change-id: 20230929-topic-8280_ahbdisp-e170e0ca2442

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

