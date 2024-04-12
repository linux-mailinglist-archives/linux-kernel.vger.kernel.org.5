Return-Path: <linux-kernel+bounces-143119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B158A3490
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40BD11F22826
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CB414C5A3;
	Fri, 12 Apr 2024 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RbwYtOz4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="egZK2jyX"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767FC14B06E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 17:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712942362; cv=fail; b=p+G9LVmO0fBF2uY2OGjXKGjpHL6PMkATpDjWaDqSOGTU9mT50Bb5JjXnOOOWZNJXYFzSFykmPD82/95AOKAct8/p4yJMsJ+0jpzxMOT0sPH60wuydT6G0oGHZ24JGZjvZA2td+rcrzHe3dLjRMAHmwO0260qkR3II+3468oabcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712942362; c=relaxed/simple;
	bh=IrTb4IEx4djwgsZRMOxRFfMTPmR+DlxrFBFt7ZdCHOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I4XWjyS9MAGZsEyReWSv9JB0iU+zJLUM+RSiING3IQixPqprJSeFWPRrRAcTMy/T7+pgs6Ma2zUW5LqMxmh4BeHYxFxFKtEva/lZitE6MsUwJ8fCuKOoN3lYKqLNvU1ZOaQu/gmvbjEsKiB0x3D5ypRkJt+mg/pWvVRCIWl6cd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RbwYtOz4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=egZK2jyX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43CGToEF014810;
	Fri, 12 Apr 2024 17:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=iJAh4kBC45qSmjaTCMGZX+Zm7upfshMAFXo4DPHa6T8=;
 b=RbwYtOz4yn3AJ/nZiFDWD7m0llTZfcJNKKHHf9yiUzKVDZJW2noEURTqJHWju+M7/fpm
 FSQh8RBl9dp6NJi+7Id1i1T5VklGbx90emf4K+hfbD6s7hchaCme4sPXhteeyTP08jpM
 oZr/HSX0bPQjN2gqqkaon6y2R+ZCLGj4jJq2hB6wslgTk4I0KF3TsWv/wNaDTuuCqstN
 LbJ/ZDmvu6ZbJwfaa2mB2zDlIjwiyq50I0OnB2p6Vp00YgaYKHIqCdqA9YkuOY1uGzMR
 je1JVkBd4yzbIU2HsShO4NvGkcdtbG1uVExnZmI04ucpR2kqyuvde751i4nFbjFxVk8x sw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaw02cg75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 17:18:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43CFlobm032408;
	Fri, 12 Apr 2024 17:18:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavubypv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 17:18:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzgZQmzCsaF3xGpRatpz5RL7kY76YM/GAijuQPPvPGBlBGtLAU3p7xe5cg5nJIHnKaH2HkIzGaxmypuIXYv1orW8jBV0EeXvBnNmJkizhkreAPLMk7b5Vu+cV396fYphp1fKPBtOZ+h/rVV0L5flCi+tGdM35i07nSNGiRb1Tz7V2s7hD+bPaxHGdHxURimIIOyljF6d2IPBWLk+xDUa97y05rjGBhs9lrn6EOIZSZJv+vFiWPruq3kAsKYLL4CGV32gReSYAzZ6xqpvssEmVq2ZEMjiXZR6OVBu0eq74tea+gYMV9TLMe6dwOR3Aku6w8keIsHjm3Ve8/CSd3lU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJAh4kBC45qSmjaTCMGZX+Zm7upfshMAFXo4DPHa6T8=;
 b=hcb0E+rCz8PvqvQNr2tAcYG8f0m3eppr92UZDtpTtyR14K02PkK4G+zPmB7YjDytspkCM0CcGwMkvZz+r9I00A6LhPd3BOAs6LD5Vp+jDKDuFFxYonyksoBibdIOAWETHW4+P+GXXb7b2YSg/hvSbkBTn/Ys9YHBFaGzu4yex6tZssjV04nw+J4LRriXttohc5QTFPWoK6kPtDCqq8G79U0Je01ZeszIUBV+m22HIPxMJHeRAzc125PzWYx3VhGXBM5UxB5W8OjskeOfGX7Oaci2Y63omUSOfzm1GbWO4N0O7ioOQ6Vi3XEnZpy2tgy152JewnQokfAHcKYV3m/pjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJAh4kBC45qSmjaTCMGZX+Zm7upfshMAFXo4DPHa6T8=;
 b=egZK2jyXMnW+ayJYSLdT8U2tM3B6720x+0O5sdj6fe3lgPmxLx8FUPcZ0/5o/HieI5Sjfmm8JI06JWPaheIKe1WsXHMpu/mZWnTpRl8mpnl7GVTgYF4NNLKaWrlO4efaBiRVbWKHqb68B8zqu9CDXhHnXHL2iVpzoZtSw08AUZw=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ2PR10MB7812.namprd10.prod.outlook.com (2603:10b6:a03:574::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.56; Fri, 12 Apr
 2024 17:18:53 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::d359:1b95:6099:3550]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::d359:1b95:6099:3550%7]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 17:18:53 +0000
Date: Fri, 12 Apr 2024 13:18:51 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org, vincentdelor@free.fr,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>
Subject: Re: Increase Default vm_max_map_count to Improve Compatibility with
 Modern Games
Message-ID: <ugjnhfiwuoslupkbmrrbbxxdosotzpqjfljebzj4dkuibmf6sr@kuew2qemsen4>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Oleksandr Natalenko <oleksandr@natalenko.name>, 
	linux-kernel@vger.kernel.org, vincentdelor@free.fr, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, Pierre-Loup Griffais <pgriffais@valvesoftware.com>
References: <566168554.272637693.1710968734203.JavaMail.root@zimbra54-e10.priv.proxad.net>
 <13499186.uLZWGnKmhe@natalenko.name>
 <1a91e772-4150-4d28-9c67-cb6d0478af79@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1a91e772-4150-4d28-9c67-cb6d0478af79@redhat.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4P288CA0014.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::17) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ2PR10MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: a829a4db-3338-4bc1-fec6-08dc5b14a0bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	41m8UPlu2wB7uQZjrQrY3X0dV2hpm/65YBdb2DyFWnupD92PjSooPDtNt+IybLFsF6WknFix0dWail9NJodfFXsuExXkndrJXmh7vmYurK93NQaaMNks23HqawPrOXk6CmtZH/1eu77NsLEQNgSG126a7qf5aHH7c/czLHCKY4rjjLm8dmk0iWVYEzMEu/K8KcMlgn7tcEphWUlIDOlg8y5nZilNekUsA2OYb+PSuLrMlDzvXAVFFZUXjz7L8dAnppxJ1UcBUTgbuSi+T2Klsvw/gKdz0FWfWNgiMuwqQv8RaMA4FdJmaNflKevXuY3ehliLX5PAD3q/ByJ7QdOdEA8gxO2vCPYgjMxsAIdwZSO72BsOOo2gbePB0BB+iZ1oK+7hbzzMuJw3I3ugDpKc3E4tqBAxfvv45KVTNLbsPDiahEKnGiQcqQuczcuwQmtRzYmbW+VLVA0whvyf1xS/aubJ6R+ZrneUMuad7q6xvti1jCD8qZ9AIerqx6PFcRCBGVP7hJ2Ld+3dXZ67BfwJArXUMzxRuHLudTVAayMgvduvK8Qxh6aS1n0eHiTm+39LeM3nB5MmoCzXxlT6VMidTtu72K+QvdC0fyNGSCL5gYp+3Fhmv9Kr8gf/aj/9nHuL7s0umsgTMCGDdR9gDpVmeFpYe7MgTKsgdFD9dOX5iH/S27Ozvnlbg/RpAtWrIaUP2m8UkLWz9dWSY03cW/FVBQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(15866825006)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z0VaMDVFREwrNWN5dnZGTVN1ZE5TQ0syUkgwSkJsWCtIdGlLUWZXWDNlNFla?=
 =?utf-8?B?WERySlErYzBMNEs3bzFWN2FJbGNxMWNiYVI3Y2lkblBWMmFyZURkRDNqcEk1?=
 =?utf-8?B?bzZvcWMwRk9CZHgwZVdQSHNrMTUrbEJvYnlmOStSZk9CMHpHejRCc3d0UnJm?=
 =?utf-8?B?TFVUZHRWeUR5eVJNcVZlY0hIdlJaVmErVFUrU1l3S2JoaGZKNnhLdmhHN0VZ?=
 =?utf-8?B?UUZJMHJZa1Qrbm1yZGNaQUtncGF0WWsvaUd2L1JUNkgzcnVLSGVjdTF3UVVM?=
 =?utf-8?B?ZHQ1SVpaSzJzaEI3R0lJakZHeWFxU0NPbEw5eFcrRC9PeFZKQkh1SzY5WUw0?=
 =?utf-8?B?UFFrUHAzd0dwdmtWUUNaWW81Q3BCeDlNOFBENThyM2RBaStSNmkxN1RMSlg2?=
 =?utf-8?B?dHhvV0ZhUk9DemsvZExlQUliZmozM3pLcWdFTE1Vc05uaVBQY0Y2SVEvTVpY?=
 =?utf-8?B?VDBFVWpQQnZNMG01WUNMRlZOR3RreHlOQ2s1QyttRnAydlJIM1M4QkZXRDN2?=
 =?utf-8?B?ZXB5Y0lsU3JUMjZyMGR5NW5WK1hVR2ZFVm5ZMVI0bXJjZTRuSW1DcHZtSVk4?=
 =?utf-8?B?WVpMNHFqVjlDR2I0a2xyY3pOcmpmSEFyZ01tNm55dVo4UkNoa2pyNFVZY1FD?=
 =?utf-8?B?dkE5R0lIMkNBS3RFbUxzcnlPN0pmZ1NBb1dhTkxZOFAwVDBWSkRGd2hPZGor?=
 =?utf-8?B?WitMMU9qSFFaMVd0b3ZlUUtsNW00Vk42Zi9UQ2FHMkJvdVluZjRJWVZQZ2xN?=
 =?utf-8?B?TU54U2dpcmNtb0tPOVBiRisyKzhqMklDcnJLWGcxdkRQdzhNYjk2b0t0b2Q3?=
 =?utf-8?B?SmNWalBnVzVTT2xxcVB6MG9Kc3llbytJWnpnK2kzV2pKZWRiUmZSR2hrdXM3?=
 =?utf-8?B?OUgzZWVJRHQ1K2N1QXJGc0UvVXdPMlVwZ21kN0djTmE4MXdRbDJVK0ZtcXR4?=
 =?utf-8?B?aXhwQkpkano0Q3M0L05PTTlrM3NLY09LT3BVQTBzWmZzMUR2OUpqcHpuS0xW?=
 =?utf-8?B?Wk9JMWRpZEU3elMrZllTQ0Nla1JXRVprcXZmSFFaeFBJNXJaaHBVVm9ZNGI0?=
 =?utf-8?B?S3FsdHg1RnAxdStiYU9GWXV4M3BYNnRlVXBGaFNURURoZWxTNHhSMXFOMnNR?=
 =?utf-8?B?Y3Y1MldNbG1pRlE4Unl2VmF2MmJTZ1VIK1NSWXYrV2I2RTY3SnJKN3A1M0VQ?=
 =?utf-8?B?WlhMSmlicElVSVZNbFA1MGhWZ1JoMHIwS003aGp3WTRZVFZ1TWZRSE1FVmQv?=
 =?utf-8?B?dlJJQXdDNktlMTdSSHdDTkluMTc2Tk1xTERkQ3owb3owd2V2U1VmUSttZm5Y?=
 =?utf-8?B?aUdpRnFLcVBiNFhOR0ZpZnRIdmdTdXVyTDdleHZGWWlVdFVUR3MxclVyZmh4?=
 =?utf-8?B?dVFqUUpHUC9aRWJsSGlnQ0dMNmdjeXF2ZGZ2bXdwNnVuaFhmdGtkbytEaDF4?=
 =?utf-8?B?cTB4ODduTkFReHVuZkpxYTh3cXBMVkFOckRhOWdqd0d4UXJ0dEhEbHFsaEM5?=
 =?utf-8?B?NExyWFNDa01iWHNLa3Q3WTVUTnBxZ2FKbjZvQ0tqVGxIdDdJMXhHcVJkWTMx?=
 =?utf-8?B?SktjblA1TGd4MGJTVjl2dUJXR25WdTBramxnMThVcWtmM2FueGovQktJd1ZO?=
 =?utf-8?B?ZEZsN1F3Q3dxMmxycDRGTHZhb3k1dmxsSDRqWE52dXZyT2FkN2NWU2hyZEZn?=
 =?utf-8?B?NkhJRmttc2RIeDJqL1BoRndKaUpqakVFaU9ybDlpcEpUVkgyWEVjMHNqQ0Ey?=
 =?utf-8?B?SjNucTJKYWV2KzRhYWd6bmR6eHNDWW1wMXlJRlV6bUwxenBhZmRNR0xsQ0lE?=
 =?utf-8?B?VDJMMm9Fb1NXN3llNFJCbldwK3BnV0FGRFN2dEgvNU9Za3FKdjY2TmFjbGha?=
 =?utf-8?B?S1I4MzRYSUxoMTBMV2VhcjZxQzRJSnFmL0lQa3pBSmVWUEZqazlpM2NVM3Ez?=
 =?utf-8?B?Z3puV0RGTTdJNm5xYWNQSndML3NXM1MyZXplZWhkZ3c3YU5tNDJGNlJkR0pj?=
 =?utf-8?B?Q0xIejloa2s5eVZ1eGtoVmcyUWM0c0dxc1gxZkNLcUFvNVNmVnkyd1M2cHJv?=
 =?utf-8?B?MHozNDdQb0h1SmF0aHBKc0NQS3Irdkx4UWEwOXdGM0RqNG1icXREQmlEZWlD?=
 =?utf-8?Q?4QB/VcToL4PuzABIN2eWBYAJy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	i9DxwsfCheKbKAFLyE7Olt4Dk0wumN+SVsITX1v616w8HzPqWltdkbLTkhF/bbBXUrsPW1Wa66gwyG2he3N5tnvIj9OWRFLml9kg3Wfl7Yu8CALZeAvNKVv46wFb0DX8XYD3TXcDO3ev45+bpvhFrGrEEKMU4y4O7MbiqeOIES1lawE9Hy7OenfXOFNA5M1UnMJyBvMuzU8R5jc5pI0y//etCYCkcrp1iIvNuLDjAlGrvD3PyhVFjwET0KAlSRj2TK+IJN+78BksVhNIuE9hdKyFdJdVIep5FSKhly77svdxENV2EiND0MG0Vl4b7JKORzFPJEeNpW+70jm4whs7A1zC2xWD3BD3BglHLpBedzNw/pck1FjSq5yuq7mZclnOQuGgcAhuqm6TQALMMmTJdroK+5ktve3cMUzByLfIdAxLMxkale/zivsD5/g4fUzkXzDv4FH7BZMR+9IwadMn/SbGviVLjbIis8vWZjgCCY8kmgrH4BwQAFDj0sZAj5WZnvVXBccM57nc7TsM+1+5Co9v4q3YuMjJLVXw+c3iBHhcTLuc5rsHTvjHUpTtxGHHSCRXNeVLJhHX+ck4dlEn77RmMBXjO1y2xZmVaWYg5yY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a829a4db-3338-4bc1-fec6-08dc5b14a0bd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 17:18:53.5794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ed08cZgYF1H6sYV/vf2j3pPI/AKizrICRkzCrFW7prbdIsXsWXnC6bLpR7LedfgrAEKv2qvbfn9lC6+DpdAPLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7812
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_13,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404120127
X-Proofpoint-ORIG-GUID: 7XeLeHVOQfh423wZ_EHPQ6W-MNxv-Pmj
X-Proofpoint-GUID: 7XeLeHVOQfh423wZ_EHPQ6W-MNxv-Pmj


Adding Pierre-Loup to cc list.


* David Hildenbrand <david@redhat.com> [691231 23:00]:
> On 02.04.24 09:34, Oleksandr Natalenko wrote:
> > Hello.
> >=20
> > On st=C5=99eda 20. b=C5=99ezna 2024 22:05:34, CEST vincentdelor@free.fr=
 wrote:
> > > Hello,
> > >=20
> > > I am writing to highlight an issue impacting many Linux users, especi=
ally those who enjoy modern gaming. The current default setting of `vm_max_=
map_count` at 65530 has been linked to crashes or launch failures in severa=
l contemporary games.
> > >=20
> > > To address this, I have opened a detailed bug report (218616 =E2=80=
=93 Increase Default vm_max_map_count to Improve Gaming Experience on Linux=
) available at: 218616 =E2=80=93 Increase Default vm_max_map_count to Impro=
ve Gaming Experience on Linux (kernel.org) .
> > >=20

This is change is getting more traction as distributions switch to a
higher number of VMAs.  I feel we need to educate them as to what this
really means and why it is unnecessary and wrong.

> > >=20
> > > We have identified that several modern games such as Hogwarts Legacy,=
 Star Citizen, and others experience crashes or fail to start on Linux due =
to the default `vm_max_map_count` being set to 65530. These issues can be m=
itigated by increasing the `vm_max_map_count` value to over 1048576, which =
has been confirmed to resolve the crashes without introducing additional bu=
gs related to map handling.
> > >=20
> > > This issue affects a wide range of users and has been noted in distri=
butions like Fedora and Pop!_OS, which have already adjusted this value to =
accommodate modern gaming requirements.
> > >=20
> > > For reference, here is the change for Fedora:
> > > https://fedoraproject.org/wiki/Changes/IncreaseVmMaxMapCount
> > >=20
> > > Here is a list of games affected by this low value in vm_max_map_coun=
t as reported to Valve:
> > >=20
> > > THE FINALS
> > > https://github.com/ValveSoftware/Proton/issues/7317#issuecomment-1974=
837850
> > >=20
> > > Hogwarts Legacy
> > > https://github.com/ValveSoftware/Proton/issues/6510#issuecomment-1422=
781100
> > >=20
> > > DayZ
> > > https://github.com/ValveSoftware/Proton/issues/3899#issuecomment-1304=
397069
> > >=20
> > > Counter-Strike 2
> > > https://github.com/ValveSoftware/Proton/issues/2704#issuecomment-1705=
199788
> > >=20
> > >=20

Most of these do not have the vma information available anymore, if it
was there (expired pastebin links, etc).

..

> > >=20
> > > **Affected Games:**
> > > - Hogwarts Legacy
> > > - Star Citizen
> > > - THE FINALS
> > > - DayZ
> > > - Counter-Strike 2
> > > - Payday 2
> > > - (and potentially others)
> > >=20
> > > **References:**
> > > - Fedora's change documentation: https://fedoraproject.org/wiki/Chang=
es/IncreaseVmMaxMapCount
> > > - Various user reports and confirmations on gaming performance improv=
ement with increased `vm_max_map_count`.

Absolutely not.  This will do nothing for performance.  The game may run
vs not run, but it won't get faster.

..

>=20
> Using a high VMA count usually implies that the application is doing
> something suboptimal. Having many VMAs can degrade performance of MM
> operations and result in memory waste.
>=20
> Running into VMA limits usually implies that the application is not
> optimized and should handle things differently. Likely, the memory alloca=
tor
> is doing something "bad" (e.g., mmap()+munmap() instead of MADV_DONTNEED)
> and should be optimized.
>=20

To be clear, what you are doing here is akin to adding more memory to
your system when there is a memory leak.  This is not the solution you
should be pushing.  Ironically, this is using more memory and performing
worse than it should.  At best, the limit increase is a workaround for
buggy programs.

At worst, you are enabling bad things to keep happening and normalising
poor programming choices.  Please put pressure on the applications that
clearly have issues.

To put this into perspective, normal applications on Linux use in the
100s.  Insane applications (chromium) use 1000 to 2000. The heavier user
is Android and that uses in the 1000s regularly (usually topping out at
around 3000). You are allowing one process to use over 65,530 vmas.

Again, this is per process.

Currently, if you run Wolfenstein II: The New Colossus (proton game),
there are 4 proton processes with 115, 104, 99, and 24 vmas.  I wanted a
newer example, but steam (or nvidia) is having A Day on my gaming PC and
won't start.

You are enabling (and normalising across multiple popular distributions)
a change from less than 120 to 1048576.  That is an increas of ~870x
of virtual memory areas - not tiny chunks of memory, areas that can span
large amounts of memory.  Assuming the *best* scenario in the buggy
programs, you'd use 65531 vmas - that is still a multiple of 546x the
number used by wolfenstein's largest thread.

> I don't think we should be raising the limit for everybody out there.

If there is an underlying technical reason for needing this number of
vmas, then it isn't provided.  I'm going to guess it's DRM/anti-cheat
that needs fixing.

I'd like the problem to please be fixed and not hide it.  You are at a
performance disadvantage with the current approach - and enabling others
to do the same.

Thank you,
Liam


