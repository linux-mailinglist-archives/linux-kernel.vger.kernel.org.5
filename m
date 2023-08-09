Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDE1776918
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbjHITr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjHITrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:47:11 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809042109;
        Wed,  9 Aug 2023 12:47:11 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379Jl5Yu082664;
        Wed, 9 Aug 2023 14:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691610425;
        bh=FbAbSqwRAV98u35zcv0xFNhxf2gVaiT10GEUTg0GYws=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=ZovuTH6TuMLeFOC58Dx5PWbSWe055s2QXfHmtkzggX23S1m9TmeNI/fYn4xzMwgqf
         7t8ZMJsnAfCN/7962OK1Z/f58DZbAHP9dsLt5la/4k+VulVqESkDrK6Q1/Sn2OvU+t
         bdkOu7Bc8fyhqxco+SY1BpASgOs7Hxgqc16GSzvY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379Jl5qL032343
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 14:47:05 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 14:47:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 14:47:05 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379Jl49g051091;
        Wed, 9 Aug 2023 14:47:05 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Thu, 10 Aug 2023 01:16:25 +0530
Subject: [PATCH v6 7/7] arm64: defconfig: Enable TPS6593 PMIC for SK-AM62A
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230810-tps6594-v6-7-2b2e2399e2ef@ti.com>
References: <20230810-tps6594-v6-0-2b2e2399e2ef@ti.com>
In-Reply-To: <20230810-tps6594-v6-0-2b2e2399e2ef@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Apurva Nandan <a-nandan@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Esteban Blanc <eblanc@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <jpanis@baylibre.com>, <u-kumar1@ti.com>,
        <j-luthra@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>,
        Hari Nagalla <hnagalla@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=867; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=hroXKt4UiC2VoiKH6paD4EdlOF8Nc0+Xt9cB4nm60x4=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBk0+00JaLbfPIxMLpqeSZF0hLU3vHBruDLjjEPv
 dNSRY9aJ4WJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZNPtNAAKCRBD3pH5JJpx
 RS3CEACLETmwIr+wlznCO3XXAWR0N+fpcJLXE9Soj2+E6mZ1/Fy4yuc1Jcl2PLIJN/kP0JqQpfP
 5JeuF3TkHXQDSuvJNeg01B15CSlY/6D6GlI7caJoVbMamHsXucz38zRsngIYoW+p5XLIxIFp9jR
 lXma/sByjD2XJE+Urzfq8LKmfVmimbNT2tg/xbp8ZfFqIEKa7A2sDlG/crpEKrp6CF8c7EMvrdh
 xfDfaktkJ8NfuvPoWM8eypT4GdgPgXu/1U0dV5gNhLhgUOLxpCdrrWQSM+AQwbD8faXdJAiRI8i
 RzECa3qEUr2PN99OxH0kXGqaQ/whgBeZBGNtM1ja00R7nEHHwubgAiuLzdN/T/tKjpmN+DgUNey
 D2D6j28uMKSy5Id4c7kCej3m+h3e2kLKEV6mMESOXljp7AMvXDC+W96aJ4sNUxo/7Yf0c2e7z7T
 oyooX+ueRpK3XUTxIchHDair7NpMc08I1ghC7H5LoCvilQNlEha4+WloMdrZGUo/ql7d6JhfsFK
 ELWYv9+LsNada+k3vJnYGWTRHdlQySVvcXnKcFBjn+kkccVXmSb3XLZO/Vs4JqiZWYAWHjsT5Uz
 CMbHIHfBksoBOyWYoVoV1j20o3DO+GaCrs1OlnrREDRKdTkk8jymIn69g1ML/Bn3Ja2DLpOald0
 b4vF0mEcVf4pIVA==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SK-AM62A-LP uses TPS6593x PMIC (interfaced over I2C) to power the SoC
and various other peripherals on the board [1].

Specifically, the audio codec (TLV320AIC3106) on the board relies on the
PMIC for the DVDD (1.8V) supply.

[1]: https://www.ti.com/lit/zip/sprr459

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index bf13d5c46578..9f7697caa5ca 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -719,6 +719,7 @@ CONFIG_MFD_SEC_CORE=y
 CONFIG_MFD_SL28CPLD=y
 CONFIG_RZ_MTU3=y
 CONFIG_MFD_TPS65219=y
+CONFIG_MFD_TPS6594_I2C=m
 CONFIG_MFD_TI_AM335X_TSCADC=m
 CONFIG_MFD_ROHM_BD718XX=y
 CONFIG_MFD_WCD934X=m

-- 
2.41.0

