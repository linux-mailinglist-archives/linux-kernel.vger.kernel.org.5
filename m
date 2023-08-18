Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2877808F2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359364AbjHRJt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359355AbjHRJtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:49:36 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E896E2722;
        Fri, 18 Aug 2023 02:49:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6FjMixxk0UA+KPUCdTOfe/+qGquTpsdoTtSxVbu9O7HoULd1Ces//2eovYmXIZElb5o1pOwS9nI0eCOZfRbMIgFhUNFYqqHx5U/uKBJ8WSgL0NwTPuojQ7035P/03jC4Sks53kxiQ8Js1C90T03Pg6WaZ1LxO7O5mhv6JFbCp3j0H7+m9EGF2vr0bGx6YLPujss5jtbpHqu/yk5B0Vyate089N5ZMzkKAKAf/zT5kmgm3E1o3hnDnQhYwNpEgC/DKBXi6GAXDVkR3xVtEHdcWg2n1u8Ec9mugYOcQFNsHsLUeCUgj1mg6YLgDxoKdZhhNtfPEu+UNJLt4W8v1v0BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJkh7d1lCZPHrPlNapQS+f/mBXq2v3myFT58UiVEfc4=;
 b=XuxqTvaxLxCNIHI6x256QHw09xqIPBTaN9cuipT/Xcp1LJ2dPCCSZH5tx9r+bWEqNaHQyV9PaNAQ/bbej55qKfIxzNIQ0k0O2m4Us3ZvZmd32sXgFKd6fmaABKVLaN6ne62mdRad2PML05zChXDZK+chpIpC+vQHY0tgypV6k/Q4/kWotUb/tLFuWgIQNcj+deli3vpnUR5AE2cPwjYV8iC4NxInClmJev0QQYm0aPYqI/DPvAHhjyNuHckqNmfIu/fNEjl3fHMD81E1GercA3x5BCutchEmw2ct3mqb+6pcVAigp2+r5ZMM9mFyRNvhssDq+E/CruNJE10qLSKFSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJkh7d1lCZPHrPlNapQS+f/mBXq2v3myFT58UiVEfc4=;
 b=ldBXYKbIT88UehQc8lkWZt5XMeOcOfmuqXt2PQI8OvwB1CrUtv8+rP4/7XG8BFaB6GXKd4nfxv0f+DQumDwrKegyFfbi5oGRUou+WWZp2GhreXE6u6UT7NhNlBw5ag76vv0V6GemldJTpF8V6pr4VSD0IfmnhDr0j3bCfLVWiCc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS0PR12MB7534.namprd12.prod.outlook.com (2603:10b6:8:139::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 09:49:31 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0%5]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 09:49:31 +0000
Message-ID: <42901855-c620-e08d-f0b6-6dcb03eb9ba0@amd.com>
Date:   Fri, 18 Aug 2023 15:19:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [V9 7/9] drm/amd/pm: add flood detection for wbrf events
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
 <20230818032619.3341234-8-evan.quan@amd.com>
From:   "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230818032619.3341234-8-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0188.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::11) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DS0PR12MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: 1748a8c7-7418-46e4-636a-08db9fd06b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K9iGHezfCPae9F//chsKpEUY77/FnLAOq85RXLadj6eA8p8BHt5yYEGxLbv2rIKpWiBSLh/XrTXtNIx31I+iXs5Gb2dURTKQ8YpB0KPq7MR6Z+N2SVBKzpIbO+Bp6Xv3tEmmryAYeqsRuy4/TLi0j+g7/PHzaqwtpmQT57lnCH1olYnDE0RpuWFjZfbIYlzqjXsvaPgFlW5ocMdznY15e07y9IYwxIKMUYDV3m1Rf1Cd1B9fO6JujvurQAUrGt+CwlzyZhbcLFTpkHiO3j7yEenRQTxUS0afrokpg2e6sU71CzPijCGu2LhcZTo4XDzzSFVhU6CiMTX6A8RpWkgALFk2A2uqjDTzNL5xufbEq9zX0XUCR5c6qgky9ChK8QcgbRI6QIuZ2aP0sFDj1NIHBYinGDjr35V6BnccJO41dJuEAT8BWk0oapcpElxLuZGup6HV0W5nVHE8NhPudxvbUJj+lyNVuhi1eNGPKbI6hcLW7gGmAozhqRjPnvtuSrZVOMGj0nsmvXZ3Q0jxVVzHhhivrhht1pXEAoJlI+Qx74PF2RFtED3hmTntqyOKerdZD4Ngg/Q+iYJI7Abjfsf5CCmaJdchopTN+P8IWBWiuFBIV4GD1cfNYN5Zx4GdmrXSDi+SmzQLqemtjgtrvx7YFn6ilEDibGULSwoGjxAFPPA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(376002)(396003)(186009)(1800799009)(451199024)(6666004)(6486002)(6506007)(38100700002)(6512007)(53546011)(86362001)(31696002)(26005)(83380400001)(36756003)(921005)(2616005)(2906002)(66946007)(66476007)(66556008)(316002)(41300700001)(5660300002)(7416002)(31686004)(8676002)(4326008)(8936002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFlTcTFmRjVWVEhQZTZFSGNJbG5UUitYNjdIVENDSnVYVTZoZ1o2SDArL0ZY?=
 =?utf-8?B?Ym9GMWlTcGxqNlBFV2FVb0VBb05pWjdXV00rRHljV1p0VlVpUDVldXdleHlk?=
 =?utf-8?B?Snl1R2U0NWE1ejlPdEF5b2ZwNHdOTitnZ0pNUGhpTXVWK0tvYlBjaWtxYTZa?=
 =?utf-8?B?emEzeVNjL2dkNHJydVpNN0RyMVpMaHF6a0EycTJsSyt4NWZuRXQ0SFdYS1Mv?=
 =?utf-8?B?eDhBaWRDVXBib05uMmVPMWV2aDFGM09hQ0t2L1FaOWtnakEzNkI2TXQzTEoy?=
 =?utf-8?B?VHNnVkJZVFlkV0p6emI5ckJQVFQrQmMzZmVQTlZaK0Vuc3Y2c2hWbDN3NWxB?=
 =?utf-8?B?UytaNk9jdmQ0bWR1dllwTC9HNCtpVnEzUnY1dzdCTWpqKzdKWmR1Ykt4N3Jq?=
 =?utf-8?B?b1NBYWhIRTIzNjN6TmtkckZsZDc0QTJCL0prQXlpdk1KdGVmalZaSHZSRSt3?=
 =?utf-8?B?THBqbXBvS0U0SElCSFZMRUFFQ0dORXFPbHl0UFpFeDZQQ0ZvOEhYT1piNzQ0?=
 =?utf-8?B?RndCU3k1emFxdjBVTk5zSkV1eVUvc0pxdzRocDYvZllZdGU2OW5WTnVTY2pz?=
 =?utf-8?B?NUZoVGV0bWdNZndxeFp0ME5jU2V2VGJnRm8yYk1XT1ByNTdsaTFPczF0Y3hU?=
 =?utf-8?B?dTJidTg0bnpnQk5ROXU1SHhJWU1CYjJIRGc1WEFBVVF5SGUrckdGQUFlSlRS?=
 =?utf-8?B?NHJSNlExMXNYMkYzNXZabFJjbVRiV0lRZlV0bHozRmJSM041d1RBRElFMWEz?=
 =?utf-8?B?U0xidlFVR1NaWitFVVNnaDJvVkd1ODQvN3RZQ25MVWRzMCtTS29XdW9EcDFI?=
 =?utf-8?B?cXpBbXVRMUxHUXpDcTNLTEN6dzN4Nm9YREhtVHpsenJwajErUzBMRXB1VGtG?=
 =?utf-8?B?T3NaM1JCdStaYUpKTWo0U1dsM2RWK2RwTGdUeFBodVJhdjFlS0pwc2dBMEoy?=
 =?utf-8?B?Tnp4aTZOd3NRS29ROFNlSmdMSDNhR2hWTkxMQzRWRHlnZmVtc0pJVmlvZ2lS?=
 =?utf-8?B?WFhiTHFGd3hodHA3Y29EZjRramJqTFJqelFxQkdCWG9nQXJYaURSNGJhY1hX?=
 =?utf-8?B?UmlzaWNKYWoxbnhSa2M2MDZJZkw0ekNjZjJGY1MwOHo1MHF4TmxuYnZYUmxz?=
 =?utf-8?B?SnNQSkpQc21nVVlja2l5KzVEbW81Z2ZxYU5QYWxPeVM4NDMwWGI3VVpQc1Vp?=
 =?utf-8?B?Yyt5M0g2WHYxVWJrcWJTVE9reDdUYVR6emxCajR2NnpuTHBaN2FjenFRb2U2?=
 =?utf-8?B?ZjRsSEFUalZxQWdvbkwvSjdWY29URU92NmRHWmlVcjg4US9yakVoblRoQ1F2?=
 =?utf-8?B?NEVLQUczbE96b0RhbWtNQmFIMFYyUHBlc25mT2pVRlFKdnA0bXVtSDkzVTJq?=
 =?utf-8?B?RHZpbmZyemxiaDRad3hRaGJEVzEwbGxoZU96cVVUM0s0ZEpIdXlDRXZrc0py?=
 =?utf-8?B?V3E0eEZzV3JUb1g2TTRQQ3BCbzVRZVZNakxoNUEvNTNpM0Z2NGRFeHFIVitu?=
 =?utf-8?B?dmxsUVJFZUNYQUhTSTBpeUU5WGIwcThsYWJxQVZ0bkFKZzZObGFULzJ3Qlha?=
 =?utf-8?B?Vk1NRWhuSXJCZHViYkswdTFTRisyNVgyRUlaV0VpSXVsRXh6THVQbXBlMXRp?=
 =?utf-8?B?S1RNUUpzZDNTK2laeGNKS0tUaUFObzBBdmQ3YVRQMTZ2NzVKOTF0WVZiU3Jk?=
 =?utf-8?B?QXU4YjJ2Qml3WFZEdVJlc3Rzc0xmVXNua1lrMElybzVYSkxkbGxiSHgyQndZ?=
 =?utf-8?B?dlRlMmtLMXREL3RveTJOemZicjZIVDZQMEcxWkdXdVJiRDRkRkFJSEZGbHZF?=
 =?utf-8?B?UXRZbmMxVy85UktpUlpGZDU3V0NCM1dCTnRkejlyK0FHTjNxeU9tZFRjaHZ4?=
 =?utf-8?B?cXdQemxEaUxUOEZBd21WYyswMlk4ejBURGFKMmJrUC9jNDVYTllocnVHc0xq?=
 =?utf-8?B?U3NEZXpFSGFrV21WbEhjTGpZdlNWcW85Q3pNQlUrZHVKOWNYYlh5Rzc5MkQz?=
 =?utf-8?B?bHlxcHNDa1ZUNC9jMFRxMXBDKzJtOHdmQWtza0syeXFtbUJZMmtuMFpFaFZ2?=
 =?utf-8?B?MzdYQWhWbFFoVk1MOSt1ZEZDUkExWUVGSm9jM3JXcGRoUnlaWlBtSzBpeGlv?=
 =?utf-8?Q?s2HVS+U9O/OpHz3M6mDyc13UH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1748a8c7-7418-46e4-636a-08db9fd06b72
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 09:49:31.1347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZnwB7qmZAFMHxLTgPBa1QoYM/RjGU8MQwzvoUG1FgthF6ucVjjX7JOOJg1WlyupD
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
> To protect PMFW from being overloaded.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 31 +++++++++++++++----
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  7 +++++
>   2 files changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 704442ce1da3..6c8bcdc17a15 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1318,7 +1318,8 @@ static int smu_wbrf_event_handler(struct notifier_block *nb,
>   
>   	switch (action) {
>   	case WBRF_CHANGED:
> -		smu_wbrf_handle_exclusion_ranges(smu);
> +		schedule_delayed_work(&smu->wbrf_delayed_work,
> +				      msecs_to_jiffies(SMU_WBRF_EVENT_HANDLING_PACE));
>   		break;
>   	default:
>   		return NOTIFY_DONE;
> @@ -1327,6 +1328,21 @@ static int smu_wbrf_event_handler(struct notifier_block *nb,
>   	return NOTIFY_OK;
>   }
>   
> +/**
> + * smu_wbrf_delayed_work_handler - callback on delayed work timer expired
> + *
> + * @work: struct work_struct pointer
> + *
> + * Flood is over and driver will consume the latest exclusion ranges.
> + */
> +static void smu_wbrf_delayed_work_handler(struct work_struct *work)
> +{
> +	struct smu_context *smu =
> +		container_of(work, struct smu_context, wbrf_delayed_work.work);
> +
> +	smu_wbrf_handle_exclusion_ranges(smu);
> +}
> +
>   /**
>    * smu_wbrf_support_check - check wbrf support
>    *
> @@ -1357,12 +1373,14 @@ static void smu_wbrf_support_check(struct smu_context *smu)
>    */
>   static int smu_wbrf_init(struct smu_context *smu)
>   {
> -	struct amdgpu_device *adev = smu->adev;
>   	int ret;
>   
>   	if (!smu->wbrf_supported)
>   		return 0;
>   
> +	INIT_DELAYED_WORK(&smu->wbrf_delayed_work,
> +			  smu_wbrf_delayed_work_handler);
> +

This is one-time and can be part of sw_init.

Thanks,
Lijo

>   	smu->wbrf_notifier.notifier_call = smu_wbrf_event_handler;
>   	ret = wbrf_register_notifier(&smu->wbrf_notifier);
>   	if (ret)
> @@ -1373,11 +1391,10 @@ static int smu_wbrf_init(struct smu_context *smu)
>   	 * before our driver loaded. To make sure our driver
>   	 * is awared of those exclusion ranges.
>   	 */
> -	ret = smu_wbrf_handle_exclusion_ranges(smu);
> -	if (ret)
> -		dev_err(adev->dev, "Failed to handle wbrf exclusion ranges\n");
> +	schedule_delayed_work(&smu->wbrf_delayed_work,
> +			      msecs_to_jiffies(SMU_WBRF_EVENT_HANDLING_PACE));
>   
> -	return ret;
> +	return 0;
>   }
>   
>   /**
> @@ -1393,6 +1410,8 @@ static void smu_wbrf_fini(struct smu_context *smu)
>   		return;
>   
>   	wbrf_unregister_notifier(&smu->wbrf_notifier);
> +
> +	cancel_delayed_work_sync(&smu->wbrf_delayed_work);
>   }
>   
>   static int smu_smc_hw_setup(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 244297979f92..4d5cb1b511e5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -480,6 +480,12 @@ struct stb_context {
>   
>   #define WORKLOAD_POLICY_MAX 7
>   
> +/*
> + * Configure wbrf event handling pace as there can be only one
> + * event processed every SMU_WBRF_EVENT_HANDLING_PACE ms.
> + */
> +#define SMU_WBRF_EVENT_HANDLING_PACE	10
> +
>   struct smu_context
>   {
>   	struct amdgpu_device            *adev;
> @@ -581,6 +587,7 @@ struct smu_context
>   	/* data structures for wbrf feature support */
>   	bool				wbrf_supported;
>   	struct notifier_block		wbrf_notifier;
> +	struct delayed_work		wbrf_delayed_work;
>   };
>   
>   struct i2c_adapter;
