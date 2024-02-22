Return-Path: <linux-kernel+bounces-77258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936B2860305
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4503DB340DA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BF0548F3;
	Thu, 22 Feb 2024 19:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BolYSrKb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r6G48G59"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D67514B804;
	Thu, 22 Feb 2024 19:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708630071; cv=fail; b=om5lBITqQCHV3io+xWY/HXWLsJSLJDedEkkQ+iZhhQFgOf9Mu+RYrO+kzdpYWsDXQ6/NT5L/p60BfgneOCKaAmgbQQMrah/+UU/eZoh9uyTue5VZFWd98guegqqxpb8FO6He0Oj5DG8DEUiBRsf0KyOugPy+LsE7ZGYJ9ekdS+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708630071; c=relaxed/simple;
	bh=ZZqhbzRsqzWhNRMU3B6iwGy2sNADScItXAR3Zc7n1gU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lVxPWgJU5c95buixuHIySzznsNQMJ1vqrqpVG6vH8KqSVXe1+2Oz5GY6WgHGr3FZe5Vo1wq8hpXFRv1n6T9NbzP6ikKe8MWj2E1ODWg8sIS759f5tweT/htCQYXKpD+puVWcv1AIj0JU3wRUA49dLXW6r66deW60QUlr8A4Mruo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BolYSrKb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r6G48G59; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MIQRFW032168;
	Thu, 22 Feb 2024 19:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=y8bYp5ArTZ/zfh3Q46AcJ6aPfrBET183TwZu7uHRxSI=;
 b=BolYSrKb21l1CfAz1zMJPgNDBJhMIT7bJmKSwGqYC8fBeI0aOrrzwaxuoYCyrrlzRORq
 VOwOt8pNfk04/dmCb+07Zbj4y1IVWPvbz+/XFIH161W7H64GJdfF6UcXOpsMJ5gsRWSc
 fUM6TifnY2eY7EyoPCdiiIrYppaD19pzDwtQQ8xeZ5bzi7zp802e6JjnHoH0cpUBIVqy
 Lfc2v0zsyclAUw7vJs0K11G/xMA/Fw3+cORwrEVIypiLiaZlvMuYI6IQv3kM7/PASheO
 iOyIL/10rDFR+mQz4eLtd+7JGX/VKQ7UFck93SWS5gfI04x+iFWGmXyvvyY5eabvYBFC lw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakk45p8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 19:27:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41MJDo19035643;
	Thu, 22 Feb 2024 19:27:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8b37eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 19:27:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKlAOg/3UOTxNHjMe6ARDYauWtkBLN6lmweekoeKFYgYatoIyfPeIquUj+EXINf2eP+FOSp1twcPwaYosvYLHczCEcxXsFaBNNLhpOGANMvTnw3t0aICz6AS2Ec42Lz+Vir9IGnatS5XyFw/04LA6rT+RLz/rapp1MMiaczNiLGlFN6tdza57TqjM2g+1uLKHOo9GqZqgtpcYszhRMtnjvvYAeIFmDKvapYdxe312YnGqZe1t2EIhLX5LZPWLv1I1RuQqbMRQ19Dcp9dAZAI+uwxINI/em474O/MADwecWMvSJ29hJxETCKrL/uY/+faQK+OZNXhWIdZFMcoaUFC3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8bYp5ArTZ/zfh3Q46AcJ6aPfrBET183TwZu7uHRxSI=;
 b=gA7fJt0+0HQHrkmIAS/MbheOPiEPqi3qjTBt6tGyiula7taw7mnWfDiiCD6sQ8Tohl8ZV1iLjeNW1VhKLCo0SjJrYQJCtd+ctQaakjlHqMm8O6RFSYUReKyvIcsYMMB7TuA0W1azGgZHXbMcy4DI7XXsO9Rvpjv0dylmsZN0tAVXdnhjA4CHOCdWQI2CTW7Z5hvgKJLod+697nFLgNCDNzqyrpliR0gNYeV9z70wSeSJkDcmUHtpKVwL+aql3XNwPlJJg9ttMvXclvfMytS3juaQ3J/Dke4Y21iGG4tesYW10sWGLbYBFsgNjPbaUJaKIBOWERZ4iU2oKxvSDEPg2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8bYp5ArTZ/zfh3Q46AcJ6aPfrBET183TwZu7uHRxSI=;
 b=r6G48G59/KjzgoHsZ+vHHSIamQy+T8GZ7hrtKaJyN0tEY5NjNPZSYKLmNX8yyDzJw298wHLbTVcA2xbwINCzT9jtBzSMlDlDbVQihmH8AYjPgWuFd0dIa6aWI8Wbt3OgYoTVCv9aVpiv6J+hwwvRFUrLSHf7iMtcKo4S6CWVCG4=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by PH7PR10MB6379.namprd10.prod.outlook.com (2603:10b6:510:1a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 19:27:16 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183%6]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 19:27:16 +0000
Message-ID: <637be178-32d6-48ab-9863-37eacefe1787@oracle.com>
Date: Fri, 23 Feb 2024 00:57:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/338] 6.6.18-rc2 review
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
References: <20240221125953.770767246@linuxfoundation.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240221125953.770767246@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|PH7PR10MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a0470b5-6bc1-42e5-0ba5-08dc33dc4712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AwHAVlTTtaNKoAtfFHRPhadUWHn/khUdS/undTa/pCchz0aM0FmOx/YXNFhwj2G5tpiBKSflXtWOCnuLtecUVYRYoakKo1hN1fOA6jj5lefd6FJVpROmRdjgLTumWblWlYn0TSdTm+HaWcB/Tlql4mpKy5i0iza7+Iwma6ppiCl9fXmflYxrG6cHDFy5MHLkep2simADjwszJTrkSA2WvshjT/KbRpM5QkcODblkyvPT3Aw4YB5o3uaCn8fWisD+3mgJRwupZNpqB+VL6Vt4UAJV56Wt++EFBGnu/6oPWQ5Eg4d7lwxDiA1zZjjgR6pOH2Xwg1SLhfT90EBj1VphZLV+WSbUC66oY6yNkLGVaC6Vcnh3nMS0U0WCrVwo8TonDvYnyhP1cclxm7fQLoaPs8gcf1bFGD6Xn7SkQmYchegs3pr2A4azeSygvpR8YMPHwAE52adBfxP/zxaOYdY0bS/QMOcbKkN3z6ziGJplOgW2UO1syj/An05BFJOFWolR+5cXwLTc8riMGpH0Ybxt6w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ck43SDhyaTVJblhZK2hWVzlsc0lBY3FUeldXbkhzZVBHQ0xzMkxaNjRGNGt1?=
 =?utf-8?B?TWI4Y3lFWCs4UDZEK2VrTzB0MkxPY2VUNFY5SzF1VTJ2MVRnYzgxL292Y0h0?=
 =?utf-8?B?RFJyMEVMTXFZL244N2lhM3ZwZkFTVmw4b1BMTSthbExFNVhIQlpTcWJxZThj?=
 =?utf-8?B?ZFVVRndhdDh1cnB6NTlhL0RsV1A0MjZKYzhYbFFWa0Y2eVE3K2tZM1ZoaC9E?=
 =?utf-8?B?WEFpWnMyZ01pS2pBalNOUmxDNUROeFRCZ1lNWDVkUm1UdkNCaCtoa29YbFVL?=
 =?utf-8?B?VVFRNmFrQytWL2Z1V3pCNGpWWFFWdjN6cS9HdGVUd1JweVVZN3BJdVF3dDFh?=
 =?utf-8?B?Y1ZRdi85UnNyMTIwem05RDRUOTU5b1JzM2NTVk9rWnkwOUZFeVEyZDdxOTZN?=
 =?utf-8?B?NFlJekhwbDFQNFdBVDNYUTFVNG96ZkZHTk9jWGExZUhIMjI1QnpaVkhGRVZI?=
 =?utf-8?B?NDJjWDg1eXJYNlNEUksyeDlYZ0FpR1Z4K3FodEN5ZTJVS29DTENMaE9CTkQw?=
 =?utf-8?B?dllWQzRIN1lVZUp2S05BNnFoN2hiZ21yT3hVZHl5Ty93RlBxbS9lLzFlSDFY?=
 =?utf-8?B?YjZHRHFQMy93bmtmdVJSY0pxS0pLUWJva1pSNFV3eXBqN29QK1RLeXJlQnRP?=
 =?utf-8?B?SkFCaGJHWXpjNlVUVWdQM3pnV0NadXBicU51RFZnSWFuNkJEb1RpMERvQ3Na?=
 =?utf-8?B?WnUzREZMbmJDRjhsZ25NNm1YVjYwWVNocXNGaEtaN1NTanpVd0QrVXNXa0VQ?=
 =?utf-8?B?Qk9JMHBqVVcrTkQzOFZ3cjhEcGl3dWxRYmR6L0NvZGl6ODdnS2gxa1V3R21v?=
 =?utf-8?B?aGxhUXkvMStpdTdJTjBxTmhpWTRad2M0emV6MWx2UTZiQURnT05mWERuZnZJ?=
 =?utf-8?B?RkYzcWs3MzFCQXUyeVlxb1BDQnFyWVVqOGtDUmtwSUE2K1h1M2lELzBlbnJZ?=
 =?utf-8?B?RlVTeHlncTVzWE1mUE9vcUpmb2NWOUVUcEJsV21MdHpCWERGTU43ZnBVaUVZ?=
 =?utf-8?B?Qm83MXZ3R0h5d0JZTjR2ZmtiNHRNY0Y4Z0hFdGxIV3JBMVpDSVQ2NkdrNnlx?=
 =?utf-8?B?aHU2T25UTGg1a1pLNW0vY3IwQSsrTHk1d3dyc0lmNjMrQWZ5MnhhLzVob2ZM?=
 =?utf-8?B?Q29Gd1FqRExlWmR6VTdtdEtVZFFSbHJaUGI1MmtHektuMVNMQUFDR3g2a1dr?=
 =?utf-8?B?eFNzUXI5UENVVWRsbkI4bmlPQjVSV25QVVJuMFVvYlF4ZmUxNnRROGxRdEVQ?=
 =?utf-8?B?czhoa3NzUmNSaW00cE96SHBaNGJVMVFlUFNFZENTQVAzZG9aNVNFNnhrYnBO?=
 =?utf-8?B?aVhzSjFOb0M2ZHUxMVNadFRjYnR4REdGeUFVc3Q4dnF5Q3NXNmRBSm1QWlBJ?=
 =?utf-8?B?WWttOVVMVVBKQjlHUC9LNzk2NThSL3QrVWk4RHNOZHpPUVE4RFRwS3BidXUv?=
 =?utf-8?B?R1did0ptTGhBaGFtTmhKSjd2RUJoaWNqZXVJVE5IZ2Fpb21sL0ZPUElBUTB4?=
 =?utf-8?B?WmQwNjdyQ1ZXMnYxNFM5YWljeWdvSmI1WWh2NzllL2FjdzErK0xtU3lmelhN?=
 =?utf-8?B?bU82WTY2dzJ3NUNCckV1TWlISmVOVjBuQWVQYTMxYXJPV3R6d1hMOVdnYnFk?=
 =?utf-8?B?am1FaVZ3cVhjMFVmN1Q3M2NjbTlCR0M5NDR5TndJUHpUd3BFSE1vbkhHU2xG?=
 =?utf-8?B?SlFYMk9oNW5FWS92cGVIRW9YMkErYi9oMENQM05IMElsSWlxSlhzQk5wSnBX?=
 =?utf-8?B?bGpNY1lQU096bnNWQkVLeUphaGtmRDl5ZkxOZUZjbmd4OXQvb0hIQ01RSEVm?=
 =?utf-8?B?Nlk5cGoxbHFkWHpjZzZSYkExMFFjNlJUN09penJSRm9lN0F2bTlMUEF5ZG45?=
 =?utf-8?B?U0NaR0FKQzE4RldhY1NNblFhZXd6aTVIRFllS2RrWjRzZXljYlZXY0VwUkhs?=
 =?utf-8?B?VmovK0llemtIUUtwT3hNeGl0NXJPSjFPREM4S0dzbThUN3E2RWN4NVE0cytm?=
 =?utf-8?B?anR0SlBDUExNL3c0amg1eHExdWgyRm1MdE5jM0ZSYXZtZzhUN2p0NUI4SUNa?=
 =?utf-8?B?dHc4TmtRY0Fva3hGQjVWZG82elNCaHA0R002d21wUFBGbi9pY3pxSHhodGdW?=
 =?utf-8?B?bGFmaWUvWXh4K3JGYXExZWwzWkgrdmU1Mm1KZGNrc3N2WkNSY1RIcmNCa29F?=
 =?utf-8?Q?+4q8goNluwhAXn0uWZqU7yA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/WMbL2kIN1Kl2bpnanqM8iFTuVwlzdNgz+SuZeD1tv6pUGx9zVJx7vGIJYYi2wjjdWO/Bmqmr+SKZ5DM1x0tzoBvPdvyToTIXk0ezwCzKiOrdWR7S+ZMkDKEJcbsVroPusFvGS8gToh5hCP1+DNWGHxphHc0N/+Bq9ORI+7Cz4l3hq1dg8Qxv2u/V6pnnfTJ/spO6xGWtFmEhAts5Al0uRyzxGRr/sxbho1y1JyK4WaVnk6/sxaFqkfFzCboGclDLhTNXzYJ8u2ZdsZ8WlabR2mw45xFhEYIuQzW/yQsm/H0p+nAY57kY3WU4XiXf6llLxAmeBc8zRMv1eYlTfoHqzqScpjzAmu7LNfth1JS4iox7+/wORId6IQVcqCzhzBIoMP0Ql+r70RZeO4gNisr2Qa8QtIDEz/hSS+NH4GJfYKX+dc3b+q9hW3UFvCzoG6ISamTFK158F+Yo5SMhoIMLX7/Y2SEdaYEfWaFo2Jj+8ah+GCmZO/7IeLzy+rYZHKKynH88ePc2D40IH0FMlQmZs9cVADrgIc51yiz9nfCu470PQOPZYQ8TtMDxkJ4iBcxWc/pTJkUBbO4ghXD9ReQWn/xQDBa3yNNWI1OO+yx0mk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0470b5-6bc1-42e5-0ba5-08dc33dc4712
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 19:27:16.1341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOSRPYVfOgq9kB+a7tMK3j+0EBDYaYwCnc9ly9ntnbejdmy1o7AEvhxhpVXgUP0wYaLk5y1Mtpvk+3di8fk20ZLIUbI68KtGpM5H5/mFEu87JJGfi5k4CH/WKF0ixE2X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6379
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220152
X-Proofpoint-ORIG-GUID: siDaNsHKvqQPwOBEKRiRbgvF3zzlrr0O
X-Proofpoint-GUID: siDaNsHKvqQPwOBEKRiRbgvF3zzlrr0O

Hi Greg,

On 21/02/24 18:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.18 release.
> There are 338 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.18-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

