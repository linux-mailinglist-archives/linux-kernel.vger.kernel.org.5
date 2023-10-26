Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35CC7D7D30
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344271AbjJZHCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbjJZHCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:02:06 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCE81A7;
        Thu, 26 Oct 2023 00:02:03 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39Q71vbs090131;
        Thu, 26 Oct 2023 02:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698303717;
        bh=BTtfBkaHjsFeaYF2wDRBkfcsL+7O+kPO4t+fXbfJ+/4=;
        h=From:To:CC:Subject:Date;
        b=TLAj5vDbG6fBUv1dmoo3nfaJnnbTJWaZ4H0akK3/DEDtURn20riLiiqbN4N+fz+M0
         MmMQimhRh5nmuCB752WnktmGFBVmzU1T9WaZghLtVPvvXJXwYr2vNy3FwkYxUVjbPL
         EJCxfW2kg3IYjX+EvmAlFyBjv5zq9Eq7Wxyh0Pa4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39Q71vHr125559
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Oct 2023 02:01:57 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 26
 Oct 2023 02:01:57 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 26 Oct 2023 02:01:57 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39Q71uC7061211;
        Thu, 26 Oct 2023 02:01:56 -0500
From:   Nitin Yadav <n-yadav@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Enable UHS card support on AM62a
Date:   Thu, 26 Oct 2023 12:31:53 +0530
Message-ID: <20231026070155.1134063-1-n-yadav@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

This series enables class UHS mode on support on AM62a SK device.

Nitin Yadav (2):
  arm64: dts: ti: k3-am62a: Enable UHS mode support for SD cards
  arm64: dts: ti: k3-am62a-main: Remove no-1-8-v property

 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi |  1 -
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts   | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

-- 
2.25.1

