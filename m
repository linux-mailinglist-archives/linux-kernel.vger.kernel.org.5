Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B553765B08
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjG0R6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjG0R6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:58:21 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6DE30E4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:58:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fh4POh+xA8n+mQQC9bE7j6kAtqrXR83pwSgT/olLOKm3PL3SW0T0MAoBpR6HuBchrMRjeqGH0J48f6jurUJrcKTD8c9gHykB4ZQ6W5tCPuPnBbdjozGwAZt+FF/KaeiCakIv55ZceMXIgd9uIaAPm1xcUygWgbxWOGH5d1ADUFCNDYGZnIzq1yOSH2qOcIoA/9muk2M+gLkA/ODrdFGRetSsWD3nV7wJV/cxTzPetwkzA6sOj792PQwrB6mZqTlB5h0udwdSs8WvOqewO2IAZ77vH61Cj7RtVoJEhl099xYZdKyy8Uiwr7smFOiCRcdoP0ULXzYncWRBXLXIeB7+gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nps6tTmr1X3dGK/Obx0Bz0d81kz8PTyjTFbEBprFH8=;
 b=D9MMH5Z1UHgJRcyS+iR1nBvBmVu/2KE0FRScEp4G2kc1L9IrT27GUc7/3BJlpc4/oETvkpcUDVa6In6zC9+g7I6DHjsuLmutJ/XZrdD1dWp14iq8pTQGAWSaRoa+fODNSt6gVpM/4ixpnmLuU6ImwmzG8p1IgpqPADcPZ3RbUG7k0IKa+egpbghFm4C0Ktxa8+XMLiFoa61/ekj1DipIvfIHL3IHuzn+7M52RUUBoS7ZqLhgonPWlZ3m4OkTrPr69t6QDbwRMj6TRfyG6AfZdWXv4HSOTAs3apeI9o4OtGbje+JvhVdoL8v+oXI5mOhk6xHtzJr1hqypq1X66mHK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nps6tTmr1X3dGK/Obx0Bz0d81kz8PTyjTFbEBprFH8=;
 b=h5FWQXEqilYoHw9wHjz0ZG1JVlZoYtntTZRdJKsfONAr+vnYmGqyGsUXtd93Q0JuGJpZOUnNSOJSeA9IWXrsDfm6oH9Ua1/2kEnikE3rebWvBbYPtxBekDv53b0ff6z3rMdr5rtlQop2BMhl1UPtbyFFDKpoWYDb1rcdv8nByvT9C9GYLcQfyj5LTEzPH45Ao2GDxzT5r6F1iJX1kLs/9WcriyhczpEE4N8wnq+7nqKIw2lNktgXhJnALkogrpqS5oRzQzXjXJR6Ja7SAGBKQPNJBEzV/FhgOHTm7xh3ChhQGnTukLvGYM5x9BkM+jDnnHJfcICQDnHRdA0MonS+uw==
Received: from BYAPR07CA0001.namprd07.prod.outlook.com (2603:10b6:a02:bc::14)
 by MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 17:58:17 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a02:bc:cafe::21) by BYAPR07CA0001.outlook.office365.com
 (2603:10b6:a02:bc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 17:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 17:58:17 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 10:58:03 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 10:58:02 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37
 via Frontend Transport; Thu, 27 Jul 2023 10:58:00 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>, Lin Ma <linma@zju.edu.cn>,
        "Jason Wang" <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Parav Pandit" <parav@nvidia.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH v3 0/4] vdpa: Enable strict validation for netlink ops
Date:   Thu, 27 Jul 2023 20:57:46 +0300
Message-ID: <20230727175757.73988-1-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT023:EE_|MW4PR12MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: 367dc4ee-fb12-4603-936c-08db8ecb0e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OKeainWuNArqLXjmtpXche/h6NcIF68UzjAiKNa0f3gVgzcrTZQZweTWXR9VXlSO7eomxgVUeaB2fXvbKygWnZCR0oMYY1LglXs2m84t8b8cLGCReGBbERLh8UugC/ysXiHJt25fhGfA7ERXW9+eSNvP4OsZakzTWVerVgr1wxgEzk6YGek8aZSqgEebABY39/geyRe2O2PrgsLsveLSg6FtnGX36UneAyq00nIgSdph6SL5cYfdbPgZqARY+4HrdItExe7GKD+8PXRT0FCw3yxvakDeNl7AbUhzUliVBSEFC4F0rzCQxoOdW6TtZOIICilG4hdtvLF7Aip+cSqPxZQfBqSbX0UAC912OPfADq3ZjWKe63CQvNPfNbGT9q0DiGI2GUnNuJypg2R0G1lqQYMJHxQ7boAy1SCRBfdpDpmq7E0e6KHUPVgB16y09C5cpgRmQMI1tg9ShcUpuFfr3ua38dl8MjSLkuZ1PAL09fT/YNkDKlZuDFhgdEdY/qh0KN2LYoxAzTp2KpxX6hi0WwJZa9k8usASpMV6AqlRgQIiUMHI3d9gBBAG2m1JDvSv4vWMK6mV+gODzt71W2SebfygwvVV5Ph+3ZO7rYgHk4715mvbqyi+IODIa3Zmuke7aVo3Ef8ytbH1z8otk96tmT0GYsqGRYgGzuJaiRrLLkKIEj9NWask2IKxDNzpTMmHJrG5OZbwB82qVWZNP4d28tf1tBurljbTFugkynrF7ex8uOrRZ2rqDg5z9+uFyhL/oVyBLMgWLM7OMWY+AIgxDGFe3auKtbNVoABDKeam4Jg=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(83380400001)(356005)(54906003)(40460700003)(2906002)(110136005)(2616005)(47076005)(6666004)(4744005)(426003)(40480700001)(1076003)(5660300002)(26005)(86362001)(966005)(478600001)(36860700001)(7636003)(41300700001)(336012)(82740400003)(70206006)(186003)(316002)(70586007)(8936002)(8676002)(36756003)(4326008)(6636002)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 17:58:17.4004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 367dc4ee-fb12-4603-936c-08db8ecb0e79
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5667
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original patch from Lin Ma enables the vdpa driver to use validation
netlink ops. The patch got split into 3 parts for easier backporting.

The last patch simply disables the validation skip which is no longer
neccesary. Patchset started of from this discussion [0].

[0] https://lore.kernel.org/virtualization/20230726074710-mutt-send-email-mst@kernel.org/T/#t

v3:
  - Split initial patch for easier backporting.
  - Correctly marked patches for stable inclusion.

v2:
  - cc'ed stable

Dragos Tatulea (1):
  vdpa: Enable strict validation for netlinks ops

Lin Ma (3):
  vdpa: Add features attr to vdpa_nl_policy for nlattr length check
  vdpa: Add queue index attr to vdpa_nl_policy for nlattr length check
  vdpa: Add max vqp attr to vdpa_nl_policy for nlattr length check

 drivers/vdpa/vdpa.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

-- 
2.41.0

