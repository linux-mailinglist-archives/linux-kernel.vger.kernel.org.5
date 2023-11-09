Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8038F7E69AD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbjKILaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbjKILan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:30:43 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704922D7E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 03:30:33 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40891d38e3fso4866105e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 03:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699529432; x=1700134232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYQvDtaR1Rq2jfedJTX47JK1X6rSYRRgJAozvHJVQR8=;
        b=qzpT2xY8PNfTnVIXVeAY99iw7geUmQTYeLgZ7oMIfteTrGyu4Bk5+Nil5nbgbn6RgY
         leitKkooXM40C2HySXlewJ7K0d94C4RPbfv5ZDhTwW1Myu+AfFAedpINlfMcuB1AZYp/
         DemgdZgw4c9YlE7HH7pABq+bRuull0BDf61vOipa+D99wwefryq6iavIvI16KRYm7Z53
         o08qwobTGs9C1ZK0PG66ygCUNWHPh4l8UCemOVSPp8A9HXvU/hwYUYoC3IEOoKFdd1Tr
         8e6DLZ+rQRF24sq2qSxPtZx3CDbPJ3ajLPbqtz1M7Q9vx1dVqZ+WBAsj/Jvz/eE2Y1Zj
         Rzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699529432; x=1700134232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYQvDtaR1Rq2jfedJTX47JK1X6rSYRRgJAozvHJVQR8=;
        b=GuvvFu4EraqCB7EDpQ8saX8kFhU3DjVIDv810ItOM2EvuE7O1HfLRMTDmhcd6GR7fq
         JktbtVwUM033lWHdNhGUHC9R5X3HHVdMMCHdxLTDNrqzfFCU3/TlGgxqQJLavNr6svjX
         2hp8ECt5ihgpzNttFmmcOUlUWJ4jXtcLN1ge69jGc8zKn5rOLynLL+HW/WWMIEQdnCeY
         OE/Ls1TwEt0xK/f6T3Q/G+YAlcFtYIveuTQa0X1wIOhetVWb39SSN4vxocLQ2fv7NdlD
         cvOa7LIvVgSxGZ9YesH/aqWpSzalV68P72hWMG4xybBVYMCj+rIwbCTrK2s856iMV8Mb
         CN6A==
X-Gm-Message-State: AOJu0YyWKviMxkI0O4cryeDEt2qd5wIQP5ydrYTSGwpun4CMSwqXxGWJ
        /FFB+jqT7ZYO5zkffcgdTzc84Q==
X-Google-Smtp-Source: AGHT+IHD4bnvrBtnw0anfkYJuCZ4+DjQZ5+N+cAxubQKJf3E/805foDxpHfXU1cRY45Av8/NMR0E5Q==
X-Received: by 2002:adf:cd86:0:b0:32f:b3a2:c2eb with SMTP id q6-20020adfcd86000000b0032fb3a2c2ebmr3675067wrj.65.1699529431932;
        Thu, 09 Nov 2023 03:30:31 -0800 (PST)
Received: from [127.0.0.1] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id a11-20020adfed0b000000b0032d9337e7d1sm7185790wro.11.2023.11.09.03.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 03:30:31 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date:   Thu, 09 Nov 2023 11:30:26 +0000
Subject: [PATCH v4 6/6] media: qcom: camss: vfe-17x: Rename camss-vfe-170
 to camss-vfe-17x
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231109-b4-camss-sc8280xp-v4-6-58a58bc200f9@linaro.org>
References: <20231109-b4-camss-sc8280xp-v4-0-58a58bc200f9@linaro.org>
In-Reply-To: <20231109-b4-camss-sc8280xp-v4-0-58a58bc200f9@linaro.org>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vfe-170 and vfe-175 can be supported in the same file with some minimal
indirection to differentiate between the silicon versions.

sdm845 uses vfe-170, sc8280xp uses vfe-175-200. Lets rename the file to
capture its wider scope than vfe-170 only.

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
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

