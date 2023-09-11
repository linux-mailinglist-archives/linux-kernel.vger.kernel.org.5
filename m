Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4DF79BE77
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378901AbjIKWhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244176AbjIKTc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:32:59 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A2A12A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:32:54 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-52a39a1c4d5so6319266a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694460773; x=1695065573; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5UMn+F1EegjHCQSiGIpyYjyy5ijgml80Jw1Zt5EbFAY=;
        b=nWiyP+bLLMJQ6NzMFaeyyhkPNbxhvGPJ/kdx9Mk4qI+tZOmTmx0/IIRL7Gt4VdY5O9
         wDzwU9FpaBgMFQwRMCCjqtw246ME6vTdbI2/BH7pY81Tay0kbHnny70tJNDVXa576IVt
         XcSju+R2uRV4OzQ9GnjhnUuw7WRFEqsGfezL2RQV0za/j6bqHpptrmPRTYGuinBF5FS8
         WgyM4QgvsxrQltPRC2VxUhIzv8qruTdRNVYa2s7YXKaw0txsVS3tE8Iy3x2Ts2GDw45v
         K2EVOIp4yIpnsbfwhtflUbBzK062J1o2Ro3fUw4iSeija24I7KKjK4bzjW7LFGKARWmJ
         E+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694460773; x=1695065573;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5UMn+F1EegjHCQSiGIpyYjyy5ijgml80Jw1Zt5EbFAY=;
        b=M/ORycHNE9MOSAmQR7fSNr2jjTDM6cxTFwwQ6YCDRuj0Q3pRJdsA3e+GsxW/XZ2wMz
         DrdANOZbH81OOeYs4PsdyDdRWS0oNgSLJe2B5XRkZSrfdH23K4e6A9+OTDfI0ViyBLvS
         bWOeYAhj6xb94WaLNv7omdHGVpEycUG+aI1obp++etBx86K8nO+xnvjSoOr/iy+tX6U9
         6hf4G8Ne4ohSr6eXd2Agv3LBIoX0jZQVcFjMVNV0HiHF6GaRXvRd4x4XATA4Vq/92sY9
         zxdBt0nQh6MqAHo32a+lAR2+CAewc95HD0mk2mBSoqBSrlfxRAx6tVC401+7XoCjRR7a
         nX3g==
X-Gm-Message-State: AOJu0Yx11qseqSLTBXmhuW/vQsV3L4WYIEuRNxf02iVGz3KfFymtUXr4
        53p335pUw7ndi938Uqk19ZLj1g==
X-Google-Smtp-Source: AGHT+IEN5RIi2xcSnwPNjVQSja3SRb0xD2tJCeAWxHBcwbpnLaq6G6YhG1w4oLwsBjzDuJ/UWy83rg==
X-Received: by 2002:a17:906:2d1:b0:9ad:7d5b:dc11 with SMTP id 17-20020a17090602d100b009ad7d5bdc11mr296841ejk.33.1694460773048;
        Mon, 11 Sep 2023 12:32:53 -0700 (PDT)
Received: from [10.167.154.1] (178235177248.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.248])
        by smtp.gmail.com with ESMTPSA id j4-20020a170906410400b0099cc402d3ddsm5698607ejk.202.2023.09.11.12.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 12:32:52 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/2] 8550 USB QMPPHY fixups
Date:   Mon, 11 Sep 2023 21:32:47 +0200
Message-Id: <20230829-topic-8550_usbphy-v2-0-a72f43311d19@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF9r/2QC/32NQQqDMBAAvyJ7bkqM1Zqe+o8iJdHVLEgiG5WK+
 PemPqDHGRhmh4hMGOGR7cC4UqTgE6hLBq0zfkBBXWJQUhWyVlrMYaJW1GUp30u0k9tEpfO+qO5
 W2wIhddZEFJaNb10q/TKOSU6MPX3O0atJ7CjOgbfzu+Y/+2+x5kKKUuuus72R+maeI3nD4Rp4g
 OY4ji8cU/RZyAAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694460770; l=919;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=gGhpM1D6PVCOQ2pV5FmkVKUb1CkrT+N170vl0E9tfxI=;
 b=Ha/wnW7hzeLkLBHibTEtEvqo8nAhkwUGnW0MVSw09JpsRyfBQ1RXCS1a48fZi0rmDT7C0iKNk
 iDxD9HO0T14BqbGIJWT/oxlVa0Ro+6WNo8FEByr/DZfxjWvpbMqMJEG
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

