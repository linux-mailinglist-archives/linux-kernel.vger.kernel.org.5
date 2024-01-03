Return-Path: <linux-kernel+bounces-15716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A6A8230D0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB211C237B0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8527A1B280;
	Wed,  3 Jan 2024 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dz4v9yF4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35371B274
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPe67X7ir8EmDuktMLx0S/XVOg0QW8ei/k3TsKPtSSP6Zv8aBlru4YE2t4NE/QkYI9DETDfRrbo5qosf4RVMS3EvtW6EI+d2ZrJOtRH5FFwa8sD4uAqmn7DLu2pBicg0cDmEIUzDA5yWDZkC238UIjoRXB12Bu44t5dhhZ1ZyzLTm07bZO8j50rP0/MnM4iCgajwkndFEiRymgN2XwtPuGru+2J2IV39ukxBb8zztQ+wCuJ4ZBKuKZ1wSWbpx6hXAkLsMD9KNO5/VqPckUjkCHcZ2MCr8FfxPyzR1n4c77jciq0KWRT7c89MBhuIVSRIxo646pwfU46MnobdFFHEqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSMh926Vl5esjIsvoX1wHOba/eB9W30z18VEik06EUo=;
 b=oaXoki1llpwkJQYC77xdlWTEq0jTXAfFHDd1m6KQlY/3nNptB013Xn0HSQtbjOA8tgmq9cAmYtMkg/khbOrxc0YfdjmeKwATwGTsmrlRD4KBmYQtIzPt4pPNf5XGp+MJblCCl+M+BuRSzHr4PTPsQivEk+s2KG3A6QScjs3JqYpaNlXm3ZrIEy6qtXw/ZAOso1HgSJpVe75cNO6iAZJs7YROGiOiZTm4eUIa4/1uWP/TE0uTVLcYGBifzWX1sfRvVQZ9bi95fe7D9brf6uEb1marOTMNOmaIh/2XQ9JIajLYH7G1nwyBZd2dDtzjSJHuhJ5d8wctnKK3Rt3qNUC7zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSMh926Vl5esjIsvoX1wHOba/eB9W30z18VEik06EUo=;
 b=dz4v9yF4fjjzMP97z+WkA04zHE8EmtJ3fXyzhPPgMP/jZNRaRI17NtBjJITxL64AIF9s/fkXLFgCMjS+Dm91aHLHV7hL3VM+ViR6cLefJ/Gam/zlV3xRHbzuyz7KDlsi1c0cy6PNQndASbNuXjen6OvaWxs4laoFx/IufrcVmVXuaJAMwpj/Qx1UqAxDeD5a+vlGa5Dw+eZVY9aHG/3cbCN51RwScKfguDIuD8JfaGmMydBpUXkLiXdlbb0orZ22OWQm7HqGLjL9hdZaeE9orK1iFXR4YzCZ1VRfhkLPGH/VfMW3ap1koL0cji2opkHxRy/DA3FsKAH/sOwH7wrCUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SN7PR12MB7348.namprd12.prod.outlook.com (2603:10b6:806:29b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 15:51:45 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::99b6:1e06:1e8b:4324]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::99b6:1e06:1e8b:4324%5]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 15:51:45 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "\"Huang, Ying\"" <ying.huang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 "\"Yin, Fengwei\"" <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Rohan Puri <rohan.puri15@gmail.com>, Mcgrof Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "\"Vishal Moola (Oracle)\"" <vishal.moola@gmail.com>
Subject: Re: [PATCH v1 0/4] Enable >0 order folio memory compaction
Date: Wed, 03 Jan 2024 10:51:43 -0500
X-Mailer: MailMate (1.14r5994)
Message-ID: <DFFD13A9-2578-4A57-AA46-068EEA77FBC4@nvidia.com>
In-Reply-To: <7acefbe0-9413-48fd-ad98-56fecc6f29da@arm.com>
References: <20231113170157.280181-1-zi.yan@sent.com>
 <1e7cf758-ac0e-4eda-a8e2-90db5eed7f7a@arm.com>
 <7ED1378A-AC39-48A2-8A2A-E06C7858DCE1@nvidia.com>
 <df51bbb7-f791-4747-9077-e9f7f37e9518@arm.com>
 <E22D7AC8-0891-4B4D-BB90-129B1CB77CB2@nvidia.com>
 <7acefbe0-9413-48fd-ad98-56fecc6f29da@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_2B07A4E6-07BA-448E-973B-5DB82A893224_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR01CA0025.prod.exchangelabs.com (2603:10b6:208:10c::38)
 To DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SN7PR12MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b65a92-0d45-469c-d3f9-08dc0c73e365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qIs72HydSP5P36Zw/aqYzCnp0g6k8kWiJXvJX7BYUZ+lUXTUMzcFCD/aNTeJywEXobzH82CAxYv54T3gjulV4p9UI5dqsl4C2vNnPTDNCoKXi4UwUF1NWiRIbpsZOddo3aAm5jp/cOD/himKpsXm/qEHpcROgy0YdyBKx/nKoD8hR4XFHQuPtSuMVjBHPvOehqkHWyi5u2FWyu+iRAbyZfbkLJpCEuNY5GGpiQNB2JUKUcKR6yCJpPcVz7Dt9aW5j44InfECewA5op8k+XPofsGS8TUCOgvfoajmVzrkl1zi3Q1nLayvTJNgUIMrwvewCIP/0q1BMMKJXwwVDYjb/1+F5OlmmimTGFk8OPSW9AAaY/xmNmfThLRxQ/oNxOV+Hyh0QvZ0Js5WBy34y/3yWOAqgYdBq6va3FOyo5PNSUqMCLNyF7lbnsGXDlT3HPNs0yLzkAZCAYWI2hedG7AnOW+EjWejiMHMm+lqjxOcjJ/Nzq05hbbG1DdPMbnDCDp29H+TFEKYEjWEsjNS+P12CogrZA9n4g541MOKSiCPsvCfGpRK+8NZdRV1KeUSrCPnUYxzDqEDVjPH0ZYS069vJQ2/oFK4JMVRhLOUPK8SMm6XJPV/XGocTFpcvZ6MUtki
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(53546011)(41300700001)(66946007)(26005)(83380400001)(2616005)(2906002)(5660300002)(38100700002)(8936002)(316002)(235185007)(8676002)(4326008)(7416002)(4001150100001)(54906003)(30864003)(478600001)(33964004)(66476007)(6506007)(66556008)(6486002)(6512007)(86362001)(6916009)(36756003)(33656002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWtsSi94QnJvdU9zYWtmUUV0MGowc1dac1FPK0pQTFkxQ2hQN3d5dXpLWEV0?=
 =?utf-8?B?bEZ1bHJ3K3IvSlZDclFTVzA2aUpwUjdtR0RqbVJsMDlsdkpnbDlJODhYcHVD?=
 =?utf-8?B?VTBIQWRlRkhJV29JaHg3aUVRWVkrWllRRkVYU1dUTWRjSW0rb0VmTmI5eThN?=
 =?utf-8?B?ZnNPbGxuWnllYmZQZVJwamYxc0ZENncrMXYwVjRYeU5yTTNiVmJPZStCemJN?=
 =?utf-8?B?V3g5ZlI3TUxJOVFZMVM2dXR3TEU1NXJvRHR2Q09wM1VoVVNWRStIZEpTN0tn?=
 =?utf-8?B?Y0hMZXZ0dHA2VmFSbHVVYitHNmhGZXhHczZSQjVBQTh6ZEZqODB4eG5acTdE?=
 =?utf-8?B?TUtDSk9xdmpCZnRjdHFPbzRid1RQOThpb2dMamsyY2ZEZlJ5dEVzS2lQbGVO?=
 =?utf-8?B?citXQlY5ZlZFTlBtMFVXYW5LKy9YaUF1SERlbjBQd3JGWmdTSFgvY3lqbHBv?=
 =?utf-8?B?blovU2cxOGpaSWpJaUp1cXVKTGFkayt0MFRaYUN5UUsvUHpOKzdzbzBqZGQ4?=
 =?utf-8?B?WjhPdmNWTVJXU3AwYSsxTURZNDhtM1VneTd4UVpENkt6UnJRWFFJYnd6amJQ?=
 =?utf-8?B?SjlKZmNtbzdQUnZYOEp3L1FMQnhmUDZLb1V1OTIvSDU2QzNROEJPQkRJQjZj?=
 =?utf-8?B?SHZjS3dldlE4WW9NNXcxRWRoeDVIeXd5N1VyWjVFM1YrTi9TakNTRFR1WkYz?=
 =?utf-8?B?L1N4a3VZM1BScUtXQmkzQloxTmU0SHlGK09yR2k1M01hTXZBZVQ2VW43NE9w?=
 =?utf-8?B?UzQ2N1cvdWtaWmtJcGticklidVpsdHUxbitPeElXZkdidWJBRURrWkY5MXdT?=
 =?utf-8?B?dGxEZVpPMlFUQ0FJRythRStzaEx6UDNTclFucHI2UHVsakxOU0NMRm1JNi82?=
 =?utf-8?B?YTA5VnFZSm5mak1nN1V5WmxJbjZTTXdabTk3TElrSnpydGVOVlRFTE1uVnlQ?=
 =?utf-8?B?UE43L21kK3dFK3pMQlNLbXVQalozdXVvV3FZM1RYVnZEK09Uci9DZllBeU9z?=
 =?utf-8?B?KzNWR1JHb0svQ1ZtdUM5ekdWSDZLZndEM1Z0RDJ5QXZ2NjJ4T3IxSWxxbUc5?=
 =?utf-8?B?TWFUWW41cnAzdVlsMzNLdjNpOTZZK3NudnI2MmdSa3JmbXU5akFkNWxmWXcr?=
 =?utf-8?B?U0FJNGFIZjUrUWY3eVhiQldyMHRVWEFvejZzZXFFYWlDZzFFMVhEWUpONno0?=
 =?utf-8?B?WWVuOWhxdllEZ0ppaFU1TEdaR1ZoT2JpdHhZZWhXd0xGZVlYNkpGTHBPRUx3?=
 =?utf-8?B?aXlMU3lHckMrYy9EWEJEc1lpMXArNEI5eXpMY0h3V0VNQ3o5dlJoTTJNY0Zz?=
 =?utf-8?B?TFRYQ2NrMmkvRlNPUGJlNzcvbEp2UlBsVVRFNVFadjVuOXpuYlFWdXJac3Qr?=
 =?utf-8?B?SFhNRXZRdWl6SC9pSnZmSmpCWVYrQktNNmV2Z0JmVXl0K3Y3RlBqM0NFQVBQ?=
 =?utf-8?B?V2JrZkFjYnUyT051cDA4UUZ4UGxSd3F1L095QmxuaDZkN0doS055ZWwxM2oz?=
 =?utf-8?B?WVp1Nnl2ZHlwN3MyMldqaTdqeEt2cVhOT3lZSjFYNUtnMm12WWZ5RWhUenNi?=
 =?utf-8?B?Q1VnbkNwdHdQdkEvZTRpbUlYZ1lOdks5T3RaWlA4TUQxbkdQR1R0VVJncEsz?=
 =?utf-8?B?bEkyN0ZGRVVnSnVCamdXZTdSTHJWTmt4dnJlT1g3Y21kUHdzekdQVlpqWCtW?=
 =?utf-8?B?Q25pTzRpYU1UcFhuWGJod2pXRkpkN2NTVFZEU0o4S0htY1FNTVg3UEZjV2t3?=
 =?utf-8?B?U0wzcmhvY1NjbnkzYzEyaXJ1SEZCQVl1YjV1Qks1L2ZoZnArdTdBMk1ibFdL?=
 =?utf-8?B?VVpXNytSbk53SHNZNVV2cmNaK2NsbVdJVmVvZXFKRGJGSmduTmNldWswNWow?=
 =?utf-8?B?QlE4aDlmK1Y2SzZ3U1dOUEVuVnZHOUs4Q3lYQzZnVkUxVW5jeWhZMEJ3ZWh2?=
 =?utf-8?B?MTN6d2xJeHFLLzBOYnFobmFmVWxxS0c0d0l5MityNnB3NHpKTzZhNGxHUzZn?=
 =?utf-8?B?dFpvempnQlF5V1JOc2FpOUJtMXN4em1IMmFTVnlGV3B6NFZ6UkF5QVlLU1lm?=
 =?utf-8?B?NjVUOXk1VGl6U0NZeGJrSFFMTlNxVVh2L0JCMmhIb0czbXVyZkFRUEE3a0Zm?=
 =?utf-8?Q?g5R9WOgyqwoUDBSUIJWY91o2H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b65a92-0d45-469c-d3f9-08dc0c73e365
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 15:51:45.7085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8KiJeQqONd+ZSNrWmt8eemAY6U71ca1Z1pCePEsXRaJXyzJNOA2IEkEqMdWfr70
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7348

--=_MailMate_2B07A4E6-07BA-448E-973B-5DB82A893224_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 3 Jan 2024, at 4:12, Ryan Roberts wrote:

> On 02/01/2024 20:50, Zi Yan wrote:
>> On 21 Nov 2023, at 12:11, Ryan Roberts wrote:
>>
>>> On 21/11/2023 16:45, Zi Yan wrote:
>>>> On 21 Nov 2023, at 10:46, Ryan Roberts wrote:
>>>>
>>>>>>
>>>>>> vm-scalability results
>>>>>> =3D=3D=3D
>>>>>>
>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>>>>>   gcc-13/defconfig/debian/300s/qemu-vm/mmap-xread-seq-mt/vm-scalab=
ility
>>>>>>
>>>>>> commit:
>>>>>>   6.6.0-rc4-mm-everything-2023-10-21-02-40+
>>>>>>   6.6.0-rc4-split-folio-in-compaction+
>>>>>>   6.6.0-rc4-folio-migration-in-compaction+
>>>>>>   6.6.0-rc4-folio-migration-free-page-split+
>>>>>>   6.6.0-rc4-folio-migration-free-page-split-sort-src+
>>>>>>
>>>>>> 6.6.0-rc4-mm-eve 6.6.0-rc4-split-folio-in-co 6.6.0-rc4-folio-migra=
tion-i 6.6.0-rc4-folio-migration-f 6.6.0-rc4-folio-migration-f
>>>>>> ---------------- --------------------------- ---------------------=
------ --------------------------- ---------------------------
>>>>>>          %stddev     %change         %stddev     %change         %=
stddev     %change         %stddev     %change         %stddev
>>>>>>              \          |                \          |             =
   \          |                \          |                \
>>>>>>   12896955            +2.7%   13249322            -4.0%   12385175=
 =C2=B1  5%      +1.1%   13033951            -0.4%   12845698        vm-s=
calability.throughput
>>>>>
>>>>> Hi Zi,
>>>>>
>>>>> Are you able to add any commentary to these results as I'm struggli=
ng to
>>>>> interpret them; Is a positive or negative change better (are they t=
imes or
>>>>> rates?). What are the stddev values? The title suggests percent but=
 the values
>>>>> are huge - I'm trying to understand what the error bars look like -=
 are the
>>>>> swings real or noise?
>>>>
>>>> The metric is vm-scalability.throughput, so the larger the better. S=
ome %stddev
>>>> are not present since they are too small. For 6.6.0-rc4-folio-migrat=
ion-in-compaction+,
>>>> %stddev is greater than %change, so the change might be noise.
>>>
>>> Ahh got it - thanks!
>>>
>>>>
>>>> Also, I talked to DavidH in last THP Cabal meeting about this. He su=
ggested that
>>>> there are a lot of noise in vm-scalability like what I have here and=
 I should
>>>> run more iterations and on bare metal. I am currently rerun them on =
a baremetal
>>>> and more iterations on the existing VM and report the results later.=
 Please
>>>> note that the runs really take some time.
>>>
>>> Ahh ok, I'll wait for the bare metal numbers and will disregard these=
 for now.
>>> Thanks!
>>
>> It seems that the unexpected big mmap-pread-seq-mt perf drop came from=
 the mistake I
>> made in patch 1. After fixing that, mmap-pread-seq-mt perf only drops =
0.5%. The new
>> results on top of 6.7.0-rc1-mm-everything-2023-11-15-00-17 are at the =
end of the email.
>
> Good news! I don't see the results for mmap-pread-seq-mt below - perhap=
s you
> forgot to include it?

The stats below only shows significant changes and mmap-pread-seq-mt delt=
a is less
than 5%, thus it is not shown.

>
>>
>> I am preparing v2 and will send it out soon.
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>   gcc-13/defconfig/debian/300s/qemu-vm/mmap-xread-seq-mt/vm-scalabilit=
y
>>
>> commit:
>>   6.7.0-rc1-mm-everything-2023-11-15-00-17+
>>   6.7.0-rc1-split-folio-in-compaction+
>>   6.7.0-rc1-folio-migration-in-compaction+
>>   6.7.0-rc1-folio-migration-free-page-split+
>>   6.7.0-rc1-folio-migration-free-page-split-sort-src+
>>
>> 6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migration=
-i 6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- --------------------------- ---------------------------
>>          %stddev     %change         %stddev     %change         %stdd=
ev     %change         %stddev     %change         %stddev
>>              \          |                \          |                \=
          |                \          |                \
>>   13041962           +16.1%   15142976            +5.0%   13690666 =C2=
=B1  6%      +6.7%   13920441            +5.5%   13762582        vm-scala=
bility.throughput
>
> I'm still not sure I'm interpretting this correctly; is %change always =
relative
> to 6.7.0-rc1-mm-everything-2023-11-15-00-17 or is it relative to the pr=
evious
> commit?

The former, always relative to 6.7.0-rc1-mm-everything-2023-11-15-00-17.

>
> If the former, then it looks like splitting the folios is actually fast=
er than
> migrating them whole?

Yes, I will look into it when I am preparing the next version.

>
>
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>   gcc-13/defconfig/debian/300s/qemu-vm/mmap-pread-seq/vm-scalability
>>
>> commit:
>>   6.7.0-rc1-mm-everything-2023-11-15-00-17+
>>   6.7.0-rc1-split-folio-in-compaction+
>>   6.7.0-rc1-folio-migration-in-compaction+
>>   6.7.0-rc1-folio-migration-free-page-split+
>>   6.7.0-rc1-folio-migration-free-page-split-sort-src+
>>
>> 6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migration=
-i 6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- --------------------------- ---------------------------
>>          %stddev     %change         %stddev     %change         %stdd=
ev     %change         %stddev     %change         %stddev
>>              \          |                \          |                \=
          |                \          |                \
>>   14998168            -1.0%   14852803            -0.7%   14890569    =
        -0.3%   14946766            -0.4%   14943302        vm-scalabilit=
y.throughput
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>   gcc-13/defconfig/debian/300s/qemu-vm/lru-file-readtwice/vm-scalabili=
ty
>>
>> commit:
>>   6.7.0-rc1-mm-everything-2023-11-15-00-17+
>>   6.7.0-rc1-split-folio-in-compaction+
>>   6.7.0-rc1-folio-migration-in-compaction+
>>   6.7.0-rc1-folio-migration-free-page-split+
>>   6.7.0-rc1-folio-migration-free-page-split-sort-src+
>>
>> 6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migration=
-i 6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- --------------------------- ---------------------------
>>          %stddev     %change         %stddev     %change         %stdd=
ev     %change         %stddev     %change         %stddev
>>              \          |                \          |                \=
          |                \          |                \
>>    6750930 =C2=B1  7%     +41.5%    9549570 =C2=B1  2%     +31.6%    8=
883545 =C2=B1  2%     +33.1%    8982606 =C2=B1  2%     +30.7%    8821667 =
=C2=B1  3%  vm-scalability.throughput
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>   gcc-13/defconfig/debian/300s/qemu-vm/lru-file-mmap-read/vm-scalabili=
ty
>>
>> commit:
>>   6.7.0-rc1-mm-everything-2023-11-15-00-17+
>>   6.7.0-rc1-split-folio-in-compaction+
>>   6.7.0-rc1-folio-migration-in-compaction+
>>   6.7.0-rc1-folio-migration-free-page-split+
>>   6.7.0-rc1-folio-migration-free-page-split-sort-src+
>>
>> 6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migration=
-i 6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- --------------------------- ---------------------------
>>          %stddev     %change         %stddev     %change         %stdd=
ev     %change         %stddev     %change         %stddev
>>              \          |                \          |                \=
          |                \          |                \
>>    5818610 =C2=B1 14%     +43.1%    8329118 =C2=B1  2%     +26.0%    7=
331427 =C2=B1  4%     +23.2%    7170418 =C2=B1  4%     +22.8%    7147458 =
=C2=B1  4%  vm-scalability.throughput
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>   gcc-13/defconfig/debian/300s/qemu-vm/anon-r-rand/vm-scalability
>>
>> commit:
>>   6.7.0-rc1-mm-everything-2023-11-15-00-17+
>>   6.7.0-rc1-split-folio-in-compaction+
>>   6.7.0-rc1-folio-migration-in-compaction+
>>   6.7.0-rc1-folio-migration-free-page-split+
>>   6.7.0-rc1-folio-migration-free-page-split-sort-src+
>>
>> 6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migration=
-i 6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- --------------------------- ---------------------------
>>          %stddev     %change         %stddev     %change         %stdd=
ev     %change         %stddev     %change         %stddev
>>              \          |                \          |                \=
          |                \          |                \
>>    1973808            -0.2%    1969617            -0.5%    1964376    =
        +0.3%    1979245            +1.0%    1993677        vm-scalabilit=
y.throughput
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
>>   gcc-13/defconfig/debian/300s/512G/qemu-vm/anon-w-rand/vm-scalability=

>>
>> commit:
>>   6.7.0-rc1-mm-everything-2023-11-15-00-17+
>>   6.7.0-rc1-split-folio-in-compaction+
>>   6.7.0-rc1-folio-migration-in-compaction+
>>   6.7.0-rc1-folio-migration-free-page-split+
>>   6.7.0-rc1-folio-migration-free-page-split-sort-src+
>>
>> 6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migration=
-i 6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- --------------------------- ---------------------------
>>          %stddev     %change         %stddev     %change         %stdd=
ev     %change         %stddev     %change         %stddev
>>              \          |                \          |                \=
          |                \          |                \
>>     479486            +0.3%     481036            +0.0%     479580    =
        +2.3%     490310            +1.6%     487107        vm-scalabilit=
y.throughput
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
>>   gcc-13/defconfig/debian/300s/512G/qemu-vm/anon-cow-rand/vm-scalabili=
ty
>>
>> commit:
>>   6.7.0-rc1-mm-everything-2023-11-15-00-17+
>>   6.7.0-rc1-split-folio-in-compaction+
>>   6.7.0-rc1-folio-migration-in-compaction+
>>   6.7.0-rc1-folio-migration-free-page-split+
>>   6.7.0-rc1-folio-migration-free-page-split-sort-src+
>>
>> 6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migration=
-i 6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- --------------------------- ---------------------------
>>          %stddev     %change         %stddev     %change         %stdd=
ev     %change         %stddev     %change         %stddev
>>              \          |                \          |                \=
          |                \          |                \
>>     453237            +1.2%     458580            +0.5%     455455    =
        +2.6%     464830            +2.6%     465211        vm-scalabilit=
y.throughput
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
>>   gcc-13/defconfig/debian/300s/256G/qemu-vm/msync/vm-scalability
>>
>> commit:
>>   6.7.0-rc1-mm-everything-2023-11-15-00-17+
>>   6.7.0-rc1-split-folio-in-compaction+
>>   6.7.0-rc1-folio-migration-in-compaction+
>>   6.7.0-rc1-folio-migration-free-page-split+
>>   6.7.0-rc1-folio-migration-free-page-split-sort-src+
>>
>> 6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migration=
-i 6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- --------------------------- ---------------------------
>>          %stddev     %change         %stddev     %change         %stdd=
ev     %change         %stddev     %change         %stddev
>>              \          |                \          |                \=
          |                \          |                \
>>    1074404 =C2=B1  5%     +78.7%    1920268           +78.7%    192027=
0           +77.2%    1903612           +78.0%    1912223        vm-scala=
bility.throughput
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
>>   gcc-13/defconfig/debian/300s/256G/qemu-vm/msync-mt/vm-scalability
>>
>> commit:
>>   6.7.0-rc1-mm-everything-2023-11-15-00-17+
>>   6.7.0-rc1-split-folio-in-compaction+
>>   6.7.0-rc1-folio-migration-in-compaction+
>>   6.7.0-rc1-folio-migration-free-page-split+
>>   6.7.0-rc1-folio-migration-free-page-split-sort-src+
>>
>> 6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migration=
-i 6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- --------------------------- ---------------------------
>>          %stddev     %change         %stddev     %change         %stdd=
ev     %change         %stddev     %change         %stddev
>>              \          |                \          |                \=
          |                \          |                \
>>    2568988            +5.3%    2706227            +5.3%    2706214    =
        +6.3%    2729716            +5.3%    2704539        vm-scalabilit=
y.throughput
>>
>>
>> --
>> Best Regards,
>> Yan, Zi


--
Best Regards,
Yan, Zi

--=_MailMate_2B07A4E6-07BA-448E-973B-5DB82A893224_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmWVgo8PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUsfoQAKISBNHeutCGDcX7bQrWnPVqinmB+xw0HXPU
GQ6DaLXCmRwNtOvkxH8gC/0OQ+L+R/vjwFVTNZNNXHJUOpemdMSY7zUKmQVd67sJ
rHgCblJ3EgW1c3VH5no1GbW8BAnJDT4lA5Yg8RnRDGUIy8NBvUGM4M5Ra7sguPKU
GFoCYWaCj41zfZAZObnvfBoH1E49wqSq6eOAeSc4Fu3416LvildfTowYxOZvQE8x
M+4xqEAJ4X/TBftGBmYAfwxwJbOMZakjVVDFnX+XV8lld6iQ1IiYie/h7X3PYRhl
IEcqoqfvI8XsZO2INdUd4hFTCmKrzJMUUqGqts1gjXA2O8l8qnYPAx+IxeRxmeo7
Mc991TbgsZ8cMgzHhaKZJjfXE/2im/BhL9pVh0T4rzXMhii+EWB/mH9MIKRs/hcp
c8AQtNdlB0uRhVF0nFpWmF1Kuew6e2Dlse5HrG+iIUEGx37h7fuNLMLYZ68Kcjhi
mF/PuoG5ZDPNpTh6TjxV0/+Yo8knoI+zsShBQMh07PNn92lU8AcGaPNu3vy8+dkr
PwLIPVJpkNkHphcWKMFVaT3drSM2l2X/aLdOJNXl5ttJKuQ5CsTmgOKb3C25CNF3
pu3Bxe8IUHJsY8s/1P+dxHy7NIJcaj70vBdV++zaLC5tjkg/2t0J/4PMsRgm/R8e
p55xoQxH
=I5oh
-----END PGP SIGNATURE-----

--=_MailMate_2B07A4E6-07BA-448E-973B-5DB82A893224_=--

