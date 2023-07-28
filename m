Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767AF76643D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 08:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbjG1Ge5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 02:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbjG1Ger (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 02:34:47 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFFC3C30
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:34:23 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52227142a27so2186336a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1690526061; x=1691130861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aF25RsasGUB1aNRKgB20J0I6Xsy/3huYOi47Fd6Xv1k=;
        b=eO7loPNL73bDnDOXXzgc7RiL8tFcMcyM14rUTfMAm0noLEPQBnrySBSubWBEFMr/Cb
         +0h5irBDAzosUfPuPhmVPpkhSO33ZQak6YDbj5fhE7M1MoqukFTPFcap7CD9m7/ONTBD
         GoMqFQx0wqb9vw5f5U1QG58ZWX1OCQitefos8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690526061; x=1691130861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aF25RsasGUB1aNRKgB20J0I6Xsy/3huYOi47Fd6Xv1k=;
        b=U9OdQ4dwOlDvf1krt1vmvKTt51sdZoU2No9c5QUBaGI1NsQlJpPAPIQEUdI6ytf9CO
         yg5bgWw80jQ4DkrKsBJH/6snoEjfV1MKDia4cCx5gAgI+OWYD1Q8DhwJaFvXHBAK+xh/
         7oQQ4uHwBclS2i9+q2G4NHzGKOAf8wjwacHYosbrpXcyQh987geHMh2x9MbZoAwLY2eo
         6JkLeIfIMf/T92SMmUJHE9xw9T13Uqu85nmWiCjAMit3gonjmYB01vcFkN8RapFSLUB3
         CgO1+cvqYxbrcqkAGsKl7TQhaiVPnbLul7y5BEdSTFZVmitErPHGdrKT/Oy6ZNSV6oyw
         MJKg==
X-Gm-Message-State: ABy/qLbsZ1YjUwExVnrwhqbDWvyrN94I/i5/tIzcvu0I4J+lxnS9n37N
        H+Ev2ibMF/+fSxgHT2A/TmxzR/eVkocjfEpfzac=
X-Google-Smtp-Source: APBJJlE2WEyHonoNCKIFWdCPNf+A8XgHkupgbLIvHk6IdkZaX8EyYmCFW58NYzChmdx9pGHU8Kh95A==
X-Received: by 2002:aa7:d549:0:b0:521:a4bb:374f with SMTP id u9-20020aa7d549000000b00521a4bb374fmr865376edr.5.1690526061424;
        Thu, 27 Jul 2023 23:34:21 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-232-62-70.retail.telecomitalia.it. [95.232.62.70])
        by smtp.gmail.com with ESMTPSA id n21-20020aa7d055000000b0051e26c7a154sm1425057edo.18.2023.07.27.23.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 23:34:20 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v7 0/3] Add display support on the stm32f746-disco board
Date:   Fri, 28 Jul 2023 08:34:13 +0200
Message-Id: <20230728063417.2980091-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

