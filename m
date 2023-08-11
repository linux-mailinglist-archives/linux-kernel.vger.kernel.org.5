Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF127785DC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjHKDPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 23:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjHKDPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:15:10 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99C230C4;
        Thu, 10 Aug 2023 20:15:08 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37B3Exwa113829;
        Thu, 10 Aug 2023 22:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691723699;
        bh=BYsvprL9NBRWCpMN14ugYnJGEVY7QhZTrwoytZCKlxk=;
        h=From:To:CC:Subject:Date;
        b=GZOjajaksmZ+qspasZ0ngXmnUR1P1i21Jim1VMANpzbHhx0pMFIdrLOz12MXkutHU
         iPoZfRn0rXcdo+pWfA5WoKnecJaS8Ynj6FLFAIOniAA0VRINzjAe3mpXRc5h/nl6Na
         n29mnfxMMHYpPPRJHMuYMnUrTXOArGfgYwCTd4gs=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37B3ExfK001844
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 22:14:59 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 22:14:58 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 22:14:58 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37B3Ewui015625;
        Thu, 10 Aug 2023 22:14:58 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>
Subject: [PATCH V4 0/2] dt-bindings: opp/cpufreq: Convert ti-cpufreq to json schema
Date:   Thu, 10 Aug 2023 22:14:56 -0500
Message-ID: <20230811031458.957624-1-nm@ti.com>
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

Hopefully, this version is better..
Changes from V3:
* Changed the description of the bindings documents to be more aligned
  with current standards (Dhruva's comments)

V3: https://lore.kernel.org/all/20230809023045.1870410-1-nm@ti.com/
V2: https://lore.kernel.org/all/20230801233341.1416552-1-nm@ti.com/
V1: https://lore.kernel.org/all/20230724153911.1376830-1-nm@ti.com/

Nishanth Menon (2):
  dt-bindings: opp: Convert ti-omap5-opp-supply to json schema
  dt-bindings: cpufreq: Convert ti-cpufreq to json schema

 .../bindings/cpufreq/ti-cpufreq.txt           | 132 ------------------
 .../opp/operating-points-v2-ti-cpu.yaml       |  92 ++++++++++++
 .../bindings/opp/ti,omap-opp-supply.yaml      | 106 ++++++++++++++
 .../bindings/opp/ti-omap5-opp-supply.txt      |  63 ---------
 4 files changed, 198 insertions(+), 195 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
 create mode 100644 Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
 create mode 100644 Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml
 delete mode 100644 Documentation/devicetree/bindings/opp/ti-omap5-opp-supply.txt

-- 
2.40.0

