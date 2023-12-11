Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B42380C469
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbjLKJYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjLKJX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:23:59 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4040BF5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:24:05 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-548ce39b101so5954368a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702286644; x=1702891444; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n6oPnCa6DBd3f+98xEuauxtAQ1S8sjdrlrHr9RLCgoc=;
        b=S3P3i2nW/PzkYyUhyscxVrRRRNPniGFuPVnWaRkF+99ZXAeVo8U6uZGflK/hSxP2xv
         zhK1Oz5NSZgaWhqGmMrXwyTtDkTeTNPBSr2ZWRHWvenSadTvVQuGj9eiwyI9AQUqbZRV
         UZ3bJJb2/FjbN+EZDB8Qcex6y47Vt3pMKylrzGGpRrGTU5ADBT983h4t2v8qSlJfILDg
         pd5UGKXTvpVzQ72sQkHzct8SxVbD/6Mm446tzPbZzbu1rBcpDV2FrN2/1nz+n6CjPrZa
         8apumfPRpUIvJCazJvaxCi4OagqexcMZwufhm6aUjiyPWbQtTd4RtrG6nbcplG70OPGf
         D3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702286644; x=1702891444;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n6oPnCa6DBd3f+98xEuauxtAQ1S8sjdrlrHr9RLCgoc=;
        b=Ig4lYsYoiwoBVTlOv3A0hrsYg6kf0mfw2oKsW3eFETFzc0NN17Mf3NjOBeah/UMvT3
         CivuhpMtJVuYNUWGPzx38B7RnDGzTDM08JghubMysXV7feWsmUiKz+Q5Fa16wC1UTK5I
         XVCVg/2GSbq1LmuSwfuotlFzfh+WDLn2aT+MhnsD9Nl+P340RTkr+eBwYzK0aBedX0jN
         7rFdQzRBkmOQdHLTEpfzBqZKigl+QQctttsFxnJnYPDz4fbzaNmvYf/ETftktojt9exj
         zY+TB1iCr9JC4M5TqJDzHXa+cbfFSkJH5Uk2B4FhA49MObOhwQWiUPROuDlj49N61zth
         QMpA==
X-Gm-Message-State: AOJu0YzeAexL09hitV+L3Nuoq6I6OJHEJ63tf9ffzp0ddohNTbNgX0VM
        BOqhwf73XYSfpeecsRq6mvKPUqxfQ37xGMEaeBc=
X-Google-Smtp-Source: AGHT+IGgfdy95mNKY3dcynCeXmQN85L2HtJqH+pLYpK7S/8dLAYGnPh0D4hxqe5RKWN0arN/imiGYA==
X-Received: by 2002:a17:906:7f90:b0:a19:a19b:422d with SMTP id f16-20020a1709067f9000b00a19a19b422dmr1161332ejr.152.1702286643623;
        Mon, 11 Dec 2023 01:24:03 -0800 (PST)
Received: from [10.167.154.1] (178235179179.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.179])
        by smtp.gmail.com with ESMTPSA id tb21-20020a1709078b9500b009ad89697c86sm4570248ejc.144.2023.12.11.01.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 01:24:03 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] Enable interconnect on SM6115
Date:   Mon, 11 Dec 2023 10:23:57 +0100
Message-Id: <20231209-topic-6115iccdt-v1-0-f62da62b7276@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC3VdmUC/x2NQQqEMAwAvyI5G0grW9j9inioMV0DUqXVZUH8u
 8HjDAxzQpWiUuHTnFDkp1XXbODaBniO+SuokzF48p3z9MZ93ZQxOPdS5mlHCpRIfEjEHVg1xio
 4lph5ti4fy2JyK5L0/2z64bpuLEHcs3YAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702286641; l=973;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=tmsSXzF1KmW91De4zWGI6eXCqf+wYJAGd6SC/NqLLho=;
 b=eFsjoUSM1mxD8XDpzXhccY/co+PmWuuma5IMOq5vVzDBMlkYUsSrVMAZwcrqtqbhojfrgbRW+
 NIQBQwnkEG5Cps5M01s17AGP2BNwcjzuWtTErvTi3NbqEFQPIKLafRm
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

The SM6115 interconnect driver has been merged now. Add nodes required
to make use of it.

Patch 1 for icc, patch 2 for qcom.

Likely depends on patch 3/ (qcm2290 BWMON compatible) from [1].

The required bindings changes are available over at an immutable k.org/
djakov/icc.git/icc-sm6115.

[1] https://lore.kernel.org/linux-arm-msm/20231125-topic-rb1_feat-v3-3-4cbb567743bb@linaro.org/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: interconnect: qcom,msm8998-bwmon: Add SM6115 bwmon instance
      arm64: dts: qcom: sm6115: Hook up interconnects

 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |   1 +
 arch/arm64/boot/dts/qcom/sm6115.dtsi               | 277 +++++++++++++++++++++
 2 files changed, 278 insertions(+)
---
base-commit: 206dd8f44be8930e25cd6c82873f21ae659abec9
change-id: 20231209-topic-6115iccdt-060f0e26f0c3

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

