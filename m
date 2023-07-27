Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5750765935
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjG0Qvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjG0Qva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:51:30 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2F9273D;
        Thu, 27 Jul 2023 09:51:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tf3cNDmR9ZSX88Wvs9iUEqPsTlsmtMbO2JHrw6pn6BMyt0e+hj0ncVOT0g/Jz1vwFQSi0hk07HiIRztcIMz5S1fX7WB65yDeLxumpC3xHtx309H1FVzz88WGGLYmkPJW2l5G0wuThOlv5RRKCN8NxwkO7M55UAxiQOEiR6YTXjwI1iQqQb2XJxLbiaW5apRjjqKmoWLlJpKY2lUNNNGHna4tSl4NVYwDMfliGJgroD/Ii4uaGkM2h3/rsxBOHEABlvCIzZJLwkuRe0PcjqKBQzNKQiwmALX6V0oGXSljoRrYDlsywObEGPLM8lLmB7uQ9jyvPgdvmc8Y1TGbwv9CTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puL4H5Rz/XNQOPAuTkzBkAwMEVDiyQm15Q16T3tcbmo=;
 b=cwiqHdyfXLCRR8eVswp1CF2YHU7P3oLJl6Ff94xw30CLtRWszqMDKeEa49hxbUJDoNwkoA4CEGC4+es61r/OfMYmo9H9/vchBv0/MnvWp8icOXwGzrBu7XbNZ/wejZ7AAVawNCDVNc6RA7F1k+obz0mNS8ZapawWd4d6hENB2KtdLV/1s1pYW7/Lk302pOdT2qipIAnlvD1tfJs2wI40pv3v7O9OhgQthsy0krMmQ+3dspSI+7kbIGqRA2jNxTiwc5Pxo6AIovhQZr9gFaLVNwbRjOgw+RNUiPw+n1sRrOLqHz4YksUu737w/OumAx8c4n67L7ziSoiULKtDM0yMqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puL4H5Rz/XNQOPAuTkzBkAwMEVDiyQm15Q16T3tcbmo=;
 b=e5NC9YG6XQxVJsubitNi1D1ox4W/agtg82YmJamoO+7IJ1wViK7266F5APtJ7s9CKSHJr407JCPOastbsU9HyX7Eyi7QZCmmxnL/U+PUGmQrwJujj2+lKuoAdGKNUJmjiO8NsA+SA5BWnpP7cLNZhhTl9+jRW2IrP1XCvAot0tE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4997.namprd12.prod.outlook.com (2603:10b6:a03:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 16:51:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 16:51:24 +0000
Message-ID: <67eefe98-e6df-e152-3169-44329e22478d@amd.com>
Date:   Thu, 27 Jul 2023 11:51:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
Content-Language: en-US
To:     Daniil Stas <daniil.stas@posteo.net>
Cc:     James.Bottomley@hansenpartnership.com, Jason@zx2c4.com,
        jarkko@kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        stable@vger.kernel.org, torvalds@linux-foundation.org
References: <20230727183805.69c36d6e@g14>
 <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com> <20230727193949.55c18805@g14>
 <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com> <20230727195019.41abb48d@g14>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230727195019.41abb48d@g14>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0113.namprd11.prod.outlook.com
 (2603:10b6:806:d1::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4997:EE_
X-MS-Office365-Filtering-Correlation-Id: 6183ed88-ae78-4ab3-21f1-08db8ec1b644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OQ10P9e4RQFqfMGfYhojy3CuKR3sTQJKN3KCp6SffXcK9G+f/nhuL6/ZPqSIFOUUOrzyqBaWSU2em+GHuPkpoch2XFyA8vuIKyGlIXYG/aCAd82BHtW1jib4KpVxNrKsgAxKqwIUkS0O89CJcBFHVloLNCcrcsepdFrri3/vBoXotcRbHfWvmFf/MxExUdlHrnihAkKdJQyTRkm2Fmu0hULmCP6zt/kDP16wGPYsd0tMWCxI5p0VSxJttz87auq61KTtXX+aN0qQ81wdqHyiDNdBSM8cXQ3WYx9Kq9hf2DzR7DZaZUAtfAEkglyi6ygpTYhkjJsPEm7oHqzmq6R0AgK6kMrhzaT01IwtsYjfUHOEjou14meXrM3BwnlGG8R0EhNyOByVy0U38oLiavtMDxEWJR2Ec/9GnbJQ/uyo+F6IyIkU+9u715sMsKYn/+xKuCTbul2trUDDSl6slmrHKfxH9ZwTzYaMoDnU9OjFZFzKQFsYTxaVce7s78Sovpb2Gkktqj7c/7zI+fFftBOfFth2XHveAg+wjOEgNb9x9Z6/MREdDI82jN5dwvQQtoniJ4E5Rx4F3DmwkjK7GttvoUbc4PfsLwV/44bVeLRPttGzBT5MDurOQmx0WMa7TbWW0NXh3ekhnIU24vY6+8Zlsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199021)(478600001)(6512007)(6666004)(6486002)(966005)(66476007)(2616005)(53546011)(186003)(26005)(6506007)(4744005)(2906002)(66556008)(4326008)(6916009)(316002)(8936002)(8676002)(5660300002)(44832011)(41300700001)(66946007)(38100700002)(36756003)(31696002)(86362001)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUhaazJmRFpkSms2UmdGcDBqZlp5Wkg5L3ZPSVg5bVpWRER4MjBPZjNDRTJu?=
 =?utf-8?B?RExvWkVSalpGczZTajRNd3Y1S05zL1lZYXQ2WHhCaXFjODJsOGNSdmhXQ3hK?=
 =?utf-8?B?d09DZWJ1U3dtTkxkcmxFVU5UUjJ4L2JRREZVd2o1TEp2MEVHQ3l2YXF3L3A4?=
 =?utf-8?B?eFRwcXhOVm1TYVFXN2FKNTI2em11dmNDVjZrWHdXcHJuOERxTkFJMVhxR3hI?=
 =?utf-8?B?T2hnSVlRYjZKTlZaMGlzcGhiYStDQjhRMlIzNGdqb2NyNEtCMGJ2SFMzOVN6?=
 =?utf-8?B?UlcyRjBqZ1lhSU9vL2t4bEcrcmIrTXV2a010aGRGMlVTUFVKZThTdzVOWVE2?=
 =?utf-8?B?QXE3V1l6M0JtbjdhNmpaS3NLT0pvajFidmdXZXNocE1MVUNlUHNiSUJIM29p?=
 =?utf-8?B?SGJCK3JoaysvN2d1QmxZNDJlQTNhTkNwaUpiT1lIOVM0OHNCakZPenBvRnJ1?=
 =?utf-8?B?TnQ1eXcrWUJROTFrOFJPUzdyNTdJd1QxWHRRMXM0TVE1THM5T2RDMUw1d3dt?=
 =?utf-8?B?VXFGRHc4VFJXMFQwYlhYd2ZtWUdOLzUyOGNLWkFTTkR6NXN6RjFRKzNkZGln?=
 =?utf-8?B?Y0RPOG5HeFNvQXRqNWN5RS9KS0phczY2REl0cVc5QTIwOHFkUy9NS1FkQXNT?=
 =?utf-8?B?VlFmczZWZUQyUVVQL1J0a0RKa3puNmtDQWJYaXZiZGN5NElqN01ZOFdZdUdC?=
 =?utf-8?B?Z2pCaHUweElpNmZGcElWWHZtcy9TanRxcTgxeGR1ajZLY09FMTRyQ2xiODU3?=
 =?utf-8?B?dTBKRitLeXgzdGpDT1FYblhTV05aeTdqYlNOYUlZVFFaUmVDK1NqQzFPN24v?=
 =?utf-8?B?T3pNQjM5ZGQ0MWloL1U4Y2Q0aGMyY1lTS0NXakw5Q1Y0SEtOTktqTGZTOEQ3?=
 =?utf-8?B?ckdJOFlNQmF0S2kvbU8ySHlyeUlpMW1FNnE1eVhydFFwaHc5QXg5NWZ1Y3Y2?=
 =?utf-8?B?UWtjZEM4MjhJNzBBR0tmaFBoWEptQWQ1YUI4UUl6Q1puQ0ozeVNjcGU2VHRR?=
 =?utf-8?B?WUV0NE02UmN6Wnlobk1VQlN6S0MzeWVXWTQ5QkFIUzRBcWk0aXpQcjcvWVFa?=
 =?utf-8?B?ZFl1UHMzUWtuVXR6Q01obFQyZXBEdWg3a25DaDhxL2ptaG54NUR6eXZwRGV2?=
 =?utf-8?B?bWVKekU2YkI2eVJSZHNuREN6bk9vYlNMVmZHUGNONnp1c2k4WkFoTHpSWnMy?=
 =?utf-8?B?b2VGNGVUZEppdGwySGt2RTlFNGhUajhZN0hZRDdNQWhxSVBNNGgwRGIydm44?=
 =?utf-8?B?bHVjblNockFURzEwNHJmZi9oM3lrVG44VkJBVVY5RzAyRjFUalR5YmI0K3Nv?=
 =?utf-8?B?Qnpvby9OTXlGWDdsOXYxQUVyOXVwRGM2TTgrengrVnN0OXNXWlZad2FhbmJS?=
 =?utf-8?B?MThXeUVkKzNkNlBIMHZ4ZVRWNW5lN0Znd1NjMXkyb0Nxc0NxT3NVUjk5dkRC?=
 =?utf-8?B?VkxzVVludlV2Y2tZcjZqTXBrSFFHcTNjZ0VRdDJ3RCt3Yzl3bWdxMWorVWxB?=
 =?utf-8?B?MHJrd1R6ZnJJRmUvcXNvVkM4Qkd4MUsrSDdSbndaeVZhUFJkejhDQ0FENFRV?=
 =?utf-8?B?UXI2YzVTL1hKajlGWmRRSkk5MmQyVlp6YmJleXhXL3dkaW9uelZ3QU83dFlV?=
 =?utf-8?B?ZjY0OWxrckJQc3Y0RVRCSmt1bER4U3ZValJzZ1pXdEt0YytMdU9TRmlNdDRi?=
 =?utf-8?B?dTF3TXBLaWZqYTEvMWhVSi9RSkd2TEZjVHNBM24vckF2cDNMcVJqdjBBQy8r?=
 =?utf-8?B?TGI2TG1OUmhUYUM4YUtzckFoRDA1SnFad0RpYUthTGl1WjZBQlAreGtJL0xH?=
 =?utf-8?B?bDN2czQ2N05kMG91bjNtekIwRk15eU02WjBRckswUXMya0RYVXRtbGt4SUZl?=
 =?utf-8?B?cmxXZ05maElxbmxRQmVmYWRTd3FadXpuR2VINkxqRzVlV0p3d1g2RnZXYUFD?=
 =?utf-8?B?N09EYXI1blNxWkxRRkF2UlBUZXdwZSt1aUhlTDRLR0Jlb0xnZjA0MTBYa0Rz?=
 =?utf-8?B?MUp0TEV6U2l4eGxvamFmSzhCckNBNXhxSWcxSUVsRzJ4SXdaSVU0T2d0endx?=
 =?utf-8?B?OU1XQWN1NXdIQ0t0dDR2azFoZGV6Y044cUJhamwybFIxVHFmNDR2VUw3bTVj?=
 =?utf-8?Q?rFeDkkLynY4aUMqhjrk6TNrhG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6183ed88-ae78-4ab3-21f1-08db8ec1b644
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 16:51:24.3060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shVWiAELGq49VpLCsbHVWC4rVn8ReWStwc9wJyhtNhLyhF5UflDSK3J5yIEDIGbho7pv+mT3uLLsF0uHY8PvIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4997
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/2023 11:50, Daniil Stas wrote:
> On Thu, 27 Jul 2023 11:41:55 -0500
> Mario Limonciello <mario.limonciello@amd.com> wrote:
> 
>> On 7/27/2023 11:39, Daniil Stas wrote:
>>> On Thu, 27 Jul 2023 10:42:33 -0500
>>> Mario Limonciello <mario.limonciello@amd.com> wrote:
>>>    
>>>> On 7/27/2023 10:38, Daniil Stas wrote:
>>   [...]
>>>>
>>>> Can you please open up a kernel bugzilla and attach your dmesg to
>>>> it both with TPM enabled and disabled?
>>>>
>>>> You can CC me on it directly.
>>>
>>> There are several bug categories to choose in the bugzilla. Which
>>> one should I use?
>>> I never used bugzilla before...
>>
>> drivers/other is fine.  If there is a better category we can move it
>> later.
> 
> I see there are already several bug reports similar to mine. This one
> for example: https://bugzilla.kernel.org/show_bug.cgi?id=217212
> Should I still make a new one?

Yes; please make a separate one.  If we decide it's the same we can 
always mark as a duplicate.
