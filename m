Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1377EEEA1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345830AbjKQJab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345752AbjKQJaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:30:08 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD6CD72;
        Fri, 17 Nov 2023 01:30:03 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AH9TXMh058787;
        Fri, 17 Nov 2023 03:29:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700213373;
        bh=CE16wh9zl1KgMuVJ0r2u9v6WuIGMBSyHIrUg3kv13nk=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=YCgluMwUd8suq94SZHXdXNR7vNQ+5lXaqR37nulSVvU0Z/HqIxnZBptLkpoFjpLip
         ohF1qQPIRY76Qa+1986xYm0KsVyZu5NkbaEwIvDXrsLVo2LN1Ls7iyFy+L4iqxPQLc
         93pUwZLXfWbDXUnNAHjIhWMKO1kgZATguyFHTT64=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AH9TX9r075646
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Nov 2023 03:29:33 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 17
 Nov 2023 03:29:33 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 17 Nov 2023 03:29:33 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AH9TW11125272;
        Fri, 17 Nov 2023 03:29:33 -0600
From:   Jai Luthra <j-luthra@ti.com>
Date:   Fri, 17 Nov 2023 14:58:09 +0530
Subject: [PATCH v2 1/9] arm64: defconfig: Enable AM62 CSI2RX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231117-csi_dts-v2-1-bf4312194a6b@ti.com>
References: <20231117-csi_dts-v2-0-bf4312194a6b@ti.com>
In-Reply-To: <20231117-csi_dts-v2-0-bf4312194a6b@ti.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Julien Massot <julien.massot@collabora.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1283; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=rUb+tMOTZAb+lVYb64icNGmFWgAhMwWgJGOMQV1XTKI=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlVzJsuaA30WzP72QhttVUNkNtw3tMHNph8yWp/
 rQA93smxKuJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZVcybAAKCRBD3pH5JJpx
 Rfr+D/sHMfFB4h7n0BFJsbJ+20P0uwCTUJ4L0GQ1Lwv7vp5ySZ5uRtVCkdNk5TOF0bDdqMybWYs
 I9VfMaizm8boY2h2mTIg//6YEOptYHMPPsTM0oC2VXNfZXudW4XBDwdX9+n23wAYStmi547KBCf
 yxUVRi0qPzw2As5iqf3H5Y12Twe59ZwVQfzhn9JHaoIe+0tiAUjyFK7r2vEStxgMnHsJotx0/WH
 VSHZVDiexIU8/ZQ9+r7emzjuaEI8mQZBl17JlAMfZIE/LWFsAdb3SRcjUukMPvnQUne1bzaZlg+
 +Jpn5+rzO5mv62K+NxhYholRTK748nq211EKNO4+Yn32HqyjNglgHF9H8eoFN7Nu/fIpf6Jc7ob
 x7OkH3OCt0PmVtb8QDodK4JJD7suepZT/EEMGxNqs+Ogsa6sUcg5MNggTC/swAyOZqchb6Bhzq9
 F267QewTmXQb9k+sRycbaRpqfPxW0i56FDnC737J05UszpVtfcIgU6twwDQwk9niqmSlJU9n9pe
 ZBJjff9kAjvMkhETKpEago6wYDETPh5y6IW96Zhc3oDC9Jy6F7e+YHB96nO5KQV+Aunz+UieoXw
 CMSMxssyLyfAeXQgJ5bjPv51QNSSzBPHrbQCIlhUa7eWFnYzPnfFgmXIl6X/+Fusnojv83XmxJI
 3KBAdTtVrFBqJSw==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM62 and other K3 based SoCs use Cadence DPHY and CSI-RX bridge drivers,
along with a DMA wrapper CSI IP for the camera pipeline.

Tested-by: Martyn Welch <martyn.welch@collabora.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b60aa1f89343..aa2df39d072e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -783,6 +783,7 @@ CONFIG_USB_VIDEO_CLASS=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_SDR_PLATFORM_DRIVERS=y
 CONFIG_V4L_MEM2MEM_DRIVERS=y
+CONFIG_VIDEO_CADENCE_CSI2RX=m
 CONFIG_VIDEO_MEDIATEK_JPEG=m
 CONFIG_VIDEO_MEDIATEK_VCODEC=m
 CONFIG_VIDEO_IMX7_CSI=m
@@ -804,6 +805,7 @@ CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC=m
 CONFIG_VIDEO_SAMSUNG_S5P_JPEG=m
 CONFIG_VIDEO_SAMSUNG_S5P_MFC=m
 CONFIG_VIDEO_SUN6I_CSI=m
+CONFIG_VIDEO_TI_J721E_CSI2RX=m
 CONFIG_VIDEO_HANTRO=m
 CONFIG_VIDEO_IMX219=m
 CONFIG_VIDEO_IMX412=m
@@ -1421,6 +1423,7 @@ CONFIG_PHY_XGENE=y
 CONFIG_PHY_CAN_TRANSCEIVER=m
 CONFIG_PHY_SUN4I_USB=y
 CONFIG_PHY_CADENCE_TORRENT=m
+CONFIG_PHY_CADENCE_DPHY_RX=m
 CONFIG_PHY_CADENCE_SIERRA=m
 CONFIG_PHY_MIXEL_MIPI_DPHY=m
 CONFIG_PHY_FSL_IMX8M_PCIE=y

-- 
2.42.1

