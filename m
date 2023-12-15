Return-Path: <linux-kernel+bounces-418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652EE8140D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92352B2228D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300C8568C;
	Fri, 15 Dec 2023 03:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UWytU7LU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aVK03Mg/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA6D53A5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEMIClQ000711;
	Fri, 15 Dec 2023 03:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=23uPU4byxhUNyJQ54bSZCfkKTx9JJfiYBQTGgAtJLvw=;
 b=UWytU7LUwZtLaEr8LmRIh3mvGZMp4Vow+XS2YkOFyXFFxPUFpxLNdJD16EztyI6oKZ2J
 fDgGNfq2Ze9u4fb7bRBUT+afNVPXKyDKPq41F9KGmgsYVOcjxkfUFp69H8jt0DH1oYss
 M69CjEpLnsLYcATfwhJVDnw9Mh5I3TGQb3nZ/DzOh71yqfCWWuH6n+aci1gAxB4J9BBN
 zvFcrdUDdKK8wO1QQUTKMGpJ8jCWP10BeX6JwaO8GvJTHFkCzOmsZHSuWGXeGLqPZ7xD
 5bRZBXA9+4K7aIIPU/K/V3YLsH+qyAyprW5EFsw0jmvPriYwM8+qhus7P/JUL82MMlk+ Vg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvgsumcgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 03:57:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BF1KL2f013042;
	Fri, 15 Dec 2023 03:57:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvephf8uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 03:57:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiZvlvgKZvcWI5eXOljvBi5h50nOh8HfNzKBFcN+lFWP1lp2l5If/OjPDSfWVpFdV5o7XgrPEP26ZnRQt8foA6sW8i6638xwoa2NtzENTg8j6FFVeGoBUmRHNRNtzPwwegmXLDQKImZsgbVD4Q+WUddOrS8ItBj50k21tu4tXvtHFx4368X+8gdEuCx0fcIEjKpKNcOCx+brqJDbPdrUuwnKg8WA/55+t1OBGN5uoDBnQrvkfCt7Ad8jTS2fC88K6TjeirkNAja3BJ8GDgncPLCdcDfxNRfsZI+dhiTli5GWc8lcB5FJh27H3JuqNHXt+ycp7QHRDufciOE5SlV8dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23uPU4byxhUNyJQ54bSZCfkKTx9JJfiYBQTGgAtJLvw=;
 b=fvmO+c+KojsDaPIxgxSILQEjXPVB8uQgZgzSfFUrMp9O1Y8W7IhvPzQ4k0aQy7/Xp6BFptNIQJnozxA+6iQtwrZCZ433CPvI8010pP22q9bPo7weduwit7nR329fmpAKdQb98ht987AIOEQbnzaCFhERoi6ZklIeY0ttktK0f6/0koExkD2GmzfRNI/z/nMQCI10coTE7Lsclm1S9DeGMXpOdADyz5+W2sS4V7i0/jdoTGqGYRQi1a4IEOy8iA3cATxmFsNfSCQSSLQoYJFKg5u9jhrjLKVfaYlZoo60MBbTO+6DwIp2hM00CE2ne9JBdhmy0RNitEovQSRo7a1Eeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23uPU4byxhUNyJQ54bSZCfkKTx9JJfiYBQTGgAtJLvw=;
 b=aVK03Mg/TYPnWuoctULxnU6NqqhK9Wh0HJ0+9GixIuzjrUteSSwsYHjyGrWvIxDoTQ2H3wI5ozyS7wW+fuoAdWJn7hpvDcuWjYqFslbTIWS0nf22G250CPlgDqhSHzTGr2+rr5xW7nCeiartb4vzIQj8xy4UQhVv2Cv8pBVkw0Y=
Received: from BYAPR10MB3558.namprd10.prod.outlook.com (2603:10b6:a03:122::29)
 by CY8PR10MB6683.namprd10.prod.outlook.com (2603:10b6:930:92::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 03:57:44 +0000
Received: from BYAPR10MB3558.namprd10.prod.outlook.com
 ([fe80::2410:62eb:80e:cc7d]) by BYAPR10MB3558.namprd10.prod.outlook.com
 ([fe80::2410:62eb:80e:cc7d%3]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 03:57:44 +0000
Message-ID: <e62c67ac-c541-4a98-a71b-3fc7da41c293@oracle.com>
Date: Thu, 14 Dec 2023 19:57:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: remove redundant lru_add_drain() prior to
 unmapping pages
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, tim.c.chen@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231214222717.50277-1-jianfeng.w.wang@oracle.com>
 <ZXuJKAInbgtuSU9b@casper.infradead.org>
 <9792a7f5-62cd-45e1-b7d6-406592cc566d@oracle.com>
 <ZXvCrfKfgwRwZTLA@casper.infradead.org>
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
In-Reply-To: <ZXvCrfKfgwRwZTLA@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0670.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::16) To BYAPR10MB3558.namprd10.prod.outlook.com
 (2603:10b6:a03:122::29)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3558:EE_|CY8PR10MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: b934e3ab-96c0-44e1-d20f-08dbfd21fe0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TvxgwlMUmgUedb5KRepEqMWjxcbKtWFqpHb8czf9Hm3Dkp6KjnoL/ELu2ArNrJbAc8NZoCuLu8JvIgXX9f4vRcZLKd3Ret4nunw99REWML1WVMx+ClhEHdMEluwsivBg/iqFGZ0f3cy5A8Ql1Res4/3MOxmUR2GiMV8ImiC6224OscVKPvN8rl9r9TMr+EvGZnBo8OCouPUNsZP7FUB1+bZut3tRM9fE8eAd+DakLbgdaT4H8fhPvlq/WR4iYur9efbKyPuWWfBfhtGBcLk9Jhcn9jMDywkmQwGiSzwHMYZPihm+3t4vUcTOCkqRNJ4Lv4i35tUCR6sCT5BDbPAJaLPjK6Jp/GoxyOVetq5sKpy5EXadwg9jcpApfBMkB7AQ+dks8YZs6vH8kqFEgV6HPEe8IgTIhI/9qLQhAv34yNUZloPFZKl/j0Rfn+QIkL4IHOkbowZGEfQT9V3RmdPwnFWHfs/okHmeZGj23AovdZyin3S0Pht7e7XQShCxyVgzshjUyFuhqSgulksZgBnFi4L88yh+m9RJSIKFsHsUobbvQiuQ5Fen+0S6yEVzLOfDMpsDir1ZwHAqpHvaNlhDixf3eMViJBH/K+1OYTZQj2UtshnFuAc/IOucymJReW6zx1zwbs+e2ipCCctXx2D+cA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3558.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(86362001)(8936002)(8676002)(4326008)(316002)(31696002)(6486002)(478600001)(66946007)(66556008)(66476007)(6916009)(41300700001)(2906002)(5660300002)(36756003)(38100700002)(6512007)(2616005)(26005)(6666004)(53546011)(6506007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MTRxYWF5c0lZZ1oxK3RxZ0w3ZjFBWnBSQjB4TWU0WlJ4ZE1zVXRvN0g0QUM1?=
 =?utf-8?B?Sk01VlltTVVId1BqTnRYWVkwdXhOcUxPcDMvYjJxZmlWWHNVdGd5Z2xOck54?=
 =?utf-8?B?Q1lJS3RUczRqbzcrdXMxMUFsWnJ0VkExYTl4cUY1ODVrc3hNNE82aHBVNzJ5?=
 =?utf-8?B?MXJhaHlxOWJ4S0RZR1BVT0JXY0Q2ZjdQYmhHR24vOXFnQXp0ZFBuVHdCeXl2?=
 =?utf-8?B?eXhralpnRDdhM2NEbUhMeElESER1MlFHT0ZaSGM5aC92SDhIMmVUaitRczhv?=
 =?utf-8?B?QWZhdGkyWHZuekg2c29FS2ZsVVByd3lQNzkzeXAvc1BPc2tWVTNwUEdtdm1X?=
 =?utf-8?B?cmFnM2pUV3BsbCtpRm43b3hiWnNpU3JXM0NiNXdGRksxd2FLdDQzRHcrT3M0?=
 =?utf-8?B?RmloekUxNGlnNGNoN1ExY1h1Y2d5ZFJBdDlnWEF1SjhFUjd5VDk3cGZjZVNw?=
 =?utf-8?B?KzBjVGIyaU1PUzhjT1cyajdwYjdEV3RNZFJsUGI4QzE1T2J2alN0STFoeG1W?=
 =?utf-8?B?MStXQjNpWE90aDhhM1NNMzhUbm9Uc043a2JKOUlnQnI0UGZqa3hMLzI5Slpn?=
 =?utf-8?B?d1JXYzg3VCswMW5KMHBZOXpxNDlYZTd0L29YUFJWMVI3ZWZwZktFZ0dNYVYr?=
 =?utf-8?B?a0IwQkhaMEJidXltKzAwekhncm1HZzVqTWkwaDRsT3FIN0RzZ0dybmFRK1lY?=
 =?utf-8?B?b21MSzJ6c1NONTFqWFZubWVNd2U4VGJROTRGQ3dRQjRYRzZoWmhEUFZyd0ZD?=
 =?utf-8?B?ZTJtOUd1YW4xRDVKVlRWa1lmT1dYczRzekdVQ1VMV2dKWTZCUWxvSmJxWEtl?=
 =?utf-8?B?NmxrVUlpNjV4bk11MklOVldDNGlvU0ZBVk1GQS9LSisyY2RvRTdIeFNYbE1J?=
 =?utf-8?B?b2dkeGlwNEZJc0N4T3VnZkcvWHN3UEFjU2JNUFE0cXppWUtBdFdTQ2JDT1dF?=
 =?utf-8?B?WkZaOVdrNFlOTlQ4dDBIQWpkQTdjRmE0N2Z3THVtcUtMUkF3bitmZnVOTjFL?=
 =?utf-8?B?UGljbGZuWE50d0F6Y2I4NXZoUmpRbzY5cHhWVC9rQU5hWDFaSElQTGZhYlNp?=
 =?utf-8?B?RXBHSmRpQjNPcFB0ZXpWcDZSV3hmTExnakxCNFdtREhhdmdZUTNFT0pFN2cv?=
 =?utf-8?B?cStoalRHVGt0R2hVM1crcC9hZHpHZHZseFR3SzJWSlIrcE05U0JpSmttOVRa?=
 =?utf-8?B?ZEZBaEZEVmF0b214MFRaTnpiUDNoclM5RmEwZ1JBeHdXUWZnNHN3YTBkSDVR?=
 =?utf-8?B?MU1MT0hGdFBVYVdXdkh1UnhXSFo0OURsUlltNm10ZzZ5eEI0ME1kd3JBWWxx?=
 =?utf-8?B?R1BNbDZqNFBGVlFUYnR3NEVRbjVsS1lzMXk4cG94QlFuQjFidzJoa2dNWWpk?=
 =?utf-8?B?czgwdy9KRnRZREZhbHgxTDVzWUxOSGdJdE1YS0NKOTI4b0NiMWhDUkUrMGFi?=
 =?utf-8?B?eG1tSmJFSEY5Nlp6SzlyRmxsQlJGNnBKOXpJcU9hSnVxQllCaDR3aEFwRVd4?=
 =?utf-8?B?SytWUzlyQ0hTT0pIdUE4SFdrSnpOekd3VG5pTmVIMDBkcXczUzVQaStOVFp2?=
 =?utf-8?B?U3BVcE4zTWUwclVZRFJhTytmUkdiZkJlbE82bXFTUFpnMEw3TzFUbEJTU3hx?=
 =?utf-8?B?aFZsb2IzZmJTd3ZZS2FQWitHakJMVWlEZUN4Q3RMWXNKV0ZjWUFhODRGMFBY?=
 =?utf-8?B?bFZJb1V2ZnhTenoyZkZKK3Nuai9yUjkvLzd3UGp3VVFxeStxVjZoL3paRTNL?=
 =?utf-8?B?MWFUMDZQYlQrNkRHT1VxRUxUOGRseDEzc0pHNDY0ck9MOUtjWGRyQ1NLMlg3?=
 =?utf-8?B?U1B3UUhOd0hoemdlVzVvQzJwbFk0cjRlUC8rd0NCb3YxWmhHeVF6NVRnZXhO?=
 =?utf-8?B?UWs1aDhuaFVPb0Nocm1FQ3ZRTWF5R1ExMVVwbVVFdllHNm1TSWhTWHREZlR6?=
 =?utf-8?B?TXVUUjB4eEtyazcyRFVCMDliT3NJaC9RaGpwbkRtOTNMT09aTmx4bTY2VmNC?=
 =?utf-8?B?cldaSkFHNlFjMkJRbUl1YWpDWWhLdzlGNFJ2N29NbzV1WVZMUHdkcldUVllo?=
 =?utf-8?B?RUJPbllDd3NLb0FzSjU5WWxvWWVEUWtDSG03SWpvOEFOZkF1UHl0RUREK0ov?=
 =?utf-8?B?dGRuOXhOcGRuL0VVQjNnWXU2cmV3UGJFLzZmTkZUeTZkTEZpR3ozUDdXb2RC?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	shDiO18rXOR7cdi+GdG/QBsrlmx5UJGM3Jcsusw/r3YJOYcrSeuOyf2cDxuXX8d7Werrxl8+yLiahwcg1iMUbSZ/8X91xKEz1Xm4c5eRfBPIYFGY9QFNmI/ti63L78jfFOxcturoh5TwlluTkjV7XQTdlcn2PgkFiy4DsSN0QuF70qzvR/71UXGOvsoJtWIlB43FDft3TL9Wzpno3zkntcrwsTDLfKjp567jA+/P+mkBHXlVs/aBeWFlk8Y8k1+zfGMwR94dgTBNSgRfEsFQGGcVXT/3pxgPovs2Uo4ia+nscBriIno0H3HLA78Wz9cLuaX59hUIjIRoWDiOdoaKXAo3J4i/dCrZfxOg3i3BUmInTnpFRphdVIXrdqmRsDDB1/SOGwbXVRkJmEIGV/O8t2WcRODDHDC/edMTCDMVEeGW9yuZ1bXzAqQb0jlviRKouOZKfBkiyRghl9bQvCVkbP0yxxNoj85/WbJGRnr0uF3bJ1t/6kTF4DYRGUDldTsptQr6KsfhDfvXgWUvHjR/HV9ZUPAwNTSeWzutCrzqZSl76QZgdbqXOfkQcfF7keJjFmimztOy6ghyGVqn88MUmPKlibMJQEsU7mbZ+drdzl8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b934e3ab-96c0-44e1-d20f-08dbfd21fe0e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3558.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 03:57:44.4523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBijigxQfvriV5WPlGE+xPDxurn0LuSVKScviaUJRMlxAYFqUmT4MOddFvCPG7S75pdT0syYYXgCtGPTkI3mopRcKZ7QIOzu/AmLkCHd+xU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_17,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312150027
X-Proofpoint-ORIG-GUID: 8Gb3NR1FURo-TsW0C4yCnfHnQ3YVlEbu
X-Proofpoint-GUID: 8Gb3NR1FURo-TsW0C4yCnfHnQ3YVlEbu

On 12/14/23 7:06 PM, Matthew Wilcox wrote:
> On Thu, Dec 14, 2023 at 03:59:00PM -0800, Jianfeng Wang wrote:
>> On 12/14/23 3:00 PM, Matthew Wilcox wrote:
>>> On Thu, Dec 14, 2023 at 02:27:17PM -0800, Jianfeng Wang wrote:
>>>> When unmapping VMA pages, pages will be gathered in batch and released by
>>>> tlb_finish_mmu() if CONFIG_MMU_GATHER_NO_GATHER is not set. The function
>>>> tlb_finish_mmu() is responsible for calling free_pages_and_swap_cache(),
>>>> which calls lru_add_drain() to drain cached pages in folio_batch before
>>>> releasing gathered pages. Thus, it is redundant to call lru_add_drain()
>>>> before gathering pages, if CONFIG_MMU_GATHER_NO_GATHER is not set.
>>>>
>>>> Remove lru_add_drain() prior to gathering and unmapping pages in
>>>> exit_mmap() and unmap_region() if CONFIG_MMU_GATHER_NO_GATHER is not set.
>>>>
>>>> Note that the page unmapping process in oom_killer (e.g., in
>>>> __oom_reap_task_mm()) also uses tlb_finish_mmu() and does not have
>>>> redundant lru_add_drain(). So, this commit makes the code more consistent.
>>>
>>> Shouldn't we put this in __tlb_gather_mmu() which already has the
>>> CONFIG_MMU_GATHER_NO_GATHER ifdefs?  That would presuambly help with, eg
>>> zap_page_range_single() too.
>>>
>>
>> Thanks. It makes sense to me.
>> This commit is motivated by a workload that use mmap/unmap heavily.
>> While the mmu_gather feature is also used by hugetlb, madvise, mprotect,
>> etc., thus I prefer to have another standalone commit (following this one)
>> that moves lru_add_drain() to __tlb_gather_mmu() to unify these cases for
>> not making redundant lru_add_drain() calls when using mmu_gather.
> 
> That's not normally the approach we take.

Okay, understood. Thanks for pointing it out.
Let me send a new patch that aligns with your suggestion.

