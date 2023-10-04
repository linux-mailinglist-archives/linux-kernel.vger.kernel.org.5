Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2997B8B26
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244607AbjJDSrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244620AbjJDSrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:47:05 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04DE10C;
        Wed,  4 Oct 2023 11:47:01 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c5db4925f9so1609535ad.1;
        Wed, 04 Oct 2023 11:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696445221; x=1697050021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVKOeyfzPTqe/CUiQ9KqX2upeUQqv3i7YeBbchF99cg=;
        b=OitOqkD0QjTGzvQF29q1oNudgSYliIUeM7GXFmdeOrX3sZjRBNmJMRrb13huiX3b3C
         nJolSpLlP+6Jn4BbzkakYamo+egMysTnn2nppyqFMjXD31aL1pUYAJYRbH7dhhVwxbNy
         ZugMF3kkkR7ixehftRdqhLgnWV+Tlu/F2oBQiHB+ZPBDodmbGs6TXdqHLSt41tXNkyw2
         l/2SaCUPHOKJKFp0F5Hva6VDmxgACdbCIxMsolrbC8/YclHUD8l336kAEQLuXrt3DS3Z
         qkaiBMAmHqsRNzdCjp4MXWTyQZ2DT4Ql8HHrMqWI0WvoKk4Ne6J73QH/J3uftJ97+nxN
         4rOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696445221; x=1697050021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVKOeyfzPTqe/CUiQ9KqX2upeUQqv3i7YeBbchF99cg=;
        b=A1EkiHbR13Q+x8YcOFUlPdm91riMiV5cy49xuqjNSQOMbNt9yBzvynvOmclA/xAGo3
         dN14siP5+UJ78cuTl5yK8C1IHS7xF8HJxQ9GrG4FkEqWZJyuFrA9rw1zRSfJNLRPnH4b
         Hai/u2pp8kyR3/aqi3HI11xGG2c9N3cWEHZHoSENXp32m1qAV5jrzcguvYwHG5y+qf8x
         knigyvYsmreQcsp+72OHIwUJuelda6B29W8Yk8XVEmdvAoJo+KWs5oK4C6kvm7cis75L
         nsnPHsdMxlJvET6ycbogJ5es8mIhlwbBo3bs16cHz6aYevYpcprv4a5czQ5QgdTbbMzm
         T13A==
X-Gm-Message-State: AOJu0YwhXlc6bbALL/boZt/eslbp+bd35nmXp37Oq8oPGBNfQ9I9BGNL
        vNDAPxLAkXZ4QCs7zLoVDoo=
X-Google-Smtp-Source: AGHT+IH5EysKla9gMnaPAFHRGkBdj66Ujtdad+jmPuEGAF4TxRvkG3qWjbp6PhDIh9aPwK9b657aJg==
X-Received: by 2002:a17:902:e80a:b0:1bc:4415:3c1 with SMTP id u10-20020a170902e80a00b001bc441503c1mr681699plg.7.1696445221141;
        Wed, 04 Oct 2023 11:47:01 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.93])
        by smtp.gmail.com with ESMTPSA id j13-20020a170902c3cd00b001b9d95945afsm4063903plj.155.2023.10.04.11.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 11:47:00 -0700 (PDT)
From:   Ayush Singh <ayushdevel1325@gmail.com>
To:     greybus-dev@lists.linaro.org
Cc:     Ayush Singh <ayushdevel1325@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        vaishnav@beagleboard.org, jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 3/3] dts: ti: k3-am625-beagleplay: Add beaglecc1352
Date:   Thu,  5 Oct 2023 00:16:38 +0530
Message-ID: <20231004184639.462510-4-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004184639.462510-1-ayushdevel1325@gmail.com>
References: <20231004184639.462510-1-ayushdevel1325@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BeaglePlay board by BeagleBoard.org has a CC1352P7 co-processor
connected to the main AM62 (running Linux) over UART. In the BeagleConnect
Technology, CC1352 is responsible for handling 6LoWPAN communication with
beagleconnect freedom nodes as well as their discovery.

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

