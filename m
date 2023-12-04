Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B94803837
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbjLDPCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbjLDPCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:02:23 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACBA1A2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:01:49 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40bd5ea84d6so12341365e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 07:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701702107; x=1702306907; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zINM1okmZX3LeNIZxM4CFTe5s+jh7nnY/35H7xAy7yc=;
        b=WY2nuAIiQQ+JpAQYBzce66aCyBUzcuNbGrfcuDMCZjUa6bN4XcQVhNctk9it8rwTkS
         Eeaf6fmRKgyn9+C1n9KmfHVrEumsz7GjFLEYJRT3cMEgbXPOAkXL2Fs3U68Yqev3SUdj
         D64gmwtfR+oKjMxRkxfr8ewdfMDn2U+IJtY8Katx6Jb3yRCAycvG5EW0p5Jw1bAAGAZH
         lmCrP3C/1yj+b/JOaNnJzXtGlg1qwJN1U+8BvZd20JSca0CQd99YxCDXD6alqQuKyJnR
         0rmpZ9ktoMpTArZEKQ33kqtu2Q92xRg2BZf5mO2Y983SBERjUiZJTXx+8nRWLyR4tYWt
         P3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701702107; x=1702306907;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zINM1okmZX3LeNIZxM4CFTe5s+jh7nnY/35H7xAy7yc=;
        b=f6niVMZC0Nm6LSz6/bRDCf9QCKUp+CbNAJPmCSFmfx1wgFDYlHXq8pDYJtYhd0/Y8H
         DOQDi5vCxCsACdzIAFvPvoNKr8wokKpu09EIjFiE9AR8bj901N4TLRNouOSEtyN30+xG
         dmWZ/Js1n28ipPcNDPvlv428sRrGHpwIz19j6xv+HANuEVtk7UQzyRD10a6Um6Aq3eUH
         kLOh2C6A+PJ7j9x8YZDIg3vptBWepvfPSMCVrRzxoUKEPluRk+CaO/MgdfK+Wuq6QQuv
         K2d32ktv/9obG9E/iFgEHmZArbeLnQOkX73zdJxf9x20aMUneLc1i8Bm9Vi3iaHuk92B
         t+CQ==
X-Gm-Message-State: AOJu0YxjXtm1HaVXnVkSlWOKyilHRxP1bTCpkJMxAm3822GC17lIhEIx
        0PsP84wSUtaDjUI9ixiRATSeYPPxQfimHcc5uiE=
X-Google-Smtp-Source: AGHT+IGdousMNLimLTKPCBAoNngKkERPZVGyvA1N0j4SLFXWXkwulvp9Tu6BmM9bO83Cgen2z7CdKw==
X-Received: by 2002:a1c:7c0e:0:b0:40b:5e26:2378 with SMTP id x14-20020a1c7c0e000000b0040b5e262378mr591590wmc.41.1701702107116;
        Mon, 04 Dec 2023 07:01:47 -0800 (PST)
Received: from [127.0.1.1] ([82.77.85.67])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c501000b00407b93d8085sm19041661wmr.27.2023.12.04.07.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 07:01:46 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v2 0/2] phy: qcom: edp: Add support for X1E80100
Date:   Mon, 04 Dec 2023 17:01:35 +0200
Message-Id: <20231122-phy-qualcomm-edp-x1e80100-v2-0-114e789f0195@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM/pbWUC/42NSw6DIBRFt9Iw7mv4xFQ66j4aB4APIUGwUI3Gu
 PdSV9DhOcm9ZycFs8dCHpedZFx88SlW4NcLMU7FAcH3lQmnXDDGOUxug/esgknjCNhPsDJsKaM
 UVHM3rLHWCq5J3WtVEHRW0bj6EOcQqpwyWr+ewVdX2fnySXk7+wv72X9SC4Pak1K0UlLstXgGH
 1VOt5QH0h3H8QWhhOcB2AAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1365; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Qa4ftx3CC4GaXW0fbbBlA83h4BynsQFZ8fy7MwCf1Ec=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlbenRWxwbX//ylPmWeNi+DkcS9YuXhUjsgMzGB
 x1yAHbHYP+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZW3p0QAKCRAbX0TJAJUV
 VhssEACWAn6IZzUEkTKCl1WK49N+WfepOn5CCHgbgxsvS1zO8Tt6mafDJlCqJeqxi0asISOvzUx
 vYuThO/pEqiFEV+7qRFpDc6RldOziPyqGkakUae6fjx1wCj5lS8iKIskUiftN0iw7j/jfg2b86w
 DlykAGqK04GBCWKE970MoM3MggIezQkV8Uv57gI433LKGe90ORe0f51PnLzHf6qUxb1m6bbcnAK
 vyRx9JKWK+7+xqySVAp0+70KL42PmKb+BW6wJy8waBAIducNZM4yxISDqRzTsWdj4NMuYeIgucK
 VovKbPnJNDKgbmXt5tbAca31MTT6F0ORtVnmrFQK9Tb7WXKfzh44Qb0nn7ZjGufbBcy0Xf90qoW
 vMAUY7wE4YBXE09MA4wDYDORzzaEiOL/3ilqh85hRi8KdjNBXlVnlR+KWy+7Fg53HCVbL48Hzbg
 OY4XUYbQ/MWSi/0qN0RbYOBZlL3IZcoPLOJCdW0SUrZiQEvE9rQCxY+O0O1U42JNuFtzzJ0I0Aq
 dWWNNzH+sK+uK2o26O7BljMBFqLY/ik+t28UY0mX1LI/vArzhxNxaxf44EDLUUXSWM4LI22uNWq
 e1fR2RcePGjTrtvEwCT2vohJhl1Xo6OXLy0w9vpQKvrnQvRETZZJIFyXqLTwrX9ETuu1k7fNxr0
 zFDRLCtw4lGXkcw==
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
Abel Vesa (2):
      dt-bindings: phy: qcom-edp: Add X1E80100 PHY compatibles
      phy: qcom: edp: Add X1E80100 eDP and DP PHYs

 .../devicetree/bindings/phy/qcom,edp-phy.yaml      |   2 +
 drivers/phy/qualcomm/phy-qcom-edp.c                | 230 +++++++++++++++++++--
 2 files changed, 214 insertions(+), 18 deletions(-)
---
base-commit: 629a3b49f3f957e975253c54846090b8d5ed2e9b
change-id: 20231122-phy-qualcomm-edp-x1e80100-a57c15fff32b

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>

