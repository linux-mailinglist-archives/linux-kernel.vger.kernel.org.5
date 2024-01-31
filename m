Return-Path: <linux-kernel+bounces-46776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D16F8443F9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 575DDB2A421
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9067012BEBE;
	Wed, 31 Jan 2024 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="rZt5qBhg"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AFF7BAEC
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706717881; cv=fail; b=HSHrsz2ewo8vn0vX/2dKMKJ2QJpi9sLkwyDgB1yyZ/VEOWqrfsiZL1XN6WG6BLT9ZacyNYcwAwKRJr3b8CFY8erCCeGyvhTr4zaw6JZ3zKAVzYYhcyTIEP57QhNRZNMVqTAjX2nte00gCKtZo94SJCR1LpkGBWFaf9ruMC8JcVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706717881; c=relaxed/simple;
	bh=z6NzW/n52pLe6gGLDbi6xwSGQKWFuSvMG4U0Gc4exN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aE8b+n3jlqPi3m1YR4Wn6ZntPrZPTxT9tAwvRRy3ZDByWfr7pBbragbBuiotUnFkkaaXmmL95Nb+UCOyBgnQ/LLfNQxuQhiM26N8VWPW4Ir/4E4Opl6ZvJLRqNvgmi+uFaaKuocWqJkJ1jRaNL/HNep5cxpg1rZzY1ecg/wLjfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=rZt5qBhg; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40VAxQSJ012441;
	Wed, 31 Jan 2024 08:17:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=PPS06212021; bh=iRwLxTULu85CneRIO/v
	ozUPo0/VWLi3GLJnunCk7V+Y=; b=rZt5qBhgieJJN0ejbRnesB1zsanSl2gY9Fd
	NxetMmeDaUpXk04kzzM6S0wAAJ9orKuh6AgyOPGdl9//gir9XqS84bxAusDEk0K3
	KDdKS0SGJT3UgnKs2ccWQXu5t3/dWjnXoisw5NIoA5eI8Pxtrqq6FVwEQnijxB6T
	yjgDbB3cqnhNG//YTvh/oKTTHnFdzp0+vr5OHOxNnBH8DvOnJ+GQpFohwUenTbna
	yw5cm9fV/sPQEPGQr9ePbJSbXaQrjxgrw4Pqc/GDQHXu8GSU3xI0Y/jwgu/Rk6i3
	K0sEDR02EcAwcdoPTgFWNoW4ImGnz8xlyujefRY16grzlGKFY5w==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vyatw0qx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 08:17:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mL8OfA09Xd06HE4MyAKhvIEjmr2u//doZ6g+pjbuznMngcHJyvgUlyiLLLrru9uPVByuWEkRkn95Zzpl03KyiaITsE5KypDnFc7M1cUrfulUI4dfi+ktH2MmNOaeoALHndtzfsuXqTGVBHk2sdKX7YAe/apcl27K7N7wi7DODC8nRc2dk3UDlGiWxarRmnMprzn6LqBOFf6jOF/iT2iuG52WwKNRPzGblsPemhL3F54vMW03R0u1fjukUsD/DtX9tVud6olN2ieZO7FxA5HyYXYGM3SuSaJwnO71jUA1601/QyZZVW6NuaDWx/wfTtr11RAbnbYjdZ4wGDk/Ey42QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRwLxTULu85CneRIO/vozUPo0/VWLi3GLJnunCk7V+Y=;
 b=kzsBTq3ZkNsusCESdPmwQ+7cexXKSwbgojuiYYtK14kBc5y8K2DbZdZlgUxzhuSwDOGCZBLDQDHYrQyM9X2bKdJONiIpqxMqsCR2BL/hhElnpsY3jROyHDNr4/QZdRXiPHgIEA9YXeLRPK+t5dZvN3EFrfu/UjzNbr3uLjjSFMMQnxWHBoJuvVi0uQHjnLiAfe3yKJA7cfcO6ZJSo+2y45EUnz+oo6B/0+j+6JWWbC6kg2GKLLcDNS9wK+4HJco65TANgD0pRsT/tiPFpJ/1EjC6GrK2c3Mg7oHlOpemkS+Os3P437JkaqcDiQaxlRZx8t9X7LdeAKLv+tomUJ9Vfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BN7PR11MB2802.namprd11.prod.outlook.com (2603:10b6:406:b7::25)
 by PH0PR11MB7470.namprd11.prod.outlook.com (2603:10b6:510:288::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Wed, 31 Jan
 2024 16:17:32 +0000
Received: from BN7PR11MB2802.namprd11.prod.outlook.com
 ([fe80::44ed:4856:6ae:a30d]) by BN7PR11MB2802.namprd11.prod.outlook.com
 ([fe80::44ed:4856:6ae:a30d%4]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 16:17:31 +0000
Date: Wed, 31 Jan 2024 11:17:27 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] x86/alternatives: Do NOPs optimization on a
 temporary buffer
Message-ID: <Zbpylz6ep3skWF9d@windriver.com>
References: <20240130105941.19707-1-bp@alien8.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130105941.19707-1-bp@alien8.de>
X-ClientProxiedBy: YT4P288CA0086.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::20) To BN7PR11MB2802.namprd11.prod.outlook.com
 (2603:10b6:406:b7::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2802:EE_|PH0PR11MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5c57d7-b919-48b4-fa0f-08dc22782066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oSneIDxysnS8iaXKXA/UZ9NHpjo034rWfL2kV5gq1ztrK/UeXcgRRaZ2Rgm+udWAa+6GIMJPMvIldgpYkBb9eSIV/txzS5clLWPWUZsfFKoTdZ2YAb7stBJZ+wuPnldlcIKRv4lt8qjEWBa9OHv8n/0c/FiRveFv4NooESjo2W2t80y9jJqOyaPMejzHJVOrH0gRc9y9iJu8es5zJ3XbZt5OWBapB1fOTvGzLuEG3aoybFzNy+SVnhL/jOwUF4da83TN0c1LrNF99lx82gZR3AR3mO5CTc/SsvaLeNGsGl4VTOOGpWKTfc4aFNFTbICfDf4l9hNS/4XEzydXtjfXKcXMfWsbAGzVrfTadgGJEwCncM5fW7td3wjVApKtn/MbmXif+jVpqEI7B65/ccSnVRVyh1rQqSAfbIDAUfOd8cST8YdgFFMQQz/0eHwcYXCB/YIZ5z0aQV+wy96bNQF319YYAqz0COn6omQYQO3to3QA0Rem5uEuHk8M2lTfOqogO5q0sKl5LQBm5p8Hbq0bXtOcn23pHblB6t5BCUs5Wiosv47UXjIWvT2iJXdte9bb
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2802.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39850400004)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(66899024)(8936002)(4326008)(44832011)(8676002)(2906002)(5660300002)(86362001)(66946007)(66556008)(66476007)(54906003)(6916009)(316002)(36756003)(6486002)(38100700002)(6506007)(6512007)(6666004)(478600001)(83380400001)(2616005)(41300700001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xv5PQxRCSnhgJvO2c76IjJeUBHL2c6MW+452Z95Z6FAeL5cQ4tOvwU7dmOS8?=
 =?us-ascii?Q?ApXYgYubxGGT8bM0RT+22f0Xpa1jkOh+1VLKiR9YW/2TS9OqMCsGs738revH?=
 =?us-ascii?Q?tlyU/PsKFYAvizsHi/2igJiRduoPAqzt9D4D7X93cM9ZspsGg1aVD4fqvB0v?=
 =?us-ascii?Q?lqF/AnGAtstYRPWyhqHxpR7JcPnFgYjBVR+UwYrmuUJClhQWQa3lj3RO3c3A?=
 =?us-ascii?Q?l3LO7ySAsQl9t/FqYVDSEhrPY1BLIs87bk2FUBC9xQGX+ng391vl1HfTfAqg?=
 =?us-ascii?Q?+CfYC+cF7zN7iB61iKv8m70IVyPa6u8xvf20GRSXhN/W2mOupgz9rSvkODvF?=
 =?us-ascii?Q?M1NG9WxcBD5ViUnKrwxcVf50CQycPtl1UbkWaSgG51EoO+joCr+94ymqKx0d?=
 =?us-ascii?Q?qz+OkeaRvxSPJw4W6JljcDKispVU0hC5LHuUpMUxf+4ZCixVnqMVy8XbcyCN?=
 =?us-ascii?Q?mxUuEDCu5Zz38ncbwd6euDTATTzgNSjkGkW99P3KS36w7gBJYmE0UOau/gmJ?=
 =?us-ascii?Q?Sl2sfBz08bMbMmsf8emriBl8hEQaR1clQQPzr5lhV1j+j38BKLfErhxKOjdx?=
 =?us-ascii?Q?JVuFCTX1u0o5PLgbl/0nA+8LHvl4rbr97AdfaptKOtL6M46BLnYNSqSsA0KG?=
 =?us-ascii?Q?nGmrYBocsBh66ewZrW2VFcpgMf7ZM7XbFoD8tyjA7GwgnV1PJTURq6ahyn+I?=
 =?us-ascii?Q?zeOG85VbT2WmAAwhVVVF+dhUIwoA70JqqzgNN5HV1goi4gwS1p1nrj+9DYAR?=
 =?us-ascii?Q?lDlQjTQCNm4M17YZX4436uNEKu4SFMVS4XTrUhCCAMIovOOdsHdjBCnMXdK2?=
 =?us-ascii?Q?1P891YVxKF6dbbouMZjCss+nja5JrluzRnnZsWAXempn0CciR2Vi+F9654aP?=
 =?us-ascii?Q?+rmh+ZITpqwNrxgiIhzU9elY69TU0cRMl8ydAtkPrCdSYv2FoGGKQugQ7AhW?=
 =?us-ascii?Q?j8IfMF0jd6SabJ7l/OUPKQEq7HVamtRPAGFQt7Saf1LKRa7/mz8UvWaGv0Ls?=
 =?us-ascii?Q?HsWAcx30qip0AMDXsr0GuhZMr+OFsSjDUaFr4tnUwkt5Vp4EyAiDqCa6h3yX?=
 =?us-ascii?Q?tA96PNrLC8Sqd/JdX1cw9HZ3MEijoFD44n8hu9yaxEUqFepF/dIkCx6kOHOD?=
 =?us-ascii?Q?E/ZAJ42XI+OtvlU6T1acKvSH1pNQpQes6WQT52Klq9/RJwYNrKHLx4/DkaxP?=
 =?us-ascii?Q?wHtROhNQ1YVgTLweQVoMsUt0rtZwdkth3KC2ULy/sUTVAw8xeTdLS/9IQs3h?=
 =?us-ascii?Q?1J3yrmHpFepfHltbDCCYt+zE4P/9qwkW82iD2uQETdds9kPCXzeO9kfYrdu3?=
 =?us-ascii?Q?lbU60t/H/U2p3kR6jI3k1Kd5Se/r0tkI3uT1LD78sBV7+1soCjLx/m1wvwmn?=
 =?us-ascii?Q?LJGepYIeTG6fJn1+KavVffCVHzPHF2GGk+wSeo91UhIhTg3Qnmz5kWNi9duH?=
 =?us-ascii?Q?1s9bYN5taknY5XhAhbNXdaY1WgItHbwVb35kkysTbBQepUf705t7kHmFhjPn?=
 =?us-ascii?Q?KM3apjR0l1ZQ114XdQd/ZOqII6FtmgIjX7ukTGhY9ct9c+cVP80BGwxxquVV?=
 =?us-ascii?Q?rF5enUxwSDabQ/8/pFR9CSo/r7klgtEQbPrPUSoid2d6DBy6eqxrv003XQGC?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5c57d7-b919-48b4-fa0f-08dc22782066
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2802.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 16:17:31.7038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XjabntU7sT+ERGEjaroOKI281yc1Aflxlmd7//NsYc2PPq7LqCTqNTyQurWOikAC1/2DefJEnDbrezxmFpsXBap9z0l7FslhmeXBFEB4k4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7470
X-Proofpoint-ORIG-GUID: C6ezdTos_YclXlhU5eJRHBVkglWThdBm
X-Proofpoint-GUID: C6ezdTos_YclXlhU5eJRHBVkglWThdBm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_09,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1011 impostorscore=0 mlxlogscore=563 suspectscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310123

[[PATCH 0/4] x86/alternatives: Do NOPs optimization on a temporary buffer] On 30/01/2024 (Tue 11:59) Borislav Petkov wrote:

> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Hi,
> 
> here's a small set which sprang out from my reacting to the fact that
> NOPs optimization in the alternatives code needs to happen on
> a temporary buffer like the other alternative operations - not in-place
> and cause all kinds of fun.
> 
> The result is this, which makes the alternatives code simpler and it is
> a net win, size-wise:
> 
>  1 file changed, 50 insertions(+), 72 deletions(-)
> 
> 
> Constructive feedback is always welcome!

So, I figured I would set up the same reproducer, on the same machine;
build and test a known broken NOP rewrite kernel like v6.5.0 to confirm
I could still reproduce the boot fail in approximately 2% of runs.  And
then move to testing this series.

Well, much to my annoyance my plan broke down at step one.  After about
three hours and over 400 runs, I didn't get a single fail. I still had a
known broken build from the original reporting in October of v6.5.7, so
I let that run for over 300 iterations, and also didn't get any
failures.

I have to assume that even though I'm using the same host, same scripts,
that because I was testing on Yocto master, other things have changed
since October - maybe binutils, qemu, the runqemu script,  ...  In
theory, I could try and reset Yocto back to October-ish but that is
probably of diminishing returns.  And I can't unwind the host machine
distro updates that have happened since October.

With hindsight and knowledge of what the issue was and how narrow the
window was to trigger it, I guess this shouldn't be a surprise.

So as a "next best" effort, I let this rc1-alt-v2 branch run overnight,
and after over 2200 iterations, I didn't get any boot fails.

Paul.
--

> 
> Thx.
> 
> Borislav Petkov (AMD) (4):
>   x86/alternatives: Use a temporary buffer when optimizing NOPs
>   x86/alternatives: Get rid of __optimize_nops()
>   x86/alternatives: Optimize optimize_nops()
>   x86/alternatives: Sort local vars in apply_alternatives()
> 
>  arch/x86/kernel/alternative.c | 122 ++++++++++++++--------------------
>  1 file changed, 50 insertions(+), 72 deletions(-)
> 
> -- 
> 2.43.0
> 

