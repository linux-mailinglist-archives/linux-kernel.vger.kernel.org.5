Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87301778537
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 04:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjHKCDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 22:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjHKCD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 22:03:29 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E479E2D55
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 19:03:28 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37B1qXri031997;
        Thu, 10 Aug 2023 19:02:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=message-id:date:subject:to:cc:references:from:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=j1O4Lu6dl4MARL/Ol4z24CWjxPN9z9MlG9mbSkLtOJo=; b=
        Da7qx38MtSjS2BDZXTviPXPAxwd2W1wMXFOeR/9d9dkHKyn6lEcoee2IRNkIy75j
        wXv3e/8wLW5pnCIiHKhYPWjcqNRJpetUKFmU2P1sZ2a3FlefEKzflA8GLL/Ad+HL
        e6+WFLw0Bgmp1MYD01d8VSGXVrBAK8vYiCvwIRQrGW7GOrz03AwLfnPDB/Knk8Xo
        h5cud0BYMcz2UKZeuzT/JWl7Nd/g0fqmwWDFrOvc/r0h69cyZwoJR1a09Vj6bOfW
        44F1AAbWZivVQnT1tR+t0RZf2Fqo3G8L+5emYdEvo/qmJu08FuyiAztjJJZWHPfQ
        K3KSNh/FlxUsHuzzLfzHVA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3sd8yk03eh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 19:02:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gO+gyRHawvKTTsnzQzQSGhZq+LHzFClOJXnSxPCJzLjWJ3yrptcm54tzVLFe7B+BdADNXBnELPYkcqY58Z0508/Afl6UI1MXlIINe1hyQKfTZWZEZHdYXALN++PSSHammxkF+hM3FifjqJclUH6Z3H/nRA7/y65j3MtamqTPaNYhFdV7NceUyXXCEqqFlZuim2vLq2mPGj/UmsKJmmDx4U3E+7mx5g4t21hZ8mQbv/BJT3AWZ0OdAQJNk9WFLcYh2dx+XbdERQfIz1MPdkiCFiSM25pS6de1md8CvTNUs5tY7RJJ1lLvdvgvMbVYnegnZPSv1d9+7UTu3YTYYJ7Raw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1O4Lu6dl4MARL/Ol4z24CWjxPN9z9MlG9mbSkLtOJo=;
 b=KOMsUYsIp4M2HxFV0SB2eKGG9SjFfDAiQCXhKgku9w9bSEDQsf6twQcuFcCZT/S10o6dwO3a8OlGCwQ7JdH6aE4OAuaqD4IQS0W2IogeYXyx4LBKH+MwcNcSNqjhwTxSR1Rji/uBMWfidKeKZ5X1zl4/fl8+Z0NDpgfvZV1vu/1Ync3QsbOYABbUa3aW4HCAsuiSFbqvuctiE2hsoDx9x+yzZbPSBlJxtkgOnef/P+/MLDmuIYnd6+biTEdGCqOBsG9SYUW17ibj6rFlxhRMr5X+bEfeKq58GLgmlCmOgU5afVQL6/HEFFF4AJlUbctq+hEeAaXilCG2jT1UFiIK1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by SA3PR11MB7464.namprd11.prod.outlook.com (2603:10b6:806:31b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 02:02:53 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924%7]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 02:02:52 +0000
Message-ID: <0651ed3c-7239-0235-ac14-b0379fe06297@windriver.com>
Date:   Fri, 11 Aug 2023 13:02:39 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] lib/stackdepot: Bail out in __stack_depot_save() if
 the stack_table is not allocated
To:     Vlastimil Babka <vbabka@suse.cz>, catalin.marinas@arm.com,
        akpm@linux-foundation.org, glider@google.com, andreyknvl@gmail.com,
        zhaoyang.huang@unisoc.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230810074704.2042664-1-xiaolei.wang@windriver.com>
 <20230810074704.2042664-2-xiaolei.wang@windriver.com>
 <08dd143e-3eb4-1854-eddd-508f997dd810@suse.cz>
Content-Language: en-US
From:   wang xiaolei <xiaolei.wang@windriver.com>
In-Reply-To: <08dd143e-3eb4-1854-eddd-508f997dd810@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0138.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::13) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|SA3PR11MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b29209-6747-497c-9626-08db9a0f1255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5HUWZ+HZs0u5JzIcwkB8/k2Q0lSLZA1FDalQKQFDcwb9U6S/t/uAkImhIYqwaVWe6bozAWxI6dUYWImAmaazqmB7HIM1AFrwPNl0NPzTSVV0z3FWmN7M+0A02mMPmWq2caGNWOoML5U24Ui/wm8o7N6IvOaPKzpR5OMJFwLKMkLlpAZeRHobVgs6XTSeCh1v67vi3dgFLsC3esIv/Cg6ZDF03CYkW+FiSEER/2SOgAvqqUDgZAiYJ9abNM0c68QyxFThrey93xpK0cdNB78jwXWNor6QNacjpRHq15FY7LOtOsJCzmXOtRMx+SkpdRd3K1/RPdR/7FfSLsVEBPm9AmqmqNq5U9YvBRxDx/dmCEzGYZWLVnqH3oD5pnlMcAel6N2hk4SGnHuRTuDlq19GUF4wlD1EffHIJ5hfOBTUY+Ap7r5/mgZwhWrHqsn9Iwsi4SJE3tyCmKu8wZUfCsO7ajOf6vlB998vCBRIOYT9Ov1ffiCQY7p+jl2rK4qw9+0PHfK8u7ZmMKFl/SSoE4iyNAi1gUsVES0xZ767KbP5FPDubYn7R3ZrsRj1aHlHsNG2GmsX+FOQtOFnGM7c/TG+rJ2Sydd3NuKztbf4Lwbm1MAZ3weLntQyX4bFLZdWMo2fEUk+Vum2zSvyaFXACZ9BdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39850400004)(376002)(346002)(136003)(186006)(1800799006)(451199021)(6486002)(2616005)(478600001)(86362001)(6666004)(6506007)(53546011)(36756003)(6512007)(5660300002)(31686004)(38100700002)(66476007)(4326008)(66556008)(66946007)(316002)(2906002)(31696002)(8936002)(8676002)(41300700001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlVKS3J0UWkzK01TcWtuR0xyWlNtYXppcGpWM3lHVGcxTGVMWTdQOHBDbElG?=
 =?utf-8?B?UjFRUW1JbzdRSVAzMkw3Y2oxOWlBa0cyRERsczl6ZFJXR0RadkVuVWlxaUxx?=
 =?utf-8?B?QW1TR21XN0pwTkZ3a1VjeU40cGpnYnpvV1hjZ0F3QTVpRG9UTDBVVUVCY3ll?=
 =?utf-8?B?R05XdmU3ZFNFNG9obEYveEtGZFc1RjVMRmJBNGN1NlNuMzFBUUxGWkxLUkFM?=
 =?utf-8?B?aythNlptQk92czNBV2RmMnBjcG5ESGFZSW1obmhKUS95WndVa0swZGllMG82?=
 =?utf-8?B?cWNsKzVyalNnVG5GQ29PSVJ4bHpZQVlmZ0FWdE9qRkhzaVpoMW0wZGRXd0RG?=
 =?utf-8?B?eFcwZ2VMUzcyalNtdWVoZmllSkdBSk1nNmxPdXRHT2p6VzNuL052ZWJ5VHFk?=
 =?utf-8?B?VWxSYTBMZHN2eXFrb3hnL1diQnNhZ1dreVFwVmtKZkhVQTY4VDBQZ1NQVkxB?=
 =?utf-8?B?cGJ6bnBNYnVPMEpyQjhPZENrNXVrWXhMdStuWTlJaFEvMWxNdE13Nkhsc2Ur?=
 =?utf-8?B?UHVLdHVSR1U5ZVFWQzdKQ3BianFabE1zOXkrdFlibUUxWGJSbUc0UkNYMmU5?=
 =?utf-8?B?VFFCOEo1R2ZxRXAyazUxVy9MT0lwazVsTUxuSTNidnlYNnZoQzdHeDBrbEt4?=
 =?utf-8?B?NmhXQjRTelpKVW1kL1hLMGw3SkRQUGp0OXFYd1V3WWJKdVduSDlnREJGeHJX?=
 =?utf-8?B?Ni9oWHlrdlMwU01wc29wRXR0Z1JJVFU1UW56TUc4M3NZdFFZbFl6eG9vV2th?=
 =?utf-8?B?Tkl5c3pOeFJRS0JRK3ZaK0lQU2YvaU9velFwTUtiWFp3U3pNNTVvYWVzbUto?=
 =?utf-8?B?NGhmUzE0TStNRjk2TDlKekU2ak9qNThoMUNSUHpMNHhxWjVDOWszMjJrcXA0?=
 =?utf-8?B?M1BuVlNyUlovMlE4Y2ZNd1ozaFFyN3NvYUVZTGFRSGU4a2NPNVVhSzZadWs1?=
 =?utf-8?B?UXJpSUlIQzZtZVRpcmgrbU1UV1FCenNUeVJiSGkxMUFRaE5SRjZUaUNIWENv?=
 =?utf-8?B?R2d5QVJQdEdYZ0ViL1lMN05JWURRY1U1dW1mVFZidWtPbm1BM0FUZnVmVDZ6?=
 =?utf-8?B?Q2duMERIVFE0ZDNFV2dySVpkUXVWb0JJM3IvUitMeFV5VW1FT1NQWGlqZW1N?=
 =?utf-8?B?VG9tdnQ5VU9ER0owVDFUSWNQVTRuNndmSWxsSnpEUEJBalUvL1ZZdjloUjY5?=
 =?utf-8?B?ZXlGSXJZSkZZMG4yR3l6cFd4a0d0LzdtZHhaMVpuUjIrS295ajZ1anpVbFBH?=
 =?utf-8?B?MzNEd3p0ZVZlSW5ybFcxWmxqcFRFUjRRQmk0NFY1dnQ4QVpWVFgrSlVyQ05B?=
 =?utf-8?B?aTN5TEZFNVUxWnE5akpUeWdBc3EyYWtkVXUwazVkd2pSaG54U3Z4R2trWkNS?=
 =?utf-8?B?T3Q2b2U3MzZibXFkcExRTjVOSmRKOEhPeXhyWlpjUk5YTzRYQ2FIeXRSQkhS?=
 =?utf-8?B?OVdjMFpxNTNkYkdhZitTWGhvOUY0UWJoODZzVis0Y1ZJWlFZcHZoYzdIM3hR?=
 =?utf-8?B?VlpFUlh2NDBMN2VTT2c4VDA3VElFVC9kckdvazBENWprM1o2QWN5SG5IVVYv?=
 =?utf-8?B?ai9NckVyVE9Md3RaTVhkT2ZkV3N3bS9QUFp0Y1FxMjFNQTJYNjBMQUZsQlV0?=
 =?utf-8?B?dHJYRythNnlDY1dpb1lJQmtKTk9kVVdnZm5XZWVDclQ1YnpobTJuUkZEZjl5?=
 =?utf-8?B?MHZJTExzQlZhY0VCMjRRYS9HczhpMDIvNENmZ1E2Ujh4dGNMNUk5T3VZMEIv?=
 =?utf-8?B?S3JCYUxnSldMQXJ4ZmlUYStna0VPV2dYVGhmTGZFMUQ2VzR4SWpPdUs3bmpE?=
 =?utf-8?B?eFR0SnV6aTE1YlVhODUvT1Q0M0dKOHVZaEQ1VHV0bTU4WHF2eENBREZBUWJV?=
 =?utf-8?B?dWU0MFlsb0dWRFk3T3pRL3QxTlF3SXJkc1hkWVU5emk2YkJIUjBPL1V6L1Nq?=
 =?utf-8?B?TEZRcEVZTVFOTnp4MXI2TmJjQVVhVzZPQURRa3VRSGRhRWoxWWNRaDh2MHgv?=
 =?utf-8?B?N3BvSHZzVFpPdXd6RVByRnVMUTlZWHdnOG1aUDAzK3JRK0xCLzRwcklsSTI3?=
 =?utf-8?B?akJ1dTlWenVLZ0FnWlRGRkdkcnRtMFhJRE9PTkR4V2lrMWZmaXZWS3p4QWU2?=
 =?utf-8?B?UDY5TzZzSGFoeEdUUm5YaWpPbTVuc1ZiWmN5K3FzVjlHSlVBTWdBYXN1am5t?=
 =?utf-8?B?YnpSMzU3NkNGRUJhb0h1eVdVVUtzVWZ1a1BaODBOTU55aWQzYmErZm9QVHF1?=
 =?utf-8?B?dG5lYW9CV3I3a0xDd1lJODlvM3RnPT0=?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b29209-6747-497c-9626-08db9a0f1255
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 02:02:52.8002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCPNIiHtnx82ZmBhaTvaEZjZFynlEKAt8k5v6J/4qbA+nwikG+jlGzp90os6B8fgiZ+p52wmNbZQHVytIT7gdlYXegTTQXo3blxpNtaeo6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7464
X-Proofpoint-ORIG-GUID: xQAfqYQLo-JPyiokJ2t87p49YmQB6MQJ
X-Proofpoint-GUID: xQAfqYQLo-JPyiokJ2t87p49YmQB6MQJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_20,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=849 clxscore=1015 impostorscore=0
 phishscore=0 mlxscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308110017
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/10/23 8:53 PM, Vlastimil Babka wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On 8/10/23 09:47, Xiaolei Wang wrote:
>> The __stack_depot_save() may be used by some subsystems even before
>> the stack depot is initialized.
> Does that currently happen, or only after patch 2/2 it starts happening via
> kmemleak?
Yes, currently it happens after patch 2/2 it starts happening via kmemleak,

The reason why I take it as the first patch is because I think this can 
avoid

exceptions when there is only patch2, such as when we use git bisect to 
debug

>
>> So add a check of stack_table in
>> __stack_depot_save() to make sure no oops in this case.
>>
>> Fixes: 56a61617dd22 ("mm: use stack_depot for recording kmemleak's backtrace")
> In case it's only after 2/2 I don't think this is truly "Fixes"?

Yes, it is indeed for patch2 at present, it is to fix the situation that 
kmemleak

has no backtrace in the boot phase, and at the same time, it can also 
prevent

patch2 from entering the stable kernel and causing panic

thanks

xiaolei

>
>> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
>> ---
>>   lib/stackdepot.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
>> index 2f5aa851834e..a0651d013a0d 100644
>> --- a/lib/stackdepot.c
>> +++ b/lib/stackdepot.c
>> @@ -376,7 +376,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>>         */
>>        nr_entries = filter_irq_stacks(entries, nr_entries);
>>
>> -     if (unlikely(nr_entries == 0) || stack_depot_disabled)
>> +     if (unlikely(nr_entries == 0) || stack_depot_disabled || unlikely(!stack_table))
>>                goto fast_exit;
>>
>>        hash = hash_stack(entries, nr_entries);
