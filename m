Return-Path: <linux-kernel+bounces-103951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A0C87C6EE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EC8DB21F86
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89EB1870;
	Fri, 15 Mar 2024 01:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="gfHmFUuh"
Received: from mx0a-00007101.pphosted.com (mx0a-00007101.pphosted.com [148.163.135.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6809A10E4;
	Fri, 15 Mar 2024 01:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710464744; cv=fail; b=D1KjvSBjOr0f0mubB37j9dRwLMN/Zs1w5nPCOi9We49VmhF8hUhHfYeTkuLM1dBdoFlm1Z6sl7Uj3gblmOk5D8m/h6rB+AdaOlbz1K+i2FRPQEco1ypk1bEiqGdRsTkwr0OaEq/piEQ1Ze3BaHazSAjrWYIelOWAb3XfgrF38ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710464744; c=relaxed/simple;
	bh=xiuT8k1uo2iSc2aNXsw36LhR0VMd5piL1AGQCbU4kAc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h6cyL188KDwTAP4R/D6C5vSn+1+EWRBfp3ZoBsS49+ZhUQoVujJKI/oTHLxyy44UNHz0+s19fRJjZ3rqiYKzw4ZqmFA33FPdkTPGqtZuPU5KEG23rvd2cFFpgSeru5+oJZYiiotFSXTCRDg8ZkQPU0ujhjclOMCswvnT84URD3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=gfHmFUuh; arc=fail smtp.client-ip=148.163.135.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0166257.ppops.net [127.0.0.1])
	by mx0a-00007101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42EKTU6W031241;
	Thu, 14 Mar 2024 23:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 mime-version; s=campusrelays;
 bh=wZEApZTe4mIIj+vBSDIumVkZxWUTtLJiSBbBRQBPw3c=;
 b=gfHmFUuh4WKrMSmkaRbzYVvuFsLzk1aj/qHtDPW194RJHTEVyR/TWZ6zl4m6jqG+SLg6
 EO4UggOFVFflJajbb1xPit9WmQ3pj1Oy25AeIa8ZdHjD2lDtiW1tmNvJZbjxnCgG1iJP
 CJQZmLcW7Qb2wja9O3F3zoOZBHaJxqc2my+Mra1QLDuyh9uOjwKHHR/Edgds6Ny7/kFL
 nrvOBCRYmJR9wXxVdIu0ilXcdL/A5u1qQS/LE4TfysZBb3orQdwaixHkVFFD/VoeGSOT
 Qk6kXOFw6LA6JyvvlpSplfGlFL5eBohg2yoOkyrktLmPkW1/o9x4KL8YL4Ps33239/d8 RQ== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by mx0a-00007101.pphosted.com (PPS) with ESMTPS id 3wujvah8gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 23:56:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPknqfQOhfsA1qegWZDSScRBWHZlyYaZOhRvBe3v2eeyuKAxUwA2mZo3IX0QVy0EDADyM//ickokDQNlM0uxnc1xzHL+b785vPJ6W9xJoUvUtsKJfWHYk+3TCfnVH4OlBa8NfWNqqpco8CaiJJwaDiOSH8wIe06kX3Lcsn9+XYzRP6eAkkwk3xD5yDoIHCKG+TThlkQL8RMPqwp6xwHfypYbz5D3Nf/SRPeq8Ztrer8uX8tIr+OgO6bxT/5awBr4NWV7DUmrEmCjhUXCyBn/KIFRG0b2X7+XmcFongYMUTxp3Z8v7tRqyz2L5YYIuYEg65WsVvJrnUAFs/fOa8Neew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZEApZTe4mIIj+vBSDIumVkZxWUTtLJiSBbBRQBPw3c=;
 b=Tt1ETS84vGLZkGO/CWjm2UfbLJlR6PGKhBqCnW59kjKxJvwSk+yhgcAtx8PYtFdJ4shkJ/7kLBQm5TdSJiJ8OItEGjif9FHrB4iRt7FdHSSDVn6WDe8D+gZpuCQKjptrGxjQyGolxTH7r2doWcvTxB4hK8GIpPQZrX530fd3wz6TFKSmt7mBPpDH8vpKDsY/azOlpEInQmN08nOWegiKtxxk7ogtMlE2wgO+vqaDcVOQtQZVrMCDrP4PO2haSFEX1EEuSEggtj/i8NwApl5IW2qLJV+RUwTRYXScA55qn/jHtoI/HqO2GLkSiZfkEQMIdic1d6zi8nTa1CdTBXhTag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from DS0PR11MB7286.namprd11.prod.outlook.com (2603:10b6:8:13c::15)
 by PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Thu, 14 Mar
 2024 23:56:38 +0000
Received: from DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::157d:9e6e:b778:36f4]) by DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::157d:9e6e:b778:36f4%5]) with mapi id 15.20.7386.006; Thu, 14 Mar 2024
 23:56:37 +0000
Message-ID: <fb6919c5-8acf-4ee3-8fd2-1d483b274867@illinois.edu>
Date: Thu, 14 Mar 2024 18:56:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kprobes/x86: Use copy_from_kernel_nofault() to read
 from unsafe address
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc: Qiang Zhang <zzqq0103.hey@gmail.com>,
        Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
References: <20240315000753.a448251fce0291e041f76c13@kernel.org>
 <171042945004.154897.2221804961882915806.stgit@devnote2>
Content-Language: en-US
From: Jinghao Jia <jinghao7@illinois.edu>
Autocrypt: addr=jinghao7@illinois.edu; keydata=
 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
In-Reply-To: <171042945004.154897.2221804961882915806.stgit@devnote2>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------VFXAmCBb9ksMBO1kaNyT1mLs"
X-ClientProxiedBy: CH0PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:610:e7::13) To DS0PR11MB7286.namprd11.prod.outlook.com
 (2603:10b6:8:13c::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7286:EE_|PH0PR11MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: 968483d5-ddda-455f-a0ad-08dc4482628b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jA6KgY7uI80dymyZL6GrLKjWJ+FZSOAsV2/0hy2rd2nJ5POUru7E5i3KqA6cUt5BuEs6HUdwbO1af1Nrrute1cXgGC8GtbPBTS29StgpPmc3mII7Xxb07VYGJlAaDnqxYFXsVaMIo3kCVH4aYFyiP85M7p/52m3ZxkjPcGcfD1+Rfra66DxLjBxkQ3fnTIA0zA1lwuPsQEebpD6jjV2aSFDCI9QymfjnqC6SXdsk5uE+TIDWQdN+G/jwLtVwCgvSrE/LTxhpfpQQ5pfSI2bN5c4N5JLFLzoF0b64alKFx04UqMfEN31+NlKmQffed5BahbqMpVQY/rJpVDKJjLH/hq7x/2YmuIogHA9bPiptz5X4SrQG+8w8/59XEVKX70qVnuEi2untF0xeleuB5ee3fESjQLjhEgB78IxDWCAxSr54XJ8TQw1y4a5JOkBTBChsDwVSv1PvHPrbpa4fU7/COG/CZad5zsCh2BPIiZ3RY+Ws5xRf2TySordulgfZxHOJcUUiQrBRE+IS0KlAjE4VKC5+JfEonlxEddoHfwQYzqJJpBaZFQpdJ5qIyxtDaF2ok2p38wBLRaNsyWX2z8iZrr92YPw+uCNzSNtUjUXSH5M=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7286.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bCtzMVZWVEFOZzl6d1hSTGVKWHFML3RkS1p5UzJHOXpZS0toaDRqbDNMZXFP?=
 =?utf-8?B?ZzUzNlFyT3loTzF1MXJhSUFMeXV5ZDJJQmFOK3pJRW5pM2o1MUJpTndTNGlM?=
 =?utf-8?B?LzV3OG00UEZmM2REWHRMd29lQ2FqVElQbkVweS91UDQ3Z3A1WkRoSlNIYUJj?=
 =?utf-8?B?ZVphTjAyZnNNNXVzQ1lURWY2K255Q0w0aGxNK052TUlKSFhHc2N1SmNVOVdC?=
 =?utf-8?B?aHVmSWJ6a0NqQzRmdzBLL0FjbVlvR1JSay9UUUEwd1hqSldFTVk3enJ2RUxV?=
 =?utf-8?B?NzFvS3NnL1dUaS9xdlNYTXVaM3c5QVBBNi9HZC84TmJsdU1aZEFSR0JydTE3?=
 =?utf-8?B?LzVMOFhSTHBEWGVkRFpDOTNjWDFKK0hWWDVFcEJJTG12b1RqRUdEc0ZpUEdG?=
 =?utf-8?B?Tjd0bUdpK3lXWXQ4aEd4eEkzWm1jdHJ6UVhvTmE1NkczWFpJQ3JsREFFRmFy?=
 =?utf-8?B?TnFPcWRqNkJ0WGZhbGpRa0dIRXF4OUtocU1YUHo2ZEN2TGY5dTRESmRlOFZt?=
 =?utf-8?B?RStiTmJYZGkzam9mbW1iNHgwelhrd3hUZ3ZsOWltSE04RStxdHRDZUs2Z3pR?=
 =?utf-8?B?VUZxTjI1bG9FWmtaTG9rNEtyZlRSYVVncllhWlFHelAvV3ZQQW85VTBKSnly?=
 =?utf-8?B?S09lUHo0b1RFbGtvc1lzWkdCZ1NpY3lzb01veFREV05iTG9wSjd1YkVNeUlJ?=
 =?utf-8?B?MU5mbkppM3pCZEhzT2xkVzNrVUE3Z0hUSGFUSFVNZ01UNG1nTFZ4V1pOTjha?=
 =?utf-8?B?ZkFMc2VMLzRFNDJtNVJIUGhmS0J0aVB6WUpqbXl4L2ZOMXJoUW8zR2xFU291?=
 =?utf-8?B?eFo0Y2ZuYUxGSTJFajhOV3JYb1Y2SzQwK2taRFVhcW1teTEyd3JMcUo1aFVv?=
 =?utf-8?B?Z2FXRlJpRGV2VDNQREY2aVY5bkNnMWZ3WWFMc3NPRmRVMVh3WEw4V3A5MU9N?=
 =?utf-8?B?d0pQamZyRFNUaXF1NHJ4aGVxSFVVZVVBWmFDMGVpMFlyK1hDU2dNMHBjMUtR?=
 =?utf-8?B?aUR6Qld6WHgvRWFqNDlYVExQZ0Y0bjNWOGt4ZzJHdTNYdXFkc24vVjUrc2Ix?=
 =?utf-8?B?b29oQng4VWxjTE1EbHVIQWJnTk5uak9qemNzODhhclhhNUQrOTI5T09uMXFL?=
 =?utf-8?B?Z0xQcFB3YkN4T0liUlVuQXcrb2ZVeWZpNXB5UU8wNms0cnhKUTZGRGU2aFJQ?=
 =?utf-8?B?TG5uQnF1dGhsWGJDTlFJZG9DcGZxRXpnb1ovRTBSNWdRUi9RTmpRUVNNVTl0?=
 =?utf-8?B?L2lRZHlSekVOMDdVUHMwT0dhcDYxYWxhazc4SGcvTnpQMEpYNWxUYzNqY2F5?=
 =?utf-8?B?V3RoNGsxMERIN2RManZBVjZkZFlycUVaRWhZbVA5bW5oT0xFRkFKTHAxYkZZ?=
 =?utf-8?B?Q2VZZ1FuQUVSK0V2dkNMOUFCNW5SdVF5b1laYzl5N2FiTStXUkZTT3BBeTJI?=
 =?utf-8?B?QlZxbnJYYXVoQ0pFS3drWTJkTDNldkhSM0tubXE5U2c4T0hkaVFGWE56bU1w?=
 =?utf-8?B?Ly95R0xIdTcvc2o5SEVuSzNMTXVxTGdWdUhHblRzemFaQU94QzltdlB5L05Y?=
 =?utf-8?B?RnB4NTBKa0lLTThGcXA0aEN1ZFZWTFdWRmI3aE9tYVM3dUZJbTBLMFY2RE5Q?=
 =?utf-8?B?MTlJZ1YzODFoOTdYWk9MeU5vaExsTlpXeGdZZ0hVc2podm1WWVRoSVdSVnc2?=
 =?utf-8?B?ZXI5a1puNHRURUxJcklCOXVIRTJSRmJhMXNpQ2pPVGticUJkM2hMWWg4ejl4?=
 =?utf-8?B?YWlLM3hmYS9ObEROZTYwckR0emg2cnRlckNHcUdvTitUaHBMenZrWVY3NVJj?=
 =?utf-8?B?aG1FQVRoZ0Mya2p0YnBnK25KWklFdkwxWEE5RXNjc2ZSMjVHb2dieUh3VnM0?=
 =?utf-8?B?d1VSTm9nMEJETHd1YlYybkpOaWNkcVJhc0tCR2FCalFxeVE1Nlhwenl6QzVH?=
 =?utf-8?B?bStXRFpSd0U2Y3dFUXkreVhNcHhuRkc3Z1BBSTF5eXU5TUZpSnNWR0IzY1Vw?=
 =?utf-8?B?WHgxYTZzM0p4UmN4Rm5KWXM4YXVqZllDblQ2b1lWRTh3Sk1heWNpMHhzQUZV?=
 =?utf-8?B?cjBrcXpiSjFobW9oa0V6UGpjVHNma3VLRkdXSy9aU2xHYW14dk5TSC9NRVow?=
 =?utf-8?B?cGUyWHM5aHRzUTB1SWpkWDJsR1lZcXRLMVZzWktDK0VZdVJkSDd6akFYN2hn?=
 =?utf-8?Q?fkdZXzRqLw0oW/fC39sMbeeRzuZECAraHUTWRRAEAiQk?=
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 968483d5-ddda-455f-a0ad-08dc4482628b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7286.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 23:56:37.1333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3oqz80Yc2FF5V3EkYEFyIrHgboC9EjM06IPcFZFookUmyLhA4+m09uA3onih8PBofobV4ZYm3E6B+zcaPej+wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5830
X-Proofpoint-GUID: WVHVn7ysVoSqsleBVZanhJ-LfcooHd0w
X-Proofpoint-ORIG-GUID: WVHVn7ysVoSqsleBVZanhJ-LfcooHd0w
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 spamscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403140185
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 

--------------VFXAmCBb9ksMBO1kaNyT1mLs
Content-Type: multipart/mixed; boundary="------------atzw0F30w5UAGoBzNsaRR55Q";
 protected-headers="v1"
From: Jinghao Jia <jinghao7@illinois.edu>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Qiang Zhang <zzqq0103.hey@gmail.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org
Message-ID: <fb6919c5-8acf-4ee3-8fd2-1d483b274867@illinois.edu>
Subject: Re: [PATCH v2] kprobes/x86: Use copy_from_kernel_nofault() to read
 from unsafe address
References: <20240315000753.a448251fce0291e041f76c13@kernel.org>
 <171042945004.154897.2221804961882915806.stgit@devnote2>
In-Reply-To: <171042945004.154897.2221804961882915806.stgit@devnote2>

--------------atzw0F30w5UAGoBzNsaRR55Q
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 3/14/24 10:17, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Read from an unsafe address with copy_from_kernel_nofault() in
> arch_adjust_kprobe_addr() because this function is used before checking=

> the address is in text or not. Syzcaller bot found a bug and reported
> the case if user specifies inaccessible data area,
> arch_adjust_kprobe_addr() will cause a kernel panic.

IMHO there is a check on the address in kallsyms_lookup_size_offset to se=
e
if it is a kernel text address before arch_adjust_kprobe_addr is invoked.=


The call chain is:

register_kprobe()
  _kprobe_addr()
    kallsyms_lookup_size_offset() <- check on addr is here
    arch_adjust_kprobe_addr()

I wonder why this check was not able to capture the problem in this bug
report (I cannot reproduce it locally).

Thanks,
--Jinghao

>=20
> Reported-by: Qiang Zhang <zzqq0103.hey@gmail.com>
> Closes: https://urldefense.com/v3/__https://lore.kernel.org/all/CAKHoSA=
s2rof6vQVBw_Lg_j3QNku0CANZR2qmy4eT7R5Lo8MFbg@mail.gmail.com/__;!!DZ3fjg!_=
C9Dn6-GBlkyS2z34bDUBsEXkTkgWp45MNrd4Rl5I5slz2A3SrurXOxKupsxLMqxC2BMiySCTf=
B2-5fPhkLP1g$=20
> Fixes: cc66bb914578 ("x86/ibt,kprobes: Cure sym+0 equals fentry woes")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v2:
>   - Fix to return NULL if failed to access the address.
> ---
>  arch/x86/kernel/kprobes/core.c |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/c=
ore.c
> index a0ce46c0a2d8..95e4ebe5d514 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -335,7 +335,16 @@ static int can_probe(unsigned long paddr)
>  kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned =
long offset,
>  					 bool *on_func_entry)
>  {
> -	if (is_endbr(*(u32 *)addr)) {
> +	u32 insn;
> +
> +	/*
> +	 * Since addr is not guaranteed to be safely accessed yet, use
> +	 * copy_from_kernel_nofault() to get the instruction.
> +	 */
> +	if (copy_from_kernel_nofault(&insn, (void *)addr, sizeof(u32)))
> +		return NULL;
> +
> +	if (is_endbr(insn)) {
>  		*on_func_entry =3D !offset || offset =3D=3D 4;
>  		if (*on_func_entry)
>  			offset =3D 4;
>=20

--------------atzw0F30w5UAGoBzNsaRR55Q--

--------------VFXAmCBb9ksMBO1kaNyT1mLs
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE2/ZzTtJDFIshN/BBL9huahcPNUYFAmXzjrMFAwAAAAAACgkQL9huahcPNUbr
ABAAi/xut4QhrBCj0gwwqTnfFYQeWUUL/yU3jlWgzEQV1zIbBPz63PNmKcW9M5fvgStBabd2aS0T
84ulZE7oAZSQ+GQAYs4p8tRaoDOw/7/H6N40zaoBJLoPYnllseo2IgVmhXgOR0u01bGHE0WDD810
I8szGGoaArAxHp+AeNDbszXshGdU6H6BmLbFoqO7uYJOqqTH7rnBrW+OuifRPkfTS+WqjDufbbMQ
ptBXz+y4MwKwNz0cubpLq4iK9GszZ7WCzrR33vNIwR53hsgaUVVeSpiol4tXrEFSc5mStX9ot1BS
VVSLj7g006Y4Almr3C3eRqu0IqTUtbaydesigYqbnqEiseY+gQpbh3jugIPKadF37+/RkgCmFmzj
nC3GuPXwPNz2UOQeJg9SQPDUly4Cfk7NiNe78UW94hKDHU//LEmqdvAQys29rDMLC8KilylPfcDo
k0uUyY+j/jyAsQWmPR6RQOEBSO5eMLqcP1qz90wgRjnLVhH5m7rlI0QCKF80Epal37ikZeC34Q6m
56n1xo2wUHBeO3ShRaDlKHChAPBymXVIetpU88tNcFBcj8Th09riTMLdlkFWOV6uQFGokIDVk4xP
DWy/OS4o/C8sPtcLrtxAI2RYsujUFnhElEa44lnwErK62ojgIF84/QZSyNmtXoEQsA4cxOYo+y9R
PHA=
=Rt+8
-----END PGP SIGNATURE-----

--------------VFXAmCBb9ksMBO1kaNyT1mLs--

