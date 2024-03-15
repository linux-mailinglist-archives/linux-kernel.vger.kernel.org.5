Return-Path: <linux-kernel+bounces-104735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D6587D2EA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2429B1F22DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56774B5A6;
	Fri, 15 Mar 2024 17:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D+dhgtOf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o0MF/bKw"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA246D518;
	Fri, 15 Mar 2024 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710524242; cv=fail; b=LDuLMFDa+KI0RK5zuQDsOIDh5pjuyBalQUSk7Nu5vSQliE8kmBGMyQeyHXgp+3w2Hv+2XFyPuh8M6ZSIo0+qmPrGngK8pn9JZj2oFCqJ4KqDtHuC4kyi/a6TFaLyCSeLHtwYx130a6J9XUhirVvTWXydHn8O4q0FsQkDltMaPUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710524242; c=relaxed/simple;
	bh=TLBYg+XwDGJfP6gK/kB3/gN9CEi7mXUTAvy5BFjSiY8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MdmO6fzoIAbRJuTqhWW02+R7apN7Vsq/4WkVaiCkSWpyD3O1Z4H8QpjjPrYzdEzCtqo+9Owxs/mm2ys5Q7vd89QsjKfUKkuKEJlfLic4ScIvTkXAXXb8BeMC8q8wkzG1AN+AXWLLZnmaFG2AmPBgH/Dmxkw9PTuq1m7D0L6t/pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D+dhgtOf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o0MF/bKw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42FH8x2k030245;
	Fri, 15 Mar 2024 17:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=dvze0ze9wHMXHxpk942SKoJiUq0ApEH7mqlQioXwn7U=;
 b=D+dhgtOfdofO3qs6JvYBPOD+LDtmezrjD5w8Bt3trjLYBbN4DzFWpVS7K8u/tYBhMjAJ
 5nbqbkHd1JTOKANhs40rX200l4vHwGiTYC1IxQO9r+IN9b6/aXoftbWDTAQx6RCPSejp
 v2JfaUC3HOTJuKyLYsOuUEx2pvbZO3S4Q9g3QGQVtJTAZ6ylbDHBa5GsJzy6BuKowYUb
 vXaKcxFp5TWRiTChUCR1QTsIOk5470+ODg6OPe1mEGhNxrwj+/g/MKdrA2z8y+CwrKOZ
 ic1AaTBsXRybj1dp1KJa6rA4fkFmJ90mMsynOQRdAL4v+kc8yDIZIhInrMl1RdfbB9oE 1w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wvt3403tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 17:36:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42FGuh01033567;
	Fri, 15 Mar 2024 17:36:47 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wvta19s9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 17:36:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUdAuJ39ijxwrIAld4lzVgw7Ll+3uWMFnKU/QRI4JxUwxnGuHzXG1Hg+z45HDjzC+zr2fASdIQqF0xv48z9gOUirrYoNenqXbfPV9FHcoW21Tht6A+eRVVqC758VlWqZV8o5Vm5KQuDgEEqjTww27MYACi1T2l9YLDXjL0b4hTiKN8XgTDCM9eIiOkNJGJaOh8ww1BML3f5IMHURhZKs5Fw9qhaRR/1jFCfr1tiCMfYOFSA9f4RYFOfYWbFF7xb+caQY1ZYl2KcatD3DWqRIMvX+CfD+j36As+W8lsEoZfrclW4aU2wA8iZdkUDG0Fw4kT1tDPYOXSNgyNkEOU/gdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvze0ze9wHMXHxpk942SKoJiUq0ApEH7mqlQioXwn7U=;
 b=KqwsNqhurwskx5Pye4cqxCwfXzzj/L0/bBL9HTjwGRJI3yQHn+lPhUyXGzFb/ZvacQvchRUUm3Z/y2vInNTOFbX8/LMzAt0UZgFn9yRY4eWjc19PNT89KAXKCS7Oa06kSUD19WVKJrtWpa8PRJV0UuQvWBQk2dkofnFHutfj1+9i9HEcAdPihgFL5Rm8+M+V3LP+OnMCWzzIxYq9WX9qmOys6isdqfEGY1xITwhGutkuK6qEktn8Zlmc1J5Awj896hrcono+Sb7FzZ7jFdJ6YN8N5lcJRUPneKtK3hUP5ZmnLcM+nRfqyDUj45HN51DIsGvyoRDlgLWwwmCSkGbBfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvze0ze9wHMXHxpk942SKoJiUq0ApEH7mqlQioXwn7U=;
 b=o0MF/bKwT/qpg3QG0hapkDc0GMw+6mPwwrDaeLw4b1sk4oIbD91uXMrTC4WO5+zaS/KZP0CfXy64u1uzwlNPJTP7CKDyTOMiiuwm5amDs8Ei6re9Y4+ixksDDomSGaIfhflP4LnCU7mGXqjpGm1cKE0lWa+yZFfQ91qECP6gOHw=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by CH3PR10MB6716.namprd10.prod.outlook.com (2603:10b6:610:146::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Fri, 15 Mar
 2024 17:36:45 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183%6]) with mapi id 15.20.7362.035; Fri, 15 Mar 2024
 17:36:45 +0000
Message-ID: <fa701bd3-440c-4d8c-90a6-043935d75f52@oracle.com>
Date: Fri, 15 Mar 2024 23:06:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/60] 6.6.22-rc1 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240313163707.615000-1-sashal@kernel.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0065.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::6) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|CH3PR10MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: e8673c7f-1d31-44f8-8957-08dc45167be2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bTeqIlqcudl4SIH9xP/xZuLGADqqV8lV569EizZU6ytCDyk/nLcWMCMIzEXipnrGkyX7KCZEMiEWYII4Qtts/ntOh3CESuBRtBDQX3+6XGoU5CaIBkPVCnIQeUuQOZl7ePjYoyZJJOapmrfDwfMrexbZeeiaR5II0HaQNYRT31rcX9UF/i4g7H/fsGIX1zTxqRGhhXIwmjO0HWLyX9GvdIok/8qluE0XDx/7sNKZqfhorNPf8fOaxBy4LCORJdafpOKVPPmszAtCAi6R5EUhr0EJTn19nTgHW4ujcJxt8A232vyIFZwCuZCBIwmJJ042JwxVTZRO6gHOd/Gnt+WgZz308Jn2oBZF+mO73J1+LVfXIALjMlWoRshstLkiOLq0XW0WwhjMSXFwZ6ounSGG/oSfZ743d3+cuEST6wYcJOPkW3rlsqwk2qejfCQwWQLNPtnmnkeczff2fmRoHrsJdW1IcaXYMGYZBBnvnUg/UGD4Sh1bN33kJgDkPfRKguGcdXFJzHrbQv5gnAtnqz4VuZu7ZRyT8quVXq0NRK5hEK6eStsADtTGJ2p3I45CovTgmEO/aCkko8pvF20boQkcTRVYXvQrFSK5LgS14ta4jns=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N0xhV3BCSHYvVGJPU2RMVGo2V3lqVWZsWTBydUZCRWdnenFUaW1QOGczNDB5?=
 =?utf-8?B?VVNRNEFaZXZoaXVhalFTOUZ4cUxxS2phWENhVW5HVXNSdlZia2VmK3NLV0tv?=
 =?utf-8?B?QmlIdS9RNmRiTnIwVmgwbldSbkMwd3FpK2RxWUVhL2tTTGdRZEYyb0pOYmpR?=
 =?utf-8?B?S2kxeVU3K0hRaU10MEsyc3dHRVk5eUZRSko2YnIxNE9rY3VRNWJ6S1dLUjd5?=
 =?utf-8?B?Vytzc24wbHJ4VTNxL3FVL3FYNHBudzBNYmpWNmNJb2pWOXJxR2RkTmlBU29X?=
 =?utf-8?B?aDBaWkxkVFg0UnlmbTBlclUwWHBJZWVvcFNTWllQYUMxSDNESGovUmcxZlJT?=
 =?utf-8?B?eHNwUFZvYzlYcFpJRDV0QzFXUkEwcWQ3enlxYlZhY0hGcGVYVjluSXhNZUEz?=
 =?utf-8?B?MU5qVjJMakM1WG1EMVU2dTVXVUNRdEhGdDZ6RGxJMjdQR0Zoai9qNDAvTVZ4?=
 =?utf-8?B?ZFB2UW0xYnlhVFBEcGVyUmhhOHU3b3FmRW9XN1V3ZDlwRW5RU2I1NzhPbG8r?=
 =?utf-8?B?MjRmVjJ4UUN5ZnZsSHJHSFdtMHZ6TnEwNzQ1Vmp1c2R4d0o3YityWjBJdjM2?=
 =?utf-8?B?cVpPZ0t0S3k1MGV3TjVXbHNRaDlQanZLc3VBazlGbnJmNTU0VXp0Tm01ck15?=
 =?utf-8?B?bUxyOEdNcW8za2w3YnJSOG81OUlMaDRqWFFMTVpjZmFETVZlY01CbU00YW04?=
 =?utf-8?B?a2dRZ2hHTUdJRjFxYzFtZXcwY2ZCRFRBNnNoUFJINjh0OG1hZGNQcjRIZVNv?=
 =?utf-8?B?UDZHS1dSVFhjTFJTWHZJV2NXOXNuUG11NmlEbG41VzA5aEFCQWd6b0tpNHAr?=
 =?utf-8?B?b3BSYS9UVkcwRExOMGpWMHdLL0pkSWsxWWM4VDYwd0dJemtGNUFYdUVLQ2s1?=
 =?utf-8?B?eG5qV2VVQVdYeTdTZnVHZlVXUHdUL3VXeXpVY3lBQ1ZzYlVuUUxoams4ZGd2?=
 =?utf-8?B?UEovREpWWXZSVXhFVHM5ZEJGcGdrVVVRZUI3ZHp0MWhjbmd6bnArNm5zZHAw?=
 =?utf-8?B?N05KcGlmbWRncGZVd3JoMDZpaUhGblplek1RNERmWDd5eVJBTWlBMUhuSmEz?=
 =?utf-8?B?V1dsZFh5c1k0M0RweEhZZk9scnlaK2drZ1gwaUlZMXFwcWhuMUdpZ05jdGgv?=
 =?utf-8?B?U0tkMHhSNjljbnBMeUJKc0NoTDF2RzJOTDJLKzh4MmNqdnNSRGNZa08wZC8v?=
 =?utf-8?B?bkF6R0JiZHN2dGdTL2xuSk5TRHZiclA4ZTdENnpVdHJ2TlRyeEFYQTVuR1dy?=
 =?utf-8?B?MU5pbmJTM1pNTXNoc25zRHlUOXQ5djliTHduRXZzdlpielljWmgrMDluTjBv?=
 =?utf-8?B?Q2FhbE9wRFJOa2RKZ1hBbzBMdlNkbnB5UkNmZVh2R3JGS2JBWkVqeG1NR0V0?=
 =?utf-8?B?cEsvQ1RUUGRaOG5RbjhxYjdFeDhBUFJUTVYvbDkxeTdCRkxUYnRMRVZRdlVa?=
 =?utf-8?B?cURySWRLdlVmRDlnZmIzSmZRZHlNV3MvbDdZVzJva214MEJVRytxbnNTOUo0?=
 =?utf-8?B?VkJrWHRFVllpV0V6M1hpQndrWXdWdEZJUWNWOHg2Z25wVmVDd1VqelNrZExy?=
 =?utf-8?B?eG94d0pkNVl4SUhzc0lPMG1XdjRibVMvbjFYMkhCVFUyMUhsaXJGeFpwdnl3?=
 =?utf-8?B?aTVrVHZJS0hRZE10OFBCaTZtN0pjQ3pRR1VtWmRORUdXdDA4eldvTjhzSFEv?=
 =?utf-8?B?ZmU5TjhlV0w5cU1UaExqaEdGRXo2dU12L01CMHZLTnFWM0t3T1NuVzlsejFT?=
 =?utf-8?B?eXVvaDFNczJidVhpZDVuYUlFak1iekhOVFRKemVOZmpwSE95eDJQaFJGMFJs?=
 =?utf-8?B?akZqNVJYTmhkQkJZNGRzdktLS0RUWWwxeTUxa0ZGMHhhREl3bkh0N3dQWG9z?=
 =?utf-8?B?KzliUEhSY01ObFJVNVhkS0JKSnUyRmpHQndhT1o3aE5oMStwVDREbUVrUXpT?=
 =?utf-8?B?RmNnWENLakZOaHQ0b0xmeGdOZmx5VXo5c2dkN25rVjg1UDRqOTlYNmI0OW82?=
 =?utf-8?B?ei9oZXJZQmR3TkFEbFJRTERRRzB1d0tCd1dpYkU4MnRwT284dEs5bmtFQ0Np?=
 =?utf-8?B?NWVUZzFRY2dKQTEyWkprWTNDU3lWelVsQkd0R250Z0ZPdE0rd1hrODRHWDQv?=
 =?utf-8?B?RTJhRVhETWZwNi9MNmVZSUNUcU5RMzBaZEdRb3pGSGVCdXl1Tm54VHpJS0hr?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/EovHeMgiOec91EXj7xsOTIhZbMvXa9XgODd+6Kb2nhDycebqwzDRHM//YRw9SiQKh/nSl11qluCpDxShMUmFrMjCRnd/lTrtOIGe1UU0y4rfFAjeHhaz5O8ZtD/LELZZBJcKX9mqHzSpMcpnqAXdV3dIdeJfAWFrYJWc2q1X8y6LV291jX2SqJrtLezu9D0RvwTIHjx5dQxEE9DzI9EPgdrFHV1goZW3RDW+ecUNuR+AOFZNsIPVJKXc/HM/+rU/S/VuHVbKJAgKqZ0DaOPatmKGp2h3MbFoyfRQOXnEuT/k6iiRzCdI5tYHAPYNI0jsZHnDbiJCOvTG6hVcYisHFJ3PIioMjEomkPAZIWzQ6eaoGb6t9YUiGZF15/7vYGfF3e1Fn50CutfzqoqMh0o18HdnOgucA43cZsbbMxZWyLFsU/lOmSY4FupRes8T/9IeOuL6eE+JDlnk4G0Ur6ZHflizG74L7iHMGt3qHTmrDq0orRdUtpXktj+lxhTyoww74GDhulHjzaGpLsZQw6jKr51++wbWxwewcrF6EnU6QTzh4wSo0iW1e0TK96NPlj51KTAsqVZAmiB9BrV9N/Dpzji1SpIezeMbCDG/LIaUfw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8673c7f-1d31-44f8-8957-08dc45167be2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 17:36:45.1267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xAo497uGZqFpDMEMekPuZ6ckK5c420lzuKbT4a88uWCoBIaqFrT21FEX0mCBiP3Jw/KI5Vx/zbZmTomjYVU4/RMxHyaPy9hWtEjG/o1DK0dI7I8QWNveN50IH4+rwqRK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_04,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403150143
X-Proofpoint-GUID: _wxA_Hcjkiiks39c-wRnZ1q2NVaR96u6
X-Proofpoint-ORIG-GUID: _wxA_Hcjkiiks39c-wRnZ1q2NVaR96u6

Hi Sasha,

On 13/03/24 22:06, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.6.22 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Mar 15 04:36:58 PM UTC 2024.
> Anything received after that time might be too late.
> 
No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.6.y&id2=v6.6.21
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

