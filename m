Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97148803AEF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjLDQzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjLDQzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:55:02 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C0AB6;
        Mon,  4 Dec 2023 08:55:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+LgIOpVlxyFjd28LwGnLoEULU+vH6yWf8D9F5fYLyJppEww8OIPlTa1yQu2JRDAVlWb2O+wqwEmKGOHDoZGyYpbv5K/PNcSKbF26naKcp2y3C9xQSkNfXzBRC/s15Wd9Odb93nQZbe5qlRQqv4+V6unmbY7je9tHgWt8ganZUrXbhl2dWUYG6+zrGq4lVgSmxuyny1ZCQpikslI5Lr2wE/yzV7UlJWS6Mm7j5NnpUzeUMKwxHQxyd/i9A0nrzCVNPRqCvUclza5ue34d1WI4wrEydDfOcqhKyYPQ+cr0fq7B8XMpu2iRn/qQ7xldpH9Dx4SceKSJqphKWJAVLQ97w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfb1YqfgOPRT4ejDMp2onoaAfFSk881KzcjxeY67u7w=;
 b=LgyLrdLdriNbgJp1tHJZ8/NHShMga+SjveQtlBATrCevxIIkRLbq8h1WOGO2lB1UXTWQmBfUekLB/fg8QaVAQgeKm5ca8lq5nJTJ5G4gGRh2aJ+2G/lFRRZQ2D9r+m93ypZIF8qPgMsTBAKXvtRV+kLoba296bNHdXV5Qlz+mFEWb29WGaqFhjU+AomXQyUMfeUfWkGk15lS8xRHWw6XnStyLkvvPRLTghkH3v1GAbOI1JUYBD0q2ZEsrjUPXxVqyP1w+XWnxI6CvzzAdbNPEuBwRr6vaJs8Jq2Lpg0hQCOu/gg5UzVWIUilN3O6JhttnDAiTKCfhSJd0sFd6jPwLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfb1YqfgOPRT4ejDMp2onoaAfFSk881KzcjxeY67u7w=;
 b=XTO/s2Dq71+k9tdhvtLK51Y9DbFXdMJznrPsvYTPIIbIYzULcMgUhH6fkcDT19ehXuAEWNUPLiy+VL+gInkquzXwuCXVW683vAE9tW+qmC9///X4l71CmzK53EVNrAg9e1SmrB8S3XuSjSrPUDe/q2zoLFdWNg/cVqEKG4J0WoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB5197.namprd12.prod.outlook.com (2603:10b6:5:394::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 16:55:05 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 16:55:05 +0000
Message-ID: <6e91d85c-8cf4-4df9-838a-e5265daed726@amd.com>
Date:   Mon, 4 Dec 2023 10:55:03 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v12 8/8] x86/resctrl: Update documentation with Sub-NUMA
 cluster changes
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20231109230915.73600-1-tony.luck@intel.com>
 <20231130003418.89964-1-tony.luck@intel.com>
 <20231130003418.89964-9-tony.luck@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20231130003418.89964-9-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:805:de::46) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB5197:EE_
X-MS-Office365-Filtering-Correlation-Id: bda52cbd-9a76-4088-1d8c-08dbf4e9c406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8fEcI3C6GOfIC62LIB3JM8xDC7bCcRVdmM6mATz7iztjXGJ+MAW1aFhqDehQccYWTFyor2hIUhHJRNpM7G/X+Kw+zRbFjMBPpIZy5e3ADUEttVNkp5+Dio10gthKrjwAWUymQsvIrQlz5gD/gRaGlx/tpa72XbHJ+LvkljDPgZhVjkeiV1GYOq6WPhsMRUZ4pMXC3+64XUEW5n/8dd8+3fmAR0jAbgde3aCHdbc4qtatbyXERT61KIYBrb2+QxZ7LfI8G0/8OhrQQgtW+GUuP39y2J9xIZRWYwxYQC/QSpxSUGAqKQqG3vp17rAu+/S+iDoIEMv3eZ8JqLA5p3NMFb3vX8AuGC1minJxlhbT6BqIDrYV0bPxgtreVNCONltrALwJS5cZjyGyLrHQVwlmwMxdVffl/zhHc5cS6poU/6w5JCAJZ6nnQnzO2wb+kiJfqvJgH75HvswborVpG/+/VBKmCtgr/MPjFnoCVyiNc42oFM1U7MN5FQwT7coCA0wMdY3QTuCD6gaZzVy5R2TdT80HV8B0DA1Xw/iWBQapkPgGsWEeRNZIaKRfrDAVsT/hKF5oeetVPuWkor5i/EKwgGpd/Dpg8Hzl6QnZDmfwP/D2ijh2/rHAtn2bYZKlJCLYZNb5N53IPHHE02fT+hN4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31696002)(5660300002)(86362001)(4326008)(3450700001)(8676002)(8936002)(2906002)(7416002)(41300700001)(36756003)(2616005)(6512007)(6506007)(53546011)(83380400001)(6486002)(478600001)(26005)(38100700002)(31686004)(110136005)(316002)(54906003)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkJMUTErdk9RR0ZiSGVhK2M0UXpLRTN2d1RkMVQ3dk4yUUl6UVp5RnNnTXZX?=
 =?utf-8?B?dHZOQ0RicXJ1ckt0VW9IdHBEdjFKNkJTK0FubmJPWlBlU1hPZC84Q1RiOTF6?=
 =?utf-8?B?clZQbEJCZ3BKYlhCT3pPa1FzRUJ2dUlGSlQ3ZGFqS3ZXenJSaUtiM1o2K016?=
 =?utf-8?B?emFZTFlUV2t3bGZWT1c5bUFKZFlPMXBJWmtENEUvb3BWcWJCZVZMbGRRbWR2?=
 =?utf-8?B?TkQwRkhTZEhBWXhaZy9PVTZzQm52QzVnTUh5a0dTMmlUeTBsYnJsSnBxdnY2?=
 =?utf-8?B?bC91SUx2dVgvZDlnVGVqd3J3dy83M3Q5NXQ5ZVFMYXNMcHhvc3ZHRTR1YXhy?=
 =?utf-8?B?cVBKblZwZ3ZhRzZTZmdXMHkrc1Y5cnB2QXpXM0Z6VHd2b3JhTEphZFJKRkp5?=
 =?utf-8?B?RUJjSlRWbm9GOHN2RHJFWFpLSk9qVzg0aU5weHlaMEx0czdkL2c5YjRzTDU5?=
 =?utf-8?B?Vk1Vd2wveGNOZUJKYXJ0WmFJaGFaM0dlZDI3VEpQZ0VUbHZYUjZXRGFwNkQw?=
 =?utf-8?B?WmFXWFNVQTFIUDNCTlV3QkpkWkxMSGxCTS85MUxrSWZNV0VyYlNTanVtRmVC?=
 =?utf-8?B?MVdKSnJTZlc4d1NOYmE2bm1VUTNiMVRMWktySzgyaTJVdFNpZXZuSjlGV3R3?=
 =?utf-8?B?eHJQMjJJalVUcGhTRmJmSWk3ZlZYRXNTVlVZYkZCZjZlOGZ4djViWW82TSs3?=
 =?utf-8?B?VmZjUG9NWjV1NS9HZERQV1IyeVQ4dU5sL2ZWaE55eWd6bktIRWk0V01uTzFJ?=
 =?utf-8?B?cVlMRFNVTFdoRXljZlhNazFQVUFpT2RMN2NjbG41SDhLVGVjVmNONCtPUWR4?=
 =?utf-8?B?WmFyNzI2dDlOc2tQY051YkJyd3V5YTBGN3RPZlMvUWFGZlNKV3VoNlBUUWxl?=
 =?utf-8?B?OHFPUkU4THlpRmNCMm55R1pVR2FoTEJINU9HT1h0ZGZKeXBSdkhjdnVUTWxS?=
 =?utf-8?B?Wm9zM2JpV3hOc2puVERaYUtmN3h0WmFsdVVqQ1A3bnJZemNsODljOFMvVDda?=
 =?utf-8?B?Uk96V2QvYVRUbS9IamFnM0dhQUVhVWFqUHA0N2djVENNUXR3WEVhTzNTS1Jq?=
 =?utf-8?B?TXljQWVCbGZ3NFRQUjR6bWZzMGZnMk5lSzZpV3FEWUlKNzE4blFmQUc0enBl?=
 =?utf-8?B?ZEJ6ck5FMUNWQ1g1SE0rUDJKTk1DcE5wbWdDVit5bS9BVmxiZzN5MURTbDNp?=
 =?utf-8?B?ZDhxUmpBR0E3RDZSKzBoWkRRcUR3Q2daZ1NPSjlpOXd2MlN3b0g2LytUeEJj?=
 =?utf-8?B?eEZJdUhvektOekF6c0w5YWluYnQ2NVU2YVJrUTFrY1o1T2ZYcXZ0bklxdkZv?=
 =?utf-8?B?M2FuL3gzRGtqQTFOeWgyUEZRd3Z3SVNVcnRMYnQ4OE5FV1p3WjZ2YUNWMjNh?=
 =?utf-8?B?Z1ZjcWtRakJDZ1puRTBhZmRVM0c5WW5nbzBvM3NNekpFQkttb2dXRUVlMEFt?=
 =?utf-8?B?eWdDVnIzM3ppa3IzLzFXK29tM0ljdWpSTlBzMVpTdG1Ldk44VnlpSmZ3d1dl?=
 =?utf-8?B?emlXcXZXMlg4eU5SRGZYdjZoV2F4emQ2M1NHMDI0R2tHeVErbzQxdHJ5THZ2?=
 =?utf-8?B?OUV6R3o0b1g0NHZxdlI4VVB6b1RGQTUzVUNYNXR0MnFlYXNpTEorRW96TVJx?=
 =?utf-8?B?dVVwOWd6ZTJiNTFNNW5BbXdwZkNkMVdHSXJ6NGg4TC9LM1Z0ZDZUV3dqalZ6?=
 =?utf-8?B?QlB6R3RhV2xFSDJjd0o0MHpyblFkRnR1N3JWZENHakhwelFzQVNXNVFvMFFj?=
 =?utf-8?B?OTdUMlFTMEZsYjAzYkZSZ0tSYVlGa1pKdytzWXV1YU5uYmFiN21veEtZc0Y2?=
 =?utf-8?B?SXB1UG1NaEpuZ2FRRlEya2plV2UveGdlbmtSakxnMW1ZMS96S3UwREV1TVNr?=
 =?utf-8?B?SUhUN010bUlMb0tGUHRPc0oxaDJDTFRNL2FHdTJibWxJSWRweHVNOEVnNXdS?=
 =?utf-8?B?RGxYYytNanlmc0F4aldFZGRMOG10OG1MWFI1UE9JTVpSaThWaDRwTUpBY1lV?=
 =?utf-8?B?YlhXVmJmeFhMRk81T1VSMGhQL2s5ZFdFTEczZEk1eUFPS0JUcnIrWThIMjJE?=
 =?utf-8?B?RTUvb3ZGakI3NlorRlJ1NGozTDVYWWkvWXAvenc5ejlyNkdOeU5YcytjVkdl?=
 =?utf-8?Q?dJaE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda52cbd-9a76-4088-1d8c-08dbf4e9c406
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 16:55:05.8039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vH26lGapcFahnK8byLxiniIedHTda70gJkf8zFm8RGwv39Q1u1DYe2gEoJ8V0RsI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5197
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/23 18:34, Tony Luck wrote:
> With Sub-NUMA Cluster mode enabled the scope of monitoring resources is
> per-NODE instead of per-L3 cache. Suffixes of directories with "L3" in
> their name refer to Sub-NUMA nodes instead of L3 cache ids.
> 
> Users should be aware that SNC mode also affects the amount of L3 cache
> available for allocation within each SNC node.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  Documentation/arch/x86/resctrl.rst | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index a6279df64a9d..49ff789db1d8 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -366,10 +366,10 @@ When control is enabled all CTRL_MON groups will also contain:
>  When monitoring is enabled all MON groups will also contain:
>  
>  "mon_data":
> -	This contains a set of files organized by L3 domain and by
> -	RDT event. E.g. on a system with two L3 domains there will
> -	be subdirectories "mon_L3_00" and "mon_L3_01".	Each of these
> -	directories have one file per event (e.g. "llc_occupancy",
> +	This contains a set of files organized by L3 domain or by NUMA
> +	node (depending on whether Sub-NUMA Cluster (SNC) mode is disabled
> +	or enabled respectively) and by RDT event.  Each of these
> +	directories has one file per event (e.g. "llc_occupancy",
>  	"mbm_total_bytes", and "mbm_local_bytes"). In a MON group these
>  	files provide a read out of the current value of the event for
>  	all tasks in the group. In CTRL_MON groups these files provide
> @@ -478,6 +478,23 @@ if non-contiguous 1s value is supported. On a system with a 20-bit mask
>  each bit represents 5% of the capacity of the cache. You could partition
>  the cache into four equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.
>  
> +Notes on Sub-NUMA Cluster mode
> +==============================
> +When SNC mode is enabled Linux may load balance tasks between Sub-NUMA

enabled, Linux

Thanks
Babu

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
>  Memory bandwidth Allocation and monitoring
>  ==========================================
>  

-- 
Thanks
Babu Moger
