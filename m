Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924AC75BFE5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjGUHhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjGUHg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:36:58 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C2F30F2;
        Fri, 21 Jul 2023 00:36:41 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-78372625badso70747839f.3;
        Fri, 21 Jul 2023 00:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689925000; x=1690529800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5girznxZEVmfu6MF8WQfEA/m0XDH2de0FPd1ig7pBJE=;
        b=rQ96798DJcU1PHpmkhnz53hSw/hzeAXvE/12sqFKxu1ctRs03NN3Kikc+baZzjH+zc
         hb096h7w+zuaY/vnWAoOOUybaZT0z4I3xcvv7pvRXrvdhZQUA2PwNFWY9cuDTr5Y756W
         Od0ap86fgPA6M+eycfVurTtjRdUyqtg/966lgDxfNRgBjFhogOVJV+t9jDIGI5olr3Mh
         SpB4voPOaAoovSRoVeuCPADodcwP0uRnEIXdYRt9guDCw2KZtnF8TfMoUaXHs+A1dB0Q
         /cz8B+PCc9DZqXoi4WyqX0suG3bdcekbXwA1bwpvKMDPRcARGz2y9qJdRPs9LbF6w861
         8Kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689925000; x=1690529800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5girznxZEVmfu6MF8WQfEA/m0XDH2de0FPd1ig7pBJE=;
        b=kWkLJUymhfJFPDATWhX/3zzsZTlpGsSLhjFDRHyalCqb+EYir8OhZild8MO9jqb2br
         DhJpPVgOH1gmsSyzwKjUlJ/BW2uEU2h1fOzuJtcYo54iujAwaRqAhii6BI8c7KSDo6S3
         C+ZsHRQKqCCMxuhW5l37K3BsvI66SFfdLUVSuZ1OYeDYMi8ESo9qQtn8+a9x0b4NtDfw
         J+i/aVyS8DW1OCMW/ZwkdF9W5ykgUGWZo/Q3qE9GZIj8Zk5cOhOWnXjXXroWvFLd5qlA
         AkM1jVfDZlPeybtRanrEhs1OJ3NQxhJjrZbRmcWja1zOnusDc0oreV2nTpNoroUKK4o/
         LPzg==
X-Gm-Message-State: ABy/qLb4QFro2jM+LG4yBZqc+sfJiCct+oX7byZU5ShBZ6w9Rz+Fgpiz
        FR/NMP/XUXRUUKllJfCORhBclFOSyzF6pg==
X-Google-Smtp-Source: APBJJlHrWyU5RgQAxLZbi7vMhdZ/p0snsV2R8tOMemB7qOrtmQnYpuH9nTOKN+vE7ch/CKlS+np9IQ==
X-Received: by 2002:a5d:8894:0:b0:787:8cf:fe8a with SMTP id d20-20020a5d8894000000b0078708cffe8amr1166621ioo.2.1689925000533;
        Fri, 21 Jul 2023 00:36:40 -0700 (PDT)
Received: from james-x399.localdomain (71-218-225-212.hlrn.qwest.net. [71.218.225.212])
        by smtp.gmail.com with ESMTPSA id k20-20020a02c654000000b0042b35e163besm883017jan.88.2023.07.21.00.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 00:36:40 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/4] dt-bindings: arm: fsl: Add VAR-SOM-MX6 Custom Board
Date:   Fri, 21 Jul 2023 01:36:21 -0600
Message-Id: <20230721073626.3673429-3-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230721073626.3673429-1-james.hilliard1@gmail.com>
References: <20230721073626.3673429-1-james.hilliard1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Variscite i.MX6Q VAR-SOM-MX6 Custom Board.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index a3ab78429799..010601da6c5b 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -298,6 +298,7 @@ properties:
               - udoo,imx6q-udoo           # Udoo i.MX6 Quad Board
               - uniwest,imx6q-evi         # Uniwest Evi
               - variscite,dt6customboard
+              - variscite,mx6customboard
               - variscite,var-som-imx6q   # i.MX6 Quad Variscite VAR-SOM-MX6 module
               - wand,imx6q-wandboard      # Wandboard i.MX6 Quad Board
               - ysoft,imx6q-yapp4-crux    # i.MX6 Quad Y Soft IOTA Crux board
-- 
2.34.1

