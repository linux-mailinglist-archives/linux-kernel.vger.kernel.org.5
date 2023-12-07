Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD95808793
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379207AbjLGMTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjLGMTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:19:30 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACD084
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:19:36 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a1eb422b412so125272166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 04:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701951575; x=1702556375; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UkIHYUvRBALFNq0yZBkoDW4A6Xngi3bw5KTNzzylyoM=;
        b=Hi5fR52eM1kghCLlTDL9eQZ0bXk4GGyxXoBlttwLwYVVIgL7nQuK8Rb5dmqC0yzo/p
         7WB7T70SDaSR7n/eEw4+HfLydexzluhle5mBsPigEYRWm9h9DM6+tVJxw3W3ARfeUP8y
         iCCeUMUOBWVT0lKCrgdCFu7LvDRlf29RxFELLhHS47ToAKxk77Xafv2yK+pOGtQgRxPS
         KBiED8FlPiIg8/DA1Bj4mhsPO1fnOvoHYY15CkviYVI+n5ukVoLy0eIZBegcFOSQAGEr
         sQT2XejWTWO444jHMZasrvXof3uXTKSMVtqr1ucjEzIGT/kyHwyF/TkFc7FYmoSEL8vg
         XmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701951575; x=1702556375;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UkIHYUvRBALFNq0yZBkoDW4A6Xngi3bw5KTNzzylyoM=;
        b=p3DZhKBBUrdlBu3wEU/74vTFd8geKkvUOWCOSw1OrgK7z5Yy8B0ZKoCYmH5kaOxPnx
         RVhccbfWZLFd892F/pkKpW1RRROn6eAc6jcjRM8wgdhgGGBWydZhI28IX0xAFZrTUqmP
         GBEg8Kql+oobb298KDkqohwYw2zPvfBftUzXlCl2jUdypOsnXSEgz0rRDdCnER/wBhVC
         jhNg9COEDExqJinpMrY8VMz8wF6K02gmiSLQRP/I3ZZqd1FOB46OnC9EfBLdnBmvI+e/
         szn53SnMkaK8PSpr/GKUNTEpzJCKPDf3aWRJnQmlUvloCDYk++M/ln8VD5Cx8BcVnVyN
         2RFg==
X-Gm-Message-State: AOJu0Yx6xn1f6sX7EJeNr/phUSimQsyvQX4yuB95ZPvczKlwDj9hgyK1
        9Ne0ov7Q+9iY4ZU+TDCI8lS2Ig==
X-Google-Smtp-Source: AGHT+IHrRLkmfjjGTvklEAKWkf38LirPV0giNGNAsHn5IyN6dVCAR5UtmjCFlV7drVANhwFQBhbaCA==
X-Received: by 2002:a17:906:5353:b0:a1e:842d:ccd5 with SMTP id j19-20020a170906535300b00a1e842dccd5mr1177133ejo.48.1701951575192;
        Thu, 07 Dec 2023 04:19:35 -0800 (PST)
Received: from [127.0.1.1] ([82.79.186.233])
        by smtp.gmail.com with ESMTPSA id f24-20020a170906c09800b00a1e814b7155sm761394ejz.62.2023.12.07.04.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 04:19:34 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v3 0/7] phy: qcom: Add register offsets for v6 and v7
Date:   Thu, 07 Dec 2023 14:19:09 +0200
Message-Id: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v3-0-dfd1c375ef61@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD24cWUC/52OQQ7CIBBFr2JYOwaGFltX3sO4QDq1JC1UaFFje
 nepO5eazOb9xXvzYpGCpcgOmxcLlGy03mWQ2w0znXZXAttkZshRCoEIY/eE26x744cBkloPOaQ
 9OLqDb9tIU4SSmhIrU1WtQpZVFx0JLkE702WZm/s+j2Og1j4+7dM5c2fj5MPz80oS6/pjNQng0
 NSy4I1UqFRx7K3Twe98uLK1kPAfK2YrirpUmrgpjfyyLsvyBg6EhRJEAQAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2422; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=mB2W6KYDvq8TrXhXBcEaJwg/nTqyORBrvBrPqSlnHwc=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlcbhFn9IOc3pVcyuGjmrlGfBAO41cuSuXYY+e/
 kDSOqEnaSOJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZXG4RQAKCRAbX0TJAJUV
 VkGCEACCWpfyOZB/VhvyT92GwvmniwF/RQJMjhbj1qMeLzfBGwuI9cJ+/sm0wH/R4gRRXIiJLsY
 Kz46ZiBdPtR8pgVzaWVK3cYVZVOJmXhlss0ZjJOdi1+UY0oFx1HAmeJ3q+4bcOmT+UoyHODnVjA
 /1F25IKfz1e2YZ+MEGV0bJbmptJC2+KIJOQihyePXu9MHhAunqUKhjCxjlUczEWlX8XOCLDZsVw
 LYoHQGPpXJ73S7XNzyhT6arWIE59loKhyhzbvp2vpryWcNnQKFMfBRg6FGbfLkIppl0ldAgSllr
 iC6dh1fufpjj6lf3qeIswJo8iqqkWbZHczgXwnQyOfKKtuxr2db/719oie57VUZxovMCCYqjysC
 jGwR7vjlhbhDq/YuG1g6aFoVa/zJaZMRcpGEqCQjJ4JkOHalCYagNbi7QrOIXT85HZV9INaFe/Y
 GY+uE7Ph4tz9MioGJc05IAarGZXiZzi2087AVdk4/rA3mqRjP8LwTbalumnbIc6QcGyIy5+aOT+
 jIFuNQZOUF/2P3MZBtk3grQrosioOniHe1Y0+1bQESS74opmJaboHf2m1NtPvKM+rnoA9lvJCwB
 1+hS6obOkSE7TYF+MKbQPjz9Rfjxrf90ZNgT//+2Pi9WKkZKUcOB3mZ6TzngWjNaNmxZbrluH+V
 ElxjR7Lbf71dLug==
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
Changes in v3:
- Added in some more missing v7 register offsets (needed by the usb3 uni phy driver)
- Added Dmitry's R-b tag to patch 7
- Link to v2: https://lore.kernel.org/r/20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v2-0-21956ae0c5c3@linaro.org

Changes in v2:
- added Dmitry's R-b tag to patches no. 1, 2 and 6
- dropped the duplicates of PCS v7 offsets from USB PCS v7 header, like Dmitry suggested
- fixed comment to suggest v7 (instead of v6) in qserdes com v7 and pcs
  v7 header files, like Dmitry suggested
- renamed PCS v7 RX_CONFIG to CDR_RESET_TIME, which is the correct name
- dropped the "_USB" substring from the include guard of phy-qcom-qmp-qserdes-txrx-v7.h
- reordered the SO_GAIN_RATE_2 offset in the phy-qcom-qmp-qserdes-txrx-v6_20.h 
- Link to v1: https://lore.kernel.org/r/20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-0-d9340d362664@linaro.org

---
Abel Vesa (7):
      phy: qcom-qmp: qserdes-com: Add some more v6 register offsets
      phy: qcom-qmp: qserdes-txrx: Add some more v6.20 register offsets
      phy: qcom-qmp: pcs: Add v7 register offsets
      phy: qcom-qmp: pcs-usb: Add v7 register offsets
      phy: qcom-qmp: qserdes-com: Add v7 register offsets
      phy: qcom-qmp: qserdes-txrx: Add V6 N4 register offsets
      phy: qcom-qmp: qserdes-txrx: Add v7 register offsets

 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v7.h     | 17 +++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v7.h         | 32 ++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h |  5 ++
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v7.h | 87 ++++++++++++++++++++++
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h    |  1 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h |  4 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_n4.h | 51 +++++++++++++
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v7.h    | 78 +++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h                |  6 ++
 9 files changed, 281 insertions(+)
---
base-commit: 629a3b49f3f957e975253c54846090b8d5ed2e9b
change-id: 20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-5ed528c88f62

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>

