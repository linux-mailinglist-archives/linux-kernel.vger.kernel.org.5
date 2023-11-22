Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7706D7F4319
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343795AbjKVKEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343747AbjKVKEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:04:16 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BB5112
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:04:12 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-548d67d30bbso4182040a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700647451; x=1701252251; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLFPkW/MlV/uq+oo/Ao5FwA9Bhrcu1wf5pve2aYJzvE=;
        b=Scygxwai8F4ckcniCeXoe9mdtOthp1fM3jRHg/g3ZOxvjbozz6Z88lgnrkdGZHYnGH
         k3vXSSLHY5isAQWtV1plRFJzo44xxRlKuTEP7hoU0+UEvlG7Cr18Zv0ga/hqnPtA6gng
         IxWzmyQvU73LywUiCHROXbHipxTM2J3vauFomX8hG87/oGCckgIK1vLdnH6tkw/YfQFD
         iENcdBFPAori27qChhxEMBzOXbeW+I9ZijORtQyAxupFGco6snwSpvWK/9rR77bDWLk3
         VETIfdvo7ToCLBs0oNrK6kz6lAsYcLOCh/PeXUx/2nfa8f7Akbf6kaZ+JmRdyY7Flz6z
         qCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700647451; x=1701252251;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLFPkW/MlV/uq+oo/Ao5FwA9Bhrcu1wf5pve2aYJzvE=;
        b=uHw4nLZbjHJ2FcK9/2krh6yF79OOIYW5+xLNRiJpVqn/5kmUWxTFHSwVTbSdy0e/L/
         6DICSRH1DJnmEzBzqsVw+P1Tf+J7OgppAv/e3XQ8mNvMrd9AlvhZFEC+PGPPTur0nGNy
         TkLy12/CQ2u1i7pq4NiWtd3U9/VHTjF8jQ5YQ8pOnIW56yKaNxuPYczwKNTRNW+sBPFi
         yQGNGNFyX84SDzME+abAzgVuFxg418Hiw+4QMj/fCFWtHAtpZ1sYp24LuOzWXa9LKrdF
         hVuFYEeOxusLDMviYt14WTW8KCjl1vWlKl6stUrGLf1mkOi/vowW1d84hB0KYJDhw5zk
         b7VA==
X-Gm-Message-State: AOJu0YwWtLl2PbPrkfst+wipwX80QOFTsaUGkNtk3+tsfLyT/OjnP9jP
        0KmFxb05ptJwVc9B92ul7rTINA==
X-Google-Smtp-Source: AGHT+IHdDcR3jLfFw+Fnvj4HxUO8NreAp3BGyDjawRM1EQMcpq0SK4I6POFVvH6XkT4cIhsEVDApOw==
X-Received: by 2002:aa7:d158:0:b0:543:bd27:f4a9 with SMTP id r24-20020aa7d158000000b00543bd27f4a9mr1253990edo.12.1700647450974;
        Wed, 22 Nov 2023 02:04:10 -0800 (PST)
Received: from [127.0.1.1] ([86.123.99.122])
        by smtp.gmail.com with ESMTPSA id o9-20020a509b09000000b0053deb97e8e6sm6110456edi.28.2023.11.22.02.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 02:04:10 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Wed, 22 Nov 2023 12:03:54 +0200
Subject: [PATCH 2/7] phy: qcom-qmp: qserdes-txrx: Add some more v6.20
 register offsets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-2-d9340d362664@linaro.org>
References: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-0-d9340d362664@linaro.org>
In-Reply-To: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-0-d9340d362664@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1473; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=CQCC6Yo01m3EkX7DFbVM2rHCtyL2n/UNlvvZq6QHvbw=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlXdIQ4jXPQZSqmEmRr6E4lDxBv+hNol1XBRRHm
 GNjV4UYEnGJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZV3SEAAKCRAbX0TJAJUV
 VipUD/9Ghzw1LnTe+JfhAgsUpLbfkWH/CvwFhlDdZj2Ql2+LcZnDvsCXImob65IsPx7BH3h4iM8
 Nl8Dk74jr4I56GaoQTtsnb9VInWu5AVn8Pf2R3JVBt2jwPdgOMgPZCm5PeD0ckBtpNj6lOiHpkj
 cYICPvKJ1YbR1WMusstk9LNrGT7qGN9y+WJQe2gZPJJjTtGN3PB9G4dbZaxIus0J3GbtoWJwAwc
 Wgf2DcfIYduPqw6kF/guL2IoqIDUs6g/gEWxpVVZt2Em2ifasBzxMYkLFpJcgHHbA+4iYfM8X1T
 jLOejesPOmcxsyaCgZDEQw8eujdwxeEZANUR/MHIO2Qa4J4Mr1ZBP4qQF2EqQQAb5iHp9vAE5Qi
 y4CWV1eoPjFooQx+LnycxqFYj1NC52t36jQabPWfy09s9lLeSTtsl8/iGpFbN/sfoo95Yuy37Yy
 SsN1QftljzDfqfV0Q4eIGrYy1++/F9uSiNWYJh5TW87A3hHzE1RIc9Tj5GFZ8RAIRpoNdxhO6f+
 C96Wrw5r8ukHi7FrdkbFXq3nT6XpG4aC3atWQvCs+CmFFTfRFCp+PKO8vK95FIQ0SYqA7GN8+Id
 ELzHiPPDbPGnDxFhF8jzPQ9df2L20fZqJd1oAMrAeCYg8VMjF3Pa2MhJkOIqUcJKNGKKs1T1Gdo
 U07zTLFhPs9S7Ww==
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

Add some missing v6.20 registers offsets that are needed by the new
Snapdragon X Elite (X1E80100) platform.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h
index 5385a8b60970..7402a94d1be8 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h
@@ -14,11 +14,14 @@
 #define QSERDES_V6_20_TX_LANE_MODE_3				0x80
 
 #define QSERDES_V6_20_RX_UCDR_FO_GAIN_RATE_2			0x08
+#define QSERDES_V6_20_RX_UCDR_SO_GAIN_RATE_2			0x18
 #define QSERDES_V6_20_RX_UCDR_FO_GAIN_RATE_3			0x0c
 #define QSERDES_V6_20_RX_UCDR_PI_CONTROLS			0x20
 #define QSERDES_V6_20_RX_UCDR_SO_ACC_DEFAULT_VAL_RATE3		0x34
 #define QSERDES_V6_20_RX_IVCM_CAL_CTRL2				0x9c
 #define QSERDES_V6_20_RX_IVCM_POSTCAL_OFFSET			0xa0
+#define QSERDES_V6_20_RX_DFE_1					0xac
+#define QSERDES_V6_20_RX_DFE_2					0xb0
 #define QSERDES_V6_20_RX_DFE_3					0xb4
 #define QSERDES_V6_20_RX_VGA_CAL_MAN_VAL			0xe8
 #define QSERDES_V6_20_RX_GM_CAL					0x10c
@@ -41,5 +44,6 @@
 #define QSERDES_V6_20_RX_MODE_RATE3_B4				0x220
 #define QSERDES_V6_20_RX_MODE_RATE3_B5				0x224
 #define QSERDES_V6_20_RX_MODE_RATE3_B6				0x228
+#define QSERDES_V6_20_RX_BKUP_CTRL1				0x22c
 
 #endif

-- 
2.34.1

