Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7983783175
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjHUTXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjHUTXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:23:14 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA2FDB;
        Mon, 21 Aug 2023 12:23:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZypD4WoQJTMHtLelqCHpY8ioYnIi6P9kHW6tXbn2ggYJr4lOVvYqLlimNVFF5X0BQZxwJzI8/S5IXfA4erC5IEW2ZpqNnqQF/cBJFa0bXkCW2YWhkWAyWh0J4bOsBLXPKiwutxQ/vofduOQZkThShR0bbxGQuzPagRYJFrJFs2+hvOU2HJjWVcf7l31EP7iMf6PmLQ3asWCen88IzCTl+QPARDmA4/jyUaI0byWhQjy5tOMnwRn7V2wUe2w4pjwcQXvAxK8jc+Rxk3qTrTkQAyeT5OBnKy3wCth/lcojYIWDDwRU9rpVxE71lmH/KwxSPkboXAaoEHqHddvEwkuLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3i8PuQdCfOru4rC0xhFiZkvUhXkZTBsK09xCE+oGB/E=;
 b=i5j8eCASsZq3kvmRbBigDe1TCYZEGDxqTL32rmwCgWX8zWNUqVTTy9DL8RE1bqb0J9rpJOsD1OceBErOjOk/yMgw8PpPa5SxNu6pzn9B1tTslzK05s6TZhAyGLj8ToqfIpE8SzwjIKJ8DN+J7UKUFR7zCj2pjq3iX1mWu/9CQQZW27TJcJEcLeQLAXTJ2MA3MQzwMY0OUthqpv1JdQL9/7uqpz1HyZcXa+pW7YB6SKHYEHHbgBG0Ex8eOnka+k6hpfV4oEpVLm3lWWYrh7X6lBcZ/mdcOEmcBe/Q53/vWIXN6tQzaOrsRN1r2Hx9Bnr+tSUVgtoFYOBFXwDe3l6wlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i8PuQdCfOru4rC0xhFiZkvUhXkZTBsK09xCE+oGB/E=;
 b=GsVHJ4EYQM6OG+V+BmJiaNUAWw44I5FHOYXPD8kZ2/YoqwjtgAaF/ggq6t8uM8SXyj/ZPYOd2ugg+x8ISrJ3YAD20QMVT8n3Ndddzn7MVXGWfeE8bpQ8SOJEMA859VGUTjAcMWShPtjxCuEHQ/gqCywAdff/zrERWAYqnzTigUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4895.namprd12.prod.outlook.com (2603:10b6:5:1bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 19:23:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 19:23:10 +0000
Message-ID: <0c1fcac6-5497-4a0d-9038-9eebf988268e@amd.com>
Date:   Mon, 21 Aug 2023 14:23:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: PHAT: Add Platform Health Assessment Table support
Content-Language: en-US
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Avadhut Naik <avadnaik@amd.com>,
        "Wilczynski, Michal" <michal.wilczynski@intel.com>,
        Avadhut Naik <avadhut.naik@amd.com>, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20230810234856.2580143-1-avadhut.naik@amd.com>
 <a0ab4d07-fb73-418b-b88d-c3ad6aa4cf49@intel.com>
 <655c916e-356c-03e3-6c67-aa40886dd5e2@amd.com>
 <CAJZ5v0j0R1GK=0z+LJd_PSh4zDv9Ydw2YA7HWm1R5wjCUsbbYQ@mail.gmail.com>
 <1c579c96-5010-4e5b-aa27-afb4f4f6746a@amd.com>
 <CAJZ5v0iPRCJLH5bkKyhjUq_tmjmR6R73fhUm3JnKptcm1cn9fQ@mail.gmail.com>
 <6bc15195-aa26-4e29-b625-74fca84f7a6f@amd.com>
 <CAJZ5v0jEcD_1+jHfAk9eN0YYJFbDZN2rZ97KHyH2-w6EqRN9+g@mail.gmail.com>
 <43b65307-bc3f-4014-9bf8-a96c6ed15d9b@amd.com>
 <CAJZ5v0g+uVZwoOr-2W19Ux9u-D=WiY=-dtcQZwYU0Ov_GE5d=w@mail.gmail.com>
 <CAJZ5v0g_DyQAnSuigBc-f0UNmW0mo=0yMadES+0NhphJs_k+cw@mail.gmail.com>
 <9d491dfe-13d8-4072-a90b-5f68107fcf95@amd.com>
 <CAJZ5v0jxKwtHM3vhtw44TW5=J916XvXSeP3DyNLcJDo+eTSRHw@mail.gmail.com>
 <fbc0b21d-33e6-4c32-bc34-3fbfe5e99b1f@amd.com>
 <CAJZ5v0i-=kfBPp2oW-40mNSAFnOzTEeey0EhDUsN6qNU+QY4Ug@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0i-=kfBPp2oW-40mNSAFnOzTEeey0EhDUsN6qNU+QY4Ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:806:24::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d4d2e7-5388-4329-a848-08dba27c0e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5D8aR2+/P2w5HRNrOi0e3/J53tdRxVuAYDBNQotgDtA4MXU7+v6H2McKWmrgHPWQkLrlkVqvdCyIMQcf4DieoHmVY/VNAyJsgyE2B0qj/Hi1Tve5t94QkseCSex4jhW8vhIOf0izXCfwYyrCxU9DAJ2JZpP8qXK/grA+X4qpEE5Od0B4lpiQenOpMulgn7m01JUmBDaRtTXVGGbtCd8da1Bp1sL612/h4lgLL1SB3CEA0ayd3x3lVGBuXl+DF0ddAqkXFaNwka6Nl/Vm/AEcVez1ViG7lBsRv+sxBC0tg/NhlotyzOCWUKOi2T2q45XLsgEj6nqRyNHYndfwF5ZXaP+XzcVELB1EFRPHPRsy5JfTev04WslhNIIvbTVztXLqSJWt72e59+W+D0gLik8S6PYUZULTqOwdlnXuj5sjolYGO32Xfyergo+0xOT+wAqeQXgdXJG7BSZaGE3syk/+fqX82PAd9K3naIJ3YnNexP6U1lMjq+uM/N1urH8yj29AjYWYeF3TFe4JP9mYSS4e/5BNmoUyc/Jl4dFAd061U7PyWSo2sTW/D2oP8H1EGOCkjiT7gMs4XaVJVm05LnLqWKIH242son7Fq65GJgJhgSJbUJwmIBLGFqEN0JCSTVtkPThPbmKrwivDAO+QdmAo9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(376002)(346002)(366004)(1800799009)(451199024)(186009)(38100700002)(66556008)(66946007)(41300700001)(54906003)(6636002)(37006003)(6666004)(53546011)(316002)(6486002)(6506007)(66476007)(26005)(8676002)(4326008)(8936002)(6862004)(2616005)(5660300002)(6512007)(83380400001)(2906002)(86362001)(31696002)(36756003)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWxMeDhBak0wWHErbXRFUGkvcmpCOGE4a2dxeXJwVFd4d3hSVy9IUmVpT29w?=
 =?utf-8?B?dkNkdEZ4b3dqNi9rcjc4RXhtNU1GOVN4NjJhaC9zWFdkbXI3R0RiUjIyTi9W?=
 =?utf-8?B?ZXRmV0lmWDJwYUtuMnNJVWJubEJ0YjdmRlpjNEE0TTdCK3FKRTlmS2MvL2l4?=
 =?utf-8?B?QWo4RzIrbVdFYTl1a1ZSRFlReUlLN2NJbWVUaFVNQWFTTWVBK05NUU5iTnNh?=
 =?utf-8?B?eVFlVjVzMi9wKzZoeU9XMWhHMk9lMDNBdkVmVHpEODRFcXJxTkxLOXhMNFBB?=
 =?utf-8?B?SzBQMG5BeXVZMExGSlp1WGtIWk5CejhFb2RKQ1RtMWNXNS9rL0hBMFdpME9q?=
 =?utf-8?B?V0ZXY0svSDc2TXN0a2Qxa3lKMWhLNXlmWDYvT2I2QzlRUFYzSzEzTHFZcWRh?=
 =?utf-8?B?WGRGam81UVVOazFyL21yZ1dCVFNzVUF1TElrbEJUSUZmM05aQUFYK0p4dW5Q?=
 =?utf-8?B?azhUbk1HYkpZcDdGNmpiWm9vWmRTN2toMDJxay9LeUg5MnFON0JDdGxNQ2I1?=
 =?utf-8?B?TmNYOFUvY1ZBL1hRcFQyWlRqOS9jVjIzNkNuNlB3ZDFURzV4bVBuZUdxMnhB?=
 =?utf-8?B?SS9BZDUzU3hmeUFOdENvaXhUZmFkZjZmdGo4cUJUOSttWEdNbDNSUzY2QjBV?=
 =?utf-8?B?djMyWTB4ejU1Unc3NkxBQzJJMExwdjdnTFdLc1NDMHRyeFk1ZEsvckFaS0NX?=
 =?utf-8?B?R1RKQXQ4TzMzNGJNTklZSHcxYkdYRTlJTUNNd1ZadmZLU3lFSlZuNGtxWFZz?=
 =?utf-8?B?dXA2WWlGaEtvV21ITE9DK1hLYW9HSndxNU1POHp3SWdheXlteDhZWnMvT0E5?=
 =?utf-8?B?RHVEd1RkQzNnMm9XQWxobmhZUjVXaVNtekIzK3JrdHRYc1hUUmtxU3hSREJx?=
 =?utf-8?B?a0I2cE5JM3gxYUZBSTVVMmNqNWFlTXJDNmdQL21zVERmbWpoeGhLck9mUVJl?=
 =?utf-8?B?M0plRVRuN1l2RVVBTUlyQk1KSldtLzVtTERIdmNnNzh3ZUgrTlVXblBYZXRY?=
 =?utf-8?B?K3o5K3c1VzcwWElRdk5CdHNDSmszNlVPVVVndlIya1NQQkZyaXJMNFdqcXdi?=
 =?utf-8?B?SXpRV1puYURkdDMvRElpZitSZVRicFNWTWIyRDJHREFra21OeWtRYTVRSFlh?=
 =?utf-8?B?c2lvRlVQczVQNVVqNUxQYVB5VGI2c3JvSmMwMnNDZTZvWmtJUlhLRWVxWmdE?=
 =?utf-8?B?bXVFVVArRWd1UU1yZi9naWU4aTVGNVIwNlBFcmhEdmVzdTg5cjVuQThWbFRj?=
 =?utf-8?B?b2dORmNRWWlKQTRjNFoyQURsVnh0Wm5RSFg2bXZrZllxTlcyekhNZmRjVjc0?=
 =?utf-8?B?bktJekdaYmNXTk4rbHNOaEcvelV0WUtoRWlqblM1YXJnU3dNcWRwT2RBRVoz?=
 =?utf-8?B?QW9MWVRSaWxuaW10RmQvMC8vc3h3U1RFS2dJM3ZSVFRxd1E1WFVBZkZEU052?=
 =?utf-8?B?a09Bd0NwaUFId3VoKzNxZHY1S0lFY053aFVPSytJazhBTU5KWWhSVzc3RXVk?=
 =?utf-8?B?RWxqcGNUUGtueXhSclpxR3AwNFFlSS9KdlpJNEZIeXpBa200SVdEcDVOSTdu?=
 =?utf-8?B?UzlDdmpEaDJweU0xYU16WG5jdWpBR3BTN1JNRExZaUpDVldJM2gvY2l5L0RF?=
 =?utf-8?B?VTNxUzJYa0c4dUNRQkg4Q1NwY0x5Tzc3RmdheVIwZlBNQ2xFREsvV2FMaDl1?=
 =?utf-8?B?R3JaNFk1M1lGbUNqUE4ra211UWlNUjdDRmlwdzFHUGZVRlppdWxLTS9sekNB?=
 =?utf-8?B?TE9zK3hKNUZMSUZnbWZqbVNHTHh0QzBCR3ozVm5ac3ZrMTlwWHk0OWpaNko1?=
 =?utf-8?B?YThvMk5MOVVhSHBKQWlRT3pQQ1BvNWo3anNZUlpIbDdlN0NoQTN5dFBDOTJ5?=
 =?utf-8?B?NUx1NXZ3Wm5MSEJDaFQrS1l4VTRDc01oaTNhNWxGS0hORnJON1lHMmhjRjZz?=
 =?utf-8?B?S29heWVEQnFCNWNRMWl1cGh3VkhUZUV6Mmppc1RBMlV4M1Vld3JrKzdFd1VO?=
 =?utf-8?B?NERzT2QzQi9KaEdHZ2VZK1YxNWlsMWNNK0FGeFliT1I1SDY0K1lVV3NXQkpy?=
 =?utf-8?B?SWxNWmxjMC9IcWUzK1BtMTlvcitqeEQ3TjRUc1lESENEQjFyWWYrNlh3Z2Jy?=
 =?utf-8?Q?62TgRQLcJ3XzcBxfqMETbEZnX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d4d2e7-5388-4329-a848-08dba27c0e2b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 19:23:10.2068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPZS0t6ER2v0FN4DBuZ8DIPQerAB1VIcEhTMxb6c1s1S6YzNFYlHfCVNbeF2rolHZH03eDsoYR/N/J5jKB1hDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4895
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/2023 2:16 PM, Rafael J. Wysocki wrote:
<snip>
>>>> Is there a preferred set of tools that can be updated?
>>>
>>> I think you need to talk to distro people about this.
>>>
>>>> If not, would it make sense to develop a set of common kernel tools for
>>>> this?
>>>
>>> Yes, it would, but please see above in the first place.
>>>
>>>> In my experience, it seems many folks use tools from their vendors or
>>>> custom tools.
>>>
>>> This observation matches my own experience.
>>
>> For the sake of discussion, and from a kernel developer's point of view,
>> should the tools be part of a separate project? Or should the tools be
>> part of the kernel tree like perf, etc.? Assuming that this needs to
>> start from scratch and not extending an existing project.
> 
> It can be both in principle, but from the practical standpoint it is
> more likely to get all of the people to use the same set of tools if
> they are included into the kernel source tree.

Yazen,

You generally envision tools like this to only be used when there is a 
problem, and not something that's run critical path on every boot right?

If so, how about doing it in a high level language with easily 
importable libraries like Python?

Then the tools can still be stored "in kernel tree" and distributed with 
distro "kernel tools" packages but you can more easily use them on 
random old kernels too since the binary via /sys/firmware/acpi/tables 
should be widely available.
