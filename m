Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCAC7F9E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjK0LXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjK0LXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:23:30 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B7E187
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 03:23:35 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a00cbb83c80so565198766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 03:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701084214; x=1701689014; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d44z1h1bT1bhQtd4WwAauevoCZ3Q5jye8G6Ah/Qs6jI=;
        b=nYPy/wW4mu1Y16kYLAUM/le0OpLS9XN9EaPcVGAFxpCsQbPa3VGmSPAchPX66t5tSA
         x3GWw5K+wV0PKOAFlJdZstbckWZg1W0yYizGmsUAur32IYztXEEgD5JC7hPiBRlj2GtG
         LxV0DoW20H6BHjEw0ZKjQAntPbeUNp108+4Sn5hqtreuxs/DJSfZStPxvpb73fhZv1pj
         3B/+EAjmz7PTh2n8GNN+8937SVUiyfZNsRX8ecYjmSo+5z4qZC5f914XhnmLCESJI3sh
         FKq1wvj1bW7it/Wv+/Pd5X3i16zkpdLh6HOYX36oUw0wg/miojbsbNCCCxN9hXOEJsmc
         Ufug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701084214; x=1701689014;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d44z1h1bT1bhQtd4WwAauevoCZ3Q5jye8G6Ah/Qs6jI=;
        b=NNFc5QsKQPCeE1qSafd0IRMqemakrTDrhSH8l7VAdwfJbjefJSbFWk3W8cC2L2PKrV
         mvLQMj6+ePJV51bGunLexf7c6pPR85d07T9GWu8fAONRczUfdjTn0d9EjveMs6foYYlT
         vvgdn2odcdof5Twbw8Y9wRRFQs0/kKTmUgACvdRJbYN9IFJg2dNwtk6m8zRMxcR3h1c+
         IB8SMlT+5GkI2qq+Or8dGQCNxMTBUtoOSy1RrJGT3hd6nH2FtK7dfbQa5n2X2ArB+oTL
         7Hw+W7RFPmin+4nS8w/TJu7dDSCwiWjDd195Q8g8mCCNiZZi/zIjXPpKExr3fBcv1Nt0
         9xcw==
X-Gm-Message-State: AOJu0YzD2nXCd856znBw6nr9pD2bTlX4Jjss3FzaRYN2/YqY7z6MFZFd
        SySXg6ijt32JCmYisySa3QvCxg==
X-Google-Smtp-Source: AGHT+IEW6wH0NXZPQk0NoWl3zNMjHId/m3KldKL87Hy84mY208B+/iWk0nOF803bg9ww6toPLn+UbQ==
X-Received: by 2002:a17:906:eb17:b0:a01:fc1b:8197 with SMTP id mb23-20020a170906eb1700b00a01fc1b8197mr8471966ejb.62.1701084214110;
        Mon, 27 Nov 2023 03:23:34 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id oy9-20020a170907104900b00a0db5da857esm1804866ejb.217.2023.11.27.03.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 03:23:33 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/2] RB2 bluetooth
Date:   Mon, 27 Nov 2023 12:23:26 +0100
Message-Id: <20231120-topic-rb2_bt-v2-0-4bbf266258ef@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC58ZGUC/3WNQQqDMBBFryJZNyWZVrRdeY8iJRNHHZBEJlZax
 Ls3dd/le/D/21QiYUrqXmxKaOXEMWSAU6H86MJAmrvMCgxcrAWjlziz14LwxEW77oq1Q1+Vpld
 5gi6RRnHBj3kUXtOU5SzU8/toPNrMI6clyudIrvZn/7yvVhtdmluHQFBTZZqJg5N4jjKodt/3L
 /uTXnq+AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701084212; l=856;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=oI0K5ZfATIrWRqPu/SFkGRDYdYA7+Hkr/7BgSVvWH7A=;
 b=rQy+D3F0dcbRbnZeWe7VPkImWt+4EtIm9q2+CzSbdDf25k3mHmInbJvoWU1jZ3WmFqypJ5fVj
 JCssj2pi/dtCLTe3FiwTQW70QZZc5InLLJzLdOX74tjkG43UlRDaWFE
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

The bluetooth module on RB2 seems to work ootb with the WCN3988 setup.
Enable it.

Scanning for devices works, couldn't test pairing on a remote board.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Set drive-strength on pin configs
- Link to v1: https://lore.kernel.org/r/20231120-topic-rb2_bt-v1-0-509db2e28e70@linaro.org

---
Konrad Dybcio (2):
      arm64: dts: qcom: sm6115: Add UART3
      arm64: dts: qcom: qrb4210-rb2: Enable bluetooth

 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 87 +++++++++++++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sm6115.dtsi     | 30 +++++++++++
 2 files changed, 116 insertions(+), 1 deletion(-)
---
base-commit: 8c9660f6515396aba78d1168d2e17951d653ebf2
change-id: 20231120-topic-rb2_bt-ad4b8abc750f

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

