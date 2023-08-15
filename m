Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752BA77D276
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbjHOSuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239579AbjHOSuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:50:16 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395A31BF0;
        Tue, 15 Aug 2023 11:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdZcjbMUwJWtX3QGbof29LHyx6mc3K+T04YJILcE1Cd1lk+Y8Rn0NJuB7fGnsLuDagKji/vFs5s16Ov+RidrVkfcapPsCnWjyxCfT7zj7NmNGime2z70FwNfT7kuhE0lVjuYGeGsi9HQtULfOzFHe3DmrAdeNYH76LrI8w12xNK1GauL86Go5x4c/DXIacInIKmDDVjNaOYrStVUg8yhk0V7+TVwmotQqQwRJAJtIPlRTIZ/reQ4LcwjWp8w1tfzzH4xaG1mN5e9/U9sq5qqG2gaD4jeCzcndBXo5+oiGPMZAV7lN+2nb9zUBqrXjgNJu3hbRqrQAFSpkgleRqvAAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMN1KB/CHtPUTqyNohee8SoELey9z2+jxcRHsSkymIw=;
 b=RQmvZSu9ZTTwoFvmTBH3N0R5H9sLkFnXylCFPZr3LohNqQC87pc/oYxBOBsyqFbiAzPfwAF7LbQHJKBG2XMzMVKMBoyRNQAwECt1y3Xw7TmqP8tEIvKp5Rm/iw8Kz+3ijAhpCBUECXSixu5DQKnnv6KvWdil/z3MXDjlRdDObX042UR6LebSTAapuQB4R6EraucFByVkDk/qgUrchLGwnwaA2PKYhDrpFSFVgo1MzGVvTQZg2L16LWHvIm1XP7GK55nWgDa1ie6OVi8PZNynBWNSg0SPOT7RxxLD0h3/MiENWG3EBJwfu/jdoxk3jbc2qYl8jPfCGEEksof7Q+ng+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMN1KB/CHtPUTqyNohee8SoELey9z2+jxcRHsSkymIw=;
 b=TEA1dP/16rnY6PJUr+3ghsaJCqoxtOijkHJQ38IUtkNkTGffG323wgs99p3SrJ6TnXkWl9v5fF8SQa2Mr3bConRjl/EA62NhQlvgR2LUOKTsoH2TGQglfnTAvuhRpsx23jqWUoEK3hYLvYbpDa5ihhGEVMpjdzE218/X2/Va8cs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by BY5PR12MB4242.namprd12.prod.outlook.com (2603:10b6:a03:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 18:48:47 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::1352:c7fd:4b4b:cc18]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::1352:c7fd:4b4b:cc18%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 18:48:47 +0000
Message-ID: <bc03e31e-8765-143b-9b1b-33ce0768e3ad@amd.com>
Date:   Tue, 15 Aug 2023 13:48:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC] Proposal to relax warnings of htmldocs
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Avadhut Naik <Avadhut.Naik@amd.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
References: <85964510-4f88-58d2-2687-f7fa76013cf9@amd.com>
 <87v8dgtb9o.fsf@meer.lwn.net>
 <CANiq72=8DH8SZS2TZF+nHzCq3onXz-OuyE-xmYZncDmiKqVfzQ@mail.gmail.com>
 <ZNvGz4v2QYowrhk0@casper.infradead.org>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <ZNvGz4v2QYowrhk0@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0079.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::16) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|BY5PR12MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: ac55ac8d-50dc-4d2a-406e-08db9dc04257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9kh8yy8B91u7sCz/KS7UOTAP93NJlPgyvBrg1U3Gj7kj3IpeCHlplbn9BpGK94NpgNdMYaumDBar/76Z7RtIFHvR5r13Z66vQwBuQo8e5F0Oktpg33ff96ovmj4vd+3WKJ99u6T3GDGoiBjykjTADIz0rjOOWuF+ngIsNieQywQeUnDXmknZ0JHuof7IpaIuD9+NcVfhzGNHbj9LWKnzqyUrj1rnx8kdYA490DmJVjxhc6I7DHeq2VIp2NMCFCATfPH3E6NEdzYMcibHfTH8nTAz+Rj4C4hEH1YoQ1OgtvNadpIxVgJSSIdCe26jVUSVSNhqO9HYE/VCSyV3ssTKzytFqM6zlqXf1gOWD1k3axVNjQkqw1HjR8f6avtouq3Ybxf/ctcbJ60aBnXL7h5PheocNd7jFvifYEN58sItVX6etLsa4IoW3T+mu4twwH/FrDC/pIAPC1+BLvEGMAeekU4NLT9USYA4MJS2MilvkASwK9jcV+OLHfe22MZe6SvNivWW9Izf4YESzd+/iYRgKE7dVEB3TPuaiHOFkwJOvhR+xPRjDefJK8roYNyO8EP5QEZf6c6D2RY/mk7Z/dHTH+oGQas5dNoQml+NZ2wLRGhm4fksHqUxc/2GF/sKxu2vV/x1EQE6V8nZ4f3teV10Nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(376002)(366004)(1800799009)(186009)(451199024)(26005)(54906003)(316002)(5660300002)(83380400001)(8676002)(66476007)(53546011)(38100700002)(6512007)(6486002)(2906002)(31686004)(478600001)(44832011)(2616005)(6506007)(41300700001)(66946007)(86362001)(66556008)(110136005)(8936002)(36756003)(4326008)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGd6TGNzMExieGN4em1ZWVlBdGhyT2N2NVY5VkIySllzd3YxcmltcnloSDZm?=
 =?utf-8?B?OXhjd1BMTU9hbWtsMlF5WHAzN1lRSDhobzljU05mckdMUTF3c2hSbzN1N3NJ?=
 =?utf-8?B?bHZuU1gwaWNPMk0xUFkzMktZY3FNOU4xZnUwVy9YYkFraUtYM0pPY3UrKzFM?=
 =?utf-8?B?Ukp5WHRaSDQ4NWljbiszWlJmSklpR1ZBQmppWHZoT1pYYkYrU1R5UjI1QVVW?=
 =?utf-8?B?c3c3Zjlkb1NScUk0Wm05alR1ZSs3elRYeWN3N1k4cmREYmRjZWlYWFFjOGJO?=
 =?utf-8?B?SkpJd2JMY2Y2Tmp2Wm5wdUREK1pkOTNTWStHVlVUdE1YbzRXMk8yOFJzclAw?=
 =?utf-8?B?NUZJNnhReTNMa3FoSEpHSWJWa1RkekVTWE1CTGdIRDFpdWNCNmh3ZnZ5N21j?=
 =?utf-8?B?Wm1ZTTBUOW5UVVVvaDdDMWZhUVM1VEs0REc2SzFWbVpuMmx1NkRnNEdhb2lC?=
 =?utf-8?B?bXFmenBqSjhoVGZKK2YzVWl2N0pEWG1tV3dHNktHdUZBVHlTbzB2enl4L3dJ?=
 =?utf-8?B?VWlRRWUyRFJKR0NhYjRjUnYySGIzdGRzNi9Pa0JTWmpFeUxVQitWVmtQSm44?=
 =?utf-8?B?QjZkMVpJbUVnajFDK1h5aUxRR04zTDZ5NDlxZEFYb29WcFNjV2R5RWtQNWlG?=
 =?utf-8?B?UTE0K2tUYUhvbUFrME5UQW9PMzRmWEhObzVNRXJndWFuMFdaVFhKbFVCYTZY?=
 =?utf-8?B?UDc4N0pyUUhuRkc0VHYrbGlONCtlOHVGUGZIVjBROE04c3UyT1M5cXlGQ1pu?=
 =?utf-8?B?bnNrVGRJWnRVWHVXbW1rV2ZYa1dxNXM2bGtUU3FtcG9OK1lxMHRuWEIyRGdZ?=
 =?utf-8?B?eVYrMUQ5L0FlV3dzSTFzaGtuT0xVemorTksxOW5IbnV0TS9XOGkrQkJoQTlo?=
 =?utf-8?B?VXdOQzVvaXgzSWFNdDVERklnVk5sNWoyaE9yemVUbUUzL3hUdDJROU1yVGls?=
 =?utf-8?B?ZVpHeC9KV2ZpRFlnNWFzbVQwZXRlbzY1SXYvQmtZeWNPcWZSRjZZbGpGaGtB?=
 =?utf-8?B?ZEt2VXVkRkppYkhBMUFwR0tQMytMam5vMGhRUnp5RzZxZk1FUi9IcUV3RU5Q?=
 =?utf-8?B?MkF1LzRiTlFzL1U3aUtqT3VqaGpmU3VQdGw1cXBwNGtTUzQybFpXb2dva3o0?=
 =?utf-8?B?cnJ0cVU5OG81clFHclJPc0FhT0NubDhVc1lTa1pJUHJLaUliQ1pHR1B5dGZ1?=
 =?utf-8?B?K2FOZWVXMlY4MnhYNGdWQ3lTMEkvUlBLbnlPKzRaL0RUcEkwMzAvZnFzcW4x?=
 =?utf-8?B?eG1hMTgyV2xUU204WGdoSDRUS3lXdkNkVSt5cTJPMWR3SkVTbk9EQXd4RFVi?=
 =?utf-8?B?QUhMVzBrcXdXREhLYXVLRGxFczZRUEg4VmU1YzcrUmY0UjJVL0Vwc2hJNmli?=
 =?utf-8?B?UzAxRnFKVUFhRG0wQ0VIRkEwN2xERE9LSlRIQnd0a01WZ0dlbGd0Z1U0ajdC?=
 =?utf-8?B?TUN6dW5SRUZqcUxLTUdqNlN0d1VsbHB4dTdJYUlxU3VkM2tQSVhKaVp6RjBL?=
 =?utf-8?B?aWNvaXJjcjhmY0JyQVFJaUJZQmRQRlFDNUhiRFBqSmRBeEYrYzJFRFhYVG1E?=
 =?utf-8?B?SENWTXBvc3B4L3UyZkFCQVJtVmZwUWtOWkVINFRmZjlCM2dYRStXME1rTVIv?=
 =?utf-8?B?N1F4L29Kbno5SitXR1UyeTdTR0dSUUFWMnVaRkdRVmpYZkY3TTcyc1pRZlV5?=
 =?utf-8?B?Z2p1NUtCTEV1QXJubkR1elJSWEtDNVF2NEl0UWlTWXFFY1BMc3V4U1B5Tkxv?=
 =?utf-8?B?VFkwVHB6eXAxdWJISjhZRGZ4c2FaeTVyaHpPci83Z2cvOE1DbHdtaFlSUGFU?=
 =?utf-8?B?WVBlSlo3SkVLVjlOeldVYkg2dVFybVJEb3BQcXhPQmRsWUNEM0hpTDd2dWFC?=
 =?utf-8?B?K3BtREJLakFlck1VbENhM1loVzNyM1ZQNUh3Rm5jUmFXcUZJN3NoYlQ4VWhk?=
 =?utf-8?B?YmtWSWc5V3gwMGlkSGVXWHlXcU9GTUVyQWpPbENxcXdiWWF5TnJlbFRDMWVX?=
 =?utf-8?B?K1V5SnU5Sktzb2x6UWY1eDdZNld3aUN4R2pSTjE1TVprK2k0aWZHNTZwSi9K?=
 =?utf-8?B?SzkrVGY2SnVCeFZHTlZwOVhVOGhhR2FMT2NQWExqZkx1LzgzejIwMHVzeFhJ?=
 =?utf-8?Q?wVPJZwbzlvvBMXuFLGr7vDGj4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac55ac8d-50dc-4d2a-406e-08db9dc04257
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 18:48:47.7243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PwTH8xpkJ/i3NxfU503ieuk7e6zyPC1N/omt3Kfvb13hzNJKdfmsdPN5IXjW4Rb0xQVFgALzgxZDbnBTYa5FZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/23 13:41, Matthew Wilcox wrote:
> On Tue, Aug 15, 2023 at 08:35:40PM +0200, Miguel Ojeda wrote:
>> On Tue, Aug 15, 2023 at 8:23 PM Jonathan Corbet <corbet@lwn.net> wrote:
>>>
>>> As an alternative, of course, we could consider turning off those
>>> specific warnings entirely for normal builds.
>>
>> It could be nice to get to enforce warning-free builds as soon as possible.
>>
>> Perhaps we could move those to a `W=1`-like group and clean them over
>> time instead? Or do we have that already?
> 
> I think the problem is that we don't run kernel-doc by default.  Instead,
> it's only run for W=1 (and higher) builds.  That's why Carlos doesn't
> see the problems he is introducing in his own builds.  Of course, if
> AMD required building with W=1 then they'd see these problems earlier
> in their own testing.  Apparently they don't.

AMD's testing practices or standards are orthogonal to this discussion. My
contributions to the Documentation effort are entirely voluntary and
independent of my role at AMD.

> 
> Is it time to just run kernel-doc by default?  There aren't _that_
> many kernel-doc warnings now.  Not compared to how they used to be.
> And enabling them for everyone means that new ones won't sneak in.
> I haven't timed how much extra time kernel-doc adds to a build.
> Perhaps that's infeasible.

Thanks,
Carlos
