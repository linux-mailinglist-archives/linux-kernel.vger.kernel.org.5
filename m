Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564687FB494
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344195AbjK1Iov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344212AbjK1Ior (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:44:47 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA6C9D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:44:53 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4079ed65471so40936635e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701161091; x=1701765891; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=agy8ovSdS/4tA9isM5mGjaMbJtjKdhELeFprJXgKFm4=;
        b=T0afsI5bH6QNj+VLY7kZSs7pyqywZ1VLJ3lqClOFuyctpM9WNqp/pAMlq3SPdPVDzU
         C/H5Z184CqTJKfsiAy5whvNq33Lquiw2UZyVcHxWKaKfSb53pTnMXJTykWgs8+Y93bwR
         TpxpQCTAGanBOJ4h8xBo0i8jc86fJOMhjKOH7hkPCYqJiMxVoIaSqmZ05xyD4A3IghMp
         esgXLKvD+8udBJEJIHqNhxiFfMlm35UKLkRcyr90FO96kjtWelov5spQtaveRM7lYo05
         YBM66/mkIK2ZWCAtqnP/dRkA0g0negqtNzb/coQWzEZRkxKv6PzSlXPtrjW448GKc/v9
         uxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701161091; x=1701765891;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=agy8ovSdS/4tA9isM5mGjaMbJtjKdhELeFprJXgKFm4=;
        b=aY8EFW5ZjD7SAdxqCF4l9LiKsAObrTgGst8keAPj61DjPe7rPPBJ7yAxwW5Tmiq5P8
         otvu1NgtHFJ+ImMXivLQRm/pQ8t03WefF4/nK+gZ5Vek5DoTYdsOjI6LNahviCWEGBD4
         2EzpsepcTmNkLadpiPIlAoFdtAlMSNntW5gpfB2URPHD5zF4XZyym+tr6vdgWJV0ic3P
         +D7U9oUci48oqwtwLAdWXL3sOHMbnDOUOskKTmSQqM+9kJfpF4TlW7sNgNVLZfRMd3xz
         u5SOESET0F5n1t1Iz4eNic0yQP8EmzljjruFWm+LfIfQ5WRmWj3cIhrjFnCPgajr6jHX
         nt9Q==
X-Gm-Message-State: AOJu0Yw/tKVuiwEGw5eNLXQrINNkXArGKkMvHedSd3RPZC3IfOgQ48Xq
        +bqeZlUR6tI1BzJmJz7NQtMHPw==
X-Google-Smtp-Source: AGHT+IHCMxHkKDRZzzcTo715MNOqXQACyaKWdD+mdAyDwj1ku5Ewlemn1wsRDBf2rklfY0UPyw2msw==
X-Received: by 2002:a05:600c:1987:b0:409:1841:3f42 with SMTP id t7-20020a05600c198700b0040918413f42mr10409902wmq.13.1701161091435;
        Tue, 28 Nov 2023 00:44:51 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id bd11-20020a05600c1f0b00b0040b4e44cf8dsm946992wmb.47.2023.11.28.00.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:44:50 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 28 Nov 2023 09:44:48 +0100
Subject: [PATCH v3] dt-bindings: thermal: qcom-tsens: document the SM8650
 Temperature Sensor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-topic-sm8650-upstream-bindings-tsens-v3-1-54179e6646d3@linaro.org>
X-B4-Tracking: v=1; b=H4sIAH+oZWUC/53NMQ7CMAyF4augzBjFSVooE/dADKExxRIkVVwqU
 NW7ExALG2J8b/i/SQllJlHbxaQyjSycYhl2uVDt2ceOgEPZymhjUWMNQ+q5Bblu6krDrZchk7/
 CkWPg2AkMQlHA0dptGmtrZ0iVVJ/pxPc3sz+UfWYZUn681RFf7wcw1W/AiICgm1MIuD4iYr27c
 PQ5rVLu1EsYzT9VU6qVD8H4VrvG2a/qPM9PmzVp1y8BAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1602;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=lkn1zcYKfl9bkHY16wHdkHaA0qFcTFzXvKecr1VVsWI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlZaiB+HcotFaVw/ALqAayEzIygwaTYTqHfBEvqvXp
 uGG5eyOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZWWogQAKCRB33NvayMhJ0Q/XEA
 DIbrC9xRJgUWCWSw6C5ezs7GwuuF8v0dxVncM5kBxROJJoI/0dEJp5MzJDaWn5pNzBfMW6JWvsXBR6
 z4G2BDA30h/ExtO1+0otpl3if1OiE586wQO8xsILD+fxLAnxTUvX1/MpuYGK9MqgT8Y3rHQbBcGVxM
 9TjlIqVHoBZUybYBvoQtczayEKG8V4vOAKA3VJ/PQbcK0fbDYIlC73/EtaXZIpZbA2GhPEGVOpWcBc
 Gd3nWC5zaTd5H3RKjF3tRhsOte6yzZ35YPaApHD6oS5BeFMXutN4jMAT3GhUi0pK4Jq08LiYn4ToTT
 VSB/vis1+U/9AitwC07dvnDeBXoWQBKKAzzrkuIwsx85MEkpEbh0YBCfjXPinofHnc17Vf1GyOUJi+
 V6iORxo+kUWiUzAhbEJdiN6KA1bNJHz00tiGs0WRPUG87U8QiOQMqbE5Jrkjgl9L2AvYwlo7dhGauE
 UhT4rRcvVNAsBSQ0Znaer60QU5rzo9+LSEA7jvilcH8BrFECAUbOqDylXI/nVgyMDOgRxYo5cL5pjF
 zz0t1CHz+obwjW9PpmUsZqnbKD9qjZM/qNTZ7o/Fb1qxWHr9U1UiGyK3NOoKod5DwJPpmCt1EaKECW
 EG9rat5Q8V1G97bZT1ME4yb7ERmKm214LLGT090JEBVX2gVl/UtJ6BTtLBnw==
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

Document the Temperature Sensor (TSENS) on the SM8650 Platform.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm8650/upstream/integ
---
Changes in v3:
- Collected reviews
- Link to v2: https://lore.kernel.org/r/20231025-topic-sm8650-upstream-bindings-tsens-v2-1-5add2ac04943@linaro.org

Changes in v2:
- Fixed typo in subject
- Link to v1: https://lore.kernel.org/r/20231025-topic-sm8650-upstream-bindings-tsens-v1-1-09fdd17b1116@linaro.org
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 437b74732886..99d9c526c0b6 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -66,6 +66,7 @@ properties:
               - qcom,sm8350-tsens
               - qcom,sm8450-tsens
               - qcom,sm8550-tsens
+              - qcom,sm8650-tsens
           - const: qcom,tsens-v2
 
       - description: v2 of TSENS with combined interrupt

---
base-commit: 48bbaf8b793e0770798519f8ee1ea2908ff0943a
change-id: 20231016-topic-sm8650-upstream-bindings-tsens-4e748933642e

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

