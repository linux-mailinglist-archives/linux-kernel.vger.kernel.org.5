Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839C67CC047
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343660AbjJQKLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343649AbjJQKLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:11:38 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B88FA;
        Tue, 17 Oct 2023 03:11:35 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c9a1762b43so44075095ad.1;
        Tue, 17 Oct 2023 03:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697537495; x=1698142295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdZHxOOzFLZn0VZMmX6FQaeZ+Bg8TaP/zYXcfd62xjk=;
        b=K7DVooVv8x7/FtT8Zjmu0aijlCQX723olTGyLQtKCNEjzovcF7kKZ5qVchBtoel4jU
         RntZ7hZvqj2sqloWlhB/B3VWgj07Oqoh7T28Z3jq1rfj0swMfowOr3nHTMTAlDqiSpnR
         t2A5nBO3Ute4t7y3DN5DLfgvKj2XECC9VHCMhM/lTaTUJ+KTPhUzrwy2CWoZHHsiMnq+
         B/Rnqmg+KQkZY1CwL8Yjl1xI3eX3LO6lA0FgjJQq6EwlJ4Z7zbpGhbd3bcllZJ/TWyqH
         dOzd656pnl1N3Qzp0Ukk8KfGnLsX5VYzlnfXyipM9u3M1t/Q9j1UxgqYGB8DKll2983D
         NG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697537495; x=1698142295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdZHxOOzFLZn0VZMmX6FQaeZ+Bg8TaP/zYXcfd62xjk=;
        b=UiwuqRb2v4pRE8DGaXrXvz7rm0bIviDW3qOrBx5rjosHanjoX27X3CpRy1lJqYaLUt
         ntCVCCKsb9j7D+PJM/zCfpcy5VVuMC1LY75BDEkKoYtNK8k/QwuJ8NmX6EWMRghg9H//
         8WhXPQCjFsJ3p62gR9xz2xgSX2OJaCW/B9ej/B92ZDkt4HcbebIcsvo48wZ0QvulOWeb
         KTIeiyMa4A6HjxA8IwjSwIM+oJrn5NjWHqZk/EJB3vuSe1Maeqp4FNba+pVuKxC2N3Qt
         yJ3F2VAz0FOn8DsKo/3E7Lknq4WjOOqpvI5JBbKZ5DVZO8C4Q2LgxrncGBcZLhE5z9cB
         c3NA==
X-Gm-Message-State: AOJu0YxychDHw57Vk7JlFXrTWAfLez1pqsrgbu/NizEw30k0XHt9c0EH
        z+P/80wfutDp8W1okvB2qzbFhltg5pOzPQ==
X-Google-Smtp-Source: AGHT+IHQXTP0m+NaoCHVUd8uWZQaMgS9sF8ezdPJ0f/jGcALWbjn+T04o1aN+MFG8Kf+5mQ+l+ionA==
X-Received: by 2002:a17:903:5cc:b0:1c7:23c9:a7db with SMTP id kf12-20020a17090305cc00b001c723c9a7dbmr1742966plb.26.1697537495397;
        Tue, 17 Oct 2023 03:11:35 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902dac900b001bbb8d5166bsm1127634plx.123.2023.10.17.03.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 03:11:35 -0700 (PDT)
From:   Ayush Singh <ayushdevel1325@gmail.com>
To:     greybus-dev@lists.linaro.org
Cc:     Ayush Singh <ayushdevel1325@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        vaishnav@beagleboard.org, jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 3/3] dts: ti: k3-am625-beagleplay: Add beaglecc1352
Date:   Tue, 17 Oct 2023 15:41:14 +0530
Message-ID: <20231017101116.178041-4-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017101116.178041-1-ayushdevel1325@gmail.com>
References: <20231017101116.178041-1-ayushdevel1325@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index 7cfdf562b53b..d2e0b11242b6 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -870,6 +870,12 @@ &main_uart6 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&wifi_debug_uart_pins_default>;
 	status = "okay";
+
+	mcu {
+		compatible = "ti,cc1352p7";
+		reset-gpios = <&main_gpio0 72 GPIO_ACTIVE_LOW>;
+		vdds-supply = <&vdd_3v3>;
+	};
 };
 
 &dss {
-- 
2.41.0

