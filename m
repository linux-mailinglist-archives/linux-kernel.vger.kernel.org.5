Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995CC7776E5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbjHJL0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbjHJL03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:26:29 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEC810D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:26:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeJP1AtnsrmkGC6Cf4EBqYIWwyy49b7DQcMDhWUGqRRr5aSplxl/WaDo6TjsYdX8GFcPOedj3tZ/d8d7CGSE2+98Dwr81p/q87o/T2FDsyzVXF3sO+VOnLbVBEl2WhPX+NkLrYDKtfSnhnbwDjP1gH3dIZDMHjCqXJKb8ViAN/48aV8ykJy7evat3cB8GOhGaOkBNVMfCIW9AZW+cIHl/aq+xNVmwkbIzJOZpy3MC0uk61BvgFa25GCqE65/MG2fBBfYVrERCbCtdZiEBx2A7YKWwvrKFn3xZsO9Op/BXMUCG2qqNyDETAOslMfg7n55mT1aXhn3aLamNHsCY6IwnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rH8Rfg674oKCZmhWtx1kSk5Xn0x+V9bxpRh9ceMCXxo=;
 b=liwwEsKuL/AoMbfU8Pp3azptWWtyHsgdU+Udm05wbgOWqGZKt4qN0ZfD1ZKto2L9ezLpo7JkcBmAlmxhDEBJjv/VX1Di+OfEOU3AvcqD6hJG+ZD8KnuGi25QGmYgCpEdjegRyqebXApBtk5qjmST9ZqfeYe8SznuKjcnnNGafRFvrGJudo2Utbc77FQbpK94ShQ+cueUrlVb1QiZBshkL0pcIBI/CDdsF2z0S2/DTYAKxhz2iHs59uvYyxSECANQ4mBbZ/0fsqPVyy/bgMBA0v0+xj42WLmcPorKDmc/akK54K2dwf14PlbP21Yn+v8MVdKHnaiNBJVxov8pK5X3Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rH8Rfg674oKCZmhWtx1kSk5Xn0x+V9bxpRh9ceMCXxo=;
 b=38KEl0sLPKQNGagCLch08sihEhTFo9jr3IIesiUyHzBH2Q8DeEwv35TfyOgpRHF8cCLu9dZxKHQngqVkTVeuuznOvzJJ2Zl6YXc1Md1rZmmVmhocEgm7tqp+s78LWxhPNj/ZmQawQQjXy3LlqEtJI/6G6kq1QT8sX71lKlr9H9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS0PR12MB8563.namprd12.prod.outlook.com (2603:10b6:8:165::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Thu, 10 Aug 2023 11:26:23 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 11:26:23 +0000
Message-ID: <ef4d99f1-e2af-0ead-6b6f-c577b3eeca05@amd.com>
Date:   Thu, 10 Aug 2023 16:56:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] x86/smp: Validate APIC ID before parking CPU in INIT
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, dave.hansen@linux.intel.com, bp@alien8.de,
        mingo@redhat.com,
        Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
References: <20230719051302.15801-1-vasant.hegde@amd.com>
 <87fs4sjbw0.ffs@tglx> <87cyzwjbff.ffs@tglx>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <87cyzwjbff.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::11) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS0PR12MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d529b0-15ca-4abc-74df-08db9994a07a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Qu1swaCiP5P7Uegi5d9GSgdee5Fdx5hbv7bMdbuc1lPLoTrHKPKxmMYKUo0WXeGbGmk8O/JIOPoVwcpdlC3QDdylCU92FattXMkJ2O6APyCbKbuKrsC8jx9aYWtd4KUJsRGTKZp8VwH7U2c+7qfNj0u6/yQE4ulzL/0tJ8nUdZVc2I7Z+yXtmEpWf+Q9Le6ntCFnauDzr2jHWfMxcNrYlU32XPJMJaxZzqJVSuU0HOAei88nC7U7FoVsa9+2GdE+vHBLVDhDVhWS/nSJ0g99KTuvHf2ZTuUKfHvZlPxmdavful6sLARb50PHkBFHrvozOaED/8ItCgdZF2CTiS0Fj7NAgOTGVSJpyj4TN2K4SNM5DZYcaBqs5trDVnsuLLr6fK0JCZUcJTTiOmIarTg+r+lXCct96P9niez8w35K8+2VEM2gwACb6aB1fUcsg5EQrbiMwLec/Ix/qw0yjslHpvEY6FDZmoeh5YoYAYtHSikpWp04cqORsf4cFLskmDz9sQxGJ2KRdY7gDJsi3mqNM6AU5y1RwaZIQQOwCVePh/Eo3mk5J+YlAi5urQ/7u0cylu/67j+HFU7PjaOoxzlAvQN/bOE6yskQKya/BiKqTiHZAWOb/TIKATqqCLkRRkhX6kEUd+SKnsnRk8XXF3pGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(1800799006)(186006)(451199021)(66476007)(66556008)(44832011)(4326008)(66946007)(6512007)(6506007)(26005)(31686004)(2616005)(53546011)(6486002)(6666004)(38100700002)(36756003)(2906002)(5660300002)(478600001)(41300700001)(31696002)(86362001)(8676002)(8936002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTZvVkMyZW1nb0hjSHhHZTNDaDVQUXgwQ2o2bVFsSzFMSXVPVHpXNnUzZW9k?=
 =?utf-8?B?azhWZzMzaS90R1FkMnVPMTJKeHZhclpneS9jVm10R3grNFY1a1NkdjBVaUhY?=
 =?utf-8?B?c1hLb2plRlZxZ0dxZ0hlbFR6NTdPbkV5YzNsWnhtVm1VMnNEWXJVUGVkR1hN?=
 =?utf-8?B?OWNQa0U4bE9YSFVJVlpnRHRDWmNTd1JMdWNGS2xzdlQwcVd3R3l3bFV6em5h?=
 =?utf-8?B?eDgzME1iV3JVVDl5SGg3UXRBQkVmYTUvNTlrY3JwNG5TNnJDeDlFSnYrcTF1?=
 =?utf-8?B?TXI3NldQcXg0c3R4bTBJcS9lSWl1dXlVR3g1aHRqbS9kNnZEb2ZaQ3BpTjU3?=
 =?utf-8?B?WFIrRjZpNGRWSVV6dlV0cXV2amFCZzBlSVlCMTM5UHlqQ1lmVkxiNUJ5MjZ0?=
 =?utf-8?B?dDdQYTEvNTdQMDQwUlFGQ0RDSXcwNjlJcFc1c3ZLQzE5Z094NUw5YVVWdGVR?=
 =?utf-8?B?Y3RWdnlFMW1qWm8xL3pSYkc5cVkyaTJNb0w0TlR3THFDTGt3RzBKclo1Z085?=
 =?utf-8?B?cEliR3FUajRLNm12bU42QnlHUXVxNUxtUWxkYytyVHBlTXhWSXpKdi9PdndS?=
 =?utf-8?B?U3RvUDlkZ2svNGNlSWZ2WHppZ3J2RDRkWlF5V0ZtZzcwMkNoR0NLMXpndlhW?=
 =?utf-8?B?SUdMWEw1YnlwV1Z1QjY4cVRITG5rampVQmpYdEx2bGhLY1J1OUxVQW5SN291?=
 =?utf-8?B?QWVHMVgzcGdtVzlsdmt3SjlHSE5yRU1VMXNJSmJLRU9GWHZOYzFQQzlaWXpr?=
 =?utf-8?B?bVFqN2hBa0d5azl1VlZkKzZnU2crYllSZnlnMHlNOHJKSXpob0Z5QWYwelV1?=
 =?utf-8?B?SmhxUkNkbVFFVkRmVmVZQ1Y3MEhGeVFmOGdCQmJnN25MT3JpTjkydUFOVlZ1?=
 =?utf-8?B?SStpNHZxWFFINDBnUlYvQjNXMEMvZ0dUNXc0OVQ3d3NndGlpWi9scUN2Zy9p?=
 =?utf-8?B?WXhHWGRRcDFoOWIyUWdUV0Q2VGFmeFRrQkpRTDNMeEtKRjdvZGZCL0U5RVZL?=
 =?utf-8?B?M3pDWTJLQjJ1M24zMWE2bm5XV3UzRzFkV1JzVHVKdkxyMWEzNW1helczaDhX?=
 =?utf-8?B?eGJxbjErSHM1Z0o2cFF5bVRhU1JaWFlUajFpeWhiMVRNYjlFaWVjcFRaTTdr?=
 =?utf-8?B?SVRKS0FUZEYvSUYvaTFqYUJzMGFjSFJrTWV3d0NDcFpLZnZnNXlOcXB4Mm15?=
 =?utf-8?B?azJYalVHN0ozWThCdXVSNkh0TU94YU9TN2ozRnR3S3hSeEpEVU9HMDg2c0VT?=
 =?utf-8?B?NWZ4dXFidnNOM0xSajAvRGY1ditwQ3Mxdk9nTjk5RTV6VHkySlNBNjBsM1Za?=
 =?utf-8?B?T1NkM0ZtS2ZnUmtybDIxeDhFZ3hTc2V4d3hXUEkxQmJGRElndkhYWmMrS0Zq?=
 =?utf-8?B?Wmh5bTI1d0t1T0lZZlVmZmJyT1R4bzFibGZ3Tm1hRUIwQ1FEUGlEYW82bE9x?=
 =?utf-8?B?VHJ1T0ZhQ3ZraHRiTTlpejJ3azk4ZDJHM0VDUjJpSHBLZklwTWt6My9sNWc4?=
 =?utf-8?B?TE9kcHJycUUwemZpYjU3czhCMy9ZS2pUUGF4b2ZCNW16U2Q4d29TUElYR1dW?=
 =?utf-8?B?Ty84d0lxd3Y2a29URy94Sjg4UVYxSFRPZkQzcjRuL2JqNzZHR0F0WldGK0hX?=
 =?utf-8?B?MVQwWHFldUpjSVlEeXlneHZTbzVhb0tyd0p3ZVBLNlFSWVpUNWVqZjFVRElo?=
 =?utf-8?B?YW55Z1BpS2EwNy9RV2NzSXk3cGh1UDVRUlhzbUVGTThCYWZGcVpWQitnU053?=
 =?utf-8?B?SStJeHJWSzZaU21uOXlkVnc1ZHFpZWlDdXVMbHFXRXFhNksxKzQrZzBINTFL?=
 =?utf-8?B?VTgyNUFONGtSM01tR3k0MDlkYkRqSGpRMktRbElwWndCNWtkdkt5UHY4QUN2?=
 =?utf-8?B?VE1GWUNtaDJmdjhiZHUyQU5TY1paVFNMYTdrbWNNbUt0UVI0blByK2FvQ1F6?=
 =?utf-8?B?bEc0Z0Z0SzlKOENPWEgwYzU0bWY5clJ3U0gyZGQzZzIvcm1BN0xKOUZ3aUxD?=
 =?utf-8?B?Rjk1WUhDVG9PWFVxYUhDN3VpNHkraXhCc21haTJWVWJtOGc4NUJFei9FQkpV?=
 =?utf-8?B?R3FTa201N2d1TmpHUEVJZnY5Qk5sRnV4NFhGd3NxL3VmUlVKemp2YThKcWdh?=
 =?utf-8?Q?zmis1LMSf+iGbsZWx4TndZB8z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d529b0-15ca-4abc-74df-08db9994a07a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 11:26:23.3609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRaRSISoUGoyHwwkSXZ6WiG/+MUm3n4WsCIWzKXgVXrssmg83Fez43AkfKa4BnAdvRAoJv5/PUGiIOawaYVvEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8563
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 8/10/2023 12:22 AM, Thomas Gleixner wrote:
> On Wed, Aug 09 2023 at 20:42, Thomas Gleixner wrote:
>> On Wed, Jul 19 2023 at 05:13, Vasant Hegde wrote:
>>> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
>>> index e1aa2cd7734b..e5ca0689c4dd 100644
>>> --- a/arch/x86/kernel/smpboot.c
>>> +++ b/arch/x86/kernel/smpboot.c
>>> @@ -1360,7 +1360,7 @@ bool smp_park_other_cpus_in_init(void)
>>>  		if (cpu == this_cpu)
>>>  			continue;
>>>  		apicid = apic->cpu_present_to_apicid(cpu);
>>> -		if (apicid == BAD_APICID)
>>> +		if (apicid == BAD_APICID || !apic->apic_id_valid(apicid))
>>>  			continue;
>>>  		send_init_sequence(apicid);
>>>  	}
> 
> I think this papers over the underlying problem that this sends INIT to
> an APIC which was never booted. The below is curing the root cause.

I have tested below patch and it fixes the issue. Thanks

Tested-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

> 
> Thanks,
> 
>         tglx
> ---
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1356,7 +1356,7 @@ bool smp_park_other_cpus_in_init(void)
>  	if (this_cpu)
>  		return false;
>  
> -	for_each_present_cpu(cpu) {
> +	for_each_cpu_and(cpu, &cpus_booted_once_mask, cpu_present_mask) {
>  		if (cpu == this_cpu)
>  			continue;
>  		apicid = apic->cpu_present_to_apicid(cpu);
