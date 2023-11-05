Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773097E15A6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 18:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjKERp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 12:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjKERpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 12:45:16 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470E4FB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 09:45:12 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40790b0a224so28742465e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 09:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699206311; x=1699811111; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nsxT65QcBic5QpwyMNIvqdwRkRC1mARnt5d+1mQIn0=;
        b=fKltRj0cRkSYhOacX4946NZ9wttS7PvGlyYhb+UCMRLYfnpFSXHaKBozRlgGufbpBq
         KegN2oqm5eZCy4iKLLhInnMEKViXPWzu3qVR4RI+1hPx9Fq13Da+6/gMoQPrEiid2Fyw
         ENkxgmm3IFBS6WREYMUNeszLTEjbgXGI8o7zW24bt6EYeE0NHqRnw5LOeQ/eEOzPUWn5
         kaFCP09pp8yjv5Uuf4NM3UJf+8l57aSqNOfB5WZhGisFIp0qD+K5t8tKYJYqvzKQjVB5
         Iv8JHxi+IOSPH5mdVtJkxdbdGdXYRry94FuiWFsjxeV5BZHhen+kICQC+L+sqq3YmSM2
         oQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699206311; x=1699811111;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nsxT65QcBic5QpwyMNIvqdwRkRC1mARnt5d+1mQIn0=;
        b=pLKDA8aUIkjEbm0AhV6J205gJafpk94N8pDfw7KNZ44GR5j3rSdnO7m44Uj9TerInB
         MGwDo1hFXrudF4eUnDbTDCn0Gq2AS6OO5DvLodkHpKIJTJjLj17CmkPDmT4fipn8d/iG
         1r79F2o7GtXsrWsyq5hm7DQfAnSDeRLIQ+xyHt1oh/2+GF4lkkiU9dkuRPu8osK7BAKk
         NUAZO70r1rp6wZ06y6Ux+u0mv5W7dMOSpYKGr7wrf08eovm34WmS1qP0Hoi8W6z4Nhh7
         rYBqwEGASKw6hZrJcoGFdxjZ6n6h3H5KXOgR3oQp08bOy0IHk3K0qBFjwnF5juttuLhx
         /kmw==
X-Gm-Message-State: AOJu0Ywa7jfng+FuX3F/otifTD/2Zyol4eRnHeZIW8RIpAjFUYUoJcNA
        JCybuRonw4OxavMMChjfqwhaGA==
X-Google-Smtp-Source: AGHT+IFFFRuz5vVVkHwIrrGRHAatUQU8Q0oj5X8fGZWbfIzQP9xKHSbLk69wwANaHGU7a2ULP4fVaA==
X-Received: by 2002:a05:600c:c0f:b0:409:50b4:3da8 with SMTP id fm15-20020a05600c0c0f00b0040950b43da8mr13704559wmb.38.1699206310740;
        Sun, 05 Nov 2023 09:45:10 -0800 (PST)
Received: from [127.0.0.1] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c198a00b004064ac107cfsm9553346wmq.39.2023.11.05.09.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 09:45:10 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date:   Sun, 05 Nov 2023 17:45:05 +0000
Subject: [PATCH v3 6/6] media: qcom: camss: vfe-17x: Rename camss-vfe-170
 to camss-vfe-17x
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231105-b4-camss-sc8280xp-v3-6-4b3c372ff0f4@linaro.org>
References: <20231105-b4-camss-sc8280xp-v3-0-4b3c372ff0f4@linaro.org>
In-Reply-To: <20231105-b4-camss-sc8280xp-v3-0-4b3c372ff0f4@linaro.org>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

