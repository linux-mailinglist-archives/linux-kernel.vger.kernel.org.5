Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983FC7CFF2A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345170AbjJSQLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjJSQLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:11:04 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0B6B8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:11:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azDwh5SaWzwWvyb2F7c3G0r7uetc8szyWUELGMsJCM3hNj4Ui2ttcpjZIjghRmRrmznVCckiLY+O+PMAZ/JrQxm6ImaS8TdkKCC4529OVgE6QQrLBKImZLkrqjwDKx/3Sd6dtuCnl6D4/H9/gjEnLLDkojDvUDLep+PVZzUyRqWhCTH2PPBbmrfL2Q2FkiIR3KMb36wjpcEL735CSu5RaoH/YDKNG8JSeOaEHPeMZ+VxKZvOg2m6NnX3sW/jEVOCVbOcLpy3bbV446Q/rYqhw8OR6JSvGEuy4lz61a4X8kiDUvIxddOytGtTZlvLCiCpwsaqUbV507CP8MV5DhCcdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rXkDMRiuwFgvrlJrsGctEQ8MmOOaNP/MeDbelII9V8=;
 b=EZgvqi1L8DLb1PJ3uiSFTeNyZ9y+HLQGlKxfSIJzbTuhcJztmtY4LxYsB85KTuQE+sPX2KVjuSLBvQjMx7WJxIeG+7HrWy9Nf/e2yJpVjcFtkj7zLzgQwgBvrNlX7Pk5XeWubsaJ1q15GWzImdMlaVGdG0a57PcbbqbSLImlfRSEgj4NbDX5yXPFfiiy68bzyrkAMj9C4cfiS07RB9eZwIWe6F9ui3kPCGIWyxZitJoRV7e/V1UfcIh00I4W1tYRKQqK4f7JTnWBTBhu4nK9a273OscN70cshIdCgWgPe/OjPd2eOJUbPFHgSsYVV3S7nNl0UZen4hrjwecNyL+q0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rXkDMRiuwFgvrlJrsGctEQ8MmOOaNP/MeDbelII9V8=;
 b=n46euJ8Hhq7JoEN5uKQzXWM95uw7d7B+BjvKb4movE5QO4qfTOvfdSwRHSD6dJ1AdgTdSZWUExn+x1UJUeomSFIfJM0PmcMJS7APF3T7yRJE9n9DecBAdp29CYIUBqrjrmUbHsFcAmsTt1HgIIYz5eUxOskfdQZen7mLZ7JcpUC1jGm80HiCCESXGv6m6rZOx32WfZJo0t+EtNEiEjij4tEgs4m6DysKSfNgoBcDiChQCXwiV9Bcq4gAfCFp9fslRCSTu+bvIMO7aRR7k4bhuk6EZ9B2eVLQ22muWwSNLMLi+YlkeFpsBdrxygUZJn1Oqvv2xgCGNq5n2HN9lw0CKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9134.namprd12.prod.outlook.com (2603:10b6:408:180::21)
 by PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 16:10:59 +0000
Received: from LV8PR12MB9134.namprd12.prod.outlook.com
 ([fe80::b15c:1b79:292f:31db]) by LV8PR12MB9134.namprd12.prod.outlook.com
 ([fe80::b15c:1b79:292f:31db%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 16:10:58 +0000
Date:   Thu, 19 Oct 2023 09:10:56 -0700
From:   Saeed Mahameed <saeedm@nvidia.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: mlx5 ConnectX diagnostic misc driver
Message-ID: <ZTFVEL3bOEHFVe+7@x130>
References: <20231019082451.785aa123@kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231019082451.785aa123@kernel.org>
X-ClientProxiedBy: BYAPR08CA0047.namprd08.prod.outlook.com
 (2603:10b6:a03:117::24) To LV8PR12MB9134.namprd12.prod.outlook.com
 (2603:10b6:408:180::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9134:EE_|PH7PR12MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: 56dd4760-618c-4aab-aaa8-08dbd0bdfb50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pPcsGcoHUKxJz2LESLTLOr9b4sfnnBbJhzdkOX/ZX4rR/N7/soRmsGi+W4bz7b/bhGns+N0Io/lX0dEgrpPE7uNhOEQFTr0yMO0nrXTCYw9QYvHxf1qSo4/U7t01fPUM00/R1Fd8bpHA9hPi0jX0juPsxyCFfXMnDPn6LNdOj4zJHno8D2w2FRBp8mMgYemQuRjc/7fKQlaDd68g4i8R/4pL+sDrqfoxwMB+VE/AGxArPjkYV/k5noZjp9y4O8EXhA1nmsUXReZGhApdEdsrEEw7EZ8UE5ejF95uH6eFgYs/by083ttHftrttygfmjnGkyRiLK7PyoHoOCfAzq7+45FMjQ4jNhjm6eGQu3ksaZkDRVngVSnLJ9g0fXjqPytGYJwihl+hT4brwdf/MdkvQsh2ljKuEi9ZZj0OcODN46UxZ+lNH5bRwcg1gyN1dnRkzGgDfVCunN5becs2M1EaEBRAEfSB6m+TIo53oA651GoElqr/D7kZ7gJDoMGsymuMXGQtxBn02F+OtnvkuZiItFO6kAAOn0Pgg1MJ1DMt4GRBPXcgZBCG+kk/WUsLdncIPaixbziFDy8TjdcnMsMVtHgEEWramnZEmJNf+SYoEnL/9oiejQtGSUUgIG3JZGtuL1vkFx6ICE1QV+5SVA/C9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9134.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(346002)(366004)(39860400002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(8936002)(26005)(33716001)(316002)(8676002)(5660300002)(966005)(478600001)(6486002)(66556008)(66476007)(54906003)(6916009)(6506007)(55236004)(66946007)(6512007)(83380400001)(9686003)(2906002)(86362001)(4326008)(41300700001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nbCplN0QCk6xuIGEwwVkx1PAOpFav+G8w5Z0860Hef2SHEjgFNwofttOfAVU?=
 =?us-ascii?Q?H8sGFNOGgichNYMeqme5LOG8DPRswJhArf3/1Lds/AkSYcu/Mzm2yBdtUNIN?=
 =?us-ascii?Q?nrLWCQ7+AlenHQjxL2Zq0t5zaFxA24CnE58a5k+cuZRQmsx2P8H1w6OdMP2i?=
 =?us-ascii?Q?Brz1H950yns6iYUGkmrhr3LmjlU8IADMSYEy6F4VrxNaYXQBnYO2MVvSbsbH?=
 =?us-ascii?Q?hlaZpImFvunI/Abqw8SPehIhFcGyaoaz3Wz45HWDuFihPndfTcA9n5xr5rD+?=
 =?us-ascii?Q?bKsQ9ixQG/9CJJrTsq+g24ZE9x+GIg7Yl6xm1BqwuxFx3I4kVLQdF6No8r4B?=
 =?us-ascii?Q?eZFqCFdz1HjYbKI4Mu7fQJy6qn2ev1w9oxpKbm30Gm69PVcBT1DzEdHftwiD?=
 =?us-ascii?Q?2jaOxGfxbLJ9PHejolvsiizQb2rVd352O6cB/GDSdTbdZYAXulLIRgnbquvQ?=
 =?us-ascii?Q?fz5vOVixVYqzca4gBl+RcjN19yyUPjjwUf2vYOaZwoYDuYpkQPf7QsLIZFXx?=
 =?us-ascii?Q?1iFCDg1pFhPkygplRijoAWdgVrO+gP/5fn+ZFo1ZM051RGiT9Z20anOjdx3z?=
 =?us-ascii?Q?/FtTBWQYH96D5PzOMU3T3J0RNs12uF7DoA9lnIaYhZkb4XNe68H0MiOkSAPw?=
 =?us-ascii?Q?FuLD5fi/2Ecbv2580Y6UyAF+EdfKZaHArDKuWRT0dUfCg4isrZs5EwtX5pYx?=
 =?us-ascii?Q?uTuPUOvTFxdhQyXXHRConcVbUamlO6q+3be/WcctkBr4d3bKWYs4gpaGqcti?=
 =?us-ascii?Q?ynHWsxI7n7YCkM9ZaoQ9BrRbDmggTNlFN88FH9fK10To2EJbgLidXADoghJd?=
 =?us-ascii?Q?soY4oswW0/Ef6ZIZvlayHtkTo9MrOCzI61y11A1YI+/dmmRecXyLs0S6QCLl?=
 =?us-ascii?Q?ckyOdDQp0aSNXf1rsqwqvnJE92T0rqi/Gem8qBSfhSfeLrXEaqb85pbGHLMM?=
 =?us-ascii?Q?Pso/a30AS2PLlSTPN5hn/aWK6JFuv/su59r4schsw3eST3GdcdaNbQb4zGPQ?=
 =?us-ascii?Q?uYghvDMsQ0qOzdVz2HTqLwG+970TpJMKSFUG58zUQnVgzclhyj724TBxhhZF?=
 =?us-ascii?Q?ZRjojjXmUFtMTZ1RL10whqc+9yq61niqpO/RBj2ZtKcqwUPva8JXU6+rk2PW?=
 =?us-ascii?Q?Sn9CWWa+Wf4Lvrw08Hcv+N0E2rqvAioXU4/ljkMOBOwAjh2KoSu5aq9bDcsg?=
 =?us-ascii?Q?DdrjvzN7Nxcv1nVHe6zlbP4vitb8Ml6PzYmpo1Ye5w/DRNxNLVQiehfhPBTn?=
 =?us-ascii?Q?anZOWOjicIPSPeGoYhaHoxMfTII0xTOZPnkUDXAgu60MLQoW7BQtfdYgZAue?=
 =?us-ascii?Q?YZSg5KZWDfyfA+8vTqZB73LrdZyDh4TQzHI9bH+k3XpRv9gZ3jfwIB+befmM?=
 =?us-ascii?Q?fvzatXIEZZBWB1WGyj67sm8QoffPI0xvy2rIwVZ1eCk+8LBmcSJp6f8xi+NT?=
 =?us-ascii?Q?CibVVxcD6hBECLngP8ZoIFjBNkUGfT6AP+7LKGYg3BJQGuNzJa5FjKsfOHyb?=
 =?us-ascii?Q?YmWaXNLNYfWRdiBz85PpzPwPGakPV/6qUwwv5tb6BN0l4LwgY6XSOmK6ZAxn?=
 =?us-ascii?Q?DQyXt4oeYK5UGabrQ4+xHnsgMtkHCGUn0ix3wahz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56dd4760-618c-4aab-aaa8-08dbd0bdfb50
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9134.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 16:10:58.7660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKwu61eekgWCbyxyJJEvjwyPwqE5bVyREBf9eJaxpV0k9ETQ49Flyx+J+vfhL4TGsAQLA6ZXr9Xcf+jp3mOrZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9066
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Oct 08:24, Jakub Kicinski wrote:
>> The ConnectX HW family supported by the mlx5 drivers uses an architecture
>> where a FW component executes "mailbox RPCs" issued by the driver to make
>> changes to the device. This results in a complex debugging environment
>> where the FW component has information and complex low level state that
>> needs to be accessed to userspace for debugging purposes.
>
>You're being very dishonest towards Greg by not telling him that this
>is a networking device, and the networking maintainers explicitly nacked

This is not a netwroking only device, as described in the tools
documentation quoting:

"ConnectX devices are complex and provide a vast set of features
and components (SmartNiCs SoCs, Multi-protocol Network Adapters with
Ethernent, Infiniband, Storage, DPU, and many acceleration and offload
capabilities).

This project will provide unified tool set to access, debug, diagnose and
monitor those devices using the ConnectX architecture and onboard
processors and firmware."

mlx5 has multiple drivers in multiple subsystems, it's not only networking or
netdev, a huge part of mlx5 is the mlx5 RDMA driver another is mlx5 vdpa
driver, and the list goes on, including virtio/vfio.
ConnectX supports multiple types of PF/VFs/SFs and at least a 
dozen of ULPs and aux devices.

A unified diag driver that provideslow level understanding of the ConnectX
architecture is the best way to go here, so it can serve everyone using a
ConnectX device, regardless of the subsystem it is being used for..


>this backdoor. Nacked it, because you can't answer basic questions like
>"what are the use cases" with more than "custom config and debug".
>

I think the tools project provides a clear picture on what the uses cases
are, it is already part of this cover-letter:
Please see the documentation, and let me know if you have other questions:
https://github.com/saeedtx/mlx5ctl

>Whether Greg wants to take this into the "misc" pile is entirely up
>to him, but you gotta give him more context.
