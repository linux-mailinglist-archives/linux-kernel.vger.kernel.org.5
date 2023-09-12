Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D947379C7EA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjILHQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjILHQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:16:09 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69366E79
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:16:05 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-502934c88b7so8413636e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694502964; x=1695107764; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1jzu3ICRlRuOqr6KXi9pg4tZ+npWXS+/xVE204wn68=;
        b=IqoD7qf3i8IL80BzGIVO0ztfIjvWO3VgD26olcFbrL9mdIqQgF3M7Z2tUyvQjzo8Rc
         NDTfVgRKbQr5LQQc0c8XP2Vy+xWy57UaDkqi18Wfw9lNjKiJOKRahEZlGVBTAKtEtb/1
         zwmmvQqEsceMOYhFH3EadcyKLCe9B9JbMyj1D7m83jvtDCqlJTGlmeOloHCKJO5j83wt
         0XbiWQg9S2cJy4XhrJtKsV+XnXpwLl+NsrXt3pFcydO/ldfSNHjD8KcUUw+X/Itzgup8
         Wxj/CkYUZrOe5ufN29DePGpPj7sDjQbwug5JNUWHAripJg4fVz2RmyawP+e3lq2kfkdP
         a4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694502964; x=1695107764;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1jzu3ICRlRuOqr6KXi9pg4tZ+npWXS+/xVE204wn68=;
        b=ASHr3BFAMqopW0wOpbjG3SwobUjmjIPphLHJ1pZsQjZ+hR6SKJ+/A2SCXf23/G2vOX
         +jfNQgYyGud/Tfvd4YJlIgMVKC2gV7q3PcDBD+wjcvBnFlQ0+cb/LqLt+Bf6HuTkeoBD
         fCeREWL8LB48+4j1EarkoyaMKooIHKY0Cmy4CcMH1zlskeDSNs0jx5QdwV+z3fuTRD0P
         5QtszX0+Nenm+6IRovTjUyuiCshTsBM17JFOt98C/BGYZ1hIPpzqxTzQgzoqyAgWOZx6
         v/9njkP0T65XrSsXPyQPkTotGa/stowSwP0OXmSPkeFj619sDtSRnL5eeF/AQjQ5/DNc
         w25A==
X-Gm-Message-State: AOJu0YxnJgWiE0Ci+K+AaOmQh96Bqskx4w1u3R9xVczkfFmOLcDZO1lT
        QRRCF58b963ownNE+S/VICzqmg==
X-Google-Smtp-Source: AGHT+IG+ijoG4xhCgyGr/TJwh9pgBHvbMTZu2K8XqqMlqy9lWAR+uwzm96wIUBxzxSTekATYYJ9MWw==
X-Received: by 2002:a05:6512:1094:b0:500:7c51:4684 with SMTP id j20-20020a056512109400b005007c514684mr12580257lfg.56.1694502963636;
        Tue, 12 Sep 2023 00:16:03 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id f8-20020ac25328000000b004fe20d1b288sm1626872lfh.159.2023.09.12.00.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 00:16:03 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Sep 2023 09:16:02 +0200
Subject: [PATCH 1/2] ARM: dts: versatile: Fix up VGA connector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-versatile-dts-v6-7-v1-1-a2734f1757e7@linaro.org>
References: <20230912-versatile-dts-v6-7-v1-0-a2734f1757e7@linaro.org>
In-Reply-To: <20230912-versatile-dts-v6-7-v1-0-a2734f1757e7@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bridge does not have any cells on the node level, just on the
ports.

The VGA connector is actually named "J1" on the board so give it that
name in the device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/arm/versatile-ab.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/arm/versatile-ab.dts b/arch/arm/boot/dts/arm/versatile-ab.dts
index f31dcf7e5862..de45aa99e260 100644
--- a/arch/arm/boot/dts/arm/versatile-ab.dts
+++ b/arch/arm/boot/dts/arm/versatile-ab.dts
@@ -32,8 +32,6 @@ xtal24mhz: xtal24mhz@24M {
 
 	bridge {
 		compatible = "ti,ths8134b", "ti,ths8134";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		ports {
 			#address-cells = <1>;
@@ -59,6 +57,7 @@ vga_bridge_out: endpoint {
 
 	vga {
 		compatible = "vga-connector";
+		label = "J1";
 
 		port {
 			vga_con_in: endpoint {

-- 
2.34.1

