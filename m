Return-Path: <linux-kernel+bounces-17885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856BA825490
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 232F02854BD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7202D78D;
	Fri,  5 Jan 2024 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NE4zJP0d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB502D63B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+cDuB9UoyZVoBEx1lnae7cYC1zMbczhB6lyZt0i/8/xIdhJ4HsZGxAX0ELclA0WFZcUPqXoFay/6XHvhULMc3aMarDcloVaY5JbgFrLsEBYQx8qi6/yBUQvTy6wul3Mdyh8B5gB1hYDptTJxwBjs8A9y4HgneemJ/mwU5MZhQL/FTi1TQvN4Dq+7+NZNf+JBYk9RsaHU+BKxs5iKhhrmiq7CRyz/KszHtMKrF0RGC77mKWKIUucYji34rxJAZgmHyFHi2W9V1MwnhSOmft5pNKESrH+L5H0C6/RJlofGc705nT53NeZpgf6UPvzIWPgduiNJMgIKyXEIfhvyH0syg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeGEJhKYkIoaGPmg68oPVAkAdvSVCXT9qg9tusH6UqQ=;
 b=XSUvYwC+Dm+T3VpB/IqGaRhtxtqWv2l7J4q+3ncgq5YFWRJKHomCnDEm1dl5sA/SVFbrDg3IOOQxaCpYLFBw7CduInXM2sKDb5iVG8IR2Y5Pe+m+Imne0qT8NZbI3dwBehNFqRqZQCgLFQowThUMg2t6B0/toixOGZ7dpUiOXtn87H37bHL/At0EU2ICdyTaT/b++u5QcwEzUigAB92wuBd7OjSwhuqwRuC1Iwz/8uL+GzsMourZaiCEyAyyu4d/UC3EIWxhemPYch3sQOs4H2TvIK0/rSKUmY0TCiCqtAlcbnfKva/XjblYxhojHUUqJ3Wyp61nNwdEoVrlDdhE4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeGEJhKYkIoaGPmg68oPVAkAdvSVCXT9qg9tusH6UqQ=;
 b=NE4zJP0dqry1c/FlwcJNYX8urIn+96lOiMuYJWj6Sv7rQrrwA99kQZc8kMkZYp/w8MSVbSwFIxxIJ5Pohm+00s+YB6MYGNBRnB6hFF+4F31TT2HLO1AKL/FUS28mOlybuIZJ1PSRncScIBHWFUn33cFYRn5veVOEobXGp4J7SQ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Fri, 5 Jan
 2024 13:39:58 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::e557:fd55:457:12]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::e557:fd55:457:12%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 13:39:58 +0000
Message-ID: <d2cc19fc-f8c6-4b3a-ba88-5db947fb1604@amd.com>
Date: Fri, 5 Jan 2024 20:39:52 +0700
User-Agent: Mozilla Thunderbird
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Subject: Re: [RFC PATCH 6/6] iommu/amd: Introduce nested translation support
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
 "jon.grimm@amd.com" <jon.grimm@amd.com>,
 "santosh.shukla@amd.com" <santosh.shukla@amd.com>,
 "Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
 "pandoh@google.com" <pandoh@google.com>,
 "loganodell@google.com" <loganodell@google.com>
References: <20231212160139.174229-1-suravee.suthikulpanit@amd.com>
 <20231212160139.174229-7-suravee.suthikulpanit@amd.com>
 <BN9PR11MB5276BA85118EECCCD89681EB8C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <BN9PR11MB5276BA85118EECCCD89681EB8C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|IA1PR12MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f9dfd7-7868-425e-45f5-08dc0df3ced1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tIQHANGOQNB88iFEeoccZzbnEFobKF+AVB4uhRVlmANyF0p0zmLb+jrqVBLxth0lHCKcI27vNWZgHjKrU3owUJ0TZeI6NAPECX8mOcRDwPV0screIqVMwk984LxLpI0Oh/vZCwNPQLPqia8/LRyEk0XpMcuA452Yq7ZvpFs0E9P8OQTBjwA9cmJRDP6fYv1WrXxynUpG5ZeagZ4jyhPaIFyrelN0wRYF2WXv0T35qLc55oNaKRYa9sxaVl4EZd3ks48IdiaS1g5bO3p0A/GuABZwK5YavcWsb8YOF2Y4G9mq0qnTRhagMcaprJU6W2IOG84BWaunmkf+xmt9uur17gNyMDiAuC01N72khxpiFTM4G4odPr4P1qIXZyY8KuCZvs9D70h1Mj6GagcTif8Bqlt5wVoyayGBiAcR6G1I2Y2Fz6lgbbgguvgb18dgNWFXGN8LziGc2OwuhuvO9NxyPeQ3O3ql39Y4RPTIi6F+YNeDVGBSj9G4RIiH2bpfkuMIikWr4QLl5ymq7v7ghGMnEmh09YCxIYxBn1JY9cPNHk6eQgMWt8oql8MrisFpi+e/UedCmJWEG/FFTJkaWtCstO09iPKFLvOJhhXCRvwTmLkYOLpZtZS6pztfs+WrBth3vmcDUil8fjAmLjThNGQbDA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31696002)(6666004)(478600001)(26005)(86362001)(6506007)(6512007)(53546011)(2616005)(8936002)(8676002)(36756003)(54906003)(110136005)(41300700001)(5660300002)(66476007)(66556008)(7416002)(316002)(66946007)(2906002)(4326008)(6486002)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnk0dFR0djFJd21jcFR3aFV3alNzNVVKMkd1c2laMTViY0pyUks1UTR4WkdB?=
 =?utf-8?B?NFU2ajBMRS9yWGtZa0R0Q0hPRFRmSjJSZytldVJtcUVXTjlaKzZWekY0MHVt?=
 =?utf-8?B?MXFYWDdnM1hPcUNnOE55cXpKWU5iWFdQQXZJWSt2d2dwcDJ3THVOcnBWR3Rh?=
 =?utf-8?B?a2lMTVk4ZC9GS2Y5SVZ6NWE5cm8vT0J3VktkN0lmaVdESGQraFdXWXFsclYr?=
 =?utf-8?B?V1Z3MTRzQVV6dk5UbUNUT0EvKzg0akJVV2owY3RSK2Y0L0xXRmlVRDRlV29l?=
 =?utf-8?B?TTlpdTl2dE00cVZpdnlEc0hEVTlTZjZnQXNPd2FJUXZ3RTh3VmJIeE1wNjZu?=
 =?utf-8?B?Y1BneHpzNzJXK3crQWFqSG4yaGhjZ1kwZHlHSE4zUWxZZXRubmdpMDVvQjVL?=
 =?utf-8?B?QjNkUi9IY29XQmQ3eEFGWEpkYlF0VnNPRWRtZHZKWFMxa2I4T1J4c3pURlVo?=
 =?utf-8?B?K052L0Z2M21PUVlDdHAySWlVeWFXdUxVS3Qxb3VLamgwaW9ReThnUmNMUHVS?=
 =?utf-8?B?VXViYXJwb2NhZEFpdGE1LzhWQXQ4RTllQ0JOR3RxYzdCMHQzMXNvUlJER2JH?=
 =?utf-8?B?MXhiRTMyK202Y1dOVTZld2pDamtiYk8wWDhQVTZmOGgrSUw2Yk43SXZRa3or?=
 =?utf-8?B?cGl5d0NUamY2ZE1zV1A1N0Z0YTJLYkVSd0NTcngxMHRLNVZtZ3NwZ0Q0ZS80?=
 =?utf-8?B?Um55THR6djF4K1JNbG14MjZLMDBvdndwMi9jbTBWZkxoRDE4ZnpwUmNiUHlU?=
 =?utf-8?B?LzFPeUIvOXlwbjRSemFSNEo1d3FsY29taVpnc0k1Q1NNVmMxK3JKNnpRSjM0?=
 =?utf-8?B?dTR4NU02UlVCZFJPUytvc0c2ZHZidnRlakUvVVdBOVRwYldEVUlkMFBocjky?=
 =?utf-8?B?SDlmL1VJTm1Wc2pNOEdnRW9QMlloaWxKN3BES1pZb0xXbitFSEhidVA2aWJa?=
 =?utf-8?B?dlFiTWxPQlpTelMyUFZZSVUxMi8zY2tyaFZOczcwNnBkVVdBUW1RWGo4a002?=
 =?utf-8?B?M0lTUDFvVVhWWXVyNnZtc0V6OTN6QnoweDhVTlRQSnJNbUxpd2sxbDV2V0Nq?=
 =?utf-8?B?Tm5PdEpqU1pQNVJ5ZGh6cWV6aHdsNzlXWU1IdGVUakk1b0hnK0t2cnJGcTl2?=
 =?utf-8?B?dHdBcm9ISEplRHQyTlY1cnRPUS9KSDdGOGF4VHo1b0tJZHJWaEE4bEJ0SUZk?=
 =?utf-8?B?c1g4bjYrM3FDM2RDOHlDQWUyZUJXN3VTejRRV0d2MURxNUdjOHZNRlZOQURV?=
 =?utf-8?B?dWJ4Ym1yTlRrSzhjU2xMckdjZ2RZSDdKUEFqRlBHRXZkRUlsTVNJT09NdTRo?=
 =?utf-8?B?WFl2YTZ1VmpzRmtQdXVWSjczNFhUK0N3TnByb2M2cytJZnA5aC8vWFRnV3d5?=
 =?utf-8?B?eVo3RTM5ZVN4dmltUktGS2ZZSWpKV0NRQUFQL1pHZC81TUZBeWJkYlcyZW44?=
 =?utf-8?B?SFduNHRLU29IdjRLV0p3dXBhVVNJQjMvR3lwdXdzTHl6NElWY1FSVnl4RzFp?=
 =?utf-8?B?YnpFSE1WYkV6eVdibUNNR0FnT1JpbDZkUkZURjloU3crcUJiZ3pORFBUOHh5?=
 =?utf-8?B?Qmx1MFVnS1dJRzhjVy9HRThJK05MS3B2Zm90dVlXMFNldTBkV0dheXlIbXpp?=
 =?utf-8?B?cUJOZHVJRFBaVnJEK2g3NlBGVXprYjlYbHl4UUU5YU9KVzhQclV2eGVlVFow?=
 =?utf-8?B?NnRmVGhIQlRobnZvYk41UEgxRjVHMkxVbHRLSFJJQnd0cmYrdXRYckxpaGk0?=
 =?utf-8?B?NkJDRWlpQ1FHT3ZSSVpPZmcvVHN6OWZ1VFA2NUUwUHpuUTNSTStHS2NyMFVC?=
 =?utf-8?B?YzcxRCtjZDVYb3F2NE9PaXFNWFRvQnRqQVBTYmY5Y2gzWG5DcTBoMnYwNWFS?=
 =?utf-8?B?QU5BeXFpekovL1QwYnVHZml4WWtEMHZxTTJIMmdkYm5yQ09ZZVhiRkF3VVNy?=
 =?utf-8?B?RnM2dXRoOE5HbVRaOXNCb0RlY2pOM3hKdHhsbm1lUUc3UGlZbklpajFZR211?=
 =?utf-8?B?QnkwVUdOUzFQZWtBSDFQSURDdnppcXdmMEVRcXZpUnZpbXlUUW1NVjVmUC8z?=
 =?utf-8?B?L0grQW9JY0o0MWt4bm9Xbnlzai9XREEzMTEvaHpURDZRanZJcmRpaHhBQWd4?=
 =?utf-8?Q?MhouI6xNkeUINuaOJrNgQFxPr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f9dfd7-7868-425e-45f5-08dc0df3ced1
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 13:39:58.0891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDjq5KqmLHrGuW84nGTOY+9dWt4TVCbm5z6M/TZKJCVRgWeulbRuVg0GGy3oT0/pfCDVWzeUUIcgG3IRWpwNtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233

Hi Kevin,

On 12/15/2023 2:45 PM, Tian, Kevin wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Sent: Wednesday, December 13, 2023 12:02 AM
>>
>> To support nested translation on AMD IOMMU, the driver needs to
>> program DTE[GCR3 Table Root Pointer] with the address provided by
>> the guest via struct iommu_hwpt_amd_v2, which is passed as a parameter
>> of the struct iommu_ops.domain_alloc_user() with the flag
>> IOMMU_HWPT_ALLOC_NEST_PARENT.
>>
>> Note that current implementation only support GCR3TRPMode for
>> nested translation, which uses GPA to program GCR3 Table Root Pointer.
>>
> 
> means there is a plan to support another mode in the future or
> actually the nested translation requires GCR3TRPMode as a
> functional requirement? imho the point of GPA is assumed
> in the nested configuration in concept...

On (older) system, which does not support GCR3TRPMode, the IOMMU driver 
needs to program the device's DTE[GCR3 Table Root Pointer] field w/ SPA.

When QEMU presents an AMD vIOMMU device to a guest, the guest programs 
the guest DTE[GCR3 Table Root Pointer] with GPA. Then we need to :
1. Traps the DTE write
2. Translate the GPA->SPA
3. Program DTE with SPA.

With the GCR3TRPMode, we can skip step 2 above and directly program step 
3 with GPA.

Suravee


