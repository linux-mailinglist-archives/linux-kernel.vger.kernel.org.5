Return-Path: <linux-kernel+bounces-23623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5187682AF3E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B870F1F22FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0310F16402;
	Thu, 11 Jan 2024 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DhaR2btN"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2115.outbound.protection.outlook.com [40.107.117.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12AA171B2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 13:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkRDYKMU/BH2wVrQ+H2yHxsahd2/XAgJod8c6BAMoZ6poLLjhim9LuP6w4bo8+fOqA1WpqkdzMr0jOG/FnmJ4mDxl6/uPTTrE6cydltMaAvOmnuthl1Hw8phlpuO6HrzyXsxTREFQ2tMmBzv8N0JX30wVJb4u9t/3MwXmYGl6Ai8eKjvMYox8Ktdu+m2X2Htl26WerdWE467HORbyQZO74SHPBP8zddEinmb9YnbgyjH7Uw2BAeIojs2FFI4hw7SNdUdNq8AfKk+LRnP1KYR8jzvZEE7k7PzMW6En1xp5P6WCaT5KS4DQeI+QxmgEHlc6F03FDi6AlWZniH6YJ5BOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDuBBuVu8QOitkq31ly7tkm8Ik0LP5JUvYFzrtUhlaY=;
 b=ZEQ7YeBoW1tHdMPQnMrN4GtvVnkkNiVzWht7LoKs7W5pCExehKsr2j/iLBUT1x2bTOUH+wjxJFFYDfUM6K2ObSl/5uM0lgGsmlhSzZEm9n0Xy1HtJDWPFjW4DPcodKfcH1idl+kBbd7wv0cvC5bwwVYf0/F7nvfeY/X8i20HApnbqoOPn/POX2Tlh22lYGN+5UbT7j+IiyMJIzg02QowFjQw2B9VCpwOUCb+IbeG4+Hc6IJKoc/jjXQKf5eGUwJB89MaS3jnbwTJ14m3uJkKESOoVyFKstgjaCJeh/d688/z2jkyI/nP/xbaHQVsFIpK6hnxkaVuQTtLG4qxojT1iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDuBBuVu8QOitkq31ly7tkm8Ik0LP5JUvYFzrtUhlaY=;
 b=DhaR2btNrVtJLKZyZVS+DvPpF61wknMxrNuuYZ9nXX59WGex32IFykXqsTJEOQtp1I/UISozRkHmHV9BtoSkRf/MtNo3Nh0LAIAxml6oO1Bzl2yLnEQLj0W5jO7I3OAjBjTr22TJNotdUAyUsm6oitvcvLPHyi+V5cjo/j9QtZtckpe6YPeb8944A+hNkZZZp09ZFRa9yqW9kSjpSUIXB/uSW5aCZV0sMUaRkNLufmmLJRhl9livgSYNfC+5zXRsQpSbLe9BYVqUGziW5Yh4I+9+TcIMd0EPqbowmQFxCQzNkLYKLw1U8ruBE52doEhU48j3csX5bKnH7MJLDxdxIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEZPR06MB7289.apcprd06.prod.outlook.com (2603:1096:101:24d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 13:11:03 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3%4]) with mapi id 15.20.7181.020; Thu, 11 Jan 2024
 13:11:03 +0000
Message-ID: <4027f7f8-fc76-4342-a0a1-9fed4ac3f2e6@vivo.com>
Date: Thu, 11 Jan 2024 21:10:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] *** SUBJECT HERE ***
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Chris Li <chrisl@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Dan Schatzberg <schatzberg.dan@gmail.com>,
 Yosry Ahmed <yosryahmed@google.com>, Yue Zhao <findns94@gmail.com>,
 Hugh Dickins <hughd@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc: "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
References: <20240111122451.682-1-justinjiang@vivo.com>
 <92413d27-6a66-4868-bf94-b736c0c88ee3@csgroup.eu>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <92413d27-6a66-4868-bf94-b736c0c88ee3@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEZPR06MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fcda640-10c3-49e2-1563-08dc12a6c36e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mPmOrXs6wf1hQwKi3aml6C9HMsrVOeNxdEVUiG1rk2ILDfUiiAAFi+lCwR3YQGoHzXu5sXHPgdTsE/6n6uQAboa/de/Ql0OAQO7yEGvBHm6cD/35ezPkF18yI60FUJZpbfk1PxvZ4fbyrATKoCXvi4gpUDZLI9NIdwMqK8SM1C/aTrjr4ClvW8MqEVXacGFB3OTQ+SWTLXBmbL9ql8SkF8MbtfvpUADFGhO0mv/G4GE3UxdLt5aGI8e+qfhs6UlR48pdzhdZnj7OceQAhNXw8Ne3X60bOuWvzrT3XuKMsniPnbQRrhraUCAXkO51Pdk5LWJ2yoHZ6POxiI7oIlD/7Bxux5MG9MjAHD+IBvxCFk6LggHfn2ykJ60cFM/H16dqlpoUGFIS+y9NFUuFZ6WCBoP3pNQUSJYxqLCS9F1rUDKkAEoC83pK/DiEE+g+q462odRftZUV2t4P4CqQIsHVyhsacD/Xh+W3qTGsDslgNtV/5fvH9PGCYaopuHhE01ADSCt54Qiks7B0RGF8CCDidSqz1+c2YPYV37UIjJ28B70MQ6c8n1KsB85NNcpurnaW7bIt6yF9B5T93vXymnRmFbeEoqaXed02YfAB/0ppWI+aW+IDCSVXoS8cunPLi+t9lGKUdZh6Z+V5DiWoTHraoZ3fWTD1ZA60BYmwamMa4vcFKavRQOm9ta3PC0bsJa0WFeAiWmkOzkW4c0dL/gCmJ/PI3aBmZkI5vIOrgKKw+eQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:fr;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(376002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(921011)(966005)(110136005)(31686004)(2906002)(5660300002)(7416002)(8676002)(8936002)(4326008)(66556008)(316002)(66476007)(6512007)(6506007)(6666004)(41300700001)(38100700002)(52116002)(6486002)(36756003)(38350700005)(86362001)(31696002)(66574015)(83380400001)(2616005)(26005)(66946007)(107886003)(478600001)(43062005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djRsNTV0c0ZjcjZCbTYwRC96Z2thSjYySkxGZzFQQTlhSnNqbjFwY2lCL013?=
 =?utf-8?B?N1BtSHdjbG5UYnkzV0xzVmZwODVhb3JLdFZwK1BJR0JCOEN2eHd5M3hwazNw?=
 =?utf-8?B?eENOWVlScWFJLzJkVE1RL0MxMU91ZXl3aWZsRWF4SUt1ekI0VlFxYUNjQkNN?=
 =?utf-8?B?N2daLzNWTFp5RURQdlUzcFhjRmlIMytUSFlDNm1CVVIxdE9NQ3k3VGFYVDU3?=
 =?utf-8?B?SzNrSW9sZ0ZRWFFIbTlpMG9aZTJkcTZlOTd3Tk8xUWxkaGVOMUFUSjlPRUdR?=
 =?utf-8?B?cEpucU9ITjFUc0xlMGYxbmtnV1VsU0JHQlR5TUM2QXk4dHRQYjJQOVNyUm1J?=
 =?utf-8?B?U2VZQjVCNHk1aFA5VzE3QzJZS1VIZ1ZPU0ZHSVYyYXpwUjI0MFBCanFiOVpw?=
 =?utf-8?B?cERadk1sYjB5VzIzZlNIS0NXbTVRd0VrVnMya0I2T003STNZMjhHOVJIalVm?=
 =?utf-8?B?QWhYZ095L2Z3MVg5bHFENSs1aXlIaVJWZkFjeUZMUysrQWhWK1lrRmdFWXlh?=
 =?utf-8?B?MjFzQ1V4aTVxQTVnYkNnYXJWUFlOdFN5U0VpMytGbU9vSmhYanJxMkZnRDR4?=
 =?utf-8?B?Z0VBUG1GUDhKOEYxOXFscmlwejZ1Y0JWamNWNVpsbGZ6Tk5jWUxVOC9Ocmlq?=
 =?utf-8?B?ajZmOTNJbUViYkM1dlU5NExOd1hQZ3RGWk5Vem1tUTlRYzA2dm56eHBBTnpM?=
 =?utf-8?B?STRFNzI2R0FtSEpsZWdMV2dkU0dSMlZ0dW5wb2FoOHNwU3p2anV5NytCdUNB?=
 =?utf-8?B?ejhPRWRqV294Tkg1MGtZUXVZK21NeEwxQTNVRzNsZ3BMc3lmUndpdlpQZHV1?=
 =?utf-8?B?ZlJPSTU3SCtKNVh2ZUtwVmRvSjY4OXJNUVNOT3UrMWVpcEJrbkpTWHNaWFBt?=
 =?utf-8?B?dmRiRFNDMUtjZE9QNjF4ZG56VElUdGkvYzRjR3ZRTUV2TXh0ZkNHQmJZazZu?=
 =?utf-8?B?T0ZoazMrSHM4bUFpbUpveFdCc0p2eWU3dHhhb0VyU1B3R0g4STQ5dzd0SHNZ?=
 =?utf-8?B?cDlyc0RNczk5MWRRZkxab3JHMkw2Q3k4MFNid0JmcWloaE9CVVRPM0hIY1E0?=
 =?utf-8?B?YWF6OFJ3TDhIdzdXVWNTV1BTMnVIS0hML0JFZTZkR1JlM0x2SnhIcTE0NFJT?=
 =?utf-8?B?MXNNSGxXRWxBMlBNSGVWd1NuRkxLTjFldCtEQTFjSEN5K2pwL0JUUGQzTVJm?=
 =?utf-8?B?Tk1JcUtSdWcwMVZJQzA0QWZQUGp0c05qLzU1dE5oMTRnOGdnVXZmM3ZrNnF5?=
 =?utf-8?B?amVWcTh0NkxqVjJQUE13VFQwNENrTkcwYzJTMllqV0l1NHpqYUNmdUJSZjZp?=
 =?utf-8?B?TnFCZmtVM3QvbDg4c0liYVdzRHRiMFovYmxWNk9sVUtHVEEzUGhpWVhxcjdp?=
 =?utf-8?B?Y1AwMWo2Q3k1QnpsRzJRWlRxbDMwUU1rakNNcVBRYjFaQzF4MHo2aE0vaDcz?=
 =?utf-8?B?VzI0dTcrMTFULzJuclFQeWpKZWNTTE9SWHRKZW9ma2pIVE9qSk0ySis3bVNZ?=
 =?utf-8?B?YXI0a2V6NmtOU1NHL2NvTWJicVNrNTFNYjU5SU1tNHE0UFhUdHM2QjZoblhm?=
 =?utf-8?B?SzdHdnFHanR4cDBxQUkySVRuMm5GWFN4YnZuWTJVbEtEcjBLNUlRU0lGTEpy?=
 =?utf-8?B?RHB2eTcxcll6NGgwcGsweW0xNnNKTFJkMmhkTW5iZ3lhNjB2MFpjTFdBL25o?=
 =?utf-8?B?dVVwNXh4eFJlQndoeWcwWnBNSStRTHhJcEljWEVpK05nWXozRzIzQ080N05z?=
 =?utf-8?B?VVJtdVdFZGhpWWVMQzBUaEk3V3pZRHB5OVFaMWxSMElPNXlFeUFnUS9IeTZs?=
 =?utf-8?B?K3M5eUpVdVNRYWRVQTJuSFNId25QWFlGUmVJMzdWemxMUm45V2krejNyNDg2?=
 =?utf-8?B?b1FtSUljaEtSZFRDMzQ1YlUrK1RQRlBRZWdWVitYMlM0VjBuUmJ2L0tjM2xV?=
 =?utf-8?B?ZVNGWldzbTBSUTg3VkVkclBOS3NOMjZJU2JhTjdGVG9tek4zODhuSmNKYXI5?=
 =?utf-8?B?UWNqc0ZlMXpYeHFHdlpSam9uc0twNnQ5ZnZjQXFSZWRVdmpBaTFxRUJJamc1?=
 =?utf-8?B?ZkxHSDRSdDBOdGpYdktXcGkzWEdIWXJEYVdKQTZFQXBKd25YcTJtQXQ3SUZv?=
 =?utf-8?Q?wZOYjq67scDJ+s1QJWMBeP9ws?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fcda640-10c3-49e2-1563-08dc12a6c36e
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 13:11:03.3882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QjLFi5oLQuWWD95qmTBO2VK064POHHDkmI69LzYiA0DQvvacOWXMP1LD6u0q+i2QJ8gPm34R5f/eZai+DPm7BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7289



在 2024/1/11 20:51, Christophe Leroy 写道:
> [Certaines personnes qui ont reçu ce message ne reçoivent pas souvent de courriers de christophe.leroy@csgroup.eu. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
>
> Le 11/01/2024 à 13:24, Zhiguo Jiang a écrit :
>> [Vous ne recevez pas souvent de courriers de justinjiang@vivo.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
>>
>> *** BLURB HERE ***
> You forgot to fill-in the cover letter it seems.
>
> Christophe
Ok, I will supplement the cover letter as "mm:vmscan: fix shrink sc 
parameters issue" in the next version update.
Thanks
>
>
>> Zhiguo Jiang (2):
>>     mm:vmscan: fix workingset eviction memcg issue
>>     mm:vmscan: fix shrink sc parameters issue
>>
>>    include/linux/swap.h |  2 +-
>>    mm/vmscan.c          | 46 ++++++++++++++++++++++----------------------
>>    mm/workingset.c      |  6 +++---
>>    3 files changed, 27 insertions(+), 27 deletions(-)
>>    mode change 100644 => 100755 include/linux/swap.h
>>    mode change 100644 => 100755 mm/vmscan.c
>>    mode change 100644 => 100755 mm/workingset.c
>>
>> --
>> 2.39.0
>>
>>


