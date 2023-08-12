Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6192D779FA4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 13:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbjHLL1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 07:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237225AbjHLL1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 07:27:14 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933F210EA;
        Sat, 12 Aug 2023 04:27:17 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe934c4decso3361774e87.1;
        Sat, 12 Aug 2023 04:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691839636; x=1692444436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ex9NYx+HBgu6/pZgoWgfrfu/p4scpVkTohOjt1lHg7M=;
        b=pN0llEAESY+It2U15Y27g05h//zrre0UROagBs08PTHBmQVn7iz7hKQTA8iYqK911V
         JWh1SpM0B7jC5dlbI94oBH4mOUINNh3TB1e0866l2gFlEfO3KCx1MQnmt6jlrZ57QjTC
         59ISQUqJJKaVQIh6HPaE5I3Yw7lDvIs6DeMe0+bNXYVjed7gA9RZOfZqZku+Yc7sWP9c
         jdYLie8Hlcd0iG785ACdO5L5lNjxzfnsDqwgua+y9xbj6ha0TVoM/KYb3+Qwaoxlg789
         NpVMPT9XG4Q6ha3ldAjqSno07vNXtdnvtSao5VbO6jQ0nADtu6nct4n+xiAjzVvoZ6SR
         ANcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691839636; x=1692444436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ex9NYx+HBgu6/pZgoWgfrfu/p4scpVkTohOjt1lHg7M=;
        b=J4ucl14DHx+ENBc0ybfKqINGhQkBGudpQOKUAboHmapgNxMKfVQt0i/GgLrieuT3pd
         INfZlPOQKNBFsXKZo/moy051q+HjT7T+idQgx6+HlJ5CBMMO0BhJONS4ykaJBSbuTUgH
         Tl4CQ09FRZCw7qhKp+Wm1lJ5FM7EWctNGPPVoSTjqUHv+Onaoq/4jfWlpzi8J/uOF7cQ
         pCNi+MqNz6BUinXIUZPGLJS6lcpj5wjf+LGQiJ4GXyKucm2zGIcEtMp5+Cz4Irs1aZGY
         eMoJwihvtEMnxK/2+3cRbG2MKFMKz8QPvfOmJYZlUh/zb7fs8aMH9GZ2XwA32OejvFVU
         0uVg==
X-Gm-Message-State: AOJu0Yy3gPBnNxcTBwalmx3XAmpPWKBwWu1qEC5XH6wm+xiEhRNcj5yf
        lgDWweJegbKCYGub98Nef7MRJaJ2Q1SIIQ==
X-Google-Smtp-Source: AGHT+IFbDsASJNCFwp84ZNhTaP1sLD8LG7+215PJRDtwi7gQrCokadl/uEB4gHwruL3aHoM2nyEQgA==
X-Received: by 2002:a05:6512:2213:b0:4fc:6e21:ff50 with SMTP id h19-20020a056512221300b004fc6e21ff50mr3809526lfu.55.1691839635833;
        Sat, 12 Aug 2023 04:27:15 -0700 (PDT)
Received: from localhost.localdomain (bzd150.neoplus.adsl.tpnet.pl. [83.30.49.150])
        by smtp.gmail.com with ESMTPSA id w3-20020ac24423000000b004fe2f085d5csm1087289lfl.299.2023.08.12.04.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 04:27:15 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/7] arm64: dts: qcom: msm8976: Split lpass region
Date:   Sat, 12 Aug 2023 13:24:49 +0200
Message-Id: <20230812112534.8610-7-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230812112534.8610-1-a39.skl@gmail.com>
References: <20230812112534.8610-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM8976 downstream dts define reloc region which is used by pil-tz
to load both wcnss and lpass, on mainline however we might not be
able to do it and we need separate regions(also validating dts might get
problematic if we had to put memory-region(rproc node) per device).
Luckily it seems size and entry points in firmware headers appears
to be static across multiple devices including Sony Loire platform
and Xiaomi Redmi Note 3 Pro this should let us fit in first ~17MB
Split lpass region(reloc on downstream) into two separate regions.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index ab76806317a7..7385d5edec04 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -338,7 +338,12 @@ mpss_mem: mpss@86c00000 {
 		};
 
 		lpass_mem: lpass@8c200000 {
-			reg = <0x0 0x8c200000 0x0 0x1800000>;
+			reg = <0x0 0x8c200000 0x0 0x1000000>;
+			no-map;
+		};
+
+		wcnss_fw_mem: wcnss@8d200000 {
+			reg = <0x0 0x8d200000 0x0 0x800000>;
 			no-map;
 		};
 
-- 
2.41.0

