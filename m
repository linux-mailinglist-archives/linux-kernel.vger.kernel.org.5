Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8EB7FD9C7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjK2OlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjK2OlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:41:00 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFA1D65
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:41:05 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a013d22effcso920280966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701268864; x=1701873664; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LMoxKGnJmIGZfkHJ0E+5YEBeUlZH7zeNhRCLk2Cz1pw=;
        b=tF8eLQM4U8+pXxKVhYrxrejm+W2m43XveXmFIomUv4/TeZZ0mlHgJKU5ovES90X5dU
         wpQsSJzpWq8xX155b4jPpSNsRvZKKlN6TtlzTYa0c0tTA+l0Yumw4ee4EE+x2TtBVv94
         WodZjZhfFpcQae2eFWhRTeYiGpe3JqvL/Aw6xWdf4CP4ZBhqnats2fkeLEEgELC+Y2Xb
         PsxalQNmHbGJCFWigslGTqTpciitPu/AoF4ir6ePsHVKGh3y6K2phrrHLGSQKEPBR5Bh
         fLAt7x6Iie/2QfPXSZU0yzhQGXGpfzausOqXmTmrKfjANTfjuUtbvR2VJTqUuIbR+gcr
         Vm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701268864; x=1701873664;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LMoxKGnJmIGZfkHJ0E+5YEBeUlZH7zeNhRCLk2Cz1pw=;
        b=fUPs0AehC7C6Yy7wpBwQhyxNrAc/6byrPr0Z+qcoiIApOY5UfCnN07WA6WmUOs2pxm
         LbcI6S3p47Kcec82m8q0Qx4pyR418kXQfDL5sInhRNRKw1pZCWVR9IExlLe7qjLhx+NK
         otZszK6UG4ZLWba8hiwyS1A3MVyh7Cp5AsPUnNrhnCmC18AMnG1hWXjvC1ir0xHY9CeE
         3BiN7ptnNuwAe5Jen1E2LNRw3ubzF49thREQS70GlNpIBD2nQsEvvPTNFR4n7qa1w7FT
         9J5XCjnive+nbanQ0mPDqv2Dw2fucbR1l29yMeKyyNbnE7PLVHqLIsN77r8gcajkfcno
         LkRw==
X-Gm-Message-State: AOJu0YyC3H0M27/99OMDQ8lKAqIQD5NP9A50qFuJP93qa9pOGsLZJK7M
        5q7k4gZtXX2f4DXgo1iqJG9AWA==
X-Google-Smtp-Source: AGHT+IHtZWKqnALRv6XH1XM5IA6QLLyVhZAx/wZiqDeiiFlMfoihiNp0TV6mitiWZ5KIYlWQk9GYNQ==
X-Received: by 2002:a17:906:d4:b0:9e3:fbab:e091 with SMTP id 20-20020a17090600d400b009e3fbabe091mr12145976eji.15.1701268863769;
        Wed, 29 Nov 2023 06:41:03 -0800 (PST)
Received: from [10.167.154.1] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id s21-20020a170906285500b00a0179ebc25esm7965638ejc.85.2023.11.29.06.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:41:03 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 0/2] SM6115 interconnect
Date:   Wed, 29 Nov 2023 15:41:00 +0100
Message-Id: <20231125-topic-6115icc-v3-0-bd8907b8cfd7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHxNZ2UC/32NQQ6DIBQFr2JYl4aPQaUr79F0AQj6EwMGLGljv
 HvRXRftcl4y8zaSbESbyK3aSLQZEwZfoL5UxEzKj5biUJhwxmsALugaFjS0ARBoDFXQtU7ITir
 XkuJolSzVUXkzFcs/57mMS7QOX+fJ/VF4wrSG+D4/Mxzrr3wGyqhTAgzTQjRG9jN6FcM1xJEcq
 cz/6rzojRyYGCTrWtBf+r7vHyViF6v/AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Konrad Dybcio <konradybcio@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701268861; l=1565;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=MX9IDohAdLeqrMZe7B3DDkmX0lHf4lB2uYiaw1SW1iI=;
 b=OQFeRKLny/MJaXzmEndsYyPc+1Zg5UKcwChXoiOM1rPKhb7G7Qo2sxFd3mDWMClZEUOK45MsZ
 jbSpN+PPraNCeA2X3rpfb/AkGQgLfXPwIRFsepcN7/xfsSzn9pUk43z
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it says on the can.

Georgi, Bjorn, can we please set up an immutable branch with the bindings?

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v3:
- Actually define clock-names before using it in conditional blocks (oops)
- Link to v2: https://lore.kernel.org/r/20231125-topic-6115icc-v2-0-69d05d90871b@linaro.org

Changes in v2:
bindings:
- Remove unnecessary '|' after description:
- sort property definitions in a manner that resembles their proper ordering
- define clock{s/-names} before using them in conditional blocks
- drop unnecessary allOf:
- move unevaluatedProperties after the conditional blocks
- disallow clock{s,-names} when unnecessary
- fix up the example
C:
- Apply my own fixup (ebi channel configuration)
- Link to v1: https://lore.kernel.org/r/20231125-topic-6115icc-v1-0-fa51c0b556c9@linaro.org

---
Konrad Dybcio (2):
      dt-bindings: interconnect: Add Qualcomm SM6115 NoC
      interconnect: qcom: Add SM6115 interconnect provider driver

 .../bindings/interconnect/qcom,sm6115.yaml         |  152 +++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/sm6115.c                 | 1427 ++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,sm6115.h     |  111 ++
 5 files changed, 1701 insertions(+)
---
base-commit: 48bbaf8b793e0770798519f8ee1ea2908ff0943a
change-id: 20231125-topic-6115icc-a187f5989af7

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

