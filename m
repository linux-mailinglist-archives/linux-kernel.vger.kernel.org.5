Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D7C770968
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjHDUJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjHDUJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:09:16 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30009E72
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:09:14 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9a2033978so40157771fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 13:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691179752; x=1691784552;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i+ZdmQe2vjcw9gjPv4iQjRIm3FBr/PMEmSD7gYRuQwc=;
        b=hcinsQkuFtpLJ9xV4fFj9cY0ql+oBRySikeZGQ8E31nfuPFd+r4JtO1kn/PIYjwNz0
         rm0WKUO5Fz9/1SiGWi7qzv5SCfZIKM8RK3IFtbW5PIzyjYSsBewr34R9hPk/j127Z7mO
         ViEEEcKnDO2euFPHvPDu16wTfbixnm4Mg3V9uBFnCGfWBF/FsOuUKgxhDBaHu0wSFOyE
         74kn03HtLmZPf9oobD28WJa2/Xn0qp7LiXgrtKALlNMv3eeg484dO+PN4/Ui6ecPuRXa
         YPrJUzUMrblsRgvwhfhvfsFkgQY9ZDBWhEs63fdFcIcJpeQoHn1GQzK6l5yxkksN20lp
         Nvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691179752; x=1691784552;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+ZdmQe2vjcw9gjPv4iQjRIm3FBr/PMEmSD7gYRuQwc=;
        b=WgXq0sSS8fHtaFJd5uvhXo4raeub/fMTyKa7LG7BbjmDaoTqTS0cdihlf/wAqg3F/D
         dwljRWGGuhKgap0/rck+s+u2nvRjGzOXyMJVuyGNNURgknfUutp3rthONRRggNVleQOL
         DikFte2B2OJX4KKsh/dPKx8UrKS/BR9R08qa2gkA2cMlEZhsWMcrSucfUwvEjwCBMAWg
         X2zrfo/VIXWLJmRgnRJ/B1oxfNos8cUQVuo2ZUrFu6S78Axx3ZPiaZvs+gLyqsBK4jGe
         EM2/9/cssE9gjZHXD0S+fnUNVB+J4WAK7dfgqj5s5Z5FqVFsR23OChwxXHNcNDtMM2Hh
         GByw==
X-Gm-Message-State: AOJu0Yz19fPvmWH43FR2Ud6oGjEj3JZVAOwQIpFFvR8TRFeh3LsICW9d
        XORcM4fuxtBJcby9Myb2qDSOdg==
X-Google-Smtp-Source: AGHT+IGbZyh6qA34iNgBp8oFYb6AJZhXUvEDwUt3b8rkf3hwhTNMR/FSJMsQs1eZ2IG5rP7u2tPKNw==
X-Received: by 2002:a2e:3219:0:b0:2b7:4078:13e0 with SMTP id y25-20020a2e3219000000b002b7407813e0mr2238879ljy.43.1691179751569;
        Fri, 04 Aug 2023 13:09:11 -0700 (PDT)
Received: from [192.168.1.101] (abym15.neoplus.adsl.tpnet.pl. [83.9.32.15])
        by smtp.gmail.com with ESMTPSA id m8-20020a2e97c8000000b002b6fed37b18sm580048ljj.101.2023.08.04.13.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 13:09:11 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/6] SM8350 and SC8280XP venus support
Date:   Fri, 04 Aug 2023 22:09:07 +0200
Message-Id: <20230731-topic-8280_venus-v1-0-8c8bbe1983a5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAONazWQC/x2N0QqDMAwAf0XyvEBtmZb9yhgjdnEGJEozZSD++
 8Ie7+C4A4yrsMGtOaDyLiaLOrSXBspE+maUlzPEEFPoU4ufZZWCOebw3Fk3wzxeQ0fcx0QdeDa
 QMQ6VtEwe6jbPLtfKo3z/n/vjPH/wy7qIdwAAAA==
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691179750; l=1206;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=AzvGjZWLIrTWpfIVnfz5gbNYaA+bZzT3svjy3XgECbI=;
 b=0E0tvMR801ggIH4I124z4f5XNPnjOBBR8BGs/LZAiTZvgfA4g2KKXac2YPpEBiF4AJQXNycOg
 pQb+63s7PKNCAd++C8WMpzuOV2PEzOBfO9w7eONj+U2+/3YLWThY5K2
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM8350 and SC8280XP both implement IRIS2, with the bigger SoC having
a bit of a beefier unit, capable of reaching a higher core clock.

Rebased atop Stan's venus-for-6.6.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (6):
      media: dt-bindings: Document SC8280XP/SM8350 Venus
      media: venus: core: Remove trailing commas from of match entries
      media: venus: hfi_venus: Support only updating certain bits with presets
      media: platform: venus: Add optional LLCC path
      media: venus: core: Add SM8350 resource struct
      media: venus: core: Add SC8280XP resource struct

 .../bindings/media/qcom,sm8350-venus.yaml          | 149 +++++++++++++++++++++
 drivers/media/platform/qcom/venus/core.c           | 119 ++++++++++++++--
 drivers/media/platform/qcom/venus/core.h           |   4 +
 drivers/media/platform/qcom/venus/hfi_venus.c      |  15 ++-
 drivers/media/platform/qcom/venus/pm_helpers.c     |   3 +
 5 files changed, 279 insertions(+), 11 deletions(-)
---
base-commit: 210fefeb11b4bf5d4c5597f126425c2d3fea1aa9
change-id: 20230731-topic-8280_venus-8f506ae723a6

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

