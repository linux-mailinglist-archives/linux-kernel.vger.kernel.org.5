Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C51774B47
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbjHHUoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbjHHUny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:43:54 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F7D30DE;
        Tue,  8 Aug 2023 13:18:59 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378KIlsH108234;
        Tue, 8 Aug 2023 15:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691525927;
        bh=S6TnKJTYbWw8N/P74aYbib8UuVQ08I0CXGWY53Z/gJI=;
        h=From:To:Subject:Date;
        b=PsNWcB0KVlHbnnb3S9j02ailxtP4MQXrEm+JkfGLyw90F8Q+ImB6g7MCyNRj6kUST
         xGyX7hn/hTwbb/VUNrHQmz/b4Qsb+ajc41UTApqR2NfjvUNVGigRIlMTH/IGMGNgEm
         Oc1c2MjY7xWMZPEXZ3uNgzNxfWAHjYaISzhCCOQs=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378KIkdX126964
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 15:18:46 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 15:18:46 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 15:18:46 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378KIgre028651;
        Tue, 8 Aug 2023 15:18:43 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Udit Kumar <u-kumar1@ti.com>, Hari Nagalla <hnagalla@ti.com>
Subject: [PATCH v2 0/3] Add R5F and C7x DSP nodes for J721S2 SoC.
Date:   Wed, 9 Aug 2023 01:48:39 +0530
Message-ID: <20230808201842.292911-1-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
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

This series adds the R5F processor nodes and C7x DSP nodes for 
J721S2 SoC.

The first two patches adds the remote proc nodes to the SoC device
tree and the third patch reserves the memory for remote proc IPCs
on J721S2 EVM board.

Changelog:
1) Added status = "disabled"; in soc dtsi files, and removed it from som dts
2) Fixed mboxes property in for all cores in som dts

Link to v1: https://lore.kernel.org/all/20230529220941.10801-1-hnagalla@ti.com/

Hari Nagalla (3):
  arm64: dts: ti: k3-j721s2-mcu: Add R5F cluster nodes
  arm64: dts: ti: k3-j721s2-main: Add R5F and C7x remote processsor
    nodes
  arm64: dts : ti: k3-j721s2-som-p0: Add DDR carveout memory nodes for
    R5F and C71x DSPs

 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 104 +++++++++
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  40 ++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  | 206 ++++++++++++++++++
 3 files changed, 350 insertions(+)

-- 
2.34.1

