Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE3B770F18
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 11:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjHEJcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 05:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjHEJcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 05:32:10 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008A5469E
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 02:32:08 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a640c23a62f3a-99c93638322so336799766b.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 02:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1691227927; x=1691832727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aF25RsasGUB1aNRKgB20J0I6Xsy/3huYOi47Fd6Xv1k=;
        b=b8vVOFsiKhLLr1bFXxu3b0b4fzG5ByTOZMyc8LOUxhXh7tXwd4xB40vB1C+1TnXEXf
         ulEByMBlb4W9BASrYgRDnUEFi4o1+akeDnLB4kg2yR3DRwOV3YFsxsKMV3P6Kl9HtsiY
         N4bU6ex122m5UfarEv6oO4HOkC78ZanmY7n5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691227927; x=1691832727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aF25RsasGUB1aNRKgB20J0I6Xsy/3huYOi47Fd6Xv1k=;
        b=PsLdA0UhfBcR0bo9nWD4MidjKxTkNJTjj32W4voH8FoIMhoRa0GJJ8sjQrGrWd4kcm
         NCDhsswLPkZ6aj5leYn1CIr5IZd+MFrlONiEQo8UUycZzz1Rg+yjUvduuGqHmNam4hIs
         qhaP1Dv+VHjcE/TI8qoTLUiiU0xWrCW0SFqjdE2pI5G6g5Htc1IaXkCSwd3IsGERqAvs
         4kHTa3gHWeyVxsC3OXDnJkmbwsChvoREgYDKHtJJDsbHoJlcVdiTfiSNghGa809wJxjO
         qpTPddin4IT3RQuBkM1UjTOXAIbHRDuSDonUhpR/7XUOJ2leMlBljXYGYS1VCo+X2RMU
         qZaw==
X-Gm-Message-State: AOJu0YzdR/BFIMsN0hOFef7XDnHDC4/5xrkws6Qr1Wp4ym+VZFEx1w9/
        /GY+2e76jDfnd+C303yQ29F+0sLZcCiNPFWdlXV8BWVH
X-Google-Smtp-Source: AGHT+IGtXjH9AHI/YJtPiVY+kUPyUT2gJnGXQxKu46u8YS85WU5PjON9DsKxMaGHjRoi/CRF1KyyjA==
X-Received: by 2002:a17:907:760a:b0:99b:4bab:2841 with SMTP id jx10-20020a170907760a00b0099b4bab2841mr2313337ejc.26.1691227927131;
        Sat, 05 Aug 2023 02:32:07 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-52-12-96.retail.telecomitalia.it. [82.52.12.96])
        by smtp.gmail.com with ESMTPSA id j15-20020a170906430f00b0099b76c3041csm2491083ejm.7.2023.08.05.02.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 02:32:06 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [RESEND PATCH v7 0/3] Add display support on the stm32f746-disco board
Date:   Sat,  5 Aug 2023 11:31:59 +0200
Message-Id: <20230805093203.3988194-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series adds support for the display on the stm32f746-disco board.

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

Dario Binacchi (3):
  ARM: dts: stm32: add ltdc support on stm32f746 MCU
  ARM: dts: stm32: add pin map for LTDC on stm32f7
  ARM: dts: stm32: support display on stm32f746-disco board

 arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi | 35 ++++++++++++++++++
 arch/arm/boot/dts/st/stm32f746-disco.dts  | 43 +++++++++++++++++++++++
 arch/arm/boot/dts/st/stm32f746.dtsi       | 10 ++++++
 3 files changed, 88 insertions(+)

-- 
2.34.1

