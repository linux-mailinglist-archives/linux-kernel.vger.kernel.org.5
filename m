Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0028B78CDF4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240585AbjH2U7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240579AbjH2U7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:59:31 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08261BE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:59:22 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5007abb15e9so7628058e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693342761; x=1693947561; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tZtGJPMqA3+qy7SC3bVVwrx8Hadb7bSfghlu98ga0vU=;
        b=uBNdEZ+FDtQub/TQpHTcPNcjLv3MDpvGrVTk2yY4QpMJwJEdeIuJ78s15P+3a66Wje
         0LEhM3HBwDguFvjBCWXiwWQFWw8BjYFRbFKeYKAvrAuwxr5FmSnS5Nzk4DU7HOP1+gpt
         uxGbfh7paCBrBgHdsvMtVU3yhUmfMUMbx2D8YcomIFOcl7/MQzvFbjtAQdzyflDj5kFL
         xbTNfbso8UOAC1hdaHpgIBntpsHQTv0J3UHYrD+IEjgeXpLZpO0LlZGhNjd7z2y3Il/k
         cMbtFra20tD478+5MDyEI3RpDUde3+J0jUQH++C33oqInMPALkTNjCtBYWlHJLo2bh+A
         h6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693342761; x=1693947561;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZtGJPMqA3+qy7SC3bVVwrx8Hadb7bSfghlu98ga0vU=;
        b=f178bxLxFoc4KgHxgGwiKG96W42L0bedeMQBpSyjIsI/HLkNS1Pbogv9JqoR0VcZvY
         XkgJkaGbWb1VMcwePpwFk+ybHVj8cJDaCqtUYmKvukNxaxty6fSkq/KjygpBnXvRVw4I
         GWPKaJmXTbrHLajvn4UVyoHIL0vUTlYE5+6mekTlv+JE4heUZmuAFRxFeR6/HNahKMs1
         w192gi+eIIkkAtYVVaknUUfAvqiT+8Y+/GNqR5372M1SzK1cfmVWyv4KXRVkKqHOTmCE
         oZpU7o58tliUh9mgsseFEoi1jzqAj/b30N24kePFb1uVh16pPcqjHO/Jt2nr5JQDyz+u
         PyPw==
X-Gm-Message-State: AOJu0YwdwadjVn+N16Tn/D5zTukiLxduSpa25I512YHce9O37wl/BGJ8
        z7N0zzl1iJW7jpVa4AdGdZeTig==
X-Google-Smtp-Source: AGHT+IEcdMrmJxE2aJj/jV2hEqio6NzYH0SNelvPC/jDlyK4JlIHA3ikCuV+e47VYI9y9Mps5r8bdQ==
X-Received: by 2002:a05:6512:5d0:b0:500:9ee2:15f with SMTP id o16-20020a05651205d000b005009ee2015fmr42215lfo.46.1693342760949;
        Tue, 29 Aug 2023 13:59:20 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id q30-20020ac2515e000000b004fbad09317csm2074025lfd.189.2023.08.29.13.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 13:59:20 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] 8550 USB QMPPHY fixups
Date:   Tue, 29 Aug 2023 22:59:03 +0200
Message-Id: <20230829-topic-8550_usbphy-v1-0-599ddbfa094a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABdc7mQC/x2N0QrCMAwAf2Xk2UDXsrn6KyLS1swGRlcaJ8rYv
 xt8vIPjdhBqTAKXbodGbxZei0J/6iDlUJ6E/FAGa6wzk/X4WisnnIbB3DeJNX9x9P3sxnP00RF
 oF4MQxhZKylqWbVlU1kYzf/6j6+04fivHdst4AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Adrien Thierry <athierry@redhat.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693342759; l=767;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=LZ6XZ3mggyAs4bqjIFE2iaDrGjBXBRUJrIRgbaHBbA8=;
 b=FI1L+7AsJ4F9NBPyc6tx/PIqm34odB1VlyqcTI1V8LdnlGhYs+EBkPnoM/6jEoj8VhGhCQJ69
 h45wQOfvihhDJ/TdhOXG9hIFOpq6rqcJEj9c9n6LnZPtHByXf7RUCCE
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inspired by [1] I went over the 8550 QMPPHY init sequences and found
some inconsistencies. This series attempts to fix them.

[1] https://lore.kernel.org/linux-arm-msm/20230828152353.16529-1-athierry@redhat.com/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      phy: qcom-qmp-combo: Square out 8550 POWER_STATE_CONFIG1
      phy: qcom-qmp-combo: initialize PCS_USB registers

 drivers/phy/qualcomm/phy-qcom-qmp-combo.c      | 6 +++++-
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h | 3 ++-
 2 files changed, 7 insertions(+), 2 deletions(-)
---
base-commit: ae782d4e2bf53b0b642ae860794f7a39470f995a
change-id: 20230829-topic-8550_usbphy-691f367b9b3e

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

