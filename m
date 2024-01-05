Return-Path: <linux-kernel+bounces-17886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9F9825491
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D171F229C8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435552D7B0;
	Fri,  5 Jan 2024 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IIQY86k7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CA82D63E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCf1f8S6C8yyy7h7VxrTqr/Oj/ILTSNLAtmMP66pLxXS+1xsT5PpCe2f4D/LiMT0OYLM7WsfMUbwquFPYv0JVGukFOBwAm7UKhnQ4gSuCqe0ZsLAEUwP8fbXv3k4gm5nSH2nk/8kAqUE1Qs3WAjJCQcL6tFc0GrWKDzT8qZbmIW0Pwx61TxcXA6vNrSWEPmZTU06mU+w383XnDkBFOZaP6Nb35M4KgArnrX2KSP+yqnjxgKRQUY6c4kXsaqB9R7Dk0zFvSQl+FTQ11JOknMEYMYDJIBw/Rx5f/zzUnid2wYqtdEi1ViUlycJ5dHIJxZcYYZItNmBtSBjo0BdWY4YQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/momUFV42la3Y0oyuStxIesLDm+Ap0azCJ2T+4mH8uE=;
 b=Qq2Zp8zbMD4yCkwzaGPZR4l4fDaEmFnubGcxZFrgHz4K2OBWdRGzvF+lg6JyaqMJJsOR2t8iMm3fDN/z7uzZoi90neWAnWNhOHMJVM6bwUJhIarnBS2uGNLTAum6w9zl4KDmK9wbirwOelk5AX5JH7lY9FaPaki96RcI5DDv7q64JM1O5eNpp2fb6nKnk9T3xM5CeHImOAIkNYzs+RUWqGyYHYqZ7RUtwTyJnxOMOxjS6+R+iX7wt1JjTquL0brcW3DU7pirxWIOrfyRJbJ+VZbwNC8/WzXJYiyBIRTdI3s/2JUXrO2d1rMH7b5VCC0tVeMxwtj7wXUBbhDWm1IIKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/momUFV42la3Y0oyuStxIesLDm+Ap0azCJ2T+4mH8uE=;
 b=IIQY86k7z6LRB2u9ztll94xReVrHF+4xIkiHb8dPSxYMfhb26A+r6+0KOHC7qhwKBLRsJrVoqLLL9bkWk6mERK1mWFoQkUDyp/P99L6br4XtCPO0+XLorYkEoiZgzJq9KJen5zzkJgWQ9Gg+DY2chIBXeQUgnFy9PbutQXUZifo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Fri, 5 Jan
 2024 13:40:05 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::e557:fd55:457:12]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::e557:fd55:457:12%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 13:40:05 +0000
Message-ID: <09d009cd-6366-4372-9534-4c637c56b3d7@amd.com>
Date: Fri, 5 Jan 2024 20:39:56 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/6] iommu/amd: Introduce Guest-ID struct
 amd_iommu_vminfo
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
 <20231212160139.174229-4-suravee.suthikulpanit@amd.com>
 <BN9PR11MB527634DAFBBACC20DD691DD58C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <BN9PR11MB527634DAFBBACC20DD691DD58C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
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
X-MS-Office365-Filtering-Correlation-Id: 55bd52fc-b78d-4ece-11a9-08dc0df3d377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kD8SzXOhOFVYCKN9nZX0Kaq4ATTMczD1H43EHQbGNzrgIaLgZ/xwLvXgI0pmduW8q5p5lM/T0IFT03tCaloJMpOwWYV8uEFtN8idgJiVOfH44aDLc0toyURrU6LJsyeHo54Oa+KOoQmVganZxSV5S/dcv9Weiu02bnTnwxXt6qoTULheGk+oKJp6jBe5+Pp2sx6FkI79wie5gwPM8O2U9jN8IyfYGAgsTMI4EOiDw9hVjShcSkWil8Z8xEbvJRQ99TJQxbqIj9LR94lLmdNqLadHwTS30U4t+vnYxWcNiz/90YF/K9BOhd9R5AyshL68aJsVloiCJofneYh7GdEHy2Ok6HPS+Gz0WFJbD69fjE7gKQRC3nQ5rgHCkBSYhAQD8dOgARXNNeGq8B/A5e/ydSIJI6DcQoLEXeIgxcs1OGsGkH7NMuOgMt79mn+2QtK4Qo4fFv6v70jCsHyR6FtZ538aniyU24/I/4IM50w3ofotrJUqwTrjmoOv2vItXSyjYUv6h/nsD0l81Wmi0WXg+Y6c4id+zVhsXQWddg0YVWX4di0WsgfFo4ErE4tk/0YxQ7im78XVQd4tVp/k3oOGUvyNKpcc3AGi6wBlDG/1fVWxzI9Befi/xrFN5MnUmeTFjJsFRD9hmkcQLrwDFd2Bdg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31696002)(6666004)(478600001)(26005)(86362001)(6506007)(6512007)(53546011)(2616005)(8936002)(8676002)(36756003)(54906003)(110136005)(41300700001)(5660300002)(66476007)(66556008)(7416002)(4744005)(316002)(66946007)(2906002)(4326008)(6486002)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TCtCZk8vTi94Q1d0T3c1YkNDY0YxRk5WTWFsZHkrK1lQT1FXYnlpRzBSL29Y?=
 =?utf-8?B?NDFyWkordS9TRWRHTEd6aW4vRHd1bFZQMDFNUE9DRnNoRHlwTTlnR28rd2Z3?=
 =?utf-8?B?UzRxbzJiK01qZ0Z6UnB0OXdkV1NGK0d1WEVVRHR1cmhRTkRaWU9oNG03MDI3?=
 =?utf-8?B?QTB2NGZvcldsTmhsdE1Ldlc1akZsOVI1Rk9QWGhFazVzaExrT2hnYnNEVDR6?=
 =?utf-8?B?Y3hGc1hkeXRCQnJ5dTlJN25ySERFRWNXODY4SmljeXpESVI1cFpYWFlnVEs2?=
 =?utf-8?B?VW9nNGVRcGZzeXhueXNFVEcyYWV1ZWtESDhhZHlzanVWK1J1WnhjZ1cyZDVp?=
 =?utf-8?B?bjRJakNSZCs4MTJrTGFNUDFtczBIK3hIS0xUR0NFdFNNYnU2QkduWUgwSkVU?=
 =?utf-8?B?L1hwSCt3MWF1UTNkZjdRc1czWERWcUIxODhodHZUM2UzK1RTV2s5VVdZS3hO?=
 =?utf-8?B?TTdTQkVuUVVuL0dkZEpxSDVTTVhkTFZFSTdRcmM5MlFNaVZneFoyTTNNd3Ba?=
 =?utf-8?B?dURPdzdiUjl5cDNKeW1Bd2d3QkhlSEFjZFFxMzJQdll2QXRxT2Q0NndaWW5I?=
 =?utf-8?B?emY2K0JoRU9RckpWYS9QelBvb2ZpMVdETmlQbGJ4RG1oSkhubDhBTkdJY3kv?=
 =?utf-8?B?bVhzZGdFUXhTa2t2SURSRk1wQk03UThncEZWZjdYWDNRaTMyRHhwUHpMaldH?=
 =?utf-8?B?S2w1bGU5V3NvUWpXSnJidms0M2IwWGEwN1lhdHYwNERHdVVrMTlrdU5NRjN5?=
 =?utf-8?B?Z0MxOGg5WUp6OFZHMWtVZDhUakhhaTRzb2h1OXdINEdNT2xoOHJQQ2plOXJN?=
 =?utf-8?B?cDE3clU5eUVjTmE5Q0wwY0k3QUtYeFdUblhGSlB4NnVjUmlLTjRxZWJHZWRE?=
 =?utf-8?B?M3hOa0ZjSnp5MGVjTGxMN2I1dTZaTTFEdk0zbGNPUWliZHVqQklYQXA5S25B?=
 =?utf-8?B?UU9UcTV4b1l3S0lnQjY5Sks3bGpZdmsvQkQ0b2VOM0JCOGczMkVNdnhGbzFy?=
 =?utf-8?B?VytjT1ZyM0xrTk5wZXNnblVsM0hYcmJxNk9LQndyYnQ5VjVtMnhvWVNlMHJw?=
 =?utf-8?B?Snl2c1NMUlJYY2FKd0U2ZFBpSk5EV1BMMzhaUnFiNjhWNmVvOFdycExPYUw1?=
 =?utf-8?B?dHVlbXZtVXRUSVJaalgrY29aZ1FZZCs5dDBNRE1iWTBwdkxQa1BrKzJOY1dn?=
 =?utf-8?B?MHZ5eVpoQVBrQ2s2QnlPU080Ym41VVl0MDZydFJISjczOGw5cFljUW9Hb25L?=
 =?utf-8?B?TU1Ya3dvdTFMd3gwWjM1SWIydldKdDk5ZXUxUm45VXNNZUpQajZPU2hqZEQw?=
 =?utf-8?B?dGVoSGhzWlRnNC9TeFJLMTBkM1E0ZWdQSUh2U0NvVXoxNUUyRm1YaHNoV1hN?=
 =?utf-8?B?S2ZBVUNPa1NhVER1dUZEODV5Y1VXakhMOGFBUDJ4NTJwU3pqVmhnL3g1YnNT?=
 =?utf-8?B?aDZFeXlYSTJoN2QwNnIrdDhjMUhEY3BwNEg2bFNUMzdlQ1FKQWFlWDExM3Vt?=
 =?utf-8?B?TTZlQnBwVDlQZ0hMQ3kwOFNwL2R1UWM5Z2tTQXVxYUtyQVRpYVV5V01Od2JK?=
 =?utf-8?B?SzBQMjd4MFFUdUZTeE5EU0Z1SXNRR1U0UHFuNG9mTVpIVlFpUUhBOW5QNERM?=
 =?utf-8?B?WEJ2aU9hTlUxS1VpQW5Ib3pYbGpjdXZNeVE4cXFtZVBWUUpxcnppV2dPT0tx?=
 =?utf-8?B?VW15aUZnQ2sxYjVObjZUb2xtTjZJdTJBYTIyd2d4Vll6b0tjbHZOVHB5MWcx?=
 =?utf-8?B?R29KQjhreTVqdmN2dXoyMkN5UUluV2V6aGFYT3hra1BRbkdScys1QnNNS29l?=
 =?utf-8?B?VHFOak9ReEJ0VDNJUE9tK3UwcERPMnJwWWdiano3TDhjeWt1Nkc4TTFyVlJn?=
 =?utf-8?B?VHp0QXBPKzZXa0RDK0RuVEUxS1o1NWlxZFVTNUxFNFVDS21wc0FEdzF1SFZE?=
 =?utf-8?B?bFE4Y1hMYVVaQm9nc244dGl3czg3bVFUb2NGT0ZqVW04S3RPL0dkdGNBdU5T?=
 =?utf-8?B?SDFHY0xVTGgvVWJYNllObmQyR0NKZCs2bzRHSUV0M0FzY0UzK25OWTA2WHMx?=
 =?utf-8?B?OFFPZ3VabTZwR3hETkl4bTdQU21pMWNMMTVqeTBkRS9pQUtoZGRYN2k3WEpU?=
 =?utf-8?Q?eGDqdSd+l3CBzVqQHavRdwaaU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55bd52fc-b78d-4ece-11a9-08dc0df3d377
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 13:40:05.7194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNZH42vipGRCGChTMymbrXtvtvnZAcl3Tnr0OomMAgaAGPRXvhaUFBzR8XQp/6aT+yjH2RY+eINRuYJ5eEu4Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233

Hi Kevin

On 12/15/2023 2:35 PM, Tian, Kevin wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Sent: Wednesday, December 13, 2023 12:02 AM
>>
>> AMD HW-vIOMMU feature requires IOMMU driver to specify a unique 16-bit
>> Guest ID (GID) for each VM. This ID is used to index into various
>> data structures for configuring the hardware.
>>
>> Introduce amd_iommu_vminfo_hash hashtable to store per-vm
>> configuration,
>> which uses 16-bit GID as a hash key along with helper functions.
>>
> 
> somehow it's unclear to me whether this series is only for hw
> supporting vf or broader hw supporting nested capability. for
> the latter case is GID still necessary?

I am restructuring the series and might be moving GID stuff until later 
when introduce broader hw support for AMD vIOMMU.

Suravee

