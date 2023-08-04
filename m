Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585D07703B9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjHDO6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjHDO6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:58:14 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E90CAC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 07:58:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnWBDTfMa/qUWZGU/OJqduk3SOP1Q8l0TB2Ch35IyGPciX91zuaKqoWyANqTkHDjiJQdFux4i5ixArybYpk440gwplDSah6IqDR0KMubC9l8yRVoD8h5TZQvQlT4I0KukbGxZyJkAZXBt7Wb6gxfGTHiQ3l+z0fcocLiksZFmUyLJiZGehfjquCPmkhT+l7Q4FFXqA1ONBsO+0Ek9SnyOlPFb9wjL6RwTKNYfV1pW8UDT4uMtNLQAUnnXIcvqwvkk9V5u9HFLlYPXKfQkpdGSXSKDbnEa5n1LgDd4FQm5GkSoo18oVZtCMot5mheSfkkidKySPxKxsygSyPVHyHp0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRboB5weNS4k81w1upiqLQ/i/+VGQwYUcAU2CESHDtg=;
 b=Zz8sODeSW05dzFidVRmAklCVUGCmTYAfo8X9UZPJDvbfSQIRVaxdGdsn3ysy3H+JBDaXHAV9JxoGqjZQ10sWGkhAviqECCSAT+/OdmUjMuri6U1Vn0J99mhdvx2Jncqn+U8EsDve4kmB+WiJ1HIcYKRtlTCb2cD0XD7VmYRKX+hwHaqV8QO4Ah/dAsD3CpW9IqR+8foPsF3UCSrDCbx3VxpwEExLJZgWk9rZx78gx/O1cWuKRyqYighbWCuq5UYWC0KAomEtVxb07FbUsOOXe7rei9EmFYJFNL1GpzH3SmFNKMPphylX+1rUnfed76IkEgZ+0CKC2dCPNPckXUFzDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRboB5weNS4k81w1upiqLQ/i/+VGQwYUcAU2CESHDtg=;
 b=Ouii6SJY4DGhLuSJVNwHINMV35OXeAuY9OHUdDKrbXYKcTBmknAMIHzlAzC9O6clPDX4y4woBXN6I+dZlHaXPQDN9hNIWgp1rxpC74n0owXZAXN10nDKuWL6skCTgUgWOpXq+Q/npekQOT2nheshwMCU2IJDSj09ANkXOy++TltaRkp9rTzzoCIv83bdjj+FQFr9yueUaqqCq/WkIeVLhZIAf60ut0emAACmQ5vXGaCMffbg2qwCMFJ1Mg4lLr38eUz7kOZf0ZOFblCN6R5vF94RnUFffBbmwHs5z98amdGvX/sWijmje2A/FBePE7nlevcz9gpXsdpszWF4ZbPCAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8849.namprd12.prod.outlook.com (2603:10b6:610:178::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 14:58:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 14:58:11 +0000
Date:   Fri, 4 Aug 2023 11:58:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     liulongfang <liulongfang@huawei.com>
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com,
        jonathan.cameron@huawei.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH v12 4/4] Documentation: add debugfs description for vfio
Message-ID: <ZM0SAfIHnMHndm8h@nvidia.com>
References: <20230728072104.64834-1-liulongfang@huawei.com>
 <20230728072104.64834-5-liulongfang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728072104.64834-5-liulongfang@huawei.com>
X-ClientProxiedBy: BL1P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8849:EE_
X-MS-Office365-Filtering-Correlation-Id: 4249bd5b-f1e9-4a29-f041-08db94fb3865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9xgJDGyn08gyFPyL8VC/0KBQadhXiewpM0gzBbRkR9C2ZA8M6PNfiV8fYUP+tvgtAU/Ra6QpsX3WotR2J5wFRXur0pvT4VWwIuAnlVQKqEOXoFJwV8cskMSaGgJkHPqeE8DXmQ2nFIOUPQDo7tLQBQq2XjdutWJgZjQN/g6Av4EM01pMrYk6SG2ks7r3kQ3r+UcOo7mFnM17EkzYMloU5nc8Nm5b3yjemb5pOnoClqfkaCZ3LlOQ+0r+hEme0jbIyZ2EhuugWIh08aPTYMJCxOSHu5K3oDOaDeeNSPWfzzSe62YNSSvaSn8gGD5ZKkTyoNN5g/JjzEqmW9F5bHplYvtTkKdMyOymbe1gnQUn4/wRdmUqd/l60MvA7KROQ1okR/jQulXfTJkUURs9Zu8F2ojQXryhvamFz5VIaSEeC07EJY0IkABm7eOvpl0arGDMRnIiuMF/6WBthgP4x0HcKwYeU0nD4LkaK6epod0PpXcjlPPdyEqOZRgeGJBSn8G7u3w2wQwf2q/DQicMqf8SbHaVI2i/2QNducuSoi8/0mN7+rGm95w/3CeuF0M7NjR3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199021)(1800799003)(186006)(36756003)(26005)(6486002)(6512007)(478600001)(6506007)(5660300002)(2906002)(83380400001)(4326008)(8936002)(316002)(8676002)(66946007)(66476007)(6916009)(66556008)(41300700001)(38100700002)(86362001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XUI6wW4xSkzfL+nN4h8iaekpUqsD1ByjMqnu5oXA9eSNqOPkT8goryNszDLt?=
 =?us-ascii?Q?RyTkSpP+OsGVV6DtWU+oM7z46bDdi3inMtZg6BudNNAjeqhGgWQvUCu4GQpn?=
 =?us-ascii?Q?BsnbCaqIHBbWbtwYsO93XWP2euqX8Hw+0PnLwOObvGO4UMABfiXrLJOIjPZa?=
 =?us-ascii?Q?gV4fT/Wttg8Lwn7xkPlq6fZCDKM4kVvexWPCudPjD7e9XX1vDEWEQPCoEa5v?=
 =?us-ascii?Q?VzKYuE58L34Uqv3k6y41G9dvympk0RlG/fSlKsUs7yyWGYJe2a32olussogV?=
 =?us-ascii?Q?teComVYVoG9Wh2HroHpz5/FtnQX6B+fkvSrRZmxQFYSIiDMeodJW0IryOzm6?=
 =?us-ascii?Q?FxO3E0Yzrs3tlrOScynSJ8AdBWNR8ubM93ijlvrrWlzEPvtduZ1rJFGJmE5y?=
 =?us-ascii?Q?sRPjgk8iJ2neu5JorYVOqRCUx2ThK/JwRd7obOJVoJO+UKcIbpLQVKszxQp7?=
 =?us-ascii?Q?XnU71NDt4t4Ce1Y8AiJY95sb685dm7S3jj3pLIYeWbRF6TY2QR2cAacN6W4i?=
 =?us-ascii?Q?HpfX4niGYF9MxrUi3IM9FbdVib6EQxUmLlgSrJkn+WpdSIvgUgurmd/je/Sv?=
 =?us-ascii?Q?fvjbM20+PfQ3LxQHB957ejasorEpckrtZcdZtViPI2evczDlD13NQgC9jJ4n?=
 =?us-ascii?Q?s9Ur8XYgHYGB1SNBThJHhzrlL8e2SXway3zxbbuVLGZ56Lw4Ij1ExxOCIaPJ?=
 =?us-ascii?Q?D5oYsBo3QUmbspfzoyQiiHOdmk4vMQn7mCV+SgOHUi1E9fGdEUnvabi0NpQY?=
 =?us-ascii?Q?zNl3hvo2+DwyX0mUussFABUcCYvBDhZbGPD+D1KBO7jrEPL+5mTJ3OXp0sEn?=
 =?us-ascii?Q?+5qCe1BC4Aa1eyRF53QwDr7RCAwcBKK6jiiGgbr8mxFDY7Rj8ebGioDhD5DP?=
 =?us-ascii?Q?1Pd4BEq6lWmARFaPT42m7ecLuKZvjVQJl8MFzCb7V0DiNyvIZL93+WoLhNk2?=
 =?us-ascii?Q?CDCGE2AYfHQAmUeGt9+Z+/GZGy6LNsiYDUY+UnikJoqjyxQ4Lzhc7L/L3CM3?=
 =?us-ascii?Q?xV19cBvtqLjsZEf5IlqfJ5nTZ6GZErIrU1VibM9DhMBK7xJzlxEyGrLpd4xm?=
 =?us-ascii?Q?Pysh7cJXBICiOvdlF0sGQ+wn8rcaZv959BAdpGyVgekG/IXKzHevhjAcJpE7?=
 =?us-ascii?Q?PPdPju6d3kHfspUaaXm9KeU2Lj1bDs3fJc1UdFpV8bs+GlUEQiVxci4lXQ61?=
 =?us-ascii?Q?TGTpFpYtKKLNkjRFCYjE3rouZ56TsrG22xJmjmP5twZhZH2UU/osvcSkMu3a?=
 =?us-ascii?Q?YVO8rzgDetK36G8IfnVeKzNyatV4U7BPYJAKmh3EE5glo2KZz+1NczFPhvVo?=
 =?us-ascii?Q?GuzZ9cleQHZF9OFkU9kpcSIVlqymyME/y5PwQzniL9fe0pbn2CryHfPXF7vy?=
 =?us-ascii?Q?ItnmD6UIWJQGgtB5yqu/zCtvVa9VcYQdVQtdXL+faB0L49N8C03ZySxBm3uw?=
 =?us-ascii?Q?jGtE9i/BbwP0i+NRbLFQHueUxm5nt/7lSq9Bo3AVjRj52HgzuE9FQlF4XvmB?=
 =?us-ascii?Q?sZH3+sVMwrRDHuLGLIkoC2ZUXk0RTSE3ruZmEqciIxXwJy1TMuLwmGEaFsRR?=
 =?us-ascii?Q?OibR6fHgFae9i0lGG8vWf0s5Qgk6sO1l6EI+Int9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4249bd5b-f1e9-4a29-f041-08db94fb3865
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 14:58:10.9639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7Z44d3JQe9elWn5wPgUhT6gYqMc9KswNeXSLc4Ij5AcQSPlTz0TMuXgB+pnzFWl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8849
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 03:21:04PM +0800, liulongfang wrote:
> From: Longfang Liu <liulongfang@huawei.com>
> 
> 1.Add two debugfs document description file to help users understand
> how to use the accelerator live migration driver's debugfs.
> 2.Update the file paths that need to be maintained in MAINTAINERS
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  .../ABI/testing/debugfs-hisi-migration        | 36 +++++++++++++++++++
>  Documentation/ABI/testing/debugfs-vfio        | 25 +++++++++++++
>  MAINTAINERS                                   |  2 ++
>  3 files changed, 63 insertions(+)
>  create mode 100644 Documentation/ABI/testing/debugfs-hisi-migration
>  create mode 100644 Documentation/ABI/testing/debugfs-vfio
> 
> diff --git a/Documentation/ABI/testing/debugfs-hisi-migration b/Documentation/ABI/testing/debugfs-hisi-migration
> new file mode 100644
> index 000000000000..791dd8a09575
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-hisi-migration
> @@ -0,0 +1,36 @@
> +What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/data
> +Date:		Aug 2023
> +KernelVersion:  6.6
> +Contact:	Longfang Liu <liulongfang@huawei.com>
> +Description:	Read the live migration data of the vfio device.
> +		These data include device status data, queue configuration
> +		data and some task configuration data.
> +		The output format of the data is defined by the live
> +		migration driver.
> +
> +What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/attr
> +Date:		Aug 2023
> +KernelVersion:  6.6
> +Contact:	Longfang Liu <liulongfang@huawei.com>
> +Description:	Read the live migration attributes of the vfio device.
> +		it include device status attributes and data length attributes
> +		The output format of the attributes is defined by the live
> +		migration driver.
> +
> +What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/io_test
> +Date:		Aug 2023
> +KernelVersion:  6.6
> +Contact:	Longfang Liu <liulongfang@huawei.com>
> +Description:	Trigger the HiSilicon accelerator device to perform
> +		the io test through the read operation. If successful,
> +		it returns the execution result of mailbox. If fails,
> +		it returns error log result.
> +
> +What:		/sys/kernel/debug/vfio/<device>/migration/hisi_acc/save
> +Date:		Aug 2023
> +KernelVersion:  6.6
> +Contact:	Longfang Liu <liulongfang@huawei.com>
> +Description:	Trigger the Hisilicon accelerator device to perform
> +		the state saving operation of live migration through the read
> +		operation, and output the operation log results.

I still very much do not like this use of debugfs.

If you want to test migration then make a test program and use the
normal api

Creating some parallel backdoor to work the same API is just
unneeded complexity.

Jason
