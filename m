Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9797F61EC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345922AbjKWOtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345872AbjKWOtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:49:15 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C151D53
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:49:21 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40842752c6eso6130285e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700750960; x=1701355760; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7xTsmye+DXprfJGCnT9r6FiE88AZxfuIxgF5Hzt0tR4=;
        b=y7YmD++Ziz4nNG01Bd3v49FG2T6P4DdJMQT7mUc4aEV/jaSBTEk5/Hpsp0dvu0HiM7
         RmCku3FQbz3c6P2HtWX67Whj7WAEfsRpiw+/sRJFZVqGlTcSCmP7e9HWRweiodN9uTU2
         d49GRHA2NhTA6Rzt18Uzyxs+u7XmkjlZFZBZzfC1pb9ts7s6awrSk2pG/mlCRQXjmr0E
         InhqfPk7eLtgilMYK1jIcXftAej421HHG5YsNW42RkHLxC1vXKbjIjV1FP1NFSifbFJK
         eT5SEbIR8AJMLPq5aRPY1yhK/v8N8iZlRAMiEwzdH9Qtza6kcWucGIgeTL00nCRFyz/F
         K3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700750960; x=1701355760;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xTsmye+DXprfJGCnT9r6FiE88AZxfuIxgF5Hzt0tR4=;
        b=R2vDavRk530XH5BOBjyjfsc/TtIYWZRH9lZrSDsxRx/Ih6x8xgXAXOvi5PoYmSCCBo
         /VPP5sp5EHTADMe5Yub1qhDeZGZ4esTaD5Tew0MKifQm6VxGD+/tWH+AC/Gw/+jPxXWc
         AcfVR9lVLO2rywDt1WKDGWigVtgGJbtoG7rKjQEJAnc70U/bF43tukTqgT9EbzFaKWXr
         eLBll9AV3jtYLjeAnnyx4XPEGQDSsyKodQxRN0pBqWpvzZuXGK7bR+1RkOLRS3xQX1yP
         oCY68AmuFvW2AH7gu3THe55LzQdwC3fmqQwVC8xxgYDvolFvTdI+zNqynwtWvzQgoqaV
         lJXQ==
X-Gm-Message-State: AOJu0Yw8VXaSAuE+PoyJj1E/27NlCuNymavY14AP24TIWoZU3Od359jS
        ZF5mOAaaxhorDTzLRHK04Lra1A==
X-Google-Smtp-Source: AGHT+IHIQuU7lcwjoAmR6ounCY6gHREfYd9JGY9L5I+XnOs8fFG5UEAokj3e3JJcK+B8DYE2uKQPCA==
X-Received: by 2002:a05:600c:3516:b0:40b:2a06:be27 with SMTP id h22-20020a05600c351600b0040b2a06be27mr3993509wmq.35.1700750959826;
        Thu, 23 Nov 2023 06:49:19 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c458400b004094d4292aesm2256135wmo.18.2023.11.23.06.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 06:49:19 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/5] ASoC: codecs: add support for WCD939x Codec
Date:   Thu, 23 Nov 2023 15:49:10 +0100
Message-Id: <20231123-topic-sm8650-upstream-wcd939x-codec-v1-0-21d4ad9276de@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGZmX2UC/x3NMQ6DMAxA0asgz7VEEhKVXqXqAI5pPUCiGAoS4
 u6NOr7l/xOUi7DCozmh8FdU0lJhbg3QZ1jejBKrwbbWGWMdrikLoc734Fvcsq6Fhxl3ir3rD6Q
 UmZC6MAVrRu9jB7WUC09y/C/P13X9ALSMWhF1AAAA
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
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1950;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=wDiv+hUfqvERKcAmDL70dW3lBiLBoxik56q7RUGIHjg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlX2Zsox7kX+DoRNk5o6Ib/Ll6tKnG7STTtnhN6RMb
 Ltu3eHqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZV9mbAAKCRB33NvayMhJ0V9UEA
 CODTMh4GaDFLf1EyRVqmsFtLOpaR02kecBIvPV9U7DSq651InGHNxUzRk5iKSDvrMfc9BPsayoSpsl
 Wxj6sQbdvNVTY7rreYl31sHRvw6RpNrp3J9nWUg4spUranQRuFhqO/22cum2hWK/zAdvKtSGYx2R2r
 2eB/uomF8TM66Qs6cfvxjmBTzacx02akdX2BzFSZl27NhHe7AIL8qoZ2x7k1/nTo7XLBwh9xYRmIPs
 MW5/irBg8dFgYTsYi7oIaZItocr3qqkt9/LLVdyhiqkrMyNjE5oMTVqIoHWmKyCKV2apZqrj7HKq4k
 qD57/uZfhQQNrIkGQBHGeZlJE797o+NgNHOixKTlVtohp5tQdWFEWX399l15zo4CesRDVVVFdJ75s+
 emEWAfEpWYafXpjg90IUd3NWmLmZe/5+wkMdCWrbMMMOVRpIRpzeU7S9xoTUzz+QG58gW1ZypqwPLP
 nnPbGkY8xhU6an11Og7HaLAPXWFjwhxF80HAQ445clzZzAKlgeCIO9aCvDALRzVIEcoKZ0+0CKReac
 d1scBj+yWp4CTTS+T55Vda8J8xjU/AuvHsDr4CPM3QXIAHs70pCgsEOomnNTVm2/W2zla7eH6lmPHq
 iqUkrQ5ZrAwHtOzIyqVUxsZ055BXI5w+zdnvxA3WpVckaO/9lquRcMLjD4tw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Neil Armstrong (5):
      ASoC: dt-bindings: qcom,wcd938x: move out common properties
      ASoC: dt-bindings: document WCD939x Audio Codec
      ASoC: codec: wcd-mbhc-v2: add support when connected behind an USB-C audio mux
      ASoC: codecs: Add WCD939x Soundwire slave driver
      ASoC: codecs: Add WCD939x Codec driver

 .../devicetree/bindings/sound/qcom,wcd938x.yaml    |   81 +-
 .../bindings/sound/qcom,wcd939x-sdw.yaml           |   70 +
 .../devicetree/bindings/sound/qcom,wcd939x.yaml    |   93 +
 .../bindings/sound/qcom,wcd93xx-common.yaml        |   95 +
 sound/soc/codecs/Kconfig                           |   18 +
 sound/soc/codecs/Makefile                          |    7 +
 sound/soc/codecs/wcd-clsh-v2.h                     |    1 +
 sound/soc/codecs/wcd-mbhc-v2.c                     |   95 +-
 sound/soc/codecs/wcd-mbhc-v2.h                     |    3 +
 sound/soc/codecs/wcd939x-sdw.c                     | 1591 +++++++++
 sound/soc/codecs/wcd939x.c                         | 3635 ++++++++++++++++++++
 sound/soc/codecs/wcd939x.h                         |  936 +++++
 12 files changed, 6530 insertions(+), 95 deletions(-)
---
base-commit: 07b677953b9dca02928be323e2db853511305fa9
change-id: 20231123-topic-sm8650-upstream-wcd939x-codec-c46f621b55d4

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

