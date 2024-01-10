Return-Path: <linux-kernel+bounces-22058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B0182988A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2EC1C259E6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D954778F;
	Wed, 10 Jan 2024 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Q0pCJLaF"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2092.outbound.protection.outlook.com [40.107.104.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EA147762;
	Wed, 10 Jan 2024 11:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEMYNC8aKlbVJjU9wpLRRsJWm4Oim5ozYAVfBltRP4Rx2x7bLUGg150hBljecn5uviZ7ZdPCVxh1vNY8gnxuTjjj7o59OBSMa7lFaRKsS8Y4rl3IGIwIN1oL/ZdybOXgBZ0iWISUW66gV8o8ZLrMGrigSzMmafnYxLMXX7mC62L2/huNUqnN9pnWxur3oLxjXt4a1Qgx50uE+hViQr2a/xy2FH2jm0KArY8AfbI3qWGb0caa6HlJ6LBNjzDGabobV9l8x31h5HAhoLFhzJXSzbCI8wjkfl/To9GE0sQ4PbHhd/mt4ovnLrhLVOw0Ky9iNIYCxzg6vlwNDCsZ0LQD8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gyeyWwI9B5CDaSsZlURkW/Obf7fz7dAtdwRFRE7Pbk=;
 b=GQA4z22gBC8wxbgcSGWnqosm//tLe0o8RtVeEUCxBpWzDZ8YS7tCOSP2nTZDzI1bIfHoxBRDouxQmPm5Bx0O2UJR/iPUzkOeWg+/5GAbbYeIUT4vFsHysPGt1HBMLhwo/VdBIvR6dmVTUy0aq3pDo5hY0F+O99PSIxUlcyTt1167/sjXWU3Jve18rpZHVJvmdZHf+l5YGDt/aB1jTOzU8bGRQZTS7jz/r7030tYW8SUkoc3TocjLex9wKlOuWy/RrvD6rTcFC+7+f3SThYW034xp7NeD/19ZUj6KVAAFWjNPRGsnpw7rkShEdBNPGYFCLkPK2sU7dFlbWAFuyVnopQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gyeyWwI9B5CDaSsZlURkW/Obf7fz7dAtdwRFRE7Pbk=;
 b=Q0pCJLaFItjlub/AcuSvsFAVfXswD19Nb0JnSjDUuVDORtj7QypLeojGhu7hKh4UeExP/3cLBgqlYmnMzfFdjn70NM8OscCVcaXCk71QMAW6otvcq0gRihQ71TmJ8iRFjhXV9rgfcA2oMtXRnXHjQn5TLHP9EVT7BH7w+yk5e3MAD32SqN2wMSWP2UWFVDRZIi63ecWQf15nZyU0k7s7ccEmde8AW2tyd4CO5sVTLeL7FVweXgECEOA3YzxNqDyTRD3n+ZvA/HLvOs8JeXecAB4npUGfjydhIcFlkiKM0CjxfcDLFXWnjvSnYbIKBslCZQLBUA8yLo84FN19noMTTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by DU0PR08MB9558.eurprd08.prod.outlook.com (2603:10a6:10:44d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 11:16:43 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba%5]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 11:16:43 +0000
Message-ID: <5a302c81-427e-4529-9250-5596a740964f@virtuozzo.com>
Date: Wed, 10 Jan 2024 19:16:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] neighbour: purge nf_bridged skb from foreign device neigh
To: Florian Westphal <fw@strlen.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@openvz.org
References: <20240108085232.95437-1-ptikhomirov@virtuozzo.com>
 <20240108111504.GA23297@breakpoint.cc>
 <a84b2797-2008-45d6-9ca3-c72666d3c419@virtuozzo.com>
 <07490c75-86c3-4488-8adb-7740b14feb30@virtuozzo.com>
 <20240109111228.GA7664@breakpoint.cc>
Content-Language: en-US
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <20240109111228.GA7664@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|DU0PR08MB9558:EE_
X-MS-Office365-Filtering-Correlation-Id: e21ae203-fb76-4a4c-9f03-08dc11cda00b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NacRqxvwwhC/xXbHgjDy9GMSJltcMm0rrthIOi4lbaoGt+tZWlLlp3S73S3+IJ/0xte8cHdPg6uUttmKc39IGROxvqEFgrEEKHQjrPRljrqWD4oLSrG8fTVxtlGp30akLupi76ZHvz4refZxIJ5l2CqAOB9FJdFGGy8JS3EfM8wn2jdncjjeusztqgYZn4p3YhzO8jkp1GiIMEBN1UO8nmXwn7/wayCvQ+t9TB4z8WrIEOXB23IWkfFz+D/qkmVPWuFMxpMVKOPrnRGPdKhARoTy8f4Qbh/zpyVWigIW4FlgJHcmt2dKILROAFuJzQjLTv2RxI0USxHHpIMuItGuRbIthXnWndjecxN7C6iTdDVRbbqnhzbV1pokYEiENQ7MMTkmyAR5uA63Ar9NfW5tEw9KCDGh8l0rPovVeQfQZ4+Op+V1EUBNp1I+GqHzla6n+UiM0irDyzsCjyT3OtKFN/DyjL4tflKl89mDfOKWHhW7hhGTwYSAksVIfLo5TAQN3+OUu2vXR/YFDe2+5DjVyP2o3YgaKetakEns/v1MA7W0wMcKPLGI3mv5KHxzMwEOmU0fYpaxkpeYMqww4+y2x1CUG2RzObOYHknMxW+DnTMOJF0cRW0qAhdvJIiA+qIavdp+lSiaO8ZmfUOG3T+9KQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39850400004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(2906002)(5660300002)(966005)(478600001)(4326008)(41300700001)(8936002)(8676002)(6916009)(66476007)(66556008)(54906003)(107886003)(36756003)(316002)(66946007)(6486002)(6666004)(2616005)(31696002)(86362001)(6512007)(53546011)(6506007)(83380400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmdYeU5ka2k2U1A0Yi9JdXVHeXR4bWRrVDRYbThyd0ptQ0tFLzlvTlpvQXNO?=
 =?utf-8?B?RU5Ycnpzd2xnUU9VSzNvVm1pZHZqWHU4dmtmSHAyNC9LMDA3L2ZBYWNkTmd1?=
 =?utf-8?B?R0ZZZmJIaXV0eWd5cnRmZXBsUFhoVG1ZZlVQaTYzQ1hvK1Y0aGliOXcyZnR6?=
 =?utf-8?B?Y011akF4UUhwSk1wUUQ3Rm94ZHovQlNzenNLU0dTWlFKTE9lb0hQU0tsdU9W?=
 =?utf-8?B?ZkVlUFowOGYvMk1XWXREQzNqQXBtUHNhMUJUNEpPL0dtb0R2SWpQcHlJYzdI?=
 =?utf-8?B?UEg5YzhVa1VIRTFhS3MvQitZK0R3U044em5Wa2JsWlQ2ZWVxUVRWbEhCU0Zp?=
 =?utf-8?B?R256OXFYYnM0TEllWnVsT3MvZFZvOFptWGYvMUtYUUxmMFlVQ2gvMDZ4c09T?=
 =?utf-8?B?aWpGREZZa21mL2N5elJuRllDbnFSeVZZN25sNVBaUVlpWEplNExGRjVJUW5T?=
 =?utf-8?B?MldubXozWnRwUUc1Zy8xUVZOcGUyL3VjSHZ0dGdXenExSlB4NjI0R3FEZDly?=
 =?utf-8?B?U082R2g1N0JXVGZKREFJVlcrRzJsdTRnMTNXcFhFSEw2QnB6K0VidU1iWnZo?=
 =?utf-8?B?V0lzYWUwL3FUSys3RVhDVXNGQzI2OVNkVy9vazA2aExCLzFtbEZSeWNNWFNU?=
 =?utf-8?B?TUh0ZXc3SHFhQzAwem5ia2cwUUFWY3d6Q2lOVDByZkpEWCtCWWNRTER2cmFM?=
 =?utf-8?B?S0xVOUVPMmk4UWkxWExrcHowRVozVmltcUFHRUh0Z0ROdEF5czhMSTFFL1ox?=
 =?utf-8?B?M09xdkp3aEpJZlZicnJuTE1IUnpLV3puRzhMMDk5ZlFIcWUvcjV0L0NUVFdB?=
 =?utf-8?B?NXdPTkZrWkFtbVBsUlBFQXhPY3F6dElrTFdYcVZKOFZRaEFrc1FTd3MvblRG?=
 =?utf-8?B?ckhsZms4VWFTWm94Tm1yd05mRmZKQXhPV2h4THR5YzFSaCtBYjBKckwxV2ty?=
 =?utf-8?B?WWMxWUIxQmlvdmwvajlsYVFScUpHOFNPV2g5aGt2Q3hyMGdhaTFsdjBEK2JG?=
 =?utf-8?B?TmdyQzJDK1UwaWUrQWZRbjhrRVpSWFBNS2FjNCs4UDlRRW9ydGpYVFJ0OVBo?=
 =?utf-8?B?OUJKMlMyTVhkV280YkNiSkZieklTdTJLckgzb3F4MW1tcmJtYjJaT1VFVnZr?=
 =?utf-8?B?dWFQWTFDOFpuTTFldVZNWUFvSGFwZ29sOGpnU1ZldFExb0tQT2MrV0YwVVc4?=
 =?utf-8?B?SThjenhCSkJaU1RqN1VlR0lOSklYdlBYcUgwcFR5SUtTS21OLzVWM3JYU3NQ?=
 =?utf-8?B?QVhyZk1GVGhWYW1hL0ZDWUxFSW4rMjg4UkhxVFlOMjlpYUlzaDduak9BS1kr?=
 =?utf-8?B?V0dMcnEwSUtXeWVFa3JYS1FpUFhEbm1JS20zOS9zTHl1VlhmV2VESlhQUEpB?=
 =?utf-8?B?bGpud2xQTHRQbWtYaXZmUEt0RHZOZjc5YU5XaUZqUjEvSEJhZkZtU2x3aVl3?=
 =?utf-8?B?dXlJbnZTUU1pTm5wb3FGeldQV3JRbHFydmFSVWQ4ZnM4bVFJckRJQUV5c2Jh?=
 =?utf-8?B?M2k1Z0tlQloxOXZZcEVpZnZma0gwMlNXdWxCdnVVTGpIYTFZc0JxUlo4ZjNn?=
 =?utf-8?B?U3diSURtQVo2OCtRdTJ4TDgwcTR3eHRJcnBCM1RTSHU4RGgzbHQ2bEZBZUtz?=
 =?utf-8?B?ek5lYVNBT0JvNE1DaGRMRWpldk0wcjNnTVNNUXZZNVNpOEpYM0grNm0wSXZK?=
 =?utf-8?B?SUJndHdpclVYTEZJZi84Y3Q5QWxQSTJYWmNXZEdSMWpiYUFTMjIwK1owM0tz?=
 =?utf-8?B?NzlOTXdIZnVUZERYdjFza2ttNytzZkovdThUQ1ZJZEtlNGJBaHVpbHlHdi9x?=
 =?utf-8?B?VWxFSEJrcnBjYlJKYVo2aS9XaW5Ocm9WTEZRN3Z0MVBwSFQwdG5jbjU4L3Rq?=
 =?utf-8?B?cG5pL3pJcWNsaWxnOVlGZFgzU2x0TUlCaHVKTGk1T2hudS9yaFRVZ08zUWNU?=
 =?utf-8?B?WllEMDRWQ2pMajlONUI4a3YvSVB0K21PT3pmVGlOOTVmdFhZZEFwSDN4MlpP?=
 =?utf-8?B?ZmpudDNVTDZMejdNcXVDTHpyWFdUSGI2OExBUkJDWUVJd2RiUFlid05TaFRF?=
 =?utf-8?B?S2JaVHFtU3lycEVBZVBqWEMxNTdXUlpNeDRIenFjM1E4cWdiQWQ4cjZnV2Np?=
 =?utf-8?B?Z2kwMWNVQkJUMTBsVGtGSnlxdWJjamxUSVFEakJBUS9RbFVxdlJkeUVGa0Nk?=
 =?utf-8?B?RC8vZG4yYTJTd2NDeGVFUVEvbWJVWXBvTWEzMWhRRmlSK3dQUjYxUFM5SkRy?=
 =?utf-8?B?dEpRdVE0S0YyZEY1L1VGUVlMTllRPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e21ae203-fb76-4a4c-9f03-08dc11cda00b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 11:16:43.3554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZALf2vc7v251gax5/QRVEiIIS0g/WQbpLHIrB7Jwbhjuq5+VhtURcdwoY5J4urAXfUfZuyMlBdrqQqGLkzXmj0o5gmsF3N5nxzRli07K0v0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9558

Here is the new version 
https://lore.kernel.org/netdev/20240110110451.5473-1-ptikhomirov@virtuozzo.com/

On 09/01/2024 19:12, Florian Westphal wrote:
> Pavel Tikhomirov <ptikhomirov@virtuozzo.com> wrote:
>> index f980edfdd2783..105fbdb029261 100644
>> --- a/include/linux/netfilter_bridge.h
>> +++ b/include/linux/netfilter_bridge.h
>> @@ -56,11 +56,15 @@ static inline int nf_bridge_get_physoutif(const struct
>> sk_buff *skb)
>>   }
>>
>>   static inline struct net_device *
>> -nf_bridge_get_physindev(const struct sk_buff *skb)
>> +nf_bridge_get_physindev_rcu(const struct sk_buff *skb)
>>   {
>>          const struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
>> +       struct net_device *dev;
>>
>> -       return nf_bridge ? nf_bridge->physindev : NULL;
>> +       if (!nf_bridge || !skb->dev)
>> +               return 0;
>> +
>> +       return dev_get_by_index_rcu(skb->dev->net, nf_bridge->physindev_if);
> 
> You could use dev_net(skb->dev), yes.

In br_nf_pre_routing_finish_bridge_slow I had to use dev_net(skb->dev).

> 
> Or create a preparation patch that does:
> 
> -nf_bridge_get_physindev(const struct sk_buff *skb)
> +nf_bridge_get_physindev(const struct sk_buff *skb, struct net *net)
> 
> (all callers have a struct net available).

For all other cases I did the prep-patch propagating net.

> 
> No need to rename the function, see below.
> 
>> -       br_indev = nf_bridge_get_physindev(oldskb);
>> +       rcu_read_lock_bh();
>> +       br_indev = nf_bridge_get_physindev_rcu(oldskb);
> 
> No need for rcu read lock, all netfilter hooks run inside
> rcu_read_lock().

Thanks for this hint! I have checked all those tons of cases and 
actually proved to myself that all cases have rcu_read_lock =)

> 
>> Does it sound good?
> 
> Yes, seems ok to me.
> 
>> Or maybe instead we can have extra physindev_if field in addition to
>> existing physindev to only do dev_get_by_index_rcu inside
>> br_nf_pre_routing_finish_bridge_slow to doublecheck the ->physindev link?
>>
>> Sorry in advance if I'm missing anything obvious.
> 
> Alternative would be to add a 'br_nf_unreg_serno' that gets incremented
> from brnf_device_event(), then store that in nf_bridge_info struct and
> compare to current value before net_device deref. If not equal, toss skb.
> 
> Problem is that we'd need some indirection to retrieve the current
> value, otherwise places like nfnetlink_log() gain a module dependency on
> br_netfilter :-(
> 
> We'd likely need
> const atomic_t *br_nf_unreg_serno __read_mostly;
> EXPORT_SYMBOL_GPL(br_nf_unreg_serno);
> 
> in net/netfilter/core.c for this, then set/clear the
> pointer from br_netfilter_hooks.c.
> 
> I can't say/don't know which of the two options is better/worse.
> 
> s/struct net_device */int// has the benefit of shrinking nf_bridge_info,
> so I'd try that first.

Ok, did s/struct net_device */int// variant.

-- 
Best regards, Tikhomirov Pavel
Senior Software Developer, Virtuozzo.

