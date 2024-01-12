Return-Path: <linux-kernel+bounces-24209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8250282B91A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB6F31F25298
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0254CED5;
	Fri, 12 Jan 2024 01:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DsxV2dYf"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C98881C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 01:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6+iOkR7lCL02cKXtUSAYlYL1sq4EWKEVykpP4CZdL3LIYZDQTix9+PJFrQfgZMfzbrh/Gam3VSc0NAc+bRfCHdu5CmPwsdfym/qtlH3l0aTzhLP4D3TCAWqiclvKIWfcEvopV+LsngBwcp+pocYa2SFD3DsAceRtS9qa2oFrcsAJfyW9ipwtUBETSzGDkJUVl/GAlBT54h0jvLVwzMOonIBVn76znFZUPIhmtm57NK5XaNdk6VmTjGeVWxDJEpqVyR9uFbQg2oPymHcfznxqF2S9zGu2Z14g5EyolR/dwI2aCzxxSyZdpHYLqn/MU6HlMbzCBkL8VUaYK4Knuoxcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cS0L/rN/lD7Y/VA/xuHHqv9vThD20R5iM/4oVdPiHwo=;
 b=CNmDZtv8jgI03wjeRkQU1n5hdX1I2ELXuigz5fgielb/uY5NB/sMwmHChkzhcTPvYAA1eXh3IsiVnNRoBj3apNMebDyKk3ab5pTou+p2ZAWcSAsjzYPjou81HewIMqxP8K4yvanKG8FYS3QbTMNFjX6AfUE44mkKLcYmKKV2PybjgzVFds8OxEXnVMu4E/nVrm6FcHyinML07/RgWa1TGEJc9m26JtlXYsJyjt/JwPf0I3FF4MjWWYbyZ4uBBHfH9c5A8oyaVl6ZCWxGByW9wdLf+V3klfI65qz7QK0M40R6A0eeXF74bu4I1d6DtBTfbbuBgxeSsf6ulbMPRDZ03g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cS0L/rN/lD7Y/VA/xuHHqv9vThD20R5iM/4oVdPiHwo=;
 b=DsxV2dYfyd/i/EjiBmELKUNoK4LIemkrgdrD231Q/JDegROqXsXyiJnFtTr2bEZMpOwTG+Zc4ravMnukhQbuRvcnBT2qXa0bxnrORP3VYZPUfXhs0bBoQQAYlaSQnJnGd2BWQDv7tmJK0Zz9llBYFzfQv2Lrn6skWSdoQSD3O0HUTDa0nJhZlCB9qBkzjYAVWly+O0n04H6qnUz66wr4d11m9YljjiJouF346t1IQywN/nAHTqAK3eC3rSvTLRS21LV3uKIDycSGpojMuCDqfoJcXfBLhOW5cG6Wx2Py3hPIsrRr3BOYVDQAuJEcL78EFkklU7kp3NgVvIJS2BDg6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYZPR06MB6640.apcprd06.prod.outlook.com (2603:1096:400:44c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Fri, 12 Jan
 2024 01:28:02 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3%4]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 01:28:02 +0000
Message-ID: <7a94c962-6137-47c1-be4c-ef2a0614bfd2@vivo.com>
Date: Fri, 12 Jan 2024 09:27:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm:vmscan: fix shrink sc parameters issue
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Chris Li <chrisl@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Dan Schatzberg <schatzberg.dan@gmail.com>,
 Yosry Ahmed <yosryahmed@google.com>, Yue Zhao <findns94@gmail.com>,
 Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, opensource.kernel@vivo.com
References: <20240111122451.682-1-justinjiang@vivo.com>
 <20240111122451.682-3-justinjiang@vivo.com>
 <20240111134338.GB390292@cmpxchg.org>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <20240111134338.GB390292@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYZPR06MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d04986-4971-4bbc-4c8d-08dc130db7c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eld9HvTCUsqjSqNiTS04w69spWDyqz0njITDSs15hqI5udWqG4skGxVqm5PCyT10V1DhK+9sHIirhHP18iHFdM4tw0BopTRkzWTZ5sF7t4IBPPPvGZ9sbvrKa5PkNftE00PFW8pPXJXyMn9d6VVlh7MY8RQk061QjO1EhjjCmhWFSumj63K0PXdi2K4ZtTJEKk4MFOm1rDa5FKuIQNlk6b/ja0qzf47n9jucFbr8v7k1usBr7aIxlImlrdN6IULHdOWmeZ5je5wNueMT60tpiyjVp3qLu3cviSkbhQwyRnz/crP55jkstiwEqs3A67TwAqHLufSM5dOo9rHw9UALbZFU1Ffz8bwN4pSGBc0KmV2WkzT7PkuwRZM36rkYpOWQH4kAG66X+Q0KXU9fIjineeAKeTubGuYivmeGsCGa1OwIKtNuXpfePfMbRZNMApcOJf6MVC67Tqe86iyr61XTDweDSy8OA+oMZFLHfIu4Gp56Aw8XGGSP2pdY8rFCRw/BKe5TPaI8AYaOsqXG3oSUEQwIJoLXJlHbuF/WKgx+3489zNlHKwEKp3pSKDTDHOKegVwENyVlbH3RnAYWlrHmNfU7jx+LVBsrzK3ZPWvttf2COGeL78byu/MKX9lMqiaCLOOPxicxUyZrdr+yTBQ37rZP9PXEDEVMwa9jPvVWBZKQDgLD8eXtFX9dcXozAvi1Kptcw6Z9VcbP4y8BQ79/sg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(31686004)(6666004)(83380400001)(26005)(52116002)(6512007)(86362001)(36756003)(31696002)(38350700005)(38100700002)(4326008)(5660300002)(6486002)(7416002)(107886003)(54906003)(66556008)(6916009)(66946007)(66476007)(316002)(8676002)(4744005)(2906002)(41300700001)(6506007)(478600001)(2616005)(8936002)(43062005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3dwTGoyOFNpMTNRMkg2UGNZNmFRbjZYN1owZlVQNFVldVB3bXdRK2U3RnVz?=
 =?utf-8?B?MkZBVEZzRUFzUWR0VEFXTndTRzBxNFBaT0JPY0tIU3gzWU5EUkNXYnpmN3VY?=
 =?utf-8?B?RmxNZ0hacloxU3ZEZUxGMWZXMzlWcmpmeGVMVUJldjhDeEQxcnhRaFRxVkxD?=
 =?utf-8?B?eGdlN05UY0RNOFIrU2lQbTVGbjZRN3BadU9wQUdrZStycjdkOTRzcEVNbjAv?=
 =?utf-8?B?VDZINUlacVlWeDJqeUFzcnBBQlA5L0g0SHJDaGJIRStVYmFhNlIvQUcxMnJP?=
 =?utf-8?B?VEhZR25ibE5QWWkrQ20zOEt2NER4TVJ5UXFuRFp2SWlCcUM2QjBvMDZMQzBC?=
 =?utf-8?B?UFo4OWUvNS9Gd25pb3BianM4d0ltTmhjUC84THVqNmhYWHZ5NzJzQWV6NitZ?=
 =?utf-8?B?emJzZ2MwdGNxeEs5eTZGdVdhNDRhbGFMYTR1TEhLNmpxYURWZmZQU25KV3Zx?=
 =?utf-8?B?aVh0ZmdYa1pBOXRZWnYvNnQxK1U1NG80YVZkajBxcFVlQWVoNENVVEhTSlNh?=
 =?utf-8?B?bUtzMUYveGI5a25BeWZOdEpqbS94RkVXaElJV1FOTE56L0ROdzBQUWUyRldm?=
 =?utf-8?B?SkxWSW9EVmkrRk1yVXlGK2xTajAybXAyOWExOUpPYWptYmpCOVBBYXJaTWpy?=
 =?utf-8?B?bHdxSk5vVHNmditjaWEzZlp4RHo3WExvcGdESDVlbkd1ZEF4TW53d1F4ZlZn?=
 =?utf-8?B?c2pNSWExeWRhbU5mQ2NqNHIvaUlPOElxNk9JN212U0tTUEQvTnc3QWVHYlQy?=
 =?utf-8?B?RUhnR3FMdi9KNDJTQ2RSS1diUG1xclIwbENCWHhFYjlqYUtzZmwweXdXMnZ6?=
 =?utf-8?B?M2dHY0o0TDkxV3JJWnBiMVhVQ1hzbjEvVzFZaSs2UkdGYmJyRmo4YldEYVBh?=
 =?utf-8?B?WUpOMzNJdEg1ZlowQ2pkMlM3Qi9mNHVMd1pCemk5TVhoOWJyVy9pL0h0K1pi?=
 =?utf-8?B?Mlora3lzQUtINWxUNXlMcVA2aXROdFNzTUNvejlpLzFqWVUzbXdOL09rZC96?=
 =?utf-8?B?UzlnejRpNkZkaWtIK2dyTEl5L3M2MUh1VjBYVm1kOHRaMjdBRlhEUVBMQmRs?=
 =?utf-8?B?aVBhSzRiSmVxRFBGVEdLQ2VXOG9yS3Rnclp2anR0ajdmTTBkV2ErQm9HRWVr?=
 =?utf-8?B?Rkt6WnRTMDQzRDhVQ0ZUaDVzNU1teUZZcEJGYzd4UFdDVkFaNVJIaFVXVmZu?=
 =?utf-8?B?TjRhWlFrdzNtOHBTa2ZaKzdhZE9Xc1pyZWJzUmxWdGRqbjFlK0ZWRnRXOXhv?=
 =?utf-8?B?Q2pDN1AzSFE1Z09xLzRXSGxjbDgrWm9BUUdkUjNQcGdFRVZWZC9xM2NRUXZP?=
 =?utf-8?B?T3FBZXo0aE9LOE1LMlNxUUlZNlZ4dkp0TjdydWpHeDcwSnlSaVBYSjFDR3du?=
 =?utf-8?B?TUUybkVpWVhkb01ZUktlSmxmQlRQa05iR1VPNFFQdUdSdUVHMmlEK1BNZkxs?=
 =?utf-8?B?eVZRdy9jWEdPeS9LaHhIbUJoYVJFZ1hPaVBRVTd5K2pQUm1Tb3RmeTRMaFRp?=
 =?utf-8?B?OHozU2pPVUY4WFh5a29pb1ZVRW4vVHRlV0c2ZVFrZ294Wmhub1ZWcjhDa0Rp?=
 =?utf-8?B?UU5lb2hBbkx2K2kyL1BPOWh4L2RnUklqQWd6Qkx0REpiUWJiaExhSXNUT3V2?=
 =?utf-8?B?bW1mVVA2RTJ5WFVJYzloUWI5ZXd3bU4xdGgxR1FpWWJHTStGOHk4NXB3M0pk?=
 =?utf-8?B?ZXdiZGtNQU9EMXE3aEF3WEIrdVhmbStQUHJieDdzeS9TVm9YajRVenA4Mkpx?=
 =?utf-8?B?bXN6VnZ2dFBZNUNYSHRaZndGejZacml4eWhtUGRQSk5CQzFOdCtGcjc0OVRG?=
 =?utf-8?B?VlphS2NraExFaTIvbndhNUgzQ0IzMDZkSG9VcTZiNVd0M2FOUmhieFA1SzRx?=
 =?utf-8?B?cjZuK3pyMElka05RSGxvQkJXMTkwSnR1S0x3Qm1iVThxUEdWaVNVVSs2c0M3?=
 =?utf-8?B?T0oycDNLSGJVN2tvenIwZERWZEQ2WUNvU0tOTmF5RUxLaVB2UkdONHRITjlw?=
 =?utf-8?B?c1BNMUU1MlJnQ3BHWVA0ck1uRmFpaktIMUNzRVI3VkpBMmZNZnhBNGptNjlB?=
 =?utf-8?B?RnFYZ2krd2FFdm5QbWM4K0UzSHQybjNKcnpjZlRKQ2oxcG1xVkRmWUEwb3pH?=
 =?utf-8?Q?J+WbWrFrJuJQrJp3E7gemZZAR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d04986-4971-4bbc-4c8d-08dc130db7c9
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 01:28:01.9841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3gDWE4HjLtZ31anlUoZD4pqu/+O95SNaH7mOplE+H9JJk5iMFabG453+mlV3zBZoS6nqLEL5IsDEbRl640ajQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6640



在 2024/1/11 21:43, Johannes Weiner 写道:
> On Thu, Jan 11, 2024 at 08:24:51PM +0800, Zhiguo Jiang wrote:
>> The values of struct scan_control's members obtained by
>> prepare_scan_control() are always from root_mem_cgroup, rather than
>> the memcg where the shrinked folio is actually located, such as
>> sc->anon_cost, sc->file_cost, sc->may_deactivate and so on. This is
>> an inaccurate sc values for the actual situation of the current
>> shrinking memcg. so we need fix the values of struct scan_control's
>> members are corresponding to the current shrinking memcg.
> You don't seem to understand how cgroup reclaim works.
It seems that the actual memcg's lruvec->anon_cost/file_cost values are 
not used in code exclude target_memcg ?
>
> Nacked-by: Johannes Weiner <hannes@cmpxchg.org>


