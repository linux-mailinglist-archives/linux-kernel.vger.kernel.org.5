Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCAD75FDF4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjGXRkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjGXRkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:40:52 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCF1E8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:40:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKk+bxYoNfaCmLCdOdCDmnHoxC20x+yMhngzgIuQ9G9V0zbHRnHFuISfzZJYG84Lad47KgL9HH0pJYIyzpn1/qroJxWeI+YIDzKuU1RCLgqcYseKafGlFHr2OYD78/JHadRuj9Pzl2inYLY5InCG4wEaN4nbdWEnJDrEXwbbMPuQN+pp/7qnJ/xxXbxzuo9LEHltmmrShMpgXqKwq5Wh/64Qczk/JF8AvgipE/vm7uFKNZ7k6tBjJ5WUOzGV9D/k8KsNzI4w6lebLWER3RAkr7+5/LIXgUFFYOsXYxonv2dZKpV5EIhUelpcXlEzFS69DEVAkDeX2tYluHa+Bt3Lcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9Cb4RiCwfVCTxsOPTzL2yV3NV6/wOX/zANfla03zzg=;
 b=gdXYum8OB1sLIjZoVtAiMAWt0NBWN6RDMP5XNM4oMfATMiGXIP6joUR6QT13prTa7mzj+gLt2fxHhlLXvsVIQztaOiyPJ8+VvB1rjfr5+rUYbZEx9bVWfFpBnZyFWQtUizKuow1q+pcsADZwzi19ToYrO3Up/BXH1AR91sY6H1N7aSfh1XHqanFkXHJtNG+vQox6m9Ck6ZykmIlUZXHkiOS8uWizSLvg22Fg0KUAS5NPp2Csg+KXh9AoPj9i+ycefMYcL//8CbbolDYVIoSVeyHOQthsgB8FdiubbR28UfnDAnIx1WvkY01jK/DLC54ae8Ip+xzDy80rgxssw5AEOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9Cb4RiCwfVCTxsOPTzL2yV3NV6/wOX/zANfla03zzg=;
 b=BTe9wxtAQVvNVk+Q2LUXbNvfwR/PE+ZfW5rSQKf9tx6fh+ZYzEAML3uR6ZFfI6ErMYuGyhbtTKcWZq5widN3WeLgr+uk/UY+vaKqjg2JAz0H4s59dr++N3VfDPX1WaoPgFqsaajiX4Flx1CyH7inIVSCPZlbx7xuhFO3gQ0T2WLqD5KExAHC1lvHqtx5Uu9qIRGmlo4lUEp0+s2kCqytzZbUtkHbvbbwYgSXvG40thjleaoGTCv8BAzTYXuko+qG+IMkffBPGezU3X3s9CCrrR4kBGxLkteRfD8yb8kfnsKYazJry1nUahyZ8H1aih7lFvFdFZpciRJwacAq1lChxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN6PR12MB8489.namprd12.prod.outlook.com (2603:10b6:208:474::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 17:40:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 17:40:47 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Zenghui Yu <yuzenghui@huawei.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] driver core: Call dma_cleanup() on the test_remove path
Date:   Mon, 24 Jul 2023 14:40:46 -0300
Message-ID: <0-v2-4deed94e283e+40948-really_probe_dma_cleanup_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:207:3c::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN6PR12MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: aa12372e-178a-4e2e-e05b-08db8c6d1d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W3DlMMnwy6BiT2dWGFoeF+BP4nHwiQXT2MX1Iz2rNqEgMB/9BJ32G+7VjonjgZ6rWK+hbWo11Mw2agNAoV1oiYexXbJ/A7SRwmscJS5WNqb5EmgvLGl+88oX8JzlL4rZkcvWnQx+xGSnsAo5SX05FawQJv3ycUB0xDCPcNH5784q8c6l6Jl3R9if26nNFIGKKpnx8WF14cJWmsqnJu7hagp8jbmf13MSFnkxA7hKl4mkzrgkSYGdoCVl63BlfgP31dMWGCMkbReVU3NMPslOmj0qWFmz+mt701YuBThqnBJAticHjoNS7JOCgDHyAwzNs/s8ORiJFbDxn83fyzbEnjEizag6dJx0GWXbTOAD+GnmCvyIJufHRUIXvxEd1FsWbL53kvDIs91tiCTBen0vQDUw70xaEkb93E9wHXq0MGmVuYplntMMiwuO95qxhTy+FR87T7wLU4qXVIRxVQ9AEKtLqBAuooBhSdK5sRUTugVUwKrSZbU3Bz08MTpq+mKaxt32Uh4ICW6/Wcjy3V8jzBYOD8+RVWagkk/nZ/T9Jm+/Ki+MOKFGqbLsAsH4bdEoH/Jf9ieWTNG5Oq8afd5AeVmc9whZ79uBk2iYEaNtFdg+mDU5jE9vJ4OVrmByCITUCcwJyv+NTC/T6pa9AxTDGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(6512007)(966005)(38100700002)(83380400001)(6506007)(2616005)(186003)(26005)(5660300002)(8936002)(8676002)(41300700001)(2906002)(36756003)(66556008)(6486002)(66476007)(4326008)(6916009)(66946007)(54906003)(316002)(478600001)(86362001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?byFftS/ANgTISoy1+lL7ZGqmd0gYLgUf0Uc+C9yD98upuHcIwoaPqr5lfDrs?=
 =?us-ascii?Q?V5XQtuqPS5hEqPuNI7vkX6yE4yWnia+7tKKOllYKlxLkJ6+J/chXVqwqFX68?=
 =?us-ascii?Q?Av6g7pD7fWz1esrNHJ/Cl+v78bR5zLEuGSFw0/t/gWUb2EaQEMxDAFdJ5xi6?=
 =?us-ascii?Q?6l3j4OjYfvCUzLg866W1xBQFsQTpQoMYy5u9jSR/1tMMBi9ImW53WVO8zCdP?=
 =?us-ascii?Q?uV3fbVdlPlkVT7UEG06j6IpeFfA035KdrY0vssbAu4lanQVocDFM8zrj2jLA?=
 =?us-ascii?Q?5NWKFaVrTd+j/bNkZOhccpThdE9zytCB/UpE9yAOHlIPtsL5vx6B3fqOph1Q?=
 =?us-ascii?Q?lUX2u2SkpbnN5lrq1xDQVVr/+kBUVFTuznbFzGxW4k8h36D4NSnAkdmHECdM?=
 =?us-ascii?Q?esCk8d74GI1uyFgH9+Mz4nbt4K/xNC1v5FdTX1qTCCCRv6dt9o9Sp8OqYF7f?=
 =?us-ascii?Q?L7HN8HVh9+qFqQks0rgAvSqj3OxXgUleHZPhHcZh+seXhyrnDgpvG61a+LtE?=
 =?us-ascii?Q?iO+X0xr62ya/EUw3QgkrRuwcZs/s+kZHhv7XGZauFFtblMH+Lp/Y34itO90h?=
 =?us-ascii?Q?htcL8ENrM9JYMqp4X9SPGDNmZITEvZuWYRAWReQrV2U93uMlhHIV6cISSKLR?=
 =?us-ascii?Q?wzHn7a0t+/nYx25DLk51L+iwpecE/w3xcI0ocDtMZAnSKA5LszMsBMv6G90k?=
 =?us-ascii?Q?dAFtO3hsxTg84ilnIsu4rGaHX6U7kGknAC7ioLKRdyCdNZTz1RkNTf+HUv5a?=
 =?us-ascii?Q?8xMffg4SoKnEoUKjB9YYJUml1cZI/gCiXKtcQJUj/AzLVvNPDZmCzVmt8jhO?=
 =?us-ascii?Q?qY/6dTM0xbM+TPvy1HvfQmqT6gYJY1vY0vAoO3lpKRLXTr67fiYp7bV91M3e?=
 =?us-ascii?Q?MnAfu87AfrsbYnRLhoSFSSpr02pg+KA9PiI4tPBR/D7pcoNYc5zsQ5ltDLXg?=
 =?us-ascii?Q?1CVMTpuor4yHZB+xdURoTfTDfMAWIpnkjl4/s+rnD0amzE8GcglUkbZYGes/?=
 =?us-ascii?Q?smFjiAshG5qKdeJJvw2Ur7jRpRRrLWn4W8PmGsdQ3HG82A1psVPaBc2Lc7m4?=
 =?us-ascii?Q?lxysYr9snTMbvsFSBlqR+3kaFba8/UMQ8cX9LS5X/3AeWwQttLhdALm1sveF?=
 =?us-ascii?Q?FA1KfWbVIC6agAMhsKxzPhuSPRhGQBTx+AQSxJU96W//VlvdviWhkLwDHAqT?=
 =?us-ascii?Q?Q5SwBiPnFvTDNUK0fvkFp08TYY7rHJV4tjYNnJX9cmOreQ8dxxyqppcqxP6Q?=
 =?us-ascii?Q?CfdnfplARvRHhEGM5p1+opLkXutpT9EZr12fpaUsPzeqw3ms/l6xj/Grx6p7?=
 =?us-ascii?Q?8R4WhRytOQMxs3VR9t5z3UwOCcInyrpWYxtvYZ6BEKaQAsIUnTu02guan/sQ?=
 =?us-ascii?Q?MD1xPa0uuKvusKWhIBefjMztVuLkL0kv/6Z5hdT7jS1t4+ckYEHRd0RQbPDw?=
 =?us-ascii?Q?z4qFpd8vg+5cNjuTdUu/Hbv9xiU3T/zQKuCNacWNN4gSaI12ueEuwUNRnKXt?=
 =?us-ascii?Q?9LDcrQ3kWPBbtXIcHsL9AqutKRHyUIojaC9wfKjxgCH8hpN8jJRULGkZSXu/?=
 =?us-ascii?Q?hatO822FzcJU4rIa3Cs6H5pRkF1mIrIUoMb1bpoE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa12372e-178a-4e2e-e05b-08db8c6d1d3b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 17:40:47.4101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbBhhS/sVQl3LiMKhaBSXA3DpsjCd8qYgI/OIAKcZiqi0EDgBP4K0sTRLfPxZq5N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8489
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When test_remove is enabled really_probe() does not properly pair
dma_configure() with dma_remove(), it will end up calling dma_configure()
twice. This corrupts the owner_cnt and renders the group unusable with
VFIO/etc.

Add the missing cleanup before going back to re_probe.

Fixes: 25f3bcfc54bc ("driver core: Add dma_cleanup callback in bus_type")
Reported-by: Zenghui Yu <yuzenghui@huawei.com>
Tested-by: Zenghui Yu <yuzenghui@huawei.com>
Closes: https://lore.kernel.org/all/6472f254-c3c4-8610-4a37-8d9dfdd54ce8@huawei.com/
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/base/dd.c | 2 ++
 1 file changed, 2 insertions(+)

v2:
 - Post to correct lists, add Tested-by

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 878aa7646b37e4..a528cec24264ab 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -693,6 +693,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 
 		device_remove(dev);
 		driver_sysfs_remove(dev);
+		if (dev->bus && dev->bus->dma_cleanup)
+			dev->bus->dma_cleanup(dev);
 		device_unbind_cleanup(dev);
 
 		goto re_probe;

base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.41.0

