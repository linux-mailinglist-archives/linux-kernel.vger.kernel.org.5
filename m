Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEE378E155
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241137AbjH3VUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241104AbjH3VUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:20:44 -0400
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE25CC2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:20:10 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-500bbe3ef0eso116815e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693430034; x=1694034834; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sB4LTQroQIGZnNvkckG2TO4c/EOlTMJPaJP5M9r0cjY=;
        b=LXHU32mSkBZKpFCGiIEDZTjwwdURuQ9WqDUK6HVmuR/VyPshPUGAsalazhI0dlFNfw
         nlr8EQaNWzhSCc6fRAcgZJ4rPqd/qtKNK0NgUEaP1fCTp/7SKTvro9bpukvrF05qtMNP
         LyQqHYeO79ejmQN1XE7xegtb5uLL6QeoG0kK7Wea+fGUs/5ulNoCwsvtSMoWGpdjG/9z
         70fUnLkQboztGVYDOXF15sSTC8zPBiu8mOYZ4W7Gl4ZFWGxqGi4iUkHHy5ygfnu35GD7
         8v1O8XI8i89MmwAef/fW6Qba6RJLF5ldLQ2jc/TtIiovaAxrI3R8bb1Wh47eva6AbxFe
         KoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693430034; x=1694034834;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sB4LTQroQIGZnNvkckG2TO4c/EOlTMJPaJP5M9r0cjY=;
        b=Yyy0SrbxC13Z/7+BuzOMS1vsdSaexGaxX6XdPlBAHX4lbpmxUblDriZUYzRs9MVp/y
         Y6UvUNRcL1MfvvjIZSxANQcGF9WUBFA1Nta7fvv3n0EpvpAWJRIftGAPFnZwvNh8ugKy
         z70lTnYLfqlzg9sgQucX439O+PoEw2KD6tD18PsdyJqfsbr3mDyLv21eiHxclqsIpGqy
         LrOxvyrFNUYMb73tmdfXjpXTlkBMFKTELhfBPLvm81nfyr1OgX65rPoumxkql7ho+2OI
         nFNMbz3F55PlQXJykpMF2RirDOyAHHFaAAkZSWbwDtN0CRWWqVxUM6oEoQwPj995UAaF
         cD9A==
X-Gm-Message-State: AOJu0YwJmesprp45WcYjBtXjLy/HiJJwoq52n1gaDxUwzbcxYrmaD8jN
        x4OGwaE0iOXs99Ma2iHEdjZcLQ==
X-Google-Smtp-Source: AGHT+IHH8z5u+wFNCt7HFZifQcuML8FzOtVdrPCQzrgiEVU88nCH/TpoI+LrP5n+nExQGynp3QOA5g==
X-Received: by 2002:a05:6512:1305:b0:500:ae25:cd46 with SMTP id x5-20020a056512130500b00500ae25cd46mr305523lfu.11.1693430034380;
        Wed, 30 Aug 2023 14:13:54 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id b3-20020ac25623000000b004f37bd02a89sm2516351lff.287.2023.08.30.14.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 14:13:53 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] FEMTOPHY REFGEN regulator
Date:   Wed, 30 Aug 2023 23:13:50 +0200
Message-Id: <20230830-topic-refgenphy-v1-0-892db196a1c0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA6x72QC/x2N0QqDMAxFf0XyvEBXBct+ZfjQZpkNSCytE4f47
 wt7PId7uCc0rsINHt0JlXdpsqrB/dYB5agzo7yMwTvfu9A73NYihJXfM2vJXwzk4xgSDQOPYFW
 KjTHVqJSt08+ymCy2l+N/85yu6wfxVjS9dgAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693430032; l=674;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=WB4bhWM031cMBzGe9vpFJGgvxxhPlYOAzO/I1MMx46Q=;
 b=4apGHqCzc+krs+LpAviYiZ40vIExSBHGwta/L37TDxa06T+G4bYYPCfs3iM5DDLfQakdafVDV
 XbWkSJ5dl5ACs744bdhPtiHYTHMZV84Oc8KZGzbOqRTavLvkRlV7gZ2
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FEMTOPHY gets a reference voltage from the REFGEN regulator.
Make Linux aware of that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: phy: qcom,usb-snps-femto-v2: Add REFGEN regulator
      phy: qcom-snps-femto-v2: Add REFGEN supply

 Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml | 3 +++
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c                     | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)
---
base-commit: 56585460cc2ec44fc5d66924f0a116f57080f0dc
change-id: 20230830-topic-refgenphy-8c2a78bc44e7

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

