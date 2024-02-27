Return-Path: <linux-kernel+bounces-82746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509518688F8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0426D2848E7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450E037145;
	Tue, 27 Feb 2024 06:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="Lq/UWL7n"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2132.outbound.protection.outlook.com [40.107.243.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3A0256A;
	Tue, 27 Feb 2024 06:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709015460; cv=fail; b=oQpcMxt8jMB6O86vcfXCXDBp7AfqxIg6tT2FXmjCiTSgyKs39dSeHstARvhO15k+eXBZZnwi/FBJ9H7QSaM4XnnH+pQ7W5B+abAmcPAa5zaDdrk2goPHfcruiVRMqcaxTe5xanXqxatHJAr6TqnRlop/197dK4faXc4obRjUuH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709015460; c=relaxed/simple;
	bh=A4OBHuT+6b5vMXBjV/MpzXiQRRHtb+JKExegOVgKoSo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W4aqn3Y+FYZQiCy9rOWr8UyI8wIJ2VScDw50cEWDGhtl0ITz4G8rbhSDDb4QnfidvHVldE5cCQtvV2+Zk8t0QW1cB/e6usVX7yhobVt8sjlbH5JdlwU8LLpITEUfmMEgkA0VtSt+SOeHimjqzKgW2eIU2ljibFxyI/7/LJrJ3EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=Lq/UWL7n reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.243.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETPCbNKMmlAfz0+Hi116e5WFMbcArx4vk6h+q+LNtoxpZxfumT4vJt+8gpIs5uHQTv9JiX0mluI8jl/LDnxd9rEsFt4hxSD2emQYkZRWU1nZQVNlPt6XlnvlFFoc5/R9RcWC0MNrZqJCqNS8UgZILHh+aM44O082uufeLHyyJJoCUqPlzeUXJMhxzL0nEQ5MNd5RTVIVwcy1BJk0P16BurPcH77rwD+WyaL36ne4MDCN+RtVS7J6bqAsdkQxaA8vLRHMWkMNgmKd1ToXqDvAnibOmmULECMtnlkrjfloVBl/hu+jbBs/k6vpIdCZoxgn0KJ72cmuX3b5KgClmx854Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4OBHuT+6b5vMXBjV/MpzXiQRRHtb+JKExegOVgKoSo=;
 b=SzLnmn1ORZ4uAwjy0DcTjh8dmr409rKzq1StOTe0jPUhp8g+w5AteDA8VfXh5FqXBbI5P+aBvNYNU0KLiTUPgnTkfWT1BBKVrjWSRFc+jFEgacAUvI1CQ0mcOATM6Smy5CfzXi5ZHmXIDd6Ct+A8o4Qs6byWRleYb74SLNQQHbh+IHIcBDims6Is1lOm2nlLAsDA+Dhs8RP0c7aDzN6zGpicT+t5nwtYRSyHsWaT1JMQ76JoMbzdh/PKkM+DjF0Ux8CpbOoVMPbJa09HqPyKaXDfDTB0Bz9ShHVSe2/QFwvPKBW34drEeNs50cqps/l5e+jqIJkMn50tNZNAQL+2kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4OBHuT+6b5vMXBjV/MpzXiQRRHtb+JKExegOVgKoSo=;
 b=Lq/UWL7ngWJ38P6u3k5D6DGM/JVLrznlz5KMhZ0OM9xcq3X8nsPaaYiCb/ijeaCb37FOsOc/cZtCzxiBoQWDdvxtbavgNijuy60e65ykwPjFHowyDoWupchp84Cjxs0hJ5LZudtbmy9/RDx2oEch3i/f6R/aY0QAdmgsIOtYV/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 SA0PR01MB6172.prod.exchangelabs.com (2603:10b6:806:ef::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.36; Tue, 27 Feb 2024 06:30:56 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com ([fe80::91c:92f:45a5:e68a])
 by PH0PR01MB7975.prod.exchangelabs.com ([fe80::91c:92f:45a5:e68a%6]) with
 mapi id 15.20.7316.018; Tue, 27 Feb 2024 06:30:56 +0000
Message-ID: <19162784-e267-4531-9906-bac3de7cf6ac@amperemail.onmicrosoft.com>
Date: Tue, 27 Feb 2024 14:30:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: skbuff: allocate the fclone in the current NUMA node
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Huang Shijie <shijie@os.amperecomputing.com>
Cc: kuba@kernel.org, patches@amperecomputing.com, davem@davemloft.net,
 horms@kernel.org, edumazet@google.com, ast@kernel.org, dhowells@redhat.com,
 linyunsheng@huawei.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, cl@os.amperecomputing.com
References: <20240220021804.9541-1-shijie@os.amperecomputing.com>
 <de696b4c-bda5-4ab2-a0c0-490b4eba8163@intel.com>
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <de696b4c-bda5-4ab2-a0c0-490b4eba8163@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY8P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:930:6b::25) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|SA0PR01MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc4c068-dd2d-4786-67c4-08dc375da79e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0w+O4qS3CO8y7MOE5+ajHzUxCJ42/8Iw+v93lBHUPiVlsl17qCUAX9eKy7i0rSzG1C9HzbA1dQJ/wnJ4+F0isJ5N2JR9kEDwOj8C3+PwqfX/DhpvpyJak7yjyxY4xCfywG0KPBSmsKgs97B2pmY7K3yHclz6O8lp4ASpE1PxjWnJ3eBOFeeEnQx0sC5GhecvyB71dxuF667zg1k84m3xZ1BLpgbqVpWKt2ExK3zO/Ee7o3b5AcJchdpjaB+bU03NuE+KlVCGYYdOGwzt6HTMIxejusdNHnrmW6dC5ZYzqSvsQeNsNHq1kEbKXnh7Q6Xy62GYQlROq8ejlAF4m2LONQstywAQzfaqxHItS+/7g71twEcMobecz4WBBSdvdkjkE+5jj/oF2MP08BbRC+OjxVlwRXou0Xj/F5I8pEMzI18GHG8ks5Mar3Gby9tfDL27CRJ1OagM16JfFDVUtvy93G3JPI/mgw3fcsSBfZmqWYDBuoIA88+Ra/aJKNamDY//X96eo41X4xa2+dqgDhYpnavW7ATz5zRaEuCi9NNeLmIcMsN6nB3UyZV2OX52fmg1P1nw4KgFFLIN28g0SbKmixODSHVjWZBGJtpspn+k+vwXAfLemEZ1oWN2oM9JvW2NIL2uMeABAsdEWRYsyw8hLA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzhQNGJ1VDJldVd2Q0FMQWE2amh6M2dhaWlKdlpIUkhXT2h3NDVEUFd2bkFI?=
 =?utf-8?B?MWhyYjdUOHdTWmkxN3JRM2pxb3NIMnBJQnBqSHpGNkNYUFQ4bUsyNjFkRmc4?=
 =?utf-8?B?dXlaQ0VNRENTNzhOUnZtK0VBQUUxNjZ2U3JsejBDT3pPckgvQ1FuV0t4ak4r?=
 =?utf-8?B?MlhsaVJzVzFTdkE4bGhUV09HWEgzNW1WL3RmRUpHVGJ3U1BZNjZ3a3h4WkE0?=
 =?utf-8?B?K3ZsM3N3NFdaNFpGcGNnblRvTlBHbjl2RE9vaXQ2V2RMZ3h4NldqbUhXZlBo?=
 =?utf-8?B?NGl6YitaSFVBdHJNMWFRQ21rOGtnWGdjUFZXazE1MXBZdk5rM0dpYnEydUJl?=
 =?utf-8?B?TjJrS0djcW1xVmtBMXhQTE5kSGRyMlJJaStRMWdBdFF4NmlQWXRzenZMcTgr?=
 =?utf-8?B?Vjg3U2wxTGI2LzNicW9teDBZTXBEaGVkNU1BRXozSGZpNDFBMkRxL0syT1Z3?=
 =?utf-8?B?WXowblA3VWc4S1lQUnlkNEFmL1M2cWpzQnNHaFpWaDJlVFUwUXM5aWlCQk9P?=
 =?utf-8?B?Y2dnV296Y3BhNm5oTWtlWmo5N0t0ZzZBaW16VWpsNmFxdVN2eWhUUVo0eUs4?=
 =?utf-8?B?TXB4L3ZubitRa3RybklnNlRLYjZNU1hjR3dtazZJL3JqMzZhQUFkcWx2UGMy?=
 =?utf-8?B?ZlViTzhUT1gvY3ZITUhmNnNGK1VuLzlpRHFYcDlodEV2N2J1dkg1S0d5VHBm?=
 =?utf-8?B?TGEzRmVzOVZqeXU3UGI3M0taN0tkS29lNTZLRkFMZ3RScEZCNmFUVmhVRHRv?=
 =?utf-8?B?M1c5SWo3TURjRDd4UTRaS1U5SWNkM0pPWkNZeFkzcFhCNlJHWG0raHIyUVVO?=
 =?utf-8?B?VXpKcFN3N2VxcHh3OVk0a2Ryai9xK2lBRDNTem5MTDlJVUVmRGNwdytwV0s0?=
 =?utf-8?B?ZnRXUEhjNjBpVGZaZWdtOXg5NlZIemFISlhBdURvYS91Vko1Z2xSYkladGVP?=
 =?utf-8?B?Mk1VZHVWVmhKQ2E4aUV0UDhtSmFIQjRxdXhtYUFremYxRzM1Qm0yMzZhUWxY?=
 =?utf-8?B?WWtBdUpJb0NCenAzT0hMQWc4VzJXV2h4TzhkUERCdzJpaElGWTdFQzQ3c05r?=
 =?utf-8?B?cTJwQkdwdTRhOWFGMCtQbVJ4RGpZdHFHQ25wdHBqYWV5Y242YTdjVWpFeldB?=
 =?utf-8?B?QklPNWd6OXA0dUwwK2VWTXBKT3A0c0J1Z2owUzUxU0QzWFg0M2xtTCtQR3Y5?=
 =?utf-8?B?Yi9FWFlTdlRLOEYwcFhBbHZUdFU5NGtJcUVKZGtsS3BkR3BPSnJaMnZkZE8r?=
 =?utf-8?B?N0s4Yy9XTHpuY1dEQ05LWjFqVkxOUHdBaW9ZRTRpNDV0ZHk0bUJPZmJRNzI5?=
 =?utf-8?B?OUhJbHFYdmNmeWVNWitUQzZ5ZnRZb2E4QUwrM21aRHdWVnY2VE5Camw1aTNS?=
 =?utf-8?B?cXBxazBsMGVBZlU2WHhKdzFEMXhrdkVRcUMySWxGdGRwVnRnWlZweWM0UGo2?=
 =?utf-8?B?dHRtUmlRWUxEMnJHTmoxY2NxRnBBS3lMZ3JDbFZkRWxhQktJamt0RlE3QTlk?=
 =?utf-8?B?U2p0SDY0QXVzL09telhJcklNVEVPRDVjaW54bWhjQlZTWUttOHdmN3FsOW54?=
 =?utf-8?B?a251TW1TSmpxMUdNNU04Qjl5WmJ3S1FPSzliZ2t6UTJ5YzJ0UG5nSFhLYnFF?=
 =?utf-8?B?Z0JIT0J5ZHlZOFlTdm9JbjdLU1FDNFptaEdydnRxMm1FMXd4ZmlkRW1RTGRy?=
 =?utf-8?B?WnFxeU5ETTdodXVsVVAvUURHRm51dGt5R0dneTdBdSs4SGtQYWhKUzZib2pC?=
 =?utf-8?B?dnFWYzNQRS8vOWZtMThFVHhER2E1NFpocWZjOWZ0dWhFaGNJK0syY3AzRW91?=
 =?utf-8?B?STRLbzkyWnd4MGxxaGdJTnkvc1ZFQlFZckdhMGJwRG1yZFF6V1FGUHpZYjRv?=
 =?utf-8?B?eWwrcjFYMnRhTldyY2tJYnhZRUd0dDU4NjZLQitNZDRPZzI0dWswWVg5WmlF?=
 =?utf-8?B?Z2UxcWRmK21ydE41b2dUNE44bnA0bWhXRWNkYVB4MFRHQUFRSll2Q3JOWnJo?=
 =?utf-8?B?WmFNQzFaVXo3RnlHYTBhVmR5OHVNN2cxM3k3cFhEUlVjY1BPUzRzOTF1VW9a?=
 =?utf-8?B?VkozekhZVGZlYVJqY2k5YlNKY2JVQ2JobzEyZFpmMDZXd2dQd3lKMHV5Q3hE?=
 =?utf-8?B?YkZ2aG1GZmJNR1I2WkpXcFdwNlBXNG44NG1remlvT2xCMSs0MUFyeFpOa1p4?=
 =?utf-8?B?NGc9PQ==?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc4c068-dd2d-4786-67c4-08dc375da79e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 06:30:56.6417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HERjFW0EbvtxlfyHmTCg/AYKsfPQj3Rrr98FTRuhxPspr8FzWyMcm5OerStBsnoPRQ/wKmXDZEiX2FXluXMyROVGbaxwiK2RKXJe1xne8mLrPde228OoLOP2vfuzoxIN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6172


在 2024/2/26 18:10, Alexander Lobakin 写道:
> __alloc_skb() and skb clones aren't anyway something very hotpathish, do
> you have any particular perf numbers and/or usecases where %NUMA_NO_NODE
> really hurts?

 From the memcached test, I do not see really performance hurts.


Thanks

Huang Shijie


