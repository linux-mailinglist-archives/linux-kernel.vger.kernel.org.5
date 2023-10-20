Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309167D12C9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377726AbjJTPbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377754AbjJTPbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:31:09 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9F5D63;
        Fri, 20 Oct 2023 08:30:58 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53e855d7dacso1462849a12.0;
        Fri, 20 Oct 2023 08:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697815857; x=1698420657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSFCTdWjzuqMNF2eZpaFzkv4Ua8pTNaRVHQDi96ry5Y=;
        b=bU67dQddphf68huXbejIhfozg1CieAcHt8ii+/07Hstdq0P6xs7yX1g8igKC5zcmsx
         TJu4kdx90jsZOFT+SQKzpCjUwYrb1npgLPL21tT7v3ZhM/B4LM50VYoOnouAjdyYv1Ge
         j3jOQ1ERjkPKwu/vZ+AzXhwuEY34urVxMCOBNrVwGo6VfcYvQ2BcXvC034909dRvlaMc
         LstRswrSxeW51ZhTkdvbrUWdjJgeXLe0bOQnJX5qixe7OmYiUz16o87AesAfhhIKF1pi
         nu86mRyKch8IaueDfyNF0h8YvQZyh/4kbDPXWrREfmQyErOY/nD1pLsm9cH7BRgtFunr
         Nepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697815857; x=1698420657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSFCTdWjzuqMNF2eZpaFzkv4Ua8pTNaRVHQDi96ry5Y=;
        b=LggMuOIJJAvs1SuVHq8ZlD+v/H0T00vQXYBPyyJzgonGpOPXQ4ylpia08KH/UZCGyC
         Ap5bI8mwTqQFG7jKAsiG3LH6S2fqhlu9OiSQWq5MJaJj+AiEOUsP/w6sa+P7N5JWgj+t
         Ax7y7quFbfzMLt8FuwhmuStP5KodU+dBrkPUBM88NOex9UsE9QAr2EvG1Jy6GTDQKH8m
         RVwqF+s8BkRewV1Z6er3AIirC2u65AMw6u9wtM8zh17WK17zQ+ZGOzlBEyjFGPONjA82
         Xg3aY/Sze73GqXs+9C5yDh4XAKFrJ3iCit735xjrCNRGwkIbTadn7iE5PjODUkq7MOYo
         Pqzg==
X-Gm-Message-State: AOJu0Ywg36vp0l+xU3eZ+4Ll30ucESNBjBqo0/WNVSjV0HufxmDD5DGr
        8p7f0AvEuE3Oi3H8C4eQkqA=
X-Google-Smtp-Source: AGHT+IEJpoLvhium+fE5LnkOOZVA3C6CcbzyDX+cSHEU1CIfCGjGXionuulzFZvd/Jm0AFXXxH+GZA==
X-Received: by 2002:a50:ed08:0:b0:53e:7ef9:a8cc with SMTP id j8-20020a50ed08000000b0053e7ef9a8ccmr1712435eds.0.1697815857165;
        Fri, 20 Oct 2023 08:30:57 -0700 (PDT)
Received: from andrejs-nb.int.toradex.com (77-59-154-235.dclient.hispeed.ch. [77.59.154.235])
        by smtp.gmail.com with ESMTPSA id if5-20020a0564025d8500b0053f10da1105sm1631199edb.87.2023.10.20.08.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 08:30:56 -0700 (PDT)
From:   Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
To:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v1 1/2] arm64: dts: imx8-apalis: add can power-up delay on ixora board
Date:   Fri, 20 Oct 2023 17:30:21 +0200
Message-Id: <20231020153022.57858-2-andrejs.cainikovs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020153022.57858-1-andrejs.cainikovs@gmail.com>
References: <20231020153022.57858-1-andrejs.cainikovs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

Newer variants of Ixora boards require a power-up delay when powering up
the CAN transceiver of up to 1ms.

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
index 72136c436a70..f6654fdcb147 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
@@ -68,6 +68,7 @@ reg_can1_supply: regulator-can1-supply {
 		gpio = <&lsio_gpio5 22 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		regulator-name = "can1_supply";
+		startup-delay-us = <1000>;
 	};
 
 	reg_can2_supply: regulator-can2-supply {
@@ -77,6 +78,7 @@ reg_can2_supply: regulator-can2-supply {
 		gpio = <&lsio_gpio2 8 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		regulator-name = "can2_supply";
+		startup-delay-us = <1000>;
 	};
 
 	reg_usb_host_vbus: regulator-usb-host-vbus {
-- 
2.34.1

