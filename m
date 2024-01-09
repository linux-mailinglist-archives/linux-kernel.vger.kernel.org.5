Return-Path: <linux-kernel+bounces-20687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C1A82837F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C8E1C23D29
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493DB3526E;
	Tue,  9 Jan 2024 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tTOtHnKD"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB2836093
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 09:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLiEqLFNyrxhuBa0NaRzggnqE+KTDKYW0frDcMcLxgKL9VYeU5ZcHk7Mm2lyr78syOhP5aNJyfc1jXLN7BqBcgB0ivKJFGhuOz2eWiGTOSU8Wc3+LmtrnVwmCgIbKQ4NIbZzQQyJH9+tj+FQugNNlnGjPTTZRrW59aLCTHgFyQ1cEIAXiMxeIHPy3W7eQUPlHsmzuSJH1CgnS0+sHKa8wPPrn8Xk9GjGI6phMQlfcCEP7/c8M7Bwcj1Jo9eQWWDzXzgJR4ARzvFBBxANZ8wHwGPZ/10q6D/NywBTrJWniHG8bJvCE5W5Rkm++k5zWIbkc/1xFUl/OfmaB5gM0//JCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCdSvqoYXXkFAnMN+PImESE4TJIN2fVY+igvezxsBso=;
 b=VX5pJtnrV6yQSeWrl2BProlRBe8B7LJJlQ1LyeRAbpQuLLoCzf7eXOsskIKM1muWlLv0N2eiy89ktA9vKnix04IQuutUkGySLcMd+Pcig8rHTnS0hpUcn1MR2alU+fjy3lIOao7DI0EFy+Bj3Gp9J5AbG1ezigXnka9Bn5Q0iY4SFhv4YdCXK+eUvz4ds9pLPOLJQ3IpextqvDCdK44kjJrJtPWW/oVdHdFRUNnczDcDaYzQQfQSJc/SlLiW769+938vfETSzVoZrH8/AyyqxgdELbuo6GYcPwQ/teLEejPFodtBn74C+gxUlMLXu5XJwc6NGrYXuglkdRZfVMRIAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCdSvqoYXXkFAnMN+PImESE4TJIN2fVY+igvezxsBso=;
 b=tTOtHnKDL0q/gqPOyCmBUV2soQLcu4rS5cu0eQvnHFhFA8hFVbnCBftuyMKxwq6dNR00szeMlvGkLGv5eFPbYSwhNQBr0AkxNbvro81uUd/fj2+kvVuGFeam8njTp7YdABeyrI+TK7E66+HCEz7GIT0g0r4QnKojdIRvjzNyZ/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 BL0PR12MB5508.namprd12.prod.outlook.com (2603:10b6:208:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Tue, 9 Jan
 2024 09:52:14 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::e557:fd55:457:12]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::e557:fd55:457:12%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 09:52:14 +0000
Message-ID: <fc15b460-9e1a-4e68-ad5d-ab1c871c1300@amd.com>
Date: Tue, 9 Jan 2024 16:52:05 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/6] iommu/amd: Introduce Guest-ID struct
 amd_iommu_vminfo
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
 "jon.grimm@amd.com" <jon.grimm@amd.com>,
 "santosh.shukla@amd.com" <santosh.shukla@amd.com>,
 "Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
 "pandoh@google.com" <pandoh@google.com>,
 "loganodell@google.com" <loganodell@google.com>
References: <20231212160139.174229-1-suravee.suthikulpanit@amd.com>
 <20231212160139.174229-4-suravee.suthikulpanit@amd.com>
 <BN9PR11MB527634DAFBBACC20DD691DD58C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <09d009cd-6366-4372-9534-4c637c56b3d7@amd.com>
 <20240105143811.GB50406@nvidia.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20240105143811.GB50406@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|BL0PR12MB5508:EE_
X-MS-Office365-Filtering-Correlation-Id: 838fbdcf-cb21-4eb7-136f-08dc10f8a81d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6AU3GBNnk0T4OVnnaf/yNGUf4w3JFaZo1H9BsWKxA7QeegKRTAjA/fEx5Lk5dRRS3vMA1qQQ1WDHfDffrm5hVuKEjh6zM8hLatFGGocw32GyAX0I+xI2n4eCbhfCqmg6GbtqfuVzOz9wkg1YunZgS5B7SozcKHhfo2oGtZQUeAYgcePoaOmbm+wUuagN6b/dLz72nGROp9a+Uh+UMDyE+FQcIWAcH2Q7f8fUlmVPW3lcyBwa9GKidB9y0xfUiPcCxoKWDYpBixIy3SYOkcP59aoTeBseuuSigIjTwfkOLdzz64PMSU3FOtcp+DoQyJhqhnnbz9NwP1/9dp6gAV14b8gcw5VXW6vt7aKc7way+D7QfE9U2dyGR8Pd3exEHRoq4lmW/lRHNOo2WzCAfc6iI19dKrKMJwwZSovJdtwgq33+Qfn2PXrgy1hM2VDPWMklE7pQpMcjzo4QbyEurXpTtr5Lxeuux7NUwt/G1+ytL6QPf7U1ENTVoTbtz3QvAaQf/ONXofb0LiQ5h8wAEhkQId8pdv+lPAPuuTHBCLJIg11I2r/A7TBMYtLnKfLnljWZ1eK5hIOqWWHyWCelv4sgxQfvZu/9o67r5eKxXcntnfJ5ikXkV39Uv0aHqQVbdll7x7sX0KvIhNVKRcZAG211HQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(2906002)(7416002)(5660300002)(478600001)(6666004)(6486002)(4326008)(41300700001)(66556008)(66946007)(36756003)(6916009)(66476007)(316002)(54906003)(8936002)(2616005)(31696002)(53546011)(6506007)(6512007)(8676002)(86362001)(26005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3A5MlZiYnNMOGpVQmFmUnhLcU5keVJ3VTFZL3cwd2ZHbUVjY1Rzb3lld0Fk?=
 =?utf-8?B?eHdMQTNDNXZrSlcrTWE1SXQ2SHVYR2w5N2ZLS1JXZWhEYnpSZllZb3NnN2ZX?=
 =?utf-8?B?Z1BHMWZPOU9RQnlDUW9oK2hRRXNEajRtaFdEd0swUGFqWWg2d0xtamhrb3Vn?=
 =?utf-8?B?b2h4ZVFZV3VBUEZDS0tjMExtY2o3bHhFbnd6R05zV2xsY0N0WXlocTJha0ZM?=
 =?utf-8?B?WXhwTWR4UmNJOUcwaWlWQmE3WlF0UzZiK1VZTDRiU2VGS2dJbHhYaVNMbTdY?=
 =?utf-8?B?ZGxxUFpyWCtuWU1GVkF4U3dvQWhJcEFFdm1LVWd5M0NRZHV3M3NweHpPWW9s?=
 =?utf-8?B?WTN1bGgzalMwZWdyVDVWV3htZzhQV09Nc3BrNWMvNTVvSmMzWnNSeGpSeDFG?=
 =?utf-8?B?Zm5SY0VNZzhyK21mYVNxRjc0Q2dNRVhBb2lsMDAwamxPTHpVajlFR2x5dnM2?=
 =?utf-8?B?cEp5emVvN2FrRWs0UUhSM2NvQ1kyNVg0UGJ4bGJ1MmVFNkVKRG10R014Q1BB?=
 =?utf-8?B?R0hQcFZtdStyZGlhVHd2am9mN3BKektDYzhMcUo3Z0ljd2JzRmRVYWc3SDVD?=
 =?utf-8?B?MWRYcHBmb1RldlRDTStha3daREYyL25ldTF2TnlydTJvSWpEbFpOYWJJekhS?=
 =?utf-8?B?ME5pVWxSMmVzdzB6Y1NZY2lKZ1FzNU4zQ0NPV0VHMEFVVS94TFB0UEloZVRp?=
 =?utf-8?B?Z2tYSENVSHdQWURrR1gxQkdUdkVUdjJtTXRXRk1qSTk3SkRoMHU3RWRURi9F?=
 =?utf-8?B?MFI4cm1xVVQ0OGJrdm00dkw1TGt3Q0ZhWnVrYmFTRjBuUFRjT1dwYnphSndp?=
 =?utf-8?B?T3VlelpyM1JHRjFaajNFQjJnVi9VQnl4TW1lSmtTMC9FMFJLa3JkT2pZZ2lP?=
 =?utf-8?B?NUI4VnA0UVRZWjcrcTFjVE1tTVdvZUVtUTg4NHk5djRsZGNoSHlmQUxlWFp0?=
 =?utf-8?B?TEVxaFcxcGNKN2RXNUtab3ZsaWpUcWxSMGQ4dUZ0dTF1Q3lIUmNIcDh2VzZy?=
 =?utf-8?B?ci9MS0NkMFI0b0RLbSs1Y2xOS1hSRCtvNTZQTnl4d2NmNkJGUFB5R2V1U0JU?=
 =?utf-8?B?eDQ0NDRtQ09RdWhEYXNvQUVmWkhTdGFYNVptOWNrc1hKclBnZFJlMEk3Nlk1?=
 =?utf-8?B?ZEdOVGNOMWtZMlNvL1RXNXN0eUpMOGEyT3lwMmM2b1AvOUcvZm9PVFErTzdY?=
 =?utf-8?B?aStneWFFMDRCTlUxVDF4MXBnc3Znci9XbmFiL0dRMHlIam51Q0NxN1pSWnY3?=
 =?utf-8?B?YndzTFFlSUhQT3N3b3JreW1DcjF1b2k4WFk3dXp1MnRpVFRsQk5INWdtNGJt?=
 =?utf-8?B?bGtPWk9xSkJ3dUNPMWRNVVh6b2ZMbGpmZlJTSkM5NjNMZ2NNYlR3YW9adm5i?=
 =?utf-8?B?NGI5eWZMWlRaMWx1bktIWGZydnJWYzdrUHdsNE90ekt4NWh5R1FjcjBrMVYy?=
 =?utf-8?B?azNLSEZQRUlOdVptVUxOMjNNVHNnTkREMXhXTktWb1dlZDV1eFE3T1BKaWxN?=
 =?utf-8?B?eXhyRlNnUjdPN2RxZGlBSmhJOGIxekNzYjBpVjVaVVQ5NlM1M0tGZlc2L0lr?=
 =?utf-8?B?bzkwdUNCbEw5aU5mMUpBaXZUWGxmOFcrN0d4elNPL1p5TStlVGZnT25obndq?=
 =?utf-8?B?VnI3QmlqOUw1Z1hxOVNENkpZYThwSFZSTU9VaGk2R0d4V0N5SWxoRXhjbWZ0?=
 =?utf-8?B?UGpxNHRuZkU0RWdnQzRuTHJhRzlwbmJrTUkyWkdUM2pqS2dVRW9rOGtLVlN5?=
 =?utf-8?B?V20rU2o0UHhCdlE3TmxWZnZDbU1OUUlEOFdPTHczeVdwYnBoMmdFNmRwRkwy?=
 =?utf-8?B?czMzZ0ZIUCtudDNrd0EwUEdrTE1pd045b2UrVWRaeVlXc3pUSUoxa3FhMUQw?=
 =?utf-8?B?MWRIYlErdkNHTE1kdkFnd3A4K1J3VTVwV1FPU295U015VHBCNlJSbTA3c0po?=
 =?utf-8?B?cHVKQURoNTNlakxkbzJKWHhzNGlsTkFqaXBnTjBqN1JEVmt4MGkxdTR3dHlP?=
 =?utf-8?B?bnFFS1VPVHJTWDNYZERkS2NVanlWLy8wRk5oQ2dhUmpCekNTMVdmZzhQY2Ux?=
 =?utf-8?B?OVJjc1lJTVU2VFlweEZiVU4vUXR0ZVZwMXN0WDVIdm9JMERWV3JmbmxOLzlT?=
 =?utf-8?Q?vG7O1P1JNinfYINwTmRFzXSaj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 838fbdcf-cb21-4eb7-136f-08dc10f8a81d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 09:52:14.2179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnNdL8bcvIerG5NNTmRGwZzKgt/etDK5MwNEMOjg1iB9xXrPr8Q5OFAmL7gpOtQV0cxUm2TK1ZAAgC1bhRFdsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5508



On 1/5/2024 9:38 PM, Jason Gunthorpe wrote:
> On Fri, Jan 05, 2024 at 08:39:56PM +0700, Suthikulpanit, Suravee wrote:
>> Hi Kevin
>>
>> On 12/15/2023 2:35 PM, Tian, Kevin wrote:
>>>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>>> Sent: Wednesday, December 13, 2023 12:02 AM
>>>>
>>>> AMD HW-vIOMMU feature requires IOMMU driver to specify a unique 16-bit
>>>> Guest ID (GID) for each VM. This ID is used to index into various
>>>> data structures for configuring the hardware.
>>>>
>>>> Introduce amd_iommu_vminfo_hash hashtable to store per-vm
>>>> configuration,
>>>> which uses 16-bit GID as a hash key along with helper functions.
>>>>
>>>
>>> somehow it's unclear to me whether this series is only for hw
>>> supporting vf or broader hw supporting nested capability. for
>>> the latter case is GID still necessary?
>>
>> I am restructuring the series and might be moving GID stuff until later when
>> introduce broader hw support for AMD vIOMMU.
> 
> I'm hoping you can just skip enabling the viommu features and still
> have nesting? That should be OK right? The SW will manage the
> invalidations.

Correct, the part 1 only add support for nested translation (w/o 
HW-vIOMMU feature). So, SW would need to manage the invalidation.

Suravee

