Return-Path: <linux-kernel+bounces-58613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC23D84E8DD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9849DB2EABC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F8D37163;
	Thu,  8 Feb 2024 19:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oF4UKT41";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w22Pa9h/"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2ED37147
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707420119; cv=fail; b=j9WUjIgjehCjfjoLhaYooegwtzgvp/SeR8MokZEvFl15yu611NAG67dg0I/Pzkw7hybu/DT8eoha+Sx1iRV3bLKGOITpOcqiwt7B/Hn7bKyKgEvOTW02hhhG5o7nqacsmc7CAG3JNLonJ3gKIazmpsQ6eBpSvYN6wV2VaeEIL80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707420119; c=relaxed/simple;
	bh=5VXbqfSFRtZW4e6XGiWEe9wJfnaPeO/XFyWFBi6KpOA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F/A8i3a2IXSm5EpF1Kv3qx+hCdVRqBVQijZEf6kzEx9hYw7S/pQPUS4FOUgdK1LV1w0s9doICHfggd3pxM2rhkWDMhp1evkmEz3wcTLcHMYZI2wW99xnIGkchJmw4UAK2ACNfhOH3zvz9j4BH5jOnACFjLepfGIE2DEjlXL+Alo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oF4UKT41; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w22Pa9h/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418Ix8Uf025949;
	Thu, 8 Feb 2024 19:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=VE/foFVqB49BoPz7eAfsBg/xS1MWS8j9W/5WI9MQIGQ=;
 b=oF4UKT414B9SZDY7mJGOHbkTeKQsmS8vrISWzLyD2ZAs1yH9PJfEfde0d6LoAlaQDo6N
 FAYKuIqh+WZJ+bN2wruiGmj0nVl28U/xq634WFWMEQYwFAayCXPyPCM0ZVwelxazRnis
 UQiZZx/c4FmROPQAdNL1yWhFhma0FGnBP4c4zGH0QoNcsfXroAdopHp6vC3gZEv4zQdz
 rxDVHH5tDtMriLlNLcbvXY8WigjNMQZJl0TlwNIncPoaxmCBZXerdFy30YNnSSmKwAOk
 bWME2Cai966y35i8aaFL4gLzMi13HxTC86nfmAxwS7kk4j5XMXdhqPant+5GWO8N6kHg cw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1d3unmyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 19:21:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 418IHk0T038373;
	Thu, 8 Feb 2024 19:21:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxb4ejr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 19:21:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cY+rVy/eha1Becjv239pA8rs70on3OV6f+FGsX98wtYhn+352dbyGiYccdtcBr2gyAco2+rM4/Z/91T8NumPl2hqlkWCO3y/bMoc+DokLHNn8a69ihhQoD4yOedB3rDV3ABXAFLZ1FWVWQ6o3tWAzyMCpQNRXX4lc8OpZ8mL++zben5/mAYC/oY8I5SL0GHUsSufJ4a42ViOBtCZK3v8mopqR8E/Iwuq6/U+HUtytMdVy0aS+pLHCa8MV4hDZWt1tMbVwc7/C/MbCNlUTvI0F7DnLwK/HGnJM1swdy++pvuk/YOtpdafkvK2n96lWoTmfK3FacpGzFIIG00l1AzYfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VE/foFVqB49BoPz7eAfsBg/xS1MWS8j9W/5WI9MQIGQ=;
 b=BdKwvxOiBSrtyV169AVFth6v42yaAVFAnJJ4TSxXgUrypa0yOtltIlYxVcnNjdPotAqUQewAvQG+EB8IOpaiQ8yPEBxI57hR9B8T17yU0ZI0C2Crbnyd7/W8PY0+mtct0aR0vBAfPskNaYnCl7emtKyBELUWddj/tBWHHXIRqQBIfk556q26G2G1o9Qvfy+Hb2nTC2BMzScDbcGAEmWv3dHVvuvYW9AYuJv0qAWEl55kH5oG3IrI7JlSGF5z7mrwHnfllbKPnvTy/pi6oPQbo2eGqxMjghDYlh2GvdTd0mUhVD8x/1bR7EAPMIsrNF52CDme3MURmHvhA9mES+fVvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VE/foFVqB49BoPz7eAfsBg/xS1MWS8j9W/5WI9MQIGQ=;
 b=w22Pa9h/TQX9E67/Q/4V8qP6fkZUH3ptynrhuCUHQy2SQAqp3GMnnhgEZR/axK3mQSRAi2prl/LvvAkrhZ6xClrRha/QTuNvwyNyo3TneDMrw9XSdms2k72P06c119OsLlQU4KscHAsI5J7ytXUv9Cr3OrAaJex0EJp6HOF0P4I=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ1PR10MB5953.namprd10.prod.outlook.com (2603:10b6:a03:48c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Thu, 8 Feb
 2024 19:21:28 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::210e:eea7:3142:6088]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::210e:eea7:3142:6088%5]) with mapi id 15.20.7249.038; Thu, 8 Feb 2024
 19:21:28 +0000
Message-ID: <78eee4ef-99ed-46a3-a776-a74bcd83ba44@oracle.com>
Date: Thu, 8 Feb 2024 11:21:19 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: Will Deacon <will@kernel.org>, Nanyong Sun <sunnanyong@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>, muchun.song@linux.dev,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com> <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
 <20240207111252.GA22167@willie-the-truck>
 <ZcNnrdlb3fe0kGHK@casper.infradead.org>
 <20240207121125.GA22234@willie-the-truck>
 <ZcOQ-0pzA16AEbct@casper.infradead.org>
 <908066c7-b749-4f95-b006-ce9b5bd1a909@oracle.com>
 <ZcT4DH7VE1XLBvVc@casper.infradead.org>
From: Jane Chu <jane.chu@oracle.com>
In-Reply-To: <ZcT4DH7VE1XLBvVc@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0215.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::22) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|SJ1PR10MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: 825f48ef-7d5e-4540-4a3a-08dc28db2638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xyjJPF8X4yYUlEK/n327AXxSQJjL+F4dKxsHrXK0pUQW04exg5K+MBFC0Hi+yL1qWkajBgc/FPB8e3lOuqqebPQcdimN5p7m2hh51+8uu8yRjG0s9sbPiLnlX3/5DcECOPn5kc1xobNk1VS1VN9quoqy8VhIRhmUYA0VnUH8fI6ldQVdDIrn3ZiTK9CZWY3AxpmyJNZGrCcwiPsWUtWF7nf0AbJ1SZ/Z5R1Re9r6Iwkuxpob6ivmL9OIngWwZTHdVTyNZYOVZ9P29YQDeLx8dCn1bqcloWdflzBIAJk5AeBvQOhGuECRrAAUVYHaoLLPaavd6NT2s+Snlmn7GIzAgDt2x5Setx8wEqpt6APh38oW0jFLCmO2U5mptFdtrmW8xf4a+nZkUwFt3fBMxzN5OOkCk/DNAII9bwwB+QVX+L733MSdUw1ZTbodJIqE9vQkkHPte7IW7xpTfJWO5ZJIWdM7PIYfGA8GJB1SOEMQq7xQbKSavjRiuMxMNhSVzlN73YGepApSmKis5YCjTelee9GFTOlwXYprPoC2gwBYaa2pbtv1mDsy5kJUkV+S3kwC
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(396003)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(31686004)(6666004)(316002)(5660300002)(2906002)(44832011)(7416002)(66476007)(8676002)(4326008)(66946007)(6916009)(66556008)(8936002)(38100700002)(83380400001)(54906003)(6512007)(6506007)(6486002)(53546011)(2616005)(36756003)(41300700001)(478600001)(26005)(86362001)(31696002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Nzc2Slg0MDFsRXRmYnB5NU54M1hiTk1YQUZtZSttb3g0cjA5VmxWb0pqaDhi?=
 =?utf-8?B?a2IzNlM3U2RMZmN2MjU2M2lYV2tPQndsMFpLSzBOU3hSL1R2dGU4dk5CT2xY?=
 =?utf-8?B?NlpxbVlhRTFvUU9EZEt4b2xCSmJmV054TkRxYU91Z0dWUkR1NTh3Tk4relhC?=
 =?utf-8?B?MzNpaWJ2ZVhvdnd1UkczZmpYQmIySkc3ZUgzVTZNVmFIaWw5ZGpXUUJSZ1VD?=
 =?utf-8?B?cUZMWWRMNzVHZWlaUEZ6L0ZVbTFCV0RqTjEwRU9WWGxpQ2w0bkZldUZnWFZz?=
 =?utf-8?B?MW00MzJWb1RMbXVUSThVYWc0cHBkaUhqTkVWQmliUUxrWHFTQzFacVJJQjJZ?=
 =?utf-8?B?b1lIWE5PMGh5SVRqRVFwR0NPcnJsWmUxczFwUldWSDNXVVYxV2tBYXJkaXhk?=
 =?utf-8?B?dDZzSEtJSStFK2xOcXdmeGtYSmZ5cWpGNEwwK1R6NzZDdjdVNzBwRnNVOGVv?=
 =?utf-8?B?MWxaa05xMkxvTFA1cUtrQzBMWDlNeE45bGVHdVBjS3JjaHpNLyt6QmlrL1dw?=
 =?utf-8?B?aklsVFVOWW1BenY3SWhwQjA2TkR1R3ltaE8vVTZsYmZ5TlUxOGJhalBCTy8y?=
 =?utf-8?B?TTRYemppOTk0MThscnVLOEFOckhIWDgrZUl1WVAyYlUvTC9sTlFNQktwYmty?=
 =?utf-8?B?SkRsa1NONE4yV1JSRk8xNWhrUythWnQ3SjVWYTZDRy9nOWo1eUIvc2ZIa0NU?=
 =?utf-8?B?Q1lDSThoQzN2dzhsbDR4alg1L1NvYnNqaFhNV1ZIS0ZoZ1E0TjhsN3hXZjNG?=
 =?utf-8?B?Q29qZGMrNlZ4T3Q3ckxoQlhnalh2K1dSQjZGVUJLQmVISFNTbjdSVWMwWldk?=
 =?utf-8?B?bndpSWRaUHF2SDJYeDZMR3p4ZzVCeVpLZlBLU1VudVpHbXJHUEcrdzlmeDNR?=
 =?utf-8?B?bVducTh2SlU3WENzaUFPZDduMWFwd053VmZMeXdNRXZxb3ppb2tiSXBxQUVs?=
 =?utf-8?B?QnpxRVArcktDNFJKK09GZGhrWUVGVXMvcmNkSWlMWThoOUp5c1FqbW02Z2hz?=
 =?utf-8?B?OUJ0b0UyZVQ5ZVhQamJLQm1aTzk3d1kzU2N6S2VzSXpkWldOdWZNeXZNVzdz?=
 =?utf-8?B?SkVDSzlhY2JxWUcrNXE0d2orWExZQXdSWC9rU3FUR05RYTBzZDdCdDByOW91?=
 =?utf-8?B?ZklNWnlIQjE1b0p4UWlyTURSUi9LZTZ4NzhIeXhua3REYzNTSVkxYkNHa0Vt?=
 =?utf-8?B?bHNzaVZUNUk4OFMzQjJPeUJQakVOK2VSK2p3cDgxdlJKUmlIZUxGaWxjRTBW?=
 =?utf-8?B?WHFLQmZleEcvRTdvSHV0Vm51OVdKRXdOMWZHcG8vV1I3cTlxMDdZRU0vQ3Ni?=
 =?utf-8?B?QmxTMDd3Z0k4aEQ4b0hTOFphOWNnRnlpUTIyYkovOTRTdGxxSURKaUM3UnB1?=
 =?utf-8?B?UElWREkyK1huWm9GVVFkU3Z3TEg1TG10MmllZGRqVUdqcG5ldHZXUnc2TzFm?=
 =?utf-8?B?S2FDc1ZpYUhtdnM1cnMxM094YVAwNzdxelA3TEN0RGpkUlE1aE5ZUWtBYkVx?=
 =?utf-8?B?b0srZDlhdDh4TmVsU0l3eit0UzhLNUpQaDg5Mjg4SkdtUVVEUTRhNFhDcDB4?=
 =?utf-8?B?Z3lFMjhiYTQ3T0RRRTQyMDNScEgwRjlyVEVjdDdGeXQ1dlQ1QVN2c1ora2pr?=
 =?utf-8?B?YjJCL1l3Q0xmSXhqZmJid2dKS3BVb01sVlZYZmVYVCtvWVRLbVdsQ1hFdVA3?=
 =?utf-8?B?ZzVPcHk1cjRLM0dTY200bmVTNEp1STh4VUYrQktyUk5nWDVLV0w2QXRiZkU0?=
 =?utf-8?B?QTJvU3RUVmVvT2xzYmhaOUxkeVRrZnIwOGlLUisxRWc1Q3RFbkYxRDY5dGNh?=
 =?utf-8?B?djhQU1hmLzRzUTBZWGl6dy9JMFlnUFk4QjdoMkN6Z0dIazVTbnNNSWgrRTdB?=
 =?utf-8?B?TWpkQTlMS0Q1dG5sWXBPamRXYVA3ZTkxc3c4MS9tUzIwYWtRZDhJakVab2J2?=
 =?utf-8?B?dXA4RVdFSmdoRlZuT2o4a3IwRVBTWGpqMXRqUFpZbkNoU0F3bGhTVlNzVVh4?=
 =?utf-8?B?UG1jeVRadWU3OXZmcWJYSjFHdzErRTBGa1dWanhaaDY3NlhYbVhKYlhDVGFt?=
 =?utf-8?B?bGl6U2hVT0V6alc4aDF5MlFWZGtQbStRaWVoaE0reTFzSGM0WXZYRTV4Vm9n?=
 =?utf-8?Q?Zd/Sm3joXg1jsDUlg+T3z80y+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6T1mHzI+CbyFYjsviWBDE9lkRXKFmuAyysidszuGaqD0IIb5jCZN8hwjeE7BcmNevBYFF8Pe5y1BOpMY/vXIehiSSTP/OP1cshb6KCLox5v0SGmv2Ei1n520ZFqLRFXEMVWQs04CbbT9Uo6D/KnEydp661wbL1/mC/4yoZYJKP4qFjTWTf6WDF9g5jsKn19X7NMaq3ct8UVX1IVrJx+1GgL7T2EZ1JT3X4+rxYvVqEXdKf1qjY32ueRc4OJfCw2UBnuY9INrFqsQ6+KaM4gD7B0Wqjma/yeuSyYqJ5HtCmXITx+GxwUr0iaCwTIDLKEiNzQmyGpp1jJHziUqFhfCYYd8jRsmDoRqeYZ5/ecOgw3fw7n6h3gN7McfOUyp54r84mt1DN1tYJXUYJEv724vYpV9p2sNhqx6VLWwM45dhf3nvFshV2uXES9MlFGrr7EfrBUhxoRIOgGXM3lroJlBhGz4RsMQmylFWXafmbJ3/u3wJdAq8DWL7dopECazshfAJl2A0UId4VH14wrsm7n7dsANoQ+pQof9O2GwP5M3jnSeZdt6orhvW/hgvwR9HSVljdy9c3IYuaqEDnsZaBzkptEElBlhPpiARWMHtY7VMdg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 825f48ef-7d5e-4540-4a3a-08dc28db2638
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 19:21:28.6673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Yg0/btbWhZLCmqxtNoR6hI9z4PYMPbhvhAstJAMHwql1GcK/f+xpNVCbGhRWGjuvwtjyGaIOzGBs64xzK4bdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5953
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_08,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080102
X-Proofpoint-ORIG-GUID: fJvtFzkIFhfLUv6BiaZ9eImNQ8d3Sy2V
X-Proofpoint-GUID: fJvtFzkIFhfLUv6BiaZ9eImNQ8d3Sy2V

On 2/8/2024 7:49 AM, Matthew Wilcox wrote:

> On Wed, Feb 07, 2024 at 06:24:52PM -0800, Jane Chu wrote:
>> On 2/7/2024 6:17 AM, Matthew Wilcox wrote:
>>> While this array of ~512 pages have been allocated to hugetlbfs, and one
>>> would think that there would be no way that there could still be
>>> references to them, another CPU can have a pointer to this struct page
>>> (eg attempting a speculative page cache reference or
>>> get_user_pages_fast()).  That means it will try to call
>>> atomic_add_unless(&page->_refcount, 1, 0);
>>>
>>> Actually, I wonder if this isn't a problem on x86 too?  Do we need to
>>> explicitly go through an RCU grace period before freeing the pages
>>> for use by somebody else?
>>>
>> Sorry, not sure what I'm missing, please help.
> Having written out the analysis, I now think it can't happen on x86,
> but let's walk through it because it's non-obvious (and I think it
> illustrates what people are afraid of on Arm).
>
> CPU A calls either get_user_pages_fast() or __filemap_get_folio().
> Let's do the latter this time.
>
>          folio = filemap_get_entry(mapping, index);
> filemap_get_entry:
> 	rcu_read_lock();
>          folio = xas_load(&xas);
>          if (!folio_try_get_rcu(folio))
>                  goto repeat;
>          if (unlikely(folio != xas_reload(&xas))) {
>                  folio_put(folio);
>                  goto repeat;
>          }
> folio_try_get_rcu:
> 	folio_ref_try_add_rcu(folio, 1);
> folio_ref_try_add_rcu:
>          if (unlikely(!folio_ref_add_unless(folio, count, 0))) {
>                  /* Either the folio has been freed, or will be freed. */
>                  return false;
> folio_ref_add_unless:
>          return page_ref_add_unless(&folio->page, nr, u);
> page_ref_add_unless:
> 	atomic_add_unless(&page->_refcount, nr, u);
>
> A rather deep callchain there, but for our purposes the important part
> is: we take the RCU read lock, we look up a folio, we increment its
> refcount if it's not zero, then check that looking up this index gets
> the same folio; if it doesn't, we decrement the refcount again and retry
> the lookup.
>
> For this analysis, we can be preempted at any point after we've got the
> folio pointer from xa_load().
>
>>  From hugetlb allocation perspective,  one of the scenarios is run time
>> hugetlb page allocation (say 2M pages), starting from the buddy allocator
>> returns compound pages, then the head page is set to frozen, then the
>> folio(compound pages) is put thru the HVO process, one of which is
>> vmemmap_split_pmd() in case a vmemmap page is a PMD page.
>>
>> Until the HVO process completes, none of the vmemmap represented pages are
>> available to any threads, so what are the causes for IRQ threads to access
>> their vmemmap pages?
> Yup, this sounds like enough, but it's not.  The problem is the person
> who's looking up the folio in the pagecache under RCU.  They've got
> the folio pointer and have been preempted.  So now what happens to our
> victim folio?
>
> Something happens to remove it from the page cache.  Maybe the file is
> truncated, perhaps vmscan comes along and kicks it out.  Either way, it's
> removed from the xarray and gets its refcount set to 0.  If the lookup
> were to continue at this time, everything would be fine because it would
> see a refcount of 0 and not increment it (in page_ref_add_unless()).
> And this is where my analysis of RCU tends to go wrong, because I only
> think of interleaving event A and B.  I don't think about B and then C
> happening before A resumes.  But it can!  Let's follow the journey of
> this struct page.
>
> Now that it's been removed from the page cache, it's allocated by hugetlb,
> as you describe.  And it's one of the tail pages towards the end of
> the 512 contiguous struct pages.  That means that we alter vmemmap so
> that the pointer to struct page now points to a different struct page
> (one of the earlier ones).  Then the original page of vmemmap containing
> our lucky struct page is returned to the page allocator.  At this point,
> it no longer contains struct pages; it can contain literally anything.
>
> Where my analysis went wrong was that CPU A _no longer has a pointer
> to it_.  CPU A has a pointer into vmemmap.  So it will access the
> replacement struct page (which definitely has a refcount 0) instead of
> the one which has been freed.  I had thought that CPU A would access the
> original memory which has now been allocated to someone else.  But no,
> it can't because its pointer is virtual, not physical.
>
>
> ---
>
> Now I'm thinking more about this and there's another scenario which I
> thought might go wrong, and doesn't.  For 7 of the 512 pages which are
> freed, the struct page pointer gathered by CPU A will not point to a
> page with a refcount of 0.  Instead it will point to an alias of the
> head page with a positive refcount.  For those pages, CPU A will see
> folio_try_get_rcu() succeed.  Then it will call xas_reload() and see
> the folio isn't there any more, so it will call folio_put() on something
> which used to be a folio, and isn't any more.
>
> But folio_put() calls folio_put_testzero() which calls put_page_testzero()
> without asserting that the pointer is actually to a folio.
> So everything's fine, but really only by coincidence; I don't think
> anybody's thought about this scenario before (maybe Muchun has, but I
> don't remember it being discussed).

Wow!  Marvelous analysis, thank you!

So is the solution simple as making folio_put_testzero() to check 
whether the folio pointer actually points to a folio?

or there is more to consider?

Thanks a lot!

-jane


