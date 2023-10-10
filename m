Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213697BF744
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjJJJ1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjJJJ1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:27:14 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A814C93;
        Tue, 10 Oct 2023 02:27:12 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39A9R2YF115412;
        Tue, 10 Oct 2023 04:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696930022;
        bh=M5KLQdJ/tF63sS8JG3afvpXgMKzOWWbSrtekEXa6fJA=;
        h=From:To:CC:Subject:Date;
        b=fQqbV2KSYhmQBGn8iLH4KN+7vBfEOHIgC8TTQTzl3vg4bG5vDikfWgNqQdFgXB+O9
         hfxJaABo5dRg0OQ5U43Qv0qbux0gBpyW/CPBh5pR5fKo+OhSimDZUaUBiQBSRzkVV8
         uEfsfgXGKvOCxUFtSz8CiTy/5BdGQCP79DBP3o6k=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39A9R26b010516
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Oct 2023 04:27:02 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Oct 2023 04:27:02 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Oct 2023 04:27:02 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39A9R1hU117093;
        Tue, 10 Oct 2023 04:27:01 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vaishnav.a@ti.com>, <u-kumar1@ti.com>
Subject: [PATCH 0/2] arm64: dts: ti: k3-j721s2/j784s4: Add CSI BCDMA nodes
Date:   Tue, 10 Oct 2023 14:56:58 +0530
Message-ID: <20231010092700.2089-1-vaishnav.a@ti.com>
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

Vaishnav Achath (2):
  arm64: dts: ti: k3-j721s2-main: Add BCDMA instance for CSI2RX
  arm64: dts: ti: k3-j784s4-main: Add BCDMA instance for CSI2RX

 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 17 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 17 +++++++++++++++++
 2 files changed, 34 insertions(+)

-- 
2.17.1

