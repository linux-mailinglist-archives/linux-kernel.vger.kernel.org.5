Return-Path: <linux-kernel+bounces-72406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8055D85B2E1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB815B21CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB1F5915C;
	Tue, 20 Feb 2024 06:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="praZsGUg"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71FD59143;
	Tue, 20 Feb 2024 06:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708410376; cv=fail; b=Hol75iUSAN74/yOFmYCZoDBORlD9JhE648ZNoDfktArTxrgjPF5LzRLrMfVtPuj9mdMQFqmgod/tkBprXmh7m+G935kBA1ypdeet/cs8fCmbwcOPCyjp+XFUN2p0cr2/9EncsM3jojy+KgLMsMf2yNQhZSYRSa8j48CVnn54xgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708410376; c=relaxed/simple;
	bh=n6HYHZyqeYVoDTwqSjaUwblYqzUcrH1o+66WCkN5vIA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nLU3dEJ2IMnqZciKhXrLP3epYOIJU42Gh+qRC5TxLnrc6fnHOJjA1J3FzUQVepAIa7tf+GgmOhMDcJoYMOHTr8BOnyxxQ6pwEM4uFtbxveQLqAWGEjURZjUCAU7VSnJXVTbjIoKZs6RHZ+2AKbFcBxclLhpGqOsMZGdX1Z+5Asc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=praZsGUg reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUwF5Cti+MoL/xkC9OprrezyZISjrGKTTNpdIin7Z5Zg/P6c4CTNmsRUHQthlq72siBYu2dq/VF+SLSFraEiFjzimXKgj0Sdoy1DymF6yV/+k5aRQ5djF8qiGV+PW3id66VVp2Tt7OXXcvoCSyeNlUlpX5ccVlKuBmOeu5C3wHisHUEMHHxv1BX2jBYo6qk5I8zErQHpkdekSBVERk1mjTCk7K5mHH8T0/NoH7ghqo/eb+Z9fCRO0daytG5dGYSYZ4zni6moUIMG1VdRXYuexLysanhzekzhF+2dLhmZhmYpiscEGooaSp9hN/GEgv+bfE4qIr3eAXui2buQHJSZ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3P/qavSTBHEr6qtlUj+jGAP1Xoz0gjLAgQH9psku2E=;
 b=GHU5NJ68AHx5TSAKqXuTm55UZuqSVvHmkG3FEG00cjBVNpRHbLU9elxPqWi/aavhYp6TBLYE2fsRN4UT/xaEzUSGFmkniMR6pQ8EqF1EpHND3cwEYmKl2VPC1Zv3L8msclHDelbVR+GkCm2vhTCiaeEbjHn+CJbI2ap+JsMB2cV3y2sczB4RguNvoAiHIXygQx5Db05+RN0F95eZ+TQ0hPGuRIFxM6FdkSFkMrSGqdUPv9diTikveoUfNcYOjXUXtwvUKQ4tkf1+faRiEANmENfMIjmrv8xrVkgMQO+wjZNSYc8EiGDuk2+XBUfyoXrSfLuuw3+ZzVYbp9oBIdG2Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3P/qavSTBHEr6qtlUj+jGAP1Xoz0gjLAgQH9psku2E=;
 b=praZsGUghtLO3YAIpjSqjqDhqAf5Y6FDUUtLagr+lORhgKWiyt6ZyQoQGZTThl5ZawLzNXRhS0lRjlKtdiCQezYCSLbl2175rbOVWz65gvBBK5Dvvsm7Opb03tIxFwYR2gVI5/USLDvc496b0+8smKasxE5HoPsPh9jIQv9eByg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 CO1PR01MB7307.prod.exchangelabs.com (2603:10b6:303:156::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.39; Tue, 20 Feb 2024 06:26:10 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com ([fe80::91c:92f:45a5:e68a])
 by PH0PR01MB7975.prod.exchangelabs.com ([fe80::91c:92f:45a5:e68a%6]) with
 mapi id 15.20.7292.029; Tue, 20 Feb 2024 06:26:10 +0000
Message-ID: <bea860f8-a196-4dff-a655-4da920e2ebfa@amperemail.onmicrosoft.com>
Date: Tue, 20 Feb 2024 14:26:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: skbuff: allocate the fclone in the current NUMA node
To: Eric Dumazet <edumazet@google.com>,
 Huang Shijie <shijie@os.amperecomputing.com>
Cc: kuba@kernel.org, patches@amperecomputing.com, davem@davemloft.net,
 horms@kernel.org, ast@kernel.org, dhowells@redhat.com,
 linyunsheng@huawei.com, aleksander.lobakin@intel.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 cl@os.amperecomputing.com
References: <20240220021804.9541-1-shijie@os.amperecomputing.com>
 <CANn89iJoHDzfYfhcwVvR4m7DiVG-UfFNqm+D1WD-2wjOttk6ew@mail.gmail.com>
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <CANn89iJoHDzfYfhcwVvR4m7DiVG-UfFNqm+D1WD-2wjOttk6ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY8PR22CA0004.namprd22.prod.outlook.com
 (2603:10b6:930:45::12) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|CO1PR01MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 00191e14-3875-40b0-c28a-08dc31dcd407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8AkEJ68j1JIIHXSSQRHyvdoGyh2kBVZoQ+ZIlPOH0dWBHlnnthuHcA5b7yZF26JijMDpjdraFxc1UEZnQZM0O4aKyaGSpOcRvQebz8Yb+dIsvayUyJHd+ri7x1L5xoiTxodxwy46ZoDTvIxhkPliHkIYSWfs7mtLlMy/2pClRA+IfAQ88kUa9UNnZPKqYY420MJrqQMT9jR4bS1vhGGbN1FyAnpaSz5ANNHDbZjWgoozK6BIbSbWk6dh5q53e217spPHwJlB4fIklkiVqCTxItIeTRQqOo63JQ/7MnnxqUiZasdIKmvgVkupoCJIlPrKZsoisxBZCJ8FlDOx4VK/vFrGF2k8lS9Ijd6Jridxk+ShTnIRXBYxmD8FHHVHWYcxV+NxDH+/sxAAowSe7rLr9rkqhedsnwjgWmYfyPDegZFgxMCqCSpXvYaLrXhd01puZnYyTiThJ8HPvItNw6H9IYDd7irUi8K36F3i8PmiWpCc1A4RkTtxm3Yx/2rk50//RwwMUIXkJQSKP2ElqQGmNX0rCXW55fsro4qB9r/HuNI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGVJWm5kVnp5TVQrRmI4S3BzZ0dmMUprR09peGRKQ3ZmbHdZeUJSdGgrS3d6?=
 =?utf-8?B?akNUUXJCWFVTUmwyMHVIZGpoQ2F3Q2x0ZDRlTDkyUmtOWklubTVsUlpyQVoy?=
 =?utf-8?B?MHAzZHlpYlo4UllZRDNzbjc4bmYvbGk1MmhxY3dCbWtmQnNwOHVaYVIxcnBm?=
 =?utf-8?B?N0xLU2lUNm5tS1MwdXNSZTZqcG1Cb3lPWmhBdzZvRmpURkEwWThyb2cyVzlu?=
 =?utf-8?B?MVZPWGlDMmFOOGhiemtsQmdQUWpUb3pVdkdNRktmYnRRVXFoVS90TTZZdXZ2?=
 =?utf-8?B?UE9GNmU0alY0Q2JHVGFRYzlzUkVHWnJiZjVhNGV3TGRnZjJzSC9nV25RZ3Nv?=
 =?utf-8?B?QzhDRms5ck1PTXU3NlZxa0JoVVVrR2l0OTFwT3lXNEFqK0dPVkFFeGdVcUlI?=
 =?utf-8?B?Qm9MMXB6UmcwS1hzNzBUVUk0QnkvVGFqQnZyTThPSkhXN20wb0lUem56NFF3?=
 =?utf-8?B?WUxQY1liSGdqeFdLWTFjR09YRkU2RSswK1lQSlB4VVJ6dUMvb3YzOUVPK0xG?=
 =?utf-8?B?cDcwWWhiMGZtK1BYWjI0eXFvVkE2YktLWHNVdVdDZXA0Um1QSENZZ2tTWEVm?=
 =?utf-8?B?TkJBcG10TllVdGxxcmVIMHhpdkNDdDBNT1haOWpua2Jqa3hCbFB3KzlibjVL?=
 =?utf-8?B?SzBFVkd2SmR4c1paMDZIMlI2Ri8xUTRMakdjL2Y3OVBFRnNUVS9TUHdSL3Bm?=
 =?utf-8?B?Z2VvU2xUZWFrcWtQN09tbHpTQk1RMUREYnQ2VmtlK1pRcTl6T0JHSGhPZU9C?=
 =?utf-8?B?RFlXNUFuMWFwcFJrNnRBb1hBZm9LeG0wL1l3WmZoVUNYMWRFb0M1eDRMOFVR?=
 =?utf-8?B?NldVbWdncTBTRDFqQ245ZTVwR1R2bENZczNPbmxSY3k4UE9LZEV5Tm9HVTZn?=
 =?utf-8?B?ZDUvckxjajZNdTFKcXU1dE1OMDQ5eWowTm80S2Qzd2l5Mm1FV3VIWWptaDFG?=
 =?utf-8?B?ZWlhOWtrenZLZ1pxeldLY0Z2VWxHLzg2WFVEVkMrUDBMQml5dHdTeGJHMjR1?=
 =?utf-8?B?eE8xeEk0UDU2d2gwNXR3SmhjbkJlaGg5aUUvTUtvdHNTY2RFQTNkQU5OWFpw?=
 =?utf-8?B?V2xsSlUxWFR3UGxIVmQxOHJmODU0NjRlM3h5MVZKWnlsQW1SOVpZK1hldTY5?=
 =?utf-8?B?Y2JVMjhUcTZibUExbnBNSWE2Nmc2UjJ2d1F5ckNUbnFlZEZvcnZZa0ZUdTJC?=
 =?utf-8?B?ZGJYaHY2T2ZjRXFBUzNsRGhPWE40a3g3QVBROXpnSnZUOWtKRlMyV0VHZVdh?=
 =?utf-8?B?SXZCQ1hIdDlRRFJjSmI5ZTB0bmhSUnZpb3AzYm9WaUVLYTg4RjdqaThQMmZ3?=
 =?utf-8?B?blVPSi94N0hBTVpKSVpPWGVNSVUzN1dGelpseUlsdTdqcnZXU3hMZythcnNQ?=
 =?utf-8?B?VTdnYTFseDVqenlVMmh3T0x2UHNyNGNPUGtmaDJ1eXdOZldHTngvTG1BSVBG?=
 =?utf-8?B?bmFVUVJEU2VObStNZjhwRHpEbHpZeUFUMjgxSVhWZDl4R250VEJwVEFySTJn?=
 =?utf-8?B?M1d0NDJhMnFOVmtINC9yQTYxYlEzUE1VVXR0YkdlOGpaT0pQY002UUxHQWhw?=
 =?utf-8?B?VHNZM1EzVkJ0SytHNzRCVHljZklnMFFwbGgzRFhBTjJrUHRUMFh1RnN3MFpx?=
 =?utf-8?B?aXVLWkY4UFgrQ2ttUnEvTXZJTzFCVEd5OFA1QWl3MmRnQXhJcno5cUFmSXdh?=
 =?utf-8?B?ajlUZ3ZqcEswOXNENW1HSDJRcy9qRUJOQUlkc1NqS0p1VmVsSDc4MjF0TE1q?=
 =?utf-8?B?UldRSlB0cXJpWGs2aW5BdkFyRDJHSWg3NHVXY3Vkem1QK1g1NFAxN1FUZ3dt?=
 =?utf-8?B?RXFmWHEzSSsrZ2YvSmZzdFFRQSt5SHE5cTVSS2FhNXoyc01xOXVPNkRmQnFz?=
 =?utf-8?B?ZEZJSGNWNUVoUjQwSkJHL3k0L04xM05JcXpsRU1HVFJQNzk2N3hZcEk3MFRB?=
 =?utf-8?B?M3FLcGdaT01jWm9Wdm8rRzhyYUl2TGk5bEN5YWJxQnpodURPb0RNZzBXSHNX?=
 =?utf-8?B?YUF0TGp6b2E4OWJOY3ZYdGs0RU5PVytURjJuWE9helZLNXhpMDZJZ1c5czMr?=
 =?utf-8?B?L0I5NzhremZ6N3V1NFJQRU1nY0J6YXRXd1A4VWNIRndsMXFiVlhDVFZ6NURx?=
 =?utf-8?B?Y0Fjd29WSGFhYTVNWllCd0IvNVRhSElJeXJGdUM0SVU1bmdSVHIvN0pGOWQ1?=
 =?utf-8?B?eFE9PQ==?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00191e14-3875-40b0-c28a-08dc31dcd407
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 06:26:10.2091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BoILI5Nz9J2E7CHVmRwWSdnSoX4tUbpRkvRFWP2EgbjFvpHMvR4C7wewrUytW00Lb3rYb/m/6AQAvaErpeu6C5lqfM6so+5HiffvLZnJXFsM6cHT3Jlna0sRFcvOzCBJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB7307


在 2024/2/20 13:32, Eric Dumazet 写道:
> On Tue, Feb 20, 2024 at 3:18 AM Huang Shijie
> <shijie@os.amperecomputing.com> wrote:
>> The current code passes NUMA_NO_NODE to __alloc_skb(), we found
>> it may creates fclone SKB in remote NUMA node.
> This is intended (WAI)

Okay. thanks a lot.

It seems I should fix the issue in other code, not the networking.

>
> What about the NUMA policies of the current thread ?

We use "numactl -m 0" for memcached, the NUMA policy should allocate 
fclone in

node 0, but we can see many fclones were allocated in node 1.

We have enough memory to allocate these fclones in node 0.

>
> Has NUMA_NO_NODE behavior changed recently?
I guess not.
>
> What means : "it may creates" ? Please be more specific.

When we use the memcached for testing in NUMA, there are maybe 20% ~ 30% 
fclones were allocated in

remote NUMA node.

After this patch, all the fclones are allocated correctly.


>> So use numa_node_id() to limit the allocation to current NUMA node.
> We prefer the allocation to succeed, instead of failing if the current
> NUMA node has no available memory.

Got it.


Thanks

Huang Shijie

>
> Please check:
>
> grep . /sys/devices/system/node/node*/numastat
>
> Are you going to change ~700 uses of  NUMA_NO_NODE in the kernel ?
>
> Just curious.
>
>> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
>> ---
>>   include/linux/skbuff.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index 2dde34c29203..ebc42b2604ad 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -1343,7 +1343,7 @@ static inline bool skb_fclone_busy(const struct sock *sk,
>>   static inline struct sk_buff *alloc_skb_fclone(unsigned int size,
>>                                                 gfp_t priority)
>>   {
>> -       return __alloc_skb(size, priority, SKB_ALLOC_FCLONE, NUMA_NO_NODE);
>> +       return __alloc_skb(size, priority, SKB_ALLOC_FCLONE, numa_node_id());
>>   }
>>
>>   struct sk_buff *skb_morph(struct sk_buff *dst, struct sk_buff *src);
>> --
>> 2.40.1
>>

