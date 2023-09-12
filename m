Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2081579D244
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbjILNcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235672AbjILNcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:32:11 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECA21704
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:31:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52c4d3ff424so7303477a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694525517; x=1695130317; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hprXduSERdcXr8fQPDcH/kOBSydAG/66jnnLTNoJnrQ=;
        b=nl27IWqiKLhE5uIdAcKZuax+8oxpllZxIiHmmEpWy8q4x4MgqsRZczvXDHNveEHWs2
         1o1Kbbx46Bd8ZLuGtcF5Ema1uY3hdvytE/CjpmAI0I+S2IGJsl4B1Bj/rnRD01bsx4OM
         HvvRHrrD+MBzAM2XFg+tj/qExR52hiiTcMvi8+z/Lk/agFM7DfhzIh/enKT9b9oaG5E3
         BiqUbMzhmJeW9p2bzy6u5q0/H4MX+2DdiTd2NQqTqw/i8fEJ9hAwMVVx6blqVGjozSkr
         ZlrrWqqCsop7g7gGxNznZy4gsooey6+kvMxnVRCgih7C8HIttTIIrw5DLHv9zplYiAV4
         Rzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694525517; x=1695130317;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hprXduSERdcXr8fQPDcH/kOBSydAG/66jnnLTNoJnrQ=;
        b=X+JduSKU3pnc3lTwE7hD7jiIvz2MYAQzgUcMWnfL030EmOGJ5eIKnI4WBQpzkEYTsZ
         /8qSoYQDwMXTb6r9uuQeFYCWfnUd72K17TRXrT8J+eNV2ZKbLcLzwpmJhV1Y20yf+zlQ
         viwnlM21BIreloMlUtgsdflqENOmrCupkhrQVuZh1GRGns7gno9HDj/PSYfm9m0uvOsU
         i7jMAiR+9Jqy1pNuYYOahW+v9hXu96leDwxzUAbJhvaaYDZ5QLjRKkgbscvwT5DQShoU
         TXoGBmV2gwxA39NsqpWo9tdQFAWtTFvoTnM9ovKfcdMxTgGH4GZC8wrGaZ/hVtMYWGTR
         zPEg==
X-Gm-Message-State: AOJu0Yx0054NSGpnwLFA0WH5y6Wu9sOWcPGrh7m6KzpMBT7V/Oe3Y01T
        K+N+c2RI9kqDb0bHhL4hec2rMg==
X-Google-Smtp-Source: AGHT+IHWdhKZNYbyCtwrTut/EnB7j26nTWPkwhyp7Lg2aisMkxMZ5TeczzzhrCocrjZIdTy380fTsQ==
X-Received: by 2002:aa7:d58f:0:b0:52b:d169:b374 with SMTP id r15-20020aa7d58f000000b0052bd169b374mr10440089edq.3.1694525516691;
        Tue, 12 Sep 2023 06:31:56 -0700 (PDT)
Received: from [10.167.154.1] (178235177248.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.248])
        by smtp.gmail.com with ESMTPSA id j2-20020aa7ca42000000b0052a401d8ef6sm5983830edt.71.2023.09.12.06.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:31:56 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 12 Sep 2023 15:31:43 +0200
Subject: [PATCH v2 05/14] dt-bindings: usb: qcom,dwc3: Fix SDM660 clock
 description
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-rpm_clk_cleanup-v2-5-1e506593b1bd@linaro.org>
References: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Alexey Minnekhanov <alexeymin@postmarketos.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-usb@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694525501; l=1330;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=oKjuNkgzsVv0G3/eKjMFGrCERVPsFFgQT84K83ka8+U=;
 b=MJI6Zkjgyl4e/MBwCcdEzH8lpMhZ2KVzQxUnEtjyLeHGmT6e7heMAaUtUwnoDHT26EvzWZBNP
 +YNiyOZcIsxBUbOqbN8aA8+DhPq+d1np3mYs4n3yRdSyzMq/mH7fMiD
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDM660 was abusingly referencing one of the internal bus clocks, that
were recently dropped from Linux (because the original implementation
did not make much sense), circumventing the interconnect framework.

Drop it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index 67591057f234..820878031d47 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -283,8 +283,8 @@ allOf:
     then:
       properties:
         clocks:
-          minItems: 5
-          maxItems: 6
+          minItems: 4
+          maxItems: 5
         clock-names:
           oneOf:
             - items:
@@ -293,13 +293,11 @@ allOf:
                 - const: iface
                 - const: sleep
                 - const: mock_utmi
-                - const: bus
             - items:
                 - const: cfg_noc
                 - const: core
                 - const: sleep
                 - const: mock_utmi
-                - const: bus
 
   - if:
       properties:

-- 
2.42.0

