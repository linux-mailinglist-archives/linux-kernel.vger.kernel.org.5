Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269CD79C7EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjILHQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjILHQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:16:10 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EC3C3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:16:06 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-501eec0a373so8538970e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694502964; x=1695107764; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2/KIKPFYXssxMONjHLHuMJMnHmj1MCubEAe8nNGK/4=;
        b=hHFVea13AMO4gOOd4u08858OSIfflCxsFargoMCAX0wKWZ10cgIYfj3nxL9RXGPrvb
         Vuy5eMyym1ZX/gJVZBsnC/fd+Yjdm1a6qdEksEKhMzk+7NdDOsXiBXSFRfpfYwCWzKj7
         UC7VD9ayFuEK8b89FJzmBZCUflponMCo0rx9M9rPC1kuBPi+M6CXAY0W85+LMtdgtxjM
         /iWwAaCJ6Jfm/JStFExZ2TUEP86Z/4FEZ8NMYGFzX6keK0lvDWrDVLhG3D5SCq3iE5iS
         k7jX7tw1nlTE7O2BDjNZ7/TiR+KtDfgIf1aEJjNnTWBxgPx3+1UqZKiz+DLdpAg+5YNW
         gLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694502964; x=1695107764;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2/KIKPFYXssxMONjHLHuMJMnHmj1MCubEAe8nNGK/4=;
        b=ZfkYsRDr1Dx6yz7bSxy/iIv1bT+C5pnu13DgtMiOYhV/WtoLgqaTJfjG10EWg3YT6u
         42gUNAoSiuEHY5YKrsiHErYAmC52EWKPIlx6wrk78AKpdgMhJEU8i+jnkRtXVo07lQA7
         UnuHQ//G3GamaWz+UoaYESFsMeZBFPZc2v3tZxcIQDB8G+n/l4CWjb50I/bGBZfKd8uW
         aMzOHGd/emE4+103ndeXCJOJ6co0KMz+OYiBC0BT8hlfoHx5wLAuSnfvMIOjVd2KsuKc
         d7uv5bQWA7Lv1b4hezhp85jvYmxDhdB9gMkPOLFZ4pw7x2meU87zqCQhYJVW8vovPUbu
         T3PA==
X-Gm-Message-State: AOJu0Yxpa8OEroG0GiO/Fe5vz78tKAIzhqI0PBe9+cRfpd0TKed81+Gj
        FZmZM0Ak18OT8hfV0r8B9d4pjw==
X-Google-Smtp-Source: AGHT+IGAwg+Jn0hf9cwRW0hxA2ESXPQgYA3bczaEUYJftDOqfnYAb2wDUm194Ifk2eI21uvddGoDPw==
X-Received: by 2002:a05:6512:2396:b0:500:b9e3:91b1 with SMTP id c22-20020a056512239600b00500b9e391b1mr11413075lfv.24.1694502964415;
        Tue, 12 Sep 2023 00:16:04 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id f8-20020ac25328000000b004fe20d1b288sm1626872lfh.159.2023.09.12.00.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 00:16:04 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Sep 2023 09:16:03 +0200
Subject: [PATCH 2/2] ARM: dts: integrator: Fix up VGA connector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-versatile-dts-v6-7-v1-2-a2734f1757e7@linaro.org>
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

The VGA connector is actually named "J30" on the board so give it that
name in the device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/arm/integratorap-im-pd1.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/arm/integratorap-im-pd1.dts b/arch/arm/boot/dts/arm/integratorap-im-pd1.dts
index 7072a70da00d..367850ea0912 100644
--- a/arch/arm/boot/dts/arm/integratorap-im-pd1.dts
+++ b/arch/arm/boot/dts/arm/integratorap-im-pd1.dts
@@ -129,8 +129,6 @@ button@5 {
 
 	bridge {
 		compatible = "ti,ths8134b", "ti,ths8134";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		ports {
 			#address-cells = <1>;
@@ -154,6 +152,7 @@ vga_bridge_out: endpoint {
 
 	vga {
 		compatible = "vga-connector";
+		label = "J30";
 
 		port {
 			vga_con_in: endpoint {

-- 
2.34.1

