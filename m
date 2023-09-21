Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5517A9D9E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjIUTnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjIUTm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:42:56 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1900EA0C3F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:27:59 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bff7d81b5eso23307741fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1695324477; x=1695929277; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wT6/A5jKUKPNqREpSjfwwNBvJsp9RJseHUsd7KRCJ5w=;
        b=bHKjcV7pUv+y996kDhnJS1u0HXwdGxzltu8Jt+R+mRF54k5oXFHjylmtMXIt7WGY05
         ICCHdtZjTzpRdMQj9Q8tbFKEsA3E52/8UY5571u4UpCimdBre3l/um+UjH2w+WH5kkzt
         2bLVrThni+FYAsPBAWPiXm05Cd1YzG44cXSUQbS0wjYSvb6oWRVPyI0NuHCKAbczjglS
         RYrtBWLTrOYcQvGD/WXl3aQhIBS4n3MuUvdUGS9+K+FQQBrc8VHHCmUY4G2RcBNTePUm
         qtDy8pdErDakPKNxrtJYfqYFmNFwZNrUZAH8nWcVBegE3M0xv+oasx/GGUpGPwcygmlD
         wzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695324477; x=1695929277;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wT6/A5jKUKPNqREpSjfwwNBvJsp9RJseHUsd7KRCJ5w=;
        b=Xs70Xm3uaQPbal3yMnNqDFwaBJqMNIsMXiJhuf8Mzci2667rHOE1AICPxw9mqfVMKj
         MLZ6KRWUf8nlTYAqmCPjJvcz8TVO+It9weiTJGxxhA9WLS6LpMTGKm5njTgaL4OEpSgD
         DG0EJhmgTQVVXP4PT2Na0hlRe66qadGuwy26gva9xBfTRZu2pWxzwPmOgSeS5j3ZfUPy
         3yvHRlP9gQF2fQBNWK8cQhJEU6OYmVjzYEuxD+3+v1kCvpwm9qGbjFZVmT4pNXeoeq5B
         sRyA1HJnwPUJtAaVIueajz1LKNF3LeG4CtXbZfFOoXVp6FcdZC+Bend8Gp2WdslFE0qI
         hgRw==
X-Gm-Message-State: AOJu0YxTffjCcIhV1KCNRSXD4iGFdeeloqvI4a8W+ByxWuEVb3L5ZU+Y
        Ww5Zt/1hKZTEzS81/gSS7WnMyEiPY/z2YqYO/f7/uQ==
X-Google-Smtp-Source: AGHT+IGieRqnzeLuaUx6Ie7RXs8JxfkdBUmowjxYl2mDxddATi1AGsiIJ7LQSmc6+cCJVTz0fUr3Aw==
X-Received: by 2002:a2e:8696:0:b0:2ba:18e5:1064 with SMTP id l22-20020a2e8696000000b002ba18e51064mr3815918lji.14.1695278048481;
        Wed, 20 Sep 2023 23:34:08 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id z25-20020aa7c659000000b00530ba0fd672sm367971edr.75.2023.09.20.23.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 23:34:08 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Thu, 21 Sep 2023 08:34:02 +0200
Subject: [PATCH] ARM: dts: qcom: sdx65-mtp: Specify PM7250B SID to use
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230921-pm7250b-sid-fixup-v1-1-231c1a65471f@fairphone.com>
X-B4-Tracking: v=1; b=H4sIANnjC2UC/x2MQQqAIBAAvxJ7bkFXJOwr0aFsqz1kohRB+Pek4
 zDMvJA5CWfomxcS35LlDBV024Dfp7AxylIZSJFRjjTGoyOrZsyy4CrPFVF5Y73x1hlNULuYuIr
 /OYylfA4JhdVjAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the pm7250b.dtsi can be configured to be on a different SID, we
also need to specify it for this dts file. Set it to the SID 2/3 like it
was before commit 8e2d56f64572 ("arm64: dts: qcom: pm7250b: make SID
configurable").

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts
index fcf1c51c5e7a..9649c859a2c3 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts
+++ b/arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts
@@ -4,6 +4,10 @@
  */
 /dts-v1/;
 
+/* PM7250B is configured to use SID2/3 */
+#define PM7250B_SID 2
+#define PM7250B_SID1 3
+
 #include "qcom-sdx65.dtsi"
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <arm64/qcom/pmk8350.dtsi>

---
base-commit: 7fc7222d9680366edeecc219c21ca96310bdbc10
change-id: 20230921-pm7250b-sid-fixup-0c35c3c59312

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

