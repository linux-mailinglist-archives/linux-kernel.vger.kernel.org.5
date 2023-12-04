Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6084D8038EE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbjLDPgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344302AbjLDPfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:35:53 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C042CC1;
        Mon,  4 Dec 2023 07:35:58 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50bf26b677dso1358108e87.2;
        Mon, 04 Dec 2023 07:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701704157; x=1702308957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0MUcVwcu9FCifO7HjzlwPMDhi7mDLRFD1pK6+mohtM=;
        b=YoHd9GRBGglfyQIPjxx18tcMAVtcQGGwiFgm0X8GA2INqgg/EQyFF1xA2Q+GhZuI5P
         tAuVaCn2kF/lxEksEj0JZhkCTMT7CzCgscI0C2YTPSXOGZ8yx7ZEXNqgPyw2hz3vt0YH
         JqT/rPQ7oJe66waJZQCwAJPSl3jEtyB8nnt+Vya2R8/GvCYkH9jAOn6P91hK8iXVxL1F
         /N3PiYx2COmByWQ6o5Wo/33T1ZdOTnNq1oCzDo7EqF4HY2PcSKMSOKXzueKWMx5Edjzd
         c5qhz5xHPZYEIH/kYBg2At3myCJdbgIngi4oiS5B0ArDszqXeKkjRA8EFBoqOtWlXEUN
         44OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701704157; x=1702308957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0MUcVwcu9FCifO7HjzlwPMDhi7mDLRFD1pK6+mohtM=;
        b=spOHJBDYIE2z9IP6+6Ndqw59zde2GxhX0J8U2VpYucTgobWgEOf3ttPLSE0rlYc4sL
         CWV46wWb2Zs8h3V4WRBJYULfjGOjPZOAE+0GYy+J7p0tJv4x53B4hFLrccT1NOouhBdY
         yw91QHmYmwTUr10c8/vaElyyKl0RC024lWtvSfqSETnn26cJeuFUkf4z4MG9vDSssSf2
         DtB3HFNi/m+1i37j/zqv7X0E74AoagSB5NK8NX8X79pFfpEbnLs4y3jXuG4zJLpCMo7V
         kZRW76wIdgwpweb4se+coxDlj/OeHZ/wzuAwP0eCrVKY4xREVl6r1VYxnPPP1GLQe5qw
         iqIQ==
X-Gm-Message-State: AOJu0Ywst4wQTEeq1a1KXjmAHtJBfpNJsRxoViQiZ7zNOciroNioivd3
        U4NMwAa4NcGNg4/vcNN4qg==
X-Google-Smtp-Source: AGHT+IF3udiFN47bfrHu8XfBAJHpEV9pshrnM6X3NzNLynr7EilRiSdLH07zmbztsogo8QQSppXbUg==
X-Received: by 2002:a05:6512:281c:b0:50b:f9b2:d00 with SMTP id cf28-20020a056512281c00b0050bf9b20d00mr480709lfb.22.1701704156886;
        Mon, 04 Dec 2023 07:35:56 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:55ff:210b:5393:c9d7])
        by smtp.gmail.com with ESMTPSA id h20-20020a05640250d400b0054c77ac01f4sm693194edb.51.2023.12.04.07.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 07:35:56 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v3 3/3] ARM: dts: rockchip: Enable GPU for XPI-3128
Date:   Mon,  4 Dec 2023 16:35:47 +0100
Message-ID: <20231204153547.97877-4-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204153547.97877-1-knaerzche@gmail.com>
References: <20231204153547.97877-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the supply and enable gpu node for XPI-3128 board.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts b/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts
index e979425f11a0..de497f6e9456 100644
--- a/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts
+++ b/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts
@@ -328,6 +328,11 @@ &gpio3 {
 			  "", "", "", "";
 };
 
+&gpu {
+	mali-supply = <&vdd_log>;
+	status = "okay";
+};
+
 &mdio {
 	phy0: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-- 
2.43.0

