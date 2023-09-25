Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136CD7AD9B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjIYOHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjIYOHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:07:30 -0400
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C0CCE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1695650840; x=1698242840;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MEYxuz1Uw+VReTSa6PXtiqg+xBQ1tt+ZjnGvZk0sYws=;
        b=a8l0irkyH0tn3osUvH57okwDktBI5iEMP3HQBVhH/oM5euNy6qpHI3G0oetRVBau
        PgDqfG4Nh84oMChggAElbWvRP1giJKaRm7ZysfUVrpuOY0I82OmInqU1fXJBYhPV
        YlxYH2gcGR65t6gewHobru3Q8GfSN7cSJvdJRuBx7yY=;
X-AuditID: ac14000a-6d65670000001e37-fb-65119417c4c9
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 9E.91.07735.71491156; Mon, 25 Sep 2023 16:07:20 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 25 Sep
 2023 16:07:19 +0200
From:   Wadim Egorov <w.egorov@phytec.de>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <keescook@chromium.org>,
        <tony.luck@intel.com>, <gpiccoli@igalia.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: [PATCH] arm64: dts: ti: k3-am625-beagleplay: Fix typo in ramoops reg
Date:   Mon, 25 Sep 2023 16:07:10 +0200
Message-ID: <20230925140710.478027-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWyRpKBR1diimCqwYmzTBZr9p5jsph/5Byr
        xbzzh9ktznTnWiz/PJvdou/FQ2aLTY+vAcXX/2S0uLxrDpvFmx9ADa17j7BbvLlwj8Wi+526
        xf+zH9gd+DxmN1xk8Zgwu5vNY/Gel0wem1Z1snncubaHzWPzknqP/u4WVo/jN7YzeXzeJBfA
        GcVlk5Kak1mWWqRvl8CVcfLdScaCQ2wV/ZcDGxh3sHYxcnJICJhI3H/5nKmLkYtDSGAJk8Sq
        g3uZIZwnjBJXT19nA6liE1CXuLPhGytIQkTgCqPElgNz2EEcZoHVjBKz3m5nAqkSFvCVuHa1
        jxHEZhFQlXi7rh2og4ODV8BCon1vCMQ6eYmZl76zg9i8AoISJ2c+YQGxmYHizVtnM0PYEhIH
        X7wAs4WA4i8uLWeB6Z127jUzhB0qsfXLdqYJjAKzkIyahWTULCSjFjAyr2IUys1Mzk4tyszW
        K8ioLElN1ktJ3cQIiiQRBq4djH1zPA4xMnEwHmKU4GBWEuH99YwvVYg3JbGyKrUoP76oNCe1
        +BCjNAeLkjjv/R6mRCGB9MSS1OzU1ILUIpgsEwenVAOj+CxN3WWJXB9Pn525KUz3IAdPu7no
        GwOGZSJa/zxvH72vdaLyXUDPX8N77VYSVwrXfp7PNfnUs9gV7kYNDN6fL7/8qxPArLjJZaLT
        B/u1nMYpxeJrNLiCy5NL9rPKHtVbsbHTTvBryclljHvzSj6LcE1d7mP157xYYaYik/2iW1cT
        2cw85jopsRRnJBpqMRcVJwIA2fvwtpICAAA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems like the address value of the reg property was mistyped.
Update reg to 0x9ca00000 to match node's definition.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index 7cfdf562b53b..2de74428a8bd 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -58,7 +58,7 @@ reserved-memory {
 
 		ramoops: ramoops@9ca00000 {
 			compatible = "ramoops";
-			reg = <0x00 0x9c700000 0x00 0x00100000>;
+			reg = <0x00 0x9ca00000 0x00 0x00100000>;
 			record-size = <0x8000>;
 			console-size = <0x8000>;
 			ftrace-size = <0x00>;
-- 
2.25.1

