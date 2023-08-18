Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F45780C6B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377077AbjHRNSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377057AbjHRNSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:18:13 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F552723;
        Fri, 18 Aug 2023 06:18:11 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37IDHqio037438;
        Fri, 18 Aug 2023 08:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692364672;
        bh=zg9d5TGVW5s8yRHMyUt4DTkSBYI+AJt/U8GKFUE5DEk=;
        h=From:To:CC:Subject:Date;
        b=zEbRYdH3k+/xZrRayGsXtLOybti72SFbB9doM4GGnWCleoI5xhcRtaiZf+wyuIRjh
         dOJAE/giC9TrPZl2K9MpB8YZweDInxn8TEejSXOlHncG2wd2CSk1sbVCe/+FiYSrR5
         lslI7b3Vu/aOX26pmYhLxmvg/NFBu+xcTemYUykw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37IDHqdI126008
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Aug 2023 08:17:52 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 18
 Aug 2023 08:17:51 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 18 Aug 2023 08:17:51 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37IDHoUH021192;
        Fri, 18 Aug 2023 08:17:51 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Jai Luthra <j-luthra@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH 0/2] Add DSS support for TI AM62A7 SoC
Date:   Fri, 18 Aug 2023 18:47:48 +0530
Message-ID: <20230818131750.4779-1-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a new compatible for the Display SubSystem (DSS)
controller on TI's AM62A7 SoC. It further adds the required support, for
the same, in the tidss driver.

The DSS controller is similar to the recently added AM625 DSS, with the
key difference being the absence of VP1 output on the SoC. The VP1 in
AM62A7 DSS is tied off and cannot be used, unlike in AM625, where the
VP1 was connected to 2 OLDI TXes. The video pipeline that corresponds to
VP1 still exists and can be used to overlay planes on the VP2's primary
plane. This can be done using the overlay managers inside the SoC.
Moreover, DSS VP2 can output Full-HD RGB888 DPI video signals.

I have tested these patches on AM62A7 SK-EVM, which converts DPI signals
to HDMI on the platform using the Sil9022A HDMI transmitter. All the
patches, required to enable display on AM62A7-SK, can be found on my
github fork[0] in the branch "next_am62a".

Regards
Aradhya

[0]: https://github.com/aradhya07/linux-ab/tree/next_am62a


Aradhya Bhatia (2):
  dt-bindings: display: ti: Add support for am62a7 dss
  drivers/tidss: Add support for AM62A7 DSS

 .../bindings/display/ti/ti,am65x-dss.yaml     | 14 +++++
 drivers/gpu/drm/tidss/tidss_dispc.c           | 53 +++++++++++++++++++
 drivers/gpu/drm/tidss/tidss_dispc.h           |  2 +
 drivers/gpu/drm/tidss/tidss_drv.c             |  1 +
 4 files changed, 70 insertions(+)


base-commit: 47762f08697484cf0c2f2904b8c52375ed26c8cb
-- 
2.40.1

