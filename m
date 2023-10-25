Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE387D6247
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjJYHSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjJYHSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:18:34 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DED7133
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:18:31 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so74642511fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698218310; x=1698823110; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zFDz+M0UYdFKqciwDNgVINJYhQcMXvNDjn381PdtAr0=;
        b=kHmiR6Q6wl9t8FL7wozdDSboPt3wEVDq9pI2zivrjf9awI4xMAgGHp/9Bk2rpEoXUS
         hh8mSyLV979W2e6rkzTzTcFMI8lKm/ORXP4WUG12xo1keVqPijpN+MUIsiOQznreCnL5
         36VApPzLa6Nvtf3WegJbxc2tscyblu76nDuUe+IfnkWohw/kY+AlYOLm7DNzo8nFiLO1
         PakkBaNCRn5YlYhZVl44FYTfgyqAIhiLuWR4OVnYBWOftcOOksOHxfAm5UOQ5s2ckujf
         BRrhHro9EptXdfI01MK/1OFUV6Djt8XKEhcDv9El47XX7yYffv4phDKl655fEF6ZqR75
         nE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698218310; x=1698823110;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFDz+M0UYdFKqciwDNgVINJYhQcMXvNDjn381PdtAr0=;
        b=TTtd2bM9g48ZDJ9+s05+BKDnRRFfNJU2zcyiohRgylKeYP7U9oalqs5C7zrr+16nGK
         BQuBx/SV/UmOxY1pmIZQ1/GZ4ybddGIlYPxBD2RQ3wdLeYujkbsTqzu3+ncQuHjPLiW7
         fAWuHx1xhPooIILgkz+Ca2KxqWrUd6JVuABzlbUupKGNa7rgKjrtYqmdy+q8tZQCept3
         net8sJZoZ2cFapzNRB7rwMb4t6Rw2xziVQFb0R2e86Oztrt8/kMsyDGcbD9AV20ENhYR
         TRYwMVxIhyhncUcWKJD9sB9hvYPPBPmrZGSwBGqkJkaKaZ4xy/143p4BU9M7xjLIvd/A
         sHnQ==
X-Gm-Message-State: AOJu0YwVK4YMOydPzC5zffaTMbW8SmtFqbbHJBhD8zqnGpajvy/GExYd
        Sfl9jJV8yK8KiRjfTaNDWur4HxlsW0Xn4NpWjz9KYNS1
X-Google-Smtp-Source: AGHT+IFrozB4gFUphdayvOWReNoVyUqfgYENSrUOhDao0BY1Ek/2sK35eeugDqPuASwqsfeiE08bsA==
X-Received: by 2002:a2e:9cd4:0:b0:2c5:2df8:d321 with SMTP id g20-20020a2e9cd4000000b002c52df8d321mr9816552ljj.36.1698218309753;
        Wed, 25 Oct 2023 00:18:29 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600c11cd00b0040770ec2c19sm18514378wmi.10.2023.10.25.00.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:18:29 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:18:27 +0200
Subject: [PATCH] dt-bindings: soc: qcom,aoss-qmp: document the SM8560
 Always-On Subsystem side channel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-bindings-aoss-qmp-v1-1-8940621d704c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAELBOGUC/x3NTQ6CMBBA4auQWTvJlGI1XsWwKDDFWfTHDhoTw
 t1tWH6b93ZQrsIKj26Hyl9RyanBXDqYXz6tjLI0Q0+9NWQcbrnIjBrv7kr4KbpV9hEnSYukVdF
 nVXzHgsENzBORvQULrVYqB/mdp+d4HH/+APZ8eQAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1190;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ujpHzL2mDnNq1FMhjNya0BMA8gZVq8wjv/NajHbGyz4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMFE/LT8pcN1QmeXxafEwBE/J6eqK93jYVGIB2VZ
 mVASUXKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjBRAAKCRB33NvayMhJ0dM4D/
 97Lo2Xvsnq/migfuVva9B3GkXe7TKwaD3yTf97a5FOxzh9cnyxM+lw0uaZgpu+cx9I1g33cZS/ZrSc
 y/D9wnGLoFNzYYJRF3bh8QjcnYL+LdzmneEOS9eHyPNZPAclo787XwcZYBf4YBX/E0kDqWNIE9PZcd
 aPHNo0I+h5HaRfqX4h4SWlqFsVOFNcVh22il8feMABF53ueTs8FUdUXjtAqo1eauy5xHhIaDrU6rTE
 BWEAAosRBS+J9wtzC9KMr9YUEgszvWs4UGz8nctW38FX2TxQ3N6y71GNW4HkuUmgfWbns4WRT4/6br
 kVtqlPW/8FB5v+FaDduN9/o+nYviNG5z/v11giMB6Yb7EKe3PR4us0RPJo0PvTkQ0dMF1x+fp2nOJ5
 lxSIrsa2B8SN4RQho0EVhA+E8WElW8g6q9MT8a0776Z0y/5ZyoharCZptzaC143tEQIN3+2wAg6UIm
 SGUadBb/Mxp5X4+nc1ectCpIVBmsaHEBYAZzSWP3YX/gppRmwCeHG3akUdBRYIPem1xvrKHKtzTKvo
 6ro12UeubKcxDX4B1rp7ky0MXRG8d+Ucsu5WpygGVNiEUGbj5U/j/X7uqGcdQi8CXECFtrnKJGskt8
 L1W1Z14V87lkQY7EN/z8I2MDSVY5t2/pLH1PqBlBLxGaWakqEwVn4mmjPCqg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Always-On Subsystem side channel on the SM8650 Platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
---
 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
index d1c7c2be865f..109f52a0b524 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
@@ -38,6 +38,7 @@ properties:
           - qcom,sm8350-aoss-qmp
           - qcom,sm8450-aoss-qmp
           - qcom,sm8550-aoss-qmp
+          - qcom,sm8650-aoss-qmp
       - const: qcom,aoss-qmp
 
   reg:

---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-bindings-aoss-qmp-f64eeb0037f3

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

