Return-Path: <linux-kernel+bounces-18407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED93D825CAC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 23:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F8B1F240A1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DA2364A8;
	Fri,  5 Jan 2024 22:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AZKnqM+V"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DE3364AE
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 22:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsUFJT4Xd/l6Gwb5naOxXZLVsKa4JlKPFzmb8embS6UD25a5gAPgRq6dRF/oNwxAc4KrobmpPLG2fegnBi0YVBI9a5xOpgg37+iTGbMQg2GyWNRrXLuVyIut6qD5d/FQDePPhrNSram39IPkCeaRIE2UVEWKb8IDjf2Z/olmFGM9NxkuKWetpHnOBeeBkse72fQwGB3jzshk5QVX/wJcjp2V34RWEeTbzCW08X9RGJ2+OuYRlEph8z+j3NXtDEIH9psvNKTAlVa88UgFJXH+PuBc5ewCwQkKDIFmArUkQKQp0bx/OeEgcuBG2rIwLRvkC73EKL0cCP7DBUZz17tapg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lukxq0Y5WQapa6k1o6UbZK1xCE8R2MK9zw1uG9GJvM=;
 b=PUiVjPUSn3q+ut/WFDW9p2gzjFlzHfoPAbReArNa5rTPPJTqC3nKw2eooGSqKLWJNiEkGM7L2yheUHjRNGXnOo9Ee03/1wvyd3DlnpOBM7UQeM342jS3HnMYMkxoR+nV6Wem7x0sFxd3kvXvNNkMwgPQ04FiaRukHHb32GN5zsUg/16Axsh6K5d6aP/TaMWnzU7li4wCHSASSbFLsSzzC6LB9Nq3buaUN2yykcZQ/qKG/xaGSQzZJUJp9VM7nhxJVJC4ead9nYV8XIreZZO92XLXaE4G71IPNDprarBcZvyyv2HPVt2f/nUVM9U5VINFCii0zSTfTqu22sTvP94QUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lukxq0Y5WQapa6k1o6UbZK1xCE8R2MK9zw1uG9GJvM=;
 b=AZKnqM+Vs3HOZ7NtNgRKBdpFJfKH9SDvuUIKtlFYhUILkgBTVEj1Gz+JtBWdn1b57BZz02wbDYJvr4x05NhEskdOqxukTltpqNecklYrRR6HZiy8noK9qLHPNO7zZyffbcrwywYMmnxmoTaG2uKtHOYP/HJAtq8jKeV3Hgb5n4M3mLmACc8nZiYw8REDe92Ms1tNxevG9myMESmdQrVN3abomwwyjw2OqSGAGqfJCesRvVPirUp9YTMl1jT3e7ICajBCaqZ/FmOmRiay7PDDV2vibz6GoHpWZFOPr/22MG2bnXfpcQGE9CW0w/Jiak58Dptkh5GsIs564ZRyiIHlzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA1PR12MB8286.namprd12.prod.outlook.com (2603:10b6:208:3f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Fri, 5 Jan
 2024 22:56:11 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::99b6:1e06:1e8b:4324]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::99b6:1e06:1e8b:4324%5]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 22:56:11 +0000
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
Date: Fri, 05 Jan 2024 17:56:08 -0500
X-Mailer: MailMate (1.14r5994)
Message-ID: <954192F7-8174-4E4F-82C6-36BF808CDE35@nvidia.com>
In-Reply-To: <DFFD13A9-2578-4A57-AA46-068EEA77FBC4@nvidia.com>
References: <20231113170157.280181-1-zi.yan@sent.com>
 <1e7cf758-ac0e-4eda-a8e2-90db5eed7f7a@arm.com>
 <7ED1378A-AC39-48A2-8A2A-E06C7858DCE1@nvidia.com>
 <df51bbb7-f791-4747-9077-e9f7f37e9518@arm.com>
 <E22D7AC8-0891-4B4D-BB90-129B1CB77CB2@nvidia.com>
 <7acefbe0-9413-48fd-ad98-56fecc6f29da@arm.com>
 <DFFD13A9-2578-4A57-AA46-068EEA77FBC4@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_766B8054-C4BE-4A77-A7D0-9AE1EF0771F6_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:208:335::23) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA1PR12MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: b77cdd25-8730-4870-0226-08dc0e41830d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O3IbgAqWzOLAPsEj/nfnPyP55GNNWSIkYb0I3rdtWeqZE2UmZ0fyeehJAR0aYc+dOSrnuHuFtN8KYqhSbombfVnZ1FQd8Fa5xUgvhtBM5+Y7mZG62pUeKuQPA3qqfhj0tDTUAmDBYZbt0cqi7jphbbfi65LQmeEw8jNqyJCUWp4g3dbJ9+6ygA3pbeKKN71E64Xcej8aK8OmsmRXVcTFwOp5Sr0/vu14SZW4XTp7p8NA+a1Ujx0c0dzxoRBqP2+1xTl3VBaJ/qoURq0M5kk9J/xW76FYn8BOBahXbNXc1NxjGNSCeI+U9IAC07Giec/vrm8G/Q7nyruho6JE5YOwwHRCMb3WO2halEWzZz/4zCwidxwdP4IHP5fCW8Q8G480WytQAOmUNXh6xt5O3Eyyrx4J70vL13NRB/YKJ0zCq6UylzE+GySdMCKlPfhi0epNU1RGL9iKlvi4uYW7vuD2xbJr1p0owj46YyeOyIAAXGdgJOLVxNGEzx9FSrqmgXIw647GNWoVrCgjyGHfkBTAY1H3KFcIAd4vrYx5LFA1Gb7yAQFWsn/QUHRQqn5Boez+LrhWOE8wHokGg9HCw2uNtjFSFpvtLfUucGxodseSeae+4dtCfAlaeXCbaNudJmNC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(39860400002)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(8936002)(478600001)(316002)(4326008)(6486002)(8676002)(6916009)(66946007)(66556008)(2616005)(83380400001)(54906003)(66476007)(6666004)(53546011)(6506007)(6512007)(26005)(33964004)(4001150100001)(235185007)(7416002)(2906002)(41300700001)(33656002)(5660300002)(36756003)(38100700002)(86362001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDVxVGZSQlVVT20zdndnWnZYQXVRSk02Ti9mSWhBMEpheUovcEJPMWx3THpt?=
 =?utf-8?B?YW1kTUhBaDNlUE14QlNpakpjNUxNK3RLTmQyTitkblNtcVJXUnZjYitPRmRL?=
 =?utf-8?B?UjBPRGR5RVFickpyaGtrdkhkTjBlcEJtNjBaOU80azNtdFBVcFozYmYyQllW?=
 =?utf-8?B?NWhYMFFaVHBmZ0dDaER2QUZseThISUFEUkgvT1lVbXNZaXFMaDJSNWI4RDFX?=
 =?utf-8?B?cmVrTmhpUU1EdWhtVS9zdGhvM1hWZVA3VmhVMWd5NWk0S1ZPOWkwRTNPdmF5?=
 =?utf-8?B?ZFBOamZCc0hyU3B3NXVvbXBXaGtEaStja09SZ2RIUUg5RWtjVnZqbWlUYit6?=
 =?utf-8?B?bmoraUhJcVBvWXNZNXYxbjk4aXZHOG54azQ5ei9Yb2RGODRISkpJSUw1TElz?=
 =?utf-8?B?ZVN0UzNEWExtemhiQUZqOUorWnE4NVIyYzZrRFJSNmVIM2JqNFRqQWhWbTlz?=
 =?utf-8?B?bHZ5aURhOHFFNVoxa2xWcEtWWlNDOHI0cGtBd3pyTWJhenNzOTloU04wK3Ri?=
 =?utf-8?B?ak9WZGFzaXVqcnBuUmdobi84YzNmVG1ZbkxHNU9DbHdPNjBVZUZCRzAyWWJ6?=
 =?utf-8?B?KzV0czZvYmdNNnJXTDd6VXF0bVRFRUJNN1RoYm5FTGJXSTM2OG9reGVkZmJL?=
 =?utf-8?B?RmRZNWgxYzYrVTZ1dWZScHMveVpZamVnT2tvWjlQWS9Ja1RZSTcrK1JRa1Y4?=
 =?utf-8?B?aWJjdjMyREFqS3kvM2tjbDR4YWRtVXFBbzRQRjkzcTVhVGtqc3hsWEg1ZFRn?=
 =?utf-8?B?UzdEKzREZFlFOGR6TTI4TE1zOTNab3g4Mi9OQnF6Ny9WSG5NYjc3Rnc0aG1y?=
 =?utf-8?B?Y1l1TVMwaFN3QTFxNVZsa3IrOEdtTzh2M1djU0pPd2FwdjlrRU82L3hNQ2Za?=
 =?utf-8?B?a3hZOVBkb0dtcGw0eHZ0V1VTbW4xNGx3clRQL25IZlN2ZmlxQXAza25CK3RT?=
 =?utf-8?B?R2dnaEU5eThCcW8vRWhEUk9tMFRuektTa1JCTlRKRWZCNjhLYmlwa3VDZHBE?=
 =?utf-8?B?VDBkT2F0cFo3WnRtR1BlRDU2dGhjTjRhemJBNUdRU0lyNmc4TG5KcGZXcVVS?=
 =?utf-8?B?d0xla29PY0krOGhkV3JUcFlPN2M0MTI2SWM3a2JxUENaNEt2TnBzbnFkNG9D?=
 =?utf-8?B?Ti9Ram95SlI3Q0pIa0IxZlEzcCtBSnpWYnkvNVF0UVBFRWFzSGNJem40OU91?=
 =?utf-8?B?RmlUdTR3dnVwU3NxT1JyMU1xZFlpVzUyamxBTTFYeGFWSUJPUHlIY05JODR3?=
 =?utf-8?B?L0JobG4vdnpway9PeHIzcytGWEJNVEdML3Z6ZEQvdWtTS0pySXNxRVRrSVhQ?=
 =?utf-8?B?Q1cvTWdEVkovcGhML1Nsc3pzY3dUY1JYY3p6dktCc25NL3JjbU8wVnNqMkZV?=
 =?utf-8?B?aUxwMlFwd2JDVlBxdkswbzZYb0ZQSmJSRFVxaGtHMmZjSEF4aEcrT1ZwTllF?=
 =?utf-8?B?bVRiSVhYVlh0c3JWR3VHU0lnSjBhMXFFbmdjdk5ObHlPSkdQb0VkdGdQMGlU?=
 =?utf-8?B?SFFHMTNDVTF3Sk4ybG5UYno1aCtHRjBsQW5xNTROTmlkMGVkQm51OEVnTUh5?=
 =?utf-8?B?L0Q3eHZseFgrMC82Znh6cmk2NVFEM2Q3bUxuTlBYWk00Z3c1cWptbW5BNzcv?=
 =?utf-8?B?RE5hcnd6cktBTFhUUUFRR3U1dzI4ckhBT1BYOUM4UWMvaG1IRnFQYVJZWmUz?=
 =?utf-8?B?U0xueXZQVXk1by9yS0ZDUS9yZjFBTGNJdmUrN212VU9iaFArSmUySXg1TDhO?=
 =?utf-8?B?WlRMa2h5YmFZQXlNQUVmZEMyWWZzR2tsdDNRV1ZIRkdFL2ZoRGZGOGVpWlY0?=
 =?utf-8?B?VXB5cHRzSGVtUGFhTHBSYjJycDMvTXd4RGhXS2QyYllGQlNlOHNFYXN6clI3?=
 =?utf-8?B?bHJWajN4QlJEc0R2bFBEd3FFWWNlZlhaOEREU2JYU1hsNE02TlB0cVhJS3dN?=
 =?utf-8?B?LzE1YUVFV1BWTTc3Q01lOUVrZ2M1cDVYRWxCeExLTWEvdTNldk5QSGJrV3dH?=
 =?utf-8?B?K3VKbk4rYXgvakNBSElyTmR2VVZibmpUbjN4Q0E5S2k4WTZUZDcxTWh6T253?=
 =?utf-8?B?QUNMbzdyU3N4THhLdG5pZCtXOWtLcTlPTVN4bDFlWTFaNzFMc3orTDZjM0VG?=
 =?utf-8?Q?6vfg95fw2npeMSpkXbps3BOr8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b77cdd25-8730-4870-0226-08dc0e41830d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 22:56:11.5655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMsNQJgnVEFp+6sInFrhcnYssqUL1n4V+QJeo6texstC4DCxnJgSczY9rPd8bZhP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8286

--=_MailMate_766B8054-C4BE-4A77-A7D0-9AE1EF0771F6_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 3 Jan 2024, at 10:51, Zi Yan wrote:

> On 3 Jan 2024, at 4:12, Ryan Roberts wrote:
>
>> On 02/01/2024 20:50, Zi Yan wrote:
>>> On 21 Nov 2023, at 12:11, Ryan Roberts wrote:
>>>
>>>> On 21/11/2023 16:45, Zi Yan wrote:
>>>>> On 21 Nov 2023, at 10:46, Ryan Roberts wrote:
>>>>>
>>>>>>>
>>>>>>> vm-scalability results
>>>>>>> =3D=3D=3D
>>>>>>>
>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>>>>>>   gcc-13/defconfig/debian/300s/qemu-vm/mmap-xread-seq-mt/vm-scala=
bility
>>>>>>>
>>>>>>> commit:
>>>>>>>   6.6.0-rc4-mm-everything-2023-10-21-02-40+
>>>>>>>   6.6.0-rc4-split-folio-in-compaction+
>>>>>>>   6.6.0-rc4-folio-migration-in-compaction+
>>>>>>>   6.6.0-rc4-folio-migration-free-page-split+
>>>>>>>   6.6.0-rc4-folio-migration-free-page-split-sort-src+
>>>>>>>
>>>>>>> 6.6.0-rc4-mm-eve 6.6.0-rc4-split-folio-in-co 6.6.0-rc4-folio-migr=
ation-i 6.6.0-rc4-folio-migration-f 6.6.0-rc4-folio-migration-f
>>>>>>> ---------------- --------------------------- --------------------=
------- --------------------------- ---------------------------
>>>>>>>          %stddev     %change         %stddev     %change         =
%stddev     %change         %stddev     %change         %stddev
>>>>>>>              \          |                \          |            =
    \          |                \          |                \
>>>>>>>   12896955            +2.7%   13249322            -4.0%   1238517=
5 =C2=B1  5%      +1.1%   13033951            -0.4%   12845698        vm-=
scalability.throughput
>>>>>>
>>>>>> Hi Zi,
>>>>>>
>>>>>> Are you able to add any commentary to these results as I'm struggl=
ing to
>>>>>> interpret them; Is a positive or negative change better (are they =
times or
>>>>>> rates?). What are the stddev values? The title suggests percent bu=
t the values
>>>>>> are huge - I'm trying to understand what the error bars look like =
- are the
>>>>>> swings real or noise?
>>>>>
>>>>> The metric is vm-scalability.throughput, so the larger the better. =
Some %stddev
>>>>> are not present since they are too small. For 6.6.0-rc4-folio-migra=
tion-in-compaction+,
>>>>> %stddev is greater than %change, so the change might be noise.
>>>>
>>>> Ahh got it - thanks!
>>>>
>>>>>
>>>>> Also, I talked to DavidH in last THP Cabal meeting about this. He s=
uggested that
>>>>> there are a lot of noise in vm-scalability like what I have here an=
d I should
>>>>> run more iterations and on bare metal. I am currently rerun them on=
 a baremetal
>>>>> and more iterations on the existing VM and report the results later=
=2E Please
>>>>> note that the runs really take some time.
>>>>
>>>> Ahh ok, I'll wait for the bare metal numbers and will disregard thes=
e for now.
>>>> Thanks!
>>>
>>> It seems that the unexpected big mmap-pread-seq-mt perf drop came fro=
m the mistake I
>>> made in patch 1. After fixing that, mmap-pread-seq-mt perf only drops=
 0.5%. The new
>>> results on top of 6.7.0-rc1-mm-everything-2023-11-15-00-17 are at the=
 end of the email.
>>
>> Good news! I don't see the results for mmap-pread-seq-mt below - perha=
ps you
>> forgot to include it?
>
> The stats below only shows significant changes and mmap-pread-seq-mt de=
lta is less
> than 5%, thus it is not shown.
>
>>
>>>
>>> I am preparing v2 and will send it out soon.
>>>
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>>   gcc-13/defconfig/debian/300s/qemu-vm/mmap-xread-seq-mt/vm-scalabili=
ty
>>>
>>> commit:
>>>   6.7.0-rc1-mm-everything-2023-11-15-00-17+
>>>   6.7.0-rc1-split-folio-in-compaction+
>>>   6.7.0-rc1-folio-migration-in-compaction+
>>>   6.7.0-rc1-folio-migration-free-page-split+
>>>   6.7.0-rc1-folio-migration-free-page-split-sort-src+
>>>
>>> 6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migratio=
n-i 6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
>>> ---------------- --------------------------- ------------------------=
--- --------------------------- ---------------------------
>>>          %stddev     %change         %stddev     %change         %std=
dev     %change         %stddev     %change         %stddev
>>>              \          |                \          |                =
\          |                \          |                \
>>>   13041962           +16.1%   15142976            +5.0%   13690666 =C2=
=B1  6%      +6.7%   13920441            +5.5%   13762582        vm-scala=
bility.throughput
>>
>> I'm still not sure I'm interpretting this correctly; is %change always=
 relative
>> to 6.7.0-rc1-mm-everything-2023-11-15-00-17 or is it relative to the p=
revious
>> commit?
>
> The former, always relative to 6.7.0-rc1-mm-everything-2023-11-15-00-17=
=2E
>
>>
>> If the former, then it looks like splitting the folios is actually fas=
ter than
>> migrating them whole?
>
> Yes, I will look into it when I am preparing the next version.
>

The reason seems to be that compaction ends early when migrating folios a=
s a whole.
It happens when a order-0 folio is migrated and there is no order-0 free =
page,
then migrate_pages() returns -ENOMEM making compact_zone() stop compactio=
n (for
higher order folios, they would be split). This should be fixed by enabli=
ng
free page split optimization, but the perf number does not say so. Let me=
 dig more.


--
Best Regards,
Yan, Zi

--=_MailMate_766B8054-C4BE-4A77-A7D0-9AE1EF0771F6_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmWYiQgPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUJ4AP/jA7Zggdqmy5eEmBbcncN8crMnivfT+A4LO7
3NfpIpZ7U9w+90LPGPD9BjPPHjna/5KrH7IrUC51Wb/s5FGP3+UhC3YZFyh8RL51
1doKJ/IKJ3At/vSagPbrGJKz5zIy+Fb/a3FRxUOGOOzyPstQ9W1qabg4ggcRsLer
B1RjiuaxXa/8PRH03ZbQ+vNtt8Es642kXexuAh1YjTAaJnaJh6rkOmNPg89lUU09
cZsEuu/bkvlukDRKrTXYWRzncEl2f9k62vnn6Gs8TSjLUKOih6M/42M3qYAlVYva
K3pZbXY4hWM19ki+oEVtxromBTxZaqFiO7MEyrcO8of/P8bwTojdFjwLObGs4s1K
GT/oohXVG7FaMkJCmoI5PEb4Y3TW7eKj5h6aXv9ectK4+zh3FIUi5xpfUP5S7uZ4
4sA7lxQMQvD4NFNGF66zjZMKxiuDfXjzFOIPKtLj/D7duUiPoAKl4PFNOCmhiXej
0OoafCvyEQXnQG7U2xrSKo703j6lWVx/iD4LCHgiWTimRjZb+G/Q06nsavlfiSN8
pkasjQnef0oA2n10dSEiQbPbPtCEcztbSrexlL2RsfWPGFwC8AbKf2cIHtlcJFP/
q58+akyG+i9+ex+/rK0b+i/pR0o9/7NIayXPfm1jEiCoymcdy+5j5RPpB8TDlKuD
i9rOeGyn
=Z9u6
-----END PGP SIGNATURE-----

--=_MailMate_766B8054-C4BE-4A77-A7D0-9AE1EF0771F6_=--

