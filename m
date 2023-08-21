Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB79C782154
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 04:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjHUCS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 22:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjHUCSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 22:18:55 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2086.outbound.protection.outlook.com [40.107.117.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21459D
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 19:18:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LepYT6DiA+mdJHSmtRJP7wVN67wwuN8bHvDzFnKZGbm+tjMUBDhogeQUjdA33SKX9DC7DdxyxKR86A3gn6RsF4gwU2YNyNMhPqgGFZhziCwhyxQXot2PSzCL//Zu0N3FfznpPBTsTNWAtrQH8MfYmfFqNKFQP0sP0Cy6OpUALSPoou3fiNWeG44LDcmHuQcNc7ZQ5T5/PL81f68ew7gtoyn0rgKcgtuZOh62ErwS7b+PmpsIH+AVKNqz7+o05xXv3lyTvoUDyDe3svzoN7tUTymoJIEnvElf+v9XDO0hKQNHGx2IsiwB4bSPtUG9eX19Q4Krmlh7vGZ8G8AB56JH+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmWc+vPTtI36PBSZZ18usGL08DPazbA5vEUIIQo+3QY=;
 b=Si4qKnstR7BeXIj35OrJ3iXudWAN23zREP+mPHkR7gqIudZUELQ9WsIg4u1aE7uopLmp+xGCoXCtzNXa1ESXeQWBt00JlUpHpb5XxV6Zq1Ibni3xz+dMPXAVTwsanNVslOFyJre2rWj1pSgRfR1nzmVKWFbD9rQ0IFcdsJaATPm2muzrOxb8wrx/KGAWXb2MpA8Xy9BkcHC+fmXfKNPL2bLYnIeH7EtXL+Tu7oPVKMYDhNLCy4i0v89thZ/0eopS0h65l5tSS8Wb8VW5vlD9GhDA6V2fJWYGhQ/3xOXit62q4Sh8nmito1w5PvY3eq3AvsxzJsFOEudFnUUG/ZFufw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmWc+vPTtI36PBSZZ18usGL08DPazbA5vEUIIQo+3QY=;
 b=PzH74mkCN7FINHIed16p/fJXOWqLj205snckfZyPpN4k4IzeEw7DyyeVm+ZhD5qBZPPHDvImXAZu9n2D+bJItSlxd8ztO/E2gGoqmMoRh7A/IZELZvgZ8BmcEIKxakYp1NgFfPFUVnHpHrVL+bgNKgxlSaA6vYBzI7+wVIUM7lCvJ25mubQdAs7uNaN5tXTb7Dv0IoFd432DKDG0gEMQo3apSc3viP4YoUeg5Om8FaHXN08g/asZ8YXYqql1I2lacoHq/KbtaGJNsXDCvr6W0G2+8+8nc2BI3hs2qYz3JdSm/32kvxPDZvvtquV11IU04nrS/ulKaA1+uEgNnkCw/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TYZPR06MB3933.apcprd06.prod.outlook.com (2603:1096:400:29::9)
 by JH0PR06MB6632.apcprd06.prod.outlook.com (2603:1096:990:3f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 02:18:48 +0000
Received: from TYZPR06MB3933.apcprd06.prod.outlook.com
 ([fe80::7e18:3180:75d8:5495]) by TYZPR06MB3933.apcprd06.prod.outlook.com
 ([fe80::7e18:3180:75d8:5495%4]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 02:18:48 +0000
From:   "Shawn.Shao" <shawn.shao@jaguarmicro.com>
To:     mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     lege.wang@jaguarmicro.com,
        "Shawn.Shao" <shawn.shao@jaguarmicro.com>
Subject: [PATCH] vdpa_sim_blk: Fix the potential leak of mgmt_dev
Date:   Mon, 21 Aug 2023 10:18:35 +0800
Message-Id: <20230821021835.1134-1-shawn.shao@jaguarmicro.com>
X-Mailer: git-send-email 2.37.2.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0046.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::15)
 To TYZPR06MB3933.apcprd06.prod.outlook.com (2603:1096:400:29::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB3933:EE_|JH0PR06MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: 401e5512-9167-4ec5-192d-08dba1ecf3fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5UQmGLDCuo6T1YU0z3iK/Yg5KkmEVZCLps2D7XTxUbQPUUjl0lTxhyvDCZBcdEwcFcmoMVUcXGFu+CIwc81rJacNP0rnhuhS51e3TnUqiDnsCN2qOYwSwgxrKO6BNjhvVKAyz0YvbdF6fu7AaVspwH3JIHfiRkoPSaUCzhOsiQ6x3rO4IjzXLrEp5bdQrrSs4bTo/9C8/uTXpIp0r/oSEv/9fDoglV/caDkCeoxHJsbr3wvY7i1v2lZ+nMhCH64Wbz80R68N1QppiSANWKMX2x3SH9m9QqTTuoLx811xjWTwMBokykq1hVfkR+Yho2NujiuQfRzM1ETedH/L+2kFHkKlRcYvmz1iqnaMcTes6izlG8iiwAXDD1pW6K9Upy4gLdblX58vHZyoDLH1FjVuCYjFsFL0LwTT2f5w5NUHFqnViVfAVTxZTQ9pmM+QhNiNvQO84y8FwRuTBo5LBmcCwGsB1aFlfWQ2bKQqw4zNIA+TDNkQd35XN57w/CseUtzRZOdQ841WUXqjB7Z+MNVstpwOqOAAktPLwz5rfSFtB3VI7gENoD2oIM+GRgft2ZFDyxa6lYtelEdFnGC4sKR8w0Xq5BccM/KB79L5l5cVEOdLGlHhiBvY1EwFrLJE9tsS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB3933.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39830400003)(346002)(366004)(186009)(1800799009)(451199024)(66476007)(66556008)(66946007)(316002)(6512007)(8676002)(8936002)(2616005)(4326008)(107886003)(1076003)(41300700001)(36756003)(478600001)(6666004)(38100700002)(38350700002)(52116002)(6506007)(6486002)(4744005)(2906002)(83380400001)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BzXCaIceIkzAFLgUVVzSQTjPprHt9KJGlaHPY7aP5bfO8WaiF4YgCBko2JVM?=
 =?us-ascii?Q?OSnCJh/W+cmqODJQMpN8kjbk2zmIhoz68U3UxxokuB0/DCbHm3U2O87F0wXO?=
 =?us-ascii?Q?VoG96LvCc0Or1LSHhJ6O4SA0zYEL2NjqneJVVyDEuiZ0+Vg9GrDfy2nmZV3T?=
 =?us-ascii?Q?nBtz6hceMx9JCu8XfCptEeT4JeX13b0PJGyxwrqpgqdeJLBKfRVmv3+OqAYH?=
 =?us-ascii?Q?KBYzXxyCOOOWQRnp5/gQQoY3wFrfGRNRAnvl05Btf2YshHbJmFeQhVwaqrdD?=
 =?us-ascii?Q?M50AvDEL1ZoE9J3nKIYM7EBQf0NLjZ2p1zJpZqm0FoUyGCddzuHLUwnojgSx?=
 =?us-ascii?Q?4VFxyWDAqgFdIRsZ99mzSoD2EZRNIaX4rTOokXSxIwfhTm2z8fOWVE4zJTBt?=
 =?us-ascii?Q?bHEQbcpvnp97Otokt96W6t6WPprYi4JUCvQuMOLXTm19AYRA2lcHgSNiDFSQ?=
 =?us-ascii?Q?EBGLh2PfbuZ7L8bad7gbjcZyTBNXNCVKWThi3k8FO7STi7segcfFL6qhwQ0t?=
 =?us-ascii?Q?oVf5zCyfm4AbJXV+Qda+G+TOXK4jBMVTLcm1gjrCjMy2QLPWuU5B7DNn7Zx0?=
 =?us-ascii?Q?0jUm+4TQ6mCiU+xe4/aqDZNlJ7O8MW7H7H8+bZZqTXDVA+pqERh3CRB1Gggb?=
 =?us-ascii?Q?xxWzjK4dOMNjd/Z8R4JS3ciIZAJc1Sm0uyNQOjU5BX/y89TGpnA/VTpBF47g?=
 =?us-ascii?Q?gzC7Lqpkug+qgUYU9fygFu+Cf+22JtSuM3UeHlWImK1dWwD+Xk/8+8BklYge?=
 =?us-ascii?Q?PC0riUC9jqdY0ARBqwnmhQEbubgddLgkFDnsB2CPma2DXySoRd6OiP0ubWEZ?=
 =?us-ascii?Q?npaq3kKRvHfIf3ETWE+WIaGSsGheQfrCYxiRN3awBPl1poY5znNKoNW0DSH2?=
 =?us-ascii?Q?0Tj+D/J0GMmLGe7fADoJJfZihhL1yjlV47TxK4X7Ot/G+xu0Pg3uMeahD4+s?=
 =?us-ascii?Q?9D83T6r6phL8cSEubWx+kXSaGn1vpWXvDJnbkp0/wDQ9ssZFEzRX2nXaTdSy?=
 =?us-ascii?Q?2c0pG+li7ZkU/KwxTYWRVimDjmbO2DtoD7orKXucmLtpenfFhUTmMK7XhcA2?=
 =?us-ascii?Q?KvoI7F2zwzgMj2vw0o7dmG6LjrVuUbpkLZ6HpFxMe/+CEyIosYzFpn/V6F+6?=
 =?us-ascii?Q?pMvIaWL8vLhBjqVx1Oy0gVFC1mPJ3pU1SnQKfiladpyajHEjB5lBt8uAxSiB?=
 =?us-ascii?Q?3VZgguDyKuInYrPZofCedAqPmWW+4nM2MLcV/+VRa8w839yRQ+Mctl5ehJlM?=
 =?us-ascii?Q?wrIU6oKZvLcYodI5a3lgoDDnIQtz1av75CQbBmgle8xvpcVtS5Dl8SptXdkW?=
 =?us-ascii?Q?yBKukcDFXy8zSt/EADyR33Crt+VJqNcQqx3ZhQpFVKiQNWQ7RGT3AxI8hvdI?=
 =?us-ascii?Q?MvTgHTSTIbsB6OzJbnDBjx9ngZOOE03K03c6JIZLyE9wkPf7gRypLV3OfyXC?=
 =?us-ascii?Q?V1Lb9gD4zS+ORNFs8jyPFlt1mIw1l2X19An0nve/SdSg58nBfYWKAV98Ea1l?=
 =?us-ascii?Q?XDR0qczI24osJ5v0un9KuQCG1YgjYvnxv63UHWGasdmwTken3LEIJ7qRFSgY?=
 =?us-ascii?Q?RjUn8JTmwuoXS/KWs4PjKJdRgfEb0OcTITuUlwzjIrYjElBluQEhNC8XlwhW?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401e5512-9167-4ec5-192d-08dba1ecf3fd
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB3933.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 02:18:48.3933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHe7txyLjwZRZgH7FCnT1KUcQ7ZjJqWrxTayAnP7Kv9lUFsErBSKnTu71hpaDMMe5U7VCXEk1R7d6iA/RxXDp8kbReanp2U/Xah+DgC3LJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6632
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the shared_buffer allocation fails, need to unregister mgmt_dev first.

Signed-off-by: Shawn.Shao <shawn.shao@jaguarmicro.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 00d7d72713be..b3a3cb165795 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -499,12 +499,13 @@ static int __init vdpasim_blk_init(void)
 					 GFP_KERNEL);
 		if (!shared_buffer) {
 			ret = -ENOMEM;
-			goto parent_err;
+			goto mgmt_dev_err;
 		}
 	}
 
 	return 0;
-
+mgmt_dev_err:
+	vdpa_mgmtdev_unregister(&mgmt_dev);
 parent_err:
 	device_unregister(&vdpasim_blk_mgmtdev);
 	return ret;
-- 
2.34.1

