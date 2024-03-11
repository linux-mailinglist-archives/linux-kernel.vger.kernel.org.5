Return-Path: <linux-kernel+bounces-98522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB0F877B69
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E2E1C20C48
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 07:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83A810A26;
	Mon, 11 Mar 2024 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vne9183h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k7ZvtnYc"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D413DFC17;
	Mon, 11 Mar 2024 07:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710142886; cv=fail; b=FOcHs3LOOTJQIYCsbRy+eN8TzJ+auS7NmY7OpVLimPpmsBcnwoekdVzqicwOQR5+7FeWqvYRyzUEXlbBj+oqS4SB6ZToBC1seSWqzA7ZV6p5YBqcypSpNxuDiOKu8lkcKm6qkAjAzXQViMmD/v4k42S6OldbQqo41hs6nsikGVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710142886; c=relaxed/simple;
	bh=s8oJRwRKxzzTyYVMoG8cXsRk29xFMhlXusb4FK0fYFo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=frZrBvm60g0di+8XdxPumf4O6TpAYw8P2ZCd1ey/+LPpWVtD6RBwv0zYSOacisma0DvYSpFyiYZvEqkN0EdFg/T7jcYBl4H4++7UlLPLjKgrrcgbojSXQZfx2WpoJdSYi9JZr26o+TSljVIcCnYR5km8aBoBYWPYURRoR3PZAbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vne9183h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k7ZvtnYc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42B4OtaE023876;
	Mon, 11 Mar 2024 07:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=8Tv317Gl5JAOfhgqRsvaVv1UkATjVOaiJw0EpJ9C9Ms=;
 b=Vne9183hS4EJ/zRH0kSaKYqvlChki2bmiWwXTZfjrrADxQ8o5gqHl7ZEdeDBOMt9HoLb
 9aDGO6M6Lmnlcy9ME3T/VMm46PAf8y2p9dOiIgETrbgmflKTmsOpzysXOVFahasE5HrN
 oyQuevxivbfdQW43PU14D8AVWPHmeM2x3oLh37X6qeN3LPQSqRXmT99Arz8feKdlSTjm
 1ASkk7gnlEMDGzlBisjxaCfBya2ZB7rtrAV7g//RzxXZhG9cMiqbUHwtQ7kemLjNGV3Y
 t+hZpzQSlwaarwwwEBab5DtvvsPMyEDM7Tp1OhZWO3C13z93noPBz/2EQ9z+a/Vq/ULl /A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrgaujh2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 07:41:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42B5K4bc019773;
	Mon, 11 Mar 2024 07:41:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre75cj1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 07:41:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McZHDab2k4xyEfx3m1+h5lw2PXzt270uC3h3ueErFMnpWp8Ysbu1FQcaBnRq4wpwy9RFmVmHRo7wQtR3IN5BCMbXmDqSez2SwlfjC+tEQNwA/hpoNfSpIOdqd8MgqWqprwPCTy+YF37chQRuYiYJ25snyyFsSM07rr6J2Z4z2xovpjYOnhkF7cTwRvPjoFKuQB028fsnqYWzsSzKOIf1rPQaE+FOOgKPPWD8vlBUMQ0rUbTZdELkcqaa03TjtDFLQhVnLrtsLKjixAKg8e2IPS7D7gBkTWs/CTLh2w0NgmsoVehQaGKlTC6TU1879w2yDZc0toPQPH2gkeLRzbafjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Tv317Gl5JAOfhgqRsvaVv1UkATjVOaiJw0EpJ9C9Ms=;
 b=g+l9WivfkQDj8YUHjvD4/9AaqqgX5dx2hxJu5IN0Vikxbn6v4i5KPdbYgzS0t1F8k0gnmG1etfCw4AixE4qAFZTydcTIqk71v20Rhpfv0NIRj37TzCWOCB7+4ONUY/SlV4oVlEsDdSteHVSZ/Eoj9zvRz6rJaCpqm9A/k0CbHDrSAYHy5gubbYOT9XBen7Qtgn2OMxOku0iSEEKXGqaT4e3BTh30BXGN3mQrJADOcvApbA+rNyYotbPgwSsjmvJ7hH3BQGusvNUClDwXuOk3GHTIrpwtEo42M7NX86SVxp0aTVxD78gHS7af440in5ZIfB7lIJUpSLU4tZ1cnaBpDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Tv317Gl5JAOfhgqRsvaVv1UkATjVOaiJw0EpJ9C9Ms=;
 b=k7ZvtnYc4NRDCaIEebcVZCUVlibltONF56zLstamuj0rlXwWyVk4SYEQ9f9V2x4RO4UdrIvObKJtst0Fti4arDAxNoh77NEck7vRuoJg9SW7GW5eu2XKWlOMyiWpF6sNzhe+Wo3iLkE8/gewTgHGyB5it2JskujNIsVFKUYuhgc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV3PR10MB7844.namprd10.prod.outlook.com (2603:10b6:408:1ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 07:41:04 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 07:41:04 +0000
Message-ID: <f7d44e94-ad10-43d4-aa57-ef0b600b1f45@oracle.com>
Date: Mon, 11 Mar 2024 07:41:02 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Add LIBSAS_SHT_BASE for libsas
Content-Language: en-US
To: Jason Yan <yanaijie@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        jinpu.wang@cloud.ionos.com, artur.paszkiewicz@intel.com,
        dlemoal@kernel.org, ipylypiv@google.com, cassel@kernel.org
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240308114339.1340549-1-john.g.garry@oracle.com>
 <cf0cfd01-43e3-141e-01ca-867a8eb9a982@huawei.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <cf0cfd01-43e3-141e-01ca-867a8eb9a982@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0616.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV3PR10MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: ee31f556-b815-4b79-b951-08dc419e9aeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8/d35nf4ssflfrvzxpcVAhgXZS0FoAeY6ZS+HmaATqgvo3n+SgJlNeJVDNbqxhxhwGCHS0sl2McvuJGe/Jf7ftHYyYv/685OxKb03FM33CHd84xkxCvKR4wNBTC26Qpw8h5MfyHmEqKi3LlXERpsPWrergI347xjGz+iyPcoycMMtytnwXBvA+P4itZsPUDkT0dRjW1P/C99Nel2o5hOSnS6MgF4dr36n1IBiCi0S8Yb6GEGDz4IzWoebPZWwaMGAs4fKVKQV5Gplp+yihae2gienH5/8zTLCJjxRFbUB0e0p8NqoojhLBnv4t8VVgiAkHbVnkR8HLIkWMj+YBT70GI6Fs4XIEVoV6uRNRGGFB8eIdlywMQQQyH3+HdBDQ/2enCqfg/i7sQF89Yyt9BzVcanpIUYGRhM6Rq7d73TbAQXZ0eLWm65RNIKIZ+rM3EMwHZmXmbx45vNoWvRZ1OneOFCaU2Lk/BCMY94A9prTVbT2P4R0Jf57C5T/48BKNxcDvl5q9ookRXKvcF11L2E9MLeNdYWY+tDN76uNw2HYDm7qw6M68Bs5uycB1z/aHub9pqCDqxWveES1V+c3IGc1XOZxjPcYKYs8ENmXPkb23D8sl8bhTB6TLrU3mGDorecnX44fj3mDPtn2CQHmJGKoojMLSc6dY+3ldujJxiDB2Q=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R0JIcWNwOGk2UmM0c25UQlU3eEUwNWhGTmxSSkZqS29WamZNVmc5VTUyc2lz?=
 =?utf-8?B?OWpRTk1YMDhhRXZsU2FMT1V5ZkpydENIRXB4UWkyQkRuNFhRaHBBejk5ZXNX?=
 =?utf-8?B?bW1EWXhyM25wUkw1YXZHY29XMFdOYXUyL2NzMW0vb2toVS9iamRveHZkcmFT?=
 =?utf-8?B?by9pTktSTGZrYk1WeFk5M3Rqa1FLc01FY0NLMGIxTjJzSm9wdk9IcFdIOG1r?=
 =?utf-8?B?bjlSRlBzcDhvRjZKY2R3V2R2TVl3MlU3NmNPZGpxSWY3SzAzUHBPNEdyRm81?=
 =?utf-8?B?Yy9FMnQ2NGZFUFVBekZZR0VBWTREOU81N2FOd1pWVWpQbXptZ3FJbElUVVE2?=
 =?utf-8?B?SmhObyt2Q0pCZFFjQ09LQmxHZzJsZUpCSU8xbTFZYjNkTkhnSGNYcE95Q2pB?=
 =?utf-8?B?aWl4dCtrQklrQXlNdkJ5cG9RcGoxSXpVN0toRnhud0k3WWtxSkkrWjlMbHo0?=
 =?utf-8?B?ZlJDQkJVYThkQnNTL0ErRmsrOXpsNFppQnZoNTlQK3dUT0pSYmt1SjVpVmVr?=
 =?utf-8?B?cjdybi9hM3k3SDhsb2JwVHZhcFAvbDZPSTZMVURXb292dkFWTnY1bExoNmE2?=
 =?utf-8?B?MlVuZytlTnMxbTdZR2lNRHgxbk5xSG5OQnFTM0tuanlHUnc5L2t0TTJaMlhD?=
 =?utf-8?B?QXB4Wmh5c091d1dwOTNrU3VUOEFzZW1IVU9IRktFakhaS1gwMjNZWjErSGxM?=
 =?utf-8?B?clF1alNuRmNzOUtlaWtsTHMxYkRpejUwOElnVkZDeVByZkptYjZUYTV4Mnlr?=
 =?utf-8?B?WmlQTHpDVDlIeDJrU3ZLaCtUZWFlcEJkV3ZWVmJCbktLdTZHRlJ3cE9xbFBr?=
 =?utf-8?B?WlFRTjBGempkb3d2MGFvVjhCRDhNOXVSZUt3QWcydVRMQVAyUVRuUHdrMVhL?=
 =?utf-8?B?Smx3eEtlYjA5eU5iMHVZUEU5OGZYNlQveHNMOCsyK2ZJUjIrTWpsV0JZeWwx?=
 =?utf-8?B?bkFUMld4UXN3Zk5IalJMQzJCOTRaMjVCYlQ1bnZ6OWorcUNzU2dzK3Z6WDFU?=
 =?utf-8?B?eHR2ZjlyME5nTExuZVFKcU8rWVJxUWR5TStqY256U01keEk1V2c5clpYdm5y?=
 =?utf-8?B?YUJ6Rjh1bUZocWx2b0ZUeDhjOForTFRja2RDTXNIaHhVSWpHb2o5d1cvQWpk?=
 =?utf-8?B?WHptQk1WWURhTWJyanV2U2IrdEpKQUs4djUvU0R2OVlpMEh6cHpzMUNRVDRh?=
 =?utf-8?B?ZDB6VzVDNk1BR01SM3ZDMVIxcmIwckJtb25MbTBsc1dIMEVDaTI5Yi9Iandl?=
 =?utf-8?B?enJPRk1xeHdKWnB3TmRNTUFHS0ZwMmRkRFhqMm5wZXhwTUMxTS9QekFvYUsy?=
 =?utf-8?B?eFdZcFlEUm4zazA4SEllNCs5Y0t0SFUvb2dxTVh2M242MUR6cnhzN1pUenBI?=
 =?utf-8?B?d1ZabWxXalRRdkduZ2hkZllNMHVobFpnRSsvRjEySUIzZjNhd3pySmhiUCsw?=
 =?utf-8?B?VE5jL1FxMTE5RGEwUkZQSmpZTGlNMUlLOFlDZ21wVjRJZ2ErMG9EelNVZXRo?=
 =?utf-8?B?QVRGaUErNExwcEdPQkJjRHNNME94akxqNXlBTHhXSis3a0ZZNFZoWUkvbjVK?=
 =?utf-8?B?MDJ2TTN0WkJ2MjlYRExOWHNtV1hseWVuV1Nrb1JWdTArR0REK1NrcWJ4cmEz?=
 =?utf-8?B?YUk2a0JLWnhuOXZza1llL1RjUTMrNE1qTVF0YWR3THFBSW04TWQ0MlQ5RXU3?=
 =?utf-8?B?Vk1GcGJ3d0FUbHRhc1R1ZnJYWUNHMERvM2FRdlYrdkdoRW9uUXM2aC95WUVN?=
 =?utf-8?B?bGs3Zk1YVDZQeDlsWHRuSmRVSWtLUkZFQm1yVjdJb3k4cWE5bndGNGVEcEh1?=
 =?utf-8?B?bWxYT3B5R1F3QVE1YkJhazhJOEJEMElvWGlYOXlBQXEwTjd4Ymw3aEx5THZi?=
 =?utf-8?B?UW1qZXhLSmRENW9ieHZoYUtGTXRpc1MzaGIweHRSQm14Mjl4RVQyV1BiOE5y?=
 =?utf-8?B?S3hVWWdsZnc4emQ5ZmhIUTdWKzF5c0s0YjViVUtPY255dncrUmFOVHFTSThG?=
 =?utf-8?B?dHVnZFNWd0Q2cGh5YjE2U0crTlR4MUF1ejM2eEVwcWNPNWc1MEpzeG9nTEsv?=
 =?utf-8?B?b0VoNkVnK0x3bXN1MnlmVkRpQTluL3dtMGRhVUF2UkU1RStZQXlPd2NBVVZz?=
 =?utf-8?Q?ONOaCJwyZjn6NNTIrRNlzXJKj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lmparG8SvVc6trhs0yX/79pNRLebXWKB/kcwsgfSch/HU9HbHBsVXu0qCBOW5b6f3t8COEy2ZqnX1omszgJ8Hiw1WGnRDj5LUZRaBsNzVYNeaMuS/t8E2tPi57fnlwSI5v446613MJQbclaawQCWV3gU1SPxxEJENvlZiK+ZPnUVOOUut0I1XaVdCLMg+JcFjOAqRhwX1Xp/uAhp64I/ub2DqeKJtRF3yRu/ycEqMcHQTyYOV2KFpgWdI42qPG0zesKHa6gl9JNl/mbAa1yOPc7Wx1x1m2S0Xp+Vrllz6B/zfKAInWkfcdMeNao9jHIfij4fRqr5aujb03GOfcYYGNz8LNVDLgKwKRlqxAVWyAzvprqy9qEY/cSkGIYG9soFWt/0V8184AIOYXp0BNLcA9Py5q0VPwAS2jTtRg+cNNukpL16l/F4nyyzQlvalkoTIjJ2RV0vMH/o3gjxubn1Zr5QBFj47JJc3ciW2pkj/rMaYIdA80O8llQt91oX0m6ph8lasdEUiKuHjORw/DDq+vARd2IrdKr2fZ2e2PnmhAj1bxrZ1vABMIP0ivboAQGwZ73wJqH+FfQ0BPDL4uUhnwUiu0WinYPj5+VcgFhqtjM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee31f556-b815-4b79-b951-08dc419e9aeb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 07:41:04.1991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7c6igrh6LYanoNgqpLtLorOurO62BE3HxqUdT2UzJySL/aGJMU1UO0WMQdgDn25AVlxV6pLoBGcAax9JsHHJEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7844
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_04,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110057
X-Proofpoint-GUID: -phnihww8D_FHNlo0WyBQ-My_gF0Mv_E
X-Proofpoint-ORIG-GUID: -phnihww8D_FHNlo0WyBQ-My_gF0Mv_E

On 11/03/2024 01:46, Jason Yan wrote:
>> - Remove sg_tablesize in LIBSAS_SHT_BASE, as W=1 build dislikes it
> 
> I cannot find sg_tablesize in LIBSAS_SHT_BASE in v1, did I misssed 
> anything?

Ah, I think that I just had that change local but then decided to drop 
it due to W=1 build issue.

Thanks for your eagle eye checking.

John

