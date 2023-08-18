Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09D2780C14
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 14:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376970AbjHRMpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 08:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376987AbjHRMp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:45:27 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21D23AAB;
        Fri, 18 Aug 2023 05:45:24 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37ICj86b030032;
        Fri, 18 Aug 2023 07:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692362708;
        bh=fDoF4BT+MkW9EQWNxGUHI0QxQxlYnV94rzgTGS+rTI8=;
        h=From:To:CC:Subject:Date;
        b=tqDKMo8sidOuHImaDTYARVss8hrqTudKm4bhSs77pSOSsVJjh8ojhAc7nUzQXb0iq
         5/6TPzPIRy2K3arCmSzGgJGVvIG1SO9jTNJG73zi50rhnq1Y1vauuATtDGnjfWM1Cz
         d96ubwAWxi3kA24yosrc523kSVxZAutuURl/FK8c=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37ICj8ne103258
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Aug 2023 07:45:08 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 18
 Aug 2023 07:45:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 18 Aug 2023 07:45:07 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37ICj7j4123190;
        Fri, 18 Aug 2023 07:45:07 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH V5 0/2] dt-bindings: opp/cpufreq: Convert ti-cpufreq to json schema
Date:   Fri, 18 Aug 2023 07:45:02 -0500
Message-ID: <20230818124504.3718266-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
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

Hi,

Convert the long pending free-form text bindings of ti-cpufreq and
omap5-opp-supply bindings to json-schema.

Changes since V4:
* Fix up comments from Krzysztof for patch #1
* Picked up Krzysztof reviewed-by for patch #1
* Picked up Dhruva's Reviewed-by for patches 1 and 2.

V4: https://lore.kernel.org/all/20230811031458.957624-1-nm@ti.com/
V3: https://lore.kernel.org/all/20230809023045.1870410-1-nm@ti.com/
V2: https://lore.kernel.org/all/20230801233341.1416552-1-nm@ti.com/
V1: https://lore.kernel.org/all/20230724153911.1376830-1-nm@ti.com/

Nishanth Menon (2):
  dt-bindings: opp: Convert ti-omap5-opp-supply to json schema
  dt-bindings: cpufreq: Convert ti-cpufreq to json schema

 .../bindings/cpufreq/ti-cpufreq.txt           | 132 ------------------
 .../opp/operating-points-v2-ti-cpu.yaml       |  92 ++++++++++++
 .../bindings/opp/ti,omap-opp-supply.yaml      | 101 ++++++++++++++
 .../bindings/opp/ti-omap5-opp-supply.txt      |  63 ---------
 4 files changed, 193 insertions(+), 195 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
 create mode 100644 Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
 create mode 100644 Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml
 delete mode 100644 Documentation/devicetree/bindings/opp/ti-omap5-opp-supply.txt


base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.40.0

