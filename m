Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6856F780810
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358963AbjHRJMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358962AbjHRJMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:12:31 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27328E;
        Fri, 18 Aug 2023 02:12:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jb+hdcU7M1/xRj+dM3srLmvfTJ//741vEe/w8PW89wylWFfreRUcMSFfy5jWCDyv7kfW4DkJyOxEmQAkhJcCXqIP9T9akmbgLWb6UUA/AQvrt3d+9Rzq+5LxSS9yOpEayP8cCb2IED6RQYd4Ej2F6HFaj7D+lxIVfyP4mA4fdmWmBTyYC/kJXLgGgjYNMfCBQ7LBbgger3krQxFNiLM4MHKyrpOtmCRp2xrjv92fvAX3uB7vWFVHTsJ9QQis92f6R09KuecC71r+0LDPOx6QJSPvieFlEu649nYIMku5u9eEjzK8a6kaxSRshfhqekq8Gr3TMhqAOObJbwJ6Uc+L6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EncIkvIf48QaL7ayqer7q9Uyi+Q8LRhqLFoGIg7DluQ=;
 b=a0Wz4g+BTsK4UWa/6TFA8xXDu+Kk38xsTBGj96ZlyUzAbLhBQgJFpeRehZLUsYPscU85tc96U+4/iBffMnE9PBm1tnYF432Vf6pvXFJ910cnMpI3n7viXeGN0TuHFno/cn2ivVJjbaIDE2g4lTamuaml2qQmuKKf6MMVMK7I/LBkB9kBQ3FGs6w8PmLm4e7wZhq9MZsBgM/z0NqcQcsfSZDzdo4uYN+LmHHYT1TxUB0q9PNyWv0BbQk5LEab2z8wKYyDzb9V7PaP6rUS+9VXhb6mqxig1KuwBeoU0zHl/fFlYkVpTksT/7aku6mdxAXXp4COYVGkGXHx+mSSeTqm/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EncIkvIf48QaL7ayqer7q9Uyi+Q8LRhqLFoGIg7DluQ=;
 b=Vxtyap56HXk24cXUuNGiwHdNof85SOA0DK19z2P5RSlrpqq+bmZZAKDem0rrMLCNqxhv9yGkFXpLEeNC9Tjm5ClyFcoZhHmyyp1wjZcOrNwkUZb9WWcAjRt5Rykde3RT4Q5/nhgJ2z3U8CxQ+iXJP9xmt09b8MTSOQkMuCUcCq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH7PR12MB5950.namprd12.prod.outlook.com (2603:10b6:510:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 09:12:26 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0%5]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 09:12:25 +0000
Message-ID: <60164c68-4a44-c2fd-67b5-787ed08d0692@amd.com>
Date:   Fri, 18 Aug 2023 14:42:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [V9 6/9] drm/amd/pm: setup the framework to support Wifi RFI
 mitigation feature
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
 <20230818032619.3341234-7-evan.quan@amd.com>
From:   "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230818032619.3341234-7-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::10) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|PH7PR12MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: ade05a37-428c-4fa3-a26e-08db9fcb3cfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BdSKf2iGSRafGbn8ZE8RhhLsEiZnYCESPu4CzV/ld5S6q0wcaX6jJM7fwNVoWF8PgWARLkXrzEt0tHEw0Yiz8ArUkIzwMUaNNqZzrU5oY6cam4wq5QVFdn0vAsNwmn50rEmjzHDE9RMDr0M4Q1fHmNFYMic8EhylWBRgRz5P6gb04XgQuDlZfFoBtJmUrYQOsHxjuM2YfkRkelel9ORnmNXr+DpJMu15caRo+odD5ENLxLXLUsdLGfPXjGMUNRb4SN6L+7rdgpVtgGNcqxEqVLpverxZBEIbaAXw+4rCMKByuCYNh1+1bMguoezS4HFLArUs1QijHtLxnNW9wgX77XZDCYG3tlXsh8SwX7fdDTmayD3Dt4s65WgWmlHKL5kVzODHsdG232iXC/x9cbI8MkTxNbSzK1K2RfWGDtuTNLkoM/Y5SHr+sUNU/hSf7Z93UOqtfnROl2lOOkbWm2J76t+2KEoKZWsJAmodnCtB+2JCQ7hHSXcsyieTulzskpjSzMHcgtxreq9aklx4X0Yiun3WFXTW9iIDZl9CG+oe48Q0ggagOt9QWG4wXEtN03RzRhHkMOqHdIlwQLVLuAjNwLAdPsEMyl7eSLjQxzdyWYD7CXnc3ouqlgBYCq26L1C/IL+wzKTLK0Ul9m7bjrZZC4xwOLdvNrR+Sedf2gs2O3b1xaJn73cdcvdVPb06DEHv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199024)(1800799009)(186009)(31686004)(86362001)(31696002)(36756003)(38100700002)(921005)(2616005)(5660300002)(66556008)(478600001)(6506007)(66946007)(66476007)(53546011)(6666004)(6486002)(316002)(26005)(6512007)(4326008)(8676002)(8936002)(41300700001)(83380400001)(7416002)(30864003)(2906002)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnRKVjZ0R1padmpaVnBnNWU1ZkVrU3ZyeXcvY0Jwdk9PVjk0NGE2V0p5WVFW?=
 =?utf-8?B?eE9QS0Nsb2Q5TU9jUWZva2loNko4TnVSZzl1S0t2ZllWNjFiOHdNdzFiTDhh?=
 =?utf-8?B?SXMxQ01tWFYza3oyM3RtMXgxSmlxR210TEtxYVpBUEVXbmN0Mld5NG51TGI5?=
 =?utf-8?B?WHFEK1ViU1VtakpOZytBZ3FKUWl1TVZ2cnZOU0lxdmlsRnA0WU1SOEQ3ZHlI?=
 =?utf-8?B?bVliakFTdFJZWEhEUDZpa042NU9KN1Q3QUF2a0JDa0V6RjRGN1MyNXF3M3Vn?=
 =?utf-8?B?MUpmdU0zUkU4Wk0rL283WlE5eXpXNmdPc29oeTdyaEQrZ0lXaVdpSHoyREQ4?=
 =?utf-8?B?bkdYMVAxcmc3NzNTU3RURVZTNTN4NHo5endtV0JHcGl0YTlHMTNhd2QvdGdj?=
 =?utf-8?B?bzhrblp5c3M4ME10U25WbTRBUFpiN3ZZYUpDRWt6YnVCTlIvc3c2aHBNUG1I?=
 =?utf-8?B?TzYzUE10RjJsYnh3RnBhY1VLNjBnYlBpM09USnFNWTNnWWxQa0RrNFluUGVn?=
 =?utf-8?B?WGxLOVc2QVVLUmV3ZnVjUHlYZU1Jd3c5Q1VPZWVvTGhId012ZHErbElIcWRk?=
 =?utf-8?B?Qi9xT3oxZStCSXdGbEhjNWR5VTJkd0RJT1NwVDl6YklMUExHQ0c2OVc3TEZC?=
 =?utf-8?B?N1BlclRPbkl1ZCtocU8xKzRpbnBiMC81dlNXOWVvR290SU42VmtPbFB5T2hV?=
 =?utf-8?B?TVJWQVFpWFBYMVI0VnFaQ2F6TWRtcmV5OUhXZ09DaTNnVXh5QzA3d0gxcVJv?=
 =?utf-8?B?ZXJFaFZycVBpYmtYd0xySTBMWld2S2lKSmdsZE1JRzArVmRQRVk0WThKNGwv?=
 =?utf-8?B?eUt4UUlCSk5meUhVVVBQY3Fub1c3RU1MY2xjSS9XaitlQlk1ei9KRTJrVmVD?=
 =?utf-8?B?T1V0dzFRM3pIc0s0TnVuU09NejRQUVFnaGJiNGE0Q3c0SExlTzhVcVd4NXNx?=
 =?utf-8?B?cFZXeDZHamwwYllCZDhQSjdWWEsvM1lFMUM4Yk01UmdJRDc0OFZ3NnNCOWRN?=
 =?utf-8?B?Q1A5eU1wdWcvL1kybHNFUS9hK0NKTUR0ekJQc1R2ZGx2Zno1VmtxUVRSVU1h?=
 =?utf-8?B?WVpjWnI1QlFtYStxS294cUE3SWVnOGxwdnZqdzA1eTM0elFtazkrczNPN1do?=
 =?utf-8?B?dndDTHRjSTZDMVlOOTkxL1Fzc2o2TTJvVTcyNUY3OUc1N29Daldjd25hNFRk?=
 =?utf-8?B?b3lreVNDWFV4SGl6U29PVnZWYzJDTmlNMkRlZDV5NGg4UjFQSUd6V2tGQjFP?=
 =?utf-8?B?bkY5VlQ4bk5rcloraFNzRUU4NDE2cHR6aklHYmFyZi9rOHMxK2RhRkM4dWJF?=
 =?utf-8?B?VFY0NHNoeGtMd3VFQ0Q4Zjg5SnRNU0p4YS90TGlGa1dDS2hlZXM2RHVhS09U?=
 =?utf-8?B?RlpEVFY5UlljVFJVYVNBc004RUJhTVdoUkozeHRjRVJHYzcwR2pTYyttU2hm?=
 =?utf-8?B?N1plS0VWdXZ2dVFzbnc4UkFWdzJmajhmeCtOL0tCemFMRXU3b0xSMHowbC9G?=
 =?utf-8?B?ZG1hWmFXODNYUDU1TC8vL01CU1czQzJ2ZnlpS2ozTGdWYUFhL0VEK3laWHZV?=
 =?utf-8?B?Q2dHME9WMUZaV3A2TTk5T0R4OG4zemxQT3FPUUVibnBzSjcvRGl3WmdwVVV4?=
 =?utf-8?B?NXFKN3ZvRkdqaCtMb1BNRU9PNnUvQ0F0UDZOQy9iVnJabk1GN3lGT2pJRit1?=
 =?utf-8?B?NmNjSHJrNmJ3RXo1UFlQcU9SN0dVTmVVWW53eFc5Y3lsajFNV3FEdVplbnVE?=
 =?utf-8?B?Y1l5aEdXUFFkVDNMMnByMXNOQ2xHWFQvc0lRV2xMdWQxaG1UcHdSOFJNc1Ra?=
 =?utf-8?B?cmM4U080Tjh0cVN1VXF6bk1JczBYVXJqYklpUVBmVjlta0ZrbWZiT0JtL3k2?=
 =?utf-8?B?Mkd4VlFSVkczQUNpTDhmazZVZUFWZWlReUd0US9CdFE3UDUwckpKbXNjUmQ1?=
 =?utf-8?B?VFlnREp6UU1CSHlscmpTR0JTd25KVnYzWjBEazFZT244b2dGb053LzRrY2t3?=
 =?utf-8?B?bG93MkJUVjhIb0VsaEN6dWRHeWxHYnBxWnh5RzZLblZrakJ3VElkSWpqb2Q4?=
 =?utf-8?B?aUxFZlRvMEdFQldxYmtHQldZNnJHWXRqeG9UQnMxNVViWXRxRnJoVnRQaFVJ?=
 =?utf-8?Q?bAG6ogY2clChxSpJLu5RkW6pw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade05a37-428c-4fa3-a26e-08db9fcb3cfa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 09:12:25.4891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qr+YpVB3sT3EUp74UszMp164YQrnz4WCLc03Eln02DK+vC+lNgTMopAZ19cQQwdl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5950
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
> With WBRF feature supported, as a driver responding to the frequencies,
> amdgpu driver is able to do shadow pstate switching to mitigate possible
> interference(between its (G-)DDR memory clocks and local radio module
> frequency bands used by Wifi 6/6e/7).
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> --
> v1->v2:
>    - update the prompt for feature support(Lijo)
> v8->v9:
>    - update parameter document for smu_wbrf_event_handler(Simon)
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  17 ++
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 194 ++++++++++++++++++
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  23 +++
>   drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   3 +
>   5 files changed, 239 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index a3b86b86dc47..2bfc9111ab00 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -247,6 +247,8 @@ extern int amdgpu_sg_display;
>   
>   extern int amdgpu_user_partt_mode;
>   
> +extern int amdgpu_wbrf;
> +
>   #define AMDGPU_VM_MAX_NUM_CTX			4096
>   #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
>   #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 0593ef8fe0a6..1c574bd3b60d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -195,6 +195,7 @@ int amdgpu_use_xgmi_p2p = 1;
>   int amdgpu_vcnfw_log;
>   int amdgpu_sg_display = -1; /* auto */
>   int amdgpu_user_partt_mode = AMDGPU_AUTO_COMPUTE_PARTITION_MODE;
> +int amdgpu_wbrf = -1;
>   
>   static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
>   
> @@ -981,6 +982,22 @@ module_param_named(user_partt_mode, amdgpu_user_partt_mode, uint, 0444);
>   module_param(enforce_isolation, bool, 0444);
>   MODULE_PARM_DESC(enforce_isolation, "enforce process isolation between graphics and compute . enforce_isolation = on");
>   
> +/**
> + * DOC: wbrf (int)
> + * Enable Wifi RFI interference mitigation feature.
> + * Due to electrical and mechanical constraints there may be likely interference of
> + * relatively high-powered harmonics of the (G-)DDR memory clocks with local radio
> + * module frequency bands used by Wifi 6/6e/7. To mitigate the possible RFI interference,
> + * with this feature enabled, PMFW will use either “shadowed P-State” or “P-State” based
> + * on active list of frequencies in-use (to be avoided) as part of initial setting or
> + * P-state transition. However, there may be potential performance impact with this
> + * feature enabled.
> + * (0 = disabled, 1 = enabled, -1 = auto (default setting, will be enabled if supported))
> + */
> +MODULE_PARM_DESC(wbrf,
> +	"Enable Wifi RFI interference mitigation (0 = disabled, 1 = enabled, -1 = auto(default)");
> +module_param_named(wbrf, amdgpu_wbrf, int, 0444);
> +
>   /* These devices are not supported by amdgpu.
>    * They are supported by the mach64, r128, radeon drivers
>    */
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index ce41a8309582..704442ce1da3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1228,6 +1228,173 @@ static int smu_get_thermal_temperature_range(struct smu_context *smu)
>   	return ret;
>   }
>   
> +/**
> + * smu_wbrf_handle_exclusion_ranges - consume the wbrf exclusion ranges
> + *
> + * @smu: smu_context pointer
> + *
> + * Retrieve the wbrf exclusion ranges and send them to PMFW for proper handling.
> + * Returns 0 on success, error on failure.
> + */
> +static int smu_wbrf_handle_exclusion_ranges(struct smu_context *smu)
> +{
> +	struct wbrf_ranges_out wbrf_exclusion = {0};
> +	struct exclusion_range *wifi_bands = wbrf_exclusion.band_list;
> +	struct amdgpu_device *adev = smu->adev;
> +	uint64_t start, end;
> +	int ret, i, j;
> +
> +	ret = wbrf_retrieve_exclusions(adev->dev, &wbrf_exclusion);
> +	if (ret) {
> +		dev_err(adev->dev, "Failed to retrieve exclusion ranges!\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * The exclusion ranges array we got might be filled with holes and duplicate
> +	 * entries. For example:
> +	 * {(2400, 2500), (0, 0), (6882, 6962), (2400, 2500), (0, 0), (6117, 6189), (0, 0)...}
> +	 * We need to do some sortups to eliminate those holes and duplicate entries.
> +	 * Expected output: {(2400, 2500), (6117, 6189), (6882, 6962), (0, 0)...}
> +	 */
> +	for (i = 0; i < MAX_NUM_OF_WBRF_RANGES; i++) {
> +		start = wifi_bands[i].start;
> +		end = wifi_bands[i].end;
> +
> +		/* get the last valid entry to fill the intermediate hole */
> +		if (!start && !end) {
> +			for (j = MAX_NUM_OF_WBRF_RANGES - 1; j > i; j--)
> +				if (wifi_bands[j].start &&
> +				    wifi_bands[j].end)
> +					break;
> +
> +			if (j > i) {
> +				wifi_bands[i].start = wifi_bands[j].start;
> +				wifi_bands[i].end = wifi_bands[j].end;

Since the last value is now 0, one way to optimize is to keep max as j 
-1 for the next iteration.

> +				wifi_bands[j].start = 0;
> +				wifi_bands[j].end = 0;
> +			}
> +
> +			continue;

If continued at this point, it won't eliminate all duplicates.

Example:
(2000,2100)(0,0)(1100,1200)(0, 0)(2500,2600)(3000,3200)(1100,1200)

Once it places (1100,1200) at index 1, it will continue the loop and 
then it skips duplicate entry at index 2.

Once replaced, you may assign the new start/end
	start = wifi_bands[i].start = wifi_bands[j].start;
	end= wifi_bands[i].end = wifi_bands[j].end;

and then proceed to the duplicate entries scan loop below.

> +		}
> +
> +		/* eliminate duplicate entries */
> +		for (j = i + 1; j < MAX_NUM_OF_WBRF_RANGES; j++) {
> +			if ((wifi_bands[j].start == start) &&
> +			     (wifi_bands[j].end == end)) {
> +				wifi_bands[j].start = 0;
> +				wifi_bands[j].end = 0;
> +				continue;

I think this'continue' is not required.

Thanks,
Lijo

> +			}
> +		}
> +	}
> +
> +	/* Send the sorted wifi_bands to PMFW */
> +	ret = smu_set_wbrf_exclusion_ranges(smu, wifi_bands);
> +	/* Give it another chance */
> +	if (unlikely(ret == -EBUSY)) {
> +		mdelay(5);
> +		ret = smu_set_wbrf_exclusion_ranges(smu, wifi_bands);
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * smu_wbrf_event_handler - handle notify events
> + *
> + * @nb: notifier block
> + * @action: event type
> + * @_arg: event data
> + *
> + * Calls relevant amdgpu function in response to wbrf event
> + * notification from kernel.
> + */
> +static int smu_wbrf_event_handler(struct notifier_block *nb,
> +				  unsigned long action, void *_arg)
> +{
> +	struct smu_context *smu = container_of(nb, struct smu_context,
> +					       wbrf_notifier);
> +
> +	switch (action) {
> +	case WBRF_CHANGED:
> +		smu_wbrf_handle_exclusion_ranges(smu);
> +		break;
> +	default:
> +		return NOTIFY_DONE;
> +	};
> +
> +	return NOTIFY_OK;
> +}
> +
> +/**
> + * smu_wbrf_support_check - check wbrf support
> + *
> + * @smu: smu_context pointer
> + *
> + * Verifies the ACPI interface whether wbrf is supported.
> + */
> +static void smu_wbrf_support_check(struct smu_context *smu)
> +{
> +	struct amdgpu_device *adev = smu->adev;
> +
> +	smu->wbrf_supported = smu_is_asic_wbrf_supported(smu) &&
> +			      !!amdgpu_wbrf &&
> +			      wbrf_supported_consumer(adev->dev);
> +
> +	if (smu->wbrf_supported)
> +		dev_info(adev->dev, "RF interference mitigation is supported\n");
> +}
> +
> +/**
> + * smu_wbrf_init - init driver wbrf support
> + *
> + * @smu: smu_context pointer
> + *
> + * Verifies the AMD ACPI interfaces and registers with the wbrf
> + * notifier chain if wbrf feature is supported.
> + * Returns 0 on success, error on failure.
> + */
> +static int smu_wbrf_init(struct smu_context *smu)
> +{
> +	struct amdgpu_device *adev = smu->adev;
> +	int ret;
> +
> +	if (!smu->wbrf_supported)
> +		return 0;
> +
> +	smu->wbrf_notifier.notifier_call = smu_wbrf_event_handler;
> +	ret = wbrf_register_notifier(&smu->wbrf_notifier);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Some wifiband exclusion ranges may be already there
> +	 * before our driver loaded. To make sure our driver
> +	 * is awared of those exclusion ranges.
> +	 */
> +	ret = smu_wbrf_handle_exclusion_ranges(smu);
> +	if (ret)
> +		dev_err(adev->dev, "Failed to handle wbrf exclusion ranges\n");
> +
> +	return ret;
> +}
> +
> +/**
> + * smu_wbrf_fini - tear down driver wbrf support
> + *
> + * @smu: smu_context pointer
> + *
> + * Unregisters with the wbrf notifier chain.
> + */
> +static void smu_wbrf_fini(struct smu_context *smu)
> +{
> +	if (!smu->wbrf_supported)
> +		return;
> +
> +	wbrf_unregister_notifier(&smu->wbrf_notifier);
> +}
> +
>   static int smu_smc_hw_setup(struct smu_context *smu)
>   {
>   	struct smu_feature *feature = &smu->smu_feature;
> @@ -1320,6 +1487,15 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>   	if (ret)
>   		return ret;
>   
> +	/* Enable UclkShadow on wbrf supported */
> +	if (smu->wbrf_supported) {
> +		ret = smu_enable_uclk_shadow(smu, true);
> +		if (ret) {
> +			dev_err(adev->dev, "Failed to enable UclkShadow feature to support wbrf!\n");
> +			return ret;
> +		}
> +	}
> +
>   	/*
>   	 * With SCPM enabled, these actions(and relevant messages) are
>   	 * not needed and permitted.
> @@ -1416,6 +1592,15 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>   	 */
>   	ret = smu_set_min_dcef_deep_sleep(smu,
>   					  smu->smu_table.boot_values.dcefclk / 100);
> +	if (ret) {
> +		dev_err(adev->dev, "Error setting min deepsleep dcefclk\n");
> +		return ret;
> +	}
> +
> +	/* Init wbrf support. Properly setup the notifier */
> +	ret = smu_wbrf_init(smu);
> +	if (ret)
> +		dev_err(adev->dev, "Error during wbrf init call\n");
>   
>   	return ret;
>   }
> @@ -1471,6 +1656,13 @@ static int smu_hw_init(void *handle)
>   		return ret;
>   	}
>   
> +	/*
> +	 * Check whether wbrf is supported. This needs to be done
> +	 * before SMU setup starts since part of SMU configuration
> +	 * relies on this.
> +	 */
> +	smu_wbrf_support_check(smu);
> +
>   	if (smu->is_apu) {
>   		ret = smu_set_gfx_imu_enable(smu);
>   		if (ret)
> @@ -1623,6 +1815,8 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
>   	struct amdgpu_device *adev = smu->adev;
>   	int ret = 0;
>   
> +	smu_wbrf_fini(smu);
> +
>   	cancel_work_sync(&smu->throttling_logging_work);
>   	cancel_work_sync(&smu->interrupt_work);
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 6e2069dcb6b9..244297979f92 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -22,6 +22,8 @@
>   #ifndef __AMDGPU_SMU_H__
>   #define __AMDGPU_SMU_H__
>   
> +#include <linux/wbrf.h>
> +
>   #include "amdgpu.h"
>   #include "kgd_pp_interface.h"
>   #include "dm_pp_interface.h"
> @@ -575,6 +577,10 @@ struct smu_context
>   	u32 debug_resp_reg;
>   
>   	struct delayed_work		swctf_delayed_work;
> +
> +	/* data structures for wbrf feature support */
> +	bool				wbrf_supported;
> +	struct notifier_block		wbrf_notifier;
>   };
>   
>   struct i2c_adapter;
> @@ -1356,6 +1362,23 @@ struct pptable_funcs {
>   	 * @init_pptable_microcode: Prepare the pptable microcode to upload via PSP
>   	 */
>   	int (*init_pptable_microcode)(struct smu_context *smu);
> +
> +	/**
> +	 * @is_asic_wbrf_supported: check whether PMFW supports the wbrf feature
> +	 */
> +	bool (*is_asic_wbrf_supported)(struct smu_context *smu);
> +
> +	/**
> +	 * @enable_uclk_shadow: Enable the uclk shadow feature on wbrf supported
> +	 */
> +	int (*enable_uclk_shadow)(struct smu_context *smu,
> +				  bool enablement);
> +
> +	/**
> +	 * @set_wbrf_exclusion_ranges: notify SMU the wifi bands occupied
> +	 */
> +	int (*set_wbrf_exclusion_ranges)(struct smu_context *smu,
> +					 struct exclusion_range *exclusion_ranges);
>   };
>   
>   typedef enum {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> index ceb13c838067..67d7495ab49e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> @@ -97,6 +97,9 @@
>   #define smu_get_default_config_table_settings(smu, config_table)	smu_ppt_funcs(get_default_config_table_settings, -EOPNOTSUPP, smu, config_table)
>   #define smu_set_config_table(smu, config_table)				smu_ppt_funcs(set_config_table, -EOPNOTSUPP, smu, config_table)
>   #define smu_init_pptable_microcode(smu)					smu_ppt_funcs(init_pptable_microcode, 0, smu)
> +#define smu_is_asic_wbrf_supported(smu)					smu_ppt_funcs(is_asic_wbrf_supported, false, smu)
> +#define smu_enable_uclk_shadow(smu, enablement)				smu_ppt_funcs(enable_uclk_shadow, 0, smu, enablement)
> +#define smu_set_wbrf_exclusion_ranges(smu, exclusion_ranges)		smu_ppt_funcs(set_wbrf_exclusion_ranges, -EOPNOTSUPP, smu, exclusion_ranges)
>   
>   #endif
>   #endif
