Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7DF7CF5BD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345230AbjJSKuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjJSKuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:50:22 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6018C124;
        Thu, 19 Oct 2023 03:50:20 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40651a72807so69764125e9.1;
        Thu, 19 Oct 2023 03:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697712619; x=1698317419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=C+gbCa2csUvJih5CA9T+IQ2LilG5fw1D7E53qTqhBP4=;
        b=QMDAS958Eqejyl7NUWQCplOrmHYKGMBHrRSFMENdJVF73ijRH766H+UYo0Gl/v77E/
         E/P8ePTOgkf8i+tylxBcFyj9faDRgHNNlh5ePjE371hWsYUGrB4W7P7Ft7vvXq3kB4I7
         O9F4oKpj47gaq6tu65XWiq7WZ9XYlFDyCrynt+JvByrZr+RntiHzpq/tWt5sbRn1YPk5
         gBYQZowtKDpzFmgC4zB0Alo6G969lsj/jQefl9XNcHCT3LOHyfKrGUM7m2cbno09yZkz
         8/EOrrYPEG7jRLsnKJLeEaUlp6SgQ/sD7dBv7uXug+T677Ph+SwfYD3r93AnrdCP8gNe
         J2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697712619; x=1698317419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+gbCa2csUvJih5CA9T+IQ2LilG5fw1D7E53qTqhBP4=;
        b=YtApKpGcLYAuzaesDYkYnJ2jpoUZS9pz7RMWknAek1e367tyZ6Aecw9tCAnkgXmBme
         UR7wI1bz17PY0mEEwMr2aEji9lvUBeK5arqO6I4ymIOxeGsrW+2Tj9o5vVTd0mhGfEQJ
         sum7NuWgHsakFcUQ9IezirdnAM4osoxr6WQ6F56Ti4KMQHbdExIyrepwm+uUmSa2hbAR
         auWj1K9WpRyVVt9O36fLhO7L4NrmgaUGqqSLF+jViqwqIQx0d2FfIhZLKyQEP0WEV/+V
         LJuIjNxlRlzMZZu8lso2meDkGfAUf9kdw1yf6QRBKIvtDT6rp4DcwuRhDDfETekV8qwm
         mNvg==
X-Gm-Message-State: AOJu0YzJ7FXUalizTL0Gic/Xi4xdSfnz1uU231UcEDEWA8F6H9jfCD5j
        L8SbnzomolCbiUwjroFWwSY=
X-Google-Smtp-Source: AGHT+IHshRj6/WXC1joXHU/5NyDhCj+tliFtEYIhOvJ5HJ3v39ftN4kN6kjASckIxvWmMIesZdV8QA==
X-Received: by 2002:a05:600c:1c85:b0:407:5b54:bb10 with SMTP id k5-20020a05600c1c8500b004075b54bb10mr1612242wms.8.1697712618388;
        Thu, 19 Oct 2023 03:50:18 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id bh9-20020a05600c3d0900b003feae747ff2sm4129511wmb.35.2023.10.19.03.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:50:17 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v7 0/4] cpufreq: qcom-nvmem: add support for ipq806x
Date:   Thu, 19 Oct 2023 12:50:07 +0200
Message-Id: <20231019105011.7289-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series originally added support also for ipq807x.
This part was split and is now merged.

This patch was originally dependent of [1] but was later reverted
due to compilation problem. [1] had some changes that weren't related
to the compilation problem and were just a fixup.

This series include these 2 required patches from [1] that are
just cleanup and won't cause any problem.
These 2 patch were already checked and accepted by maintainers.

This small series adds support for ipq806x qcom-cpufreq-nvmem driver.
Special function are required to make use of the opp-supported-hw
binding by hardcoding custom bits based on the qcom SoC ID.

[1] https://lore.kernel.org/linux-pm/20231010063235.rj2ehxugtjr5x2xr@vireshk-i7/T/#t

Christian Marangi (2):
  cpufreq: qcom-nvmem: add support for IPQ8064
  ARM: dts: qcom: ipq8064: Add CPU OPP table

Dmitry Baryshkov (2):
  cpufreq: qcom-nvmem: drop pvs_ver for format a fuses
  cpufreq: qcom-nvmem: also accept operating-points-v2-krait-cpu

 arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi | 30 ++++++++++
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi | 67 +++++++++++++++++++++
 arch/arm/boot/dts/qcom/qcom-ipq8065.dtsi | 65 ++++++++++++++++++++
 drivers/cpufreq/qcom-cpufreq-nvmem.c     | 75 ++++++++++++++++++++++--
 4 files changed, 232 insertions(+), 5 deletions(-)

-- 
2.40.1

