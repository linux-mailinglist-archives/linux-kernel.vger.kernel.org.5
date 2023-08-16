Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1503377E443
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343837AbjHPOzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343832AbjHPOyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:54:50 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F692721;
        Wed, 16 Aug 2023 07:54:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJbHhJirFVW0FpS+dMUEANQQ4HF/enSny05CpxGv+LHY1PbAoXfxKGPxaWYl3sIicBrawd413HvGMfIv/Ayc+4TVf5tV0G9ygaOJ3g5rGrnbPu5Lh2hC4gq/98MVmrkY+25MppCxpAIjmg1VdwpjmGHAHBd/1hOtZUk+v8d5dRHzKJOH6DK+PQNO6hUohP+Dwjc6KSBM3gDoxk4HP78ldTjHCtEXQov8b0lHlEe8SwrVjZcnA1l7ggNzC5Bz3mH3ex4OVtdW8/hYsuKe9vpqW1VhEyTPZ71ojw2ApvoTQcgj8CtJOWfCcUWeQzNg+ET+HNoa90Qmqso/m0QbrbCG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFY7wHMunlUUheDmU7+A7Vag0z5dzOq6JHlg511tqDY=;
 b=d7i9DQx9fH93OKvGXn5eWM5qpYi9XM8XFw3Xosn7kmF7JzsvWftUuQXiZwYmzssKt7Ky9bUdE2iOqLmDGwNlEYk9JxmEOA9PIMDi+abQGoUhigNzZG0cpMLHXWfpENxA9GNKNr28EChhTZKwe2AaJvNGrAusaQzZhjV1Eq9wQi8H7AChQK3EJhYnAULe2giimRB5cDU62tlg3j5yX/UJT9TLwzqHm3wCFcGifwBhyfTO1MYRj8XSsx3elywxSAy5tZYEKxcf3SFt3pfKTgyVaLh+yq8LG6b+jb0jv7ct6VMm1FCg1OQtYtWMtYblK7A9e7QDUnhyAM5XvnknzeV8+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFY7wHMunlUUheDmU7+A7Vag0z5dzOq6JHlg511tqDY=;
 b=AcONHg24znEVvKuYOy7fUyPYJp3i2/nmNbNx5HSL2UgTzkm0WTI8AuO+2aSgle06+9BiHXh3KyC//8J2v2vrSYCwRytlxD1FnUkYAASKWuJrdY3R61n7FCwDwk1iJLWAlI3PQOaY9ZFOQXRRTJr9HUe+FY2BKSzG8O2OQW8nPOU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by SA1PR12MB6725.namprd12.prod.outlook.com (2603:10b6:806:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 14:54:38 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::1352:c7fd:4b4b:cc18]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::1352:c7fd:4b4b:cc18%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 14:54:38 +0000
Message-ID: <24698029-4c45-2292-ded5-13a6c12e93dc@amd.com>
Date:   Wed, 16 Aug 2023 09:54:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC] Proposal to relax warnings of htmldocs
To:     Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Avadhut Naik <Avadhut.Naik@amd.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
References: <85964510-4f88-58d2-2687-f7fa76013cf9@amd.com>
 <87v8dgtb9o.fsf@meer.lwn.net>
Content-Language: en-US
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <87v8dgtb9o.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0034.namprd06.prod.outlook.com
 (2603:10b6:8:54::18) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|SA1PR12MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: d74d2904-1caf-4b4b-f76b-08db9e68b6f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KhlneQeB4DsYa3BcdkjwInHnyoeoXMwPNkTK18kcIWtf2V9MbcwfxTIx7WozyqkJ2ir6Enl22sDm3euBKmOygf43nc9uk8usCW9EkBPXnM2xfOoIhk2Q5QM7JCXoUOANIgGL98uxgOoX5jLQPZ6ZkmMOGvRWMWfvOBkmiGZG8LxE2gA2QJnCszty916Vigjw9f+KcOrFKrhPQGDJmIMiUycyLKZRUbt7TTTgMbC2862TQjt5bFANdpa2ZUH9fvpmo0otDtRZvouAbhUkvCJNKHv6mCG++5896aAM5n9F9vwoGzbGHn8aYuRDGKHJF0r61T6oZO5VJnVQXY0VDYY7I1B1TKmewM3e7LUIVS+hcAS7fNxSTVyvjz7UefhUIHo44EdRSmwidJyTxbksdzfpD1yC70jsFsU78//6N36pqChyJEUqWb7OQKHtflBn53kzyhaj3CiDtLOtYDisUoc4zZvAJ3RIbdHe062qr3d3gM32a+Xeu8stQRvGvckyJZ+6zyA5touUie7n0ZWOdpjTyoY2E+GP/QUEfobIJgAP480toa3ZTF65N1VcCmoUlESwd7u8dMcctn1PAnyKstQo1bTQzSWxWNbmqo06P9l14KikpLC9uExRF+OpvDqXJF+6YnBmLn5r7x6NlWtaUbbomA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(54906003)(66946007)(110136005)(66476007)(66556008)(41300700001)(5660300002)(44832011)(38100700002)(31686004)(8676002)(4326008)(8936002)(2906002)(83380400001)(26005)(478600001)(86362001)(31696002)(6512007)(53546011)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFc2aWU2Y3pXcnJ3UExsekJsOTFhYnNhMTJNV2MrTXRlcXJqS1lheVQ5SEVF?=
 =?utf-8?B?dTNjZ1VZTTVHZ3FTNEVwalVSUmlhTkFJOEk0VzVWcG5RVG1sZHpNTnBTZkJZ?=
 =?utf-8?B?NzNvckQyN2NQdUtRdVFmejNHTkVMZ3pJM1FlQ2VsVUd1OUJZZHMxSytRZXk0?=
 =?utf-8?B?bEdJYjhzeUIrNlhxcHAvUDE1SzYzOEt1eGtrdWdsVTNGQzZhQkJ6R3IzUFNl?=
 =?utf-8?B?ckd2aHdQWjVoZG0wWk1vZmt1UjJpdWhXNEZRV1ZKZ2tpUVh3Y3VWUEFEYnVl?=
 =?utf-8?B?b2xxWVB0eiszK0NUTHByQ2xJUFVpSHNkV3NUcVBHMEFBeEk0OTlIMUdIUjYv?=
 =?utf-8?B?Szc5NCtJM29wVTl0SHAybEtsOURpVWI4ZDNXYU1WMyt3dVppcVExWmlMSVVk?=
 =?utf-8?B?cWtBY1J0SWt2T0phZ3NUbXp6VVd6VzJMaGdpcFdnZ1lSK2c5aDNkRi9LaE1E?=
 =?utf-8?B?c3BEU3pLUWU0MXYxSkRFTzk2ZzBpamZIRnBFa2ZrQzJnLzlSSDRMUmZXcnY4?=
 =?utf-8?B?WmpJODVTL0l5UTZpNFlDVDdFd0x4ZEhKa01URkFwYTltQml4MkRsbFBybnVT?=
 =?utf-8?B?SnhVaUNyS0dtTGJKTEZlMENwcGhRaGN6SmE4WVRvbmxLZ3l3dHBKS2ZCcWxa?=
 =?utf-8?B?MVhNR2Z5REJReXZMaVE0bDlwamd6Y1I4OFlIOFNNMXFrVExZNWJyejQ2cE05?=
 =?utf-8?B?OCt5eUp0ZUVENmEyVEgxRkZQTnlQUHZMaGNJSHpFTTVBSm5HbU1xWFcxQmJk?=
 =?utf-8?B?aURSZHRYWFplVkxUSmorZjhBSFhwUGVqL25iOTl5bUk5T2hoRDBXNVloTDRQ?=
 =?utf-8?B?VmJuSGFvYzhzQVViMHFVbFAwSG8xTlMwVldKc1IvNmhZd25WNXdablpUTFhk?=
 =?utf-8?B?dDlHcGtiR0ZZTmZZN2JTdHdzVDF5b05RYmQ5YmVIeURmcCtYTG1vakRJRC9k?=
 =?utf-8?B?UFlrYlUwbWw5YzgvbG5HQjRtZDI2cThWSThUT0RHQXU3RjRCWGRWKytmczlI?=
 =?utf-8?B?TjFRMk5RUmMrdExnWWtCL2dHdm1FcEJIMXpHcnRrM0M2VjVCazgyZlJKVHVF?=
 =?utf-8?B?TmpwcHZ4d0Q5VnhYM2ZyaWRIcnhKa0RSUTdRMFBic0t4dkR3Mk1na2E5czEx?=
 =?utf-8?B?VUgxV3QwUUczMmdKSEs0TnJkejZ2a1RaZWJNMWtuRFhFSzd2RlFOWHJwRDRp?=
 =?utf-8?B?alp0MnVTOC9vWlRWeDZ3Mng0WEs3K00zRVc0RkRVSS93RGo1NExUMmxTQWY4?=
 =?utf-8?B?KytKTVZubnJ2STJnekpYVjlxckMxTVl1dlBZaThxUXFudk0rRGVqUVZJYU45?=
 =?utf-8?B?UGY0TDZpRDJxQ3RUVjZQVGo5S1pRVGFBNHF5SDdQVXYwellKdVpFSnNJZkFw?=
 =?utf-8?B?K3hNTGtGdGZmUHB2OXpTM21DcFdHUDZwVkdKU0hGSXZlZVRtOEdwZzJsellY?=
 =?utf-8?B?ZE9oL0tsL0k2ekFaak1DSk5YVThGWS9wYmJUTm4xMWVDcFdUanpzM3R6L2l0?=
 =?utf-8?B?L0didWZMTmY1VFp6OVMxMjFGMWdFUVEyNnF6RHV3citUTHVlR2UyeWFXcWxt?=
 =?utf-8?B?QTYrZ09JZVlqYk1KeWpYRllFaGRyV0dycnE2M3lMeWptbGRlbGhGUFdycDhS?=
 =?utf-8?B?S3F5aWV2UG14Qk1GeGEwNlZVQlNTZ2dTRWo1cmovRVFrQWRpU0tnRE93NTQ0?=
 =?utf-8?B?QWZDcmUvWmpXRWUvOG15QXdMbXg4Q21uY0I2U1pzWDRvVTY4ZXQxOTZVaHBO?=
 =?utf-8?B?K1RtMjBiWXRWckl1T3B0R0xlZys5Ylp4d25FZnpCbm1xeXVvSmpjbmpBa3F4?=
 =?utf-8?B?WHJUU3RWckpmSGJ5UzZlQThOMVd6NFJ2Z1Q0djgvMkpaWk83eENxMU8xVDIw?=
 =?utf-8?B?TXU2dDdCN2hWMmxaZVJoa3Y1NXFjSThTUktYdm1tYVRaSXQxd1NKVHdEOHNa?=
 =?utf-8?B?b2JzZmNpREo1bnRVQk5SQjVnMldxYVpjbitjSTY2enlPazhIcWpFRVhTU3Yw?=
 =?utf-8?B?Y29rNFo2cHk3N3daVDF2bjB0WWVaNVhZMXBROENQRDRKMW5WWGtTWjB0RmFU?=
 =?utf-8?B?RnNJNmd2THorYlhjc3h3dGZKdC9DVHVPc29WMkZzaE1nK2ozSk5DVVVKRjBM?=
 =?utf-8?Q?2T1ZsbYDPowGjpjVjdFuMeK93?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74d2904-1caf-4b4b-f76b-08db9e68b6f7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:54:38.7981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJrQuirFFdFoNTRiIJehJ4+k/2xuklDFf4tPu4tG08T25K0M1UcPHyhleXywbRL1RSNqRtN6eyvr/sDZDrCwHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6725
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/23 13:23, Jonathan Corbet wrote:
> Carlos Bilbao <carlos.bilbao@amd.com> writes:
> 
>> Hello all,
>>
>> I would like to discuss a recurring issue that we all have encountered
>> while running `make htmldocs`. The process often generates an overwhelming
>> amount of warnings that are not relevant to our work, which makes it harder
>> to identify and address actual warning messages related to our changes.
>>
>> One of the reasons for this is the variation in warnings raised by
>> different compilers. For instance, the Linux kernel robot employs Sparse,
>> which recently raised a warning that we (Avadhut in CC, and then me
>> reviewing his patch) did not catch during our testing [1,2].
>>
>> Particularly annoying -to me personally- are warnings of the form:
>>
>> "warning: Function parameter or member 'field' not described in 'struct'"
>>
>> that seem to enumerate every single undocumented field within a struct.
>>
>> I would like to propose something to alleviate this issue before the list
>> of warnings keeps piling up.
> 
> ...other than fixing the actual problems? :)

I'm happy to fix as many as I can, but there are obstacles e.g. some things
lack documentation, such as undocumented fields in structures with names
that nobody but their creator could decipher. Also, that won't solve the
underlying warning display problem (which maybe it's W!=1, as noted by
Matthew.

> 
>> I suggest for the command `make htmldocs` to
>> only display, by default, warnings directly related to the changes being
>> made, unless explicitly requested otherwisee.
>>
>> I'm thinking we could do this, for example, by making hmtldocs a two-step
>> process: First running htmldocs as usual but with warnings disabled, and
>> then generating docs again but only for the new files (see $git diff
>> --name-only HEAD), with warnings active but limited to the scope of the
>> changes made.
> 
> A normal build should just generate warnings for files that have
> changed (since the last build).  Does that not do what you want?

That's not the behavior I see on my system, when I run `make htmldocs` I
see many warnings from other places.It floods my screen. The default
behavior appears to change between configurations and compilers.

> 
> Trying to get Sphinx to do smarter things with partial builds seems like
> a path to frustration.  Since the specific warnings you're talking about
> are generated by kernel-doc, a better solution would probably just
> invoke it directly.  It wouldn't be that hard to bash out a script to
> feed a given set of files to kernel-doc and see what it says.
> 
> As an alternative, of course, we could consider turning off those
> specific warnings entirely for normal builds.

Thanks for explaining, yes, looks like kernel-doc is the place to do
something at.

> 
> Thanks,
> 
> jon

Thanks,
Carlos
