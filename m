Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039BE7C8C6F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjJMRjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjJMRjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:39:06 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD26BB;
        Fri, 13 Oct 2023 10:39:05 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4066241289bso24690425e9.0;
        Fri, 13 Oct 2023 10:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697218743; x=1697823543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxgF/BT0Q1d86ImgBQJc7uUcvRZJQAS7KHrdxpFNXRU=;
        b=N3arRhd19lS33bqvzZpKcXuwhdl8VTxeQjLCJc6M+QUjnO6enjbnzYe8228jzUD1Tl
         3Zj8r56NchmiO9KcdKk1et1cXnzwEt9pTIh+kF0AV67dIFp3EIHf3390MKXYidb0lg4z
         fPZCeosuYH7itxYRJoNFyxlApU2rlgvYPTIzuTXgt51j6xALqcFapaIhq2MEG23frd4B
         l2qHPG7Yzf3VAtANdQrjkwJ4EB4tVxs8q393b8gCVpFGlbcGhH9YoLqlaUNieyZ+fHXc
         7qzEH96lt4edOLIjVMlNlqC5TPlOWvr7hNAEdKIKqZYsQpbbQ9Ipd9aSMJcMXw+sk4+K
         pmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697218743; x=1697823543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxgF/BT0Q1d86ImgBQJc7uUcvRZJQAS7KHrdxpFNXRU=;
        b=dP5JZ226HV9XTZPP75TjRMbE0RqNcV1/asIS10lZhCNbOkFRn6Y/Sd7yW6DLTCbycd
         8/s+39DxZis49wZr1N+XeuLeKwjF5KZ17jRmY4+jZar7yQHk+DFWUCaMVN3SNae/rh/j
         jMjr5h2ivaxtE9mv06yXgJz92zFa6kcYOkMxAJ8j4BkMaxFtjBkpfSKYt3l6hJi1KwuE
         kDALHBh15TJc+LTykm1S6OPeGYToAItf+wAT01/1rMHCV/IemuS+j2eHxKMc8Y7DD4Sn
         SbpWeZTvCdVl/Z004xi0Vc80zB4jBbmLtB0qNlfj0qhw+tFdvYhXdnjRnZTXTkUjYKG4
         3a1A==
X-Gm-Message-State: AOJu0YzRer5uWZ2Hkr27u56ammnEIqcrhLCFNaIF6xnACxT8DVGrTJPX
        1I8LM+ZiNuqPDsSjnsc2jLs=
X-Google-Smtp-Source: AGHT+IHPCy72MJexf+rVvLrAdwSYSUv1y0/LDoEYYNmChrZqJagWFAWsc5nUwo0YnPLjhtA37OcVqQ==
X-Received: by 2002:a7b:cb8c:0:b0:405:3f19:fc49 with SMTP id m12-20020a7bcb8c000000b004053f19fc49mr24639712wmi.34.1697218743149;
        Fri, 13 Oct 2023 10:39:03 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j11-20020a05600c42cb00b0040652e8ca13sm692074wme.43.2023.10.13.10.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 10:39:02 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/4] dt-bindings: cpufreq: qcom-cpufreq-nvmem: Document krait-cpu
Date:   Fri, 13 Oct 2023 19:38:51 +0200
Message-Id: <20231013173854.7399-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231013173854.7399-1-ansuelsmth@gmail.com>
References: <20231013173854.7399-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document newly introduced operating-points-v2-krait-cpu compatible to
the list of accepted compatible for opp-v2-kryo-cpu nodes.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v6:
* Add this patch
---
 .../devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml       | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
index 7391660a25ac..185e014eaa31 100644
--- a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
@@ -46,7 +46,9 @@ patternProperties:
       - if:
           properties:
             compatible:
-              const: operating-points-v2-kryo-cpu
+              enum:
+                - operating-points-v2-krait-cpu
+                - operating-points-v2-kryo-cpu
         then:
           $ref: /schemas/opp/opp-v2-kryo-cpu.yaml#
 
-- 
2.40.1

