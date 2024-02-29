Return-Path: <linux-kernel+bounces-86657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5B786C879
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B4B1C20C7C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438CF7C6F0;
	Thu, 29 Feb 2024 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V5mbWoPW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m/q55LWR"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837A37C6D2
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709207501; cv=fail; b=Yctzjg61Rz29ofrVCSf0bjQgjGTG6eA6RuxYqmy85+aS+o+4gLNv0AsOnu1UB4L2WH2bhsQkNuqDrQI+aLQmKg9IcQ07O/7TTBbgj8war2wZOslrNhpStWsK+ovaUBf+61vSPhbfV5CUNMkTEKM6yjMwZFZr7a6I7Xzrg8Pg//8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709207501; c=relaxed/simple;
	bh=XhUYl6FboX70sH46lt/oe3iED0j6T+JeX4Fh3JCdRLQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iAdOWWtXgcsNZhruUh6dZ7D0ynqMQRZEvQggI7m2hFXfM4fO4zMB6DyQleeUgZqkFI7g7vzZTq0S6U5ekdNF343mwUDawiEpx/SClnJ36DGg4C9h9aQPB8w1Y46SbiMlYOA6ate1iLE76Yr9aDEVm/kRCAP9b9d1JD/6QOeXJds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V5mbWoPW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m/q55LWR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41T9W5UY012505;
	Thu, 29 Feb 2024 11:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=lr30ytms9pUo6jg1aN6Xr2GbvukEM4o2dBN/80lHMuw=;
 b=V5mbWoPWaCkCYtXKwxHFvOIL7qm0Y1Sgmnsi2Gt0JLlCyuMpA8k3naoH922Zoch+e+tr
 lQ4lsPWxdpKEIJ80HJrvFfNCqQ2oPOlwFou6wyIRmCm7Tpt2KnVNZjzFbeB51As4q2rZ
 JuFb6Np3JEcqBwt7ctSnsg2int7I6zuP3dmMm1cdJ8anG7MeSwtwSSeAmmjh0CAgHuvj
 koYVGpEUO4WKQt7ihoHfQxqvAMmD+voazJ8LAruSATRuC4bGc7akHWoNWaea16n55u1Q
 BNb1cf9+9AzHmM4fPyuDJNN+S2CuZIKR5/YdiIoClgMqQjtDCFuJSNS5rgUmegkbBf3Z jA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8bbd2yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 11:51:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41TB5KtI005778;
	Thu, 29 Feb 2024 11:51:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wjrra9g76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 11:51:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+tTnpKv/b6EWeM+lJXvq08bAe/VSJYGoyuTV8yUbjyU0XtQpFVCDEf1a3HaRrnY9h1JnIqsaDEUPEnyweR6rc/iQPouUbwA45uZ1ojc7+nGHPN8VqJZXO//WA8WI0/C8wtNpVR6u80oKFKixr5LkEm4vmOgDXSjJwAvkGrljEjHU5YPFvdGpfD+1h3xYXPQSqdEBJaemtXoseYpvsCDXhjiuiVp3g27I3jnZ7Z6z5SqoUFZV3za2HFSEiwgsqST/JgfHx4cNwKQa0GErOLxNnRutEZ3mN9+q2wT5dPTJ8y0SC6OYJGwp+5J9eeQjJ4A8NEtfGD874DUMoD3sZFQhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lr30ytms9pUo6jg1aN6Xr2GbvukEM4o2dBN/80lHMuw=;
 b=S7xqRVj2OHVAZd3jReMk1kBBKwjO/KNtXIHtlSHK9AwUx7PtvZpO8zc+6sbN0yVO087Bwm0ykZ23UnrT9LmcL5nXGqR5dGAzXCyjGJ/QV20sd51S6OhzeE/+7cR+LIOLQeB/OWWdPW2XX2ztSF8UkM4ny3ByUn6g7G/o5+7ymsp4VxUtp3WTGV7qWL9lsT3DTd291Xxm/YmD38eUV+Fz/Jmy7vxlpBawpcjA/+xo4JEbWIJ1AfH/mRyyrb5AH/HBfxy29b6mui5RHrPyIkIgnZ+8XFSvNOyakLxLhtLKxumLTA39rfL3RL9CvdC6VaHoOnjdJQrclbcf6d86/Z0FPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lr30ytms9pUo6jg1aN6Xr2GbvukEM4o2dBN/80lHMuw=;
 b=m/q55LWRugp2kTqNMCYsSZk9pPQJWxuqsdjieA9D3VURKDBGqaSJVt4AvAqQsjZkZtX5PYKUpUfkQCWLaBbkDE8ZZG2NEF27GTuuQR9Qh4y0umg/U+F2KjkchiGJNoYkYHjMh8krm7eCowQHkYVAElZqPIFcvCI0MgQrB0VdoDk=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SA2PR10MB4476.namprd10.prod.outlook.com (2603:10b6:806:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 11:51:25 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a4ab:7076:36d:a488]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a4ab:7076:36d:a488%4]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 11:51:25 +0000
Message-ID: <0911562a-4dee-4942-9170-f5ec2678792b@oracle.com>
Date: Thu, 29 Feb 2024 12:51:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 5/5] misc: mlx5ctl: Add umem reg/unreg ioctl
Content-Language: en-US
To: Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>, David Ahern <dsahern@kernel.org>,
        Aron Silverton <aron.silverton@oracle.com>,
        Christoph Hellwig <hch@infradead.org>, andrew.gospodarek@broadcom.com,
        linux-kernel@vger.kernel.org
References: <20240207072435.14182-1-saeed@kernel.org>
 <20240207072435.14182-6-saeed@kernel.org>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <20240207072435.14182-6-saeed@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0043.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::17) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|SA2PR10MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: cac34dcb-1385-412f-625e-08dc391cc1b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ctwwCJGQr3bzpa0gPp74v+oKpGwcHcLBVc+FHZQJ8ElpHbreXiNwWLfTMgD3/s+ZqNmyoS5OIdNlGG/NqZCzi0TrBLhqWD1ekt0wiGX683nZxeKN4GvrqLGHxz5Sp+HdEucShwDrPNtRbrwd70ekCAa5FQyu+9qfkEwXOW5x2tBGqW/iHz79nK9EvxRiswuBOcqAqcTRfn/ai5SXBkca4gCuM+Sx8xEGpNn8RVosiYG4rmOnI34W0KMVJVVPKUw6powlJm8ZBXdkzjKWWtgXE5ojghpriw0y1z/YGQ+LorFQgJ85uULbtX4ljKsMBDMqQe653aI5bC8LssI48yvuIrzMblRI3kEZR3ZlvXnJl/D9pPRznjhSS5BBVhR8cVFtFWSQRXSQt7BruLN2umEDjsfKEPRFMCpAg5mPQQBmzuMzB7i3KCj2AI6Ium9P6L7SQKSoQEmUNb8k4AAgMUQZBdpGB6T1Og16N7vYjnzbcqktFe6LbqUZINvMWnMmLJdxt923ElXl995SHd7EZFbOahQ3IinEagbzlG+0K/RoSbHcNJfwy+DjUbVM47eMkJqqPdPf3sRTbTbAd/kbJxuovy5O0ym6O+DeI6YgolQ4C7ynC7bTaLwOckJbhYT4d4AUE5vI4BBGdV+zK5RR4IF09w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VGxqd25GbWY2UDhCK3NINmg2MEFjMm56UW9RdlF6cXFjOXpWNEpIbCtTY3RU?=
 =?utf-8?B?czBLWGRiT2FCL1VBdEpIOWQ5M0J3bkdleFhvVVNGS295MEZFcEN1Z2RZT05W?=
 =?utf-8?B?dGVacFk2bzZPQ3hBTlRsM1g5THp1VEt5b1BxcWZQZk1DendOV0s4RWZ3WDlE?=
 =?utf-8?B?S05odU1ZV1NDU1BWNDFHWFdVaHg2azUvK2svUzl6ZWVXUlh2RWZEZXBlRHB4?=
 =?utf-8?B?UWthYVhrRzd4UzBqZENmM3JFSDNxeFVtaHNwOHdwbmxsdHdJMzU4ejlHUExv?=
 =?utf-8?B?UnFzVGFzMUd6Q1JHM0xBUVpOQ3d3NlBBM0JBQ1J5TFdaeC81Q2xiRG5LMUk1?=
 =?utf-8?B?VGVPcG9nQUNHYS96VUhUdHBnbTRtMnNTRVd5cDN3QnBKNk1JNFJnVzhOcnVI?=
 =?utf-8?B?TVZUVWMvck45L09sZ2MyMEVUQUVDbGZvbjY1cTY1am9UR0RLTnhqV3NSSVlU?=
 =?utf-8?B?WXNKUW1JamFnWWRGYTdCSUsxaXVlcktKWFZjbDFpb201T1RoNU5SR1oxSzZr?=
 =?utf-8?B?N3BGOW54Q1FFT08xM2R5NDU0OVlJMEllNWtrTjFFa3lnN0xlNFhycFFmN29G?=
 =?utf-8?B?VytPTlQwdll3YUhsVDh5L3J4QkV2R3FUVVd3YXQ1dWxZaUNVUStsYVgvOERB?=
 =?utf-8?B?R3ByN2UwSGhhbUNOS1ZpNWt0ZDB5NmJNVE52WUFHS3VMc01CMUNiajJIN1Zr?=
 =?utf-8?B?aDRXVS9XcVBHVmpNSjhVekNEc1BhZ1E2bFd3dWpHcFY4NlMrY0VJc0VSTCtZ?=
 =?utf-8?B?aXJOZ0VQa3ZsOXBuazF0TmdlZnFXY2dvY3k4Rk52T0hGNHM2dkU0TTM0WkFh?=
 =?utf-8?B?V1R0SlFIV1lhYnZTeFNFRWpFTldoUVF5ZXlLTERWVWIycW5OdDdQTW94SGVH?=
 =?utf-8?B?cU1OVHM3U2lwU2tmOU9ON2hMa091aU5YMUxsMEJTNVVzOVY5YkRzeE9KZ1Y5?=
 =?utf-8?B?RWdHYktzWGptWjlvejNzZnU5TXVnSGZkbjhqRXorTHR5UXhZQkJicUdXOGRV?=
 =?utf-8?B?ZTZES2pKTDRJZE5DUm9GVE1GblhRNThPejhnTWNqQ2NzVWVyRVBmU1A1WmFr?=
 =?utf-8?B?eHJsZmFjRUcwU0ExWlRSUlFIOGV3RHd3aVpueUhaTjVvd05rM0dYN2o1Rno3?=
 =?utf-8?B?ZmwvUTI2NXdPaDVDMExCQ2xHT1RzbWNmU1cyQlNHak95VzJEZ0dUSGpmUFJU?=
 =?utf-8?B?VnNVT00xcXl3MDFQK25FMTJ5c2haZDJpbXJTVmxGdFM4YXZlN3BacHZaQThW?=
 =?utf-8?B?UzQ0SU5tUy85YXJWSWFSUVVCWG1XRS8zWkZmVkV4M3FhM3JEbkdsRFpiSnU4?=
 =?utf-8?B?TjdERW94Y2V1UE5IRkJzZmRUNXJWdldPazNEcWRUM3FoTytkZG9GdElyeWJm?=
 =?utf-8?B?LzJ3Nm1nRElTVWsvYkpHWGZCNVQveTJLMzUyWG01TVFJc0lQUDhvRVMrZis0?=
 =?utf-8?B?aGNjY3daQTZEaEx0dkVXeUp5ais1WEtteEdyZUN5Z21vNmlncDJqakJ2WUpj?=
 =?utf-8?B?VFJiZ25xYUZaVFhBcFptdkNNelRYQktWZVdLNlV2NWpkcXpmbm5VdXlKbGhS?=
 =?utf-8?B?aVlsVzc5VEVza054V29hbzUvMkV6djMyc2VWZnpFMWYyWjRCdkx0ZERpcnhW?=
 =?utf-8?B?QkVyZzQ3MWVVZjFSRTJiM252UzRjalBwQjdLaDRnd0ZQQ1F0WVNxMHBWSHVR?=
 =?utf-8?B?ckZwZUlTV1R6WWQ3ZU8xWjZiQWV4YjczbzlxbEhzeTZ4dWRqVXNIZU1iUlRV?=
 =?utf-8?B?RTBxT216SnQ5b0NVUEdUMXlIZUZrRkJxQ0ZhNE9uNFFTbzZCazczYnRidWNW?=
 =?utf-8?B?OUU2L1JSQU9FQ1NqVlJkVnNEZURjN0tuVlpWajQzS2c1UGx4Z09Zb0x2ajFE?=
 =?utf-8?B?VEJwTGdyTDg4bS9Mc3E0M1VJZEdnbG1YKzE0YXBGd1pseDJZcE9VYUVJNDM2?=
 =?utf-8?B?SEFEREQwbS9nc1dGQVVXUFJKcUROeWhRdjFqckppeWJwUC91Y2hZaGVKUzVG?=
 =?utf-8?B?U3B5cFZKYkNvSENwVHdQREpnenNDV0w4dHkwWHQzQm8vKzZOajFFOHpuRVVR?=
 =?utf-8?B?K2diN1pJTjR3QisrQkFhVEpabVBjbFRneUsyUjB0ZDdlRGEyVHErNEFHRUtJ?=
 =?utf-8?B?THNZT0I2cHJkTmdhcTRoQVFGTGtFNVgwNktnSFc1em5BNVh1Z1ljVStQSEQv?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cKJWSLxXB79eYxUkjCCHvN8opXFF2Xpi9WFfRkSScRP7f72dxck0bRZyTAOO+F9h3LBPUSsZhTJcPg4oOMR+sUuAGV6dpTxEj0fqWjWu7txXwT1VsMyy9VsSsnp9kqf7pzuWR4UN0gL+A5WufvIgNSUp5WGhXmcWy/c/UahKKj3suzec1ywozk13DDpZ90kB/zeuinoYIS/Wq7XsVa1vhyVwYxlwyfLhJPSowdjnIpXpsvPhlgelMeAmY9zuRO0AeWDSfNpzfyxJwY4Zh+6/cwN8pBOLEQ4+E51YBsDcle6VDMvKbXhJ/Ks9tHk/RPhelCl8REzdVLy9pO2jE3mjhrq6Gk7RtkJvw4fvmk5ykAS8GKvNjnamzu6t8tf76QPd9izM3NdFmRSLFtu8UfBqI2hRyAKMD9HFIduaS5/uYB0d1WA6bsSbJt3LG+izs7Mr5I9EQ2a/HTWoFQ7oya19THpM41DOJML8vy0mw7Co9Zl3IQplAhpeVDX8LYTIO1Riogpn0pbcqIOwjFBPFc+dajOClVXd6a4iGta9q93mSfZ4pjL4j9BHiKPrtxZjFyo3h72ifR8Gp9pFwIpS7BQwBRmdCkjnY2wrUHJvGp3g5I0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac34dcb-1385-412f-625e-08dc391cc1b9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 11:51:25.3980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tCmIAqV38zETYpAQOje2Dz+R3y0lSn/LgH2uMY3b0sZoPIAg1Ycmn8n6mZyqSel3kQooDMZTGZ16sTlqYwwFvqhlGw+a/cL8T9mujp4AnfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4476
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402290091
X-Proofpoint-GUID: Mwsmfr8NX-nCg95vL3un0WoOXKOOT49f
X-Proofpoint-ORIG-GUID: Mwsmfr8NX-nCg95vL3un0WoOXKOOT49f


On 07/02/2024 08:24, Saeed Mahameed wrote:
> +static int mlx5ctl_ioctl_umem_unreg(struct file *file,
> +				    struct mlx5ctl_umem_unreg __user *arg,
> +				    size_t usize)
> +{
> +	size_t ksize = sizeof(struct mlx5ctl_umem_unreg);
> +	struct mlx5ctl_fd *mfd = file->private_data;
> +	struct mlx5ctl_umem_unreg *umem_unreg;
> +	int err = 0;
> +
> +	if (usize < ksize)
> +		return -EINVAL;
> +
> +	umem_unreg = kzalloc(ksize, GFP_KERNEL);
> +	if (!umem_unreg)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(umem_unreg, arg, ksize)) {
> +		err = -EFAULT;
> +		goto out;
> +	}
> +
> +	if (umem_unreg->reserved) {
> +		err = -EOPNOTSUPP;
> +		goto out;
> +	}
> +
> +	err = mlx5ctl_umem_unreg(mfd->umem_db, umem_unreg->umem_id);
> +
> +	if (!err && copy_to_user(arg, umem_unreg, ksize))
> +		err = -EFAULT;

Why do you copy this back to userspace, does it even change?

> +static struct mlx5ctl_umem *mlx5ctl_umem_pin(struct mlx5ctl_umem_db *umem_db,
> +					     unsigned long addr, size_t size)
> +{
> +	size_t npages = umem_num_pages(addr, size);
> +	struct mlx5_core_dev *mdev = umem_db->mdev;
> +	unsigned long endaddr = addr + size;
> +	struct mlx5ctl_umem *umem;
> +	struct page **page_list;
> +	int err = -EINVAL;
> +	int pinned = 0;
> +
> +	dev_dbg(mdev->device, "%s: addr %p size %zu npages %zu\n",
> +		__func__, (void __user *)addr, size, npages);
> +
> +	/* Avoid integer overflow */
> +	if (endaddr < addr || PAGE_ALIGN(endaddr) < endaddr)
> +		return ERR_PTR(-EINVAL);

There is a check_add_overflow() macro in <linux/overflow.h>, should that
be used instead?

> +
> +	if (npages == 0 || PAGES_2_MB(npages) > MLX5CTL_UMEM_MAX_MB)
> +		return ERR_PTR(-EINVAL);
> +
> +	page_list = kvmalloc_array(npages, sizeof(struct page *), GFP_KERNEL_ACCOUNT);
> +	if (!page_list)
> +		return ERR_PTR(-ENOMEM);
> +
> +	umem = kzalloc(sizeof(*umem), GFP_KERNEL_ACCOUNT);
> +	if (!umem) {
> +		kvfree(page_list);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	umem->addr = addr;
> +	umem->size = size;
> +	umem->offset = addr & ~PAGE_MASK;
> +	umem->npages = npages;
> +
> +	umem->page_list = page_list;
> +	umem->source_mm = current->mm;
> +	umem->source_task = current->group_leader;
> +	get_task_struct(current->group_leader);
> +	umem->source_user = get_uid(current_user());

I think you could do this, right?

umem->source_task = get_task_struct(current->group_leader);
umem->source_user = get_current_user();

> +
> +	/* mm and RLIMIT_MEMLOCK user task accounting similar to what is
> +	 * being done in iopt_alloc_pages() and do_update_pinned()
> +	 * for IOPT_PAGES_ACCOUNT_USER @drivers/iommu/iommufd/pages.c
> +	 */
> +	mmgrab(umem->source_mm);
> +
> +	pinned = pin_user_pages_fast(addr, npages, FOLL_WRITE, page_list);
> +	if (pinned != npages) {
> +		dev_dbg(mdev->device, "pin_user_pages_fast failed %d\n", pinned);
> +		err = pinned < 0 ? pinned : -ENOMEM;
> +		goto pin_failed;
> +	}
> +
> +	err = inc_user_locked_vm(umem, npages);
> +	if (err)
> +		goto pin_failed;
> +
> +	atomic64_add(npages, &umem->source_mm->pinned_vm);
> +
> +	err = sg_alloc_table_from_pages(&umem->sgt, page_list, npages, 0,
> +					npages << PAGE_SHIFT, GFP_KERNEL_ACCOUNT);
> +	if (err) {
> +		dev_dbg(mdev->device, "sg_alloc_table failed: %d\n", err);
> +		goto sgt_failed;

Is this correct? See below...

> +	}
> +
> +	dev_dbg(mdev->device, "\tsgt: size %zu npages %zu sgt.nents (%d)\n",
> +		size, npages, umem->sgt.nents);
> +
> +	err = dma_map_sgtable(mdev->device, &umem->sgt, DMA_BIDIRECTIONAL, 0);
> +	if (err) {
> +		dev_dbg(mdev->device, "dma_map_sgtable failed: %d\n", err);
> +		goto dma_failed;
> +	}
> +
> +	dev_dbg(mdev->device, "\tsgt: dma_nents %d\n", umem->sgt.nents);
> +	return umem;
> +
> +dma_failed:
> +sgt_failed:
> +	sg_free_table(&umem->sgt);

Not sure about calling sg_free_table() if sg_alloc_table_from_pages()
failed.

> +	atomic64_sub(npages, &umem->source_mm->pinned_vm);
> +	dec_user_locked_vm(umem, npages);
> +pin_failed:
> +	if (pinned > 0)
> +		unpin_user_pages(page_list, pinned);
> +	mmdrop(umem->source_mm);
> +	free_uid(umem->source_user);
> +	put_task_struct(umem->source_task);
> +
> +	kfree(umem);
> +	kvfree(page_list);
> +	return ERR_PTR(err);
> +}


Vegard

