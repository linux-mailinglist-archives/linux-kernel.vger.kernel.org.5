Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04A37BD517
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbjJIIZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbjJIIZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:25:08 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE642AC;
        Mon,  9 Oct 2023 01:25:06 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3998Os5B113187;
        Mon, 9 Oct 2023 03:24:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696839894;
        bh=Tj7Gy6Xo6sZ11WWNP0dGT0Go1/OTwecYySniex9/ka0=;
        h=From:To:CC:Subject:Date;
        b=b9plz3cz3WsGh9Pl1ybaIf4nCkAm1CYMqxyZAy6uGKLiyGCK5D4h8Tvr9SmJhNGfV
         e9ySf0SfJAdU5hZMP2M13qPvsjTMCWMz3sL9uvVjwA+KPiZhyX8uHBgwsM9VdLr/f4
         aNyybf3hleshU8qN5qy5lZn2+6OQMDoILB+Y912Q=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3998Ossx034359
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Oct 2023 03:24:54 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Oct 2023 03:24:54 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Oct 2023 03:24:54 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3998Orre106452;
        Mon, 9 Oct 2023 03:24:53 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <vigneshr@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <afd@ti.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <u-kumar1@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH v4 0/2] arm64: dts: ti: k3-j7200: Fixes for various dtbs_checks warnings
Date:   Mon, 9 Oct 2023 13:54:50 +0530
Message-ID: <20231009082452.30684-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Few fixups for j7200 dtbs_check warnings.

This is V4 for the following series rebased and tested with 6.6-rc5,

V3 : https://lore.kernel.org/all/20230513101343.785-1-vaishnav.a@ti.com
V2 : https://lore.kernel.org/all/20230505115858.7391-1-vaishnav.a@ti.com/
V1 : https://lore.kernel.org/all/20230424173623.477577-1-nm@ti.com/

Bootlog with basic hyperflash testing (6.6.0-rc5-next-20231009):
https://gist.github.com/vaishnavachath/f7265e932725fd992dbc4e48b993e9c0

Patch 2/2 depends on the following patch under review which enables reg-mux
to be used when parent node is not syscon :
https://lore.kernel.org/all/20230911151030.71100-1-afd@ti.com/

Changelog:

V3->V4:
  * Rebase and tested with 6.6-rc5

V2->V3:
  * Drop pinctrl fix patch as the fix [2]  is already merged to next.
  * Keep register regions unchanged as it is correct according to memory
  map, update commit message.

V1->V2:
 * Address feedback as recommended in [3].
 * Address feedback from Udit to limit the FSS register region size as
 per TRM.
 * Use reg-mux changes in [4] to simplify the hbmc-mux modelling   

[1] https://lore.kernel.org/all/76da0b98-3274-b047-db11-ecabc117ae11@ti.com/
[2] https://lore.kernel.org/all/20230510091850.28881-1-tony@atomide.com/
[3] https://lore.kernel.org/all/20230503115130.c7m4a7crub7kmfjw@gluten/
[4] https://lore.kernel.org/all/20230911151030.71100-1-afd@ti.com/

Nishanth Menon (2):
  arm64: dts: ti: k3-j7200-mcu-wakeup: Switch mcu_syscon to
    ti,j721e-system-controller
  arm64: dts: ti: k3-j7200-mcu-wakeup: Update fss node and hbmc_mux

 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- 
2.17.1

