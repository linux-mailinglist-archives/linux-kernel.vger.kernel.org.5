Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70989801F1B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 23:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjLBWgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 17:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjLBWgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 17:36:02 -0500
X-Greylist: delayed 336 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Dec 2023 14:36:06 PST
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9043125;
        Sat,  2 Dec 2023 14:36:06 -0800 (PST)
Received: from newone.lan (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 8756A1612AD;
        Sat,  2 Dec 2023 23:30:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1701556228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XspAsrkCXlpUdpjb7XVP7a4O4n0C4JQNFCB+VTfuIHM=;
        b=2XCUuxMPRVY70307cESv+j11kw6NvpSHZnMoNpheW6qAIpAVsC3JbCWNuepVUHAdxLWwb3
        4qBBYTcq7w39ZGfvEBuIUCEIeCxUjOX0DmaZCgCJ88WIlylxxuZnv9xdfa6kOoq6mDL1Qv
        GFEJqHJJtKT0ucQQbGeqYWAWE177vI4=
From:   David Heidelberg <david@ixit.cz>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        David Heidelberg <david@ixit.cz>
Cc:     Thierry Reding <treding@nvidia.com>, Wei Xu <xuwei5@hisilicon.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] ARM: dts: tegra30-ouya: make dts use gpio-fan matrix instead of array
Date:   Sat,  2 Dec 2023 23:29:03 +0100
Message-ID: <20231202222934.137191-4-david@ixit.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231202222934.137191-1-david@ixit.cz>
References: <20231202222934.137191-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes.

Adjust to comply with dt-schema requirements
and make possible to validate values.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm/boot/dts/nvidia/tegra30-ouya.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nvidia/tegra30-ouya.dts b/arch/arm/boot/dts/nvidia/tegra30-ouya.dts
index 7e3de26ca960..c284dd0a55ab 100644
--- a/arch/arm/boot/dts/nvidia/tegra30-ouya.dts
+++ b/arch/arm/boot/dts/nvidia/tegra30-ouya.dts
@@ -4611,8 +4611,8 @@ cpu3: cpu@3 {
 	fan: fan {
 		compatible = "gpio-fan";
 		gpios = <&gpio TEGRA_GPIO(J, 2) GPIO_ACTIVE_HIGH>;
-		gpio-fan,speed-map = <0    0
-				      4500 1>;
+		gpio-fan,speed-map = <0    0>,
+				     <4500 1>;
 		#cooling-cells = <2>;
 	};
 
-- 
2.42.0

