Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABFE7C8916
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjJMPsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjJMPsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:48:09 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2126.outbound.protection.outlook.com [40.107.241.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9DABD;
        Fri, 13 Oct 2023 08:48:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCiPAM4m5h1kBcCX1LtmNTryMNosiItk1KgrY8m82khDdDq0zzLLIJH2AMhCVuxi49LfwKc1gKxk5+uBlP75V0bCxKxCBj/mGMdtE3yFkdODofvzi2A4Si4S1Z7G1lq+J05t2FrUoegAJr2Ndes3BM2xB8/HQG1WZjkZqfpposrwHC4WMoDxF2Ez7LTH9vkFwmKEKMPyspZ3Hmvju08Yjv9F1r0FSZGUv9uEu3cOlWSz984KrM8xHpEHOFc4IiGLDDUeXmgLE8/GpOa61wG5k9SM13oFhlZ5o8I8Fb80WY2JTXKby/80eoyHom9i5spQaIeL0r4T2nV7JPNcg8wn3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBs/WpjvyK7bbl8B0Hw3cWl0gUOeweqrNR+s6y6bubk=;
 b=CwAneneojIDbY2WULuerpdbkWB/MwiASX4Ds+7SIEA+vxoepJfG6DIVmPurXNtUieXwF/+ObsnS35NpT9Wqgj+NiCr4HcS7K5of1z1BYA+x1P4iKK1t46xDQyLSBIG1i+RStdSkz/3vaxb87hMRGHwdkYIVmdPxEuva2PiO4RzAUF8pc+zTIqoZQHaB6leepDm5sFMNDVrfSRrZ6YM/Oaayg+4uiI+mlq1SOEOVcPv6c8cZmWaSLpx5GRJPUxDnaGa7RV9KEO/6RooqACfWxMsCpZBO7sJ/a8UMFqq7hDVnklSqSBS+WMTE+kW1XIgivl/6MCvQZtJVwRJcIV4V0rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBs/WpjvyK7bbl8B0Hw3cWl0gUOeweqrNR+s6y6bubk=;
 b=KLSGKBcaFLIjwg5JVwA+dBmJQOThFwJpJPMQNA4l+C2bHiqREAZcPctRGJ8x/tCpUsC8CUSerNi9DIUkTtwee2Q25kTWqjncHs7F+n46qpO8N+xUHDevH0Ny1kBhvpMSBJ06sElg4h14xPse8RjUNyuSjbQs0LceQSKuOP6P3JU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:10a::24)
 by AM0PR10MB3153.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:184::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 15:48:03 +0000
Received: from PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1315:9ecc:6928:f486]) by PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1315:9ecc:6928:f486%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 15:48:03 +0000
From:   Emil Kronborg Andersen <emkan@prevas.dk>
To:     linux@armlinux.org.uk
Cc:     emkan@prevas.dk, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        saravanak@google.com
Subject: [PATCH] serial: amba-pl011: set fwnode from parent device
Date:   Fri, 13 Oct 2023 17:47:42 +0200
Message-ID: <20231013154742.76836-1-emkan@prevas.dk>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0011.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::33) To PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:10a::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB4576:EE_|AM0PR10MB3153:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ea52308-7569-4826-8667-08dbcc03c8e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gipw1Pf1SVlmNOmQ/cZcTXRTrx9Byx0F3Je5AyUtLOymxDBx+SzaNJt9F5tW4DdeEO+yrNvoF0+bh/OPymDlwlPsIAynhIgxGEWDgCSD16db/47XRB6OwtPpjByD5eCwTKrWFzv8VREb9nyVXiSoLatp9ZI+Uwfg4+g/5DpIQlaPCnLFkOJi0emlVS+6JpvJskHMk/YJKHN087YLiNh979x8PJ1NTL3STX4uQMNAWvfk8sAMgrwuNkbkLBrij6OeUUn8UdXbrnUN9HFiv9HoN/esclataPJKodJV7OTNrbJ3dgQOnaSST2v4DAcD2XxmJ+fwO8J7RIiAGttiLihu9ygVwXWNiyf/a9bD5AlEfC6HzS5REO7NKyLQoiOFO8Q39qwF/IQfUHOGzNL/RWOzqO8wQxrm7GOgUaNVpviQhT8ReUw5qDps0PHaADT+ANGMtYVFEAvEcK62nIq6QaU/eN3ZHUO+8nW/Pq4oKkhNIAJMbDEhCWqvReuzPwZ7pEWa2LCfIgnoynClIuaW4jc8QhGjkaoFrmVrFTaZ1x8JvQecIBG15YEwlG2rw7rKYJ+eFtRqDcb9GwT4iCV5UVbt/2c5yRO4y1dsn7m9vRrVtSC0gxZwxgFv11UvB2Ix8d72
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39850400004)(376002)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(8676002)(2616005)(1076003)(6666004)(6506007)(6512007)(52116002)(26005)(83380400001)(5660300002)(41300700001)(4326008)(2906002)(8936002)(478600001)(6486002)(8976002)(66946007)(66476007)(316002)(6916009)(66556008)(38350700002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?47517WfhkOPd1/QXheaMyuy8iw++ioWtuaC+Sgv8o1xrun+LhTn1+UxgIXmw?=
 =?us-ascii?Q?fjRPR/iV88IRAUGUAivZay5tBw6V0ZhalIBZF1C5c+f0iCJMdQpGlgVhvMgV?=
 =?us-ascii?Q?IvgW4RMb4n93Z24vnMDw5ZPRack/17NW4ZXPk9KOA6RhHl1o/JJ3XATKy6Df?=
 =?us-ascii?Q?pnTF1EIXeEd6NXnyQ556GmPgE2w0S8MsJFzVkpkGcKEu+ohHVp8f47e7pUtQ?=
 =?us-ascii?Q?wfAitJqLqvxuwwR0P/+zXJa97Jkf5lbtnIRIO5b3dsrNOii+m2kEmCrSO7xq?=
 =?us-ascii?Q?xsR8F8BrdZI15/F53Ys9tmiA32G+PKIgiP/SP2a5JURp3D+dKdz9jZ+Mm0HG?=
 =?us-ascii?Q?O2Q9c/CuB1BFZW3bomLpPRv6AF4wm3s1vM9DYNfjzF/vSWy3D63VGhoEAgek?=
 =?us-ascii?Q?b78/gKtPX2NYyCkmBEoSDbbuVxuv2DOyvXOGb3HSNszkSwqfO+AkoThk9W5W?=
 =?us-ascii?Q?yeEzzUiRAPCKvsocmao1sZUfYoLvfFS83fJgqmaRQsQIMUCTELAcFmaYc9qe?=
 =?us-ascii?Q?rDY56Ma8jqMD5/VFwfs7ksRZYxmY64kBTAMqo7CcnKqHCGzKJA4h9i/as0s0?=
 =?us-ascii?Q?uKRs5ja4463/mjdChz3EaWStIU+ZulahZAZIjvx9HjqlqqU+olLilk5LcUp2?=
 =?us-ascii?Q?AXVCzcwI+vLja12Wpv+ugCl7XflCdiVaxI5PhZJv27hT1uiX6hL67iDjPKJg?=
 =?us-ascii?Q?Dz6Y9f+wPPR0OCCIl+PIFTyfd90OmdDq+L8TzEOCJZqwv0OHqDRhXknglodB?=
 =?us-ascii?Q?0nMBdbEPjkLbFhOcGOJt1YZEaUquPfduzQSCLwflZikuepZRU1ABLF4VX4fo?=
 =?us-ascii?Q?iOpCRhCRHmTpc+x/o3wpbKim0/BqHNPRGHhwiQ96PEaDcfeWTTHjhJ3gCx24?=
 =?us-ascii?Q?nXP8/ibz8CCW4RwPYQjVBu+LHNHgi9EJ1vsawTFZbZLxPE7TZSNDQFDa+2gx?=
 =?us-ascii?Q?D2i+h9vztJoZii63Qo4AB1bF8jvVauzlfI4Nw63ZY0qR1uFeLwaefSXFrQnT?=
 =?us-ascii?Q?FzlhdDgKZTxHWPaPoad5g2Nd3jfgqznS7MDZsuYObfYIlBgKx9Jnz+SqcJbq?=
 =?us-ascii?Q?QOjWVqZQ9Tx3m9y8E4MdWTSIl7iJPpL8wvJiIonG22XADKbnLVSPqO6qPjUG?=
 =?us-ascii?Q?ha0eV6RBSbMGpGWzVrNA+ahu370vfm06ZbbdHxpDXcYzI6IXBsvXOIuYV8lR?=
 =?us-ascii?Q?t8ZFkt3aLsKv6ZT7bCcstt47xLkKGEMuERXJW4OHjmVClrzZnYNfSX9W7vTi?=
 =?us-ascii?Q?Ql9OjU+PcLdJ+9Yixo3k98xfACTkcg5mLSSFEpIs6LikQXiTxKTiUVj0lOsm?=
 =?us-ascii?Q?lP0AZ53WrTYkxeCj4pvq9/TpNTZlA4EldVbvHDeuMps0L1Rs2WhdVWw5xceg?=
 =?us-ascii?Q?ZJdIDcrgC2m6YSvSWMczZQ6NBOxpxRNFA9aGR4WlhNq8nn+PMrPnJly4jMc9?=
 =?us-ascii?Q?IDuJ/+qOtF4qIYGxxH/pnnpLbNQGyL1b/mLbw+FBhGF7d/YJ5XrzV2o7m+cD?=
 =?us-ascii?Q?P1Hy7QFDteqmzPsoGj7IMhvNuoa/Giomi29IJizGNg5xK1G9SuLBUA2MdyFq?=
 =?us-ascii?Q?y2ZqHclFSOd9aQtMR2ZmG4HppJs9gOTFHpoAd/efpkRogoY/46qTXc6/rJKC?=
 =?us-ascii?Q?Sw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea52308-7569-4826-8667-08dbcc03c8e0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:48:03.1724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0GE7TUgncHU6cCW4GVrLlRYjaAHaeez0lpT2mviqPKRSkqo904ngwlJNcQ6AzEdI2IHRGDbJNatV/GzrFupAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3153
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 3fb16866b51d ("driver core: fw_devlink: Make cycle
detection more robust"), consumer devices without their fwnode set
printed errors like the one below:

[    0.261887] uart-pl011 3f201000.serial: Failed to create device link (0x180) with soc:firmware:gpio

To fix this, set the fwnode so fw_devlink can find and handle it
properly.

Fixes: 3fb16866b51d ("driver core: fw_devlink: Make cycle detection more robust")
Signed-off-by: Emil Kronborg Andersen <emkan@prevas.dk>
---
 drivers/tty/serial/amba-pl011.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 3dc9b0fcab1c..29cef84b71c0 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2798,6 +2798,8 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	int portnr, ret;
 	u32 val;
 
+	device_set_node(&dev->dev, dev_fwnode(dev->dev.parent));
+
 	portnr = pl011_find_free_port();
 	if (portnr < 0)
 		return portnr;
-- 
2.41.0

