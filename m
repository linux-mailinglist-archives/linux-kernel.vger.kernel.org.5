Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6019675617C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjGQLY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGQLYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:24:24 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9D1E4F;
        Mon, 17 Jul 2023 04:24:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPkMj1KAGYFIJVjc7HkX9UASa/59+XGEYr00ocT68Rl/lMQX+oZcdH70dGFSV709OxyAzxjG/3XXVsevbH/erg35EGDpt4vqFpWH/Xel+ROKXophaVpMBZbrGZ4jxxxWB3ZziIozSEy8+04sTXuQVrZ8KMApAYlT/XPz55i7XQUWpIiukcUOmBIIqQIEzL3zr2au39TYjDaMRoPG3Isu6f1tK/sH7zHaXm5JK0VT7IJSxDTJ2m39n2qiYsajZa0jJrr0/DX1e0lz8roX0qD4bvILng/ljc/edGu7RM+rgB+gyszGVmii7TsrQ/MMSW6HmzVtMZZDDqh9afzbs1DmpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I54V6jcxhif3kZrzyoSu4QcW9UPR9Sd/uXRtewAOFGQ=;
 b=go6xa3EfjAjmgDuzPq6MfGSiS+eVnUJtGx5/mDQr0IHEN05DxleSAfxQUU9Ak21PlPTJw/jJ01l5uVMV9McDyoPYh/hagHtYkkvvfEaZEUNh15wu+ovnoox5msekkS6k/ziw8tZO3gzmWE3Qe52DFIuPhk5Xhkd/NRfPQygSIa/E0vFMytveCoD3TEdvtD5LqK1RSEqbd1mbVb+U8c6/CRfxOgDmo8r75z/ShnucJMjwpldWYvLjoMBP7otVrKIAxmZ9x0VcPS6f/Q7WEUonvHEC7+HqJrTl/B2ZYaFC9VXpsXfePL3NB1PE6YYmltKf3tYsDSQjpWAbmFPa7yATCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I54V6jcxhif3kZrzyoSu4QcW9UPR9Sd/uXRtewAOFGQ=;
 b=PtI48jWKzvXD6BqRX+moseA+D8SQ9EqdaMbKq0k2LnX8UxSAU/ryhjvxMJciFSv6S5SXWFZ3O7p0Fvng8mHQVSypW/6Pp32n0bCVxgN9hkQJC0vLkgl/sPMhj7gWjMhh8y7t8VU4Yb0w9wKNkXLIq/I1w9r4Qn0b0bJpqHUqpoU=
Received: from BN9PR03CA0535.namprd03.prod.outlook.com (2603:10b6:408:131::30)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 11:24:18 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::fe) by BN9PR03CA0535.outlook.office365.com
 (2603:10b6:408:131::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32 via Frontend
 Transport; Mon, 17 Jul 2023 11:24:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.32 via Frontend Transport; Mon, 17 Jul 2023 11:24:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 06:24:14 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 06:24:14 -0500
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 17 Jul 2023 06:24:11 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
        <michal.simek@amd.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH 0/2] reset: reset-zynqmp: add support for Versal NET platform  
Date:   Mon, 17 Jul 2023 16:53:46 +0530
Message-ID: <20230717112348.1381367-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|SA0PR12MB4448:EE_
X-MS-Office365-Filtering-Correlation-Id: afa9b6dd-470a-4ed4-86f3-08db86b85c83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wd71FCScnMXgQhOoKih2t4Nh87tA2MeAE8osI5CC6meGpzhaBXORWfY5xR24sN1rygUwn8jH1lvpYK03R2tlxA7hYZpWKS0aQV9phEwL+dpcB5odr/6s7E+rLw61cD0b3j8Xql8A+Q0AZtmV7IZlGwFmoRDHzK+HBNtJhOzi6sZsn0KFRyvF+QRBJS2yX3B6bumkHEwIkMbutHc0CrRgs6yW3iMR2iGTMMkfdmar2P74qsD901YW+o13JstX+vyDa9h1st91YB47I3GsOBd3EBoCvJ343VZy9Ti/vLNF3IUpHeXGzBRO+S9WQjyXjCwTC4P5FG3rkZYCSv9q6e5+AFycJhztH3CyS2UdYdlgptnOfTsNUP2N1lZ3AyrG+RjDf2ZbRSmsjdh9q1ljIPUdrjRdH52uPSqfJR/WD0js512mAaCn/QNIjAXEp/u6gDZ2p7ubMssYzbHvSYKcvLzeHkLJS2wBIgCgQmyYEkRISwiCM07lAevyIPcroqRmes5F6fhNWhKLoA5kxxnl/S0nJWXbAx+ZCNGBRtoGO2cWH4MJqMNTqB7l9dn3l/SM0WR/yMd8AAYDnetgTeIlq8KTg2vxaQwPte+yJkErb6h0alqNUDw+6bSxe9yVrnYr4KQ2RoQBtkcv0n4lDt0ytI5eCZQKcn4P6Ex5YYCFktXb9M78bbTf0xfUe9pr4LTQPs0jAE09bBvPmIei2ha9zNGC6jdCjN8wO2u0bcnVlKNh5OEKsrGC0h+BasRRjMUdUBL5Dr8FmyZZUyPrVM6VdodKKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(478600001)(6666004)(54906003)(110136005)(186003)(1076003)(336012)(26005)(70586007)(2906002)(4744005)(44832011)(41300700001)(70206006)(316002)(4326008)(6636002)(5660300002)(36756003)(8676002)(8936002)(356005)(81166007)(82740400003)(40460700003)(86362001)(426003)(36860700001)(2616005)(47076005)(83380400001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 11:24:18.6816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afa9b6dd-470a-4ed4-86f3-08db86b85c83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extended the ZynqMP and versal reset driver to support Versal NET platform,
accordingly updated the dt-binding with the Versal platform specific
information like compatible string and reset indices.

Piyush Mehta (2):
  dt-bindings: reset: Updated binding for Versal-NET reset driver
  reset: reset-zynqmp: add support for Versal NET platform

 .../bindings/reset/xlnx,zynqmp-reset.yaml     |   4 +
 drivers/reset/reset-zynqmp.c                  |   7 +
 .../reset/xlnx-versal-net-resets.h            | 127 ++++++++++++++++++
 3 files changed, 138 insertions(+)
 create mode 100644 include/dt-bindings/reset/xlnx-versal-net-resets.h

-- 
2.25.1

