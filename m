Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B902F790931
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 20:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjIBS3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 14:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjIBS3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 14:29:40 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F49810F0;
        Sat,  2 Sep 2023 11:29:36 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68c0d262933so92836b3a.0;
        Sat, 02 Sep 2023 11:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693679376; x=1694284176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnrT7LHJjUAagSGCNBHonhWO840GVzI76QQJKTy0U0o=;
        b=CL0eI76EZtaH66cY9GuSviVKG30QxD7m0VmLdjKLT/u1pki/13B79pKgO/WRzPSBcb
         4gCDz8N1oWvMXWncCZcVg5kYElUPhJYMbf1kT0C72jiPo8zxeMsQ6vR9eIK8fOa4Jw2O
         tSiTVfA/8OfQ8ymBU9x14l7caSJAVtzHavoHX3oEFD08SdOQGAqjPu/AaopaT7O9ssSI
         HS2egYl6GyXv0kPpoGWDoJPdVh4ikalAWpdDJyD/lC2fGwa5KbL4B/g5+8tcZhLqUSDc
         7xGepAM6rQvz8mR0/5gE/N/NyuL09gIImLr31VyP0eepW1rfQpvALCHtuWsLr5JqDhcu
         GP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693679376; x=1694284176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnrT7LHJjUAagSGCNBHonhWO840GVzI76QQJKTy0U0o=;
        b=iz3/dar326rDPG+qNF+QGP5SNgyhNFPzPog+j0wNpnau/FkKporkBRVxOjTtMQQGeP
         3C6rQsQ0kIuga5D8OvFagEykoTXqOjOZH2R2WtV8XTadBEz+kJvNkl1Oy2kouhezntX6
         9i6lDLSgZS1nSMGvxCdDY6PaNrn34Zfm34ivhTItdf3J3hOKAsyDhNSzJ2MZLFlnMp0u
         qN+rhaL9QAX+suyTczyzcSG89t5fB6F6MTpAV05apPPYF8soBqpchQzRycdozmxH0vKE
         eNvpM5Ysa0A1x4SnCu9bG62hzbSEqw9JdSXuAC+OByY5lV8PbmucdXWgXwWW7mEtV5zQ
         hqMg==
X-Gm-Message-State: AOJu0Yx+8RsEanK+G2FdmkVwZjeCkN4/8GmQc/l1OlvCQaNxUD7opCmw
        C9TW30Xl1U2qm/BApxnl4VV0Kml/4DA=
X-Google-Smtp-Source: AGHT+IFyh/QK01pwrTqOJo0jEmHr/IuRlq/pYy1squww9SSU2If6HdRuDy0sTSLQ0E0NRXRHYegpnQ==
X-Received: by 2002:a05:6a20:8f17:b0:138:1c5b:2653 with SMTP id b23-20020a056a208f1700b001381c5b2653mr6667590pzk.41.1693679376415;
        Sat, 02 Sep 2023 11:29:36 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.93])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902eb4600b001bf846dd2d0sm4918970pli.13.2023.09.02.11.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 11:29:36 -0700 (PDT)
From:   Ayush Singh <ayushdevel1325@gmail.com>
To:     greybus-dev@lists.linaro.org
Cc:     Ayush Singh <ayushdevel1325@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Vaishnav M A <vaishnav@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH v4 3/3] dts: ti: k3-am625-beagleplay: Add beaglecc1352
Date:   Sat,  2 Sep 2023 23:58:43 +0530
Message-ID: <20230902182845.1840620-4-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230902182845.1840620-1-ayushdevel1325@gmail.com>
References: <20230902182845.1840620-1-ayushdevel1325@gmail.com>
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

The BeaglePlay board by BeagleBoard.org has a CC1352 co-processor. This
co-processor is connected to the main AM62 (running Linux) over UART. The
CC1352 can run Zephyr and other embedded OS. This commit adds support for
the CC1352 in the Linux kernel DTS. This allows Linux platform drivers to
identify the device and communicate with it.

This UART is used by gb-beagleplay, an upcoming Greybus driver for
BeaglePlay.

Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index 7cfdf562b53b..10abbb8feda5 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -870,6 +870,10 @@ &main_uart6 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&wifi_debug_uart_pins_default>;
 	status = "okay";
+
+	beaglecc1352 {
+		compatible = "beagle,cc1352";
+	};
 };
 
 &dss {
-- 
2.41.0

