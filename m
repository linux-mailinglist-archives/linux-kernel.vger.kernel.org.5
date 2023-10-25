Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055667D626A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjJYHZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjJYHZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:25:13 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05FF90
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:25:10 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c51388ccebso78793101fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698218709; x=1698823509; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ri458HBpNHLXsYlIQQ4bff/ThAPB9PgG4OupwV+LdXc=;
        b=k/u5op/ScPCafrXtdeprSu+GuVnvEHCcTkG6Cds5yp0QFNAgeWXAK95XYoFt00vGxH
         i89iRCXEKAeYLsfAdXmDu8Fj45dU2QvRQ2XjSevFzdpKRn3tKUmJdEQwpK1mzPANMGR0
         w7iMgDl2t49edW95o8wIKwlA988bNuBXYhhpFpXuH75OW6OC2yxbAVP4ndNsZjo9bWph
         q2I8376Mbt9csUJLTDcraySW4ciNXrdxHMa90XpgD47h9brsMJDyej8exU4iLm+v6YNC
         yGQTeslcIe6sl5xdrYIg16a3TyS7TtIM5lCw/M7cbCNeKMu0ksr+r2HIYn1VPMqH5nQq
         KlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698218709; x=1698823509;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ri458HBpNHLXsYlIQQ4bff/ThAPB9PgG4OupwV+LdXc=;
        b=MmmXEWJFU1gjlJI6yGQZH5gdCgIUlAfa+2b+jqAhzFrPL+LEYvfUmzI7DPZcg9vWYi
         2unGykjC5K82cUj01uvk0SZy342OD8l4Fi/jbhYqCkfzDNoAfj9B01Gg39zhyPlAnzad
         5YxO7IQvbzFTE3X+5HIo2I6/b4TssEdejHiMWltXqD6aRDvA0AtZ1dS05ddJDaiaPlxa
         aWU/MekI+HXXWETut5/62ATijjiPfadWahfl1A+KbwhGDrrzoxHqurb8TIedWMwHW3dl
         tz9k7VS7pbFi1Ckj5zTwLYvpkNfOSzz+8HCh2fDjiizelIxwEpYSyK1CkXOfNiqlwL/v
         Rmlg==
X-Gm-Message-State: AOJu0Yw3b0FyuXXe6R2WK9ztlGcoS/UijXtcG+gZv/x3jNkMHK7EJwYI
        TrdKSUChzLe/lHmd2yGyWOxlcQ==
X-Google-Smtp-Source: AGHT+IEO018Y3r90kMqB6BOJDhpYBiNCTIKIo9VOfLP7dcc8SejJfgrHZaQCp45Z3X8iUkMLdH0KNQ==
X-Received: by 2002:a2e:7218:0:b0:2c5:4a0:f3cb with SMTP id n24-20020a2e7218000000b002c504a0f3cbmr9445936ljc.11.1698218709213;
        Wed, 25 Oct 2023 00:25:09 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id fc11-20020a05600c524b00b004064cd71aa8sm14033102wmb.34.2023.10.25.00.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:25:08 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:25:06 +0200
Subject: [PATCH] dt-bindings: cpufreq: qcom-hw: document SM8560 CPUFREQ
 Hardware
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-bindings-cpufreq-v1-1-31dec4887d14@linaro.org>
X-B4-Tracking: v=1; b=H4sIANHCOGUC/x3NwQ6CMAyA4VchPdukm5EZX8V4mKODHhizBWNCe
 HcXjt/l/3cwVmGDR7eD8ldMltLgLh2kKZaRUYZm8OSvjlyP61Iloc33/ka4VVuV44xvKYOU0TD
 VLSt/MGZi8iG44DO0WFXO8jtHz9dx/AHAXyuleAAAAA==
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=wkyJSzNygVePEVNeV4ngw1vtxt+msc+22f2dDIh8Bnc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMLTLfu4jLiWmaKbHJcTJ/6Cr7L6bVBFzsp2zodf
 aFZC9VeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjC0wAKCRB33NvayMhJ0TQoD/
 9FLfE3wwPk2VylrBBo8tInn7AwsFB7rL3do91rUVv+qK7YJxojfV0MWR3nEiKvIvI9yCJe6NzMIphq
 kKpx8CGVHg0wLFtFLI5L/uYqzEdiJ1j89RkgiBp8Juahg3JFjkChFrfLgq+Y/LfWL3J06kqyZzKDr2
 zyzfJNAdv8/KUIVOLpTuL8+uIK8QK/AkSXq6pYWyRnS4drXj/soCtPMP9LutpjB+cOxErli0DVvE4b
 CaEeUDPiNg8DapUXYgLmEkUoF7J6/NvnI7x1rWDpy0EVo4LenLeiYE4G4oiycg2sO8FublTjetBT3+
 R2FsSV7sPKPecyidzmlgcndl3tU/mgRzRxjQd/FMok35yW6z4ME5B2SZ/fnSsMmCVSYMilSD7Z8lmN
 E/u54XFNJSb+ekK/6EC83MftFgPAzTLJAg+lnYWGqtm+radI7RYw9ISaIcqqaaZUxesBJZ2/8slUZ/
 EAHZv55tdgdydMAkCIaP0K8USWyBYRDiNRX/zvLrY4AV8x/Dk07hzAs9MXO8yLKLyw8EiLJ5rCSCne
 LARWbCirwyp+A/HoXElAsoISu0cR8AzEGbWJTRV3Q9dege5zJ0f9MrUaqq6rqO4MrTQu4hAtP/Lvwu
 kff8cvOCcBnN+ZZcuYJv+UB7MBqURh0S4FoLnqvJAbBDB5hLkssiAKOwhFKg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the CPUFREQ Hardware on the SM8650 Platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 0177d1ef0bf9..56fc71d6a081 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -43,6 +43,7 @@ properties:
               - qcom,sm8350-cpufreq-epss
               - qcom,sm8450-cpufreq-epss
               - qcom,sm8550-cpufreq-epss
+              - qcom,sm8650-cpufreq-epss
           - const: qcom,cpufreq-epss
 
   reg:

---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-bindings-cpufreq-af0e0277172f

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

