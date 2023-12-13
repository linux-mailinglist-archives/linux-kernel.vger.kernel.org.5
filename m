Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556C5811C76
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442536AbjLMS26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbjLMS2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:28:51 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2049.outbound.protection.outlook.com [40.107.255.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7B0E3;
        Wed, 13 Dec 2023 10:28:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YX3OgHislZ7tMsDIXQc1tE+ZqBsjMjBWL37o6goL7QQZF5kCXgMmYpLTIYgKQ2RwDfnwvgQxK55R6Ifk83Iqyq+JrV5gk/hpy8RnjOxYEg43V+xhXusY9I4cfVmnxxTUH3jBHSGUauipt01YKAxvqROeXBY9WU5YbIPM6wSDnpWYP19n08RQ5RVfW3Ogw/qNOt3lUY8qJgNAfyP//PwElTQbR72XjwEcBpzvq5/UlrQCIrRctotdllh8gv90XRP6PfVwuxRtapoPA8zo6Tevnyl3bJGkE6+EzCCIOUBIbHDSggXJYU9KfQKPNAy1zbNaRLMUL/xe0v9n03k5MeLhTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0LyUQsBfa7WSXoN5rhI9TJq9YpuQCvgfS5Mnc2qq9k=;
 b=FvYD6enwKkf90rwAHjxzzaAVXT7mHa+kNaa2uSf0ikp/wyyuhb6zSuz8CDlI6q2eTh6zdstLN9qQOQygWk9umArZFv3ZK3UxzG99U3SPGvgAFhUBvfv6/Cm/jsmeodpoWuWC8ZGKmipumM9d4pXaFZGZRwJeJiXns4ulOyEvdj2unlzBBMog6sPi5xLE2m0HvorPRvUUS/+YnCMAaWeNMQcIfR7Zyh5PsmcGc9MVEfi82hsW/EjD56tbbgmxCxIiMb5bQihxPQlfrz0bK1tShc6s83is99PWfj3xeWzFHT6mDaKTzQupvhsIUrmHs+px//LQxl1muzN/eY3avRumXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 211.75.126.7) smtp.rcpttodomain=arndb.de
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0LyUQsBfa7WSXoN5rhI9TJq9YpuQCvgfS5Mnc2qq9k=;
 b=BKqTAXMz9LlcEfe05ZuYGUUfa68sNNJHG2E5hhwbLK/vScjqG5Yr+4mqJpL9apjN6FRBM+zPum3XZoPqaAsvWVMyRe4iMKVfdy/rt6ofxGsPFMJeg877KtPId9QXd2MzqFtS3nYIpPVvVOyyYVyY7rqehVMEVm5bB47sfLp7twM=
Received: from SG2PR02CA0131.apcprd02.prod.outlook.com (2603:1096:4:188::6) by
 JH0PR03MB7548.apcprd03.prod.outlook.com (2603:1096:990:16::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26; Wed, 13 Dec 2023 18:28:51 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:4:188:cafe::66) by SG2PR02CA0131.outlook.office365.com
 (2603:1096:4:188::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 18:28:51 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 211.75.126.7) smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not
 signed) header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of taln60.nuvoton.co.il: DNS Timeout)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 18:28:50 +0000
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 14 Dec
 2023 02:28:48 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Thu, 14 Dec
 2023 02:28:48 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 14 Dec 2023 02:28:48 +0800
Received: from taln60.localdomain (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id 872E85F5B8;
        Wed, 13 Dec 2023 20:28:47 +0200 (IST)
Received: by taln60.localdomain (Postfix, from userid 10070)
        id 84249DC3749; Wed, 13 Dec 2023 20:28:47 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <arnd@arndb.de>, <pmenzel@molgen.mpg.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v3 1/3] dt-bindings: soc: nuvoton: Add NPCM BPC
Date:   Wed, 13 Dec 2023 20:28:43 +0200
Message-ID: <20231213182845.3744685-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213182845.3744685-1-tmaimon77@gmail.com>
References: <20231213182845.3744685-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[211.75.126.7];domain=NTHCCAS01.nuvoton.com
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|JH0PR03MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: 509e2b84-5051-4e96-4fcc-08dbfc095a6e
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u5OrwcXnTqjI8dyavYitKIB6MAwRCxmSEiEgl1HvD4tbTkKGS4FTrEjhKCFu0ma3mQu4O7JupeAgGYVJ3l3c2Wl50fCWnFea9xRfZiJbiHmypOI0ePOKEeuAPRTsHbwK5FfzXYOnc1S0B4IY0HR8wp8OsxP88DbbTHIso0m2t9TWcqsJ9ynA5zLswIW/N5lQKZ+PJstbWjdnj5jbjBaM4rAVd/Ul8xIIPr+KSC7f7VAkLWotkQpnvV+jKvmveMQZxZH7ZoR/RS34mOdLMDxo0mTnTRY7JCuvz+4tzrFHDDlJ1t8ei8qUSmVfMfEnH7Kmd7svRV3BWHHDDTVy/dUJalZrnCYuIpnPlKPsKKazKIElWV4vHdxJl/XE7Ng7yOi+zFlSTHE22mFu3ziMsggFgHbUSH3JE+ixMyH3gDowWe3UpZTj+HmZMykEARNxUCu7wOaNmwLUcG/r2fe+4kmiF05CJ9vu+5wEQYn7brM47feaxjek7bgk7P20w5f/f+sLK75gZ1ijqw7EZcw5aBpPSY4EZkulhsPDrhEKuxVEZeAqCWGs2PO3vhA8+Tjp+6uHC3SwShQe0lvT1HC//Eo2cXOxY94/VjOf5cMGYH1RDwCe/6LRYhxpbiHcteokn7hOfGMQWFMCYch8aoMES2x0qBlocIla3DwL+kAuniU1JSTpMIwPBSVuDXTpOmZuStvYnLQH5khq+AAcSDB0l8wQwVUNmozTTs9WFVGJe2tj4EIbDow53ezUp9bqYksTDhP4BFHtftFI6y399f5Z/3eDNjXLjZBHX/NjRPDSgxvkWW4gMYsMEgVuCZNapue5CYLRYqbIuy5P3tHXzzCaDzkvHYWn9HkjD8PYU3djkGSshd3sWd6//LbobtGMmpnpYueSoA1b5c9PJdJd6kQLSB8CfA==
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(61400799012)(64100799003)(48200799006)(82310400011)(451199024)(46966006)(40470700004)(83170400001)(82740400003)(47076005)(41300700001)(63350400001)(921008)(81166007)(356005)(35950700001)(2906002)(7416002)(966005)(5660300002)(498600001)(40480700001)(55446002)(36756003)(110136005)(8676002)(8936002)(316002)(76482006)(70586007)(42186006)(54906003)(70206006)(4326008)(2616005)(6266002)(1076003)(42882007)(26005)(336012)(73392003)(40460700003)(6666004)(82202003)(45356006)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 18:28:50.4672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 509e2b84-5051-4e96-4fcc-08dbfc095a6e
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7548
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added device tree binding documentation for Nuvoton BMC NPCM BIOS Post
Code (BPC).

The NPCM BPC monitoring two configurable I/O addresses written by the
host on the bus.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../soc/nuvoton/nuvoton,npcm-bpc.yaml         | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-bpc.yaml

diff --git a/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-bpc.yaml b/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-bpc.yaml
new file mode 100644
index 000000000000..c04302a1d52b
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-bpc.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/nuvoton/nuvoton,npcm-bpc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton BMC NPCM BIOS Post Code (BPC) controller
+
+maintainers:
+  - Tomer Maimon <tmaimon77@gmail.com>
+
+description:
+  Nuvoton BMC NPCM BIOS Post Code (BPC) monitoring two configurable I/O
+  addresses written by the host on the bus, the capture data stored in
+  128-word FIFO.
+
+  NPCM BPC supports capture double words, when using capture
+  double word only I/O address 1 is monitored.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - nuvoton,npcm845-bpc
+          - nuvoton,npcm750-bpc
+      - const: nuvoton,npcm-bpc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  nuvoton,monitor-ports:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Contain monitor I/O addresses on the bus, at least one monitor I/O
+      address required.
+
+  nuvoton,bpc-en-dwcapture:
+    description:
+      Set DWCAPTURE bit in BPCFEN register that enable double words capture
+      according to the first address setting.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - nuvoton,monitor-ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    bpc: bpc@f0007040 {
+        compatible = "nuvoton,npcm750-bpc", "nuvoton,npcm-bpc";
+        reg = <0xf0007040 0x20>;
+        interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+        nuvoton,monitor-ports = <0x80>;
+    };
+...
-- 
2.34.1

