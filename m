Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C95179BC41
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbjIKVFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244325AbjIKUHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:07:23 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB87D1AB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:07:18 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bcf2de59cso617446566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694462837; x=1695067637; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8xKtPAeHdfJ6/z/qz3x+wJCKOROjQ3kUyd8YMWyjKpg=;
        b=kqeFQE+3mba6yhF6GJRrxFoQazQo9J5IfmER2SqGaWnArRkM6E+1PNIZytYZYf1CXn
         QIbUfvxIfIq5Ym6L1P1FsuzlgqSuYnWHtxiMfWTjm9OR1Nzm+VPiV5L3DeMMIr35tWuD
         A06bJBSNw4cIep0fbIAk6b68suKY05N6e/H8rp302oAQRWsG/8SwPAT/VxF+px885U7p
         tgxLVjzEW0HYEgxg8uBR+n0adJNF44327/0z1snk1a9J7USLrUYgoKQHyqoP6acB2rcn
         qDwKpnTdOAlve4T6bOQqfC0GAE+S+Do8qhpcg9lePMiB/mWOalFF+GdQu62xoWsB6IJk
         3p+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694462837; x=1695067637;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xKtPAeHdfJ6/z/qz3x+wJCKOROjQ3kUyd8YMWyjKpg=;
        b=scMITcrOTmDwMM2scFiOgPOd3wtr3m9M/IjkbxIJrd+hZ7vsyNBG/DYeUFqhJ2KVpi
         k2pbLGjzI1DfK2xQMuOJbbvAHzKiD+sqrgswEORsXTvgNz+Oi0DW+O40KTgOGi9B4AMC
         dWO5A/bca1DSMmYbOBlnyBgtG5eOZdoUnAxGrCyGbX40LHNG4Jdskpv0kI/s141XSTdA
         lP2xxGpNxSBDWpUCm1XfqnhMx+F36m4a1+WrWLaJVW/PhO8YGrGDMBjbuGs73zRgSrJk
         Ud8RypfBSEbhr/ABvRNPrP6d3oOQ4Qc8cMP2PVGywV3Yzm7z4+1nvHoKxLJOX3pG6Vzf
         kFaw==
X-Gm-Message-State: AOJu0YzubIVn7W0dDuaFqnhkeMWLlU4MkCvRNXoJa9SFpXjR+eELmvl7
        uJ8G5z0fgCksHzIUF4Cew9mgJw==
X-Google-Smtp-Source: AGHT+IGw5HRTK8mnycR6zM+zwfL0W2TNmF+pb14up1M7rBqIYMeESqMSuAp5jZ9Yaws+53PW629XQQ==
X-Received: by 2002:a17:906:ef8b:b0:99b:4ed4:5527 with SMTP id ze11-20020a170906ef8b00b0099b4ed45527mr8984194ejb.25.1694462837037;
        Mon, 11 Sep 2023 13:07:17 -0700 (PDT)
Received: from [10.167.154.1] (178235177248.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.248])
        by smtp.gmail.com with ESMTPSA id z19-20020a170906715300b00992e14af9b9sm5753258ejj.134.2023.09.11.13.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 13:07:16 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 0/2] 8550 USB QMPPHY fixups
Date:   Mon, 11 Sep 2023 22:07:13 +0200
Message-Id: <20230829-topic-8550_usbphy-v3-0-34ec434194c5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHFz/2QC/4WNywrDIBQFfyW4rsVHXnbV/yilaNTkQtCgiTSE/
 HtNdt20yzlwZjYUTQAT0a3YUDAJIniXgV8K1A3S9QaDzowYYZy0TODZT9DhtqrIa4lqGlZcC2p
 53SihuEH5p2Q0WAXpuiE/3TKOeZyCsfA+Q49n5gHi7MN6dhM91l+JRDHBlRBaKyuJKOV9BCeDv
 /rQo0OX2F8FywrZMFtyTqmm4kux7/sHHpDgDAsBAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Adrien Thierry <athierry@redhat.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694462835; l=1082;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=GbuZM1oKvKUNGOcNj2S2w9EzwDPdJOgvLs+UCp8aD1E=;
 b=q7PWDq7q/ELe5Zp+ef3vBLiTCjnqaXMGeijHC9KwM/0rgl8uSFltZ3UzMCialzQSMukCziLdk
 cApa95206WKCOnqU9gWPPHTGL2GeW7s/A0GE2tcxAVQEv9H6neDKF2G
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inspired by [1] I went over the 8550 QMPPHY init sequences and found
some inconsistencies. This series attempts to fix them.

[1] https://lore.kernel.org/linux-arm-msm/20230828152353.16529-1-athierry@redhat.com/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v3:
- v2 except it now compiles (missed .c change)
- Link to v2: https://lore.kernel.org/r/20230829-topic-8550_usbphy-v2-0-a72f43311d19@linaro.org

Changes in v2:
- Pick up tags
- "Q6" -> "V6"
- Link to v1: https://lore.kernel.org/r/20230829-topic-8550_usbphy-v1-0-599ddbfa094a@linaro.org

---
Konrad Dybcio (2):
      phy: qcom-qmp-combo: Square out 8550 POWER_STATE_CONFIG1
      phy: qcom-qmp-combo: initialize PCS_USB registers

 drivers/phy/qualcomm/phy-qcom-qmp-combo.c      | 6 +++++-
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h | 3 ++-
 2 files changed, 7 insertions(+), 2 deletions(-)
---
base-commit: 7bc675554773f09d88101bf1ccfc8537dc7c0be9
change-id: 20230829-topic-8550_usbphy-691f367b9b3e

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

