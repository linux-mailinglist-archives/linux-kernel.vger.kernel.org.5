Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96777B32DD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbjI2Mye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjI2Mya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:54:30 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890AEC0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 05:54:27 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a648f9d8e3so1961155766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 05:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695992066; x=1696596866; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+AuRv4KTqJ8bK4vJwp6Rlf7DjgTsFVdEaK8Kexn8Dp4=;
        b=EtO4qQzO0EwnfQP2LmgE0c11zwosPYH7yRn2ZgK4N6quOqrexlV5RD8rHw9D7iPRA3
         7zeEX67iXS7a+ECJqmayhM8Qorq/25apHl2mDKYpSlJZbXQ5PED9bN7PoYDQ/D8IWFX5
         kd9HZ89Jn2jEnt+CvlPpAN8/swrtKPkjETJjSo5RLLM+dvM7b1jJb2n7zhmPv2x9uofp
         euQpeaQ90dN5dVSBe0eKWT8gbwus3EF4Y6wwtBVJp4unsbTAZ9YGX5sZ2UasR1vWm9Lg
         ELdWu8lkHDgp7REbRGi8YRubABrSMxM1lJq8wuylVH3MzJxjyESFomfcE+XMCrl8w3JZ
         17FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695992066; x=1696596866;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+AuRv4KTqJ8bK4vJwp6Rlf7DjgTsFVdEaK8Kexn8Dp4=;
        b=cQdNEJI7cqPXIfTZ0FRy2IVsJnppartTd9gAzsAmqXVTP3Bkdcen9Q74t18b1bzDt9
         BVwkvcFcvU49NQABppyWu2otFbnapME2K7niCi1pUeDyEScsfJy0AK2RQXsY4Uf6v5jE
         QkEpShKBMVmixHn8uOJ6TIK9USdjQFBcdBUuVJYiFfKxOVTVDV3/oLsYikkYFMUHXqlw
         6hvFgQi9KKIbIJZTy/Dh1yr6SvXF8bplPGEDMUn3sa4Q//HTbu06ztmlD2QVrbFi8e8U
         3thib7sga161S5IMnQNDFlvPu4qVg847oBcTg6LS5zGx2cSmWR4MSXHytTNYh5bAd4tf
         jR0g==
X-Gm-Message-State: AOJu0Yw802NA/SA/H1wnW00eB2FSMExgJIAbdnogZElGgZL6mo6KwvRX
        xFPDbywSuK9NZsnnjimEs1g02w==
X-Google-Smtp-Source: AGHT+IHRZn9LrlpURw5VR8gkE65oLEBKEN+4DaWKjtyxPioqWxZlBs4SfN8Yt45onlSLuw1Zv/bBug==
X-Received: by 2002:a17:907:7851:b0:9ae:594d:d3fc with SMTP id lb17-20020a170907785100b009ae594dd3fcmr3150969ejc.17.1695992065978;
        Fri, 29 Sep 2023 05:54:25 -0700 (PDT)
Received: from [10.167.154.1] (178235177217.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.217])
        by smtp.gmail.com with ESMTPSA id j26-20020a170906831a00b0099bc8bd9066sm12380376ejx.150.2023.09.29.05.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 05:54:25 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/2] Raydium RM692E5-based BOE panel driver
Date:   Fri, 29 Sep 2023 14:54:19 +0200
Message-Id: <20230927-topic-fp5_disp-v2-0-7b5e1d1662a6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPvIFmUC/3WNQQqDMBBFryKz7pQkpWq66j2KlCSOOiBJSKy0i
 Hdv6r7L9+D/t0GmxJThVm2QaOXMwRdQpwrcZPxIyH1hUEJdhFYNLiGywyFenz3niE3dSCeEtiR
 bKCNrMqFNxrupzPxrnouMiQZ+H5VHV3jivIT0OaKr/Nm//6tEgaY2xvZ1K7Ue7jN7k8I5pBG6f
 d+/aCqhL8IAAAA=
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695992063; l=1363;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=2d9A8dWRUIiELWOfFWWRUFTRoeEgh24LYoeTZfnTIdg=;
 b=KFKilxuw2y1VD+FVx1XyC7xUmXUIkaWMvt6MYZK+K3+21M+RhPOmeb+/6P9/3/UQ25nyvjoNk
 lYj79bWX3LZBhrDtvOTAyE/dQBIM3ecP90jsp65aVlQbSgneO/pb2Mu
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Fairphone 5 smartphone ships with a BOE AMOLED panel in conjunction
with a Raydium RM692E5 driver IC. This series adds the bindings and driver
for that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
DRIVER:
- Remove 1ms sleeps after each DCS command submission
- Remove WARN_ON from probe()
- Move DCS off commands from .unprepare to .disable so that they
  actually reach the DSI host
- Do NOT introduce the 60 Hz mode for now, exploring ways to avoid tons
  of boilerplate
BINDINGS:
- Fix weird capitalization at the end of a sentence in title:
- Drop unnecessary | in description:
- pick up rb
- Link to v1: https://lore.kernel.org/r/20230927-topic-fp5_disp-v1-0-a6aabd68199f@linaro.org

---
Konrad Dybcio (2):
      dt-bindings: display: panel: Add Raydium RM692E5
      drm/panel: Add driver for BOE RM692E5 AMOLED panel

 .../bindings/display/panel/raydium,rm692e5.yaml    |  73 ++++
 drivers/gpu/drm/panel/Kconfig                      |   9 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-raydium-rm692e5.c      | 423 +++++++++++++++++++++
 4 files changed, 506 insertions(+)
---
base-commit: df964ce9ef9fea10cf131bf6bad8658fde7956f6
change-id: 20230927-topic-fp5_disp-7671c009be18

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

