Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EC1800C8F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379035AbjLANur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379065AbjLANup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:50:45 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850BE10F8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 05:50:50 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b4d9e81deso20586765e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 05:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701438648; x=1702043448; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rYNGk6XZtcHXeUZQI4MtfBcpoSsmfJQ07T1mNJVJxmE=;
        b=Gmu68VdiFGwG/DzvtNY295z76IMohwDGgxPlwWeRAh8tpKkRW/fu1yLgXh72l3SwJn
         m4pdGYltx3N3P6eHLt5NcrSutlFRt29MY1ldRS7p999/IgOmt2xVaQ2MV70Jr4HH+pKf
         P6V1au1uzmFEUq7e36sv4MCyINwwnYGhQrY7LQAqwcNRPCrPzyuc2pkh5R8VYxeiY0fd
         hgEIlwOnRrg4HEAnTk9JnJitRZLcn4nZeOCjSEdKFoxTSUXlG5IEQyMiICkP3u2jIfqJ
         V0XiLgPj1SO/2KnmR9N1Rsry18yw/eXISk8pm+b12epwj8BW6wec+LYG9pmIGcCpOkyg
         kCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701438648; x=1702043448;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYNGk6XZtcHXeUZQI4MtfBcpoSsmfJQ07T1mNJVJxmE=;
        b=EvdQhXie46eoBB7eh1QoEE39xpA5nYvYwSoQOVlalQ7kAVGXp2ArAINeeURHINZzrP
         rg9OQRwSVSpgKeFw/TFzZeMMwreVxj8YJX/Xj2+ljkRpYu1VdPuT5HxLxUdgwlQTkNxW
         OF1HA/PzNyemK9Y6eROBjD1yeq+mOaKlHvWNkdfJkUkUeSrVaE0uo6ITxjbd2+0xW6AB
         NuGPihF0NpAwbKp0Dqu71uniJVerWwzEXgDq6RKKPSDpghiC1vMzo26tsO0B+rQF/2Vt
         41vWYM6qTeQPh3NGrNUl8WA6VJXfrF7FGBs3GRqrr6Wl6H/2BANxthhVC4Bnr3/r0/ml
         XN0A==
X-Gm-Message-State: AOJu0YzCXiEzfTv6U8/yut5O/mBV/LHH8N0oJ4N/CTbwRQHJtRqFO3wh
        BdsCB0bAMJcQ6cDotfX6qhXqLEGO3DoAqCfiGRg3jQ3L
X-Google-Smtp-Source: AGHT+IF5X73Zh5hiFUO8DhLM8nRT5it4kNvMhJaTUK9MQ7BOjaGp2a4L9MusWA5BnHvvvMNDPj+WTw==
X-Received: by 2002:a05:600c:3ba9:b0:408:37aa:4766 with SMTP id n41-20020a05600c3ba900b0040837aa4766mr437099wms.5.1701438647868;
        Fri, 01 Dec 2023 05:50:47 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id s8-20020a05600c45c800b00405c7591b09sm5539942wmo.35.2023.12.01.05.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 05:50:47 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] arm64: dts: qcom: enable IPA on sm8650
Date:   Fri, 01 Dec 2023 14:50:40 +0100
Message-Id: <20231201-topic-sm8650-upstream-ipa-v1-0-7e8cf7200cd2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALDkaWUC/x3MQQ5AMBBA0avIrE3SVgmuIhZVg1mg6SAScXeN5
 Vv8/4BQZBJoswciXSy8bwk6z8AvbpsJeUwGo0yhtWnw2AN7lLWuSoVnkCOSW5GDQ1XbwRpfTo0
 tIPUh0sT3/+769/0AryuhemsAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Alex Elder <elder@linaro.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=rGIgscOjbmks/az7dqZuSI2/UjBmJOrXf0Dv6ltyXJ4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlaeS1zlexurgi/SMzNem9W/9mALN+EfSs9EcwH8Ed
 7IApwJKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZWnktQAKCRB33NvayMhJ0arND/
 4iIadXIDuMqu7Y5BrA2mMa6kpAZDu4hX6PmWGaJ+KNCgzEX2w+8Ug9ntNlV3FPar+eia3+4zKigCQu
 ggTYb/ein5jOY/T7aNPJPeMShyHOEB2I6D3FVDa2XKq03yNMwrWaLgVjqPxuRMXGfza4u3Md+DWo9I
 uhZAIkfqW29Qrz4pay7E71B8KTKcYLoRQiKxqtMkAO0DjNBM/49EkhwD9TD3PQti82rC+4I8ELjnej
 chLUl7nTaoh5hH1J8/m46dMBOp6tE45B/dPs8G03oATBxhJDvZSZ1JJaneO2rXjw2aelY+U9D3xQvo
 +sWn4DukeAt+jZgu7/jT2ja1LR65JOep4MXXP7OV5MsyNTGM5jkzHLLTHH6VHahOi/AEDSD/cnIx7s
 4767Hw1+omtLNBDXv8yeVECnEJ0zEm3t/cl29saMWkOuiCqd5ctna7AcfhnHhVHgzSq2E87/kLdK6p
 ltAeyBA8bObbmfB7MoOBGg19m55ZiTeKrUZOqesxAmGVsqJmzj3W5BaDAfUdM4yRBf5H1SKUUIkK3Q
 hzijH1JiMsz7NSBsCe16q1Yf6RoXu+adkI35xupwxu8ib1caXf57o5dRPwpqdl4/JhviRveqDmcjGJ
 lC6LHS/eBu3VFCz72M4lR52B6nJVRgho3gq+66dflQAztFypeHyMMtZPFvcw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the basic DTS information for supporting IPA on the Qualcomm
SM8650 SoC.  Enable IPA on the SM8650 QRD platform; GSI firmware is
loaded by the AP in this case.

Tested on SM8650 QRD:
[    5.764240] ipa 3f40000.ipa: IPA driver initialized
[    5.787438] ipa 3f40000.ipa: IPA driver setup completed successfully
[    7.446693] ipa 3f40000.ipa: received modem starting event
[    8.413152] ipa 3f40000.ipa: received modem running event

Depends on SM8650 Initial DT at [0], bindings at [1]

[0] https://lore.kernel.org/all/20231130-topic-sm8650-upstream-dt-v5-0-b25fb781da52@linaro.org/
[1] https://lore.kernel.org/all/20231129-topic-sm8650-upstream-bindings-ipa-v1-1-ca21eb2dfb14@linaro.org/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      arm64: dts: qcom: sm8650: add IPA information
      arm64: dts: qcom: sm8650-qrd: enable IPA

 arch/arm64/boot/dts/qcom/sm8650-qrd.dts |  7 ++++++
 arch/arm64/boot/dts/qcom/sm8650.dtsi    | 39 +++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
---
base-commit: 25cb94419a71435991cc8844251ffc0194f4dc8e
change-id: 20231129-topic-sm8650-upstream-ipa-084b42c5f943

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

