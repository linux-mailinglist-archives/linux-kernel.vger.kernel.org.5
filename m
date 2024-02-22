Return-Path: <linux-kernel+bounces-77246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1AE86028D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5F91C23277
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EC7548E5;
	Thu, 22 Feb 2024 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YVXgT5Aw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mJhICPZU"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B6814B827;
	Thu, 22 Feb 2024 19:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629714; cv=fail; b=BGVy6JAvCp+ezCXBnwFyrGDuXTnVzuqq6XszFiJXOXzcZo9qkXPv2+XqxEfLNwl0RLojNr6QHniDnOeBL1N/jPMq263os8zvCwleQko2XXM9uYr/fz15GNPda6iLd+0wgHLWvdMXD1z7nHTp/hSIpzru1GtgUBiMDZ/lGAb6ajY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629714; c=relaxed/simple;
	bh=fC3jtacD7TsbL/YXzjhlnDAGsqKowv88TOXkRFBbwbs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Agj6PjX9/tlapAX4D2XCq2jSjrZIqC317vL6FWEYYf1Jrb653nCa9HuuVnVa16c1A9/MnmhNy6peCHV7b5rtzqgK/+Z1NuJVkhxrt56zCuL6XS09d0/2Xn4KSPHiNY0jqiMCa1YaJTUYwtEakyB447YYHelxe0MSpM5rojrh3OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YVXgT5Aw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mJhICPZU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MIYLG4017721;
	Thu, 22 Feb 2024 19:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=LHXsol/9mMtRQ1rDEzm0lOr2xOQQ4gUTMUSkKF9Ofik=;
 b=YVXgT5AwfuEhgPdGYAPzBJk5sRF0e4RyGiFjVoTmPGxTmHXoXyRxHQ7jZoy9aHZZQyK1
 SWHWARFIA7i1sYLgavUbshdtSgYsHQZhqzBFvdrnEu5I29lSbUnceEqa2gnR6C8xnxo6
 CPmSA+nPmk1AjwW2VaUVIPVFFhE1HHCIzpAOdmClH/Tv2uiNWdg/SYiKb+2KBwfxmwH5
 5eDSf7sG6alHjvRf4LPkMQyeDlXMRBp9jl9b6VCBdPzCsg7DdbKAZS31fudIZJoGnsxT
 yNawJKRd3WNIqi+4/seTRHYau5tAQHnbSd7emSw5AmKsSNz/A6lv1GfNUnu0xYOQQLyM Cg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakqcdpdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 19:21:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41MIvB4o024941;
	Thu, 22 Feb 2024 19:21:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8b4au8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 19:21:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4olk6knWWb0FPWKg6xoYPpOnnnuyTOw7iPfSIFAN9jHjRf8AxhbqF32h66+9sTFDYhdqHpymL2M4lNLxuizx1+n/zBSBoMXvb2u9TM/joMPIn397mRiWBNwGEwlYHsRuQPL2+h9Oi0wjILcXbedpxS2kBlDcuCp7ljmL45mpeQjJkP5THUTaEpeNVAZ+SHniAWzyiqCZEma6Eb62mfIoE8oZO9felNvLySNq1elvcU++NDhMwlJMsPDNCWhoJ3DxaXflgBeeSbWudtJ0nN8MAe5CVJjD5WP4M8O+kuufasIxQr1SvlRTan3Lb2V3kJudVbp6LKYeFCjACSa16vRjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHXsol/9mMtRQ1rDEzm0lOr2xOQQ4gUTMUSkKF9Ofik=;
 b=DpghuOJoEPX9j9bGnEoVsKX7X/m0aiuTgpzWorpJxfdYKVaWxhcPXy2lJtdmeBWU9ErIAEDuFksp0ZbnUsYhrznIPwxsa6iNjyLRnuhvoCInTVeFl/YW/g11x7Fv/Q0OfFKLSRmaL/nqpMAMgDwoLUvsfWNcpGx9f+AewCNbv79PYsspLQJuRJmlOLISx2Jju177h7XzcwryDpuoKEhJLQG/foaTj84kiuk/kipSiikrKoKzi7NHCqV3oYWfeZIOYtepYGZlbfsuI/qzv9c6bfqYfsY0Ib3LMn/83RfTMY8q6+2KHgb3zHQkUxbzgv5GkuuRIj54B7qIRzrTXuhWMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHXsol/9mMtRQ1rDEzm0lOr2xOQQ4gUTMUSkKF9Ofik=;
 b=mJhICPZUmd/rvkKKyS4CPijfjHQAVzBMos6tPXpAdw90L6T5G6SzQq2gSq44We65zVEpzrXWCpC4pqC92kcpKgK5PbSV37yrLyKnCRsTBtMD673Uphd7bM/vHWc3T2zZz96el7Ua7vhmv8sNJkmtIJ7YvR59w4V8ldKwO/MMlSs=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SJ0PR10MB5765.namprd10.prod.outlook.com (2603:10b6:a03:3ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 19:21:06 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183%6]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 19:21:06 +0000
Message-ID: <2ad690d1-30db-460b-813a-4bc40bfa55ea@oracle.com>
Date: Fri, 23 Feb 2024 00:50:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 000/202] 4.19.307-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240221125931.742034354@linuxfoundation.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240221125931.742034354@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SJ0PR10MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b18be0-e259-4d8a-3da9-08dc33db6acd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qWRwki76EsA9aG74zkRjqUURMz29aeeK049pCGyFurYMibXXeKbNZCcpM+j205dvgWAqo6hWHyrIEkoZFMb3edzrv1UmEk359b8zK8Y8kUCpU7AAk1ba12pqscVaqoLDWpKHbmeUXBSGbRoS/Pe71MMjuLcKACrT4myJR1a018QiAAfEZyTyorrg4KKnewhccBtTixtBvSwEwiVTybtYdjTyyHlFcKLj8D9j1Cosuph3IUlVB132rbqr0lGf6LUbpCCfZ43EE5kIDNbUkU9eX9p9ysd9jkjMlzBWt8lsLK0LlHp5D5Qv0NzpS8g98cMW8PlH6KVXoYxOa+/fvRMaV4KuoeEEgRcPtAuAaH3bXR87h59aH/BL+ivRKixjXplGPsYIG/uKanYv9j2GeZq+v6kv4DDwFN7GkWMzY2FhvtBOwvPrxiiLq5cgAjyeC5+UVK60rIQtSSUnKuOW5e8IPggtWkeccKJR7tSCXCzrw/HmVl/VU+ByTrHjJD+W06upJ6JHnp9PwaSdRWLlexUlYA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Mjl4UXE1SnlETFkyLzBvNGZZcCs3TXZabTNudjNTU0kwL3hsZUFiU1NQZWxM?=
 =?utf-8?B?ZDBXMGU2N0VULzFvVUVaZFAyWWUzVjRYT3BMdkdPQ1k0Z2dlNDl5bnIzTXJ2?=
 =?utf-8?B?dzltUUNRQ1NsWnQ1WmNwTFNVc01qeW52QnRUWXFkLzRMVVRVUkg3eVdzWDY2?=
 =?utf-8?B?cnY4YjFSMTJDeW5sZlJRMUJndTdjdlliV1BxbEVYTkpGQ3N4MEdEVG5CQVJa?=
 =?utf-8?B?bWJhbytuZjdYYjZTVDlTMHZDdUUvT1lEMWxNRnM4YkZPWGdNU2ZKQk1FM3do?=
 =?utf-8?B?NEViRTFSd0IvdmdOekYvQW9ycWNDMDlqUzlKTk5GK1FaempkRW1sci9vaVQr?=
 =?utf-8?B?bzhEL1pYSlJKQzV6TDA1a0hZRkpTK1J2WWdtTmdVQ3Arbkx4NXhQNXdEc2pm?=
 =?utf-8?B?YTZFajRMNWpISXUzZkdYQkxwZDVnTWR2TWl3NDF2elZpeWVyV0FvNUt3aWFK?=
 =?utf-8?B?Ry9JM1BDZkRpcm9KcUJaZEVXUHpFRGVXZUdKWEZ6L2hBVUh0VEtwQjFRK0o2?=
 =?utf-8?B?d1ozaWwyYUhpNEVjd1BubjdjU2RsUEtQQ3E3T2Q1NUx6Y1c5UFY0L1dTOTB1?=
 =?utf-8?B?MzRMZ3dyVTJWdnlxK0Q0U21PTFhSNzZ2ZzNXK3I1MGhtWXl2Y0RISkxnVmlT?=
 =?utf-8?B?QlpiK0tkZUdhbGJIKzFjbk44Vmc3ekR0a2E2bGZ2dFg3ZUJWTGVqbnNkWndP?=
 =?utf-8?B?REJuelZZWTBpeU1nckpsNWozYjdRWmJpQ1hBNkdCWDB6WmV0dEdITTRIV2xC?=
 =?utf-8?B?bnc3UDM3VVFDbVZpWXRQdFF3R3FMSTR0NGh1dXpSaGdySjVIaTBjQ0QwK3NJ?=
 =?utf-8?B?NVBhTUY2Q0FiSkgzRXZUR014OGZ0bEFnZm1LMTRmTCtxeWg4bVZUTStMeDBR?=
 =?utf-8?B?VjhIUjhSQUpzOFJsY1RUdmJDcE1xd0NwQUhUSnlCOEVpWUlBN0ptVjdhSzNC?=
 =?utf-8?B?bDRRNlR1VUlsSUVQbU5WcWdsWFhpb1l1ZmNLNkJITDVlR2tWc2s0S3pCZW9L?=
 =?utf-8?B?ZytrRzN4cmt6S1ptdjFvVnFrR005NlFnOE5LVGNVQ2llNzM2MWhCOGxjR0xr?=
 =?utf-8?B?d1dEY0Y0NmU4NDNNUnFGWXR5UjN0SjBMYWZELy9oUVNZVmYrbithS3BmcWw5?=
 =?utf-8?B?Wkd2bHV6Vzl6L3NSYkVHM2ovQnFwUWNGWkpnd3pOWTNRb2h3VTBWc0JibllU?=
 =?utf-8?B?aUVieE9rVUhaN3p6YWRvZEhlRmptZ2s1bWRNaFRuRUkyOUVKNW91TXpTdS9q?=
 =?utf-8?B?UVcwQmpPSlZlSWJLR3VYMTJsK1p3aWgwdnNialpUZ3puV0hTSkwrVHcxa204?=
 =?utf-8?B?ejJRVzZSNG4zb2hSeEJFc0FDVSs2VGRPYlZ3aFh3ZzQzczlsazdHeHllRlN6?=
 =?utf-8?B?K09qdC9NSHJGRmhMa09ZQmhleThQWnRuMzNqM3lGejdQQjZxdmVaKzFQUFBP?=
 =?utf-8?B?ejNKQy8zUUdZdUc5MnFlWmcxN1BvVTgyQTRXNkR3aisvSmx5cDlaTkNtOUdO?=
 =?utf-8?B?MHRDWnNxNjluWmY2eE5uMGxEODlZVlFjNVFkQmJkK2h4bFo0cFF3bmwrdDVh?=
 =?utf-8?B?RWdTcXdLemEzR21FVWx2VmFKZkErVllYaWpGZHBtbktSUFNHRzFJL2ttai83?=
 =?utf-8?B?b0NWRkIwQkNvTWR4cGhsT1plVkFNZ3pRRDhFQlNxYjRwUElXZ3paOGRlRVFv?=
 =?utf-8?B?UTNlTmxMdmFoSmpLaFdjL3N3cVNKbDg5eTZvNklyQ1BRT1pEbkp1VE9Hc29x?=
 =?utf-8?B?dW01YXBUR1NOOVMvMndmcE95SS91bkM4WXdNcGNzd21IWXpvbWdNYzdQUy9S?=
 =?utf-8?B?eFhGMURMdDBTZXJOUW1aU2REVWNLMk8zaGxqc3lkWHNOdnIrTzNWSW51eHZ5?=
 =?utf-8?B?NGUrNFJOU09UdkpFSjBuQ1pzYVRLLy9PSmlGL0xBY2tPajhqQWkxaGtUZlZw?=
 =?utf-8?B?NVFBekVZNW94Ri90S1haYm1QNmpZU3A3empTSXNTdGZOclZWb3hZUTE5RXlS?=
 =?utf-8?B?dTZhRDR2Ullid3RZSG12QnNOcDJnVnBlQWNPM2dnMkt5bk9qdGZrTm9VQ3pz?=
 =?utf-8?B?MGdQOFBrTmUrWlJFKy8wbmNhWU1ZYUkxM3NKaStqdVJSbE9WcHJlUytjNWxV?=
 =?utf-8?B?YS9NNDMwTzAvdFRUM0wrQjJxckQ1cVBZTGVqc0U2VGFIdDJnWmJIeHIrYUlC?=
 =?utf-8?Q?xmCTHti+xQ1SR57E31gXbZI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/aJr5NJs+u+BvcoB2b9ELSfwYaR7znIuK/B2mrsI8DvWfOxtcJsiXwv8Q7C7Duv4jO3Osqf0J0Liji7tGYnX4GjESzSgHwGa6Jc/mH8vblCC4XWRYtMivl9XMcoHfPrZsGGbe9I0myOXl+QRAEW9afyUp6lvacn1dhWzdQDSbUbk5ajUTM17JfP5rNPkSnmE7D3DfP+PmP1/s7mymQkFikTYh5qgRsyF34HcZW9kYVaWjjQdRYwfE3Ts6WRhlcUClITiyOI60wyl4ZnDsePhczW51YNsUVMxowkQAcC6ZuffQmHcgwKeOvjxQUIkU3r5jzLTWsfwx77Fp+T16967damRyjyiXE2sd+JCUUq7mjmuaudDUwve2PmrncnjtwbQ3Tr8jvGuPx5Z74XJzy6JffZDEImRPJdPFTW8FxFtbxnqKpJ8khg8JpCdnKyr1fd5qCw4wHund5l36E18YXAGqp4V9Q8JFJ/dHfByNzAxoPJigCYMh0j6DPywYAnkWFi0dRfZ4aMUEJ8Rrfn7NUV/wD1v7M1xFQBz43wAHHLu9txtp938MSPuiXxXTnOo1gkPWPUvjLgSZij6XQcQ3JsAEz1CawjPZkiBkL/obgx6Ljg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b18be0-e259-4d8a-3da9-08dc33db6acd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 19:21:06.8313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okTnjxkw80kf7VnHnijs8XcAmsFU5g3Xf9VyvhTbDTvNWtxHXdyzBQ97bTL2OYXuZX667RpRvkq4KwM71IBSoCjtMWO1F4otXIqMOc5L6zberOwvZbF8Z+QTE+3yuPlD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5765
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220152
X-Proofpoint-GUID: xfG0hxYQ8D16gBaamDo8s35CCrExoSRe
X-Proofpoint-ORIG-GUID: xfG0hxYQ8D16gBaamDo8s35CCrExoSRe

Hi Greg,

On 21/02/24 18:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.307 release.
> There are 202 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
> 

Built and boot tested on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.307-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

