Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890827F4316
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343750AbjKVKEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjKVKEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:04:14 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336B1112
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:04:10 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-548d4fc9579so1306223a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700647448; x=1701252248; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w7f1ry+FDQqkAZW/rR9a28DSHUlK9OY3DwH31gg9Q84=;
        b=sBCC7xiNkfyEG8JlnBE/0g0t7PulTT9t1ymXEDpuL78gflcB6u3WRe6NXck0C7O43U
         G65xD96m2/yx8eG39BodNbJ3bye040Ec1NbP67yLjS50io5AGsGWuHa7sfbTb4V2m+pO
         IyODIcJgZdcIJhsV5Njc9IqKDfy6CojpVEckqb94ut9XfSmjoTZEQiHmV/eiqkSG7WG4
         +jsuMqPLURly21xL1Vkb7BG+OAz3OgXWS8arvn1oOrp/pTHpqoLWlRvcEm4u3n/ZjDw6
         HTWqryItaXHoWqDpvpxRuBqzao130fUYECv6guih1Rsql2meC7v1t4wlfN0VPI7S+LkL
         5vUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700647448; x=1701252248;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w7f1ry+FDQqkAZW/rR9a28DSHUlK9OY3DwH31gg9Q84=;
        b=OJBKaATUcRz8+vPH734299wnUA8qV4vKS9BGhQZbfghhEqgonYxiqy4Xe3WFMh/FCT
         5mp9DeQ49THXIx1oJIpdMBn25N6U32u3rlEcsrjG3RFM/tO8cCQtu3MWQYf/Tfb16OI2
         qVJzM2JYO4B8K0OItrVZ7CL2Wis2DdyEEx2SHpGa0TJYZhyEctkdmd+X8TAFI4fByrqs
         A0N3QW1Vz8w5m85gAplXqhbmKqmaOoZzyyY9aDVqEq31S9DgyO46hAo6V70+d8Y8UZqa
         gHJoTwHV1vLP6FiIiEhseIaBkGKibae2EXS9KiuPRiGfXXaI0ZoHbo4CAsy7oqA2Erj1
         Lo5A==
X-Gm-Message-State: AOJu0YxCHbrN476HTmH5U3FhBcfftJSPaNe2TWc0M8N7BdEX72gHk2QZ
        xScZ1YR37xexVhyVfvBzG4Hc0w==
X-Google-Smtp-Source: AGHT+IEgDMMola5hcl3sRGIjNkZchAYK9E5xjDjIMJIUVE72GkCxvOD3iYG8i8XcduQFgvMtPwfE7w==
X-Received: by 2002:a05:6402:341:b0:543:5dd9:a72 with SMTP id r1-20020a056402034100b005435dd90a72mr1795722edw.1.1700647448634;
        Wed, 22 Nov 2023 02:04:08 -0800 (PST)
Received: from [127.0.1.1] ([86.123.99.122])
        by smtp.gmail.com with ESMTPSA id o9-20020a509b09000000b0053deb97e8e6sm6110456edi.28.2023.11.22.02.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 02:04:08 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH 0/7] phy: qcom: Add register offsets for v6 and v7
Date:   Wed, 22 Nov 2023 12:03:52 +0200
Message-Id: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-0-d9340d362664@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAjSXWUC/x2NQQ6CMBBFr0Jm7SR0DNh4FeOilKltUgp2oGoId
 7ea/M37i/d2EM6BBa7NDplLkDCnCurUgPUmPRjDWBmopbNSRLj4Dz43E+08TVj636jFcsHEL5y
 dE14FOx470lZr1xNU1WCEccgmWV9laYuxnktmF97/9u1+HF+P3xBriwAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1529; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=7uNpWvfhMS/e7VHo0mKgiRBZNnLydquBiQsmtLr7VSc=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlXdINHHIs4ath05z+8Hs8g1gW0X3hAEI4sNFPy
 +DU07jxd2eJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZV3SDQAKCRAbX0TJAJUV
 VlmPD/9x+2g6mcKduypmeUFwCUL0yc/3rSOtxmr7QHSCkyLIOWBeVRU+XUgyjhn/NxUW339dn7m
 4+5wgGSjhqibxtG2bG0fLHbRhwDTPG7lChFSCQf/oHqK5S4kDO+kSf1RYUgGPtWgD076y+I7/F7
 8e9t0OnbriPw015DPoxGz45pI5iA/vEDjm8GP9fLWJhZeREaI5dwv/gOp3emf2HxA0PjbnW2rnK
 +xv4qXmHpO4yBUF++OVCYwt5dguoHHUsHfy3a8Oljd/lkAZ3sAp85/X4Y09Az+y+/QxXuKIqe6O
 V0eHoM0Y7QruLAxmDZX6zq+jxVI75LIwbsFCcAfu93z9bjz6ZPgECyTZz8NRc8TQNkNujwIYMxd
 taSHQFu3A5a4+iaCwk7/TTkuuIAHAc/OCQKYpQOLhq+ZuhkD21KnDAp+nEeCWvQX5d7Nm3YsQmI
 Lhr485G4J1UvVb8LZ0Gn/WSUyJNaQ4JbwCnzr3FMo3Arb9wGl344U4d8Ol2z0osgMK4jgCIxRlc
 dlu+tKZfE4f9cOIAnj2Hmwqsi8Vf8FYZv6+65YNwsxonDxbGykgydbdpvkaeX1GlCvcZV1NX615
 AaG2kTM7WEV6dDZmX+IspFA1f8qL/zbCiv3N2c84tPhYTN8yxk1cgBhTUcSuRxqVJOHK76dsBYB
 AyvULfIMouyi2vA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds some missing register offsets for the v6 and v6.20,
as well as the new v7 ones. These register offsets are used by the
new Qualcomm Snapdragon X Elite (X1E80100) platform.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Abel Vesa (7):
      phy: qcom-qmp: qserdes-com: Add some more v6 register offsets
      phy: qcom-qmp: qserdes-txrx: Add some more v6.20 register offsets
      phy: qcom-qmp: pcs: Add v7 register offsets
      phy: qcom-qmp: pcs-usb: Add v7 register offsets
      phy: qcom-qmp: qserdes-com: Add v7 register offsets
      phy: qcom-qmp: qserdes-txrx: Add V6 N4 register offsets
      phy: qcom-qmp: qserdes-txrx: Add v7 register offsets

 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v7.h     | 31 ++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v7.h         | 28 +++++++
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h |  5 ++
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v7.h | 86 ++++++++++++++++++++++
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h    |  1 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h |  4 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_n4.h | 51 +++++++++++++
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v7.h    | 78 ++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h                |  6 ++
 9 files changed, 290 insertions(+)
---
base-commit: 07b677953b9dca02928be323e2db853511305fa9
change-id: 20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-5ed528c88f62

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>

