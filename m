Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D9077BA06
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjHNN3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjHNN2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:28:51 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543FCED
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:28:50 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a640c23a62f3a-99bed101b70so589507266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1692019728; x=1692624528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UwTK4kQuV5VxtjBSsgaGk0balJ0EXu0ogmgIW94gvrs=;
        b=Gr+qyuiLUYHVDstJKxuX9OmR+46d+I9eLx7/jZRTje+YIqMXDAXUywQUzxqi+5oxFi
         we3gIUjU9v/By0hcv2xh13nzuQ1h3z9KRCo0yxfMM6SkQlHCkUVAuzxKlDW5a0Rw5ftH
         whLYUfuT46a28iUkKMhbbVZY/iZG7cWrAQveE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019728; x=1692624528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UwTK4kQuV5VxtjBSsgaGk0balJ0EXu0ogmgIW94gvrs=;
        b=b8sZEry/803wFKwnqe+SDGK+1dY5Vg52gPiKTA7Tc+TNu0vg96rrcAUp9NUhBvbiAE
         cxhvebdTM+FGj7kJogx1etorHXNE/Fw/twtqd5angsHVwGzNkOI325PS3y9LiiyX1/Kg
         RAgCskYLBEUBlY4H4B99+0DL+dyRpUBBDjNWotb5Fp2mwHgg8/nCtwnvFzpxIfrhJV0s
         HSEQA1UwkwtMoct/iCkMmcfK3de5v/u47LowUCOx6SBYzx6f9D/cXjB22Yho0KrEDVHe
         eXYGsyji0hzqALnHFZOhnY7K9GNQp/LcSOevNak2m1niUbqj8Dk066/m2IhtsNiByupW
         w+eQ==
X-Gm-Message-State: AOJu0YySs/+/WbchtmEvoghFvOZ3jpxQOX/mWAO7dDRp6tfAC/pERuN7
        g1XEiYWNApe07VZ7EU/lgIPh02inQlIkkA72kS9llYZW
X-Google-Smtp-Source: AGHT+IGls+RQsK667fY/9NGJP8lytIadwNC1YoCHU8DSXGFvYdF3uY8ozRFXsf8peTtmChtHNxVDnA==
X-Received: by 2002:a17:906:30d7:b0:99c:4ea0:ed18 with SMTP id b23-20020a17090630d700b0099c4ea0ed18mr7677926ejb.8.1692019728414;
        Mon, 14 Aug 2023 06:28:48 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-180-23-204.pool80180.interbusiness.it. [80.180.23.204])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906248300b0099d02ca4327sm5662066ejb.54.2023.08.14.06.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:28:47 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Philippe Cornu <philippe.cornu@foss.st.com>,
        michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v8 0/4] Add display support on the stm32f746-disco board
Date:   Mon, 14 Aug 2023 15:28:40 +0200
Message-Id: <20230814132844.113312-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series adds support for the display on the stm32f746-disco board.

Changes in v8:
- Add the patch [3/4] "ARM: dts: stm32: rename mmc_vcard to vcc-3v3 on stm32f746-disco" to
  th series.
- Add the 'power-supply' property to panel-rgb node.
- Move backlight and panel-rgb nodes after the vcc-3v3 node.

Changes in v7:
- Add 'Reviewed-by' tags I forgot in v6.
  https://lore.kernel.org/linux-arm-kernel/20230629083726.84910-1-dario.binacchi@amarulasolutions.com/T/

Changes in v6:
- Remove dma nodes from stm32f746-disco.dts, they are not used by LTDC,
  so there is no need to enable them.

Changes in v5:
I am confident that framebuffer sizing is a real requirement for STM32 boards,
but I need some time to understand if and how to introduce this functionality.
Therefore, I drop the following patches to allow the series to be fully merged:
 - [4/6] dt-bindings: display: stm32-ltdc: add optional st,fb-bpp property
 - [5/6] ARM: dts: stm32: set framebuffer bit depth on stm32f746-disco
 - [6/6] drm/stm: set framebuffer bit depth through DTS property

Changes in v4:
- Use DTS property instead of module parameter to set the framebuffer bit depth.

Changes in v3:
- rename ltdc-pins-a-0 to ltdc-0.
- drop [4/6] dt-bindings: display: simple: add Rocktech RK043FN48H
  Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next):
  https://cgit.freedesktop.org/drm/drm-misc/commit/?id=c42a37a27c777d63961dd634a30f7c887949491a
- drop [5/6] drm/panel: simple: add support for Rocktech RK043FN48H panel
  Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)
  https://cgit.freedesktop.org/drm/drm-misc/commit/?id=13cdd12a9f934158f4ec817cf048fcb4384aa9dc

Dario Binacchi (4):
  ARM: dts: stm32: add ltdc support on stm32f746 MCU
  ARM: dts: stm32: add pin map for LTDC on stm32f7
  ARM: dts: stm32: rename mmc_vcard to vcc-3v3 on stm32f746-disco
  ARM: dts: stm32: support display on stm32f746-disco board

 arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi | 35 ++++++++++++++++
 arch/arm/boot/dts/st/stm32f746-disco.dts  | 50 +++++++++++++++++++++--
 arch/arm/boot/dts/st/stm32f746.dtsi       | 10 +++++
 3 files changed, 92 insertions(+), 3 deletions(-)

-- 
2.34.1

