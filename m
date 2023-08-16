Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8173777E183
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245158AbjHPMZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245145AbjHPMZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:25:21 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B28026B1;
        Wed, 16 Aug 2023 05:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=4DazX9eS7z6S0Y9/ixJPGOqmAYYUyd7bfz0vK4l0qWc=; b=lc/2tatXOR+VZnA2Id51TlGTHp
        cabyUwxPJgb/1MWlD7pgZclu64TdgoMiQbCiRsON26lmyUbysBpfHCz3astNp14z6VjuV08tWJ/YO
        sL1lATPTMdStvD+8Crp2X8kcQlQBOQKYElAkp9t+LtFCnOxf7G2muEC/wKfnfieXrV16ZEX4ns2Yl
        l5ZtnSHxNYTAYPZGcBmHZRW395/7zr6lI9qUTuyWl0nddQjTc3t7pRvwhFlCy4eSWdBm/WLVmNJQh
        4+a/+jj9aYPK2arXJPGyRdJGhZWvcJlN/OVFtXT9PgV26zBKiYF+lXd2xS7l1EptCKRXF5eg3hhrq
        2hYaSdDA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1qWFaI-000NBJ-QP; Wed, 16 Aug 2023 14:25:10 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1qWFaI-000HIl-3v; Wed, 16 Aug 2023 14:25:10 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     l.goehrs@pengutronix.de, a.fatoum@pengutronix.de,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Sean Nyekjaer <sean@geanix.com>, dantuguf14105@gmail.com,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/9] ARM: dts: stm32: osd32: fix ldo2 not required to be always-on
Date:   Wed, 16 Aug 2023 14:24:25 +0200
Message-ID: <20230816122435.3153513-5-sean@geanix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816122435.3153513-1-sean@geanix.com>
References: <20230816122435.3153513-1-sean@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/27002/Wed Aug 16 09:38:26 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the OSD32MP1 Power System overview[1] there is no hard
requirement for the ldo2 to be always-on.

[1]: https://octavosystems.com/app_notes/osd32mp1-power-system-overview/#connections

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Acked-by: Leonard Göhrs <l.goehrs@pengutronix.de>
---
 arch/arm/boot/dts/st/stm32mp15xx-osd32.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp15xx-osd32.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-osd32.dtsi
index eb43a1e3a0c9..902ca6c23533 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-osd32.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-osd32.dtsi
@@ -124,9 +124,7 @@ v3v3_hdmi: ldo2 {
 				regulator-name = "v3v3_hdmi";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
 				interrupts = <IT_CURLIM_LDO2 0>;
-
 			};
 
 			vtt_ddr: ldo3 {
-- 
2.41.0

