Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE9C7E067A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 17:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376387AbjKCQZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 12:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345395AbjKCQZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:25:26 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D582D61
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 09:25:15 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32ded3eb835so1521049f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 09:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699028714; x=1699633514; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nsxT65QcBic5QpwyMNIvqdwRkRC1mARnt5d+1mQIn0=;
        b=koVvCQPrLrSGuPV2Ef2SpA7bmvgvl9CfCUItewz0iPUS1oYk7dhEGRJWgr/CAI2U6A
         73UjMJe1UihIkDtxBLftzgyjouoln5+llsVYOKnI0TozcvzA0HKUmV28SpNPW7ZrTmYw
         gBuzG0DW72L5F2nXPoRkF2qGrYwVx1nWncr2gSFenc/N1pxwASbLdStNkhT3N2/8m9Q2
         Pj+mY/OUzU1H5npSj7yG1rVipjIiy5joGykJj60grpnH06g9FC2rQed+PhrArDXyKaHC
         xtw9y3o8AsU+hbCEriX7nzqb5djmlq1bEPHtt3aIrj6hCPSqlq+PH5lOVx+lYlSRl9OF
         J3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699028714; x=1699633514;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nsxT65QcBic5QpwyMNIvqdwRkRC1mARnt5d+1mQIn0=;
        b=akunh8BNp0ObTop4QqVoiuEBEU6eAe4BVT8EUghYoRKhoklTpi5WAvV7+f2GCcwhHW
         Z8PvbPzOZ+jaKoWmSYDlDC8FN77dZWW7xhukQCAGBpJRF6JMrxT2nTL4PJ/mAOmJf0a9
         9t2GHBt1ytC8Xp5rToik+z+Q5I1Dpu68Lpg4RHnuG60psGIJF1bJ6gwQbA/SsKHo2t+q
         YdFw3/naj6XSEvJPd/sy6eIoD6r3LUc1khd5dUMUWJSXm1D96eatpYpn2sZbgnMJHFMt
         71TdE5qf1s957OusK+knqLc+Nz4xpfZc6awq1XgXpauunQK4Z2pkM2gL4LDoiTrx7BjQ
         wN/Q==
X-Gm-Message-State: AOJu0YwHCY+oXYYbgDqb4KhMOSA6YlNEINynDhei+YYUJy85Vw8uuFM1
        zbjIjpHs3/8KkNeav9PrBrPPiw==
X-Google-Smtp-Source: AGHT+IGo6lDoKqnaJdwkbAtYZA2R5l0+C8lHC4nqttrgc+u3GPlzNrionP9TVCm5xbBfEUWI/Wpucw==
X-Received: by 2002:a05:6000:18a5:b0:32f:86e7:9beb with SMTP id b5-20020a05600018a500b0032f86e79bebmr16538359wri.14.1699028713819;
        Fri, 03 Nov 2023 09:25:13 -0700 (PDT)
Received: from [127.0.0.1] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d650d000000b003142e438e8csm2219972wru.26.2023.11.03.09.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 09:25:13 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date:   Fri, 03 Nov 2023 16:25:09 +0000
Subject: [PATCH v2 6/6] media: qcom: camss: vfe-17x: Rename camss-vfe-170
 to camss-vfe-17x
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231103-b4-camss-sc8280xp-v2-6-b7af4d253a20@linaro.org>
References: <20231103-b4-camss-sc8280xp-v2-0-b7af4d253a20@linaro.org>
In-Reply-To: <20231103-b4-camss-sc8280xp-v2-0-b7af4d253a20@linaro.org>
To:     hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, vincent.knecht@mailoo.org,
        matti.lehtimaki@gmail.com, quic_grosikop@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.13-dev-26615
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vfe-170 and vfe-175 can be supported in the same file with some minimal
indirection to differentiate between the silicon versions.

sdm845 uses vfe-170, sc8280xp uses vfe-175-200. Lets rename the file to
capture its wider scope than vfe-170 only.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/Makefile                             | 2 +-
 drivers/media/platform/qcom/camss/{camss-vfe-170.c => camss-vfe-17x.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/Makefile b/drivers/media/platform/qcom/camss/Makefile
index 4e22223589739..0d4389ab312d1 100644
--- a/drivers/media/platform/qcom/camss/Makefile
+++ b/drivers/media/platform/qcom/camss/Makefile
@@ -14,7 +14,7 @@ qcom-camss-objs += \
 		camss-vfe-4-1.o \
 		camss-vfe-4-7.o \
 		camss-vfe-4-8.o \
-		camss-vfe-170.o \
+		camss-vfe-17x.o \
 		camss-vfe-480.o \
 		camss-vfe-gen1.o \
 		camss-vfe.o \
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-170.c b/drivers/media/platform/qcom/camss/camss-vfe-17x.c
similarity index 100%
rename from drivers/media/platform/qcom/camss/camss-vfe-170.c
rename to drivers/media/platform/qcom/camss/camss-vfe-17x.c

-- 
2.42.0

