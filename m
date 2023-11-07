Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF7B7E3FF5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbjKGNVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbjKGNVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:21:33 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B047392;
        Tue,  7 Nov 2023 05:21:29 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c6b30acacdso75129801fa.2;
        Tue, 07 Nov 2023 05:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699363288; x=1699968088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkcBjw6N38nWpcH98Wo6zXUMJseV8oYDmiwD9ic+Q3E=;
        b=Op6DVYsYVEKONaN43KLwLRXzbj/crJXHppdrECTO6fqhkWB1HTryEqq09MyWbwvD8d
         0eGjAkmKv3CKIoqjerRGAEN5us8I+LXG3OzLDdS+ooioaHjtvfdQx5g0b/67YCN93Y9Q
         3JgWwyDT/knqch/Cgi/ARdWJpoSdKe+z7Bor+KZu8qb1R7sdaG6PEz63QzWcB9vgG+av
         O+TtXWOuXsf6MychZ7jVJ9d1R7mR0/a4ySqsf26XXsXAfSJtvSahuRv8W2gBt5KhouEA
         EmKvtW0Jfojrqr4W5er65J6m2FZV5T/4uWanARgU2FLnWUwOdefTl+IjBHUAzUNmhraq
         SwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699363288; x=1699968088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkcBjw6N38nWpcH98Wo6zXUMJseV8oYDmiwD9ic+Q3E=;
        b=moCNFCITUxhDpcktlU+2cqz1dV2m+CO+44Ij8i1AyMhejYAurWC7bdwpLqyrlLP2JN
         Lxoyx/JfkenUpQ/4ZdhS9T9iFkp2WraEmHc86V4gCLhAyZFzD8pTC28PwybQXXcBKPt1
         Voj8T7qR5ontIicpwzs7GHWNzT+2Z70sAS16oeLz85H0ZQUxDLfK//vcZqt4hIB0/B1d
         z8NvG4vQ+rJ/kSXkCqyne8COEn0KXcjW8wAgCfeoqPgSUkOIb6EXKO15XXBf8psMPiNP
         2ipW9YJJB18bubAcBWxKHJshKfUO4p+O26GzZ1TsrisO8HOMhonRnJR6JsYxQLkmfx7V
         GX1A==
X-Gm-Message-State: AOJu0YxV4Ufug9c+IAuwHCObfYf3/vq7KAF3zHX+BRcZhom8ES51MEp1
        Z7EAsWr+kcGpcA1ns7BiSzI=
X-Google-Smtp-Source: AGHT+IEcOjZaTG4bXioWPlfAx6mUeADkRgjRpoC0lFW8eh2uLucQV1GNPJ7VSo9vSVOe1GxwJ9/IpQ==
X-Received: by 2002:a05:6512:10cd:b0:4f8:7513:8cac with SMTP id k13-20020a05651210cd00b004f875138cacmr30261458lfg.48.1699363287608;
        Tue, 07 Nov 2023 05:21:27 -0800 (PST)
Received: from ubuntu.. ([188.24.51.27])
        by smtp.gmail.com with ESMTPSA id w7-20020a5d5447000000b0031980294e9fsm2356297wrv.116.2023.11.07.05.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 05:21:27 -0800 (PST)
From:   Ana-Maria Cusco <anamaria.cuscoo@gmail.com>
To:     Ana-Maria Cusco <ana-maria.cusco@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: iio: hmc425a: add entry for ADRF5740 Attenuator
Date:   Tue,  7 Nov 2023 15:21:17 +0200
Message-Id: <20231107132118.1165494-3-anamaria.cuscoo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107132118.1165494-1-anamaria.cuscoo@gmail.com>
References: <20231107132118.1165494-1-anamaria.cuscoo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ana-Maria Cusco <ana-maria.cusco@analog.com>

The ADRF5740 is a silicon, 4-bit digital attenuator with 22 dB
attenuation control range in 2 dB steps.

Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>
---
 .../devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml       | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
index 2ee6080deac7..67de9d4e3a1d 100644
--- a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
@@ -12,6 +12,9 @@ maintainers:
 description: |
   Digital Step Attenuator IIO devices with gpio interface.
   Offer various frequency and attenuation ranges.
+  ADRF5750 2 dB LSB, 4-Bit, Silicon Digital Attenuator, 10 MHz to 60 GHz
+    https://www.analog.com/media/en/technical-documentation/data-sheets/adrf5740.pdf
+
   HMC425A 0.5 dB LSB GaAs MMIC 6-BIT DIGITAL POSITIVE CONTROL ATTENUATOR, 2.2 - 8.0 GHz
     https://www.analog.com/media/en/technical-documentation/data-sheets/hmc425A.pdf
 
@@ -22,6 +25,7 @@ description: |
 properties:
   compatible:
     enum:
+      - adi,adrf5740
       - adi,hmc425a
       - adi,hmc540s
 
-- 
2.34.1

