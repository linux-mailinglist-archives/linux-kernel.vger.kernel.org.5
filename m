Return-Path: <linux-kernel+bounces-163455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CF48B6B31
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B23FB21AE9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED56736AEF;
	Tue, 30 Apr 2024 07:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="p4+OPv0R"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C9D1C291
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714461263; cv=fail; b=eCrecuHKrwsmzDKhrsC6TAp7SrW+vdk2S74wT4NNunnnzsZa7KISLnLB+pIkiATUErsbNBQJPWykj5vm+s5iLvP1IymyeVVGCQkb0dyRty7g7GNS4iIGUh3iJ0lNBESNLRrUjwgoeH7DFDZWJl5vuEvYXlRipQ5D2sZEXsSBgDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714461263; c=relaxed/simple;
	bh=2CWJLgM0hJskxhwQ794lp13Oud/SnxroiR8y2b0SelU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EBOuuhmmBmXFuEvHuKHGTta5nOaO9PJNa7EpfbDkVc/HNtE4l7iJWgrfkuKe3oQ7azjCWMCcOx6i2NnaQcHe3kYJVo7iQ0dJPVW4cau4xajB1xHb86DB5IT0CQA4RCFYQV189y9quP+jiyVdFg9iCHSqYoVGxtTru/tY1+no3PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=p4+OPv0R; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U5oJVj005626;
	Tue, 30 Apr 2024 00:13:21 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xt43b13me-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 00:13:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrSdThIWSbmDMFBlwsuwb809yl719wcJUD8pPk9ACzAsqumpKvFh4K2d5E+066LRYmomj8EV/Js0SOf4cau7Am8Vf+30fby3xmvjhkMA8vKDT54zQA6U/uNqX1pKlsGt47mS4k5bliowC60lFwuZA3v2i5Z39jdlwsiUhmSOjHVkhdSAhs827Xlx7i7L1rdj8mlpPc4iscwg3nYqAN3iF5ZCWFMxBSiVpt5UDnNNDQWId66LP+ANQWq1bEFdUUgTbem9ne1Ubuj5hx9jRf+5adpInblC2YmNkq8iczgI5d1Tr0sMOgjLE+WFN4uLPbHKk5T2s9UDByjSdIxNHv3qKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5X/WKY+Q5wX1SzzQjyuh0Y1p5yD5TCZcPmPLkM0lVkU=;
 b=LxDrpgMX0aIxYe4lQldbxSEU4rKqkw5ebptja5F3FBk4D1jrloZBKqDNph8MDap0lRwSare/GT/pAURQmvrIynDSWIIr2KMhwWOcv/53NZRF9WgYJdBK3BdHFFDW/aPwrVb3EivUSBrmKXY+IoYhQfOmS62q1dXtk7EjFiHd8AH7nvJbcf/FNuT7jjUikrIWjv8GvmcVewUVhd2kBb96R8S8E0oJiMkazYeq9L7uU/y4V+VvAb6fy9dqR5UexgvvFwArt9wWV+l0F/U6DyILWYvDi1NEM2ZdV0q5wqi3OSd5tqG3dt5okReMxhZ0Vbxc7OgBcpU+vamOtMqqbvpUWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5X/WKY+Q5wX1SzzQjyuh0Y1p5yD5TCZcPmPLkM0lVkU=;
 b=p4+OPv0Rw7BLgHHBqHAEsY9MaNOavctc2M7vtd9/1C4u7tEqOemEjizkIyA+Wfq6nuxt05Bdtiv5F4cCv7JPx1ZoD4fxcdBZhOKfzgHpZuH4oX89gJcRTbPP2gkF+dlKAZGwL1YZVUfBTsziN59AR6j+NWmR+a9uQ1AnawiU490=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by CO1PR18MB4668.namprd18.prod.outlook.com (2603:10b6:303:e7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 07:13:17 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905%5]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 07:13:17 +0000
Message-ID: <b87653fa-34e3-4124-a96f-f5d2b9730f10@marvell.com>
Date: Tue, 30 Apr 2024 12:43:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 28/31] x86/resctrl: Drop __init/__exit on assorted
 symbols
To: Dave Martin <Dave.Martin@arm.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, David Hildenbrand <david@redhat.com>,
        Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-29-james.morse@arm.com>
 <c27c7813-5744-4363-bb7b-f9fbe80fd549@intel.com>
 <ZhfzF8L6w1pgJJ1r@e133380.arm.com>
 <47af4fef-35d3-4d88-9afa-42c1a99fbe07@marvell.com>
 <ZhlfQKMg4xeA53SD@e133380.arm.com>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <ZhlfQKMg4xeA53SD@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0165.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::9) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|CO1PR18MB4668:EE_
X-MS-Office365-Filtering-Correlation-Id: abb10117-7edb-487f-39f1-08dc68e501f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MGRITWQ5RGllcE5heEczTHh2ckVSb3dMZXMvM1k4ZGNJd3EwQkdzRysvVitz?=
 =?utf-8?B?M3gvQUNkaExtVWJPQXVvdXNnMEFjOWV5L29rRHlHZlVpRjF6eVhWamlrZFVR?=
 =?utf-8?B?RUVUZlhubDBVMUlSRDRVdURMTXFSc0xYNU1tZ2JYcjdheE9YOVVGOW5YZXht?=
 =?utf-8?B?YWlZdk5PeCtEeHExRnoyK0pLaDdXUXlnRk40TVVaZGFIK2xxQzc3MVJYL3Iz?=
 =?utf-8?B?U0x4VkY3WjhqNUl4S3hmQWZzbUREUmNDMXVDdFdHMnpDM3dac0pwRFZuajlh?=
 =?utf-8?B?Q1NHUGVwT20yUG5neHdlSFladUI5bHlwWXNZcHlKbmRiSTQweDFDcGtDYlZX?=
 =?utf-8?B?VmFEYW5yOTVLTG9sZExINkhuc3E0YXg0WE03d1BhRm9uUjlWNVU5MW5YV1o5?=
 =?utf-8?B?Z1pYdTNXUU85T1Q5VUJIeXpIeEdwSlVSOTJRRzJ6aWxqQlFERUxpTGhkb09w?=
 =?utf-8?B?UW44eEdPREMyeVhuZFR3SEVMZDdiNGdNa3NIVnkxalZRNmptcmc5VWVtdzNZ?=
 =?utf-8?B?aEpiK0JldmVlTnZ6d2c4NS9nRUlnMldlYjgrNWQ4eXJwcCtVWGw2Vzd1UklK?=
 =?utf-8?B?VC9YS1I4MUIzZGJPeHNxZWQzcU1obFdGZEJqNkVyRW10amFpS1lMM3JTeFNU?=
 =?utf-8?B?VWZ4cjlQaHA1L0J1cGQ5ZUZtUjJWaXZCM1pQcmcwS0JEbTVDVVREWkxCMkNq?=
 =?utf-8?B?blY0Q2dpQXBHUlJ4cjBhQ1J4RmZ3SmZOZUEzclRlcE1IWVFRcFlBekZFVEo1?=
 =?utf-8?B?QXhFdHFVU0NoaVh3QS9ib29QSExVSnN5Z2F6S0FZTSs2VWFKcGY5UXBRQ0J3?=
 =?utf-8?B?Zm54OWNaYTlHSEwrNGptTzBZblVvcUFQeUZjQ2RpWWIvYm5oVzc4emJuUlZL?=
 =?utf-8?B?TGxnM3pEUS93OHVmelk0VWZFekJXMFhyWkdDR3V3bXEwSjc1SFdIN3NRNkor?=
 =?utf-8?B?L28zQjlVU0praWcwUXJzNFNQV2RKR0ZvZWNnVXgxWGEyMVdYamFHNUkrTVgy?=
 =?utf-8?B?OUwxNjNMKzVha0R1TnpTOE5kZDgyMEc2YXF1SmpCd0pvN0JJL3pNaWl5SVVN?=
 =?utf-8?B?emRmU1d0dUZmcW5hc3hzVzdFKzVpZHoyWnI1bjhTVnE5N05NUVFzaDhGaU1J?=
 =?utf-8?B?ZVdjSXY4VzFUWG5EUzNaRGJaNktRbGoxQTJwVWpTcHAyQTRRWXFMS0ozVHVB?=
 =?utf-8?B?WlhKdUU1ZU9jUjVSaEYzUkI4VEVVcTJBSDBVU0RmTzRYVWlWRGVldnRDQzA3?=
 =?utf-8?B?Z0pkQTN0UEVTYysvTlVvL2J0dVV3NGVzNVVZZmkrNHRNUlRYV1h0b1VtR1Ey?=
 =?utf-8?B?UjUxRm5zU2QraWZqMUc3SU5BUzd1by9Xa1FZVStsQ1c3UCtuY0YrWVlqd1pQ?=
 =?utf-8?B?QlI3a3FONjRFTWovd3p2UUJjYmVyTnJhL2V1WHMxU1ZkdStscllOMEd2K3M3?=
 =?utf-8?B?UEp5NXhzeUxmWWo4MVNjVm9SdjZXZC9JUTZvM2YzZGtLeldhdUJBZ3VmbzI0?=
 =?utf-8?B?a1ZvMm4yWVZmUktBNThrL2FEdEJLVktNRHgwdUZ2Q2xaVjVuN3VCTVFhdmlD?=
 =?utf-8?B?Z1d4T1JqbTJjV0N2VVZ6anZjOXk1Rk5yNjRnZVFvYzNYL2EranYzNVZWLytR?=
 =?utf-8?Q?v74dHQojKrdnnb+45A+UK/Ne+hkUY5Ws56FMTmRaFrs4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QStNTFZrOGQ0KzYvUW5xbndqTExtRWpld3c0OGZiYzRkOU01S0NmMDJEUW4x?=
 =?utf-8?B?RXRJanF4aDRhaE0vKytJRWZnVmQzb0YxeEFXckRqaCtld29kVkdjTk0vbUpw?=
 =?utf-8?B?aktMWjMwcm44eDZkNVJIaWIxQnBPU1BLaE1ZZkErRHdWYTNRajZIbVJHeC9k?=
 =?utf-8?B?VjF3cXU0a2Y5eGZZSnZlMkE2NENXbGpGZlFqc0kydTgzTi9mYktjQXg2ZG14?=
 =?utf-8?B?T3pTNzBNZkdROVJRd2Z0cTVKMndIdUd3VFVMeDM1c1FPRWJxRXVDZU1lOXRa?=
 =?utf-8?B?VWJuM2g1L2JCOFVYZUR5R0hqYW1yMVpaVTBMNU5VVXdnL2t6d0ZkSzg1eFI4?=
 =?utf-8?B?b3JPWG5sNXdYVmI5ZVNnSkd3WWorbkVNQWdOWDJVTmh5TkZvelVnRFJxdFdt?=
 =?utf-8?B?ZGQzR3dUQVR6V0ptTUZIQzhiSHhDYTdadzJUM1pueUR1SlFiNll0Si9jaGJ1?=
 =?utf-8?B?ZEdiMXgzZDJpa01RZXllSWorYldYcGJkcEh3ZE92ZEF5WGttYlh3RFdMcGtG?=
 =?utf-8?B?Zk1qcTc5N0hrVTBTaTRaS3g1ZmJLWnkxTTJLb2JNNU9xYVZJSHpMYTFxSU9h?=
 =?utf-8?B?U3QwSFNEV1kvTG13NjQ5VjdRYXh1bStmNk9qd0ZZZVFIUGRONDcwN3JKNkow?=
 =?utf-8?B?dDdIR1pGaXoyY2RsMmRzQW1EbHdCckM1d09nQlZPamJ2SXV6WG1HUjNRWmp1?=
 =?utf-8?B?bnNnUjZsVGdaRjZ4TzhQaC8vamRFVXltelh1Rmp4Vlk3MWlVRVM2aXl5OVl3?=
 =?utf-8?B?NkNsWkVZTlNzMlo2Z3ZYblhJd1NPQ0xTaE1WZlNrMVJwSzVRc2YyV2Q4enlW?=
 =?utf-8?B?SkVyQmNoNDNaNkRwb1VnTWVwOUFIckMwcnhRcGNHMkpwUzloYXlVS1hhYUJl?=
 =?utf-8?B?UVBVcjJyT3VtUnU4Ym8xMnV4WGR3ZnlFcXNSeTZZN1lYc0JpMDB6WnBmMkZr?=
 =?utf-8?B?cmMyUVQzcEdNVWtBSHVHWWFWdUJweWgrd1NPUWFaTWd2T2hRb1lBL29oWXYy?=
 =?utf-8?B?UXZ6VDNnekF6elVkMEpkWGd4SlMya0djT1ZlUm9SaXZlb1lDbndPd25kZTds?=
 =?utf-8?B?L1JuQ3EwQ1ZqdnZyZFAzb29CcTdTV3J3Nkc1RVhkREpzNUY2VndKVzFubjNh?=
 =?utf-8?B?N3RBNmROa3hSamNyVE50U1ZuY3RnaWlQczFscllPemwrb214VUEwcnptaUEy?=
 =?utf-8?B?OFlVclNOVHdGWEJQL05SbU1vOGNrdk55UDBqRDhYNG1PQk4zMnNhZGtNUVNJ?=
 =?utf-8?B?dkV2UW9QL3NhRjRhcEEzM0JoOXF0emtPV3RBaHI5bnpNNFlZMlJ6MkRzZWhL?=
 =?utf-8?B?OGVjM0w2MHRUOCtUZmczZGtHNUZQSkxPS09iZ0JUK1hXTlpLZFhQOUt2MkJl?=
 =?utf-8?B?MS9lNE1OeG1mVi9UV1BxZjBSNlo4MzhSYU4yUTlxNDRaSTNYUkZIbkRZVzY3?=
 =?utf-8?B?YnYxVWRzYTNsYkQ2RGhDVStFSnM4Zkswa0s5OWRDMXJ5ckkzbE8xY3VUQUpU?=
 =?utf-8?B?UGJKeHZBSlppT2RGVG92TldlZmNaM2hmL0NjUEduanI3d21pVkdZZ0p2VzJO?=
 =?utf-8?B?ekQ4dXVWYUJJQUZjK2NVVS9kTElqMlNxbUQrNGNiSkRySHdQQzhUT1R1WTdv?=
 =?utf-8?B?UTBqOWcrN2FnWWcwMWFVRzYyVzBIYnZTRklVM1AzM2RSL3FFUVRqQ3hEeXAx?=
 =?utf-8?B?cDNWUjk1WXRQWEl6ZU5UQVdyNlJFdzRsTlZ0TVc3bFliSUJCU1Y0ZjNwWFhH?=
 =?utf-8?B?WmVySENiQ0pBd3RLS1JRYVdmSURGZUFBQThHUHZzNHh3NXBQVVMvTnBreUtr?=
 =?utf-8?B?TVpWaXBPVHRneWQvOGpiVDI5WWMzcEJ5VVQ2RmFXNWdXR0xwcUs4VG9neXhy?=
 =?utf-8?B?REQvZGdWSnA1U1Q5Y0xLNWtDNzVUclBNUmFYalVIS0E4N3NKUlBiOHlnNVRG?=
 =?utf-8?B?RWVwVk1vUTdZZkNBUU9KakRzMm9KQ2FGMG5rZklRRWI0enhGK3ZyamVncldx?=
 =?utf-8?B?SXZDMERvWW42R2J4UzhCNjBqSFJkTVUxYmhVR2ozL3FacHlrbWswZGJ1VlJG?=
 =?utf-8?B?T1VheFNWUE50N2MycGR5RXdjTDRqYVhhQ2FWRjRtN1BGUEhqUkNIeWtyU05l?=
 =?utf-8?Q?0hY1w3vKdIaJCuGJslZZRNxOS?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb10117-7edb-487f-39f1-08dc68e501f4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 07:13:17.2938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eftPlTUJuUY02Ej6TT+RBpgdxRRdroYU9clpC4HNLO/oA+/0G9aQgDoDgR65DL5kqz7hj9mGaKyMoS33hNxUgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4668
X-Proofpoint-ORIG-GUID: hc_wp0TMjWEdZua-Mle_VwMcUqzkJMSR
X-Proofpoint-GUID: hc_wp0TMjWEdZua-Mle_VwMcUqzkJMSR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_03,2024-04-29_01,2023-05-22_02

Hi Dave,

> Is it possible to unmount resctrl once the system is in this state?
No, it can't be unmounted, as there is no mount exist.

>> # mount -t resctrl resctrl /sys/fs/resctrl
>> mount: /sys/fs/resctrl: mount point does not exist.
> 
> What if you now try to mount resctrl somewhere else, e.g.:
> 
> # mount -t resctrl resctrl /mnt
root@localhost:~# mount -t resctrl resctrl /test
mount: /test: unknown filesystem type 'resctrl'.

> 
> I'm guessing this _should_ fail if you weren't able to unmount resctrl,
> since resctrl seems to forbid multiple mount instances.
> 
> I'm not sure what the best behaviour is here.  Leaving resctrl "half-
> mounted" might be a good thing: at this point the system is in a semi-
> bad state we want to make sure it can't be remounted.  Unregistering the
> resctrl filesystem from the fs core feels cleaner if feasible though.
> 
> Leaving an impossible unmount operation for init to do during reboot/
> shutdown feels unfortunate.
> 
> We might have to look at what other filesystems do in this area.
> 
> The mount machinery does provide other ways of getting into broken,
> impossible situations from userspace, so this doesn't feel like an
> entirely new problem.
> 
>>
>> Additionally, a question regarding this, Is a complete system restart
>> necessary to regain the mount?
>>
>> Thanks
>> -Amit
> 
> I think James will need to comment on this, but I think that yes, it
> is probably appropriate to require a reboot.  I think an MPAM error
> interrupt should only happen if the software did something wrong, so
> it's a bit like hitting a BUG(): we don't promise that everything works
> 100% properly until the system is restarted.  Misbehaviour should be
> contained to MPAM though.
> 
if "resctrl" is nonfunctional in this state, then this comment[1] here 
does *not* make sense.

"restore any modified controls to their reset values."

Thanks
-Amit

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/tree/drivers/platform/mpam/mpam_devices.c?h=mpam/snapshot/v6.7-rc2#n2228

root@localhost:~# mount
tmpfs on /run/user/0 type tmpfs 
(rw,nosuid,nodev,relatime,size=32923772k,nr_inodes=8230943,mode=700)
resctrl on /sys/fs/resctrl type resctrl (rw,relatime)

root@localhost:~# devmem msc_addr 32 0x9999
[  687.096276] mpam: error irq from msc:1 'PARTID_SEL_Range', 
partid:39321, pmg: 0, ris: 0

root@localhost:~# mount
tmpfs on /run/user/0 type tmpfs 
(rw,nosuid,nodev,relatime,size=32923772k,nr_inodes=8230943,mode=700)
resctrl on /sys/fs/resctrl type resctrl (rw,relatime)

root@localhost:~# umount resctrl
umount: /sys/fs/resctrl: no mount point specified.

root@localhost:~# mount
tmpfs on /run/user/0 type tmpfs 
(rw,nosuid,nodev,relatime,size=32923772k,nr_inodes=8230943,mode=700)

root@localhost:~# mount -t resctrl resctrl /test
mount: /test: unknown filesystem type 'resctrl'.



