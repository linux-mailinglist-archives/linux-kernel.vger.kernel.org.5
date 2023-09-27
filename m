Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F122A7B0527
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 15:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjI0NTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 09:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjI0NTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:19:09 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78DC121
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 06:19:08 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9ad8bf9bfabso1430915666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 06:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695820747; x=1696425547; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ex2j1HgBhR1f7+T8Tw8OuGpDZVU+3dvDfXhVV1inwiM=;
        b=Cm/s4e+x/ImggxCAUVrJ0nevsrQ8Q+YT/UpQUUzBxBB+N35PF/UdyB9JrfdHLcK/NG
         SU2TbzeZF1otKX4Sh7gwTUUCgh3X2+KD1CSq+E8sSIxxTbG9nS4p0QYs9SF/2QCel0vu
         9dAkzr76l7Txinn7ykON/ORvUboMY1paUpS3sBIOqZgVHmZlfj6vXNBCkRdL5dIodsp8
         79j4gitb9NYCIT5VXis8jFXmI+LdeyS8QzRJjg/Jumx2OwhKykpzAqb74q91UDC+S8+x
         cnIQE7ZeXO8UhZpVVZLRD5VSkvzAZGvQK7htpfCheHGrgIOwPJSq3rOi/GiEy6mTjSec
         ZQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695820747; x=1696425547;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ex2j1HgBhR1f7+T8Tw8OuGpDZVU+3dvDfXhVV1inwiM=;
        b=LXbGkwAkQaGuNMm0pRVzi0X9rTYDSAo3+aQ6BodXva+dPCGP82TD6JhKtP87k92EE7
         yWy25WncaP/PCEMthKjV3QiFxJaunMSMwxq41m91zzfBxWYRZgXIvH8yeFqjwnlgx5cP
         +YmXxtVyFu/AxddH4Y0XZQ8euiux2pixxDY2rdJroMMJwv7JOG5ALcf3fEWtB+WCAh4o
         Eq86EiOktr+T3TWp7/fLO8wAnltE+khXelGPoIsXKT80Ule2sT2enGBRbfckUVimBVWB
         XE0wt+nobHyAiayuXYOoQ2xYxy2taQknHPoXVIMBWuSH6TLeiQkefLMgA4Jucc1uddRC
         QgXg==
X-Gm-Message-State: AOJu0YzlfelA2XKHaOXfGAN6MpXhWZ7qyEhhOEtTecIT7ERwI70Yck0k
        5TB6/09VC9iiksmNq8EpfTmTDw==
X-Google-Smtp-Source: AGHT+IGu1wbqk0GFZX73piIbUS2jzIqtwNkAydKLJwpjj4a/7CTd7GSLrjBK4RB9WdRKN9Vy71i0Kg==
X-Received: by 2002:a17:907:2714:b0:9ae:68bf:bf2 with SMTP id w20-20020a170907271400b009ae68bf0bf2mr1572481ejk.69.1695820747090;
        Wed, 27 Sep 2023 06:19:07 -0700 (PDT)
Received: from [10.167.154.1] (178235177023.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.23])
        by smtp.gmail.com with ESMTPSA id md1-20020a170906ae8100b009ad8acac02asm9369335ejb.172.2023.09.27.06.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 06:19:06 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] Raydium RM692E5-based BOE panel driver
Date:   Wed, 27 Sep 2023 15:19:00 +0200
Message-Id: <20230927-topic-fp5_disp-v1-0-a6aabd68199f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMQrFGUC/x2N0QqDMAwAf0XybKCtbFV/RYa0Nc6A1NJsYyD++
 8Ie7+C4E4Qqk8DYnFDpw8JHVrBtA2kL+UnIizI44zozOI+vo3DCtdzmhaWgv3ubjBki2R40ikE
 IYw05bZrl976rLJVW/v4v0+O6foj5ieR1AAAA
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695820745; l=836;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Mn59zuX+Tdfbn5rVObYzOLlA/VLiJznWMnAdWQMfYA8=;
 b=NzCtxa23q/2zxYt92xRQO7kNc4G/KZmOcaxHWz5/6n27ZskvfSWBTIAy7Gqa9C+ha1ag9+eix
 6V03J2YinCKBoLCiI1wCkwKyt5ddjE/A4BTLPESBKMbEO634TIeqTuj
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Konrad Dybcio (2):
      dt-bindings: display: panel: Add Raydium RM692E5
      drm/panel: Add driver for BOE RM692E5 AMOLED panel

 .../bindings/display/panel/raydium,rm692e5.yaml    |  73 +++
 drivers/gpu/drm/panel/Kconfig                      |   9 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-raydium-rm692e5.c      | 496 +++++++++++++++++++++
 4 files changed, 579 insertions(+)
---
base-commit: 18030226a48de1fbfabf4ae16aaa2695a484254f
change-id: 20230927-topic-fp5_disp-7671c009be18

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

