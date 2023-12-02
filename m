Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45059801CCA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 13:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjLBMwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 07:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjLBMwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 07:52:00 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0428E18C;
        Sat,  2 Dec 2023 04:52:06 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54c5ed26cf6so1992507a12.3;
        Sat, 02 Dec 2023 04:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701521524; x=1702126324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvqh3YsIrEQFTmWeg+MPEc2rGBC/JrpRd/TYuGzYb50=;
        b=YOG4ixL6jUh9MlGv/w74on9he66ZRyG1UfdLT9e+GwCZds6+8Nqzn5MpYII7XoFRmz
         FS0VLVEWoTgDB6ugoiYf205j3hv4i0E5LbrkNMnEcW5WS9OLFvHTgP46gnoTHlpLo4Xg
         Zhev5WQJfazHvnjiNd1rrwqOsZDsxl1Yo5L1xzPxVmiQl3lX9tyUSfDjNXsgznxl3P2H
         rtT4f4npzx9Cajd4PIpEJXLU1fwlREBdeUhNRA9CFWj6ffdRR2u4x+c0bWcgYohAywZO
         ysVVLZknoSXBqnfZyaLI3pIImRt24zyOG8mJn3J57q+US9DsVFq9wBHYvi4zbhTNleqQ
         5OuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701521524; x=1702126324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvqh3YsIrEQFTmWeg+MPEc2rGBC/JrpRd/TYuGzYb50=;
        b=AV9f3X5bM0WxyXI8QJpHMD4kzgnPTtrrudkll1GzSnaeWIaBU4wStfvOPmYP9Vbu7V
         XNrD49+dq4ayzu1+38V4Njw2LFVWiNplZ4L95mA9v57CgWNSy1rEtCSUZYi2uI52Fcht
         yRibEBT/KH45avZOIcjqn6dsxIjTi6JZVqJ7nSJSjiAc/HeGgw7eVwdTbA0IITBelJnP
         HcKvbWhWP25b7OKzhUiTRKthGLFzsfyZhj38qINHc6FEEWfcfH4FfTYG4/9bxp9iafeT
         /Br+qkb14LnE6+5tP/WHyHPz3+yeARjlX3MBnVE4rtQcnuGbr9pcJqbofVQPwNgotzwo
         SJbw==
X-Gm-Message-State: AOJu0Yx9qUcCkuueMbBHDm0j88k8TKfZLtU9iiCC/7aVgannkRHb9Nq0
        pUUhDsqPj9oxhL0Vv1uPkA==
X-Google-Smtp-Source: AGHT+IFQ04hd02/k8ts4CI8E4zUUh78rM2JYghUB6DkvNvfM35AgawiZ8im+gUYqpmxxzX2y97BApA==
X-Received: by 2002:a17:907:bb86:b0:a18:f82c:65d2 with SMTP id xo6-20020a170907bb8600b00a18f82c65d2mr1932769ejc.34.1701521524226;
        Sat, 02 Dec 2023 04:52:04 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:908e:b829:354b:f8ee])
        by smtp.gmail.com with ESMTPSA id g5-20020a170906198500b009c5c5c2c5a4sm3018161ejd.219.2023.12.02.04.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 04:52:03 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 5/5] ARM: dts: rockchip: Enable GPU for XPI-3128
Date:   Sat,  2 Dec 2023 13:51:44 +0100
Message-ID: <20231202125144.66052-6-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231202125144.66052-1-knaerzche@gmail.com>
References: <20231202125144.66052-1-knaerzche@gmail.com>
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
index 61b9f069c8a2..0a8ead0bfe09 100644
--- a/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts
+++ b/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts
@@ -315,6 +315,11 @@ &gpio3 {
 			  "", "", "", "";
 };
 
+&gpu {
+	mali-supply = <&vdd_log>;
+	status = "okay";
+};
+
 &pinctrl {
 	dp83848c {
 		dp83848c_rst: dp83848c-rst {
-- 
2.43.0

