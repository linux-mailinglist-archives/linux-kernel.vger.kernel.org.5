Return-Path: <linux-kernel+bounces-165570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0188B8E1E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14A01C21186
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2EE130488;
	Wed,  1 May 2024 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="VezXFfSH"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163F7502A9
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 16:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714580615; cv=fail; b=DjftZuq/AExgY7sAgSNLDGjr5gy4MZk5k/mimLQIiEk+4/+Iu0UT3WUQ6uJ2m2Yyqkn46hl28U8v3c3CM6VrSFJMcuecW0HX56FGIialXQhk3jq4lNRmLBADy9OcEAkHcJZaj1+9yOUqNR91KNHNatUl1SnqX/fEIZv6V23s8nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714580615; c=relaxed/simple;
	bh=ISIoHi24+h3cjjAkxZ6WhB21AozgMAm1aJ0axr/tQRQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mhNhtw/3XK2zNn7eOenpA/orbh7mx8wbuPf49ecm5Ho4nmbBgDBqbhkTDaieeiMY7iJzthjg4vgfCBIXqduqrXpNKaAW3h/3Rt2vVmQtnRjeH3miH2MeXqFAL2HRugZDE4II77aBTy4gDebrjExSIs0kBbnsjIpAEpS5CJhmIFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=VezXFfSH; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4415HUUl010308;
	Wed, 1 May 2024 09:22:17 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xtxqf603t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 May 2024 09:22:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCWgoIkr6CoH3JS7VdIr7dLFhtMnFq1YrCouWmVs9m1oplwfKStyAEmRXVnm41XDsTG7u1MtyWKf4G9gK+p7u/CqGub+4juy3iyzzNAzRpOzVbzfrOA88eBILWDbZ75KJRfAbSe0Pq86lF1OW0fZgEt/eSrLgX4l/D15MdjzxZOU4f0PfS71K/jp+1UpG2RUkQpyM3uNswXXYJpInCOTyl4H/xlrnbeIRoTCk+LEjwZhZXRHGCUNeQ19F/cAfXmYwZwO8j6CUrB9jj+PGxfLHsDAoCSYecxlf5jWD/bdtYCvetMDo04YgGlcbb4imO2Fdm/ZiCqLuT2baJLDKYcJAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uVr8U7MsAEQtQqxEOy9cwDl6KPLnKptW7/nPQdoNTk=;
 b=PR12kLVGzDZ02usYXY+RDzSu9OXt/CynXSCgjKbGPxCCPmOGaqIBWYx68sMofSikOtdyJhwUCv+Hqji7nOtyJbVPz0PAn08EH4pYKdylSxDbQxOOb4vjYM8wtHRS+vdgIiq2SHoyXo9YYFjxBpFmOHJsIrN9wEXQg8at+1B0mXgkkjHiwlNiwxig7FxZEha26gaUJbcQLFfqjk8bSQCpTbEvmgNXjGDeERVYRp4sD2m0Mfo8E8rPEoOvjjANH9ylfNWum+35aCrHfb3KZlKvJ5o5NvUeM76CFHbGGaEQXWiteCVZOpQkAQZEZox93MYUJsH2xZsSgQqo9gzZTTDpWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uVr8U7MsAEQtQqxEOy9cwDl6KPLnKptW7/nPQdoNTk=;
 b=VezXFfSHazmB+Fq32t/OnG+WEtDj5xjBoVnrvCqSNGc+92+/1L+f9g5EBIMFyDwOgk1qgWM9oQsClukKg6AmgVQ5nmG0RTvjmIF3LQ5G5GU0ofP4mCc+2EZ0K7sR4d41zL9lJGuarll25ASs4vd93MFDxjV+LGO0UFFsUQPyjjE=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by BY1PR18MB6041.namprd18.prod.outlook.com (2603:10b6:a03:4b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.37; Wed, 1 May
 2024 16:22:10 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905%5]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 16:22:10 +0000
Message-ID: <cb40c3e6-f678-45c7-b8e7-a6f337b51dfb@marvell.com>
Date: Wed, 1 May 2024 21:51:51 +0530
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
 <b87653fa-34e3-4124-a96f-f5d2b9730f10@marvell.com>
 <ZjEaA+YRPA+p9msM@e133380.arm.com>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <ZjEaA+YRPA+p9msM@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::17) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|BY1PR18MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 6399667d-140e-47fc-c954-08dc69fada49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?V2tYUUNzRkZQdzFTZkU4TytsQkpDeUU0SnRaYWs5dGVraGFORmxnK0FyQ1B4?=
 =?utf-8?B?K0xqQzZocjBiMnRTS0pkUE1ta2xUaWNleE0zUkJ6VVhZTVk4U2NPRy93ZlZu?=
 =?utf-8?B?UVphdjdVc0tGLzVMRUJRWnBJTlhPU1hIWjNQNHBIbUswUHRNbUFTZGlwV3dj?=
 =?utf-8?B?SURsVnZqNFgvcDlRZmhCWUh1bGVWZWd0MXJWN2hVWEc4ZlJmVUhkVFRBdzhZ?=
 =?utf-8?B?NFJvNVd4UlVoOFBTZHVLeHJSSFdFK3pmVmlhZTFKdFZyWnJ6OEpuaVlrZnln?=
 =?utf-8?B?dDBqUnRDZEJ2WE5ocjdvdjl3NVBIRUtndHhQZnN5TzFTcWxYcXhQdkhXbnBy?=
 =?utf-8?B?VVJKR2YzRm9VWExtaWg3WWNPcXNoUnNQSHMrb055TXZWUTJ6ZnViN0ZnSDZP?=
 =?utf-8?B?S3orSVFPZW5hbnFKTzVWVnVTa0wvdWtlM1h2czB6QTl1R3hubTZtRFJWZGpt?=
 =?utf-8?B?anl5eGZGaEI1L0hTZCtVNmRtaE9TeU9XQk5YTlZnYkhEYkpOVjNHdThEbjdH?=
 =?utf-8?B?V1U1L2dpUXlCOThUUFNUWXFPVGIyb0d3SWpTVlZpeWpHNXVUZ1lNWU5oWXJn?=
 =?utf-8?B?cnFOaU9leDlpT0FrNC9hbTBObHpJOFZQNERoMkxkcUlMbHh0MVRZWlFiYlR3?=
 =?utf-8?B?VHd3TmRJMm8ybjhETnN5UE5iQXN4RUdNbHJsNFJRZEcyaHI2cnlhcFpRUEZM?=
 =?utf-8?B?NkEvbHFGMTUrRTUranVpMWU0cXlZK3lQQnFvb0x2OGNaaXFsK3puUTBIb21V?=
 =?utf-8?B?Rmh6YXBBbnRXSEQxWWhMa0J3MytsRElQR2k5eXBBeG9HbE50Qys2eFk3YWhh?=
 =?utf-8?B?cEpIZ3Q1cjE0SDI2M01CL2lENVRBSlhXcDh0UTdLTFBCYzlKcUVtSDg3S2Z1?=
 =?utf-8?B?R0RWSHUxWmx1dUhUelNZTjQ4b25ZcDhsWWZaakN1eDZZVHVJRmpJTlFxTzlz?=
 =?utf-8?B?cS9BMEsweEFGZXJ4VUQrZkM4QlZDS0pPU3htZDNYV053dGJYempKWkJzVU1v?=
 =?utf-8?B?Skh2YzZhSmk3ajV1NUdzZ1gyQzE0OGZ0WkJLc0pzNG92QU5FcllTVlhPd2FI?=
 =?utf-8?B?ODlMcTA3UjJwd1hNS0s1YURvU2ExM1UrVGx4anlJTDRrbitaazNIQzE0N3hI?=
 =?utf-8?B?Q2plcDhKRXorU2tkN2ljNS9WUXY1akd6Y2E2b1pKVEd0VnhTTXZEblVMRkRV?=
 =?utf-8?B?MWNmWFp3bThtWFFtQW9jNit6MnJiTSt5Zi9uZHRHS1JRZjRJci8xcXZqVFMx?=
 =?utf-8?B?WEV5QlhrVjJhNDlOa3lkVG44Q1YwdGRPaTF2bHlaQUZwSjlsWkFydzJoazhQ?=
 =?utf-8?B?WFVzUGxOSUVJWEtvZEpZaVBGQkNsenNUNnNlZTR4N1NWYXpaaERoT0w1b3Vq?=
 =?utf-8?B?Q3J0WXlIL1ZsZzRtMTRmbDRuTFF2dDVmV1RJMW9pM3hDeUEvSE9oQXpwUS9C?=
 =?utf-8?B?R1YrRUJBSDlvVnE4NUVJNHVhdWl1TEZzVEZ2aGdRaDNaUy9hMmZQc2IxYWk3?=
 =?utf-8?B?NnZNUkw2Qk9yRC9MUDhtNVNJQ0t0c3VUOUtrY1N3MmZiQm52RW4yeVlJeGZJ?=
 =?utf-8?B?L01LcHIyUFo5c3hkZ3lnZEJlQ0EwY05jYWQ3L3h6WFBiMkpyVmVLbVI3eEpt?=
 =?utf-8?Q?24JuorC0DYw8PYQ1/AxWe2W6UNL7RpcIrlKPkf5ICfUU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QkFuaWE4Myt6N0s1d2s4emE1YkxzcVdsaitkN2x6cW1yWDRHQmxGcmxZTWZq?=
 =?utf-8?B?d25kSXBZYTdIV1R0UEtwTTlBM0x5TkNJclFJbURMVHhWWVEycFFUcDEwNk1R?=
 =?utf-8?B?cmU3dUF2MWtjdVJDYU5qTE8wMmhtOGJFcEpTTmUyM2V6dzFjZE5MLzVSaTdZ?=
 =?utf-8?B?cytMbkxkYlFZY1lveC9IMXltVC9EMjhTcTI3Z3B6NDdHY09aVWN6dlFEWkdI?=
 =?utf-8?B?Q213ZkpWMy9pdmlUMGk0L0srY1Nka1l6d0dHVlIzNXBRUFhKcXkwMDBydndu?=
 =?utf-8?B?R2RnVmJNTUlrTVBaSGFvWHRCQVZjckNTSkVZQS9VTzFBclh0TmcyV0FxKzBq?=
 =?utf-8?B?SExmYjl5cjFZMXNJOG40N0pDUlpJU2xTRVJjb0FvVFYwMGpjWUxXNW5KUTdR?=
 =?utf-8?B?bnpkT3pWWW4wbkx3a1kxRnM1LzN4amZPQTdldFhYZjdWZFFyaVB5R3ZvNzQy?=
 =?utf-8?B?UUlacUdhb29UN05TUWtBb0pXWEpOU2dvZERidThFK1N6MlFSdHMvbUFhVTAw?=
 =?utf-8?B?bnBlWGEvWVhpeWxvYm5maXdHWVovb00rbDU4bzBoRDdTb1RRWllEQTdzUm83?=
 =?utf-8?B?UWoveVRIbURxZ3JQRjdMMTM3dERJMDRqUzJ5bGF5ZTdDZ2VDRjFSVzBDSlhm?=
 =?utf-8?B?NlY5OC9CTFNESzlvU3l6b3dMK3RrZGQyR3ZMMHBuL05BOFB4ZndYZTliOXRj?=
 =?utf-8?B?bTlld2pvRnUxcmMyZ1pOR0o5MzZrTktGeEFBMzJXdXVkcDJsb0xRWFFUc3FV?=
 =?utf-8?B?aFJMbk54RjdsMGdLZGc5RlVSRjRnMEZJaFFpMFRXSHNZUG9wckI1TWJzVkZz?=
 =?utf-8?B?a0IwbzVtS1o5YkZDM2VUUExlUlpYREY4YUhSQkpOVVBpdG1iRlp0VzE3TnAz?=
 =?utf-8?B?ZjNNMFIyK0k4cmNWTk40V0FUK0JNNHRLU2dFT3JwTmtPNnJ6OURSdzdRWEg1?=
 =?utf-8?B?ejB0VWdxTzBNQy81NzFwa1Q4aGhVWktMWkE2aDVKZzRGTWtualB1ZzAwYlE2?=
 =?utf-8?B?MER6TDJGNnB1MUQyT0JhVGJjd0lPTnU3U0Zic252RnJkbGROU3J4c1hXa3ZL?=
 =?utf-8?B?alhPOGt2WHZlNkd3a0pjS0lxZ3ZmZWVJY0IwaVU3bStuWmY1dlJMR1NPMmM1?=
 =?utf-8?B?enV0L2xkaDFhSG8yb044YVVXWmtneDJzSEF3QmFyelMxb2c3ZVltR2hnTFJk?=
 =?utf-8?B?dlNPajMvSkRDb3V0dldLcEFGc0w3bGJ1dS80dXhwd0RZZ1JMWTdlQnRWOVRZ?=
 =?utf-8?B?N1BLbXB0NEgxQlJEdytzeUpsc0ljR09RakJzMjhtTkJqa1p3WW1Mc2J3eGdV?=
 =?utf-8?B?UkhsT2g1MXZVMGhDVkZHZXNJRUZjTjQzM25ORStPUDFoczlnU2hxOTBnUnFt?=
 =?utf-8?B?czY0NGhYT282WGFGUE9mRlVnOWdzNXB5WkcxOENsTFg4U3QrK2l6cHozVmhI?=
 =?utf-8?B?eS9lb2kxdVVpSDJJUFhOSVJieEcrdHFSK2RsaFFJYlFVcHBGcmZTZWl0eVU0?=
 =?utf-8?B?UzBjejBQVkhSYWk3YjhBQTFiNnJydW1GMVU0N3VvNWQxRW1sNFIxaVZyajdU?=
 =?utf-8?B?QzBpOC9nc3NYUUFLVmUxNldSMDlyamZMSTc5dFZodUZ1VXhmODZpY3Q2b3pL?=
 =?utf-8?B?MzIrZldSeEhZK3FzWkVjTytQeGtrQ1p4WEZoV3VKcFlXa1VFU1IwRXVlRlho?=
 =?utf-8?B?Sy9ieGpDaWo2SVFqQTFVNmlXcUdvVEVnRkRlWWdqLzQrYm5BL01wdG55ck1n?=
 =?utf-8?B?UTBHd2I2cUdENmx0c1VIbzViTGsxaURMZHgvSHlwT1VURXdHSitPb01vNXNY?=
 =?utf-8?B?MHMrNGFzUTd1c0dlRm1BOWVhbWJ2dUZSYVdPMlNONCthTFMybG1FK05tejRl?=
 =?utf-8?B?dDZUK0VxSDZYbTloRjRycHJ6REp2clhFTXRVTUttdXVMNWVFdTA4WkFxRksw?=
 =?utf-8?B?cGRSaTg1VzJQM0J4VVRQMFhYcmxBb1FLSWRNbnpacjNDNGtzendXbGEwUHJT?=
 =?utf-8?B?MjRPcXVZbHcydGdhZmVSeFd0MUphdEc5SlU5TEU0dnZBcktWa3FNK0FtbklB?=
 =?utf-8?B?NTJQTGhmSjBKV2QrR205aXBwOUQ1cDZRWEQ5Y29QbGIrdjBSZC9NdjdQVnNK?=
 =?utf-8?Q?mg6gCcsQGxauMjpiiZpMiEUpq?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6399667d-140e-47fc-c954-08dc69fada49
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 16:22:10.7929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: diy4yqZcjVFL/YaYfl27+JMHviLne4p3LvW0El2o6aOwSP2XfLIhgboFs49VkAs5rOyyFdLFiufE7XDA3EO4Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB6041
X-Proofpoint-GUID: 3H6zONeAO6ltHlWTteLpfSTU2zw8UnRq
X-Proofpoint-ORIG-GUID: 3H6zONeAO6ltHlWTteLpfSTU2zw8UnRq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02


>>> I think James will need to comment on this, but I think that yes, it
>>> is probably appropriate to require a reboot.  I think an MPAM error
>>> interrupt should only happen if the software did something wrong, so
>>> it's a bit like hitting a BUG(): we don't promise that everything works
>>> 100% properly until the system is restarted.  Misbehaviour should be
>>> contained to MPAM though.
>>>
>> if "resctrl" is nonfunctional in this state, then this comment[1] here does
>> *not* make sense.
>>
>> "restore any modified controls to their reset values."
> 
> Can you clarify what you mean here?

What I meant was, What's the rationale behind restoring the modified 
controls, if user is going to restart the system anyways (in order to 
use MPAM again), but later realized that it is needed so that *non* MPAM 
loads (user may still want to run other things even after MPAM error 
interrupt) would not have any adverse effect with modified controls.

Therefore, taking my statement back.

> 
> I think it makes sense to clean up the MPAM hardware as well as we can
> in these situations, even if we can't be certain what went wrong.
> 
> [final comments below]
> 
>> Thanks
>> -Amit
>>
>> [1]: https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_pub_scm_linux_kernel_git_morse_linux.git_tree_drivers_platform_mpam_mpam-5Fdevices.c-3Fh-3Dmpam_snapshot_v6.7-2Drc2-23n2228&d=DwIBAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=DzR4EYX-356bYvqcrD5mYQBzLmDppMaRaHx6yjN7nRE5GH7nogtw6VtDZchmqb_q&s=SKpVy4sPg3dbFJGfMfUGoo252IHOrHrLfcv5f0sCmm0&e=
>>
>> root@localhost:~# mount
>> tmpfs on /run/user/0 type tmpfs
>> (rw,nosuid,nodev,relatime,size=32923772k,nr_inodes=8230943,mode=700)
>> resctrl on /sys/fs/resctrl type resctrl (rw,relatime)
>>
>> root@localhost:~# devmem msc_addr 32 0x9999
>> [  687.096276] mpam: error irq from msc:1 'PARTID_SEL_Range', partid:39321,
>> pmg: 0, ris: 0
>>
>> root@localhost:~# mount
>> tmpfs on /run/user/0 type tmpfs
>> (rw,nosuid,nodev,relatime,size=32923772k,nr_inodes=8230943,mode=700)
>> resctrl on /sys/fs/resctrl type resctrl (rw,relatime)
>>
>> root@localhost:~# umount resctrl
>> umount: /sys/fs/resctrl: no mount point specified.
>>
>> root@localhost:~# mount
>> tmpfs on /run/user/0 type tmpfs
>> (rw,nosuid,nodev,relatime,size=32923772k,nr_inodes=8230943,mode=700)
>>
>> root@localhost:~# mount -t resctrl resctrl /test
>> mount: /test: unknown filesystem type 'resctrl'.
> 
> 
> Thanks for trying this out.
> 
> I guess the behaviour here might want a bit more thought.
> 
> I'm not too keen on us leaving a defective mount in the namespace,
> with a nonexistent mount pount.  I'm wondering whether things like
> systemd may get confused by this...
> 
> Cheers
> ---Dave


