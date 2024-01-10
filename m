Return-Path: <linux-kernel+bounces-22274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9156B829BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE5328709C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6B34BAAF;
	Wed, 10 Jan 2024 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="t5KG4HTM"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2092.outbound.protection.outlook.com [40.107.20.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C767A495C5;
	Wed, 10 Jan 2024 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fjae62TxSt7lzUwzpwwwy2enMSdLVIaern2InCoyz7BhTzk3S8oX8QqYWtAy0cHAX9LabMMR3g4BpD+kOQ+Nm6RXIgKe9TdDP/sV0ONBHEoNunzAq5EvRPVaI5Lc2d8qXhtp7j4SuiSAwq0VmOVLE8QPBSr1t3GK8IUVjm6qQomqA5wUfc+OndT9zCrCpEiWKmeNuEMhVrcMWmYNm03+mTPzWIdBzvWaR4kI9Xs+pevlt13SIj7kzp20zIOIKG2OMXceBxzNuBGj6xCenLgBCU2fDHKpV33BG/eHehtRo0JnPrrbTruG/pSzpH0wE1gCgP9TD/t/VyVMvF/KKKh8bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWYHKqKa42xFEGod0ASMSyIyp8a5/PJWi8Htbuz+xTk=;
 b=C7K8jxRqhTSWbx+kw24n2Xbum5DnUKzWulotjKDFepUqAQaPo6MVEod2WL4H9jw4fuQyg6LymjXBJ1SHMdeH6FYpP+NSXodS29eTd+kEuKdbzT9PTZFiAg+al0XuZreFQFrImYqyeyfi7WmUHLZ6luwGflpL/fFnbyJRjjZ76ZXIV+VhDgDC7EsVH2vxUVhAZXTtmjvgk0cMsbzHNcHYtmVXZsOik5gbQCkta4Dw6b7QaYnfiGOjjHBTZo/zbzDlTXBClWgz4o92sbyKqRALOecXMuywtvASuUX81w0bJOsq9hdeARXlFuIRC7EBCGfduxJ+CQSbYWe8+QUfAJo9pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWYHKqKa42xFEGod0ASMSyIyp8a5/PJWi8Htbuz+xTk=;
 b=t5KG4HTML+BAQdyenECRUa4RX64x3H3VEIL3QuyLx2rC5e1ZCsxVq7kjODSeT4tT9fQ0d2L2yTCfoyWWQ3p8HiqiJWX3LdrmSpD6l2jNsjCQoQbxSlpO0JXF+2zWQlq0x7UYA3EaXoeFZH2uEZOgE3wO435eNYfFql5bAnAqXhHLGMvHzcAEebd4NsU7BEE5QcX+gbZRG4dxE/8hrx3d/SDLRsGnox3TIrG0HZh/CWqUqag3RD7OVOHtAypAA2QNZd6kTmPauD2feeGZ9YjLLqaF8abzTsKq3Wv63zJ/Z5WqsxNflDjpDfq7hj82i+TFLjSzr9snl0uLYKHupybE1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by PAXPR08MB7468.eurprd08.prod.outlook.com (2603:10a6:102:2b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 13:48:22 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba%5]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 13:48:22 +0000
Message-ID: <367b1642-c09a-4bc6-ac63-7692b716174d@virtuozzo.com>
Date: Wed, 10 Jan 2024 21:48:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] netfilter: nfnetlink_log: use proper helper for
 fetching physinif
Content-Language: en-US
To: Florian Westphal <fw@strlen.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@openvz.org
References: <20240110110451.5473-1-ptikhomirov@virtuozzo.com>
 <20240110110451.5473-2-ptikhomirov@virtuozzo.com>
 <20240110133333.GA24888@breakpoint.cc>
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <20240110133333.GA24888@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR0401CA0001.apcprd04.prod.outlook.com
 (2603:1096:820:f::6) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|PAXPR08MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: a198e0d9-5e56-4092-e27f-08dc11e2cf9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UY39PyeBazRES2G3Lu0OTLgT+qHCDTvgHa/hEcu3V/YRiiVzg1H6VDjHOSDrnliwwTKUvD6M18FPCrEgS9EttFG1zYvLt1ybGu4Kqu1S20WKiFyx90piFeJz/W5bcehJoBSCa5FlsuZmltxj2+6y3Lys1r1aCoZD3atpuKAUS8AGriNSKjrydj80RFq3mL54d6dfhgEBz8pq9mbq5OjnYvcxmIaleOB6ZDsoZDs5owf3xQuudpiveDgl9BuC4oC3puOuLD4ROdQL3Hrk5Y9hFkGYbp3OLAk4xKlj7IzKuLL+WimZEJEwWcpEjMca/kQh5lt0vvlAiu1D54ZXOC3vlHMgSDm5YeZmefpoY/xVVvO9gqfv8wBuCX5XbFMv+GS65GUQE9y8N/DbrIcDkrTPpDnEkYbGP0Ssyw9wVbR4QiPC3RhRxr+/HumXV4pdPbkzJ8JMOrscXBSJsEI08OpW0sbzsXMYWaGeFKsMWNwITmQRDpd1mbAGLu+h2AkhSWjCMtahxn4Xv7/YQ6sL+Vjl69TOzUWMIp4asEMgLNMEDNXZwpJAa2dbSsyaQbgp5yU/9lNIXE2OfLwFrIhx9ZTXWlv6CfXeXu0DGeOB4kFEuViudRq5+qX8GMtO1eB+Gxw1Gsl/Nf5hZJJbHmAw+SzEiA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39850400004)(366004)(136003)(346002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(83380400001)(41300700001)(66946007)(36756003)(86362001)(31696002)(38100700002)(2616005)(6506007)(107886003)(53546011)(6512007)(6486002)(2906002)(54906003)(66556008)(66476007)(6916009)(316002)(6666004)(478600001)(4326008)(8676002)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWRFY1hBV3VZTUFkT29pQmZlYm9UUy8yZW1FOGNJOVFSbmVRaEpPSkJrODhD?=
 =?utf-8?B?aUpZYUxBbGVGbzhvU1d0bTRMNFZaT3F2RnNqZW1GL3BiY0hjdUJlblpWcitY?=
 =?utf-8?B?V1RaY0ZhWWFPQWlCM2VJQmwwbVVOQWVvZXc0V2xPOWxwSFdlNytuRWdmbFIr?=
 =?utf-8?B?MmxqNE0rb1NXTVBtNVMraWM1Nkoxa3pzU0NPcmtqcGhYNW1jWFMyZ3hjS00x?=
 =?utf-8?B?eWwrNkRBVlNqOUhoTkxsNTFOTlQ1cWcxZGUxMTA2U1R0NWgyK0wxODY3NHFJ?=
 =?utf-8?B?NDZPVzV3Y0VxZXF6a09HQlhGU3UyWG5EUVphU2lkY0E5aDdJVk1PbTRmNW94?=
 =?utf-8?B?REplQTlCZnhNR3pDM2UveEo1MnBkamxINTI1ODJXRlMwSERJdUEwWGRGMlVo?=
 =?utf-8?B?UXRUVGhlaUdsTUFBZ2ltVnpjT3RsWVhuVlFhSzVNaFBwS1FUMkRmeDNXNG9v?=
 =?utf-8?B?Mmx3dU1mVkcrWnpoL2dmbERVZmQ4MlFaMUJYM1ZjbENIZGx0dnNVWFd3eFRl?=
 =?utf-8?B?Q0N2M1VmSnJiUlBRYTdyWGJwZ1IwR2lYN1VadWlCdkRTS29ZWmFYR2Z5YWRN?=
 =?utf-8?B?M1pxU01aUndjZ2hGaWh2aHlrQ1luSlRGaWUzV1JjSDNIYU56RW9mU1FsMzZG?=
 =?utf-8?B?NDhhYW5DbHVDU2RIOEk1VTdNSGZ6ZFdYd3loSjZJVCtSMVU0cVAvRWlBd3Rw?=
 =?utf-8?B?KzhDN3RCSzJKMkwxYU9VRzUxVkZCQ0ZSSzBjOUxWRHRlbTM4RFJ5NzdYbEZl?=
 =?utf-8?B?SXR0RUlKcnZaMGd4MG1WVXBkaVFCQVRWVld2bWltWDB4Z2M1Y0RJaTN2b3BC?=
 =?utf-8?B?YWtaOHI0VzM1dW9WV0pIcHVOa3ErSFAzUTlDVFlIbkR5NSsrdUtxaWlLenlH?=
 =?utf-8?B?RkFadmgxVUV0N3pKV3NOYTFFMjQwSEFWNmY3WDZObGxGNkhWTkhVSEJXZU5Y?=
 =?utf-8?B?TER6c3Y1ZEFNU1A4eDdaTEdaZEwyZnhOd2xCVklGbG4zdWdBdHBlNVk4Q2dt?=
 =?utf-8?B?Z0NzQk1icW02N3hteVFOQnlQN1RnajFnZ0hMajRpN1NSN3FrUE03NHVwZUZK?=
 =?utf-8?B?VC9HVmQ3U0hkbXBLS29IU2NaT29vUzduTWlWc3lpV2c2b1hkZWhXZWJaZjF1?=
 =?utf-8?B?NkQwTXMwbGxHZ3ZvVGsyTk5KZFp3RzFBaGUySHA5bngvWk9vMm5hN1hlMlNi?=
 =?utf-8?B?RmR1ZGhPZG5ndDJ4OWNYZGFkYmtWaWJTaHNiVlFrbW8xT0lvd0VYSW1MUTY4?=
 =?utf-8?B?emhnNWs1WVhoSFFzTktVNEI4N2pZVjByZDg4U29ZOXVPaU1ZajNVTUx5K3Fy?=
 =?utf-8?B?TjB5L3ZwbHlJOHJBbGVuUUQvZGVPb3lwSWxCK0RHOXZLLzNaZnZ0RlhDVmM4?=
 =?utf-8?B?eCt5WG5GS0RGb2pSQ3lOZDRHVEZFT0YvK2xkYW5IQ3MvZy9SNFpDVlBuV0tp?=
 =?utf-8?B?NWo2enBvc1EwOXpCUzlyNVRGVUZMRUxFV3VLbFM4YTNaWDlBdmNqNmFKOER2?=
 =?utf-8?B?RHVJbUlmdE1nYWxEUkcybVU2S0JGajJkNXIweHpObjlyTlltQkVnbDI5VTBM?=
 =?utf-8?B?a2M3aDdBVURZcGZweDJaVFlMbjZNSVhicEYwS2tJaTc5UnVPMUUwZUVRM2lD?=
 =?utf-8?B?Z3lHK0NZbDZLWGpzVmNpcm0wUnM5MWZ6cHZpaVFmbExUaFJMTTdCcVM1SU1V?=
 =?utf-8?B?SGN0bFZsb0lDTDh4dlM5RTIvUW91UklHWnlDcU93SFNIYjd6OWRlbVY3anpt?=
 =?utf-8?B?T3U3cDFPenNQd2FmNG5VeGZhNEFRZXl3M2pzVUZ4WlYxU3kxR2o5WWZtUXRa?=
 =?utf-8?B?VURYWFhIQVJ5YW5mK3l4NGxOaEdLR1AxcTVBL0xpVmZyZUtYUU9JVE91WFMy?=
 =?utf-8?B?Y2ZpS2hoSHNaYVdRNzJBc2Q4a2t0b01DM3ROQlIvVWZEMmo5dTMxMXdzVXpX?=
 =?utf-8?B?cGZpZ1h3WjRxSzRmdU5Rd293Z01VcDJwdGxuYVVsN0FmNEJrdy9FeERIT1J6?=
 =?utf-8?B?NEJiTVlwYmI2dFRtWkZjU0h1cU5jZE92NWI5ZURTYUgyaC84YmRsRDllbENL?=
 =?utf-8?B?Y3NFZUJXVlVJci9RTzBJTHRJZHYzcm1iVmlKVmJGaURQTVhZSDZWZ1lnblJt?=
 =?utf-8?B?b0xpeDZXSE5ENFdGaG9RaDhEK3hXUWE0eTc3V3lmTjdZSDV5UmNMWE9BQWpR?=
 =?utf-8?B?UkdMdFR1Qk41ZFlWOVFhTE93blNVZ3RjZzJua2VYS1pqU3RvaDZGSXN0dVBI?=
 =?utf-8?B?bzVsTXVCbVVnbWNGYnZNeTNoV3dBPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a198e0d9-5e56-4092-e27f-08dc11e2cf9b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 13:48:22.6340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DawzuBZeAHSqGEotznUkYJFtDBn/pP/AR7kdz9obBgcMOU5ohgvHDmb2FIJtIzouGkN+MfNtkFLShNDkiGI9yrRPDzl1US9lkQQw2LswAfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7468



On 10/01/2024 21:33, Florian Westphal wrote:
> Pavel Tikhomirov <ptikhomirov@virtuozzo.com> wrote:
>> We don't use physindev in __build_packet_message except for getting
>> physinif from it. So let's switch to nf_bridge_get_physinif to get what
>> we want directly.
>>
>> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>> ---
>>   net/netfilter/nfnetlink_log.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
>> index f03f4d4d7d889..134e05d31061e 100644
>> --- a/net/netfilter/nfnetlink_log.c
>> +++ b/net/netfilter/nfnetlink_log.c
>> @@ -508,7 +508,7 @@ __build_packet_message(struct nfnl_log_net *log,
>>   					 htonl(br_port_get_rcu(indev)->br->dev->ifindex)))
>>   				goto nla_put_failure;
>>   		} else {
>> -			struct net_device *physindev;
>> +			int physinif;
>>   
>>   			/* Case 2: indev is bridge group, we need to look for
>>   			 * physical device (when called from ipv4) */
>> @@ -516,10 +516,10 @@ __build_packet_message(struct nfnl_log_net *log,
>>   					 htonl(indev->ifindex)))
>>   				goto nla_put_failure;
>>   
>> -			physindev = nf_bridge_get_physindev(skb);
>> -			if (physindev &&
>> +			physinif = nf_bridge_get_physinif(skb);
>> +			if (physinif &&
>>   			    nla_put_be32(inst->skb, NFULA_IFINDEX_PHYSINDEV,
>> -					 htonl(physindev->ifindex)))
>> +					 htonl(physinif)))
> 
> I think you can drop this patch and make the last patch pass
> nf_bridge_info->physinif directly.

The whole Idea of this patch was to replace nf_bridge_get_physindev with 
nf_bridge_get_physinif before the patch which propagates net, so that we 
don't need to propagate net first and then in later patch remove it when 
replacing with nf_bridge_get_physinif.

But I spoiled it by forgetting to remove net propagation to 
__build_packet_message...

Is it ok if I leave this patch as is, but instead remove:

diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index 134e05d31061e..ad93dd77e6071 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -463,7 +463,8 @@ __build_packet_message(struct nfnl_log_net *log,
                         const struct net_device *outdev,
                         const char *prefix, unsigned int plen,
                         const struct nfnl_ct_hook *nfnl_ct,
-                       struct nf_conn *ct, enum ip_conntrack_info ctinfo)
+                       struct nf_conn *ct, enum ip_conntrack_info ctinfo,
+                       struct net *net)
  {
         struct nfulnl_msg_packet_hdr pmsg;
         struct nlmsghdr *nlh;
@@ -804,7 +805,7 @@ nfulnl_log_packet(struct net *net,

         __build_packet_message(log, inst, skb, data_len, pf,
                                 hooknum, in, out, prefix, plen,
-                               nfnl_ct, ct, ctinfo);
+                               nfnl_ct, ct, ctinfo, net);

         if (inst->qlen >= qthreshold)
                 __nfulnl_flush(inst);

from third patch?

-- 
Best regards, Tikhomirov Pavel
Senior Software Developer, Virtuozzo.

