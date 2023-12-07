Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4914E8085E0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjLGK2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjLGK2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:28:09 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA76419A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 02:28:13 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-33348e711e0so744187f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 02:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701944892; x=1702549692; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hLBYCsu9d8WmaQTQcfobdTHi3f2NWL6EdzvNFiXeOFw=;
        b=beVI/smy18lRud3CUcKCjxOP0a4n4ZzdeqD8nhXOf3tHOUKdOCfB1n0aH54a3rxwIH
         uYBLuwpCk2PJbGgeiggRJZX5tubeu6rfkYa87XTwFjMqwBoT4j4hDtbQccKp9qMlB5k0
         ZD+TwZnm5VtAcmCQyEY+FTruVBy5OyJVfY6iXnN2la2OEe+z7WGJ2Sc3bMA+vCLy3icX
         CQ7qTPNnGaAX0bhq6hey98hgYCf3ZzjIAPo9aFrzmI4sWlZBsZZyJ2VSCdM7WtFsYBOA
         n0cHj1ggpR3gO2Hwl1/qGHz6Rd5bEw3Qx/HpJsXltTRm5JIBFDarDmbwx6QocdassnJd
         krHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701944892; x=1702549692;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLBYCsu9d8WmaQTQcfobdTHi3f2NWL6EdzvNFiXeOFw=;
        b=cjl06x4nFpnoprpVwkc4oigSblaiLsfVYYIS4a/42+0SIvTaS59XOIAEM/WIpm4eOP
         hVlz5iyOsd9k6GGzGt/24WtdavL0KSmKjzWG8TaMqZ1simxsgXFe88Wq8hkUZpndA6v7
         jsi0s/iy6sAhDpxw+e+uNz/PqxLetp+tGoSGiEC3Q16m93icASXwKJCjEe5viHTNNcLJ
         NTaL6xDF6kqLsuQ1xSr08Ij6+yx9qzhMQGSHFp9Xd+x8rfu/OGCJ2Swzu+mYwRJWhiBX
         ZhcKk/EFyU2NeLDsjykxh6rqyn3xMqyRYfZvG+F5ALzoY0REvVNrXWfr6pTooKzpA1VE
         Qmew==
X-Gm-Message-State: AOJu0YwTTBBo/gSr+0GdvAdxkDvV7e6i6/sy/dFMQVxxLw78oeTBT4Kr
        NQKxAtkZk+atd819lT+wI1QRcA==
X-Google-Smtp-Source: AGHT+IFxtgcZ9BWWTaiGAX12un0qVcpcHQm3BrfMx0yMmvlbVwvLRsso141EN2lpYKSjr3UiJJkaFQ==
X-Received: by 2002:a5d:688d:0:b0:333:3fc7:f2b3 with SMTP id h13-20020a5d688d000000b003333fc7f2b3mr1589969wru.35.1701944892241;
        Thu, 07 Dec 2023 02:28:12 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id d2-20020adfe2c2000000b003333d2c6420sm1073412wrj.74.2023.12.07.02.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 02:28:11 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/5] ASoC: codecs: add support for WCD939x Codec
Date:   Thu, 07 Dec 2023 11:28:03 +0100
Message-Id: <20231207-topic-sm8650-upstream-wcd939x-codec-v3-0-6df9585ec7c8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADSecWUC/5XNsQ6CMBSF4Vchnb2G3hYEJ9/DOJT2Ak2EkhYRQ
 3h3C4tx0/E/w3cWFshbCuycLMzTZIN1fQxxSJhuVd8QWBObYYqCcxQwusFqCF2RZyk8hjB6Uh0
 8tSlFOYN2hjRomdc58irLjGRRGjzVdt5frrfYrQ2j86/9dOLb+p8/cUgBuZHKlHjKDV3utlfeH
 Z1v2HYw4QfFlP+GYkRLSabgssJMqS90Xdc3pcF7ZCwBAAA=
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4100;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=kcGuLbZl5aneodJLsCPYh6Dc/XYF3ek5bDn5E1Ya4bw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlcZ44o63KoaGOJ3a6jMhKpCsbV0QE4pJ6LDsBTL2C
 OIjVn4qJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZXGeOAAKCRB33NvayMhJ0ZsrD/
 42E7eGy9DDA8l7Cu4mN1o9QO5v6Ex0NBfyf1lYn/Z62pZMVoo0wonrkASGIeZ9+65kUeIim6RLwrPf
 zAgEmf56jO08zz7/Yo68NehVzPfZnu87CT1DAgGhD2uugm6pSxhKFPIUcMCJKEQet2imD1w7G+2fYf
 gqHtCXrVqi3MRM8kKsotnI/uTdAVjfNdBhSkv6pNOO5DEfGGkDQz0eH0k1nzwc3wp1cvx9N/5htNP2
 iQFBoqMeP6ggYsUfbrUW7ds2Z0fCDYJXqZ5VLZOIw8BITe8ZpNmXU2XbmqlqC8I6W6BJHYhaq2xBuS
 mEqaupHQjf0kkTjx9Xmt6XGWjKIaoxhLJHajytxZHNojCLd9XNEKMb+THcNLSGnNjS5wEoRe2K3wSM
 eMF38D9l4NgBfVBiwnnL5MMdoamrOVaSK+5GRePeHgo+AUCgYqNkINBDuzrWCIGnCxpDBcX+GkNrNd
 b/svKUCk3B62GzqcIL1tO0UYfLCBqscGGNy4YxoRczxG57zaLVBlsli1Zut1eo6xNo1Knl0UyclWGL
 h0i8p6CeH6DwY6Z0blpBoM3XwZud3yIGARa1zc6vs0/WGDfyKceSEPe9PPMvSdscAO5KLupy8V8uMh
 P/+kuakLo5qsFqsK4Z4stUhFS/Okhnbhx7XECvAMr5NOOtIc28aSvlb9eMSQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the main WCD9390/WCD9395 Audio Codec driver to support:
- 4 ADC inputs for up to 5 Analog Microphones
- 4 DMIC inputs for up to 8 Digital Microphones
- 4 Microphone BIAS
- Stereo Headphone output
- Mono EAR output
- MBHC engine for Headset Detection

This adds:
- bindings
- MBHC changes to support Type-C muc
- Soundwire Slave driver
- Code driver

The USB Mux subsystem support will be submitted separalety
since it's a functionally separate subsystem connected over
I2C with it's own reset signal.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Fixed W=1 and smatch warnings reported by lkp & Dan Carpenter
- Fixed dependency on CONFIG_TYPEC and added guards to not build type-c related code when disabled
- Collected review on second bindings patch
- Link to v2: https://lore.kernel.org/r/20231201-topic-sm8650-upstream-wcd939x-codec-v2-0-94ed814b25aa@linaro.org

Changes in v2:
- Bindings:
  - Dropped all references to "Slave" or "Host" terminology when possible
  - Collected review for first patch
  - Added wcd9395 as fallback of wcd9390
  - Fixes typos errors
- MBHC:
  - Dropped all references to "Slave" or "Host" terminology when possible
  - Fixed EXPORT_SYMBOL into EXPORT_SYMBOL_GPL
  - Fixed typo in commit message
- Soundwire Devices driver
  - Dropped all references to "Slave" or "Host" terminology when possible
  - Dropped comments and unused code
  - Reworked wcd939x_swr_get_current_bank()
  - Added comments to wcd9390_interrupt_callback()
  - Reworked regmap's wcd939x_readonly/volatile_register checks
  - Added comments explaining while bind/unbind are empty
  - Added comment on SDW_SLAVE_ENTRY meaning
  - Added more register fields defines
  - Style fixes
- Codec driver
  - Dropped all references to "Slave" or "Host" terminology when possible
  - Added MICB_BIAS_ values enum and used them in the code
  - Moved zdet_param to the top
  - Added TLV data for ear_pa_gain and used it
  - Defined as much as possible every bit field used on/from register
  - Replaced 1/0 to true/false when writing to single bit fields
  - Replaced for loop on all bits with ffs(), simplified code
  - Simplified MICB fields handling code
  - Reworked and simplified wcd939x_get/set_compander and other kcontrol get/setters
  - Reworked and simplified MHGC impedance/zdet/qval code, dropped dead code
  - Added comments on wcd939x_wd_handle_irq() utility
  - Added comment on the interrupt handling architecture
- I've not moved common code yet, I'll probably do later since it would alter wcd939x code
- Link to v1: https://lore.kernel.org/r/20231123-topic-sm8650-upstream-wcd939x-codec-v1-0-21d4ad9276de@linaro.org

---
Neil Armstrong (5):
      ASoC: dt-bindings: qcom,wcd938x: move out common properties
      ASoC: dt-bindings: document WCD939x Audio Codec
      ASoC: codec: wcd-mbhc-v2: add support when connected behind an USB-C audio mux
      ASoC: codecs: Add WCD939x Soundwire devices driver
      ASoC: codecs: Add WCD939x Codec driver

 .../devicetree/bindings/sound/qcom,wcd938x.yaml    |   81 +-
 .../bindings/sound/qcom,wcd939x-sdw.yaml           |   69 +
 .../devicetree/bindings/sound/qcom,wcd939x.yaml    |   96 +
 .../bindings/sound/qcom,wcd93xx-common.yaml        |   95 +
 sound/soc/codecs/Kconfig                           |   19 +
 sound/soc/codecs/Makefile                          |    7 +
 sound/soc/codecs/wcd-clsh-v2.h                     |    1 +
 sound/soc/codecs/wcd-mbhc-v2.c                     |   95 +-
 sound/soc/codecs/wcd-mbhc-v2.h                     |    3 +
 sound/soc/codecs/wcd939x-sdw.c                     | 1584 +++++++++
 sound/soc/codecs/wcd939x.c                         | 3666 ++++++++++++++++++++
 sound/soc/codecs/wcd939x.h                         |  983 ++++++
 12 files changed, 6604 insertions(+), 95 deletions(-)
---
base-commit: 07b677953b9dca02928be323e2db853511305fa9
change-id: 20231123-topic-sm8650-upstream-wcd939x-codec-c46f621b55d4

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

