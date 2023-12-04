Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725318040EF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbjLDVUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjLDVUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:20:19 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33E9AA;
        Mon,  4 Dec 2023 13:20:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8M96AwWxQBAw89pOqsiw/IG0pblAkEZxikMWvWP7gs6/J5hBmnI/I4/4x4Fpy9t9ql97IXQck9sZjci0lhp4xX3BnubFudgcYrmRlm6bVpfL15UvrgzYEeoS75O5jntf+K55ruVh10uEecdZPSRGiHfMm1iY7aQX5Syfu4Uk+jBRV5ecCbSi9bOtLiavRAXRK/U7xAcltp/7VLjmwmJuE6FsSwSC6yFrAxNlysPzEqY177iJfj4e4cb9WRhcv5afusyWjIWEuYFhYc3wl3OtAc6PtUAtsW6cBwXzE4+PaQuSarij/IXhitZGH8RUKwfZtcDY3YXuh1RMYiNKORZvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBfA1Mu22uJrbeLqYj9mLw4htZ3hI+7unYHUWhNXvK8=;
 b=Kf6VqdFQcGI4h5P9ZVhuuXrfgQ5HihLJDEDR1+mb0zqkMxg/Nadeq8z6DLPIhIgKRi3cXAUuaKWdfawt7bvtQuPvYuFCZkLKF3QcZZTVhh/cJ6DDQGpHFgU0l73XGbjrLbDjBX0eufz9gJ9MMivEHJ8KDCooItvqd8AihQVqm+Z76PH/6G1ENdczVT8NIeJZK1+K693DOhscqWK5ebHUQKg3RxxsCV14WJ/VMLZBfJ7m1TpNtTjSw66qxGbwyBmBrmP3b5Bg1mZBJ6SSt7EkEXpWWdC1fQgJfv2d+embGObtf/tDc8AVnyfGRCUQUqMYUZvp6GJiqJ9OyVQ7WUtXOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBfA1Mu22uJrbeLqYj9mLw4htZ3hI+7unYHUWhNXvK8=;
 b=Ao4Yc+olis4doO6Fk+zRZKq9AOvgDSoldNUDi4UV1AyPgAO3Ei8FySqa+nmaRqo99hgIJxC0JpLDl6EsWr1rj1KRNtzCmr+BPgI+kCSmsp4UCxqzognE42r+j2XGY4+wEyRiDezyE+rqZiFPEJGO/3MsjOM9EJvTAS90Th48CAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM6PR12MB4218.namprd12.prod.outlook.com (2603:10b6:5:21b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 21:20:21 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 21:20:21 +0000
Message-ID: <8c762203-db0f-d5f4-fc81-9cc548ee92af@amd.com>
Date:   Mon, 4 Dec 2023 15:20:18 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v13 0/8] Add support for Sub-NUMA cluster (SNC) systems
Content-Language: en-US
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
        patches@lists.linux.dev
References: <20231130003418.89964-1-tony.luck@intel.com>
 <20231204185357.120501-1-tony.luck@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <20231204185357.120501-1-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0180.namprd03.prod.outlook.com
 (2603:10b6:a03:338::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM6PR12MB4218:EE_
X-MS-Office365-Filtering-Correlation-Id: 88e991c4-5ef8-47b9-149f-08dbf50ed2aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mHKAqhRCElIdsky1rv/i6WnjHtlOh3X1lYQ5DVtjpPK34BBx/7X9Ya7k2ovJ86l579agV6LbMDT81sw9UpOMFSEqMd4E0h916KuOn8jrDgA0ux7wtv26Jv6blqbLXDdAOB93zb90lA63CRHxxkRzJg4L3pqaqrPsru9Zv2K9NUfLyNIO96IEnfwvZuNzlHJz/Yi1uNjT7HchsCHi6omZ8HhyugkYRx8Fe+iQCV3LGVvF4OEZtlqhyEwatS7jPSbmeV8cqKeigVk+bqniNb5grSA7HFGPD9nqyYQPeoNthX/9ivsODJ5HZ1vo8Nt43+BzURKE6vB1VMI7zZs189mSIsGsJVIHpdqpVVQI2bFjdry91lSeH+TXxQ865AG4eeBkohclJnmJ1yKVpA1gGPaSV1+ZMlnjomIrOv8SrivHxn4qjeMpNQ03W6UURPvM4I4mDhLZ25Ez71MlSUgQsI0h4s3Ks8K0GTrj8S4pLEqz849Xkfs1/lrQSGn8HQD4wxi05/iiiz7ZLZX1R0DQiUAsAVUlPFoKK/InUJsgktDyDBg23f8YXJuc631sil4l+F83vsz9iSYU9xdM+JTUwNkytUswlyff0dCuneSrG0w53gzXPyUbyorsTtPABG5kmel2ZBQCsce8STOam1HReMr918qdGKDP4mRj4Eg0MccoF3xGPX54E/5zPFPguJHYprjaLPkfAeUWZgVVhwd/XMnMzn4HJeLwQE6rXKmsDm709qQVFCNe0Uflrvgc5jjNwlba
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(376002)(366004)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(186009)(1800799012)(31696002)(5660300002)(7416002)(4326008)(8676002)(8936002)(2906002)(41300700001)(6512007)(36756003)(2616005)(6506007)(53546011)(83380400001)(6486002)(478600001)(26005)(6666004)(38100700002)(31686004)(110136005)(316002)(54906003)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG5hZTRobHY1UTRqbUE5cGJlWlJ5cmR5SHVYRmtETTRnNWdWZlUveEFjdFlD?=
 =?utf-8?B?Q0pqbWpVMnFkRjdlSTRodHhDQlRDLys0OWNCOHhRMjBSOWZ6c0lZVmkxZ0py?=
 =?utf-8?B?WUFGSncxaUI2WVF3ZHJJV1hnS3huelJBNzFyODlmRVI1ekVaZUdscVN4VWR1?=
 =?utf-8?B?RGxNVS92M0VqcUdCQm9yMnNncmwxenVkM0R5aVMvdEJEL0hVVmc3QWIydGF5?=
 =?utf-8?B?bmNPKzA4Z3l5Z2VVa2c0Nm5YNmpvVlRBZ2hGcDd1ZllaejdFRHNZYWdSWmcw?=
 =?utf-8?B?QWsyZW8zV2RqeHcxL1hMdS81T3VlNDBIOGhUZkU3cnphUThSOTh1ZCtGeGxm?=
 =?utf-8?B?bGZHR3ZjczFRbk1LdGExY2pGa0F4azRkOW9hdndjdlA3bHdxVzZ3QmdQZHBw?=
 =?utf-8?B?RkdwRTFXTVd4YlFmVWpHMlhueitlZ2hjeHNNNGhNWE52d0R1ekVIYmJjWE11?=
 =?utf-8?B?Z2dXZUxMRWs2Mml6WXNjYjBpaXpSTTJmYWdxOW1uNUtqVythU1VqUlN4YlVP?=
 =?utf-8?B?MlZndUxnZkkxTzRjM2ZzMmFvY1RnTlR5OStPZVYyWE1uT1NRbzlFaEkzQXRW?=
 =?utf-8?B?cXluZEp6M0hjTnhHM3BYdm1seGs2d2dLNlNkcktRZnB3Vjd3VmtVY0o2ZTEx?=
 =?utf-8?B?cGE5cmVjcDJpVThLak5VakNiUkp6K2VXdDNtZjk2RjYxY3VBNlR4OEdBRy9y?=
 =?utf-8?B?QnA0QWZNUVYwL1V2amgyVlhXaTZMa1lHOU8vZW9lQzY2TTcrUDlseEgvNHBo?=
 =?utf-8?B?dTM4SGdsbjN0bHhMM0RJRndJL1FMTHRDU0xObXNTVGRMY1pqSkdqS2JqUXVZ?=
 =?utf-8?B?Mm9pcVJDYzRNbU5XWW1UaTg3b2pVWGZlc01sN0ZwYUFzaUlmbWFnRUh5UFJy?=
 =?utf-8?B?RnhrTmZHMlJKZ2VndTRXSjdLaC85S3lPRjFnOHhOTFAzSVNvQUJIajdaSC9z?=
 =?utf-8?B?TWVONktrWlpNUFArQkMwYU1ZN1NBZmdtdzYrWXkzdnA3RnpxMm5ROTNVTVlY?=
 =?utf-8?B?MUdLS3Z5eXRaVFpUNjc3NU1tdFhIV0JPbHlqaTBqSkxjUmdSV2diT054TWVx?=
 =?utf-8?B?eDRVVnI4L0JuSkdwWVMrekMzSkxjRGxFWHdkV2pXR3hDYk4wMGc4ZUF5R2E4?=
 =?utf-8?B?YlFTeHErWnJFMGZzN2hRLy9IbFhXbitSZm9wMGk4eHdmUDRrSHBlU1QvSnlI?=
 =?utf-8?B?TEVOV0V4LzdQRno4M0VyS0Q1REZ4WTY2aW5LRXlOSjMvUEJydHcxNjk2Q3l4?=
 =?utf-8?B?SWx4WERNRW85dVlHT2NBZ3Z4U2cxcGxDbzFQYzV4VDZyZnVHMzEvK1Q3Z1N3?=
 =?utf-8?B?ajduZ2FyYmhjbW9TdDJuQ01wZy9qU2NVUC9RbzJ6RWd6ZW5yMG14QVpaM3Qv?=
 =?utf-8?B?dnZBYWtnb29XN1dCT21QMzBZOElYNHlwWXBrS1UxeXJhdTZzb3l4WlE1dm5B?=
 =?utf-8?B?aFJPYXBKcHdnUDQrOUZRZCtDMWVNV0lrRlhDTE02RFFvRHJvQ2R5bkR4Nk43?=
 =?utf-8?B?eUtJV1VIckNvUVZKZ1hEem9XRmU4ZFhHY0paRVQxZHJkekFKRE1MZ24vUU9L?=
 =?utf-8?B?RmtzVnJJL1VkVFo2NllYZkVlQVI5Y09mdUpiNmt6cFJVZXlGNFlFKzJvZDNk?=
 =?utf-8?B?TlVONVBtRHpiRDEwYmNWYkszeENhVnpOaHR0dnNnS0hvUGtsd0V4bzRsRm1G?=
 =?utf-8?B?Y3Z4d0ZRa1hpSG9lanNIb1pBTHE5bWFJT1VZZS9halJQWHFkWUJYY2xrZTBQ?=
 =?utf-8?B?STBERFB3ejI0K0lxdGNTSzFwczdTWDBwaEZjdUFQd3FjcG5qKzNEaWNlK2dW?=
 =?utf-8?B?eHZaRi9XQUcyYW5iUURUeFlEQ0FPT0VDc2RLaUpXZTJ6ZzZyRTBsbHBITXdx?=
 =?utf-8?B?VHhNV0hGd2NIUDJLNzVvRVRyMEN0ZWJRRW5iMHFiU1BpejNhc3FKNG9qOUtD?=
 =?utf-8?B?SHFJZXpwc3A4UE5KNVJCQlAyTXh0NERUMjQ1OERFZ093bWNMcDZqbitHeStP?=
 =?utf-8?B?T2EveUZkSElidUZBTEVGcEoyQmUwUWh2MjRjVWxQSlZ5K2ZSdWZUUkw5VW50?=
 =?utf-8?B?K3ZJZHdzLzZpS2pXRmNyRS9ZdE4xV3RHQTE4NzcwYTRFd3J1QUtHOC95Y3hD?=
 =?utf-8?Q?leL6Nox2ird2h4m1mz2v3HgQO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e991c4-5ef8-47b9-149f-08dbf50ed2aa
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 21:20:21.7077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VkRxNxOun652P/4tuF/g6f12j/tWVP7zAKrJEQ3BVCT2zZ+/et2g802yqXjey97
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4218
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

Tested the series on AMD system. Just ran few basic tests. Everything 
looking good.

Thanks

Babu

On 12/4/2023 12:53 PM, Tony Luck wrote:
> The Sub-NUMA cluster feature on some Intel processors partitions the CPUs
> that share an L3 cache into two or more sets. This plays havoc with the
> Resource Director Technology (RDT) monitoring features.  Prior to this
> patch Intel has advised that SNC and RDT are incompatible.
>
> Some of these CPU support an MSR that can partition the RMID counters in
> the same way. This allows monitoring features to be used. With the caveat
> that users must be aware that Linux may migrate tasks more frequently
> between SNC nodes than between "regular" NUMA nodes, so reading counters
> from all SNC nodes may be needed to get a complete picture of activity
> for tasks.
>
> Cache and memory bandwidth allocation features continue to operate at
> the scope of the L3 cache.
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
>
> Changes since v12:
>
> All:
> 	Reinette - put commit tags in right order for TIP (Tested-by before
> 	Reviewed-by)
>
> Patch 7:
> 	Fam Zheng - Check for -1 return from get_cpu_cacheinfo_id() and
> 	increase size of bitmap tracking # of L3 instances.
> 	Reinette - Add extra sanity checks. Note that this patch has
> 	some additional tweaks beyond the e-mail discussion.
> 		1) "3" is a valid return in addition to 1, 2, 4
> 		2) Added a warning if the sanity checks fail that
> 		prints number of CPU nodes and number of L3 cache
> 		instances that were found.
>
> Patch 8:
> 	Babu - Fix grammar with an additional comma.
>
>
> Tony Luck (8):
>    x86/resctrl: Prepare for new domain scope
>    x86/resctrl: Prepare to split rdt_domain structure
>    x86/resctrl: Prepare for different scope for control/monitor
>      operations
>    x86/resctrl: Split the rdt_domain and rdt_hw_domain structures
>    x86/resctrl: Add node-scope to the options for feature scope
>    x86/resctrl: Introduce snc_nodes_per_l3_cache
>    x86/resctrl: Sub NUMA Cluster detection and enable
>    x86/resctrl: Update documentation with Sub-NUMA cluster changes
>
>   Documentation/arch/x86/resctrl.rst        |  25 +-
>   include/linux/resctrl.h                   |  85 +++--
>   arch/x86/include/asm/msr-index.h          |   1 +
>   arch/x86/kernel/cpu/resctrl/internal.h    |  66 ++--
>   arch/x86/kernel/cpu/resctrl/core.c        | 433 +++++++++++++++++-----
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  58 +--
>   arch/x86/kernel/cpu/resctrl/monitor.c     |  68 ++--
>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  26 +-
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 149 ++++----
>   9 files changed, 629 insertions(+), 282 deletions(-)
>
>
> base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
