Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873BB76C0F5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 01:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjHAXd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 19:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjHAXd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 19:33:56 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B177268E;
        Tue,  1 Aug 2023 16:33:54 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 371NXi4G022334;
        Tue, 1 Aug 2023 18:33:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690932824;
        bh=gx+cskALCcYlkgApV6e1s5eBIaxIV+QhYxQ6AIInkcg=;
        h=From:To:CC:Subject:Date;
        b=GRvkEGcw3zq99clo1xycR1p1vcVMJgIQBxnr41Ig+YR9SKeFQyk16klFehvmTElCI
         tudx06mhiJGPNDjz3M5MPVM0DMzZT2z2VRotlSiAgF2/3LE6D8P4n4oOCRzUqvGPPL
         +AWyZkroZe67O4dQFkhzE4u22wmbXScLtJmienaY=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 371NXiph064876
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Aug 2023 18:33:44 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Aug 2023 18:33:43 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Aug 2023 18:33:42 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 371NXhKa096375;
        Tue, 1 Aug 2023 18:33:43 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 0/2] dt-bindings: opp/cpufreq: Convert ti-cpufreq to json schema
Date:   Tue, 1 Aug 2023 18:33:39 -0500
Message-ID: <20230801233341.1416552-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Convert the long pending free-form text bindings of ti-cpufreq and
omap5-opp-supply bindings to json-schema.

Changes from V1:
* Tony has picked up 1-3 of v1 dt cleanups[1]
* Fixup the bindings for the various review comments received.

V1: https://lore.kernel.org/all/20230724153911.1376830-1-nm@ti.com/

Nishanth Menon (2):
  dt-bindings: opp: Convert ti-omap5-opp-supply to json schema
  dt-bindings: cpufreq: Convert ti-cpufreq to json schema

 .../bindings/cpufreq/ti-cpufreq.txt           | 132 ------------------
 .../opp/operating-points-v2-ti-cpu.yaml       |  88 ++++++++++++
 .../bindings/opp/ti,omap-opp-supply.yaml      | 103 ++++++++++++++
 .../bindings/opp/ti-omap5-opp-supply.txt      |  63 ---------
 4 files changed, 191 insertions(+), 195 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
 create mode 100644 Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
 create mode 100644 Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml
 delete mode 100644 Documentation/devicetree/bindings/opp/ti-omap5-opp-supply.txt

[1] https://lore.kernel.org/all/20230731062551.GH5194@atomide.com/
-- 
2.40.0

