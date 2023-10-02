Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483037B5A39
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjJBS0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238787AbjJBS0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:26:45 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2112DE6;
        Mon,  2 Oct 2023 11:26:40 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1dc9c2b2b79so18514fac.0;
        Mon, 02 Oct 2023 11:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696271200; x=1696876000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMeCSX/w7tJc0iityHO3Qn4uN/ryo/E1f99r0zVNUKE=;
        b=VTUIujk4e45qleTGbBuHa/n+rIE538mhqPRS/reqOckatBZpUGIsnd65+KIPMCQ8ay
         tfhfTtQahks21mDGXUr9IEuAn7MK34JYd0Cx+BaBFyJDgCj7bE9VCa6n7sB/IoMxUtGk
         LgPhxSzC8R5Wssw0glSHEinDVu6Sy2GfaHPG63k+BIC3GBrVdFSPYjTqNuMyRj1UnOUo
         aIyDx/Bi+fQwtIoLTyjb+GXgvuQ3wRV3OLS45uZFeARaeRl/jzoYK74uSGowCEEQebR9
         EfCIxNv4IY669smVvEEynxZAo2Vo8MshOOybx85sXVOFMELDGnyTz37NR7+q0qX04kVR
         wDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696271200; x=1696876000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMeCSX/w7tJc0iityHO3Qn4uN/ryo/E1f99r0zVNUKE=;
        b=Flh8vGftAIDjnzDv5vMkFXPsZuPEC9crcJWDCbPfVYvbHWRHCyU0C49FAxPnpx9yTK
         tTt/NNZ5v2UdKpJvmyY8WrF1451EWw2Ioy9jg3ZuisKbPa5iXgfJ/VqjLuTa1eAoSiAm
         wNz3YS6nWdI9iHqJzvCqzL5RtlUeI7e0eOoDrqFMKWUW5y3RZK83OM/P8ZtMQASx2jVM
         eLYwEZM2/jxVdDSQoy32GHOrXBgDORB9SoziPK48NkORA1dQU9CQNPBPnoPUH73ZFwcs
         ZJbZD6OsO8fa+6gvsYVJ1bGiH3t0+vMjIfLpGgqLvGq1y6KOe3rdCor5u7eVeQJLP8A8
         I/pA==
X-Gm-Message-State: AOJu0YxROuNSTY2QEUktAMHEr7PAa7jLMwoyGlPeb/NirJ5fMuNQmFts
        fcT7UaRRxoDqstWRozGjgCQ=
X-Google-Smtp-Source: AGHT+IEdcVWTW30EtEbPJcaFvAfF5wCjAmSmcLoYePah69Qv2s/V5Bu5Md/rFw+gtbhDKIzReGdYQg==
X-Received: by 2002:a05:6871:80e:b0:1d6:cb43:71cb with SMTP id q14-20020a056871080e00b001d6cb4371cbmr13457621oap.54.1696271200054;
        Mon, 02 Oct 2023 11:26:40 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.93])
        by smtp.gmail.com with ESMTPSA id a8-20020a637f08000000b0057d86bb613esm17249584pgd.45.2023.10.02.11.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 11:26:39 -0700 (PDT)
From:   Ayush Singh <ayushdevel1325@gmail.com>
To:     greybus-dev@lists.linaro.org
Cc:     Ayush Singh <ayushdevel1325@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        vaishnav@beagleboard.org, jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 3/3] dts: ti: k3-am625-beagleplay: Add beaglecc1352
Date:   Mon,  2 Oct 2023 23:54:52 +0530
Message-ID: <20231002182454.211165-4-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002182454.211165-1-ayushdevel1325@gmail.com>
References: <20231002182454.211165-1-ayushdevel1325@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BeaglePlay board by BeagleBoard.org has a CC1352 co-processor. This
co-processor is connected to the main AM62 (running Linux) over UART. In
the BeagleConnect Technology, CC1352 is responsible for handling 6LoWPAN
communication with beagleconnect freedom nodes as well as their
discovery.

This mcu is used by gb-beagleplay, a Greybus driver for BeaglePlay.

Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index 7cfdf562b53b..5160923b4dc2 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -870,6 +870,10 @@ &main_uart6 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&wifi_debug_uart_pins_default>;
 	status = "okay";
+
+	mcu {
+		compatible = "ti,cc1352p7";
+	};
 };
 
 &dss {
-- 
2.41.0

