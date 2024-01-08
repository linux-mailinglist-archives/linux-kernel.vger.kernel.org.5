Return-Path: <linux-kernel+bounces-19420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0410826CA8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046551C2186F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7E714AA5;
	Mon,  8 Jan 2024 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="G25CXPPn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2100.outbound.protection.outlook.com [40.107.20.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207592940C;
	Mon,  8 Jan 2024 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQU7LbkRTswMsgBFNRW5wQ53sJrbEMHoFDgf6GCVBEwhFRxs9rvgSzfln03addTkyFwb8REQSQDnql+XtipEjD/oVDFmsPOhaEVCPhnHrZ+yqLvAMPAt6QA+EtVqc72hJzaGHSBbIvhFrf07LaedLT7yZKUE8dZwlSwm47cjh4XEOuy4JGZBX4s4RMGGuAR+xwULEug0mGilU1fYAYGSLDgplKi0QdKmzxzoW5abzi6UDxmaGE4uojImmg3/etfmzNQGjYxWlJLt06pRT8238zIreZmBR4WPFG0BqEiYnkq/w756Q+Xu/Nwu2E1QWVq8V16+bhmNYPop0eCbOUving==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAsun7zHKnm6AbVuxCVsU8MNxyu6/LDHXpVbaaPdN60=;
 b=U95RxUsLpWsEyZ52uBDvTWPeM/d+YaiMwsf6fawGKywk6Zf/gclT1XkiRgPItygJzVAqtSl1EW3/8Zwu/KdOq1s23xWsnguXyJMEL7ctnHGu7s+5Hwu3S6GINnNQI/s7lLqYcArghBYbl1A23FMiJ9iedffSIpVdo9oLGV2kSpR06s9RlbX4bM84hswJJRhzioYdeFcgP0v8SO7El7j3nM7zK/0yFRc2LrK9w9Vxm2uyjJ1VBgjNGjxcrmnAYaYIjo6DLNwuU/KHKNsrpkfpvv+wYndXiOfNIdruF6OQzu+8uSu8wnH569rcP5YWiSCpQhXF6fU8XI+cstWAUq0CZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAsun7zHKnm6AbVuxCVsU8MNxyu6/LDHXpVbaaPdN60=;
 b=G25CXPPnJaUw/jJNUA0xgYO+4F9UEFSf2XN/vRYvc+DHX9KaYSymJfLhyz17ZXbdN2R2tg6Ral7Fnd0orMZgp1aPUTGNeDBMplkg6FhqfLRWSFgZF9ClNXQ1fopbafMe2d7nsE3cN8N4cmEApJo9y8lGolemkZhnwxOvjq5lMLZnS2yuYUYMwsiMunxp6EbG83WVEwTm3xBKIMEr1ySKag6mWq59wvxYAbEN+IyVgyfcFHtFCf3blIWAa9q87GRNMjzuVtzGKIcdC8ccm4EMMA4tjKoq0WTjNK12kp0OtX5Uk5rP72oQHtPoNpUYBvdRw5BpOVR4qjfxPj+7Zcov4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by AS2PR08MB9522.eurprd08.prod.outlook.com (2603:10a6:20b:60e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 11:26:16 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba%5]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 11:26:16 +0000
Message-ID: <a84b2797-2008-45d6-9ca3-c72666d3c419@virtuozzo.com>
Date: Mon, 8 Jan 2024 19:26:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] neighbour: purge nf_bridged skb from foreign device neigh
Content-Language: en-US
To: Florian Westphal <fw@strlen.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@openvz.org
References: <20240108085232.95437-1-ptikhomirov@virtuozzo.com>
 <20240108111504.GA23297@breakpoint.cc>
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <20240108111504.GA23297@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0082.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::22) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|AS2PR08MB9522:EE_
X-MS-Office365-Filtering-Correlation-Id: 285c91a3-2eb1-474f-b794-08dc103ca094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HQne/xuNnRCPUGm2lRg5pTs8/mDrDQlLUXdaQaeSCEcfzz/IwtyECi8+lMsL0+AmJ94gDOhBOKqhQtfFQUnQc9/yCczkUXRfPuoZ+boJi3iNzv57jegMBupyBK90GZg/z34vO6OCnXqBVbRgD1o4OFrOCXXyibA0mjroTGk0V58M2tTdkbK/GKwDvlKzIR/osABS3bleysURDVqoiy5i87BR0ZgZWQktnZmvvoqPGUqFD12wTMPhzBJeB74YdgGYRZMp9On+pxFANSsKje0VbYjGrYhrIQtbU2u+8cfoNPeAbKujcuV72nTDr4msrrFBt5Ow7g32qHxMckY2Qlc/dkyTRBwacXeIjvPdT4D+vOA+ojYNjLZG0hMiIXGYb3ux/9zEK6bXWtIK63tNHcegRkr3HOwQEEUt2CVixE3Adu4XeiXRvg4oFx4iVUN1u5SOTBk/p8GgyabfShPfFVIJhDhRw59LebOH/dl1OEJCB1mCnO5M8oQy4v1eD/u6PdMcQX43xqXCeqYRyyUhQOr62h37BpKwUaraczrvvCX7TS1YNpQH9m3wxUoJNIKWSdRUjKhga3PXsawG1PyXHooitiZnYAI9J2X0klSn1iGdHx96UfSqsB4B96XMIRJzGA8kSHD9O8npmXmE3AtQ8yHoMg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39840400004)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(4326008)(66946007)(478600001)(38100700002)(6486002)(8676002)(8936002)(83380400001)(2616005)(107886003)(53546011)(6506007)(6512007)(6666004)(66556008)(66476007)(6916009)(54906003)(31686004)(316002)(5660300002)(2906002)(86362001)(31696002)(36756003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVNrTXREWnZ1MUE1MWd1bU56VUhFYkwrdU5yMG5Cc09iTDV3RHdLR0dFcDdp?=
 =?utf-8?B?K0pDV1VzMUJwZlYzWG1CWlRiMlp3Tkp2a3ZKWXJ3Ri9BV0FEOHJGcjU2N21o?=
 =?utf-8?B?aWYyVEl3ek5ZbW5MNW5Zdko2YmMwb2RPdU1vaTFIbjlJbmhOZUVxeU9xdm9z?=
 =?utf-8?B?eDlYZzU4STE2OGZCWWZQeFlhaWNCWjdKZXRwNGxZdy9ISmIvM0l0bldzWS9p?=
 =?utf-8?B?Z2piYmlJcXNmYnY0NGRnTFlRb09oQkcrYmZlbjFLODR4akMyeEFWbndTc3p6?=
 =?utf-8?B?c1ZDbnBtcjZVZ1VVN0JrTWNMYmRlazZWcm1RNDVHMEdlYTl3Q3A3MmpoTzA3?=
 =?utf-8?B?N3E4SzlEaUk4UTV3UWFFZTArSTdSSWh0a1RyYTY1K1V6d3IvNVBNL3lNaU9y?=
 =?utf-8?B?WkRwcDUyUktjeXRxZXFDbHlJV1Qxa0RaQ0ExalF1TzlMZy80L0dsK3h2MlFW?=
 =?utf-8?B?a1ZkYXh6akROVXBKd3orVmNDOG9BZ2JwejVZc1JRaXVIUjcxZFVMRzh4QTcv?=
 =?utf-8?B?UlkvV1pRWjRZb1BUaVBwc2tRV05OZ1g3SWcwYUtrRFN2TnQ2U2pWeFUzUGw5?=
 =?utf-8?B?cy9UTEkycnpBT2VWcW5RdjJoSlJYOURsazc3QjNDZ1BWVEVEZmhpY0NpYThv?=
 =?utf-8?B?MUZGSTQzQ0FFTjdWczQwQ2Z0R0U3SURxdzVqY21Sa1IrenREZ0dwUVROSzJH?=
 =?utf-8?B?dWxPL05RdWFCQWladVdSZEg0ZGdOQXhJSEs2b2ZpdWIrNmxZZHA5cEthcmNy?=
 =?utf-8?B?U3MyVHgrc2JvOWlHODJOdzVmNEVOc3ltMUtPUUZXN0xhYzN5d2V4c0l2Ry93?=
 =?utf-8?B?cGdDSythY3k1eU5veExObG01ZVdkSVA2Vm9WbWJ2RmszMTdkNVNWOXBCa0dL?=
 =?utf-8?B?SzlsQVJCNENMRlZVNkhlV05CSjd3ZlNwWmNCelR3cEp4MDZ4TGFlTHNEM1Zt?=
 =?utf-8?B?MnFNUXZFSG15SnhBNzNiTHRsOEtqc3hMUXhoTTU0QWdZV3lKVHg0ZlZKTXZ5?=
 =?utf-8?B?bEtBODdXeHI3ZjhxU2pndWZvWlpvSGIwb2M0VGtNM08rbTFaNnZKQktkRzRt?=
 =?utf-8?B?cFBCa0ZudmV6NGw5cmp6UHpMekVHRC9YMldyZklodTByaDRWOFNkL1A4bEZk?=
 =?utf-8?B?ZmYzbjFkdUlHQnZCeHRIdExhb0dKZnJyY3RsWGhmUWhZOUhsNlFUNEZLbVN2?=
 =?utf-8?B?RTlvUzNBd3d3aVl2Qld2MS9IamZpblNoVHpFMjRtU1VjWjZZZWV2bnJxWkJ4?=
 =?utf-8?B?ajhkaEQ2SkJmTUptcWMrbk96R3NjQk1zTHQzOVJRT2FDc2VJVEV6SUJPUUdD?=
 =?utf-8?B?S0lkaTRWQ1RvNzdrMDZvdnZwNTRTdnJMQ2ticUJ5T2RHTEVCbkFUVWo5UDNw?=
 =?utf-8?B?N01aQUpMSzlLZndxR3hOWWkvVjJMOXBjRHp1LzZHOHlyL0pGT2VLTUlnOUY1?=
 =?utf-8?B?K1Z0WVB0VVBTS1BjODdEVVVLOWtsSFNWMm9tMmttZVFxWDFsRnJnbWUzQVRa?=
 =?utf-8?B?N0tyMjl5WVNlbDhiQnFGeDBKaEx0b1I4d3hrSWlmYnB4alVVVHZLU0VxSWdn?=
 =?utf-8?B?ZW94aitpL1ZxTEdCYWxmK2tIR09tZkF5QTFzWGFEZGRqVm9XaktZOGtWY21P?=
 =?utf-8?B?b2RtWTZJZjJFVjBZa0oxclVZeVhoLzIwZ2w5bWQ3UFVDQ0VKRGUxSms3S0JN?=
 =?utf-8?B?OGRFMHlYSkhsZ0pNb1pEak44NjJUWit3Ty85dlNxY3JybERCb2k3WER3blR6?=
 =?utf-8?B?cVorc2RvTUhlNnNSWVl1YUM2MlhtaVB5V3kyZDJwbTdkMG5XSGZGRXNYVDl2?=
 =?utf-8?B?bmp3RHhhM3ltc0FSRVRpeDlhTnJSd3NJMnZHNXdtcW9TL09RV1NySldpR2NC?=
 =?utf-8?B?dk9EbFZxZ3RESW1UWSswbVNNRE5uYU95SHd2Y3FrNlE1YVlYU0RKc2JVMVI1?=
 =?utf-8?B?Y0FnYlRGT25LL0JYV3hiajEzZXArZDlGVXFwQklRbVk3STJOY2xIcktxVjZj?=
 =?utf-8?B?a24ydDRsdEx1dW1KNC9tQU9EdTJaMkYrbGZOMVRqbHJLVytFMjBvWjVpakpi?=
 =?utf-8?B?bVlBQlduWDdDeTR3K0dCVk9kcmZOUzVyVGxlNnBzZ0tMVWdjV2NkZ0w2dHoz?=
 =?utf-8?B?ZkJqNUJ3clZRWU5IT2g0emxKdmhIR0x5dEl2THhoajRqUjh6MHA5cTEzM1R3?=
 =?utf-8?B?MGVLSXdJY3JHRmlremZZdzNxeTBrdGQvWmJlYmJmSnJ1Q1V3S3RXdWh1aE1u?=
 =?utf-8?B?dWt1dkJwZkFYdGs2V1poa1phQXVBPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285c91a3-2eb1-474f-b794-08dc103ca094
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:26:16.0576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mBFXLPxga2G93KyvHmjcsiDZ4gmJIrmIBC2ITWhBxJRsYh9jRvsWxCqAulCCC+8syO3k+qTi/ofi2N5taByr/8iLbVmeRhKMkisQ3EdC3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9522



On 08/01/2024 19:15, Florian Westphal wrote:
> Pavel Tikhomirov <ptikhomirov@virtuozzo.com> wrote:
>> An skb can be added to a neigh->arp_queue while waiting for an arp
>> reply. Where original skb's skb->dev can be different to neigh's
>> neigh->dev. For instance in case of bridging dnated skb from one veth to
>> another, the skb would be added to a neigh->arp_queue of the bridge.
>>
>> There is no explicit mechanism that prevents the original skb->dev link
>> of such skb from being freed under us. For instance neigh_flush_dev does
>> not cleanup skbs from different device's neigh queue. But that original
>> link can be used and lead to crash on e.g. this stack:
>>
>> arp_process
>>    neigh_update
>>      skb = __skb_dequeue(&neigh->arp_queue)
>>        neigh_resolve_output(..., skb)
>>          ...
>>            br_nf_dev_xmit
>>              br_nf_pre_routing_finish_bridge_slow
>>                skb->dev = nf_bridge->physindev
>>                br_handle_frame_finish
>>
>> So let's improve neigh_flush_dev to also purge skbs when device
>> equal to their skb->nf_bridge->physindev gets destroyed.
> 
> Can we fix this by replacing physindev pointer with plain
> ifindex instead?  There are not too many places that need to
> peek into the original net_device struct, so I don't think
> the additional dev_get_by_index_rcu() would be an issue.

I will work on it, thanks for a good idea!

-- 
Best regards, Tikhomirov Pavel
Senior Software Developer, Virtuozzo.

