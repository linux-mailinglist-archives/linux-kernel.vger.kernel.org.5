Return-Path: <linux-kernel+bounces-14809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3978222B6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9021F235AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8A616423;
	Tue,  2 Jan 2024 20:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VuVU3vtM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D458C16402
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 20:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQUnKuIsGCRo1zVRh+Ksvv06OnM9g83GG8Bv/9Q6ZZ3V7Xqa69ILI/bVfWVBdtrBB8eb1q6wPgT4Vh8iA7/JaT+avmjsqxvYUbKbJJMTmwLtyqvUjshw/wi6ctytUYyVpLNyRp3qgP9uvcV0m2Y2tte/xFAdiZ4zrsRtd9k3mSp0oc5ztr4FabdMqaPqG5QCz2pglj32Q8Ar7+ak5A97uCqckapIyAlUZ21jjSZxcOC+/Sk8PDovU+ksos1thXarxFfZfcu/nhyfxd5Qk8N3F32V8Kk64fmNX66UTgq9iJl7bGC0q9MdyLptR18dZpRsuhAEcvBzQdhLl97CAiZWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkpClYuf0xPvlVaABSHgTqAcaFIoBBQGLPhmBwyS2Ug=;
 b=ZL86RzruHDQeNj6rgDl2qO5gXB+OR33ybIseHMj74IfYOPQ/7YXYPDBRgTyX43A5ESuhWRnBO9UDOtNC4zMJPsSDX6sBVKb294hl/yx0CWsrxQQ1Sh9JSOuuZmt6sHfNNMaX/wV7gfeZR9M7cSds7mrPr0pccm5t2MXUhP8F6g8sKBBHUtrohQBoevaseWb4E9omDIuE3m7qm7lPKVIKaQCb6KWIzHhDa/IeGDbICkS9tS2lKq2x0YaMlp11j9ECgVuY/iQ+5jtoQGkWAtn0afWlCfA9+HIRKcriyn4wsY7NvMQztGDPbHL+KXwtk0532XyrXwFpcDFEYeZyKmtUHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkpClYuf0xPvlVaABSHgTqAcaFIoBBQGLPhmBwyS2Ug=;
 b=VuVU3vtMwJhN78h/a0/n1TxC7D+ELA78TihE3/WfRFo0XdKhdYs2SxNDLJDCL7WFhFIyd2esu9B2Ltj86qleZzGmtTee8Em1o2xgg9juGrV6kP8C/j6qpAgEDvANBNq1x03TX9F//1FZcFMSmHHl2UYejeKvx5yVp6przomI4ZiZNX8qm0uPNUfyGDyVJm3l0332A2hxov5s3Q6NqDzf8bzhGhT9ZQDR8xUc9c0/3xZ70V2KUnBO8yNKjMat+m9POJdGiKYdoKwqAdIluknDDfuDD8mB+gaE74T1ozPJnOWSf+z3iwvQXSgryH2RrxGMIwJKJETV4sjO5Fg4IHsNWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS7PR12MB6168.namprd12.prod.outlook.com (2603:10b6:8:97::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.25; Tue, 2 Jan 2024 20:50:12 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::99b6:1e06:1e8b:4324]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::99b6:1e06:1e8b:4324%5]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 20:50:11 +0000
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
Date: Tue, 02 Jan 2024 15:50:08 -0500
X-Mailer: MailMate (1.14r5994)
Message-ID: <E22D7AC8-0891-4B4D-BB90-129B1CB77CB2@nvidia.com>
In-Reply-To: <df51bbb7-f791-4747-9077-e9f7f37e9518@arm.com>
References: <20231113170157.280181-1-zi.yan@sent.com>
 <1e7cf758-ac0e-4eda-a8e2-90db5eed7f7a@arm.com>
 <7ED1378A-AC39-48A2-8A2A-E06C7858DCE1@nvidia.com>
 <df51bbb7-f791-4747-9077-e9f7f37e9518@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_17FCD383-1028-4C4A-AD67-A86D05071D13_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:208:160::48) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DS7PR12MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: 8884e85f-67c6-41d0-3397-08dc0bd469cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rXSurCdXLmCFH5/zi15KUVLVK+oiMGseboOo7PP+bLe5cAtiO6Br/e89mkMAB8FXDlWAmIsKpc8zhpHH62hnrbSt0R2tx2QblK+KSp33CpFuJZyq14XdqV/9OttpRsjKuwlI11aeLixO8BLtP1ncNtS6r3N/ZwOfpcCR9nk9e3EuQ/+12Crcw+QUPuqP0nwR+H+HlBFn8F+F28v2KNSo7GaUJ//sw4Wgm8O/Cd8UIv/nm8/rfF3hgtqxx3QTmcdTePMQwGuU+lfpIDlKOdQv2d+o8ueHJhzjqzo1VeDtHRKlwkRhaz2jT+MvYWB3q9r0SJk6OxqMLxQ4hqEg3C2N+iBok3hIPD0SG6cY5EPUuZyg+zW0+H9TPV/YuFoyhurFb2orNEmy0lxxok+FjQM0gofED4iD686C7Z0neFlNzIbKKhIVr2Kg0R/64pox0kflvhxCI9VFsSINNxBqVOSrEwGpro0fS4A+gfa+ZHzMtfGybPPgc4M6owx7yzfdrZXqx7h2NkGqkL2Chus3QHhvPEyQi0rSnkpX1mpK5Df98JUZGgGIYs8vuyj6BoSC/1NK86eZ36/6Tn6kVMKmjnQLN6rDJnPA48ax72aN4koQTVhw6UoBVc3zPWk1JV3295IS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6916009)(66476007)(6486002)(66946007)(66556008)(8936002)(2616005)(54906003)(8676002)(316002)(26005)(478600001)(53546011)(6512007)(6506007)(33964004)(6666004)(4326008)(7416002)(30864003)(5660300002)(4001150100001)(2906002)(41300700001)(235185007)(33656002)(36756003)(38100700002)(86362001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzluMmtPQ052SlU0RmRCNFJjVndwZkNacjNEVkpVL3AxU2Zka3JsbHdxdGds?=
 =?utf-8?B?UVEraWE4ZWkxNVFJa3FyWk5DaDZ2SFJtTUVTalJ5MHc4R1I4dXlVa3Vscjlu?=
 =?utf-8?B?cE11N3NxRVBoeTVYUDJqMmhHSElRNG9MNjdlOTZLMnhuaTBac1BYK2pXTksz?=
 =?utf-8?B?dDZHMi9lRnFvSjY2cFl6dFJoTitraFlrQUprL3BmZE40Uk01NjVDT0M5UzNr?=
 =?utf-8?B?RlcwTmVYemFKZEErQmF0b2swdDFTOHJVS2NGUnhOMENFaTdUQjUrMDdYeTJu?=
 =?utf-8?B?eEh3Rkx6dkQ2RjVqSkxWRC90eTRraVFVY256c0xzRWhTQ3VlRHFBVU5EYTlt?=
 =?utf-8?B?YVBvcVBXdFlONFdOUmNBQjczRStiRFBGL1JTVnZuZ1U4a3BKTkZremd3VmNp?=
 =?utf-8?B?TmM5RWNxeE4xK3BDQ0JaeE9RM3NXTEFISU1FK3NuTGI5ZVgzbUFRVHV2KzFq?=
 =?utf-8?B?R2M5R1BwVWNtTGk2REN5aFdhZm84TXRkYzJjVklCOVRGZUI2UEx6YkwyT3RU?=
 =?utf-8?B?OXFzMHBPdVVKNGNzTUVCWjQ3ZytYVWZ5VUQxN2dnaU9QSkxoTFQvSy9NNkdr?=
 =?utf-8?B?b1dvdURyVTdMWW91NWhFT2piYlVZNFZRa1JHdHNhU0hNSUt2eDIra1dabFVt?=
 =?utf-8?B?WWRxZC9HOFRTWlZKQzEzMWdKZmdFRTJRNjNDaFRTaU1lcWNGbDdSWEVjdUFV?=
 =?utf-8?B?RmhocW5kVUJQVldrZk9BYXRVZ0JwUjZJSjNuazlvaXFBUy9SV0Y2eEFOLzZT?=
 =?utf-8?B?Z1B5OFdXRHF6T1FwV0dQWTV5VFZmMjEvYURiVkVRcFViSmI4WUNXOWVKTGdl?=
 =?utf-8?B?a01YR1VqMHVBd0poWTZ2MllBelM1MkU2dTM3RUo1a2ZhT1MwcWp4OEMzcWlh?=
 =?utf-8?B?UVJHbFdiamM2SXd0SWt3enpKQUhwVG9yTzcvOVBSa0E4Rk9qaFJDOGJhTEp5?=
 =?utf-8?B?bytYZk5wU2pIcjVSRTZIMWR4WFJMV3JhTVFqZndKTFBqMUMxVG5WM1RnMVVz?=
 =?utf-8?B?YXlkV2Q1K0pDc0RET1h5MU5RcnU2U0VjS1hIWFFuQlhEK3RWWlc3NktWVFlv?=
 =?utf-8?B?Q2kwRVVmWTYxK0ptVU5lZWNvdnVudTdVYk5tWERXUlNDRk53cGYxUCtwVlRo?=
 =?utf-8?B?Q0w0b2E4djJLb0hiUldzckppWkNqdTNKcW1SVmgrWFQrTy9OWW9CQVZxYVF2?=
 =?utf-8?B?dlloL0hCdmxTT1VES1RjazdyMnRBVjR5V0tHdWp6NFVZeUpodXVVWVR0cnNl?=
 =?utf-8?B?NHY2Z1NtbzdqOFF1aUhuVVNuZHBOcnJlb1MrMVQvOElnUGI1czJaUngrWHQ4?=
 =?utf-8?B?ckVmZlE5bEg4Rmo1OUJQNDJwQnN5UmRiNWRwM0NST1RPMTBvekR5NEpiV1pO?=
 =?utf-8?B?RXlNTGZUODRiNCsvdERtRHBhWWk5RW1qeXI4VlJCVnE2S01vUEtkUEhmZ3Fr?=
 =?utf-8?B?ZHY3M1AwWTVVaEdHYW9PNTVGaS9yajdPVk52V1g2MTFZRmI0MUcrM21DU1Bv?=
 =?utf-8?B?V1lIdE42SEZQSlhsZFJIYVB2ZWpGMDNCMnB3Y0YxVThqQ1c0K0Z4RHJjU0Uz?=
 =?utf-8?B?VUw4VHBaNW9SV3R2bm5QVEZ5djdnbnJXZWdWZi9zR3RYQ04xcjJaekx0dUMy?=
 =?utf-8?B?dVloVTJ1YllnTEM2Nm9zZFBvN1Q5VXFTTi90RjlaSWh2UGp4cFJBMXNsSTQv?=
 =?utf-8?B?SHYzN0h1VUw5Q0duRUZUS3NJdjJGNWRPbUtteDJ1V3ZublArQXRhNFU3SWpK?=
 =?utf-8?B?N1JwY3cxRERGSHFXcTVVRVRCaDJDcjl3K3oyb0tJT2crL3pGUWhGZkxtUG5K?=
 =?utf-8?B?SGJUMzZKT2I2aDB0cUczZGwxMlJTYXRxY0FlNTBIQ1c3WDlUcXczaFZvWVhO?=
 =?utf-8?B?KzBGUG9KYzM3M3hHRlREekJoRStJNElLbEtQaWl1dHlrRDRMYzlKSGlLOXZX?=
 =?utf-8?B?bFBuTER6KzFpaUY5di9JVlZQWnNnSWpYa2NjdGlSQ0RCU3hKUENFczJUYWdX?=
 =?utf-8?B?OHZWVVhyN2lRazJBMXFBTWtUc1J1Sko5RTlsWEdpdElnWTdlOG1NMFpvVTVS?=
 =?utf-8?B?ZmlZdnFWZEl4WTEraktDOGg1Nyt0YW9sUWxEL01sMWNyV0o2MkJvR2p3NGFS?=
 =?utf-8?Q?fsf44TJm/uCdHaBvq9um4N8mW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8884e85f-67c6-41d0-3397-08dc0bd469cf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 20:50:11.7883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Y4cKVwD8TtA+g6sSbSosWqyxyuxmRMjpmVQCtQZO1jxtz/y2kRF8JZdKY6RvLDQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6168

--=_MailMate_17FCD383-1028-4C4A-AD67-A86D05071D13_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 21 Nov 2023, at 12:11, Ryan Roberts wrote:

> On 21/11/2023 16:45, Zi Yan wrote:
>> On 21 Nov 2023, at 10:46, Ryan Roberts wrote:
>>
>>>>
>>>> vm-scalability results
>>>> =3D=3D=3D
>>>>
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>>>   gcc-13/defconfig/debian/300s/qemu-vm/mmap-xread-seq-mt/vm-scalabil=
ity
>>>>
>>>> commit:
>>>>   6.6.0-rc4-mm-everything-2023-10-21-02-40+
>>>>   6.6.0-rc4-split-folio-in-compaction+
>>>>   6.6.0-rc4-folio-migration-in-compaction+
>>>>   6.6.0-rc4-folio-migration-free-page-split+
>>>>   6.6.0-rc4-folio-migration-free-page-split-sort-src+
>>>>
>>>> 6.6.0-rc4-mm-eve 6.6.0-rc4-split-folio-in-co 6.6.0-rc4-folio-migrati=
on-i 6.6.0-rc4-folio-migration-f 6.6.0-rc4-folio-migration-f
>>>> ---------------- --------------------------- -----------------------=
---- --------------------------- ---------------------------
>>>>          %stddev     %change         %stddev     %change         %st=
ddev     %change         %stddev     %change         %stddev
>>>>              \          |                \          |               =
 \          |                \          |                \
>>>>   12896955            +2.7%   13249322            -4.0%   12385175 =C2=
=B1  5%      +1.1%   13033951            -0.4%   12845698        vm-scala=
bility.throughput
>>>
>>> Hi Zi,
>>>
>>> Are you able to add any commentary to these results as I'm struggling=
 to
>>> interpret them; Is a positive or negative change better (are they tim=
es or
>>> rates?). What are the stddev values? The title suggests percent but t=
he values
>>> are huge - I'm trying to understand what the error bars look like - a=
re the
>>> swings real or noise?
>>
>> The metric is vm-scalability.throughput, so the larger the better. Som=
e %stddev
>> are not present since they are too small. For 6.6.0-rc4-folio-migratio=
n-in-compaction+,
>> %stddev is greater than %change, so the change might be noise.
>
> Ahh got it - thanks!
>
>>
>> Also, I talked to DavidH in last THP Cabal meeting about this. He sugg=
ested that
>> there are a lot of noise in vm-scalability like what I have here and I=
 should
>> run more iterations and on bare metal. I am currently rerun them on a =
baremetal
>> and more iterations on the existing VM and report the results later. P=
lease
>> note that the runs really take some time.
>
> Ahh ok, I'll wait for the bare metal numbers and will disregard these f=
or now.
> Thanks!

It seems that the unexpected big mmap-pread-seq-mt perf drop came from th=
e mistake I
made in patch 1. After fixing that, mmap-pread-seq-mt perf only drops 0.5=
%. The new
results on top of 6.7.0-rc1-mm-everything-2023-11-15-00-17 are at the end=
 of the email.

I am preparing v2 and will send it out soon.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/mmap-xread-seq-mt/vm-scalability

commit:
  6.7.0-rc1-mm-everything-2023-11-15-00-17+
  6.7.0-rc1-split-folio-in-compaction+
  6.7.0-rc1-folio-migration-in-compaction+
  6.7.0-rc1-folio-migration-free-page-split+
  6.7.0-rc1-folio-migration-free-page-split-sort-src+

6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migration-i =
6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
---------------- --------------------------- --------------------------- =
--------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev =
    %change         %stddev     %change         %stddev
             \          |                \          |                \   =
       |                \          |                \
  13041962           +16.1%   15142976            +5.0%   13690666 =C2=B1=
  6%      +6.7%   13920441            +5.5%   13762582        vm-scalabil=
ity.throughput

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/mmap-pread-seq/vm-scalability

commit:
  6.7.0-rc1-mm-everything-2023-11-15-00-17+
  6.7.0-rc1-split-folio-in-compaction+
  6.7.0-rc1-folio-migration-in-compaction+
  6.7.0-rc1-folio-migration-free-page-split+
  6.7.0-rc1-folio-migration-free-page-split-sort-src+

6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migration-i =
6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
---------------- --------------------------- --------------------------- =
--------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev =
    %change         %stddev     %change         %stddev
             \          |                \          |                \   =
       |                \          |                \
  14998168            -1.0%   14852803            -0.7%   14890569       =
     -0.3%   14946766            -0.4%   14943302        vm-scalability.t=
hroughput

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/lru-file-readtwice/vm-scalability

commit:
  6.7.0-rc1-mm-everything-2023-11-15-00-17+
  6.7.0-rc1-split-folio-in-compaction+
  6.7.0-rc1-folio-migration-in-compaction+
  6.7.0-rc1-folio-migration-free-page-split+
  6.7.0-rc1-folio-migration-free-page-split-sort-src+

6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migration-i =
6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
---------------- --------------------------- --------------------------- =
--------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev =
    %change         %stddev     %change         %stddev
             \          |                \          |                \   =
       |                \          |                \
   6750930 =C2=B1  7%     +41.5%    9549570 =C2=B1  2%     +31.6%    8883=
545 =C2=B1  2%     +33.1%    8982606 =C2=B1  2%     +30.7%    8821667 =C2=
=B1  3%  vm-scalability.throughput

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/lru-file-mmap-read/vm-scalability

commit:
  6.7.0-rc1-mm-everything-2023-11-15-00-17+
  6.7.0-rc1-split-folio-in-compaction+
  6.7.0-rc1-folio-migration-in-compaction+
  6.7.0-rc1-folio-migration-free-page-split+
  6.7.0-rc1-folio-migration-free-page-split-sort-src+

6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migration-i =
6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
---------------- --------------------------- --------------------------- =
--------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev =
    %change         %stddev     %change         %stddev
             \          |                \          |                \   =
       |                \          |                \
   5818610 =C2=B1 14%     +43.1%    8329118 =C2=B1  2%     +26.0%    7331=
427 =C2=B1  4%     +23.2%    7170418 =C2=B1  4%     +22.8%    7147458 =C2=
=B1  4%  vm-scalability.throughput

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/anon-r-rand/vm-scalability

commit:
  6.7.0-rc1-mm-everything-2023-11-15-00-17+
  6.7.0-rc1-split-folio-in-compaction+
  6.7.0-rc1-folio-migration-in-compaction+
  6.7.0-rc1-folio-migration-free-page-split+
  6.7.0-rc1-folio-migration-free-page-split-sort-src+

6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migration-i =
6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
---------------- --------------------------- --------------------------- =
--------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev =
    %change         %stddev     %change         %stddev
             \          |                \          |                \   =
       |                \          |                \
   1973808            -0.2%    1969617            -0.5%    1964376       =
     +0.3%    1979245            +1.0%    1993677        vm-scalability.t=
hroughput

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/512G/qemu-vm/anon-w-rand/vm-scalability

commit:
  6.7.0-rc1-mm-everything-2023-11-15-00-17+
  6.7.0-rc1-split-folio-in-compaction+
  6.7.0-rc1-folio-migration-in-compaction+
  6.7.0-rc1-folio-migration-free-page-split+
  6.7.0-rc1-folio-migration-free-page-split-sort-src+

6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migration-i =
6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
---------------- --------------------------- --------------------------- =
--------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev =
    %change         %stddev     %change         %stddev
             \          |                \          |                \   =
       |                \          |                \
    479486            +0.3%     481036            +0.0%     479580       =
     +2.3%     490310            +1.6%     487107        vm-scalability.t=
hroughput

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/512G/qemu-vm/anon-cow-rand/vm-scalability

commit:
  6.7.0-rc1-mm-everything-2023-11-15-00-17+
  6.7.0-rc1-split-folio-in-compaction+
  6.7.0-rc1-folio-migration-in-compaction+
  6.7.0-rc1-folio-migration-free-page-split+
  6.7.0-rc1-folio-migration-free-page-split-sort-src+

6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migration-i =
6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
---------------- --------------------------- --------------------------- =
--------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev =
    %change         %stddev     %change         %stddev
             \          |                \          |                \   =
       |                \          |                \
    453237            +1.2%     458580            +0.5%     455455       =
     +2.6%     464830            +2.6%     465211        vm-scalability.t=
hroughput

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/256G/qemu-vm/msync/vm-scalability

commit:
  6.7.0-rc1-mm-everything-2023-11-15-00-17+
  6.7.0-rc1-split-folio-in-compaction+
  6.7.0-rc1-folio-migration-in-compaction+
  6.7.0-rc1-folio-migration-free-page-split+
  6.7.0-rc1-folio-migration-free-page-split-sort-src+

6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migration-i =
6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
---------------- --------------------------- --------------------------- =
--------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev =
    %change         %stddev     %change         %stddev
             \          |                \          |                \   =
       |                \          |                \
   1074404 =C2=B1  5%     +78.7%    1920268           +78.7%    1920270  =
         +77.2%    1903612           +78.0%    1912223        vm-scalabil=
ity.throughput

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/256G/qemu-vm/msync-mt/vm-scalability

commit:
  6.7.0-rc1-mm-everything-2023-11-15-00-17+
  6.7.0-rc1-split-folio-in-compaction+
  6.7.0-rc1-folio-migration-in-compaction+
  6.7.0-rc1-folio-migration-free-page-split+
  6.7.0-rc1-folio-migration-free-page-split-sort-src+

6.7.0-rc1-mm-eve 6.7.0-rc1-split-folio-in-co 6.7.0-rc1-folio-migration-i =
6.7.0-rc1-folio-migration-f 6.7.0-rc1-folio-migration-f
---------------- --------------------------- --------------------------- =
--------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev =
    %change         %stddev     %change         %stddev
             \          |                \          |                \   =
       |                \          |                \
   2568988            +5.3%    2706227            +5.3%    2706214       =
     +6.3%    2729716            +5.3%    2704539        vm-scalability.t=
hroughput


--
Best Regards,
Yan, Zi

--=_MailMate_17FCD383-1028-4C4A-AD67-A86D05071D13_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmWUdwEPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUtcgP/iyV2JijfXdsRR8scovlox8yBYVhszETirF5
rB/XIWFw++/YzmTFFp7bS2hL5IqJB0eSF9e7Lmdmryj5w07WDlc4USgznxO4YdPc
CD5I7wa2z2SiqKGOlbP2oJJ17c56poxAhbJuruLdOQ2gPDmhc+6u7zdBpRYCflzc
J4jTDuYtBF96tp0cRsca8MEjEKIosrz4OSRzLHqnILl2JWLqxy6E0EaMnDK4dTS7
HNuMqVuo0T0L8bK+1nf05XZUX81+x8LxMgee3u2XmL13QtamYLbhmtRZOGSBdw2u
60a32enUjYLpTGz29P4ptkv2/KKD+iHSQ2Z4cYI2ktBIn3M31hpG0wDFxB/SvAeB
sftjB9MAxOJsR3nq7KG23xXDV9AmBUHErMWCg1TMkglUGvgSvauUW/eBWyQyexNh
z6sA0tO3hddXI78AB3SfvABjOH7fHz6E93j1wze/DncpCraHljrgtiQAutkIn+Qg
hZJ6JlCjDlRXKQ8z0mtkWuIZdvr5FtKOuEP3Au5TekfhaIjfGkpMor/95pai/8Xm
LY8M/eCpDt3M1KWproUPdyZP3CNUjZhhCIEGkxS3munYs3TRrlqNJ8w4uk+aynwN
H7GpdnyB6UwkAr2ABpGGjVuLb2T/WFsTMoxjSWm+sO6dPvcdIMLRr21t4IhUu7Tq
qKmcnK+6
=3x7k
-----END PGP SIGNATURE-----

--=_MailMate_17FCD383-1028-4C4A-AD67-A86D05071D13_=--

