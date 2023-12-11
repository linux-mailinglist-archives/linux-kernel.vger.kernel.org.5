Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF4B80DC79
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345008AbjLKU74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 15:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344974AbjLKU7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:59:52 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79B2CD;
        Mon, 11 Dec 2023 12:59:57 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BBKxhKC129492;
        Mon, 11 Dec 2023 14:59:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702328383;
        bh=/zH9ezNaAZm7yjXTnoBaCKXNFia2jSA2fWzEY7U5mD8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fT5m72YxdNiEWIyBCoMQrtjmbYM3EIIGgy2pMG1HKrj5OkFNwnkHL1hcCIbsBRtup
         AhYqcx1XiHaxFkGWDEGCrd3bsn5QJsWCjSZ4y6gco+sH3PHYiIDuzVfrJ0b5Jm87tm
         OalaeJ9OGWvMxcVRyt0Naa51SfA5OMDsLWBYEXIg=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BBKxhQI037280
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Dec 2023 14:59:43 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Dec 2023 14:59:43 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Dec 2023 14:59:43 -0600
Received: from udba0500997.dhcp.ti.com (udba0500997.dhcp.ti.com [128.247.81.249])
        by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BBKxRo8003825;
        Mon, 11 Dec 2023 14:59:43 -0600
From:   Brandon Brnich <b-brnich@ti.com>
To:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Nishanth Menon <nm@ti.com>, Darren Etheridge <detheridge@ti.com>,
        Brandon Brnich <b-brnich@ti.com>
Subject: [PATCH v3 2/2] media: chips-media: wave5: Remove K3 References
Date:   Mon, 11 Dec 2023 14:59:20 -0600
Message-ID: <20231211205920.698939-3-b-brnich@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211205920.698939-1-b-brnich@ti.com>
References: <20231211205920.698939-1-b-brnich@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change compatible string to match dt bindings for TI devices. K3 family
prefix should not be included as it deviates from naming convention.

Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/all/CAMuHMdUYOq=q1j=d+Eac28hthOUAaNUkuvxmRu-mUN1pLKq69g@mail.gmail.com/
Signed-off-by: Brandon Brnich <b-brnich@ti.com>
---
 drivers/media/platform/chips-media/wave5/wave5-vpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
index bfe4caa79cc9..0d90b5820bef 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -272,7 +272,7 @@ static const struct wave5_match_data ti_wave521c_data = {
 };
 
 static const struct of_device_id wave5_dt_ids[] = {
-	{ .compatible = "ti,k3-j721s2-wave521c", .data = &ti_wave521c_data },
+	{ .compatible = "ti,j721s2-wave521c", .data = &ti_wave521c_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, wave5_dt_ids);
-- 
2.34.1

