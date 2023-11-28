Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EEC7FB098
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbjK1DcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 22:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjK1DcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 22:32:17 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2139.outbound.protection.outlook.com [40.107.93.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EF0C9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 19:32:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRvm9FuENhbmqUpapiFqiw1bsr9TvNIvoIUSQaSCcHdEvDzY+Is7LnmoZeTa8xnZ9Fbqfc+TmwgBGaxNZcSyR/dRbpHI1iRI/X+pOtQmVLcGhSLOxpaZr/8XuxJfsC0aJc/AI6YSLQtqVnkB6+5HUVI59xobDxJN20csgMcwQXw73MxBN8b9+lLbDpiBa8ogMmCCu9fcuRUG5OGUyijV85lvNtvq598U0DgX+xlO+cjw6Jk4V2bzQ339qnNk6NGtV2PZwfubLwo5Z4HEY48GkLqGEZ4xJpM50a3ykeryGF7NOH+zwZwBTBFUExBFutOaxjPh1WdgEJD1XUXHzpmnzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzMuDtOaoN9gAD2j21FVfjp6m/IZJh54uZcF0EjP7io=;
 b=SvtiIvKw4EMV101rnU5ppTrInzwpyQK65AxXr3sEmkLibVzhyz9eJaFcMcXjjLqnjFiqN24oTVFj5VfVzIKyICy2zhGS4PFSOPdhQYCgmWsGHlbeVWjteDf8UbL/DdT+h9+H5VM5phewdrf8ARrFQlTBCHvdQUBFMgfpWaPhL5dwxHTK0mGALlMzyj86u8G3QAixIo6nh6PBP3tVKOw3sfR6/JRrE/K3EeqRha4EFugD35LuuZQYPdOcqgpv3syjBpwhUqfJ9gltzaN98LMe/9DanOh3Oi35orBPlelV7wszo1z0JBtp0ixDfoMb9nLEnZRevO+cs2KiHp6GZAUUJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzMuDtOaoN9gAD2j21FVfjp6m/IZJh54uZcF0EjP7io=;
 b=SrBb4w0GeuwXPOl5lxfcjlPXPTBd1g23jwOh72oGs9WwldP2zIK+16Xl9cv3NX2Hw22cDT5N64+ThdNUsH+bzSefSDtn9HAGNk/UfecyGkI+GCPAqb0CREX8nJXoARg4THkTDTk4c2/a0KYU4d71Ut71Hx0Mq6UToHyKBkkfKiw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 BY3PR01MB6641.prod.exchangelabs.com (2603:10b6:a03:367::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.29; Tue, 28 Nov 2023 03:32:17 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77%7]) with mapi id 15.20.7025.020; Tue, 28 Nov 2023
 03:32:17 +0000
Message-ID: <a7d85fee-23cd-4b85-adc6-16980b6e5e02@amperemail.onmicrosoft.com>
Date:   Tue, 28 Nov 2023 11:31:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crash_core: export vmemmap when CONFIG_SPARSEMEM_VMEMMAP
 is enabled
To:     Baoquan He <bhe@redhat.com>
Cc:     Huang Shijie <shijie@os.amperecomputing.com>, k-hagio-ab@nec.com,
        lijiang@redhat.com, akpm@linux-foundation.org, vgoyal@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com
References: <20231127020727.25296-1-shijie@os.amperecomputing.com>
 <ZWQEP4SczFh+GUHq@MiWiFi-R3L-srv>
 <33021b87-4c6a-45fc-a6ae-265765cfcd78@amperemail.onmicrosoft.com>
 <ZWVdxAv/PPHY3Ndl@MiWiFi-R3L-srv>
From:   Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <ZWVdxAv/PPHY3Ndl@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:610:50::35) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|BY3PR01MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: 22b1b539-dd3c-44d0-287c-08dbefc29e9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lGGRMQ9BSLhlwT8CTnxr95bBhHd/oJb850guMQ2SgQYFuORAXbrFbIjb5B4gpIGg210hfffWL42xRUhIjowTecBJjhxz9hYMrazPllJaR4OVlyTqj24g/vEfWx7gO9QIlRzSdQKy4k7cQ8VbwE8VuKrbl2mBOpg2Q6Krs/Ou0wUKq3VJMxkee+p8TKtib+siR2jAxVCmO0A8dCCjZqasDIfzV6jXppOhRCdztwTPmmBzw6NT/C3ewXzczqmpd1w4IAOYYABUlTohNAXFqwIV8HhQGC2Ri/HkmIXDkxxbFLYfGGbLkA5KI46BquJ1r7s/YOrvApjqvGxzjQXAtQhS9o4NEy1q747n2vihbON6lIxIPOHCPo8gVMixvSjB3zahoLLSDWH6ShTGSjl8/Eb6BZWUIpw3EJFC4g6LKRQXfOBYXhC6KlowLXdFBqenVw2uvp+g26DkBu8XTzHktSYYE73JV6hcHD1/HPFAgSrAyY7ebJZUVgyVhqTBqHSbZwC+PmHNv+ZDrGcVZ/YEQnAaLbt4WXUrjJHW3K4+vMqD5HHKNFBaLDLBED82Y4yT7+hV6lEpYr6YZd4Z7+oetYjHRxKZ8bfh+7of5DQjrskpkmk6e4ZQ928pwtdb5HxlMQ99
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6916009)(38100700002)(42882007)(31696002)(83170400001)(66556008)(66476007)(8676002)(8936002)(4326008)(5660300002)(2906002)(6512007)(31686004)(107886003)(41300700001)(66946007)(6506007)(2616005)(316002)(478600001)(26005)(6486002)(6666004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3VmcVQwMlBsdDVldGJZTUhFZERDT3R2aU4xSTZYK1VPRVgwSC81OXRwOTFl?=
 =?utf-8?B?NXhBaGp3Tjd3RlNUaXd2MlpPUTlObHNaSEx0VGR3cWlqWU9SakNkRjZYZEt4?=
 =?utf-8?B?RkZyQkhaU1pxaW0wWU5hQlJ2WjZISTlpK1diY09JcUJVTlRoTlA0SlBmb1Zn?=
 =?utf-8?B?SHhYTy8ya0FVWDM5b1hmVDgvcjZJWVZOb2hYR0pTb1ozTjgyYUdIaGVOMVdR?=
 =?utf-8?B?ZEl6QTNZT3drMXd6dCtNNVhUNmFWVXc3d1QycEVTMXBqWW1tSnMwUVhYMXVp?=
 =?utf-8?B?R0JhY2dYY2RnWHhOS1EzWEdhdHlxb1crak9oVURjSXk3UGJtUXZMQTdGUndl?=
 =?utf-8?B?UzcvMFAzbGdkZGpDc2JQRUFIZWVVVGM0M1VCU1dscjlKNy94SEVGbWx1WGJw?=
 =?utf-8?B?NlZMVm5IMldVQW9BdUZuS09NV2tBTGZUTVowcFlPSWduUHNKZ0hZcHoyMkRM?=
 =?utf-8?B?dUE2b1pyVE5HdlBQcStlbVlEaVhhY1loTVJ6RVRUNHRNSHVqWWx6bzN1ekVz?=
 =?utf-8?B?QnJxNmRKWTM5V0g1Z0FKV29MYlQyTG5YMVRIeENraHROS3ZGMU1tTHE4dUZp?=
 =?utf-8?B?RnJubWpHRWF0NnpLUjE1RXVMRG14WVRwcDRxNnZpWXJJV2YrK2NOQzFGUDI0?=
 =?utf-8?B?bitSbGEwdHpMdnFab0wyaTE1bk5JUHdERHVCUDNWUlhDdUptdS9DZXdQS203?=
 =?utf-8?B?NFJHcVpPa0V2aGxSaFU0ejJ5cWRBR1JORk9adWQwZ2V2T05uYmJHSWdkdFNz?=
 =?utf-8?B?MStOaGFwd3BNNGdIclI2RWlzeHM3dllRQWdVUDl5OUZXWDZiVDVQRHl2QUNv?=
 =?utf-8?B?ZVl3UkFoVXJvQnNMVXBtLzdVZktHTlJNd1hwL3pmcEFpQTVneHVaRERrSk90?=
 =?utf-8?B?dXR0aHhWSmloWjArc2JRSjNoenVWRStFNC9hVUhPRkJjaEdIR0JTZ25JcW5w?=
 =?utf-8?B?UEtWSjNNZXU4ZENscmVKQk5MRkYvaHhqbmMrY3RNV3dVYzhUZUxqY2kzM3hM?=
 =?utf-8?B?NXZmVHBFd2Y0aGU2WkJFMGVoVXU5RFEzeVZMQzZBU0RnNjdSTWEvMnR4eHAz?=
 =?utf-8?B?WkxIanBKcWtmdEVVSzVSWlE3N0xXQVh6dnhLWEZYdytib25YUFBjNTVhekVM?=
 =?utf-8?B?YURwaXVmdjczc2tMUnhvYUp1K1RrZE44czZvRXBZb2VyWFBJM21rVVF0TWRX?=
 =?utf-8?B?K3k3aUU0OFdsRjNOdFlaWVVZd2R0WWhqNDlJVHlZc3l4KzVyQUhzd3l6TGNv?=
 =?utf-8?B?bStrcWJVa2xoTHFNektGN1I2VDdySDlERTVMWHptMjJ4VGROOUMxNzFPUjdj?=
 =?utf-8?B?WjlMU3hGRHRSZUpoUENZclpTWFkvSVQ1S0FESEROR2xZbmEwMHR3K0pNczYx?=
 =?utf-8?B?am8yclNqTUVCejBGNEhGajFiYTFmTmN6eEdWcXhaS2VDbm5jUVdGYWlIZVRC?=
 =?utf-8?B?aXVCR3VRbHlzVHlwdjg4aUJsVFAvNHhLeElCcGtoVXFCR0k2c2hmYThFSHcw?=
 =?utf-8?B?L1pjZEIwK3ZEL3p3UXJTeG55TlQ3b3Z0d3Q2L0xpQVJJRmgwWFFJcm1hYUx4?=
 =?utf-8?B?UHk2ZDlveDV1OHFRMkpYNFBvczkxM1lyQ2YyaHA1UEVYYVpqVUpieUVrOW9C?=
 =?utf-8?B?TWVZc2ZvNTZpN3lDcWtmLzBLUTRKNndDYW9UK0o1a01RNWNwaFFYUkF3Z0l0?=
 =?utf-8?B?bkg2M1l1c3F3bEFNOHBmYTYrMExjSHBKSjJWdTNXbjVoTG9HNmhuN21UeUZ0?=
 =?utf-8?B?WW5QZzlIWEIxd2NLSURvWFVBQjhTMEFsV1hQRmVBaEhFZnJvNExMbTlMN1lt?=
 =?utf-8?B?QmlmMXpTeXdPMlU0RmVOdFUvY2YvYlcwKzMxZ3d3RXViYytKb0RTd2YwZThl?=
 =?utf-8?B?dXVBakIrZDBscS9ZZUZJNVVadGRZRTE3R3k2SkxoQmpGczlXM1BCbVpDODVG?=
 =?utf-8?B?TDZJYUdlTDBPZ0YxMFFWZkFlakxGUVpSVFNtQW5ZVk5SWGZRWWwrNDRKblpN?=
 =?utf-8?B?ZzhyWjhxa3pOMDJZVEFVSWZCWTAzbG90Vm01aTl2SHB4akJvVjUwdjdlR3Fy?=
 =?utf-8?B?WitON0N6VS9najVZMEZwRWZZS0hTTVhtY0RidnljLzZmRXMrSjFTNE02cW02?=
 =?utf-8?B?VkllZ2tWQkFWNzJRYmR6KzAwQUs2TVpCR0REbXpGZllzeHVkZTAwWFZmbUly?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b1b539-dd3c-44d0-287c-08dbefc29e9e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 03:32:17.0066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4zsEAGED2WSBkuKXo+YjBysRV0jvNfkDvcakTfQDCQWNlUaTERsL8shR10LkqUYDWe/h6/jwb9HNP+oUmZgDj+mEZoY73aLNGJWbl4Z+8ZwRF1sh/nNd/a25/NU7L92
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6641
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/11/28 11:25, Baoquan He 写道:
> On 11/27/23 at 11:18am, Shijie Huang wrote:
>> 在 2023/11/27 10:51, Baoquan He 写道:
>>> Hi,
>>>
>>> On 11/27/23 at 10:07am, Huang Shijie wrote:
>>>> In memory_model.h, if CONFIG_SPARSEMEM_VMEMMAP is configed,
>>>> kernel will use vmemmap to do the __pfn_to_page/page_to_pfn,
>>>> and kernel will not use the "classic sparse" to do the
>>>> __pfn_to_page/page_to_pfn.
>>>>
>>>> So export the vmemmap when CONFIG_SPARSEMEM_VMEMMAP is configed.
>>>> This makes the user applications (crash, etc) get faster
>>>> pfn_to_page/page_to_pfn operations too.
>>> Are there Crash or makedupfile patches posted yet to make use of this?
>> I have patches for Crash to use the 'vmemmap', but after this patch is
>> merged, I will send it out.
>>
>> (I think Kazu will not merge a crash patch which depends on a kernel patch
>> which is not merged.)
> Maybe post these userspace patches too so that Kazu can evaluat if those
> improvement is necessary?

No problem.  I will send out them later.


Thanks

Huang Shijie

