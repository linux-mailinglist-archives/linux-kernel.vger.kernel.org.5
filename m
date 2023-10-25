Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63A27D638A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbjJYHiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbjJYHh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:37:26 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7889384A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:35:09 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4083f61322fso42158765e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698219307; x=1698824107; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pe4SRUofU2WFm2fmN823Um+mIBdgfTseC5LX2TC6qmk=;
        b=T7Utl1aTwx2yevUK8aVbd9iS9TRpfdmNsZGhXGZYg+4e7QghB16ML+7RZt24NNf2AB
         8nF7EbxbbN/dwi1CPA2QSV8iXESKxQjN2ToBqegEwL1rkmyibvr0vIM6NGrsVQ2j98kT
         jMXa7pNCR6JQYLyl6+Z8S7w9GSRZ1sSjT3QgdNgDRo5KwCSIyF76k1DE7c3fjni3KS30
         MZ6MLwwgh4+0MbBwCd1KhTf6ht6i6IYVzK7xy+d1h2jLF6cA9WbV+DFkOGCQR3IPGTyz
         gFDBmTJ8moe3CKckurQyiPkWpe8orFTYnN7U34ssR1lQK4awqw3OWCbHRGJIPYQvMPgx
         /ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219307; x=1698824107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pe4SRUofU2WFm2fmN823Um+mIBdgfTseC5LX2TC6qmk=;
        b=IUxEM8E5Ye6osNqVGsgIIOmvDWZ2NDAsicTwVvcRq2JJi13Jqj8hWZ/SZVF0usMzl2
         kBdV66/Tl2URo3PBFfuupY3LZ70ODpDzOFQP4iR1Vp2MG1wq+jqmcbmkWqsLGzQT3HQ0
         I3pymW6NJ83n7Yoq+EBcSCdlD/Y/3AvsE7/H3R9AVcQ1h9SMTdx+4PVY0j/JICUanjf9
         v+RCvbg4/W63DTqa7Mh3s5+MN9T2yV8MItHr7GQ4oYd1O8CLyL7pa5k4j1aPkkLi04+Z
         96jAfqmAforQFKuV/TM/7Exq3s0e2Qo5IzcRRbzsZGBldOumr0tANZCC79cqsj4/lFMq
         J8XA==
X-Gm-Message-State: AOJu0YyIOzZho+X2rmaLuBxl9EAlLXDS++aRpjk8jjVbRxOq8VGWxi6r
        V3ec0Yxd1jjkvlfZLbnAJsw8TQ==
X-Google-Smtp-Source: AGHT+IEiQvJPZXUSoJ+rvGAVwkMDv40zmLqfwbPBtb7KlNbEPmm3TB9RLLv1bPNuVdvy0rjD8U7C4A==
X-Received: by 2002:a05:600c:1c29:b0:408:3d91:8251 with SMTP id j41-20020a05600c1c2900b004083d918251mr10926835wms.5.1698219307607;
        Wed, 25 Oct 2023 00:35:07 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id x18-20020a5d60d2000000b003248a490e3asm11449058wrt.39.2023.10.25.00.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:35:07 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:34:59 +0200
Subject: [PATCH 1/8] dt-bindings: display: msm-dsi-phy-7nm: document the
 SM8650 DSI PHY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-mdss-v1-1-bb219b8c7a51@linaro.org>
References: <20231025-topic-sm8650-upstream-mdss-v1-0-bb219b8c7a51@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-mdss-v1-0-bb219b8c7a51@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=748;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=LjEsqHAGp+UfualC/tIMljUQuvkQEZ5WI4NYmB6cs2o=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMUlzhTUsc4upScdy9doWeeZ8Av0tdD3FxQMALDK
 w6zzprCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjFJQAKCRB33NvayMhJ0QJqEA
 CUt/Fq2kgT90yTup1XhV+j3NhHGt6q7dqGEjHB+5YL+39c+RYWVhJ8fq+9zDhTot7kYVsS8nJZlrbn
 JhZ44Zf77PWDphzIjLmVzSgW9QHZbzsIlNCX5Z2NyFVhbm3q/OcJKY9bRA8addCLKdo4ublGUg0Gsy
 EOMNZpc20cA0Ujl3WGyU/m3vdVRI/2J2YiEATw3d+MueFgm7w4DJnjEmnkSuwmDnuwahIlNPK++/M8
 20I32mfmeIhUe4eRUn8bnM6fSuOOqrHXxNhRHdzFIh4bCrSpJEk0QVj+pBs2nmtkczf/fK2+wpsbFs
 5sOKycIN2dIVv8mIi2w8w44dTpVT7d+VL6XrvetdsSqO9iMMy8/nrhvSJGFRt2RCQZRnYmaW8GoRWI
 zUNt4XdlIrnkdY0RovJdvaLHLGO7vw7KHd3nr0P3uKwnb0sCdnbsisxvHE6zZb5twIU1ojpsru0owQ
 vk0iBMrK4HoGvQuAC0iVoXnSip+GE1hcS/S9ULjhFqQBzYc1oTqmi6gxpkOeMYHJobJnFJFJuSwQLo
 piFfPx9T2CsDrGFIK2/A5aKSEufirnWnpd4Hpnj8blFh5MDV9rEpvEsoyBv4kxKTDwFfyLEPuqg3+W
 WegGC7+fkK1/ViVzn2uEywsilYnlcYXkeBMoT8WtERZBXQs5XMfrMBABJqPA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the DSI PHY on the SM8650 Platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
index dd6619555a12..7e764eac3ef3 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
@@ -22,6 +22,7 @@ properties:
       - qcom,sm8350-dsi-phy-5nm
       - qcom,sm8450-dsi-phy-5nm
       - qcom,sm8550-dsi-phy-4nm
+      - qcom,sm8650-dsi-phy-4nm
 
   reg:
     items:

-- 
2.34.1

