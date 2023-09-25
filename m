Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BC07ADB25
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjIYPPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjIYPPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:15:04 -0400
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E22101
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1695654892; x=1698246892;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Aztr3VYtO8kOtoJBuY53Z9iJWLMmwPwq9fsB2RzDtKk=;
        b=AnBSQtaPa9MTodUaSH+SFciBGM7DR5ig4na9sM40UjF6Jb34TgyJQHK1w7qhjLIV
        n9/k2Oin/9H1dXYM6XvGuMDs16OJK7o47mP1NSbEPus8a0qVGoD9rhQOMdSCygld
        1E7/WveNSA3ZSwRNcxuTSYm+Rri8yWKVRjkekjCMNfI=;
X-AuditID: ac14000a-6d65670000001e37-95-6511a3eca3b2
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 3E.42.07735.CE3A1156; Mon, 25 Sep 2023 17:14:52 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 25 Sep
 2023 17:14:52 +0200
From:   Wadim Egorov <w.egorov@phytec.de>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <keescook@chromium.org>,
        <tony.luck@intel.com>, <gpiccoli@igalia.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: [PATCH v2] arm64: dts: ti: k3-am625-beagleplay: Fix typo in ramoops reg
Date:   Mon, 25 Sep 2023 17:14:44 +0200
Message-ID: <20230925151444.1856852-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42JZI8nAo/tmsWCqwdv/0hZr9p5jsph/5Byr
        xbzzh9ktznTnWiz/PJvdou/FQ2aLTY+vAcXX/2S0uLxrDpvFmx9nmSxa9x5ht3hz4R6LRfc7
        dYv/Zz+wO/B5zG64yOIxYXY3m8fiPS+ZPDat6mTzuHNtD5vH5iX1Hv3dLawex29sZ/L4vEku
        gDOKyyYlNSezLLVI3y6BK+P4ywvsBZs4Kpbs2s/awNjA3sXIySEhYCJxr28HSxcjF4eQwBIm
        iYk/37KBJIQEnjBKTLuiD2KzCahL3NnwjRWkSETgCqPElgNz2EEcZoHVjBKz3m5nAqkSFgiQ
        6J36lBXEZhFQlbjccogZxOYVsJS4u24HM8Q6eYmZl76zQ8QFJU7OfMICYjMDxZu3zmaGsCUk
        Dr54wQxxhbzEi0vLWWB6p517DTUnVGLrl+1MExgFZiEZNQvJqFlIRi1gZF7FKJSbmZydWpSZ
        rVeQUVmSmqyXkrqJERRLIgxcOxj75ngcYmTiYDzEKMHBrCTC++sZX6oQb0piZVVqUX58UWlO
        avEhRmkOFiVx3vs9TIlCAumJJanZqakFqUUwWSYOTqkGxrXSqzYZ9P9wPF/s7Z/ROC27aK7U
        7DdfozK9tnGItkWbbmru5sgU3Ol4UaFZVy4u6AErS5DZkcM8yzoatSeFbRLpX1Mcvnz9o87Z
        PxX27okyc+yLNC1baHp3x0PLycpc3Qdea5itk+h2iJVpOif1kTfs7ufvF5f0To3mfq4YkO42
        RV1C/t0TJZbijERDLeai4kQA4eOXKJMCAAA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems like the address value of the reg property was mistyped.
Update reg to 0x9ca00000 to match node's definition.

Fixes: f5a731f0787f ("arm64: dts: ti: Add k3-am625-beagleplay")
Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Reviewed-by: Nishanth Menon <nm@ti.com>
---
v2:
  - Add Fixes: f5a731f0787f ("arm64: dts: ti: Add k3-am625-beagleplay")
  - Add Reviewed-by: Nishanth Menon <nm@ti.com>

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

