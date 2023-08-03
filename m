Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830C476E2E6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjHCIYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbjHCIYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:24:05 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8383146A1;
        Thu,  3 Aug 2023 01:18:07 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3738I2kj107542;
        Thu, 3 Aug 2023 03:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691050682;
        bh=wLIG36mwgYjb9tKFTWdlKJ8otozWX3XZkQtAlza2ZfA=;
        h=From:To:CC:Subject:Date;
        b=hQYVYHpncfNysd5ywTO7K3BY/qUVD0rfiqMSIGDpJWeYflz8h1/gfpZRResEnvPqR
         JS+Jund5Q+jTX5olgDnQI9DRbh7jS/djlsRcnPAScSq6mhR7mEPEZyTUQ7Zii3uYOv
         GBdImImW4X+n99EvsSL083dmwO2Tc34e/qZCuoTE=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3738I2YE101146
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 03:18:02 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 03:18:02 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 03:18:02 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3738I1qL008507;
        Thu, 3 Aug 2023 03:18:01 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <a-bhatia1@ti.com>, <r-ravikumar@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <j-choudhary@ti.com>
Subject: [PATCH 0/2] Add HDMI support for AM68-SK Board
Date:   Thu, 3 Aug 2023 13:47:58 +0530
Message-ID: <20230803081800.368582-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM68-SK base board has one DP and one HDMI port.
This series add support for HDMI peripheral for the same.

Jayesh Choudhary (2):
  arm64: dts: ti: k3-j721s2-main: Add DSS node
  arm64: dts: ti: k3-am68-sk-base-board: Add HDMI support

 .../boot/dts/ti/k3-am68-sk-base-board.dts     | 138 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    |  46 ++++++
 2 files changed, 184 insertions(+)

-- 
2.25.1

