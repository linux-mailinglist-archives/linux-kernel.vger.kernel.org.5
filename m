Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F64378090A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359419AbjHRJzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359433AbjHRJzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:55:15 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C734830C2;
        Fri, 18 Aug 2023 02:55:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnWtiF2CMeTiG9P0ElYdpVayGTC7VOMcGwCQGrvoh25OFJ+WMznWc0s6Bukuj0BkkCk7HhXw+2spMVcVEG01Hu8gYFTvJpt1MrvTKXCLcyAgoEp2uBKkQXZ5GdOUG/XiaDzkUDi+gCgWOUDJF6u2HkonbzqsQiNe3nrVk+I78Lc0XNao0v2WuFbHeUH+xuNi1e+Eb9uPno9KoivxbjgS7rS0xVeplery1SJLbwrNTsn37M26Te2H53RH2aEaKr8oAbxhkylYr6pJBOwbXMZNqLwDP7C6siEg0sl3qUS8PZ87jdwyf4iEZSaHxvaGjRT3pSy5TK+GfKzfR13rN4xdJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNAJwz+Yksw0nyLmI5VyrP4OjdZEMnZZS2y16puDWoc=;
 b=oeqgYgq49nvaIRjCWccJSTxrsC0/bqdTkpknrwIUzvc1rsJKwnpzk9iVPcHLHlItP8xpzwGU2z4APJt+tMHKGmZ7KQhaZitmUUwmD5kh0Fu9P+8EexbdGjBcugY7OcK3kd8olfku7op4l7syIxQiySRefirvaMOFGeGcL36hMbUqsQd8q/b5TFAfp+rfTKDT8u057mtF/UEdGiemN1ZUSOXlhIuG4dEif8ZlA/F8kux6a+mdNjGPf9UG/3nik9F0KS5hVN/JMa++2mO9W6dxESeCx3aqSFooyLa3r9u4NVyxYTkLfY8vmqWeuNOLaYkPuV5Onw7DYuF0i4mYXfb1UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNAJwz+Yksw0nyLmI5VyrP4OjdZEMnZZS2y16puDWoc=;
 b=Ev1ScFs6Wk7LAH0Ulb0c7MV7UnIiVQvMjC1VNuakSraLL+HDMn6dhGJ7pc9Z+4LjTqQ2bCoHAOFw20gU2AlyXJpe7YNzfDZq+txMivEkU9L8Y1cZndUzNe8gHk2AszcYcpzK+DmuPLisr64/8ox1YIWEnrGG+5xs2K7UIUH1UGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS0PR12MB7534.namprd12.prod.outlook.com (2603:10b6:8:139::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 09:55:09 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0%5]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 09:55:09 +0000
Message-ID: <c8aecfc1-c03f-80ee-bd84-aef85d0302f6@amd.com>
Date:   Fri, 18 Aug 2023 15:24:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [V9 8/9] drm/amd/pm: enable Wifi RFI mitigation feature support
 for SMU13.0.0
Content-Language: en-US
To:     Evan Quan <evan.quan@amd.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, lenb@kernel.org, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alexander.deucher@amd.com, andrew@lunn.ch,
        rdunlap@infradead.org, quic_jjohnson@quicinc.com, horms@kernel.org
Cc:     linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>
References: <20230818032619.3341234-1-evan.quan@amd.com>
 <20230818032619.3341234-9-evan.quan@amd.com>
From:   "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230818032619.3341234-9-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::17) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DS0PR12MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: 84cfb9a8-5a92-4728-802e-08db9fd13536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5oxFHWSDM0EcEXvWalrSzyenlvB7K7ihWMs09pzOag9r3+m1bxLqU1PXn8fZpL1yDCrsKv2VRI9ZELPDynPeOqyz9c9DO/FUE/3pFpQs1Cv7olM6CPsA429fxzJJYKWbZziHFlG1NcEB8pWZWdJz6l+McQqqPdZ0WIO0p9SXoYkP4qb/MWhVwf/6S0ZP9pc65OLtZ5a5zMeBKoHEcvy4RDL/sFB0EklppOG38ia4hzd5iRvRrb09ghYyvXPCuMveGumeHX9ME1dViZi9AuxWgJKfNNSpkqi07PHIExNDZLhRa8d3fEgIY50Fwy/ALufj0O01Yz0mdODU83bBJ5ZhxFMW0Pj+qF/EJk43BDLX8G/HkKLNXNy9+QC9TpAZ+gURc+CUx4ighLQzdTYfHlUggB6KSD6EAd0OSzh3LrqHxF4uqNhPo7EaFJxM/Oci71OvnlGH7V3UkWMB1VkksKrWapDz8yXcSF4qPX7xCMKpXAKUpd1RSjc/I9OXXmWIwFWx6C3oWHSNlIK/TsZ54Uk13/h+8IbD43xx5pu2yIgJEoj9BxcRBJwSmI+lA+FUr4ZyrD7m6x+nYiqdUkyQdSUC6cAeVJl/fwib1WYt4oDRbByVbafRUCkkOWegYRKt8+PQfcppmb8zGvgQAZ3dAFVA4eb7PFGpAxdjNC8vC9AhzQA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(376002)(396003)(186009)(1800799009)(451199024)(6666004)(6486002)(6506007)(38100700002)(6512007)(53546011)(86362001)(31696002)(26005)(83380400001)(36756003)(921005)(2616005)(2906002)(66946007)(66476007)(66556008)(316002)(41300700001)(5660300002)(7416002)(31686004)(8676002)(4326008)(8936002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGxTdUJSZVVkMWxOVHhQa0FhazhMMHBBZVRPZE5paUNNUmF6alkvWllXYjNL?=
 =?utf-8?B?Z25OSGpPZU50ck14bFhwNmNmMXZhK1pXQmpWTnlKSlZvRWNpVGJ3SkVvWldZ?=
 =?utf-8?B?MWlaaTlxaXJqTENjcFpweThpMC9xYThTV0ZWSHhhZVZ1amNvL2UvOWxUbWdq?=
 =?utf-8?B?K3F4OHgwcXg4VXdpNEVjM0NFUk5OYTVtNGxJNUJxRzdJVXF1TmsvL1V3d1ZN?=
 =?utf-8?B?Zmo2emhzdUd2aUpFQXhrMWpmWm5pbiswcGlaVUErdmdhTGJSOFpGYzB2WGFI?=
 =?utf-8?B?dTR4eDB0aXpBb3Q2Y2d6NmZUdXFIMnI3TjlSNnNYdm41dXVKNDJpbEJ3YWs5?=
 =?utf-8?B?Q3RBQVpLSFB1TlhsTWFyNDBDVFdzOWN6NWhsaS9ybVY0VXhnTTdVUnJxYm1m?=
 =?utf-8?B?c1M2T1JsaWltbi9LMzdaVS9RdXAwekd5T000SWZoSjhLSFlnSTUxRVVGcTZt?=
 =?utf-8?B?ZUhpME5wcFowUkN1ZGpGeE92RVcrbzRGdW4rUmlxYVBSWTJUQ0JNUVlHeWtE?=
 =?utf-8?B?ODg3ZUlWLzNDOGo3TUZsZ2lpTXJDczAvUks0aEh2QWc5ZHRnMG9nRUJURVJn?=
 =?utf-8?B?Y2tKak8va0h2T25qT0hlYWFycUMxMmtRYlkzNDdlSy9DZTFmQUpDYk50M3dz?=
 =?utf-8?B?ZWpKaGt0dTkxdS9lenhkYzloYmpFWG5XZW96aEJYUVg3NjBIYWFqMHFVWkRX?=
 =?utf-8?B?bkJhYmFIOGlWdnQxSUlzVzFvdjJTRzMrV0g3QVVoNE5MaG9WL3pnQ1hQbXVB?=
 =?utf-8?B?K2piU1EwdWJzaGpFSDMxZ1BNL20yRXhERUM2Q2tXam8zRHhRdVpHOTI4dmRa?=
 =?utf-8?B?aGlQaXRmK21CbEcvYUFpRXRicTB3MGI3a293dG9aTE9rNjZ4VWlRQzgzMGVD?=
 =?utf-8?B?UlN4OUJKUXppTDFHNU9wVFpqZjVESkk2VnFzaG02YnFKRFJBMTJmUWE1Ujlm?=
 =?utf-8?B?S0MvZ0k2eGxKQ0N5bVlDS1hPemxaZUxJRlZEM3NLamJva01IRDduVGpXWlBF?=
 =?utf-8?B?ai9aZjBEUzVFa1pIY1QwK3ZLT0ZTblUvN1RscjFjdFh0OWYrTk5XZVZ6ckZj?=
 =?utf-8?B?KyszRFhBQ1ZleFQ3bFNnYVVaZi9pMDNSQllLZ0VlUzgzVEcycmU2RGhIZTlZ?=
 =?utf-8?B?QVdFdU5aSStsREwwelplai9CSkNadkh3TzQwc3haTVFJVjRLclluY0RLMlZJ?=
 =?utf-8?B?ZXY1b0VxV0RpV2UxS2ZicVJVc0RwSVBMS1BvVUNZVkI4SU9VSEtrQnU2dnd5?=
 =?utf-8?B?QjFYWjkvdkhZNVVGRWRvNzFPems3c2pHZzhUcUU2L2RJQmh6YTk5R20rY0Rq?=
 =?utf-8?B?SXB4ZFRpN3UvU2FkalVHcjQ2QnoxUmNDMkxkbmhQaWRGWHV5c1JtNExSTEg3?=
 =?utf-8?B?RGNzZjlJZ3hNRWpZV1MzYTZmcUdCS0I4dmFtK3ZycEk1bzVyQnVKdHJYWHN0?=
 =?utf-8?B?eUJmUmdHZyt5a1pVYWs0RjY2MjRvc3dBTTFyOEZwOFozWFRDL1V6aHArUE9R?=
 =?utf-8?B?dXFqNVNSK3hJcGlIZldxSVZSdGR6S0dYUlh6TTl6MS9jZG1ELy9TOWFYMzdJ?=
 =?utf-8?B?YzZwNklVRkJiak1qZWFQOGhSV1JoS2VLZnZVVnVyQmxRRk05QVBNbWFCc2NY?=
 =?utf-8?B?R052dzMvTi9yWlVzaWgzUmlBR1Fiait2NUhoUS95Z1ExNGxIeGszbmxjNURN?=
 =?utf-8?B?Ly8wYzY1VUxVNlgySml1NVQ5anArekRBVHd6YnhFcW5PbDhiNVUzODFuaGsv?=
 =?utf-8?B?QnIxbTNvNkpsN25FU2o1T2hvcTRncVFwaFNhY3pIM3R0YXUrVVBJTjYvV1JQ?=
 =?utf-8?B?NmQvRzZRUDlsakF4YTV1bks5WFpFSUNWRWM1RFEyYWl4UXJOejVrSERReEgx?=
 =?utf-8?B?SG5LUGVBcTBvdm5mMnRGOXkrdkdMSWg1eHRjSEVtb0djY0srMzduRDZTYWhq?=
 =?utf-8?B?anR6UHlXUVdOajdKeG93RmNrUkxRRmlrWlI3R3lxTnRFWlZQRkw4bElzbE5G?=
 =?utf-8?B?L2tPUFVXUDRFbi9LS1dCTk91NUVwRGVreDhpd00rMG1EOS9oekJjTjdrc09D?=
 =?utf-8?B?bnJ1S1FVU1IwRlBSY3hkWXNBUHArd29hSm1qbEpDMFZRczg5RktpRXVpWUwx?=
 =?utf-8?Q?3ZZdUQ97DfpdLgV50bd6V0Gun?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84cfb9a8-5a92-4728-802e-08db9fd13536
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 09:55:09.6765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81ZZxT7CVvm48O+Mmu1VF/ToMrTVs8KacFOE3WtcN4cwCOsoxU7E5JinDJsmV7ET
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7534
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/2023 8:56 AM, Evan Quan wrote:
> Fulfill the SMU13.0.0 support for Wifi RFI mitigation feature.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 +
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 +-
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  3 +
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  9 +++
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 60 +++++++++++++++++++
>   5 files changed, 77 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 4d5cb1b511e5..54e76d6e66ce 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -325,6 +325,7 @@ enum smu_table_id
>   	SMU_TABLE_PACE,
>   	SMU_TABLE_ECCINFO,
>   	SMU_TABLE_COMBO_PPTABLE,
> +	SMU_TABLE_WIFIBAND,
>   	SMU_TABLE_COUNT,
>   };
>   
> @@ -1501,6 +1502,8 @@ enum smu_baco_seq {
>   			 __dst_size);					   \
>   })
>   
> +#define HZ_IN_MHZ		1000000U
> +
>   #if !defined(SWSMU_CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !defined(SWSMU_CODE_LAYER_L4)
>   int smu_get_power_limit(void *handle,
>   			uint32_t *limit,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index 297b70b9388f..5bbb60289a79 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -245,7 +245,8 @@
>   	__SMU_DUMMY_MAP(AllowGpo),	\
>   	__SMU_DUMMY_MAP(Mode2Reset),	\
>   	__SMU_DUMMY_MAP(RequestI2cTransaction), \
> -	__SMU_DUMMY_MAP(GetMetricsTable),
> +	__SMU_DUMMY_MAP(GetMetricsTable), \
> +	__SMU_DUMMY_MAP(EnableUCLKShadow),
>   
>   #undef __SMU_DUMMY_MAP
>   #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> index 355c156d871a..dd70b56aa71e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> @@ -299,5 +299,8 @@ int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
>   				     uint32_t pcie_gen_cap,
>   				     uint32_t pcie_width_cap);
>   
> +int smu_v13_0_enable_uclk_shadow(struct smu_context *smu,
> +				 bool enablement);
> +
>   #endif
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 9b62b45ebb7f..6a5cb582aa92 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -2472,3 +2472,12 @@ int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
>   
>   	return 0;
>   }
> +
> +int smu_v13_0_enable_uclk_shadow(struct smu_context *smu,
> +				 bool enablement)
> +{
> +	return smu_cmn_send_smc_msg_with_param(smu,
> +					       SMU_MSG_EnableUCLKShadow,
> +					       enablement,
> +					       NULL);
> +}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 3d188616ba24..fd3ac18653ed 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -154,6 +154,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
>   	MSG_MAP(AllowGpo,			PPSMC_MSG_SetGpoAllow,           0),
>   	MSG_MAP(AllowIHHostInterrupt,		PPSMC_MSG_AllowIHHostInterrupt,       0),
>   	MSG_MAP(ReenableAcDcInterrupt,		PPSMC_MSG_ReenableAcDcInterrupt,       0),
> +	MSG_MAP(EnableUCLKShadow,		PPSMC_MSG_EnableUCLKShadow,            0),
>   };
>   
>   static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] = {
> @@ -237,6 +238,7 @@ static struct cmn2asic_mapping smu_v13_0_0_table_map[SMU_TABLE_COUNT] = {
>   	TAB_MAP(I2C_COMMANDS),
>   	TAB_MAP(ECCINFO),
>   	TAB_MAP(OVERDRIVE),
> +	TAB_MAP(WIFIBAND),
>   };
>   
>   static struct cmn2asic_mapping smu_v13_0_0_pwr_src_map[SMU_POWER_SOURCE_COUNT] = {
> @@ -481,6 +483,9 @@ static int smu_v13_0_0_tables_init(struct smu_context *smu)
>   			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>   	SMU_TABLE_INIT(tables, SMU_TABLE_ECCINFO, sizeof(EccInfoTable_t),
>   			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> +	SMU_TABLE_INIT(tables, SMU_TABLE_WIFIBAND,
> +		       sizeof(WifiBandEntryTable_t), PAGE_SIZE,
> +		       AMDGPU_GEM_DOMAIN_VRAM);
>   
>   	smu_table->metrics_table = kzalloc(sizeof(SmuMetricsExternal_t), GFP_KERNEL);
>   	if (!smu_table->metrics_table)
> @@ -2593,6 +2598,58 @@ static ssize_t smu_v13_0_0_get_ecc_info(struct smu_context *smu,
>   	return ret;
>   }
>   
> +static bool smu_v13_0_0_wbrf_support_check(struct smu_context *smu)
> +{
> +	struct amdgpu_device *adev = smu->adev;
> +
> +	switch (adev->ip_versions[MP1_HWIP][0]) {
> +	case IP_VERSION(13, 0, 0):
> +		return smu->smc_fw_version >= 0x004e6300;
> +	case IP_VERSION(13, 0, 10):
> +		return smu->smc_fw_version >= 0x00503300;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static int smu_v13_0_0_set_wbrf_exclusion_ranges(struct smu_context *smu,
> +						 struct exclusion_range *exclusion_ranges)
> +{
> +	WifiBandEntryTable_t wifi_bands;
> +	int valid_entries = 0;
> +	int ret, i;
> +
> +	memset(&wifi_bands, 0, sizeof(wifi_bands));
> +	for (i = 0; i < ARRAY_SIZE(wifi_bands.WifiBandEntry); i++) {
> +		if (!exclusion_ranges[i].start &&
> +		    !exclusion_ranges[i].end)
> +			break;
> +
> +		/* PMFW expects the inputs to be in Mhz unit */
> +		wifi_bands.WifiBandEntry[valid_entries].LowFreq =
> +			DIV_ROUND_DOWN_ULL(exclusion_ranges[i].start, HZ_IN_MHZ);
> +		wifi_bands.WifiBandEntry[valid_entries++].HighFreq =
> +			DIV_ROUND_UP_ULL(exclusion_ranges[i].end, HZ_IN_MHZ);
> +	}
> +	wifi_bands.WifiBandEntryNum = valid_entries;
> +
> +	/*
> +	 * Per confirm with PMFW team, WifiBandEntryNum = 0
> +	 * is a valid setting. So, there should be no direct
> +	 * return on that.
> +	 */
> +
> +	ret = smu_cmn_update_table(smu,
> +				   SMU_TABLE_WIFIBAND,
> +				   0,
> +				   (void *)(&wifi_bands),
> +				   true);
> +	if (ret)
> +		dev_err(smu->adev->dev, "Failed to set wifiband!");

Since system could be operational even after this, can we downgrade this?

Thanks,
Lijo

> +
> +	return ret;
> +}
> +
>   static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
>   	.get_allowed_feature_mask = smu_v13_0_0_get_allowed_feature_mask,
>   	.set_default_dpm_table = smu_v13_0_0_set_default_dpm_table,
> @@ -2672,6 +2729,9 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
>   	.send_hbm_bad_channel_flag = smu_v13_0_0_send_bad_mem_channel_flag,
>   	.gpo_control = smu_v13_0_gpo_control,
>   	.get_ecc_info = smu_v13_0_0_get_ecc_info,
> +	.is_asic_wbrf_supported = smu_v13_0_0_wbrf_support_check,
> +	.enable_uclk_shadow = smu_v13_0_enable_uclk_shadow,
> +	.set_wbrf_exclusion_ranges = smu_v13_0_0_set_wbrf_exclusion_ranges,
>   };
>   
>   void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
