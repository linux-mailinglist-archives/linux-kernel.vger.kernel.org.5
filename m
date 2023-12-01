Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D89800727
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378061AbjLAJeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378139AbjLAJeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:34:15 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3103268
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:33:45 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5488bf9e193so2234358a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 01:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1701423223; x=1702028023; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHVrjeIvHlbkENQloINWmB2dsPrtzcOkwkp/DcbG/G4=;
        b=SeYjkzI5cMP4BR3ShT0Idgn/x3Hwp6sH51dI4B22CW1dIk8SqdWWvwyopbnhyu3K7A
         9TQzlCeKuDZU9QiOl94uNgX1Ki3IRgcncVjBQsC7Fp45meFHumK5P/D5wBLk815qzAls
         7t9hr3D56tqLFo4SK7QMVrVyWZGKiOjSXQukdnuIxhmy60BWctFCuYKKXXCTeWIN7e9G
         x/iKEJFNAMr++56ndZ9LMFLgetxcsoaVB5r2Ws3aP/lgZTAHbhuh0JRjLEOqGRkLyjE7
         eFcfdMvB0tLPNsSIRWIADsvn1TqdI+Z5HCCeVuEO9xHzMMJ+M8m9GCoFPXk6Jak3S+tu
         Df9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701423223; x=1702028023;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHVrjeIvHlbkENQloINWmB2dsPrtzcOkwkp/DcbG/G4=;
        b=kUdcvjuv+ThbZxx6bY3wcY08UBomBPe0n1+xoHynnQbSm6bn2eFXbVMWll+JM182bD
         ha+G4i7Fm+Js2Amis2nV3PHCg0t4x41mfvilI5k3f9zSBL1KGpEYINu/pHfhk+IhdUer
         FJdgHQtRRdwMvvsNmGpLuiDtMnkNWyNnw9JuGHmqoj3onwe5vttViguoBfh53E10E+Ip
         cGMvBZK12/iiW/HvbzpfSI3u0k22wgqMr3I1RESZKzgIM1h3Uw1SJKx9FYHVSx6kWAc/
         AQlJ9T0ndxUYgZzlrlXQe1EWlnT5025ikxjVL1zewDQfiHX7wJmvVoTYff1n/Qb2gRN7
         Jlpg==
X-Gm-Message-State: AOJu0YyvSjo2U3tRroIRFgFrLXeT0I/bogs7gVhq8IYnE5t0br+CPhF7
        WdsbVjPVnN5rEkbUlVsXAWXVxA==
X-Google-Smtp-Source: AGHT+IEid4Ye47Vw7u2H0QYSqPZWJcAhKKUil0A7lFg/3cgLgNI+1GrOrPS+aUv+vw6IHdlWx7zz+g==
X-Received: by 2002:a50:c251:0:b0:54b:7a1c:6b01 with SMTP id t17-20020a50c251000000b0054b7a1c6b01mr589403edf.33.1701423223596;
        Fri, 01 Dec 2023 01:33:43 -0800 (PST)
Received: from otso.luca.vpn.lucaweiss.eu (dhcp-089-099-055-216.chello.nl. [89.99.55.216])
        by smtp.gmail.com with ESMTPSA id b16-20020a05640202d000b0054bbc6b6580sm1423708edx.31.2023.12.01.01.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:33:43 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v3 0/3] Enable venus on Fairphone 5 / non-ChromeOS sc7280
 venus support
Date:   Fri, 01 Dec 2023 10:33:17 +0100
Message-Id: <20231201-sc7280-venus-pas-v3-0-bc132dc5fc30@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF2oaWUC/33NsQ7CIBDG8VcxzGKOQwo4+R7GAenVMkgbUKJp+
 u7SDg7GOP6/5H43sUwpUGaHzcQSlZDDEGvI7Yb53sUr8dDWZggowaLl2Ws0wAvFR+ajy5ycbSQ
 oVFpJVs/GRF14ruTpXLsP+T6k1/qhiGX9gxXBgVvfaGl8J5R2x86FNPZDpJ0fbmwBC34QAYA/E
 KzIpcU9GGOFFPobmef5DTjxykT5AAAA
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devices with Qualcomm firmware (compared to ChromeOS firmware) need some
changes in the venus driver and dts layout so that venus can initialize.

Do these changes, similar to sc7180.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v3:
- Move 0x2184 iommu from sc7280.dtsi to sc7280-chrome-common.dtsi since
  it seems to cause crash on some boards (Vikash)
- Pick up tags
- Link to v2: https://lore.kernel.org/r/20231002-sc7280-venus-pas-v2-0-bd2408891317@fairphone.com

Changes in v2:
- Reword commit message 2/3 to be clearer (Konrad)
- Link to v1: https://lore.kernel.org/r/20230929-sc7280-venus-pas-v1-0-9c6738cf157a@fairphone.com

---
Luca Weiss (3):
      media: venus: core: Set up secure memory ranges for SC7280
      arm64: dts: qcom: sc7280: Move video-firmware to chrome-common
      arm64: dts: qcom: qcm6490-fairphone-fp5: Enable venus node

 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts |  5 +++++
 arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 11 +++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  9 +++------
 drivers/media/platform/qcom/venus/core.c           |  4 ++++
 4 files changed, 23 insertions(+), 6 deletions(-)
---
base-commit: b2a4d0696192f24f79ea71fea2d775da28fb9157
change-id: 20230929-sc7280-venus-pas-ea9630525753

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

