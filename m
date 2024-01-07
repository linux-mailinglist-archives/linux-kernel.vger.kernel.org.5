Return-Path: <linux-kernel+bounces-18749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74ECE826284
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 01:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750961C20C25
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 00:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7037315A2;
	Sun,  7 Jan 2024 00:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AXRimFQP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367015241
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 00:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVrxYwx7mu2XauBeEvtwJpM8xiYYZa+qsyCVMdeRg4K3qmvZmss1pFnmaHVYqZzp/ehEmLivPH3RC29r7dwtj0hwIR788p802neTQUPYWXvFZmm5xwW3i/oZM3DKDiFgvFkYnP6+L7I3fdllFGoBeyRA71421XfPGJp4jBHjCURka3jLH4nJHu2tpk8hbdT5f6s4cyziYglQUw3ovyutsatBXOQIuhjawZg239Mlhy7TGqntwyajyWt3/qKbY23tKoaQV35yW5hc+NDdtBF8uk2x5WF4wXcZByWJvpewNeQrMOTp1RHlRdy5aiAz6OKjLFPU7B3dnb3HTWSd1iV9kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzJsCxke5Z3C/RxMPOGmi7I5L7htq0JE/iMNPQTK4uA=;
 b=lHDAVrUNVLxFBHIJw2l5uIZCmwpoT829JdMsgUpaxmG8HKFKI5K0BTktvSiVFStVCn6p+qpcB4oWCi8eEaouVwHKzsyB+uoIPmIEUoH/x+oF8CWRewaHfUZn/+CKl4wMuCz2wErGWmg6IOA0syiDkmS2jYBdapOhVrYe/j/eNgVkKmN6NXf2tMslmVGMr9r7djOK+r7mbnTRik3wNSRHsEhvUHDw29MOU1Fx90SaF4rsdCd5L10xtng6f6X1ndOFdyt0EWM/iopX76LSJv1npiJynlPRUI1x1M4KH9zWexzS3GYxQVl65BgUhZkKss6Z3az22x7gUk6pOS1NcXxTWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzJsCxke5Z3C/RxMPOGmi7I5L7htq0JE/iMNPQTK4uA=;
 b=AXRimFQP1cg9ohU1M5tEWpwCPmF4LWK31HfAAFNwGgeDK6RP8UnUIzXwneVnfN5ptAsqTKkTOAIdG4nWqmECBwRN3b0GkWohDw1U6bR7dtmci5onLnCS13aw4zU9M1DGiUeFlPwkmFpO/jDS1bRW70TCL1efCwkWM2M2J65ENWMmUlDPOSkk2phh+8XZoSNpBuciKhFa9YUyR5Lw3LmV2J7GeTtbK9ygaa3QvBJAX2fHCMT40y/6Os9J3S01Zmx5m5WCHlG9wKmIfOZkWeDPTR5PD8OFeiqilgIapttiornRY0nx/4KtdvWQnAmTMF96Z3HLak6Xh10GZhSeczxPzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by LV2PR12MB5846.namprd12.prod.outlook.com (2603:10b6:408:175::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.20; Sun, 7 Jan
 2024 00:40:54 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7159.020; Sun, 7 Jan 2024
 00:40:54 +0000
Message-ID: <19075505-b1a6-48d3-9732-7277c4697cf6@nvidia.com>
Date: Sun, 7 Jan 2024 02:40:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme_core: scan namespaces asynchronously
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20240104163826.10561-1-stuart.w.hayes@gmail.com>
 <ZZbhKM0L8pFYX_zd@kbusch-mbp>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <ZZbhKM0L8pFYX_zd@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0277.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::8) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|LV2PR12MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 39249b7a-b77c-4c0a-0625-08dc0f194e46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KmfZ8m3gHgUZWZVbJi/XKLWYfaXpnGhCcHsiQZ2aTV3qX/7tTLY+GcjydQKUmAITab4wu0E7WvhKkzawYI4fqZTKZkhXgtWNW7KsTwFGzPPv1BSCq2gMmaPl2gt372d4jC0EqWpJ+TrLR07jSGE26BLyg/iIwYJTHLtpTDLaK0qgKfEX68RHWN24WePaZQMG05dytWfD+ACuew80UWDbgSodAGlZRkFV6Mj6jdKvrz4zM2UaMvv+5pfxp4tGFYiiZQvXF8gbNh7ZBJr7ShicGh/A+xPOJ2UEQOa9b/rh/+lIZuI2FzVSXGYsGqJIi9u61Yuzh5gyqDy+NuGmnqy0Wxf0yDO/Zn7pbHGEFfr/n2Bobuy2tj296jcX64pdtaebQsQqZUBHCSF/VEV1OP55gsOvuof1TQ4zNf+GEGe1wfVrtZETykUoBwvCsBdxHIK2cLhVWy7mAI8ApPCpyOPTAyhTbn0BapxU5vT7VDbPD262+L3DnT495GNUXkkgHSM4U5R4qbHh2BGTC+WLq3nhv++eCUuBIut7kaEsg3AM0OAV94IVF8G6deZg3h9bo1FGM8M2Ji+20f4Tj5Vt4Ih0WV+4wqdtJU+4hRdMkRNLp5vNC9XTZiSHntdVLbu+BOpYF68HTmphvHyVKGOdqz14Wg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(53546011)(26005)(2616005)(478600001)(6486002)(6506007)(6512007)(6666004)(83380400001)(5660300002)(2906002)(41300700001)(66476007)(66556008)(66946007)(54906003)(316002)(110136005)(8676002)(8936002)(4326008)(38100700002)(36756003)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rlc5dGFEZ2hSbk9FNUZtdjgwdDB1MzFPZk1lUXdiNjlnY0ZoWS9BVFJ5bncx?=
 =?utf-8?B?NnhKZXRNZWplV2dZRTNqRTh5MEdNTFZ5YnVuR0ZLZnNzM0NtZFNJQkJveXRh?=
 =?utf-8?B?WEQ1OWRMK3VxRHBCNjczOUpmY0dGUEhkUS93SmxhZWI4OWdWSDJUb0U5cFIy?=
 =?utf-8?B?SzZSVDgrZzJYS01UZFRScStxY3I2c0RKQUZXMFg1VDUrMTR0Sy93NGhyQy9m?=
 =?utf-8?B?NVdqeHZjRC9lWDFGK0FpV2p4UDZCTFhuR0lQa0dISTBNY0JTeU50b1RGdEZ0?=
 =?utf-8?B?b29CN2dRLzUzdklvUDNOcU5LUjY5ZzJSTHNBblhCSHFLSnRLTGd2WVBCenB3?=
 =?utf-8?B?cW5PaDlCWnkvYWh4OTZEQUtSZXdsdVF6M2VnZGp6ZE5vcnZDV0hucWl5Wk5T?=
 =?utf-8?B?bGtsb1pNcEg5Ni9vUWhMRkc4b0YycUk4UU9veVFPRm1LWGw4VGJ1WW10Q1Av?=
 =?utf-8?B?bFlWUTZGbVlERGdVNExta0J2emtTK2FPcWJlWEZnYUVJa3JNNmlGa3ZnWGlr?=
 =?utf-8?B?UWdISUkvSVkrbTdwR2grNW5SREJTd3RGd3BUeDNJSjNPL3BjdWMzVlRoTHRJ?=
 =?utf-8?B?cDVXZEtXVUJXUUNMdWx4SVBTZVFydnpKYzdUd2VwdWZJdU1lblNvNEdQNjJN?=
 =?utf-8?B?OUtIQWVTRkpkZU1NMHhsTnc1TkpOcklPN0hidTVXKzl3dklVVVpGa1VkVFZX?=
 =?utf-8?B?LzlxbW1QWHkrRmMxdUV1bDFJbW84Uy9XVm9EV0F3ek5xYU5YdGR1bDNHKzVN?=
 =?utf-8?B?Vnl2amphbTU3bzUxZVFrRmNKa3gvQkluc21vTGJhQzhSbVFQVy8rTGx6eGlv?=
 =?utf-8?B?V2xPbnZLZTRiRVRpYWw1U0hjdm0xeG9ROVRuNzdXZGxYc202dTd4NCtscWl6?=
 =?utf-8?B?ejNuaCtHQXdOSm81MWhtcGJpTFNVL0ZSNVBoc0JSbXVRQnFJb0JHY0hGWkRz?=
 =?utf-8?B?NmtlNENjYmpnSmswblA3TkJ3L2VHcUU3ZVFvdXRmSXZBb3NSdW9GTFY1dlBK?=
 =?utf-8?B?VG5paEhNbE9mZFRWeDRFZWlDa3N4Zmcvclg3RzJ3YWtDbjBhTzRBeGpMZmxG?=
 =?utf-8?B?bW9RbDR2Qk9TY2Z3ck9uZ3lmNE5EYjhtYnNqdkZvc21qTXo0cHNNRDVCWDF4?=
 =?utf-8?B?NllYZDdxRGZBNVU4RzB5d3FXRS9qVVNRMSthejlVa3paWUJkMTdWcnFUTEpv?=
 =?utf-8?B?akNGL0xYakZBWFczSUJ1QlphdDdkQ2c4VFBWZ1hkazVsRUpuUUlucXZOUWVU?=
 =?utf-8?B?L3dhblVxZ3Y4NFZBSEVveWd5b0N0cnI2L1NDaXBxcGpjZXVhU0hFdDE5UVdo?=
 =?utf-8?B?YkVHMFJRc0I5a1NDZlRLMUxrQ1lhYitzUENnK3lQeWZFNVNKLytwTGp2aEVx?=
 =?utf-8?B?U1R2L3FBbjBvM1ZwZndINS9jZW1VaG5kM1ZvaUxhTnFCNkNScFdxZy9uV2M2?=
 =?utf-8?B?VHZLdVNVa29TaVVYd1ZKNDB3WGVKQzJlM1g1b0M0K2t2T0RKbEdrWktKWFhJ?=
 =?utf-8?B?QVFpc040RUFpYWwrUENhQmdHTGVYWmVNYUd2ZGNXOGZTVktEck96dzlLdkYz?=
 =?utf-8?B?VHhqbTZkdHZFVmdMWWNjWFY5M1FSbVhBeW1WNXhuaXdKRlNRdlFiRHBqdWhr?=
 =?utf-8?B?N2VRSDkyZkczWms1QUwyaGpwRElRL0xzclFUZnJTSENqdXpucG9zYS9HNG95?=
 =?utf-8?B?QTFmeExkMjdTVFgxbi94ZzkrZm5EUi9HWC9KVWE3L0l4VTFOUEtJaStsaElB?=
 =?utf-8?B?ZWlEZzJIemFhVWplQjJ3cmRlMGh5UlNUV1JyNkk1ME42MkdtbG0wOGlhVzdU?=
 =?utf-8?B?MUZFNzJ4LzdDR3NYTTlWWFB0WW84TGZYMUpwQWJXR2NFRGphRU1OVVZIekxF?=
 =?utf-8?B?YTNCTktFZ0tuWFJhb3Y5TnJISlpuZG91ZUg1WVFZeXE4THlEL1RRcGNOZ0Jr?=
 =?utf-8?B?dHRpVlpoU2ExQVNOenhvMlJScnhSQUdhZVYwL0M0MFNlTHkva2xRUHVPZk1K?=
 =?utf-8?B?MSt1L0ZzL2FQdEhSckh1MU9BY1FmMmlBNUp6OGVsT1lZTWIzU3VwMWFUQ3J1?=
 =?utf-8?B?TngvQ211Yk5FNFBXZ2F6dktGNkNQbXY1RFN1SHhEMmY5SWVXUDloY1BJSDhZ?=
 =?utf-8?Q?wObSCr/6BYAPoeISzW3VmgbXp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39249b7a-b77c-4c0a-0625-08dc0f194e46
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2024 00:40:54.3748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVqflUqeXrt+L8L5C3WhZxf2VdGKYOlqx+AeYnMktdLxNSiKW84hhAJAWfUdCptPYLOXVIdUrEkuTHx25B1ZGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5846



On 04/01/2024 18:47, Keith Busch wrote:
> On Thu, Jan 04, 2024 at 10:38:26AM -0600, Stuart Hayes wrote:
>> Currently NVME namespaces are scanned serially, so it can take a long time
>> for all of a controller's namespaces to become available, especially with a
>> slower (fabrics) interface with large number (~1000) of namespaces.
>>
>> Use async function calls to make namespace scanning happen in parallel,
>> and add a (boolean) module parameter "async_ns_scan" to enable this.
> 
> Hm, we're not doing a whole lot of blocking IO to bring up a namespace,
> so I'm a little surprised it makes a noticable difference. How much time
> improvement are you observing by parallelizing the scan? Is there a
> tipping point in Number of Namespaces where inline scanning is better
> than asynchronous? And if it is a meaningful gain, let's not introduce
> another module parameter to disable it.

I don't think it is a good idea since some of the namespace 
characteristics must be validated during re-connection time for example.
I actually prepared a patch that makes sure we sync the ns scanning 
before kicking the ns blk queue to avoid that situations.
for example, if for some reason ns1 change its uuid then we must remove 
it and open a new bdev instead. We can't kick old request to it...


