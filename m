Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B52878C5FC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbjH2NfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbjH2Nda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:33:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA212CC1;
        Tue, 29 Aug 2023 06:33:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8550365722;
        Tue, 29 Aug 2023 13:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13F5C433CA;
        Tue, 29 Aug 2023 13:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693315953;
        bh=VBzknaTaZotCbwVOa0C18oLzg8oXNQxSdFkUl27vCP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KVm7mzw8ZI7x6GLLNE36w5rUTLSUci4O8UFMYQ1vnxxZ9za4Zr9cBhNMWxtqx7PHx
         jmM3r8k+XxAcFkgDXwku4C1JTAr508medQ0ooSH5svtBSPkFPdSUN5AZ11Q4SdMg6v
         SMGQJdZ4gJU4AsGB35jf588jakyeJUwKBGlVWV6s3FT6ZvgKpYi3/lKBsM5xvGomqg
         uFC+HyP9Izv27H5zhM0vFh+dPAZD7fS1GBhKswGvyx2woCZTanSbFrBo3U1YXxuRlD
         to5EiVhhHG6F6dh3CgW8ibd1XqgL7hpXn2WLqmtEs6RTbYuj1+DHtcj//19cE15XLQ
         WEvwitQBvV0yQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lin Yujun <linyujun809@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 11/17] ARM: dts: integrator: fix PCI bus dtc warnings
Date:   Tue, 29 Aug 2023 09:31:58 -0400
Message-Id: <20230829133211.519957-11-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829133211.519957-1-sashal@kernel.org>
References: <20230829133211.519957-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.12
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lin Yujun <linyujun809@huawei.com>

[ Upstream commit 42ff49a1967af71772b264009659ce181f7d2d2a ]

An warning is reported when allmodconfig is used to compile the kernel of the ARM architecture:

arch/arm/boot/dts/arm/integratorap.dts:161.22-206.4: Warning (pci_bridge): /pciv3@62000000: node name is not "pci" or "pcie"

Change the node name to pci to clear the build warning.

Signed-off-by: Lin Yujun <linyujun809@huawei.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20230811-versatile-dts-v6-6-v1-1-d8cb9d1947ed@linaro.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/integratorap.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/integratorap.dts b/arch/arm/boot/dts/integratorap.dts
index 5b52d75bc6bed..d9927d3181dce 100644
--- a/arch/arm/boot/dts/integratorap.dts
+++ b/arch/arm/boot/dts/integratorap.dts
@@ -158,7 +158,7 @@ pic: pic@14000000 {
 		valid-mask = <0x003fffff>;
 	};
 
-	pci: pciv3@62000000 {
+	pci: pci@62000000 {
 		compatible = "arm,integrator-ap-pci", "v3,v360epc-pci";
 		device_type = "pci";
 		#interrupt-cells = <1>;
-- 
2.40.1

