Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86F47A59DC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 08:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjISGUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 02:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjISGUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:20:19 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087EF115
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 23:20:13 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38J6J780033809;
        Tue, 19 Sep 2023 01:19:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695104347;
        bh=5QF/TFuchkBw8dysWEbjHXJeM0ALhCmJVTDJqKH+3tk=;
        h=From:To:CC:Subject:Date;
        b=QGordz83aYSLdF7ZZ9ukwfxZGwrU1SY8IMFW1iT6ppQ8Zmz3cM7WpfV3vHoN8bict
         BvSvvZQDXfA50zPpmUDAqPt45KzCGRYM459hDX0Noe53mdXjuqz4BhoFC+yVSVx0c3
         B8bbA2qtn08rgTyNV9Fop6ZTy9nW255WZgeMZWZw=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38J6J6Y4076430
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Sep 2023 01:19:07 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 01:19:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 01:19:06 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38J6J6kk006705;
        Tue, 19 Sep 2023 01:19:06 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.199])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 38J6J5wK016474;
        Tue, 19 Sep 2023 01:19:06 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Suman Anna <s-anna@ti.com>,
        David Lechner <david@lechnology.com>,
        Roger Quadros <rogerq@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <srk@ti.com>, <danishanwar@ti.com>,
        <r-gunasekaran@ti.com>, <vigneshr@ti.com>
Subject: [PATCH 0/3] Bug Fixes for PRUSS irqchip driver
Date:   Tue, 19 Sep 2023 11:48:57 +0530
Message-ID: <20230919061900.369300-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
This series adds some bug fixes for PRUSS irqchip driver.

Thanks and Regards,
MD Danish Anwar

Grygorii Strashko (1):
  irqchip/irq-pruss-intc: Fix listed IRQ type in /proc/interrupts

Suman Anna (2):
  irqchip/irq-pruss-intc: Fix enabling of intc events
  irqchip/irq-pruss-intc: Fix processing of IEP interrupts

 drivers/irqchip/irq-pruss-intc.c | 47 ++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 6 deletions(-)

-- 
2.34.1

