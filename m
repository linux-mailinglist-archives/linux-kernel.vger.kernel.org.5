Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE09D7BF979
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjJJLRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJJLRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:17:40 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F77AC;
        Tue, 10 Oct 2023 04:17:38 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39ABHPjN045227;
        Tue, 10 Oct 2023 06:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696936645;
        bh=Q6r9tPBbiCITJC8MN6mOY4JEJZtB+2v5IwMOXI3v49A=;
        h=From:To:CC:Subject:Date;
        b=iKcqgsW0p6dqOze7MdnjrIc3nYygkTdnXi2IcGhs823QgtyFsKsrnPe1lP4TqCrs+
         iQrtH79M/INm2G7edB3VCC8G0L5r5r2zJeSFaruG76GCNmh1MTx8fZrhy8XhIR0ICe
         XG44rj5k2uZHT5DeIXXz7K7IRkhXMYIQ9lJppScI=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39ABHPkH031630
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Oct 2023 06:17:25 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Oct 2023 06:17:25 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Oct 2023 06:17:25 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39ABHO58122843;
        Tue, 10 Oct 2023 06:17:24 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vaishnav.a@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>
Subject: [PATCH v2 0/2] arm64: dts: ti: k3-j721s2/j784s4: Add CSI BCDMA nodes
Date:   Tue, 10 Oct 2023 16:47:21 +0530
Message-ID: <20231010111723.17524-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J721S2 and J784S4 have a dedicated BCDMA controller for 
Camera Serial Interface. Add the node for the DMA controllers
and keep it disabled by default.

The BCDMA instances were enabled/disabled and tested:
J721S2 : https://gist.github.com/vaishnavachath/4b9d7ec2ee1aad59a57d44cf28ed7eb0
J784S4 : https://gist.github.com/vaishnavachath/f928e4566aa80c7f47e7ac3c1491d62e

V1: https://lore.kernel.org/all/20231010092700.2089-1-vaishnav.a@ti.com/

Changelog:
  V1->V2:
    * Fix indentation for the reg entries.

Vaishnav Achath (2):
  arm64: dts: ti: k3-j721s2-main: Add BCDMA instance for CSI2RX
  arm64: dts: ti: k3-j784s4-main: Add BCDMA instance for CSI2RX

 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 17 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 17 +++++++++++++++++
 2 files changed, 34 insertions(+)

-- 
2.17.1

