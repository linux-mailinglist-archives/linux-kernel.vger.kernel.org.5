Return-Path: <linux-kernel+bounces-17887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 309AD825492
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35C1283DC9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980292D7AF;
	Fri,  5 Jan 2024 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hBOIfnN4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97472D7A9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9qADQ6q5uJbOv+Xg70UOvuJw6s8p3hWe3CU9P2uOUThjQFluYP88cTVToPeN/wb49lDomk1yiqXc8hqVtpk/Cfo5lshpGmuDOJuHCphQAvLo7MnGbOYR9rT50J5jIwpw9+gyhdOcYz1VScJ4uhZRckYpwiv/pQ7QrTQ19pwTKl2hBVeaHFxeB7Yao0/NKGQuFckWsHjiOU4JaDrcoxrVmQmG3h3zJqo8gxLjSudiis0Vm0fktg1wpoVcLoG14xPJdPEOiMAM0lmNX/6C6LYts7x3h6N1lG+CsiyrfiIRI9LhsvTloqWrxLqA8Qizz630242p/fnaJAnIK8/Lv3gmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPWPLCi9NvccSWi5yPZ1RxDwlDJzmgPUqlHsVNZlqS8=;
 b=Y+44x/ZasDcxjU5LVOhWkOBOc/i/i1JzGnKadFvZSDhRQ4VjuTeZ9NcVCDBXgtj1ZcpktZsYxBWQ5fvOR/6HECzO3Zc+GrRxEz4/ZzIjY62MhfRdWUsOPPQFTmBcqZjMwUTjP+RUrNaO6C0XIHXnONFpY7Q+bFlvT4obxyWrfv43U3qjIKhajszt59vL0GAKFhyAcpFGRL2dIofW66Zh15vnzSl04hOZA2Lmbmx6233ead9Jto9ETby24gDRqjIcchdkLaWReW+m84hIN1hJQJTsbOLhUUHsxVJcsHxyZT58rh+uJUZ/gqwMghgqPRuI7PoSWEfp79vtj0lgJYaSoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPWPLCi9NvccSWi5yPZ1RxDwlDJzmgPUqlHsVNZlqS8=;
 b=hBOIfnN4fukY2qryGyYVspoXSkaQqt1IYrNfMvVM96O3Qsugs/qH7DttM4JgWS+u0vaeqOAcuk9K++j9xPBn/jvjDzF9F81LmnoAKcvFtJljDHQ48aEJG2rNWHpDSnIEB3kNmz8iRwNaD+MbrxgDdj9zyugcxZp3yE+45vvfFv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Fri, 5 Jan
 2024 13:40:11 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::e557:fd55:457:12]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::e557:fd55:457:12%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 13:40:11 +0000
Message-ID: <e480bcc9-f13c-4172-b4d3-e025e14790b1@amd.com>
Date: Fri, 5 Jan 2024 20:40:06 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/6] iommu/amd: Add support for hw_info for iommu
 capability query
Content-Language: en-US
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
 <20231212160139.174229-3-suravee.suthikulpanit@amd.com>
 <BN9PR11MB52767952B60E86FD6C93CB1D8C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <BN9PR11MB52767952B60E86FD6C93CB1D8C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|IA1PR12MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f25879-0eba-4855-9992-08dc0df3d69a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ycbm84Q1w6OZcbbytS1mcnibUiYnBA7cdKq6chK8wqYlLsCESnOwWwWUoaMwUjZDYWiC5wpcJo1IJPfWOz+29TW7DdjLdL538oBbrzCd16Gxp9u34yE+9a5K1Fru6s1cxZJ9tbaflfrlIwTOXfjuinG415sR7O5nVOyXPPOBL9UTdryYTYPC6fi+T/1D9eIULH4QRa5PyzmHvRCoC95AdKJvu4gyWl1dXblGrdAAoEcSqmpTkm1exdngrbaOngyh/Z+FM21daGdI8ya4803434mQi0t9jfxCc7Tb9fsloROmZr54SFyWaq/rPZbJDnpVvx/o1XHWxR6OqimM989KA07BGawIe+8xeJJiU0xE3cbFoBJDbKagLByKUJqs7RRKQ/SC/erGeGkDnpI4dN/V+UljA6oDXcOOtOQqRQZQrdpQGNQb25zoc+YXYD20VEsObpycdnooKtCec+TgLnPXQatVvwLf3VVhBXUpia+6C1Veck0SAF02o0mypsNTC0He/E6Zi5vtpWWyh7fEw6/3UTvSBeoKRXlJ4dbmX5RvtgYELagjuAQ1kJFDZKOtZKjtzMG8mNN7h3mqdVU6HiR1PiYm3j+Hz+4dA/3tEkk6iUc943n5S4b7JhlYOhmeg9hddzi4VmiSxmgPxXcVl1GiBA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31696002)(6666004)(478600001)(26005)(86362001)(6506007)(6512007)(53546011)(2616005)(8936002)(8676002)(36756003)(54906003)(110136005)(41300700001)(5660300002)(66476007)(66556008)(7416002)(4744005)(316002)(66946007)(2906002)(4326008)(6486002)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnAwandjNWZZclZvRHhxRkhhZjBJOWVOcmU1M0FLN1VrR3R6VjlINHFNZ2FH?=
 =?utf-8?B?bXFpVjcyRldhM2UwdDFyUzF3aGU2QTJwSWpWSzU4VW53UXNuSm5jbFd5UHp5?=
 =?utf-8?B?SnNCMmp1cnN0a2JKdXNpaTVSWmkvYzFtb3ZaUVBjbHk4NjBVa2VWSjMzQXF2?=
 =?utf-8?B?a25NcllHRk4zQU9LVGlaSzNqTUVlZzlaOC9JZ2FxTksvYkFCdERDSWR2V2FN?=
 =?utf-8?B?N1NLQ3pQdGYwWFUrWW9kaUV3VmcrWDl2Y3JkOUg0QmlrMDlBTUcvSVBjK1Nw?=
 =?utf-8?B?ZzVJNkJuZGhFbnl6SS84b1BYRnAxWkU3cU0ya1VmVm8rQmhPZFlZSmhTUW0w?=
 =?utf-8?B?b3dtd2Rib1hXWmt5anFyR1hVV0JFcGtYT1l3VGFKR0lrYldyL3FzVWlidmxa?=
 =?utf-8?B?YWlMT3dJbE1SZTBIV09iN1BvMUdkMWtoWTFjZUZIajd2MDQwZ08vU3R1L1lp?=
 =?utf-8?B?Rk4vN0dEK0xlL21IaGwzblcvZXZZWXZMNm1IQnFIbUtoTW5kdVAwNTNyYzdx?=
 =?utf-8?B?eThiRTJJSzFGVzl6TC9Dbi81blF4U3p1NzdLK0d0QnNlSXREMlRtR01MZmw1?=
 =?utf-8?B?ODJYdmJBUHRBcmp2RVdRWXNmNWJyYnVlZzgwZ2VUQ2J0RGYzb1F0ZEdnMzZC?=
 =?utf-8?B?Uno5N3VMVW5GVFpsei9LZTFGU3RrZVlLVlVQeTJPa1Y3VlEzUjlSeW1ydkRY?=
 =?utf-8?B?emgxYWRicFBVNGg5K25FcTJGekVadlFtUWtjRjB6NTYwb0pRNXY3dW0za0Qv?=
 =?utf-8?B?TU56amlRR1Z1VDBvTzNIYlZPUUVJOHFYdVprMXlDZWhycGI4T0g0b1UvSHBx?=
 =?utf-8?B?QWJkZi9LVkJndGNOaWRTYjJpM05FWWkzWE1oZS95UFMyeitsekFsSTNRNldW?=
 =?utf-8?B?cjlKRThZZ01SYzBBRmFJQ0NCYzAzakdYN2txaC9iWUhUdnc1aG1PTXRGNW8z?=
 =?utf-8?B?LzhVUjFnZFpIaXhNUHlLOXBOYmFCdDNPbkFrQ3RJT2I5QnZZUm5MUnl3VkRp?=
 =?utf-8?B?MHFXYVc4bnYxQUtnR0haK2wwK2dUZEVZWm0yYzhJb3FhZnAyK29VK1RFTWph?=
 =?utf-8?B?L2VJRkhBcVkvWFJQYUlFTjhvSVYwc0J2eFNzWUQ4UEdTRjJUaTFIbDg3Um5T?=
 =?utf-8?B?RFJnbWd1ak0raVJuNDN0TWEvMVZjM3hmT0pyRXEyRDkrMUxDVzZKT0N4RHND?=
 =?utf-8?B?ZkJKVDJQVHZWTGVkNkJBamhvdktJdWhoZ1JxdUFzUk9kYTZHTmxVY1UweS9v?=
 =?utf-8?B?U0xsR3pKOHVMWVllZFRHSC85Zzl5UDhLcnpld09wUzlsa3lhMkJrK3I2cTBS?=
 =?utf-8?B?ekVPbThQNjJncXB6SUlLSnozRjJkODFnTEVKQjRlL0FpLzNoVHpGTmVQVUw4?=
 =?utf-8?B?MDJGNm1PakQrNWdaMi9jWUVDTEpUU04wQ0FzYWZlaXFVVkRYU2YwRk9neUhY?=
 =?utf-8?B?cUdqRWU2LzFkZTR2enBkdGVhbSthRTZLYmlZL2tOTURCQ1ZQSEVMWGMydXow?=
 =?utf-8?B?djhkK2pIVUpleDZhSEo3d2U1VDZPeTRKNExrSG5mTDYvU29GYmhqZ1VvWmlH?=
 =?utf-8?B?RURReE5qbmRuKzNvLzM0N3hlV0dVYldzUG0xNm80elZYUUV4NHBKZER6YXh5?=
 =?utf-8?B?eTNwR0pnZFo5T3dPa3ZYemNFUEZQbkVpQTlCb0xXNEMwVHBUTFJjUVJkK0NB?=
 =?utf-8?B?Y2RuWitIM3Z3cG9kWFNDZXhab0d6bXl5SDNLVytlSWhyampIa0V4QzFrQnFP?=
 =?utf-8?B?WmJ6T2RPL2YwVE9uOHIvSkxmTkFyY1pDRDVCTWRZNysrQTVtbkRUMGdNWkt3?=
 =?utf-8?B?Ky93bTNDOTNnRy9ZeXVYaGR5WjNXRzVpZTJyR2xJc1lVMGMyejg0UkpYdHJK?=
 =?utf-8?B?eGNPdmlxWjRUQ0pBRktZQXowOENOMkg0aUNDZVZSc0o4UmlmM2FhOE1iRWNC?=
 =?utf-8?B?M0xzWnhqSmltVVNic3lEZnR5SERZQVcwOE83SU9Bb2ZZWkJwSWJPelEvdFdq?=
 =?utf-8?B?UWI3Sm9PRUNZamtodlkzaWdVbUtvejAyRWFBZHMzUlk2NTZjVVpMVEJRdVhq?=
 =?utf-8?B?TVk0THp0TWNZbGY0dEVEUmlDZVZNTE9TcTBmalNxTit0WVlXTHkwU3p1RG9D?=
 =?utf-8?Q?+ZH7b8i/mlrHvBKwrSF/jraqy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f25879-0eba-4855-9992-08dc0df3d69a
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 13:40:11.2042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZP/7DgRH0fTBlH8ZGklr7JxaWzkAqz54h+aysGkD+9oG/JMVy7zsYNbrrtASJEXGcgaq+RimNiw9ddb7gym6jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233

Hi Kevin,

On 12/15/2023 2:32 PM, Tian, Kevin wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Sent: Wednesday, December 13, 2023 12:02 AM
>>
>> +void amd_iommu_build_efr(u64 *efr, u64 *efr2)
>> +{
>> +	if (efr) {
>> +		*efr = (FEATURE_GT | FEATURE_GIOSUP | FEATURE_PPR);
>> +
>> +		/* 5-level v2 page table support */
>> +		*efr |= ((FEATURE_GATS_5LEVEL << FEATURE_GATS_SHIFT) &
>> +			 FEATURE_GATS_MASK);
>> +
>> +		/* 3-level GCR3 table support */
>> +		*efr |= ((FEATURE_GLX_3LEVEL << FEATURE_GLX_SHIFT) &
>> +			 FEATURE_GLX_MASK);
>> +
>> +		/* 16-bit PASMAX support */
>> +		*efr |= ((FEATURE_PASMAX_16 << FEATURE_PASMAX_SHIFT)
>> &
>> +			 FEATURE_PASMAX_MASK);
>> +	}
>> +
>> +	if (efr2)
>> +		*efr2 = 0;
>> +}
> 
> Don't this need to check the support in hw?

Ah.. Good point. Let me add check for the support for these features in 
the actual hardware.

Thanks,
Suravee

