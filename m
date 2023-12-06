Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E9D807825
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378632AbjLFSx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378501AbjLFSxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:53:23 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229D0D44;
        Wed,  6 Dec 2023 10:53:29 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B6IrBHC057740;
        Wed, 6 Dec 2023 12:53:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701888791;
        bh=t1HwZK1r2ixK90Q2qTbyJs2eDQNqzluN/sL1qWsmJsg=;
        h=From:To:CC:Subject:Date;
        b=iNSHNx4oYJerKwvqMIR0uON9vOpvEjbPEFJEDtVhgqq1UbxXeaushL7nLo5GvFzB1
         QOvaLgh7EeDAVQkQKM568Azzz9cqnIEkFJ+N+RA2vLTgF88FHUHPkMJX+Ja4yRT4qX
         MA6nje/MwmVCWvUQOyzju/XtASg1BdyaIe9c+Els=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B6IrBNU029211
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Dec 2023 12:53:11 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Dec 2023 12:53:11 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Dec 2023 12:53:11 -0600
Received: from udba0500997.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B6IrBND020337;
        Wed, 6 Dec 2023 12:53:11 -0600
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
Subject: [PATCH v2 0/2] Update Wave521c Compatible for TI Devices
Date:   Wed, 6 Dec 2023 12:52:52 -0600
Message-ID: <20231206185254.1748473-1-b-brnich@ti.com>
X-Mailer: git-send-email 2.34.1
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

Hello All, 

There has been ongoing discussion[1] surrounding the issue of having K3 
prefix included in the compatible for dt bindings. This series removes this
prefix from both the device tree binding as well as the driver. Updating
the binding will not break the ABI at this point as the driver is still
only in linux-next.

Changes in v2:
- Include more context surrounding patch
- Fix style issues addressed by Krzysztof

[1] https://lore.kernel.org/all/20231201063309.tingjc3cjhsqb6r7@confusing/

Brandon Brnich (2):
  dt-bindings: media: Remove K3 Family Prefix from Compatible
  media: chips-media: wave5: Remove K3 References

 Documentation/devicetree/bindings/media/cnm,wave521c.yaml | 2 +-
 drivers/media/platform/chips-media/wave5/wave5-vpu.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1

