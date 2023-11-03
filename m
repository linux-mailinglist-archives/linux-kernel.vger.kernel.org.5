Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C127E0532
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjKCPCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKCPCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:02:04 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A5DD4C;
        Fri,  3 Nov 2023 08:02:01 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507f1c29f25so2691962e87.1;
        Fri, 03 Nov 2023 08:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699023720; x=1699628520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wLP3jxyfUOUJLsqg3GaPkk4IR+kJBNyFel5/8Pny34M=;
        b=RJxjDMtZChqPE2ZCjHw/8zJ3Me5+nQWSe+1U1l43vqJ9WR3C4t6Wfy9XS6iCawOwEa
         TULTE3Yq6aSEiboCfzmZQ91ATcorWoKD/aJuh+62LjG89NMRGtEIOAZwMwEd80A+51H3
         Dn+USi8pUl1tKQQ3hNjrT1FShqQHtbawBp68Huka66K9uFXsKHVix0ixzuTUxotaglNL
         4RfkoqmXTemkoK9tKq/zh28Xl/Is8TBh8MIIloPt5PvcJZ+Q05GGUkgt3H7e5Xlq434c
         Q7GdGMeG2BwFzYghpaQ2apAYrVtbtUeUXoaSgFLAZxC/Kzljs9+miMzQVgce+g2kA8EF
         hunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699023720; x=1699628520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wLP3jxyfUOUJLsqg3GaPkk4IR+kJBNyFel5/8Pny34M=;
        b=XPzrokPKwv6XSUtFfGT8qK6LkirnvhayXSrJU0ajEhZmzfmYnQRUy8j1vsBeffumJx
         rib5ecGZZV7Wx799iw54+EmCIoDA4TqDLzhUffZ8CAQxFuUpVef9cHNKGmnb2CMoNTVn
         uGtxUqj+BX3TXZ3A8aPnSAIslOQYgJA4kW55KsoIjCSk/y7IdCgfnDu8I7v8QAEvbUgJ
         P627pa+6TahNahMhBYhFj2g/fp5kU86K0S1tv1M1RBivbB2OjprcL/ixfRniZsWnNwK1
         8X0JMpQpdL4YeYzHqsu4pD0a79HYDsFQCXBogwzlFUqNJIndu4dE31zqVk4rDQ3z3y4T
         39IQ==
X-Gm-Message-State: AOJu0YxBMLUv9f78+EszKT4tVM+fAE3MjIn14CZTPUeVeyr942LR5/Hy
        pjbtMh2Xk33qg0sFM68pPrBdR49elbuRmg==
X-Google-Smtp-Source: AGHT+IHpuRso4xtWjlPSeW4ndkfqTYZci2G+utdTJThRaovC9kcAw+ZRkL8n2UZGX9vECFoo6l5mJw==
X-Received: by 2002:ac2:5b5c:0:b0:509:448a:d with SMTP id i28-20020ac25b5c000000b00509448a000dmr4384411lfp.31.1699023719697;
        Fri, 03 Nov 2023 08:01:59 -0700 (PDT)
Received: from ubuntu.. ([188.24.51.27])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d6848000000b0032f933556b8sm2077277wrw.7.2023.11.03.08.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 08:01:59 -0700 (PDT)
From:   Ana-Maria Cusco <anamaria.cuscoo@gmail.com>
To:     Ana-Maria Cusco <ana-maria.cusco@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add ADRF5740 driver
Date:   Fri,  3 Nov 2023 17:01:28 +0200
Message-Id: <20231103150130.1090246-1-anamaria.cuscoo@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ana-Maria Cusco <ana-maria.cusco@analog.com>

This patch series adds support for ADRF5740 Attenuator.

The ADRF5740 is a silicon, 4-bit digital attenuator with 22 dB
attenuation control range in 2 dB steps.
It offers parallel control mode through four digitally controlled inputs.

Ana-Maria Cusco (2):
  iio: amplifiers: adrf5740: Add Support ADRF5740 4-bit Attenuator
  dt-bindings: iio: hmc425a: add entry for ADRF5740

 .../bindings/iio/amplifiers/adi,hmc425a.yaml  |  4 ++++
 drivers/iio/amplifiers/hmc425a.c              | 23 +++++++++++++++++++
 2 files changed, 27 insertions(+)

-- 
2.34.1

