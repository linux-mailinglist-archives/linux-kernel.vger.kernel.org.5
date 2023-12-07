Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC2B808649
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjLGKw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjLGKw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:52:56 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB9A10C2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 02:53:02 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54c79968ffbso1007911a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 02:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701946380; x=1702551180; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AtCSycu5VoV4XGxtf8UzVv+51mWT6iBDiDsVSWX2wmQ=;
        b=ZpXeXnHOMV8VLiCP3f49NU/ZqxWz6jmZJ5MkZ5oj+iMkbfFW+KD7avR4gCg/zSNdL/
         wCJMZPx6fQ0+MSsTJ0gpxhOjkANXBRI01xNWJilYQTbC6uUYeu721ZmNqSNLk6RTMbQV
         VoseiVatvSst5As9JsI8Qof80A7LM4sWnnEGWr5vOyooiz9E/pIVOlGG2QG0WCVZuQAU
         5/fAAfkqHcOrTAld/hEqGxgnSqOdgjItBJLKdjMF69apZ+4koGPFymrI3wXrRc+nYIWr
         Nyt7cdXcc54lZ41MiKvICWtXAFA4OX7O9A+hPod2xQnsKEPeXv2ipOHsNiTHWz9uUC+v
         /oEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701946380; x=1702551180;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AtCSycu5VoV4XGxtf8UzVv+51mWT6iBDiDsVSWX2wmQ=;
        b=k2H7VqNAwaz7aJ2hI4iHAgax9XoyBu/kFRKv5YYhcsOHJqH13tyHDllGNGulywYLG9
         soBlKFAXAxXUTzTmocVrBYn19Nognrhj6be/RAVTMebxf/gpbSbopGVTVjuN1R3GH4xz
         mJIbsZ2ubVdelErSOSfbV7IeY33ru441w91bPT/HbpVtTnHdTJFAip1+zKqwrPow1lO3
         RSXp4Jl4JjQ5s3Nbx4rgcYqzj56bxVm1dU7+JStpU5fU1pAn3TV5szU5Zk5hA9p4NTnA
         lRMn8QwKsSxIsYZewpnByJ1eudZE51qsHzemQ2gd3M4Sf35Ot+V55pHNMsvSuxQe3e9y
         6/mA==
X-Gm-Message-State: AOJu0YzxeMi4kAlaEYPFwU+tgIIuoJ/HDtnfByTfX528hfyPxJzIATll
        FL1U4DinIgjqAdKsG3j3EEdiQA==
X-Google-Smtp-Source: AGHT+IFZAW6iGHIUOWPQlYEIASIETzRu7Kbq8+GrvsORtO8W4NYmCpiJpraQ3A5q8w+f5CAqnaWQHw==
X-Received: by 2002:a17:906:12:b0:a01:a193:1d56 with SMTP id 18-20020a170906001200b00a01a1931d56mr1427724eja.14.1701946380521;
        Thu, 07 Dec 2023 02:53:00 -0800 (PST)
Received: from [127.0.1.1] ([82.79.186.233])
        by smtp.gmail.com with ESMTPSA id k23-20020a1709063e1700b00a1db8b08610sm668700eji.148.2023.12.07.02.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 02:53:00 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v3 0/3] phy: qcom: edp: Add support for X1E80100
Date:   Thu, 07 Dec 2023 12:52:47 +0200
Message-Id: <20231122-phy-qualcomm-edp-x1e80100-v3-0-576fc4e9559d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP+jcWUC/42NQQ6DIBQFr9KwLg0fapSueo+mC9SPkCBYqEZjv
 HvRXXcu5yVvZiUJo8VEHpeVRJxsssFnENcLaYzyHVLbZiaccQHAOR3MQj+jck3oe4rtQGfAigF
 jVBVlA4XWWvCa5H+tEtI6Kt+YbPCjc3kcImo7H8HXO7Ox6RvicvQn2NczqQlo7kkpKikZtrV4O
 utVDLcQO7JrJ35axbMK4I5lJTUDWfyptm37Ab+EthcjAQAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2332; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=J0EO7EFg1UUSjme4RsWRaM9iONQtXhLwbGIIZFOz4eQ=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlcaQBe5bGJRePDF3FebwqZ6aTKwsnphqkGo1c1
 zwZfP/GC8CJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZXGkAQAKCRAbX0TJAJUV
 VlSWD/9EuCWKfjtiFjobk3uxsDeMKlEyfKMAURDentVCqtx/tdduq+aN2Paubjw8qIhYFax0ozD
 neobZgMzFaQmvOZMM5pBO3c8+BH8lEG8JLTI5MXXlhPsEdf9WR1rbml95OcE2JPprTbtj86Aus6
 6nBw58IPFJo0BciOkTNSMnCHtfWxPTQj47qxIHvnawGXtXmMJDSjTeml5MBz0X6CzDeGTs8Kvkq
 mkgBWLPkjnQDkDc5puoGNcbIgxE/zyh2HErKs1XCy/kbds7ZPvUE3j2jnLLh5Rx2lJ0K8R7A3Ed
 mCfvf1cbXPF8ntdGUaeoyekEEQSIIGcnwyPZwKUxIIOtNUgOsuidcLxCMONth9XZvTEbh6KqztF
 gaVsRR+IHLH9hBYrC7AkLNvY5mg468QY+jRbBZ54QpBPTdc3LVkuaqc7GHdBnYh3M+tOhEaVk/q
 tn6fN/EHTcDK1aeaTQjOgBDfZV4lJKbndbaTejHAq/84/YDpvPOnlbT7qhP7GV/TWKe+4waOi1/
 UmPpQjpBB2hIy1hUuBblQhj26ekUtjcZSBSgaWL9YCtRGqQbgvtzijTbpt7uHyFLZu7JpnAxlNp
 zuCOUWysDY/ceX4muA8bLxOmAjGHkd96vIsFWnYw5P5t7h++u1kR9zO32swP6a10M8A6XF0m1QH
 dMVZFfDD9qSNabA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the X1E80100 eDP/DP PHY and documents its
compatible.

Now, the X1E80100 uses QMP COM v6 registers, so it is added here. This
required configuration-based register offsets support, so that's done
here as well. Then, the legacy "PHY type" specific compatible should not
be used by newer platforms, so the platform-specific configurations have
been added. Rest of it is pretty much variables renaming to make their
use more obvious.

Only tested this on the X1E80100 CRD. Need to test it on at least one
legacy with "PHY type" compatible platforms.

This patchset depends on the QSERDES_V6_COM_SSC_ADJ_PER1 register offset
added by the following patchset:

https://lore.kernel.org/all/20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-0-d9340d362664@linaro.org/

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v3:
- The whole support for COM v6 register offsets has been reworked from scratch.
- The bindings now document the phy-type property. (dropped Krzysztof's R-b tag)
- New patch for adding PHY_TYPE_EDP into bindings header file.
- Link to v2: https://lore.kernel.org/r/20231122-phy-qualcomm-edp-x1e80100-v2-0-114e789f0195@linaro.org

Changes in v2:
- Added Krzysztof's R-b tag
- Re-worded commit message for bindings to suggest same PHY can work in
  both eDP and DP mode rather than being different PHY types.
- Implemented different qcom_edp_configure_ssc and
  qcom_edp_configure_pll for each version of the PHY.
- Dropped the cfg8 override in qcom_edp_phy_init
- Used enum instead of defines for PHY versions
- Link to v1: https://lore.kernel.org/r/20231122-phy-qualcomm-edp-x1e80100-v1-0-a9938990edb3@linaro.org

---
Abel Vesa (3):
      dt-bindings: phy: Add PHY_TYPE_EDP definition
      dt-bindings: phy: qcom-edp: Add X1E80100 PHY compatibles
      phy: qcom: edp: Add support for X1E80100 PHY

 .../devicetree/bindings/phy/qcom,edp-phy.yaml      |  15 +
 drivers/phy/qualcomm/phy-qcom-edp.c                | 583 +++++++++++++++++----
 include/dt-bindings/phy/phy.h                      |   1 +
 3 files changed, 506 insertions(+), 93 deletions(-)
---
base-commit: 629a3b49f3f957e975253c54846090b8d5ed2e9b
change-id: 20231122-phy-qualcomm-edp-x1e80100-a57c15fff32b

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>

