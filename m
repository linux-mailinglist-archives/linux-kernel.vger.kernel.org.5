Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073C67BAB4F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 22:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjJEUN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 16:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjJEUNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 16:13:54 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE48B6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 13:13:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hrn6Ssj71MK7CUCRRznSD/1HVNgo3GSoff0S3vpMQ/6Argr23AOJJT5LU2KwziscG6nqGy0RH9hx87CtexBZF3Nrg4kbu9Hf79ADzESw/cKAw/ff9fwihs/WPSt/DbI+8hJNMFdQISUGtMFJjj296zempnzvsXQqQ9/Rw0eKquZZxP9PZJ/zD5nr8aQ5OQbiBh3HzDuyXbniuW3n2M+AFUo+aQKpFCfLQoT+AwW0bSZET7Vti+QeJQSklzR0Jmn99nRaRO+2TgTO8Pk7nnEUtCpbFRmHPHhfSNG3g+/a6IZJ/JXb2JAVXtLm31wJA98j56TIOgxP1WS0W+W9di5IjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNeLIjsDi0LgiIpVcKF4IAsmdeIseSBZuE52iSzYl5g=;
 b=dJOW9oXyoXR2H2li1CQcViR/89ZULQOTt+FxaIir7rPGeZIYLv/GqvYNS4f5AEPfun7YQE6D1gjGFdh3v644Sh/OfUL+I0775rkbNXNIH+xsKvwgY48EYxd6bg5wR0Itq8stgWL3iRQiqNKqVXyrDYL+xVrSJ853xY0KePiXWpiwaK91kjtdI0JWHmSX+dwNobwQEtdoIBzUP6J3WzRo9QkT+nN3FySEVUPiw8H/xgnuDn22ErHcylj7gcRykOVDSMznzDVIQvEwCV83vHg6EsaoIGSnHGLgetEBmbO+jbIMnRVLn/yu1w3BqYBrDAD3jPiHSDQw8pHxj5OYh7TFvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNeLIjsDi0LgiIpVcKF4IAsmdeIseSBZuE52iSzYl5g=;
 b=paiPyU6Tgniny+0NYnhIYnYw0qQ2VTzalUqBg2Qc/cLm/WEoQNwWpZe+8vpvA1/XCd5/ncL0MBCCexBC4feiUrs49gHdfywY+xjvYMCdVNfGK2tbXQww1ggzRfXt5dUfBBegUrYSss4PHkXdqWMGbj+UcEx5k1hs63Ef0E5EYdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 20:13:47 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 20:13:47 +0000
Message-ID: <2b5e62a3-3b5c-c98a-6b5e-909a021a8d4e@amd.com>
Date:   Thu, 5 Oct 2023 15:13:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 10/24] x86/resctrl: Allocate the cleanest CLOSID by
 searching closid_num_dirty_rmid
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-11-james.morse@arm.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <20230914172138.11977-11-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR02CA0151.namprd02.prod.outlook.com
 (2603:10b6:5:332::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA0PR12MB4510:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d11312-bd4c-4da3-88b4-08dbc5df950b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m1/hxNwdGPJLBoVlqr5sZYZZ3ro1PSO3t/6ZZGANw5t34wJ2PP6IHfrRZ0yeA/eANL7rYKlC1S7e2XIy+K/HxWlXtVZRmKa3nNzoaU2vIXLt28HFr2s9Zjl3INKf9dxyxe0d8Vehm4S4Sie9XpZSfJPlIkYm+t51X0ExbPNsdyuu+p5K5I9b8+NbgQx7YiYIhO8+KzoFuwZqFUAcS837EDKAOVbvsEnenNsG+gVavur1WxazBNm9NdDbF9JGv/q4GUHetLfc0eGVQvztiUMtseUGltOsmI6YQf9qmEQiau5fKy9x7ndvfjLhBEv/OnRzmOcnXu2ISitMqeBexfwOPWILgujQrl4rE51iWiO1I5T1Gjg+BtP3f1ywEfBKljV+/STBEkK9BG7JaQl8UebI5m2N0BOBh7SGEUTLLWmJHtv+956kDPJ7q2s+T43hm5BMMW0rl9gSoajN9gWWObN6OcDSg+t5NxGC4+ufVoKflUnnA39udJQ/RUZAedDkeTAirKxbv1ubusqxZ1q9SbctYTXyqcP/xIN8AR2b13COcutlZYgIQfcrr9GYZ9LM/+Lh7M0C5iXdK98MIkBlBqGkKvvl/nCGXgMnWCoi6VsWKcwVDG3IjcqLJz3UjsBUTKQuEwXcHT7dt04ozLRh5tPbyfHrb92TcDHUckwxOY828tQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(31686004)(41300700001)(66946007)(66556008)(5660300002)(478600001)(66476007)(83380400001)(54906003)(7416002)(6666004)(6486002)(316002)(53546011)(8936002)(8676002)(4326008)(6506007)(6512007)(2616005)(2906002)(26005)(38100700002)(36756003)(31696002)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFZBNU11eVQxM2x1ZEhId2lNSUIvMU9Zc01uYnJ5bStSRFhnUzg5QUhHOWUr?=
 =?utf-8?B?ZW0vTXhxMzllL08vVkE4SWd2VytweVlUZGFHaXJsd1FLZ0Fwb0FkeHRrbG9L?=
 =?utf-8?B?WGdzSjhzendsREowTUJvYWh6Y0dOT3FtRm5zN3lKZ2o1RjBtdW9ZRE1mUjJP?=
 =?utf-8?B?L2poOGJ2OUQrZys2N01XbWRXVGt6ZUJyTEpKUkdLb0lFMzlTcmZFQTVNNGQ0?=
 =?utf-8?B?b3RhcHRKRWlWNDJxc1dwT0Qwb3JhU2tUY05DZklYRkxPYStvWlNVSXc4Z0sr?=
 =?utf-8?B?ZitHSVZNRURQWDg5RDU1R2pDaExDVkRPL2xsU2tkZFlucmF2YllYUnprS0NO?=
 =?utf-8?B?TStDTFkzTnV2TUpRa0Q3T2svV2RtWDFmMEQwVHpMQWJjNnNHQnF3K3ZCTGRy?=
 =?utf-8?B?U045bHhQMmdqOWRscFc0SzY0bkIwNW16czd4M1RKWmQwUUVhY1c5dmFIM2xC?=
 =?utf-8?B?TFpTaXQ3Z01XaFBVeEpRdFRLMVB3aHROSkxqcWNyVnpydmhqQVMxMnpKSzFF?=
 =?utf-8?B?NE9HdS9ISTlMSGs3NFlNUzNoejJYaUZNWXQ0dFpZNE5BbGsrYTZuRHFjblJC?=
 =?utf-8?B?UnRPZy9MWWdPUFg0MGNsQk12NkE3Tng5ell4clkyK0pBT1FpUS9zNDdQbDN1?=
 =?utf-8?B?bVBaUERabTVCVCtmck04WHhKSWVneiswSzNpeHJFd2RhRjltbkZoRGZFU1VK?=
 =?utf-8?B?RXRrbXpMeEtsSTBtVGZxcjVhSm9rOVFZdUNHRnhsWFhNb20xLytEclFUd2NE?=
 =?utf-8?B?cmNEcDh1Q3ROL0MyQVYrUFYvRk1sK29tWGszRGVKbHlqa0R0SWI5Q1FyTXha?=
 =?utf-8?B?V2NDdExZUDVDbG50M3IwQnNrL3ZFSVZHc0Y1UkhBMTZHMkh0d0txWjNhQVpE?=
 =?utf-8?B?dmoxUG14WjJsUmFrZ1BzQ1Y3WVFGcUx3Z3YrcEZZRWVncG85TS94RTZHYTVU?=
 =?utf-8?B?bTA3UnhzUk16THBqYlA0NTRkSk5GS3ptWjFRVFlqNTBJbjVreFNqQVl5QlZ5?=
 =?utf-8?B?aExjaWg1akZUUUxpLzV5SU96OGhURWpJWkhkQTc3dyttZVVrajljSUVtbXhs?=
 =?utf-8?B?dnVUM2JiWENRdlpkUk51ZktRR0RrUUxmVU5HUmpqZG1CTVpzZkpaTlIzWXpP?=
 =?utf-8?B?VUF2R1lxMi9WaE9scVRKUnBtc2paaTVpUzdiY0xhenVlRk0yM0RoZ1Q4NnZ3?=
 =?utf-8?B?V0ZzK3dPMkUzQkU5WlhjUW1Wa3V0SkJmWnNTVUZFQmo5aGlRUUxkWG91OS8x?=
 =?utf-8?B?aDVWcGNhd3VMMEZIZ0Fxck9NR1NsbFk4UzM4TzVBbVRoZlRqbnVETHJUcisr?=
 =?utf-8?B?bTBCR1hrcnZKeUVFSE1odTFDTlVJZUZEU1FQQmRhVHYveEtkODB0cHZwY0pQ?=
 =?utf-8?B?UUxFNWVoZ3ZrUE80N3FOa1RFL1hyMjg5TUpaandwSHFPY2tyOFR6UlhadlBS?=
 =?utf-8?B?MkdkdEhkcTA5WUZYWjEzbWtFYTRjS1Jubml2eVhPNCtBWnJoNXNUWUJQSEVu?=
 =?utf-8?B?SHpXdU8rRXdweFFDMGZ0TW1IZ2NjUGRPNVZjSE9NK2VraXlvMzZETldzV0Fq?=
 =?utf-8?B?cXg4ci9wZTF0cVRZWERUa1c5c3RJOWFqZHJVQ1VJYzdvTnFVdGZOYmxNaTVK?=
 =?utf-8?B?bHV0N0ZUcGk2c29BWERPai96QzdGMnpsVXNSaVptUUlORE95ekVGa3hCbUNM?=
 =?utf-8?B?ejRRcVhPaW96WUM5dXhPdkNucnI1akVKa1hvTXc1R3ZId21yN1dQTVJ5SGxv?=
 =?utf-8?B?YTFRMjV1WWM2blBsRyszN2p4cjBEd1RoQm9uUTFWdlVic0p2SUhjMnl2UmJa?=
 =?utf-8?B?UURrOXd4WWY3V096YXV3Q2VzRGh5RStycU5selVZM0xKS3pxMFl1bDJGZ1NC?=
 =?utf-8?B?UUJFMlhybWJRclo0ZVRJSktrQnpmQlg5NTZkRXVQR1kxZDVtTWtVTWJFVmFN?=
 =?utf-8?B?d0dCSnA1ZVc4YkJYeGs1bGx1NXQ5d3AxS3JZb01YUUxJQWZSUWt3Z2JwY1N3?=
 =?utf-8?B?N2ZLOFJNd1lHRU1HdHZVWXFJS21PQm9tNnFvUnlDcE82cHdXTkxTajI1YVdn?=
 =?utf-8?B?b2NzL1pFS0ZCNVF1YmdKWlFXS0VzUzVmclVwSzhuL2QwNHVsMWs1VExLNDhH?=
 =?utf-8?Q?Qocc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d11312-bd4c-4da3-88b4-08dbc5df950b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 20:13:47.4014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zy/yU7DK9zwr0SjL1YdaPryynFfCX0hsGtPxUxB1c6/Pp/hsYz+jhWeJfoFKpJW8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4510
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/14/2023 12:21 PM, James Morse wrote:
> MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
> used for different control groups.
>
> This means once a CLOSID is allocated, all its monitoring ids may still be
> dirty, and held in limbo.
>
> Instead of allocating the first free CLOSID, on architectures where
> CONFIG_RESCTRL_RMID_DEPENDS_ON_COSID is enabled, search
> closid_num_dirty_rmid[] to find the cleanest CLOSID.
>
> The CLOSID found is returned to closid_alloc() for the free list
> to be updated.
>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-By: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v4:
>   * Dropped stale section from comment
> ---
>   arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
>   arch/x86/kernel/cpu/resctrl/monitor.c  | 42 ++++++++++++++++++++++++++
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 +++++++++---
>   3 files changed, 58 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index ad6e874d9ed2..f06d3d3e0808 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -558,5 +558,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>   void __init thread_throttle_mode_init(void);
>   void __init mbm_config_rftype_init(const char *config);
>   void rdt_staged_configs_clear(void);
> +bool closid_allocated(unsigned int closid);
> +int resctrl_find_cleanest_closid(void);
>   
>   #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 0c783301d106..0bbed8c62d42 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -388,6 +388,48 @@ static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
>   	return ERR_PTR(-ENOSPC);
>   }
>   
> +/**
> + * resctrl_find_cleanest_closid() - Find a CLOSID where all the associated
> + *                                  RMID are clean, or the CLOSID that has
> + *                                  the most clean RMID.
> + *
> + * MPAM's equivalent of RMID are per-CLOSID, meaning a freshly allocated CLOSID
> + * may not be able to allocate clean RMID. To avoid this the allocator will
> + * choose the CLOSID with the most clean RMID.
> + *
> + * When the CLOSID and RMID are independent numbers, the first free CLOSID will
> + * be returned.
> + */
> +int resctrl_find_cleanest_closid(void)
> +{
> +	u32 cleanest_closid = ~0, iter_num_dirty;

Just naming num_dirty should have been fine.  I will leave it you.

> +	int i = 0;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	if (!IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> +		return -EIO;
> +
> +	for (i = 0; i < closids_supported(); i++) {
> +		if (closid_allocated(i))
> +			continue;
> +
> +		iter_num_dirty = closid_num_dirty_rmid[i];
> +		if (iter_num_dirty == 0)
> +			return i;
> +
> +		if (cleanest_closid == ~0)
> +			cleanest_closid = i;
> +
> +		if (iter_num_dirty < closid_num_dirty_rmid[cleanest_closid])
> +			cleanest_closid = i;
> +	}
> +
> +	if (cleanest_closid == ~0)
> +		return -ENOSPC;
> +	return cleanest_closid;

Line before the return looks clean.

*       if (cleanest_closid == ~0)
+		return -ENOSPC;
+
+	return cleanest_closid;

Thanks
Babu

> +}
> +
>   /*
>    * For MPAM the RMID value is not unique, and has to be considered with
>    * the CLOSID. The (CLOSID, RMID) pair is allocated on all domains, which
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index fa449ee0d1a7..1f8f1c417a4b 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -132,11 +132,20 @@ static void closid_init(void)
>   
>   static int closid_alloc(void)
>   {
> -	u32 closid = ffs(closid_free_map);
> +	u32 closid;
> +	int err;
>   
> -	if (closid == 0)
> -		return -ENOSPC;
> -	closid--;
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> +		err = resctrl_find_cleanest_closid();
> +		if (err < 0)
> +			return err;
> +		closid = err;
> +	} else {
> +		closid = ffs(closid_free_map);
> +		if (closid == 0)
> +			return -ENOSPC;
> +		closid--;
> +	}
>   	clear_bit(closid, &closid_free_map);
>   
>   	return closid;
> @@ -154,7 +163,7 @@ void closid_free(int closid)
>    * Return: true if @closid is currently associated with a resource group,
>    * false if @closid is free
>    */
> -static bool closid_allocated(unsigned int closid)
> +bool closid_allocated(unsigned int closid)
>   {
>   	return !test_bit(closid, &closid_free_map);
>   }
