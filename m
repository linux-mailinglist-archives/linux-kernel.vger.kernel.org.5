Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0B27F3228
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjKUPRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjKUPRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:17:48 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2056.outbound.protection.outlook.com [40.107.215.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA99DD;
        Tue, 21 Nov 2023 07:17:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MG/fT2prN9jJxPdZ1JTgpR2BAxf7PtErlgiJptYaTdo7eO1M1W8La7vPCMAsjfE2hbpvRGQw7z3HGq1X8KhsglSnMTM3eVNV0eLZZSnHeIDZcVg+Q8zxly04zmW6IccDXlsQUnWQTiKMfHls48AYdaFtpgZzowE17uyqN3lL/pkanM1tv9YQwqdRHV8rfwljEaoTJOJbB7JyVJKWylIFKmi04/0lV0C5GT1/90gLSc5Z08x+lG+l2kjoJuw8rSgHmCHQ1yj+EJboWGQ1xa0Q5NqGK3GUvOlJ2NLtkGXwJ+ThP+CMJWj+mh3QFnKsD9hpE9BGByRzJboBn2h6okJ0nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqtIbLGKY6xLG6kSTp6ZeqMWZrxoOSI/PJhQHp9YZNw=;
 b=Qjl24P9zeTcXXd0e/y4vD+whyEAIlwEa/59llDvObULDSzxkjiDqT95XdAnMJGR1vAdBdYZ7YhUy5flbDKPcJ3Bc3N8v+nYS4chiOthnLqaOKEJtejDVk5lBAVUaVtjtUHNxAn4siM9f57a1uA55YOPWmRfmQRVXI23PVi/64Rp0qB0nBIwdNE4+/bwqk0c8pAfzHA6xyfI17xjS/6pNWLcCR1Cq31Hym6p60BKEo6csclCMa32jUF8IehU0PELCrxF1hSKqYHMvd3BnA8+HzCC1Gl82joVqOeIg5OR1zqyMBQSIUTp1B7y9z/XDLWdq257ZQHinMdTAO0+fccIvKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nuvoton.com; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqtIbLGKY6xLG6kSTp6ZeqMWZrxoOSI/PJhQHp9YZNw=;
 b=il94ztlxyIzEZwB/d+efFTJE8teWvSezWflKwk8fgf6LdRPsAB9GM6SINE98wCtqUXioT6G3XsViOoXX5AR18XwvRd/cv5OUxx6zAy9PpAHBA9woYpubqxISCLumejp/hnSpM61/5VL6FQJ03a4KtMESLFGp1B3m8DYfC3rVlBo=
Received: from SG2PR04CA0200.apcprd04.prod.outlook.com (2603:1096:4:187::15)
 by TYZPR03MB6917.apcprd03.prod.outlook.com (2603:1096:400:28a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 15:17:40 +0000
Received: from SG2PEPF000B66CC.apcprd03.prod.outlook.com
 (2603:1096:4:187:cafe::37) by SG2PR04CA0200.outlook.office365.com
 (2603:1096:4:187::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Tue, 21 Nov 2023 15:17:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG2PEPF000B66CC.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 15:17:39 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Nov
 2023 23:17:38 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 21 Nov
 2023 23:17:38 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 21 Nov 2023 23:17:37 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id EF58B5F5BB;
        Tue, 21 Nov 2023 17:17:35 +0200 (IST)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id B7443235CE25; Tue, 21 Nov 2023 17:17:35 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.torgue@foss.st.com>, <peppe.cavallaro@st.com>,
        <joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
        <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 0/2] net: stmmac: add NPCM dwmac support
Date:   Tue, 21 Nov 2023 17:17:31 +0200
Message-ID: <20231121151733.2015384-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[211.75.126.7];domain=NTHCCAS01.nuvoton.com
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CC:EE_|TYZPR03MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ab169c-37e7-4d59-a6d7-08dbeaa5001c
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DgEccS5r0GAZ36rBapW52kBgjka35NqG4PBD0IAJo4d0oI06YyxNu4gCPI6Bz+IVXfFtip4e++Yh+FrD8t3sxwr2gu6CJSdaT8E0alOAgpEPdrhvHGe12ph+89bfW0ByJNA7k/YtNqozAc7ZQG98B/bzLS7iiZrAcB8xtu9XzeTEWsDyiUXuxhZv99DhTAImleHF2M/hbpX0ZXINM1zD1i9Zok6CvQAwBTcyFLJKjDXHBbqhAigLMykQvufrUpufLYLtnd6Dt1T8aBU+SWSUa6ade1flv6WpNyRZDPI0p8jL7Ldc/RaUf9CDznd5WyAIkwmdlVmVnvnBGH/okduLf8RAGFC2iofIKyPxlXFilwGuXZa8p+DyZX8kPmPCKP578bUvXBI9pMWHDpCCSDUECbOyyWYTaO91zx66VKYCnCRa+7l43OQFn3Rm2iFhnjop42aB7W/pHfkplt6A/jlMDpZ3DWrGUVgAnX+Y5whW0vDjTWOTmw9C2mLQ9H3cvH5gj1fqLIOsjPa3wsMPUZusZoDARMSszsLu5tnWJnW6ApvIWkLdtKi9pzuX3VHHUHsAsLj2du4OQl4W+Wco7trC+k9i4zZqQ9TJRkl3x8+VJkTf+/kYbBWqS5UCUh0OFxWdIUDVClmI7u8R/hg9EoDGvMTRZ5kwdKW88De5Wp6EJNN4X/OgndwYG2bJOVZBo0mXPPjL/M60gRJWs/22QIwS+ZgTSoAv0k+TohsHcU+62Bo9EAwY9eRaiX8zgZ3shtkK3xOj1XR85oKZU3HnPf+3GF/Ly3qXxfqsrOzVqgr+SG4Md/W6z+InLsYeM+RytUJS596yjhXo5Ztmih+uzSC0SrfJcLPywrE00pnArJ/3D+I=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(451199024)(48200799006)(82310400011)(64100799003)(61400799012)(186009)(36840700001)(46966006)(40470700004)(40460700003)(73392003)(42882007)(336012)(6266002)(921008)(82740400003)(36756003)(83170400001)(356005)(81166007)(55446002)(47076005)(36860700001)(110136005)(54906003)(42186006)(70586007)(70206006)(4326008)(8676002)(8936002)(41300700001)(316002)(76482006)(7416002)(5660300002)(4744005)(2906002)(2616005)(40480700001)(26005)(82202003)(1076003)(6666004)(478600001)(45356006)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 15:17:39.4188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ab169c-37e7-4d59-a6d7-08dbeaa5001c
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CC.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6917
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

This patch set add dwmac/stmmac for the NPCM Baseboard
Management Controllers (BMC).

NPCM8xx driver is a part of glue logic dwmac driver to support sgmii.

The NPCM dwmac was tested on NPCM845 evaluation board.

Tomer Maimon (2):
  dt-bindings: net: Add support NPCM dwmac
  net: stmmac: Add NPCM support

 .../bindings/net/nuvoton,npcm8xx-sgmii.yaml   |  72 +++++++++++
 .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
 MAINTAINERS                                   |   1 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   9 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-npcm.c  | 121 ++++++++++++++++++
 6 files changed, 205 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nuvoton,npcm8xx-sgmii.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-npcm.c

-- 
2.33.0

