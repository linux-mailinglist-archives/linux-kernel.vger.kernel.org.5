Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A80880EB4D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346437AbjLLMQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjLLMQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:16:39 -0500
X-Greylist: delayed 1657 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Dec 2023 04:16:45 PST
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E030DAF;
        Tue, 12 Dec 2023 04:16:45 -0800 (PST)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BCBFlxD006990;
        Tue, 12 Dec 2023 03:48:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type; s=proofpoint; bh=wgC1suebrDF9AZq26Lu
        ocx4p+8YMTeMeMAVST/Xi6/o=; b=O9OyXe5D2wWxAjKQlSiwUWqsnTMnPZjs9CC
        Z5Wpnt8Frj+5VEEzYJIUH7Bkz8P3VxjQLsfWbbKZwfpLvhEe40zC5WwSpVM9+ETb
        K2bXiwXCRvsevXqDdyPv9fWtk3d2zool3r/p/dj8KZkL57vdEHNiXRSwefupuVND
        +U6NrgXEUMqwai7OJiRKM8v2X8Pwn9KqdW0HIZ73BUNTdHrA9zqak+ASUMXZ3yvK
        kAlgKv1/kKu/VDKrCbJ8ZZjA5v/Ngx9BkTaX9udmgMBDlnBnBiC2wbLzWMbfYwtt
        QqC1ok/+mM5nBAU+Bv65jABG9JKPrXARSCA6qDOmLH8ZUNo7DXw==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3uvnnx9k4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 03:48:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jw+CKIJUa8EbrSqvVbcHZkCrkVI7A0raWF0DwBsKTxD1LeQU7Q47cK/Gsqr3XKetmhvRnJX8E0F9Iw3mvLelKlNgLURmu0V/3dRhp0MvkSVfg8SX6zmgbR2XBfgai5cCmBpEoZjUCAH8bm4LzI+yz5EqUL6a4d+Q1VUl0StWPdFdCylndzqDLWFfwyZ5saHye2+WLg0btcX5Qw0yxByx/U/V/VW+c+0NM6OhvcGZIMVxRNEZHAcEubUkRg990Ofl14UEnu8VYgDdI4wvAWV1dBubB50LcXttrL1VxNgPf0MAJ0+L4W6xlbaMRbVnu/wf66LPgZDD1WPzZ6pt0PGQ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgC1suebrDF9AZq26Luocx4p+8YMTeMeMAVST/Xi6/o=;
 b=CWREVpJUVgYbmm1kx18zATPdTyTBN4zSM0vMP8YmV4e1PPeCH1R/D2+UwZXRohIHkMyBvvm2Bta8fS/VB13cO6GH4h4aeGs0iI60HcQtgOwHqRbMFuI8l+mhh6UzU31SYdF82hdoWSJ+ubm/8dL5J3f95h/AAAErbpDbGixi1AZLvR17S5gYxj9eGHiNQJCGsYoyyVVkSE63bTpolVnBACF/oG1vFcY6S6WcKxal5Wq8eWyT+02tZBnDgok56/LvIBDw8XxSUF5Xlpc7HHI/jR3wDwr6RPObFQgA/9izqmDxfwSRFvGy7HnVrEp3eBzFk5vK0RsKBaDAKYG9rdZndQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgC1suebrDF9AZq26Luocx4p+8YMTeMeMAVST/Xi6/o=;
 b=MqHWjyldjvgBDdmzaFOFDmlbPZk6p0CxDyTjTQaWjIBpzSx8l29pxaXLuKwPyyV4GCYlIFUK2s7gPmBj1bcYfW7ZCwp0JiR/W1d5HW3qgLeRR+GEnuJZYtaplqlc9F5g5bsLh+sj04cnZzOCIKH2KFdCozuhQnLkeVXBPzuRDoQ=
Received: from MW4P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::8) by
 MW4PR07MB8523.namprd07.prod.outlook.com (2603:10b6:303:100::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 11:48:50 +0000
Received: from MW2NAM12FT037.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::7a) by MW4P223CA0003.outlook.office365.com
 (2603:10b6:303:80::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Tue, 12 Dec 2023 11:48:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com; pr=C
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT037.mail.protection.outlook.com (10.13.180.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.23 via Frontend Transport; Tue, 12 Dec 2023 11:48:50 +0000
Received: from maileu4.global.cadence.com (eudvw-maileu4.cadence.com [10.160.110.201])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 3BCBmjpm027153
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 03:48:48 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 12 Dec 2023 12:48:45 +0100
Received: from cadence.com (10.160.88.83) by maileu4.global.cadence.com
 (10.160.110.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7 via Frontend
 Transport; Tue, 12 Dec 2023 12:48:45 +0100
Received: from vleu-orange.cadence.com (localhost [127.0.0.1])
        by cadence.com (8.15.2/8.15.2) with ESMTP id 3BCBmjdf1468951;
        Tue, 12 Dec 2023 12:48:45 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.15.2/8.15.2/Submit) id 3BCBmiJv1468949;
        Tue, 12 Dec 2023 12:48:44 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <rogerq@kernel.org>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2 1/5] dt-bindings: phy: cadence-torrent: Add optional input reference clock for PLL1
Date:   Tue, 12 Dec 2023 12:48:36 +0100
Message-ID: <20231212114840.1468903-2-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20231212114840.1468903-1-sjakhade@cadence.com>
References: <20231212114840.1468903-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu4.global.cadence.com
X-OrganizationHeadersPreserved: maileu4.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM12FT037:EE_|MW4PR07MB8523:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7958f7-685e-45d4-57bd-08dbfb084efc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7iVC9reX5MLtQ9TUJiLkFnZaUqnIfNRjIRI/+1proeEAfMuP6XtcgSk4tTiDEydSmuWE7hTfm0EiVDz4AcbiWc3d2xwfJFWPG0f4oq3iVq+UdvF6KQW+mS0vlw1Lna7pKG4buT+0ZiNnowfC75TvaAFV08H8N3hmIlD3M31KKmtHXLh4oycjTYx3TWb4OacjIQLkOTRHD0Ib0nBC9XuwOy21UaQcNa3j7eOSCvGw2LoEQ4UZYiDER2c/JYCKNwv+bokRVpDKck18vqEduyP8zmlPNNTx+tugb0uwbfyiLs+IbMA0MSweksc4kZfwS1cn7LxkmbSl+Vr/u+oJIsH8UBXYvyhj6yJZSH+ULD1qnXTI5+hDh0TjsAFm7I7fb8gABkTTFAZs2g2RQDFVVGe6J65zuRVnw/eKMP8fStUrIc5fMIlqgQyD2caMoB66FviofoocxMAlvV/FvSAL8aegg8fNDzwoIEe4GfgRew8Mtl7Lc3uA49bXSPrOfBnEWVr/srrOMKhJlJN9+dhcacl+ZLgATSmYAFzDfFKx6YoHESti3ocAGR6a5h0jZOQ0ZLKUzBTeMUeak7IXxRGbSLjUAJf594Bt/i57Uy8qzH8vEk3bP7nnaLUFI82jzX21aV262i1LNyKEBXZ+WaFVYS1vYwK1xXaPMQld2+hOMysuQjIGSxQXOGVKALghCbCmG0YTow8Xne3MCD+pe/yLWmR/Je3md14F2mcLZ0R3Vn83uj+FIcj22kXsb51lFPWvibS9En6YS1SFNBSwO/pdGKGWmg==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799012)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(40480700001)(86362001)(40460700003)(42186006)(110136005)(6666004)(54906003)(41300700001)(70586007)(70206006)(82740400003)(7636003)(356005)(36756003)(336012)(26005)(426003)(1076003)(2616005)(83380400001)(7416002)(2906002)(5660300002)(478600001)(47076005)(36860700001)(316002)(4326008)(8936002)(8676002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 11:48:50.5902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7958f7-685e-45d4-57bd-08dbfb084efc
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT037.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR07MB8523
X-Proofpoint-ORIG-GUID: qIQPXSGfEa7Af6OzEL27cWSbvSrVeNpi
X-Proofpoint-GUID: qIQPXSGfEa7Af6OzEL27cWSbvSrVeNpi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxlogscore=887
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

Torrent PHY can have two input reference clocks. Update bindings
to support dual reference clock multilink configurations.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 .../devicetree/bindings/phy/phy-cadence-torrent.yaml        | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index dfb31314face..98946f549895 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -35,14 +35,14 @@ properties:
     minItems: 1
     maxItems: 2
     description:
-      PHY reference clock for 1 item. Must contain an entry in clock-names.
-      Optional Parent to enable output reference clock.
+      PHY input reference clocks - refclk & pll1_refclk (optional).
+      Optional Parent to enable output reference clock (phy_en_refclk).
 
   clock-names:
     minItems: 1
     items:
       - const: refclk
-      - const: phy_en_refclk
+      - enum: [ pll1_refclk, phy_en_refclk ]
 
   reg:
     minItems: 1
-- 
2.25.1

