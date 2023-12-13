Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDA281195D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbjLMQ27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjLMQ25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:28:57 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70691F2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:29:03 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50bfa7f7093so9232543e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702484942; x=1703089742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vMU6rrGmxgyuL5TMMGyP9RyaaPrkiegeHhKObIZg/xs=;
        b=GdA/WwQH4WSe7uaoF2YNOZnizmgt8DxQSZ/DDPP8JenTPCO4EkAHB4SLZkqL0SwZTr
         2PLe0gtPlmlk781UPcGsGlG5RUd81ekTqvbuGOsi0tbv3cX+Ev0QpM8fxiiku7oRfER4
         HjqXornI72XC6J6eX+/cm2q0HMKKaew7z4PGyoJZ5WSAjlPOoIRJOumB8VhXoEv1xPYQ
         aXTaK5v11d9bUWCP2F3mQMEDoZeEKaeAnmuf/bkgRzC6S0fidwZqq0YWfGIiLAwFWNam
         re69MmWw/iuNwTPiBIG6Zf4imyUgiBcNawBvzE/qDPsJILhsO18STr+WEE3j9e9ClyrZ
         QQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702484942; x=1703089742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMU6rrGmxgyuL5TMMGyP9RyaaPrkiegeHhKObIZg/xs=;
        b=PNeyBkhuBDTOWTzsAHlvQ09mtZlsvq2uIm7/IwV2nhNnNMUTxw2ncm2YgQNEjEYQse
         YU43kh5FLS+TikQfpiNOOvsXJWYXkB7QNu0untmtKGfBCXBvN6sPZhYQcGpQ6NPbDCT7
         4S/ZXZnt6ic1R4tvkwbiVcKG1Ko4lNHHu0kZ5n0i4pRA/OaEzp88Rs4NFriSVlbJthHA
         Eg1j6lz927AObkOet7SlTZ/TcSd3tIuKinxEfn1A7X+MQdc5MXkZcCckDMUonL+PPhwK
         ytnuku5ekIcybZniP3cw6gPrhsLRC552+ASJNyBGeRYY6aOlqDvfUpcYZOVeYufcY+mP
         yYRQ==
X-Gm-Message-State: AOJu0YzPGo4ncJEkOxUr4zqTVEVr1VqHAOkbZlU3weI+lgdcfU8ZLsZy
        FAx6dg+ODAjOu8oQYja30+skwA==
X-Google-Smtp-Source: AGHT+IFJu6vsF/X1yu3ijUE5ikBJmKtuP5O78EYgVqbIzMF1rD5Pj8yPIiXoKlW7GBWTwlov6p8k3A==
X-Received: by 2002:a05:6512:969:b0:50b:fcd4:832d with SMTP id v9-20020a056512096900b0050bfcd4832dmr3753987lft.113.1702484941699;
        Wed, 13 Dec 2023 08:29:01 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id br7-20020a056512400700b0050bfe37d28asm1641026lfb.34.2023.12.13.08.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:29:01 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 0/4] arm64: dts: qcom: few improvements
Date:   Wed, 13 Dec 2023 17:28:52 +0100
Message-Id: <20231213162856.188566-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
1. Previous submission included stale patch.  Resend without it. No
actual changes, but marking it v2 for convenience.

Best regards,
Krzysztof


Krzysztof Kozlowski (4):
  arm64: dts: qcom: sm8450: move Soundwire pinctrl to its nodes
  arm64: dts: qcom: sm8450: drop unneeded assigned-clocks from codec
    macros
  arm64: dts: qcom: sm8550: move Soundwire pinctrl to its nodes
  arm64: dts: qcom: sm8550: drop unneeded assigned-clocks from codec
    macros

 arch/arm64/boot/dts/qcom/sm8450.dtsi | 36 ++++++++++------------------
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 34 ++++++++++----------------
 2 files changed, 24 insertions(+), 46 deletions(-)

-- 
2.34.1

