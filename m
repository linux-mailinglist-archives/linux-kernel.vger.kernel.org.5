Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728CC763E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjGZSbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjGZSbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:31:41 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C8B26AE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:31:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuWbCBEICagEYih4IbQrz0GbK7HJWSjrYf8U61sUvjL7GN0xUXXZNxA8YgiYz4HYCxhMeC8X/EGQNR7RrPGW8NncmleSBbNnjOdudexLYntuI5Yw1OjlESjbAEIG3jzDMXK919HhbAfyZp/H8g/TIj8lHPEwPLwgFsvLyDuH/Z0DMa73o3GgPpvLjotnoGDowE/W54b1Aj9LYje2WWK/jO2zTzsQs/x5sTLp+4iGH9P4wIB4MN8tDX18BzaWJRdfgopnhLTHWRuPe+uka6KrN7ejEioYUXPEz2yPC5s+Yz3eQ+lRodf+sv+Ei5ZuRNO7JrAMx2/TNykkmjim2p6yAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NesKOVXikCLA4XF5mUs58QdvbPAAsWL7QAypABjWcLU=;
 b=V658FXZA4rHhwpT498KDJZk5Vb3uR35Ei87tRfjWxbY/IbhR/b3qixqE4PpC9mIPHFDXvD5WUnxELOOShWw6scyY1+ibxtS19sw/R3FskrjUnEkRBvYBqVoRgbYOU59EhNafhP8MDFYju6wMsMa4Gq72E/VBJKR/ZyApCEjZfLXuPZ5tbzAQ74WS0Nwe7PAJHo8NFJ5SawavWBiz91Nv9uKsGVSTCdatDxDsKLUOGN4mV/rG5u2YrprllRowfbXrl736o7wKaGO9d89ASPawF+svSSzlzvuQH/ln0GcivtJ5dBd45gDHkkL1dzJBBq8+SrAWhvPYux/FTqF74CUTTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NesKOVXikCLA4XF5mUs58QdvbPAAsWL7QAypABjWcLU=;
 b=f1v8oxq1si6gAlRukmx3TPD6nJZaOLnntbSrh0QS2NXeOZjBxNsK091lHMdxeQ8TCQT4zNk3imRnRdY3HmJYRwbi1UWhJXrdZ8sXv/mX3T+6yVozq9AQnP0HsY5cEIP9EHn0JGfnD3gNP+/+ikYfkC2RQr3FGfeUVwtDW+V570BVjXOg8n3ulYDT3iVEFNCziUx1rlFQ+xFBFSW7a3FJoehOyWXhscDFoSzWRUAoBLX24eLzvRLxF9kh9GmejRdaCGEmxEP/IRy007IDJHQOBdQIg73vSAUed1shgTJkp6Rbk34GI9AfW+An5gKWAvMyHLSzxqBg6L2S4lJ92cVGBQ==
Received: from DM6PR07CA0063.namprd07.prod.outlook.com (2603:10b6:5:74::40) by
 BL1PR12MB5272.namprd12.prod.outlook.com (2603:10b6:208:319::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 18:31:34 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::67) by DM6PR07CA0063.outlook.office365.com
 (2603:10b6:5:74::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 18:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 18:31:33 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 26 Jul 2023
 11:31:22 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 26 Jul 2023 11:31:22 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37
 via Frontend Transport; Wed, 26 Jul 2023 11:31:20 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>, Lin Ma <linma@zju.edu.cn>,
        "Jason Wang" <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Parav Pandit" <parav@nvidia.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH 2/2] vdpa: Enable strict validation for netlinks ops
Date:   Wed, 26 Jul 2023 21:30:52 +0300
Message-ID: <20230726183054.10761-5-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726183054.10761-1-dtatulea@nvidia.com>
References: <20230726183054.10761-1-dtatulea@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT046:EE_|BL1PR12MB5272:EE_
X-MS-Office365-Filtering-Correlation-Id: afd3126e-f57b-4e1b-4b11-08db8e068a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zikaesuyqw75V3iMAARzEIIU/sQFcTIDf4n/9vwLzfIU/HEsBLG3ulWRg1WHrum1CTCKR7aXsPNmxb9wIVkIIxy2bn/2OXJ0SLGEdFfu2wlQ0Brs7krJtiFxq/gR9FYVam7uVC5c5wzwIrMAmkEkTtEt/tN/Vu8bO+pMC1PkIjEXQclVoNjoTvRDTSWk+bRUW2XySU5XDQ/8UUs1W5sqCEiwzrMQlw6Ckt4s7Iw66tyI+8xvMfGVebftNZVeuRL7cPv/nozPbNGiPz0P0GaPRRk+OYVlAk3R7CpB/b6waTlabp8UG7Yw89ul6G27Z/g445iMwt5WxhTV1dLoO7wSDJjbIcR+Iao0wqx0XMY0aSMhNFUPQlZJ9CgQmUMAwC1Q8FK9XE+3LInU+KfjzqjR8hFYp7bnal9j9Fy509N3FUXfUx+5/c2tsPnVS23Utg3YH9TcP5ZxXZgwwMCeM2IL0mCjsvrHRlPNZMi2vltKB1Lyyx1zx9FJ0iaRqYa+WFyc3ZlvQD1jmUguMFoBPUjj53Sz50KR6v4FOojUF0drs4pqcMqVyYhiVREC7uE49P4tWoYAbz2pyJ4qqqJsSP4pfEqezaD88E70xfs2Wjll2I+JJvsnhzVlY1fhSAySrJrbcIUyrPmZvBH3fAxAXSYyEEtsD3uq42+6EaOWdXElmoeQNvtiG2ObEY061ADnnK5vkyOTSeRQ9guQ5gRu+MTLubyrB9QsabIpyEMe1jvgA4RDbBfP1eC4zWQt1N9bVHNw
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(83380400001)(36860700001)(110136005)(54906003)(478600001)(47076005)(2616005)(8676002)(8936002)(5660300002)(36756003)(41300700001)(426003)(2906002)(40480700001)(7636003)(70586007)(70206006)(86362001)(316002)(356005)(4326008)(6636002)(40460700003)(336012)(107886003)(82740400003)(6666004)(26005)(186003)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 18:31:33.9381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afd3126e-f57b-4e1b-4b11-08db8e068a17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5272
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patch added the missing nla policies that were required for
validation to work.

Now strict validation on netlink ops can be enabled. This patch does it.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/vdpa.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index f2f654fd84e5..a7612e0783b3 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -1257,37 +1257,31 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
 static const struct genl_ops vdpa_nl_ops[] = {
 	{
 		.cmd = VDPA_CMD_MGMTDEV_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = vdpa_nl_cmd_mgmtdev_get_doit,
 		.dumpit = vdpa_nl_cmd_mgmtdev_get_dumpit,
 	},
 	{
 		.cmd = VDPA_CMD_DEV_NEW,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = vdpa_nl_cmd_dev_add_set_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = VDPA_CMD_DEV_DEL,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = vdpa_nl_cmd_dev_del_set_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = VDPA_CMD_DEV_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = vdpa_nl_cmd_dev_get_doit,
 		.dumpit = vdpa_nl_cmd_dev_get_dumpit,
 	},
 	{
 		.cmd = VDPA_CMD_DEV_CONFIG_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = vdpa_nl_cmd_dev_config_get_doit,
 		.dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
 	},
 	{
 		.cmd = VDPA_CMD_DEV_VSTATS_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = vdpa_nl_cmd_dev_stats_get_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
-- 
2.41.0

