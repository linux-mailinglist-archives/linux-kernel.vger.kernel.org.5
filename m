Return-Path: <linux-kernel+bounces-59194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E06F84F2F3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33809286EC3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3292167E8E;
	Fri,  9 Feb 2024 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z7SieVY5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R/UmnQCa"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38C3664C1;
	Fri,  9 Feb 2024 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707473468; cv=fail; b=A1wtzkBIO8SQBrWPr7YHSAqVDzs/wNDpXXEgpw21pBXhy/uB2Vy2Sh0X3qmH8RB7UAnazY7Z5QV9BQFJiwU59/J60PbNzZvu2ilKbdM6WVgFBBMqExamJKsU0uPHY+43/sfHSAA6xfqVWwHWwT6E265WqGogUiJrNhZsyiI0WYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707473468; c=relaxed/simple;
	bh=konkPlR/MWuei6FKZDATJ0qAQV8XytLvtTrL+msko5U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dN+QtPgavshVa3H90Vfx3ziB4oUeWJcqKE1tU4iPOsmVNMPI2usy9oZhovNuxjgXE53+J4tPW6rkUsknvLRlz7vYKBJkE2s91D/F/mz5+bW7r59dWK//vKl6CCH6hEeQMnGwkpDQ1DbvoZ1jHD3/N+yQ952QxeoOfN/xFpIqkr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z7SieVY5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R/UmnQCa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4194xFLD013647;
	Fri, 9 Feb 2024 10:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=DuQXTfmAubTgpMJWF4n7gkagxBSowZ96X7DltS46MrQ=;
 b=Z7SieVY5DQUrRC2gNYYacKjpoVhQls7QhgtFV6KlPTyikbFnsxQQ1XdYxoye8dc5Jv36
 1zeiSeb+QbfR3gBo1TDoEiyMFG8xIKEcykO3qd0Zntkpmc2VVs7wJjXMXjlebUEpMGX6
 9kxkUvhuQ5vu5EknOBZBOrLkyECTyMKzwjSBpaXA3jZrbBRsf7P0T3rgkYjSrz8Z5EpZ
 YbXX8vNjAu3lg7jhcQvxBg8WJC7hWGMVF2qwfLbvrH9XdZgS8EvwoeDB0eHYyBWInLXy
 2xFp+S7vUyh/RID5VOk1Pa+KLE6DdcYe6WL7GAeSWDQBi+I5A4+DMQV6XczYr9zqNN1S 6g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1cdd73ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 10:10:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4198WOkX038386;
	Fri, 9 Feb 2024 10:10:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxbrygx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 10:10:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8FIMY3WCQaujhMwhJbFA+U10Te0/iyoQ4b76ZWuwDZJ/MC9vRLNhm1s1uGegitvmzc4J4IEG9Q494q16Wj994WKil1WJzybHFZO/WqYT2q/HfQxos3BWM45CDIyJcyB/cSijcnccFN6fUZIvPwYmTE07K/2zcnTKWfkj4cFhQU1/4ln5zMgU0Qadgpi4eqMoxE6RauHXUPgq6jO5WzTAJXk1Iu1TNP5BuH1XRtYSsr/qRJ3e+7Vtw0WZY4bFKeAe+7jQofq6WedPWPjlIRACAhK0mRl7c6stLCVTmKP08hOgq5cPdgOfpUG+HzEK2G/dcgJNHADll1rIWBekbWR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuQXTfmAubTgpMJWF4n7gkagxBSowZ96X7DltS46MrQ=;
 b=Hru12Kj7QRygh+j9tyoH/BZIF8aiLPOzt0b+KYkvyf7Cyyo1wkJ5yePieVWvUjZ5bE8SgkGQQLEFzv4YT8cpVLgJJsL0YSHphXgEmM5YioCiWjTjw/eDiYMOHVbvEgbn3s4iFywmHGF8+SwWLTEOzhl1ztdJfV913VM/ns91TL0FCYWmrvQiUbZGJung8xmL1DS7fze2CL+0bhtB0SGIPVhjxIomeZv6bpuAm7Ntsym+Nlb1Y3O8RwxyC69M/o1000UjXSsfHjklh3X6sjwNE4pdUGuY4Z1WCwu1Yi/+BfZvRYbD9k1vUGs10kfJ27LNggwPsgsWsrMXbkea5OrmKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuQXTfmAubTgpMJWF4n7gkagxBSowZ96X7DltS46MrQ=;
 b=R/UmnQCa0v4CP46DNuL+QZun5Q1hZb/psEqMpPuc4Wj6L0A7oQe0moMZwL6j236gpVEl8otMxHdF8bPyec67c9n9m7w2BTd6QeReqHJmJOJAMOKT8epUWuRoYbSp5aCNy0bgLxSG+mtmWGlahnoxzuLGV+C8u2cd1R74w4RjmgQ=
Received: from DM8PR10MB5430.namprd10.prod.outlook.com (2603:10b6:8:24::10) by
 DM3PR10MB7912.namprd10.prod.outlook.com (2603:10b6:0:43::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.38; Fri, 9 Feb 2024 10:10:47 +0000
Received: from DM8PR10MB5430.namprd10.prod.outlook.com
 ([fe80::7df1:74a:ce20:152b]) by DM8PR10MB5430.namprd10.prod.outlook.com
 ([fe80::7df1:74a:ce20:152b%7]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 10:10:47 +0000
Message-ID: <b456d5a0-1e3f-43f8-bb1e-1221c0b2a6cd@oracle.com>
Date: Fri, 9 Feb 2024 11:10:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Makefile: Fix make cleandocs by deleting generated
 .rst files
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Thorsten Blum <thorsten.blum@toblux.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240208145001.61769-1-thorsten.blum@toblux.com>
 <87a5oafu1z.fsf@meer.lwn.net> <ZcXypIwlSZnH/kTf@gmail.com>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <ZcXypIwlSZnH/kTf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:3:18::30) To DM8PR10MB5430.namprd10.prod.outlook.com
 (2603:10b6:8:24::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5430:EE_|DM3PR10MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: fe0b080d-75f5-4abe-16ed-08dc2957624b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jIroqBQ0P8k/qC4Z7fo/CaWl7EOJLUfyYkvZUIQu+5lzfJM5tuJl1LtQosfhny1iSTwHJrAAVvXEH5J+x/8okkjW1KTf1gFTv4Lxwckst1fq2D4Z+8NnKzLysgT2jYflp5GoboG1BTO56MKwkaHnl8VpQOJWvkt48Mpvv5eh56ZaXJ8OHs1KsziNIE0VdMFAmMElKfaf4OMWF/iPydYGkOQA9va5r8TXQua1wRQZZhSfihLusu23E0RIjQNEIQDtS3820LIVtmi0Xwy+4UuF/Dk/4TvWacX+FHjBwKQ5aJsbHLZXDwei4IAu/7ng0UgRgvjfNaIfwBZQweVdKXVXxFbSSS5c3t214cKb76NfEeVfto3fm/MzfBLKkFt0q1c2FaCmMxY9n6B29Rs0euZRcxeTvNXauQLkRvzr3IA10p2eis9ofREZJ8S+vrVM2Xt+vfkxWXwaWJQ9zZwvUSue5dAjzCjKqdkbDea//95iNjk6R+rdrBx06CFmzGHlcv3m1P0qyjULygrIlctAJ4MgoQCL9BGDuO5vOnHjI6BxOg2YrAc2ObwjIzs4Q+Cs9yCM
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5430.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6512007)(6486002)(478600001)(31686004)(41300700001)(2906002)(5660300002)(44832011)(8676002)(8936002)(4326008)(110136005)(6506007)(53546011)(6666004)(66946007)(66556008)(316002)(66476007)(83380400001)(2616005)(31696002)(86362001)(26005)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SkhzQXhFcE1Ib1loeTd0d1lTQVZ3VStqdk5JUFYzQmNmbUJtVlBaOVVMYlhO?=
 =?utf-8?B?dVBGYlJBNTNOa1c5aDcvNUZmeDhRSG1qTXlZMzJLa2FlaGZYcGVHWDhnUUNs?=
 =?utf-8?B?WHVSK3pjdEl2Mm9xZDkySG1QM1AzWGFaUmdzcjZpUHFTellqVlY3bGg0c01n?=
 =?utf-8?B?aXY3dmdadGVTZEcwMmVCaC9XZ2UySjJYSC9pRzRhZFRlbU9zekkreklKM1lt?=
 =?utf-8?B?SzRtek55cDR3SEVLdy9xaHRac2VCL3luRU9tR291NDlwZGlOaThRUUtndUM0?=
 =?utf-8?B?LzFMNm1WUktINWp6dHFOVnZ1N09KblRvTk1MV2hNSGxoNkd0ekVIOVVPbEEz?=
 =?utf-8?B?SnZCTXhyVGl0VE5UNWUrbVJJaWxJY0RYNk14dVpEbDNBU1FxWHc0WS9BamFI?=
 =?utf-8?B?ZndYaG92MThVamZwT3BDUnZNbVlRYk5UVTJlZHVqbWJqN3ZkNmZBbmlqQkFK?=
 =?utf-8?B?MGhWWDB6OWcvNXdyZHFHUkpZUktTRjFVekdGR21EbTFiekV0SW5PTUJHS2dq?=
 =?utf-8?B?b3kwRjRDR0tlZXRCWFFHV2EyNVJwTUNkQ25CL1J6MUwwb2J5NC9ncllQTjY0?=
 =?utf-8?B?K2V6Z0g4cmlDUThKVWNLd1I5YnhCZ09DbmxrZnJldUZpYVcvRHF4WnNpWXRm?=
 =?utf-8?B?bU4vWHJDQmRrMkUvd2YrWDkzdlFscXAxdVMrRzhWL3FPdXBmd2kxZnpUcERx?=
 =?utf-8?B?QjI5bnBNSG5KUDZQT0J1YnMrMHpJd01Bb0xHeGNaU0MzdEJOM3kva1NkcTlm?=
 =?utf-8?B?TE5wU0RuUkc1QU5zajBIU01LWEpzcHpMMUUxTHhJWEwvR3BVQzJIWDBWeUlq?=
 =?utf-8?B?cEZqQlNxNUx6RUdDVXcvRHJNMFRzTXRRcVNYOGRXMG5GWmJTZC9oTW5XdkFN?=
 =?utf-8?B?U3ExNGNZZmsrY01OQ0lTNkFEc3hMUnVxNm1DaTF5RlhQN280bzZSMit2L01N?=
 =?utf-8?B?YkhmSmNZUlhRN3RCeFBoSVgybkVNRzNvSWpyZ3Z3NVZpbjNiNFdiK2VGZ1BI?=
 =?utf-8?B?ejRLTGlXbm9MRS9jVEJlWk9USkswVEpNSVVXaTg1QmtrNDRYeEZKaUVIUDJQ?=
 =?utf-8?B?em1yMEZ1YlYwNHl2TUlPSTVjc2tma25BcVhFcjBsRHFLVWVwK3NTQWhYTkUy?=
 =?utf-8?B?Z2c3ZzZuYzRIL0FLd3F1S1p6YWpKMzRIdWJRNUY2WWphN2lxSkZMczZtenJY?=
 =?utf-8?B?eFVpR1YrR1pwS1cwZUN6OFQwYjYwankwc0pLR0FJZHljVENxWWs4KzR3aGlu?=
 =?utf-8?B?NjB5VmdvVVQwVWMwWmMzY3lwU1RvSVI3bzF5MXdsU3NkTjdNNGVsdllmZFVC?=
 =?utf-8?B?NUdZMmUyQUdvdTJ2ZE55bUpUZGZQdVNYdDluTSt6SkE3N0lCVGhZRjU0eUk1?=
 =?utf-8?B?bHFoa0FXUG5XK0xUcWJUUTlYeVM0b09BdmduY2FUV09qM2F5SUlieVRCY1gy?=
 =?utf-8?B?THVqSnJwTFNtZUFyeDFtZms0K3Q1UmhnWTdFVDBROEtpNUNzTzc4K3hHdEtz?=
 =?utf-8?B?YTM3TkErUVJtbnZVRmNtT1p4NEVrWVB0ZnJ2R2dIckwxU3lHUTdPbWY2TGFR?=
 =?utf-8?B?cEFCVW9LeTk3a1VWekRwZUpVdnhNT0l2TUhJVFFBK0Fic25lUzVRbFdBNTJH?=
 =?utf-8?B?TUJKditkL0F3US9lYlQ5VDN0RFRYZ0prZ2lreVh3a1gzSkJBS0hiVlBRSWQy?=
 =?utf-8?B?WStTYnNmWXZqSzdGTC9Ja1VkMjFWblIzL01MRmhSdDR5SFoxNEdldUFzUkVQ?=
 =?utf-8?B?eHovQ1E2Z3VFZUhhb0Y1a3RQVjZCT0lYZy9NRVlvU0NNdVdsb3UyRHhRYkgr?=
 =?utf-8?B?RXAxbHNYWFdiZHhzTkIzR003eFEzWkxIRlFJWFEyMlBoQTlXblFTeWVPUjZG?=
 =?utf-8?B?VjNpZVN2dHUzTSt4cEZRSzliTG9ZRFViOExXc2d2ZTNqZUxCdUlIL0NhNWEz?=
 =?utf-8?B?NXJtVm5VTkYrWG5MbmIzYUkrVHdSL0FmemJocFdWTkxVaFVFQkg0NXFWdWtJ?=
 =?utf-8?B?K1VzdUhlZmtWdHlGRU4wLzQzRmJEVEZOMTUxcXplcXdKZVQybm9Xd3lDMTUz?=
 =?utf-8?B?dzY4RUJpVlV3MUo3ajBaU0MrZnNqYURvOUZFUGlIVGFyVm9KZUdXZkRaUmE4?=
 =?utf-8?B?bVpZZGROSGlxSEhLeHFmeWdHSWRta25SUVJCdjVEcXdCYVg0NVRtRzhqK1Bs?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VjnoL7pe4sN4Uh1RoFIdw4PGrUzhKlhZ4RHWh3js0IirDfWz1NwXEa27Yw9lxw5NhTAquB6uW7wNXnA0OsJsVua6L3RpYx3W1rXDvIzres9B1SIbDIqp/L918le/lUTdB3CUyijc9vG+lEFr+kDjnHFbltUFJikzcCkHUjyTFS5Mvmu8phNAw8iflTlJDDZhLpY83NuehP9fcNbNZnxoxH9eRusEChn1v6J4chl+tWv56zPvp1AJ2MKZGkcdS8IvUfRsc9aMrnaxRxY15EjhExDYTxGIyneySN36SlY2kBqGS54mr+nM1zLjq2IdYLF8ZCSGW1tkaRSJL7McmnmvIgjiR1iCfPJdEo/8yYtMCXrwO84zBU580Ub/FboWtesOA3yanSDI48xUuO83BDxEAphB+px4ZiXxmZBYQl66OpyajOp++r648SQiHgyV/W5ZCCjRyS7zZt6eHoSmTkrZPxnCyIxS0wQwlbcl1Uub7ue9BaGyZOWuabGGJJYZ+KdbNfQHxBVD+IpCNAf5Qirl+cjMn98jVt8jS4LYSWW1V6GOcYfoL2Yua88ifdrqlEfMix3GEVEXGGJCzv8gJvGEVtlI7dKKebj/q88KRS1X4K8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0b080d-75f5-4abe-16ed-08dc2957624b
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5430.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 10:10:47.0632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFp+4EFDvzRodVzwL78xr/KQy6r7Bxy1fqhqZeN/AwVyjZv17HLtH5SUDI4A4WjbpM+BHt8cS+hj4enXVus4WE9sOpLhxonN05fTyP+B0Yg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7912
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_07,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402090073
X-Proofpoint-GUID: dV9zqHI6OQ2yf6kJeefpgOAyFhET_KTN
X-Proofpoint-ORIG-GUID: dV9zqHI6OQ2yf6kJeefpgOAyFhET_KTN


On 09/02/2024 10:38, Breno Leitao wrote:
> On Thu, Feb 08, 2024 at 03:52:08PM -0700, Jonathan Corbet wrote:
>> Thorsten Blum <thorsten.blum@toblux.com> writes:
>>
>>> The script tools/net/ynl/ynl-gen-rst.py (YNL_TOOL) generates several .rst
>>> files (YNL_INDEX, YNL_RST_FILES) in Documentation/networking/netlink_spec
>>> (YNL_RST_DIR) which are not deleted by make cleandocs.
>>>
>>> Fix make cleandocs by deleting the generated .rst files.
>>>
>>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>>> ---
>>>   Documentation/Makefile | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>>> index 3885bbe260eb..4479910166fc 100644
>>> --- a/Documentation/Makefile
>>> +++ b/Documentation/Makefile
>>> @@ -176,6 +176,7 @@ refcheckdocs:
>>>   	$(Q)cd $(srctree);scripts/documentation-file-ref-check
>>>   
>>>   cleandocs:
>>> +	$(Q)rm -f $(YNL_INDEX) $(YNL_RST_FILES)
> 
> I haven't check but I _think_ that just deleting $(YNL_INDEX) is enough
> here, since $(YNL_INDEX) depends on $(YNL_RST_FILES).

I think removing all of them is the right thing to do.

>>>   	$(Q)rm -rf $(BUILDDIR)
>>>   	$(Q)$(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=Documentation/userspace-api/media clean
>>
>> So this seems worth doing ... except that there has been talk about not
>> depositing those files into the source tree in the first place.  Adding
>> Vegard and Breno to see if they have any thoughts on the matter...
> 
> Agree. This is definitely worth doing.

Agree too.

I'll have a look into putting those files in the build directory, this
patch shouldn't affect that.

Reviewed-by: Vegard Nossum <vegard.nossum@oracle.com>


Vegard

