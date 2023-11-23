Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E327F63C0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjKWQRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjKWQRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:17:40 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D31910C9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:17:46 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c5071165d5so13565551fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700756264; x=1701361064; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pujVRWSCfIATffTNycbDYi4i1pCGIH+ZOcX0lBAR6Ok=;
        b=CS7ce4mlmIaA8YC/wHCs93tq1z0fvAvB948jEuWdpMEDpM1smUbrh+PAqaruWID40I
         3jxcPNuuuOKcku6edHIueEZR+Dh+DEi7X+eeQaU1BK7mPe36xZmSrTwbEZJgq1XniapC
         X+tzUumdRYMtLk4NVUs1g7XfS8B7NvJbPkBvemUDPZWV57wkR8w3AMtS0g/7RnrWHaQm
         nU7HR8O0lWmgkBPi8nVFcd3zBQ3w8ToEG19BFWVfjL5qFAzomutVVZ7cKag7dREwRYyC
         ELjYWMR4ohgWyZGTh9BkBxqFL5RfLYRAdzjv3gGF1DkwfjJpAC1Ujks/3ByvxTMG/loZ
         M5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700756264; x=1701361064;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pujVRWSCfIATffTNycbDYi4i1pCGIH+ZOcX0lBAR6Ok=;
        b=lgqrq/A1iyfWMdMxHEIYU47OAwbOZDmNqVAc+kUIc6rbOPfC4N1L/IPeSI6lDWiY2p
         jaOQ9WZTsXdoMYXfceZpjtiYx26RCIv5BSy97ELBubPEQtwtB2CTd22WGxY/p59nOwPq
         tqBqaOk3+L+HVWTFVy42jl1AkbjXsr19DYHpzKhPRfpQKItfArG9A5y7Dh22yMnlkqHc
         rL+qHk10Onhb6eIJGnEnuD+egMilEMqhnUYsn+4nfQsSyTjToELi2bApRrT/FspAlu0E
         7LXK9WKMvbygH+K+3pYz5BsqmIIJFLaOtjYeoZp8tN1EWgf+YBVfUbEG5chT2l5O7zEY
         2oaQ==
X-Gm-Message-State: AOJu0Yw3icbwzuAndzlkN5a6lEhOU7XTSqmJaJavgz4xMWT/hcXvnWA5
        RngOCyernTRZUQHvF54RVD6A2Q==
X-Google-Smtp-Source: AGHT+IGgruZuQVFa5oEJQDX8aqb5/Ot/vkkklZXcQPqwbozIu7QKs3JXX4OMcsRDkgheysPCEwBdhA==
X-Received: by 2002:a05:6512:15a3:b0:507:b0a1:6088 with SMTP id bp35-20020a05651215a300b00507b0a16088mr5413280lfb.46.1700756264200;
        Thu, 23 Nov 2023 08:17:44 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id y3-20020adfee03000000b0032f7e832cabsm2052748wrn.90.2023.11.23.08.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 08:17:43 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/2] pmdomain: amlogic: meson-ee-pwrc: add ISP power
 domain
Date:   Thu, 23 Nov 2023 17:17:40 +0100
Message-Id: <20231123-topic-amlogic-upstream-isp-pmdomain-v2-0-61f2fcf709e5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACR7X2UC/5WNTQ6CMBBGr0Jm7ZhOFYiuvIdhMYEWJqE/aZFoC
 He3cgNXX963eG+DbJKYDPdqg2RWyRJ8AX2qoJ/YjwZlKAxa6QsRXXEJUXpkN4ex7CvmJRl2KDl
 idENwLB5tWytdN2RvRFBMMRkr76Py7ApPkpeQPkd0pd/7n38lVGgVmcb23LSsHrN4TuEc0gjdv
 u9fF1HfkNcAAAA=
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Daniel Scally <dan.scally@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=893;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=9FcVA9H1qv0poQwZkxkRJQ5+OyLnOc8rdQ539wz0wiQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlX3sl/oeVw69IbWwEg0CwIM/8QW1I7Km1XZjYjaJs
 bkGoziKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZV97JQAKCRB33NvayMhJ0Y8cD/
 4lM8bue7qAIylsKEW9oZVV638spFcUpbyNzb1mU3hwuhKS9H2tJVvNeqbWSK3gXoR14OIMAxjRL5ro
 3aDOtyBlDlfkspncumv3v460IQSN8/Ca+KWTfmGF7HdkPrnI9YTk5jdOShA3wttqCMQC8vDRpmMq7A
 BQT1iBkgocNOI/dQ8jPvM1M4Na8iBagMStLM/Hnqjc6Z69if+XeSfK1JkVerOXpktYcsQxGaf188YH
 0MCV5LB7Wf+0xBcIjD6pJyIUF5SQqiK2votYzKla8leOogRV5+HdypCumad35KB+swbARwQvaPg10J
 GasOhGWPphHFACyKC/742I2VDmG8r3A2WR3H7LkghU5IBL7G80qec3xPvF+n7WgktqGLg4iJVa4gF0
 zFKxRmz+l6oyL+2tPHLwHYBS717ZKB+I/GG98L2Eq3zWoP7skXpp3NcZ0RnTeiTmwBs21F2ARKsXzV
 4TJ2LNjG29zao96AcwlpqavGjdGx+McxTOMRgb5XvQWEvr+JW5IPe1+Jyfj7nY6xBrAtCwRFjID6Dr
 U/M63T6Zcn+CD+BIVZ6h3HizfnRFFUgrE1aP3HmPalq/MmJ7Ms+xYTttPPuowFyr3tf4T4cxth93VA
 ahFw30yjwMrXgh4XcmrQjx41X5c9H8srGZ8F6AFAJFgK6d1+RWdCOAdMEsig==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MIPI ISP power domain bindings and entries for the ISP power domain
found in the Amlogic G12B SoC.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Correctly use REG1 for second g12a_pwrc_mem_isp cell
- Link to v1: https://lore.kernel.org/r/20231114-topic-amlogic-upstream-isp-pmdomain-v1-0-f01e6fca67a0@linaro.org

---
Neil Armstrong (2):
      dt-bindings: power: meson-g12a-power: document ISP power domain
      pmdomain: amlogic: meson-ee-pwrc: add support for G12A ISP power domain

 drivers/pmdomain/amlogic/meson-ee-pwrc.c     | 16 ++++++++++++++++
 include/dt-bindings/power/meson-g12a-power.h |  1 +
 2 files changed, 17 insertions(+)
---
base-commit: 5cd631a52568a18b12fd2563418985c8cb63e4b0
change-id: 20231114-topic-amlogic-upstream-isp-pmdomain-f7502561f911

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

