Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C407809AAC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 04:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573115AbjLHDrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 22:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235648AbjLHDrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 22:47:18 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2081.outbound.protection.outlook.com [40.107.6.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCD51723;
        Thu,  7 Dec 2023 19:47:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egAclo4BGutUuMl/t9XeM0wUSRzmQpLjj1eBtKQiLoeXD0J0jSFRN2+t9A5rQVjDqAcz+kSxYNG+MlwP7EjdtGTN7T4cL5ccmVkNk3i3pPif7qmtvvefAsCQ4qkIi6PZGPuJmQwvmYqpakHp55yWrUa1ZjMzg9SITuM0hJaW8IuROOtfXQVmJ/MXY3c1UmNQHSbbg9fRk1IQlwGpei58e9cxivf1gAst+miuavZDTMqVl8jmqWWqLXy6GVqXNZAz0Um8YtJd37ImlIP4poXXAtDLGORMyWD0s4a1TIQqAQXB4Qd2vWs2zicxpVyoyS9JUtl2EIDx5wrmhV2Kpoz44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFsYfTI9dLdrSKC/yXcw0xxtxQedhy79RqMmoNrgj1Q=;
 b=b8GJaX54HERXfyl3Sqoi4SoNO1FiBQmiax/lCWKuBCwt9ikOJv1oxXo2OmL/TnueK/dHcqRgnsVWllKUMbKUL8AeyyAwDcvpe/JLPK3tLvEe4yr6exEL5+u643VUkxT6gBJ9Zp76y0N2LQ0rKhPSgFobCY0f3KXO3Qp8vAl/g0OJVjbWGGzPuwb6BsiUD3fJuAJcRm9rSEKQH+dXA8ybuRvBIdTcEljSxuGTPFuYAhuRxaMTqAdfpvf3e63eYDF2o8Bpv16pR03r73WGyAthABCUIRacWn7zI1TTfd2YxMT8j30+quckPyyw8LCOHUPsQuo5V2AEUkFVcNyOxNtY2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFsYfTI9dLdrSKC/yXcw0xxtxQedhy79RqMmoNrgj1Q=;
 b=YbNpisDTO1tFpC+6h+/yKPJA+YXZpVeaeu16I14w4iRjBvnmhlpb9+KGx8jPJ3Du7EgjaAfSWsL36Vzhha4CMheiCphyedaOgJjV4EwuQvH2LniMstpxK6oBtaDAfDe2JOXWpsdXnYtEzKPLuP6WHu8sINlKbEIa8jnRtAeDlDo=
Received: from AS9PR06CA0581.eurprd06.prod.outlook.com (2603:10a6:20b:486::21)
 by VI1PR02MB5760.eurprd02.prod.outlook.com (2603:10a6:803:131::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 03:47:19 +0000
Received: from AMS0EPF0000019C.eurprd05.prod.outlook.com
 (2603:10a6:20b:486:cafe::ea) by AS9PR06CA0581.outlook.office365.com
 (2603:10a6:20b:486::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Fri, 8 Dec 2023 03:47:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF0000019C.mail.protection.outlook.com (10.167.16.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Fri, 8 Dec 2023 03:47:18 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 8 Dec
 2023 04:47:18 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 8 Dec
 2023 04:47:18 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 8 Dec 2023 04:47:18 +0100
Received: from lnxchenhuiz2.sh.cn.axis.com (lnxchenhuiz2.sh.cn.axis.com [192.168.77.59])
        by se-intmail01x.se.axis.com (Postfix) with ESMTP id B43BCF7F3;
        Fri,  8 Dec 2023 04:47:17 +0100 (CET)
Received: from lnxchenhuiz2.sh.cn.axis.com (localhost [127.0.0.1])
        by lnxchenhuiz2.sh.cn.axis.com (8.17.1.9/8.17.1.9/Debian-2) with ESMTP id 3B83lGg41248431;
        Fri, 8 Dec 2023 11:47:16 +0800
Received: (from chenhuiz@localhost)
        by lnxchenhuiz2.sh.cn.axis.com (8.17.1.9/8.17.1.9/Submit) id 3B83lGOi1248430;
        Fri, 8 Dec 2023 11:47:16 +0800
From:   Hermes Zhang <Hermes.Zhang@axis.com>
To:     <sre@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Hermes Zhang <chenhuiz@axis.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: power: supply: bq24190: Add BQ24296 compatible
Date:   Fri, 8 Dec 2023 11:47:07 +0800
Message-ID: <20231208034708.1248389-2-Hermes.Zhang@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231208034708.1248389-1-Hermes.Zhang@axis.com>
References: <20231208034708.1248389-1-Hermes.Zhang@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019C:EE_|VI1PR02MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5013e6-8c89-4ab0-f0f4-08dbf7a0605d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tEYsRW0a/BfTTl4Huut7A1xTRDi+vIp/NPSPSbyf0ZbpXR0MPxz/kq8w1s1qIlhehWmaF94Uq1L1YqCCOiST/yfbZ4IemPHX4qkPYNEQWlYA6GZHETRY8/FQi8o3gscoWNpRdSgk8mDY0DFSqfHdkAh8lnMvEV2OXWXuiA9SWiY6wbRpaoS42sQT+XOWnwTVRVMqb7/7RuLx24zv4kwMg7/K0TIv5Lypz3LiKcQnBT4Zm2s7AnbTGCizRmvaOFkRZ+XTbXDJtzmiE1fQ9EqhTuM17GVFLV1Xp3/gopIfcqRK5tt4Z/A4jWRyI2mJrIk1iqRhoEjL3rLnXgwZob0RV3wQHnaCfkv28YucaVvnq4pmguRFMUZI/+zgvkZksMExcHpVeWInHLkoltFN34JowKaoj10+tQpungkbLdu4VAS4n8q5/D57j5hunl0baf9pnz1z6VlnJ+vbNtAaeBGanNaqm7A+L2bk2PQawrpce/LuLWG8jgxBkDV78upI1XesNKaugMoFq73rHdevDDqk73OrkfAw4LPA3vDD/eqZwx2/tXQxIox98hweCo9tlsn743nGih0JYSTlMVJRw9C+QLonE/BJNwiPvanQwsYm7jIZNzvoveYJQt5iKzW/oNIQu9J/HX/6lg5kUQcysmpHMUFe3fWgBtcocQ448Idb2JpLCpve/1i1wbPx+Afhv3vmhBgs3IU1C/b5JybJF6VJ5nA7PJDPdB+bQ4WUC4P6OPp/G0nB2pQAyOX+xJjBBF4Jch7eBb7l8WvQOJhe038hmQ==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39850400004)(396003)(346002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(40460700003)(54906003)(42186006)(86362001)(4326008)(8936002)(8676002)(316002)(110136005)(478600001)(70586007)(70206006)(36756003)(41300700001)(2906002)(36860700001)(81166007)(47076005)(356005)(5660300002)(2616005)(26005)(6666004)(1076003)(83380400001)(82740400003)(426003)(336012)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 03:47:18.6341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5013e6-8c89-4ab0-f0f4-08dbf7a0605d
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB5760
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hermes Zhang <chenhuiz@axis.com>

The BQ24296 is most similar to the BQ24196, but the:
1. OTG config is split from CHG config (REG01)
2. ICHG (Fast Charge Current limit) range is smaller (<=3008mA)
3. NTC fault is simplified to 2 bits

Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---

Notes:
    v2: restructured the code to support bq24296 and add Acked-by tag
        from Conor
    v3: handle the match_info in the modern way
    v4: fix compile errors

 Documentation/devicetree/bindings/power/supply/bq24190.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.yaml b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
index d3ebc9de8c0b..131b7e57d22f 100644
--- a/Documentation/devicetree/bindings/power/supply/bq24190.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
@@ -20,6 +20,7 @@ properties:
       - ti,bq24192
       - ti,bq24192i
       - ti,bq24196
+      - ti,bq24296
 
   reg:
     maxItems: 1
-- 
2.39.2

