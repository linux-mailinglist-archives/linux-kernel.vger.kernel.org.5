Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B96E7B408F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 15:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbjI3NlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 09:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbjI3NlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 09:41:21 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5C71B2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 06:41:19 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4060b623e64so9859325e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 06:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696081277; x=1696686077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eJoM3geBcjIHXCFO0Ynx9CVYJRwKfnB5miGTvqrYdhk=;
        b=tK58F9UKxKSwe82qYH36VvXnCUX/LK+rl/4MI+2TBezzm4rv99VVrW3tu9sbJF8pYx
         9gw05SlYF07Ocx+MIj2CYiG7LnlOQ3eEQysZ3FmWp1K+32olejuRPbGuvNgp8iQl8uZt
         aBqsjrON894bDy/p3oEZIOKKBhmKxaAiIH634JSUGve4+f1/OMfwNJ2trMolbZQ7//3k
         ObTF9Ns4oRKxQuM8RMtatWfOpoKlU+dmKFngZ+dftPY9F0BpaIL3cW3kiLnsHCwMjcvs
         GrFCDKjpSagvwiL5yTokE5n4VLgACRNtOj5Tn/whYmc4u/2GDnZ2GqyOlXSEV68T9L1l
         wnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696081277; x=1696686077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJoM3geBcjIHXCFO0Ynx9CVYJRwKfnB5miGTvqrYdhk=;
        b=iU7hvP4pK48+pQli5RmlYRM///epF+noM1QkbcH6nb7gGNwypQCgd5gprJtqAXUark
         Sp1fGicD4KK4DbgjboW/2cidcVtYCXq1it77qwByP1DmqL+l8mjxFuEKzFKxd0f6mee3
         Di6ANSYsMJHjajdOaezIEfRH9y8lvrg6Xf+AkmawRKEFijtnrW5kQygtVQwd3MdQ0Gqc
         zxPgjBQbVVsnwcWxgVzM7lz0SHei6oaedikLeqeuQf4DneCBcWF1QjakNr4heHlznz/g
         7a78MR48+nvxF5tq0Vrx7ndbyny8kKIyN0v8dNVPiDuiK8312M0i8wi1icK3vTqZX9MN
         EtWQ==
X-Gm-Message-State: AOJu0Yxj7/KVDaEpzri4Fh1hWSwrjcC/aL7erFOS7kfBKFQTBYXTpdpl
        gZYcGxyhGpvC5/FKCTsfqNnJDA==
X-Google-Smtp-Source: AGHT+IG0ZqV8SkamgfW0teCI7xDdzqKl/VtV8Y3kgDHuWYbc7Bq94TWbYn2TXcXcqhLHj2Fvtk8c+Q==
X-Received: by 2002:a05:600c:2287:b0:405:409e:1fcb with SMTP id 7-20020a05600c228700b00405409e1fcbmr6276169wmf.5.1696081277381;
        Sat, 30 Sep 2023 06:41:17 -0700 (PDT)
Received: from x13s-linux.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c020b00b003fe2b081661sm3408261wmi.30.2023.09.30.06.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 06:41:16 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jonathan@marek.ca, quic_tdas@quicinc.com,
        vladimir.zapolskiy@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH v2 0/5] Add sc8280xp CAMCC bindings and driver
Date:   Sat, 30 Sep 2023 14:41:09 +0100
Message-Id: <20230930134114.1816590-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2:

I've expanded the scope of this series to include some fixups for the
camcc.yaml in general.

- Adds qcom,camcc-common.yaml
  There are a number of repeated patterns in the various camcc yaml
  files which we can contain in a common camcc .yaml instead.
  I used gcc.yaml as a base per Krzysztof's suggestion.

- Adding the common values file I noticed that sm8450 and sm8550 were
  both listed as compatible strings in qcom,sm8450-camcc.yaml.

  This appears to be in error though since sm8450 and sm8550 are
  not compat strings of the same driver but different drivers entirely.

- Switches to indexing, instead of fw_name for clocks - Konrad

- Adds the GCC AHB to the clock index - Bod/Konrad

- Changes reference "cam_cc" to "camcc" throughout camcc-sc8280xp.c

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-26-10-23-sc8280xp-camcc-v2

V1:
This is a bog-standard series to add in the CAMCC for 8280xp.
As a precursor to adding in sc8280xp I thought a bit of tidy up on the
existing yaml for the camcc controllers in general would be worthwhile.

As a result there's a precursor patch which aggregates the various camcc
yaml files into one location.

The sc8280xp looks like sdm845 with more blocks. Similar to sc8280xp we
park GDSC to CXO. Thanks to Dmitry for the suggestion the GDSC parking.

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-23-09-23-sc8280xp-camcc

Bryan O'Donoghue (5):
  dt-bindings: clock: qcom,camcc-common.yaml: Add a common file for
    camcc
  dt-bindings: clock: Add SM8550 CAMCC yaml
  dt-bindings: clock: Add SC8280XP CAMCC
  clk: qcom: camcc-sc8280xp: Add sc8280xp CAMCC
  arm64: boot: dts: qcom: sc8280xp: Add in CAMCC for sc8280xp

 .../bindings/clock/qcom,camcc-common.yaml     |   44 +
 .../bindings/clock/qcom,camcc-sm8250.yaml     |   32 +-
 .../bindings/clock/qcom,sc7180-camcc.yaml     |   23 +-
 .../bindings/clock/qcom,sc7280-camcc.yaml     |   23 +-
 .../bindings/clock/qcom,sc8280xp-camcc.yaml   |   57 +
 .../bindings/clock/qcom,sdm845-camcc.yaml     |   23 +-
 .../bindings/clock/qcom,sm6350-camcc.yaml     |   13 +-
 .../bindings/clock/qcom,sm8450-camcc.yaml     |   33 +-
 .../bindings/clock/qcom,sm8550-camcc.yaml     |   56 +
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |   16 +
 drivers/clk/qcom/Kconfig                      |    9 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/camcc-sc8280xp.c             | 3052 +++++++++++++++++
 .../dt-bindings/clock/qcom,sc8280xp-camcc.h   |  179 +
 14 files changed, 3437 insertions(+), 124 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,camcc-common.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc8280xp-camcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8550-camcc.yaml
 create mode 100644 drivers/clk/qcom/camcc-sc8280xp.c
 create mode 100644 include/dt-bindings/clock/qcom,sc8280xp-camcc.h

-- 
2.40.1

