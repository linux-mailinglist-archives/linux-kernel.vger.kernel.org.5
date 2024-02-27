Return-Path: <linux-kernel+bounces-82908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C64868BAB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E571C2221C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3425A13664F;
	Tue, 27 Feb 2024 09:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l4Dh4Nuw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WA6nrwC0"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6244135A68;
	Tue, 27 Feb 2024 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024808; cv=fail; b=eU/nxC6ub/B37kvGHToBTMpxMPj/+cagMwtqshp2MuChF5WpKKzCDp6znnOCcuTmgOPbL+wLV5TThiCvvSNPhJ8O9HN3ogr3fu9rcOOtmDkb/uRralqNuSAEk0g+G14q0b5l/CmOA9kFLsxcfercweVznQidwkCs4OzAs8Ov0fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024808; c=relaxed/simple;
	bh=fzViQb5YVN09J42lpxsLCCOGxZrKlwaS2FgTiMRS38k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nJiqYctysQq1J6dIlMq1LA52KeATUmJys32EHe0/jtvFwI3WVV1K2SZHqGOlKEtO+SoWd1qpOIEtHL51E9Rnvou1cPWFgk/FEwP5ksQVpDiemgqeDAxScf345h16dGIaw911ec0F5l/Fv1UIG7K63qYw/D51wRaIzOlNcYiYfJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l4Dh4Nuw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WA6nrwC0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41R8ifAB031794;
	Tue, 27 Feb 2024 09:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=TgOibxE1knTXJF5QNjwoM2EdOITYtDTNYYsu6uuRzF4=;
 b=l4Dh4Nuw/h//MPpi++naqxJU3FVflABMWth9BRHJ8jtVj//VytKl6ID7doyUyyoHm01m
 iLzcSA13KX9seJOVE43FzR4zBx1IjIHFnccJ5UU4SwnHIrDq4pz21SwVCIcEvwU8zRj5
 7E1djqNCL6yaSqEOjdu4oA5g8hEDg46Gv6r9okZ+GARt8MJLkAZYyzT7bWYcSEoqdRbf
 Wa44bOPlCwsE7s/tnF5+3XtXqLKY5cK+yKaEeW2/y4jLL63cJ6XmVjaIjRJdjsz+veJq
 ivSYYGQvo/6gve2aLBtypuWdAqGNOwVPyfzzwAn/c2OdDKYyJDtNHujXuh+7iD3pI/ss aw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf82u6js8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 09:06:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41R7mnxE009790;
	Tue, 27 Feb 2024 09:06:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w6vfj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 09:06:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOkQxacnvw01oc8dOv62F5YUeBo4MlOa1gINLL7eBPDU2OstMizGwn4Twui2qaKl+O+sW7iZVqDFh/XZkXj6OOzluCS/razn1CBtN+pWM4z3j4H9a22ojvFY1JW1FygU69FXJbfwzjX/GXVKBuG4crWUzD+nh/+UlVqPdAtLQfNWB+Dxfd5PeL1hgRxeChLkRqa3pcziGD6p/lt86IuqMC4IBdh5kA/4NwrVo/DKgwh5WnQighUha54h1dVEYXUyeS8rrrdfN07hLPazWWLcHmdOzM+u3kbskt1CYUId+kzNiQlb1MLkl6gwaJedSy/ddPlWdAD4p7R82F7m3fih8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgOibxE1knTXJF5QNjwoM2EdOITYtDTNYYsu6uuRzF4=;
 b=FrMzuGZZnc3njaEf60LmkDV8jc/oas9QUvPv2oxCKty/v9YUnrPb/D2yRFCUs1dseLMe0wet21I9mKk/ZKTlM2/FMIFRumaqFfmXqPtsR+1izW0txFa1XikfF6F2g61EdzyFqwjCj2GL6i8rrOyprsKaUUHL/d0N0vjoc3wBxro8yluAhe754519yWK8Yzv/L5blzZY4ZuefOYnkwhsBThzPADNn6b3iXRialPjWSYASSwCLxHjSXxm6hLMNmTRyTcfFLoDaj3SC2/uOztJEsTxHjagB+bhom7DiXF4FgK9/56zy9GzFKpEqNec4LALNY1tfpy8UdBMUFDYvI64vkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgOibxE1knTXJF5QNjwoM2EdOITYtDTNYYsu6uuRzF4=;
 b=WA6nrwC0CtOM5GKHyzuMV4Yt8hIylzHDoym4KioLWC4u3U8YeTIWy2iUO8B5Oh96BQzo22RoHjvkhHNDKPx8p4UZ6nGBRkfNpvPMvN2BE0+Rtn6Eoj1mLzqdHLBC61oBxOa//rBu2aXK0oYaBPlvs0mZrnw1fYlOTTK0C3oYZbg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV3PR10MB7721.namprd10.prod.outlook.com (2603:10b6:408:1b7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 09:06:23 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%3]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 09:06:22 +0000
Message-ID: <7d132b63-7336-4f59-a5f0-5ec37c3c34d3@oracle.com>
Date: Tue, 27 Feb 2024 09:06:19 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: libsas: Fix disk not being scanned in after being
 removed
To: Jason Yan <yanaijie@huawei.com>, yangxingui <yangxingui@huawei.com>,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        damien.lemoal@opensource.wdc.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        chenxiang66@hisilicon.com, kangfenglong@huawei.com
References: <20240221073159.29408-1-yangxingui@huawei.com>
 <d765d2c5-3451-4519-a5e1-9e8f28dcd6b3@oracle.com>
 <cdf241a7-8504-5b87-2d18-d2a971f6ebb9@huawei.com>
 <8dc34f04-943b-26fd-01bc-34fb98803503@huawei.com>
 <b2ab5439-361b-4160-4e73-171026ecc486@huawei.com>
 <8138ab55-1c43-8df1-dafd-95b16b7b3ce4@huawei.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <8138ab55-1c43-8df1-dafd-95b16b7b3ce4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0301.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV3PR10MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c81791e-7267-4cae-e905-08dc37735e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Adu6BP1PiysM0u5S/YH5W8glW4127xMS8rvg3wwLEulH75kA9sYGVw3kHs5onOUb0JSzb4YZFFJyKuNR7JU9lFI4ts1U8SKXZ3Epk5V4vLcnrsuVdrijsV8/A/5iZ0xXvvxkM/SMIc+uIDqhr0b0KTKQ7+MqfiNYb0aEXpCg70GfD2B7CEpiww988lndHT/PfQE1mjiIxczOy34q4pJpgtd1pXrSSFcuMMiggo8W+mIrhB1XQUFoHVTUYzEx/+wwrlYA/eRgD8W1tqjhNbNRiWyRYtFV8l6SbeZy3U7paA/eTy7IAVAMOd/aPBjTV/ZtYuh/bwg4XU+5+paVPp5NNJ1q57W9/rrbAH1IRPR8BeQyL1bHzMSqRUs+q9yw3P4ssz81xPEm2b+jukD1uWgQb1GHhh5VpCc+7RVhpxaCZJuSuQY3H/4AkvIJiynMVf7kzdtb/DZJYp3GJcsXueQ5zne1CXpXqou3oTtU/lJNl7Rsdqf3qMkU4/0WiIHgPuoYBzyrricAkHt4CwJvnKUxC/4UvpbiQGyBCHY74gbdrEFb2UcEVp5bjo1oD0oo4lUzHM2omZopQ8hoKHfKF2M+nPjDtu2yjro+uEEd3CbmYcqLXl7HlnnWTQt+uWmBn7Larr8hlMGZcG63wJi6qCzZvw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T3VvYmxHZC85WHRrVm93T3h4bERhUFRxUlkzOWRXTWJKRk1sVk1vQXd5RlRT?=
 =?utf-8?B?b29SL1dRSldjSnJ4Q3creU1yM1hTbzVCaEZ0STNWN2tqT0I2ekdvSjhLY1V5?=
 =?utf-8?B?bGUxMEFGNFprbTM4ZTJqV0dNWG9Kc01HbHJpWVNyMnVTclJkWWdOSGVIUFhx?=
 =?utf-8?B?NjNqelRmZE5xN1F4NE53SFR4TGFpendYT1dPTmV1dGFvUGcrQlpUMnN6T2tV?=
 =?utf-8?B?WE5IcmRWYzRFZ011Z1VrZTAyZTBBZHEvWjhxMkVTYXB1ZUQ2RnU0Q0lLS05D?=
 =?utf-8?B?WXVYQ3ZEVVg3TWtyR3RqSHhWbERxUmxLT2dFZWh0MldBOTMyc2pwRVBxdW85?=
 =?utf-8?B?dGdtaWpISFkzRVMydmFZVnVDQkNvY3B2UFJNWnVpaGxWakpLbVdUTmk2Zm5F?=
 =?utf-8?B?aEwrMitkVGNLTXgrU3lxUGtaK2d3T1lCWEFzS0l6Q1cwdXBBRnk4TzlDajRw?=
 =?utf-8?B?WkErOVUyZTdNbU5qWURGbXBNVGNBYnZnVnR5amRMTEI0OUxIRlNMcmNDOCtq?=
 =?utf-8?B?M0xXTldLclhrT1V0WkVzbjF5R1NIcnFYK1NyUVJOdFNYdTBLNmhVL0ZGVURa?=
 =?utf-8?B?eHhkTVQ1clIxWE9qWFVtdzNhUDVXemtMYkdmRlh5WXdmVGQrbTFUejFnYjZj?=
 =?utf-8?B?SkVsZDFiblV5TllMZ0JKWWdncHlIemxjRXYwbWhJS0U1TlJMZ3JHbnFmWVRK?=
 =?utf-8?B?RkdCNm9xSUc0QmgyeU5lemoyVlpreEwzWndWTTFSRE1qbHpTVllBTmhqck1o?=
 =?utf-8?B?MTNaSzIwY3RTMXRwZkxsTmZLWFhxZ2FrdWRSRmNUZ2F1a1ZlLy9YRGtkVjBX?=
 =?utf-8?B?QUJwcDYvREprVnNWZ3RINWh4UjRnMHV2R2h6c2w1ZXAzUVBjUXM0WDlzak5Y?=
 =?utf-8?B?MWdjc2JiSnpKbkh5Qis3dkRZNjB6bnNJQkRiaURHSitvRGJZeUNWYTlPRG1z?=
 =?utf-8?B?SkoyVkhXclRvME5JYmhpTERBU01UL1lOdFUzUm1lTkQrQnlMci94dEgyUlpV?=
 =?utf-8?B?V2EvUDB5bDljUWRYbzN0bmtxdHYvUVgwYmhJdjJ6QmJrbmlNMHBTVEVheEd3?=
 =?utf-8?B?QUZ4NTJzQXhZMHB2WEVGdUtVam5tenRKY3p4ZDRDT3hhdThTYWtQeHJuSGhm?=
 =?utf-8?B?cUZEZUJaOVBKdHR1d3FqTkM2a2ZxVzI3aXgrUDZMeTNyWnB5ejk5QlZlaWxV?=
 =?utf-8?B?MndiemxIYnJHT1p2dWV4b1A1ZzVoM09UK0pOOUtjSEtBSzVGWENqQnJrczda?=
 =?utf-8?B?NVFGbHV6dGtpRllGaXRReVRQM2xiOUhpRlJwaHNRdHNSMk55b2c2bzk4bW0w?=
 =?utf-8?B?Y09LaVd6MGt0RUVkcnpKeThReGI2bGdqT01GMm85VTNOWjh5SzlpdGUwVUZQ?=
 =?utf-8?B?NXJWdkNlajVsL0F1VnQvckZZTWxtNHpVN2VXKzlYNkxFc0tNYVVTenU0ZkQy?=
 =?utf-8?B?cC9kZnhBTmFRNXRFWFlWNndVYW5zK1lIMkFBZGxwU1g4TDRjeDhZL3V5UU9s?=
 =?utf-8?B?ZUxBbjJ0WVdOcHk0NkNQcys1V1hiWWI0aHFRQU9FL2dZdnJaSm1ZYUc5TW1x?=
 =?utf-8?B?ZHpxTENjL29naCsxRE9FMW9weHhqRVd1MG9IZ3ZHd3U5Vm4wcnBtQ295VEsz?=
 =?utf-8?B?cDN5eXRxMU9uZ3Y2TkNnSzl4R1NUWGpobXlNMW5qRkwzeDZPdzlnWnBXd1pN?=
 =?utf-8?B?UTNjU2tFQWRqTmdTdUQ0d0lFT0loRjl5cGhFU25lNzZVb2dEbHFONlkwMHRa?=
 =?utf-8?B?bFBIVlpobmU4RjIrOXZIdzZ2UTZmTWFlYVFRWldLRnU5VEJlajgvVlFmamNJ?=
 =?utf-8?B?U0JIOWwvWnhhZlpyckVLV3VPTS9hODdDSUFJZlFYS0pEenp0Q1FVK05OdTMr?=
 =?utf-8?B?N0t1d0JVSWRtUmc5dkNYbUEybGYzSkU5dlFwTlh5ZU4zbmhUOC9ocm5ucWJi?=
 =?utf-8?B?aHhjVVdDRzNEODlHbXVjL2Z1TytxaHFHUVkwYWY0eFdhSWVlK2YxTGNsV2tC?=
 =?utf-8?B?Zi84S1ZMdi9oU3hjOUpjbUgrYWU0aHRIeFZ6S0RQcktmOUZlWE5IVkJtUmZ5?=
 =?utf-8?B?WlRSbURjV3hJalQzN0FPWlpiZFhqQ0p3U1EybGNVNUtJZnJreVdXZWUxVzdD?=
 =?utf-8?B?VllPRjMyeWxJVytrbGJvYnkvOTBFWm1hNStSZmlWR2s4aFdiUzlLU043WXQ0?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OR62mmCIMbdfxHim9UHUbU0CLCB3RzBI0CbpO8WgfkQSCegKVrdnDfBrauZcv6gFnmRp7nNEOEUFcNs7wlO261AQxLhY/EtAqHg+QfCa4OuFtKfiPQWbCdzio+kYE6priM4HBTimCfRFYRshAoVZgTbCUEdX48Uni+gPySVj/fh67oPIAy1a7bmv2rCrQqfv7NYMWRCatRyaMOpjGXhDTH2wxUyS2fOk7uR4prgFVu0Fpo7/1n0LRIThpeTec1vGNqm6tCKW3A/DIiHdvXD0ojKFsDNC6hgjROEPOcjotvXFkbq7EvcRc0P4j3AS+IBfkSlnbE0BeEyYQcCrawbzgoPidFBtQtGQA5z9zlli05R+OyxLctjYBP8YXm7ba7h+kO4vW1wlhPy6gQQ8Kc6oWiBLcd3h6g5EWh36a3NzivfyEH+lPdK1uPnYmuL5WxgNZZoMWndC/LQMcA8OwMEaEc6teBZ4ZZV1XCZ60Il+foJVBwaf0y/St3pBXnqfVsSEajLaRea0c73utYGhD3iLuwnHqgE9xwFmaNFz3XdsbBbs5n6hYXoebQ/6xbnW/3lUuxUF3qUaQCvwCD+pKI5iyPwADDHudJQhwAIAxxfyPLo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c81791e-7267-4cae-e905-08dc37735e8c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 09:06:22.8728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTemxVUmNddQ/9SUhPMTzZ7ZUlX/Z2PgdO5/B5r3ILlZNOnMIfHmnyn2Y95GwT/kqNPuWZmOaad0+Yn8kjQr9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7721
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402270071
X-Proofpoint-GUID: o1Z27VFmxh5Ez1qhNHrIVuaoIt8r0zBh
X-Proofpoint-ORIG-GUID: o1Z27VFmxh5Ez1qhNHrIVuaoIt8r0zBh

On 27/02/2024 07:16, Jason Yan wrote:
>>>
>>> Can we directly set phy->negotiated_linkrate = SAS_PHY_DISABLED here? 
>>> For an empty PHY the other variables means nothing, so why bother get 
>>> and update them?
>> The value of the negotiated link rate has two possible values ​​in the 
>> current processing branch: SAS_LINK_RATE_UNKNOWN and SAS_PHY_DISABLED, 
>> and both come from disc_resp. If we do not use disc_resp, but set a 
>> fixed value SAS_PHY_DISABLED for it, it may not be appropriate.

But we know that the phy is disabled, right? It's our phy, isn't it?

Thanks,
John


