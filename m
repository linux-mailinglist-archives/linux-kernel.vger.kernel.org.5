Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA617D9B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346146AbjJ0OUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346118AbjJ0OUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:20:39 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DB6191
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:20:32 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9bdf5829000so346924166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1698416431; x=1699021231; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f/YAcCQSyL0MrtnrGqDdCH8ykc9V+03QnHqH3Sh41Y0=;
        b=Pd9NHANuXdyDutJRghNRBB8Qbne9f6dkiWP3Em/pVqchrFambs9beQYLS1j6ZeThDd
         ODiF7mGAzx1OZmkZovzeRgXcawOnwb+8vwYE9pX6eUJeYzGWJTIxXNze7TYiqr9IHmLu
         Vsz6I+GbRN9O1XV5+KPgL1L1TkpCxCeeJrNVM9RfG1GEGsG5e323UeRAySgAB3Q8Fy18
         UrStoU27WAaa4Oq/RiZFmy59kweDwSf7m29rHIedlEYLzKsvfkoinfNfxJaurFivZbA0
         4aTTmoN0XZLwtoCLYygAqIkfo3k8x/XNFatlvMvkgZ03E7Y2uQKO5ZYzJmN8fbxQaO64
         zHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698416431; x=1699021231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/YAcCQSyL0MrtnrGqDdCH8ykc9V+03QnHqH3Sh41Y0=;
        b=bDpuP0b2FpG5P+mqDZkSNlJWzGv3jmYRbWoWIB49JOWlTUjTsucpMddUWJplC/QlJ4
         EruSU+fGYr3jChmnsPp136Z+k/F/t4cy/B7AnfQ8qVNBUu8XgjvQ/MXDjMabF/2AJZcO
         AqaQsLvWNbpjjIbfIxL7vnLNQWGColI3iQa0jW7izGOa0KsBrfozxY6wOFFsgcXZaH/H
         tUFYnLaFZcDDQu+aYE6/JoABUrrpUwc/xHX+QByuWxsqX/aAYe+KVa+5AGYCdR50Q25I
         jiOsJZEcbhmefZ4gk6/PSupCatmVwiFXbDoljXMQCUynXl0cVespb/tG+FszjgN/jvOA
         2QTQ==
X-Gm-Message-State: AOJu0YwhpoJmg30oad3LL+lygmKBg8jM71ZHOmW3iaJNxmA3T29GbEp/
        uQ1tGctNiXV/j4zOQUchoZInTA==
X-Google-Smtp-Source: AGHT+IH5OCx1kUMTZKHFrbG9AqS1NrHdCbb9zdWSsXcRx4drhINFK/59KH3fJ0Dcp7kpH4gqfd3e2w==
X-Received: by 2002:a17:906:fd86:b0:9c5:f1c6:5978 with SMTP id xa6-20020a170906fd8600b009c5f1c65978mr2123696ejb.55.1698416430978;
        Fri, 27 Oct 2023 07:20:30 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id z23-20020a170906075700b0099cc36c4681sm1254076ejb.157.2023.10.27.07.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 07:20:30 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 27 Oct 2023 16:20:23 +0200
Subject: [PATCH 1/9] dt-bindings: remoteproc: qcom: sc7180-pas: Fix SC7280
 MPSS PD-names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231027-sc7280-remoteprocs-v1-1-05ce95d9315a@fairphone.com>
References: <20231027-sc7280-remoteprocs-v1-0-05ce95d9315a@fairphone.com>
In-Reply-To: <20231027-sc7280-remoteprocs-v1-0-05ce95d9315a@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The power domains for MPSS on SC7280 are actually named CX and MSS, and
not CX and MX. Adjust the name which also aligns the bindings with the
dts and fixes validation.

Fixes: 8bb92d6fd0b3 ("dt-bindings: remoteproc: qcom,sc7180-pas: split into separate file")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
index f10f329677d8..6f0bd6fa5d26 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
@@ -114,11 +114,11 @@ allOf:
         power-domains:
           items:
             - description: CX power domain
-            - description: MX power domain
+            - description: MSS power domain
         power-domain-names:
           items:
             - const: cx
-            - const: mx
+            - const: mss
 
 unevaluatedProperties: false
 

-- 
2.42.0

