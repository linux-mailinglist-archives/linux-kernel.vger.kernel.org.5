Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABEB79BCDB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357349AbjIKWFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242852AbjIKQZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:25:53 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4007DCC3;
        Mon, 11 Sep 2023 09:25:48 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BGPeub063227;
        Mon, 11 Sep 2023 11:25:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694449540;
        bh=2NS7RtXShs92z9a7/2efqbfykiOx628JBR1q9f+Spyo=;
        h=From:To:CC:Subject:Date;
        b=UlbClhoDZcKrwoVqQm5M1yWfaEFWxGGUwdEWW6pbv9qwJXaTtnv1T+JpOl9lTkB6U
         3sFE3q9DEj8kSJljVSMHwKZlvozNku58Px7lS1A7uNWu36FMfeWoEE2elwD+3/QITl
         xpUmI9K797EIDUHo4iX7uTuV6D1JLGiLt0Kn88rg=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BGPeQB022184
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Sep 2023 11:25:40 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 11:25:40 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 11:25:40 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BGPeaa036964;
        Mon, 11 Sep 2023 11:25:40 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Vignesh <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tom Rini <trini@konsulko.com>, Bryan <bb@ti.com>,
        Praneeth <praneeth@ti.com>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH 0/3] arm64: dts: ti: k3-am625: Add boot phase marking
Date:   Mon, 11 Sep 2023 11:25:32 -0500
Message-ID: <20230911162535.1044560-1-nm@ti.com>
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
  arm64: dts: ti: k3-am625: Add boot phase tags marking
  arm64: dts: ti: k3-am625-beagleplay: Add boot phase tags marking
  arm64: dts: ti: k3-am625-sk: Add boot phase tags marking

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      | 10 +++++++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi       |  2 ++
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi    |  2 ++
 arch/arm64/boot/dts/ti/k3-am62.dtsi           |  3 +++
 .../arm64/boot/dts/ti/k3-am625-beagleplay.dts | 26 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts        | 27 +++++++++++++++++++
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 16 +++++++++++
 7 files changed, 86 insertions(+)

-- 
2.40.0

