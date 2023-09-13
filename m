Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82C079ECEA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjIMP3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjIMP2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:28:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EF21FE5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:28:48 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31c5a2e8501so6814588f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694618926; x=1695223726; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/d3xKANM1+Tg4h0nwb5Z/K20lY+AlE+zGQheDE2qGpc=;
        b=AhqfG2+5FcuejNIvuv5zMQkFaApwcEyt8Dk1eYhKBhfll3VnwmP5KRRn8Jc1hnIeqC
         i16rrqZr7JA0PL88gUXYuuE6xqsQyZN6MK0oYAxYKGb6ICZda80o6Qqt0GAWIK5iVHEk
         SirrUjSVAsEajCPIqxqwAyyLbVb+JYmVsECM4Asfn3RXi+Rx6XAR/pshdEYwSHs/PEus
         XMQ3MwURHew9Nb3UViSyidNtpEqE4czUeZ7ttYoZWxe9MLEqxmBsC2kWtgfgLmPIu6RV
         8yRfo3llOduJOhp44QP1oRhoZv+UzdkBU8GPTwUC7DHtYgHqUbhRmPzcOJy0BRONXoST
         gTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694618926; x=1695223726;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/d3xKANM1+Tg4h0nwb5Z/K20lY+AlE+zGQheDE2qGpc=;
        b=Sflonal1nJe6rhrGla+/Cy4VuXp+rnMDK+mvsbeu+M5W3Y5ZBP3KJPRxh3sDqDsd+G
         Q1wmVjS5ZTAlK0wPa/jIcRf6NTX0qOdYvUcUWmNZhsj9fhOygIkiZKL7HIsHWb9gWUH+
         rS4zfxq8sELNxTcZFPuA02jKUocMu+cSPdVdygqfdMi/ydvKetfs11Fhwr6FL6iUFidT
         UGug/wqfJ6cFvEbtg7AVN10CYGoSttV/FhDeQWcTQNgVsCBw8oKn1EzvHWaOIkqAVToc
         JOHRz18FAMbYsYIXfKNMDM+BtC2jxQzH+ngzwAzH3LYIMk/mEqC9XAdC7g1BaSOaxI3Q
         yPFA==
X-Gm-Message-State: AOJu0YxnWX59drHhHfxFGrfWW8k9HGa/evqzvzq1HT8txlVqDkSTT5YA
        b87sfLGlB9Max38bi6MBHL46sBqyNyogxocto/WhJA==
X-Google-Smtp-Source: AGHT+IFPKfpKr7JxfwV7TtSFzjcqi3rNuz/mPAOK8wwns9KWtPA/nP9F/6atME34EMEXX6TndxWazA==
X-Received: by 2002:adf:b306:0:b0:317:df4f:4b97 with SMTP id j6-20020adfb306000000b00317df4f4b97mr2330649wrd.7.1694618926324;
        Wed, 13 Sep 2023 08:28:46 -0700 (PDT)
Received: from [10.167.154.1] (178235177106.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.106])
        by smtp.gmail.com with ESMTPSA id a11-20020aa7d74b000000b0052a404e5929sm7391979eds.66.2023.09.13.08.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 08:28:45 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 0/3] MM8013 fg driver
Date:   Wed, 13 Sep 2023 17:28:42 +0200
Message-Id: <20230621-topic-mm8013-v3-0-781da361ec60@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACrVAWUC/32NQQ6DIBQFr2JYSwMfRe2q92i6AEQlUTBgSRvj3
 Yuu2kVdzkvmzYqC9kYHdM1W5HU0wTibgOUZUoOwvcamTYyAACMcKF7cbBSepppQhlnFq7LRTS2
 hRkmRImgsvbBqSJJ9jmMaZ6878zoa90fiwYTF+feRjHRf/7xHigkuClIpDpyQkt1GY4V3F+d7t
 D9FOLNht6XmAKysK9F+23l2ZjUdlQXtCqkI/2lu2/YBIZYv6TIBAAA=
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694618924; l=1329;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=O8IJxCgW8NJAZR11B6cnppK2RlWuoaoVovJyUjtSzjc=;
 b=Xvlu7u7xd3EMxyhDH4IZnXF98FyEd04pkOaHT6okLEyrsrCnqxomnnMeq3/9QD+TtcvueT/qW
 PTpashvKGNUBjcq3mpBhpMwM8ejZ6eWtn+1pI7Sa8HxCqlmF+HnUEfH
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series brings support for the Mitsumi MM8013 Li-Ion fuel gauge.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v3:
- Reference power-supply.yaml in bindings
- Link to v2: https://lore.kernel.org/r/20230621-topic-mm8013-v2-0-9f1b41f4bc06@linaro.org

Changes in v2:
- Fix typo in patch 2 commit message
- Drop driver.owner in patch 3
- Add PRESENT psy property
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20230621-topic-mm8013-v1-0-4407c6260053@linaro.org

---
Konrad Dybcio (3):
      dt-bindings: vendor-prefixes: Add Mitsumi Electric Co., Ltd.
      dt-bindings: power: supply: Document Mitsumi MM8013 fuel gauge
      power: supply: Introduce MM8013 fuel gauge driver

 .../bindings/power/supply/mitsumi,mm8013.yaml      |  38 +++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |   5 +
 drivers/power/supply/Kconfig                       |   9 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/mm8013.c                      | 283 +++++++++++++++++++++
 6 files changed, 338 insertions(+)
---
base-commit: e143016b56ecb0fcda5bb6026b0a25fe55274f56
change-id: 20230621-topic-mm8013-376759e98b28

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

