Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1096D7F4462
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbjKVK4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbjKVK4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:56:04 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD6119E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:56:00 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5409bc907edso9282513a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700650559; x=1701255359; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HLDI3wzMix+NWssn2rikTDQZvDop8e4c6V7Woh1WHUU=;
        b=dETIR1Xk1vCA+X7O0cD8zhvZrLymwmDJqT0DygyAdlfieR4z721NSIQ8pzf+ozIIIw
         BqjrQ0EvtEMRPFA6IdLbKOeMT5sU6/FayyVzWh7/Mb4Dmrx+vr8QN8b/+iWijTMS2nOR
         ZVKmzn3XA8OaiPMGB5vNxoUurhWSbExEhH+mfrXtgZoQHVC8GunuleznSQUKdN6497yZ
         w/t3hgmdZeAy/TyRJjqWdXLXLe5PXoLYHM79XAH+0QBNaLB8ZKc+zpEMmBUm/Vbh2dF9
         8/5w7mMjNTTpJjNrwJ5KBFGc4s8kTK7CJ5qIxaWnDTAq+vf94k9N4JyvxoIcw2RYK1RZ
         CT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700650559; x=1701255359;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLDI3wzMix+NWssn2rikTDQZvDop8e4c6V7Woh1WHUU=;
        b=Mq8LLZznwVpGAgVeT2NS8w2/3BoW7enr44iJOu1N0zoXbNZDCyTd7SOvXdSN/a1UWQ
         IuhlDHTc1GJHz5WnuByTo/bbYFqLGcKl0vBntNnn7gFPiTZ2x3HEyqV9YZ8TklnTybPD
         NbvUIKkksoY/gaMCwCQUvMpRRSf4ve9C8zvU4zbGpZE9o5IJEZ73tivYurGDoAUMuASf
         CExcCWWnpdDgWDx/KO6HDXYh9mc6Dz4gg1TRa5QzTVrqoKiJlHgP0KVU7eQvNhXZ0nkC
         OQ7zPZXzNtA+mWg3pZPCq5NgbcwaoHOlTg6sqb1DxDDWSjDDO3xYwTs3vzRBgS0C0Ie+
         NcjA==
X-Gm-Message-State: AOJu0Yz2e8m/m+DLTXGBY4tLll3IkvX89q0oCLQ8M3I0d1L7QcMJjV5U
        cw1f87qxoMZ1PVJ3WfGPWm8hxw==
X-Google-Smtp-Source: AGHT+IEcUs2DzE0DCcfF/Zqi+FS19jJkgid6BYQFfSIGdYh4e0kqwIWPHfhZgF/ve8h/TZgtEuuWDQ==
X-Received: by 2002:a17:906:2d4:b0:a04:d5e8:cd84 with SMTP id 20-20020a17090602d400b00a04d5e8cd84mr539404ejk.56.1700650558988;
        Wed, 22 Nov 2023 02:55:58 -0800 (PST)
Received: from [127.0.1.1] ([86.123.99.122])
        by smtp.gmail.com with ESMTPSA id mf3-20020a170906cb8300b009f28db2b702sm6423557ejb.209.2023.11.22.02.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 02:55:58 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH 0/2] phy: qcom: edp: Add support for X1E80100
Date:   Wed, 22 Nov 2023 12:55:47 +0200
Message-Id: <20231122-phy-qualcomm-edp-x1e80100-v1-0-a9938990edb3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADPeXWUC/x2NQQrCMBBFr1Jm7UBmSlG8irhI0okZSNOYUKmU3
 t3g8n14/x3QpKo0uA8HVPlo0zV3oMsAPtr8EtS5M7DhkYgZS/zie7PJr8uCMhfcSW6GjEE7XT1
 NIYSRHXTf2Sboqs0+9oe8pdTHUiXo/g8+nuf5A6sW876AAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=866; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=6Qe8P7OumubbvMZ9Ocse/XGaxEKzcj9WjK3I0PgWsKE=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlXd42TNpKNmMaTa4qcGZmrA2jYc/smPgdRuMrW
 v60cO4OVtyJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZV3eNgAKCRAbX0TJAJUV
 VhmdD/oD6CPBHJwtRsdfJJ7iQXCg85N3wd7U3WD4obqKy6M5x+kTlVi1uW67vDAKI9vFoVMFnBi
 u5mSHcHcxVzRfvsizSZ0kkLhUTU0iEISy/WCJBr23Uzx/u5C0Ew/4wRwj/LA+nekqZlqmXh+slK
 Oq0cjxfuAFmlqGBfMLxsPVrtHebmSk3qSetoA9p4x0Djv7bdqhaupitLw1/yGMeIv4zlPxeG9I5
 3RxOlffUk3N2ahtdMlnJt6x0LaWtOtBdpZppBTUJ3G/7z5zadLv9o8nxihIOU55BizsM5v0qUcs
 w0HevtuJEQmy4xdOw/oSsOoBX4F/3843czrKYMEmeYd2AUVQaioZfpxLYREha4bJtGSqZctqqGm
 5mmDeH5pWa/TnKDjb9mRemQ7fo/sJR31ROhV2DXub8YnbW+CvGhe7vW+THCyWwiJ/TKdwWLYEn+
 zvS+lb8Jy4qvgHfn09pTqnUKI6Dkw0VEYFKFoSmUJ+PInsTTMXS3+aHHY1DIeyQza196qWA9XDA
 CjM+E4RDxU1CBBdBnQalmSt62yldlGHd9KBK3joRkFxZWnPcgbRVV/Ny6QvlIl+YuxQaLnKIKQB
 J0/uQxM+RiUM9yMzJpA24UzJCIvaGiXr0QHyy0YM/xrjyVkuVRswuQyG5zSo7EgAi9oEVDLCkwr
 6vYaEBJmnvim1KA==
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

This patchset depends on the QSERDES_V6_COM_SSC_ADJ_PER1 register offset
added by the following patchset:

https://lore.kernel.org/all/20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-0-d9340d362664@linaro.org/

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Abel Vesa (2):
      dt-bindings: phy: qcom-edp: Add X1E80100 PHY compatibles
      phy: qcom: edp: Add X1E80100 eDP and DP PHYs

 .../devicetree/bindings/phy/qcom,edp-phy.yaml      |   2 +
 drivers/phy/qualcomm/phy-qcom-edp.c                | 305 ++++++++++++++++-----
 2 files changed, 233 insertions(+), 74 deletions(-)
---
base-commit: 07b677953b9dca02928be323e2db853511305fa9
change-id: 20231122-phy-qualcomm-edp-x1e80100-a57c15fff32b

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>

