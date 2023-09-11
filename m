Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7C279AF45
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353136AbjIKVtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243676AbjIKR3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:29:19 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A9F125;
        Mon, 11 Sep 2023 10:29:13 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BHT33W082639;
        Mon, 11 Sep 2023 12:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694453343;
        bh=5rbDCxIn1o8pLoVQisBZ74AOVgIoyVSBOV0yDizArsI=;
        h=From:To:CC:Subject:Date;
        b=kEmnvezg2qQIohhPisYUnoG0Nv2LXpWgR83UOEJ0hXA1NJaEBfTshHpey9liE5iAT
         MpFtdbK7tNLS5ppVrcVZOJDKrxgwCXXRfb67NvBwP7UbUUGuyrIjV/xHLkez1O/fnz
         /LANeU0TporyDiQw875/vwN6mle2COo6mtYZe83Q=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BHT3Go010074
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Sep 2023 12:29:03 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 12:29:03 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 12:29:03 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BHT3Ve032998;
        Mon, 11 Sep 2023 12:29:03 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Vignesh <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tom Rini <trini@konsulko.com>, Bryan <bb@ti.com>,
        Praneeth <praneeth@ti.com>, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 0/3] arm64: dts: ti: k3-am42: Add boot phase tags marking
Date:   Mon, 11 Sep 2023 12:28:59 -0500
Message-ID: <20230911172902.1057417-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bootph-all as phase tag was added to dt-schema
(dtschema/schemas/bootph.yaml) to describe various node usage during
boot phases with DT.

Based on next-20230911

Nishanth Menon (3):
  arm64: dts: ti: k3-am64: Add phase tags marking
  arm64: dts: ti: k3-am642-evm: Add boot phase tags marking
  arm64: dts: ti: k3-am642-sk: Add boot phase tags marking

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 11 +++++++++
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi  |  2 ++
 arch/arm64/boot/dts/ti/k3-am64.dtsi      |  2 ++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  | 28 +++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   | 29 ++++++++++++++++++++++++
 5 files changed, 72 insertions(+)

-- 
2.40.0

