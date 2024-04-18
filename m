Return-Path: <linux-kernel+bounces-150841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A788AA582
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDFCC1F22AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35422AE66;
	Thu, 18 Apr 2024 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lFG5P0XV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b4WJltUX"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46F311CB4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713480312; cv=fail; b=euIyRgJEhofUNKuHFlrR1AutwZi+C6Cjbh8SxiIuOmfUdPdC22UsVS2W4fWI4Uo7zIYFEghXVda/RY6waBbYt/G04qTpoJDqZ/rS2bFHgltIFy1O/FoaOXXa4gbTqTqe7frxTCZ6rvfL5Kl6rBt0kBwQX7nBRbL1Ewj4cL2LpvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713480312; c=relaxed/simple;
	bh=ULIs7rQ0u4vEgEor89dr3uslisbZt0nGLxeBNz2E1Kw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vApuMkfpRJP6HD9JFa3hwAr+PC2Jz3F+1i5vPDhq2V06yQRQce2Oon+4bTW69H92bEHVFTPLADooTFqh1sL51OFlny1/4NWivJxzU4pKJmrxdK5JKkWVJxuDGAFEjuPxbR42o7DZrY/X0pLJ0JJB2I3ejj3J++ZgoDUg1W8e7qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lFG5P0XV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b4WJltUX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43IJiXEn022464;
	Thu, 18 Apr 2024 22:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=LJ6SYYJIwwa7hVaJM64amQ61dg1hZkcXQefVUPygc7Y=;
 b=lFG5P0XVRzikXB7R9ytoVcX/UQfAkPtsA0MTArm+c/asCZky1d7JIXST9m/0mqDogBue
 vH2bTSHxljb6zzxVLL5+IgO8+UDwb17J0DDY5I/HC/pxLJCTunHzK2g7RgkJux+tysGl
 VMFeetCf397zxou9oB3qzbpIkyV0yxIBiDigIbdvoMrpxx+cQidBAl5ji9sWY9HuW5vC
 VqWl+cxGZEljf/cqEDLjMreecwMewGbU9Zx9LZ8ULeHzHWhJ73izcwgO4wgZDikTUbMn
 UL0ejXFLvvrkQ2suBhnfFHrVssT5DlG4pYPXvX/k7pjvsd7GsUfxZ5d/ez5lWZ9lfx95 kQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgn2urbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 22:44:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43ILskVs014872;
	Thu, 18 Apr 2024 22:44:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xkbuq9eb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 22:44:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFoVHhn0ttUQq0LgoASHUgO417n8yMRqZBNFe9Z2SnFxppFh9EVizKqXfox1dQ3tNLLD2zpsRjcCcIhNLWQfAvwUsT/G+VsYp1O6Thh3MjE4SawZNm/2zkvV9LJ49XOG/28zMFYBH1M8mrqQRhcm2tZzvf6Yy/XdkWTH0SWOeNiLuZnC3GLir3z1bY6c87OnUPHfm9AqKLVh1ekmCMf2WVpO1cWQqR+sLzyFKkR7BnJQ4qqMn4zfyBTFYL7aGRpYeUnsfvSq4i+whXEuLCeYO2IVR5Z45v23/zWjnm7+H4EpiE/YRFnhnKaFhtyUrLPnvEWlkhWKnpFquwM+PlBc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJ6SYYJIwwa7hVaJM64amQ61dg1hZkcXQefVUPygc7Y=;
 b=cOYiJME7R+vHRmS9E8L6kuTuPvP74nbKVmM32X1DPTB3yqSYMi6EPYNS1E+ZsR7S2IxqTvdXuJxzp3pZioKB4ktZU0jduWmG0/pOyl3LYUfmOtNIWhAnw5vl1bD5b5i/5aQkkRo0PB6WyJDZzw2hAGsyX0DM9COxNlXvr5lb/6bfLbbCLqSAdr+Z5Tfb+PaFaLrBNhhxw8lN4lOQQWJPdfSdWcCosdFk2kxly9WFEWDYLJ70z/YVsPbo1u5fQL9HJa+w6wU7y7DIAQnIC7q1u4m8h7kFB3k9wDF75vU8qEIlZXXzxW4xaIbAxuOnwPTMCCpvvfM7jcqr5+S0JOgTYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJ6SYYJIwwa7hVaJM64amQ61dg1hZkcXQefVUPygc7Y=;
 b=b4WJltUXrqBDmZFvJAo6pGK2T/0vP5Qq2drA8jrG9ng7q9amSJXeNUrSyy8XPEyVPIf4Y5PmjY+QEmgKeHMby9LGlHAmhh0gcnI+SZ/7C7spjJ+eRt6r1N9zwU9NUPsPBpW3zlWpulnWT2asrIXkRY9EGEBBU3z87wrbg90aM74=
Received: from PH7PR10MB6379.namprd10.prod.outlook.com (2603:10b6:510:1a9::15)
 by CY8PR10MB6660.namprd10.prod.outlook.com (2603:10b6:930:52::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 22:44:43 +0000
Received: from PH7PR10MB6379.namprd10.prod.outlook.com
 ([fe80::de1f:84ac:fe86:2865]) by PH7PR10MB6379.namprd10.prod.outlook.com
 ([fe80::de1f:84ac:fe86:2865%6]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 22:44:42 +0000
Message-ID: <7bbbd88d-3350-4a67-93de-f054176ae9ff@oracle.com>
Date: Thu, 18 Apr 2024 15:44:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] slub: limit number of slabs to scan in
 count_partial()
To: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, junxiao.bi@oracle.com
References: <20240417185938.5237-1-jianfeng.w.wang@oracle.com>
 <20240417185938.5237-2-jianfeng.w.wang@oracle.com>
 <9863d6b8-cb6d-4555-b35e-38d495f3afbd@suse.cz>
Content-Language: en-US
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
In-Reply-To: <9863d6b8-cb6d-4555-b35e-38d495f3afbd@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0043.namprd20.prod.outlook.com
 (2603:10b6:208:235::12) To PH7PR10MB6379.namprd10.prod.outlook.com
 (2603:10b6:510:1a9::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6379:EE_|CY8PR10MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: 716c4779-6244-4881-eca7-08dc5ff92352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CgjwU76yQKdZx6ZBetAxILzvXxlHVfuM1pxVqjK5Yv3VcaUNANPHZ7eypmJdCgfcXSYeVB4YNRjwwJGisPRT1x3tBG4hGc98hkCtfCBHMg5pR5fYpZv+1G7qWg252Vz/jtTyekAx153DUPBieybOczS5u/m0NK4+BQzrWUTidl8ywWJD92+QN7YTN8Vrkhj4DWrnIGaqxbJhdmdmCtYR+rmaU5uTpZrjTWZ+bcA8FBhDRUT5hNvnAn5k8kt36nJc6evG3HDQdIobk4T5GIidMY4+cMw9Ay9vhiSwHqIiLGobZ3B33Tke7Nez6ck1swdnIFchuRFFJI9MYk51Y0a1dY24w1HP1mmH9pDx4CDFdZwTYrOR7JgexyTbDmXSKZtYDgdDeXeak77Qk6C38cof7htoAg8XHvA7RH3hpB3RWnoBSJOqZHMtrkPU5AGw182qEcPMUDD4pL9Ri6VcMnTg1gg9OyuQAZ5RmYb0Z9Yo9FW7/GkhliDkfWAORWWIf9gfzv/8WuC6CzPW2H2RD2QFvRPXBqZ7T5EOxpf5ZV9SE/bfXkCOtNzX/u7S8FQfULzlwajaA3tV/RM0MTHBYyb23mcLwU05wGilDHvd1MZJJ7eP+H6DhG8+xhWagoIcjXjL
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6379.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dkR0NWtvODVDaHVPcjNONnhnTEM2M1dOWWw5WERPSU01aXVLTnp4R1R5Ynht?=
 =?utf-8?B?KzBHWW0yVVM2cFhQdC9JejRsaEtxdHcrd1I1OG80WVFVbjhSWTJaWmRHb2hU?=
 =?utf-8?B?OUczY2hXM3YxdlRBcVBBaWdkQzAvaDlrSldoN2VxdWh0VlZpYVhMOXJNbG1Z?=
 =?utf-8?B?aXdGRG94RkN6NEdLcUgzbElyZkRYTk91czlqMS85MCtNRmdIK2VEdE0rNElh?=
 =?utf-8?B?WW9NeXQxUzNhUEw1ZDlLbXQ4dDVzRldWdHpFZGxOOU54N25LbU1PbUViSENo?=
 =?utf-8?B?TmoyMDVRd29DKzVmWm02VndjZUI0ZklHRmtmQ1I2K2d3ajJvOUM1UkNxZmxz?=
 =?utf-8?B?SGsvQnVBWFpXNHFnMXdndUxKazJ2VFY2MEN2eWxpeFhDTWhOUXR2NEF4ZzdW?=
 =?utf-8?B?RnNXbjlMZ2ZJOXg3dmhrTlhEY2RKSWYwdGFrZ3pMMkVLWjBPd2F1RSs0ei82?=
 =?utf-8?B?ajdpV2I5WFUyWENVcnlJSkorcENJQnplQjluOWRmL2xqMm92TjRTYkdnOGZp?=
 =?utf-8?B?b2xJYTRoaktoMlpqeTQyUWk1UFVYU1UwRkhraXVSQm5McHBsZkNSL1dHdktx?=
 =?utf-8?B?cUdJT1R4NkdnYkxUcnJUVGtaQnR3U2hTMHI0cVU3ZkFqQXZhNCs0bGdwOHBp?=
 =?utf-8?B?ZzNOL2FPU0NXS2JlL2RRYXNHYmsxdWs4S2NkUG83azVoRzNWdXRBWFI4eEJQ?=
 =?utf-8?B?QnRDT3VJWW5BTmFmbVBrc3JiQk5YOFJlNWdhbVRoR0FLRG9lRjRmTGhyOUpt?=
 =?utf-8?B?TDNHZWM2VzJNd29FTnRHTDVGWTE2eVJ0YlB1VnBXUStnL0gxTHBaY1ZiTnNu?=
 =?utf-8?B?Y1EvZnpibDNKeEk0YjVGK3kzRnl2di9hU0xRZ3g1dWZLeE9WV3ZIR0Nudlly?=
 =?utf-8?B?OU9PTnlDUjRzQStqOGZZeWJ6MnRpb2RYY3NzWGNNVnVRUkFDckZhQ3ZVbWUr?=
 =?utf-8?B?aDVKVk15RU50ei9XSk1KaG4xVi9MTzJneTJUN3U3Mnd6U2ZxY1BLaE03Q09X?=
 =?utf-8?B?U1grbXc1NlY3RFFTaXhXNzdxc0JXZWJOSzR2YUFjbGkvWlJlVVBYOWZzME5I?=
 =?utf-8?B?d2ZFUjY3Sm45TzgyclJKMEl6UHVjK0t3a3gxRkxtRklGSlBLVkJMbzNpMVJW?=
 =?utf-8?B?ZHBYcmNMRFBlZ1kxMU93cC9FVnZpSUhvdm5mS2d4SEJnQW1KRzJiYnc2L092?=
 =?utf-8?B?bkNnSUtjbURLclpHY3JkUDFlZEFabUttSHJselF6V3Zza1VVVUxuNjAzK1Fq?=
 =?utf-8?B?clo4NUlMeWNORjZ6K0VCVEVsT3Zic0xlWmtMSmkyaWZBWUFTMTdxc1BZdE1I?=
 =?utf-8?B?SUJ1dkRmekpkMFh6d3lrL3JUYUd6ZUlkUEpRNWRjdzYwbUI0ejVpY0YxN1FY?=
 =?utf-8?B?dnoxaGJPUmxFejJYbUxGeFdyMmpvK2RGVjRtQVJSa1EwTVR0WjlUb1JQbzBL?=
 =?utf-8?B?V0M1MFZuR2pJTi9wOVdONlhKWUJzTXpRK2NUeHkvblMrWG1jeGFPWHVIaHdP?=
 =?utf-8?B?YUc5c21oaFh1ZDFtRWgzK21ueld2Z2QrMUZmRjZFUm1TU3laQnNxZ3VXK0x0?=
 =?utf-8?B?bjgrTWJTQTBZK2cvcHY1VGg2MzFtM0xxcjAxbEptRmVRakdEMkYrY2Q2Q1NF?=
 =?utf-8?B?QXEwSDA3TVcrVXlWQzRpR1VzVy9RemVWUW9aUUpwYTRvL1VhcDBQUEU0T2hL?=
 =?utf-8?B?S3VSbWl0Syt1NWY1Zm45VGhHb1FQd2pZQWlsYlNWNi9wUmhzdldSd0F4THd1?=
 =?utf-8?B?b1lFNUMrM0RSb3NDNmFGSS9oSjdPa0hFRzJiZkI0dVBzakcwdWRsTTR1WlRh?=
 =?utf-8?B?aktOU1BZbC8yUEJHVStFZ00zS2xwUGpvVDUyS3F3UUErR1R0NVhXUlNjdkpT?=
 =?utf-8?B?ZjVKcXFSR1VOMHlSY1lVWjN0N2dyRzVvRlFWaGJEVzF6S0xiWGVIakRndVlu?=
 =?utf-8?B?eHdvdDd4dGlnMHJxcCtXbTdPcW55QnJsTUYxUHQxNG9FbWFjSGdnUThialVR?=
 =?utf-8?B?K0t6eTI5YTRpK2hZT1c2a0tsOEJDZUxROGVpYXZqbTNkQ3BYUWkrNmJBMmpj?=
 =?utf-8?B?Tkw5UzJaWkdHTU9xVFFTRkFOOFRsUjhHZ1ZqV2NRdjhQN2V1eHVuWlNxRHhi?=
 =?utf-8?B?NmNxK0pxTmZxU0l6d0ZMcjV6RHYyL2JhRXZiQlkvL21SdzFvN21Zc0VwaE9F?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FM59sjl5g/XU7Re2x6QyNxc7iXyW3Mf2yL4b1lYo1N8OhYJB/p3df+Cl5p7Kz2GUJ521TLsy4J9Gt/LUhw5Sp/fiogcrMn6F7IttiShPrilmZ75HwhrIb9hA0m2YEHfVFaNwxK4OUxgnzsP+tT+dmFDZW96g0GFAdDWRFzaIKVjbyQMnV2eV/12qkdN0XlBHJ4wFyTEJSEtyYuE2RAxiNvEqb7sO2hPh+T6MSRyDVPSEjZei80mnilAHXNZPbu7CmPpt+AMCsevW7ILY0zms8rVeHb3GoABkjETSgEL/Rlvc7cA27lGX9OZytzNnjMUbiu4NVsaD0EktqUgKEvo+rQ3DPjYHs+ue6cNS9klsBHF4tzafTCfqVsOJ2ipLxdhkz5d8XnsRizahOGahllniRVj7Ey306jHJ/v9K9OayOkgXpZZqvtL2EpM7l0pDTUEPxklN7Wy8kwHeugKRPTqEtqGzIQWkoY8a6mc2P60y1OzekhF3TMmJQZq9aNCz5CnZVtoGUbLzmq8+/R0kZJzNDuWftstP/91jbnorTmpEPM3gyJ3x+kkYqwmlQbJrEvYMzrnqhqH6SxP2r0uXVf6GkWsLsx1ygi7N/KE/9Jq5LvU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716c4779-6244-4881-eca7-08dc5ff92352
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6379.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 22:44:42.5883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2nhSqw9xb3jXkJB7Wzd1IR52IXG49Kf5hzF0whwLc8bTxeEXLI+yqa5WdhQBcTwJ/+pAdUK2mgIhFgVhKbi13gS4O2ILOEmAOYOaGF7f+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6660
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_20,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404180163
X-Proofpoint-ORIG-GUID: mH0hCj5xAKx_SGPeczGrvxPFSYQI2NHi
X-Proofpoint-GUID: mH0hCj5xAKx_SGPeczGrvxPFSYQI2NHi


On 4/18/24 3:01 AM, Vlastimil Babka wrote:
> On 4/17/24 20:59, Jianfeng Wang wrote:
>> When reading "/proc/slabinfo", the kernel needs to report the number
>> of free objects for each kmem_cache. The current implementation uses
>> count_partial() to count the number of free objects by scanning each
> 
> Hi,
> 
> thanks. I wanted to apply this patch but then I realized we use the same
> function besides slabinfo for sysfs and slab_out_of_memory(), and it's
> not always counting free objects. When somebody is debugging with sysfs,
> they may expect the exact counts and pay the price if needed, but we
> probably don't want to make slab_out_of_memory() slow and precise, so
> that's more like the slabinfo.
> 
> So what I propose is to create a new variant of count_partial, called
> e.g. count_partial_free_approx() which has no get_count parameter but
> hardcodes what count_free() does.
> Then use this new function only for slabinfo and slab_out_of_memory(),
> leaving the other count_partial() users unchanged.
> Another benefit of that is that we remove the overhead of calling
> get_count(), which may be nontrivial with the current cpu vulnerability
> mitigations so it's good to avoid for slabinfo and oom reports.
> 
> Thanks!
> 

Thank you both for review.

I assume that: in most cases, people would stop at /proc/slabinfo;
and they must have a good reason to dig into the exact object count
in sysfs. At that point, it is better that the kernel can offer it.
So, it sounds good to me to offer the two capabilities, i.e., fast
approximation and exact count.

I will send a v3.

>> kmem_cache_node's list of partial slabs and summing free objects
>> from every partial slab in the list. This process must hold per
>> kmem_cache_node spinlock and disable IRQ, and may take a long time.
>> Consequently, it can block slab allocations on other CPU cores and
>> cause timeouts for network devices and so on, when the partial list
>> is long. In production, even NMI watchdog can be triggered due to this
>> matter: e.g., for "buffer_head", the number of partial slabs was
>> observed to be ~1M in one kmem_cache_node. This problem was also
>> confirmed by several others [1-3].
>>
>> Iterating a partial list to get the exact count of objects can cause
>> soft lockups for a long list with or without the lock (e.g., if
>> preemption is disabled), and is not very useful too: the object
>> count can change right after the lock is released. The approach of
>> maintaining free-object counters requires atomic operations on the
>> fast path [3].
>>
>> So, the fix is to limit the number of slabs to scan in count_partial().
>> Suppose the limit is N. If the list's length is not greater than N,
>> output the exact count by traversing the whole list; if its length is
>> greater than N, then output an approximated count by traversing a
>> subset of the list. The proposed method is to scan N/2 slabs from the
>> list's head and the other N/2 slabs from the tail. For a partial list
>> with ~280K slabs, benchmarks show that this approach performs better
>> than just counting from the list's head, after slabs get sorted by
>> kmem_cache_shrink(). Default the limit to 10000, as it produces an
>> approximation within 1% of the exact count for both scenarios.
>>
>> Benchmarks: Diff = (exact - approximated) / exact
>> * Normal case (w/o kmem_cache_shrink()):
>> | MAX_TO_SCAN | Diff (count from head)| Diff (count head+tail)|
>> | 1000        |  0.43  %              |  1.09  %              |
>> | 5000        |  0.06  %              |  0.37  %              |
>> | 10000       |  0.02  %              |  0.16  %              |
>> | 20000       |  0.009 %              | -0.003 %              |
>>
>> * Skewed case (w/ kmem_cache_shrink()):
>> | MAX_TO_SCAN | Diff (count from head)| Diff (count head+tail)|
>> | 1000        |  12.46 %              |  6.75  %              |
>> | 5000        |  5.38  %              |  1.27  %              |
>> | 10000       |  4.99  %              |  0.22  %              |
>> | 20000       |  4.86  %              | -0.06  %              |
>>
>> [1] https://urldefense.com/v3/__https://lore.kernel.org/linux-mm/__;!!ACWV5N9M2RV99hQ!LuGLO7jdg-btEuCdiGR-urqWDlQa9J1c_HdkmkBogW_86XHSFoohzTP29qfBZScVYn3BKt0s5m5CUniSpHWw$ 
>> alpine.DEB.2.21.2003031602460.1537@www.lameter.com/T/
>> [2] https://urldefense.com/v3/__https://lore.kernel.org/lkml/__;!!ACWV5N9M2RV99hQ!LuGLO7jdg-btEuCdiGR-urqWDlQa9J1c_HdkmkBogW_86XHSFoohzTP29qfBZScVYn3BKt0s5m5CUo6BnK68$ 
>> alpine.DEB.2.22.394.2008071258020.55871@www.lameter.com/T/
>> [3] https://urldefense.com/v3/__https://lore.kernel.org/lkml/__;!!ACWV5N9M2RV99hQ!LuGLO7jdg-btEuCdiGR-urqWDlQa9J1c_HdkmkBogW_86XHSFoohzTP29qfBZScVYn3BKt0s5m5CUo6BnK68$ 
>> 1e01092b-140d-2bab-aeba-321a74a194ee@linux.com/T/
>>
>> Signed-off-by: Jianfeng Wang <jianfeng.w.wang@oracle.com>
>> ---
>>  mm/slub.c | 28 ++++++++++++++++++++++++++--
>>  1 file changed, 26 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 1bb2a93cf7b6..7e34f2f0ba85 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -3213,6 +3213,8 @@ static inline bool free_debug_processing(struct kmem_cache *s,
>>  #endif /* CONFIG_SLUB_DEBUG */
>>  
>>  #if defined(CONFIG_SLUB_DEBUG) || defined(SLAB_SUPPORTS_SYSFS)
>> +#define MAX_PARTIAL_TO_SCAN 10000
>> +
>>  static unsigned long count_partial(struct kmem_cache_node *n,
>>  					int (*get_count)(struct slab *))
>>  {
>> @@ -3221,8 +3223,30 @@ static unsigned long count_partial(struct kmem_cache_node *n,
>>  	struct slab *slab;
>>  
>>  	spin_lock_irqsave(&n->list_lock, flags);
>> -	list_for_each_entry(slab, &n->partial, slab_list)
>> -		x += get_count(slab);
>> +	if (n->nr_partial <= MAX_PARTIAL_TO_SCAN) {
>> +		list_for_each_entry(slab, &n->partial, slab_list)
>> +			x += get_count(slab);
>> +	} else {
>> +		/*
>> +		 * For a long list, approximate the total count of objects in
>> +		 * it to meet the limit on the number of slabs to scan.
>> +		 * Scan from both the list's head and tail for better accuracy.
>> +		 */
>> +		unsigned long scanned = 0;
>> +
>> +		list_for_each_entry(slab, &n->partial, slab_list) {
>> +			x += get_count(slab);
>> +			if (++scanned == MAX_PARTIAL_TO_SCAN / 2)
>> +				break;
>> +		}
>> +		list_for_each_entry_reverse(slab, &n->partial, slab_list) {
>> +			x += get_count(slab);
>> +			if (++scanned == MAX_PARTIAL_TO_SCAN)
>> +				break;
>> +		}
>> +		x = mult_frac(x, n->nr_partial, scanned);
>> +		x = min(x, node_nr_objs(n));
>> +	}
>>  	spin_unlock_irqrestore(&n->list_lock, flags);
>>  	return x;
>>  }

