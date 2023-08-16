Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A711E77E6EB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344901AbjHPQsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344938AbjHPQsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:48:13 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB8A1FE1;
        Wed, 16 Aug 2023 09:47:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLnEmCS1qxOTfnhFG3V/K2babUJHgi94VmLE+Wm3+/GCsRuKios2kPArukSaeYLQZnatur0dRJtYZIUsNdMOOaMnXSV+vKe2M9TNQGBeWo0ES1z/kdmy15uIg2LpwoQ0hoyMqx4KSGxC7HcOF+uXXm40cjnqh6z6XrVQT7JbYM6lcJUl62RIZEOc2KEv92QOIwUy7/ae7Bd3yc57/EqAdqmfjn5Gnp1RowHP9dv2Sx4LaVNWmFw0s2aa1033h0aHe+wYg8XC3Zf2/U8WqSdYp8TuyRgQKHEiXhDbz56n17ogdkvUix9NU+8+gtJ3J7ru6eXSL1VpbP8DcumM0Bo4qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UL2xC9qdHcBq8vWwEhlTL8626SSgF6ALCHpIhMlEJLg=;
 b=JoclJV0dDkm1kuDBX1WRpDGOJYrHEHte5SSZRJa6tuuKr8L+vuXLuokpzH9+0S6S6q0BakUhbBj8SgxEGl/t9D/IUdMB238NfYWFQhP3wnO4K6Ykc0kr8CN7b3KV/jV7RnjZtzsrwOvl3090EtmZgufwBW5g5CQO9HYrhL3Z/oEIn9i+FJGWjPlNRsUj7nyi0ISsLi3ehnW4ZPglRkQtQIBOvWKgGXwZGvq3gAFuhNWnQbk1bWNSIo8/GflVeWsYJHYotPId1DNPg9zN/A6uCa7pi6hurH89BsjoosA5pVwnZKyJD0EvlAZbY7UzkNeIKo3NTE3eR6eOuXDIbNHZ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UL2xC9qdHcBq8vWwEhlTL8626SSgF6ALCHpIhMlEJLg=;
 b=elG24eXeUxx3gCdoft59WGOZVRJ8kTw39UrZlRlmlitZHSMjawytqLoM6u9nu+xrD2O0OtBxl9jXwmuCp6xtmrmIyKZBI8dNgjdfhejXJtwhtQ1TNS9w4oF3TrW5N7bqx2IlC9tpqmHgfZuRtRlUEo74gxwX78JyDYZam6NAxWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 16:47:44 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::1352:c7fd:4b4b:cc18]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::1352:c7fd:4b4b:cc18%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 16:47:44 +0000
Message-ID: <0409fa2a-6a0e-49ba-1320-c876d2b7a9b2@amd.com>
Date:   Wed, 16 Aug 2023 11:47:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC] Proposal to relax warnings of htmldocs
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Avadhut Naik <Avadhut.Naik@amd.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
References: <85964510-4f88-58d2-2687-f7fa76013cf9@amd.com>
 <87v8dgtb9o.fsf@meer.lwn.net>
 <CANiq72=8DH8SZS2TZF+nHzCq3onXz-OuyE-xmYZncDmiKqVfzQ@mail.gmail.com>
 <ZNvGz4v2QYowrhk0@casper.infradead.org> <87bkf79row.fsf@intel.com>
 <f7d0e554-b6ac-49ee-4caf-640967bc1053@amd.com>
 <ZNzoEVYE1dTOnni4@casper.infradead.org>
 <16011802-fb29-da56-a1b9-8cc1182dd449@amd.com>
 <ZNzx9IAtsqP3KC/P@casper.infradead.org>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <ZNzx9IAtsqP3KC/P@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0056.namprd12.prod.outlook.com
 (2603:10b6:802:20::27) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|IA1PR12MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ee2364-56de-48f6-3b9f-08db9e78838d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: INsr6grCedk3IlxnKD5yYVmUAX1W/tIm395RJo5PyGX0VusQV0X+tkA79ufUMKYCmET2B6G2fl7x1SqYJsepFCoLU9RhBgKRYoXbzBOcUJwrvMZxTMcjFGi4bLiWS2DO9QhXm55SUyi/vb71A4hFvJX4T72Z5Tsnjb61ubr6OGvdY/wCS1jBce4Dtm9tN4Fv35lC5ZeugcnWzURzdB11xUwzhW1+yiz4qooqBM6iXMlvQYq+k+mtGsMruZjTCvUqaOt0pCH5/1tG74iYokrqQxMJRcAuva+qZ8inlDE+LkWi/Egxf8aDYGNAtSC0lnZZ51lxdIga9fzGZ0TKI2GkahjG4n/oXD5Lx34p/5TWNv5sQ7mJxbTMy8k6HJd9/gwKlANGZMNiBW8Q5w0aRjDDVzHYL8eUBIbgVvMMsnBqhRjtccZ/BIlX/xQm3jZ49IYLApNc33wtpm3pJY/gzEYG0kGI4v4PYHlcP9aLQWK22Yjs635hBfKI4W9ppaS6P7rm3GR031zozU4T06+Fz4vK2O+IeDuYPZrtnb80LdpkfdzbXyWg3Mk4p8y0MNX/hEq3EmfdPs8XJQY36RzW4hUUXncy5zHNhThPEUErQh1Xa79571QTIUBrzgNrmcua7SPXKBQCA5bAFTmjFn4DjdWiJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(54906003)(6916009)(66946007)(66476007)(66556008)(41300700001)(5660300002)(44832011)(38100700002)(31686004)(8676002)(4326008)(8936002)(2906002)(83380400001)(26005)(478600001)(86362001)(31696002)(6512007)(53546011)(6506007)(36756003)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUpGSXpZc0lxZnpEZzFPRnlBUk4zT3EwcUV4NXZYVGxtZnMrdWtMT3dXeGFv?=
 =?utf-8?B?U0dkYUpvc2JJWHNtaGYvYmZ2STVsT2NwOVFGeXVlaWxCVmV6R1ByMmEwVFl3?=
 =?utf-8?B?bTNVSkczaFB4TnNwNWVlNGhHMmNiZEhpWW80bjlkbDVzd3ZyY2NFcm5oeVRY?=
 =?utf-8?B?dFc0OFJpNTJVczlIcXBpRjZ2QTZndEZnTDgxbStaQkR2cmVJQlVNUDQ0ZFdT?=
 =?utf-8?B?SHpEVUpaeHFVYVE4NzhKRWZ5S1JzVTl3c0NaUUJOVFZ0SG8xa3hxTWE5YzNB?=
 =?utf-8?B?SDBsQWp2dEk5TVg5SHNneHFiOVBpZDVZcHBDalVZWjh5ZExVQ080OVc2L2ZZ?=
 =?utf-8?B?UjhKLzRvdTlkK3RaQmszbGVRa1FxeXR0aTREMGp6ZG1oUVB2cFJMREE4Z0hj?=
 =?utf-8?B?OWZYNE1aY01yR1dldGdSODlCa0RMNHhoSlVIeHhrcTYwMGN1cC93N1BaSm5P?=
 =?utf-8?B?NzRMNExIZ09TK25FdzJJNVV3UXByNHlVcTBRc3ZSdkVaL3llZFgzR3NrMXJz?=
 =?utf-8?B?L28zNFNSL09OSTZCUUUwUzRFOXc5TmJwbGwwN0hnckt5OEJUaC9MQXpEYWRR?=
 =?utf-8?B?Ry8zbm1jamlGZXVkTC9PbkNIeEhCZllxejFJUDdxZ0hCNXppTVZ5SEw0ME5s?=
 =?utf-8?B?Z3g4TmFQMStIcFVWNHk1dlIvbG1MWnJza05pWmJ4dGNDMmdQV1hmMVNaajRW?=
 =?utf-8?B?clRpSVo2cy80QkM4RTk3R1lsT1hqUGtKVlZhZmFrRDExd0pCUHZFTGwvS3Ev?=
 =?utf-8?B?TVc4MDEyOU9OaVZBU3I2UENieVAwYWJDS2hjUjIvcE5RYVVYNjlMZ3NCT3h4?=
 =?utf-8?B?UGZGMlhqODdmOFcxN08yeUlSOGIrUUJYVmhBUTRxdVdWVmovS05FRXpzOFZj?=
 =?utf-8?B?Qm9wVFZWeHNTVmJ0U3lrTk1tajgyeEwrVVpYeU82MGN5YmNZUyttVmlraSsr?=
 =?utf-8?B?U09XWW11YzFhT2QvQ2V4bUk5dS9VcTFBNi93QldTWUk0L0R3Q3hzakViUy9O?=
 =?utf-8?B?V0VFQTA0Z0JiRTBMU2xLQmhhRCt5QTNNbTJSVDN3VFVFME5wb3pjb0tuQm1U?=
 =?utf-8?B?cTk0dUNsWmRNTGdCNS9rMW5kYXR6SGZ0Qkh3ZkJ1OGR5a05Pa1BHM2hEemc3?=
 =?utf-8?B?STZZUlM3MHRJY0JyMGRoc2tCYzlCNHYxSW9MWTdrMTE4UmVJRWFJSDhTNkI5?=
 =?utf-8?B?MDNURFNHTjNINXR0blNsVDVacjk5c2s0UHNrZmNOd2l6aVB3dWt5QWZnY2Zk?=
 =?utf-8?B?SkJFenh0RjBXeWFHS2VueVZKRE5NRGV3amwvMzZGSFQrT0liQ0ZydjVVd2N4?=
 =?utf-8?B?UmE3OG10N05pQlFFT3U1NERxVnpUYkNlM2dWeTlMVmZUdzZCS2J0Z0tiVzZM?=
 =?utf-8?B?dndIaDluYzZ1Qis1cDlFZnh0YkJOKzRrMExGbU90RENSQXRGNWUzTUMwTysw?=
 =?utf-8?B?RjZDK2R0d1V2bFJqUXZ5RnN5VDBVMXNQZGc5OWh5eEd1NmdXcXZwSWZxdm5o?=
 =?utf-8?B?ZXNxbS9GR2p6bTkrUmZobUNvaklZcEdvYnZMUU1OT0lQbjNpdWVxbkNuVVVw?=
 =?utf-8?B?b29vT0NFZ3crMmJYSmg0QVA4UmlQT25ZcnhlZ3A2dDdwbTh3T0ZWcW90QTM5?=
 =?utf-8?B?djdSY2dmZVIzQnZHU1ozOGtpTnVubG5Oa0ZydC8wMndMS3laMmNneWhHZlVQ?=
 =?utf-8?B?MGtsQjdraFJheEFrbURtRTJhRkVHWFRYRm40MTNKVFBKWEQxcWE1RkxuYzk2?=
 =?utf-8?B?VHdtQ05neHorME84c2VrZVE4UEpMbTduU3laLzhWQmgxQmI1SDNNc29iWS9t?=
 =?utf-8?B?TzlFN0l5dDViWjRiQnJ5bmlIbUlJZlpsMzVRbXNpN1JrTGE0b0MyMi9WbCtw?=
 =?utf-8?B?VVExa0xmV1BIUFRieThkMkNQNmNFaDJ0ODNhQVdVRDdVVkhOR1ZDaEJFZUVE?=
 =?utf-8?B?TWpoMDF5RHBjS1hKc3orWEZnRE1qWm9QQXRTUElEM1ZmejFHVGp4MjlkdXRZ?=
 =?utf-8?B?MUhWcnhzMThKdnRVS200UHhIMGx5SERhQ3RYVHBpY2lOUUZGcU1HNm5uNlJW?=
 =?utf-8?B?cEZoLzBoV1BrMnlkZ0FiZWltelBWMEd4a2FmRndOMWJ4T01QaG4yeklFNG9x?=
 =?utf-8?Q?ud5XkHp6YP/KYMkrwbawvoe8A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ee2364-56de-48f6-3b9f-08db9e78838d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 16:47:44.5429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQLvuMCSF8qD1oKtUxUJAHQwTXHf9yZa+hcKOn10J8FuNRbtn8WkKMgWskBbVJRcj+E46QICs6tw0rcLpVrkkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/23 10:57, Matthew Wilcox wrote:
> On Wed, Aug 16, 2023 at 10:21:07AM -0500, Carlos Bilbao wrote:
>> On 8/16/23 10:15, Matthew Wilcox wrote:
>>> I wasn't proposing making W=1 builds the default; I was proposing
>>> running kernel-doc -none at all levels.
>>
>> More strict warning level, right? My concern is the same.
> 
> The problem you're seeing with kernel-doc warning about undocumented
> fields / parameters is due to people not running kernel-doc -none.
> So I'm proposing this:
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 82e3fb19fdaf..52f57c0c5227 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -100,11 +100,9 @@ else ifeq ($(KBUILD_CHECKSRC),2)
>           cmd_force_checksrc = $(CHECK) $(CHECKFLAGS) $(c_flags) $<
>   endif
> 
> -ifneq ($(KBUILD_EXTRA_WARN),)
> -  cmd_checkdoc = $(srctree)/scripts/kernel-doc -none $(KDOCFLAGS) \
> +cmd_checkdoc = $(srctree)/scripts/kernel-doc -none $(KDOCFLAGS) \
>           $(if $(findstring 2, $(KBUILD_EXTRA_WARN)), -Wall) \
>           $<
> -endif
> 
>   # Compile C sources (.c)
>   # ---------------------------------------------------------------------------
> 
> Now everybody runs kernel-doc -none on every build and you don't get to
> see that problem any more.

Understood, that should do it. I will also try to fix some of the legacy
warnings. Are you interested in submitting this patch? If so:

Reviewed-By: Carlos Bilbao <carlos.bilbao@amd.com>

Thanks,
Carlos
