Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465217E1C3D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjKFIcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjKFIcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:32:41 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C47E1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:32:38 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40906fc54fdso32425505e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 00:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699259556; x=1699864356; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yGdc5TqNwEwI8LuWMGOxs2Q/VDqv0+cFDb2zP6MVqyA=;
        b=Vi/qr22v5VDqtF1j3kkZdntcR8Dx7DR5crFShdCyDNhYmHhot4GsdGwGsUrKJcwTRM
         6xqZmdsyS7LsjP+/tk5ZDHQGQzKkSnj3IzH2m0HoSgydFwA5CnZ/vqJNYGXe+ErmFIPQ
         t2Vnk3Z5ypRAEDefHFQeEyzzNOuMTmI7UtoeDYhm6cf5FYVy5i9Q+Np9hJ47Wr3NqnDM
         3bekt/XviauBd6jbc/MMka/f2DT2ALyoP6W+AzjQeGsorVnTMz+wv0qBGM6Ie8Itw95C
         nkYyrSJNjs8rBlQjIuI7qG6sOs2UNB0KITK8Ov/0ZudHEeUokDJGwvQPikAYtwnUjns/
         MeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699259556; x=1699864356;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yGdc5TqNwEwI8LuWMGOxs2Q/VDqv0+cFDb2zP6MVqyA=;
        b=gNjwtXO5PsZl/ASvXRTOvtbbLJfOucaGgLu3R0MBodsBWTsB8baNrZ+zauSx5SXAeN
         6s03jIGXnpXFptOQNId4P7dvn8qBDK0rtAz4PCG1rrawFsQql/n29yhDB5HE13pUHNZZ
         Se5+rS0peLRmTM6Sa787cxFmGn8mvN/szXhjOAxtxSfCC075zGKrQX4REeRKHAbelF6N
         8by903VrfQFqCYyEqmOdf0+wmpXvRvK3DmborZ1yZ3l6GdlZMIDKHpWQDRYCvLdaJPYC
         steM2qPNJZXNOITk3Z1Sb+Kl0r2A7ovBOXuLWSrxPF1XmfEaT+etdBtSUC667Znyv0UF
         d04g==
X-Gm-Message-State: AOJu0Yz8k5ZSt5EQmluOUsI/4Pk2yJB06kI2LtoEjgmtseCKE2cXTZaB
        U7TX133slNDF63CWVzvBGS9fnK79YbMdL6LODjws0w==
X-Google-Smtp-Source: AGHT+IESKDFqjIoeKu+O06jreXgb6AO4cz1WBTuN/4MCxmRfFcZbzpG6er8uJgQs3mBbpcUx/6CNWQ==
X-Received: by 2002:a05:600c:3590:b0:408:3d91:8263 with SMTP id p16-20020a05600c359000b004083d918263mr23549136wmq.13.1699259556403;
        Mon, 06 Nov 2023 00:32:36 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c020c00b004063ea92492sm11405241wmi.22.2023.11.06.00.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 00:32:35 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/3] pinctrl: qcom: Introduce Pinctrl/GPIO for SM8650
Date:   Mon, 06 Nov 2023 09:32:29 +0100
Message-Id: <20231106-topic-sm8650-upstream-tlmm-v3-0-0e179c368933@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ2kSGUC/33NvQ6CMBiF4Vshna3pf8DJ+zAOlX5AE0pJWxsN4
 d4txEEXxvcMz1lQhGAhoku1oADZRuunEvxUoXbQUw/YmtKIEcYpoQonP9sWR1crSfBzjimAdji
 NzmEBLXApoOO0QQWYA3T2teO3e+nBxuTDe//KdFu/LJNHbKaYFJubWmiuhXpcRzvp4M8+9GhzM
 /uxODm0WLEaI4zgtRKSmT9rXdcPrS9iqhEBAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2091;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=liRG2tGz2HogeQacCQJWMFtpY/T14R8wDOl6tNod+jk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlSKShIQTlD/j24n5fmsTaCXlc4Y6MHGHTO2LBVN0Y
 XzDQZsSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZUikoQAKCRB33NvayMhJ0Qm3EA
 Cgjw3DNM+oXUkvzDUY9Vp7yUkUnzXZozIUMrN04cLBYWDK7dhserFpD7+Xc86FfKyg+a6OqVA7jczV
 0xv4X7y3gieh0bHkdZ+ZKTdC0sP+cBCcvhp4DGqN0yaY6wKYifnfjld39U1Qbd8otj2G/xjWdcyHi1
 Z6N0YB+OmRm0N963B6rzMOwxGUO1zhcoYOC0M3VZNcaeYgtDR6xOP46ePkBpnbjc7nQaenldH936j7
 wnPJvNW1v7kQt6c4Jdjkc7OfS9sx8WocCIgRQMgP7f1wKfz8hK5yEXS2dJx5B52A4SSoOe8dbNihr9
 lek4AZxJHTEf83Prv1cGOMJ3G4CVkRWvcj50WBx5RE+n34DM1jNcLGr0gGm3k18AyverxoNX+ZJZEh
 P4SLHTUBUJ/fyIFZZ9G1sRCIJchYMkScgPBHHW6F4+aluPvye086v+CKAsAeb85fiAdYaB06bevQBT
 b80JtuVillBR54vyI7S3sDhT25DBdXTVron63ZFBhMqQ3A6aMrfcgUCqUZtGPOkEVxHZWfTkLtVglS
 GImGuD9FrSpvaq6x1ehmNu8LbcPaWg9NhWHX4d+9QBl08UCwovIQScntTb0DP8s/KAs2tZHe354M1k
 bAbmkyfbm6GKFwjlUR6wadQ/4kh2tCaas1l6uk58SHpNVxLHds+BkyzyeFtg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SM8650 Top Level Mode Multiplexer supports 211 GPIOs,
and the usual UFS Reset, SDC Clk/Cmd/Data special pins.

An handful of pins can have their IRQ generated by the PDC
module, and for this support for the new wakeup_present &
wakeup_enable_bit is required to allow the "wakeup" event
to be passed to PDC and generate an interrupt or a wakeup
system event.

As SM8550, it also supports the i2c_pull_bit bit to enable the
on-SoC load resistor for I2C busses.

Dependencies: None

For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm8650/upstream/integ

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Correctly squashed intr_wakeup_ change protection with the spinlock
- Collected bindings reviewed-by
- Link to v2: https://lore.kernel.org/r/20231030-topic-sm8650-upstream-tlmm-v2-0-9d4d4386452d@linaro.org

Changes in v2:
- Collect reviewed-bys
- Fixed unevaluatedProperties handling, and dropped the true properties
- Link to v1: https://lore.kernel.org/r/20231025-topic-sm8650-upstream-tlmm-v1-0-4e3d84a3a46b@linaro.org

---
Neil Armstrong (3):
      dt-bindings: pinctrl: document the SM8650 Top Level Mode Multiplexer
      pinctrl: qcom: handle intr_target_reg wakeup_present/enable bits
      pinctrl: qcom: Introduce the SM8650 Top Level Mode Multiplexer driver

 .../bindings/pinctrl/qcom,sm8650-tlmm.yaml         |  147 ++
 drivers/pinctrl/qcom/Kconfig.msm                   |    8 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-msm.c                 |   42 +
 drivers/pinctrl/qcom/pinctrl-msm.h                 |    5 +
 drivers/pinctrl/qcom/pinctrl-sm8650.c              | 1762 ++++++++++++++++++++
 6 files changed, 1965 insertions(+)
---
base-commit: ed75ce58b3a55d2cd95b68a06fdb010e1e18d825
change-id: 20231016-topic-sm8650-upstream-tlmm-4ece354ef319

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

