Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B079A792BBA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240947AbjIEQ6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350230AbjIEE7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 00:59:53 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028A5CC5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 21:59:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btyCde85eyTrHr/xMRwCHtNTk9UiTr3FoOWdm/aF2qikKN85hLr8VXrIgVvM+ew0mfFdIpgphJHgjgKX9ovWrJG2Yip3bdr01zaecq897kyIRaBzbtMjyyUPNuEhxXkutFI/BW1rDoe5/lcRTe1YMzBexXqZvY5BTEQhCITO6hUkCtcOl2rGyKRTLcEUCGJFashERiNDvUq3Lh8k1MrvRoFNqRF58bDQMMdwakOUam1KSPHzGWRa0fs424d6zTy1VzgHVY7uxDnpA3pozdKkYCeAA+qaEj3yvxYzXxBtAIqiEVQeDsDAJ4QV10KnsYc+tezS19/yW9OBVvFMPZccVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYJgreYm2BDx3Pn7mlW1MlWFcOARTpXIonVvGEAr5F0=;
 b=X0mBeqVZ7QWXA+j+sMViPGTZtAL0MmzJGarDwD28SPzn7t+I9Ic5gZG/eAuv2f0yr+bOIA1mMQYNSxZKzPAtworJOKlND1amo4FHYV/aosYoSw6/Hkd4+ogyOmT2mcKfuvSlT0QkloCTKeBexb4l7LD5cRGnQnt38XbZ/mZO7LQLZf1nok+y70MrHfLuuYeiNen9k4XDWTNJD4cfooGqWigzs2uwxdGN21VLaZJ1YjT0jLNGzMXjHix7Qijn++4TKRcRlf80uPmSopbP8+w/FU2MLpNTB6w6VSL9Qo5dbhNkfYZdYo7m5RKAnxLzsfz9ybls/0XgN5zlyMG85zPh3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYJgreYm2BDx3Pn7mlW1MlWFcOARTpXIonVvGEAr5F0=;
 b=SOdv8nKNky7pjtap8IFGvumWKBDaJ7zkqI7KqfB8yWYaJcdPskGVRkpyAsH2VkIf5ZMKt+qFq03k1+DWUklMDN+bnyzsT2eAxEbdaE1sSvM2Be8Zy40U64fxvqD5IyuVCD2sOt0F+LB0KqoqM5/cTKp+ZuWV/KkpdY9usn2LFI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS7PR12MB9042.namprd12.prod.outlook.com (2603:10b6:8:ed::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.32; Tue, 5 Sep 2023 04:59:48 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 04:59:48 +0000
Message-ID: <8be32518-ce53-744a-9fe5-9f2a33095c18@amd.com>
Date:   Tue, 5 Sep 2023 10:29:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 6/6] mm: Deprecate pasid field
Content-Language: en-US
To:     Tina Zhang <tina.zhang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230905000930.24515-1-tina.zhang@intel.com>
 <20230905000930.24515-7-tina.zhang@intel.com>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20230905000930.24515-7-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::34) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS7PR12MB9042:EE_
X-MS-Office365-Filtering-Correlation-Id: e9bd1b61-71f4-43dd-99d8-08dbadccede1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EHwog3dRxwlISPiRi6Yw5itGSFJYxHA+174GfhTNNcwYDT9pvPrbxUl404kue1wi/kap12LIaeku55cvbo1kF+bydCIDlH/jYBA9v0z+guPIQlvMudNYb8bAaFoYuyIjHcW7I+cU7DZz9siX2x9emHlxTRWfloNOKnfb3J6dyZwCKT2eH6TmO6fWtTABRF+CCahCdwhW8oRrRMGI8VUsEIDQT+elCozucSGORJdkNRQcAMTIMSjPr1kg35hArN9k/IHW3jVb2f8I9mDrP3tNL2ZFSxHWQ8U5WfXrPj8H+SjaJY0z+FXyw8r8eD9JLoNAq5q8aQyIKXNsA9dry0mWnwlZLI/Tonpy3tRnPmaKQuiXsYQebow2H7Di+5clqHTOYhiJemAhxPhvAmEwIbOOBdokw6COnrICQiOaWlJFiaBPEuxj7On1MvE9BzFZBZ6M+GwRNfFywIavEA6mHwTGoo17a/u7vPHp3L82Kb1h8Z+nYD8BmzuF4KTIyQGl6grJmr3XTaehalPaK1OgdQzX17aN2JyG3I9LDTnDYGL5CUNvc8Fl5s5iEXtqt8359z+IUNcIs43i9KDZ14ky4AWbZPwlIBzwYi9vZPDb31yTsEGndWaxrz/505SXj2mr4jnLImWrZX2OLErDndEyGOXy8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(136003)(346002)(186009)(1800799009)(451199024)(41300700001)(6506007)(6486002)(6666004)(53546011)(478600001)(83380400001)(2616005)(26005)(6512007)(38100700002)(66476007)(36756003)(2906002)(110136005)(66946007)(316002)(66556008)(86362001)(31696002)(31686004)(5660300002)(8936002)(44832011)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czI0K1EvT2haTDRyMHFKenZubU5Yb0dzQ29rOXlBcS9TRGlTdU9EQ1NVZ2lq?=
 =?utf-8?B?R1F5SlhHdWs4Y2cvMGdaNVRZNTZRZmdUeUExcXRzQUFWVjBSUXBKK1k0VHli?=
 =?utf-8?B?Z3BqVHcwcWZYSEpjRjFTMzN1dkpWSU1UbFRaWUVkbkdyaDJ6aXlNb0pOVnlp?=
 =?utf-8?B?QnNadUJLQlZCeDFZbEw2UUJPNUtLUVNJdHh0ZDdWeWV0OGFwc2FyL3FhNm5X?=
 =?utf-8?B?dmgxNHR3bnhlbnFzZkhaWjVkU1FVeDF2dnc0ZU0rZ25QelFqU1lCRG9Rd245?=
 =?utf-8?B?QjVseTZCTjhCUGxEckV0d3UzUGswRVVkc2lYOHR4WDM4ckM1SENpNGRramdZ?=
 =?utf-8?B?QlpJeUJNOG9tZWZtd1BwRE5jZGV0L1hoOWNGaVpTMC9qWWxDNGxRWmx3ZmIx?=
 =?utf-8?B?NVUxWVlJMjV2M1gwbE1sVXlxeExtVHREL1ZZVGIraHg1dE40TEV1RURtOTUy?=
 =?utf-8?B?QTcwSlczQnVzQ1ZXNjBkQ0NZNWFWd2xpbGFBMVhEM2JjNnN0b0drSmNtT0JX?=
 =?utf-8?B?MGtQYVhmeUZ1Qi9UNDRFODRJZUFYcW43Y2R6K2gzUVVCZDladGUvSStMakdZ?=
 =?utf-8?B?STdlYU5TUndUMmQxYk1MSTJ0L2VmSzdpTHR1Z21xdjVWNUFyMHI2dnRLRGM0?=
 =?utf-8?B?K0xhT0VyMDV3Ym9WQlRmdmdTaG81bUhRQVM0Q3lpdjFRdTZOV0hLZVJrdGJZ?=
 =?utf-8?B?aGlmOW11TWtPWmVvZUdQUE1jQkFwbVRkU0Rja0xXVHoxTS8yWlp0MVJsK2dE?=
 =?utf-8?B?UlRtSmhtZ3pPMS9VZUlJeEI5NnhleHVHdUFVditpUHNmdFBQWE9LbVNKU0xk?=
 =?utf-8?B?ZUdyMDZ0SU9sejR4S28wekQ5WXVRdFJRRTFUSGx2T1d5Q3lQVTNIdUczQWtG?=
 =?utf-8?B?WnVuUDZEVzRYZ0hZOWdlcXNDSnRTaFVwVDI3d2VVOEV3Y2hZOVEzV082MzZU?=
 =?utf-8?B?S1RDYXo3aHhHUytLZkI2emphZldHNzY0anNXY3U1QlBhUG0yMjBRcHJXUVBL?=
 =?utf-8?B?bHJNRE4xY2NBcmZzcEFzU2Z2MDRBK3kvNCtKZ1hSMFYyMTZQMy9LcEoyRXJG?=
 =?utf-8?B?UFdXTjl1Vm8zL2trcHZGWEpQYWxNYmJmVWtVcjd0RFJSZHB3enl5UlpETldQ?=
 =?utf-8?B?UjhuKzl6WTBRd1pnYzlqMWhQMWtMUytDaEN3TEVacFpsdk5qSWxyOHk2ZzhZ?=
 =?utf-8?B?Qlc0a1lJaEp5NlJyVUMwRVFkaERNVUdMVThCcWZoeUlyc1U4VUd2ZTl1ald2?=
 =?utf-8?B?dWQvZ2NMZjFqcEVTRllXRWNlM2d2VERTMVRud29UaGlRYkMxL1RaQlhwYzR1?=
 =?utf-8?B?VVhINXFpT0ZVODdjZEI0UndVVlMzYUFyYkxwZEd5TTV5NCt0WmF0SmQ0NTF0?=
 =?utf-8?B?djg1Yk42VElmUGJaNXdFdURhOHdOWVc0SG1SVlAxRkh0NXRERXUzYVVKN3dC?=
 =?utf-8?B?YkEyazBzdVhkditXM3prNVNkY0p5a1daU0tiNWdvc1pDeVRBc0U1Z0ZsdlFj?=
 =?utf-8?B?NlkxakFJMnI5UVZjdVplWWZiODJXTDRtNjFoRXNFcHNtRDFNQnFKVHpmZmZI?=
 =?utf-8?B?d1RGeFlEN2IvYk1pNzU5RlZJMS9oWUtCVWlpUEM1MTViMFNZWFo2c2ZIWGYv?=
 =?utf-8?B?a2RYaWtaTm1zNDlrbTM1cUFvK2RnVG1TZTRUR0psZ0tnU2tuUFlteUVxNmht?=
 =?utf-8?B?M3dVc28wd3JrNnl3REM2UVZIekNySDhNR2RtazBkSEhEUTlya3l4RG9xQUdM?=
 =?utf-8?B?NEVCa2VuMGpxUUVkUUlEOE0rTkxhS3RRUU1MdGRDTDZ5T2ZSZzFST01MLzZW?=
 =?utf-8?B?RGl1TStXdmx2dWNxZ2VUSTNYVy9xbTdmaFF3TzZIa2NqRFYrQm53MXlSTHVB?=
 =?utf-8?B?UXdnL251Vi9DZGtJRzFmMTd3RGZVbUw2cUh1clFUdWpnMEZRTWdwMXByRUFO?=
 =?utf-8?B?OUhxU1ZUMXdzVEZFekxZRmo1YlQ0cUN0SStiSTFZeS8zcnFMU05oZXhRUXg3?=
 =?utf-8?B?YmluMHJSQlg5VlJEV25udU5MN3Q1Y1Rxbmx2M2t5R2pCdVgvdS9vSVRZb3Jw?=
 =?utf-8?B?bkpQbHE2MzA1VWZpQlhXTGgyblJUL0ZKME0xd1NkQ3lhTWpPcGRYL1I2U01Z?=
 =?utf-8?Q?65tN+nxSJNxCfhrK/vlPLRndk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9bd1b61-71f4-43dd-99d8-08dbadccede1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 04:59:48.2312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZdcMzuRf9QJYLZ9V9anOvxaNSZo2N5ZJhRZvVf+6wRCrBHmKLXc+h7vS4Ddsvj1Pwnx1IvYAw+M36/zy5aej9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9042
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/5/2023 5:39 AM, Tina Zhang wrote:
> Drop the pasid field, as all the information needed for sva domain
> management has been moved to the newly added iommu_mm field.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>

Looks good to me.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant



> ---
>  include/linux/mm_types.h | 1 -
>  mm/init-mm.c             | 3 ---
>  2 files changed, 4 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index b486f521afee..fb0e4416d9d7 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -808,7 +808,6 @@ struct mm_struct {
>  		struct work_struct async_put_work;
>  
>  #ifdef CONFIG_IOMMU_SVA
> -		u32 pasid;
>  		struct iommu_mm_data *iommu_mm;
>  #endif
>  #ifdef CONFIG_KSM
> diff --git a/mm/init-mm.c b/mm/init-mm.c
> index efa97b57acfd..69719291463e 100644
> --- a/mm/init-mm.c
> +++ b/mm/init-mm.c
> @@ -42,9 +42,6 @@ struct mm_struct init_mm = {
>  #endif
>  	.user_ns	= &init_user_ns,
>  	.cpu_bitmap	= CPU_BITS_NONE,
> -#ifdef CONFIG_IOMMU_SVA
> -	.pasid		= IOMMU_PASID_INVALID,
> -#endif
>  	INIT_MM_CONTEXT(init_mm)
>  };
>  
