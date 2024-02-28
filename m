Return-Path: <linux-kernel+bounces-85522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E2D86B705
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EEC92851DF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8F84085A;
	Wed, 28 Feb 2024 18:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DQDZgPFm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wEIcoWOD"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E06D40849;
	Wed, 28 Feb 2024 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144311; cv=fail; b=CQS7zaAinlLAV2wfKH+uG/ds4l73VIzhUIYAdTeuPBhbQYY6ECrcZmeOvXBk1HL6ZB3udC9gA1Mu7DD6yFvxkEGAmhbHCkAAMCFHSbN1PXv20h/3zcloNPGcPlVFnVxsBskSR9cbVBT5BRlsEZIIY7WkgTZF5LPhCLHD7tQm/0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144311; c=relaxed/simple;
	bh=CxoddcEW9Dim9oP5JI1pR8IGW+QHkbWVSP4Yv1cEcQg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PhmT8U4DAsCvJOCfHHvq4gWZniYjjblRZAdNfRprWWpAF4uZ0ZxTH7IwVZsCHOJeg78WKQZujGUiFoGLuJvOMqC5w1mRWw8cS08mAix0sZvmDT15XrjrorYq9+SYIe/Be+HkB2xSbNMAX1o8pNkUA6/QsyCUoMXc75HRHiftG7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DQDZgPFm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wEIcoWOD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SEdgbF010752;
	Wed, 28 Feb 2024 18:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Zq6FARUpPgFMNfOCcmnYkTcgbzOc5Vcnv7DvJ6rnVUY=;
 b=DQDZgPFmI0tNjQTlBJF5/qPDmkr52V01uz619Wx3/bpszAmkFZJA7S+VzuKwYi6eU/7E
 qHWPPixlF+t2mLnZL8KuPTx8wI5JHhYuiE8f3Z++T1QIB3BGQmK1YwHWNGczuZ2u9epA
 ImlVum9hFA8zhdkwaaUTLEEbBEzT9WKJ8qXkC9SyXc0ZPWAZuK1s11MOtbReJK3Uh/Ec
 CXf2RIgR2b0LiIvSyEGyWCw+HjT6fMN7Co1K072GAXoXhkEzVH19lrGTK+InXuAUrJ4m
 kSX/jEZs+9WRQMkQVXCIVryrd748YBj6ZLqaXf+Z5CCXItsj0yu2SlLMF3WRTct6vXDu dg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8bbaw3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 18:17:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41SHw9PE001793;
	Wed, 28 Feb 2024 18:17:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w9a887-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 18:17:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwTLmzlsVlTtx9X86vGIYCjuealsdb4nnoBztRmdSAJXio8bJHi8sOGloO53Hp0fcxa5N3Y/wTqNhlsQfH3DFrxKxmyqFUK/TOA4o523/D+gqumwnksU2rG3g3hRT8uLi0Sl9VmhSTE6zxfPxsHhWOuwRDykREBYQ8RVYaKW8kxlhI/zt6GZiLcXrSfb3SBj5Tz75MUx4a03KM5BvW/QnJIOJ6xbzNFeHA89NrsHksK7XMh1s1aJsKwSwF++JVPZyVACNGrFWEASVovvLYZNz/PIsNqHchIgDImF40eQlY/ozMj7CtoY0p/xpAZmNflMyu23HnA9Hynec8GOCe8Kjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zq6FARUpPgFMNfOCcmnYkTcgbzOc5Vcnv7DvJ6rnVUY=;
 b=ANHh4Z0yiBODdF+NWL1y+2nlMqO82bRWxyse6jIRqnuZOVyNgCiYzAYv2cde00BmBC4ZIA0Aya+owr5gksooIKd21Fg1zZ6APBLLpHoh2CCXGPvw1dUeZEt8IgXW6vVRFS1D0yP85TB8T2MYb4TZ+G7ebIU02seWBLlK8YPjfMd1sVDDIsZ5lS22adiZ4jIqsUS2ZEztqaZWrifyMiX4LJlp0w2AUYy/eNEwTkIU3hTu058ri0gjLZ7hLCwaZYp9GlBzeP2cq7HbXrZNwP9ftjJrQAQbpE1olCDArKQjULAf8n078FIi0NGsu3c0E3ljrXJJpSXhRVNaV+086uKnvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zq6FARUpPgFMNfOCcmnYkTcgbzOc5Vcnv7DvJ6rnVUY=;
 b=wEIcoWODC8eDe+X991nHPpy5D3MPZffwv7dT/V44/c7kjsS9S4mCDgQuXwTBqs7+KATLuURArmOgNzPRhjQYjVsOqae8MwC26pxUgO3WFIc8QbOwslUhfaZqLkhxM7HyaWJ714CO8CT5urSwtO0KLjP75hfCefjXBATlAH/WLCc=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by MW4PR10MB5837.namprd10.prod.outlook.com (2603:10b6:303:18d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 18:17:39 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183%6]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 18:17:39 +0000
Message-ID: <1e8c0c74-3fc3-42df-afb2-5105af63ebe6@oracle.com>
Date: Wed, 28 Feb 2024 23:47:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/299] 6.6.19-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        Darren Kenny <darren.kenny@oracle.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20240227131625.847743063@linuxfoundation.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|MW4PR10MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bd5053c-ccce-4953-e476-08dc38898bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6GabBYeuA3BrTM/oQfTvxv+OjKpHwMuOtTcmREefAS1kEMxrKXKJZzZYB67Kev+1RnD5eB++mV3CITZgy5TinIe+xfwq18JOHpFkaMciz9aAaX55xOcvYz7ftsRXX+knc4nqORxdH60QjItidVPTaF9sOeIJUjK6+u2iR5npk2tHbCF76tYBfE5kYwcXZ0zuXNPdM8MZl+7EstsVmwP/jY5b/YAe+1sINwbaJtnVIYnw+JHlgvn92a4KRs1o8Ecl9YEw1BVbPTJhvNLedTrVMyYV7xr7bKmrfZMl9+RNz3kEZ+Nm9b9zLZcB2u3ww2ogAKHNDuZellvttGc5W22nOWhC+X7e87ZQRcZbFUB4i+Z6QQmNcYImAJlzZwVRiSRgD5bSt7BSMxQwBgSgveE5nQ32u58T2DtIlX5gCxti+XqLRqN4ldJ3XEbLS4FeT0pWXv4OeqREERhaDICepiVr3Jyeqg/lxCVjzcfA3XVouVgAXXOjMVj7oq873viNozwBHZcDv6/CKYga7ZDhXta8FjOSqqFY53xWjbht+6P0nyX/D2IY5vQzvrjhiwUa8VbaO0n7S/ZJAMcwu0EKPoytYQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N0wvMDFZRE1zUys5NHBaekxKYlczbTVGK3dTcjFRMmN1ckUwL0YwaUdwbnhr?=
 =?utf-8?B?TWREeHBRanVqTjI1M0JNZURiQUFqclZ1eWR6bU9PemloZkFYaXM5Q25oa29Q?=
 =?utf-8?B?ajFGVnVTeDBpdlprc1dPU3BLZ2dCZVlGZHZveFZHSk5vOEw5UHd1QzVVcFYx?=
 =?utf-8?B?UTVkK3NvV0ZoRzhaQ2t3N3Qra1pGaU0wR0RyVzJJc0hxOSt4SFV3MEdSRnNx?=
 =?utf-8?B?TkZoYks3RGt0cm5OZkVzUzlRZW9rd203TVdUZlRpK2RCNldqUmhLZUJCWkN4?=
 =?utf-8?B?WCtZU0RvMEg4SUVPdms0QkExNkZZaVU4eVFvU1I4SXF1ZU9kMjJrY2s1VTlq?=
 =?utf-8?B?NWlSWmxjcjl4S0Y4VHdhL2VzeXJGMWNTTnBhd0VOcFRQNHRDem42bFlTdTVy?=
 =?utf-8?B?NWw1YXhRMiswYWhlTFZyYzF0aDdDYjJzRmUrSGkvaFFoMlJIZitQNlF4ZjQ4?=
 =?utf-8?B?UElBWDY4c1dtREpkQmNqWW95YkFHSFVZZE5nNWR1Q2YwdzhxY3VIZFFCK2dk?=
 =?utf-8?B?VHdUR0tpbG5QMG93NEdvN1Rub3ZVVHB2MEJtUW1kemYxdjg0ZEt4NXpndUZ3?=
 =?utf-8?B?L05zekJFd1gwOEYxVEVnSEpaRlhlZHEwUmtRZW9yNTlENWlwZDRJZ1A1L1Ns?=
 =?utf-8?B?UHdCcjBNRVZ3WWszVGZkT0ZPdzB6blpqcU90RzJGNFFKV2lwQ0JaRURrYUtv?=
 =?utf-8?B?aHFOa2Zrclp4bmlMNlRwRnk1N2lvV1d6bGtMTk1Pa29wdThiZGJMcVVVWXZk?=
 =?utf-8?B?T1V0T3Joenk0cVFmY2VacDRrKyt1a2xLK0lGcUJCcVp4SDA4KzNPV24xOHQr?=
 =?utf-8?B?bEUrcStJUDV3MzNFS0x3ZmhyTDhEUk1tU3lHeGM3NHlzbndZcFoxNno5UDRr?=
 =?utf-8?B?THhzVUtFQitsTGhSUUV5RkpIUmM3MWlWckFacmtDTzI5aXNsTkFtaU9Vdndj?=
 =?utf-8?B?TXpKaFpkQWlqWU9UYVVLNWg3eVU4bW5Db2tnUU44K3dBWHJNWmF1OVZKWDlF?=
 =?utf-8?B?VU9UM2pBOXR3ZmF6OThxS2tKRkU0MkpYdStQQ3NVZzBKbElWSVBteklLSXN1?=
 =?utf-8?B?N2dNVjlBYlV6bmZ3MFg1cnE5ckNOTWF1S3l1S24ybWNITGNtMWcxL3BsOXI4?=
 =?utf-8?B?Z1NpOHcydVhIcXdUWnZVVXZraHNLcVZpTW9JeUE1QlpnOEtheHVjRzM4dWNP?=
 =?utf-8?B?a2VHbHIwUHpvNlBxS3JSMktZWkNaRkEreXZCZFFFLytyd2ZIYWkvRExid3Rl?=
 =?utf-8?B?cHE0TGs3dk9nUlhxMmwySzV6VHZCTE9ubzFhbjQyUGNUcXRNVkFNQmJDdHFC?=
 =?utf-8?B?UVkxdURMS3AzRi9ENWNTS1JOaDJTcG9BbW13SFRDeDBDRE1hNWlTMVZsTXdB?=
 =?utf-8?B?d21KM3F6ZGdQK01DTVRrbWlvYjJRZWpiT2xzRTZIM1hZS1JNM0FJdzZXckdm?=
 =?utf-8?B?V2MwM2JYdDI1N1JIMGVFM1JqQUtFRnN3Y1ZuRUtsVlhwVmNSRVg0aXJnTk9l?=
 =?utf-8?B?ODlTWkt2QTdta1gxYWlXeUlHN0IxSHErbDNVa1ZzdG1BanZFMjlTOE5QemZs?=
 =?utf-8?B?aDdMZWVRdGRZNHdaYVhBWmQyUXBTNldMQk55L2Jaa2NrbVgydUJwRXBiWFRJ?=
 =?utf-8?B?a1JUOGFZWUlrYWdHWGhGNXdsWENFWG5WTlV5ZFVqQnNYc1lseFQ1aXlaKzBU?=
 =?utf-8?B?WDVJc1FTTXhURnNDUnM4M1Y5dEhnM3pVT0Fob2hSWjgweTRwM1VNOUkxeksy?=
 =?utf-8?B?MFAzZlBJaWRnbE00OVd3K0RmUmlsbUFGd2pUVnZxMTkzcjVQVlNDcE1Wc3h5?=
 =?utf-8?B?STFVNjBWUUl1ZHZCM1c5N1FVVFZkbFpDUVhmZjNPY25kYTNWbWtvblpYRVMv?=
 =?utf-8?B?VGtoaHpONWVNWjNQYlo5NmJxaVdrWHFpekNKU25Na3B3Zml0KzVCZWorajh0?=
 =?utf-8?B?aWtKbm1LckFtNmxQeElKM0h4TEZpUGRZNExsWm92Mks3V0YvZHVPRDNBU2xN?=
 =?utf-8?B?bW9PV1dRRXNWdFlMQVRlemlyOTBiZHg1TVh4SXRCR3ExV1NFRWc3Zm8vQ3pJ?=
 =?utf-8?B?dEw4eDRNVk1lVjJ3bG12ZVB0dkJZaEZoWGtnL2VqeVg5cmdoYWdQaGt2S1hQ?=
 =?utf-8?B?WWMrS21iWWZkYXc4bGw4OWhKRDdDcHRwSXhoQmNYUTBUUGFwdTFmVnBZamhC?=
 =?utf-8?Q?gIoT2fUVXElUSL+ovU79qz0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ns1VgDD/XyT1ZACh0KdSwb0DyOQhTc/8He7Ear8wkFBMydWitZ0RhKz2U6ifS75rQX8GlFgh2uTqS/gnfS4J+Aly4hsGodQXJznnq8vc8lvGe8YsQSsEZdT+/Mw1FN+A/K4Fsq1L2hXHCbcIv9LREA9IUVnPE9V38bKvp3yhrG/cO+yRNCwb0pGAvmpcIsfiiaxwd84Upr2XYsil+uwfyymWRuY26744cUh1g1eLafoKC26JocuyFWk4bEs8sG8yxskcmTidwRwh6yvHl12erT5IAbOT4TvwZAGeEOQ0VkV/A7GDpkdKK0u4hXviWj6CEpd/lXu3hqkxrgIaBhnyyEinT10989jkS8v6B7P2quAGXExOkXkkGucMnPnRBCSkI38+i9l3ep1sM4ar/QvBnk2Z8Zedrm0eBj1WAOY/l2mi1IFw+eafAt/CEc9cDVpomu6vFOixgHBrEjQNNeevBtqXqbrqrgTL4tn8QUhrOfCmCgdqCqhPov/5kcB+lcmowPDTqTCPVK93RV+uACu77rthCHDMZKym9Wx/Tkh6ehAQDKWeOx2eO1pPi7PGfJpmKYes4SB7SK3tbESAuZComvxrWjQ+sHY1lIV2CmIO+Oc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd5053c-ccce-4953-e476-08dc38898bdc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:17:39.0890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LcCxJIreTdMFwrz2rAhZTmCwpvUovYaHaDAZyMJAcw0XF0Qm9121PUGBYVEdhu6Tc0nt3frxrkUCxSHLeqZDUIfXD/VvGUkXaui6mgnWXmihjNk4jFay7HN1jQw1RBMb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5837
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402280144
X-Proofpoint-GUID: aR86StFXyAFLCp4F6K5cAsmMZQNT_zw-
X-Proofpoint-ORIG-GUID: aR86StFXyAFLCp4F6K5cAsmMZQNT_zw-

Hi Greg,

On 27/02/24 18:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.19 release.
> There are 299 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.19-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

