Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E2080ED96
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346436AbjLLNav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346522AbjLLNao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:30:44 -0500
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07435A1;
        Tue, 12 Dec 2023 05:30:48 -0800 (PST)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BCBFlxC006990;
        Tue, 12 Dec 2023 03:48:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type; s=proofpoint; bh=Kr1G8S6OzQNIWYw3Pzr
        cXZqWHIt6p6NrtYa/jg59Ojw=; b=ToWjewuQxTOxJYIP7bHzDzfRpOclLdsvvFu
        aAo2YvNF8urrne8+Ll1hRQHgvNjHuObA1/lP+Xcm7qWoJ2TQcJTijMteFHGrI1Z8
        I/yjgrpT1c+TjNfHIPzuVwmq2eMBTO1XJpGN7UbeMXd6cWSVAp62Z6Zd5qUeIJqC
        Xo50nWR/dPNwDOMc7GBVqyWJvtIaAkDb0gMkbcBgkaw+HtjmYh+hr4Opz52LWpJF
        mk7MOsoAh6XeJT1Hg+zPsU2e0k/9+iu9C7HfXn/WQyn+RMbY4DoOp7TLCFDIYpBA
        jdbqxlxBAt8hSJYfeyoYk7iSY4H0KKki5ZbJjgEuzk/4A8XOUkA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3uvnnx9k48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 03:48:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0RUhtsS5sjIk2gdo7ZSS8rG+wNtGVMjuEKVUFERbqPTdQLfHBit25dspGUG4/86QpfH6BtWkrjLfNzkUBLtsskWP/GFKIpG3EH3t+Yj1nvhPXTgBoBnQVlvJ9YMq+ohtFrkqtpIKqjzHr64HixO+qJSl+R+pkOCQ9g8pW809GM+KRxBL6XceCnnnhOZIKmRzGj2ALEwJrokkJfPnbukTMzfEutYk8f4xb1VERWmX8q1JMEakMXDC7r5TdUiwa06H33Ud2/ftxl5sIaSwQZVROz3MF70s/djlmLru0R08V+bbEjH6nhfq3nWQqy0Surg1cD+9Cq5b7f3UlgZlx2lTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kr1G8S6OzQNIWYw3PzrcXZqWHIt6p6NrtYa/jg59Ojw=;
 b=O40iEnfVPdbXGr2MVyEKQYTlTVY4reXYPj7DP2RiuvHiLF/y8C9BnT/txj0TN++OQqkaTw0IhiKX1gqAszGDyWhzXCDl0t0nFmzNVEXzzGCq/GTRlQAGfssfAYT/8zi5IppL4lLPyFovpTOeVKM833MYWP57kXDLhma9Z8PgjVLChlpw1XxUhAN7AbUoqAdMIpTHT1tCaBybHwN21/52ABY+lUayAQx91HQtB/hjgFnb0+WlUgJ27USs5V6BeYJM/gjnnn1wzIfuaCameLotlLaI9YYnWlcX8En2+h8+HIszmjecC7b0RBWuy2V+5QTF9TRw2nAywgD7eZZ8JRUOTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kr1G8S6OzQNIWYw3PzrcXZqWHIt6p6NrtYa/jg59Ojw=;
 b=Hs1Q9FW/WKPNl/M0Qap0kw5YqmTt5wFYH9KDNFYuM/Bed0iqrO7uj2PjLfRwZiMYVskM20f0g/J+NKyBli1m8d16Km8AxTilTLALtRRWX9ZZLdTcmzDqcSyP2IK1iXP23OZWK9KcfQyURGtBsIhrBU9dpZifvK+nuOBRuk2xBAA=
Received: from DM6PR08CA0007.namprd08.prod.outlook.com (2603:10b6:5:80::20) by
 DS7PR07MB8335.namprd07.prod.outlook.com (2603:10b6:5:3ab::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26; Tue, 12 Dec 2023 11:48:50 +0000
Received: from DM6NAM12FT045.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::74) by DM6PR08CA0007.outlook.office365.com
 (2603:10b6:5:80::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Tue, 12 Dec 2023 11:48:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com; pr=C
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 DM6NAM12FT045.mail.protection.outlook.com (10.13.178.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.13 via Frontend Transport; Tue, 12 Dec 2023 11:48:49 +0000
Received: from maileu4.global.cadence.com (eudvw-maileu4.cadence.com [10.160.110.201])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 3BCBmjpn027153
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 03:48:49 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 12 Dec 2023 12:48:45 +0100
Received: from cadence.com (10.160.88.83) by maileu4.global.cadence.com
 (10.160.110.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7 via Frontend
 Transport; Tue, 12 Dec 2023 12:48:45 +0100
Received: from vleu-orange.cadence.com (localhost [127.0.0.1])
        by cadence.com (8.15.2/8.15.2) with ESMTP id 3BCBmjrR1468963;
        Tue, 12 Dec 2023 12:48:45 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.15.2/8.15.2/Submit) id 3BCBmjDW1468962;
        Tue, 12 Dec 2023 12:48:45 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <rogerq@kernel.org>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2 4/5] dt-bindings: phy: cadence-torrent: Add a separate compatible for TI J7200
Date:   Tue, 12 Dec 2023 12:48:39 +0100
Message-ID: <20231212114840.1468903-5-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20231212114840.1468903-1-sjakhade@cadence.com>
References: <20231212114840.1468903-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu4.global.cadence.com
X-OrganizationHeadersPreserved: maileu4.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM12FT045:EE_|DS7PR07MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b5ff15-6e66-4f49-899c-08dbfb084e97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /HAxyoSoWZ3MHUInz81pQhMyottFYP1KQwbg0kzSDiFPHkQjI29jjiMns4mp3Gzf7/zseHg2NDwaZNE+yGC78wIVLWHLEWvqkRdZt1Wm+SirEfdVhY+CTksO4h47gjGxLt1HeQmxUBSdW/n7txOvCkMp4NJ7FVXDaFaha3cGzq9YZgLu6MrBCGnpAazaraCqInW5QLFDNppZxgIH3hSnvT2xMwh4lsX236gqw9R+4ybywLr+xaoCpuRJz1Vm76sFQtt6m0WQ2b0brAJDSYwETf2vZYLkXUNNR9eJlikfu1hC4D49LNUjVJQ7hBOgeRG4++sQggkU7vDXdTfxR0TTp4idTHYe8h1u1/hlnWjjKPgITg5be3M/gNGsFcrZU6hQ5hw3M/2DpqYuzdHCLpiClPV410uvVGa8JmuUKTX8F4T8qZHh+hyoe1ymFeyymlYKJcyC2+zaqL0lIM7TcWTxckxO+NQV2fD1Ccp5c/V7a9TthspXBoHT2/ttcz5+zVrEXQIKFw2lv7Pn0AsAYm3wAljTYJkG/9ZZ0zKumKGxv7r2B3e6OgRqYWLrxUv/VdE5f5rL/HeAuLeIaeZBkD3EHT4Cmg188IXoz7BTpB/jC9p0a+5YjGnmCal431Tnvoj/n5qTQyNcI8OrBihWadQGz4yY+PmFgIKNbvzKXz7la/HHt51TtdGYPNYH1i4SWdRRPxTeOp+BAZW99p+1bR/D5qUNritz3N9+iJ9M7Sp3FmjrAn96AtPc5yQshz/4fqFMJflaE58Z5RDxZW/60xffxQ==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(82310400011)(1800799012)(64100799003)(186009)(451199024)(46966006)(36840700001)(40470700004)(7636003)(36860700001)(82740400003)(47076005)(356005)(426003)(4326008)(86362001)(316002)(8936002)(8676002)(336012)(6666004)(54906003)(70586007)(70206006)(110136005)(5660300002)(40480700001)(478600001)(42186006)(7416002)(4744005)(2906002)(36756003)(41300700001)(26005)(40460700003)(2616005)(1076003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 11:48:49.8983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b5ff15-6e66-4f49-899c-08dbfb084e97
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT045.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR07MB8335
X-Proofpoint-ORIG-GUID: NrIBm2_kS8wtmcBIt8bjdQbIqeATiMrq
X-Proofpoint-GUID: NrIBm2_kS8wtmcBIt8bjdQbIqeATiMrq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxlogscore=862
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120094
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI J7200 uses Torrent SD0805 version which is a special version derived
from Torrent SD0801 with some differences in register configurations.
Add a separate compatible for TI J7200 platforms.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index 98946f549895..a053ae5668de 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -20,6 +20,7 @@ properties:
   compatible:
     enum:
       - cdns,torrent-phy
+      - ti,j7200-serdes-10g
       - ti,j721e-serdes-10g
 
   '#address-cells':
-- 
2.25.1

