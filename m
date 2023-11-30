Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E8B7FE91D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 07:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344605AbjK3G22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 01:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjK3G20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 01:28:26 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0073B10C9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 22:28:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFbxMNoRoxwKoQKLGQd8vCpf1hVvln2ngBaqC6D0HcXLWaO2JSKJCmDIB6ap/nIX1GtFDSF4NcS3kWgnCF2GDkOS4dNstVi6z8xtBhkfNgRn754VIwLKkR1jJA4fbvqjipwxoHYrTTIjDSZWGILKm+yDeErq65O8/Y+8PFB+2ci101HoB9IcH8sNiqHE+hTBaltGLBH5+rNU+e3ay0ZiMWifxxUJryJMD52XS4YKokSdLPO8vXcvgDWY2+pOfOogKl+a+nIMi1eSUegNjsjj+H4gvDlra6M+EQMF0IRwrfGl+LWPPhvUhCrZfBznBvOwaufR7FTDKmcfrxWGaoIJYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjvKWx4+eS7wsvV92NeVOtswi0XrMHD+vLJ5M595waU=;
 b=duCft2zcZbEqwccWi2C43EMM7ZfTLmudfcj5ixWQqzxUEO3pWVyht/WyqguxuBUcV7dQrzlxe4imPZecoqs7hdt94SqYB7hiR5nrvgE/Ef7ZxDW/dvSCpfU3THqsTvZk4OIQultKDoNVewsqWnktV6pA3/5dfj9V0TAyVr0QcKLsJ2PSNfaIgrSITaty+pg9Q9/C+g5WSaCoFVc8ic1fBfp4+bWEbfFZX24Av4dvvJfR9tknT4zsRYrCR8VL7hLoic8Po1BV7QG2Bf0fLpJOw1RjNOQIBbhpUx7gInk+xeUPB+68nYE1AsNXlX/fTKBvpGkTvJ9I4tR8/o0pzBYKDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjvKWx4+eS7wsvV92NeVOtswi0XrMHD+vLJ5M595waU=;
 b=t0cpZiGq2ecN4NcIJzPbuy+09RpW+fdrWUh5pUt6tNjieT/WyLclIO9KS0oP96OyspCwgSTGqw3jvum+bbA8Fk+zbSLLKniuPB5GPjxOv9u79qOPm6PPceClV1sbBDmDi4/BOJzrzSXaJYijQ1i7pnk1urUvclJT+UAQHCADN7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM4PR12MB6495.namprd12.prod.outlook.com (2603:10b6:8:bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Thu, 30 Nov
 2023 06:28:24 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::cd68:8823:38b3:65bc]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::cd68:8823:38b3:65bc%3]) with mapi id 15.20.7025.022; Thu, 30 Nov 2023
 06:28:24 +0000
Message-ID: <fc2390cf-bdf9-590e-d078-4bb616d5feb6@amd.com>
Date:   Thu, 30 Nov 2023 11:58:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] perf/x86/amd: Reject branch stack for IBS events
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230602194513.1589179-1-namhyung@kernel.org>
 <c5a40920-0b14-b9b5-19ee-48c965bd12e3@amd.com> <ZV9lfJyyC7xawHBC@kernel.org>
 <3d70b52f-2042-328c-6dc7-37fcbb3510a2@amd.com> <ZWSombzfCkxHc7lC@kernel.org>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <ZWSombzfCkxHc7lC@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::20) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM4PR12MB6495:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a3792ff-a722-41a1-a453-08dbf16d8df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JftgCxSAARAEVOm4Fs0qR1b96vyH5a6oOsnfVztH/KffhIfj1xvKoJYhY+ivOmc9MVHKzrnRePUt+Ey3+lyiMEoV7P0CbsOoNDB4kAja15/YSDNA8BihZ82gnkpH97qEv5q8kR1Cm5XovG5eeQ1Oq4uAx6VJYaWyjno8h5yiIz2FZJz2hafumzW/79psndQIgu4VVBIjWnbomvClglDdoeHo7C7KtDjZzdwIBr8P/uLkrgYjGuWkSPgEp8YdMN/iboYTnWpnOOHMI60y3lid/MmfNqm21rEZ1fBRVFthPu/jT2p3wbby0i+KAUiZFoXoJl5OmobtbkVdcVk//99ODLPgqdPes9U2xAb3xuAuvsasD+y+poh4AMkdo7k1bAhkgq70PXU3QEHwnCBA/2gdtsyUZb+c4plQORPbi8EcOwRwxUiuw4BhUHdA/RkL0MDSzZh53szMHItJDyMgYV6UbQOvvSfCht5utiIVH5csgNwlyq8iYVVhep3doZzJdaLr61RS0UdlVMa8+J5AovJo0iozUBRRttlhV9fIkYTJx9LPzksApH5MfIJMOBw9kxg/wTGcDY4pe/p0V7+w2FY9vPDj6pVnu1BBNgWeVYpXsQ3cupmvEhNpRdvcx5RjgI8CETyKckIgVL39FkcBHKVTtoSfaXobKuN223bgD+HUW+EAWq4zpQXSsktzqokHIA+I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31686004)(2906002)(4744005)(44832011)(4326008)(8936002)(41300700001)(8676002)(5660300002)(202311291699003)(316002)(66946007)(6916009)(66556008)(66476007)(54906003)(6512007)(6486002)(966005)(2616005)(36756003)(6506007)(26005)(478600001)(6666004)(53546011)(86362001)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmpGNFBhaWhEb2Y0VXJVUVhKNHVRMmYxWnFiSXZpUUtrRkhnYW9Vcnd0Wm9s?=
 =?utf-8?B?Ymd1aXpMbVBjUnVjSVZudzU3TmdrVkgrbFlNaVlkbVFwQ2JvcTJCemNWblBs?=
 =?utf-8?B?MWk5QU9Gak8zUVZkdVMzU2UxdWVjRStQWUt2VnVGRHlwZFk2Qk9BUFNqVHQ5?=
 =?utf-8?B?enBDcHA0N2ZSVE1GTVNza0U5cHRtTzVlMUo5bWIraXJRenAraGtWSmFXT0tv?=
 =?utf-8?B?SDROVkg3d2hCbTgwaXdTWms3MngzUE5qZkw3S2FMdDAxYmVlZno1S3F4eW43?=
 =?utf-8?B?U2NnUE9GdzYxSEtrZk45clByOXdBd3ZHSzNvalR6YVhPYlhSN3EyU25KejIy?=
 =?utf-8?B?L1hZb2MrTUt2TjloeExPc2U2Wm0yRDh1Nkx6WlFCbVdackU4TzJHZUlnY3Jy?=
 =?utf-8?B?dENCWnJrbzRNUDhRcXN5azdTV0ZqajR1eDRpaVU3dDRuRHgweGN6WVRnNGF4?=
 =?utf-8?B?Vkc2d2JpdnUwWkNraVF5T0JRcTZYeFVodDRvNyttWWdBVTI1QUcramt5MEdP?=
 =?utf-8?B?TlVueE9LUkNxT29CWjRIRTlIUkNadk5TdzFZSTA1UEdBNWZKSmtVUFVwYXpm?=
 =?utf-8?B?K3BMTDVGR3JRbTUrSUhCOGhpZGFsbHAxc3cvWEp2L2xrT3MzYnU0U3NCWTh0?=
 =?utf-8?B?cVcxRzExd05DOVZVRHlwSWZVVXFvalRvVEhmQWJ3V0IrRzVXTGpZN3dMRXFp?=
 =?utf-8?B?VS9UOGpuUWg3YksyQUVyRkkrTzc0UDNIWnBuTTMxenN1d3ZZQ1dDZ2lYZHBY?=
 =?utf-8?B?QTl2dkxaaUpQS05KdEVhRE9BYUNZdWNqeWhSUEpIVEtIYWR3aEsvaWRlZVRr?=
 =?utf-8?B?UGdid0Rxc2VmVnljdjAvdWs0LytlYXJMV3VCZUlPVnBvdkVKaFkyVER4ZEdW?=
 =?utf-8?B?NDJMWGMxbHpFN2VtMVdISHpvZmZ5ZktkMkxGQVhqb1RsNW5JYlU4S0VRMWlm?=
 =?utf-8?B?MjBmV0RYS3FrMHMyZjgwME5uUnFsVUY4TDVvQmxGSXJrcnNiMXoxbHMvT1Fa?=
 =?utf-8?B?U1MvZlpoS0FmUHhnTXRVUk8zcERYczhXSG1yTnZmYjFPUGNwNzBBVmdoZHYw?=
 =?utf-8?B?a011WlVBdEMrTnlwVDNkczY2TmJ2UHlLcm44YWwyN2JVWk9LKzNWcThuam5J?=
 =?utf-8?B?YmlTczlFVnVDVEErU3VEbjVMUFZHYnY0ZGVWcjkvVWs3dlIvODJmang3cmlz?=
 =?utf-8?B?WVQrQThRTi9oMXpScFJONng2VEI0WndFbFpTZDdtamgwTmZ2RkcvT3FEeG0y?=
 =?utf-8?B?b2lKVXhZL0c2OTZPZGZ1V1pLK1ZKUSttdFpKT3NtQnNuYUpNYnc5MFVqVlZq?=
 =?utf-8?B?MktPNmI5K2tQaUZ6NWl4ZzF1a3FwQ1lHc3BaUFBwa3ozVmJCZHMwYTc1SlZT?=
 =?utf-8?B?UHBWV2ZRdXNuZ1lIVUxEejFKWjM4djI1cm50RkRraVV1V1IrYytWNUxsbklo?=
 =?utf-8?B?YVhOTE10MEJHVmErcFJxSmNpOGUxRFowdDluWE9PeVVxRkl3ZlZFazJ4bVhX?=
 =?utf-8?B?N01rUFVTYjFvaTZMUExKM01mS3c2dVMvRldIWldBZ0RweTNHQUg0cGZUOVJv?=
 =?utf-8?B?aXBuUGhtbWxOSFlLbTJER0NMdDNZeU9uZVVzVUNZaEVmbDJkT0gzWVBqYUsy?=
 =?utf-8?B?ckN1SVk0RWt1b2prUUtldTJJZG5GVzdxV1RlMFEweDhKd3VvS3pJbHBMVDVQ?=
 =?utf-8?B?V0lybkYzWlY3M2hoRWwxMFNZZ1lMa0ZqWnBHdjR5VlYxNXB0QXdkTGlWNVdv?=
 =?utf-8?B?QjUzU1dVZEFXOENrd3hhODFMaWg1VEVHQjJMQ205TGUxeXNseGJWZExFRUpC?=
 =?utf-8?B?TkVhZ0xZYnY2QS9leTBObEpzQlp5Y3IzR1RiTC9aVFhzQkFhdnpucExPZ2Yw?=
 =?utf-8?B?OHkxN3YrMmZtd0ovRXJkSVVxUG9WeUttc2YzVDhWblhaemNxdlhRS21FSXM5?=
 =?utf-8?B?dXNVS2ZyRVZTa0NMS1pMcWJHakhTYWV6K2I4YVRvZlF0cGQ1eXlXTkRha3Aw?=
 =?utf-8?B?azBxVTAzcUhFYThmNWpPSXJpYmVmc1RvVTBqaStPa3lXcjBrekxNR2lhcUJ6?=
 =?utf-8?B?S2cvWGdveG5PdFViUTdGYzVRV2RnckZ4VWJGeEVzSTVnaHphblZ3UGM3TE8y?=
 =?utf-8?Q?+h04QYvuq6lbyydznSLVNnT1h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3792ff-a722-41a1-a453-08dbf16d8df1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 06:28:24.1809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uv9xUfP0ZdECbvCI8VgTlXJWRg4Uakbefoi4bVgoF5AYGfrjc0eI4KJSq8SfwBUdRca6/bRSRo5x4pw7OmT0lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6495
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-Nov-23 8:02 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Nov 24, 2023 at 09:30:37AM +0530, Ravi Bangoria escreveu:
>> On 23-Nov-23 8:15 PM, Arnaldo Carvalho de Melo wrote:
>>> Em Tue, Jun 06, 2023 at 10:08:43AM +0530, Ravi Bangoria escreveu:
>>>> On 03-Jun-23 1:15 AM, Namhyung Kim wrote:
>>>>> The AMD IBS PMU doesn't handle branch stacks, so it should not accept
>>>>> events with brstack.
>>>>>
>>>>> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
>>>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>>>
>>>> Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
>>>
>>> It seems this patch was not merged, can you please check?
>>
>> Right. And it does not apply cleanly on peterz/queue.git/perf/core, since
>> surrounding code has changed.
> 
> Can you please refresh it if PeterZ has nothing against?

Posted v2: https://lore.kernel.org/r/20231130062246.290-1-ravi.bangoria@amd.com 

Thanks.
