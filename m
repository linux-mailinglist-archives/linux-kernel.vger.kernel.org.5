Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EA780425C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343501AbjLDXGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbjLDXFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:05:40 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C8AD3;
        Mon,  4 Dec 2023 15:05:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJ2Q2cBqxst3O41cS8VHc+gPNVv1nJgA2Hpzsl74A9SrURc0ZnvTbMPBhnUY5C+wXevObnF00GKXoLKuzXbi6Lx+lIOTLX4+M3DUGaktIqQCpnqTAFs7qyOjgMz4Woa/5BI9zdec16I7nocWSRW7joiue3E7d1CTGPinqM+M7uCNtkx+gbB4cZ8HKzhITV5DNW0Vt0NjuwrVvSXaf4j72MoMNqfflu+zOAvrRHYn15YPmLq2+IyjQf9Zs+dA72EFq6DuZo6GtLH7dJNuXbwRM/8ux6R9ctPvHncT+N0QEYstsdgSr1lujCXNHpoLSHw4gGEBRVpbC1QZD+cVPtENGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOjFja/wFWLVkNLxuN8mnM1TKnvydTz3+wSrTeWd6yY=;
 b=n7q4X0Fc8q0CmyJKY6ohIhafGbT+Re0EqgbIzwnpcq8M1XKhUExWJ4+8z/wQcPv1XBhRn7WClKL4LUmdEIl9uGh7iOPreClThj3v/X4QeC2052L+nJ7LN9JDtP+FeDE3ptZFzOfDRLvZPBeqh732NoIqetFzbdpeNcndXPKpcNlAxqZayeEKoMdQkEVlIepSUdnme8m5cDQe9vJtS9RbAwc987z3X4Qt5OdxF8VSyJqG3Exi13xfncl6qu49VOsPMZDg7WjuEp1G/09eXlx7MuTooU7bSmIOpzjo1sODEQ/abs/3/1MAqF368Tfc4hcidk2A1CZ/nJckK5AITxg05A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOjFja/wFWLVkNLxuN8mnM1TKnvydTz3+wSrTeWd6yY=;
 b=l+hjcVUYpK4w5ZLRMq2p2Yk7n7f39k8qb09PZu6bHyAcT5T5eUxLUm2QwOJWF+iEPvQmJ6qdBNZ2/1KjEpcwqsF/Mp5Rk8HyX/g5+fptwXk45nhxlni/Gy0qSz+51r56Lu87Hsol/zTFqNDfklexFfS84j9Jy1x+t9gMvNVhob0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 23:04:35 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 23:04:35 +0000
Message-ID: <7b66283e-5801-ee37-aa76-af0c04240a20@amd.com>
Date:   Mon, 4 Dec 2023 17:04:30 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   "Moger, Babu" <bmoger@amd.com>
Subject: Re: [PATCH v13 8/8] x86/resctrl: Update documentation with Sub-NUMA
 cluster changes
Reply-To: babu.moger@amd.com
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20231130003418.89964-1-tony.luck@intel.com>
 <20231204185357.120501-1-tony.luck@intel.com>
 <20231204185357.120501-9-tony.luck@intel.com>
Content-Language: en-US
In-Reply-To: <20231204185357.120501-9-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: 08139f6d-245e-4837-2156-08dbf51d6198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bp5p8/LtORMvjQmc1MAqMdh59+8v5X6wgty+hrPeuZI7GdNqnJb6xjF00Jne9qJi/NDLiBCBzCip+289NvQTsH0U6L4Ysso3mob4n35V+XfIpVqXoEbNNtqjGVOOsE1R5hmXunXGfhVkfHJkcLbDjlRXhPy/oNc2IH8OBDfciYKOO+8c1ZiF5WcDaIO0clA45o/Lc21p/iUcqIVeoNPCWAfAG9FXqHjMaTwZRxnEg6Zi4j9DEAJhaYE+Wtsbtfs2OTLOnP4bRIh8vQFyoK+wogQrQT4HlsMKEnNlXDQsFjc+mlrlUKIUdAob6kzV0WDrtbXtKZkE+2sD+GjDXlUQ2D6JjGEccY5dNkh8GwcI7ht+Z06ae82aFVCrMNmeZ6k8xEN47r8KBuJysD7DK0G4BQFbIInW06aHouHaWIMLEiBcOK3nCoz96g71PGlAye8Yv/417XQbbCTEgLNO/FyMpgCp1MpXBJxgDFq8Q9dAUKcaM+2b4071jsuYzX/HG1REt0m1d0OtPThbMEEOReZ5O5cS1wgsUvP1itQH91ljIV91mInl8Yno0MAC8oCmXhuhrl9ChLyEKmIH2+oLiXnAlfU9OhQNCcjtYttebfmdXtpLAxqrH2PX1cTg9Tjdbi0/Y8dv5TSlsRU9pdvq6iBSPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41300700001)(38100700002)(36756003)(31696002)(2906002)(83380400001)(5660300002)(7416002)(26005)(2616005)(31686004)(53546011)(6512007)(478600001)(6486002)(6666004)(6506007)(4326008)(8936002)(66556008)(66476007)(110136005)(8676002)(316002)(66946007)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnBZYWl0RWYrNXRVNTIrVklWY0NVSmpmSTEzYktlQzRvUlh3OU5rM2lBUFNp?=
 =?utf-8?B?RXJ0WE50YTdkeFNTSTU4ZGNxcExtbEtlTHk1WDMxZlFoWnhWWGFIbmEvWVJs?=
 =?utf-8?B?QmoyMWZFOEhVRmNXWnBVSEgwa3NXUVVTcmVTN0tRclZ5ZElLUWV0TjhEWStD?=
 =?utf-8?B?dVRYYjhzRURwd2FyZ1UzL3pra3ZDT25yaHliS2RtUm9uMUpuOU9sUDY0QWpV?=
 =?utf-8?B?K0wvcjBuMzFEQkE4cXcxc0Z6YW1sM2N3V0tLVy9rYXhYMW9UZnppd1lqeEp1?=
 =?utf-8?B?ZmxWSEx0R2Njdk9hNmw2TnpQamtPOWFSNXFTbkgyMXZ4Yk85MzIycTlZcHQ4?=
 =?utf-8?B?QVJWVWFFRFB1dXp1VWRsMkNwNjk3OFRLMFVvTHhjMzJUM2hxWWkvTEcwSkpS?=
 =?utf-8?B?bzdQUE80UnNqbXVYdm5EaUNrRGk3SHd0RzRuSEtkRHhrUmxwblVyTk9ndDVv?=
 =?utf-8?B?M3Nxd3Z3bC9LQjNVMElWb2hKL2tMaVBSSElmWkFFRmFPejhETGRIV1MrOHU4?=
 =?utf-8?B?OEM0NDhNeDhseStGSXBDYVQ0c0pId1pvZkNobmFjUHRSTFpxTjJjNE5Nc2pO?=
 =?utf-8?B?V3BNWHdKeEt3UXpuQThTTVEzTnJqbmI3VTIxK1FKZ2FIZlJaUVNJM2czSmVY?=
 =?utf-8?B?VDZBcXR4OXpsVW04Q2NIRWgvbkhOT1B2UGpWWTZwS2NZMUVuNmVDR1RZNFRn?=
 =?utf-8?B?ZkxUbjhGSGk4Szk3ZWhwQ0ZaS2E1SFJDcTFUN2UvU01iNjBCciszcG5Td3RU?=
 =?utf-8?B?RkxXeWJ6ZWJ1ZTNkeUp6MkRDY1plTTRaa2FoR3lOMWkvaGZkSnBRU29kOHRT?=
 =?utf-8?B?cDdWOXBZcWZmNTlRU25iTW5zRzJRUDBnSFczREtDb0Qvd2JLRG12a3RHUnBz?=
 =?utf-8?B?S3pIOHNTWG9wOTM4aEp4RExCSGZPUDYvNlVpL2dmbFlWelppSlg3ZWFpaXdI?=
 =?utf-8?B?NEl5NEp0ekplY3ZsYkRVZzBLMk5vZTlMNndPYzVkRlErY0hVSVhRQWhqMTI5?=
 =?utf-8?B?ejByZDM3dklML2hLdzFtNE9QWTZIWjJjUmwyT29Zcm0ybHhDQTdGczVXM2JU?=
 =?utf-8?B?Vkk3VzM1VnJNMDY1V2ZLVlM1REx6LytvbnR0U0ZYaDBJQzVMRU9JK3F3cHd6?=
 =?utf-8?B?NkVmNXBRQnE1aWVhOWJCaDF1ZkpmL3oyV1J1M25vc3dZZFM3WXJhV3J2YjBq?=
 =?utf-8?B?c25EWmpSNXNjRUR3OGcvYkU1ZEhwSWRlZUtselpXdVhTajBxbkdHVjg5aHkz?=
 =?utf-8?B?d09zSXFnVlVqM2E3SVB0dVdTNGplTXpLMk1DcUh6VTJ5TitMZElZSzZEMHNX?=
 =?utf-8?B?YjRpdjZpbkVybTRuWndLcFRPMDd2Z3lqR1k1ZHBjRXFvbHJsYm83VTV1UkdE?=
 =?utf-8?B?ajRteHFtdDI3SXA0S2VkWjZBVksrazdCUlZ5a1k3MjdFYjBQNXROd0hPQ2dl?=
 =?utf-8?B?TnZhYTJtVkQrOWxnVkFZaHl0RTNFTGZGZ29PT0ZyMkZSZ2daZy9EV3VGcFdw?=
 =?utf-8?B?YXNJRHlHMDgvaWZINll2d2E3dldhQzJEV2o3SjI4QnFxazB6cytaa25ta09B?=
 =?utf-8?B?MlRmNWtMMkhHM3RkQW81dnU2YlI2Mk1YZ1ozcjVkOWhmV003RnhvSElYQ0Er?=
 =?utf-8?B?dURwWDhwKzl5Sm5VUHZLNlpoYTNqOS94L2lIRWhjUGlreHA0cTZ5RTgwRnVY?=
 =?utf-8?B?RjB1NmpNL0R5dkI1MU1WUStOc2VZY3NPSERVNHZlSTd6cTBpaUMrdjNQY25K?=
 =?utf-8?B?Unc1bHdyb1pYa1lqcm9PbVFZaFZtNnVIVmtOVGZ4NlVQWlc4UkJFNnRkT0tj?=
 =?utf-8?B?cXpCQkhQL2xOZTNCZnNZVDl2RHU2WHZwQjdOM011K2pxWThUUjVIMks3SEpP?=
 =?utf-8?B?b1MwUHVNU2NrcFZTRHdnV3JHbDByeCtyLzhPMUkySFVEak1JS252dThXS0I1?=
 =?utf-8?B?MXBYR3k3VlBub0JHaGhWdTVhYTFWMzA0MmRxbjJIOUN4clRDcm9kSlA4aUpY?=
 =?utf-8?B?WlNtVWJ2eXBSeXc5aDBCdDVQQUlxOWcyNE4ydGhNMDFMY3ZMWmFkRXUrM040?=
 =?utf-8?B?RzJZRXhiaElPVEExV1FzTUJXZTBnclBkR3F2THZUMHZrTzR2RGlxb2t3bEVw?=
 =?utf-8?Q?MFyNCh0GbikEEqcEBj5/P4Eh3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08139f6d-245e-4837-2156-08dbf51d6198
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 23:04:34.4384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfkneCru5ur5BacAod7f/Y7CMjB6IG2EM1WjE7IEyMzctft37Nu3e0pff6Yxmr24
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/4/2023 12:53 PM, Tony Luck wrote:
> With Sub-NUMA Cluster mode enabled the scope of monitoring resources is
> per-NODE instead of per-L3 cache. Suffixes of directories with "L3" in
> their name refer to Sub-NUMA nodes instead of L3 cache ids.
>
> Users should be aware that SNC mode also affects the amount of L3 cache
> available for allocation within each SNC node.
>
> Signed-off-by: Tony Luck<tony.luck@intel.com>
> Tested-by: Shaopeng Tan<tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Peter Newman<peternewman@google.com>
> Reviewed-by: Reinette Chatre<reinette.chatre@intel.com>
> Reviewed-by: Shaopeng Tan<tan.shaopeng@jp.fujitsu.com>

Reviewed-by: Babu Moger <babu.moger@gmail.com>


> ---
>   Documentation/arch/x86/resctrl.rst | 25 +++++++++++++++++++++----
>   1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index a6279df64a9d..15f1cff6ee76 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -366,10 +366,10 @@ When control is enabled all CTRL_MON groups will also contain:
>   When monitoring is enabled all MON groups will also contain:
>   
>   "mon_data":
> -	This contains a set of files organized by L3 domain and by
> -	RDT event. E.g. on a system with two L3 domains there will
> -	be subdirectories "mon_L3_00" and "mon_L3_01".	Each of these
> -	directories have one file per event (e.g. "llc_occupancy",
> +	This contains a set of files organized by L3 domain or by NUMA
> +	node (depending on whether Sub-NUMA Cluster (SNC) mode is disabled
> +	or enabled respectively) and by RDT event.  Each of these
> +	directories has one file per event (e.g. "llc_occupancy",
>   	"mbm_total_bytes", and "mbm_local_bytes"). In a MON group these
>   	files provide a read out of the current value of the event for
>   	all tasks in the group. In CTRL_MON groups these files provide
> @@ -478,6 +478,23 @@ if non-contiguous 1s value is supported. On a system with a 20-bit mask
>   each bit represents 5% of the capacity of the cache. You could partition
>   the cache into four equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.
>   
> +Notes on Sub-NUMA Cluster mode
> +==============================
> +When SNC mode is enabled, Linux may load balance tasks between Sub-NUMA
> +nodes much more readily than between regular NUMA nodes since the CPUs
> +on Sub-NUMA nodes share the same L3 cache and the system may report
> +the NUMA distance between Sub-NUMA nodes with a lower value than used
> +for regular NUMA nodes.  Users who do not bind tasks to the CPUs of a
> +specific Sub-NUMA node must read the "llc_occupancy", "mbm_total_bytes",
> +and "mbm_local_bytes" for all Sub-NUMA nodes where the tasks may execute
> +to get the full view of traffic for which the tasks were the source.
> +
> +The cache allocation feature still provides the same number of
> +bits in a mask to control allocation into the L3 cache, but each
> +of those ways has its capacity reduced because the cache is divided
> +between the SNC nodes. The values reported in the resctrl
> +"size" files are adjusted accordingly.
> +
>   Memory bandwidth Allocation and monitoring
>   ==========================================
>   
