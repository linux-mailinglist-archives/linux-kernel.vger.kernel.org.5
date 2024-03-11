Return-Path: <linux-kernel+bounces-99166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEC2878460
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176E12837E4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7221D4AED1;
	Mon, 11 Mar 2024 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MUDmdtTi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SytCwpah"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C95B481B1;
	Mon, 11 Mar 2024 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172800; cv=fail; b=IT+aM2UJb0ODPyxcjb6BsHlraAIXO7R/yYtBUSwvVdFJymmT6FSOyeC0j1+f5JSmJt/yEOHCO/At1GgUj8yZvMn1TdOk6xBquI4Rkc12sbDeF7CJ6Ubc3Urd9tUGyFgrNtLBm+oOBnOXMbLV+U+Xh7wDZLKFRC90txg4OjMP6Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172800; c=relaxed/simple;
	bh=uomkPK3jNrKS1YVmOzfhXFcHp/I+QNV60gWUlx11xUA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o5OVTKVOb1P1k7LfdQr1+N+WIPlhoY1svvYBR8N08pYc7P9HPvkRvmdrAzk4ZFMDbTnHx2s1CcCb72NLvQz+99pjhEQUb/stiLDMfq+W78kmDZodUEceEUpf3lYmCaLxR2tUYYi/U4QBnBj74g5dVbsfvsDTaKH4cJsz4kxfxKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MUDmdtTi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SytCwpah; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BFv384029968;
	Mon, 11 Mar 2024 15:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=EJNYlqyGyirNUT/OLqK2Kg6FW63vQwrAO1hpCBGu5Aw=;
 b=MUDmdtTiFiZoFXpYIbpG992wJfloupV/HR5aigHWgiGy9gmOk5v8pGjuHTPFCA0Jre6E
 1E0Ro8EpUI0hUoxs8oyT9vS01f9tWFTePljjwa4IyoiVvTisbC2LMYbpSYn25JktcudH
 bA8LOmtLbN+iL0zwvJ+0U6XeNdH0vgyoYaA+ceUy88HT5+wGclqDFBsPdJKNPGYIRCFD
 V/sEquxfrkUMqhx8ApiCUa1N/3l4TOZERtzUOMhQ+cJWXszakoYxe5yzJdC1dEooV8WA
 GEftmfMt1P0oPRhRSswKh4aLdmViOaFuR4Ba50LUFYHtoA3P3O2AEPRGvgizgLEFQ1jL 4A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrej3us3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 15:59:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42BEo8jl009084;
	Mon, 11 Mar 2024 15:59:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7c5n5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 15:59:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOn0YoyJ/kFYipLWr9Gl8iKtYvXkQfEWgaCw9nK04X8kbkqYW+zvASal+tj4zlgvKlQGyA9gHy/WmO/X2vKFw9eD46pEb5Lrrw2AGqM/k11Vfke5kqO677reVeSeX727jRBzsf3RN/OCQdqsmWN7HSMCyrQj3BpVgEbb8cM14rm/3JeyjPrkDPrkzkC27n7A5xQ/TzyaKqRszIgYEDSstaPP8L+E9SCEDFsu2o3PjdQ6P0cXXzuxeZkDMudp4QPKd/PzC9KLLONFYdebhztfjkvW0NzjHk4c42arAcKg3cMZbq2/A+ulLo916YCzKM5i5ve3LGn+ftSO98rYqqCUJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJNYlqyGyirNUT/OLqK2Kg6FW63vQwrAO1hpCBGu5Aw=;
 b=FBokzwA6bIgo7jF49rOFlotypmB+9pX1bgZqrqXprWdP0Br5b0FhUbtu07IohxTXPQ8hSk8tpK5LbZhRx+Tso2Ytyz4LMwSPciqJbpnrbnp9/+/dM2UCSAQpCOWKxP1RixTRjf3/qgtapqeN+Mus0YlQRcM755cAHcqZO2TBaqCKEq/QsEQ82cxd2zFCd3okcUR98vTI9P2Nws2QZjX651A3G3IDLDO6MjZ1wjrT+y4k+GmK1GXFZfMRM6dDcgPvRafm/4gej4iwS8QXjK8WZMHTV1y+/PVYaEqN0QjHrlM2G+5hpefOICC8bqpITBnpjLYOn/WNiom9EWNWHc0r2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJNYlqyGyirNUT/OLqK2Kg6FW63vQwrAO1hpCBGu5Aw=;
 b=SytCwpahfhlTchvkNySMItyU5MmGLHh9m0mZD3a9FdZYfbATQMAflT08bHoBTUDEoRtXK6++AiiuZz9aMybdW1Xb7rQVexQrxWM61SRXtKJ3UBHumulRx+URt7pBGWRYH8POMDgQLGe9MJ2gP22/myVQG93xjCHIvLMPjlRilbs=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by BY5PR10MB4273.namprd10.prod.outlook.com (2603:10b6:a03:205::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 15:59:45 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d%3]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 15:59:45 +0000
Message-ID: <5b05f924-9077-4e68-9925-248470154a90@oracle.com>
Date: Mon, 11 Mar 2024 10:59:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] scsi: target: iscsi: don't warn of R/W when no data
Content-Language: en-US
To: lduncan@suse.com, target-devel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, dbond@suse.com,
        hare@suse.de, cleech@redhat.com
References: <cover.1701540918.git.lduncan@suse.com>
 <437f863520874ee386b6882ef749bf8d988839ca.1701540918.git.lduncan@suse.com>
From: michael.christie@oracle.com
In-Reply-To: <437f863520874ee386b6882ef749bf8d988839ca.1701540918.git.lduncan@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:5:3b9::32) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|BY5PR10MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a45d70d-7ecd-42a8-8751-08dc41e445a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	x1KfelK3u1IuvVbdLLeN3BLxOI0SDMe23ZEkZM3qAJuS7HRBDkmGQmupASs61B0Vp5Bw7K79i9fZybsMzgqgT0K4t6Q3NiksdpyWbuPY+ph64I8JHRQVavma3jP51WQBzN74hkleA0CCg7H07QdmAAP0stsK4A+HOHIi0WBYATw8haI5hOKzs1c2p3xvEHESKHMUEiQafKZ8FTuyKzwB6UMNQ9qxJsnS8sMCclZGrctFVbfaKU5yvNhqnCFZPZzQBgedYa4QZSdSzt6kbW8VXU2G1NUorGjaZxLdFv/iCb+qNf3owOTIngsZqzXsgM1xza4fkhbCGngsjESJCZAd7b3FflPiP0LpUos5MkONjkoH2bsBTfLg4E/JeiQ389HPW/v5TmX9WaZV+LeWem1ncwZnIXRBCyndcwiqsNSGyezo3i+M7udpoglSNk9eg8xLGgNFxUYbaMWE4tUKbTwG4+biMviN0V90czSNSzarl9QY1l6Lvn63VhaDE42gFkTJwVnmv7JlVknkabA15PKrYIPw+o1Ef440koGiOuaWUTxtUTioPgvSPecFYCInKqJnrdU5hJPpIbeZog111GDK+6dEUdi944vsjn+rJ+ywiklYaEnmMcqoehFvxCWlffwhcqROH1R7lkOhyYTgDvHdjfeRLxccwpM+UcHLojWbeUI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SzAyeVZyTk5xelA1Y3dkaUV1RXBUenZCVjkrb1NMQzV1OUVEZDJkalNaaXFl?=
 =?utf-8?B?OXVLT01XS3Z2UktMTUpZSGZkWW1NVzFaakFtTDgweWxLTW5JbTNZTHNCRkNs?=
 =?utf-8?B?RUVlYXhMaVQyRVRhK2lxQldFU2NoQjlLK0s4bStwZ1BnY2JXRDBZRHI0bjVj?=
 =?utf-8?B?TGp1YUgxNi9rMzl2Rk5GL0lFRFd0cmtEUGJGbGNNR1BnQlA3dE5aNHJkS3o0?=
 =?utf-8?B?a091WTZ4dEdTZFVxdjkrNlRYajhpN1pUelg1cy9PSU54c042dVB6Mld0dGx1?=
 =?utf-8?B?KytLMUU1QzFaVmh6VnFFeU9Wa1BKdGlGcEF6anlzUEYzaitpVUprU05yeDVE?=
 =?utf-8?B?a3hBdW1OS09uaXA4MEtaVFRYL3lNdVBvWmZ4UmVudTFiQkU4dHJTQ292NUc1?=
 =?utf-8?B?MS91Unh1cllzSzh4bkhDN3NvQVI1a3YyTlRzNS9ORWhPcHF2dXI1UlFqR2Ez?=
 =?utf-8?B?OHRxaGN3eFVPTkp3b1lBakZUVlJ1Yy8xSUJ1ZHVjbWFYejFOOVJHaVpWUHBH?=
 =?utf-8?B?MWFZOHcvNENPeHJxa0NLbmV3VmdlT3Z3Tk1yZkxPaklFZEUydFBqUFdLWmht?=
 =?utf-8?B?VFZiZ0FZOUNoNUVTd3NRTkVSVU1NbngrTTJFUis0Um9URFlPbFlaWlROTXhh?=
 =?utf-8?B?bmZzbytQQThXYVR6U084OHdOd2N5aHRiZVNJRTc2YlpxT280YU9OcW80d0JC?=
 =?utf-8?B?MDZCMkpLejVzSGU5NUY0amMrTlljdi9ZbnR0SU9udVZwRThjaG1oSlViUzhy?=
 =?utf-8?B?QjlSNzIwUnAwR3pBWTQ4TURxQ1l4TVFnS0hqWC9lWElYeTZXc1VaZUo0dFJn?=
 =?utf-8?B?a3pnRXVrbEp1UlJxYks5NSt4Y0s4UW5Yc2QwQnBHanNkODBNUTkrd3A5bktw?=
 =?utf-8?B?SWp0NzN6Z1FqTWVHWGRwanVpc3hOcjBORnJRMUVTbFJCTjB6QklSaTRVNU1r?=
 =?utf-8?B?bzh1SHh2U0ViQ3N2MGIxejRadHFrOURabm14NDFNVzR3U0JRL1JzTWxjaHcy?=
 =?utf-8?B?TmpyM2tneHJoYVZhRGpwZit3TzlGZWZSUXlpaUZ5TDlOakRmaFdMU3F4TUZl?=
 =?utf-8?B?OG42NWtrbnQxVjVxY0VVMVkzN09zTnJ1UUJXeG5EdkpYZnJaaTBvQ2FMdDVT?=
 =?utf-8?B?V3ArZ3lRTFZ4UXl2SFhKemFnOUFXSm9Fcng0N01TUEh2OE8zRTBlWnA1MHA5?=
 =?utf-8?B?QS9JN3kxMkU1anZVdkxZMmJQYW9MbElzYk9ta2hJYXlFNm1lTExOMDVlYy9x?=
 =?utf-8?B?dGNKY2swaTFNMUlxRFZidGpEQkQvanB3bE50VitrcitmSHAzTTFvVUJYQWsw?=
 =?utf-8?B?Z1RodktqV1RVN09MbjdMcllubnRKakhiejM0bzlON2Z3SDJqclZZS3p3Wk9Y?=
 =?utf-8?B?QmxDeUNCbnRzYTFmMlZKTlRhc0NkRFdpYlJTcGhobVhlTWNxMG1IYjZGbUR0?=
 =?utf-8?B?QmF3aDQ1RFlUdDBxcVZiSy8wOVdvSjNHL3N3MmtmMU1XUVoxQTE0TXNDQXNa?=
 =?utf-8?B?RnU0ZnJKcXhwTW1XVHpRamk0MXY2Z1V5Q3ErNTdpZ2xzUlVMQ2hVYXZBaHBw?=
 =?utf-8?B?dFcxYUd2WjZtak5TdnpqUVhwZ1lpbGNEQmRSQW1XQTNNbTNMMnZtMGxUVlht?=
 =?utf-8?B?ajNGcmcyUkpseUNuOGNoL2l5U0hGS09LNDI4a3E0ZmJBbWdwTm1TUTQ3LzlL?=
 =?utf-8?B?aktMTzIzQ2Y4TnF3WEtIVUp3TmsrWWx0TXBTeDBDWXp5d2xwdUx6YXhFZWk3?=
 =?utf-8?B?dmpWcm9rdHljUEdkSlEzZ0JCZnVoamgxWDVQMW5tYlJOL09aUnFhNFFrOFhQ?=
 =?utf-8?B?cVczRHpFUmNGTnFGa1NKalU4SHBaVXNtZnV1bEdvS3JzSmR1dXpXbWhyVDIr?=
 =?utf-8?B?Q3plbDFLeFZCb21JU3NEd0FMbHpzTWRsNkh0OUUrV1J3dzdQK3JtSm40ejI4?=
 =?utf-8?B?d0NBTmVHWXk5N1pIYU1peW80ZURzZ0NQUk5CcWlLYzFYaHV2R0ZSclRrSFky?=
 =?utf-8?B?MHZQcTdoczhndWtod3JwZHRqbDRpakNTTHJzb2x0K1QrR1V2NjR6SzlIYU5I?=
 =?utf-8?B?OEhTSnFGSGhveURsbUFVbm41YXgybVA1aXdkcWJ5WlpwdXJpSFJRMHQ2dTQx?=
 =?utf-8?B?WmJhZG44dndkZkV4Wm4wN0JSODVnOWU0c0xBQWo2QW50YXJQU3FsWEFRTmFu?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vwGKwZsrd7cd+iYXHRr0ydRGyiwEP5zONIwasgWltn3O6M7RZExguPTPSOJjAH90JDEMABPUpBejdNa6R9wrCv8iOlyNXviXSeaOC0AxYmuS/A4kQ84WL7qg/1cf2o/16Z5RzQJHi4oUmUDvXfxCs++YCGhtc674WEQxNIGq+7fnpD2fXvPGxEODx6232Hk3ujYsOdxeKCM8WoAuwHkn+XO6Dfq7KLvkZ+HyjcyYNxATlhPaW4KEoIan1vvSG29JdqS+1VCEUoLKOxEpDIgS8lEmPIdJNciSLd89vHq772IFIP/YZ0Rrwl2SdDu5l/hEXzH7QP4bOzoZaAyMJNzhSXYZftWEavjtE+61f9wMIi7FPc8y20KrQEQVcqRKR38WdTYEdSt0zgAwRBw0DlbAaQb8GstEGd1suOXL0pEXGi5pcGt0nXijII/n8HOwcWfCQmuJEgi04iQx+ZuwX6kIazUtm5CNOgmNAS/tswYfvFg6vhqmZcTezeQuAc+pyubZm/+55SYGKw2cQS5ZZ0tYaAsCM/DXWjwYZQ5tWmGeejpwGtSorHJE0+gF21n0l6ofi6EHzlxSGMiZhPJnShk+PEqHYkaBZProjfCodgpPwuE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a45d70d-7ecd-42a8-8751-08dc41e445a2
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 15:59:45.7615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRr5C0utA29wpsclMKtxrX/KyZBu0EbRT1SNmA010AyPnNrGMvwCAYQDp9RP6BeJhRgG4G1Ygw/wdRM8tZjQxdpL2e+gToCPCjGgeHhqDrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110121
X-Proofpoint-GUID: cfbwrVrEAsqb-_CqStGx5NbzhcliHHJi
X-Proofpoint-ORIG-GUID: cfbwrVrEAsqb-_CqStGx5NbzhcliHHJi

On 12/7/23 11:42 AM, lduncan@suse.com wrote:
> From: Lee Duncan <lduncan@suse.com>
> 
> The LIO target code has a warning about setting the
> read and/or write header bits with a PDU that has zero
> transfer length, even though the code mentions that the
> SPEC (RFC 3720) allows this, and that some initiators
> set these bits. But in practice such initiators end up
> flooding the logs with thousands of warning messages for
> IO that is allowed.
> 

I've never seen us hit this. What initiator is doing this and what is 
the command they are sending?

Is it also related to the first patch? Is some initiator sending 
something like a TUR with the immediate bit set during some sort of 
stall/timeout?

